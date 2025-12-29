Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BA8E8FDB1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 10:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaA47-0004vJ-Ru; Mon, 29 Dec 2025 05:01:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vaA3r-0004ne-E4; Mon, 29 Dec 2025 05:01:19 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vaA3l-0003EG-8y; Mon, 29 Dec 2025 05:01:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSiKLGvlk2y+Ol9fGDoFHqowVWjIEm2Kk+oVP6KXxrj4cyFpZyE+DoCuDPhujkxMMBXIaEIVnFAITAzoWDFRJfbZdiX0Bjn5sQqR0332KojnI2aOMvYK3jZ9wUbv/4kZ4ygbQAAvQ3af9koNZZWEFFWDulYP1zTtI/uHd7HDuSSmnU9xJA0zz0EEeYfculqC8P+wSWZVAij18q7EYBaAncooxtKzXBpTKDI48IlwAY0mKssKC8UbPuqxUYN21OFkxk9wDYdwrnw+Dl/R7tnwI7Pondtsbd3CmJgS2y/eSPK55LI9ZbdA9yNIGUCAY7SgMV/6WvN5GBe2bMyEhrDhlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wgo8P2+FwtGzbOBHGWYgaox22IXyvlChz1AuQ1nd3tA=;
 b=olr0r0Pz4SfIAw4Ary5cVk74k4NwK9NfbIi0X1SrugTOD9Dmyc8iwiLHFyNCoxUBv7cEBKOWwBPBCcq3Sr/7/D9u2vkd+z0clFBV4G6mGvwGsVrWuDpGrdBa+1n37rY/V1o6JxGcSEXVp4c7Tu0UhHdcxtie/uvtqyZdCsLrMcQmVCsF5bbT03zS+v/NtCrns+TAMSkeCw8J4Ku/AS/5WHBe+x31QiOG3qikU9sPXM2xRbKYg4ghclo8mEQDouahBJ0BhuQF3dPfwyHEtY1Fau3jR4eI66nZNX96xnzwnMzU2Fb5F9pvLj/Ak9g/aUX/P7fgtPyMjtbufF6++VeFyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wgo8P2+FwtGzbOBHGWYgaox22IXyvlChz1AuQ1nd3tA=;
 b=BXbNSdC0J+XCwd3dBhLOzWohfuiE4dj0i8pc4Wotp0xppB6SNcZ2jEUjMCiZEGP8v7ccLg8l82Gn3mOE7rl31TfUVFWmq8ChGOW0FeT01QO+tM3oq02huftPjjDk9zaSyPoTYFblejUJR+Cq8JFaX0hvoWVpTM0gRKO3K0YUJEt2fqorrshi+9bBXfpxW1Lo51pMbWp/lSFy60HgaVWM2bUbIcSqpmQEG3MVhMS3UrxtqscDQewvAhPihOPArSf78ZAey4ztaBzm1MP2PrxZQosBTGuO/xzAnEw6WdzRcvcacP0Tgzol/E1cY8ZGvOlHY/NsN3ilemjTBADus20txw==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SI6PR06MB7194.apcprd06.prod.outlook.com (2603:1096:4:252::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 10:00:52 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%6]) with mapi id 15.20.9456.008; Mon, 29 Dec 2025
 10:00:52 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: RE: [PATCH v4 06/19] hw/arm/aspeed: Integrate interrupt controller
 for AST1700
Thread-Topic: [PATCH v4 06/19] hw/arm/aspeed: Integrate interrupt controller
 for AST1700
Thread-Index: AQHcdHaIPJRDnyY3FkGdWJIplrk53LUwn2CAgAKBWUCAAqkRgIACJL9w
Date: Mon, 29 Dec 2025 10:00:51 +0000
Message-ID: <SI6PR06MB76318E7A596008386B0AE51CF7BFA@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
 <20251224014203.756264-7-kane_chen@aspeedtech.com>
 <465b0714-bd08-40b5-9cf9-5cd206e8548b@kaod.org>
 <SI6PR06MB76312852C6243B1F48202A89F7B0A@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <55adfce4-0dbc-492a-b586-4c46df78007a@kaod.org>
In-Reply-To: <55adfce4-0dbc-492a-b586-4c46df78007a@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SI6PR06MB7194:EE_
x-ms-office365-filtering-correlation-id: fd3817fa-a563-47a0-d926-08de46c1265c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?aHQzdkNNaDY5YVBKWFhwL1JUMEM0ZC9PQUpDWElOU2dTY0xuY01Td3dXMVow?=
 =?utf-8?B?SW83WVZ6eEkvVEhpQXg5RlJXTEk0VWRZSjJrUHNRREFJV3YvanI2eWMwMXRx?=
 =?utf-8?B?SDBEOW9sRjBtYWVuQXRqOXo2L0svbjBlV25QZFl4ckRYYjRPbVpLUVl2dlJX?=
 =?utf-8?B?VE9ST1ZILzJ5WGtqZHAwWEc3aHU3SC8wSDVjTStSUkd1UUNhQk5lNmI4cTk2?=
 =?utf-8?B?ZFJoaXl3QXB2YTJhWWpBZW1TOFVSdllVcmluNUQreFptVlEwRWdvclVUUmta?=
 =?utf-8?B?dlM0aUdya0tWWnN5UHJVSkZDZFVaNWNxdjZ5c000N00wQjJicWQvR0pHTmZi?=
 =?utf-8?B?MFM3dkZGOW44TldtUDVCbDZ0T1NYM2J3QStrdjZ3ZzFDS1JWaG5yVnZRNVlK?=
 =?utf-8?B?Nko5TkE2eG9aKzgrQnVxZFh4K09TSDRJQjF3c09UUWwydDk2ODVnMnR2YlVu?=
 =?utf-8?B?YjMxeDhGZWRSeENtcGVFOU5mTmNCblo5bkluNHZYU0dQN0c5d3RUK3cyQkp1?=
 =?utf-8?B?Y3hYR3JkTU16WHhGaUNmS1QyMWJiOCtBMXFPejJQdmFaWHNTV1gxOHZpTVlr?=
 =?utf-8?B?eC81bmNIMnhGbjVtejNaYnpHR1VDdUdKME5OeFJRRW15M2NHMmlPM3dMV3c3?=
 =?utf-8?B?T1hqWGQraG9NUEVZM1M4M3NSVEthQ284UmxpMlJrY0tBRmdsdDdSRi9mRjU5?=
 =?utf-8?B?b1UraHZkalN3eVRuRzdTTWhQQjhVNEhKOGpxaFk1ZlJ2QkVhSFdJQ0NxcnZl?=
 =?utf-8?B?SytiTkl5UFdnVTN1dDdPdmVsQkxnL3Q5Q2UvRFFCeTVDVmUzUlhaZXR3cENP?=
 =?utf-8?B?cXoybzEwc284NW9uSW9zZDVBN2MrckJxcUdOWlBLMFhxUmhka2NMWTNjSU5r?=
 =?utf-8?B?WjNWUWRBT3Yzc3dodUwxM3UrYS9yY0wwcE9PZVc3bENwUFJPNFhqZHBwZVcz?=
 =?utf-8?B?S3J6SHFZKzdwTWgzUk8xbTBHUjdwa2J4ZTIrMFpGT2thUVo1L3pYSmZScCtP?=
 =?utf-8?B?aEJJV3BxcFdYMUV6cVlwcnNaaVFkTmZhQVIrbjhidjZGMlNVYit5ek5SNnRV?=
 =?utf-8?B?RzhRSEVFTjJ4RkNhbUpEbE1Yc1hwZlZ3YVBaS2Vhc3lvZVJWQ3RJc0tKNUwx?=
 =?utf-8?B?eGpXbG51WVhsZVBPUEFjc01ycHNvL0NqMy82cURNTXMrMjc2SEJpOXpva2ZX?=
 =?utf-8?B?Z3IvQWgxRFNGQkpHdDBDaC9BTUxTQ2dVaHN2UlBzYldkTXhiWUZHSlUyUTE3?=
 =?utf-8?B?bmlwaU1NOUVsc1JTVVFZVnJVZFRsY3J0cnExNk1VL3M5TEV1emlRcGVmUTVQ?=
 =?utf-8?B?RGFyNWswVHd1ZTI1c3lnZjYrZTlCb1FGM1lFZzR2ZjFKWkdNbUY3cVRxVzRX?=
 =?utf-8?B?dUFmeENWUkdKNVNnalMyL09ZQXpSeVZFcUhxK0JpQVZvU3J4T2FnZURRSzlj?=
 =?utf-8?B?RkMvUk9ab1Y3ZDlJbUtzVmpDTmY4QVBucnVGRnRtVnZFN2pUQjhPVzBLekJ6?=
 =?utf-8?B?dXpZSG5UaWE4RGY0MU1YN21UY3REazRhQ1dBSGlpMlF6S2l0UVA5WHN3bCtz?=
 =?utf-8?B?Y21LdDQ2ZHdqd2lCdWhEVGdHaVNrUnplM2RlR2l6RnI2NmRNVGk1Nk5jcUZn?=
 =?utf-8?B?bklFY3hXVmtYRXB5YnRMREpUNll5R0JLOGJaQVIxcmZRYnN4S3FPUnBJM0Ix?=
 =?utf-8?B?MzlGVGg5ck45djlFbFc1c2xSeWt1bUhGWFByYklGMTFoR0VPNkJ5SnJDWGFM?=
 =?utf-8?B?RllMeHJ5ZW9DYUJiUzFGQVk4S0JueGsxYTJ6ODhXQzUvaUc0MzBIMlJnajZu?=
 =?utf-8?B?ZnMyZE1GQ2JJNC9pN1grQzlnODN3ZHo3bm1GZTJDYnFlTzl3M2hiNXNqc2JS?=
 =?utf-8?B?dk9sQWdQWFdiYVE3T3Y3NGlzbklvMFVWaGZ6d0p4YXZXOWJYOGpzOXhXc0N4?=
 =?utf-8?B?R0xPbUxsd1NjSjZUR0FqUlJ5WXYyaGN6N2M5dkRQcHVHZHFOZGlSZ3IzMDBY?=
 =?utf-8?B?dVFxdU51TFFnSkY1c3ZrNmYyYjZQL1N1eXhONTVxcXp3QUE5M09ZVFo2VFRa?=
 =?utf-8?Q?ubKAY7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2NUVWJQVm00WTB3TUppRUhKUnZ4ckR2V0V5YVN0bVZBYkVlT1hEUnJJbGVv?=
 =?utf-8?B?Si9HSnJIR0pTRGR6VzRpVkFGT2hXbGhudnE5clBqVTBVVGhRenpQaEdLaHdj?=
 =?utf-8?B?SmZJMFBlamFjd3ZhbDBYMkZ1cFkxZHdReTl0YmNPcFdYY1RhVWJ6akJndDRM?=
 =?utf-8?B?WWhvRVVySDZSdGZKQ1oxK0huYUkyRWRVbmtoTDFMeHFYYTREUXlIUEZIMGhH?=
 =?utf-8?B?Y0E4NmlUZGZLeTFTT251eFMvM0J5MHczYmlGSHQ1M2ZEelVHWHZYbkVNcE5w?=
 =?utf-8?B?bkNnWCsxZzVsK2s4d1ZPbzlSc0hmQTg4NkhiUitqTlFZTS9VdWVPeEM5TFJN?=
 =?utf-8?B?SUcxNDdTejhGTmhmbDhBTmpRNlRXWE5pNW90U1RiVUJrOVo2VWNNbWNYVldY?=
 =?utf-8?B?ZTlrMFF5cWNiMDhKYUxJUTJaYkd4Y3huM0ZzOGZ4MlZmYTdQejVGTHJxaXBz?=
 =?utf-8?B?QmtSa21qRGpVbE1rQlJuZGl1Z2gwU3FQcS91YXUxVTJ4aTYrVytseE1wRXFv?=
 =?utf-8?B?RGpLb0xITlc4aFRXYVJZZ1FkR2VGai9MakQxdDhhTjhDeXpkcDlBbmNoMW5Y?=
 =?utf-8?B?QXdPN1VtNHM3SlAwdUZsSnoxSkdEMld1ZGh0a3hBRTl0NFhHK09nVUgzSyta?=
 =?utf-8?B?U295emhGb0NGTHJwdWtrSldWNm1TMExqNVNlUlNDMFpZcUpqNHpiWU40YXZy?=
 =?utf-8?B?cDI0NWwxZ2M5MGFBTU84THBvQ2l3WS9uQ2lURytnVmlRNDIwQ3B5TmJIcDlt?=
 =?utf-8?B?aVR1M0hRWThBMWZZYWw5NDRnTDViVTdIT3d0Z0ZTRUhpYUNhaVIwZEkvSXFZ?=
 =?utf-8?B?MUJrSEdjcVl4QVcrUXc1akhoMVNuSjZBTUNuQ2wwd3VPVWNEMFdaSm13STh5?=
 =?utf-8?B?bm9sbi9taHNwWklRaTJZNzZ0RG9LdW9VWUs3S2hXMXE2d0RKQnpQSUN5TlJw?=
 =?utf-8?B?WjJiRlhHV0NGeTU5RFFXYys4QjduQk0wM0tqaktJSU1rMm9YbEwwMFloS2ln?=
 =?utf-8?B?ZlhxWWNPSTJRY2VjclZsSXYzd0Jlcmp0L1VPTm9sdUt6M0F0NGNaSGZyUU5T?=
 =?utf-8?B?Y1JIeTlWMHd0NkxackZWWWo2cVZ3czV3V1RXaUNENFU4K3hLU3N3NnVBTjNh?=
 =?utf-8?B?eUk2dVB5ZmhnU1M4dTZKb213Z3hCNWx3bG9nNThoSTFaM253dDljRlphOTFP?=
 =?utf-8?B?bVpCNG93TUowQ1ZCcXFOT1ZxNnhMQytINGdoejZqUVRrV2FqYmxCekFXRkZr?=
 =?utf-8?B?V3FYSnk5bzJHN0QxT2RmRG9Qd0FTL0EyaTJxVTJtT1AwdHdGT0Y2SlZLS2ZY?=
 =?utf-8?B?ZU1NdjVBTXc0RVJ6bi93U0lkY2R2T3UzTHRvZFIrZ1VrNElFQm1FWHRocDBt?=
 =?utf-8?B?QkcrVDN1UHRoMkpPV0dWTHVkNnRaSDVWN0MzVWVoTDNmWW0rMndpVUNkMEZn?=
 =?utf-8?B?MDhJcFNKSzlZeXpUZTAzNWpET0hFUGJ4MzdGM1ZielhuemNEQ01ZKzRLT1hG?=
 =?utf-8?B?TWo0OHZTUWpYTjZnbFJ2K2k3QnFEZFJOQ3dkV2h2OXJmVjZZeUdZd2VMbXpo?=
 =?utf-8?B?dnM4WlJrL3ZGd3RjNWNBaVNONmpnMEVpOHQ3a3Jad203Z1pHT3VYa1lCbGJD?=
 =?utf-8?B?NVphSHNMWmJyaHN1ajZFTER3OHJxWHN4ZjJpcjBKRE9pbXNEaE5YdzBWQXVR?=
 =?utf-8?B?NG1nNjBPTTdJR3N1UWt6WHNOTmh3cXM1ZWo1bjE1eVhsNE9iV0tRaGp5VStW?=
 =?utf-8?B?RytHZDJFNGxVTVQ1RGJXaHZIaGRKZnJPZ0JIaHpXMkJmQkx5L3RldTdveUps?=
 =?utf-8?B?QXNoTnB0UDUrQURORkxZVXBFdE1lYWNFRWRGZzdyQUlKb0FtTFhiL1k2WFov?=
 =?utf-8?B?SStxaGNuSEhiWjc5VURsRmY4RXgweWNvTytPcFJGajNSUXUzSkpCMzk0ZHBi?=
 =?utf-8?B?RXRGTFR4d2NkVUtuQVhKQ1RiRkRIdGtrODExaVlhamlBRVhiQ2tiYVJMQ0hz?=
 =?utf-8?B?QkRCZkVkMGpFV1hrcHdJaWNYYnVUeHB2VmVCb3lqYXlrTllXTXpieStYNE45?=
 =?utf-8?B?MysySmI4M0pPUFZvTG4vZkdTSGRyY1JJVStrY3dpQ21MWDhRZUIrVHN0MGUx?=
 =?utf-8?B?cURnU3VKbnh2dEpkb2F1N1p3cG1XemZRVmtWb2RZaHBFek5uOHhKR3MxUmp5?=
 =?utf-8?B?cE83NWV4U0pTRGRNMmZFRzVGMGxobWNQbnkva2oyYUlrbnRyY3BWOEt5TnFt?=
 =?utf-8?B?WWhwbDB0Y0RMNVBNTk5aWlR5dGNaZGxqclBlRncxbnRqY2VkbWV1M1JYYmtJ?=
 =?utf-8?B?aGtoUXNXR3hZMWJhYW1Nd21mN2o2UWx3RndqUVd6SVh6M1cxTU5rQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3817fa-a563-47a0-d926-08de46c1265c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2025 10:00:51.8831 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3QO8icrMs3elS6xSwTj6n4dApvZD9NB+cUlxDEGBMxBozt02tm5h/KTZG2SShUkY8TH7/9yDXo9YtOGL2xU17Z4+ZpzkYyjjxfEOyPjWchI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7194
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=kane_chen@aspeedtech.com;
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBTdW5kYXksIERlY2VtYmVyIDI4LCAyMDI1IDE6NTEgQU0N
Cj4gVG86IEthbmUgQ2hlbiA8a2FuZV9jaGVuQGFzcGVlZHRlY2guY29tPjsgUGV0ZXIgTWF5ZGVs
bA0KPiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgU3RldmVuIExlZSA8c3RldmVuX2xlZUBh
c3BlZWR0ZWNoLmNvbT47IFRyb3kNCj4gTGVlIDxsZWV0cm95QGdtYWlsLmNvbT47IEphbWluIExp
biA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPjsgQW5kcmV3DQo+IEplZmZlcnkgPGFuZHJld0Bj
b2RlY29uc3RydWN0LmNvbS5hdT47IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+Ow0KPiBv
cGVuIGxpc3Q6QVNQRUVEIEJNQ3MgPHFlbXUtYXJtQG5vbmdudS5vcmc+OyBvcGVuIGxpc3Q6QWxs
IHBhdGNoZXMgQ0MNCj4gaGVyZSA8cWVtdS1kZXZlbEBub25nbnUub3JnPg0KPiBDYzogVHJveSBM
ZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPjsgbmFiaWhlc3RlZmFuQGdvb2dsZS5jb20NCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2NCAwNi8xOV0gaHcvYXJtL2FzcGVlZDogSW50ZWdyYXRlIGlu
dGVycnVwdCBjb250cm9sbGVyDQo+IGZvciBBU1QxNzAwDQo+IA0KPiBIZWxsbyBLYW5lLA0KPiAN
Cj4gPiBUaGFuayB5b3UgZm9yIHRoZSBzdWdnZXN0aW9uLiBTaW5jZSBJIG5lZWQgdG8gc3VibWl0
IGEgdjUgcGF0Y2ggdG8NCj4gPiBzcGxpdCB0aGUgSTJDIGNvZGUgY2hhbmdlcyBhbnl3YXksDQo+
IA0KPiBDYW4geW91IHBsZWFzZSBpbnRyb2R1Y2UgdGhlIGJ1cyBsYWJlbCBwcm9wZXJ0eSBhdCB0
aGUgZW5kIG9mIHRoZSBwYXRjaCBzZXJpZXMgPw0KPiBQbGVhc2UgY29uc2lkZXIgYWRkaW5nIGEg
ZnVuY3Rpb25hbCB0ZXN0IGFuZCB1cGRhdGluZyB0aGUgZG9jdW1lbnRhdGlvbiB0b28uDQo+IA0K
PiA+IEkgd2lsbCBoYW5kbGUgdGhlIG5hbWluZyBhZGp1c3RtZW50cyBhbmQgb3RoZXIgbWlub3Ig
Zml4ZXMgbXlzZWxmIGluDQo+ID4gdGhhdCB2ZXJzaW9uLg0KPiANCj4gVGhhbmtzLA0KPiANCj4g
Qy4NCg0KSGkgQ8OpZHJpYywNCg0KSWYgSSBtb3ZlIHRoZSBidXMgbGFiZWwgcHJvcGVydHkgdG8g
dGhlIGVuZCBvZiB0aGlzIHBhdGNoIHNlcmllcywgaXQgd2lsbCB0cmlnZ2VyDQphIHRlc3QgZmFp
bHVyZSBpbiB0aGUgY3VycmVudCBwYXRjaCBzZXJpZXMuIFRvIGF2b2lkIHRoaXMsIEkgcGxhbiB0
byBtb3ZlIHRoZSBidXMNCmxhYmVsIGNoYW5nZXMgaW50byBhIHNlcGFyYXRlIHBhdGNoIHNlcmll
cyBhbmQgc3VibWl0IGl0IGJlZm9yZSB0aGUgQVNUMTcwMA0Kc2VyaWVzLiBJIGJlbGlldmUgdGhp
cyBhcHByb2FjaCBlbnN1cmVzIGJvdGggc2VyaWVzIHBhc3MgdGhlIHRlc3RzIHByb3Blcmx5Lg0K
V2hhdCBhcmUgeW91ciB0aG91Z2h0cyBvbiB0aGlzPw0KDQpCZXN0IFJlZ2FyZHMsDQpLYW5lDQo=

