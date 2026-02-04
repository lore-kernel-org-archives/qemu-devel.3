Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193D3E83EE3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 07:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnX9Z-0006iQ-Mu; Wed, 04 Feb 2026 02:18:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZD-0004Zf-5M; Wed, 04 Feb 2026 01:40:47 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vnWZ6-0004HE-Ic; Wed, 04 Feb 2026 01:40:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQ5n3tDkvE27WWp8vvciJOSYTF4txTvXsTB5EsfBhaxhzckW7aiw9THgKb2+alieE5Xf9Mp3q9iJ78I6DgeaCUu+f8iDzM7/1g4rxwzYlYIg6XheKgp0IPsj6PkijrZUfGKlJ7s3Cc5LR/iCzTWFXgIk3pIuZ2U51P2xalUN+iP3n6HiXsG4NVVH0+lUuj4W+rZj9V5xQgLN61TRzXEL/hU3VzNgtGKMdNrqRB8j6SyECP7mchCZhcz1X4ILLMSO4A/djPTCtK4p/D6IW63EsZY6gQjTAKyOypRWXlwpwQnMG9uoVh+MR3w7M1/Q57J/DvnmJk7v6EA+HDHsIQdBjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvtFG5J7Q+rK5rue84jD8GZkSjLOPBMKgGdM13qiXws=;
 b=bUgDx17a4KvoZfFdNd/YD/KrRl410RhbtS74jR18wtdnDvgtN5lM83Yd2goi7GaZ/n7aXy4r42ffUJfQjjuI2gf6jBRp04oZlpraCamzYXyYo2YmjTPPuh8gE9MBcWXIbj5rHOkrEVwEIhc+cEINrcNAO3+Xu8rsAEijqR6qcxVtG2NRVUNbTuBu0Wv6UkMcPD7x3OJFKSp4XPK49x0wcm21oeA64E+qEwrJKAo1SA99It3ePhhjvTmWJWL1zMzIqyZRnm94sKzaaLRileJyKxmwoRIKlhMcoliVBRK73EDh+k3uCq/kSDjq+6CSYKxqFinzJAS5EOe03wZl7WW5Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvtFG5J7Q+rK5rue84jD8GZkSjLOPBMKgGdM13qiXws=;
 b=m+lHnyapW1wLkfDhtaOJbzHG3OIKkEDQX8HcDGCzw7hQt3Fb24aEoRKh8TCn/niSvAerSZQaJQoNo0DTKhWOShyt7rSQRhMlwpa+W/p9gBSVFi1CaKwg6pxAzEzaiA2mOvINSCYDICFeSBAns2CmXa96xJVeufiUK5zHR7qtj4Kvv5ihaJRFyIRk0UdeI9+4KrziZQa82Gph0+CO8jsQ+evRGFGkv2B1I1SQiQ+GL9Dsl6JMFB+QqCBXJ2DLQIrnuEpEU1mL/OeYdMAIonweWAkmDplPuHI0Eq/q0zJfUOIaHsdSUIe6PoHfnrks0ib6cnYWQlOsTr8ktSHGaQuQsw==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TY2PPFD3DE53D05.apcprd06.prod.outlook.com (2603:1096:408::7ad) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Wed, 4 Feb
 2026 06:40:22 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 06:40:21 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Nabih Estefan
 <nabihestefan@google.com>
Subject: [PATCH v6 02/22] hw/arm/aspeed: Attach LTPI controller to AST27X0
 platform
Thread-Topic: [PATCH v6 02/22] hw/arm/aspeed: Attach LTPI controller to
 AST27X0 platform
Thread-Index: AQHclaEh1HtC8DQH5kinlaF+YQnQcw==
Date: Wed, 4 Feb 2026 06:40:20 +0000
Message-ID: <20260204064016.3515639-3-kane_chen@aspeedtech.com>
References: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260204064016.3515639-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TY2PPFD3DE53D05:EE_
x-ms-office365-filtering-correlation-id: c6a4ad4e-b4cc-422c-7f8c-08de63b8451f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?WDhNSUlvRGFxODZxWjBKdEM1c3FseEwzY1BaaW0wYS9hcmpVdk9ua3RvRndw?=
 =?utf-8?B?OSszaWpTWTA2bFJEbE1Qd21KUnpvRFJSMmd4MGRmVUJJbzFwTFhZQUtQZUQw?=
 =?utf-8?B?WllvaXEwa2JqRGtURGJkQlo1Ry9KR09GNUIySHpJeTM5OFIvSHRLNmFXWG0y?=
 =?utf-8?B?WnZPMC95K250NldWWG1uNHdHb00rRURoQUsyT2RHMmhtOFUwOEN6Q3N6eEJN?=
 =?utf-8?B?WVQ4OUR3dVlJdkdzc1Q5NXVJK1JncWN4TG1rZVZ0ZVVpaEZUaUNGQk9jbEFo?=
 =?utf-8?B?TFpONjgzRmkxRjlXZ3M5L2YrUHg0T2srYyt0ZzdwNlVzOGJTTjFGYW9abWc5?=
 =?utf-8?B?UDFHU0Vmdm5PRzI4VG5IbHVwRU05RnZVZlplbnNzL3NEWUZzclJDQkFpUFk2?=
 =?utf-8?B?eDFOUk8yWEQrTUNCNTI4QVJqNFN4aDNsVXVKd1RxUFgwZUYrUjgwSWtqdE1V?=
 =?utf-8?B?M0NZdHhvSEc3UWxSRzlHTjFjN0FtZ244UXozcWdHOGhFV0F0OWIyT2lGYTNs?=
 =?utf-8?B?Ny9HdlBJeXNkYWsvSG4xNnl0dkFkUWNTbnYzK2hwNCtSRHhQUXUwbENsQ1d5?=
 =?utf-8?B?UkdwOFJVcWZ6TGxYWURNUndVVSs1S29JTFJRbVJiZmNHcGlXbHgxaURFbTFy?=
 =?utf-8?B?Sk9scFp2VXFiQy9UU0VmblR3SFAyMk52V0xVUGQ4YkRGQnY0Y3NEOUtRbmtN?=
 =?utf-8?B?RG1Yam9DbW5oTkV2U1Zidng4OWtmVHVNcjVFUEZ1QzlxV1ZjVjY5NmV0QjE4?=
 =?utf-8?B?czFocEVPNXhVQ3NoUEV2RlJsaDJjVTlteHB2M3MwaDRrUWFNVENLckFua1lr?=
 =?utf-8?B?UEdUWkhTRGZCMUV2R1RRdGhlSFdYaTV6UHozM245aUt2aUsxUkhVUml3U2F5?=
 =?utf-8?B?MWdaYS9GYlJLUUphYnYyNXh6bkx0M0FUY3ZlMHZYbi90eUl4RWdzbnNCK2tY?=
 =?utf-8?B?eGxwdVVRQklKNmc0QklDRHRzUXQ2VHhaM1l0WnYxOThDemk0VDB3MFJEZG8w?=
 =?utf-8?B?L2luZ1JPWEpIazFvd3A2TENtWkJJMitCbHMrbnZmVkJoZjZxTWpOYWdwTFZO?=
 =?utf-8?B?cGszOU5VaE9LZTJ6cHFDVVpuNnFMb21rUEJ2dHI2MjRzVWdHak9wVXByMXNl?=
 =?utf-8?B?aFVsZ2x4eVBBUEw5WWVlU0JmRm96Ny9UeUNmajd6aEcvSFdpVmZyZGd5WnMx?=
 =?utf-8?B?S2dBVDIrYVVGWTFKWDNmTGhOUk9kT1lGN2FXOTB4eTZweEF0MWxtMEdPWXIw?=
 =?utf-8?B?d3VjQW44bUU3WFFQMmZ3cDZZNEVrbVdzaVdsVWxLTmcrLzVlSHVWK2J2dktq?=
 =?utf-8?B?QlBBZWlvZmdEclhZaUpzMWtGSEMzb1VVdmlHck4rbHVpWEpJamdOOVZFeCtw?=
 =?utf-8?B?RXpLQWYvcTREQ3BoRHI2a0RvRDFDSFhaRkluWTRJVkxVRmY4N3Jab0ZwcTQ3?=
 =?utf-8?B?dlEwaXozRW5NT05Jb0g0cjZEWHBnbVBpajZLR0ZZUXpQQnk2Q1hGdlI1RG82?=
 =?utf-8?B?VWxqbEdBbEUyNG1FcUVBK01IbFhQQVlkVFZEcUpCenJ5T2grZjVaNkh5dUMr?=
 =?utf-8?B?RWE4ZnhHSEptMElocmNJcm53UXNTS1UxRGJ6ZnlMdXFKbjR5RlRFdnByaW1B?=
 =?utf-8?B?cXhudmJFcGNyNFowTWNmaHhYejVDdXZ2THJ4YWpBb3JpRHdpSmNDc0VmMnFj?=
 =?utf-8?B?Z3puV0c4QmRkUjZRNHJnRVRGbTI5WitvMTkzRGNMRkpTencvbVRkNURTYTdK?=
 =?utf-8?B?RXhtV2tBMzgvL3lUVXdYbldFay80VWt3VThmcnlPNVRFZDhMY3ZHOWlhaGRy?=
 =?utf-8?B?RmJRVUljOXNzNGFWZkxWSk1aNmpROW1kVXFXYTZlSlhoeGZYSWdaMTYxTkM4?=
 =?utf-8?B?SkFtSjB5RFB2MmdsdTVyVDRUN3ZUTkRLWnhvOEdQcUFKbHVOendUSUdGa3hn?=
 =?utf-8?B?Nkk2NVQ2T0RGUTdoeDVFZzJndk9xdllQaVBaYi9BeWtiaEtoUzBxRlhzNTFm?=
 =?utf-8?B?K2lTS05peDc2UWx3QWhGMUxrem11cUREdWtXa0RBZjRRc05NVW1nOXJnWkk2?=
 =?utf-8?B?NFlXRERDejVKYXEvMTRYN25BaXVBOERBR0o2aUZFZTJ3S0ZZa3RlaTJtZXlD?=
 =?utf-8?B?SmNma1RtSkIyVk83TjhsYmtob3hTTzgvclFoMjBKSzdZL3h3bm1xSFNreFRN?=
 =?utf-8?Q?XWVfADtfrDj1Vl8OI9AjRAM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1Q0OVZ4azhyejZwVmpDTUwvT0h4eEJlSzZUQ0I4dDBYTXdZcUZCTHVhYkJ2?=
 =?utf-8?B?Ny83bGRZMjFaNnh1bEVkb29mcHFHZjdyNWNmY2c3TmlPNDJFSFlXNzNWN0hQ?=
 =?utf-8?B?ZW1ueEIrcWY0K3F6V0piS2JDMjZsdEVzSUdQMWpLVDZuTUFCSnZ2T1BkR2VS?=
 =?utf-8?B?NlZES016YkRJck8xYkdzNWh5RnU3dXNWb0QzTGxEeS9HSzQxWUtKaGRwQVhG?=
 =?utf-8?B?RmZiK0tweTliUHdXQ1UrVjR5N25RWkpiQndHUVBBRkZoOTJ0ZE1PTk1TRnpS?=
 =?utf-8?B?VnIxSXdTYStiSkVDTXdrY1BWN25mRGtpeDRxdFZyaVZwS2FRczlHa08xeUp5?=
 =?utf-8?B?d252Z2x5UWMrelIveW1mUGk0VDJBYTBRNTVqTG8rQWVqS3BOS0I2WDM1TUd6?=
 =?utf-8?B?VlZockxsNndFZFl4TkZPRmJBOVpYOGpMOG5HN0grTkxwWVZ6OG04TG9UZ04z?=
 =?utf-8?B?NHZ3UXBWUUwyekRuSzI5aytXdWl4Y0xTR3h0NEtMcVd6SG9HQllkOXJpSjVm?=
 =?utf-8?B?MnBObzdFKzlmaHlUK3JHR0txeEVKSm9XNisyS0MwbllOVC9tRThLcFkvZlQr?=
 =?utf-8?B?MTRlOGVMNWE4cEZ3RlVmS3hEZHBpSXZnbEkwc3JGTkJrdktmUDE1T3dBNk9Y?=
 =?utf-8?B?MjV6K3V5dUgxOURXNEowa3djS3lncm5vOStUY2FUdkJmYm5IVm42UVRmNU9P?=
 =?utf-8?B?eEp5bW43bTFwNWdVZGNaL1VpbFFxMkc3RWlHbzhwQWl0emwydGltRUdkdlR1?=
 =?utf-8?B?UmhlcDNGbjdudFBsRytuV3lPbEN0RUVZRFBvTFlDMUJ5U0VVWXY5YzlyTVNG?=
 =?utf-8?B?STFuV2o2Y1YxVXZZWGZBSkRidy9STUxzU0wzVVl2ZmpiTXpjamVoTUxpajhi?=
 =?utf-8?B?MzVtdzhTTGNMUVVITjRVUmNlQ0xIQkhyOU0zTmx0SjlZMmkyUU94SjFFcGJk?=
 =?utf-8?B?VzBnNTVOMGo3YWN0R1k2RjVEbUdMb0lwZGhUNnFZRXhPQ0xuQVduUGRqZzdN?=
 =?utf-8?B?bzI1TndsT2N5a3JWUlVtb0QrbnVFbEhGQUtSdkRBOGxuazIzWlNZUnNNMzlN?=
 =?utf-8?B?UTk3ejF3VWlOMUI2Z1pRdVpwaEx4K01maHFNUExucEhsR1FVWldEZXBmc01v?=
 =?utf-8?B?aXU3WE9neWpqWHNkMlo3UkF5MHRtS0IvVC9NTXhWNjR4TTFxbzVZUkswRHJo?=
 =?utf-8?B?dXZYU2hRUjlRV2JjRXlZeUlGcFhjTUd3TnNGcXhyRTNFNm9IRTR6MGliTlRp?=
 =?utf-8?B?V3lXNUlCYkNNK3VOdThPOFRtbXRBcnZlbVpLQzdjQ0xLVHExbnZQOTFYVUNP?=
 =?utf-8?B?YnZ5WkxHbEswdG8vek9leVE4ZlBEUVJtOElEVXFUUm9YMnZFSHgza3Y0M3Vs?=
 =?utf-8?B?WHJ5YU56akVwaWR6YlB6SDBMWGZMVkxSWVdRQnYwWUxyY2dKcVdXK1VjQWtn?=
 =?utf-8?B?bERDYTQzVTRxVXVBTW9CL2xsbW9JUnN4THFnbU9TM1NwZHdEUC8xSm0vQmY0?=
 =?utf-8?B?MHdscnQ0V09KSG1vc2NRZnZxY0hHVjZIWDNQbDhBUFpuQXFOT21mZ1V2U1Mw?=
 =?utf-8?B?cFVyS1MzYjE0MEdPbkJHMGc2cG9FZTFjRldsMy9oWnUxVjg4a3BqRUZpSm5D?=
 =?utf-8?B?QjRiYTRHOEtEUktPdnNEMXpvdm9iNmsrNzBlcGJianhqYmVqMEh2eTdOamYx?=
 =?utf-8?B?SGxtSWFkWHJUMUZ3Sm1qVHk4U3NxRVA2TUlTcFVhbUNxNjVHbzZxdDFMdmcx?=
 =?utf-8?B?bnlJcHZXc1M0aHZ2aU05b3p0S1RDMkM5TVVadHVpb3NoSnJOcS9La0pVUmM0?=
 =?utf-8?B?NHIxS2hsOWs3VzBNN3Vyemt1RG04MFNtWWxGeldwQmJtMlFuVUZLSVBwS1po?=
 =?utf-8?B?S05rWkxKYjE5K3h4Z0JVRjYyOHZnM29uZDI3SEUvTkdhTXF3d1g0SUk5U05h?=
 =?utf-8?B?MTIvMWU3dEJRL2pxKzdmazZLdnlvUHdTSm8weTN1Q3dlQXRySUkrYk5vQkNr?=
 =?utf-8?B?dmlVeG9Jd1dwMTN0TUxXQnVEWkNTZHVPQ0pJdC83ZUNwS2IxellyMzI4S0ln?=
 =?utf-8?B?c0NyVDltMFFhTEI0MlpJd0czYmd5Mkl5QitOZ1FHVWJscEsyemlFMDg2Rk9X?=
 =?utf-8?B?ZzlQRmlOejhVR3NTUUVXUy9haUxPU282RFlTOEhaNkdaU1U4RTU0elpDcUxn?=
 =?utf-8?B?c1dCTGZZWlZOOEJZWDlyOG9JMHM0WklHK2ZLUEZScXJ3WWNKZnQyTXhLQy83?=
 =?utf-8?B?aXozS1lFcmxVL3dUUW8vUVBaeUxOeHJhY21oTG96RTQ5UzB5dm9yS0tHVmxJ?=
 =?utf-8?B?bkN5cU5jbStXY0g3REVCYUlLZkhBeFFqYmtVaXZnNDRleXMwcDFjdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a4ad4e-b4cc-422c-7f8c-08de63b8451f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 06:40:20.4180 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kb+mSKCY22leo1PcYFwUvqMmggDqltcA4dPYWjiGULurMYw15URMOryWVxXKYK9KmOBI0WHBag6a8PBAxiWT0DLXnJ8dGhTCa0zgLRm9AZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPFD3DE53D05
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
X-Mailman-Approved-At: Wed, 04 Feb 2026 02:17:18 -0500
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

Q29ubmVjdCB0aGUgTFRQSSBjb250cm9sbGVyIGRldmljZSAocmVwcmVzZW50aW5nIHRoZSBBU1Qx
NzAwIEkvTwpleHBhbmRlcikgdG8gdGhlIEFTVDI3WDAgU29DIG1vZGVsLiBUaGlzIHBhdGNoIHNl
dHMgdXAgdGhlIG1lbW9yeQptYXBwaW5nIGFuZCBkZXZpY2UgcmVnaXN0cmF0aW9uIGFjY29yZGlu
ZyB0byB0aGUgQVNUMjcwMCBTb0MgZGVzaWduLAp3aGVyZSB0aGUgTFRQSSBjb250cm9sbGVyIGlz
IGV4cG9zZWQgYXQgZml4ZWQgTU1JTyByZWdpb25zLgoKVGhpcyBjaGFuZ2Ugb25seSBoYW5kbGVz
IGRldmljZSBpbnN0YW50aWF0aW9uIGFuZCBpbnRlZ3JhdGlvbiwKd2l0aG91dCBpbXBsZW1lbnRp
bmcgdGhlIGNvbnRyb2xsZXIncyBpbnRlcm5hbCBsb2dpYy4KClNpZ25lZC1vZmYtYnk6IEthbmUt
Q2hlbi1BUyA8a2FuZV9jaGVuQGFzcGVlZHRlY2guY29tPgpSZXZpZXdlZC1ieTogQ++/vWRyaWMg
TGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IE5hYmloIEVzdGVmYW4gPG5h
YmloZXN0ZWZhbkBnb29nbGUuY29tPgpUZXN0ZWQtYnk6IE5hYmloIEVzdGVmYW4gPG5hYmloZXN0
ZWZhbkBnb29nbGUuY29tPgotLS0KIGluY2x1ZGUvaHcvYXJtL2FzcGVlZF9zb2MuaCB8ICA1ICsr
KysrCiBody9hcm0vYXNwZWVkX2FzdDI3eDAuYyAgICAgfCAyMSArKysrKysrKysrKysrKysrKysr
KysKIDIgZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2luY2x1
ZGUvaHcvYXJtL2FzcGVlZF9zb2MuaCBiL2luY2x1ZGUvaHcvYXJtL2FzcGVlZF9zb2MuaAppbmRl
eCAxOGZmOTYxYTM4Li5iY2ExMGMzODdiIDEwMDY0NAotLS0gYS9pbmNsdWRlL2h3L2FybS9hc3Bl
ZWRfc29jLmgKKysrIGIvaW5jbHVkZS9ody9hcm0vYXNwZWVkX3NvYy5oCkBAIC00Myw2ICs0Myw3
IEBACiAjaW5jbHVkZSAiaHcvZnNpL2FzcGVlZF9hcGIyb3BiLmgiCiAjaW5jbHVkZSAiaHcvY2hh
ci9zZXJpYWwtbW0uaCIKICNpbmNsdWRlICJody9pbnRjL2FybV9naWN2My5oIgorI2luY2x1ZGUg
Imh3L21pc2MvYXNwZWVkX2x0cGkuaCIKIAogI2RlZmluZSBWQk9PVFJPTV9GSUxFX05BTUUgICJh
c3QyN3gwX2Jvb3Ryb20uYmluIgogCkBAIC01NSw2ICs1Niw3IEBACiAjZGVmaW5lIEFTUEVFRF9V
QVJUU19OVU0gMTMKICNkZWZpbmUgQVNQRUVEX0pUQUdfTlVNICAyCiAjZGVmaW5lIEFTUEVFRF9Q
Q0lFX05VTSAgMworI2RlZmluZSBBU1BFRURfSU9FWFBfTlVNIDIKIAogc3RydWN0IEFzcGVlZFNv
Q1N0YXRlIHsKICAgICBEZXZpY2VTdGF0ZSBwYXJlbnQ7CkBAIC0xMTIsNiArMTE0LDcgQEAgc3Ry
dWN0IEFzcGVlZFNvQ1N0YXRlIHsKICAgICBVbmltcGxlbWVudGVkRGV2aWNlU3RhdGUgbHRwaTsK
ICAgICBVbmltcGxlbWVudGVkRGV2aWNlU3RhdGUganRhZ1tBU1BFRURfSlRBR19OVU1dOwogICAg
IEFzcGVlZEFQQjJPUEJTdGF0ZSBmc2lbMl07CisgICAgQXNwZWVkTFRQSVN0YXRlIGx0cGlfY3Ry
bFtBU1BFRURfSU9FWFBfTlVNXTsKIH07CiAKICNkZWZpbmUgVFlQRV9BU1BFRURfU09DICJhc3Bl
ZWQtc29jIgpAQCAtMjc5LDYgKzI4Miw4IEBAIGVudW0gewogICAgIEFTUEVFRF9HSUNfUkVESVNU
LAogICAgIEFTUEVFRF9ERVZfSVBDMCwKICAgICBBU1BFRURfREVWX0lQQzEsCisgICAgQVNQRUVE
X0RFVl9MVFBJX0NUUkwxLAorICAgIEFTUEVFRF9ERVZfTFRQSV9DVFJMMiwKIH07CiAKIGNvbnN0
IGNoYXIgKmFzcGVlZF9zb2NfY3B1X3R5cGUoY29uc3QgY2hhciAqIGNvbnN0ICp2YWxpZF9jcHVf
dHlwZXMpOwpkaWZmIC0tZ2l0IGEvaHcvYXJtL2FzcGVlZF9hc3QyN3gwLmMgYi9ody9hcm0vYXNw
ZWVkX2FzdDI3eDAuYwppbmRleCBlMTYxODNjM2IzLi5iYmNiNmUwMTI3IDEwMDY0NAotLS0gYS9o
dy9hcm0vYXNwZWVkX2FzdDI3eDAuYworKysgYi9ody9hcm0vYXNwZWVkX2FzdDI3eDAuYwpAQCAt
ODgsNiArODgsOCBAQCBzdGF0aWMgY29uc3QgaHdhZGRyIGFzcGVlZF9zb2NfYXN0MjcwMF9tZW1t
YXBbXSA9IHsKICAgICBbQVNQRUVEX0RFVl9VQVJUMTBdICAgID0gIDB4MTRDMzM5MDAsCiAgICAg
W0FTUEVFRF9ERVZfVUFSVDExXSAgICA9ICAweDE0QzMzQTAwLAogICAgIFtBU1BFRURfREVWX1VB
UlQxMl0gICAgPSAgMHgxNEMzM0IwMCwKKyAgICBbQVNQRUVEX0RFVl9MVFBJX0NUUkwxXSA9ICAw
eDE0QzM0MDAwLAorICAgIFtBU1BFRURfREVWX0xUUElfQ1RSTDJdID0gIDB4MTRDMzUwMDAsCiAg
ICAgW0FTUEVFRF9ERVZfV0RUXSAgICAgICA9ICAweDE0QzM3MDAwLAogICAgIFtBU1BFRURfREVW
X0xUUEldICAgICAgPSAgMHgzMDAwMDAwMCwKICAgICBbQVNQRUVEX0RFVl9QQ0lFX01NSU8wXSA9
IDB4NjAwMDAwMDAsCkBAIC00OTEsNiArNDkzLDExIEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9zb2Nf
YXN0MjcwMF9pbml0KE9iamVjdCAqb2JqKQogICAgICAgICBvYmplY3RfcHJvcGVydHlfc2V0X2lu
dChPQkpFQ1QoJnMtPnBjaWVbaV0pLCAiaWQiLCBpLCAmZXJyb3JfYWJvcnQpOwogICAgIH0KIAor
ICAgIGZvciAoaSA9IDA7IGkgPCBBU1BFRURfSU9FWFBfTlVNOyBpKyspIHsKKyAgICAgICAgb2Jq
ZWN0X2luaXRpYWxpemVfY2hpbGQob2JqLCAibHRwaS1jdHJsWypdIiwKKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgJnMtPmx0cGlfY3RybFtpXSwgVFlQRV9BU1BFRURfTFRQSSk7Cisg
ICAgfQorCiAgICAgb2JqZWN0X2luaXRpYWxpemVfY2hpbGQob2JqLCAiZHBtY3UiLCAmcy0+ZHBt
Y3UsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVFlQRV9VTklNUExFTUVOVEVEX0RFVklD
RSk7CiAgICAgb2JqZWN0X2luaXRpYWxpemVfY2hpbGQob2JqLCAibHRwaSIsICZzLT5sdHBpLApA
QCAtOTc0LDYgKzk4MSwyMCBAQCBzdGF0aWMgdm9pZCBhc3BlZWRfc29jX2FzdDI3MDBfcmVhbGl6
ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApCiAgICAgICAgIHJldHVybjsKICAgICB9
CiAKKyAgICAvKiBMVFBJIGNvbnRyb2xsZXIgKi8KKyAgICBmb3IgKGkgPSAwOyBpIDwgQVNQRUVE
X0lPRVhQX05VTTsgaSsrKSB7CisgICAgICAgIEFzcGVlZExUUElTdGF0ZSAqbHRwaV9jdHJsOwor
ICAgICAgICBod2FkZHIgbHRwaV9iYXNlOworCisgICAgICAgIGx0cGlfY3RybCA9IEFTUEVFRF9M
VFBJKCZzLT5sdHBpX2N0cmxbaV0pOworICAgICAgICBsdHBpX2Jhc2UgPSBzYy0+bWVtbWFwW0FT
UEVFRF9ERVZfTFRQSV9DVFJMMSArIGldOworCisgICAgICAgIGlmICghc3lzYnVzX3JlYWxpemUo
U1lTX0JVU19ERVZJQ0UobHRwaV9jdHJsKSwgZXJycCkpIHsKKyAgICAgICAgICAgIHJldHVybjsK
KyAgICAgICAgfQorICAgICAgICBhc3BlZWRfbW1pb19tYXAocy0+bWVtb3J5LCBTWVNfQlVTX0RF
VklDRShsdHBpX2N0cmwpLCAwLCBsdHBpX2Jhc2UpOworICAgIH0KKwogICAgIGFzcGVlZF9tbWlv
X21hcF91bmltcGxlbWVudGVkKHMtPm1lbW9yeSwgU1lTX0JVU19ERVZJQ0UoJnMtPmRwbWN1KSwK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiYXNwZWVkLmRwbWN1IiwKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzYy0+bWVtbWFwW0FTUEVFRF9ERVZfRFBNQ1Vd
LAotLSAKMi40My4wCg==

