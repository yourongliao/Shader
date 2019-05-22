using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MVPTransform : MonoBehaviour {

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		
		Matrix4x4 RM = new Matrix4x4 ();

		RM [0, 0] = Mathf.Cos (Time.realtimeSinceStartup);
		RM [0, 2] = Mathf.Sin (Time.realtimeSinceStartup);
		RM [1, 1] = 1;
		RM [2, 0] = -Mathf.Sin (Time.realtimeSinceStartup);
		RM [2, 2] = Mathf.Cos (Time.realtimeSinceStartup);
		RM [3, 3] = 1;

		Matrix4x4 SM = new Matrix4x4 ();
		SM [0, 0] = Mathf.Sin (Time.realtimeSinceStartup)/4+0.5f;
		SM [1, 1] = Mathf.Cos (Time.realtimeSinceStartup)/8+0.5f;
		SM [2, 2] = Mathf.Sin (Time.realtimeSinceStartup)/6+0.5f;
		SM [3, 3] = 1;

		//Matrix4x4 mvp = transform.localToWorldMatrix * Camera.main.worldToCameraMatrix * Camera.main.projectionMatrix;

		Matrix4x4 mvp = Camera.main.projectionMatrix * Camera.main.worldToCameraMatrix * transform.localToWorldMatrix*RM;

		GetComponent<Renderer> ().material.SetMatrix ("mvp", mvp);

		GetComponent<Renderer> ().material.SetMatrix ("rm", RM);

		GetComponent<Renderer> ().material.SetMatrix ("sm", SM);
	}
}
