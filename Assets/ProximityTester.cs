using System.Collections;
using UnityEngine;

[ExecuteInEditMode]
public class ProximityTester : MonoBehaviour {

	public Transform player;
	Renderer render;

	void Start() {
		render = gameObject.GetComponent<Renderer> ();
	}

	void Update() {
		render.sharedMaterial.SetVector ("_PlayerPosition", player.position);
	}

}