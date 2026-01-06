Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F719C47BC4
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 09:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd2xB-0002Bn-Gh; Tue, 06 Jan 2026 04:02:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vd2x9-000295-5H; Tue, 06 Jan 2026 04:02:11 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vd2x6-0004vU-7G; Tue, 06 Jan 2026 04:02:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OcW3dERl95fkkLOam1Dyu+vfkZzzwtrPvY3w67+dqcHubyXmP9urr+EBb+DKDaAa+gHpISqPY7IvBZl74rOJonNvx31MzB2B1TU0iee+LvrDt0twi43pptMVAoVQVVeAqOppq7SefE1SDdO4F/2vEfQuW93ityX/leeixeB6jrg4mT6LVqZcTrTiRa63IXhK6IFRsKkTE31qbmSv1+w/JzxUiZObBAxj1hbeaTkGLK0pK9g69OveC4NQklOtGQni55kpywVhd99+RLhJv1EHzftYeXR3mtMWMUec+izXVHHBIAvgX8hk4G0GHEO2sddoNq5ePZ/0WvFXR7AuV5iLpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JepnaD8zyk09AHjgSN39NlPJvSVzs+uEszo3BgcpCps=;
 b=R2MJZkpJhLjJZ1hANqPKr5hgpOt6jkHRSgrZQ/DzmG7h5jP/XGzJGv/aIUPlHSY/8S+KWbqTUxay//LjiLsZ5GN1omp2wmdnjQ7eZjCNo7Hx4yYb51tvyoLHpR1vwUTgOid9/gPqn5Nbz5EUr72K8z9vvV8bfhMEYI0M3Y2znJ9d0GcOL6hawhSMMMRPiFxLY5CnRHN7xaNQSli26OidAGBkCUT7BN8s0DURHCkgzdF5f/l41a7QcS5dffNrodWgw58nCGSd3rwOXoq9GidkpkjA43/1h51AhTl3HxnYHWg/0QaOAv5OAYPEg9Z0z8EC4ceZHPcBEXGkb/GZVH+pjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JepnaD8zyk09AHjgSN39NlPJvSVzs+uEszo3BgcpCps=;
 b=Cuq2DRhnpdpK9Gg4FrfIGFFjL2giiiXAYPJZAKmvHX85Ep6KNXBB0vIWYirlxW06nv2OxqpBVoihhlbyCuOq8rddYdh448R/m7MNdmk9cdczEKrozADmJ8lMzNBHS5D8MBv1eLDZ1S4AXw4+DP60JuRKc3ePbbLNqn+QSeHGmslipQhOYwyuvsKktnJcGTxQRIRwVSWDYw4P+VLnco/lqVYDi4jiThwBxZTSj/+j0x+nx/nJoztavvyDQa9OteRHGYnvGaXbY7HmzeT31VewErWX02DqeTdXpk8Q4TVWSsJkhl1Ca4ag7d690TTiaChidqHOAS7rV0tRmgjlyMHePw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SG2PR06MB5058.apcprd06.prod.outlook.com (2603:1096:4:1c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.5; Tue, 6 Jan
 2026 09:01:59 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5%3]) with mapi id 15.20.9478.005; Tue, 6 Jan 2026
 09:01:59 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Joe Komlodi <komlodi@google.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "venture@google.com" <venture@google.com>, "clg@kaod.org" <clg@kaod.org>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, "leetroy@gmail.com" <leetroy@gmail.com>,
 "andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>, "joel@jms.id.au"
 <joel@jms.id.au>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [PATCH 15/19] hw/i3c/dw-i3c: Add controller resets
Thread-Topic: [PATCH 15/19] hw/i3c/dw-i3c: Add controller resets
Thread-Index: AQHb2/bDds1jC46n3E+PvtdG4wbH27VGHhWg
Date: Tue, 6 Jan 2026 09:01:59 +0000
Message-ID: <TYPPR06MB820627A0064914A0C4FBE2BAFC87A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20250613000411.1516521-1-komlodi@google.com>
 <20250613000411.1516521-16-komlodi@google.com>
In-Reply-To: <20250613000411.1516521-16-komlodi@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SG2PR06MB5058:EE_
x-ms-office365-filtering-correlation-id: 9f62a980-be9b-4d9e-5fac-08de4d024006
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?QzlhSzVkNUFuVVY4WHF0RDJlcXdnM1RKRk1aQkQ1Q2k5OGxWT1IzU294cFB2?=
 =?utf-8?B?ZUUvanNEajN6YWwxZDN2S1hEMjJrVFE4dGZ3eWNGOGNHWWFhaHFFY1dENk91?=
 =?utf-8?B?NEhTSzFYTEY2TjRzU0xLUHd3STArOW1tWE5XUDJIbXdKaDNUQzd1aXNCdWdK?=
 =?utf-8?B?cERrSGpicUdkZ2Q4cE5mWVlsOEZlYXZ6bjl1ZjhIV3ZhMEFldWVCVXoyZzg1?=
 =?utf-8?B?OE5jUTlIZmhOalVrZlZiVW9GU09uWitSTmFvSzBvOHlkUytvVS94aDlvZ3BD?=
 =?utf-8?B?eVJUdVUreEpOclo1R1Z0dG1wODJPWWVxQkYzcmVuN1lkeGpTWXBVaTZYUEVD?=
 =?utf-8?B?RWVzKzhhOVI3bWZKdTgzelY5WC9vMWQzempYMTQxaG56Q0gyU093ZVZ6TDlw?=
 =?utf-8?B?cFpyTWtHTlpXWFEvZHNhUmk4dTJOaU9OVVJPclNqaVBuMThWcXc3T1p2U0RI?=
 =?utf-8?B?aG5EWVZEcytzQWdTMmovNi9VdGtrRWxxcXlhakdXOFFyMUNZdk5XMlBDeGcy?=
 =?utf-8?B?VjlPWE9Vc01PbEM4Ky9rTUJJSUNvVzNETHdDcXcrR1REQzFPNnlHeXdPYWFG?=
 =?utf-8?B?VHUwL1FKRFZjSEFzSVA1VkZBeTlZLzBYVU50Zk0xLytHN2c0YzZrNmVCdjBM?=
 =?utf-8?B?dFdMMFhHckl1REphaFFzbXptUnFESFhkNkRGczNpYmFGUEY3eU1JV0NXSzNV?=
 =?utf-8?B?UTc0MzZTWFJWQUZCd3ZjVEZGWUxENFE0elc3bGlDMzVzdGRDOUdvVmlCZ1NG?=
 =?utf-8?B?VlpicXVZVEM0TGZPUDZiOVJoWkJsdzZWZW4wdTYra2k1aFRGZTNKa3c3SFlv?=
 =?utf-8?B?OGh5SW5CUjFEZ3dKYXJLM0ZGc2tYck1NRWZLSXZBM2Y2L2didS9zQmQwUHlQ?=
 =?utf-8?B?bjdxT2puVDRXenl4eC95VmlHVjlzUzN6dkVCZTFlcXVXcWh6Z1o5TVNrbmRy?=
 =?utf-8?B?U2NST21WbllyTGh5blBhV2hNTkNtcFVhZGo4dmQweHVVR3FCQ3J6bWwrN1By?=
 =?utf-8?B?TTRXVk83bEhCZTVKU2FnTy9OdVRFN0NKaVN0MFF4ak9WdldvYzNoNlNaUTUz?=
 =?utf-8?B?dHRYQ0xwdFlSS2xRWXJLZE8raDM5UW5EQXlxTk1nejVMbVdlaWV2NGJ1dDN2?=
 =?utf-8?B?YXhIMmozODFWU2sybmJoWE5VWUdiQ3JLVXBXNU14cDk2M01YaENjakY0QVJt?=
 =?utf-8?B?Z2tJTVRKWWdqZGl3RTM4TklIaUwzZVdGejU1WUZ2Q293SndJOVZvRmJidk56?=
 =?utf-8?B?Qll1c0lKaWdJWjFKU0ZNVzFxeUZDSUlBelJmRDNHbHZUNW9DbHdneVd3aWFX?=
 =?utf-8?B?TE9JVU5sT3VnRXRnQ2JSUVh4Mm5DOUNMZHFwRDZIZnQ4S3F5N3ZBRkFvRkZG?=
 =?utf-8?B?Z1BCVDhqbVQ4MHZZb1FKM1VueDNURnJzMENSUmpyS0I5THZLZ0VtalBJMnJ1?=
 =?utf-8?B?S1BkYUJYZFBndS90LzR3d1IvclVBRmlaT012eXlEUGdtRHEveWU4NEJLRm5x?=
 =?utf-8?B?dFpFV0NLdFExTGhEN2dFOUZITmYvcFlYWGEyV0owdzlNMEM0MU5FVEVQTXRV?=
 =?utf-8?B?Y3BjUUpuV1JXUFBHSjhaejN2RENqbXcyQWE2VUtmcHFkQlBOdVR3ZUNpV3da?=
 =?utf-8?B?SUFRcWRuWVFaaGhOaXRDYldjMzgrWDF3NDVsdERWWENuVm1ZZjN4aGVhNXNC?=
 =?utf-8?B?elJjVFRERE43Q0NXdmZHYXlFT25CVG1rY0JPdTV6T2kvazZQOE9BV2Q2a0ZX?=
 =?utf-8?B?c0lLZVJORUdUUWlLc2d0bGtYRmxydU1BUk5tRlprd0ZOc2JnRWdVWUxnam5q?=
 =?utf-8?B?WTd3N2hnbFdkZjZCeGd4RC9wc0lqamdLNWtqa1dTeloyRk05bm8rZlV1b1B2?=
 =?utf-8?B?MTI0UmIzU3NkcU9wditCQjIyaUdBdTNRRWt2ZGtxaEZkRXM5UE9mM2JiK3JT?=
 =?utf-8?B?c0hPRjNYdGZ0dklRUHptbHZYdDVzM0ZxcnFUMVBGQ0J0YnhVdTdCZnJacmJ5?=
 =?utf-8?B?Z2p2c2pGYXgzK0k5ckRqUzhGSUN4SUlpU2N4RzdRVVZ3WnhtcEJCdVFOZUFJ?=
 =?utf-8?Q?FM8RhW?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1hRMkpnaGlHd3J3SzlzcTBOcmxNWnFKbFQ1TzVvcGdwMDBZcE5ENlZyVzhl?=
 =?utf-8?B?L2NWcmU3eTY3U3daU1hiYmpNSVhuNkMzZGJ5bGlpR0JmQWVnQUNnM1NlT1VB?=
 =?utf-8?B?V2hmbVZreXJmcXRmTE9HVXB4SHRYZEJzS2xMSUpqdjhxMEIxUTZwaU1raitm?=
 =?utf-8?B?V0lXNkJSWjI1M3pTRS85R25mNGN6c2NyTWdiZEtHYUlrTkVlQ0hRdUdxZGtX?=
 =?utf-8?B?OVdRdjF4RS9memhZWVNYVVpnVjJtN3JkYUl2cVhWZ0VwMHlTcVpoMFRLTGta?=
 =?utf-8?B?N1JXWnZBaXhHVXNxbkx0RjNmUU00K0VkcksxaC9JcnovOCtmdjNDWWVNbHA5?=
 =?utf-8?B?UnlZdWFrYVUwRHdWbnFiYlVDYkVVeldlV3U1QW93b1h1bk1uTXVMTTBLWXps?=
 =?utf-8?B?QlB5UnRzWktyUjlyOGxRS1hVRWVHVXVXaW5ZTHpyd3JPekU5V3BIQzZGZ1Nz?=
 =?utf-8?B?UGg3bGpFcjdoNmtRbUU2YUNHcEswa2VnSERnM2RlVjBVT3BySk1mT1pBK2R4?=
 =?utf-8?B?OHVqS1hscnBFZ21temJ6Y3EyRXpzT3JkYUl2eDRWaWxVbzlqbUZYZ05kZVMx?=
 =?utf-8?B?enc1QW5LUHhpcjVLTjFwYnNkZloxTG4vUGx2SEIwY3NUTHRYVGs1dG14S2dC?=
 =?utf-8?B?WnlYbytoSEJmV29WRDVTTHRxUkxNdzNQSFc2aHNZMkJKWWFXMTR4OGxVc3RR?=
 =?utf-8?B?cnlQT0YrRWpVVGJQeE1QNE8vZ2VoZFJra05hbnZLaTlQZHNHdU1CTXFUdzRU?=
 =?utf-8?B?L3ZGcUZ0S0h0WDFveXZEd1pXV2p2SnJ5NzhLd1BkcllESDNhN05WOEQ1ZjFO?=
 =?utf-8?B?a0lISlhwd0Q2aGRiNDllcGd3YURHZENvTTZWc0lUUVVNa3ZYRmlVbUMxUG1m?=
 =?utf-8?B?UnhFZkRvRlJlZXNhcVkwNVg3MlVXc09TVnR0MnBqdmNaMHJDQkFzT1gzajNO?=
 =?utf-8?B?TGgySkRVUnN3T3hhcDZobGxvMk9nUEE3YnA1eGVZcklYWW1uWFcwdVVHQzc2?=
 =?utf-8?B?TGt5YjN4Q0wza3NvNWxtRTlkUVR6eE9VQWdjejlObXFlSjIyaUVJRGRhZWFZ?=
 =?utf-8?B?TmxiSnRrT2lBcnJweFdwV2k5bXJqUUpHUW5EWHBwS0MyRUlwaDZSMGM3MDRU?=
 =?utf-8?B?SHpaYXNjTXBOdkpIU0RjUzRybkc3VlRFUWdqS09vcG40Z0ZpeDYwYm1tTkYy?=
 =?utf-8?B?c2xMZlYxUlNDSlB0UisrQzFmQWN0a0ZJMnd1eWo5ODRiNVFwZHlMdjUrQkdi?=
 =?utf-8?B?d3NSRkYySmIrWHJmT05Xby9Nd0J4MjIrL28zUkVhQjNiRDBKZU9IV3l1NEVx?=
 =?utf-8?B?UGZQaTBTNXUzVHArcFNpRmtRY3JQSjBLclUwdG84Nk9RTVNtZjJaK0szdThD?=
 =?utf-8?B?QnNrSklnMzdicHVBL1I2eWgwc2daSkpzZXVmSWx0eE1SOGRVSzg5NktwM3I4?=
 =?utf-8?B?VWpEZDRKSmp6NkhlN0ZWSDArVFFpMVNxYWd6enptTXJ0Sy94SHpjbTBVK0Vt?=
 =?utf-8?B?UzdyenhQb0ZFRHJjc2preUhlTHRMMWRkcTBZTzlrRWZyY0JFeGJEY1VPZzly?=
 =?utf-8?B?YnBwMzQrRHMyRFA5b3JuM1VyVmdNYTF1L2dtbEpKaE1hNk93YVRudFpQZWZX?=
 =?utf-8?B?MXg2aVJtY09mbVBVeTJmSGJMbUlXSGlES0thVlBKT3BLSEc4ZzNtUmd0TDZT?=
 =?utf-8?B?UURRbTdwVHh5bXFjWEFzU3d5Z3ZXdHczbmlpYk5zaEI0RTRXaWVmOVJnNFd0?=
 =?utf-8?B?MHIxK203ZThxRGdMMG1WK0tKMWZaYzBPcDRINzNRdTBmbDMxd21aVmt6dDdh?=
 =?utf-8?B?R3V2YkRyZDdIbmVLRHFMajBqc3BBdzI4N2pIZU82M1V1di9uZjVNZzdtNE1a?=
 =?utf-8?B?UExkYTRDUjUrTDhseTJwOHFrNmNLdThmM0NMaytkdnNDYTI5WXFGb1IwcHps?=
 =?utf-8?B?SWtmSFJ5OVhRMU91OGpuN1VJQVk5MDZrUVBLSUFiMEdXWThYVTZRTklVcjVp?=
 =?utf-8?B?TWU0VU9wc3ZVeWUxQTIxTCtNU0RRS3ExZ1hWaVZKaHRhdGs3WWpWYmhqb3pQ?=
 =?utf-8?B?ZHhDZ3Nxc0tFWXE3Uk9Sc3Q4Y09DQldPRVAvT1gzSitwdzQwaFVLdWZ2NEVr?=
 =?utf-8?B?QUpLVlpERmppS05ITkJOS0l4Vkt2MUlIZ01xN1Y2SVRZRXczKzc1ZDBkUkdr?=
 =?utf-8?B?bzc1NVFLOEpMOEs2UmRoTHk1bUpaMmNuRHI2Zkx1NXdQdWR4S2QwYzByVkMx?=
 =?utf-8?B?Vk5vWXhaUzR4akRBMGpGbHFrd1NkZXFGSmZXQlR0UFRaaFBNV0EyUTU3QmVq?=
 =?utf-8?B?MUU3YXkwdW81UXJ4aGYxN0RRbjRoTzRvSmZaWGUwN1JERy9XeFhhdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f62a980-be9b-4d9e-5fac-08de4d024006
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 09:01:59.2148 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PClifROZnsTpvd8GikrYmrp6WDXIlBIjhkxM17zDo6pMQiYwh23gIP2lnC3i2/lglainpfsWE6XPJIfA0f9YOnRmAt0hbtwh6gvENvdHRvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5058
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

PiBTdWJqZWN0OiBbUEFUQ0ggMTUvMTldIGh3L2kzYy9kdy1pM2M6IEFkZCBjb250cm9sbGVyIHJl
c2V0cw0KPiANCj4gQWRkcyBiZWhhdmlvciB0byB0aGUgZGV2aWNlIHJlc2V0IHJlZ2lzdGVyLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogSm9lIEtvbWxvZGkgPGtvbWxvZGlAZ29vZ2xlLmNvbT4NCj4g
DQo+IFJldmlld2VkLWJ5OiBQYXRyaWNrIFZlbnR1cmUgPHZlbnR1cmVAZ29vZ2xlLmNvbT4NCj4g
UmV2aWV3ZWQtYnk6IFN0ZXBoZW4gTG9uZ2ZpZWxkIDxzbG9uZ2ZpZWxkQGdvb2dsZS5jb20+DQo+
IC0tLQ0KPiAgaHcvaTNjL2R3LWkzYy5jICAgICB8IDExNw0KPiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgaHcvaTNjL3RyYWNlLWV2ZW50cyB8ICAgMSAr
DQo+ICAyIGZpbGVzIGNoYW5nZWQsIDExOCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvaHcvaTNjL2R3LWkzYy5jIGIvaHcvaTNjL2R3LWkzYy5jIGluZGV4IDYxODQ1YzkwOWYuLmZm
ZjNhMzU5MWYNCj4gMTAwNjQ0DQo+IC0tLSBhL2h3L2kzYy9kdy1pM2MuYw0KPiArKysgYi9ody9p
M2MvZHctaTNjLmMNCj4gQEAgLTg3Nyw2ICs4NzcsMTIyIEBAIHN0YXRpYyB2b2lkIGR3X2kzY19p
bnRyX2ZvcmNlX3coRFdJM0MgKnMsIHVpbnQzMl90DQo+IHZhbCkNCj4gICAgICBkd19pM2NfdXBk
YXRlX2lycShzKTsNCj4gIH0NCj4gDQo+ICtzdGF0aWMgdm9pZCBkd19pM2NfY21kX3F1ZXVlX3Jl
c2V0KERXSTNDICpzKSB7DQo+ICsgICAgZmlmbzMyX3Jlc2V0KCZzLT5jbWRfcXVldWUpOw0KPiAr
DQo+ICsgICAgQVJSQVlfRklFTERfRFAzMihzLT5yZWdzLCBRVUVVRV9TVEFUVVNfTEVWRUwsDQo+
IENNRF9RVUVVRV9FTVBUWV9MT0MsDQo+ICsgICAgICAgICAgICAgICAgICAgICBmaWZvMzJfbnVt
X2ZyZWUoJnMtPmNtZF9xdWV1ZSkpOw0KPiArICAgIHVpbnQ4X3QgZW1wdHlfdGhyZXNob2xkID0g
QVJSQVlfRklFTERfRVgzMihzLT5yZWdzLA0KPiBRVUVVRV9USExEX0NUUkwsDQo+ICsNCj4gQ01E
X0JVRl9FTVBUWV9USExEKTsNCj4gKyAgICBpZiAoZmlmbzMyX251bV9mcmVlKCZzLT5jbWRfcXVl
dWUpID49IGVtcHR5X3RocmVzaG9sZCkgew0KPiArICAgICAgICBBUlJBWV9GSUVMRF9EUDMyKHMt
PnJlZ3MsIElOVFJfU1RBVFVTLCBDTURfUVVFVUVfUkRZLCAxKTsNCj4gKyAgICAgICAgZHdfaTNj
X3VwZGF0ZV9pcnEocyk7DQo+ICsgICAgfTsNCj4gK30NCj4gKw0KPiArc3RhdGljIHZvaWQgZHdf
aTNjX3Jlc3BfcXVldWVfcmVzZXQoRFdJM0MgKnMpIHsNCj4gKyAgICBmaWZvMzJfcmVzZXQoJnMt
PnJlc3BfcXVldWUpOw0KPiArDQo+ICsgICAgQVJSQVlfRklFTERfRFAzMihzLT5yZWdzLCBRVUVV
RV9TVEFUVVNfTEVWRUwsIFJFU1BfQlVGX0JMUiwNCj4gKyAgICAgICAgICAgICAgICAgICAgIGZp
Zm8zMl9udW1fdXNlZCgmcy0+cmVzcF9xdWV1ZSkpOw0KPiArICAgIC8qDQo+ICsgICAgICogVGhp
cyBpbnRlcnJ1cHQgd2lsbCBhbHdheXMgYmUgY2xlYXJlZCBiZWNhdXNlIHRoZSB0aHJlc2hvbGQg
aXMgYQ0KPiBtaW5pbXVtDQo+ICsgICAgICogb2YgMSBhbmQgdGhlIHF1ZXVlIHNpemUgaXMgMC4N
Cj4gKyAgICAgKi8NCj4gKyAgICBBUlJBWV9GSUVMRF9EUDMyKHMtPnJlZ3MsIElOVFJfU1RBVFVT
LCBSRVNQX1JEWSwgMCk7DQo+ICsgICAgZHdfaTNjX3VwZGF0ZV9pcnEocyk7DQo+ICt9DQo+ICsN
Cj4gK3N0YXRpYyB2b2lkIGR3X2kzY19pYmlfcXVldWVfcmVzZXQoRFdJM0MgKnMpIHsNCj4gKyAg
ICBmaWZvMzJfcmVzZXQoJnMtPmliaV9xdWV1ZSk7DQo+ICsNCj4gKyAgICBBUlJBWV9GSUVMRF9E
UDMyKHMtPnJlZ3MsIFFVRVVFX1NUQVRVU19MRVZFTCwgSUJJX0JVRl9CTFIsDQo+ICsgICAgICAg
ICAgICAgICAgICAgICBmaWZvMzJfbnVtX3VzZWQoJnMtPnJlc3BfcXVldWUpKTsNCj4gKyAgICAv
Kg0KPiArICAgICAqIFRoaXMgaW50ZXJydXB0IHdpbGwgYWx3YXlzIGJlIGNsZWFyZWQgYmVjYXVz
ZSB0aGUgdGhyZXNob2xkIGlzIGENCj4gbWluaW11bQ0KPiArICAgICAqIG9mIDEgYW5kIHRoZSBx
dWV1ZSBzaXplIGlzIDAuDQo+ICsgICAgICovDQo+ICsgICAgQVJSQVlfRklFTERfRFAzMihzLT5y
ZWdzLCBJTlRSX1NUQVRVUywgSUJJX1RITEQsIDApOw0KPiArICAgIGR3X2kzY191cGRhdGVfaXJx
KHMpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBkd19pM2NfdHhfcXVldWVfcmVzZXQoRFdJ
M0MgKnMpIHsNCj4gKyAgICBmaWZvMzJfcmVzZXQoJnMtPnR4X3F1ZXVlKTsNCj4gKw0KPiArICAg
IEFSUkFZX0ZJRUxEX0RQMzIocy0+cmVncywgREFUQV9CVUZGRVJfU1RBVFVTX0xFVkVMLA0KPiBU
WF9CVUZfRU1QVFlfTE9DLA0KPiArICAgICAgICAgICAgICAgICAgICAgZmlmbzMyX251bV9mcmVl
KCZzLT50eF9xdWV1ZSkpOw0KPiArICAgIC8qIFRYIGJ1ZiBpcyBlbXB0eSwgc28gdGhpcyBpbnRl
cnJ1cHQgd2lsbCBhbHdheXMgYmUgc2V0LiAqLw0KPiArICAgIEFSUkFZX0ZJRUxEX0RQMzIocy0+
cmVncywgSU5UUl9TVEFUVVMsIFRYX1RITEQsIDEpOw0KPiArICAgIGR3X2kzY191cGRhdGVfaXJx
KHMpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBkd19pM2NfcnhfcXVldWVfcmVzZXQoRFdJ
M0MgKnMpIHsNCj4gKyAgICBmaWZvMzJfcmVzZXQoJnMtPnJ4X3F1ZXVlKTsNCj4gKw0KPiArICAg
IEFSUkFZX0ZJRUxEX0RQMzIocy0+cmVncywgREFUQV9CVUZGRVJfU1RBVFVTX0xFVkVMLA0KPiBS
WF9CVUZfQkxSLA0KPiArICAgICAgICAgICAgICAgICAgICAgZmlmbzMyX251bV91c2VkKCZzLT5y
ZXNwX3F1ZXVlKSk7DQo+ICsgICAgLyoNCj4gKyAgICAgKiBUaGlzIGludGVycnVwdCB3aWxsIGFs
d2F5cyBiZSBjbGVhcmVkIGJlY2F1c2UgdGhlIHRocmVzaG9sZCBpcyBhDQo+IG1pbmltdW0NCj4g
KyAgICAgKiBvZiAxIGFuZCB0aGUgcXVldWUgc2l6ZSBpcyAwLg0KPiArICAgICAqLw0KPiArICAg
IEFSUkFZX0ZJRUxEX0RQMzIocy0+cmVncywgSU5UUl9TVEFUVVMsIFJYX1RITEQsIDApOw0KPiAr
ICAgIGR3X2kzY191cGRhdGVfaXJxKHMpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBkd19p
M2NfcmVzZXQoRGV2aWNlU3RhdGUgKmRldikgew0KPiArICAgIERXSTNDICpzID0gRFdfSTNDKGRl
dik7DQo+ICsgICAgdHJhY2VfZHdfaTNjX3Jlc2V0KHMtPmNmZy5pZCk7DQo+ICsNCj4gKyAgICBt
ZW1jcHkocy0+cmVncywgZHdfaTNjX3Jlc2V0cywgc2l6ZW9mKHMtPnJlZ3MpKTsNCj4gKyAgICAv
Kg0KPiArICAgICAqIFRoZSB1c2VyIGNvbmZpZyBmb3IgdGhlc2UgbWF5IGRpZmZlciBmcm9tIG91
ciByZXNldHMgYXJyYXksIHNldCB0aGVtDQo+ICsgICAgICogbWFudWFsbHkuDQo+ICsgICAgICov
DQo+ICsgICAgQVJSQVlfRklFTERfRFAzMihzLT5yZWdzLCBERVZJQ0VfQUREUl9UQUJMRV9QT0lO
VEVSLCBBRERSLA0KPiArICAgICAgICAgICAgICAgICAgICAgcy0+Y2ZnLmRldl9hZGRyX3RhYmxl
X3BvaW50ZXIpOw0KPiArICAgIEFSUkFZX0ZJRUxEX0RQMzIocy0+cmVncywgREVWSUNFX0FERFJf
VEFCTEVfUE9JTlRFUiwgREVQVEgsDQo+ICsgICAgICAgICAgICAgICAgICAgICBzLT5jZmcuZGV2
X2FkZHJfdGFibGVfZGVwdGgpOw0KPiArICAgIEFSUkFZX0ZJRUxEX0RQMzIocy0+cmVncywgREVW
X0NIQVJfVEFCTEVfUE9JTlRFUiwNCj4gKyAgICAgICAgICAgICAgICAgICAgIFBfREVWX0NIQVJf
VEFCTEVfU1RBUlRfQUREUiwNCj4gKyAgICAgICAgICAgICAgICAgICAgIHMtPmNmZy5kZXZfY2hh
cl90YWJsZV9wb2ludGVyKTsNCj4gKyAgICBBUlJBWV9GSUVMRF9EUDMyKHMtPnJlZ3MsIERFVl9D
SEFSX1RBQkxFX1BPSU5URVIsDQo+IERFVl9DSEFSX1RBQkxFX0RFUFRILA0KPiArICAgICAgICAg
ICAgICAgICAgICAgcy0+Y2ZnLmRldl9jaGFyX3RhYmxlX2RlcHRoKTsNCj4gKw0KPiArICAgIGR3
X2kzY19jbWRfcXVldWVfcmVzZXQocyk7DQo+ICsgICAgZHdfaTNjX3Jlc3BfcXVldWVfcmVzZXQo
cyk7DQo+ICsgICAgZHdfaTNjX2liaV9xdWV1ZV9yZXNldChzKTsNCj4gKyAgICBkd19pM2NfdHhf
cXVldWVfcmVzZXQocyk7DQo+ICsgICAgZHdfaTNjX3J4X3F1ZXVlX3Jlc2V0KHMpOw0KPiArfQ0K
PiArDQo+ICtzdGF0aWMgdm9pZCBkd19pM2NfcmVzZXRfY3RybF93KERXSTNDICpzLCB1aW50MzJf
dCB2YWwpIHsNCj4gKyAgICBpZiAoRklFTERfRVgzMih2YWwsIFJFU0VUX0NUUkwsIENPUkVfUkVT
RVQpKSB7DQo+ICsgICAgICAgIGR3X2kzY19yZXNldChERVZJQ0UocykpOw0KPiArICAgIH0NCj4g
KyAgICBpZiAoRklFTERfRVgzMih2YWwsIFJFU0VUX0NUUkwsIENNRF9RVUVVRV9SRVNFVCkpIHsN
Cj4gKyAgICAgICAgZHdfaTNjX2NtZF9xdWV1ZV9yZXNldChzKTsNCj4gKyAgICB9DQo+ICsgICAg
aWYgKEZJRUxEX0VYMzIodmFsLCBSRVNFVF9DVFJMLCBSRVNQX1FVRVVFX1JFU0VUKSkgew0KPiAr
ICAgICAgICBkd19pM2NfcmVzcF9xdWV1ZV9yZXNldChzKTsNCj4gKyAgICB9DQo+ICsgICAgaWYg
KEZJRUxEX0VYMzIodmFsLCBSRVNFVF9DVFJMLCBUWF9CVUZfUkVTRVQpKSB7DQo+ICsgICAgICAg
IGR3X2kzY190eF9xdWV1ZV9yZXNldChzKTsNCj4gKyAgICB9DQo+ICsgICAgaWYgKEZJRUxEX0VY
MzIodmFsLCBSRVNFVF9DVFJMLCBSWF9CVUZfUkVTRVQpKSB7DQo+ICsgICAgICAgIGR3X2kzY19y
eF9xdWV1ZV9yZXNldChzKTsNCj4gKyAgICB9DQo+ICsgICAgaWYgKEZJRUxEX0VYMzIodmFsLCBS
RVNFVF9DVFJMLCBJQklfUVVFVUVfUkVTRVQpKSB7DQo+ICsgICAgICAgIGR3X2kzY19pYmlfcXVl
dWVfcmVzZXQocyk7DQo+ICsgICAgfQ0KPiArfQ0KPiArDQo+ICBzdGF0aWMgdWludDMyX3QgZHdf
aTNjX3BvcF9yeChEV0kzQyAqcykgIHsNCj4gICAgICBpZiAoZmlmbzMyX2lzX2VtcHR5KCZzLT5y
eF9xdWV1ZSkpIHsgQEAgLTE2MzQsNiArMTc1MCw3IEBAIHN0YXRpYw0KPiB2b2lkIGR3X2kzY193
cml0ZSh2b2lkICpvcGFxdWUsIGh3YWRkciBvZmZzZXQsIHVpbnQ2NF90IHZhbHVlLA0KPiAgICAg
ICAgICBkd19pM2NfY21kX3F1ZXVlX3BvcnRfdyhzLCB2YWwzMik7DQo+ICAgICAgICAgIGJyZWFr
Ow0KPiAgICAgIGNhc2UgUl9SRVNFVF9DVFJMOg0KPiArICAgICAgICBkd19pM2NfcmVzZXRfY3Ry
bF93KHMsIHZhbDMyKTsNCj4gICAgICAgICAgYnJlYWs7DQo+ICAgICAgY2FzZSBSX0lOVFJfU1RB
VFVTOg0KPiAgICAgICAgICBkd19pM2NfaW50cl9zdGF0dXNfdyhzLCB2YWwzMik7IGRpZmYgLS1n
aXQgYS9ody9pM2MvdHJhY2UtZXZlbnRzDQo+IGIvaHcvaTNjL3RyYWNlLWV2ZW50cyBpbmRleCBh
MjYyZmNjZTM5Li4zOWYzM2Q5YTUwIDEwMDY0NA0KPiAtLS0gYS9ody9pM2MvdHJhY2UtZXZlbnRz
DQo+ICsrKyBiL2h3L2kzYy90cmFjZS1ldmVudHMNCj4gQEAgLTExLDYgKzExLDcgQEAgZHdfaTNj
X3NlbmQodWludDMyX3QgZGV2aWNlaWQsIHVpbnQzMl90IG51bV9ieXRlcykNCj4gIkkzQyBEZXZb
JXVdIHNlbmQgJSIgUFJJZDMyICINCj4gIGR3X2kzY19yZWN2X2RhdGEodWludDMyX3QgZGV2aWNl
aWQsIHVpbnQzMl90IG51bV9ieXRlcykgIkkzQyBEZXZbJXVdIHJlY3YNCj4gJSIgUFJJZDMyICIg
Ynl0ZXMgZnJvbSBidXMiDQo+ICBkd19pM2NfaWJpX3JlY3YodWludDMyX3QgZGV2aWNlaWQsIHVp
bnQ4X3QgaWJpX2J5dGUpICJJM0MgRGV2WyV1XSByZWN2IElCSQ0KPiBieXRlIDB4JSIgUFJJeDgg
IGR3X2kzY19pYmlfaGFuZGxlKHVpbnQzMl90IGRldmljZWlkLCB1aW50OF90IGFkZHIsIGJvb2wg
cm53KQ0KPiAiSTNDIERldlsldV0gaGFuZGxlIElCSSBmcm9tIGFkZHJlc3MgMHglIiBQUkl4OCAi
IFJuVz0lZCINCj4gK2R3X2kzY19yZXNldCh1aW50MzJfdCBkZXZpY2VpZCkgIkkzQyBEZXZbJXVd
IHJlc2V0Ig0KPiAgZHdfaTNjX3BvcF9yeCh1aW50MzJfdCBkZXZpY2VpZCwgdWludDMyX3QgZGF0
YSkgIkkzQyBEZXZbJXVdIHBvcCAweCUiDQo+IFBSSXgzMiAiIGZyb20gUlggRklGTyINCj4gIGR3
X2kzY19yZXNwX3F1ZXVlX3B1c2godWludDMyX3QgZGV2aWNlaWQsIHVpbnQzMl90IGRhdGEpICJJ
M0MgRGV2WyV1XQ0KPiBwdXNoIDB4JSIgUFJJeDMyICIgdG8gcmVzcG9uc2UgcXVldWUiDQo+ICBk
d19pM2NfcHVzaF90eCh1aW50MzJfdCBkZXZpY2VpZCwgdWludDMyX3QgZGF0YSkgIkkzQyBEZXZb
JXVdIHB1c2ggMHglIg0KPiBQUkl4MzIgIiB0byBUWCBGSUZPIg0KPiAtLQ0KPiAyLjUwLjAucmMx
LjU5MS5nOWM5NWYxN2Y2NC1nb29nDQoNClJldmlld2VkLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xp
bkBhc3BlZWR0ZWNoLmNvbT4NCg0KVGhhbmtzLA0KSmFtaW4NCg0KDQo=

