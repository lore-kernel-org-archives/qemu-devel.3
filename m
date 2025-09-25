Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B21BCAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 02:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1bmh-0004ml-Om; Wed, 24 Sep 2025 22:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v1bmf-0004mD-9M; Wed, 24 Sep 2025 22:32:37 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v1bmb-0004cj-SS; Wed, 24 Sep 2025 22:32:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LIdB4gJULuxFHH7H0tTUFN38cogA6+kb2v0WFQbKopv8spgiFeqisWPGGuHvtd5yR23O5W/2+N0P2rUf8oh+SEvRYJN1C/wEF+ivA/Fy5rx4IfBu2yVqwhUdDWzR0Swyk4a/+Vd697IVP/TW8kh+4buuPcoXJyDavRuO+GU7yv0bi3Gni7iLvQGssxad/VNJDEf2120+MRFwAMgr/wB0k68EBza+3yOhYDuBGjWIyRk9/Uv/K7TOjiIHb9Gr08LWFBLOZCmQi5JLneCMGk7s7XGIdoWH1YOoKTZjxoyKtGPNQEqmujFzhFWTIonVqp38/POUE8bZdgfme9ZgxrqMXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3XDE5YBd+2uXy6OfpVFI5r9f5CAjAmw6GQbZPIwrRc=;
 b=fjWKd2LhK6+RP6Cx4TeqhIwaZgqemBd1WO0tk+GlcV8MazdD1bjcLhLKul5cZJaZcnobNlQgozbFlv1Kl+6P4VlPLpTcfr2YPhzxHIYcLo+/ufEcaSxwfIx6lsjSW11ZUQerdaBOvTIZVaA6w/JOw30zy+9/AisQSlUnHmSzBhnKVOFkQW/I+c7mfmXqsm+IreNon/j0cMHdKo7P8aMqn+bJGKnHa4j9eftjDN3vtHjVudhNxRey8tP2NpLfGUgzfrJWnd9kJlPM+DseM/nyuzRsXfKenOxY/8UB9So7KuGcJaH6EarZhBQ6wZ8zG9sMf+dk7fYD1eaZk+yM8Z4snQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3XDE5YBd+2uXy6OfpVFI5r9f5CAjAmw6GQbZPIwrRc=;
 b=a4WgLHTCxuFJdpUotBvKwUgPMupPMMkDjUDqcbOOYVPDEH2tUC4rGxupOMMR1qqnB7Jg+DUGuycoGKgJGgBYzR9ibbGTEdW3nNbnivZ4KIpRObwrilWcoMSt9RNZtFMAfqOVTsS+i2JK/Rw+wmhL8szv5g2rprkzcg02eLWyv9xYp73DN69oiHU6Q9YihmgTN1iCyhHCeJKcLh5Ud4IMx/vwq/yE6G/MD93/Dyu+KCMy1Lc0zsNTKJlOetV9zZqChnnbLsoqv2UXx3x60L9iWnr0hfm6TfFxUlaFbaGKgD/1e0CSZSkNbUDeZxC0tXQx1Ea/nXTpsJdueKVBmhHCCQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEYPR06MB6335.apcprd06.prod.outlook.com (2603:1096:101:13c::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.20; Thu, 25 Sep 2025 02:32:18 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%3]) with mapi id 15.20.9115.018; Thu, 25 Sep 2025
 02:32:18 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [SPAM] [PATCH v1 08/21] hw/arm/ast27x0: Add SCU alias for SSP and
 ensure correct device realization order
Thread-Topic: [SPAM] [PATCH v1 08/21] hw/arm/ast27x0: Add SCU alias for SSP
 and ensure correct device realization order
Thread-Index: AQHb9sykX4ZS+8HKlE6CthFW598H6LR/1CqAgCED8pCAADYQAIABNKFggABYMgCAAQBmEA==
Date: Thu, 25 Sep 2025 02:32:18 +0000
Message-ID: <SI2PR06MB50413935D3232A7618C71605FC1FA@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
 <20250717034054.1903991-9-jamin_lin@aspeedtech.com>
 <a06379d8-ec0f-4842-87d9-5cecdb1dfd86@kaod.org>
 <SI2PR06MB5041DB54104CB51250E5E110FC1DA@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <5003d6ba-bf7e-4bdc-9c22-7360024536cf@redhat.com>
 <SI2PR06MB504175E8604D90397E631042FC1CA@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <078f252f-774b-47f8-bf94-6b1de8e70359@redhat.com>
In-Reply-To: <078f252f-774b-47f8-bf94-6b1de8e70359@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEYPR06MB6335:EE_
x-ms-office365-filtering-correlation-id: 22e1c765-c214-4cdf-a835-08ddfbdbbf59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?OHhTVkkyM2Nja2Y2VzJ5N0dvdmlzSDVvY0FNUm9jdXNaOUZUVUhTUEFxUGRC?=
 =?utf-8?B?c2FVcEZFZTJRUmZPR0lPeVEreCtuSzBkWmp1VjEyL0tkNzZEUzJwRXJEeWla?=
 =?utf-8?B?d0ZpeVVvVHZ6RnlRcE0wbGFJc1Erd3pGcUROOXlzQ2lzZHh4WHVKVVRzR0lK?=
 =?utf-8?B?NGF3V0lJT2xDTFg3NjVxdFFwMWU1TzZsUXozVUFQUWNiYmRvUkIzVkZvMlMx?=
 =?utf-8?B?TE5ickw4TEZNMzNNeEhybkczUklTbnViMjBaYVBWRXFjRDFmWnBvN1A5ZS9h?=
 =?utf-8?B?UnlLM2hUeFcxdWJ3eTRGdzhKSG9TT3FyZDlmM3hlb2VXcUhWLzVxUDRWakl3?=
 =?utf-8?B?UHpJcXA0MFppSytCdVNaM1hYYW5RMEdLRk5HR2FMdkRtd3k3ZVRXcGk3YXpi?=
 =?utf-8?B?VjEzLzhUK3dXM242V2xRN0ZkTGQ4Q0IyNGZCdTZmQ092a1hTMVlUTzJMVU1z?=
 =?utf-8?B?UWRxSUtoRXFIeTRxMjZCemdmYkFPVXBLbW1BRFA2MjFjVmphaW1xdi9JMjJW?=
 =?utf-8?B?TTJFbTR5ZnBEazdEdVFQY3dmMTNKaVVFd3BLdTlHZmdpZTJKbEVYci9UeFJO?=
 =?utf-8?B?bHk1UGNUSDYrd045Z2M4bDB4RHZWbjEyU01oRGVGZk1VbXFwYjBJVWs0Q20y?=
 =?utf-8?B?RW5UTHd3Yk5rWmZBWTduNFhOWTNiUGFZYlZ1NVJDL0ZUSm1uS3JFblNhdTN2?=
 =?utf-8?B?YzNwWGNrY3RKT0JjSWNLUS83M0JWQ3VQeXRUQURPL254NUlqTVU5aVNNcnow?=
 =?utf-8?B?UmsxaXEwaDRTYXhNWGtmTmE4QmZEWCtxNHpWcDdZaVdYOW9mUWs0MmZJWkUr?=
 =?utf-8?B?RC85ZUNma05VdDhRY0FYYWxlQWVLb0hNQjVucW05NXZlbXFaYkdFOEpuMFVk?=
 =?utf-8?B?Tmxrc0pLblVlMmtwLzNkbG8wVmdLRS9HSmZRQ0FydVJ1U1ZuMnZQbitITkdB?=
 =?utf-8?B?MDc5Z3JxOFZ0bUVQNkMzaXB1Z3ZnNUY5eTQxSnQ3ZzFudFNhZDZlcE1Fc0Rz?=
 =?utf-8?B?Uy9yNWZHazNpV2xDVXloZnAwUmtSaFNHUnZZa01NRFM5aFBlUlJ5dWwxbXY3?=
 =?utf-8?B?cng3L0JSb0lSdzlnWTV3M2Y0Y0lpa2x6RkR0NkovTFF0UXcyRnh6KzJmK1lM?=
 =?utf-8?B?UitJeld2M0M5M0piclNlOU1hakdNRG5Ub1N2b1FCeVZ3cERDK1NML3Y0dDFJ?=
 =?utf-8?B?dUxPVjc1OFlTRSt0NUhkOVpJS2UzOWV1MDhYQXU3d3VpOUpObjkwZXRkV3ZC?=
 =?utf-8?B?Q0JnWkd0QmVuNWIyQjdkaEFUYjVka3htWDkwYWxFZTluVjZUSVh3OU56dWt4?=
 =?utf-8?B?RUZWNlExZUVrNFliejA2ZU42Q2dEMkJWa3lKUko4dTlMN0VSVzIremZtcTRx?=
 =?utf-8?B?OU9sNGNnd29Ddld1dEVXRzN4YUlmOGJvL240WDgzenNSakhmWjVQY0I1eUo2?=
 =?utf-8?B?ZG1XUkZSM08vWW8wMlJkOWhFVEZuSlJOdVorNUlFS1Y4QkJkMHhjRVRLdVVJ?=
 =?utf-8?B?YXBXUkZGWWZEUVV5L0lhTm5hWVMrN3ByVHl0dEJscUU4NlBLcCtlMHhLU0lw?=
 =?utf-8?B?ZFQ1TVZCYUhiaUFFSnNuSXZjdGFHREQrWXZUYkNaVFpHQUxGQitRK2VPWmRr?=
 =?utf-8?B?OFBQQTllcktXcUtKb1Y1amdIS0x2OHhxdUxYZ0YzMkdYSk45YVczM1NCTkR1?=
 =?utf-8?B?bnZNWXRBUmFuYTlmQWZwQ0lMcHozUUFpMjVxQ3RTTWlJYUlIYzM2YlV4VEJi?=
 =?utf-8?B?NldlOVFJSVJ2RGwwSk1kOTlZQW5vQ0JCUjhxdDVBbTZML2FvaHF2Z1djemw1?=
 =?utf-8?B?aXFYNHBBUy9CQWwvb3ZTK0VEUnMwYktDRDFNdVM4ckdVQXZkb2NYT2RWNFdy?=
 =?utf-8?B?bVRXY3RFVmtYWTNWT3ZubGdzc3RTN3hCNzluVERBaytlbHN5U3BTN2lCWTli?=
 =?utf-8?B?a09UUDNLSGdXYm1oeHdCY0xSemUxM094a01BWmFjZ1duSFJHZVJiNld5VFVn?=
 =?utf-8?B?NVBFM3BNdXVKQXVLRExmRm56Ti9VNkFxSFpPWlZNTHhDTWtWY3AvdWt0elZl?=
 =?utf-8?B?UjBGanVlTXJSMXh0blRuR2FaMzdQR1RNZ2hRQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGdQRCtIdUt5ZWNFQnNNaWpKeGZvaGxmOE9UN3o3aVRyVDgvKzBHZVM2QlV2?=
 =?utf-8?B?Nk9oQ0wwOFUzY2Q2RnNpa2dkRC9LczVjbHJaWStsRlA0UVFEV0ZQZnk5NDZQ?=
 =?utf-8?B?Q0EyNms3RHRGSkJaZlVLMG1TMmdjTG8xUXBVZTAyVm9yRlBLMzluOTVTUG9o?=
 =?utf-8?B?WUQ3aXNiYkFXUy9OYllmaGd4UUI2UlVQRXZxZ2NBUnQ2UHU5Y3Axc0ZCNjY2?=
 =?utf-8?B?all2Y3p4azNGNmF2Q2VrMDd0RUgrRkFGREpxN25WS2dCTlZpeFp6NkdWcTBa?=
 =?utf-8?B?SGpKNWthSFAybjVCMG1nMFpmalRMdzB0d2Y4anlkK2JhWTl4ODlFczJseUI4?=
 =?utf-8?B?ODRFdnNxTGlrRUJUdjYvV2EzQnBQNmplYjlqaVFkOFZ2Q25WdXBrRCtvMnpL?=
 =?utf-8?B?TnJ5aVNPR0NVKy9MUEtkNUkzdWJQeHdVOHJDN2tRRFdvNmN1ZkdZZitNc3pI?=
 =?utf-8?B?NGhMUVlHMXhscXFqcDJ6RkVYWE9VNnhzTWxVT1JuOVhSbk5DQU9FRmFPN3Q4?=
 =?utf-8?B?cWtaeUNneFczbzBRMFNkREpmZExDdStGSmwvZkRRZ3NSMG54RVFrc09aKzBP?=
 =?utf-8?B?d2lPRExCL1RYWW81UnQxWkxHclRCK2c1dlQwSnlDZXZ0anU3WEVnZHYvVzJH?=
 =?utf-8?B?MWNEc2hUQmR5YjNyNzU5YlVicFhGc1RFeEphS0FFcSttWm01SlVvY0ppNFJP?=
 =?utf-8?B?dXZNd21sbFFad0dZck4wZEpWZEwzajdpZjgxZXdjV1Z4UmlkWGdzT2xzK2xH?=
 =?utf-8?B?UG5wWU0vRU9HV2FsRHpZYlF3RElKKzk0ajcyWk9zVzk4bzhOYVBBYmNwMDRw?=
 =?utf-8?B?OU92dXhOczRPSW82R3h4cWhtWmc0L2ZMWncwVHIxWkMySGlZcnZZdzAvU0lC?=
 =?utf-8?B?am1aWGswZW85S2lDOVd2OUxBMTVpYjRVZktPek8vUkUzTWxsVzNxeXhYOVlP?=
 =?utf-8?B?VVA5MGVDODBlanl5UkVLVGhNY2U5ZE52elYzQldCVyt3TEVsYmdTZ2cxRkJ5?=
 =?utf-8?B?R0E4dXdpODRtZm5abVltQU5NRklXRGQwWk9XQmpDVVJpbjhBUnk2MmlWekEr?=
 =?utf-8?B?dFlNYjg1aDBiZjFSQkRnWDJJQ01DV01WdGhVOGtaVzhlc0tvaUd4em9GNTFw?=
 =?utf-8?B?RzhCdk01Yk5LYnkrNDVhTTZVTmxtTFJQY2x6Ni9wVWZxZnJmaXMrb28yOHg5?=
 =?utf-8?B?R3pYM2g0OXY4SjQ2UnVrOS8zS2FmeXhmbm1IUUs3dVFaMFM4WUFHL1BSS2hJ?=
 =?utf-8?B?Z0lkL1lzMUNJS3BxdjBVcWtyK21nSFAvekJBaWRMVS9uLzNzaWRST1VjVk5l?=
 =?utf-8?B?dStEdDlkcHBrNElFL2ZSbWpETGpnZU04cE9zLzNTRk9ob3JlNHlwRzVwVWdu?=
 =?utf-8?B?ZDhQRjRNUWoyWm9BMytLLzBKUzNETUdlaWY5dE9RcG1yTkNBTzhHc2plQkdz?=
 =?utf-8?B?Sm8rZ1pQMkltbmlTYkg1eVJxR05WdFZ6dUVJUFV2YVlqTHhLbGc1ekhEcloy?=
 =?utf-8?B?bnA5Wmd1anFBYVRGd2cxY1R6VkJlSmxWb1hvekMwc1VMeFRPelo5b1FKUCtv?=
 =?utf-8?B?L2hIN3l0Q1h4YjhtQ0VQTmUvdTBpeUhFZzNBNmhTRjZuNTBxOERFbExvK3U4?=
 =?utf-8?B?YXR6dkdLclBRK0lpSWVBTlQ2Qzh6aFFaTTRuTDE4dU9BSCtVUUhBY2NkeUtF?=
 =?utf-8?B?T2RkTU9IQ09nWDhYRTFJNTl6M1V1SWhYTlVCNndUWDV5UGxrSEdmS1AycS9J?=
 =?utf-8?B?OUQzMFEwN1ZjL3JSdEQrUWlaT0ZFZGVpTWZSTUZsZXc1a2lDZm53SzgwaUNU?=
 =?utf-8?B?MWJzbzdJUE5UTkdGZnNGSVBRbW8ydXJXY2ZTVU9IWWRCa3JhUGE2Mndxc2FT?=
 =?utf-8?B?S2F1TlhzYXdpV2ZiMG1TNEJaYnArL1ZGa3BzQ1l4OGRvV0kxTVFvSXNhWDNZ?=
 =?utf-8?B?clhOR1VyTVBtTjErRHhRdjVrcFNGMzVWYkVVY1ZDM2RmcTNueEN0ZXBja0ww?=
 =?utf-8?B?MTgreXlsRFFPZjNVVGt4aS9VMzZveHNGT2lqMlVPZXpwZmROblFlaDNxZkJ4?=
 =?utf-8?B?YkNERHFQV3NncTBoVUZTQVNUMTZLS0c3SVVwNlQySndOTWNQK1ZPQjVuNnIv?=
 =?utf-8?Q?zOodLubDmuC/sDuTu7D9/ku4I?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e1c765-c214-4cdf-a835-08ddfbdbbf59
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 02:32:18.2729 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4K1uYd/J8r6lwNGysAsVivJpg4ZuI6hTbg8rhmnXE1wKOnWJVNN/4d6hlT8ZyrrdnyTKMLAVUecgJDvxeqKawqBNuRBh8LOuFDQvXBk7Ztk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6335
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbU1BBTV0gW1BBVENIIHYxIDA4LzIxXSBody9h
cm0vYXN0Mjd4MDogQWRkIFNDVSBhbGlhcyBmb3IgU1NQDQo+IGFuZCBlbnN1cmUgY29ycmVjdCBk
ZXZpY2UgcmVhbGl6YXRpb24gb3JkZXINCj4gDQo+IEhlbGxvIEphbWluLA0KPiANCj4gDQo+ID4+
PiAzLiBNaWdyYXRlIGFsbCBBU1BFRUQgY29wcm9jZXNzb3JzIChlLmcuIFNTUC9UU1ApIHRvIGEg
Y29tbW9uDQo+ID4+IEFzcGVlZENvcHJvY2Vzc29yU3RhdGUuDQo+ID4+DQo+ID4+IElzICdBc3Bl
ZWRDb3Byb2Nlc3NvclN0YXRlJyBhIG5ldyBtb2RlbCBzdHJ1Y3R1cmUgbWluaW1pemluZyB0aGUN
Cj4gPj4gbnVtYmVyIG9mIHN1YiBjb250cm9sbGVycyA/IGlmIHNvLCBsb29rcyBnb29kLiBDb3Vs
ZCBiZSBtZXJnZWQgZmFpcmx5IHF1aWNrbHkuDQo+ID4+DQo+ID4NCj4gPiBZZXMsIEkgYW0gcGxh
bm5pbmcgdG8gdXNlIHRoZSBuZXcgQXNwZWVkQ29wcm9jZXNzb3JTdGF0ZSBpbnN0ZWFkIG9mDQo+
IEFzcGVlZFNvQ1N0YXRlIGZvciBTU1AgYW5kIFRTUC4NCj4gPiBzdHJ1Y3QgQXNwZWVkMjd4MFNT
UFNvQ1N0YXRlIHsNCj4gPiAgICAgIEFzcGVlZFNvQ1N0YXRlIHBhcmVudDsgIC0tLS0tLS0+IENo
YW5nZSB0byBBc3BlZWRDb3Byb2Nlc3NvclN0YXRlDQo+ID4gICAgICBBc3BlZWRJTlRDU3RhdGUg
aW50Y1syXTsNCj4gPiAgICAgIFVuaW1wbGVtZW50ZWREZXZpY2VTdGF0ZSBpcGNbMl07DQo+ID4g
ICAgICBVbmltcGxlbWVudGVkRGV2aWNlU3RhdGUgc2N1aW87DQo+ID4NCj4gPiAgICAgIEFSTXY3
TVN0YXRlIGFybXY3bTsNCj4gPiB9Ow0KPiA+DQo+ID4gc3RydWN0IEFzcGVlZDI3eDBUU1BTb0NT
dGF0ZSB7DQo+ID4gICAgICBBc3BlZWRTb0NTdGF0ZSBwYXJlbnQ7ICAtLS0tLS0tPiBDaGFuZ2Ug
dG8gQXNwZWVkQ29wcm9jZXNzb3JTdGF0ZQ0KPiA+ICAgICAgQXNwZWVkSU5UQ1N0YXRlIGludGNb
Ml07DQo+ID4gICAgICBVbmltcGxlbWVudGVkRGV2aWNlU3RhdGUgaXBjWzJdOw0KPiA+ICAgICAg
VW5pbXBsZW1lbnRlZERldmljZVN0YXRlIHNjdWlvOw0KPiA+DQo+ID4gICAgICBBUk12N01TdGF0
ZSBhcm12N207DQo+ID4gfTsNCj4gPiBUaGlzIGNoYW5nZSBjb25zb2xpZGF0ZXMgU1NQIGFuZCBU
U1AgdW5kZXIgYSBjb21tb24gY29wcm9jZXNzb3IgbW9kZWwsDQo+ID4gcmVkdWNpbmcgZHVwbGlj
YXRpb24gYW5kIGFsaWduaW5nIHRoZW0gd2l0aCB0aGUgbmV3DQo+IEFzcGVlZENvcHJvY2Vzc29y
U3RhdGUgYWJzdHJhY3Rpb24uDQo+IA0KPiBBc3BlZWQyN3gwVFNQU29DU3RhdGUgYW5kIEFzcGVl
ZDI3eDBTU1BTb0NTdGF0ZSBsb29rIHNpbWlsYXIuIENvdWxkIHRoZXkNCj4gYmUgbWVyZ2VkID8N
Cj4gDQpUaGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlvbi4NCldpbGwgdHJ5IGl0Lg0KSmFtaW4NCj4g
VGhhbmtzLA0KPiANCj4gQy4NCg0K

