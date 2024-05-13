Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25F1C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 19:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6bKx-0008F5-KN; Mon, 13 May 2024 15:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s6bKw-0008Es-2P
 for qemu-devel@nongnu.org; Mon, 13 May 2024 15:27:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s6bKt-0008Gd-9T
 for qemu-devel@nongnu.org; Mon, 13 May 2024 15:27:49 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44DJGg83015243; Mon, 13 May 2024 19:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=1R4X6aJ1GTx9u2/5myXw+ZKBrLJ+JLEjk8Heme9JsYk=;
 b=XK2cjPRC9HGmIRBREXqRD++qN8rO+oqj/pZzSZ9mHLu5BlrNVcUb38ltyal+IFHzrzCy
 SJNUbtTYNw26L3BtIDmS7LY7NGjr53bZ8RFQUsdXbxMWTCIkTrkb/Sa5LWYm0kCbt/k3
 WsLaNnOkF3LTENYppGvCLVxClNkQnNJXYj8h9YxRJ0mNhs5PMhP3Zf5yGT7yO4rCFviE
 kHDKmHlb8kFTXUK9jJbtD/UpRLhTdNPg3IAMu8nFI1baTa4Et90kvIo6TJRs9TQ2AUlw
 0tLuBAwP5eKKwzIhf476DsZx+EH1SIGr4mCWAZNf1VllH76Iz08mZKzkV9MFunRxcNAS DQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3qgv08pj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 May 2024 19:27:42 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 44DIgBPO038340; Mon, 13 May 2024 19:27:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3y24pv2nu9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 May 2024 19:27:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGZsaQka4WwUl6RfpZxtAtN4MbIxrq30iv+5y3l17EXPx+d/7MIoik7yGPi1a4E4X58Dktq5lUS0meok9EXuGpeLnCR1ina3mksez7oHokTvjbr3DOicwlPtRHnOZ9ofNMwaMonw+6grGaZiC+8Lh4K0wL1RNokM1ZX7uIGUFqQCjpmykYgDgSuFZ44aYUlwtWYMDF1gfDZHZM0S66L0jl0m/Amkf6NEhIDmAeP80lo5o0eVJEUhXLDhHqoRMyS1b/rCeoMIqGMBEpiaGrvc1ahG833Id+9ZjDotHgbSIsBjsBR3XFM5ZZoz4mFWsNyILcNhhPdjwQPkKgNzrNAfKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1R4X6aJ1GTx9u2/5myXw+ZKBrLJ+JLEjk8Heme9JsYk=;
 b=DW791BEwWCBW8NyCQsOKIBq9aLpqIwdZ6v3bMGi9XFbePddhz2/xhD2b1FDjDVqfRwgOcSterdrBNvhx8dg/glov08h/NwSrV3ypqtvW8O0x12UOhlJG+Fst82yW5o3A3d03IwxB8mTHm9t2ZjJeIFLaE8l/8m4jXOaWtlGPQ0iBsldFcR35xtTMP4I6OyNeTYr+nmhFLwM64vhZxDey+koUyuDaupn1Xt7WIFDysuKXJFemUqOGDeGB1/5hWPBjFbctAAcoOyvkmtxvvPOBJNFxmnTOWshqwkPki5GX0TiJswhRYjkKA8Fu+uRmNthN4tFNBwKyqVW9xctRS23tVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1R4X6aJ1GTx9u2/5myXw+ZKBrLJ+JLEjk8Heme9JsYk=;
 b=d8+rg3xfh0YM/Ai+BVsTkIxnWtVrhFfHDmMMZKKybRGDnJuoE+bI9aXptENZbYt5x37kMxq1KL7a7QrYHfFlMsUlueBnS1/dHwTWy11vE27btXzhKlFYwb7pRaM6mdvcFbHQf907e2aLoXJNaHUmXhftEBQxPKnAjzsPRvhlkAU=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by IA1PR10MB6856.namprd10.prod.outlook.com (2603:10b6:208:423::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 19:27:34 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 19:27:34 +0000
Message-ID: <819578ba-c92b-4589-8916-f085d0e7a92f@oracle.com>
Date: Mon, 13 May 2024 15:27:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 03/26] migration: SAVEVM_FOREACH
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-4-git-send-email-steven.sistare@oracle.com>
 <878r0mmsxx.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <878r0mmsxx.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::33) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|IA1PR10MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a048f78-b579-4264-58cb-08dc7382bd6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkNrWS9KV0JIczhVZUVKRnRacitseHcrOHZhUnl4K0VEcG5OdkJnelNZN2Z6?=
 =?utf-8?B?eUp5YStrdWJhR0JSS1FVYVIxUHBRL2IxYkFrWlJYclNXVTdZbmpLNjRYbVZJ?=
 =?utf-8?B?N2VmdkRyc3dvU1VKeDFuUW9MZHhRZng1TEhyc05iRWNMc0luNEN2RFpqMUk5?=
 =?utf-8?B?RG9USWFuRERZOFQyRHRGNkhHaEdpamtOY2s0YTczU3dzWDA4Nyt2ZllLR1Yx?=
 =?utf-8?B?dnFyMWhtTlJRMG9zY2tFelVJYmUzdWNwaitNOWJXV1JaSE0wZWRnVy9NN3Q3?=
 =?utf-8?B?S0RLS2hhbU96VHlDVzg3bXlpYXZJRkRNWWo0RHVtTFJvbEFOYVk0OUNyTzJk?=
 =?utf-8?B?VjBTcXNqVWhrd2VRRDNwOXRCTHo1WVp0NThYYlU2ZGhaMDVpWmJ1MXVFVVJp?=
 =?utf-8?B?aEhjcWNNeHA5Y1R1czRtYjNmUTRPL3FscTZKYVEvQWVWQm9tekh2Z1hXYVM1?=
 =?utf-8?B?d1g0akJyRC9uSTg0YjY1TkZlYk9DOWNGUmxDT0llaG1IWW43MktEd2VnRTlM?=
 =?utf-8?B?SGFsVXVtckl4Z0NUZXNINDQ5WWZxTkRsMmNqOHlyU01tYkgvcGNXYjNLUm5x?=
 =?utf-8?B?SThHeHZxZmZDOVJQZ1Bsa1ZmSWJGbmlZNGZkTEtaZzd5aFlhU1pHWkdNVkEv?=
 =?utf-8?B?SXFSRWxmYVlJT1JhUzhWWVhVaU1lNTJPSHc3WUMrSVpLSUhrSGRrcEJTUEdT?=
 =?utf-8?B?WENoRG1JNUkzME54QW4rNnZMYUlQL2dJRUhQdDBFb0ZxZlpZVFN6YW1LN0M0?=
 =?utf-8?B?Z1NEeS9sTEw4anpOZUVaN2tMdzdCUmFreTF3TnZDeTJHeERNcVFiQnpWMjdm?=
 =?utf-8?B?OUQ4U1doZVduanZsS2FNU1NEd0xEWFM1K3o1b2d0SXBaR0RNRlgwNUpGU3lS?=
 =?utf-8?B?L2dtTEN5VnkrS1RGYzVIajV1bWNtQ2NDaGxCeVF5QVBrVVI2NzVsYmZZQlh0?=
 =?utf-8?B?N0dINXI4YWdtWGRpdWVGVTRTYmdNcVNWc1l1V2I5TERUZmxYcXVQNlREQU8v?=
 =?utf-8?B?MkIzMi8rejc1ZVlNeUJiYXNwdFoyQys4bDNCeS9BY0tyckhDOXdUZkU1MFlE?=
 =?utf-8?B?c0tQUjUvTGpJK3o3TVJpQ0MzSDZTa1NiV0gvaFg4dlVmVjF0R2NUUXBXK3Z2?=
 =?utf-8?B?alRXOFVEejdHUEJBRkxVRWZOV3FSQW83YnJlVHlVK29NdHQvRHNoQThLaEY3?=
 =?utf-8?B?cWljb0p2QkFwSzRkUUxtYmRtdWExc005N2NtU1RPWjFSQ0t3RGhHamdNMkhK?=
 =?utf-8?B?WCswbXF6dUtkQS9SaUNEMEllQXBXNkpWRHpQM0xrbzhsN21zdnZ5d2ZtQ2xP?=
 =?utf-8?B?OE5ScjMyTXgxeGg4aEtoaHg3K1U0aGhJampFU25uM2hIaHgxMVNQQVZDdG5p?=
 =?utf-8?B?NDY5aFBUQTU1V0xXdjRDcUEwSGZCbmVXODhacXJ2UUdMSytoZ2hYcEtDSmpG?=
 =?utf-8?B?N3hIN2pKNkFmbjFhdSt5VnhrekJFcDZ4MzFha2tjMkF2NUFmNyt3MU9ZMnRG?=
 =?utf-8?B?SmFJVDBVUjdZa1pKNDJiYXd5c2JKaXZEV20vbGFFRjkzK0hIVUF1OTdTNzhx?=
 =?utf-8?B?QmQ2Mzgyb1FKV0lSQmpoZllDK0M1K1ZaNEd0empKYUtnb3o1RGJPSnpFMWoz?=
 =?utf-8?B?Y2pxWkpWLzJ4QW1HaGtIZ3FnMHlFTS9PWEtnazlFaUljRkY0WEhGd2xyT09u?=
 =?utf-8?B?OVBMcmNNMm5kazdGdUd2cXVtQWFsWFdNa2h6VEVkQTFhRFFPNC9QQ0FnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(7416005)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0k0VnVOdCtmQXJRc3k4YXJSL3RwbnhGMnlZcEVUeGpxOTlsbHNsMVpGOWk2?=
 =?utf-8?B?RjQzOStPOGNOYis1TFNXN2JUd2pxak5XdDdwMVRkaFVGYXZHMjJSZnJZcVR3?=
 =?utf-8?B?dyt2Qm5GOHYyOTNJUiszYTF3ZHdvVGMwejRZR2kwOS82aHhwU0JzT2xzQ0Vi?=
 =?utf-8?B?TUNON0VuR1o3TjE1OHNXVjNlTXgyZXFLYWptSWp2R3haV0tTTk95UURZbHF0?=
 =?utf-8?B?U3VsdVlQT0s5ejgwcnFGcUFncTBsQU1TdE1XVzRocnk3STFPRkowWmtzVFY0?=
 =?utf-8?B?SXdXWFRzVzdBWDhNTDJRYm5ISjJycG1TTHJJZ05XayszcFFqbmNwWnl1Y3g1?=
 =?utf-8?B?VW5KMW81UUlYNy91RGl2c0ZxMEdMZWV5YTZkMldqSkE5YVpGVDYrdFBKYWdY?=
 =?utf-8?B?bS9BWUF0anI5Vmd0MXI0Myt0Rm5aU0k0UjRmemhpQzB4c0QzSll5cXhrZnBa?=
 =?utf-8?B?VFZQMzZwSEFkUFFEckZKQ0YrYVU5QjZjeEpLaVVUZHJKRkNJa3lhbGFmK05W?=
 =?utf-8?B?RVJOaHg0bGEzZ2pGcW1oUlZHOVhTci9ValVZZkxXcjB1YkdlSCtDYnprMG96?=
 =?utf-8?B?VnlVam1qNi9OdkNURnd4bFVMUWpaOTRKZk10NnZWUFNJR0YyVzBpaDExVW1v?=
 =?utf-8?B?N2xWRTljcTRiNzh4VlNDOFE1aVBVaGhSMzVqUDdoY2NJb0VaL1FUUnBnMk1F?=
 =?utf-8?B?bGkyVEhpYW9ZWm1iRDBqYTZpS25ZRU4yTXM2TTJkL04vYTB6b0cySVJvUmtN?=
 =?utf-8?B?bFdoZmVCcGJrU3Ftc0o1dTBxOHI2SGZJbnVBUCtmQ1lySk41NTVLamVZNDNS?=
 =?utf-8?B?Q2lJalRmajZrRFZGV20zeVN5UjhSaVR4cEtUZ3BQZnpyenJUY0ZxZ2t2OXZz?=
 =?utf-8?B?UkcvUVNuVnFlVHhjTVRnUnVrSmtOTkdMUHZOUnpuTVdhbUUzNWpzWkVhMjhM?=
 =?utf-8?B?cFdPcGkyV0tvSlNEdGZIYWd3MU9pVnZzbVlBZ1lSRnVNSkM1ckgzZVIrN1Fi?=
 =?utf-8?B?MHp6NXNGeUp1dUQ2T09PTXN6alBTV2FDbTBsOExFcDBKclBLRndnT1F0aVdO?=
 =?utf-8?B?b2VvYUtrY1NJcTFLRkh6ajZ4ZlJOQzFUWGFnS0haVU5wTUVFd3dJL2pseDc0?=
 =?utf-8?B?cjZhejZuY2EzQ0V0NXA5RVF0OUNlZVRBWTNBYjZJNGlXSUh5Ym1RQ3F5QXNk?=
 =?utf-8?B?U0YyNXp0WnVjRXBoWlJLRnA5R2JRTnY1SVkxU1AxbXpwL3JhbURwam9yOE9n?=
 =?utf-8?B?MGdFUFExV3JheHZ2L296cWJxUW9VOVNwdVQ1MW84c2NCTW45RlhDWGRrT0NG?=
 =?utf-8?B?Z1lWMGVIY1lUbjllaDREL2lvUjNJTldHTm5yK21uZE5pRm1TN2FNNHdhKzdB?=
 =?utf-8?B?V1BqRHRmRUdUNkY1LzdFbkdPZ3A2SkRHbmhMbXh1Z2NZeGtscGY0TjV1OUNp?=
 =?utf-8?B?N3hpTEdveHliVnZmYUIzQ0JhZlVkQ0ZWelhxMjFRcXc2Z2NvR1oxZzRuTHdC?=
 =?utf-8?B?OUlMNXFIVmRjRG5tMWZxWXNSa3FDRWJHRnhhYURyMnd1SXMzS01uK2RVa0hC?=
 =?utf-8?B?dTRVZnVFMTltWTY2OWRjL3JSd1BzTmZ2eSszRmpNcG1EeXJyYUxQWFJKSG5w?=
 =?utf-8?B?blI1Wmd6blV3T1JNT01qWUxGenl0OUpQdWxvc0JlbmhmbXg0MGg2ZGl3bTlX?=
 =?utf-8?B?Mjl0aSthZnNJNlZMZGY5V0U4ei9HTzdkc29vOXpVWDk4RDZrb0sxYWpBaURo?=
 =?utf-8?B?Z29PM1JBUFcxSHVPd1dlcUVHMEc5MVNrOGRSVFhUS0FibXdFMXlQVEtDK0lG?=
 =?utf-8?B?VTRRQlExVFppc3hNdjNoZlVCVnZxMWo2cjFQUWdKdk52UE5rRU4zUFlMcGFm?=
 =?utf-8?B?ZXF0alZFSXBFUjRuckhVcWs0MUF3T0sxSGtwZGtRMlVWL3ZGd1JiRFJtT0Fl?=
 =?utf-8?B?ZlY1dVNDR0hDdVVoZHBFV1I1ZkI4ZXRaQzdSYWx3N3BwT3dSWjdzTXNoak56?=
 =?utf-8?B?ekpYWUg3Wm1sVW1vWm15UmhaWWlQdlBWcXhkMWFZQnlNc0Uyamc0d3p3eVhK?=
 =?utf-8?B?T0hJcWF3QXhkN3NSYWhSQkNtK2o5UHdMS0MzRVFiZE5GT0I0cXRmdThhMU5B?=
 =?utf-8?B?ZWlqS2srWHZEemhZMHc0d0VZcnJRb2VYbWZWQVhFN05MQ3FiMzZGZTNRamNx?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2q7xnvx03ZAIs0UcdLrxKnnwYyPqBKIFxnQ+ZgMzZyBEmYN0sZqvY+j/RWCncGaYnzV8+2oKIXw2r3yXKg4hKKjGY5n7g6+cpy5cQnIHoZgC442S6eInFLGNGghgsGkughMRxTm7miiKvvaljxj5HWaVlcZF2N1XgconSKwmDWG2VakdLBYTwXLx9BLY51yYpfAflOh5ctEH90j62YXC6CDSlzx+SqxXXc32KIJjV0xQRpFTEaAXOxYDZVNHsdbIiRoBiB4jhHNKOldcUYCq5NLbB+3Qq9HBEKnwBIPi0NFA9xi5clXXKX//cRlW8eZnifyjola5DsYdiXDXcJQX/35Wt100VJOnLUTUNI5LXHJIgPLb2KjDOx9S2+Vvaj7Zfc2KdvmE+rFQTkgHitdO8mNV4gE5AZulo95ovR/DaNngi3gcIdDwFapXkcLTBrU2LkpPkMFJoKixjMLsSardJtHpXZL056K1lXjB0Cx9SjC7vhdsa63SRY+UCeUYBmFpnBhHpE06Upsf3Tgx6VF475U5N58Ukll4Zi9Gjcc9i29hNp/WHQrwaa+cARt8enFBQp04AGYXQZXusitbmmMlJGMlbK9x8kk90P0gj+FHRfw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a048f78-b579-4264-58cb-08dc7382bd6d
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 19:27:34.2012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i5ZAeadYCt4ZFUbb1DdJsWlKfWgXw8sQ3oin4pWONt+z4kxFCVetr8sZCpz3VvFIOmsSQIDgn7kmg4JD26+iMTeyfB9FbobZEfAlG61fPgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6856
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_14,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405130131
X-Proofpoint-GUID: h2G6Stjja8yQdVKSTfdn9V31zMHBEWoB
X-Proofpoint-ORIG-GUID: h2G6Stjja8yQdVKSTfdn9V31zMHBEWoB
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/6/2024 7:17 PM, Fabiano Rosas wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Define an abstraction SAVEVM_FOREACH to loop over all savevm state
>> handlers, and replace QTAILQ_FOREACH.  Define variants for ALL so
>> we can loop over all handlers vs a subset of handlers in a subsequent
>> patch, but at this time there is no distinction between the two.
>> No functional change.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   migration/savevm.c | 55 +++++++++++++++++++++++++++++++-----------------------
>>   1 file changed, 32 insertions(+), 23 deletions(-)
>>
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index 4509482..6829ba3 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -237,6 +237,15 @@ static SaveState savevm_state = {
>>       .global_section_id = 0,
>>   };
>>   
>> +#define SAVEVM_FOREACH(se, entry)                                    \
>> +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry)                \
>> +
>> +#define SAVEVM_FOREACH_ALL(se, entry)                                \
>> +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry)
> 
> This feels worse than SAVEVM_FOREACH_NOT_PRECREATED. We'll have to keep
> coming back to the definition to figure out which FOREACH is the real
> deal.

I take your point, but the majority of the loops do not care about precreated
objects, so it seems backwards to make them more verbose with 
SAVEVM_FOREACH_NOT_PRECREATE.  I can go either way, but we need
Peter's opinion also.

>> +
>> +#define SAVEVM_FOREACH_SAFE_ALL(se, entry, new_se)                   \
>> +    QTAILQ_FOREACH_SAFE(se, &savevm_state.handlers, entry, new_se)
>> +
>>   static SaveStateEntry *find_se(const char *idstr, uint32_t instance_id);
>>   
>>   static bool should_validate_capability(int capability)
>> @@ -674,7 +683,7 @@ static uint32_t calculate_new_instance_id(const char *idstr)
>>       SaveStateEntry *se;
>>       uint32_t instance_id = 0;
>>   
>> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>> +    SAVEVM_FOREACH_ALL(se, entry) {
> 
> In this patch we can't have both instances...
> 
>>           if (strcmp(idstr, se->idstr) == 0
>>               && instance_id <= se->instance_id) {
>>               instance_id = se->instance_id + 1;
>> @@ -690,7 +699,7 @@ static int calculate_compat_instance_id(const char *idstr)
>>       SaveStateEntry *se;
>>       int instance_id = 0;
>>   
>> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>> +    SAVEVM_FOREACH(se, entry) {
> 
> ...otherwise one of the two changes will go undocumented because the
> actual reason for it will only be described in the next patch.

Sure, I'll move this to the precreate patch.

- Steve

>>           if (!se->compat) {
>>               continue;
>>           }
>> @@ -816,7 +825,7 @@ void unregister_savevm(VMStateIf *obj, const char *idstr, void *opaque)
>>       }
>>       pstrcat(id, sizeof(id), idstr);
>>   
>> -    QTAILQ_FOREACH_SAFE(se, &savevm_state.handlers, entry, new_se) {
>> +    SAVEVM_FOREACH_SAFE_ALL(se, entry, new_se) {
>>           if (strcmp(se->idstr, id) == 0 && se->opaque == opaque) {
>>               savevm_state_handler_remove(se);
>>               g_free(se->compat);
>> @@ -939,7 +948,7 @@ void vmstate_unregister(VMStateIf *obj, const VMStateDescription *vmsd,
>>   {
>>       SaveStateEntry *se, *new_se;
>>   
>> -    QTAILQ_FOREACH_SAFE(se, &savevm_state.handlers, entry, new_se) {
>> +    SAVEVM_FOREACH_SAFE_ALL(se, entry, new_se) {
>>           if (se->vmsd == vmsd && se->opaque == opaque) {
>>               savevm_state_handler_remove(se);
>>               g_free(se->compat);
>> @@ -1223,7 +1232,7 @@ bool qemu_savevm_state_blocked(Error **errp)
>>   {
>>       SaveStateEntry *se;
>>   
>> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>> +    SAVEVM_FOREACH(se, entry) {
>>           if (se->vmsd && se->vmsd->unmigratable) {
>>               error_setg(errp, "State blocked by non-migratable device '%s'",
>>                          se->idstr);
>> @@ -1237,7 +1246,7 @@ void qemu_savevm_non_migratable_list(strList **reasons)
>>   {
>>       SaveStateEntry *se;
>>   
>> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>> +    SAVEVM_FOREACH(se, entry) {
>>           if (se->vmsd && se->vmsd->unmigratable) {
>>               QAPI_LIST_PREPEND(*reasons,
>>                                 g_strdup_printf("non-migratable device: %s",
>> @@ -1276,7 +1285,7 @@ bool qemu_savevm_state_guest_unplug_pending(void)
>>   {
>>       SaveStateEntry *se;
>>   
>> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>> +    SAVEVM_FOREACH(se, entry) {
>>           if (se->vmsd && se->vmsd->dev_unplug_pending &&
>>               se->vmsd->dev_unplug_pending(se->opaque)) {
>>               return true;
>> @@ -1291,7 +1300,7 @@ int qemu_savevm_state_prepare(Error **errp)
>>       SaveStateEntry *se;
>>       int ret;
>>   
>> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>> +    SAVEVM_FOREACH(se, entry) {
>>           if (!se->ops || !se->ops->save_prepare) {
>>               continue;
>>           }
>> @@ -1321,7 +1330,7 @@ int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
>>       json_writer_start_array(ms->vmdesc, "devices");
>>   
>>       trace_savevm_state_setup();
>> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>> +    SAVEVM_FOREACH(se, entry) {
>>           if (se->vmsd && se->vmsd->early_setup) {
>>               ret = vmstate_save(f, se, ms->vmdesc, errp);
>>               if (ret) {
>> @@ -1365,7 +1374,7 @@ int qemu_savevm_state_resume_prepare(MigrationState *s)
>>   
>>       trace_savevm_state_resume_prepare();
>>   
>> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>> +    SAVEVM_FOREACH(se, entry) {
>>           if (!se->ops || !se->ops->resume_prepare) {
>>               continue;
>>           }
>> @@ -1396,7 +1405,7 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
>>       int ret;
>>   
>>       trace_savevm_state_iterate();
>> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>> +    SAVEVM_FOREACH(se, entry) {
>>           if (!se->ops || !se->ops->save_live_iterate) {
>>               continue;
>>           }
>> @@ -1461,7 +1470,7 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
>>       SaveStateEntry *se;
>>       int ret;
>>   
>> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>> +    SAVEVM_FOREACH(se, entry) {
>>           if (!se->ops || !se->ops->save_live_complete_postcopy) {
>>               continue;
>>           }
>> @@ -1495,7 +1504,7 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
>>       SaveStateEntry *se;
>>       int ret;
>>   
>> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>> +    SAVEVM_FOREACH(se, entry) {
>>           if (!se->ops ||
>>               (in_postcopy && se->ops->has_postcopy &&
>>                se->ops->has_postcopy(se->opaque)) ||
>> @@ -1543,7 +1552,7 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
>>       Error *local_err = NULL;
>>       int ret;
>>   
>> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>> +    SAVEVM_FOREACH(se, entry) {
>>           if (se->vmsd && se->vmsd->early_setup) {
>>               /* Already saved during qemu_savevm_state_setup(). */
>>               continue;
>> @@ -1649,7 +1658,7 @@ void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
>>       *must_precopy = 0;
>>       *can_postcopy = 0;
>>   
>> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>> +    SAVEVM_FOREACH(se, entry) {
>>           if (!se->ops || !se->ops->state_pending_estimate) {
>>               continue;
>>           }
>> @@ -1670,7 +1679,7 @@ void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
>>       *must_precopy = 0;
>>       *can_postcopy = 0;
>>   
>> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>> +    SAVEVM_FOREACH(se, entry) {
>>           if (!se->ops || !se->ops->state_pending_exact) {
>>               continue;
>>           }
>> @@ -1693,7 +1702,7 @@ void qemu_savevm_state_cleanup(void)
>>       }
>>   
>>       trace_savevm_state_cleanup();
>> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>> +    SAVEVM_FOREACH(se, entry) {
>>           if (se->ops && se->ops->save_cleanup) {
>>               se->ops->save_cleanup(se->opaque);
>>           }
>> @@ -1778,7 +1787,7 @@ int qemu_save_device_state(QEMUFile *f)
>>       }
>>       cpu_synchronize_all_states();
>>   
>> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>> +    SAVEVM_FOREACH(se, entry) {
>>           int ret;
>>   
>>           if (se->is_ram) {
>> @@ -1801,7 +1810,7 @@ static SaveStateEntry *find_se(const char *idstr, uint32_t instance_id)
>>   {
>>       SaveStateEntry *se;
>>   
>> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>> +    SAVEVM_FOREACH_ALL(se, entry) {
>>           if (!strcmp(se->idstr, idstr) &&
>>               (instance_id == se->instance_id ||
>>                instance_id == se->alias_id))
>> @@ -2680,7 +2689,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis,
>>       }
>>   
>>       trace_qemu_loadvm_state_section_partend(section_id);
>> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>> +    SAVEVM_FOREACH(se, entry) {
>>           if (se->load_section_id == section_id) {
>>               break;
>>           }
>> @@ -2755,7 +2764,7 @@ static void qemu_loadvm_state_switchover_ack_needed(MigrationIncomingState *mis)
>>   {
>>       SaveStateEntry *se;
>>   
>> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>> +    SAVEVM_FOREACH(se, entry) {
>>           if (!se->ops || !se->ops->switchover_ack_needed) {
>>               continue;
>>           }
>> @@ -2775,7 +2784,7 @@ static int qemu_loadvm_state_setup(QEMUFile *f, Error **errp)
>>       int ret;
>>   
>>       trace_loadvm_state_setup();
>> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>> +    SAVEVM_FOREACH(se, entry) {
>>           if (!se->ops || !se->ops->load_setup) {
>>               continue;
>>           }
>> @@ -2801,7 +2810,7 @@ void qemu_loadvm_state_cleanup(void)
>>       SaveStateEntry *se;
>>   
>>       trace_loadvm_state_cleanup();
>> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>> +    SAVEVM_FOREACH(se, entry) {
>>           if (se->ops && se->ops->load_cleanup) {
>>               se->ops->load_cleanup(se->opaque);
>>           }

