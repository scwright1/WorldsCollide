using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GenerateProximityShell : MonoBehaviour {

	private GameObject shell;

	private bool enabled;

	// Use this for initialization
	void Start () {

		shell = GameObject.Find ("ProximityShell");

		enabled = false;

		shell.SetActive (enabled);
		
	}
	
	// Update is called once per frame
	void Update () {

		if (Input.GetKeyDown (KeyCode.T)) {
			if (!enabled) {
				enabled = true;
			} else {
				enabled = false;
			}
			shell.SetActive (enabled);
		}
	}
}
