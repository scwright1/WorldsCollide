// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/ProximityRemove" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_PlayerPosition ("Player Position", vector) = (0,0,0,0)
		_VisibleDistance ("Visibility Distance", float) = 10.0
		_OutlineWidth ("Outline Width", float) = 3.0
		_OutlineColor ("Outline Color", color) = (1.0,1.0,0.0,1.0)
	}
	SubShader {
		Tags { "RenderType"="Transparent" "Queue"="Transparent" }
		Pass {
		Blend SrcAlpha OneMinusSrcAlpha
		LOD 200

		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag

		//access properties
         uniform sampler2D _MainTex;
         uniform float4 _PlayerPosition;
         uniform float _VisibleDistance;
         uniform float _OutlineWidth;
         uniform fixed4 _OutlineColour;

		struct vertexInput {
			float4 vertex : POSITION;
			float4 texcoord : TEXCOORD0;
		};

		struct vertexOutput {
			 float4 pos : SV_POSITION;
             float4 position_in_world_space : TEXCOORD0;
             float4 tex : TEXCOORD1;
		};

		// VERTEX SHADER
	    vertexOutput vert(vertexInput input) 
	    {
	       vertexOutput output; 
	       output.pos =  UnityObjectToClipPos(input.vertex);
	       output.position_in_world_space = mul(unity_ObjectToWorld, input.vertex);
	       output.tex = input.texcoord;
	       return output;
	    }

	    // FRAGMENT SHADER
	    float4 frag(vertexOutput input) : COLOR 
	    {
	       // Calculate distance to player position
	       float dist = distance(input.position_in_world_space, _PlayerPosition);

	        // Return appropriate colour
	       if (dist < _VisibleDistance) {
	       	  //float4 tex = tex2D(_MainTex, float4(input.tex));
	       	  discard;
	       	  return 0;
	          //return tex2D(_MainTex, float4(input.tex)); // Visible
	       }
	       else if (dist < _VisibleDistance + _OutlineWidth) {
	           return _OutlineColour; // Edge of visible range
	       }
	       else {
	           float4 tex = tex2D(_MainTex, float4(input.tex)); // Outside visible range
	           return tex;
	       }
	    }

	   ENDCG
	   }

	}
	FallBack "Diffuse"
}
