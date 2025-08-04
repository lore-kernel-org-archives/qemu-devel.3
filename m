Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F276BC87FD1
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 19:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj0OX-0001lv-Lj; Mon, 04 Aug 2025 14:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uiyiM-0004Op-9I
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 13:11:17 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uiyiH-0001RT-KO
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 13:11:09 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574D6VJL018154;
 Mon, 4 Aug 2025 17:11:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=uRzKx3slXMl4vdfaxe6xYg630uotjKd2bQPxi0Qo9bE=; b=
 M3s/3T8EfmDN9H8qs8qfYGwsRTQqYXZUTKMgi0CE4Dd0o2QBQjnJar0+ofVM6t5B
 Hq7uJa01wbZOwUL79XzHy62GVbQziGNPJAjwBvYRVHwZ/Au2+spYQtOp3CYD7pAu
 LFwOSHjaG/QhkgqnDS0joMGSFmsYa/61sE262/czSl/sKtF3oJ9LMoy+7WivMiKJ
 SxlmdKgFi1MeezQsj+YsTHaB0X5OHgjeI+Q5SGHFhIf/PbX22qwICV4M1/YvS1cr
 m8i0k5T9VWJ6j3QhZMItAjzGCgoTZOwR6fagrMhfABaNMBWLl6JoC/4Cu9DQOT8Z
 GNn+/sIIjG0U2V6B66VlLw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489aqfk332-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Aug 2025 17:11:03 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 574H1qYs029029; Mon, 4 Aug 2025 17:11:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 48a7qcwh8n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Aug 2025 17:11:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L00KXejBBf8I9GkiL4k6O2lBAXqxVBfSplc5zRAB92iObWcmnGxPhMPfHFrc30jPDk4+iAo6pX8aYi7E9vpalO5Syl+4XbmObwInycBEG0uugy653ORP9ZK/ddOaTrBhiJ7b3EmnUF4WPzXWLXpGaBjYhGYAyxbgpjQHQ/78Ce3+3JhvCX4/htpNZtoRqxTpHYGxcyIvEIV2VIjUcf3bBrg/RSEGXesfa5BFp3btEKFlGeuxzCgHjSoUlWtVkd9mksfNbMee7zf0ADZnVH8e25pPRfnZ/0TIt+TL1tI1v5atkiNXxfy0y+MdBcpxx2QhcoW9zCtzCvJoYywbBgEOHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRzKx3slXMl4vdfaxe6xYg630uotjKd2bQPxi0Qo9bE=;
 b=ws0bz8HjwTBCabV40RCO3/0yckKEZJeUV+SiezJl6dFGVPJq4i9Qsi/jBxNlzKbexYF1XgeFN8fibn8YcBZE+yhh7d/RqSaqwaN8PbDP1oPjGM3p8UPWsPiWtKokndE2av7C+UGXpq+9ZP52cfLB06AyqVZWp59xBfdF4Ey6Kj2Vr3qKRvZJsxGcBlwbbZVqPB3TnWIBFtOXWHXcmwhVn2LjoEWftpFQkFaUFD+4WqKbC5L3JtjplSuhjwMB/BRgL6nPyqMfNiDWTrEijZTbJkRK+dKb78Ob+W48Chso4Gu2NYSpwIIN3At8chC8Jt981+8wUdyeMxHIc9PUbS/H6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRzKx3slXMl4vdfaxe6xYg630uotjKd2bQPxi0Qo9bE=;
 b=gdB4HbyQ1z7+8PBJY7gHzFDo/RRqEsfjuLMNBRs2USHSP82BQOAT0oor2qS4MBqAe7bsFHgf0k2w/l8Vn3eNn9ofX4gD+OuvMV870Ga/uFcckXAPfjEulLUDWXnkNvdCn4pZ0YwWxB4gupD/bV84N43uvtBF3ws1kMXWZWOyJvc=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH0PR10MB5578.namprd10.prod.outlook.com (2603:10b6:510:f1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Mon, 4 Aug
 2025 17:10:59 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 17:10:59 +0000
Message-ID: <6bb59bfa-8083-4823-9f15-92132e8d6783@oracle.com>
Date: Mon, 4 Aug 2025 13:10:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] qtest/qom-test: Don't bother to execute QMP command
 quit
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net
References: <20250725135034.2280477-1-armbru@redhat.com>
 <20250725135034.2280477-5-armbru@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <20250725135034.2280477-5-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::17) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH0PR10MB5578:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e90d9db-fa1f-4b6f-e1a7-08ddd379e1d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVhSMnY2WVhCenB3VkZyMUJ0WGNsaXVGNTV6WUo3cG5CWDFiZ05NblVjUzJD?=
 =?utf-8?B?TFIxVmlEdVJVRm0ra0pFSURJK1QyTEY2VkJKTFc4UGxxbjRQbi80T2pDV2pD?=
 =?utf-8?B?NnlWN1FIZXVhTTg4RVJXQlhLTW1BU3BVU3FxOWxvUkhuQmJPcFg0c0VoeUtW?=
 =?utf-8?B?TlI3cXgzRFdORXpsTVVQcyt5K0wwaDk5ZWRUTHdzZ01wSXBldnNaQU90SnMv?=
 =?utf-8?B?S2NRNGNma0JLVXBXMzJ0Q2ZUWVR2TzRCczdzUnMycWpoYUV0TDVQN0YyeGRv?=
 =?utf-8?B?K09UeVhvYktSME9JVmJzVm9MWmIvdkM2OU5FK1BzbEpjNXJBY1gvbElWeGVB?=
 =?utf-8?B?UDBGdEtodm5TVGkrZHM5bzJRNXB0Z1RqWldKZmNadXhSZnQ5dFUyME0wWExr?=
 =?utf-8?B?MmI4RUNHUmV2M3ovam5DMlUwcVZzcnU4Z2R4aDQwNmpZZy9jcmdFSnJJYWhE?=
 =?utf-8?B?bGI1OU5YWHBtYTlDT0k5ZUUzV21PS3lJdmFsbzhmWDNJek5ZZFpxK2N3Uk4y?=
 =?utf-8?B?ZHMrOEFEZlhSWWM4VytSSmNRZ3p0Wnl0OHFGK1NsSDdJOWFyaWp2TXY3QU9I?=
 =?utf-8?B?NUJ5eE5xaEJaZThkbTZ2ZG1aZkN4MUxpT1NCMlkyZ1BsU1VJUHlYODFtK1hq?=
 =?utf-8?B?ajV1M2txcEwvcmtiWFBQNVFjWVE2clMvcis3bGJxN0xzc1VkSmE1WXhpb0t5?=
 =?utf-8?B?a0swTVp1ZndrdzVMWldGV2pYaG1Jd0RLMkhxOVFLczM1eUVwWDJVK0w4Mk01?=
 =?utf-8?B?U09rbjAxeUMzT25ja2hYVzZvLzJZVFYvVVZBWDlISzM3bHB6Skxoa1RYSlJo?=
 =?utf-8?B?V3hHKzhKZ2tZdWwzSUE1dGtPM01OR2JJTjA1OWdXRGxiRGF0QkFacmdqVWVl?=
 =?utf-8?B?Um5GU0Z1RnpyVk9jZ3JZcStOeVNOU0kxYkxSYUxGY2JBS2lvYXpna0s2RnAw?=
 =?utf-8?B?THJkazBRcXZVQnI0NHpwclBaNXNUeXE0K2U3Sno0UGtJdzdRdm5nU250RkdG?=
 =?utf-8?B?QTBoZS9UYVB5N1dFM2NGbEd1SDRxV3VtY1ZsMkVkczhnRkVZK3BENExMSXBW?=
 =?utf-8?B?RmNaN29ZM0hnL21pK1o0YVJCNGVUSHIraGk2V2lsNUU1Z0EwNVpXWkFQbFBD?=
 =?utf-8?B?T3FWZUMrNzFvaFNPUkFqaThCMW0xdkYxVVN1VGVKdjRUTVFVT0MycEg5aW15?=
 =?utf-8?B?bk80ZG9zRkhWMFRPR3pVZ2p2T3RrdHVqdlBuM25XdU9GYlgvY1FsS0ZhVjh6?=
 =?utf-8?B?OHJ0Nm5uNVNjOUE0dWZ6eUN2R3V1bEk0VU5hQzlLVWJoYXZtN0l1cnhSZEpZ?=
 =?utf-8?B?R1ZwaU9pblJtWG5hQ1gvL1ptV09kMVhrZFBVVFl6RGN5NUFZVDFOV25aSnFo?=
 =?utf-8?B?UGN5S3M5Y3JjM2hWY294OGVGYVEwNlVxMENoY2xaNjBhTVNRa2NQUksya2hn?=
 =?utf-8?B?ck9BUFB4b0tqc0x4NEFJV1ZiMWNaU3R2clJadmtURWNFT3BFMU1JVm1PN3l4?=
 =?utf-8?B?WHVWU0dHRVQ0ZVZVd1hMbHZMZGwvZW04YXNteVJTYVRIbzJnUGtpSkxOd25Z?=
 =?utf-8?B?ZUJubEdjRUpJVzV2dnN0VEFPaSs2cTMyNnRDZmI3V2VXdFhSSGJvdkVWRTM1?=
 =?utf-8?B?ZWM3MGdIckN5MVVheWxVL0JNYm52UFhaeXFuNld1ZHZvOFprTHpGUlpROUlZ?=
 =?utf-8?B?dGsxbWJQNFFaaVJvOXFmTWt4bzdxcXN4eUdjRmptMlVLdm16aS8wZXg5NlpR?=
 =?utf-8?B?UDBKODNOWUFMdFpRdFV1bmZERHNFWnA0ZGdNQzRwbGF3eGY2cTZHSjR4NkpP?=
 =?utf-8?B?ald4bFJuNDBJeUQ0djNiVGhiK1hTakNQQTlNTEgvaGhxUDhmNHlGTk8xQlRj?=
 =?utf-8?B?UlFTQlZ5cHN2bERxdmRPdjk1Qjd4MUZxcTFNME5HZ1psYmc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWxwZ3lKRzVKd09hb3lsVE5ZOWJYajF5Ny8yOFlrY3VPUDRBdVBkM0RPa3dF?=
 =?utf-8?B?MHJvUC91YmlMRjhBOGRPM3lUa1VmdkI4dzF4aGRhQ1pUV3VOcE5YMUREcEpL?=
 =?utf-8?B?NU9zb3l1NHRKbEhFcnR1c3VSRVVzYU1RdXFSS1ZZdzZhbWhTaWtpTHNDN0h6?=
 =?utf-8?B?QlNXc2hpb0VMYldxT1hZMUhvRUJ1ZkEzQmhpNDNONW5kRTdEeHFpZlVXQU1Q?=
 =?utf-8?B?YnpUSFNON2RUa3JHdmRhRmV4aUwvZXh2bjVaQk9VelQ3YjF5YmxEWmpHa0FC?=
 =?utf-8?B?dmR1dncvVXZnQWxybFVMTGUzNSs1eGZIRlVLeFVaS2oyUk5FRnpYWTZ5NEth?=
 =?utf-8?B?V1ZSRjlkVmxSUnNWMk9GYmorNzJkNHdWQkZaT1dudzBRRTFRUVpWL3NDZFBF?=
 =?utf-8?B?UVd5bVBZZHFOUTlxS0FqMjVJSWZLb0lVSVlFNnBrS3BwcGhVZmRpaVVhVFNt?=
 =?utf-8?B?K2VMaWtVTWx2RjhUWVg1UzlxMzFOaklyU1JBOXJhOXA2YVlyVk1sQ2dYUWpD?=
 =?utf-8?B?amdpVjNCeVptaDhlMlg1TmxsSkU0SEVyZ29ZRmxhYjI5YVpMbmRtUlQ0aHdE?=
 =?utf-8?B?ZExXamhCVC9QQ1I4TUg1akZmaWhMWS9FdmRqK2dzMURkdUFyamRkWmVqdXhQ?=
 =?utf-8?B?bzAvNU5NRStSZDBwOFV2cWxiZnBXSlNhVmd5MVJuR1NaYzBIMUFsUmJ6b0g5?=
 =?utf-8?B?cVVzUURJam9VL2JYSHEyT2dIbEY4M0hGTjFIN2FMZ25BUGNrNUxFTm95TWkz?=
 =?utf-8?B?dVZOQkhzemY3VTduOWtUK21Pby9CcEdwZisrbFA2MGY3UDE3a0lES01XVXVC?=
 =?utf-8?B?eFdya3NNc0Z1b2k3VGpEVjFKdzNzQk1FU0Z0c3lsZTBYWHdBb3lPb0wyeWtq?=
 =?utf-8?B?QkNJWmNEN1A3SkNOUy9WVUN0K0NUQzhGeTZ4NFV0TmNxelZnREg5RzJsTGtw?=
 =?utf-8?B?cmFZQVp6SWp1aDNiNXE4K0IrNVhvajhaREVqdjVUdlloYVczcmtJQ2pSYXEy?=
 =?utf-8?B?Y04vMGJ0NHJSMC9KS092ZG9pb0tsODdqY1lUVTRFeXdtakZDT20vaWNuQlYx?=
 =?utf-8?B?Wk5udUhnV1JGd1VpUUxmeVRwRlIyYjhucWRTRGlBb2RwNm1ZMlNENE1hNUh3?=
 =?utf-8?B?N2NuQ3E3cjBlRVI1dG91TnplUmJNbGZaQkJEdjI4SmtJWXd3NFprRjh3cjEy?=
 =?utf-8?B?MkllQ0JLeHhyOUI3U3EzVEczMTNzd2F3OHdHK0JWb1pCWXJEVVYzRkt4VE4x?=
 =?utf-8?B?Vk50QU5BbEJwV1JXMmdYclBJQW9ENUc0Q1NwMS9SRk1JeC9RdjBxR1lhb0hi?=
 =?utf-8?B?cCtnckFZUGZiOU92Z2t5OWdwTHFmdmE3SkJEc0FBOXpmQjJyeURNclkxWFdU?=
 =?utf-8?B?aU9GT0ExTlh2K1pHSVNTdHZsaGwxRFpyUW83TCtVdjE2d28zT1BLaWwzUjhY?=
 =?utf-8?B?ZzRiVkFBd2hhYU9DSGQ3bzcxeENZd0MwSkJlTHV2K3E0RUU5QWRMYVo4bXBX?=
 =?utf-8?B?M1NhbW45aUkyK05DNjVSVmp2OXBLS0pIbDJIck5VcWdVdFNRbzZXcjAra2Y2?=
 =?utf-8?B?ekIrbDJBVnJsU2EwUUIxeFU4UGNqUVJzNkF5UTFrU1BNeFY4L21vaU5RTHVU?=
 =?utf-8?B?bGVTT1hxWTlzTkhxZERkSUs3WmUrSXE3VUcwcjdPdHowSWRpdFBibXRoek8r?=
 =?utf-8?B?QzRyUHAyNnJrKzhHTitnL3ZSSGtpMm5IbmZ6VlpRbFJTVHhKZXE2K0dyU2pa?=
 =?utf-8?B?dWRVNHJNNElIQ3R4Qmt1MnlnSmJ4a2I3TkVqQjdEZjRmUjZMM1NRTGh2N1ht?=
 =?utf-8?B?VWRkUVdqUHBQOXIzZFY1RkEyZmcyR3BwYTlsU011SVhPODB2cnAyYllBeC8v?=
 =?utf-8?B?VjVzUGhaUnZsUTc3eTFRR1luV1lNM2FUNDhvd1ltcUtHY0g0Y1J2eGVaT0l3?=
 =?utf-8?B?Z1I0UXpGMTZwOVpBRlMvUmhzS1l3ZVI5a3c4ZVpoeVZ3REk1ZUFqazZCZGNY?=
 =?utf-8?B?eWhGSUR0Sk1GbE0ySm96Y09ELzMvT0tBN2xqOGJnaXMzTVdmNDdtSHZIbGFy?=
 =?utf-8?B?cVFzVTdsRHVBMzVCNVVMK0l5QWEyWDByOTY0MWtZbWVYbUpURWlsUU43SVY1?=
 =?utf-8?B?aERUK0NlNFlQQzRGS2dSbkxBNzlyeS91OXpic004S3p1NGl1dVcyVk1hdlN5?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XywgnMWINV+vF7bTzMDxGN/WJDBgTp/KeWgYLBERqlXSogtvv7moTCUjryZfvjPrttb17k/vjp9At8EMa9vuA+/3oXy+rxN0RchMUBfV4w700HX9ePt/W2Hmezu3HxpW94ObuoPadpUCfMSXfEQFE72xzfdXIxGQ40ixOsMS4YM0FgswOj+teu7Jqu/xdpfwtFwv9OmqbMDxDdpOZyNi9rrOMsm5K8KKLvEHriFCFRzH1/ucr+JXm52dVft/KbGwTDMyAYxxx9Ng2clr+wP1TcU3Y1X4wEAo8dqUEoHcaY7B8R7UJf8c4Z0bL6AILf1QNeLJmfJM59LSS5mWNjvlQp7kjQZ8J5UIg5mZxMq2c3hm6g//ccV8nwLaRWPG1vwcudNlR34rQeRknrXB1S7wQ48p/Ex4hefoXDtKIWMDWE3xZR+rR6ZnBLTg4Y60DDsxG9kDyImLVYxZZMZUdBFD6t9GLKooV6JO+bc2h4CsejdZKrzK9+aTIcwmGwnvvWVj0p5MTfl0R9womlWN1lGMTrze9kvVJMy0tyw5WcR5T+ORjvglyDRgX/5Y+an58Vbdr6JxmuX7JGZOReOa5FLve2TKaEYa/t8+id1LRtbEtqA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e90d9db-fa1f-4b6f-e1a7-08ddd379e1d8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 17:10:59.1490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jX6+Gi26SKTEfWbojrMF0dTTZ48kfemOxnSVkbF2VtAGtmjy5ZzHBOJS4jlTUG5NqF/+WSYhLpxNXiO+4RxDQG/mTP+5/cOyZYIgIxKFo5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5578
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_07,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508040096
X-Authority-Analysis: v=2.4 cv=TrvmhCXh c=1 sm=1 tr=0 ts=6890e9a7 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=HlS3HgzlXE7a_-_k5XYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: w99ehW93rnIsAlVGi2at81J8R02bJFFO
X-Proofpoint-ORIG-GUID: w99ehW93rnIsAlVGi2at81J8R02bJFFO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA5NyBTYWx0ZWRfX8TnRypLDpV5X
 2osEKCwuggxJR8U4Y4M8jsHveL4h5qzcGs8Wva5bgda5CoT7UpKHKyCcPjc0xpnV04qnIjJu6v3
 OPxMsviUWcblVgKnkpPzgp/KfbNBmLKTFuPd0425uHLjTwwZs2KLuDhZkbK7ok4YgEH573MSeGs
 pYwavesPYZ0Byv3Nt9xXC7kKc6ri/R7ExFQBeHvTkLvMfzsowyvZhYF0z95rx1lyrdGDarFrmGg
 s2N4nMP1ZAiDX22jBD4T03rAuBtbN0LIkIcSvbQxvxvyXgFT2n4qRKnNyngFq4sWFSePf4rz4KH
 2Ggpv0PbOSH8LYWY9vD9KhIDEo9TseIxStJ5sJvE8r5qfMEQWJ418cqRozuCQoAotKOehW7ivg3
 8sVdnfU1oM3UKblQ8SzIFZY5621AncQeQU0JpIryf2c7dmw0QoexGpiFOu+0GJzvS46uD+U1
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 7/25/2025 9:50 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/qtest/qom-test.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
> index d358b69c7e..6421f2d9d9 100644
> --- a/tests/qtest/qom-test.c
> +++ b/tests/qtest/qom-test.c
> @@ -215,10 +215,6 @@ static void test_machine(gconstpointer data)
>       test_list_get(qts, paths);
>       test_list_get_value(qts);
>   
> -    response = qtest_qmp(qts, "{ 'execute': 'quit' }");
> -    g_assert(qdict_haskey(response, "return"));
> -    qobject_unref(response);
> -
>       qtest_quit(qts);
>   }

IMO the quit command improves test coverage, albeit by a small amount.
It guarantees that qemu did not die after returning the qom result to
the client.

- Steve

