Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51077C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 08:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJq5D-0005fv-D2; Tue, 27 May 2025 04:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uJq4s-0005cK-3X; Tue, 27 May 2025 04:54:31 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1uJq4m-00029h-BP; Tue, 27 May 2025 04:54:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AempO/nXpXIUHQNJOJoWcMlxcr5VW4Bej6R2qNg5r9wzQjQ1UXpLhdSLBeepj3aG3s0FhZ3vnE4xLdRRqEBrbaW3jTfyiFWA3/+bRMON5S2jWXik3SZw0CCqt9RlZe6TSKkVmy77z452+lUJ3iVyA6U60Ub4GRXkSLw48A9yJ2PAvOj7XncsXoklX/wYVIGruw/+PI5R7ME49pfJ4LGPpasxF4PcCS3LN5MWriUFAABad3+kC6xdJRUMbib8O4XXu5Ffs0GueY8m2UL1wVFHu/J8oarUfY8RO01fPplLKgkbelw7rZKEVjBWi2WDBaBbpilUkqwL8+x0lWgdSFX8hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLPj5BhU5BgQ/58vy2zRUlIgB6K/5QThQ3TNC5D2LAI=;
 b=OWkWbxRp+MYs/415CIrtWysJfjRTIOTbBRxEX7LL6O8KZi3f/XBoriUhpAKVuGoknIO8MwaBVOVvNfamJEmeMRy4Ltu/OY3dq2gKRRg+91KKNc2x23+NuMK+anau+UQVso0ylehj4YW7SkuNlevkxBYPcfvaCO18Nupv9w03VKcvJIR5k7bi3xoggpkBGX6kIj1knuDu8qFLthJ4Wz3UzTPIXSJHfxcJnjbd8JcgchtUF6fVX+sD98PPpaMDZtBEXgcqqHRinHF1go10Sjyv3oNgjvWP8tuWVu9ObIgikuJDk7A2uHFXEecBAJO/KnhBSU8crU8mZ7PrQa3/jXfjvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLPj5BhU5BgQ/58vy2zRUlIgB6K/5QThQ3TNC5D2LAI=;
 b=T+DtOBbzVIwX/XXwK45aTcfKVTPFmS7/n90CGlZLqCmat5ZTmmFL5KA7YLx1y6Dl5FEG3c7AnzXBaN9dTkrVzfcg+O40uQvCBQBYsTY9P0AA+x5OUYFO346lNAPTXb/bqWGKhC/N49CZruF7H71M0nq9eWC9IdpzjM7SWgV7mEU6vWCuM0fHChLm1BVIdo5eq3unUtN7WzxuFG9QCH+GiVANn3TrQ5ex0o1fI/2odFggmnGtQ0Ps6scbhc5cE/7HRmAAXg9IXF/C4daavWMQywC5UTOrsg/9rUsNlOSQEu09/JXGjDtQ1a53hkCUMA6rTaly1GgNTonkAcVcGuWSvg==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SEZPR06MB6691.apcprd06.prod.outlook.com (2603:1096:101:17d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Tue, 27 May
 2025 08:54:13 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%7]) with mapi id 15.20.8769.022; Tue, 27 May 2025
 08:54:13 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v4 2/3] hw/misc/aspeed_sbc: Connect ASPEED OTP memory
 device to SBC controller
Thread-Topic: [PATCH v4 2/3] hw/misc/aspeed_sbc: Connect ASPEED OTP memory
 device to SBC controller
Thread-Index: AQHbwx2wy9OBNck3jUaG7fhOGvFKe7PmJFuAgAAAhoCAABLRAIAACIVQ
Date: Tue, 27 May 2025 08:54:13 +0000
Message-ID: <SI6PR06MB76316CDF36D7F51A6AA8A21CF764A@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20250512091014.3454083-1-kane_chen@aspeedtech.com>
 <20250512091014.3454083-3-kane_chen@aspeedtech.com>
 <67ced980-d6d8-4a2d-85ba-c918298ecf8b@kaod.org>
 <SI6PR06MB7631337C549FA649031173DFF764A@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <05a02b39-a76a-4f1c-8562-cc93ff0c21c8@kaod.org>
In-Reply-To: <05a02b39-a76a-4f1c-8562-cc93ff0c21c8@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SEZPR06MB6691:EE_
x-ms-office365-filtering-correlation-id: 97df8d55-30c6-44a7-ffbf-08dd9cfc0dfd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QkgvcmFYRkNxNytYWlFkZ3JwRyt5QmVDOStOWGJFK2IrOUp1U1BDS00rWTl6?=
 =?utf-8?B?cktEckRwZE5nWko0N05zVEdnajhMVUZVYmhqLzVocVdka0I0Y1oxYXZMVjdQ?=
 =?utf-8?B?VlNYSjBzNXBMZndYRVN4UWVxY2ZSdmtpalVUbDNuM0JaSzRDdS9zOTJVSENs?=
 =?utf-8?B?ZVdBRzJNZzV3aGh0aS9SMmRWQm9LbzlvZEV4eW9YSlBIekE3MVdjVjI2UVk1?=
 =?utf-8?B?a2h0ZENPbitEdUpDTllEYnpnMGZjallEWWkzVG9FcVhVR0hSSlBaSzdJcm4x?=
 =?utf-8?B?V0N3aS9KZkcxUFl4b2duZEZNZU5UMFJQc2tCdWhVSG9hako1M0hzcGNFSTdw?=
 =?utf-8?B?Mk5vZHNjK04wL0JQU2VXbzJuNDcxUFhuUEw4NXVZcGo0STdHWkllS3VYNmdK?=
 =?utf-8?B?UEhqdUZCTy92YTBRUmVxS244NmhSTUNqbkRkSzh6aGhOOWFOSC9YRVYveThm?=
 =?utf-8?B?bklGUDBOUWx5Z3FSeGlEMzJiR0VYYWpwMnF3M2ExUHBpaXpmVW1pbW9CYWh2?=
 =?utf-8?B?UEJHMEVtMlo3S2ZrZGlHNUU2UmVvczE1cUE1WXhVakc4WWh0c1hiS09rTmJl?=
 =?utf-8?B?ODZGN3F3SWxrWS9hNndSbWdPSmpGS1JQSU5JUHIxVldvUC81OUh2VEZmcERq?=
 =?utf-8?B?Sm9Ud3NhK1NZbDZaVDdYZzQzcERjSjZicDNZZHZweHU4ZUtBMHFyR0Z6Yncr?=
 =?utf-8?B?K1F3OC9TSWVyWkVZTktiM1R1c0VYTEg3ZXZub1o3ZnJVbDV3MWtsbkltYXRE?=
 =?utf-8?B?Yi91T1RCOXFIQmZuU2lLL0ZEYVp6cE9NcmZuZVNGalZpK0llcU13dzZrUDli?=
 =?utf-8?B?c2hCeEI0TCtNOHR2SDBIUFN3RllvNEczanpCZllqNVVVRlo0S1FZMWlPM240?=
 =?utf-8?B?ckZmZGc2ZG96eTFYUVZiWGVyZHRUcWdmS1l4dzQxMVVJaVdzUDF4ZXpzVlhM?=
 =?utf-8?B?YWVoVmJwMm9WeWZRTXRXL1E4UkFDVCtIanRHdUdCMnp6M250cTF0c3J0cWxt?=
 =?utf-8?B?ZGlQaUJKc0ZHSTZrbTJILzBlTDRsTGhEcVpldEZ5a2YvT1VSLzlOdEorU0xh?=
 =?utf-8?B?QzYyQ0VvS3hCcnJBK0RTT3NyY3NnWFVhTGNLSXhwenFMczB3Qmx0SDJhOUtn?=
 =?utf-8?B?LzA1cXpMWDRhS21PdXlyTGNpSnpCY0N0dWtkNysraXNBNjNLVnBIWGs0UmFy?=
 =?utf-8?B?MEYrdm14cnp3a3BOWTlRQkFsK2ExQnh0UkNNZGY3Z2ZIbFRSSHNBL0xXNGVO?=
 =?utf-8?B?QXNWMDVzTFJMc0k3VFlrOE9ITUkyd2hncHpjRTFwZk96cXFRTWVBbmkwU0Y4?=
 =?utf-8?B?WTJVY0JvcmQrZExIRDkxTGlya283TlZ6elpsU2Vqd29DcnBNL3hwZ3YzaU94?=
 =?utf-8?B?OUlkZ244SWY3ckpYNmNmMm1Mb0gycmNvS3Jpa2h2WXl6cGpqazFZVWdwT1FS?=
 =?utf-8?B?ajRTb1VZQnF1aWI4bGJ5Ly9JTEo4SFFTa0FrYUlXWTBpWW1DTlZrQ2htZGdT?=
 =?utf-8?B?eFZEYXRBcGRPUmRoeTA5UGhQMTFRcWVNcEFrL2w1enFGNkNCdFFWTjJ1WEFE?=
 =?utf-8?B?WGFQR3JVSXNZV2lZVDFHcU1YSldQYmNjS2VXdVBRdDRwdEo2ei9FMmRrSzRr?=
 =?utf-8?B?aEJnakZMbFNnVWVOQVZpLzM0V2JsVXZ1SXZhTWxzSGU5UWI2aUg0L1BYbGg1?=
 =?utf-8?B?ZUVKMkpsTDZRczRPa0Q5R0QrMUZrVVYwUDZiRUJpV3VJZ3BUL2diNVpDQllx?=
 =?utf-8?B?OTBQTVFiRENIcDIvMUt3SU84dDZCdzhiaXdWVzlBUTM4QUpMdTM0NHZRUHU1?=
 =?utf-8?B?ZmdlNDlmSlVVZDVoT2pvRDcrc1FmWWpJa3FQTFNzb29aQzVWaFoyTXRuWXVa?=
 =?utf-8?B?UzlrQ0k3REFRZVQ1VGhTZW9lZ1VhYzlPK0E5RGRHUTRpRXdaWS9tSFh4OVlL?=
 =?utf-8?B?OVlUZ1ljMzlISVVLbktpWHMyMGE4U3JrOGtiT1V3eWtRVnpNMXA1QmRHSjFG?=
 =?utf-8?Q?z6iuCf3NvA1arWRjUCniVAsMsUi5vk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzVSTklUMTNpSC9JWlpJVmQ5S1gxVXhsMk93b0EzelNRcGlhVFV2VlNDUWpT?=
 =?utf-8?B?Mis2WmtNQWRMZjUwVmRaVWV0WkMxL1VQQnZiWTg4dzU0UUlhckhMZFdGTGVi?=
 =?utf-8?B?ZStrMTV1UU5WK3E4QW9uaHJzM1h2RmlkK0NnaVNZQzF1cHNtZHNFelJUWjlx?=
 =?utf-8?B?SEdXTVNqSVV4UFNEUkgxcjZZazhKbS9tZXJIdWhhTTNmWlpybm1ZNnVXSnVU?=
 =?utf-8?B?MEgyMTIxdU9tOTVTZ0VvNUIyQXRXb1BKdEZwbEt4UGhVbWNleVcyc2Y0TnNV?=
 =?utf-8?B?OUF6TlJqRFh2QXM0U29odDBCcFJuUVhKVlhsVEh0eFpxV3d0aWlrQmFSNnV6?=
 =?utf-8?B?eU1kV0djMGM4alFiNUVEWkZCSFBrempZMC83SFVKK0dlamg3cEhzSmlqQUJJ?=
 =?utf-8?B?SWc3WnRHS1ovOTBpYWFpZnRZSGVnUE8rSE1ZSHVOR0M4eUNsUlJzYVA0Y2wr?=
 =?utf-8?B?bENWTkxxdkorVEVLclQvWUVxT3hCNFExMDQ4UjZJS3pPay91WmloWE94ZFZM?=
 =?utf-8?B?ZG5vSjhNQTZvMEdBQVRQSFNkVkxkb1NQb1JWWFdTVXpYY1hpR0x1NWFOekFa?=
 =?utf-8?B?Y29sZlVmclpnazJpSVYwNkdTSVVzK1hnL2NtTW1KUzlvbjR2Rk0xSlZ2Q2g4?=
 =?utf-8?B?T1R1VTRHTXlRMlJocE94MVpYOEsrbzBHTUFpckliZjVsb0lZMUk5UFo2emVn?=
 =?utf-8?B?NWIvNG93bFRWQjFzdUJFVGJnd2hPeDlZbnNjNDhPalRwQ1hwTTV2NUFQSG5t?=
 =?utf-8?B?aTJmNXlNcnVIMG96TGpwaEM4aVRRMkNhZVhvZGF4NU0rVHdOTmxlRllOUUVV?=
 =?utf-8?B?SGRFQS9YU0Y3MDROc1YwZzh1Y1JUV2VqL1dabkc3eVE3WlR5MDVrbXhISzhN?=
 =?utf-8?B?Ly9nZW40UFFKY2R6SE15WnJxamsrSXNTK2MwL0NlUU1raENtK2dBRy81dlpq?=
 =?utf-8?B?RVg1YTlRUVNHVnJWQVRVVi81TTlYWEhXREZJekdBNHl6UTJrM1h6VHhnL0JD?=
 =?utf-8?B?U2dIZzNCKzhsbm1odzd2aHh4ZmFuUGhnSGpqNG03OWxMeURXK1Uxd1RXS2lK?=
 =?utf-8?B?cnBZRkVabFJORnd5bU93VU9YZ3kzSzdka0ZxRjJGUGg5VStvRWtUMEpBZkhs?=
 =?utf-8?B?NytkbkFtUzJSVGlEYkVsS2UzcTVRdWVLdzN2WmJMZEpzQ0NxMFdyems1blMr?=
 =?utf-8?B?TlJ4dStOR3ozL05qZFhmL01CRXZLa1hvQnlvcjFNa2c0eTA3d2NDeHVlVDZE?=
 =?utf-8?B?dk1kUklrbFBsSFlWL1VuWm5Mc0c0dU5UZUR6TkxBNnJuRER2bFlGSEZlZFF5?=
 =?utf-8?B?MUw5S0JkV3EzTmp4RTdpSDErNWlzdnNnYVhsYnhOOHpKQnBDcG1FSzhMZUwv?=
 =?utf-8?B?ellhZHRqRnBwK0lndWh6VTBTTFR2cWx0UWk5OEx3R2Z3dmRVZ2JXSHRhSE1i?=
 =?utf-8?B?S3R4ZUF6amFrMjZLUzl2RjdFL05UeFpLd3k1OUFRZXN1dEdjUVpJelRta203?=
 =?utf-8?B?VG1uWEdaWWkrTk82c3FsN25RR1g5YklzYWlncGwzYkpLZkNXc0lJZW1wdzFO?=
 =?utf-8?B?a2Q2NnArWWhEMVhrOG9OR0ZFajMrU0E2Y056cUFXMUJEMmJ0aXRDN3dBMEFm?=
 =?utf-8?B?cTlTQVR5Umt2OFZvSkk0WVl0OU5rNFJjTGN4WmtlUXNvbHIvV0ZaZHB6eUU2?=
 =?utf-8?B?WXlhK2lUTkgyQXhveHpZdXNtUm9jUHppRWx3U2oybUs1NE5qUHUrMi85cjFp?=
 =?utf-8?B?L2p0V1ZMZGQyWDVGa01uUnAzdTRLY0IvK1pkb2lZUVEzd0xaSk55WXdFaTFL?=
 =?utf-8?B?eVlXQlg4VDlFVVYwNy9rbTFEQ3FCMjk4WWkvbTNOaWtSUjF4OURza2FQWFNa?=
 =?utf-8?B?Z0NYM0c3ZEl5ME1WdHFNTkNrUld2RmdqY0UvOHZadTdoR3ZjSlhrOHpjcTQ0?=
 =?utf-8?B?RXRDWmkzbmU3RGMyb05wclRYMnBpTGxYd3dYMmZ2ZGR1QkVaUGYzMW5oVXha?=
 =?utf-8?B?UlZGTG9nWVBFUHFHTElVczBVV1RLWks4VUVPYkZkTE5RVU5aU0VuQ1ltN3NR?=
 =?utf-8?B?bXgvRWxqSS9RMWJFamYxU3kxdFEwMndidWJRVWFyL1lVOU5IdGRUSlF0RTZU?=
 =?utf-8?Q?7KURlmWgYBH9h6R3ZaF3udj38?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97df8d55-30c6-44a7-ffbf-08dd9cfc0dfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 08:54:13.6426 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2f32S83HzeD/GwQ0cHRkQ/HfVHbYG1+TmbUkYNQjCa8fe6dHOtPOd33+MncnbBr5g95IvEYTsk1ka0l0SW/BWra/tIzuuastwkOKyCUQ2gA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6691
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=kane_chen@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBNYXkgMjcsIDIw
MjUgNDoxMiBQTQ0KPiBUbzogS2FuZSBDaGVuIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+OyBQ
ZXRlciBNYXlkZWxsDQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBTdGV2ZW4gTGVlIDxz
dGV2ZW5fbGVlQGFzcGVlZHRlY2guY29tPjsgVHJveQ0KPiBMZWUgPGxlZXRyb3lAZ21haWwuY29t
PjsgSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBBbmRyZXcNCj4gSmVmZmVy
eSA8YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5IDxqb2VsQGptcy5p
ZC5hdT47IG9wZW4NCj4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9w
ZW4gbGlzdDpBbGwgcGF0Y2hlcyBDQyBoZXJlDQo+IDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+
IENjOiBUcm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjQgMi8zXSBody9taXNjL2FzcGVlZF9zYmM6IENvbm5lY3QgQVNQRUVEIE9UUA0KPiBt
ZW1vcnkgZGV2aWNlIHRvIFNCQyBjb250cm9sbGVyDQo+IA0KPiBPbiA1LzI3LzI1IDA5OjQ2LCBL
YW5lIENoZW4gd3JvdGU6DQo+ID4gSGkgQ8OpZHJpYywNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3Jn
Pg0KPiA+PiBTZW50OiBUdWVzZGF5LCBNYXkgMjcsIDIwMjUgMzowMiBQTQ0KPiA+PiBUbzogS2Fu
ZSBDaGVuIDxrYW5lX2NoZW5AYXNwZWVkdGVjaC5jb20+OyBQZXRlciBNYXlkZWxsDQo+ID4+IDxw
ZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBTdGV2ZW4gTGVlIDxzdGV2ZW5fbGVlQGFzcGVlZHRl
Y2guY29tPjsNCj4gPj4gVHJveSBMZWUgPGxlZXRyb3lAZ21haWwuY29tPjsgSmFtaW4gTGluIDxq
YW1pbl9saW5AYXNwZWVkdGVjaC5jb20+Ow0KPiA+PiBBbmRyZXcgSmVmZmVyeSA8YW5kcmV3QGNv
ZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5DQo+ID4+IDxqb2VsQGptcy5pZC5hdT47
IG9wZW4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251Lm9yZz47IG9wZW4NCj4gPj4g
bGlzdDpBbGwgcGF0Y2hlcyBDQyBoZXJlIDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQo+ID4+IENj
OiBUcm95IExlZSA8dHJveV9sZWVAYXNwZWVkdGVjaC5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjQgMi8zXSBody9taXNjL2FzcGVlZF9zYmM6IENvbm5lY3QgQVNQRUVEIE9UUA0KPiA+
PiBtZW1vcnkgZGV2aWNlIHRvIFNCQyBjb250cm9sbGVyDQo+ID4+DQo+ID4+IE9uIDUvMTIvMjUg
MTE6MTAsIEthbmUgQ2hlbiB3cm90ZToNCj4gPj4+IEZyb206IEthbmUtQ2hlbi1BUyA8a2FuZV9j
aGVuQGFzcGVlZHRlY2guY29tPg0KPiA+Pj4NCj4gPj4+IEludGVncmF0ZSB0aGUgYXNwZWVkLm90
cG1lbSBiYWNrZW5kIHdpdGggdGhlIEFTUEVFRCBTZWN1cmUgQm9vdA0KPiA+Pj4gQ29udHJvbGxl
ciAoU0JDKS4NCj4gPj4+DQo+ID4+PiBUaGlzIHBhdGNoIGFkZHMgY29tbWFuZCBoYW5kbGluZyBz
dXBwb3J0IGluIHRoZSBTQkMgdG8gcmVhZCBhbmQNCj4gPj4+IHByb2dyYW0gdGhlIGNvbm5lY3Rl
ZCBPVFAgbWVtb3J5IHVzaW5nIFJFQUQsIFdSSVRFLCBhbmQgUFJPRw0KPiA+PiBjb21tYW5kcy4N
Cj4gPj4+IEl0IGVuYWJsZXMgYmFzaWMgaW50ZXJhY3Rpb24gd2l0aCBPVFAgY29udGVudCBmb3Ig
c2VjdXJlIGJvb3Qgb3INCj4gPj4+IGZ1c2UNCj4gPj4gbW9kZWxpbmcgbG9naWMuDQo+ID4+Pg0K
PiA+Pj4gVHJhY2Vwb2ludHMgYXJlIHVzZWQgdG8gbW9uaXRvciBjb21tYW5kIGFjdGl2aXR5IGFu
ZCB1bnN1cHBvcnRlZCBwYXRocy4NCj4gPj4+DQo+ID4+PiBUaGUgZm9sbG93aW5nIFFPTSBoaWVy
YXJjaHkgaWxsdXN0cmF0ZXMgaG93IE9UUCBpcyBjb25uZWN0ZWQ6DQo+ID4+Pg0KPiA+Pj4gICAg
IC9tYWNoaW5lIChhc3QxMDMwLWV2Yi1tYWNoaW5lKQ0KPiA+Pj4gICAgICAgL3NvYyAoYXN0MTAz
MC1hMSkNCj4gPj4+ICAgICAgICAgL3NiYyAoYXNwZWVkLnNiYy1hc3QxMFgwKQ0KPiA+Pj4gICAg
ICAgICAgIC9hc3BlZWQuc2JjWzBdIChtZW1vcnktcmVnaW9uKQ0KPiA+Pj4gICAgICAgICAgIC9v
dHBtZW0gKGFzcGVlZC5vdHBtZW0pDQo+ID4+PiAgICAgICAgICAgICAvYXNwZWVkLm90cG1lbS5i
YWNrZW5kWzBdIChtZW1vcnktcmVnaW9uKQ0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IEth
bmUtQ2hlbi1BUyA8a2FuZV9jaGVuQGFzcGVlZHRlY2guY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiAg
ICBody9taXNjL2FzcGVlZF9zYmMuYyAgICAgICAgIHwgMTc5DQo+ID4+ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+ID4+PiAgICBody9taXNjL3RyYWNlLWV2ZW50cyAgICAg
ICAgIHwgICA1ICsNCj4gPj4+ICAgIGluY2x1ZGUvaHcvbWlzYy9hc3BlZWRfc2JjLmggfCAgIDUg
Kw0KPiA+Pj4gICAgMyBmaWxlcyBjaGFuZ2VkLCAxODkgaW5zZXJ0aW9ucygrKQ0KPiA+Pj4NCj4g
Pj4+IGRpZmYgLS1naXQgYS9ody9taXNjL2FzcGVlZF9zYmMuYyBiL2h3L21pc2MvYXNwZWVkX3Ni
Yy5jIGluZGV4DQo+ID4+PiBhN2QxMDFiYTcxLi4yMzdhODQ5OWQ5IDEwMDY0NA0KPiA+Pj4gLS0t
IGEvaHcvbWlzYy9hc3BlZWRfc2JjLmMNCj4gPj4+ICsrKyBiL2h3L21pc2MvYXNwZWVkX3NiYy5j
DQo+ID4+PiBAQCAtMTUsOSArMTUsMTQgQEANCj4gPj4+ICAgICNpbmNsdWRlICJody9taXNjL2Fz
cGVlZF9zYmMuaCINCj4gPj4+ICAgICNpbmNsdWRlICJxYXBpL2Vycm9yLmgiDQo+ID4+PiAgICAj
aW5jbHVkZSAibWlncmF0aW9uL3Ztc3RhdGUuaCINCj4gPj4+ICsjaW5jbHVkZSAidHJhY2UuaCIN
Cj4gPj4+DQo+ID4+PiAgICAjZGVmaW5lIFJfUFJPVCAgICAgICAgICAoMHgwMDAgLyA0KQ0KPiA+
Pj4gKyNkZWZpbmUgUl9DTUQgICAgICAgICAgICgweDAwNCAvIDQpDQo+ID4+PiArI2RlZmluZSBS
X0FERFIgICAgICAgICAgKDB4MDEwIC8gNCkNCj4gPj4+ICAgICNkZWZpbmUgUl9TVEFUVVMgICAg
ICAgICgweDAxNCAvIDQpDQo+ID4+PiArI2RlZmluZSBSX0NBTVAxICAgICAgICAgKDB4MDIwIC8g
NCkNCj4gPj4+ICsjZGVmaW5lIFJfQ0FNUDIgICAgICAgICAoMHgwMjQgLyA0KQ0KPiA+Pj4gICAg
I2RlZmluZSBSX1FTUiAgICAgICAgICAgKDB4MDQwIC8gNCkNCj4gPj4+DQo+ID4+PiAgICAvKiBS
X1NUQVRVUyAqLw0KPiA+Pj4gQEAgLTQxLDYgKzQ2LDE5IEBADQo+ID4+PiAgICAjZGVmaW5lIFFT
Ul9SU0FfTUFTSyAgICAgICAgICAgKDB4MyA8PCAxMikNCj4gPj4+ICAgICNkZWZpbmUgUVNSX0hB
U0hfTUFTSyAgICAgICAgICAoMHgzIDw8IDEwKQ0KPiA+Pj4NCj4gPj4+ICt0eXBlZGVmIGVudW0g
ew0KPiA+Pj4gKyAgICBTQkNfT1RQX0NNRF9SRUFEID0gMHgyM2IxZTM2MSwNCj4gPj4+ICsgICAg
U0JDX09UUF9DTURfV1JJVEUgPSAweDIzYjFlMzYyLA0KPiA+Pj4gKyAgICBTQkNfT1RQX0NNRF9Q
Uk9HID0gMHgyM2IxZTM2NCwNCj4gPj4+ICt9IFNCQ19PVFBfQ29tbWFuZDsNCj4gPj4+ICsNCj4g
Pj4+ICsjZGVmaW5lIE9UUF9EQVRBX0RXT1JEX0NPVU5UICAgICAgICAoMHg4MDApDQo+ID4+PiAr
I2RlZmluZSBPVFBfVE9UQUxfRFdPUkRfQ09VTlQgICAgICAgKDB4MTAwMCkNCj4gPj4+ICsNCj4g
Pj4+ICsjZGVmaW5lIE1PREVfUkVHSVNURVIgICAgICAgICAgICAgICAoMHgxMDAwKQ0KPiA+Pj4g
KyNkZWZpbmUgTU9ERV9SRUdJU1RFUl9BICAgICAgICAgICAgICgweDMwMDApDQo+ID4+PiArI2Rl
ZmluZSBNT0RFX1JFR0lTVEVSX0IgICAgICAgICAgICAgKDB4NTAwMCkNCj4gPj4+ICsNCj4gPj4+
ICAgIHN0YXRpYyB1aW50NjRfdCBhc3BlZWRfc2JjX3JlYWQodm9pZCAqb3BhcXVlLCBod2FkZHIg
YWRkciwNCj4gPj4+IHVuc2lnbmVkIGludA0KPiA+PiBzaXplKQ0KPiA+Pj4gICAgew0KPiA+Pj4g
ICAgICAgIEFzcGVlZFNCQ1N0YXRlICpzID0gQVNQRUVEX1NCQyhvcGFxdWUpOyBAQCAtNTcsNiAr
NzUsMTQzDQo+IEBADQo+ID4+PiBzdGF0aWMgdWludDY0X3QgYXNwZWVkX3NiY19yZWFkKHZvaWQg
Km9wYXF1ZSwgaHdhZGRyIGFkZHIsIHVuc2lnbmVkDQo+ID4+PiBpbnQNCj4gPj4gc2l6ZSkNCj4g
Pj4+ICAgICAgICByZXR1cm4gcy0+cmVnc1thZGRyXTsNCj4gPj4+ICAgIH0NCj4gPj4+DQo+ID4+
PiArc3RhdGljIGJvb2wgYXNwZWVkX3NiY19vdHBtZW1fcmVhZChBc3BlZWRTQkNTdGF0ZSAqcywN
Cj4gPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IG90cF9h
ZGRyLCBFcnJvcg0KPiAqKmVycnApDQo+ID4+IHsNCj4gPj4+ICsgICAgdWludDMyX3QgZGF0YSA9
IDAsIG90cF9vZmZzZXQ7DQo+ID4+PiArICAgIGJvb2wgaXNfZGF0YSA9IGZhbHNlOw0KPiA+Pj4g
KyAgICBBc3BlZWRTQkNDbGFzcyAqc2MgPSBBU1BFRURfU0JDX0dFVF9DTEFTUyhzKTsNCj4gPj4+
ICsgICAgY29uc3QgQXNwZWVkT1RQTWVtT3BzICpvdHBfb3BzOw0KPiA+Pj4gKw0KPiA+Pj4gKyAg
ICBpZiAoc2MtPmhhc19vdHBtZW0gPT0gZmFsc2UpIHsNCj4gPj4+ICsgICAgICAgIHRyYWNlX2Fz
cGVlZF9zYmNfb3RwbWVtX3N0YXRlKCJkaXNhYmxlZCIpOw0KPiA+Pj4gKyAgICAgICAgcmV0dXJu
IHRydWU7DQo+ID4+PiArICAgIH0NCj4gPj4+ICsNCj4gPj4+ICsgICAgb3RwX29wcyA9IGFzcGVl
ZF9vdHBtZW1fZ2V0X29wcygmcy0+b3RwbWVtKTsNCj4gPj4+ICsNCj4gPj4+ICsgICAgaWYgKG90
cF9hZGRyIDwgT1RQX0RBVEFfRFdPUkRfQ09VTlQpIHsNCj4gPj4+ICsgICAgICAgIGlzX2RhdGEg
PSB0cnVlOw0KPiA+Pj4gKyAgICB9IGVsc2UgaWYgKG90cF9hZGRyID49IE9UUF9UT1RBTF9EV09S
RF9DT1VOVCkgew0KPiA+Pj4gKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiSW52YWxpZCBPVFAg
YWRkciAweCV4Iiwgb3RwX2FkZHIpOw0KPiA+Pj4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+
Pj4gKyAgICB9DQo+ID4+PiArICAgIG90cF9vZmZzZXQgPSBvdHBfYWRkciA8PCAyOw0KPiA+Pj4g
Kw0KPiA+Pj4gKyAgICBkYXRhID0gb3RwX29wcy0+cmVhZCgmcy0+b3RwbWVtLCBvdHBfb2Zmc2V0
LCBlcnJwKTsNCj4gPj4NCj4gPj4NCj4gPj4gd2h5IG5vdCBjYWxsIGRpcmVjdGx5IDoNCj4gPj4N
Cj4gPj4gICAgICAgcmV0ID0gYWRkcmVzc19zcGFjZV9yZWFkKCZzLT5vdHBtZW0uYXMsIGFkZHIs
DQo+ID4+IE1FTVRYQVRUUlNfVU5TUEVDSUZJRUQsDQo+ID4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAodWludDhfdCAqKSZ2YWwsIHNpemVvZih2YWwpKTsNCj4gPj4gICAgICAgaWYg
KHJldCAhPSBNRU1UWF9PSykgew0KPiA+PiAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiRmFp
bGVkIHRvIHJlYWQgZGF0YSBmcm9tIDB4JXgiLCBhZGRyKTsNCj4gPj4gICAgICAgICAgIHJldHVy
biBPVFBNRU1fRVJSX01BR0lDOw0KPiA+PiAgICAgICB9DQo+ID4+DQo+ID4+IFRoZSBvdHBfb3Bz
IGJ1c2luZXNzIGxvb2tzIHVzZWxlc3MgdG8gbWUuIFNhbWUgZm9yIHRoZSB3cml0ZSBhbmQgcHJv
Zw0KPiA+PiBoYW5kbGVycy4NCj4gPg0KPiA+IFRoZSBPVFAgbWVtb3J5IGhhcyBzb21lIHJlZ2lv
bnMgdGhhdCBhcmUgcHJvdGVjdGVkIGZyb20gZ3Vlc3QgYWNjZXNzLA0KPiA+IHNvIEkgdXNlIGEg
Y3VzdG9tIHJlYWQgZnVuY3Rpb24gdG8gaGFuZGxlIHRoYXQgYmVoYXZpb3IuDQo+IA0KPiBXaHkg
bm90IGZhaWwgdGhlIHRyYW5zYWN0aW9uIG9uIHRoZSBhZGRyZXNzX3NwYWNlIHRoZW4gPw0KPiAN
Cj4gPiBUaGUgd3JpdGUgcGF0aA0KPiA+IGFsc28gaGFzIHNvbWUgc3BlY2lhbCBoYW5kbGluZyAo
c2VlIGFzcGVlZF9vdHBtZW1fcHJvZyBpbiBwYXRjaCAxKSwNCj4gPiB3aGljaCBpcyB3aHkgSSdt
IHVzaW5nIEFzcGVlZE9UUE1lbU9wcyBmb3IgYm90aC4gSWYgeW91IGhhdmUgY29uY2VybnMNCj4g
PiBvciBjb21tZW50cyBhYm91dCB0aGlzIGltcGxlbWVudGF0aW9uLCBwbGVhc2UgbGV0IG1lIGtu
b3cuDQo+IElmIHlvdSB3YW50IHRvIGtlZXAgcm91dGluZSBwcm9ncmFtX290cG1lbV9kYXRhIGF0
IGEgbG93IGxldmVsLCB1bmRlciB0aGUNCj4gQXNwZWVkT1RQTWVtIG1vZGVsLCBpdCBjb3VsZCBi
ZSBpbXBsZW1lbnRlZCB1c2luZyB0aGUgZHJpdmUgYmFja2VuZA0KPiBkaXJlY3RseSBpbnN0ZWFk
IG9mIGRvaW5nIGFkZHJlc3Nfc3BhY2UgdHJhbnNhY3Rpb25zLg0KPiBZb3UgY291bGQgYWxzbyBt
b3ZlIGFsbCB0aGUgY29kZSBmcm9tIGFzcGVlZF9vdHBtZW1fcHJvZygpIGNvZGUgaW4NCj4gYXNw
ZWVkX3NiY19vdHBtZW1fcHJvZygpLiBBcyB5b3Ugd2lzaC4NCj4gDQo+IEkgZG9uJ3Qgc2VlIGFu
eSByZWFzb24gdG8ga2VlcCBBc3BlZWRPVFBNZW1PcHMuDQo+DQpHb3QgaXQuIEkgdGhpbmsgSSBt
aXN1bmRlcnN0b29kIGhvdyBhZGRyZXNzX3NwYWNlIHdvcmtzLiBZb3UncmUgcmVmZXJyaW5nDQp0
byBzb21ldGhpbmcgbGlrZSBwbnZfcG5vcl9vcHMsIHJpZ2h0PyBJJ2xsIHVwZGF0ZSB0aGUgY29k
ZSBhbmQgcmVtb3ZlDQpBc3BlZWRPVFBNZW1PcHMuDQoNClRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rp
b24hDQoNCg0KPiBUaGFua3MsDQo+IA0KPiBDLg0KDQpCZXN0IHJlZ2FyZHMsDQpLYW5lDQo=

