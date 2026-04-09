Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14B1E98FA4
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 03:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAfoK-0002jY-Mi; Wed, 08 Apr 2026 23:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wAfoJ-0002jG-CP; Wed, 08 Apr 2026 23:12:03 -0400
Received: from mail-koreacentralazolkn190130003.outbound.protection.outlook.com
 ([2a01:111:f403:d40f::3] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nutty.liu@hotmail.com>)
 id 1wAfoH-0006rd-MM; Wed, 08 Apr 2026 23:12:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o8p6e6zasEVfKKG7/DPqrXnEH3Zw0kers2JeFjBs+zlGzmQKNGUohgT7KecxagKE8s5NZf+WQsVICAfnsjH/Je0SHbWKF5BizAy6qDv5Pa8i4FIfUpANd9LrZ7zalVQOlyLqB899LZYtVybnAPX0PVbLP5JFJT6aruz9QuG9cpphs7CcTKFCulnPLT3p8ZClM/rAERPjReODN8CqHkgBvmOg9dviw1qNU60/34qbYanXJY7HA2QGMt1Wf8DQp5MFt2z5thvBgWANvjOS/538A6uwVk6gvbJ3g53qTrgfFevAj5PWRmn248naGh/EGrX7Qx2Idw8boqa57EGjA5ruDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzVO4sgSEB9nekjeeC9hvFObTA2uoJroRM9NERdOA+0=;
 b=A4X7RLrdL6nT2MgBGQK6wEXiZP3SZYfJl1/djBx0cXCAeamHCXwNPWDkTRX7FgS+P8m2iwF69b+AbveHYNNzBJUI8CmQrp/fHU5WcCKNyF+rl6py9Ovt59nikZMf5xld3mHIOZOUE0oTnXuNZM+AZK2wcuc/ko2GHP+8usF2V7u6rJYoBb/ShgXZ2IzSBH6JqtF0DMSiNMEJosQg6tEygDxdJ4/WXmnsN3sXPX71CQ2wmEM4+8g+wR7j5oVUettJp1yc7T2SFhrDdkrigXIjjoSpIqI8I9RKQsYCQdF2KH6VV+x7+uJQuu6GYsZaBPKEFsWp7XKY3ZNXB8P6PGwlDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzVO4sgSEB9nekjeeC9hvFObTA2uoJroRM9NERdOA+0=;
 b=EsOJbH7sFpz3r08A/1D2F2Jh3O2Z0BaBIHtYktiobdB1SpnhvllzZ/kAz9yZughFZLcky4UyR90HcSu987UmoVS+gdCVik+WSG19F20KraiCEBzvOkTohvaVLR4jrCICn23cArE8iogyNKgQYPw4W0GUbgcRZl3lC7OVt3jH63KOq+btFwwWgTMdqK5+hGcDoFz5cVKMmaqwH1NJ8StfyTwUfBeoQo0cPqlDzwQhvpOwTNSmQTSdNdnLkaB0wGGz+UZfK9VD7bfvGjqgwBvu26dSOYy0sJklwGynLoakwhO03RZZDz7piXxiGop7thjp9HWg6QycsNItC/GYFdScIA==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by KUZPR04MB8864.apcprd04.prod.outlook.com (2603:1096:d10:27::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Thu, 9 Apr
 2026 03:11:53 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%6]) with mapi id 15.20.9769.017; Thu, 9 Apr 2026
 03:11:53 +0000
Message-ID: <SE3PR04MB89223BDEA32413CF6A75C1F5F3582@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Thu, 9 Apr 2026 11:11:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] hw/timer: ibex_timer: Update IRQs after writing CTRL
To: alistair23@gmail.com, palmer@dabbelt.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20260407043614.372871-1-alistair.francis@wdc.com>
 <20260407043614.372871-5-alistair.francis@wdc.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260407043614.372871-5-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:196::18) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID: <ccccfb80-b7f6-40b8-b6e5-916e61196071@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|KUZPR04MB8864:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b136a2b-feaa-4143-9792-08de95e5bf71
X-MS-Exchange-SLBlob-MailProps: P1EfU6pZOd8VPwDsmXmpSwyPl9aRR8R+aSWSzu5U11yuqlvfYk+/Kkz+3eKri0CLPA8kz5NM3jz80Oe53b8B1/YjzlPfFVAtwNp0TDBGWqvJHHaIXVyNQd1m/Lj2yZbTObe3epDN5jtgU+jlvassmsDMrOCUgMQ6kf1f7DXBJda8QFE3YXCRyqEA7Bqo+VdC//0ttbiQirSjYfL5LPN8sCRJxk+TOrMK91zmCgSeXHI4YKiCMZRoufkZlwqeLCv+AakKGGFDTcwFbewrFj88CgrcgApn4WaCG/kv4pSt8yEl9N26cqTKvAymEKyu5yhBJv5GsJHZzgLHfARyfZaFWPpZPRBBbGyYWC7g9VUO+XMla8TR+POY+RFdchPBH0uBdQ1UcoYVk9mLdeiR/H4G7OsS4HMD0OryUcIy3tVREeSBBl3Pfnd5VBkaWg0ZLWhK5n3hZVc2tUIAsvraUtdLqM5yOlVVFI75IQaL7SWt11A7b5PkE1E5wbTPSWLk+PS6JraHWEj9HseJ6JAMA1xY5gKBU3e8g2UmN/fIMZmLxJzH6iruV4/Hf9Dd+seg4NILrKv7SIQc4vS7bHC/CioeciOPzOXUzTwk1klww1VZTXFGYv4hQBbgL1iozNQkkDO09ZSUuCJyd2QXvLbHzG9zuhxR7x9CfZ+inAN0b9jR00HnCnJMFJ7q8YjphxxnGjjfFaMiWRDvwTq4hNRH6VKxcJNPq+B+f1Vdc20283NY76+auuCEUOhxOzujJti1tvDEJCug/iWKA4Be9c3vV0SBGlH7XGYNTVgt7OgWOB/4H7J3MLlDivTiNg==
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|19110799012|8060799015|23021999003|15080799012|51005399006|21061999006|5072599009|6090799003|1602099012|40105399003|26121999003|4302099013|440099028|3412199025|10035399007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlVHNUZJVUlJV3dlQ3pmTUpPbVBuZytLbUQyUCsxME9NMHVpUjN6S0hBU3Rp?=
 =?utf-8?B?WFJ3bzU1Tm90bnlLYStJM3Q1U1BIYWo2YzZWYUdMajYvRHZ0MHErMzV2UUZH?=
 =?utf-8?B?azhtS3liMWtCeDRFRW16NzVGNU9tSmt0eDl5WU1tdmhJYy9jUVE5UGtNdHZ2?=
 =?utf-8?B?U1JYOTU2Qk55UWYxWEZoVTFRc1VNVWFMallYb000cHVwTzh5VVBqVGdIUmIy?=
 =?utf-8?B?Q2ZLUzNJcDFWM3VJbjN0ZVlGd2ZPRm5LZEtEWERhNTJqWXFuaFB1SWMrTmV3?=
 =?utf-8?B?akhaTkw2UXZQUC9EQWpPMUtzaGh6OWEvbmtkY09HTlZYQTAvM0w3Zld3YTAw?=
 =?utf-8?B?Nmh2VVp5OGJ1RkFNWkdLUGJSNDZIeW1kbU1HeVc1eTRhWmd1WTYwd2ZxR0tK?=
 =?utf-8?B?ZnVBdzdOZ2o4UlZoNDMwVkxBMmtKOXJTWXVBQWlzWDZQZE5iaCtTSk51RkR0?=
 =?utf-8?B?ejMxUWd5bVpqU2pkazlHeG81aXRKYlp2SkhKcVN1Yy9zK0ZBeG96QmVVaU5n?=
 =?utf-8?B?OEZUMkRsWURCS1I4TXNvMjMzWHRwNlBDOUVjUXVRY0VaczRWemdjMkorMnlW?=
 =?utf-8?B?d2JicmNab1NFL0V4VmpNWHNJZ3g3Vm81S2VGM0krUmZBL0loa2NWK2hiMENz?=
 =?utf-8?B?VXJwd2xpczVSRk53cW1zcm9OcE90U2xMVng4TWdYdS8xNVdWM1pYU2RLNnF4?=
 =?utf-8?B?bEJUaVpnNnJXQ2s0ZDAreUliRitLN1k4MDVxNkRQMG4xakFsdVkxSG5VeWFB?=
 =?utf-8?B?b3BvNkkrVHNCN1NOWE1KSWZRd2tsYU5vTnMyT0VvM0luNlowa00wNnM2YzhX?=
 =?utf-8?B?bzBteGtTT3RXTjU1WU9maU4ySVI3U015a0djcHZ2TXVLUTZsZXlUV2xWUm9I?=
 =?utf-8?B?aHI1RHhoUWZYNkZqUElmeTdtRitKTTFSZUJxUVNkQUZ1QVF4TXhydzVWekxx?=
 =?utf-8?B?TUFQOVRnVVUrVEhncGIyaW4yMUNIRHRnK0hqaUIzWnZaSys2cHE0eXpuTHRD?=
 =?utf-8?B?RFdmbUxRUFRFM2dZVnhBR2dJNWhoZHYveXAxVW5tb3FKNU9EbUQ3Y1FxMWtB?=
 =?utf-8?B?d09Nc1UyeDhrZTNNVnMwL001ZWVRWVFZaTBpWEZhb1dwcDNFOUVzRmxtOWpF?=
 =?utf-8?B?d2NNcTFHblBYQnhvUGhPNU5uL0tGQlozSmg5ZDRVM0t4ZFdPS3ZXSWU3NWtT?=
 =?utf-8?B?S095ZDJNZEs5YkZiS3VLUWF5RTZ2RkEvYnRsZi84cXdabjFpMUpqV3JJVXpa?=
 =?utf-8?B?QjBRc1ZMTldEbUJZYkRuVU11RGc1eloveDRzNWhiWHRQZHIvekRyR2dMak51?=
 =?utf-8?B?MDhZRTFmaDR3SUVTRzAwalp6VDVQaWJYUmRISEFNb2JuRmk4QlpQQ1dSamRy?=
 =?utf-8?B?NEd3VmZMSVF5ZmJUQ011RlRyd3RxSEdGTDZCQk9qV2h4Z0Yxc1VCNm10T2c4?=
 =?utf-8?B?UFNXVDFqajBVeUEvaDNyNXVCWHpDSVJNWGh3UG5BPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekVuU2ZDeFFXWS9IRGxiN1hGd0xSc2c4M29IRFdUUEl3cDUrVjlMQTVXeU9n?=
 =?utf-8?B?TEhjdXhxL2ZhMWJIS1QwRXdncTVvSDhrMEFRTkFDWllBaHhKbEsrVmtLdTE5?=
 =?utf-8?B?c1hSZmFUbW1FaEh1eHJHeDdhTW0vN2F2NU9HdndlY2JlbldaSVpqMzRDR1hk?=
 =?utf-8?B?czhha1JzNFJ0amdaTnhqZWpNSWdwakVxNW1Uakp2L1FPeTM2Q1BUbCtEcnJ6?=
 =?utf-8?B?M2h5czNScmMyZzR3RVBEcEgwVm1HZlh5OWE4a3Y1ZGVYUDYybVhaeUJHOWxQ?=
 =?utf-8?B?aERzTlVIeEpCTW5nR1ppdnRzak5EU090ZEhYam5rd3Q3dUNFVWgvR3pSd3Yz?=
 =?utf-8?B?bGR0L2N6ZGpPOC9TMXkyN0d1Tm1CNUs2aEFtanZEVm80SmNYRHIrOGcyTDRJ?=
 =?utf-8?B?VjRSOVcrNlg4VDNIRjV2aGZhMkNhTHpMQk9mZ0tHTnZGK2RoWWUxdXRZOWJC?=
 =?utf-8?B?UFlpSXkvNG5XS0lNaDNCWG5wMEcveExnUEI5TE9qUnNqdHh1ajFHeFYwQUFG?=
 =?utf-8?B?RkVJSCtBNGNacnIzOUg2eXZybU9LZ0JNT2hxYUtLbXkwZ0hqQWpMZDNSUDdl?=
 =?utf-8?B?UmhGRS9qN0d6SjZnUUdlTG9HUVNheGdlNHByV3FKN1pTUWdsZUtGQWRMbU5H?=
 =?utf-8?B?TXhTTVNEK01HUDQwRHNzMXRRaXIvVEp1T01GZi85VHdlbVY4M3EwMllDT25J?=
 =?utf-8?B?VzNJM0Q0YnYxREs1Q0lmRVNrR1NabWVlcFEwLytiZ1FIUHBMOWNyQnVVdG4r?=
 =?utf-8?B?UHlQTndJN1hwQWxJeS9ZMGl6UlhjMXZsTkJUbm1kbnllTlVBeG85U3U2Q2c5?=
 =?utf-8?B?OGlEKzZoZDA1akY2N2dUM08vRDZEei9SRDdRbXNyMGZaVzRJY2hNaElKM01v?=
 =?utf-8?B?N0Fnbm5VQ1VTZGwwQkdENHhGZUxGZWk2TUwzR3dOZ2lNTDRkdlJRWG1BYWNZ?=
 =?utf-8?B?Zkk0Q2xscHdUZmVhS0p4bCtsK3ErNDFIR0tOQWFnMkIrOHZsdWNuZmw1bWt0?=
 =?utf-8?B?U3diZTVQOVQxbGNLU0czeGUyK3V1YXNBZ2Y5UUljRkVQckhabDJWVTQ4aFhY?=
 =?utf-8?B?NTZqRFc1MzNIdzBVeURCaTlmZ0IxRjZIMEFSNVdnUExrK3NwSUluVW1ramQ1?=
 =?utf-8?B?UFp3U3VxbDRFWXZ4L3JqTVZ0ckRORmhvajVGMkdyKytJclZaLytvam5IOUFr?=
 =?utf-8?B?NzR5Ri8rdnFIc0RLMGVCTWlqT2YwSHZLNUc3eXQzWDM4WmYvNGVKZENUejNC?=
 =?utf-8?B?VmIwYlJNeHRVSy9SMG1aakRjUGdMcTl0MHdiVTJWektMSjRDMnh0YnMyL0Uz?=
 =?utf-8?B?dzg1YVoyYy9uUVV4cFVFVlVDWTV1YldpcHlNeEh4eEdkVkFIUCtFQ1NtSWc2?=
 =?utf-8?B?RkpNQThYSWdXSGdNTlVDZjlJNXZhR04zR0JoNE90Z2pCK0lyUzhaYkpDSDN5?=
 =?utf-8?B?dVIxUHVkZnh0b1QyZHN5WlBXZjR5SUN4M1VYQjVBVElNSzR2MlpielRQalBS?=
 =?utf-8?B?bXYrSHZWUXFDL0hid2lITVF2Zi9sTjZRQmF2MUQ5dE1aaUphZUJScU9ldmlt?=
 =?utf-8?B?a0JmZENKNUFONmR0MG4xWWRiOG5rSGVKbStZazRkUGxUeGFVRENKOUVSYW1L?=
 =?utf-8?B?MUFpSjdnSXYvS1NTKzRuOE9iMCtkNW0yNWR5dFI3S3AyZUNKVVA2VGxDeENq?=
 =?utf-8?B?NWhOY0NtcjFxTWF5blJlRlAwM0NWTGd5bksyTTJkNEkyc2EvWFBJa1FwOC81?=
 =?utf-8?B?dEFzK0RsM0hTYy9LNkkyOTNTd3MzUUFka2tIZ0xjRERITm4wbHFrdXM0My9C?=
 =?utf-8?B?M0hHeTJGVUN2TEhqeW9RRnJrcVlJY2FsQVVpMFE1TEJmUzJzeGNwcmRHdVdw?=
 =?utf-8?Q?+mIbI/kYb5O5D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b136a2b-feaa-4143-9792-08de95e5bf71
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 03:11:53.1577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR04MB8864
Received-SPF: pass client-ip=2a01:111:f403:d40f::3;
 envelope-from=nutty.liu@hotmail.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 4/7/2026 12:36 PM, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
>
> When writing to rv_timer.CTRL after setting the compare values the timer
> doesn't fire as we don't update the interrupts. Ensure we update the
> interrupts after a write to the rv_timer.CTRL register.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2796
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   hw/timer/ibex_timer.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/hw/timer/ibex_timer.c b/hw/timer/ibex_timer.c
> index 0f12531934..571633803d 100644
> --- a/hw/timer/ibex_timer.c
> +++ b/hw/timer/ibex_timer.c
> @@ -193,6 +193,7 @@ static void ibex_timer_write(void *opaque, hwaddr addr,
>           break;
>       case R_CTRL:
>           s->timer_ctrl = val;
> +        ibex_timer_update_irqs(s);
>           break;
>       case R_CFG0:
>           qemu_log_mask(LOG_UNIMP, "Changing prescale or step not supported");

