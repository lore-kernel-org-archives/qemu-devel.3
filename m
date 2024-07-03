Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B184C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 09:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOwB3-0007fV-4R; Wed, 03 Jul 2024 05:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sOwB1-0007ev-Te; Wed, 03 Jul 2024 05:21:23 -0400
Received: from mail-sgaapc01on20714.outbound.protection.outlook.com
 ([2a01:111:f400:feab::714]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sOwAz-0000iJ-W5; Wed, 03 Jul 2024 05:21:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFFZ0iazISSlvJT+UwNZJXWUUVehRXH3DMLdKqCKANORKyvGrfHxC4Cp0qNbf1SKoPoQ+Awj1GoFAegqY5HcdYQeIqjMVluwPr47bMw+xcHTnIbCTXClS1RAcCzMcZfXKUUYA2PJBKuqGO4TDCXKAkHi60G79b9bAdYUKoKtCf4RJTK8x9hYvCTmWtXr9yeNSqr+LfJxRoPJSynaKZeY+z5exQ+Cwu0g7ABoIp3j2lCDRP63PQ/J6kUTt8avLdhyeNrKFOFePhudifYDz9aoOR8uFi6jYy5dqTgCMhrlAV2uKdx0uSwd9OZkkZHFfQUD6vn+UHyHUjm4/u28pQ3mpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwqIqmjfahYEKzlHdNKNBhPkRs3TXVopFepeI2HfZg4=;
 b=bCZ0XAbhDo+QRdfckVu4/13x8gp7Mmwlco3LkjJY21GIDZSPl7g3usNtO87WoRWEa2RQY4/wzzeSXfOAFwINrj55Wls5sAx2ZQdw0sb4PfvqCX46iD1UZyb2rpc7JJNhVhJEWyaouQVV7lKXDYSOdYzKFScClPeEVahAjssAm32qvG+8WE6yme+vPX/lvxBd+5Mv83YQ8thPmZtRzGfbtN48/Ax5oIUg96UpSD/1QXzitNPuruo+84TL+Vb33Z44CVdWaoeEe+Gfa+CVLtcL60JkqkhIf5/bv7vWhTWUQMrdBoLTD8UTh6r5funSusxhmq6pWHVZFoP11VxLzRJ6Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwqIqmjfahYEKzlHdNKNBhPkRs3TXVopFepeI2HfZg4=;
 b=SuxtEbKbDJy32yzhf1vAL2dJmdmjNCIwFkFR8I5PJ78fhczjz4fZtIc/8ukyZmOq2UY1OSW7qTIarHxDWm7CGiG03gwLiJrFMzxx1hxZv19i2gDpL1xxCZGTQ3qqirLJV1WGoePLSIfD3+qxVkzutKmP6q7gCkMIa0hAtkU+Hveo93Booj27atU2wtgoBGo7EaAsfHzldudKjU6d7rxQgMOCh2D15AytGmTZOWta4mlUi/7vpNmo5+L4mMkm1sP8kHIB98v3fCy/+0mugN7MZMzc6z0IypWDJ1ZLgt4hc3/NA4FqMcv434LRh7MEwaGb/sa3a1f3CfMWyjlxqyzURw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYZPR06MB6565.apcprd06.prod.outlook.com (2603:1096:400:452::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.25; Wed, 3 Jul 2024 09:21:13 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 09:21:13 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, Kevin
 Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Wainer dos
 Santos Moschetta <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>, "open list:Block layer core"
 <qemu-block@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v2 1/5] hw/net:ftgmac100: update memory region size to
 0x200
Thread-Topic: [PATCH v2 1/5] hw/net:ftgmac100: update memory region size to
 0x200
Thread-Index: AQHazSFQd8EfejQHWk+FzNbLaZnI6rHkuBwAgAACNFA=
Date: Wed, 3 Jul 2024 09:21:13 +0000
Message-ID: <SI2PR06MB5041B6D9E15FBD345F7A48D0FCDD2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240703081623.2740862-1-jamin_lin@aspeedtech.com>
 <20240703081623.2740862-2-jamin_lin@aspeedtech.com>
 <c3ee29b3-4587-4056-a5f8-338c253cdb45@kaod.org>
In-Reply-To: <c3ee29b3-4587-4056-a5f8-338c253cdb45@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYZPR06MB6565:EE_
x-ms-office365-filtering-correlation-id: 1dc4acf9-283a-4739-ebc4-08dc9b417c1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?c25LbVd2bWc3Ym5meXZaQ1ZqMDFidUVDMjBsbkppN0E2TEtuSjQwN1Z3TGJW?=
 =?utf-8?B?dW83RzVjZ0xmTUZzU3F3czN6RmFaOUtMcktuT3RUdEJWVWlCRWk2RTNQRGp2?=
 =?utf-8?B?dUVGS3FPbmdndjU2VXE3cndwWW9KK2dxVU1RczRQSDQveHlGVDExVDVzL3h2?=
 =?utf-8?B?TktyakRqRFg2dUVsRG00VnBCSGJrUVZFVlNBZnExeGYwMXc1UmdoRnQ0aWlV?=
 =?utf-8?B?TVFnRythYXNldUMvQlNWcEFIbHBHRFlDU3FpakRUZzYzZW9xOGFTa0JMM1Vi?=
 =?utf-8?B?NkJ3N25Oa3NOVVE2NE5jellzZUp6b29BVXltVFI2NGt2K0JWWXlSNkJaQ0R2?=
 =?utf-8?B?dFJNUDZVQ25GS0ZDZUwzeWpEU05XLytvM1Z5RndVeSs2emZrS2FzdmpnSi9h?=
 =?utf-8?B?RFNLeWdEK0JGdzhwb3NrYm04N1Y0T25WZ0pJQ0tWRjNYMVBmZnJtYlR6cHp3?=
 =?utf-8?B?TXhQdjBscUtrdUJVaGVrYUc5Um1LWmVVdkI2dGN3YThBRUdxT1A3ZHdxU2I5?=
 =?utf-8?B?S0cwczhqTFVTVzUySlhrUUFmaDkxZEZuWCtjZUFTM2gxbEZjU3FpT3JTL0h3?=
 =?utf-8?B?K0dvb0JydmZZeEg5YTB0RmpOVjdKOW9yR0tMbWVOU2tCZVFLOXlXOXBXd3c0?=
 =?utf-8?B?V0c2SW8vYTViZFRJbHBDQVZQeDNybS9SWGw3M3pIQjhKSys3N0dNak1DYml4?=
 =?utf-8?B?VGVDLzhzNVFFZ0Z0MTFYc1k2ZXZUcFBWbXQrSGJwZ0o4dzMwSlN5ZFFWUk4y?=
 =?utf-8?B?d2tpVjhsWTBxUmxlMWlKTmg4bDNuYlFrU1Q0YXN1bHM1UmpBMjN1UDVzVHdI?=
 =?utf-8?B?b2NWbG9FZndPVjdBY1hzbGlrOTFQRDd2WUFRRkhwcy92OEYrVi9sdXhvQ2tu?=
 =?utf-8?B?YmdEaHpCWlB4bWpHc3MrcjZUdG1OOVRZQU1ReThkR0crUnE4RDNmb1hLcVZq?=
 =?utf-8?B?em94TlFEQmJPdS80UEN3L01jY1BQRGRLQ3l5S1h3VWg2dlVrTy9MTHZLRFV4?=
 =?utf-8?B?M29CYkdQbUJ6NFdQMVR5dm4vSnI4WmlrWi80K2E1TGF6R1pMUGdGZDIzcmNS?=
 =?utf-8?B?NFdWTGlONzhHeHZjRG10dDczdDFsRG5pc1M4TElEbW5ERmVVaFJvLzhJaWhV?=
 =?utf-8?B?OU8zN25zdGo5a09EMmwzd2lUQnNNcW4wdktuN0UwY01tNmh5ZkRicEZkSlJo?=
 =?utf-8?B?QXdQemd3QmQwd01nMDFIRU9jWEhIczJLMmZJamJCNCtMMVFTWTY0MWdqZTlu?=
 =?utf-8?B?MlphUDh1N1BOWGFnQUFYVkQrYi9tQ3lvdEwrdDg2Z2dneDJuWEk3dm5Pc2lh?=
 =?utf-8?B?cnRvQ1RMQ3AvR1J4ZzdLK0RyTEkzeCsyZlEwWTZ1VWM5cEdZeHJLR21SZi9s?=
 =?utf-8?B?WVZNZmRjYXB4UDBPQ1BJcDdqNndNUWRzZjA0akVsQ21wVUhxMXFDc1J1MzhQ?=
 =?utf-8?B?VWExY0xPa01ZNVJBeUFpWldiZHZxUUNveS9mb1BNakhNODFWNzZYa3Q5MmVN?=
 =?utf-8?B?N0p3WCtZN2VtWlpJejV5YTVOM0JsRTVKSjlZOWJnUjVtREtpSkQ1RDE4cjNZ?=
 =?utf-8?B?b0ZuOU5va0RpS1BBWHloc0I2ZU4vSmlBZVovMG9vUStIRGgreDBhNC91WGxZ?=
 =?utf-8?B?czJ6TGVvZjE4dUxwMUFQRGpQN056MW9DM08rTUljWVVqc0l2WnBXbTRaQjg0?=
 =?utf-8?B?ZzJaTHNqTTRJYmJPNThuTHVNUXhZdVUxZHBWQWNVOVlxNTRmRG1SeVhIcXBl?=
 =?utf-8?B?Z3ZNdGV3RThWcStNenlIOGUyVW85QU5FaG1rQW5mMy9SS1gyNlhoMExqQ0FP?=
 =?utf-8?B?S1Roc2FCckxvSDBKR3VVNDRhNmtlU1pyM2RiSVY5NExCdkNEaDJEWTRkd09y?=
 =?utf-8?B?NlJpN1lCdFlkVzM0d1o5MEJwRVRlTktlcGhUTVZoVEl1QjViZU5MNjNOY0ZZ?=
 =?utf-8?Q?tulTcW6Zbag=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RC9nREY3UmY2bkJRU0VxZ2hoOU9Qd21kWWJMSDZhSzdia2ZBeVZNVXJqR29B?=
 =?utf-8?B?L2ZaLzBQaFpLT3BJcW53UUhQT0dLMnN2T0tMbzdWdzVnTkhTUHpNM3Z0bnB3?=
 =?utf-8?B?MnhFODV5TkVFWm1RK1BsSjJtMjBsRmFMVXgwbnR2dm9xQnBxNFBtTWdEN05Q?=
 =?utf-8?B?bEdKdHNJYnRaWUpGdTVvaHZOTy9Ma0MzeklJVTRwQTdiQ3dwNzd3eXZJSXJY?=
 =?utf-8?B?WVd0RXBLcEJyejVTeHp5WERBdy9icmRaVm1mUGEzbnR1bjNueFdsWmtTY3gx?=
 =?utf-8?B?cHNIb3djb1JYWGduRHE0Umw5VWZwM0RVU0xOTzc4RU5Ec21acEczY0ZqeU9G?=
 =?utf-8?B?RUpWTzRPSWpOWGQvNnpRQkthcW95T3dGME9Pd3NhY1NwQ1IrOXRFbktNVVVz?=
 =?utf-8?B?ckJtVDFuZU9HSkp1a2FDZi9pbW1pakN0UVhFS3V5dXJ6ODNkSmxqNTBrZm5o?=
 =?utf-8?B?Um9qUGtnVmlIbFczWjRjZjNUS3U5cGNXUTBPcXBnS21QN3c0b0ZkTzdIWjJ5?=
 =?utf-8?B?Y2RUQzlKR2FwK29mUzJBekRic1NlTGlCNXptWHBoeUhUOHlwRzROaTY1YW5y?=
 =?utf-8?B?eXJpcHdIMDFrbmlicjhNQnRWNDIwYWFBb2d6OHk0dmRBQXRTMjI3YVZsZWls?=
 =?utf-8?B?bTJYTHV4c1F3TkI0MFZQRGlzMTRDditESUlxeFhsMXl2aEUxS1h3UDJzcnNr?=
 =?utf-8?B?ZjNnKzBIWXZMejRsQ3dSK09hNDhsUmpmQ2w4T3ZxdUhWN25URHhSeERIZ3Jn?=
 =?utf-8?B?N0JLZ2MxWXpUQm9nYi9SaGhnb0Juam5SL1pRQmxqdlp4SmNJSlZFMG9SNFBj?=
 =?utf-8?B?WVpQN1YrekNaRmVZNnR1aUpGbjlNRG5yTWNpWUlrRGNPNnV3VkU4bk9IYmNq?=
 =?utf-8?B?MXQyeUNaWU1TelA1M2xQOVZldE1nNis2UXV3R25EQktDbm10NjdhZUpIYU0r?=
 =?utf-8?B?UzkvZHh3RzU5clI2ODdJeGxHMEpMaklDQ0dwV0JHQXM1c1gwK1NjbnZMYkgr?=
 =?utf-8?B?TUZOZjI3K3M0ZEVmTmV1bHlEbDJ0SzRGcGZlQzdwak9TR1M0NFZtMmtma3NM?=
 =?utf-8?B?WUhsMXpjM3F0R0RzZ2EzRHZKbG1kSjlzU2VLbkt1Q0xWOEhRWVFrMFlWSTQv?=
 =?utf-8?B?NWk2OUlYeFlUYmNjUnJ5TXYxZDRxQlN2YnpmM2tUZmNWdlAyQllOT0xxdDcw?=
 =?utf-8?B?Mmhkc3dkMmhsUVZsVEZ0MVhPV25uMHJtYVY2V3JybXo5MHFNM1hZb0hZTjhx?=
 =?utf-8?B?VGFUcGRTS0NIUzF2VW1nVDFETkl1VnR4alFXbjZyRHppS1BaZUlLaHVWbjUw?=
 =?utf-8?B?ZHFacjYyZ0UzNlZ0TzdZeGpGcFlVd0dPbnFmZW1rZXlJdnA5MkJSNzJMZitK?=
 =?utf-8?B?bTVoRC9zSmdGVEI1U3phME1FNURtSE81amtYR3ZJYzM2UHJvTVFBWEtVdm5O?=
 =?utf-8?B?RzM1RlpUUVdMdzN4YXJpSTVGN3dudXd5bFdqMFhzeGxuUlludWRSSVJmbFBG?=
 =?utf-8?B?RjlEWUZGTnlsKzZOL3FCczZvTHZSUkl4Z1liWDdkN3hVUjdKQkxZODdST0ND?=
 =?utf-8?B?R0RnOW1xVVpQb3Q1UmtmdU9IQ01FcUdyREdmWFdRTnpRd1I0VWVTV24xcU9i?=
 =?utf-8?B?d0dxWTZQdWdEdHFlY1RBcVRsR2FNU0w5aEljdis4RXhiaEpaT3gyR1J4SGh6?=
 =?utf-8?B?RlBOeTZUY0RiVk1zRklVdWNmRmdsN2NwVngwdkw3aGY4WlRoNG9wYTUvQ1kw?=
 =?utf-8?B?QUJIbFZvUU95dnZhZDNUQ09sNXJQNXZtUk1pR1Z2TGJJQnAwdlRtVTFzSitC?=
 =?utf-8?B?KzFKd1Vqb1NEb3FjazV1clk1QjE2dGtiMmVFWE9xWWxjTzQrWHpCdTFTZzVj?=
 =?utf-8?B?Y3J5MWhUbXpoY1h5emIyVDVCNmgwUGNRaHFSVElkSE5wSWpEL29jb3Z2K0Zq?=
 =?utf-8?B?SWxGY0tNRUlkN0puSzM4UktIL3JCOGlKR2JlWUtCWk5zWnNQTnk0OEM2WmxR?=
 =?utf-8?B?bUxKN1BiWmlHOGgwbGdTL3JXL3c3L1hmM3R3VkplcE1hcmMyNU1aN3lEZ0Er?=
 =?utf-8?B?UDhLSkQrNmsrVXFWNFRueFkyTUhwZ1doZENTQmFqbTlHMTgxemFGMTQxbVAr?=
 =?utf-8?Q?JVmwd7nb/M1zGgMe6VVIxx21/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc4acf9-283a-4739-ebc4-08dc9b417c1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 09:21:13.6918 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iPBdWciZtX2PynObBaxVF/5zmJVoie5ac+db5XxUMvW9f4gqNejGfMqgVhX2/l6zrIGlvJGC6aNkcKw4WZpKcjIYi1tt40F7gy73eTAx3JI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6565
Received-SPF: pass client-ip=2a01:111:f400:feab::714;
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS81XSBody9uZXQ6ZnRnbWFj
MTAwOiB1cGRhdGUgbWVtb3J5IHJlZ2lvbiBzaXplIHRvDQo+IDB4MjAwDQo+IA0KPiBPbiA3LzMv
MjQgMTA6MTYgQU0sIEphbWluIExpbiB3cm90ZToNCj4gPiBBY2NvcmRpbmcgdG8gdGhlIGRhdGFz
aGVldCBvZiBBU1BFRUQgU09Dcywgb25lIE1BQyBjb250cm9sbGVyIG93bnMNCj4gPiAxMjhLQiBv
ZiByZWdpc3RlciBzcGFjZSBmb3IgQVNUMjUwMC4NCj4gPg0KPiA+IEhvd2V2ZXIsIG9uZSBNQUMg
Y29udHJvbGxlciBvbmx5IG93bnMgNjRLQiBvZiByZWdpc3RlciBzcGFjZSBmb3INCj4gPiBBU1Qy
NjAwIGFuZCBBU1QyNzAwLg0KPiA+DQo+ID4gSXQgc2V0IHRoZSBtZW1vcnkgcmVnaW9uIHNpemUg
MTI4S0IgYW5kIGl0IG9jY3VwaWVkIGFub3RoZXINCj4gPiBjb250cm9sbGVycyBBZGRyZXNzIFNw
YWNlcy4NCj4gPg0KPiA+IEN1cnJlbnRseSwgdGhlIGZ0Z21hYzEwMCBtb2RlbCB1c2UgMHgxMDAg
cmVnaXN0ZXIgc3BhY2UuDQo+ID4gVG8gc3VwcG9ydCBETUEgNjQgYml0cyBkcmFtIGFkZHJlc3Mg
YW5kIG5ldyBmdXR1cmUNCj4gPiBtb2RlKGZ0Z21hYzEwMF9oaWdoKSB3aGljaCBoYXZlICJOb3Jt
YWwgUHJpb3JpdHkgVHJhbnNtaXQgUmluZyBCYXNlDQo+ID4gQWRkcmVzcyBSZWdpc3RlciBIaWdo
KDB4MTdDKSIsICJIaWdoIFByaW9yaXR5IFRyYW5zbWl0IFJpbmcgQmFzZQ0KPiA+IEFkZHJlc3Mg
UmVnaXN0ZXIgSGlnaCgweDE4NCkiIGFuZCAiUmVjZWl2ZSBSaW5nIEJhc2UgQWRkcmVzcyBSZWdp
c3Rlcg0KPiA+IEhpZ2goMHgxOEMpIiB0byBzYXZlIHRoZSBoaWdoIHBhcnQgcGh5c2ljYWwgYWRk
cmVzcyBvZiBkZXNjcmlwdG9yIG1hbmFnZXIuDQo+ID4NCj4gPiBVcGRhdGUgbWVtb3J5IHJlZ2lv
biBzaXplIHRvIDB4MjAwLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxqYW1p
bl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gICBody9uZXQvZnRnbWFjMTAwLmMg
ICAgICAgICB8IDIgKy0NCj4gPiAgIGluY2x1ZGUvaHcvbmV0L2Z0Z21hYzEwMC5oIHwgMiArKw0K
PiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9ody9uZXQvZnRnbWFjMTAwLmMgYi9ody9uZXQvZnRnbWFjMTAw
LmMgaW5kZXgNCj4gPiAyNWU0YzBjZDViLi40ZTg4NDMwYjJmIDEwMDY0NA0KPiA+IC0tLSBhL2h3
L25ldC9mdGdtYWMxMDAuYw0KPiA+ICsrKyBiL2h3L25ldC9mdGdtYWMxMDAuYw0KPiA+IEBAIC0x
MTA4LDcgKzExMDgsNyBAQCBzdGF0aWMgdm9pZCBmdGdtYWMxMDBfcmVhbGl6ZShEZXZpY2VTdGF0
ZSAqZGV2LA0KPiBFcnJvciAqKmVycnApDQo+ID4gICAgICAgfQ0KPiA+DQo+ID4gICAgICAgbWVt
b3J5X3JlZ2lvbl9pbml0X2lvKCZzLT5pb21lbSwgT0JKRUNUKGRldiksICZmdGdtYWMxMDBfb3Bz
LA0KPiBzLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgIFRZUEVfRlRHTUFDMTAwLCAw
eDIwMDApOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIFRZUEVfRlRHTUFDMTAwLA0K
PiBGVEdNQUMxMDBfTlJfUkVHUyk7DQo+ID4gICAgICAgc3lzYnVzX2luaXRfbW1pbyhzYmQsICZz
LT5pb21lbSk7DQo+ID4gICAgICAgc3lzYnVzX2luaXRfaXJxKHNiZCwgJnMtPmlycSk7DQo+ID4g
ICAgICAgcWVtdV9tYWNhZGRyX2RlZmF1bHRfaWZfdW5zZXQoJnMtPmNvbmYubWFjYWRkcik7DQo+
ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvbmV0L2Z0Z21hYzEwMC5oIGIvaW5jbHVkZS9ody9u
ZXQvZnRnbWFjMTAwLmgNCj4gPiBpbmRleCA3NjVkMTUzOGE0Li41YTk3MDY3NmRhIDEwMDY0NA0K
PiA+IC0tLSBhL2luY2x1ZGUvaHcvbmV0L2Z0Z21hYzEwMC5oDQo+ID4gKysrIGIvaW5jbHVkZS9o
dy9uZXQvZnRnbWFjMTAwLmgNCj4gPiBAQCAtMTQsNiArMTQsOCBAQA0KPiA+ICAgI2RlZmluZSBU
WVBFX0ZUR01BQzEwMCAiZnRnbWFjMTAwIg0KPiA+ICAgT0JKRUNUX0RFQ0xBUkVfU0lNUExFX1RZ
UEUoRlRHTUFDMTAwU3RhdGUsIEZUR01BQzEwMCkNCj4gPg0KPiA+ICsjZGVmaW5lIEZUR01BQzEw
MF9OUl9SRUdTICAgMHgyMDANCj4gDQo+IFNpbmNlIHRoaXMgdmFsdWUgd2lsbCBzaXplIGEgbWVt
b3J5IHJlZ2lvbiwgSSB0aGluayB0aGUgZGVmaW5lIG5hbWUgc2hvdWxkIGJlDQo+IGNoYW5nZWQg
dG8gRlRHTUFDMTAwX3tNRU0sUkVHSU9OLE1NSU99X1NJWkUuIFdoYXQgZXZlciB5b3UgcHJlZmVy
Lg0KPiANCg0KV2lsbCBmaXgNClRoYW5rcy1KYW1pbg0KPiANCj4gVGhhbmtzLA0KPiANCj4gQy4N
Cj4gDQo+IA0KPiANCj4gPiArDQo+ID4gICAjaW5jbHVkZSAiaHcvc3lzYnVzLmgiDQo+ID4gICAj
aW5jbHVkZSAibmV0L25ldC5oIg0KPiA+DQoNCg==

