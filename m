Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5DCACAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 03:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1yuS-0000ms-Ia; Thu, 25 Sep 2025 23:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v1yuP-0000md-MM; Thu, 25 Sep 2025 23:14:09 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v1yuI-0004Dh-Cc; Thu, 25 Sep 2025 23:14:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMIyh7LKVjzjRDiRkmubI/ELR5zTsc+sVJeerz7NLkjhrugnXaPbrDUoyxGCX1QjudRJ+gndE1yqx8PxmQ3PHFrWyLEsYfzfsGeJ5bQV5U9uFLjbJFtK/YqLHIWKqxdIgvBH+XsJSDyost+FhNU5JiwaLtouvr5FVJj0f8OnBTXZgz/c3JRPfx8Gbk/wE9UZNFRAsnG+D95NBv6uMNKq6Fxr4yYg/+dBCsVuuSp07xOL0C0YmDJG9lGic80H8p+IEFXbxhfxmbrqLb6EhV2iV/6gwbJBTLygx7mftMoXfG+3BCk5kAD6fo9DUOmebJQWNE2w/lqcNJoXuMXZSgEVdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hd7y5U6K4iseLvHxTOf1YXaIYINMRJYk6Qce3YnKhls=;
 b=qpNgJJoZukpU/lIKGZwT0PUeqpGktMXgUlYCNypfG/LXEwsbhHQGJHGv3n5QFhnhq8BbLNZQbwM7ZfckDp7QzEUaBE0YpYCp3eUDae2TinKpIKfcS42JGo7/DSyfIJf7+mc92gNn0YiItVM/SAa0GjUaITH1O9H2QcpWpVgTAkJ/Q19sD+H/Spino66Tpo0Pun0LAaOkvXnPLt3nl8WinVTAI1eMDXLWFWYRCnlREy486LKqEeCDqDcMJbyoIRmOpmNTPxmJmgEkFZKWqFFMORzIRnkEhxyAffasVtu9J2j6QrrNxapR6Sb5GnQK7skklG51RALtOkzpU6OgMCC5qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hd7y5U6K4iseLvHxTOf1YXaIYINMRJYk6Qce3YnKhls=;
 b=Y68vpjm0JG8ucpe5QwZy+04OdcusP4mDQkFXJDWpnR8h0K9k6p/XW2XzQmPekFcmiOLblUhXmivAacfosR6m5AClLo9qMy5gDMCy6n86XLE1D/mzBXZoI6/ld5Ff8wsGMG498WBYI7a2rDt4iyoXB0p/sV8n+cv5mtVqwpRgla55LSfXEy4FgoHb8bjzm8IiW9CL32X0Vh2a7jTZ3lhdfjq43XaEqJ1qX5sHtGjI/d2V0su0nMvScczdeOXsBTqVvc2iUXO8x4SOuoauWV4542qpbfwoVfYApg7Ds6gXbhH4kl6TTo2TFJ2Tmn2Rp0Xt1briXTtgtm/Pz6ZkcQ8y+g==
Received: from SEYPR06MB5037.apcprd06.prod.outlook.com (2603:1096:101:51::5)
 by SI2PR06MB5411.apcprd06.prod.outlook.com (2603:1096:4:1ee::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Fri, 26 Sep
 2025 03:13:36 +0000
Received: from SEYPR06MB5037.apcprd06.prod.outlook.com
 ([fe80::7c38:ebde:a05c:8196]) by SEYPR06MB5037.apcprd06.prod.outlook.com
 ([fe80::7c38:ebde:a05c:8196%7]) with mapi id 15.20.9115.017; Fri, 26 Sep 2025
 03:13:36 +0000
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
Thread-Index: AQHb9sykX4ZS+8HKlE6CthFW598H6LR/1CqAgCED8pCAADYQAIABNKFggABYMgCAAQBmEIABm69g
Date: Fri, 26 Sep 2025 03:13:35 +0000
Message-ID: <SEYPR06MB5037311A981103C166149A94FC1EA@SEYPR06MB5037.apcprd06.prod.outlook.com>
References: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
 <20250717034054.1903991-9-jamin_lin@aspeedtech.com>
 <a06379d8-ec0f-4842-87d9-5cecdb1dfd86@kaod.org>
 <SI2PR06MB5041DB54104CB51250E5E110FC1DA@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <5003d6ba-bf7e-4bdc-9c22-7360024536cf@redhat.com>
 <SI2PR06MB504175E8604D90397E631042FC1CA@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <078f252f-774b-47f8-bf94-6b1de8e70359@redhat.com>
 <SI2PR06MB50413935D3232A7618C71605FC1FA@SI2PR06MB5041.apcprd06.prod.outlook.com>
In-Reply-To: <SI2PR06MB50413935D3232A7618C71605FC1FA@SI2PR06MB5041.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5037:EE_|SI2PR06MB5411:EE_
x-ms-office365-filtering-correlation-id: 019f7a8c-fbb3-4f12-b25e-08ddfcaaaea4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?NHY1NTd0ZWxjbXBHMVVvTnN1WW1rNmJDcE9TMWEvNmFLZUZlc1FHdmJiWUd1?=
 =?utf-8?B?eEZlcExOdm04QUxwaTQvTXVCUXhjL2V1S0ZlUzVQRGVpOVZlVGliNHJYdkVJ?=
 =?utf-8?B?UXB2Y2UrTUlQZW1Ea0tQR1ZsbXl5NEJjeFl3dVpncUQ0OE15ZjR6QXg5Q2NK?=
 =?utf-8?B?MEpjVzh3aXlleThGREtNVjZiN3B0bDJybGR3SnQxNVgzeng1eUV2Y3hza1RE?=
 =?utf-8?B?LzFTR244dXhQVlU5V25BeTJtMVk0TjR2SWNtUGxvdG5HVzNjb2gvbllMY25S?=
 =?utf-8?B?bGhZM3FETXB3T0o0OVBGR2pPeEQvT01KY2J3UmNXLytweFlCeWt5NHFFNThh?=
 =?utf-8?B?MEsrS2UzSXlIS0xzNHlxOVhyTzBVT05ac0RxNksybjdYTkxmTXJScTgzbUc4?=
 =?utf-8?B?YXVMT3FJd2ZsTmNVUzZKTUtRT05RSkZ3ZTdCWnJrNmxiNGwvWkVpKzhud0hV?=
 =?utf-8?B?NXRtU0tZdU1jMHA0dFdjV3pZbEhOeCtDUkRVOXZsemt4S0dHOTJINGVXOUkz?=
 =?utf-8?B?SHZ1RU5ERFVWYk5OekNPWEErV054NlhSd0ZvV1hGMlprN3hsbUM0TGZIVmtF?=
 =?utf-8?B?UStyM0RJSXhWYXFOYXBPcUQzMUZEYVF4WWNSWUFlWTlQU3phVWd1Y0pwZmRy?=
 =?utf-8?B?QUlsWGZvWlZLelQrcEpDK2JRZXNxRlRZUnJlWEl6T2UvSTErTjc5K3dHa1Fv?=
 =?utf-8?B?b3ZFbzRLV0RVc2pOQ04xN2VIT2h5N1hKNTVQSmI3M2NVZUZTYnMrWGk3WkI1?=
 =?utf-8?B?V29zNnBjbm9pN2F6OFBwRVVYZXJKQXpHcmo4NGMyN0xIbWwrV3FQTEpvR2FW?=
 =?utf-8?B?eVhYNUNvMUhOL1pTcThZSVFjVnRyczk3YVdZN1hKRjd6M2lQNmdCZEhSb2x0?=
 =?utf-8?B?TFE5WHdvQzJjbzd1eUprdDdRM1JtSWg2WnZHOWF5dUo1VmJvRGFyZlRleUhh?=
 =?utf-8?B?WFAzbmtOSkZLYVdNa1RUYllUVEo1Z1VwMXJBQ2NtNlh6RVZ5US9wc3gvZW16?=
 =?utf-8?B?UzNhZGptMEhGWTNyUEovUjdnK0JqaHdYRTFyOGFZaEI4bGRycmhhZDBKbTZT?=
 =?utf-8?B?YTA2R1FTang0aStVRjdHQnN1ZnJUQnFWKzBoVGpyOWFIQ1l5cmp4UVg2Mkt5?=
 =?utf-8?B?eE5hT051SGJtZ2RsOWVKVytuZW9BZFlwVFpYWW1YTFlWcXRGVmRXOVpRdkl5?=
 =?utf-8?B?ell4RGkyWjdlakhQbEVsSjNVWjdOMDRrbVQrTFp4eFBOa0hvcU8zM2d1Yzhh?=
 =?utf-8?B?aGtLSnBFR2U0SWtzcmtWbnFLWmd1eFBlNVZHTG91ZTlaUE1yaWZuTDgwOEhX?=
 =?utf-8?B?ZjRQZFFLSzZDZVhZOXRoNG1URVpFVzVtRlFmV3pJWVVia3l0Q1J2aUUyYzNm?=
 =?utf-8?B?c0VxUmVmdjU2L2hzNk5wQnRDUUtNaVF1KzhDWkJTOG05R3hORWVhNTZRbkVO?=
 =?utf-8?B?VTdwd0VhWWVuMTFLMks1Q2daekN3b3ZzdGhUcDl0dUZLUy9HbHJLeXRjTVdw?=
 =?utf-8?B?MWFQTFBPWE55MjE3OWVOdEVCZWIvN0dERkF3SEVZYlcrQ0JzcmRhaHJoRnhI?=
 =?utf-8?B?RHZ4ZDNSRktFNjlmRmFUd04yQVhiN0VpL29hV1lVd2ptc1V2V2htaVRrMWRB?=
 =?utf-8?B?UkpWTEVkRjcyQnVwVHhQSTdxL1dRd0krTUtPYUpLRE9TR1gzV3ZpTmRHMW5l?=
 =?utf-8?B?ZkpWSlk4N0MxREhjdTlFOG50WVBzVktmMjFZeXpOaTZZTFRqeHBqbEdPWnJr?=
 =?utf-8?B?TEZoNzdrZ3ZZNVV5YWphd3o1Wmx3RTVJUWlMOEIvWk9LMlNtaVc0c29FUGRi?=
 =?utf-8?B?TklRVmFoZy81cWphbkxVN1I4aHNGSWI5RmpVdTQzNGVUcWNrcUcyaWxYOVJS?=
 =?utf-8?B?enE5SHpuMDloREpDSXZPdG00OFJlNzVWZzYvREIrZmdLQm5QcEpxRGZpYkFp?=
 =?utf-8?B?S2owa1ljQkM2dVFYUXlIVmF3ZWx1QThTbmpiWGZDYUk3ZU1qUXQzRjdYZ1lD?=
 =?utf-8?B?Wis2V2IvVDY2SEt0dmFINldWM2Voc3lYUS9jcUovSXN3ZDA1a3lrUmR0bC93?=
 =?utf-8?Q?LUD+fB?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEYPR06MB5037.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bG5QQ1AwTUR5TXpaSFBDU1BtZkhabjR3ZmNSTWpPNGdPM0JDcm5wUVdFanNv?=
 =?utf-8?B?c1hQbW5VaG1JMWVtM294bkdJVU00TXg5V3FQZ1hSYnI4QTJBUnFTVVF6T3FX?=
 =?utf-8?B?VUxNeXg5QU5HUXRHTFhqQ05HUDV0c0lFT1NDZ0p5OGlDcG1yRHVDZWxDeTNO?=
 =?utf-8?B?bUdIck43Y3o2cnY5Qkxod3praDk5aWpNd3lPZi9mbllmaitlRUNERHA0Y09H?=
 =?utf-8?B?VFlBS1ZiMFVXd2RKMjh2VnJtdTBDcVl3T0Z4QUtKbnI5VFFld0cxdkhYcENO?=
 =?utf-8?B?ZzY0R0RlYXF6NjhuTk0xS2QzMit0Sk5NMjRoYVNtNFIzMVB6dkF0U2hnYWht?=
 =?utf-8?B?SVByeUpQalhMZmt1T3VPSUo1ME96dWcyS3htTFBQMUJpUjQwVGFha0NTUUtn?=
 =?utf-8?B?ajR4ZDZKRWtzVlMwYUw4LzJXdTk5dWZraGgyWG5ablVwV3RiZkNGVUp1c3c3?=
 =?utf-8?B?U2Jha05aenBtMklQcjYzVHZiZmNXNDFReTR5OEU2S05YcG5CTWFVNnhVendL?=
 =?utf-8?B?S1dGN1Zwb04vZS9ndzRvVjEvc3MvdzF6NDV2NW9LRkVGMUFHK0VadUNyTSt6?=
 =?utf-8?B?SEdqS2NORVVvZUZVek8ybGJrdm16UjBPeW5ia081V0RuUkN5WGU5UFdYdTB2?=
 =?utf-8?B?UDgwNExxSWZORVVkb1V0S1dZK2RXdzJaQnZqRkRLOVlYRnBHWU9lNExDVU9I?=
 =?utf-8?B?aVVOdDBGTUJoemFLSmVIZkJZM09xalkrRVNTN1ozdU1SOHRKWTlsMitYa3BG?=
 =?utf-8?B?cDc0M29jcUx3YkJaY3BRQVM3QlEzc2xydzlYWFNJN2xCUUhMcHg4d2t2ejNy?=
 =?utf-8?B?QkdvU2pnK3hCMTVnWTlkVVZEbWE5d3c2M0dsUjY5cEdHQmJ0aHNiOVZlNTUy?=
 =?utf-8?B?QTUrUDR1aFEvbGs4RWwxSXNEZXhmZ1dwZ0RldSsxcmo4SDdubDRSOHZaWW5z?=
 =?utf-8?B?OWQ1Q1JvRjVqODA1TWxSblU0Ym1KL01DVXU5Q1M5NTliZ1B3ZVUwNDU1WWNH?=
 =?utf-8?B?aFRPMzg5VEY1Q2VwaEYrazh2dFZHWFhJWjkwcWdlUjRlK0QzSGd5VWJMSFZp?=
 =?utf-8?B?Mzd6WTFLUWNSSGVJaGZ4aC9kcS9VSFVibFo1eHBIVHRXcXQ5MGR1TS9Xb3F5?=
 =?utf-8?B?citYYlVCTFFCV0xtRkRCUnB0RTI0WHEzT1laRjRMQkloS3ZxMmwwKy9SRE0w?=
 =?utf-8?B?czBQVlBWb2RrRit3WGJweE9VR1Fnc0RZejZWckVTNGo2dC9jRTNhUHNFNCtU?=
 =?utf-8?B?QVFLTGdXY1RlRW44YWt3VXRRNkV1U05SRStxTVd0QWU0eW5uTkxNdFdEKzVi?=
 =?utf-8?B?eXRHc1FSNEV4QjdaOVBYM3I5anBQK09QRUdsTlNsb3dNRjBXb1lORTFDTUtw?=
 =?utf-8?B?VG1CRHJvSGlkUFYvVlVqTStMK3BuQ2owRHczV2MxR1NhejlMem8vbjF4K0Yr?=
 =?utf-8?B?TFhtYmJtYkZKLzJaR0JHMXhYSlhUMlRIMzFOeXE3MzRFNFBncXFXMXhrWHNU?=
 =?utf-8?B?UmtyU1JKR1poYk51cGc0Wkcwd2xaR2p5UlJORlQzY2xWb2JVSTdYR3dvSmlE?=
 =?utf-8?B?WFBjbjFNaG0yRTJocnQrU3VreEtVSUJ0Zkw3akdwNmVXOTFCc0NTL25aVU1U?=
 =?utf-8?B?L0pVWGt2anh3azhiNExTS1dGU2VNNUREVEpxSVh2ay8rdExJU0d4Zi8wbXBm?=
 =?utf-8?B?QXB5TlVxNHd4UFlQamROT0JXa3ZuTlI2VmVqTFZTaU51STFNaStFcDRoNzNY?=
 =?utf-8?B?VjRIL0NVODhLbkxUS3M0V2laY1ljM3R1U3pMNytSQ2czMExyU3ZNemJwNXpk?=
 =?utf-8?B?QWtMZ0hER2VLa0dUcU90SnBkUSsyVGEvRVB6eWpDcHJCYW5MZ1dHMXVUZWhW?=
 =?utf-8?B?WW5oVUJhUzd2aS84OW96UmZFcFZpaWZTZXVXWUlNNy9kOHRVRWNZTDhpMkVj?=
 =?utf-8?B?Y2tqdVhWSXJHNjhhaUNrQlZ2MHJYbVVQTE45YjF1aU5pekJISjErUHFKZmtQ?=
 =?utf-8?B?OVJXdXdTYzIzekp6bEJMQWNLMElJWGp6RjJYcGtvc0k3a1FCUmtGVGtsaXVY?=
 =?utf-8?B?QkhnbDNCaHN3WW5jNVZMd2V3VURickF2bCtOb2lXZUdkWWM2WW1VL0dkMUIr?=
 =?utf-8?Q?qMpehTjn9RHW1MfTqS/JRrNqh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5037.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 019f7a8c-fbb3-4f12-b25e-08ddfcaaaea4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 03:13:36.0714 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1M0lKAXH+0HiAPM0fkK08hLHEq4lX0+Y9wET8rDm0M9+3Alj8ewFndAQ1rz2HYbNn4Kx9AAtSsYIU9DtvVW8FeIA1eQZBwhtFGs1Yqa5qMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5411
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYw0KDQo+ID4gPj4+IDMuIE1pZ3JhdGUgYWxsIEFTUEVFRCBjb3Byb2Nlc3NvcnMg
KGUuZy4gU1NQL1RTUCkgdG8gYSBjb21tb24NCj4gPiA+PiBBc3BlZWRDb3Byb2Nlc3NvclN0YXRl
Lg0KPiA+ID4+DQo+ID4gPj4gSXMgJ0FzcGVlZENvcHJvY2Vzc29yU3RhdGUnIGEgbmV3IG1vZGVs
IHN0cnVjdHVyZSBtaW5pbWl6aW5nIHRoZQ0KPiA+ID4+IG51bWJlciBvZiBzdWIgY29udHJvbGxl
cnMgPyBpZiBzbywgbG9va3MgZ29vZC4gQ291bGQgYmUgbWVyZ2VkIGZhaXJseQ0KPiBxdWlja2x5
Lg0KPiA+ID4+DQo+ID4gPg0KPiA+ID4gWWVzLCBJIGFtIHBsYW5uaW5nIHRvIHVzZSB0aGUgbmV3
IEFzcGVlZENvcHJvY2Vzc29yU3RhdGUgaW5zdGVhZCBvZg0KPiA+IEFzcGVlZFNvQ1N0YXRlIGZv
ciBTU1AgYW5kIFRTUC4NCj4gPiA+IHN0cnVjdCBBc3BlZWQyN3gwU1NQU29DU3RhdGUgew0KPiA+
ID4gICAgICBBc3BlZWRTb0NTdGF0ZSBwYXJlbnQ7ICAtLS0tLS0tPiBDaGFuZ2UgdG8gQXNwZWVk
Q29wcm9jZXNzb3JTdGF0ZQ0KPiA+ID4gICAgICBBc3BlZWRJTlRDU3RhdGUgaW50Y1syXTsNCj4g
PiA+ICAgICAgVW5pbXBsZW1lbnRlZERldmljZVN0YXRlIGlwY1syXTsNCj4gPiA+ICAgICAgVW5p
bXBsZW1lbnRlZERldmljZVN0YXRlIHNjdWlvOw0KPiA+ID4NCj4gPiA+ICAgICAgQVJNdjdNU3Rh
dGUgYXJtdjdtOw0KPiA+ID4gfTsNCj4gPiA+DQo+ID4gPiBzdHJ1Y3QgQXNwZWVkMjd4MFRTUFNv
Q1N0YXRlIHsNCj4gPiA+ICAgICAgQXNwZWVkU29DU3RhdGUgcGFyZW50OyAgLS0tLS0tLT4gQ2hh
bmdlIHRvIEFzcGVlZENvcHJvY2Vzc29yU3RhdGUNCj4gPiA+ICAgICAgQXNwZWVkSU5UQ1N0YXRl
IGludGNbMl07DQo+ID4gPiAgICAgIFVuaW1wbGVtZW50ZWREZXZpY2VTdGF0ZSBpcGNbMl07DQo+
ID4gPiAgICAgIFVuaW1wbGVtZW50ZWREZXZpY2VTdGF0ZSBzY3VpbzsNCj4gPiA+DQo+ID4gPiAg
ICAgIEFSTXY3TVN0YXRlIGFybXY3bTsNCj4gPiA+IH07DQo+ID4gPiBUaGlzIGNoYW5nZSBjb25z
b2xpZGF0ZXMgU1NQIGFuZCBUU1AgdW5kZXIgYSBjb21tb24gY29wcm9jZXNzb3INCj4gPiA+IG1v
ZGVsLCByZWR1Y2luZyBkdXBsaWNhdGlvbiBhbmQgYWxpZ25pbmcgdGhlbSB3aXRoIHRoZSBuZXcN
Cj4gPiBBc3BlZWRDb3Byb2Nlc3NvclN0YXRlIGFic3RyYWN0aW9uLg0KPiA+DQo+ID4gQXNwZWVk
Mjd4MFRTUFNvQ1N0YXRlIGFuZCBBc3BlZWQyN3gwU1NQU29DU3RhdGUgbG9vayBzaW1pbGFyLiBD
b3VsZA0KPiA+IHRoZXkgYmUgbWVyZ2VkID8NCj4gPg0KPiBUaGFua3MgZm9yIHlvdXIgc3VnZ2Vz
dGlvbi4NCj4gV2lsbCB0cnkgaXQuDQo+IEphbWluDQo+ID4gVGhhbmtzLA0KDQpJIGFtIGNvbnNp
ZGVyaW5nIG1ha2luZyB0aGUgZm9sbG93aW5nIEFQSXMgY29tbW9uIHNvIHRoYXQgYm90aCB0aGUg
Q29wcm9jZXNzb3IgYW5kIFNvQyBjYW4gdXNlIHRoZW0uDQoNClRoZSBDb3Byb2Nlc3NvciBzdGF0
ZSBpcyBBc3BlZWRDb3Byb2Nlc3Nvcg0KVGhlIGdlbmVyYWwgU29DIHN0YXRlIGlzIEFzcGVlZFNv
Qw0KDQpBLiBNTUlPIE1hcHBpbmcNCkN1cnJlbnRseToNCg0Kdm9pZCBhc3BlZWRfbW1pb19tYXAo
QXNwZWVkU29DU3RhdGUgKnMsIFN5c0J1c0RldmljZSAqZGV2LCBpbnQgbiwgaHdhZGRyIGFkZHIp
DQp7DQogICAgbWVtb3J5X3JlZ2lvbl9hZGRfc3VicmVnaW9uKHMtPm1lbW9yeSwgYWRkciwNCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3lzYnVzX21taW9fZ2V0X3JlZ2lvbihkZXYs
IG4pKTsNCn0NCg0Kdm9pZCBhc3BlZWRfbW1pb19tYXBfdW5pbXBsZW1lbnRlZChBc3BlZWRTb0NT
dGF0ZSAqcywgU3lzQnVzRGV2aWNlICpkZXYsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGNvbnN0IGNoYXIgKm5hbWUsIGh3YWRkciBhZGRyLCB1aW50NjRfdCBzaXplKQ0Kew0K
ICAgIHFkZXZfcHJvcF9zZXRfc3RyaW5nKERFVklDRShkZXYpLCAibmFtZSIsIG5hbWUpOw0KICAg
IHFkZXZfcHJvcF9zZXRfdWludDY0KERFVklDRShkZXYpLCAic2l6ZSIsIHNpemUpOw0KICAgIHN5
c2J1c19yZWFsaXplKGRldiwgJmVycm9yX2Fib3J0KTsNCg0KICAgIG1lbW9yeV9yZWdpb25fYWRk
X3N1YnJlZ2lvbl9vdmVybGFwKHMtPm1lbW9yeSwgYWRkciwNCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBzeXNidXNfbW1pb19nZXRfcmVnaW9uKGRldiwgMCksIC0xMDAw
KTsNCn0NCg0KUHJvcG9zYWw6DQpSZXBsYWNlIEFzcGVlZFNvQ1N0YXRlICpzIHdpdGggTWVtb3J5
UmVnaW9uICptZW1vcnkuDQpUaGlzIHdheSwgdGhlIGZ1bmN0aW9ucyBjYW4gYmUgcmV1c2VkIGZv
ciBib3RoIEFzcGVlZFNvQyBhbmQgQXNwZWVkQ29wcm9jZXNzb3IuDQp2b2lkIGFzcGVlZF9tbWlv
X21hcChNZW1vcnlSZWdpb24gKm1lbW9yeSwgU3lzQnVzRGV2aWNlICpkZXYsIGludCBuLCBod2Fk
ZHIgYWRkcik7DQp2b2lkIGFzcGVlZF9tbWlvX21hcF91bmltcGxlbWVudGVkKE1lbW9yeVJlZ2lv
biAqbWVtb3J5LCBTeXNCdXNEZXZpY2UgKmRldiwNCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgY29uc3QgY2hhciAqbmFtZSwgaHdhZGRyIGFkZHIsIHVpbnQ2NF90IHNpemUpOw0K
DQpCLiBVQVJUIEluZGV4IEhlbHBlcnMNCkN1cnJlbnRseToNCnN0YXRpYyBpbmxpbmUgaW50IGFz
cGVlZF91YXJ0X2ZpcnN0KEFzcGVlZFNvQ0NsYXNzICpzYykNCnsNCiAgICByZXR1cm4gYXNwZWVk
X3VhcnRfaW5kZXgoc2MtPnVhcnRzX2Jhc2UpOw0KfQ0KDQpzdGF0aWMgaW5saW5lIGludCBhc3Bl
ZWRfdWFydF9sYXN0KEFzcGVlZFNvQ0NsYXNzICpzYykNCnsNCiAgICByZXR1cm4gYXNwZWVkX3Vh
cnRfZmlyc3Qoc2MpICsgc2MtPnVhcnRzX251bSAtIDE7DQp9DQoNClByb3Bvc2FsOg0KTWFrZSB0
aGVtIGluZGVwZW5kZW50IG9mIEFzcGVlZFNvQ0NsYXNzLCBzbyB0aGV5IGNhbiBiZSByZXVzZWQ6
DQoNCnN0YXRpYyBpbmxpbmUgaW50IGFzcGVlZF91YXJ0X2ZpcnN0KGludCB1YXJ0c19iYXNlKTsN
CnN0YXRpYyBpbmxpbmUgaW50IGFzcGVlZF91YXJ0X2xhc3QoaW50IHVhcnRzX2Jhc2UsIGludCB1
YXJ0c19udW0pOw0KDQpDLiBVQVJUIFJlYWxpemF0aW9uDQpUaGlzIGNhc2UgbG9va3MgbW9yZSBj
b21wbGV4LiBQb3NzaWJsZSBhcHByb2FjaGVzOg0KMS4gQ3JlYXRlIGEgbmV3IEFQSSBzcGVjaWZp
Y2FsbHkgZm9yIHRoZSBjb3Byb2Nlc3Nvci4NCjIuIEFkZCBleHRyYSBwYXJhbWV0ZXJzIHRvIHRo
ZSBleGlzdGluZyBBUElzIGluc3RlYWQgb2YgcmVseWluZyBvbiBBc3BlZWRTb0NTdGF0ZS4NCg0K
Rm9yIGV4YW1wbGUsIHRoZSBjdXJyZW50IFNvQyBVQVJUIHJlYWxpemF0aW9uIGlzIHRpZ2h0bHkg
Ym91bmQgdG8gQXNwZWVkU29DU3RhdGUuDQpNYWtpbmcgaXQgZ2VuZXJpYyB3b3VsZCByZXF1aXJl
IGFkZGl0aW9uYWwgcGFyYW1ldGVycyAoc3VjaCBhcyB0aGUgVUFSVCBhcnJheSwgYmFzZSBpbmRl
eCwgbWVtbWFwLCBhbmQgSVJRIGhhbmRsZXIpIHNvIGl0IGNvdWxkIGJlIHJldXNlZCBieSBib3Ro
IFNvQyBhbmQgQ29wcm9jZXNzb3IuDQpDb3VsZCB5b3UgcGxlYXNlIGdpdmUgbWUgYW55IHN1Z2dl
c3Rpb24/DQoNCmJvb2wgYXNwZWVkX3NvY191YXJ0X3JlYWxpemUoQXNwZWVkU29DU3RhdGUgKnMs
IEVycm9yICoqZXJycCkNCnsNCiAgICBBc3BlZWRTb0NDbGFzcyAqc2MgPSBBU1BFRURfU09DX0dF
VF9DTEFTUyhzKTsNCiAgICBTZXJpYWxNTSAqc21tOw0KDQogICAgZm9yIChpbnQgaSA9IDAsIHVh
cnQgPSBzYy0+dWFydHNfYmFzZTsgaSA8IHNjLT51YXJ0c19udW07IGkrKywgdWFydCsrKSB7DQog
ICAgICAgIHNtbSA9ICZzLT51YXJ0W2ldOw0KDQogICAgICAgIC8qIENoYXJkZXYgcHJvcGVydHkg
aXMgc2V0IGJ5IHRoZSBtYWNoaW5lLiAqLw0KICAgICAgICBxZGV2X3Byb3Bfc2V0X3VpbnQ4KERF
VklDRShzbW0pLCAicmVnc2hpZnQiLCAyKTsNCiAgICAgICAgcWRldl9wcm9wX3NldF91aW50MzIo
REVWSUNFKHNtbSksICJiYXVkYmFzZSIsIDM4NDAwKTsNCiAgICAgICAgcWRldl9zZXRfbGVnYWN5
X2luc3RhbmNlX2lkKERFVklDRShzbW0pLCBzYy0+bWVtbWFwW3VhcnRdLCAyKTsNCiAgICAgICAg
cWRldl9wcm9wX3NldF91aW50OChERVZJQ0Uoc21tKSwgImVuZGlhbm5lc3MiLCBERVZJQ0VfTElU
VExFX0VORElBTik7DQogICAgICAgIGlmICghc3lzYnVzX3JlYWxpemUoU1lTX0JVU19ERVZJQ0Uo
c21tKSwgZXJycCkpIHsNCiAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCiAgICAgICAgfQ0KDQog
ICAgICAgIHN5c2J1c19jb25uZWN0X2lycShTWVNfQlVTX0RFVklDRShzbW0pLCAwLCBhc3BlZWRf
c29jX2dldF9pcnEocywgdWFydCkpOw0KICAgICAgICBhc3BlZWRfbW1pb19tYXAocywgU1lTX0JV
U19ERVZJQ0Uoc21tKSwgMCwgc2MtPm1lbW1hcFt1YXJ0XSk7DQogICAgfQ0KDQogICAgcmV0dXJu
IHRydWU7DQp9DQoNCnZvaWQgYXNwZWVkX3NvY191YXJ0X3NldF9jaHIoQXNwZWVkU29DU3RhdGUg
KnMsIGludCBkZXYsIENoYXJkZXYgKmNocikNCnsNCiAgICBBc3BlZWRTb0NDbGFzcyAqc2MgPSBB
U1BFRURfU09DX0dFVF9DTEFTUyhzKTsNCiAgICBpbnQgdWFydF9maXJzdCA9IGFzcGVlZF91YXJ0
X2ZpcnN0KHNjKTsNCiAgICBpbnQgdWFydF9pbmRleCA9IGFzcGVlZF91YXJ0X2luZGV4KGRldik7
DQogICAgaW50IGkgPSB1YXJ0X2luZGV4IC0gdWFydF9maXJzdDsNCg0KICAgIGdfYXNzZXJ0KDAg
PD0gaSAmJiBpIDwgQVJSQVlfU0laRShzLT51YXJ0KSAmJiBpIDwgc2MtPnVhcnRzX251bSk7DQog
ICAgcWRldl9wcm9wX3NldF9jaHIoREVWSUNFKCZzLT51YXJ0W2ldKSwgImNoYXJkZXYiLCBjaHIp
Ow0KfQ0KDQpELiBDb21tb24gQVBJcyBpbiBNdWx0aXBsZSBTb0NzDQoNClRoZSBmb2xsb3dpbmcg
QVBJcyBhcmUgYWxyZWFkeSB3aWRlbHkgdXNlZCBhY3Jvc3MgQVNUMjQwMCwgQVNUMjUwMCwgQVNU
MjYwMCwgQVNUMjcwMCwgYW5kIEFTVDEwMzAgU29DIHJlYWxpemF0aW9uczoNCkFyZSB5b3UgYWdy
ZWUgaWYgSSBjcmVhdGUgYSBuZXcgYXNwZWVkX2NvcHJvY2Vzc29yX2NwdV90eXBlIGFuZCBhc3Bl
ZWRfY29wcm9jZXNzb3JfZ2V0X2lycSBmb3IgQ29wcm9jZXNzb3I/DQpDb3VsZCB5b3UgcGxlYXNl
IGdpdmUgbWUgYW55IHN1Z2dlc3Rpb24/DQoNCmNvbnN0IGNoYXIgKmFzcGVlZF9zb2NfY3B1X3R5
cGUoQXNwZWVkU29DQ2xhc3MgKnNjKQ0Kew0KICAgIGFzc2VydChzYy0+dmFsaWRfY3B1X3R5cGVz
KTsNCiAgICBhc3NlcnQoc2MtPnZhbGlkX2NwdV90eXBlc1swXSk7DQogICAgYXNzZXJ0KCFzYy0+
dmFsaWRfY3B1X3R5cGVzWzFdKTsNCiAgICByZXR1cm4gc2MtPnZhbGlkX2NwdV90eXBlc1swXTsN
Cn0NCg0KcWVtdV9pcnEgYXNwZWVkX3NvY19nZXRfaXJxKEFzcGVlZFNvQ1N0YXRlICpzLCBpbnQg
ZGV2KQ0Kew0KICAgIHJldHVybiBBU1BFRURfU09DX0dFVF9DTEFTUyhzKS0+Z2V0X2lycShzLCBk
ZXYpOw0KfQ0KDQpUaGFua3MtSmFtaW4NCg0KPiA+DQo+ID4gQy4NCg0K

