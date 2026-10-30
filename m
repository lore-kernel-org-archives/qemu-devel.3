Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13CC606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 03:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=PzI2mTLn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMdB7-0004OO-NV; Thu, 29 Oct 2026 23:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xMdB5-0004O2-Tb; Thu, 29 Oct 2026 23:21:15 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xMdB2-00016c-UI; Thu, 29 Oct 2026 23:21:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDIVbQgqPo43UcF/6gPcKRrA7jUNfdOhtw9/Ax87UV5MCrxhHMfKrC7DSQpEDKQBZA63KdQTNPenIC/a285WEaSOjyYHzgBpPMtXERZly6xRLoDL8mEqXz2VKaunqKqLhKEQYtyZIg4itpxzheIXdAxEMtM/0EVsIQj2E6y9TOkb3CaShJSipYiLW9Rhyjqpo+OpnLJ5uT8kHwTIGWUtZEE6bE6lB4va37JkUi7rplyigyEj3WmUC0i1cqQynLCrZE/PUVbHijl877XtCg+zy212agAwwevIc1ZBKzj9x+/EQJqDjkMjhP2V1l+kCv/j7xeaSULWlW8fu1ShOPJ+IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9EDN9H6iFyHACjkrakoj78mGJ/ip2uY7AkbNn4LXiY=;
 b=jCfxwJfQRSUu4NPdm08+VIbLyn8WbT/Ygpl0IAHtvfEOYu7Bw0uyF47RIflw+UWUQiVDlc8HmN7GIsFNm2SxyYdSS2OecEz+sLMp/975wd6KJvuq3H1u0ayWTXLDUJsDJ3hKsNuaXpogypMUY4lpkmKdqrMAI3wgFCGZoq5goJpg6BJkKkOtzQknYqhApgEyylUF/HoQ1VamCLnI4VbezkHrpZ3PUC5KtLT9RPdGI2Nyb+Q1TXggoXFV10/us746p+7eigt2i06ixKKyiIAfghFBAXxepBXgFRIgJP+yIf+g/7kzint4gWk+20ZEPShIZZAxW3D2Dyss2+UN1yD8vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9EDN9H6iFyHACjkrakoj78mGJ/ip2uY7AkbNn4LXiY=;
 b=PzI2mTLngkF4WSoF2xtFOQ4GM5Qszh9a4iKa9ihLdRA0Gl3a9IXmQbK2b4dCZkOKWzX9DaKKYSSte2wM/XQwxn25X2976XhqIDP2ijlhOkGe+s+WojVMy6czYLKCkXgXofkZLLWUOn4ijMEE4sl0rAK+yJoaFDHoNwbezxf4r4KW7MMT85ngG6PxUnAZ31ZlTH9dIh8uwN8EutfOc/GhgTxeUyD0j6aEx54cyBUVslmkPtPo9s2Rg0PhRuTAKUHIU7XRRCnJ1KIq83e46XnclnzbKFbpVrVcL7L4aJD6Ox+iXtgHHaadQ5qBjwX2Ibw7OUqr9h3Fa9RzOoVfgXQbYA==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUZPR06MB8267.apcprd06.prod.outlook.com (2603:1096:d10:63::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.4; Fri, 30 Oct
 2026 03:21:03 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0592.003; Fri, 30 Oct 2026
 03:21:03 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>
CC: "kraxel@redhat.com" <kraxel@redhat.com>, "junjie.cao@intel.com"
 <junjie.cao@intel.com>, "junjie.cao@linux.dev" <junjie.cao@linux.dev>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v7 4/8] hw/usb/redirect-server: Announce the exported
 device
Thread-Topic: [PATCH v7 4/8] hw/usb/redirect-server: Announce the exported
 device
Thread-Index: AQHdZo5BumtgaWGS+Eqi0U9La8Z+a7cUzRSAgACgeWA=
Date: Fri, 30 Oct 2026 03:21:02 +0000
Message-ID: <SEZPR06MB7362E722589FC817C0D4FD78FC6D2@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20261028034140.367393-1-jamin_lin@aspeedtech.com>
 <20261028034140.367393-5-jamin_lin@aspeedtech.com>
 <179329584772.3884549.14074212173976966982.b4-review@b4>
In-Reply-To: <179329584772.3884549.14074212173976966982.b4-review@b4>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KUZPR06MB8267:EE_
x-ms-office365-filtering-correlation-id: ae53c47d-c6c8-441a-1ac0-08df3634d3d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|4143699003|5023799004|56012099006|261009223027099003|261028144727099003|261026140227099003|261022105027099003|261026121527099003|261022075727099003|261021123027099003|261021121427099003|10067099003|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: jwAGlmu4ENnmyTCxT8qt3mD4fsZ2NLqeVnA/Xcmw5mD5gEcQpwOOKOSwxz5vx+DtHcnbXQ+WoIc52fo7S2f5ntfocxuXCpU8MfQiT3731b67oTeH7qTrRbrfBT1eS5j6d8JcBaPC8bR6DzsnfGlGlsSxwexapYMPcLrHm4YqseY0tZUJ4qpoVBSKhQ5goDb5EHA8tt20ZuxPuWkhTIMf2ODkvB6R0zhtsdurLqaaFu2pjL1OveKTF4adEUtf0jzHY2spAlMzxLO/68B+oCRZCeMfD0Li+thMZrRhMuspVIt5mwgJIHbuFwD4UhpL/dXvJSXSaSA1UcPD0zDmEmifisBWv9MEnmSPAdg7GfOD4mA07jStraQ+K4wLp5FhC0rKr5MVvhDPkwKfvS9xqDmVwYOC7B1mdoZy67jdKBrfDqUGinBSSsTlJhgUPxeq0/s+ZvowxqWBb4wj44d6+pTpLeJlRgYsaDygSqIdrEPOjnuEdw4PoAQrm7RtsKmci9tYwretohKyBRy0roJQMDe/wB7TfA4otav9OCs7eBQfkHjWAGLlWNCBxCaqPw87FAXSxAq1JBRZ35HoUzS7rJxOGasQOWwJUOiHB8A68doYmHlGAyR4SJ/CoMF3yItPqLpEltomc1wWwgzeUlOyG1CpYBQobRXy17rLrtKo01Mzo5OiHZUWoDhFcg6CZyVme8NYdDxITtx3cOjRXVgJRwkiPOAOmJfEE4m5PDgQ6EMsr58=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(4143699003)(5023799004)(56012099006)(261009223027099003)(261028144727099003)(261026140227099003)(261022105027099003)(261026121527099003)(261022075727099003)(261021123027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2dXOURtRmZMRktzRnBpUzlIaVJ3YmFzRk5PRGdKV08vbnphWEUvcFVlM3BP?=
 =?utf-8?B?UEw1T1pXR0lMemNhR05iQTlrOW1XUnRpUEVyOWxnVHpwL2Z0bkRSY25pZDFu?=
 =?utf-8?B?OUY5OG9CMldjY1doQzJ5YUhwSnJvTFlpZlZYREhLMVJFbkJPYWR3a0x4MWs2?=
 =?utf-8?B?UmoxdEh5UVpxeUcvdmtkWVNRT3V2V1poVnZVa0x6RUE1Q0pZZy9jZjRBeVVN?=
 =?utf-8?B?TGowc2ZGcHhGUGZHSDJLdW1hL0EwOFlxVTFIeUFwajlQcWJTY0ppN0M4U2N3?=
 =?utf-8?B?a2phOUxaZmRuQU8raXJ5N3lCNXk1cjNNM0tIb3g5VC9hUUZ3T3dyQTZ0aDBx?=
 =?utf-8?B?RXJ1TDBjdkNCMTlwM3JQbG1QOTJiSnRhdzBub2ZnanF2a0tlb0RxclhHcjZ5?=
 =?utf-8?B?MW9Xa2YzN1hYVmtrVUxzVXdocmZadEIrYk5RWHVqK0hMb2dZZXpCQkhMNm9z?=
 =?utf-8?B?amFaQTg0Nm9LQjB0b0hPaDE3bEV5Q1Zrcm1VQlpWOXlUakxqeVFHbkdHM1lk?=
 =?utf-8?B?MDY2RlZHOW1hQ3RDU3phT0JqTGdaa0R5NzMxUVp6L2QxbHRYazB4NGdFbS8z?=
 =?utf-8?B?ZDVKcjJCUHpEa1pQTTM3K3JYa3VoanZtb3pFK0dBWVJ6ODRRWWFrYlU2SHRQ?=
 =?utf-8?B?RmRLYVJOaXROS3J0R21kbkQ4MGNCNFdwRUIxMHJCOW9wSjJPdnZ2WHhBbWFv?=
 =?utf-8?B?emRaZTNabjFZdHAvSGEwdjNjTVZ1ZGt2SStKM3k2Z3NzemowM3lCT2Zqejc3?=
 =?utf-8?B?OFJhU1UzaWt0SnZJU1dwRzlJNTRCZFZuRkpZYU9RdWkwY1ZCQkRtc3RmdjJj?=
 =?utf-8?B?YzBCQmd5K01LQUd5bEc1L254MkZwaTFNc3dzcE9Qa3Y5MnlpSHpLbmFXcCtL?=
 =?utf-8?B?LzZ2V3ljQUtZZ3lRa1craDlleERtUmR3c3hRWC9SZElFem5jcWZNaEpMVEVX?=
 =?utf-8?B?MzJ2cUhENXBkSjAzcDg5cGFtWWNpTEpLOHRPbm5HbFEvSXNzZ29oR1BuMU12?=
 =?utf-8?B?dnB1RE5SUmRvS3hNckVPNGhoMlJiKzFHNUpndktjTXphV0VhS0MxdHYvdjFy?=
 =?utf-8?B?c3c1djBNRno3M29XS2RBQVVrUXlzTDdDR0ZNb1hPWEFEWm5JeU5qQVhVckJh?=
 =?utf-8?B?ZWNZdmROd3R6Ly9ja0tKM3BuVlJFUytPZ2Ird0UwaFNjNE55ZXZyNjNoYlBJ?=
 =?utf-8?B?ZEZGNE0vaUExdkNvVHNyaTVyb2NuTFY0alcyUjVDOHA3bXcxY0hqcWlFSEY0?=
 =?utf-8?B?ZENyajA5c3ZWV1l3Y2dQU0tHTHczL0h3NmNsY0dxdVpmL0VlS1l6REtnS2Nh?=
 =?utf-8?B?YlRZOS9XcjZEYTh0UW9HeEp3ZkdFRzJHejNnNStVN0FKTGV6a2xrcnIva2xZ?=
 =?utf-8?B?MUZuQ1RYUTAybFJVZFZZalJ0dDUzOVZpdWMxNGFzTzNibHJ5YWRjZUIrZ0Z5?=
 =?utf-8?B?dnJ2Z0FpSmtDQmttcCsvOVQxeFhENDU0d3hkVGZERmJnNTRkVU1iSWg0Zk1S?=
 =?utf-8?B?VklzSXFXZGpPSDUva3VFdHpTeTNNY0t6QWhjeUdYeElSdFRxUkRVdStpbmdt?=
 =?utf-8?B?Nmc2b0krcGpqL28wSU1IaDR6YUREMUVnSjhPU25OOXFSWmlFNXFtZ1Fiby9a?=
 =?utf-8?B?VHVTNmxIMXI0d0wyREdldzV6SU03N2NGVklLeHpWWWVLUGpKWklnOVJsVVA2?=
 =?utf-8?B?VjhuL3pGRjdwaFMzSnVMRE56WmwyT1VsSTFWQ1kyWGRUQVR6aE5BMWpmTEFQ?=
 =?utf-8?B?UmJmZVdGOVRpcjlNN3h2SGxITVdlbE9GY2twcmMvb0YyeGFiVkFpUHExeVB6?=
 =?utf-8?B?eURXTU8vaGxsUTBqa2h1ZCtCd3E2bHJuVXVTcDZ5elh5R1gyRjJvekEyQTNB?=
 =?utf-8?B?RHVDUGRBVDlFYXZrSWlDbGllT3AzUVJvOE9hbEdGU0VrektuS1pYUlFDbE9C?=
 =?utf-8?B?dk1KZFVET0VIdDZ0ZGlCeWZOaEZGbWpmbmJSc1Jrdm5IVXpybkpkZmU3OWRF?=
 =?utf-8?B?cVBQdXl3Mk9XcWtBWTBVb1RvN3JUOEtqeGs0dGtidmVsSzMvQUF3YkJqNnZJ?=
 =?utf-8?B?MUJPVm5Eb0ZwdDEwck5nNFhXcmE3Kzl2UTU1bDZzRzZEM2paQnhteERIT084?=
 =?utf-8?B?WllLelZqZmtobCs1cUpmbDhMTjJQaG1QNVdPV1YwL2RaUTVtaTU4dlloR2pl?=
 =?utf-8?B?SGJ6a2kxcWhxM1c3ZFVaRVd5OUZvczZ3d3owOFNuWEYxRnpySjVLclB2L2ls?=
 =?utf-8?B?dmFwYzhRNGRxNUtPbm1vQTZ1bFJZWnlId2hlN29WWVhkNVliR2tWWHB3Y1d1?=
 =?utf-8?B?ODE2TUkrYWtRMlg1RjNqVTZRTmNhREozbjltYjJvOXJhK3FpTG5XUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae53c47d-c6c8-441a-1ac0-08df3634d3d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2026 03:21:03.0100 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0OKY0M5FVToH1JLG0hzj4Kcs/ghoLqMqfLo3gYUuI3UZKx4J+nWh52yNxuJJvRTv+hPtVd1TY4CaESEGwOq95BDr81U7nqQDBT7X9sWcedk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8267
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgTWFyYy1BbmRyw6kgTHVyZWF1DQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyA0LzhdIGh3
L3VzYi9yZWRpcmVjdC1zZXJ2ZXI6IEFubm91bmNlIHRoZSBleHBvcnRlZA0KPiBkZXZpY2UNCj4g
DQo+ID4gU2VuZCBkZXZpY2VfY29ubmVjdCB3aGVuIGEgZGV2aWNlIGlzIGF0dGFjaGVkIGFuZCB0
aGUgaG9zdCBoYXMgZ3JlZXRlZA0KPiA+IHVzLCBkZXZpY2VfZGlzY29ubmVjdCB3aGVuIGl0IGdv
ZXMgYXdheSwgYW5kIGhhbmRsZSB0aGUgYnVzIHJlc2V0IHRoZQ0KPiA+IGhvc3Qgc2VuZHMgYmVm
b3JlIGVudW1lcmF0aW5nLg0KPiA+DQo+ID4gZGV2aWNlX2Nvbm5lY3QgY2FycmllcyBubyBpZGVu
dGl0eS4gVGhlIHBlZXIgYXNrcyB0aGUgZGV2aWNlIGl0c2VsZg0KPiA+IHdpdGggR0VUX0RFU0NS
SVBUT1IgYXMgc29vbiBhcyBpdCBlbnVtZXJhdGVzLCBzbyBhbnl0aGluZyB3ZSBwdXQgdGhlcmUN
Cj4gPiB3b3VsZCBiZSBtYWRlIHVwLiBUaGUgc3BlZWQgaXMgcmVhbDogaXQgY29tZXMgZnJvbSB0
aGUgZGV2aWNlIG9uIG91ciBwb3J0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGlu
IDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IE1hcmMtQW5kcsOp
IEx1cmVhdSA8bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPg0KPiA+IE1lc3NhZ2UtSUQ6IDwy
MDI2MTAyODAzNDE0MC4zNjczOTMtNS1qYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0t
DQo+ID4gIGh3L3VzYi9yZWRpcmVjdC1zZXJ2ZXIuYyB8IDEzMA0KPiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0NCj4gPiAgaHcvdXNiL3RyYWNlLWV2ZW50cyAgICAgIHwg
ICA3ICsrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDEzNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvdXNiL3JlZGlyZWN0LXNlcnZlci5jIGIv
aHcvdXNiL3JlZGlyZWN0LXNlcnZlci5jIGluZGV4DQo+ID4gNDk3MWQ4MWFmNDg5Li5hZDZlNGM0
MjJiYjkgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvdXNiL3JlZGlyZWN0LXNlcnZlci5jDQo+ID4gKysr
IGIvaHcvdXNiL3JlZGlyZWN0LXNlcnZlci5jDQo+ID4gQEAgLTU2LDYgKzU2LDcgQEANCj4gPiAg
I2luY2x1ZGUgInFlbXUvbWFpbi1sb29wLmgiDQo+ID4gICNpbmNsdWRlICJxZW11L21vZHVsZS5o
Ig0KPiA+ICAjaW5jbHVkZSAibWlncmF0aW9uL3Ztc3RhdGUuaCINCj4gPiArI2luY2x1ZGUgInFl
bXUvY3V0aWxzLmgiDQo+ID4gICNpbmNsdWRlICJody9jb3JlL3N5c2J1cy5oIg0KPiA+ICAjaW5j
bHVkZSAiaHcvdXNiL3VzYi5oIg0KPiA+ICAjaW5jbHVkZSAiY2hhcmRldi9jaGFyLWZlLmgiDQo+
ID4gQEAgLTkwLDEyICs5MSw4OCBAQCBzdHJ1Y3QgVVNCUmVkaXJTZXJ2ZXIgew0KPiA+ICAgICAg
Ym9vbCBpbl93cml0ZTsNCj4gPiAgICAgIGd1aW50IHdhdGNoOw0KPiA+ICAgICAgYm9vbCBob3N0
X2Nvbm5lY3RlZDsNCj4gPiArICAgIGJvb2wgZGV2aWNlX2Fubm91bmNlZDsNCj4gPiAgfTsNCj4g
Pg0KPiA+ICsvKg0KPiA+ICsgKiBUaGUgZGV2aWNlIGlzIHdoYXRldmVyIFVTQkRldmljZSB0aGUg
dXNlciBwbHVnZ2VkIGludG8gb3VyIHBvcnQNCj4gPiArd2l0aA0KPiA+ICsgKiAiLWRldmljZSA8
ZGV2aWNlPixidXM9PGlkPi4wIi4gTlVMTCB1bnRpbCB0aGVuLg0KPiA+ICsgKi8NCj4gPiArc3Rh
dGljIFVTQkRldmljZSAqdXNicmVkaXJfc2VydmVyX2RldmljZShVU0JSZWRpclNlcnZlciAqcykg
ew0KPiA+ICsgICAgcmV0dXJuIHMtPnBvcnQuZGV2Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICsvKg0K
PiA+ICsgKiBEZXZpY2UgYW5ub3VuY2VtZW50DQo+ID4gKyAqLw0KPiA+ICsNCj4gPiArc3RhdGlj
IHVpbnQ4X3QgdXNicmVkaXJfc2VydmVyX3NwZWVkKFVTQkRldmljZSAqZGV2aWNlKSB7DQo+ID4g
KyAgICBzd2l0Y2ggKGRldmljZS0+c3BlZWQpIHsNCj4gPiArICAgIGNhc2UgVVNCX1NQRUVEX0xP
VzoNCj4gPiArICAgICAgICByZXR1cm4gdXNiX3JlZGlyX3NwZWVkX2xvdzsNCj4gPiArICAgIGNh
c2UgVVNCX1NQRUVEX0ZVTEw6DQo+ID4gKyAgICAgICAgcmV0dXJuIHVzYl9yZWRpcl9zcGVlZF9m
dWxsOw0KPiA+ICsgICAgZGVmYXVsdDoNCj4gPiArICAgICAgICByZXR1cm4gdXNiX3JlZGlyX3Nw
ZWVkX2hpZ2g7DQo+ID4gKyAgICB9DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIHVz
YnJlZGlyX3NlcnZlcl9hbm5vdW5jZV9kZXZpY2UoVVNCUmVkaXJTZXJ2ZXIgKnMpIHsNCj4gPiAr
ICAgIFVTQkRldmljZSAqZGV2aWNlID0gdXNicmVkaXJfc2VydmVyX2RldmljZShzKTsNCj4gPiAr
ICAgIHN0cnVjdCB1c2JfcmVkaXJfaW50ZXJmYWNlX2luZm9faGVhZGVyIGlmYWNlX2luZm8gPSB7
DQo+ID4gKyAgICAgICAgLmludGVyZmFjZV9jb3VudCA9IDAsDQo+ID4gKyAgICB9Ow0KPiA+ICsg
ICAgc3RydWN0IHVzYl9yZWRpcl9kZXZpY2VfY29ubmVjdF9oZWFkZXIgY29ubiA9IHt9Ow0KPiA+
ICsNCj4gPiArICAgIGlmICghcy0+aG9zdF9jb25uZWN0ZWQgfHwgcy0+ZGV2aWNlX2Fubm91bmNl
ZCB8fA0KPiA+ICsgICAgICAgICFkZXZpY2UgfHwgIWRldmljZS0+YXR0YWNoZWQpIHsNCj4gPiAr
ICAgICAgICByZXR1cm47DQo+ID4gKyAgICB9DQo+ID4gKyAgICBzLT5kZXZpY2VfYW5ub3VuY2Vk
ID0gdHJ1ZTsNCj4gPiArICAgIGNvbm4uc3BlZWQgPSB1c2JyZWRpcl9zZXJ2ZXJfc3BlZWQoZGV2
aWNlKTsNCj4gPiArDQo+ID4gKyAgICAvKiBQdXQgdGhlIGRldmljZSBpbiBERUZBVUxUIHN0YXRl
LiBUaGUgaG9zdCBtYXkgbm90IHJlc2V0IHRoZSBidXMuICovDQo+ID4gKyAgICBkZXZpY2UtPmFk
ZHIgPSAwOw0KPiA+ICsgICAgZGV2aWNlLT5zdGF0ZSA9IFVTQl9TVEFURV9ERUZBVUxUOw0KPiAN
Cj4gdXNiX2F0dGFjaCgpIG92ZXJ3cml0ZXMgdGhpcyB3aXRoIFVTQl9TVEFURV9BVFRBQ0hFRCBy
aWdodCBhZnRlciB0aGUgcG9ydA0KPiBhdHRhY2ggY2FsbGJhY2sgcmV0dXJucy4gQSBzdWJzZXF1
ZW50IGNvbnRyb2wgcmVxdWVzdCBmcm9tIHRoZSBwZWVyIHdvdWxkIHRyaXANCj4gdGhlIGRldi0+
c3RhdGUgPT0gVVNCX1NUQVRFX0RFRkFVTFQgYXNzZXJ0aW9uIGluIHVzYl9oYW5kbGVfcGFja2V0
KCkuDQo+IA0KPiBZb3UgY291bGQgYW5ub3VuY2Ugd2l0aCBhIEJIIGluc3RlYWQgKGNhbmNlbCBp
dCBvbiBkZXRhY2gpIGFuZCB1c2UNCj4gdXNiX2RldmljZV9yZXNldCgpIGluc3RlYWQgb2YgbWFu
dWFsbHkgcG9raW5nIHRoZSBmaWVsZHMgYmVmb3JlIGFubm91bmNpbmcuDQo+IA0KDQpUaGFua3Mg
Zm9yIHRoZSByZXZpZXcgYW5kIHN1Z2dlc3Rpb24uDQpXaWxsIGZpeCBpdCBhbmQgYWxzbyBkcm9w
IHRoZSBSZXZpZXdlZC1ieSB0YWcuDQoNCkphbWluDQoNCj4gLS0NCj4gTWFyYy1BbmRyw6kgTHVy
ZWF1IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+DQoNCg==

