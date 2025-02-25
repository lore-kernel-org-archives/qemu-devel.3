Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A220C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 19:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn0Ot-0005Q4-Lk; Tue, 25 Feb 2025 14:15:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tn0Oo-0005OR-43
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 14:15:22 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tn0Ol-0005PK-8Q
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 14:15:21 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PIXgBW007517;
 Tue, 25 Feb 2025 19:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=gLepyF8wDyTX3MkG50N2v1Pj4OGYwcyg1lrBsloryVY=; b=
 KBWyqUoFFi0QoWInckl7vtTDkhtGnQjuVxsuZopZWnpglXcECluKxW8B7t7r/PE4
 4Y57dt1NKfeMkqBhp7RynDTXtX6t3TlaQWQAe0vy+ZOuTmwP3hTN+jyJI/yd1pbN
 mqaiZkZc8kUojx+zjN74FMCGdoLnuWFctLhWFxmr1VHhtPpJJQtxfqkq9BbusEoF
 VTjT7RmjOQ8blJMNBp/mRUlN/dLFMg66PD0ChOI2i7jg9s8H9eNjrjcgbXLjII5w
 iNP1aAWZ/ZPhrNeH04BWoUGhofEMAs/diOzBHzxqCfKVFMg/cET5eGlmG120q2ci
 8uCo4BVwPyNFI09Z/ZHr+A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y6f9e0rr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Feb 2025 19:15:14 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51PI5d8Y010096; Tue, 25 Feb 2025 19:15:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44y519e0tj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Feb 2025 19:15:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJ1BWIJLfM4Pz8W1Q7UIALBJdckiyepdiKvbe7iVbWg+rIEtzn7HVfam84Opr2Pj+33IVVI5aIZVwyrYAx0J7dN3K/fUbGV5EWN+eaHqGkMazajZEOmqzJWJEooenrxldTBna0lbzzqe+ibF4tFVoElzeqRIAUm+qbsRPKOyc0+nIgC/a97tIHClE4YF2EYTlNXSrr1xAMABBoJ6MSSikQrR3MLag2QYeyxXVS0WA6MnP6kccmheXWbQbCXB28EafUId0IasujS+xrv6uRuQwZosaUSOKHBl8kkC2EkaV9sDV32T91bGjnZ9fn6j0qWQfUrs9+Oo03Z0ywXWiaPYwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLepyF8wDyTX3MkG50N2v1Pj4OGYwcyg1lrBsloryVY=;
 b=o+8fLAd1oPsG33Rrxv90oN7vwxWYjv73cAR1wAOwCBQ5/uIa0U+Os8R/iup/NKPfn8rnm6eLqtBVPsIt4+XxlG9nDxCwPW6fxjO2KT7nL/4pe6ABGa+H7IFmxPsWlau8iNagnNO0HWxm6ccxK5c7TJGMFQz8hWnX7w0UbSjZszhqjiivcVDGnygMp3XASFPpT9OLo5gGfGrgHkTxcwEmXE6kLlOOZ2lr01eXSQYWfgWRkIWQC5PStD0LSCZncICQRULxfHpd1PkyfOZ2emc9XdlJTRsKK7fswx9X/isD6uq43TOAHlfigq8k/Vs1/6o8OZpg9QdBVZBdZFMnNV/NrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLepyF8wDyTX3MkG50N2v1Pj4OGYwcyg1lrBsloryVY=;
 b=LZtQVLWWmRRuOkP2OBGkRLwg/OEu7v9BaQchbI4Q+tuij1vqWjg12OOPIeg6hH5zkYJE73GRhdF1T69OAm7j0Nf2D94i8rguU5EuihdNTOuxx++xQVqzm8dbR1b/jKbA7n2ioBJOJeO5FdDfFtes2xYTqZ8MArzWnooftzsz/7Q=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY5PR10MB6071.namprd10.prod.outlook.com (2603:10b6:930:39::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 19:15:11 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 19:15:10 +0000
Message-ID: <39fdf80a-e983-4af4-b780-bd719395f585@oracle.com>
Date: Tue, 25 Feb 2025 14:15:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] migration: ram block cpr blockers
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <1740409979-243462-1-git-send-email-steven.sistare@oracle.com>
 <3f00e92f-1229-4d1c-bcef-832e399671c4@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <3f00e92f-1229-4d1c-bcef-832e399671c4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::12) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY5PR10MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a6de6a-1048-4a1d-81af-08dd55d0b941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUpWNjdMVmgwUFMwTkhDZ2FxMTd2eVhvTm1aVy83WTR1L0F3Z3A2ckgxMTFk?=
 =?utf-8?B?N205WVVwS1lDRGZLUCtHRUw4VGF6dXJsTzVZT3JMQVp5UmNubXVHQzBCREFX?=
 =?utf-8?B?N2E0NU04MjlNL3FvUzFxNUxQK1ljdUVpUWc4Mzh3cGE0T2xUOVNqdzZNWWRB?=
 =?utf-8?B?RkoxV2xxYUg5YzI5QkdCOFRIcjd0NlB4dmhscDZ3a2xyVmZjTWwvc3dZMGdW?=
 =?utf-8?B?aEFPZ3FBOFZXejhmQTNhQmVTZytocEYxdEU1VVhnMkF0aE9iVjI5R1RWQzZP?=
 =?utf-8?B?bjgyTUZsS3M3Y3JpdVpDdlY3b1k5ZVFST0kvWXZjK04wTDkzcXVXdENrWG5r?=
 =?utf-8?B?SWtvWHF2OWNscWpOWnRVRlJWbnZmbzNzSEpZMEVlWFVuU3FHalRKNVM2N0or?=
 =?utf-8?B?QXR4SnJPMldQbVRTZzRrckJIaU5DZ3VhZjNZYVY2UWVaRlhJb2xtOE9sZHNU?=
 =?utf-8?B?a1ZXbkt4TGZKT0NUOHNGNi8yaXJTanZDNmsxZW1QVFdhamFhTE8reXZRK01F?=
 =?utf-8?B?WE5GTGttVS9zTUV4L2xoWXQwd2N2eXpIOVo1UW9BU2xnajR1YTdBNEZIbGw1?=
 =?utf-8?B?VkdLeG5Qb09pMTZyUVlVckkxZitSUnlEUDZibW1LNDNucmY4cFpzU2JpSGVQ?=
 =?utf-8?B?M2M5c0ZpRjYwQUwwYTdrRzlGTWkvVWg4SjlZVGloeGhSUmwwYXJONjlJRUlY?=
 =?utf-8?B?TVo3aDBYemNvRXRPbEsydWE2SmxibG1xY0dqNjVxeXpRd2pSOERNLyt4Q3g2?=
 =?utf-8?B?VHBLR1JtVnJxNmlpRWFyTWVDcVluWmdaczlXQTZwaVQySmsxbHo0VE54Z3Fj?=
 =?utf-8?B?c2JBTkszNWVzcVYwOHo4U3hycDkrRGtzZ3lrWWttdXBGdm9nM3hZOGlJSkFy?=
 =?utf-8?B?LzIzV0dpWWJaaXUxaU51RStuWU5EZnhsZmljUGU1VC91RVMvK2p3NGp0RDBt?=
 =?utf-8?B?NjJiV2hDVFdXWVR1eTFvRTBZNEdrNUJZcTBzY2c5b0FzaDA1eEVKNFV0UnRv?=
 =?utf-8?B?TGQvL01iZ2UrOFBoUVlrVjI1QlB3TnVmN2tiUFBzeUVNTXE5SU5RUG5BRzZz?=
 =?utf-8?B?UWgwem9WMlBMUEJMZWZjRHU5NUNadUdSQ0tEZEozdDAzdm5WdWc3NWMyWFVn?=
 =?utf-8?B?WEJsNXdvbTBhL1dzWGI4TzF0VC90RDhSRGNSUCsySFhJV2JDU3VQb3pZbzFT?=
 =?utf-8?B?amEzd0hNK2RMSG00TThBVGlGOUlnWjU3WmwwT2lrUmFtNlhlNTEydThQLzFp?=
 =?utf-8?B?QjNwMnd0YTV2V3RLZEViU0M0eG4yUURBWVJHRnZnMW5TcjVqZWZhS3NiZEMy?=
 =?utf-8?B?SGN5VjRsNVp6UHlWV1VzcVBaSWxIb1RzVlY0RHJKbjRJTFNSc3h0bE5vTkJR?=
 =?utf-8?B?aXJ5RXEvaVMydUJ4NklLSVZYaDRmVi9YMWp1dU9WOUF1NVpHOWNmUjZpT292?=
 =?utf-8?B?dURlLy81SVNMY2NpckFKM054WnlSZGFObytkOWNKTUpHVmExVG03bVVUTmNu?=
 =?utf-8?B?WXlaWmQyRHJpdklPRzlmelpDek5YMkxuTVlpb3l6c2dhajB2MTE2YnFPTmtC?=
 =?utf-8?B?ZzJEV244Y0tyWlVSUzRMN1hjMk5SZDU3eUFkaHBRR2FRUlFrbm92SnVVQ01z?=
 =?utf-8?B?WEEraUEyWTc3OWFoVUxraXZnSENYQU9IOHNqbFQwdXFUZFdEYlNhclpLOG56?=
 =?utf-8?B?RVAwNzJaZE02YmZ1d1RVTm1EQTdvcTZhVTZucUo5TjBCTmhydnZPY2dJK3hV?=
 =?utf-8?B?aHh1ZHRDbEc0WE05UXRXODFpK3RhKzJISVNIY1NxZ00vYndvY24zbFVvaGRZ?=
 =?utf-8?B?c1RRNi9YWWorNTlwY1k5MU9oS09FaWNzejlJTENOQ1YwejRXT2c3UVU0OUhU?=
 =?utf-8?Q?a/TMUw/f3GkUA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bE9mK1h3RXY2NWJZL0huOWdDVmFiOEN4cnNoZllLQWpvTWp5MEhhaFN6OHRt?=
 =?utf-8?B?ZzQzdVRJb2FZNldhTzVFV2N5ajl5bWpRdU0yL2ZqS2NoQWpEalY0QS83b3Bz?=
 =?utf-8?B?MGNtNEcrb3BXeHljMCtkOUpkK3NOZXluM2MwSnkxV096QnQzalZ2TXdDdWh3?=
 =?utf-8?B?SGhTQ0ovR1cwR2l4eG1mVWZtME9WMGFKTzhoMnl2TUUzMTBvd3hGTmtPK21G?=
 =?utf-8?B?K0UrVlVSSGdkTHV3L3VheW9iY0hxbUsrTkNBV3BDRkd6Qm5tL3ZmdTFYcDR6?=
 =?utf-8?B?NktjMkFJNksyRExCeWxoUU5mQmNUUGRGek5kVDUxanpGTnlNSjJDb2YwY3pX?=
 =?utf-8?B?RlM3ZDExa0Fuak1hY3MxbXRuc1FqZWhuakVQMTRJRjBoeldJTGI1WW9YUUlz?=
 =?utf-8?B?OEI3bHV6WUZ1bU9IcWQ0V0dVdVVXU3JWOHdwZ3dUdHZWQ0o2WVRxaStyQVVZ?=
 =?utf-8?B?UXhHSk9uMFVLZzQrN1YyUzJrNVlwM1dEQm5kUkZNVEg2SHVIOUFHT3BFa1JY?=
 =?utf-8?B?VzhKUUJ3TWhWMjN0NXhodjVMdnNUK2JQVjJocWdpM21qWVlIQ3FTOVVLY04r?=
 =?utf-8?B?NzlFQkFwZDZjc2VlWHFJN2ExVytrREttM3lrcVJXQUdBV2VhVFNHeDh4KzNV?=
 =?utf-8?B?RFprODFlWEs0S25Lc3VGSllZMXI4RnhJZ2VxR05HNldBVElNcjN0V1J6aS9r?=
 =?utf-8?B?ZGR4OHUrSWRqakpSVU1rcUZKYWRQQ2hTakhkYW13eHg0NTREcmd3OFRxckt1?=
 =?utf-8?B?bnllNHMyRG9LU3hXTXI3clpHRVFzQS9kRmg2OWxweTJLaGhOclBzQWdyWnFz?=
 =?utf-8?B?cGlTODhMTHRqVzJtcVpGRU5nRU9pZWZ2SDNqYkEzbC9nV1NvMVFieVhQSTNS?=
 =?utf-8?B?TGR4Sm52dkpaL0ZLRHBOTmhOdVY3T2VydTJoZWlEaXU4RmU2QUxCV3N6MWp6?=
 =?utf-8?B?NEM2aklLcmhwVVdzTm9vSnpRRytQRXEreHljYW85SmZvZkU5THlXd25xRXFJ?=
 =?utf-8?B?dDloMGJZQ1dPaXdqaHRXMzZIU3RwMndkUWZqTnVIWS9aWWZlSUZDSGQxNk5q?=
 =?utf-8?B?bVIyVGxWZkRnV1dpU3NHNlhIbm16VEtqZ1hzUk1QNEdYb3d1YVZROGR4Z1l1?=
 =?utf-8?B?UXNhVHhFYjhPb21lTEpUVUs1RFlObUJXRE1DY3h1L3o4dzIxa0NyTGxyUlVE?=
 =?utf-8?B?M2lESm95cGpGSGtXd2tLSHFJMUVyQkVuZ2ZBZ29ES3BnSXhjUm8wNk00R0lR?=
 =?utf-8?B?bzdscVJzT3hoUmNXckdLMTIwK0R4MWFmbUtib09BeWkxdHEzWkJYVzNMcm0r?=
 =?utf-8?B?d1BHRmNPOEtqdGZIeGIyd1Z2NzlNWlVJTk1jMjZLNmp6QkM4VENlSkdOblVy?=
 =?utf-8?B?Q0RVWWZYNlRwZVdYdDJrdm1GTmcwRG54cGw4VU1nbHptZjA0RGZyYzZ3TG54?=
 =?utf-8?B?M2RPVUIxSGRCZG1MV3BPQVNpU2c3Z1pqa3Z0cHUwM0U4NDJDUjNQeTdHMzRl?=
 =?utf-8?B?c1pLbjRiMVlOVjdxaTRxSmRLcjdXajVRL1FialU5Z1NaZkxDd3VSYThhUUxa?=
 =?utf-8?B?RVBVL0pHZUJ3QTkyQzEzWGY0MmVLQkFMVWJzYXBzZGpsNjdjWisraW9TcGhR?=
 =?utf-8?B?MXhZREZnd09BZFFzenpEdnRBZVBSNFZYNGpLWG5MZVNjYXNtaElZMFJqZTJP?=
 =?utf-8?B?WS9iWjcrRkI0YWhZL003Y2V3QVJYR0ZSR0pIeEpYQi94UFczS29mM2w2VVYv?=
 =?utf-8?B?bzdWVFlkUnZFVEV4c2wvTkxKMm1WcGYyRlRYeDFaUitEYVpQR0dwcFVRV2JV?=
 =?utf-8?B?VVo0c0N2ZGdMa1ZZbTJKS20zL1M5NkQvNWZyYXZTKzI5TkxXeXlYRHZMeFZa?=
 =?utf-8?B?a1ZJb25nTmpjNlE3eGZGK3pacU50SFE2Vi91RTUvVlRPOVdoQ05wMDEyeDBR?=
 =?utf-8?B?WVRBaTRTQ3BqdGpCUXV4b1IrdE8vZm5Pd1NWZXZObG12cUxQSzhxbXIrMXBH?=
 =?utf-8?B?WDA5dGd0LzFzV2tiSkR5TTBYRk4wRjJ3T1dUeVFBVnZTR3VOUFVSNHJiT05T?=
 =?utf-8?B?QU4xMDRDbWhnMll3MjV0MkhTTC94dGtKOVVDKysrVlk1WmFOb1ROS0NMSSs4?=
 =?utf-8?B?UzZWcWtkTlNyY29pMlplemVYWktsbGJhUFlpdFJ6M0RUUXJzNmlwQkhqZHpp?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aP9U1qrJ+8voVdboqFNBEflY/uXispBCq23nlmLzNvNjiUVqY84c5cimtJAlAlWrM24catSGTIuHycZrYDuI/2wQGBpdegv4CD/fY7zHY2wbt0xUdpExkp5JhKJAbZvXmu+oqcEEYbs57NRqCENs/1ua5hvtaZfGABrIhII4RJ2DRDi9evFX6Kedf3RhRjwuo7sSpP4xxt2tX6QF+JFnkd3NDrix6OAhcnMUazMjJKjqyD2Zjop/ivBs7bm2YC6m3ayW9cp5MSzTW4mzmWqUy/noqEqCt3mwaqMGktIqBLGhqJqn02MnT8Tw3oJ8Z+AXu9w1SNQFN24fGYGuQmyQkqiDzXrbhHbEOUmYbx5F9FjVGobOXmRdVynaE0ujzMKNOOPLs8EIAT+raVui8Z2t8A7qjW74MiRoMkD/QaPpMf2sC0nsHz3SuZaDHDmNr0BEj/fLjGQy+qlylFUN6FsOxr17Ve/BFM+e1OCxqOsJ6Tm5SbM48DIqV5TbT44n8joRN5BuBzCof/qybGudIyTquY6+vF28t9mtexnbeB2LL0DfmMG7DkglIQ7XF6R4kOSb8eeMP9G9GlsfQYitg3EVRG0WVfEcsPyl0kgP3gAq0J4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a6de6a-1048-4a1d-81af-08dd55d0b941
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 19:15:10.8913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bnpL6YCIOMDwSEkuazZ2uIpm0jN8rquEQWKaoZv222xWZSf75GkTlVMqklQB9jxMzyiB9XPizX8AwkLrigA0L3JrI5PatIIMvBUqQlbqPHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6071
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_06,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250117
X-Proofpoint-GUID: 0Nn1fi2fHaIulKnYqOE1lc7kbkMY5dUw
X-Proofpoint-ORIG-GUID: 0Nn1fi2fHaIulKnYqOE1lc7kbkMY5dUw
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On 2/25/2025 11:36 AM, David Hildenbrand wrote:
>> + * Return true if ram is compatible with CPR.  Do not exclude rom,
>> + * because the rom file could change in new QEMU.
>> + */
>> +static bool ram_is_cpr_compatible(RAMBlock *rb)
>> +{
>> +    MemoryRegion *mr = rb->mr;
>> +
>> +    if (!mr || !memory_region_is_ram(mr)) {
>> +        return true;
>> +    }
>> +
>> +    /* Ram device is remapped in new QEMU */
>> +    if (memory_region_is_ram_device(mr)) {
>> +        return true;
>> +    }
>> +
>> +    /* Named files are remapped in new QEMU, same contents if shared (no COW) */
>> +    if (qemu_ram_is_shared(rb) && qemu_ram_is_named_file(rb)) {
>> +        return true;
>> +    }
> 
> In general
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> just one more question:
> 
>> +
>> +    /* A file descriptor is remapped in new QEMU */
>> +    if (rb->fd >= 0) {
>> +        return true;
> 
> This looks odd / wrong. Assume we have
> 
> !qemu_ram_is_shared(rb) || !qemu_ram_is_named_file(rb)
> 
> (negated condition above)
> 
> Why should having a fd be fine? It could just be MAP_PRIVATE/COW (which you document above) or an unnamed file?

Thank-you, that is a bug.  I will send V4 with

     /* A shared file descriptor is remapped in new QEMU */
     if (rb->fd >= 0 && qemu_ram_is_shared(rb)) {
         return true;
     }

- Steve


