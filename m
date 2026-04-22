Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F691F94CC2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 05:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFPka-0001MA-I0; Wed, 22 Apr 2026 01:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFPkY-0001Lv-Nz; Wed, 22 Apr 2026 01:03:46 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFPkX-0008Tg-AV; Wed, 22 Apr 2026 01:03:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRPSlH233JO3lTwViUTZYe7f/TZNMzOFADilGgTcp5wjA0yLxKe+zXZDpXIApHtkKxeCKng7cJVDQmMN85IhvbZGmy+77y2RRcj/N/yKAf8SJDun4R1/RV7Y1sYgt5NwvYStlDMlAxbIY6QCi5zQ/YGPEN4qe45G8+KEx5XDZrBUEWPOkgifxOpSW6A1cOO6S8BK94fufsDZozxSaeoYFWhfo03DIN0RWFgJZqIRDvkvl8L5GKfkSznL2oTCN17JC0GCa4fPNI0F6XUmNF+WGsaSeYRM3fMpbuUu3MT9oV7jGsl4jPvBV9YkkNDzLlCsBLjyW/ushr14Z26GcSYBsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5+OslL3qIE7IzLsEdIt7kg9SVGKQMwWnB0NIE5SH9M=;
 b=pcafFp4q/u2230HzkqQqZxqYinStrbgrgRuw7lpk/X9FZNdW1LC9TZ84ergBO4iGJOhfdmcM3JZfRlU75ls8H8kvzzE7P/L6WI7dRdv8bkmqBXO0eRW+P1v66prPqD+gI7TDRMBmB+G3NGYPwUGBEvvbRk8ZWsQqNzsygeCVk1wtH4lP6s3QO9Zsavd+d9KumhpmDa1pVnoWyeSa85mA24ppVhyKazEaqLR/UgM+cnKXSEXIUfdB02mGt3SKmDnlWwz5RJSUn+A7LD6K99WfULwmP6lPTW5RpFChgZRqxuiF2q98zlQzqyFs2XRmDMmTuupggQSQruD3KTTDlgxcmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5+OslL3qIE7IzLsEdIt7kg9SVGKQMwWnB0NIE5SH9M=;
 b=SSmTIXd+Sj6mtnBOXiISP5zyqaDPW39In5F5m4bRY6VQMD2GUiZx8Ll3TsID4I/KmDKOYQTlGtwZSA2PUMqmwtlb4e7skuLH+hAYIwVsPAAOK0Njnpsmoau6lbRvUo8XXqK+Tbehjy4OI10vfDgCaIfdkjsfMTUP74e1YUELGZoXR3LexAMT0nei0rIY2IQT1XudgZdwtV9tSfWk6Yq7Z4Hbof0jHQYxWZUQUjyd5U9Qu15FL5YVc6JRnTB0OL+SVTu4QlbrHOQElI/jggMtOq1jMz2klcndxzSLWqJ9h5Tcw4WJHdlq1YdqcaWQhKASxuhLF0TaUaDoMf8/pXUjnw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB6325.apcprd06.prod.outlook.com (2603:1096:400:419::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Wed, 22 Apr
 2026 05:03:37 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.017; Wed, 22 Apr 2026
 05:03:37 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: RE: [PATCH v3 15/17] hw/arm/aspeed_ast27x0: Set EHCI descriptor
 address offset
Thread-Topic: [PATCH v3 15/17] hw/arm/aspeed_ast27x0: Set EHCI descriptor
 address offset
Thread-Index: AQHczUNW47iTpoljY0OGKkDOuhfdPLXiy22AgAfEj2A=
Date: Wed, 22 Apr 2026 05:03:37 +0000
Message-ID: <TYPPR06MB82066823EE395F67DF9EB3D8FC2D2@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
 <20260416014928.1279360-16-jamin_lin@aspeedtech.com>
 <0503f085-784f-40fd-842d-07c6b66373b3@linaro.org>
In-Reply-To: <0503f085-784f-40fd-842d-07c6b66373b3@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB6325:EE_
x-ms-office365-filtering-correlation-id: 76eb89d3-cec7-4c9b-3d84-08dea02c8350
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 37aSzdERoxH9FFllerLO/W4msEqQpil7MY0HL4Cgl0knSb9Sv/eAyc3FOWkjgQAOa2yFVR3EJ5/kpnTpEmma/N0ynhFpVev+/vLBGVUvSf6hSp/FFRcWf4TcGK/OreAKcflNl+7XSNEJdxchMkWmCVSmKaIQSAY71W0egxrvcPk0n8en+VgLdL6n1JH7SBoJKkQefBqhlwObIOdyBiaixK8kpkakNQbOCEL9tWOibohdWtOusqrCWG/yRv/g8EQj3R+vSaK5rr0fqswyC4UI7I8PvR5YbKTQ3xHDMyXqlvQ2M0JpQxYhBG1kjLBlklETg37wDAFyHfCJZ0+mM0yIULSERrwHLWVB00YF2Udd5PdEUSu317hnBkRrkRXU6q3fv4f/olhJixl/PucyaBO+mnBdO+yti8C1zfC57wpniPem3xYUwHeDcYAsp38+GQk7/gftstLKCFY0V1T+940gqRBcFAJsg+Mf4UBQtut5uJ3HLPa2lI7WuvTJQ0IGBkYhf/AL7PExPXc0NWypdE5aeAqbGPidCw7+H4Fzw/zdgWeBlEoh17CtKiPeMMQ9Xkmfz7ei1lk+KaFmP8Ov+myHvg55iK+/kXnyah9Z4dvsJnRhRREmz7mh59Eb0qBvXVIHvtLaFk15mv4joc2XeKNKgwz+T0F6EqRzWUay+Wiw2M7fBmabxtps03g0LwZtKgxoYK91aao3zp1JcQNBdjDcbjGs/W27up/OpeUmK6xyFFT5wGq+rI/c6uPI1v7CTHdzPJImC3FOEVL9dvEZK97OIUy1vq4pMU7frTqAPsaWpNX/tjEYu9ttX7FfxlG3Ry3A
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWgvS3pTQmlLTFgyQkNUUCs5QkhDaXlaK1loS3dORUtjeUlPcjdOVzgxRkNY?=
 =?utf-8?B?L1gzNllCZmg5MVRHSVd5QWFpTklrbGN1YWVpaDlUVEFSVnQ5NkRld25vZ1FQ?=
 =?utf-8?B?S0paQUVocnUzM3NRY3UvOWc0U0ZmV3l6eVNlcnhCWmNRN3ZYNFdQYk5aSGhM?=
 =?utf-8?B?YnlveE1RUlh0ajNkZjNKMDlRK1N2RVZpV015NDY1NEpIZ3p4cVFXdGpaRkN4?=
 =?utf-8?B?bmIxNXQ2N25zVCtFV0NuMkRTM2ttVGcyRVoySFB5eTFUMTZkUzlNSXNuT1hu?=
 =?utf-8?B?YjZyZnh3b21Qcy9PczlxR0lCQlZhdXI3N0YvOG5wbjhOd0wxdVJjS3dMU1p2?=
 =?utf-8?B?SXZ1NWNwV2FjYndsaG5jczJTdVk5aFpRc0FhR2Q2WUlZUXZycmZBODBPdm1l?=
 =?utf-8?B?NHJYK0VrbE9ZRzBSK0RjM1NRL0xveFpUMFQ5U3Jqa04rUnV4b0ZUT3dXQjg0?=
 =?utf-8?B?MGZSQ1pvc1JxbnBkWlhIbU1tV1p5MzF0SFdzcHIxSk10UnhRNTBKR0llZkpZ?=
 =?utf-8?B?ZGVreExMSkxGeWpsZ0JxSE5jcUVxSXg3K1RpbS9QVTBrejYrR1d1ZVdjMGtU?=
 =?utf-8?B?VmhTYWNFN0tRcFNkdHVFbmx6Y2JrcmdmdGtlMytoTVYrZERacmt5VnlZalZ4?=
 =?utf-8?B?WkdpL1FvVkRXSllUeDROR1pxY1JRWmNaMnFHZWpWbmNXZmdKQUR4U2lnZ0ps?=
 =?utf-8?B?MGc0aHFuaENVTVFRTk9iNDhLajVEYjd4V2kzaTZtaU4rR2FMam1BKzB2WER1?=
 =?utf-8?B?Qk1yRS8zMHFSMHE0U2dJb0YxNlMyUHRpdFREM2tYZk5wZmRzVFFXdHl4alhH?=
 =?utf-8?B?d0xvMUs3aFBOeGpBRElzc0JpWEZzdVp4K21oRTQ5a3ZXMTUzN3ZLZ2hWMHhQ?=
 =?utf-8?B?SERrSE5UU3l3UEZYa1krS2M5dzJYVGdhUlB3TmZlSUpEZzdCS0hSekR3a1JI?=
 =?utf-8?B?MU91aDFiTHkrQjZtTy9UY3JER2duNWVwMlBrYkw3b2M1TkZidGJTOERETmVr?=
 =?utf-8?B?SjVZb0xEOHVTYlprKzhiRmVyS25lZC9UbEROSy95WTJ1SXNIRGtQME1Td2Yv?=
 =?utf-8?B?bFRUeDgwaEJLNjU0dmJ1a3llOWFPU3ViV2s2TEpyVUFVaE9MTS91OTUrL3pm?=
 =?utf-8?B?a1J1SVptTGN3WGRGdjFYQzFvOVFCOUJSVmZEVnZ1U2pPSjN1QUFvMUNTQTUv?=
 =?utf-8?B?NjhDQXBsY0kxMFdtRU0yNVVrRGNQL3JDdHlxSnpGN3k5bmVWay9aNDltalNk?=
 =?utf-8?B?SGNrSWVXQlpDaVQwaElHVGo1RUZjSzVSeDNnOFJXbi90S3ZtcGhBZlBmV1lp?=
 =?utf-8?B?N2pNRzJiR0xoOEZIUlZxbEpvZG5QdGNMOTZjQmNXSS8yUlhFaEduZitSb3FY?=
 =?utf-8?B?M2lHS0kzS2t0RCtXTDZtQWxhSGNNamsrcEdSS2YvU01QM2NQcElSYi9Uemtn?=
 =?utf-8?B?ZHBNdVVxQVJ1bEplK0grUWZQMG93bWtVemZHdU1iMVd6ZGxqMFhtTGt4dExa?=
 =?utf-8?B?SklkbjdhUjFZZ3drY2srY3U5L3lJMXA0MlhPb2VmTVI1T0dSMDk1RlphMGQ0?=
 =?utf-8?B?R0FITlptdkpjcCtVYjNLeEdoZ0xlL09QUnJFeFVKTTdoRVVaSVMrNzBONnNk?=
 =?utf-8?B?UmoreG53NGxoekNGdm5DZDNkdTVQcWduK0dTMDZ4S3loalR1ekMxYWVnaER3?=
 =?utf-8?B?cWxnbldNL29XWldjSmlsNEFqNXQ3V3QvYVc0NnVTNnlYOGc3OWV6RFIyb0Y0?=
 =?utf-8?B?MGJzbVNXQTl3MWhERHFyY0htZ0FJUk9pbXdaNnVxKzNyMDloUWlnMGZqK2lz?=
 =?utf-8?B?Nm5pUDIwNjFscnhxU2Q4S0IrdEZiVUNDd0FHejZXQ2Y0Szg0RkxvdzZpNmRu?=
 =?utf-8?B?eTQ5cHlLdXIvdmZXZWo1MGdpOVJSRk51SUtwN1dBNDdXVSswUTFVeUhZVXFR?=
 =?utf-8?B?YVl3WCt5bEVXOXRzZnpzczVRSWU3Rks2VlpUQlFoblFocHF0dS9ZWjdwS3Bn?=
 =?utf-8?B?ZWhReDNsOWJVUGRkU25lZmdGTUlLeFNLdG8xWDMvcGJkelJWUUtnLzNkV1RL?=
 =?utf-8?B?RXNYMlJCZEw3TnJkenZqdng5eVBiZTNLN2ZPQnhXSGxpaEw2aFFJSDYxTTlo?=
 =?utf-8?B?RHpuWVY2cHlNQnhNbGV4eGhCSVA5UzA3a2ZpZnJqSEVNMHdMTVRPaFJsYnh1?=
 =?utf-8?B?OXpSVmRNQUFSdGMzSVFlSzJ3S1BXTVk4N0t6UngvdEIxQ3F1RDg3aE0zWmpC?=
 =?utf-8?B?Mmp5REYwNlc0MlpWRDU3cEZrNGZsUWt0b0l2eXM4RmtLQ0JuMHVwT25lK05T?=
 =?utf-8?B?enZBc2wrOTQ3RXJZRWdWM0hkK0hpSm9qNDIwYkZBcDhFeWZ4K215UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: U2xChJTSVzl4Iuf3fKPjFQkYIfVCc1XroRAHcu3CJt7bRcFzZuu7SIUiSQteMG6vaVQeC8eY+yvtwkfx2XsRq4zcj12+T28nyJLKz0nm0Mb8y/6aMPXg88b/MAHxO8mjvevzMGv6ecH9TOpd0TYKxsVxk59rGDm+f0Yrx3lW4NiusBCRJsNkAzjzTFED3dT/eZ2b8LiTLjzU5cxNpemoI+Z+ba5WV3uw0LSj/6c1RXQRgKnx4EeMVnG8z8gvpZwbGKVGDHBlvP8dP/avb8TVG9i0/uPnct9zU4ZofVw1Kn2kIlkCi+MfQYvy5Ew6l2wLESglvlsDeCFYBmi8zY4f7A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76eb89d3-cec7-4c9b-3d84-08dea02c8350
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 05:03:37.5054 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zaPV9MAiiI1PIJZ2KxC04mlN0ZGDxJKBTRDkBQcaq62GcepZdY/s3+v2z6SlvD/gJlbHv8c6pp3WJAIpbqwLrPEixNJVBfPDa/cDqVJ5rzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6325
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgUGhpbGlwcGUNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDE1LzE3XSBody9hcm0vYXNw
ZWVkX2FzdDI3eDA6IFNldCBFSENJIGRlc2NyaXB0b3INCj4gYWRkcmVzcyBvZmZzZXQNCj4gDQo+
IE9uIDE2LzQvMjYgMDM6NTAsIEphbWluIExpbiB3cm90ZToNCj4gPiBPbiBBU1QyNzAwIHBsYXRm
b3Jtcywgc3lzdGVtIERSQU0gaXMgbWFwcGVkIGFib3ZlIDRHQiB3aXRoIHRoZSBiYXNlDQo+ID4g
YWRkcmVzcyBhdCAweDQwMDAwMDAwMC4NCj4gPg0KPiA+IFRoZSBMaW51eCBFSENJIGRyaXZlciBw
cm9ncmFtcyB0aGUgc2VnbWVudCByZWdpc3RlciB0byB6ZXJvIHdoZW4NCj4gPiA2NC1iaXQgYWRk
cmVzc2luZyBpcyBzdXBwb3J0ZWQuIEFzIGEgcmVzdWx0LCBkZXNjcmlwdG9yIGFkZHJlc3Nlcw0K
PiA+IGRlcml2ZWQgZnJvbSB0aGUgRUhDSSByZWdpc3RlcnMgZG8gbm90IGluY2x1ZGUgdGhlIERS
QU0gYmFzZSBhZGRyZXNzLg0KPiA+DQo+ID4gRGVzY3JpcHRvciBtZW1vcnkgaXMgYWxsb2NhdGVk
IHRocm91Z2ggdGhlIERNQSBBUEkgd2l0aCBhIDY0LWJpdCBETUENCj4gPiBtYXNrLCB3aGljaCBh
bGxvd3MgZGVzY3JpcHRvcnMgdG8gYmUgcGxhY2VkIGluIERSQU0gYWJvdmUgNEdCLg0KPiA+IFdo
ZW4gcnVubmluZyBvbiBBU1QyNzAwLCB0aGlzIG1lYW5zIEVIQ0kgcXVldWUgaGVhZHMgKFFIKSBh
bmQgcXVldWUNCj4gPiBlbGVtZW50IHRyYW5zZmVyIGRlc2NyaXB0b3JzIChxVEQpIHJlc2lkZSBh
dCBhZGRyZXNzZXMgc3RhcnRpbmcgZnJvbQ0KPiA+IDB4NDAwMDAwMDAwLg0KPiA+DQo+ID4gU2V0
IHRoZSBkZXNjcmlwdG9yLWFkZHItb2Zmc2V0IHByb3BlcnR5IHRvIHRoZSBEUkFNIGJhc2Ugc28g
dGhlDQo+ID4gZW11bGF0ZWQgRUhDSSBjb250cm9sbGVyIGNhbiBjb25zdHJ1Y3QgdGhlIGNvcnJl
Y3QgZGVzY3JpcHRvcg0KPiA+IGFkZHJlc3NlcyB3aGVuIGFjY2Vzc2luZyBzeXN0ZW0gbWVtb3J5
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVj
aC5jb20+DQo+ID4gLS0tDQo+ID4gICBody9hcm0vYXNwZWVkX2FzdDI3eDAuYyB8IDMgKysrDQo+
ID4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMgYi9ody9hcm0vYXNwZWVkX2FzdDI3eDAuYyBpbmRl
eA0KPiA+IDRhMWY3Y2FkNzMuLjNjZGJmNzhhYzEgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL2Fz
cGVlZF9hc3QyN3gwLmMNCj4gPiArKysgYi9ody9hcm0vYXNwZWVkX2FzdDI3eDAuYw0KPiA+IEBA
IC04NTgsNiArODU4LDkgQEAgc3RhdGljIHZvaWQgYXNwZWVkX3NvY19hc3QyNzAwX3JlYWxpemUo
RGV2aWNlU3RhdGUNCj4gKmRldiwgRXJyb3IgKiplcnJwKQ0KPiA+ICAgICAgIGZvciAoaSA9IDA7
IGkgPCBzYy0+ZWhjaXNfbnVtOyBpKyspIHsNCj4gPiAgICAgICAgICAgb2JqZWN0X3Byb3BlcnR5
X3NldF9ib29sKE9CSkVDVCgmcy0+ZWhjaVtpXSksDQo+ICJjYXBzLTY0Yml0LWFkZHIiLCB0cnVl
LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmVycm9yX2Fib3J0KTsN
Cj4gPiArICAgICAgICBvYmplY3RfcHJvcGVydHlfc2V0X2ludChPQkpFQ1QoJnMtPmVoY2lbaV0p
LA0KPiAiZGVzY3JpcHRvci1hZGRyLW9mZnNldCIsDQo+ID4gKw0KPiBzYy0+bWVtbWFwW0FTUEVF
RF9ERVZfU0RSQU1dLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZlcnJv
cl9hYm9ydCk7DQo+IA0KPiBTcXVhc2ggd2l0aCBwcmV2aW91cz8gT3IgaW52ZXJ0IDE0IDwtPiAx
NSBvcmRlcj8NClRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24gYW5kIHJldmlldy4NCldpbGwgaW52
ZXJ0IHBhdGNoIG9yZGVyLg0KSmFtaW4NCg==

