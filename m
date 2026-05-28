Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3ECCD5BD1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 09:05:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSWfL-0002iw-Rg; Thu, 28 May 2026 05:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wSWfK-0002iB-0j; Thu, 28 May 2026 05:04:34 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wSWfI-0003vk-Fb; Thu, 28 May 2026 05:04:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=afP4Qe85s6PzuDj3tysKWtG5d55kdzEEluGyxIjgwdQBMFjseeUt3/unCkvlIc50iQhElmwgEJRHSjoxIXyG7Fz2SxA9OyxCHb4pshdLC3kRplpfMuBfxs/hSBCYb8nLRdUyIKthhPfOCOnG25SyLMQUuJoD7eQuaWnUOwjHV3HqgClrIlEKa4s4PYX+ObkJhDP6KDNpDLsuXVQ9U0/TvI/kd1fUYjHfc6M9oXKgdV7bZXlaLjrVQDS8pAQt3xqdX2XkdfgzbYUd4jtyhBSqc34F08TwgwFzxf/kJeynMJz1l1W4NuBy581TOPluuQ+KNDLWgtz/V8MNcU507oK71w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPK9leXWJtDSrBbcQc8l/8IVnNN6OdTqcGHilPkG/TY=;
 b=S19a+6BovBLXH8d5Xe0GcDgXsFM6meNg+IsnHcCjEEWZPJ5ZN4D7Aj+Q6C79iFhGQOtrndWXVa3ppFHDT/XBs1T5zkX9bgtApCqGP+nsd8FhYaMdwHz+0Q6Fz7uH8fSeGVlABkcYOfCLjeHS74znqV160AwCYwY3PAI4kfFGiwjtQMrAUHd5ddnk2xKBJjpS8EI7eWDPygocn19jayRGMB6+tS+3irMruFLD63SmZj9If6BnEf6ehQuVGngs5ai1CXPsNlxqa7rofQq/AwTiQ1HTnVhVMh3hH2wW1y0/xoMI5sXyG4adw1tL50vKAfPyFSeyKxap6Xnp+EluYCi7pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPK9leXWJtDSrBbcQc8l/8IVnNN6OdTqcGHilPkG/TY=;
 b=nits5NZmQW6ehrVSIy3Y6+iDoe/6jzbAaa6HFlHUHhH5PtRPgW1qy7B4/V87nNoBHsYUsfWckrzRYjzhnnP2pyw3kiOyI/HkD+OgXCJa4Hfn9zt/QeDucDSdlkSWnOF9GKLYG1Wprs3rjZOZyiHdeBT4/45e4oQeVk/ye/sPTqdxFeicivcTqodLnNYAfQHPpUn7DxMINj7LPr0X4ieE9LYRYKQIP+rpRnJnlDnQ2Nr8xn9b5SDTxiD1CbtFkxUoBs6vrw7UHyyuSAsRLMbGM9PJ1VTL16KXYyUNZdINyaxxnfN8rk0OcjS+hKJtrcWw3e1XsIhcA8vw6nlU06fvIg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH2PR12MB4263.namprd12.prod.outlook.com (2603:10b6:610:a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Thu, 28 May
 2026 09:02:50 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 09:02:50 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Zhao Liu
 <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>, Nicolin Chen
 <nicolinc@nvidia.com>
Subject: RE: [PATCH v4 2/9] hw/arm/smmuv3: Improve accel SMMUv3 usage
 documentation
Thread-Topic: [PATCH v4 2/9] hw/arm/smmuv3: Improve accel SMMUv3 usage
 documentation
Thread-Index: AQHc7iaD+r8P+WgxNkKuOoS58pwc9LYjHzYAgAAFmgA=
Date: Thu, 28 May 2026 09:02:50 +0000
Message-ID: <CH3PR12MB75481D70032929A89D643630AB092@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260527221631.612026-1-nathanc@nvidia.com>
 <20260527221631.612026-3-nathanc@nvidia.com>
 <5a0afcaa-3fa2-498c-86a9-32480619e973@redhat.com>
In-Reply-To: <5a0afcaa-3fa2-498c-86a9-32480619e973@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CH2PR12MB4263:EE_
x-ms-office365-filtering-correlation-id: f1dcfee9-1cb1-4668-a191-08debc97e51c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|22082099003|18002099003|56012099006|4143699003|11063799006;
x-microsoft-antispam-message-info: MlYMeH5M3UsGvP0YFV4HIgkcqYqd90asPu97EnlQ+0/ab47Kx320YSL7e/8y1lRzMcRdmOb9VafA2uOhfJbqYoeDLqr5qoBDxcxZ21LJjtziVzbvFIi+bJxc/IVKRuXn8qxYeaF2FxdHJOEqzmUpbVIDnjmAurM6wh/WfQL13Rfwq+721ZArLXBJhiJNmErq9fdfvOGncD5u3fVSUUt26JSsz3PjotI2/kqpBuO/vHXki14mArj8CX/zu4tlzgt2jwcSbV5dgAfYLfmpnVziayHONgPn11lJPOnxsbISMLsxvULGs5CWF485nwhRuktbj+wNJ8GlcU6vPzlPAGb/dTqBqIrxvTlhVBO0WDxN97pKcZ3WGC2butQ/O9xir0C9dPb/dti6UcfLtrDZJK9xUQjgvs4BoWMUDGBGqQ4En17eNHYbTsBl8R8k+7hLpwh8warsTYzXcvFxdXofSglBVrnm4yZMwMupag1HVCb5ktEVwJMMuHPFFGphvpHx7IEWCDCzc8J0jjxt7Ob1xERdCC2Iy1LKlsjCZh3MNwZwvbBkSLX2u5CmPsXR5ERgSYFp0bC7nk68WftStGQrI2OPukeLafPCyxWL/crsTp1/MPVRJdPgvFu1EZcdMLEa/G1AgMLcNdKdvYgJmj+jI/sHEa8gCuVaq8JC0MYhJB4tQZMMut8gsu3tVTE8bdNdIpriDX5brNOI5p4YIePCTCpCCGJpr4Wnbdynn06j0sdJyG71iJ23ooNgrwsF2C6+IjTn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dm40cE05YzZ4M09jdEVHRU5ualdURlFOMmFxbkJoZlE3WkZoZ2gzNEJUaGNz?=
 =?utf-8?B?L3JIVC9CaGZhMnkrNnkwSFlNR0tRbEdtL1VBNXY1UE5ia1o0a1k5R0NCeW1S?=
 =?utf-8?B?T1cvcUlOQ0xHQlh1andmM2hkT0hFLythRXJPL05paUJ4Rm80bXJFOFhXdCtw?=
 =?utf-8?B?Yjh1b0hqYmQwMnF0dTNZKzJUMjFIaDVjT1E3WDVKd3FoRDREbm41Zm5hNzZT?=
 =?utf-8?B?U1JyMFRXRGNTSVlEdXhrUDNPaWpoWVcwZjdpYTFSeE5ucmxGakNsL1c4dTJE?=
 =?utf-8?B?Ymc1OHRxM0hKY2F0cEhoRlkwRnRyVkZZTUFQVVk5Yk1OallwQkhLdWRaSFA3?=
 =?utf-8?B?ZkN6Zytnc0N5S3p6K200UzJWSjZTR1hEQ0ZKUGM3emdUREVMdDNmcWpOS3FX?=
 =?utf-8?B?amRGTGdqVjdqWkt1Znl4eDNqMC9BMVdrcUNnSjcwOU1NdmwrVk9EYTdGVzBD?=
 =?utf-8?B?UVd6dlJYRTJIbGZtWHpTcTh2QkRJMlJWVDdYQ3dSYzYxWE9VeU9vY2w3b2xR?=
 =?utf-8?B?Ym5Xd2pzWWFUNjBCeHFZdzc0aXV6NnNYc3pRbUFoeHJWT1B0dEI4U1BLdEJX?=
 =?utf-8?B?MXZPbDlBS0IwRVpoZzB1YXFyUnhVN291SEI1NWFVYTFTa0RHWFFHdnlLVFUx?=
 =?utf-8?B?R1NYN09mcXNMZjEvVjBTM3drQmZZZ1pSN04yVXNDV3o0c0dVREhuRnZUNVBJ?=
 =?utf-8?B?WjFBcnovaWVyQmo3czFNQlMybHI4N3lDSSs2a0dvU1ByUWFrNlR3Z3BSeUVE?=
 =?utf-8?B?ejd2dEt6b0h0dTc3d3gzSUkxcmxxYjd2alNzaHZWdHJlVHpjWWg3bkNMa2NX?=
 =?utf-8?B?R1p0QjhUODNFYkNaZExCM1l6WGpJU1kyUHdEYTFLbGdaRlZPemtZVXFSYXBF?=
 =?utf-8?B?Mm5ZN2M2eUhlaHYvQkFoaEIzRytrVzFoaTBlNktGdGZZVENDWml1Y29tWnB5?=
 =?utf-8?B?S0pRc0Y5TVN2WXc5Z0lzZkFJSnlXY2xDNFM2MUZzTkhuRDRaaGNMS2s2aFh4?=
 =?utf-8?B?V2xxdy8rZGdTMWtBQWFneFQ5Q2V4bHIyZW5DYW5YaU9JWUZHamxodnk4TXYz?=
 =?utf-8?B?NUI0VWRyNldIR1FwaTZraFlpZzd1aWF0M21lemQ1YXRPWVpOTktGc0pHTzhY?=
 =?utf-8?B?anRqdHhocVdTcnI3OU9jQ20wSk1oRkNvTC9ObmExWHoxMFlpOHllSWJKdWVU?=
 =?utf-8?B?bjcxYWxKMFhOd21BK0ZCaVJYWHlrbFR2ckFQMThzd0hiUFNoZk8vK2tFMlZK?=
 =?utf-8?B?N2ZvaklhbGw4akRqRzJ6NGVwTklJWlN0Z3BSK3ZTenoxVU5xbHU2V2FBdnVs?=
 =?utf-8?B?R2c4ZTNXQjlkMDFoV0RCaFpIMmFNSUEvQmV0b2NTcXhNYy92R1VNYko3TUE5?=
 =?utf-8?B?TkRKT1lOQ3dBNHZhK3JnSmIyRFB1U3JhOENmQVA0RW9DRCtTdDkvTDBCbHJz?=
 =?utf-8?B?d1RmeVRnMWpYaitYcU9zWFVYQSsvK01TT01RdnI4L1JBS29WemxFb1MxdWJw?=
 =?utf-8?B?MEpKVGlJMlJXUUxHQkhzYm1oY0xDNjFIZ1QxRzEvdjZjdytNaGxiRzVjSHNB?=
 =?utf-8?B?SXV2QThuL2x4Y2t0TU9jV0d3TWtVWFUrd1lXY29xNnpMNmNHdEJJRlZhQUV3?=
 =?utf-8?B?UDFRNldlOU02NzAxV2FFczE5L2dsd0xWMVUyV3VraTQ1K2lLQnE2VmovVTdj?=
 =?utf-8?B?WXJpUXNxbTZIMVFnT2VlejZ4cnlxUVc1VEI0WVB5RUJzZUwxM0xjNmQzZ2U3?=
 =?utf-8?B?RU0zMFY1L2o5Ym1wYXFLeG9NUVMwREpxU1NROFZ4UTFubmxZQ3hJaDB2S3h5?=
 =?utf-8?B?bmVzS1MyaVZiZmpYbTlBQncvRm9tSzFGQkluMjZ2MjJrWUxIZ003QzRFa2sv?=
 =?utf-8?B?ZHVvc2ZVbHpmRHRGUFZ1dThXWDRGMkMvWW8zSmdCS3U3WEpvSC9yMlVMKzZr?=
 =?utf-8?B?dnRFUk54VWxPZmRxV3lZcDh1NzM5ejBHWVBWUU0zUG01RGV0MGZQcTFYMnJE?=
 =?utf-8?B?Tk9QRlhlU0V3VXpyYjZTOENWR0xrL3Rkcmx5RUtMSDhTSFVnVjA0VHRpaXNK?=
 =?utf-8?B?ajFUWVZSM1I0bnd0dTRtTEZGdVBjZGsyNzNoVWRKdEtPaTBaSURNWXZqWEVB?=
 =?utf-8?B?U29MTGl6V2RtZ2tkSGVLRU41SFllellCUVN3bEpaeU16LzVUcFAySDhGWk4z?=
 =?utf-8?B?OU1TcWxhaFZiL01UdDJHREFlUnNrYmJSaWFwdG1lTkR2bkhyYW9EcFpUNlBH?=
 =?utf-8?B?ZW0rZzJtdVprcHNyOW1rTlZPdWg0QXN6aGI2M3FxUm54YlFFRDAxN2NKZEdR?=
 =?utf-8?B?TWtaZmttMTNwR01PVktYTlZ1RTcyRlNBRzZQVDdOaVM0TG1ZMUdHUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1dcfee9-1cb1-4668-a191-08debc97e51c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 09:02:50.2548 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d6xWjr3z7pky01ZlHTU1oGlNR8fyLRW8OmF1H+VqVYE5x6zpYCWN6NiouAaUuYr831b87/u/sn62ryEE8w0CPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4263
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAyOCBNYXkgMjAyNiAwOTo0MQ0KPiBUbzogTmF0
aGFuIENoZW4gPG5hdGhhbmNAbnZpZGlhLmNvbT47IHFlbXUtYXJtQG5vbmdudS5vcmc7IHFlbXUt
DQo+IGRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxA
bGluYXJvLm9yZz47IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpDQo+IDxwaGlsbWRAbGluYXJvLm9y
Zz47IFpoYW8gTGl1IDx6aGFvMS5saXVAaW50ZWwuY29tPjsgTWF0dCBPY2hzDQo+IDxtb2Noc0Bu
dmlkaWEuY29tPjsgTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsgU2hhbWVlcg0K
PiBLb2xvdGh1bSBUaG9kaSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjQgMi85XSBody9hcm0vc21tdXYzOiBJbXByb3ZlIGFjY2VsIFNNTVV2MyB1c2Fn
ZQ0KPiBkb2N1bWVudGF0aW9uDQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3Bl
bmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IE9uIDUvMjgvMjYgMTI6MTYgQU0s
IE5hdGhhbiBDaGVuIHdyb3RlOg0KPiA+IEZyb206IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52aWRp
YS5jb20+DQo+ID4NCj4gPiBBZGQgYSBzdGF0ZW1lbnQgdG8gY2xhcmlmeSB0aGF0IHRoZSBob3N0
IFNNTVV2MyBtdXN0IHN1cHBvcnQgSFctDQo+IGFjY2VsZXJhdGVkDQo+ID4gdmZpby1wY2kgZGV2
aWNlIGFzc2lnbm1lbnQgd2hlbiBzZXR0aW5nIGFjY2VsPW9uLg0KPiA+DQo+ID4gU3VnZ2VzdGVk
LWJ5OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IEh1bSBkaWQgSSBzdWdn
ZXN0IHRoYXQgOy0pDQo+ID4gU2lnbmVkLW9mZi1ieTogTmF0aGFuIENoZW4gPG5hdGhhbmNAbnZp
ZGlhLmNvbT4NCj4gPiAtLS0NCj4gPiAgaHcvYXJtL3NtbXV2My5jIHwgNCArKystDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9ody9hcm0vc21tdXYzLmMgYi9ody9hcm0vc21tdXYzLmMNCj4gPiBpbmRleCAw
YzY1ZGM4YzkxLi5hOGM0OWE0OGFjIDEwMDY0NA0KPiA+IC0tLSBhL2h3L2FybS9zbW11djMuYw0K
PiA+ICsrKyBiL2h3L2FybS9zbW11djMuYw0KPiA+IEBAIC0yMTY1LDcgKzIxNjUsOSBAQCBzdGF0
aWMgdm9pZCBzbW11djNfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqa2xhc3MsDQo+IGNvbnN0IHZv
aWQgKmRhdGEpDQo+ID4NCj4gPiAgICAgIG9iamVjdF9jbGFzc19wcm9wZXJ0eV9zZXRfZGVzY3Jp
cHRpb24oa2xhc3MsICJhY2NlbCIsDQo+ID4gICAgICAgICAgIkVuYWJsZSBTTU1VdjMgYWNjZWxl
cmF0b3Igc3VwcG9ydC4gQWxsb3dzIGhvc3QgU01NVXYzIHRvIGJlICINCj4gPiAtICAgICAgICAi
Y29uZmlndXJlZCBpbiBuZXN0ZWQgbW9kZSBmb3IgdmZpby1wY2kgZGV2IGFzc2lnbm1lbnQiKTsN
Cj4gPiArICAgICAgICAiY29uZmlndXJlZCBpbiBuZXN0ZWQgbW9kZSBmb3IgdmZpby1wY2kgZGV2
IGFzc2lnbm1lbnQuIFBsZWFzZSAiDQo+ID4gKyAgICAgICAgImVuc3VyZSB0aGUgaG9zdCBTTU1V
djMgc3VwcG9ydHMgaGFyZHdhcmUtYWNjZWxlcmF0ZWQgVkZJTy1QQ0kgIg0KPiA+ICsgICAgICAg
ICJkZXZpY2UgYXNzaWdubWVudCBiZWZvcmUgZW5hYmxpbmcuIik7DQo+IHRoaXMgaXMgYSByYXRo
ZXIgYWJzdHJhY3Qgc3RhdGVtZW50LiBXaGF0IGlzIHRoZSBhY3R1YWwgaG9zdA0KPiByZXF1aXJl
bWVudCwgZHVhbCB0cmFuc2xhdGlvbiBzdGFnZSBzdXBwb3J0Pw0KDQpJIHRoaW5rIFNNTVV2MyBz
cGVjIGNhbGxzIGl0IGFzICJuZXN0ZWQgdHJhbnNsYXRpb24iIHN1cHBvcnQuDQoNClRoYW5rcywN
ClNoYW1lZXINCg==

