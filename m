Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4751CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMnA-0002xL-Gq; Wed, 07 Oct 2026 04:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEGhD-000600-4J
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:44:07 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEGh8-0001Rq-5M
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:43:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQtSIZWNsKqX0B2zYgI4orlQ5dZklofuxQOPVF4p31r66iTx1My/mHF+CnGWwY+XaBKJXhdlqAycagiGU8+mvxIxmwyZrH14IdEeQGRRpGTPWW4e/9gv8wbbxxTBY0OYTUiruvVq+G+qTZat6j3+5STmhb38mBPp1DaCnBuVDfowksFCYHOzTAMxbWcHYMo4yt637VKZjywZy/Twzz+1X3RTOlXKd6UQLft6gDOrXFyR888/DtEpDWRYZ/MGvZy5t/o7iepJKtYvqH/xEAcSfsQbuAPf9UmeQLAI2+A+Cjf4DVmwutluitklARAF5WfbRHMIe24nAb//yfWl/hkIRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOcv9wIwlBYPyIObGjCTbm2fFWrEwKrhmMrmSrbg0IU=;
 b=OZExiTX1cZ9qZiPucWpHNyOMQ8zyOggj4q8aKN+cBrhvJSEIWstLWq8H0zYQ7rvv6ASFqXSsyir/DY2K1PAUc2a0w1w/vNimqEldRCy7UHoy6TluezYHuukDhAH+oidbA9eQc+Choc6DVVqjYxs1zTLP4an/IqCkJj3yGknychB0tZBy9m5h5Er6X6PNJ3Ns5FWN0QsS7LI3R1hXbnxJeLOFHKXJVuwPiJIvNn2V7ufkFa14NNFHa1ecCJU62mX2PPxXf32zeXeKwMbJY2v9vBkm/ny0fL23DqmWOUPXYEH59+ODUBtDz6yktjpG+zshKqaFfs25dJZq9vvDw73L4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOcv9wIwlBYPyIObGjCTbm2fFWrEwKrhmMrmSrbg0IU=;
 b=laiyR7z0Vbb9YXf0rxCXeC0t1g5c1eaBtY5/+qdLlf1LHydXVgUZzprNgTM2VsGuomrt4HhHRU5xLH8t3ARA4POXVRJhAG02NApOhIo2Elyp4ZAYyUoPlk0RHG/u7r3LfMjGB0iKz0TM+W7tBIDTM+pJ/LA9118UPLNDWincabLLwnHpFNc6CfsvaegwAjnAfbFtdJw2cf3B/eW3jkgaHt/ROOBURVBgoCVXQ8LYsEc4KlOdsbT3Yb6VDWGJsqD5yQTXeB+Uavz8XxCuU83aVR/yYkitJVTdSD5yYfuAVE5/W2DDVEkUuQGF9WUZ7D2oCVNpioXB2dylykrY85j/fg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS2PR08MB9392.eurprd08.prod.outlook.com
 (2603:10a6:20b:594::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 15:19:31 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 15:19:31 +0000
Message-ID: <21631cbe-5b7f-42dd-90ae-e2266fba6f4c@virtuozzo.com>
Date: Tue, 6 Oct 2026 18:19:29 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 16/22] migration: add incoming migration failure
 notifiers
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, maciej.szmigiero@oracle.com,
 odaki@rsg.ci.i.u-tokyo.ac.jp, dwmw2@infradead.org, dongli.zhang@oracle.com,
 bchaney@akamai.com, den@openvz.org, farosas@suse.de, clg@redhat.com,
 mark.kanda@oracle.com, vsementsov@yandex-team.ru, philmd@oss.qualcomm.com,
 sgarzare@redhat.com
References: <20261006-up-vsock-vhost-v5-v13-0-2ea78fd1b7ed@virtuozzo.com>
 <20261006-up-vsock-vhost-v5-v13-16-2ea78fd1b7ed@virtuozzo.com>
 <asUCSERCr0EkHu4j@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <asUCSERCr0EkHu4j@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZRAP278CA0015.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::25) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS2PR08MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: 51e450a3-b9d9-4103-8d7f-08df23bd3891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|18002099003|22082099003|10067099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: xNfY9zqh4wqtq77lfcmB7oH71VmjMFWg2KgcU59/2lGSde9NNINMAgx9CWhAD5zAikHPs59F927ofoXCsLQIFvP/Lx38Jz94TCt2kVMn3dts3tsjy7AXL+XkVt1+5m4yJOyD/B2SyFsab0498MVeSj6YFosHKnvV86W9MBP1THbA6vuUu/M08caMSOOzeFNjH2CCKOhiwvY2Q1s80wNxKkqcAWf48s/GQANP5uTXiUP42gs2bFM745dyCAHYDgPC/hHYdxUwRnwPlbkL4mbCcwE6kK8kux23KB+/kAfi4gwtX3umf7JfKvYZPRrHG1B3IbYS+BUeloUGzilOjxqqmwPPn6AhGOBHCSnOnJMOGvW9398qkcEzNUhlEOFKF8ZTB1pqWLWJzUwDXG8YjMbNu3BKswCa7bS4B+3ynAphChPPcgBZBq/G4bwWUYZbBWu5NPHdMnNX4jdzNbdRb5QgmOxX8dAFmPUAciSTR4qVwrgMEWAD88xNhqdB0G33bYZ5CEv73yNok2sCetnR5iK0IObDjdSF1uH/PYvd5DsECeyUjn5V3x0N3fZe7bTsSWjJbguNVFazRBBvI92nsWiNKDzm3TgcgMfjhyxJD/qb00SW+L0Yrg8LxRdThuvfXvqg0l6/AzP1G5QqCNdRRruikdb1qJZ5MEM1d0QzPE6e1GY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1k2ZFptT2lEcXhmVnRvWUJlSHJOZkg1NzZkZEVRQ3JtdkdIZzNsc3N2bWxu?=
 =?utf-8?B?ZUFRajBUWDRuZkliS0xSRjhkT1JETStJUUZBQzZ2MmVpMFkzN0FtOHlKcFgy?=
 =?utf-8?B?NENnZHdwT0xmbDdkMkk0WjRpaWxNcWZUSlFEa2NILzJHQWRBMGhtKzB6UGxL?=
 =?utf-8?B?Tm9CZlM4WWxTa2kvTkxTOW5USXhOVElkVy9Wb2psMGdsRk9GbTN1M2lJUG8r?=
 =?utf-8?B?ZFkralk2aG5Ra25DSHAvME5kbzh6NnZRaUEyNVhiakhMMDFBdW9JTjNsNE5Y?=
 =?utf-8?B?bzhhRnhuK1RvK0p4T21XeG9valFVeTAyKzZRV3lzaFZzTDl0QzZqRGlzMGJi?=
 =?utf-8?B?N0xuTWVCYTQvT2JYOUxEbTZJQzF6UVM5YUwyQ2pVSnpWZlppcDZKWndBVko5?=
 =?utf-8?B?V3dscFRDNlVCV0FITCtQZ2RaK2hCcUgwQzl3djN6eG9yM3laTEh1RVFmODM5?=
 =?utf-8?B?YzRlQ010MVZoeGNLbC9kUFZWVGhQL0RrZFEwNVBGWTVEalBiUVM3Tzk2Sk5x?=
 =?utf-8?B?Zm1yeUVSNlhjRUVLTHBnRVdtczJxOTVTOVZlM3dZQVI3Y2Z1c091OVNibTJ2?=
 =?utf-8?B?bzVpYjErN3ZhR0tHaGVycHEzTmtBN3ZPclpSMDBJZDduU0lpdU02N0pIcnY4?=
 =?utf-8?B?SzBMUHhxTk9wckoyOER4QzI3MWpURHN2ZW1TSnhKMDNjckxtWnV0TW9TWElN?=
 =?utf-8?B?RExMSW9PSHlzZlJoNjB5MHprM0pHbzdwRS8xV3M4SEVvRWpuNk56YU8wbnk3?=
 =?utf-8?B?YmxESEI0L0tBVWdqWUdxSklTaWZkSlZaMXIzZ1cydTEyV2g2Q0l2NjVSd1Ey?=
 =?utf-8?B?aHhoMW5XRDcrZXE3L0VXYXllVE1jZGk1YXdRdEp3MStqaXdSMjM1aGtLekgy?=
 =?utf-8?B?RVlZNndSbFlzV2tid1dLYWJCeWl1VDcyVnJkNWVNR3pMaGxWQXFPMGlHYzgw?=
 =?utf-8?B?U0NHamtzSk1KMzhLaFVOOFZlSHlqNFVRd3pmMXpTMmt1SzFEandlTzA0TE9Z?=
 =?utf-8?B?T04zbUd6bWdnMlg1UkFwUTJoZW83SitPbXZzQjRTTm1vL3c2NEo5dVprVzZo?=
 =?utf-8?B?NjNNSGc0R3dUSDJkRWkyWncweGt1ZGhSVlE3ZHR2SVBHYk1pY3dUMkdKUXpa?=
 =?utf-8?B?S3hmYmZ1ZG05cFhLaEh3bTNMeFg1M1VycGpnQWNNZXRsZGVLR0xCOEk4RTZ5?=
 =?utf-8?B?LzEyY2srQXU3MHBBS0Y3VjBGTkxMOUlGenE1VVozU1JmMjlNa0M5clFlQ1hC?=
 =?utf-8?B?VUg0c2pSeVA1ZUZ2QmFGSVE5dUZwckthY2I0Tit3WVRrbks1eVFmVVZxcVpq?=
 =?utf-8?B?ME9PSFNIZWRDd3orTUpjODJGenY1VnRYci9rNnJZbE9uWkYxdU1pUjFOWnI5?=
 =?utf-8?B?ZERqc3hiVkpDN1ZWNUVwOFFiWHNLZThHU2ppWEpLV2NmTTBILzJpbmlmNGlW?=
 =?utf-8?B?cHN0R0VLUG83eUxiMGtULzJyR2pJYWd0MVhlaCtnREV5WWVTaDQ2aUtQNk9Y?=
 =?utf-8?B?WGU0V0ExUm8zSmR1TzFuVXErYUhycVlIUFhmSDJsOUJEYm9VWis0cExseFk3?=
 =?utf-8?B?bWxNM1NFVTRFMHhRd3F5eUtCK3N3eU5iQk4yUFZxTjUvY09RNTY1WVphck9T?=
 =?utf-8?B?OVM1QUhHdVRyRXhMWk9vTkR2VDRaeWFZMk9IUVN2eFlvNFZnVFhpbjJZSnBY?=
 =?utf-8?B?MmVVNkdZT2J5cUlxd0xBcEpzdTFveEl5TUpXcGY4Mkw0bDk4eUEwQnVhY1R3?=
 =?utf-8?B?aWxoQlRPeUpua2ViZlZIV1hRb3luRE4rNW11NS80TnBxSkVhb3I1cUZCZjJW?=
 =?utf-8?B?ckROUjB1OXIzd1JMcjV5QjFTZnZwWUg3d0ZEV282TldObGlzV2Izb3dJUUI5?=
 =?utf-8?B?QWVwQkp3eG9KUEkwQWxSMDlqTFZnSWRtYkY1ODZranBIL2t0NVNEU3lGMDJT?=
 =?utf-8?B?TUJZZFMrQ2V6T2x5MFNpR204T2d2ekNwanIzMCs0bm9Mdm13K0FscE9mWXRJ?=
 =?utf-8?B?QmJoV1QxVjg4a3M1dnpqRUxDYmdIMEVhY3pkRnhtN0J0M3FpVVMrM3VtMDVh?=
 =?utf-8?B?cys3eXdqQUFjRHlsRmRNUzlvVE96ZWZvcm9yaWg5dGUrWUV3a3lWNFh0a0o2?=
 =?utf-8?B?aHBaMWMvS3lUZ2RMcHlxc2xHdVBKcnpxRXNxb2xoZC9SUHl3cnNjR0ovRGhZ?=
 =?utf-8?B?ZmQreWJHT1RXUWtrT3lpRmRHNmVsR3B2L09taFRGQndCSTZITTJEWmZRVnpJ?=
 =?utf-8?B?OGRWSUVpTC9OSVFaQ2ljQUxnMzhteSsrUjJ2T3paZDJCelY2WXJmQnhlMkF6?=
 =?utf-8?B?b2JDRnpHNE50YWI0NndyZ3B0WTJyQzdrcVV5OVVVZ0k0NHNibHlaWWovU0M0?=
 =?utf-8?Q?3Tp4m3YA+PM9ppqE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e450a3-b9d9-4103-8d7f-08df23bd3891
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 15:19:31.6443 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XoxwTqtjYo5iok4PPHU7082xCekh4OWOQtZqUInSOGPA+Xvz8/vV6d+do15LZ5cjeTjH0O6ZzJ0k10VvIv2qZ967WMZSUdWXq80O9UyV9E8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9392
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On 10/6/26 5:14 PM, Peter Xu wrote:
> On Tue, Oct 06, 2026 at 04:58:39PM +0300, Andrey Drobyshev wrote:
>> A device may take over a resource from the source in post_load(), e.g.
>> vhost-vsock acquires the device ownership on a CPR target.  If the
>> incoming migration fails afterwards, there's currently no way for the
>> device to give that resource back before the source is told about the
>> failure, over the return path or via the MIGRATION event, and resumes,
>> or before the target exits.
>>
>> Add a notifier list for that, called from the failure path of
>> process_incoming_migration_co() before the failure is published.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> 
> Should we better reuse migration_state_notifiers[] and introduce
> MIG_EVENT_INCOMING_FAILED?
So far I can't see why this wouldn't work.  Should be functionally
identical to what I've done in this and subsequent patches.  So if you
think adding a separate event is cleaner - I can certainly go this way.

Thanks,
Andrey

