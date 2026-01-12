Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FD2D25051
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 08:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfDK1-00050y-Sc; Mon, 12 Jan 2026 03:30:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vfDJm-0004xz-3o; Mon, 12 Jan 2026 03:30:38 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vfDJd-0008Mq-U9; Mon, 12 Jan 2026 03:30:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrweVNEfS4IATLRFp+BJ1xtGZFC8Ga5q1HKaaIcfJwvyWQRw4/188pzrq5NXXM6zj84yg4n6aXq86wd7txzsmjti1SPjPllK2WC5G6u6RSnSD6Q0I/JEAIuJfWyz4UuAY3npx5ROidDTexBEB2xNuKOomThtBOCmmws46HAUzP1aVKzwHYrE5l5/jsWAvGqAZUp514EJ4M/ErZEabyyTbP2VA7Mq/4iS4v+FtRyBxQPBKjwstyY7FFDobRRGhEeoOlV7QOhERVJQ8+uLzGIwES9a5FV2EHFGYg4OkeIdu/uE/5vbsHf13u3bxqsR0ePqMgDV1cK8yXko20jAERaUAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yq705J7eQFD9ODP9RsqzrbzQtfKlPnUNvReyVDio9ac=;
 b=nF23w9hAUP7pNpSR6hcRfBzZRM4vxsgH4BiejSj3EPXC+FKe0s63ZN9JFnV3rinGjcT26NkTGc2Jm+3xRXBRwH5v6L1mOXgYQJzTnZIJgT2a5yHoCF7a7cCMXgbLJEV6Phhx1/TbSpFiXWCXjSn8u5RHphnTgEHolxLP862ak5fA9Wxv/asHLMkCe5hbtQ3RCH54tXELGVFdByx/6cOQOlJEdmkts42liQFjJMHt/nz7urH5M8QI+i+Wf3JI5mQkOD1d+5vKmJ35735np77QB1Wn7flYUVBsxbxuqHjQCrix6vGXXo1NLMMeKZqzyYc1vNq3WdyaEBQnaSSFCFoYIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yq705J7eQFD9ODP9RsqzrbzQtfKlPnUNvReyVDio9ac=;
 b=KUasFsxJbUzZ4HQSc5RhtMSP3iIAR5jOlo0L+E2ZloqBXb4pMKpxKzaj3YidZzFFgsQSQsdIV3gkujB+HyDol3cBcWIhle62d7Q+yt2izEsnGGZ9nPgXrV1EHmPNSdBpJ1DbAkFbrdi0RFDa1ooxqn/9pgAtCM2EsSNY9u7bBTbWFuWLZH6x/DhPOgy0KfRwL86idviinDId2//XcUeUXnk5t7NXfJD3T0PsxMqrEJcWMH9cEyjGph2lSI17a5GNWVMJMKFrEG/UCwh0wYbseSRcJ29+0M2Agp6+KJwTOtvMBeuMfZckqmwe6BElLuXOu1JYVG6d61Jl1nEm9pnkVQ==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SG2PR06MB5033.apcprd06.prod.outlook.com (2603:1096:4:1c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 08:30:11 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 08:30:10 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: RE: [PATCH v4 14/19] hw/arm/aspeed: attach I2C device to AST1700 model
Thread-Topic: [PATCH v4 14/19] hw/arm/aspeed: attach I2C device to AST1700
 model
Thread-Index: AQHcdHaM7LqK+1z4NUeh6mGjSHFVqbVG4dYAgAALpoCAAM4SsIAAbWyAgAEVn9CAAK+KAIAEXkyA
Date: Mon, 12 Jan 2026 08:30:10 +0000
Message-ID: <SI6PR06MB763187527271B099B236853FF781A@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
 <20251224014203.756264-15-kane_chen@aspeedtech.com>
 <1a3595d9-eac7-4575-a31f-1b869c6175f3@kaod.org>
 <5af965b1-d4f2-4b5f-b339-a3ca1ec1905d@kaod.org>
 <SI6PR06MB76312CC4E874C642DA879F11F785A@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <6f0e285f-4921-4b18-8dac-f80b435dc1b4@kaod.org>
 <SI6PR06MB763104221FFD3B2F8511E62FF782A@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <ba0183c5-d2a4-4dea-9238-d26a45c4daa7@kaod.org>
In-Reply-To: <ba0183c5-d2a4-4dea-9238-d26a45c4daa7@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SG2PR06MB5033:EE_
x-ms-office365-filtering-correlation-id: 2735c59b-1452-4e7c-07a1-08de51b4ccc8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Qk4zdTRIajJmTUo5ZFA2dFc4U3VwdEtZc3J4MzBzKzJLMS8zZHNaTTlBbGpT?=
 =?utf-8?B?dlpsUkNabmpvbWhmRWt1R010eTVrajE1ZHdmNXFKQVRjQmw2OGcwNWpNOXBv?=
 =?utf-8?B?UGtRUTE5STZ3aVZVNldNU3JMbnZ2WHhwVlYzc09pNE5aSW9WUlNpT3FLd2ZN?=
 =?utf-8?B?RzZFY3NudTMwRnZ4a0tyQmFmSEdsVkVWLytHN2E4MytWQUVrTk1tU1NsajEr?=
 =?utf-8?B?bHo3OEs5YUJoRXlrbzZLaWRQVU9tRUU0OWZJWHRlaWUwU1M5V3R2eFhPTkdB?=
 =?utf-8?B?VExMZEFCSjhleUtlMUF5K1VPaW1heUhkeklPOGxyWHJOWXc4b0g1Y0JJd3JN?=
 =?utf-8?B?VkhzMWJCV1pmVnpqT1RIT3BQQ3ZMdWxKSW1BWU5sQkZ6SmVaM3htQVdDSVo2?=
 =?utf-8?B?c1EwdkdxVVhSVjZxdjZvV3NpY2tjVHJnYTJ6K0lNWkdEYlJ4a1lPdEhhQW54?=
 =?utf-8?B?YVZVdld0TURteFZQbW9Ha3hhVkVxMlhPb2RtajNpQUdNTnhwYUhDSHdWNDg3?=
 =?utf-8?B?czlrUlhGVGw5WU1GS0pqMFE0eVVFOGtwdVNzTnlhNExtYlYya0VJc1N0bWxx?=
 =?utf-8?B?TnlVdEJJUTlyVkhSdnY2Sm9sTjRwOG56TXVHZUtJTzdiVzJXeGpoWVRLUVV4?=
 =?utf-8?B?dTJZaVlONk14Vmo2c1VZU3JLVU0vUE5iam9VU2R6MWFaangrdE8zY1FIL2ZV?=
 =?utf-8?B?bWtIRE02Uy81SVZIYjBBNE1iM1BoampTLzhIN0k3KzltWmoxbmFDQWVlSXpK?=
 =?utf-8?B?Ti9qNzFIVDE3MnZuSGVZWXRzNlF4akxWbkowMWR5bG9udDZFNDBVeVFiWnpn?=
 =?utf-8?B?NW1jMFRSNENWOFdOWnNzVXVEWmtySlFOYU9McWhEbFhnUi9nRktXLzBvU0FI?=
 =?utf-8?B?aVdORHhralVrY0lOZE9XejFOa1RPNERMVjFnMEpaQjFSRndSODFyQm1heGZi?=
 =?utf-8?B?RTJEcjVIWWZUdk1lTjBIQ05ZWC8zUnp4eHB0MFdLbjl2U0grTFZxZ002VDJ6?=
 =?utf-8?B?QjV5bU5nWWViSzYxeU9HVytBYlQ5VnVPNkNsb2dFVkxGRTc1K3hudCtzQm93?=
 =?utf-8?B?cGREYWVzbEcremNQRFdKUjUwL3A2ZWoyblVSZjlpY1dsdDVxN01zbWozUzJi?=
 =?utf-8?B?VzYrSXFlL09USlZ2TlhxcDIwYTFBc3gzM012T0laM0hVWitYaThzZEJXK2tx?=
 =?utf-8?B?WEtMcGtRcHhGRHpWT1VmcHdGVFNRK2JmSW8yWmZqV3k5aDFXZ1BUT1BFVFho?=
 =?utf-8?B?L3YxS09rMndMZnliU3pJTEFQSDllSno2eEdqZ3hWc01aTGEvV1pvcVZ2ZmRm?=
 =?utf-8?B?Q2ZjeFRjanpYSEtNbURUVG5BQWVVdW8xSXMyTW80QTdRSG1jcHhoOVlYanpi?=
 =?utf-8?B?eW9FMzlFMzJrUWVCODljcit5d3NZRm54NFNsa0U3dktZOVh1b0V5SGNaTTlk?=
 =?utf-8?B?ektRTWcrSktFZ3FuUUtaVlZ1MzIwSHhGWkhRd2t1aVR5aFZmOEVPbEZqQmNX?=
 =?utf-8?B?R05Hd1Fra0dIc1JBSGhxWDlkWkpRYTd1SnNTalprYjVEV3BDc1RnZWJ5YzFV?=
 =?utf-8?B?OE9BWXMyWmZmQ1ZxMFZZblFzWWZxTjVGeFp4em0xZmxrWnV6eE1wc3pJVGY1?=
 =?utf-8?B?c2pqYXVIVXpYWG5jRTgyemtiR3pDYlNSNVY4RmJqelh6aEJqY0NYd0sxMlRP?=
 =?utf-8?B?L3djZGZHdmdVLy9oZzV2emRvQWcwNjhjVWlyM1ZWYnhlVzU5NlhXcXo4aVhB?=
 =?utf-8?B?c1dWZkp4Z3I5THNHME5UVEpTQWZsNHBYb2EvNHAxOWgrclJTOWxORm5DU05Q?=
 =?utf-8?B?UDJIbUh0V1M4TGlWTm15RExHVEhSM0ZsTHpxZEFiY1FUeCtxVTNCT2dlQ0ZR?=
 =?utf-8?B?ZlBOQUhHM0NJSmxPaHcvcWFrRmNiM09ESGppL1hrYnN0bzU2QnMrS0J0Q2ND?=
 =?utf-8?B?ajEyUTFoNmRxMkZwZXhJR1pKNHJYbG9zYlhhWitVTWZVZlJycnRiSHlldHpR?=
 =?utf-8?B?TGZNQVd0dkIzNWpYODUwZXJkMmpTVGxXV3hDV0hPM1o5Q1ZRak4xZWd2WnEw?=
 =?utf-8?Q?fT8yD4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWZXQjc1aWRuK2ZsVjh6anBXR1p5SXROanBydkZqRW0wSHB6bjNoR0MwK3pa?=
 =?utf-8?B?RWpsbjFMcjlGNHpzU2JVT1g5dEErUWtPdjBDM2ZTRWVDYmxsK3NHYjE1dTNK?=
 =?utf-8?B?ZU5BRkFlTCtjNnA2a3NUblVHQ2IwU1RaQlRJMENaVVl6anRJN25qbEJHV1RZ?=
 =?utf-8?B?MWxlSWp3VWpUeEJoQXlVSFlqZWhQK2xlRWJjcldNeFRVRC9sV2h0SUtpVENP?=
 =?utf-8?B?eWN3UTUxenJqK25qWnE1bFliYk54d0NmS1VVc0ZYaExYN0ErdkdTVlJzZG14?=
 =?utf-8?B?MTA3ZnQ5cUZHc08zeHhiVFRTcWhHRHFqdE9OSURRaWpSekhUak01bWJzMWpY?=
 =?utf-8?B?RzJnRFFiWlI5NFViMDJzdEkweGJ0YzlHTGxSMWx0YlYwWkhncnE4SDFmTVg1?=
 =?utf-8?B?L1RhbUtDL2M1S0dXY2VreDNDWXhPRHlCaFVzRWdQeTBnWWxQcEdMdFJjaC9h?=
 =?utf-8?B?ekhDbFBTaklkYlZOcFlBdStZdWR0VmMzVE1majNFZWRMa3V4UUJaRjZibVQ4?=
 =?utf-8?B?bnd5TWUyS29ZclZKS24weW1YclVqaVBLK0U2cTdPWFNodUNZM2JIOEtuaGZD?=
 =?utf-8?B?ZnhMeEVkaVhKaEtaVXVkQlNWSEp4ekRjSWhHZkJGU3I1aGpWazZaMmdhTVZL?=
 =?utf-8?B?eHVrVmwwRVBTNDZwMDE1TUFEQk9aVUIwSFU0a1RwV1dpR3FKM3Fac1V0RzRv?=
 =?utf-8?B?K2UxQnFvTnU2K3pDdGFxM1YxaitNL2sxMUhwL0hiYythWnQ3SElzWE1rREIx?=
 =?utf-8?B?VWNBUW1lRjQvelRKbDN2K2h3L0JmT1JTMmgwU3p1MmV2dW54M1MxdnNXS1N3?=
 =?utf-8?B?bmlhVGkwN2hqbnNTUklGcDRhbWt2bVFnSHhabkVSczFIcHJTRlE3Tnc2U2gx?=
 =?utf-8?B?cmR2Rm54TXNzQ3JpQmhWWU16Tng1S0Z5OE5CQTBEc3o4VnNQRVBqaVZOcGQ0?=
 =?utf-8?B?ait1Q1M2TWJiamNqbzNIVXN5V0NSVndTd1M4bmJOdHRnSHdsYUlQVklMQm12?=
 =?utf-8?B?dzloMnpnRW9EVTlyVHVpa241VjRmdU91bjlkMmhNS0hJaVJiZGpvZ3F6akN3?=
 =?utf-8?B?RnlvUVBjcWpteGlKcjdiS1NRcHFOWEllc1U3WVBaR0V0Zk5FUG1vYi84RVBQ?=
 =?utf-8?B?VDdURUVCbEdyVG81RnNjZ3BMN3N4U0xQa2JkMmh6c3EzNW1rRGdRVTZDTGNq?=
 =?utf-8?B?TlhuQS8zMXgwTWMyV2dqU2FhOTVwRUlhYjhNMlFSN0RjQjYzc2VJc1Fxek93?=
 =?utf-8?B?Y00wcS94amZzWGk4QThPS3M5NUF1Vk9pUmdxRGdjbjBSTGJqL3ErLzNRTTJK?=
 =?utf-8?B?cTdDNVJGcUNMUkNRN2JHWnhESXp4aTk1WHp1NlFuQlIrdlpUMURtbFdFdG0w?=
 =?utf-8?B?cVZscUxxZ0JqdDFEeVREU1E3c0VNWjFpdlVxVm05Nno4SWRXRzZnUTI0eFJR?=
 =?utf-8?B?MVA1aHgyWWhpNSt0WFlaMG9OMm1GT1BUeWpNaU4rNUdlREdNTWwraGUvd0V4?=
 =?utf-8?B?MjVUY01oekhOY2VwMTFNMnIzQ0gvZERIRTdhTXhnNXR0NVFwZ09uRUxYL2pM?=
 =?utf-8?B?NXhWa1dnZkdLbWRFQVFVbmVBUU1pdis3RURCaGNnQUhkamhZQ2w4a0ZZZEpr?=
 =?utf-8?B?a2VxQTIyMmd5K1pGSFdKcXNyYWlZOFNRZFZiNUZNdlJtZHJIb1UybVU0Wlhz?=
 =?utf-8?B?QUpBK0k5M3VWeUZWUXVkMkgxeWcvUDIrbHl0dUR3QTVnU09xZk1mMVppZ01L?=
 =?utf-8?B?aEZFUWVRNjNCOWVhWVRmNWhkcjA4K0J4U3RZYmJRQldEYVFiaFJBVm11SHFE?=
 =?utf-8?B?REdmRHRwNk5MRXVJQlg4K0ZLa1g4RXlMK25YQzF0TXE2YVowdTV2QkRvdmdD?=
 =?utf-8?B?RnNEZ0tVQzZpbG1PNHZ4ZU8vT2d0R0RKVkU3MXdtaHNGeTRXVDZheXpvaHk5?=
 =?utf-8?B?V0U0SzhLeEpSSHpzZFN0eWFKN0c4QndGdWdEY2h2bkZYeEFzMVNGamV6NUkx?=
 =?utf-8?B?KzBsRGdCNHNHNS8zNHFhalhIWEhaVkwxWXhoR0R1Mis1eDhKQVlPcDhNb3dL?=
 =?utf-8?B?RnM0Z2h5NlVsSkNNRnNSb3N6MVhBaTBJYURrenJsT0ozWWplNDIrV2l4QlRT?=
 =?utf-8?B?b01TNmtzY3pjVEhscnVLYkNVWXhBUVBBWnJZKzZVRW9EM2JvU3E0b0hsbEho?=
 =?utf-8?B?TEJkL2RXWjk2eDRLZ21iTDdDQTk2RmRBeXZaTUFOY0IzazVkMHF6eWlmNlVn?=
 =?utf-8?B?T0ZEU2o1UkJPM0xHSzhVTUhFL1MyRk8ycFF6NjZnTFhjME0xYVpzTEFBZ2dI?=
 =?utf-8?B?cnBmWUM2SWtPT0NqMEpNZ3BIZFdTMzFFK0tkL1ZHd3F2Tk9qaGlRZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2735c59b-1452-4e7c-07a1-08de51b4ccc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 08:30:10.4686 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ku3NXreJxvgT7/s5A7sHH5ziVHF/fz9OEOUaFJJxFtd3iWxLlbocABcXm7YGzTzoDNiy3mC29SKgUB9lHDKNLeuTUJyUxNBdCDd+GJ67tQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5033
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBGcmlkYXksIEphbnVhcnkgOSwgMjAyNiA5OjI2IFBNDQo+
IFRvOiBLYW5lIENoZW4gPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNvbT47IFBldGVyIE1heWRlbGwN
Cj4gPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47IFN0ZXZlbiBMZWUgPHN0ZXZlbl9sZWVAYXNw
ZWVkdGVjaC5jb20+OyBUcm95DQo+IExlZSA8bGVldHJveUBnbWFpbC5jb20+OyBKYW1pbiBMaW4g
PGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT47IEFuZHJldw0KPiBKZWZmZXJ5IDxhbmRyZXdAY29k
ZWNvbnN0cnVjdC5jb20uYXU+OyBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1PjsNCj4gb3Bl
biBsaXN0OkFTUEVFRCBCTUNzIDxxZW11LWFybUBub25nbnUub3JnPjsgb3BlbiBsaXN0OkFsbCBw
YXRjaGVzIENDDQo+IGhlcmUgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gQ2M6IFRyb3kgTGVl
IDx0cm95X2xlZUBhc3BlZWR0ZWNoLmNvbT47IG5hYmloZXN0ZWZhbkBnb29nbGUuY29tDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMTQvMTldIGh3L2FybS9hc3BlZWQ6IGF0dGFjaCBJMkMgZGV2
aWNlIHRvIEFTVDE3MDANCj4gbW9kZWwNCj4gDQo+IE9uIDEvOS8yNiAxMDo1OSwgS2FuZSBDaGVu
IHdyb3RlOg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiA+PiBTZW50OiBUaHVyc2RheSwgSmFudWFy
eSA4LCAyMDI2IDY6MjQgUE0NCj4gPj4gVG86IEthbmUgQ2hlbiA8a2FuZV9jaGVuQGFzcGVlZHRl
Y2guY29tPjsgUGV0ZXIgTWF5ZGVsbA0KPiA+PiA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsg
U3RldmVuIExlZSA8c3RldmVuX2xlZUBhc3BlZWR0ZWNoLmNvbT47DQo+ID4+IFRyb3kgTGVlIDxs
ZWV0cm95QGdtYWlsLmNvbT47IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPjsN
Cj4gPj4gQW5kcmV3IEplZmZlcnkgPGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT47IEpvZWwg
U3RhbmxleQ0KPiA+PiA8am9lbEBqbXMuaWQuYXU+OyBvcGVuIGxpc3Q6QVNQRUVEIEJNQ3MgPHFl
bXUtYXJtQG5vbmdudS5vcmc+OyBvcGVuDQo+ID4+IGxpc3Q6QWxsIHBhdGNoZXMgQ0MgaGVyZSA8
cWVtdS1kZXZlbEBub25nbnUub3JnPg0KPiA+PiBDYzogVHJveSBMZWUgPHRyb3lfbGVlQGFzcGVl
ZHRlY2guY29tPjsgbmFiaWhlc3RlZmFuQGdvb2dsZS5jb20NCj4gPj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2NCAxNC8xOV0gaHcvYXJtL2FzcGVlZDogYXR0YWNoIEkyQyBkZXZpY2UgdG8NCj4gPj4g
QVNUMTcwMCBtb2RlbA0KPiA+Pg0KPiA+PiBIaSBLYW5lLA0KPiA+Pg0KPiA+Pj4gVGhhbmtzIGZv
ciB5b3VyIHN1Z2dlc3Rpb25zLiBJIGhhdmUgcmVmYWN0b3JlZCB0aGUgYnVzIG5hbWluZyBsb2dp
Yw0KPiA+Pj4gdG8gYWxpZ24gd2l0aCB5b3VyIGNvbW1lbnRzLiBUaGUgZGVjaXNpb24gbWFraW5n
IGZvciB0aGUgYnVzIG5hbWUNCj4gPj4+IGhhcyBiZWVuIG1vdmVkIHVwIHRvIHRoZSBTb0MgbGV2
ZWwsIGFuZCB0aGUgcmVkdW5kYW50ICJhc3BlZWQiDQo+ID4+PiBwcmVmaXggaGFzDQo+ID4+IGJl
ZW4gcmVtb3ZlZC4NCj4gPj4+DQo+ID4+PiBIZXJlIGlzIGEgc3VtbWFyeSBvZiB0aGUgY2hhbmdl
czoNCj4gPj4+IDEuIEFkZGVkIGEgYnVzLWxhYmVsIHByb3BlcnR5IHRvIEFzcGVlZEFTVDE3MDBT
b0NTdGF0ZS4gVGhpcyBhbGxvd3MNCj4gPj4+IHRoZQ0KPiA+PiB0b3AtbGV2ZWwNCj4gPj4+ICAg
ICBTb0MgKGUuZy4sIEFTVDI3MDApIHRvIGRlZmluZSB0aGUgbGFiZWwgZHVyaW5nIGl0cw0KPiA+
Pj4gaW5pdGlhbGl6YXRpb24gb3IgcmVhbGl6ZQ0KPiA+PiBwaGFzZS4NCj4gPj4+IDIuIFRoZSBi
dXMtbGFiZWwgaXMgcGFzc2VkIGZyb20gYXNwZWVkX2FzdDE3MDBfcmVhbGl6ZSB0byB0aGUgSTJD
DQo+IGNvbnRyb2xsZXINCj4gPj4+ICAgICAoQXNwZWVkSTJDU3RhdGUpLg0KPiA+Pj4gMy4gSW4g
YXNwZWVkX2kyY19yZWFsaXplLCB0aGUgY29udHJvbGxlciBnZW5lcmF0ZXMgdW5pcXVlIG5hbWVz
DQo+ID4+PiB1c2luZyB0aGUNCj4gPj4gYnVzLWxhYmVsLg0KPiA+Pj4gICAgIFRoZXNlIG5hbWVz
IGFyZSBwYXNzZWQgdG8gdGhlIEFzcGVlZEkyQ0J1cyB0aHJvdWdoIGEgbmV3DQo+ID4+PiBidXMt
bmFtZQ0KPiA+PiBwcm9wZXJ0eQ0KPiA+Pj4gICAgIGR1cmluZyB0aGUgaW5pdGlhbGl6YXRpb24g
b2YgdGhlIGJ1c2VzLg0KPiA+Pj4NCj4gPj4+IFdpdGggdGhlc2UgY2hhbmdlcywgdGhlIG5ldyBv
YmplY3QgaGllcmFyY2hpZXMgYW5kIGJ1cyBuYW1lcyBhcmUgYXMNCj4gPj4gZm9sbG93czoNCj4g
Pj4+IEJNQzogL2kyYy9idXNbMF0vYXNwZWVkLmkyYy5idXMuMA0KPiA+Pj4gSU9FWFAwIChMVFBJ
MCk6IC9pb2V4cFswXS9pb2V4cC1pMmNbMF0vYnVzWzBdL2lvZXhwMC4wDQo+ID4+PiBJT0VYUDEg
KExUUEkxKTogL2lvZXhwWzFdL2lvZXhwLWkyY1swXS9idXNbMF0vaW9leHAxLjANCj4gPj4NCj4g
Pj4gVGhlIG5hbWVzIGluIHRoZSBvYmplY3QgaGllcmFyY2h5IHNob3VsZCBub3QgaGF2ZSBjaGFu
Z2VkLCBvbmx5IHRoZQ0KPiA+PiBidXMgbmFtZXMgZXhwb3NlZCB0byB0aGUgdXNlciBhcmUgaW1w
YWN0ZWQuDQo+ID4NCj4gPiBTb3JyeSwgSSBtYXkgbm90IGZ1bGx5IHVuZGVyc3RhbmQgeW91ciBw
b2ludCBoZXJlLCBzbyBJJ2QgbGlrZSB0byBkb3VibGUtY2hlY2suDQo+ID4gIEZyb20gbXkgdW5k
ZXJzdGFuZGluZywgdGhlIG9iamVjdCBoaWVyYXJjaHkgaXRzZWxmIGhhcyBub3QgYmVlbg0KPiA+
IGNoYW5nZWQsIGFuZCBvbmx5IHRoZSB1c2VyLXZpc2libGUgYnVzIG5hbWVzIGFyZSBhZmZlY3Rl
ZC4gQmVsb3cgaXMNCj4gPiB0aGUgY3VycmVudCBvYmplY3QgaGllcmFyY2h5IHdpdGhvdXQgbXkg
Y2hhbmdlczoNCj4gPg0KPiA+IEJNQzogL2kyYy9idXNbMF0vYXNwZWVkLmkyYy5idXMuMA0KPiA+
IElPRVhQMCAoTFRQSTApOiAvaW9leHBbMF0vaW9leHAtaTJjWzBdL2J1c1swXS9hc3BlZWQuaTJj
LmJ1cy4wDQo+ID4gSU9FWFAxIChMVFBJMSk6IC9pb2V4cFsxXS9pb2V4cC1pMmNbMF0vYnVzWzBd
L2FzcGVlZC5pMmMuYnVzLjANCj4gDQo+IGFoIHllcy4gVGhlICJjaGlsZDxpMmMtYnVzPiIgb2Jq
ZWN0cyBhcmUgcmVhbGx5IGRlZXAgaW4gdGhlIGhpZXJhcmNoeS4NCj4gSSB0aGluayBpdCBpcyBm
aW5lLg0KPiANCj4gDQo+ID4NCj4gPiBJIGJlbGlldmUgdGhpcyBtYXRjaGVzIHlvdXIgY29tbWVu
dCB0aGF0IHRoZSBvYmplY3QgaGllcmFyY2h5IHJlbWFpbnMNCj4gPiB0aGUgc2FtZSwgd2hpbGUg
dGhlIGJ1cyBuYW1pbmcgbG9naWMgaXMgYWRqdXN0ZWQuIFBsZWFzZSBsZXQgbWUga25vdw0KPiA+
IGlmIHlvdSB3ZXJlIGV4cGVjdGluZyBhIGRpZmZlcmVudCByZXN1bHQgaGVyZSwgb3IgaWYgdGhl
cmUgaXMgc3RpbGwgc29tZXRoaW5nIEkNCj4gc2hvdWxkIGNoYW5nZS4NCj4gPg0KPiA+Pg0KPiA+
Pj4gSSBoYXZlIGFsc28gdmVyaWZpZWQgdGhhdCB0aGlzIG5hbWluZyBjb252ZW50aW9uIGRvZXMg
bm90IHJlcXVpcmUNCj4gPj4+IGNoYW5nZXMgdG8gZXhpc3RpbmcgdGVzdCBzY3JpcHRzLCBhbmQg
YWxsIGZ1bmN0aW9uYWwgdGVzdHMgcGFzc2VkDQo+IHN1Y2Nlc3NmdWxseS4NCj4gPj4+DQo+ID4+
PiBJZiB5b3UgaGF2ZSBubyBmdXJ0aGVyIGNvbmNlcm5zIHJlZ2FyZGluZyB0aGlzIGFwcHJvYWNo
LCBJIHdpbGwNCj4gPj4+IHN1Ym1pdCB0aGUgdXBkYXRlZCBwYXRjaCBzZXJpZXMuDQo+ID4+DQo+
ID4+IFBsZWFzZSBzZXBhcmF0ZSB0aGUgYnVzLWxhYmVsIGNoYW5nZSBmcm9tIHRoZSByZXN0LiBJ
IGFtIGV4cGVjdGluZyBhDQo+ID4+IGZ1bmN0aW9uYWwgdGVzdCBjYXNlIHRvbywgbWF5YmUgd2Ug
c2hvdWxkIHVwZGF0ZSB0aGUgc2RrIHZlcnNpb24gdG8NCj4gPj4gdjEwLjAwIGZpcnN0ID8NCj4g
Pg0KPiA+IFJlZ2FyZGluZyB0aGUgZnVuY3Rpb25hbCB0ZXN0IGNhc2U6IGN1cnJlbnRseSwgb3Vy
IEJNQyByZWxlYXNlcyBkbyBub3QNCj4gPiBlbmFibGUgQVNUMTcwMCBieSBkZWZhdWx0LiBJIHRl
c3RlZCB0aGUgaW1hZ2Ugb24gb3RoZXIgcGxhdGZvcm1zDQo+ID4gaW5zdGVhZC4gSSBub3RpY2Vk
IHRoYXQgdGhlIEFTVDI3MDAgRENTQ00gaW1hZ2UgaW5jbHVkZXMgYSBEVEIgd2l0aA0KPiBBU1Qx
NzAwIGVuYWJsZWQsIGJ1dCBJIHJhbiBpbnRvIGFuIGltYWdlIHNpemUgaXNzdWUuDQo+ID4NCj4g
PiBPbiBBU1QyNzAwIEVWQiwgdGhlIEJNQyBpbWFnZSBzaXplIGlzIDEyOCBNQiwgd2hpbGUgb24g
QVNUMjcwMCBEQ1NDTQ0KPiBpdCBpcyA2NCBNQi4NCj4gPiBUaGlzIHByZXZlbnRzIGRpcmVjdGx5
IGxvYWRpbmcgdGhlIERDU0NNIGltYWdlIG9uIHRoZSBFVkIuIEFzIGENCj4gPiB3b3JrYXJvdW5k
LCBJIGNvbmNhdGVuYXRlZCB0aGUgRENTQ00gaW1hZ2UgdHdpY2UgdG8gbWF0Y2ggdGhlIDEyOCBN
Qg0KPiA+IHNpemUsIHdoaWNoIGFsbG93ZWQgdGhlIGltYWdlIHRvIGJvb3QgYW5kIHByb2NlZWQg
d2l0aCBmdXJ0aGVyDQo+ID4gdGVzdGluZy4gSG93ZXZlciwgdGhpcyBmZWVscyBsaWtlIGFuIHVu
ZXhwZWN0ZWQgYW5kIG5vbi1pZGVhbCBhcHByb2FjaCBmb3INCj4gdGVzdGluZy4NCj4gRGlkIHlv
dSB0cnkgdXNpbmcgdGhlICJmbWMtbW9kZWwiIG1hY2hpbmUgb3B0aW9uID8NCj4gDQo+ID4gRG8g
eW91IGhhdmUgYW55IHN1Z2dlc3Rpb25zIG9uIGhvdyB5b3Ugd291bGQgcHJlZmVyIHRoaXMgc2l0
dWF0aW9uIHRvIGJlDQo+IGhhbmRsZWQ/DQo+IA0KPiBXZSBjb3VsZCBhZGQgYSBuZXcgImFzdDI3
MDAtZGMtc2NtIiBtYWNoaW5lIHRvbywgaWYgaXQgbWFrZSBzZW5zZS4NCj4gDQo+IFRoYW5rcywN
Cj4gDQo+IEMuDQoNCkhpIEPDqWRyaWMsDQoNClRoYW5rcyBmb3IgeW91ciBzdWdnZXN0aW9uLiBB
ZnRlciB1cGRhdGluZyB0aGUgZm1jLW1vZGVsLCBJIGhhdmUgc3VjY2Vzc2Z1bGx5DQpsb2FkZWQg
dGhlIEFTVDI3MDAgRENTQ00gaW1hZ2UgdXNpbmcgdGhlIGFzdDI3MDBhMS1ldmIgbWFjaGluZSB0
eXBlLg0KDQpSZWdhcmRpbmcgdGhlIEkyQyB0ZXN0IGNhc2UgZm9yIHRoZSBBU1QxNzAwIChJTyBl
eHBhbmRlcik6IHdvdWxkIHlvdSBwcmVmZXIgbWUNCnRvIGFwcGVuZCB0aGlzIHRvIHRoZSBlbmQg
b2YgdGhlIGN1cnJlbnQgQVNUMTcwMCBwYXRjaCBzZXJpZXMsIG9yIHNob3VsZCBJIHN1Ym1pdA0K
aXQgYXMgYSBzZXBhcmF0ZSBwYXRjaCBzZXJpZXM/DQoNCkJlc3QgUmVnYXJkcywNCkthbmUNCg==

