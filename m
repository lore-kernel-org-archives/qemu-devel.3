Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7CEC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 09:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4chT-0002O1-5r; Tue, 15 Apr 2025 05:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u4chO-0002NV-Fh; Tue, 15 Apr 2025 05:35:22 -0400
Received: from mail-tyzapc01on20726.outbound.protection.outlook.com
 ([2a01:111:f403:2011::726]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u4chF-0003az-1d; Tue, 15 Apr 2025 05:35:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OvaBY7hO4oQlY55r3/aLNr+Rm+v2m+mONnGagcTgjOukyXWWnRhS0rcM+6fJ8Xyz3lqfmFvTXoBfnnsvrAVtAjYH2Yh3OiVEm0vQo9P7HjgVQYpolSDsaBXX2p3GdSWDA/6d2xE4y32ROMRpXiNao99YGkOWFnJ3iQYCQ3tyGeNANe6HDljkhdbvGhnlS1AtvyymRDEx3xbKyiEVlUqAn261j/h+/YzLeGv52rci1Ig6j9KkHhIimXFMH6ekGaKmXR4fNcrprDK1eQ8szLE8LQRgreXb3wnToML9TvtuaBM7TPZe9+X7AcsOHhPb/T/LkJ4S7JQaAudzgBGhnXWPOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/5DpsSgL+UoC5Aa4VFaVScFWTbZ3mgdA65ObyO3UNo=;
 b=Efh6OxpEO6yfX7+8iZ2YJuqCA9NnOKnqIJHMhPwrgE+Kk+G0ZHxUUk0LIw0EFALN/bV8UjjsYDsLrrcuL9mGw0y87tIDxLaD7GxSotrmOKH/HAEedNFcts6ef1EEXHKSr/iuUJourNJ/gCZdJdhHHlji3PWVVMW/yHLZ2rXzKYwpLvoMYJyL6XxyP2h+UPZREoHQNcLPfzaE1i/Hw3x7D7nVPJ+NGj1+gvAb4r2wB9NpcHVs7mx5lvni9koKAlyguelTykuijXIMv0FgenNyU2MSMAxSBpq8V/F3E/Pd+vSCu347uhbvnb5nweVvpi42JFLyqlA7y9h1nL9hHqfGsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/5DpsSgL+UoC5Aa4VFaVScFWTbZ3mgdA65ObyO3UNo=;
 b=cGE4EuzGmq/fQ7TRmdDK7dAkAAlcIDgslkVQ0Ydznu/JWRrYvZeVRbcmXmAXwM3BrJb6T2z8brVkzG5jZ3GJyjPCB422uxZKHH7TfC/qmV195FPv9vneZnNV2iJGQPTx2SUZZ2jIJ9zq7pUF9H+25cJSZhwQIl6l/IGtjlg/ihQcVL2mk0Zi5hzvGW6cHRMTNTC26Obfn06R/WX1hPwg6Ln3R869gC8V3Zy0w8rEWXjT1CZWvKU1LqchjttFInlc/xHBBW4ujqO4bdNuYNxEwOm4dv/x+KmgUcI3zK5Zri0mSzW8XpXpCl4L2KVEpVTb1t1zAF3ef0G1YlGPN3A5SA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB6572.apcprd06.prod.outlook.com (2603:1096:101:184::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.27; Tue, 15 Apr 2025 09:34:57 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8632.025; Tue, 15 Apr 2025
 09:34:57 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Nabih Estefan <nabihestefan@google.com>
CC: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, Troy
 Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v2 07/10] hw/arm/aspeed: Add support for loading vbootrom
 image via "-bios"
Thread-Topic: [PATCH v2 07/10] hw/arm/aspeed: Add support for loading vbootrom
 image via "-bios"
Thread-Index: AQHbqcG9me2omjhCUUi7MtZUDXpZTrOepD+AgAPfM9CAAS1ZAIAAxd8A
Date: Tue, 15 Apr 2025 09:34:57 +0000
Message-ID: <SI2PR06MB50413B875162D6ADD2F182ECFCB22@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250410023856.500258-1-jamin_lin@aspeedtech.com>
 <20250410023856.500258-8-jamin_lin@aspeedtech.com>
 <860fbb39-feec-4c1d-b05f-aea7889a698f@kaod.org>
 <SI2PR06MB5041C73D934E10DEC9B66805FCB32@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <CA+QoejUvnwZBqS6nJBi5y=g1-r+f=9SnDD4SQOL3kxqeMbS_cw@mail.gmail.com>
In-Reply-To: <CA+QoejUvnwZBqS6nJBi5y=g1-r+f=9SnDD4SQOL3kxqeMbS_cw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB6572:EE_
x-ms-office365-filtering-correlation-id: e0f6821e-20bf-41b1-399e-08dd7c00c940
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?emJTdjlWTVRramEvNHB2T0U4Y20rTVNDWVBWZzJWbXBrM0c4bmh0S3BhQXNY?=
 =?utf-8?B?RmljeGZKR0Fxc3hzTm16QllXNDlFUS9RYTVFMEZScEx2ZlI2UXdEYVBiOW5B?=
 =?utf-8?B?WUo5eVJuMTFHRGpTT050OFhuem9vcFRlMFYyWGJJNWg2UDNkNkI2d0VLdm5q?=
 =?utf-8?B?c0xJVnl3VURDcDlzdEZLeUhhMmZrTmJuU2NZbGc0TkFtKzNCT1RYUVdmRkRq?=
 =?utf-8?B?MDRDWUpFQlg1YmhubDVVRitmbTJmRGlmSVhmd3BZTU8xbTgvRG9XTVRNRHJl?=
 =?utf-8?B?QWw1Y0FCSmlvOUxTRHF6aW1tenBVNmVjMlJBVzc0R3JBTTRKS1RTRDNzVWhq?=
 =?utf-8?B?OWJVcENRMGZwc3hCNmdVc3NrbmpFOUJ0ek91bVBNN1FRNktWU01zeDN5MGZV?=
 =?utf-8?B?Q2N2eHRaSkZtejRMVFYwZDh6RkJMWXhaVVFhOTVIRXkzRklHQ0RJMk8ySlRh?=
 =?utf-8?B?Yk5wVFpwUFZncnRlVEVWWkpjL0VvNFYzcWFCeUhPTzdOYkRXTGdIYStROUNx?=
 =?utf-8?B?ZytnMkdqQzhuRWNGN0VIYTBTREd4ZTlsNkVKSkNmcEo3VFNLdFU2TlR2VDAr?=
 =?utf-8?B?eTFlQ2NqUE0xd3M1NjFKVWN3bVN2OCt5TVFOU1NQRzZOWSsvRCtNV0tvY0ZC?=
 =?utf-8?B?RnNUOGN3dEpaUm4yb0NBUE5FM2UrWWE5Sncvb2RKS01kemtuakpObmlONDQ4?=
 =?utf-8?B?YkhnQS9VS0Z1djB4SFJsd0ZiZGxXRnR2dDliSC9UWjJpS0dwRDdLMkc1ZVll?=
 =?utf-8?B?T1RPU0U1SDJJd1NxQXRSd2Q1T1FWd1huZGJvdVk0RWszZ3NKUCt4aDhib3dR?=
 =?utf-8?B?MWtNYjl2NzYwVHQvRVltQWZIQm9LSlYzSEttZmg4Yk9tUERjQ3hySk11YW9P?=
 =?utf-8?B?Rzh4cWlkQTB5SXZKWG1YNHdRUFVJNTRORjRpVXE3a0VLS1JNZXhob1VxemZT?=
 =?utf-8?B?NFpDaTJINks0ZFpHcWNZbDJDV1JWL29LaSs5MTNRT3pYM2NWajU0ODVSVEp2?=
 =?utf-8?B?RU9WcG5ZNmRTSlBMdHl6QzIybmlWRU54NWN2akk2d0VFYlNDRlc2a3RGQWl6?=
 =?utf-8?B?YU5TU1BvVXMxT0lBMkJGRmZMaFFZdUdCRWtMSnpwaVNseXdCTFQ1REkycnpY?=
 =?utf-8?B?MzZBV3FUWG4wMU80Q01PMlNBNmtsalRBR3ZHcFNHaHVVMWdYNmFxR05JUjQ4?=
 =?utf-8?B?TmZqWkExeWw0QTROS05mU2NRRzZqSWlZcjRsZGJ5NkRCTTMrN3RJSjg3YkRv?=
 =?utf-8?B?NFp4SjJ3Smw2U1pRdFlpYnlEaXVWbW4yTUhyb3pQY21VUHJ1VFBMSHNhT1Fo?=
 =?utf-8?B?UnJyT1VJUHFFYkRuWDltM3ZPdG9rT3VFRjNYWHdTUnVIanpjM0dORC9MVEdy?=
 =?utf-8?B?M1RpVEY2bmxXaFVsdUc5RmZ1NS8rWTZ6NEJJL3Y3RzJOWVBJNEx0TUdZM0Qv?=
 =?utf-8?B?YTN5UWFPSllZa0xXTHR0ZHkxbTMvc2x0ZGxqeitQYUl0djJHam01dHlGRjl0?=
 =?utf-8?B?T1I4VmZLK2x3T0g1M3Z2YjFHcWhwQXdGMW5tRUcyR0xySW5WWTFIeTRNNlBD?=
 =?utf-8?B?ZWVGOTdob0ZseXY0eFdEUU8wWngvbWlRRUlBa1RYdkNPNklFTVpNVG9SOElD?=
 =?utf-8?B?MWVyMC9QL1BMNE5JL1FMZWlvM1RDQjRkZzBuOEQ2Vi9tV2szN1JCYkwwNGkw?=
 =?utf-8?B?QWllcFlQa2I4SUd5ZTFSM1JrYjhZMVg1ZWVTTmduZExuUlF0bmQzQ2hEYity?=
 =?utf-8?B?aGIvSE91TWs0NWs0WG9NcjVXTDIza3BlVUxoZEpLYU5udndlNWQrU0dvR2U5?=
 =?utf-8?B?RFdNWkU5TVE1SGZqQ2ZZbkdiemV4RlgxcGxMQ3JFWWFSclJQTTMwcS9VV2Iv?=
 =?utf-8?B?eVhHMlNHNHM5cFExazFsZUVtVWEyUStNb0taSjNoOWVKSUE3UHYrNXJrUVRM?=
 =?utf-8?Q?Y/xLqqkyTos=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmNqMGt6ZHJJc0pSS0l2QmlUTFg3UWV1Sit1SUFlSldxbmJmczZmQ2t0MGtK?=
 =?utf-8?B?UmlxS1ovR2NVSWtDNlYxRFlGZ1Y0YnAwVTh2b05SREtXY3JQcXdQRVpyelhh?=
 =?utf-8?B?eGs4RTNXSkxabEt3SC9vTStQU3dvOUxGZFhLN2ZvWlhXR0hRUjN1cGRtb0U2?=
 =?utf-8?B?OWdZQkxnenZYS2tlMkRDM05ueUtUQUtLazB1M0xtR01lUzlCcVRHUDBkSGJZ?=
 =?utf-8?B?ZWRETSt3V1Y4OHEzOVRLaUpFWkJsYmtYV0dTcmdtcWlkSUFhcC95T2h3cEtO?=
 =?utf-8?B?UTlIK0hUNVQwYmpwazFBU241OGdZc05LcjdxVThUQjNEU2o1Vmh4SVcrcVc4?=
 =?utf-8?B?WFNrUDQzTzFMTDBsVTlyUGtTK05aajhVTnRSZGZIcElSQ29oQzk4cXhGVjMw?=
 =?utf-8?B?eHV5MW9yMXR6aWZPa1RNWXNJR29ubUlMMW4rZGRvcWg0Vy93ZU1uSEhMdER3?=
 =?utf-8?B?WEhDS0g2V2RjbDhIRmdzWEFQd0J4Qll3UmliUGpVbW9QdGV3UWNwNXVyRmN4?=
 =?utf-8?B?YS9NWWFFQ3hiRmFXa1NSMFNIaHZ1ZjhKRGs0R0w2L1RaUXFLM3hIMm1INEdG?=
 =?utf-8?B?VTgxQW9YRnFlZVFxNGFqV3JKRVpFMzJ0REF1Z0F1eFh5elZqMHYxeWVpcTFw?=
 =?utf-8?B?WGV0SUpKdmRLNmtTZGdvbUU3K3lvbkZMMkQ2bUZmbVBuRW5PVjFjZ25FUHhE?=
 =?utf-8?B?Mk5IVDc1UlJ6UVZGRDVDWjFzVUszVTd3SWtVQmlHM0RBNm9BL0xYd0d6dDdG?=
 =?utf-8?B?TFMraSthbUJ4bkdKYTJPNnlnK1NYRzNtUGw5bHFKQjZYZmlMYkN3dDNHdkpu?=
 =?utf-8?B?MzI5dXRBa1RUckdzREo3RjNoaXZJcGZtbFpIVmVNT056cEZsSDRTYVl3UkJo?=
 =?utf-8?B?U0RKVzBMcGlIcnB3dUozUmVrWGxnS0hBdDBkSjFxLzhuTU9sRytxb2dzQ1hz?=
 =?utf-8?B?YzNNeGpyaWNEZWFaa0ExbzJuSEpVR1MxeFJnU3laVktReWdJd3YxV3QxYWxP?=
 =?utf-8?B?a2xucmNjeDVIc1Z0U3FuUkFnVTBtRkN0K2lFOHRHODRFbGxxbGtYVTFmSEVV?=
 =?utf-8?B?T0hZWG81dWFhZ0tQeVBHejJKT0JOdUJ0cmU4OTI0UFFndWtIRXFuQ1MwSGZT?=
 =?utf-8?B?dWIyOFNZZEVEVnEwcW5RV3VZc21yTWN2YXBNb2UvTCsvaGs5QWxvbXhjand0?=
 =?utf-8?B?YkNJY25CNURGWGFRMkE3MjBjZkpyakxPVXVZR1Ryd1gycXgvRENQTlNCZkhR?=
 =?utf-8?B?dkVsNm15eFNTUE9aTGhsL3o3ZTJCaFFZelNBcjRrRVpRMG9YWnlzTHU5RHhz?=
 =?utf-8?B?QjNhVGd0cS84d251RUJLaHFHV0d4NG5wZDlVUXlIdW1POUtVdzhQOTRMNlBV?=
 =?utf-8?B?dmFlWUFXUzB1VUZjaTRzbFNnVEkxYnBaRU5URzZrS3hBaS9UR1gvNFBkOERO?=
 =?utf-8?B?MUhYNmxkeHZabytTdW1ZemZ2ZDZiSnVhT2NSWEl0QmZKK1g1TzJtako0SHIw?=
 =?utf-8?B?TFFYbUZLOW13M0FDdGNtOTg0V0dQbmxyYnh1Y0NJYWd2RjZ5bklZQ2lPODRD?=
 =?utf-8?B?RG1rOE1KVGxTVlRubzJIRHJoQ1orY1BiWmVGNEtOOXJYdmRYVWJDWUJrMlho?=
 =?utf-8?B?SEx5S2NUYk9QTGlsWC9Rb1ZheHA1Q0NoTi8wQnlycy9ONENCM1VaV3IyM1J2?=
 =?utf-8?B?b1ZXUEVoRlk5dFZxQjBOcE95VzE2dmVha21pOXB5ZmNOL2VDWGYwczVLSGND?=
 =?utf-8?B?VW1Eazk2YjZOdFljN3N4S2xiZW1ieHpSVVViTWJjSERzVFVQZlVBUkZ0KzRn?=
 =?utf-8?B?R1kyNEFBdDV0cUtaK25PUHZMNVVkckxsV0hwV2ZaN0t4djVjQ1V0dEkzdllN?=
 =?utf-8?B?aC93QU1nNVRFZis1UzNuNnZZNmZaNnpxN1lpZFNrUzZpSjlwc0VocnBMWkFn?=
 =?utf-8?B?YlJUeDB4MWc5MXN1ZkZQaGlmanp6WDM1bE5DRFM1aDRzTGpGWGgyeEpKTjFI?=
 =?utf-8?B?cWU2dmY4ak5yYjIxS1VCZVMra0t5c3Q2VEpOR3VrTlJzTVBvM2EzMTNZRUNM?=
 =?utf-8?B?RGNxbDhxUXpNVVhTQlcwemNRcTJLbUpvWWtac3crYm9EZHNhc0I2ZkdINGJh?=
 =?utf-8?Q?UrCpWgw+X9St2X+zchPjhB0eP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f6821e-20bf-41b1-399e-08dd7c00c940
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 09:34:57.4347 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fV/gkTCXBqoPBVnnKZTKamLAhu2EiIKcm+D/GLte6oMOWcE5iehfgj/P2VtpuDtFXDrQjXgl+BrJqONUVowg0uye6Dz9FsCITu6TonWWMr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6572
Received-SPF: pass client-ip=2a01:111:f403:2011::726;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
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

SGkgTmFiaWgsDQoNCj4gPHFlbXUtYXJtQG5vbmdudS5vcmc+OyBUcm95IExlZSA8dHJveV9sZWVA
YXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDcvMTBdIGh3L2FybS9h
c3BlZWQ6IEFkZCBzdXBwb3J0IGZvciBsb2FkaW5nDQo+IHZib290cm9tIGltYWdlIHZpYSAiLWJp
b3MiDQo+IA0KPiBIaSBKYW1pbiBhbmQgQ2VkcmljLA0KPiANCj4gT24gU3VuLCBBcHIgMTMsIDIw
MjUgYXQgODoxN+KAr1BNIEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiB3
cm90ZToNCj4gPg0KPiA+IEhpIENlZHJpYywNCj4gPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MiAwNy8xMF0gaHcvYXJtL2FzcGVlZDogQWRkIHN1cHBvcnQgZm9yIGxvYWRpbmcNCj4gPiA+
IHZib290cm9tIGltYWdlIHZpYSAiLWJpb3MiDQo+ID4gPg0KPiA+ID4gT24gNC8xMC8yNSAwNDoz
OCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+ID4gPiBJbnRyb2R1Y2UgImFzcGVlZF9sb2FkX3Zib290
cm9tKCkiIHRvIHN1cHBvcnQgbG9hZGluZyBhIHZpcnR1YWwNCj4gPiA+ID4gYm9vdCBST00gaW1h
Z2UgaW50byB0aGUgdmJvb3Ryb20gbWVtb3J5IHJlZ2lvbiwgdXNpbmcgdGhlICItYmlvcyINCj4g
PiA+IGNvbW1hbmQtbGluZSBvcHRpb24uDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6
IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+
ID4gICBody9hcm0vYXNwZWVkLmMgfCAzMiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPiA+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspDQo+ID4gPiA+DQo+
ID4gPiA+IGRpZmYgLS1naXQgYS9ody9hcm0vYXNwZWVkLmMgYi9ody9hcm0vYXNwZWVkLmMgaW5k
ZXgNCj4gPiA+ID4gYjcwYTEyMGU2Mi4uMjgxMTg2OGMxYSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEv
aHcvYXJtL2FzcGVlZC5jDQo+ID4gPiA+ICsrKyBiL2h3L2FybS9hc3BlZWQuYw0KPiA+ID4gPiBA
QCAtMjcsNiArMjcsNyBAQA0KPiA+ID4gPiAgICNpbmNsdWRlICJzeXN0ZW0vcmVzZXQuaCINCj4g
PiA+ID4gICAjaW5jbHVkZSAiaHcvbG9hZGVyLmgiDQo+ID4gPiA+ICAgI2luY2x1ZGUgInFlbXUv
ZXJyb3ItcmVwb3J0LmgiDQo+ID4gPiA+ICsjaW5jbHVkZSAicWVtdS9kYXRhZGlyLmgiDQo+ID4g
PiA+ICAgI2luY2x1ZGUgInFlbXUvdW5pdHMuaCINCj4gPiA+ID4gICAjaW5jbHVkZSAiaHcvcWRl
di1jbG9jay5oIg0KPiA+ID4gPiAgICNpbmNsdWRlICJzeXN0ZW0vc3lzdGVtLmgiDQo+ID4gPiA+
IEBAIC0zMDUsNiArMzA2LDMyIEBAIHN0YXRpYyB2b2lkDQo+ID4gPiBhc3BlZWRfaW5zdGFsbF9i
b290X3JvbShBc3BlZWRNYWNoaW5lU3RhdGUgKmJtYywgQmxvY2tCYWNrZW5kICpibGssDQo+ID4g
PiA+ICAgICAgICAgICAgICAgICAgICAgIHJvbV9zaXplLCAmZXJyb3JfYWJvcnQpOw0KPiA+ID4g
PiAgIH0NCj4gPiA+ID4NCj4gPiA+ID4gKy8qDQo+ID4gPiA+ICsgKiBUaGlzIGZ1bmN0aW9uIGxv
Y2F0ZXMgdGhlIHZib290cm9tIGltYWdlIGZpbGUgc3BlY2lmaWVkIHZpYQ0KPiA+ID4gPiArdGhl
IGNvbW1hbmQgbGluZQ0KPiA+ID4gPiArICogdXNpbmcgdGhlIC1iaW9zIG9wdGlvbi4gSXQgbG9h
ZHMgdGhlIHNwZWNpZmllZCBpbWFnZSBpbnRvIHRoZQ0KPiA+ID4gPiArdmJvb3Ryb20NCj4gPiA+
ID4gKyAqIG1lbW9yeSByZWdpb24gYW5kIGhhbmRsZXMgZXJyb3JzIGlmIHRoZSBmaWxlIGNhbm5v
dCBiZSBmb3VuZCBvcg0KPiBsb2FkZWQuDQo+ID4gPiA+ICsgKi8NCj4gPiA+ID4gK3N0YXRpYyB2
b2lkIGFzcGVlZF9sb2FkX3Zib290cm9tKE1hY2hpbmVTdGF0ZSAqbWFjaGluZSwgdWludDY0X3QN
Cj4gPiA+ID4gK3JvbV9zaXplKQ0KPiA+ID4NCj4gPiA+IHBsZWFzZSBhZGQgYW4gJ0Vycm9yICoq
JyBwYXJhbWV0ZXIgYW5kIGxldCB0aGUgY2FsbGVyIGRlY2lkZSB0byBleGl0Lg0KPiA+ID4NCj4g
Pg0KPiA+IFdpbGwgYWRkLg0KPiA+DQo+ID4gPiA+ICt7DQo+ID4gPiA+ICsgICAgQXNwZWVkTWFj
aGluZVN0YXRlICpibWMgPSBBU1BFRURfTUFDSElORShtYWNoaW5lKTsNCj4gPiA+ID4gKyAgICBj
b25zdCBjaGFyICpiaW9zX25hbWUgPSBtYWNoaW5lLT5maXJtd2FyZTsNCj4gPiA+ID4gKyAgICBn
X2F1dG9mcmVlIGNoYXIgKmZpbGVuYW1lID0gTlVMTDsNCj4gPiA+ID4gKyAgICBBc3BlZWRTb0NT
dGF0ZSAqc29jID0gYm1jLT5zb2M7DQo+ID4gPiA+ICsgICAgaW50IHJldDsNCj4gPiA+ID4gKw0K
PiA+ID4gPiArICAgIGZpbGVuYW1lID0gcWVtdV9maW5kX2ZpbGUoUUVNVV9GSUxFX1RZUEVfQklP
UywgYmlvc19uYW1lKTsNCj4gPiA+DQo+ID4gPiBXaGF0IGlmIHRoZSB1c2VyIGRpZG4ndCBwcm92
aWRlIGFueSAtYmlvcyBjb21tYW5kIGxpbmUgb3B0aW9uID8NCj4gPiA+DQo+ID4NCj4gPg0KPiA+
IFdpbGwgdXBkYXRlIHRvIHN1cHBvcnQgYm90aCB2Ym9vdHJvbSBhbmQgbG9hZGVyLg0KPiANCj4g
Rm9yIHRoaXMgY2FzZSwgY291bGQgd2UgaGF2ZSBzb21ldGhpbmcgbGlrZSB0aGUgbnBjbTh4eF9i
b2FyZC5jIHdoZXJlIHdlDQo+IGhhdmUgYSBkZWZhdWx0IGJvb3Ryb20gYW5kIG92ZXJyaWRlIGl0
IHdpdGggLWJpb3M/IFRoYXQgd291bGQgYWxzbyBmaXggdGhlIHF0ZXN0DQo+IGlzc3VlcyB3aXRo
IHRoZSBhc3QyNzAwIHF0ZXN0cyB3aGljaCBmYWlsIHdpdGggdGhpcyBwYXRjaHNldC4NCj4NCkRv
IHlvdSBtZWFuIHRoYXQgaWYgdGhlIHVzZXIgZG9lcyBub3Qgc3BlY2lmeSAiLWJpb3MiLCB3ZSBz
aG91bGQgc3RpbGwgbG9hZCBhIGRlZmF1bHQgdmJvb3Ryb20gaW1hZ2UgaW50byB0aGUgdmJvb3Ry
b20gbWVtb3J5IHJlZ2lvbj8NCldlIGNhbiB2ZXJpZnkgd2hldGhlciAtYmlvcyB3YXMgcHJvdmlk
ZWQgYnkgY2hlY2tpbmcgaWYgbWFjaGluZS0+ZmlybXdhcmUgaXMgTlVMTC4NCkl0IHNlZW1zIHRo
YXQgaWYgdGhlIHVzZXIgZG9lc24ndCBwcm92aWRlIC1iaW9zLCBOUENNIFFFTVUgd2lsbCBsb29r
IGZvciBhIGRlZmF1bHQgdmJvb3Ryb20gaW1hZ2UgaW4gdGhlIGN1cnJlbnQgd29ya2luZyBkaXJl
Y3Rvcnkg4oCUIGlzIHRoYXQgY29ycmVjdD8NCmh0dHBzOi8vZ2l0aHViLmNvbS9xZW11L3FlbXUv
YmxvYi9tYXN0ZXIvaHcvYXJtL25wY204eHhfYm9hcmRzLmMjTDM3DQoNCmBgYA0KY29uc3QgY2hh
ciAqYmlvc19uYW1lID0gbWFjaGluZS0+ZmlybXdhcmUgPzogbnBjbTh4eF9kZWZhdWx0X2Jvb3Ry
b207DQpgYGANCkNvdWxkIHlvdSBsZXQgbWUga25vdyB3aGljaCBxdGVzdChzKSBmYWlsZWQsIHNv
IEkgY2FuIHJ1biB0aGVtIGFuZCB2ZXJpZnkgZXZlcnl0aGluZyBiZWZvcmUgc2VuZGluZyBvdXQg
dGhlIHYzIHBhdGNoPw0KDQpUaGFua3MtSmFtaW4NCg0KPiA+DQo+ID4gPiA+ICsgICAgaWYgKCFm
aWxlbmFtZSkgew0KPiA+ID4gPiArICAgICAgICBlcnJvcl9yZXBvcnQoIkNvdWxkIG5vdCBmaW5k
IHZib290cm9tIGltYWdlICclcyciLA0KPiBiaW9zX25hbWUpOw0KPiA+ID4gPiArICAgICAgICBl
eGl0KDEpOw0KPiA+ID4gPiArICAgIH0NCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgIHJldCA9IGxv
YWRfaW1hZ2VfbXIoZmlsZW5hbWUsICZzb2MtPnZib290cm9tKTsNCj4gPiA+ID4gKyAgICBpZiAo
cmV0IDwgMCkgew0KPiA+ID4gPiArICAgICAgICBlcnJvcl9yZXBvcnQoIkZhaWxlZCB0byBsb2Fk
IHZib290cm9tIGltYWdlICclcyciLCBmaWxlbmFtZSk7DQo+ID4gPiA+ICsgICAgICAgIGV4aXQo
MSk7DQo+ID4gPiA+ICsgICAgfQ0KPiA+ID4gPiArfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICAgdm9p
ZCBhc3BlZWRfYm9hcmRfaW5pdF9mbGFzaGVzKEFzcGVlZFNNQ1N0YXRlICpzLCBjb25zdCBjaGFy
DQo+ID4gPiAqZmxhc2h0eXBlLA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdW5zaWduZWQgaW50IGNvdW50LCBpbnQNCj4gPiA+IHVuaXQwKQ0KPiA+ID4g
PiAgIHsNCj4gPiA+ID4gQEAgLTQ4Myw2ICs1MTAsMTEgQEAgc3RhdGljIHZvaWQgYXNwZWVkX21h
Y2hpbmVfaW5pdChNYWNoaW5lU3RhdGUNCj4gPiA+ICptYWNoaW5lKQ0KPiA+ID4gPiAgICAgICAg
ICAgfQ0KPiA+ID4gPiAgICAgICB9DQo+ID4gPiA+DQo+ID4gPiA+ICsgICAgaWYgKGFtYy0+dmJv
b3Ryb20pIHsNCj4gPiA+ID4gKyAgICAgICAgcm9tX3NpemUgPSBtZW1vcnlfcmVnaW9uX3NpemUo
JmJtYy0+c29jLT52Ym9vdHJvbSk7PiArDQo+ID4gPiBhc3BlZWRfbG9hZF92Ym9vdHJvbShtYWNo
aW5lLCByb21fc2l6ZSk7DQo+ID4gPiA+ICsgICAgfQ0KPiA+ID4gPiArDQo+ID4gPg0KPiA+ID4g
RXZlbiB3aXRob3V0IGEgdmJvb3Ryb20gZmlsZSwgdGhlIG1hY2hpbmUgY291bGQgYm9vdCB3aXRo
ICctZGV2aWNlIGxvYWRlcicNCj4gPiA+IG9wdGlvbnMuIFdlIHNob3VsZCBwcmVzZXJ2ZSB0aGlz
IHdheSBvZiBib290aW5nIGFuIGFzdDI3MDAtZXZiIG1hY2hpbmUuDQo+ID4gPg0KPiA+DQo+ID4g
V2lsbCBzdXBwb3J0IGJvdGggbG9hZGVyIGFuZCB2Ym9vdHJvbS4NCj4gPiBUaGFua3MgZm9yIHJl
dmlldyBhbmQgc3VnZ2VzdGlvbi4NCj4gPg0KPiA+IEphbWluDQo+ID4gPg0KPiA+ID4gVGhhbmtz
LA0KPiA+ID4NCj4gPiA+IEMuDQo+ID4gPg0KPiA+ID4NCj4gPiA+DQo+ID4gPg0KPiA+ID4gPiAg
ICAgICBhcm1fbG9hZF9rZXJuZWwoQVJNX0NQVShmaXJzdF9jcHUpLCBtYWNoaW5lLA0KPiA+ID4g
JmFzcGVlZF9ib2FyZF9iaW5mbyk7DQo+ID4gPiA+ICAgfQ0KPiA+ID4gPg0KPiA+DQo+IA0KPiBB
bHNvLCB0ZXN0ZWQgYWdhaW5zdCBvdXIgY3VzdG9tIG1hY2hpbmUgKyBjdXN0b20gYm1jIGltYWdl
IGFuZCB0aGUgYm9vdHJvbQ0KPiBpdHNlbGYgd29ya3MuDQo+IEkgdGhpbmsgaXQgbWlnaHQganVz
dCBuZWVkIHRoYXQgZGVmYXVsdCBzZXQuDQo+IA0KPiBUZXN0ZWQtQnk6IE5hYmloIEVzdGVmYW4g
PG5hYmloZXN0ZWZhbkBnb29nbGUuY29tPg0K

