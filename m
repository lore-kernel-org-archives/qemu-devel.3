Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80546C369BD
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 02:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5F3r-0007S9-C4; Wed, 16 Apr 2025 22:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u5F3p-0007Rm-KY; Wed, 16 Apr 2025 22:33:05 -0400
Received: from mail-sg2apc01on20721.outbound.protection.outlook.com
 ([2a01:111:f403:200f::721]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1u5F3n-0003ec-Kq; Wed, 16 Apr 2025 22:33:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rhk1PMdGZYy0gYjhMs3Y/BPMRyJ93rJ2ldyItU1uvRaPPP/wTuZkuTc9xLrUvUWU+hoGbvFLgD7Ow48+3uRm56jWmw2sgfRXqj7giJ8gKtBvuTCXOPATd45jtWZgOr/wEvi5kjDuTvkAxMVzff/OopoH/QlClSUEE+pqvDBs3eQHvdOQoaha6oDW5XzkHerJ2hPS02JtRXKklCfhFr678HYiicIBGX4/oaaPeNpLB4lZLtG/CixzGydX0VCXYVdtQifVq+a4yPnrkadT2P90BABU7QeXfp4kPWtPzfSpY1vVzI5Ib2XQ05uDTFLrMNLL6nuiE48n5BKHbFtyNJNbhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWSYpUkDQajcOukgsKUxB8jtEhVwmDYfHDC6WgXzcA8=;
 b=QC7adhcJ411f6gzLnWBb5DeQWqbDbQD8fXdWInRBDGCEgfsXvPCHOP8pFy3sBAX0aikuAzEvTeqCb/VYUGygnBYpCekqXm5FClWzRUdOy70xyIlQAQniShrxmeEJV51IDuHrdlt67G4vgd9UM4APoo6OEQfUse8vBoddA9yL4KChV8q/Z5e1QO7ySbR8AT9PBbm8E2rFZCCt7uFtC1Z/UL4GC90EA4EoYFfQPXez1m2gFRDO+xoJsl+m86M5YgeZufRD3oRNrXMHMgiPMuJpx0nX5JOEF06kufW5eLPoLwJ/isnR4SX0Ib8/A8O7aAQdDMO10YafVVazNjljaMPwQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWSYpUkDQajcOukgsKUxB8jtEhVwmDYfHDC6WgXzcA8=;
 b=XCDSprOurnMW2XQvuuY4D5U3Dx1api3sK1pYuSHS+HxU98Bd6iURU3kco4+vm9PXaZTV1qctl63B0Vqq/whC5fBMEccCVuhtOKnUyg7pW/Cg6nNxVlqqI1zn2QkZ8sK8idSh4Q5mP2FV3U18DLjiDpZeqNcmtIf0GMjjEE99vv2+Us6pDV0dtiGbTS4Lri0rkriWXPW0gG2A6xX26qxLSACFT8kadxKOM4rtWLKP8o9H2jvF9xoiWPq5vz0El++4sL0TAHFsp6g79tVEAX8Oqc6zKOgryyks2b/2sglf3i8M/eSFysAbHtsUjCPWATwEC2q620Xpd/ZMGS3fthJ48w==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 KL1PR06MB6669.apcprd06.prod.outlook.com (2603:1096:820:fc::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.22; Thu, 17 Apr 2025 02:32:54 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8632.025; Thu, 17 Apr 2025
 02:32:54 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Nabih Estefan <nabihestefan@google.com>
CC: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, Troy
 Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v3 05/10] hw/arm/aspeed: Add support for loading vbootrom
 image via "-bios"
Thread-Topic: [PATCH v3 05/10] hw/arm/aspeed: Add support for loading vbootrom
 image via "-bios"
Thread-Index: AQHbroG9BJUpBJYybEOM22ETV6e9tLOmvgCAgABmyEA=
Date: Thu, 17 Apr 2025 02:32:54 +0000
Message-ID: <SI2PR06MB50413651FEA62C51FE8F77DDFCBC2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250416034327.315714-1-jamin_lin@aspeedtech.com>
 <20250416034327.315714-6-jamin_lin@aspeedtech.com>
 <CA+QoejVSakV1zfpUwP_ybF5AzcO9k9LYy=ApiR-joi94oRUH4w@mail.gmail.com>
In-Reply-To: <CA+QoejVSakV1zfpUwP_ybF5AzcO9k9LYy=ApiR-joi94oRUH4w@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|KL1PR06MB6669:EE_
x-ms-office365-filtering-correlation-id: cf400c74-fcb6-4fe2-b52d-08dd7d582858
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RTZlaTBiZ1dGRzV5TlEzZm9DQkJRMXJpRlVrRHdndDE1azc0TEd5UjN0a0Mw?=
 =?utf-8?B?cHhWMDMrNUlkU05tNHhwdEJ5b1Y0YkI2M2hUTGx0SHJvejVyK0d3ZmkzL1dX?=
 =?utf-8?B?MHVyOFRKbERBcVFnK0ptRUIvV0s0YVJXSTdXMlRwSHBkN3JaTUtlNzdYVHVY?=
 =?utf-8?B?SGYzTzE4SFpnVTV2WW0wUGJSTDEvUC93TVVUMzQyd2x5ZkFiV1VYempJNHA4?=
 =?utf-8?B?Nkp4N05ZOVNoRDdxdENnbVR5dDJtOHExcXZrekRoVXMyenMySml5V2lkSWNM?=
 =?utf-8?B?elpBc1pTNytOZXpnSWg4aDVXN2swSWs3MlhEQUFIR3JGa2theXRkV1pVQjlj?=
 =?utf-8?B?VXFabXhOR1RaSEVyNFI4R0FseUVFa2pldWN6end1aW9ueTNHbXJKQmNjbFlV?=
 =?utf-8?B?eVN5WGYxbDVFWlE0c0xwN3NYRlpBUWhDb00zUEFGd3dBc1Frb3JsTHdHeERF?=
 =?utf-8?B?c3NOTjVQSG53TW9XNU9OSGFjR2NsTWh4UEl1RWVvQTRGdTA3R1Z5WWJ2bm41?=
 =?utf-8?B?aks4WmpQZTlHR3cxNk9yTUpZMG9GMWhBQmxPNjUwOWZGVHhXZnV5aFp3U2hp?=
 =?utf-8?B?d2JaVis4cGR3ci9CYmE5Z0ptdjI1Tmk2UWxvYloxWlVRc0hmNnVzTnRUTzdt?=
 =?utf-8?B?TGczY2pIL25ZcEFYYWJVNGI0ZEhLdm9OWmNnZHgxbS9TWDM4MlkvQldRRTNR?=
 =?utf-8?B?eEJna25kM29QZHFtdG5sVWFwZjZjajc0VEZLb3ZXdEpvaHdkYzBIQ2QxZXpQ?=
 =?utf-8?B?aHdLa3NyVjAwUC9rUDdjOFlhUFllRGZYdFdldExpNGpaY2Rsb2tnS3JVVnlN?=
 =?utf-8?B?NzRHSVZJWTBONWgxWGVvbjVaRER0YnRJdlVYQkRZemdGYUViKzlHVXpiRmV6?=
 =?utf-8?B?OExTbmcxSk5uYXVsTmRvSUlFVWlhZlg2NlRkQmJWTlVOWXFmSk1qRFhXcytm?=
 =?utf-8?B?aElZbUdheC9OcWZsMEVPZC9ZSk1QcXgzNStqaU02a1dqWENmbm9ac2lXVmFu?=
 =?utf-8?B?YkJlRklXZkRQUi9YaGd3ajhqcllMUisrRlZQUXl0TC9mbHFhL0oralduVnRr?=
 =?utf-8?B?b2podWYweDcvWXR3aFZOUlBMTkNQOHdlZGludjl3S1dXSk1sSXZ2Q3FUVjFY?=
 =?utf-8?B?V01VS2Jzci8zT3FvVS9zR2RxWjdaTW0zaFVaWnduVDJPTTdQOEVaeXVmcHhC?=
 =?utf-8?B?dEVyYS96YWhUWkR0SzI4VUh5S1d1MUpDK3ZHRHJlbEFTVzVLbkxOQ0xzN01H?=
 =?utf-8?B?NCthYnJsYzYzM2JtdytlQUdZdnB2YkFaTXJORkI0clQ4OEFBVGZQblkwOURm?=
 =?utf-8?B?TFNaTDQxNkRrRVNJdTl1cXFpZzVPTjEvVmxoVmIxamNVZkJtSUlpYnQ2Z051?=
 =?utf-8?B?SXptSjdpT2w0RnljS2ZTenJQWHhRNy9KeG1Pb3ZBR3FySk5yT0liVzBnYmt1?=
 =?utf-8?B?VW1KdDArTzZZTXVKLzMwbks4SVZDeGxQei9nUkVCMTE2eEU2VUFjRnFZTHFa?=
 =?utf-8?B?ejV6bVhkeG9FbFk5ZCtQOEZEQTdBY0FmczN0N3piVGFMODdZaytkTHBxWVVZ?=
 =?utf-8?B?eG1zUjRZQmo3L1hXZHY3aFFVbGhzWHNUK3IwaTZoUDVLNDd6Z3FCL01ta3V2?=
 =?utf-8?B?a0VSOU5vb1d4Z2haLzhJT1l3Y2pkcG5hYVdzcEdxcUt3U0tHTHJ2R3dtbUE3?=
 =?utf-8?B?bFlqWjB3UUxua0FkR3RtYm5ONGxiYlhUNG0ycGZrQUsxVHlET0FWQXBTM2pJ?=
 =?utf-8?B?K0JkNnpwOUlma3M4K2hxMWorUkNLNEJWeEh5L0dUV2hhZzBtRzJNKzV6VUdi?=
 =?utf-8?B?OTdVd05XTTdhZEQzcTdKRDF2bGY0aEFkeWxTT0hEYXFXYVc4VFFwOWNJMlNj?=
 =?utf-8?B?UFJDOVVMVkVXUXI1dGFLcjNDRER4eWZRNzRoVU9JT0FaaHNmSTVsaVdKMm9i?=
 =?utf-8?B?UzBLMzIzRzlBanBua01aRHdQVXNCcFRQMVBVVUVPSTZRTkVkWXN1VEdIZ1RB?=
 =?utf-8?B?QzVBZjNKQXNBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlZwVU93UUZEUzlpR1YwK2hWNjJQbEJYS2xxNTBwdkY1WWEya0VsZTBySVFy?=
 =?utf-8?B?c2t0K01nZUlaam9DbzBJMncxTVNMVk50aHVXaU5NSjFxUzN0Qmc2UHhqL2Ux?=
 =?utf-8?B?RGtnallPZWhBZ29EeUxKMmVObEU1VUpCdFEzUGZydmpjUyt2Qk0yeEF4UThH?=
 =?utf-8?B?eUtkR2Q2YzFvMUhnRnFWQmxhYnMrTDZkeSs0MXdxM1ZzTExvRDM3Wm1FN05k?=
 =?utf-8?B?UFB0MjNrN1JvZnIrQk9MSGtzb1h0YVJJRDBpbnE5clByZnh6UThZQjJ5YkND?=
 =?utf-8?B?YytqWWVkR3dlRG1tM0Y3RHRQZjJrQjl2d2xQRTZqd2p3Zzg0RitGVXZDakF1?=
 =?utf-8?B?ejc4aThkZkNsSUJ2ODRhejB1WmFZcldLWi9FL3VYN2Y3eHBYUjl2Mks4c3kx?=
 =?utf-8?B?cEhiejdtcjVtZFZ5aitBL3FiMzVsTFQ4YWhpT2lPWmY1am41RVdjRENRZ1dq?=
 =?utf-8?B?UHh0R0ZISk5XZjN4K2lIMEorZkkydWNXejdKZ2hQRTA1YVpTUEpnRE1uUkw3?=
 =?utf-8?B?enpydWxGUE5MZTJZbnRxM3VvRGo4QUQ1RmZZTEZtVVBDYW5IZW9YTTcwL3Ra?=
 =?utf-8?B?RVBIUFFYcmN5d0dYMyt3NnZocFZoZmVTTktpK2UxMmVtamhiVExqKzkvaTk3?=
 =?utf-8?B?eCtiUSszQnZHbUYzUDVQRG1GalFjSXRUNzBCbjVoT21QWHF3OUIvQ2Rvenkx?=
 =?utf-8?B?WWlSS2IvWUR4b0ZRbjViQnM5WndBUnpkRVhvQjhTWm1kUnFpN0dvNlRlNDdI?=
 =?utf-8?B?V1dORjJGYTVobWMwMlgyK0dYeTlra1k5dXFGZldVRzNUak1sR3JpTHFEWWJM?=
 =?utf-8?B?WHd4QlhnTWlUb0NLYUpmY3d6VGliMGZEUW9uN3VrWHZoUmlWV3lpUkRQdWt0?=
 =?utf-8?B?SXpiTDFQOW5DbTF1K1QzaDRnNG42WTUxdE1JV3VjUG1HZ3pnVEYrQWltNUVz?=
 =?utf-8?B?amF4eVV4VStDQXZZaFA4LzRIaEpFK2VKL3lselB2YlR0azhnK1NaQU1mY3Zq?=
 =?utf-8?B?eDJJMllxSHBnYjFLRktjQ3RZdit2QytuK2lIWWpILzBoSTJOMW5lZDFHby9x?=
 =?utf-8?B?dEI2N1E0ekt1eEhzS3V6UnVRUHJoL3hCRzd3TVY2eWUrZWg5Kzc1MVhaQml2?=
 =?utf-8?B?dTgxekV0RGkvTElqYmpWZHgzUG96aG54T3hHNk8xZ0dlbm9jZmNoRGNjMTZI?=
 =?utf-8?B?SGorQXBLdzYveGZSUE9VTE5MTVF3ZnRYVjh3TklwY1NYb0dUdFFGS0dhTWNl?=
 =?utf-8?B?cnNrQXRieUdNOVNCdE1Xd0Q0c0dweFJuNDdZVE0xM3lRYUwxeDhUVnlIc3p1?=
 =?utf-8?B?cVQ2QklNNHlIK1JEMTd0cU92SDdCVGtEMDFRRFBTendtcmdQTkczZjhoVkwv?=
 =?utf-8?B?VnJUVVViRVFXZDJQUmxmaHVCMDhYYTh3R1ord2wrY2pCZS9oWWlLWkxTUVNJ?=
 =?utf-8?B?SmltMTN0UWxJbFRVRzZXai83dGlpYVFJZW5KdmZoNEIyZ293OGhFYkRtaTZZ?=
 =?utf-8?B?S01GNzVtdmUyMXREaS9XeTNBRlA0NFd0SlAvYVZuZDluK0w4cHVaQlpwQUc0?=
 =?utf-8?B?Uk96OFNiL3lrcEJ0NUlEd3VseEZmdVBKOTdjUTRLTk9WZWVueVpLcjBBbUgw?=
 =?utf-8?B?MWxBdnBDV1M3Y1NVd08ra3VIQ2FTQkl2VHVROHVLejNtUzRBM0s5cTZocEpq?=
 =?utf-8?B?VCtyUVc1NmNGZHRtL3d3UElaMFByOVlYdEtCeitGdXRpMFRuZklCckZCdVd3?=
 =?utf-8?B?OW1CcW4wTldaOGtoMTQ3SjJPUGZjbER6NmxNRG54aGRWU2xUU2xGV3dsMjJs?=
 =?utf-8?B?bDNIY2FocHRNTXovYVpXRWFjdzRhN2ZOdDNFcmtJamFHTGtFM3N0T1pQRWox?=
 =?utf-8?B?eDgxTlBic0dqLzUyQS9ORUR4VlM1anF1NXdqTGErR1hWaHc0TDRpNm13VVZN?=
 =?utf-8?B?eXdQZk56RUhpZUR1dkNGaCtVSzFrZGdkbU5yUWtRVmxsZXdyZXd1VXcrdGNY?=
 =?utf-8?B?ZzFSL3RIY1RBZjhKN2hPL3NBUXZvOE9jbTBaUXcrZG9BUWNPaFRrcUx1U25U?=
 =?utf-8?B?NCt0cVB3blhSb1FqY0kwQkxBVEZETjRiamljemlSREpRaXIxUTZCODAxQ0dw?=
 =?utf-8?Q?D0xJRpgpqYO3hSJmq+LXXOCv5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf400c74-fcb6-4fe2-b52d-08dd7d582858
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 02:32:54.3824 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SGIU8D1JslYtOdMQjgUNwR/pIopWy2XAxTb2bramAI5Tsj49wpAA71FXpctIUp+lYu7wbD4XD5UYJ27NPm8kbvzIr3WLMtePFUb1mrJ5x7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6669
Received-SPF: pass client-ip=2a01:111:f403:200f::721;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
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

SGkgTmFiaWgsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAwNS8xMF0gaHcvYXJtL2FzcGVl
ZDogQWRkIHN1cHBvcnQgZm9yIGxvYWRpbmcNCj4gdmJvb3Ryb20gaW1hZ2UgdmlhICItYmlvcyIN
Cj4gDQo+IFRoaXMgaGFzIHRvIGhhcHBlbiBhZnRlciB3ZSBoYXZlIHRoZSBib290cm9tIGluIFFF
TVUgb3IgaXQgd2lsbCBmYWlsIG9uIHRoZQ0KPiBkZWZhdWx0IGNhc2VzLiBCZXNpZGVzIHRoYXQg
aXQgbG9va3MgZ29vZC4NCj4NClRoYW5rcyBmb3IgcmV2aWV3IGFuZCBzdWdnZXN0aW9uLg0KV2ls
bCB1cGRhdGUgdGhlIHBhdGNoIG9yZGVyLg0KSmFtaW4NCiANCj4gT24gVHVlLCBBcHIgMTUsIDIw
MjUgYXQgODo0M+KAr1BNIEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiB3
cm90ZToNCj4gPg0KPiA+IEludHJvZHVjZSAiYXNwZWVkX2xvYWRfdmJvb3Ryb20oKSIgdG8gc3Vw
cG9ydCBsb2FkaW5nIGEgdmlydHVhbCBib290DQo+ID4gUk9NIGltYWdlIGludG8gdGhlIHZib290
cm9tIG1lbW9yeSByZWdpb24sIHVzaW5nIHRoZSAiLWJpb3MiDQo+IGNvbW1hbmQtbGluZSBvcHRp
b24uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0
ZWNoLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IE5hYmloIEVzdGVmYW4gPG5hYmloZXN0ZWZhbkBnb29n
bGUuY29tPg0KPiBUZXN0ZWQtYnk6IE5hYmloIEVzdGVmYW4gPG5hYmloZXN0ZWZhbkBnb29nbGUu
Y29tPg0KPiANCj4gPiAtLS0NCj4gPiAgaW5jbHVkZS9ody9hcm0vYXNwZWVkLmggfCAgMSArDQo+
ID4gIGh3L2FybS9hc3BlZWQuYyAgICAgICAgIHwgMzYNCj4gKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMzcgaW5zZXJ0aW9ucygrKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvYXJtL2FzcGVlZC5oIGIvaW5jbHVkZS9o
dy9hcm0vYXNwZWVkLmggaW5kZXgNCj4gPiA5NzMyNzdiZWE2Li4yYjgzMzJhN2Q3IDEwMDY0NA0K
PiA+IC0tLSBhL2luY2x1ZGUvaHcvYXJtL2FzcGVlZC5oDQo+ID4gKysrIGIvaW5jbHVkZS9ody9h
cm0vYXNwZWVkLmgNCj4gPiBAQCAtNDEsNiArNDEsNyBAQCBzdHJ1Y3QgQXNwZWVkTWFjaGluZUNs
YXNzIHsNCj4gPiAgICAgIHVpbnQzMl90IHVhcnRfZGVmYXVsdDsNCj4gPiAgICAgIGJvb2wgc2Ro
Y2lfd3BfaW52ZXJ0ZWQ7DQo+ID4gICAgICBib29sIHZib290cm9tOw0KPiA+ICsgICAgY29uc3Qg
Y2hhciAqdmJvb3Ryb21fbmFtZTsNCj4gPiAgfTsNCj4gPg0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2h3L2FybS9hc3BlZWQuYyBiL2h3L2FybS9hc3BlZWQuYyBpbmRleA0KPiA+IGI3MGExMjBlNjIu
LjdmMTEzNzFmMDIgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL2FzcGVlZC5jDQo+ID4gKysrIGIv
aHcvYXJtL2FzcGVlZC5jDQo+ID4gQEAgLTI3LDYgKzI3LDcgQEANCj4gPiAgI2luY2x1ZGUgInN5
c3RlbS9yZXNldC5oIg0KPiA+ICAjaW5jbHVkZSAiaHcvbG9hZGVyLmgiDQo+ID4gICNpbmNsdWRl
ICJxZW11L2Vycm9yLXJlcG9ydC5oIg0KPiA+ICsjaW5jbHVkZSAicWVtdS9kYXRhZGlyLmgiDQo+
ID4gICNpbmNsdWRlICJxZW11L3VuaXRzLmgiDQo+ID4gICNpbmNsdWRlICJody9xZGV2LWNsb2Nr
LmgiDQo+ID4gICNpbmNsdWRlICJzeXN0ZW0vc3lzdGVtLmgiDQo+ID4gQEAgLTMwNSw2ICszMDYs
MzQgQEAgc3RhdGljIHZvaWQNCj4gYXNwZWVkX2luc3RhbGxfYm9vdF9yb20oQXNwZWVkTWFjaGlu
ZVN0YXRlICpibWMsIEJsb2NrQmFja2VuZCAqYmxrLA0KPiA+ICAgICAgICAgICAgICAgICAgICAg
cm9tX3NpemUsICZlcnJvcl9hYm9ydCk7ICB9DQo+ID4NCj4gPiArLyoNCj4gPiArICogVGhpcyBm
dW5jdGlvbiBsb2NhdGVzIHRoZSB2Ym9vdHJvbSBpbWFnZSBmaWxlIHNwZWNpZmllZCB2aWEgdGhl
DQo+ID4gK2NvbW1hbmQgbGluZQ0KPiA+ICsgKiB1c2luZyB0aGUgLWJpb3Mgb3B0aW9uLiBJdCBs
b2FkcyB0aGUgc3BlY2lmaWVkIGltYWdlIGludG8gdGhlDQo+ID4gK3Zib290cm9tDQo+ID4gKyAq
IG1lbW9yeSByZWdpb24gYW5kIGhhbmRsZXMgZXJyb3JzIGlmIHRoZSBmaWxlIGNhbm5vdCBiZSBm
b3VuZCBvciBsb2FkZWQuDQo+ID4gKyAqLw0KPiA+ICtzdGF0aWMgdm9pZCBhc3BlZWRfbG9hZF92
Ym9vdHJvbShNYWNoaW5lU3RhdGUgKm1hY2hpbmUsIHVpbnQ2NF90DQo+IHJvbV9zaXplLA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApIHsNCj4gPiAr
ICAgIEFzcGVlZE1hY2hpbmVTdGF0ZSAqYm1jID0gQVNQRUVEX01BQ0hJTkUobWFjaGluZSk7DQo+
ID4gKyAgICBBc3BlZWRNYWNoaW5lQ2xhc3MgKmFtYyA9DQo+IEFTUEVFRF9NQUNISU5FX0dFVF9D
TEFTUyhtYWNoaW5lKTsNCj4gPiArICAgIGNvbnN0IGNoYXIgKmJpb3NfbmFtZSA9IG1hY2hpbmUt
PmZpcm13YXJlID86DQo+IGFtYy0+dmJvb3Ryb21fbmFtZTsNCj4gPiArICAgIGdfYXV0b2ZyZWUg
Y2hhciAqZmlsZW5hbWUgPSBOVUxMOw0KPiA+ICsgICAgQXNwZWVkU29DU3RhdGUgKnNvYyA9IGJt
Yy0+c29jOw0KPiA+ICsgICAgaW50IHJldDsNCj4gPiArDQo+ID4gKyAgICBmaWxlbmFtZSA9IHFl
bXVfZmluZF9maWxlKFFFTVVfRklMRV9UWVBFX0JJT1MsIGJpb3NfbmFtZSk7DQo+ID4gKyAgICBp
ZiAoIWZpbGVuYW1lKSB7DQo+ID4gKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiQ291bGQgbm90
IGZpbmQgdmJvb3Ryb20gaW1hZ2UgJyVzJyIsDQo+IGJpb3NfbmFtZSk7DQo+ID4gKyAgICAgICAg
cmV0dXJuOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIHJldCA9IGxvYWRfaW1hZ2VfbXIo
ZmlsZW5hbWUsICZzb2MtPnZib290cm9tKTsNCj4gPiArICAgIGlmIChyZXQgPCAwKSB7DQo+ID4g
KyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiRmFpbGVkIHRvIGxvYWQgdmJvb3Ryb20gaW1hZ2Ug
JyVzJyIsDQo+IGJpb3NfbmFtZSk7DQo+ID4gKyAgICAgICAgcmV0dXJuOw0KPiA+ICsgICAgfQ0K
PiA+ICt9DQo+ID4gKw0KPiA+ICB2b2lkIGFzcGVlZF9ib2FyZF9pbml0X2ZsYXNoZXMoQXNwZWVk
U01DU3RhdGUgKnMsIGNvbnN0IGNoYXIgKmZsYXNodHlwZSwNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgY291bnQsIGludA0KPiB1bml0MCkN
Cj4gPiB7IEBAIC00ODMsNiArNTEyLDExIEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9tYWNoaW5lX2lu
aXQoTWFjaGluZVN0YXRlDQo+ID4gKm1hY2hpbmUpDQo+ID4gICAgICAgICAgfQ0KPiA+ICAgICAg
fQ0KPiA+DQo+ID4gKyAgICBpZiAoYW1jLT52Ym9vdHJvbSkgew0KPiA+ICsgICAgICAgIHJvbV9z
aXplID0gbWVtb3J5X3JlZ2lvbl9zaXplKCZibWMtPnNvYy0+dmJvb3Ryb20pOw0KPiA+ICsgICAg
ICAgIGFzcGVlZF9sb2FkX3Zib290cm9tKG1hY2hpbmUsIHJvbV9zaXplLCAmZXJyb3JfYWJvcnQp
Ow0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiAgICAgIGFybV9sb2FkX2tlcm5lbChBUk1fQ1BVKGZp
cnN0X2NwdSksIG1hY2hpbmUsDQo+ID4gJmFzcGVlZF9ib2FyZF9iaW5mbyk7ICB9DQo+ID4NCj4g
PiBAQCAtMTY5MSw2ICsxNzI1LDcgQEAgc3RhdGljIHZvaWQNCj4gYXNwZWVkX21hY2hpbmVfYXN0
MjcwMGEwX2V2Yl9jbGFzc19pbml0KE9iamVjdENsYXNzICpvYywgdm9pZCAqZGF0YSkNCj4gPiAg
ICAgIGFtYy0+dWFydF9kZWZhdWx0ID0gQVNQRUVEX0RFVl9VQVJUMTI7DQo+ID4gICAgICBhbWMt
PmkyY19pbml0ICA9IGFzdDI3MDBfZXZiX2kyY19pbml0Ow0KPiA+ICAgICAgYW1jLT52Ym9vdHJv
bSA9IHRydWU7DQo+ID4gKyAgICBhbWMtPnZib290cm9tX25hbWUgPSAiYXN0Mjd4MF9ib290cm9t
LmJpbiI7DQo+ID4gICAgICBtYy0+YXV0b19jcmVhdGVfc2RjYXJkID0gdHJ1ZTsNCj4gPiAgICAg
IG1jLT5kZWZhdWx0X3JhbV9zaXplID0gMSAqIEdpQjsNCj4gPiAgICAgIGFzcGVlZF9tYWNoaW5l
X2NsYXNzX2luaXRfY3B1c19kZWZhdWx0cyhtYyk7DQo+ID4gQEAgLTE3MTIsNiArMTc0Nyw3IEBA
IHN0YXRpYyB2b2lkDQo+IGFzcGVlZF9tYWNoaW5lX2FzdDI3MDBhMV9ldmJfY2xhc3NfaW5pdChP
YmplY3RDbGFzcyAqb2MsIHZvaWQgKmRhdGEpDQo+ID4gICAgICBhbWMtPnVhcnRfZGVmYXVsdCA9
IEFTUEVFRF9ERVZfVUFSVDEyOw0KPiA+ICAgICAgYW1jLT5pMmNfaW5pdCAgPSBhc3QyNzAwX2V2
Yl9pMmNfaW5pdDsNCj4gPiAgICAgIGFtYy0+dmJvb3Ryb20gPSB0cnVlOw0KPiA+ICsgICAgYW1j
LT52Ym9vdHJvbV9uYW1lID0gImFzdDI3eDBfYm9vdHJvbS5iaW4iOw0KPiA+ICAgICAgbWMtPmF1
dG9fY3JlYXRlX3NkY2FyZCA9IHRydWU7DQo+ID4gICAgICBtYy0+ZGVmYXVsdF9yYW1fc2l6ZSA9
IDEgKiBHaUI7DQo+ID4gICAgICBhc3BlZWRfbWFjaGluZV9jbGFzc19pbml0X2NwdXNfZGVmYXVs
dHMobWMpOw0KPiA+IC0tDQo+ID4gMi40My4wDQo+ID4NCg==

