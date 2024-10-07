Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A369ECFB456
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 19:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxtRx-0002zM-PK; Mon, 07 Oct 2024 15:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sxtRj-0002yi-1v
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 15:31:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sxtRg-0006Ga-RD
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 15:31:06 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497FMeU0016444;
 Mon, 7 Oct 2024 19:30:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=SEGHorleiQlt2WkT4uFZJaQhQo4n1GreaKR5J7z/qgM=; b=
 FxKzPlgLaBPkTSkeSzEEKuev1OsiBWIpy/RZ9WJgsHvxqht5BBZoSFt9yWC8honl
 uQZnzexia1ffebHkEdWZ5s/nQvt+Fmm1XNl1daAGcf8i8nt8JBYJ8JQj4GOs0LFj
 dlvy4YcWufNBwOGbkidhwu3c9FGPonBqoNl8kKnOljltAs804cxgVdi8ckBFtpSI
 ehb1U9liQD+ybFsViEqW3LZxZdWu0D+tvi5DlI5WV6ACXbI0zdMhbuQRAeFSJXr2
 sw4j+L6P2zlchUmBeb0Cw96JQr3B/AVVkyfNd20Iz6KS1JHe2y+Phfg1f/w3No7v
 I9fJkqm1Co1Kvfk7esYb9A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42308dm6v9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Oct 2024 19:30:56 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 497JIdrA004716; Mon, 7 Oct 2024 19:30:54 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 422uw68kn7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Oct 2024 19:30:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0MClkUqagDaK9+fTJymX1qeN7j8+BGwBCVD3ndzpZkVQhjDX2aQeG7gM6rOxdEVGsKhdwOvEm6LyLUot6kVjOFPrXo9akias0U2xRcgAYit4AEajJM88dCf777cUentYVt5MATeJavtoFAK1tYOB40XFtiNiM+yYSV/hj/FG9q1/4rx3+/UkXuGYWwUF4yBBT9qQfJuT37oo2A1qNKzxCYzoNrpSHSkd4dL3G58IQHw1pezZYehhb0zz1D5AF8YKk3+LiQuQLWZsOgjZzIBbUpusai2tyCB1iFWDf6fezaf3Y80I2lZFUCJLIaguuLSOOBpJ85bvXi76avVg2hdkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEGHorleiQlt2WkT4uFZJaQhQo4n1GreaKR5J7z/qgM=;
 b=ctBdHlZBTWRHkwiUGyc3misB+PonvRCdH9vFThotwEfCi5eEjtrm7Ms9QceoDzdYjuhtl+jAySfhAxccR6RLYI9v6BvTOoaWIjILeVfhK/15ikennYxgcQbMUBIKq41P5onUfuaKh/DYn84XK7SmkmJE6gXFngVd890cyBCOXX1z/YalWzD+oMDb6FDYcR/AdbnzAREZThn0SA3yHgMnSkZn8VMiF/L7ouj4/QD02MTcwxLRq58/uq5885IH67dl5HbrlfjblYb2fTJjucmw6BH7vFDI0akNt5Bmff0l2fkWT1D6yP8pAofCtrGJR/SGR92SXSLt+BSfKoNB4NlYNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEGHorleiQlt2WkT4uFZJaQhQo4n1GreaKR5J7z/qgM=;
 b=abESrCyFKoKG2rYRHfTLSS7PNdNEAgaohvLLM9RLhRoDwKVoL5pC7IUgFHNPHsOmLACymWOaesWqvSuzCyHN6yx+PBshVPTyX3t2737d4VL/WQnb53tetswC/fy7aEuuP0Qexhw82xyCOM9WaKFXbBLFhTGu4/8tk5/zxY8wJ5o=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA1PR10MB6025.namprd10.prod.outlook.com (2603:10b6:208:38b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 19:30:52 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 19:30:52 +0000
Message-ID: <5afa3276-f9ac-45b0-bfdd-638cf8cb713b@oracle.com>
Date: Mon, 7 Oct 2024 15:30:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 01/13] machine: alloc-anon option
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-2-git-send-email-steven.sistare@oracle.com>
 <ZwQAGfeAZqyAqrWy@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZwQAGfeAZqyAqrWy@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:208:329::10) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA1PR10MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: 7561c09e-c29c-4208-2a15-08dce7068e14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akdwOTJzdlNVMWluM0R0RlZrb1Rjak9yaE1wcWFWVEFxa3N0Q1ltWW1tZTly?=
 =?utf-8?B?clNjY2I2REdiSzkyR1duYUQxZkRPeERTREo3czFyVi9zbXVjSnZ4eHBPY0lR?=
 =?utf-8?B?VWQ0N05IYlZOV3B6dFNKT1RoMVhWSUFWMnhvQmVFNkxJZXBlMFZVVVR1R3Zp?=
 =?utf-8?B?WGxUVzdwL1p5TkhVZGFOTDdEZzBod29paTdsY2dCL0tqbnRSZEYwKzgyYWlT?=
 =?utf-8?B?U0d5TXpXSjBNMm5vUnBkR1h6R3VTeVNFbXdmVTloa3ByMG0wbUdMc1Z4OTl5?=
 =?utf-8?B?czFIcWx0ZjI3VUtNRXIxK09CdHBGd25yUEQ3clRYOHNkNERFVXZiOXM1MkZH?=
 =?utf-8?B?aXFCMnVuVUFoREtKT29zQ2xuamQyNWg5Q29mckIxWWhoaGtuQ21haTBER2ky?=
 =?utf-8?B?aEo1WUpNVEJJL0tua0pjMFNtL0krOEZaeHpqOWZ1Mk5KaStoNmFuOWwzZTZh?=
 =?utf-8?B?M3p5c0t3ZHkrZklmSUc0NnMwS3Z3eENEL1RaUWc0OGx0UzVlVzZ6MVByNGRF?=
 =?utf-8?B?STQzcko5VkF2TkQwTG9vay80OWdBWUpuWGRWSGFrclE0ZkdSNzlKTnJUSThs?=
 =?utf-8?B?T0NoYzJVZTY0ZUxHMkl1aXRSdDhKV3BxMDdvaDJEeFZKTi9WdHFiQjB3QmJp?=
 =?utf-8?B?V2NPV3ZiY2x3UndoSEVxZm10RlZGSGlLZExTZnE3T3k1YUVSQnJ2OGhCK3ph?=
 =?utf-8?B?SkRTUUtQT2xTZ2c2NU1vM3g1N1VldGVrM1FGVlZsUWRDaTBOZk14NW9PMFdq?=
 =?utf-8?B?N1RxVTFRbC82TFZJcTRXY0N1M2xKZGF5SlZYYXNQelBvUDZ6c3FYWDBrZXFT?=
 =?utf-8?B?dTFzUmpQYzA1bExiWEpLcUJuVjYzUXQzSFpORVBoVVh1cGtkWHJJZ1VqRVBD?=
 =?utf-8?B?Wjd2UHB1OUFhR29yRnB0dDZ4QWdCS2ExYSsyY0ZFZ3U4QUE5TFlFMlJKZWdO?=
 =?utf-8?B?L0lHVVM5UG9lRGl1NFZNSHFVY3hZaDJmK0wvS25IY1lqeEdOWHRhamNjQzho?=
 =?utf-8?B?eDg0WllKS242Y2pHOElWaTJubTluWEdqMlhvY01lZ2FVczhhSkJiS05sdHlT?=
 =?utf-8?B?N2xZQ3o0cWZsQUYxaEI5akQrWFc3ejB0VVlKanQ1eWNJWDltbzFIVENZV1U5?=
 =?utf-8?B?WnQxZzdlSStzVHFKTGl2UXVtS2lmQ3V2Vjl2NEdHNU5ROXlITEo3L2NsblhL?=
 =?utf-8?B?bHg4SWZ5Tjk3aEVhSU04Y1M2NHlkTWVWQUFSWVJFZVBNaTl2UytGUktiL0xY?=
 =?utf-8?B?ano0bGxFL1N5M3BSYTByUU5ZWEpCbEJua0dMemhWdktrY2NwSzNZeWNueHVt?=
 =?utf-8?B?aXpkb0hSSzV5Yk11aFYzcS8rOUVROHZpc0hzU2hldU1iLzIwVVpUd0QvbUYy?=
 =?utf-8?B?U3JoVGJWTWVUaGZTZzNsZ0xiUE5iZWo1dW1RNkVtTElyYlNIMEpFTCtSVEha?=
 =?utf-8?B?MzlwNWk3NDRzQXB2NCtXbStXN250NEVHRFY4KzJWQmRRaDdSUDZlMGw2ODZV?=
 =?utf-8?B?RzdxU2FCNlU2UVZJWVpBR3o2TlBvRVFyRTMyeTJaZFhHeFdxSEJxdWFERFU2?=
 =?utf-8?B?cnFWblgxRmo1dEtKd1VjaFlsNW0xWVJHQmxDVGtZRzVJbVJtS1NmOTdnSlNI?=
 =?utf-8?B?VnQ0QndmdTYzdVFQRzFuUXlMZk5GcGRZd2RGM3VtcDQ2bUZBV2wxeWlJcndI?=
 =?utf-8?B?RGRaOGtFL1dsSldDZGpXSG1aRGRTMW5RRUNSZGl2ZzFDQjhnV2RCSmRRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjJDUDArMFF5K0xudk01YUY0cVFwUkJrTXQ4S1laWEc5aW42ZUwzc2lwYyti?=
 =?utf-8?B?aHlneEtlUGh0UE13SXRIc2VRWUVWRHlBd3NNRDhpSFh0Z282S2llWXlCWUF6?=
 =?utf-8?B?MEJGSFlucUMvTCtEUHNjQTkwUEdvckpNRThTOC9YREZib28rQ2lNNTBwMEU1?=
 =?utf-8?B?UHRDajUraC9TR0NJc3NMS3lVSUpDS0dQSkI2S1A3cXNDNHpVTUIxNE1xOXZw?=
 =?utf-8?B?bEo4WU9RU0UwYlkyMkhlM1pFZ2p6YzVYc04rckI0d045cjVrS2NLaC9EUFFv?=
 =?utf-8?B?SlBGUFJIcFByTjBwYStsZUxPZ0lQUlRIeFMzakhaNmdPTzBQeVNoTDJ0enBH?=
 =?utf-8?B?QU1rcW1xOHFCdDMrT1pkL1RGVlphNzEwUTFIbFp2QzFPK0Z6ZnVvTXZ2WnJw?=
 =?utf-8?B?eWErOWJUZE1qdW5nWU1YQ1psL1ozRUxWeTB1TlU0bm9UOXFZSnR6S3E5N1FX?=
 =?utf-8?B?aVJLb1BISXp0ck16bG5GcXRMZnR2cXFxMnNxd09TNDdqc08yb3lZMnRWM1l0?=
 =?utf-8?B?YXVmVmY4Vzh0dndvVE9nNStFcTZaQ05zZDBFQ3pTaGZUc0JwaFJjV1p1NlV4?=
 =?utf-8?B?Mis0OVhYckMwRWo5a1lvelhYc0YvQnZuU2pFTjZPbjBBV1F2ZkNDRS9NNG8x?=
 =?utf-8?B?N2Z1SkUzei9OanhXQjlBeGJjc3lFVzJjMFF0WVMyRDJZWWsxaHh4dUJrV3Q4?=
 =?utf-8?B?c1ZDQkZTc24waHBQcVRETEYrWjcrc1UyenprR0dHV3lseXZQTkFSWnJKaGpP?=
 =?utf-8?B?cW01c2dYUmFCbjByZWpOK1JYVFl6a0l0UktxTEtUTmtJbEw4c1VudTIrS28z?=
 =?utf-8?B?TVY4djRyTHpqYm9NOVUzMzYrcUJkcUZ4RjB2eGxKTkx5R250VmsrRk0wWnNB?=
 =?utf-8?B?OGRuYVVPYXJrQ00vL1Z2aFdUOXNLbFlBTUtBMkVuRVhDNDZlNXREbDJOSVJO?=
 =?utf-8?B?VjU0QXRyZWxHejMwc054R0tmQXVmd1FCcDNTdEQrT3hDL2pKRkFqNkpuTCsr?=
 =?utf-8?B?NGp0N2hNN05rY3BKdVlhVDdhRjI1RllvbkxWREF6NTd6UEtEaUdqRUxzOUxM?=
 =?utf-8?B?VUIvV0lrRFhKQUlPSEdOWFFPOWRxbStoREJMM3VqTzFrOEJUSmZ3M2YxampF?=
 =?utf-8?B?WEFBQjlrMjAyNXc3TUw2MzlBS2ZDV3RxYzV3bUFFM0UwRi9FdHptZHJtYWUz?=
 =?utf-8?B?d0lJdTNyeHFPc3cyMW1uYXZYT1pqYitCd1ZaeU9YRHEyNGplcWxyS2NTOUlR?=
 =?utf-8?B?emNWVEV2NkR5OEJVMDFSUElXZEhKY3BhTEpDZVl6NVNBQVdObmlaZVQwZVRW?=
 =?utf-8?B?U2VqKzZKMzM2V3BCOGc2dXJlSy9MRVJrM0VnTi9zODIwYnlEWDJKeDd1aUxy?=
 =?utf-8?B?WHJ3V1VYc1E3TzlJREkyY3FEUHRMUVUxRGN1c0VHeWY3ajBwdzFVS3NYelFU?=
 =?utf-8?B?UlN5eTVveHNEQmFJSGpWTmpqQkhibitqa3ZHRzhzSG9vOSt5UTAyb2R6MnFT?=
 =?utf-8?B?TzFmT0VzZzNDc2xVRDJLdTV0M0wxNGU1R3JwbnJXM1FCa2dBR3ZpM3MxOGxH?=
 =?utf-8?B?T2ZGU0duaEYzcGtxckhUVm1pWmp6OEFscUZETFppZitFTnV0dER2RENheTBN?=
 =?utf-8?B?elhUUGRRN1UrZnlyTmdhU3l2MC8vVnpWSXFtYXJQZDE3eGoyTTFIRnlIUTZn?=
 =?utf-8?B?dWhDdnI4VUE5R1hIMklLM3orZG5yRTNKOTU2N3A3TkFQamhVVnFJSnVISCth?=
 =?utf-8?B?VEJZZkpCanZvUmtzVUhRT1NQdGF6bmtueHlreDE2UDM4Tk9WeDBaOXVaZ2Fs?=
 =?utf-8?B?aytXYmFxNldaMDBCYklLbFNZZWZHQ2JDSTdDUGk3d1NYQmlqakdyaXhtdkM5?=
 =?utf-8?B?enU1QUlGOXpVQThsM2s4a2Z3aW5TcEhSY25rb3hISndlN1IzSmU5NEpSaWJR?=
 =?utf-8?B?d2lmMGVVWFhkRlZ6VitKTVZqQXZuQ1daY0RaalM4cHVTbUVaTWxib0UwbjEw?=
 =?utf-8?B?cVFXZHl4cXNEREJhcHlvcU5JQkdvOTRLRzdEeFgxRllra2VPQW83bjdPR3hj?=
 =?utf-8?B?c1prTlBhWjFRLzQ2WWR2TjA1WGpGU3ZNc0hGUzE2QVMwK0NBeG8xbW9ucXlF?=
 =?utf-8?B?NVVwTC9tN2VPbFZPenJHcUxlVGRVVzZpbHJHcWZpWFU0QU9iang4eEwrVGZq?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lqWSkwDjKldpR5kBZt9E1YrFXbdxrC3I3HQYQzU4u7e/ip6Uy/3eu4tUNgQUKU3kFfhn1WaIM/DpZvgc4prSq2Z0wa4lDScYdNN5206MCWcyrVO+OgNdgXxUutxlb4RpHMGnMhufTT1Tz+/I2SSVk2p1eAxXq/o1yUgIwjSLLUKhxW5BYK8k5DVCsW35C4c2+32I1Um0p31JUdgkA2dz26TfxE4vJlNujcC/sOjeBmXcmyumvLTRjmoRjYE2ZDblx7yEqMEDQlGnn69aYVWScFVOGSbJ3KMeGlPe4WA/owlwvqz/xFlFmZXDEfCvmujsMJr+GKOsejYt1PZb4BmG7koENouZv6271GyLv01bgr2no8RHWvKzcPdATBxmHISK8vl4WA4q05oTZSkPK9COsxQiq079wIPspm/yIYpIervF0OfYxkNujzp0E/WL2e3mQbWBZdTnkxAW/95s6TZ30355KDvSLvL/51krW9CTznnqaBQ33RZdWUaT6s/RYPNMsVgaWPlZtVR79VGJplKPvXSY0AXSxmRWxURAFSEejIkYi5ar5oWhelrXp3OJ0puzhSHqQ3g368pEaxpe4zHUWjg/+FPvGJqaz+PtlTBq3kk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7561c09e-c29c-4208-2a15-08dce7068e14
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 19:30:52.0939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9kcngLhenBDwsHlyUZ6HVnpDwbrYOtkGMT4Qqp+eO3AV+4Pa580vRCvRVtbkIVQg4Dg/ygVu1VtwFjb+C7b/6uzr0qgyXHF9abs1QkwHP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6025
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_12,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410070134
X-Proofpoint-ORIG-GUID: 52QbT0rtYSJ0N9spKrCOa-bRBDSIhWkT
X-Proofpoint-GUID: 52QbT0rtYSJ0N9spKrCOa-bRBDSIhWkT
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/7/2024 11:36 AM, Peter Xu wrote:
> On Mon, Sep 30, 2024 at 12:40:32PM -0700, Steve Sistare wrote:
>> diff --git a/system/trace-events b/system/trace-events
>> index 074d001..4669411 100644
>> --- a/system/trace-events
>> +++ b/system/trace-events
>> @@ -47,3 +47,6 @@ dirtylimit_vcpu_execute(int cpu_index, int64_t sleep_time_us) "CPU[%d] sleep %"P
>>   
>>   # cpu-throttle.c
>>   cpu_throttle_set(int new_throttle_pct)  "set guest CPU throttled by %d%%"
>> +
>> +#physmem.c
>> +ram_block_add(const char *name, uint32_t flags, int fd, size_t used_length, size_t max_length) "%s, flags %u, fd %d, len %lu, maxlen %lu"
> 
> This breaks 32bit build:
> 
> ../system/trace-events: In function ‘_nocheck__trace_ram_block_add’:
> ../system/trace-events:52:22: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 8 has type ‘size_t’ {aka ‘unsigned int’} [-Werror=format=]
>     52 | ram_block_add(const char *name, uint32_t flags, int fd, size_t used_length, size_t max_length) "%s, flags %u, fd %d, len %lu, maxlen %lu"
>        |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ......
> ../system/trace-events:52:22: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 9 has type ‘size_t’ {aka ‘unsigned int’} [-Werror=format=]
>     52 | ram_block_add(const char *name, uint32_t flags, int fd, size_t used_length, size_t max_length) "%s, flags %u, fd %d, len %lu, maxlen %lu"
>        |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ......
> ../system/trace-events:52:22: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 5 has type ‘size_t’ {aka ‘unsigned int’} [-Werror=format=]
>     52 | ram_block_add(const char *name, uint32_t flags, int fd, size_t used_length, size_t max_length) "%s, flags %u, fd %d, len %lu, maxlen %lu"
>        |                      ^~~~~~~~~~~~~~~~                                                                   ~~~~~~~~~~~
>        |                                                                                                         |
>        |                                                                                                         size_t {aka unsigned int}
> ../system/trace-events:52:22: error: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 6 has type ‘size_t’ {aka ‘unsigned int’} [-Werror=format=]
>     52 | ram_block_add(const char *name, uint32_t flags, int fd, size_t used_length, size_t max_length) "%s, flags %u, fd %d, len %lu, maxlen %lu"
>        |                      ^~~~~~~~~~~~~~~~                                                                                ~~~~~~~~~~
>        |                                                                                                                      |
>        |                                                                                                                      size_t {aka unsigned int}
> 
> Probably need to switch to %zu for size_t's.

Sorry for not building 31-bit!  And thanks for the tip about %zu, that's new to me - steve


