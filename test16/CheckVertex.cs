using System.Collections;
using System.Collections.Generic;
using UnityEngine;

using System.Linq;

public class CheckVertex : MonoBehaviour {

	public MeshFilter mf1;

	public MeshFilter mf2;

	public MeshFilter mf3;

	// Use this for initialization
	void Start () {

		//1
		Vector3[] verts = mf1.mesh.vertices;

		float max = verts.Max (v => v.x);

		float min = verts.Min (v => v.x);

		Debug.Log (max + "  " + min);

		//2
		verts = mf2.mesh.vertices;

		max = verts.Max (v => v.x);

		min = verts.Min (v => v.x);

		Debug.Log (max + "  " + min);

		//3
		verts = mf3.mesh.vertices;

		max = verts.Max (v => v.x);

		min = verts.Min (v => v.x);

		Debug.Log (max + "  " + min);

	}
	
	// Update is called once per frame
	void Update () {

		transform.Rotate (Vector3.up, Time.deltaTime * 10);
	}
}
