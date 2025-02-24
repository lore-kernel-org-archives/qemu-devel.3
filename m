Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EED7C021B3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 05:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmR7p-0002v4-16; Mon, 24 Feb 2025 00:35:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tmQoi-0008PW-94; Mon, 24 Feb 2025 00:15:46 -0500
Received: from mail-psaapc01on2090.outbound.protection.outlook.com
 ([40.107.255.90] helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tmQof-0006rR-Qy; Mon, 24 Feb 2025 00:15:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPgXSbK4uPs5hrcMdpNFahMxA7YPUKfCpVQqoM4Iy/OLV6L/vVHIf7NhYjOE/G5T8D3X4gjNLcfyf/7PrdB5ZiTRNSpJFrHs+yRpmS9XHO0udPa7dMu+eNkCXYn7qdRv0FSSDPSIgr12lS5DPhZWNdepVN7EQG7x8cy4F2atNKXlSF/AbGvVo19Hl3XXRSSnLGlAAkPwvdCvUpSUS6FhauoloLOhgP/thNAzex3Xew9JP+bdwBjq+Wp41helikiRdx5VSgINQb2QbyQ4CYzLVhhMre3nD2yRa695i/X01d+yzNzY6MrQGbtJJuPQbF6xiUVCMRsOHx0/IDpcRSYGsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVARHEwd0A76n2e8xuNM+KJF1qI41XszDOn6h7AA+do=;
 b=zNBZo4yCTTB+loN8+sVo68sGA6dOqeQAfPaXJCB3ZrH0KcOe2ko+7FNeKHPZrAQJK5L21vTwRs82dNslHKa/XHRaPkQZ2H6zHMu1cNy31VKsJyqoMv/p6bXkzqY49cRVOZQtzCb7R6tK84ZM1Rn6V5M1UiqztGUPsitIE5fcPTwGqWgiZ/7z/okKhxB5I1enB+/svVDtbE4PCm2Pz6YKhuGYY/Gh4jznBNyJ7BAPxHbCpAYLDxViix0jCaiY7n+FA1OSMi64Qk+1JgFWGGmjrjBB6Ga1KSzk5IcgJo7FqlltFMovsKIk4k5e9KG4kHOYeRawTvO+KteKJaajsKTxzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVARHEwd0A76n2e8xuNM+KJF1qI41XszDOn6h7AA+do=;
 b=AALlfkNYkmoNeDGtk4sY/b5voUpspswKXdyVcP86L7z0li1paifZwEEN2XT0R4+OXGRi0zC2kVISZEZIO7VztFeo8cBEf0r+3umKUEQAQHEJ2DciX9//HsZgOiHdn8ljxLqn0U2Yo0ue/CvXJBOD7fmKGBbtyVfX4KU29j1zJFshxBb7PKwRfrZ5b+HnIIuP+ny/loPUXa88xkEhTF1z+gZGNM4TZp1OfGpEv+hyOKEjqmQgmEAY5KQSrSFORVhpwIkllqv4vDV+nremrKZXxLuLEC4DixuM+Ao831FX/Qg/mHPRedLPTyf2gAum7cIu4nGTJJbwhcqqiwaA01asXA==
Received: from SEYPR06MB5037.apcprd06.prod.outlook.com (2603:1096:101:51::5)
 by SEYPR06MB6063.apcprd06.prod.outlook.com (2603:1096:101:d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 05:10:27 +0000
Received: from SEYPR06MB5037.apcprd06.prod.outlook.com
 ([fe80::7c38:ebde:a05c:8196]) by SEYPR06MB5037.apcprd06.prod.outlook.com
 ([fe80::7c38:ebde:a05c:8196%5]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 05:10:27 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v3 21/28] hw/misc/aspeed_hace: Fix boot issue in the
 Crypto Manager Self Test
Thread-Topic: [PATCH v3 21/28] hw/misc/aspeed_hace: Fix boot issue in the
 Crypto Manager Self Test
Thread-Index: AQHbfchky6ROwLofhkuIiNhSbOQHZrNMoGUAgASp1uCAAIowAIAEJK4Q
Date: Mon, 24 Feb 2025 05:10:27 +0000
Message-ID: <SEYPR06MB50376DC24FB2098C8E9B3D93FCC02@SEYPR06MB5037.apcprd06.prod.outlook.com>
References: <20250213033531.3367697-1-jamin_lin@aspeedtech.com>
 <20250213033531.3367697-22-jamin_lin@aspeedtech.com>
 <51b4d012-db0c-42b1-ae0e-2b28751bc2a4@kaod.org>
 <SI2PR06MB5041F4186411EE60CB26CC44FCC72@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <68c95702-8ccb-43b7-bb1f-afc37c8d727d@kaod.org>
In-Reply-To: <68c95702-8ccb-43b7-bb1f-afc37c8d727d@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5037:EE_|SEYPR06MB6063:EE_
x-ms-office365-filtering-correlation-id: 726757c5-5d21-49e7-61b9-08dd54918d22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZFlFY0dlRGpBYjk1cEpicXE1RHErVWhaUmdPN3NyNTJkK3A1aS9rbC91a0tt?=
 =?utf-8?B?M3UwTHBOaWtpQTN1RkRHamVKamIxakNuQVV4dHJOckVXdWNZd1lFZDJreHFw?=
 =?utf-8?B?SXVlSFRGL29aY2l6cnRGR3RCZFlOM2dLSnBqRVBLN0lFbElWdWNlazR5MGlq?=
 =?utf-8?B?ZzlyYXZTVG8rck5ZWHhpSGVDUHU3MDZTK09mcC9xY0FOY0Uvcm4rRHhzblpU?=
 =?utf-8?B?a0hxbXRRLzlkREh6VDNZdWkyTG1MMWd0TDZwS2luOTFXYXJ0MXlSdXlmc2Nm?=
 =?utf-8?B?OW5MQkFwSnZ0bzlNakpiUWxvK1hLaG5FZEQra1VUK1o0T2pxODF0RW5tY3Zh?=
 =?utf-8?B?V1FNSW5zK3ZkNENWODRaRS81bjdqMVdLZXZCNjJuNmtWcHlTR1ljTHM0ZERq?=
 =?utf-8?B?NXBvM1FjMDFMTVpwWWdHbTY3UTNnZDNnMSswWDhDMHduUmtqU0J6OE9ObnpK?=
 =?utf-8?B?RmlKWUJEZm85WmhrOWpjSXNoRTZhMytlaWZBeTNUWTVldmF5WUpZYitGWjdo?=
 =?utf-8?B?ZW1iejJKOEFndVVwMy81Mm5RWE1obVRMeGJhckVtbVFnUWlBQXdIOGF1VnFn?=
 =?utf-8?B?SVBWNTRQOFF6RUxyam1SOStWN0xQTkVCRmpZVGczWDJTU3RoTkJQSFJpVlBG?=
 =?utf-8?B?Y3prQkN1eEZUMTFocDFWT3RlZm1hRXlhZG9HNmJjZlR2bGxEZkpjVklZdllD?=
 =?utf-8?B?MnlZSUNtVHBLN2R4U1JDVFVGQ1c0R2pobllSdUZhSGcvUFpuVURMSmRDdVp3?=
 =?utf-8?B?d3o2MjY4ODZWaW5qdnpvRW5NOFljMTc0b1JqMkZkN01IRC9jaitYZVllempZ?=
 =?utf-8?B?VVU3ekdCQXpQSmZRazF0Z2tNNlN1Ymx2OWJUVFVrQW1FOWZGQ1g1WXBQVEpq?=
 =?utf-8?B?WUVQOGRKZTVPTVlEMXlrYWNvVXpIOGhGN2JzdVZkV1Bnb1V1VTBORzZUQlVM?=
 =?utf-8?B?bGsxTVdPZXk4SmoveUVMTzNrNVpDVlRBYUNEK0hFSUlFcEZoK1dFVGdicTVl?=
 =?utf-8?B?cmp2b2Z6NkxDTnhNaS9aazFzYzZhb1ZLNTJiaDAzRzluZ25yempjTEdaaHZR?=
 =?utf-8?B?bjhrUFV3V3lvRTRXdVhJdm9pb0g5dDFBRFFVZXdmNk1LUVZaWWwxbVp1WHpS?=
 =?utf-8?B?YStpa0poWG9OMzlVY1lZbElMMjlSaThoem9NNEs2c2dONlRrN3E3L0RpUkdJ?=
 =?utf-8?B?Tnp6T3JPcXE5ZmIxR2l2RFU0OTc3MEQ1SmF5Q2xsZnZaVjZxTFZwYjNFMzV0?=
 =?utf-8?B?cmhXR1hGN3RhcmZVOUkxeUhoalcvR0g0UFV3L21aa1JyYnZkdkllQ3dRMEFX?=
 =?utf-8?B?WU0wS0YrL3ZwU0ZSdmhiQ0UydmxWaG8vSXpqa0k3Z2lTY0NqdUdLVUk2Mzhy?=
 =?utf-8?B?T29zbG5xa0hwUGNCK1VpclVqTTdvdzdxbFM1eEdCa3o0emlrS3FkOHpPWnZ0?=
 =?utf-8?B?TnY0LzAvNmNwN3dBUmRwUDAybERRZm1TQ0owTlFVdDBJTkk2UHFDaDRwTUFW?=
 =?utf-8?B?Nmc0ZEY1UjNDczB3bkVxaEpJVm0vRXdncXp1NVErNlkwbzRoN0pEUFJSKzAr?=
 =?utf-8?B?TmE5dUltRE0rYW5RTmRicmt4dDJianR6M082d2NjeEp6TnBvTDlqNEdkckVM?=
 =?utf-8?B?cWRiSXdjcDJxU0ZjVWJsMlI2RUJNZXJUYzF1d3FIR2FidjVYc2xwKzB1U2RP?=
 =?utf-8?B?S1BQWkw3cWh1ZUVMdEM2QXo4b2huZ0ZhM1E0QWU4aVdPd2pnN1BtdTNGdEIv?=
 =?utf-8?B?aHUzemx0ZmtaZ2o3czQ4NTMvamZ0SVdmUjhHUFpRdVBzQXVrRjBDNDJzNWlJ?=
 =?utf-8?B?OWs5YzhXMmozU3Nqblp6eHdvTXg1K3A1S2RwZ1lYUW4vWTloTUJwUkFXVDVq?=
 =?utf-8?B?OXJHSU1vSEtqcEtFZHd5V3hJZERRZHR2amcvUFA0U0dPaTdQbjBueGJEMnVm?=
 =?utf-8?Q?/X6bGOcWiTehFubeDkhdUL9I/wAvXl3W?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEYPR06MB5037.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2wvWkJ4Ly9odVQ0aThGMEVvR3BqeWJEaHRTRll4SEJNMkdvcngxN09nWXdx?=
 =?utf-8?B?UUVVREtxMTZoTWFCdkdWQ0NvYUJwTlZGbWNqS1pmOGExd3lqK0RxVUIrd0lh?=
 =?utf-8?B?cEQ5UWFSbFFlSnF3MFB6MEtlaFJmd0thMWNNdk5CL0xrWDZ3N3czQzZKYktv?=
 =?utf-8?B?THVCc1NDNVBTcWpzZittSUQyNjB3S0MwYjFzTFFITCtYUERFM0dJN0krUmZW?=
 =?utf-8?B?QXpldXlCMmsvcUlMWjNvMW5jY2xZQVNDVmtQVllUdEoxWlZoanZVKytvZGhR?=
 =?utf-8?B?YkNnKyszV09xZVZ5UHhuZ0ttdzZUTUpqVkVxTVlJSURCc1JrL1ZXSmhFSFNn?=
 =?utf-8?B?UHd6bW9wbnFWc0xFdkJSajVVZllFNXVJRFFKd0RlclFYbTRnSWZWdlZKekI2?=
 =?utf-8?B?ZXJqdlNSQlJhc0hGZjRoM2s1UjMvRER1Ykd2UC80aXI0NFJkQTA1TEVab24z?=
 =?utf-8?B?Z085S2YzUEpoM2V2cGN6eUNoV09xUUlIcDE1cHpuM3BoR2orOEUyQkljNFF4?=
 =?utf-8?B?SlN6ZHNsaktlWWhmeE9NRUVxb3lVcUJ5VWFEeGd3aG5raFI3a09reCtrZWhx?=
 =?utf-8?B?blRVcFdLS01hdnBsMzlJZFNGZ1Q2anpJNzBLUGpENm9VVEM3bDd3dkkveW5w?=
 =?utf-8?B?clhHZ095ZjNGSkZiSmkyQnFyaFR6UHhVMms0akhaeDZ3YkhlSk5Ed1U2OU4r?=
 =?utf-8?B?QUVKdHZFQWs3TWk2U2RFTnoyaXZWdFRva0lDRFcwQnk2c0RWZmhYdWF0Sm5q?=
 =?utf-8?B?VGo2Ui80dXRvR0FuYzdIcy93dGQ0bGNnRmdyNFpjTTFPekloUHpYLy91dWo5?=
 =?utf-8?B?UXE3bWhwQVdUeWRIZXVBaEJaRkEvKy9POVpnRmF1NFlkTWdHV3pPRTlrcHA4?=
 =?utf-8?B?MTh4OUJpYUZFakZ3UVd1MTU3dUFlRXRuaHFVVmwrbldqNHBSTk5lUnNvWVg5?=
 =?utf-8?B?eUZDYmtLUmJHQy8wNEtZVDJLWlYra2t6Y0dtdzg3cmVsRXBERzVZRmI2VFJD?=
 =?utf-8?B?UjY5WGRiaVFwQXhYL1QvK2lvSzY0ZER0Sm1uN0RlSHVZbkZBUkt6emdIM3h2?=
 =?utf-8?B?cFBWWktNRmo2dXNDMWVWZWdqZXk4S1l3aEpGalFkYm51N1ZlYURaY2RtQktx?=
 =?utf-8?B?ZE9FT0hzQk9wSkx4Q09qZjV1elhJSU84U3ZiVWl5dkZUNXVlZVBOaklYWE85?=
 =?utf-8?B?eG9Xa0dIaVRTdXZVNTU1S3FBV29KcWVZaXRSRVpkZ0hqakFoMUhDYk1PdEJj?=
 =?utf-8?B?Rk9EUk42a0E3VE9KTE13K2NnalVrNFVnK3hTRmtCbTNyUWRLREY2SHNUR0g3?=
 =?utf-8?B?NmxDbEwzYWxBVS9qdmt0cTRTcEJhTHBJN3Z3MUlHMjhncEdOd3E4UDRDUlNT?=
 =?utf-8?B?NWZyNWU1TUpucVBPNGJDUzZHS0xRMFFLWjRtMXB4dEkzQ1hyeTZDL3IzNVg0?=
 =?utf-8?B?RElQanRNdXVDdWY5aGVsY3lwaTRTbjl5RmN0V2pxbUh5a1pIVmRHTGdKK3pR?=
 =?utf-8?B?YTJnT1NlSFVFS25UaXhyODUvdm1Deis3dkJqUElubmJMVlBKNXZTcGVJTm5j?=
 =?utf-8?B?RjFBMjY4UFhyU3NqYzVpcDRrc25KQmRvaXZjY1RqZm9lclhmN3JoTUk0aGxE?=
 =?utf-8?B?U1gzMGEyYStLYm1jRU5PVVUyd3ppNmhPUzBNT2lkNkRhRnNXVmhRdWd6d25R?=
 =?utf-8?B?NFlCSjUvcWRkd1NEM3VWWXBCb0g5TmNZUURlZzFrQlR0OFhESmxJMlhhTmxI?=
 =?utf-8?B?WnZHSlRiR2tZSERUaVR4ZmJLVjJtT0dnSytSZU5aTkVES3I3emdNNFVrTEpy?=
 =?utf-8?B?eUp2elFUTnV0T0F0MnBZUi9ONlZaUm0xMktOWmNXWE0wY2NBdWFZejRzRng2?=
 =?utf-8?B?bzhIS1hFN3czTkc2SFh6QndRN0NkaEh1eUFEcnJYa2VxYWU1UTRPUWQ5Z0pK?=
 =?utf-8?B?RHczVFlrWGdsVklrM214TXh6dWYzc1hMTktPdEUzQWJwcnpLeWNhMWxBMUll?=
 =?utf-8?B?TzBvTzNMa05SZXBBdmUzMytYc2szVkNJSTY3a0lCVXlHSHhHNHVuQnk0KzM5?=
 =?utf-8?B?a2REekZsWDR3bTBoUEdoTFZpMFFDRTQwSUozNFBQSlJpWXBMdUpBSkZCNk83?=
 =?utf-8?Q?58w7I1TxjO16UPzH/b5nG4Du0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5037.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 726757c5-5d21-49e7-61b9-08dd54918d22
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 05:10:27.1277 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HXxACQYt2gj9aWWLAb+TW1XuDH1/4RKpzzI3E9aI3J7UBl2bzjo1xwIuEESGWxgiue8zCHn8Dz2uzU/CdU8qac6cEiyzMsWE79GP06CVVPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6063
Received-SPF: pass client-ip=40.107.255.90;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMjEvMjhdIGh3L21pc2MvYXNw
ZWVkX2hhY2U6IEZpeCBib290IGlzc3VlIGluIHRoZQ0KPiBDcnlwdG8gTWFuYWdlciBTZWxmIFRl
c3QNCj4gDQo+IE9uIDIvMjEvMjUgMDY6NDMsIEphbWluIExpbiB3cm90ZToNCj4gPiBIaSBDZWRy
aWMsDQo+ID4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAyMS8yOF0gaHcvbWlzYy9hc3Bl
ZWRfaGFjZTogRml4IGJvb3QgaXNzdWUgaW4NCj4gPj4gdGhlIENyeXB0byBNYW5hZ2VyIFNlbGYg
VGVzdA0KPiA+Pg0KPiA+PiBPbiAyLzEzLzI1IDA0OjM1LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4+
PiBDdXJyZW50bHksIGl0IGRvZXMgbm90IHN1cHBvcnQgdGhlIENSWVBUIGNvbW1hbmQuIEluc3Rl
YWQsIGl0IG9ubHkNCj4gPj4+IHNlbmRzIGFuIGludGVycnVwdCB0byBub3RpZnkgdGhlIGZpcm13
YXJlIHRoYXQgdGhlIGNyeXB0IGNvbW1hbmQgaGFzDQo+ID4+IGNvbXBsZXRlZC4NCj4gPj4+IEl0
IGlzIGEgdGVtcG9yYXJ5IHdvcmthcm91bmQgdG8gcmVzb2x2ZSB0aGUgYm9vdCBpc3N1ZSBpbiB0
aGUgQ3J5cHRvDQo+ID4+PiBNYW5hZ2VyIFNlbGYgVGVzdC4NCj4gPj4+DQo+ID4+PiBTaWduZWQt
b2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPj4NCj4gPj4g
UGxlYXNlIGFkZCBhbiBBc3BlZWRIQUNFQ2xhc3MgY2xhc3MgYXR0cmlidXRlIChib29sKSB0byBo
YW5kbGUgdGhpcw0KPiA+PiB3b3JrYXJvdW5kIGFuZCBhIGNvbW1lbnQgaW4gdGhlIGNvZGUgbWVu
dGlvbmluZyB0aGUgaXNzdWUuDQo+ID4+DQo+ID4gVGhhbmtzIGZvciByZXZpZXcgYW5kIHN1Z2dl
c3Rpb24uDQo+ID4gSSB3aWxsIGFkZCB0aGUgdXNlX2NyeXB0X3dvcmthcm91bmQgYXR0cmlidXRl
IHRvIHRoZSBBc3BlZWRIQUNFQ2xhc3MgYW5kDQo+IGludHJvZHVjZSB0aGUgdXNlLWNyeXB0LXdv
cmthcm91bmQgcHJvcGVydHkuDQo+ID4gRG8geW91IGhhdmUgYW55IGNvbmNlcm5zLCBvciBkbyB5
b3UgaGF2ZSBhIHByZWZlcnJlZCBuYW1pbmcgY29udmVudGlvbj8NCj4gDQo+IE1heSBiZSAncmFp
c2VfY3J5cHRfaW50ZXJydXB0X3dvcmthcm91bmQnIHRvIHJlZmxlY3Qgd2hhdCBpcyBiZWluZyBk
b25lID8NCj4gDQpUaGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlvbi4NCldpbGwgYWRkIGl0Lg0KDQpK
YW1pbg0KDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KPiANCj4gDQo+ID4gVGhhbmtzLUphbWlu
DQo+ID4NCj4gPj4NCj4gPj4gVGhhbmtzLA0KPiA+Pg0KPiA+PiBDLg0KPiA+Pg0KPiA+Pg0KPiA+
Pg0KPiA+Pj4gLS0tDQo+ID4+PiAgICBody9taXNjL2FzcGVlZF9oYWNlLmMgfCAxMiArKysrKysr
KysrKysNCj4gPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspDQo+ID4+Pg0K
PiA+Pj4gZGlmZiAtLWdpdCBhL2h3L21pc2MvYXNwZWVkX2hhY2UuYyBiL2h3L21pc2MvYXNwZWVk
X2hhY2UuYyBpbmRleA0KPiA+Pj4gODY0MjJjYjNiZS4uNGQwOTk5ZTdlOSAxMDA2NDQNCj4gPj4+
IC0tLSBhL2h3L21pc2MvYXNwZWVkX2hhY2UuYw0KPiA+Pj4gKysrIGIvaHcvbWlzYy9hc3BlZWRf
aGFjZS5jDQo+ID4+PiBAQCAtNTksNiArNTksNyBAQA0KPiA+Pj4gICAgLyogT3RoZXIgY21kIGJp
dHMgKi8NCj4gPj4+ICAgICNkZWZpbmUgIEhBU0hfSVJRX0VOICAgICAgICAgICAgICAgICAgICBC
SVQoOSkNCj4gPj4+ICAgICNkZWZpbmUgIEhBU0hfU0dfRU4gICAgICAgICAgICAgICAgICAgICBC
SVQoMTgpDQo+ID4+PiArI2RlZmluZSAgQ1JZUFRfSVJRX0VOICAgICAgICAgICAgICAgICAgIEJJ
VCgxMikNCj4gPj4+ICAgIC8qIFNjYXR0ZXItZ2F0aGVyIGRhdGEgbGlzdCAqLw0KPiA+Pj4gICAg
I2RlZmluZSBTR19MSVNUX0xFTl9TSVpFICAgICAgICAgICAgICAgIDQNCj4gPj4+ICAgICNkZWZp
bmUgU0dfTElTVF9MRU5fTUFTSyAgICAgICAgICAgICAgICAweDBGRkZGRkZGDQo+ID4+PiBAQCAt
MzQzLDYgKzM0NCwxMyBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfaGFjZV93cml0ZSh2b2lkICpvcGFx
dWUsDQo+ID4+IGh3YWRkciBhZGRyLCB1aW50NjRfdCBkYXRhLA0KPiA+Pj4gICAgICAgICAgICAg
ICAgICAgIHFlbXVfaXJxX2xvd2VyKHMtPmlycSk7DQo+ID4+PiAgICAgICAgICAgICAgICB9DQo+
ID4+PiAgICAgICAgICAgIH0NCj4gPj4+ICsgICAgICAgIGlmIChkYXRhICYgQ1JZUFRfSVJRKSB7
DQo+ID4+PiArICAgICAgICAgICAgZGF0YSAmPSB+Q1JZUFRfSVJROw0KPiA+Pj4gKw0KPiA+Pj4g
KyAgICAgICAgICAgIGlmIChzLT5yZWdzW2FkZHJdICYgQ1JZUFRfSVJRKSB7DQo+ID4+PiArICAg
ICAgICAgICAgICAgIHFlbXVfaXJxX2xvd2VyKHMtPmlycSk7DQo+ID4+PiArICAgICAgICAgICAg
fQ0KPiA+Pj4gKyAgICAgICAgfQ0KPiA+Pj4gICAgICAgICAgICBicmVhazsNCj4gPj4+ICAgICAg
ICBjYXNlIFJfSEFTSF9TUkM6DQo+ID4+PiAgICAgICAgICAgIGRhdGEgJj0gYWhjLT5zcmNfbWFz
azsNCj4gPj4+IEBAIC0zODgsNiArMzk2LDEwIEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9oYWNlX3dy
aXRlKHZvaWQgKm9wYXF1ZSwNCj4gPj4gaHdhZGRyIGFkZHIsIHVpbnQ2NF90IGRhdGEsDQo+ID4+
PiAgICAgICAgY2FzZSBSX0NSWVBUX0NNRDoNCj4gPj4+ICAgICAgICAgICAgcWVtdV9sb2dfbWFz
ayhMT0dfVU5JTVAsICIlczogQ3J5cHQgY29tbWFuZHMgbm90DQo+ID4+IGltcGxlbWVudGVkXG4i
LA0KPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXyk7DQo+ID4+PiArICAg
ICAgICBzLT5yZWdzW1JfU1RBVFVTXSB8PSBDUllQVF9JUlE7DQo+ID4+PiArICAgICAgICBpZiAo
ZGF0YSAmIENSWVBUX0lSUV9FTikgew0KPiA+Pj4gKyAgICAgICAgICAgIHFlbXVfaXJxX3JhaXNl
KHMtPmlycSk7DQo+ID4+PiArICAgICAgICB9DQo+ID4+PiAgICAgICAgICAgIGJyZWFrOw0KPiA+
Pj4gICAgICAgIGRlZmF1bHQ6DQo+ID4+PiAgICAgICAgICAgIGJyZWFrOw0KPiA+DQoNCg==

