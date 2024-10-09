Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D32CCEE343
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 20:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syd0W-00011D-FI; Wed, 09 Oct 2024 16:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1syd0V-00010u-Pr
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 16:10:03 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1syd0T-0005pL-JN
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 16:10:03 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499IIQsu016797;
 Wed, 9 Oct 2024 20:09:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=T0Pvo64ZvKbGAXzb7ME9ghjYxj4jmkSekSmZqwmGd5w=; b=
 itzZcRKz5xqUmtM8Cr9/cIjxDFpLklaLUHO3v4FO2dOeeV9mFbLYgvUUCwznlUfW
 9XcbuecEzWUWNvSvz3qwIGPFuy6MmzunKDueXczaAzweBdjOn7+fom1pcxYwPySW
 UJG10f5CQFj+7+qhKhaG1VtJR8H5QXJCQPdeiTdKEVEJXp9ih3sNblSrBmDSrpmg
 N/WsYphjvmccy9kpdtJ3Tc4l4WsnaULBlrf7Ng4Y19NWGYMwTD3SUzUzAg5kuVFl
 waHuQfbUqRuxEzTnrrQC8Kdj97/EzP7o3OhghDTMy43p3Nv7Ux4usl6RqZRjOQgW
 nWcsuaT4G6GLFoIfJT4NUA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423034smea-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Oct 2024 20:09:55 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 499IUB2S019073; Wed, 9 Oct 2024 20:09:54 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 422uwfe9g3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Oct 2024 20:09:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jWEMeo/xThkBt4B+Jmn/kJIO6s8EI1gO4XxwvZ6NrVQzTiuTZWumwWk+lv2sK5o5iYA2xz5W2XrnSrP0Wy2461usb5KC8up7aSOmOBBswYhm1RWFoOEn2hToJI0U8YaBf/5BUPDVBTvWL6zRC2dyYHiulckmoubsfLOU/AdJb75NvQtXK88cEyCBl0OizgRk4Mjr6dOuIQQ24eSdQO6NC0LYvvH800rU1CXZU+8JBITfQuk2K5suoCLIPTZ9Sg32YCo5Kxb7vfN7EHk0URBotNAMGp4xFIeLhNwzEECRrLHACf7Wv76GGAwnACwMswx6vCiMcn0f297mVGj9hCf2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0Pvo64ZvKbGAXzb7ME9ghjYxj4jmkSekSmZqwmGd5w=;
 b=vEHbp1eX0v8xGhasgQVoqrsoxt9y3dMD6yuACpIHtBmRzl+qIwzewN5dfyaYAnL10yMyAoJdxCwnZEz+u6nGenCLJH3ZKX9dKeKvfKZeLR8DVsn0reLVEiK/6d9NGYD26x3LLCqOH2Sd4PO2nF2LHtfYkeQU/GSsIGKxfgb+oUTECUAEImdN+d89TWEGcTMdYC+WRHaS8iLAyTrtu2EdppXxJQowND16SFdJ2gnYjK/TUomnzOHtdq/e30opuHAKzhvDZSMFh9u4zyk3Qb6PTT5JW4MgSnwLmF2752PhQ9NLrnTmg6UGhVResi06fyOozAFkN8QOWkjrKVEf3Y539g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0Pvo64ZvKbGAXzb7ME9ghjYxj4jmkSekSmZqwmGd5w=;
 b=pS4DYSprbGItqofqc53CyQwr6bTHw3eyVX/v70LGCNEx7IS1iYOfQtZSY+9T193A4nNCpLy8WFJFNaQI7QPtxKQIHyMq2Y8aH78bqspwnyXigQUYilT6hBqlr/L/+jk0z+yNg3JNArHGRaHD/BGQjF7JrvF0wBJWx4tVZetDE4g=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH3PR10MB6788.namprd10.prod.outlook.com (2603:10b6:610:14b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 20:09:52 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 20:09:52 +0000
Message-ID: <95bfa06f-de5a-42cc-8078-c49fd617a73b@oracle.com>
Date: Wed, 9 Oct 2024 16:09:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 13/13] migration: cpr-transfer mode
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-14-git-send-email-steven.sistare@oracle.com>
 <ZwQ6GbVCmitlills@x1n> <eb41bce1-a776-4bb2-adb8-23fdc7cff1fb@oracle.com>
 <87ed4qtpo1.fsf@suse.de> <ZwV-NRICDNTajTRq@x1n> <877caitno5.fsf@suse.de>
 <ZwWMj4FYYpOSnPbe@x1n> <8b92a6ee-19f7-4483-9766-6b849cc04017@oracle.com>
 <ZwbUTXCxxl4heZYV@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZwbUTXCxxl4heZYV@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0121.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::13) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH3PR10MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: ffd0eb8e-9c73-4d64-68cb-08dce89e5617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UHo2RXhFUGxNS1QxaDY2Tmo0a1k0QWpPZGRibXE0MmVlZ2ROTmZyU1M2NzUw?=
 =?utf-8?B?UnNVQWZieDV4NDFzSlhvMTFPcklFb3Y0eDB0M0JNZkRLQ2Q5SHF2TVd5VEc5?=
 =?utf-8?B?VnhaL0d2OTNCQ0QybW15K25ucklWS2NDalI5WXlxdndnU1BlNk42S1BneU5a?=
 =?utf-8?B?bTJPTC8xV20wTSt2clhWenpRNkYvTzhUOG9TVGNaQjRkVHExNTNubk1qNUtq?=
 =?utf-8?B?S1hQa3Noc25KT0IwSGQrLzNRdElybjNlaEhxSWxlRENtWDV3V01HZ092VFJn?=
 =?utf-8?B?OWZNYnU4VUZiYjhQNzNpT0xSSko0cUp3eVBGaWdEMHl6UjhyQVFoNzdKU1ZH?=
 =?utf-8?B?UG9oVmZTbU5LbEVMTnBQNUg0QUE3bTdjZE5YWCsrSVVCTGVDbTBLU1ZEVlZB?=
 =?utf-8?B?dlVjNEpza0xtTDRicTJMY1g5WlMrU0lVaytkZVBuTWhJUG5BTDA2RUhlVEFG?=
 =?utf-8?B?U1dacDFmcHJCcGU0dXc5SHpacGo3cTdhM3Nqa0VpQ25LVk9jUFFFS0ViQ2ww?=
 =?utf-8?B?UncyNmUwNDJZWDNRVjlOU3pGRDkxVGlIbm9LS3FLTCtGcy9YOEl2K3Qwd2Nu?=
 =?utf-8?B?TzV1TFRKUVJWSlFsblU2VHN0WVJMR1MrOWtJNytuOXROUk0veGF2M2VuZ1hl?=
 =?utf-8?B?OUlLMEtZa2d1UEZucFcweHpwNC84cTRpWUNVZGF5VTRiNmNaeWRhZlRQQktQ?=
 =?utf-8?B?bnNEcTJsUnE0MjJSaWdyZEdqU2RuYUhXQTVkTGVmQXdvS0hIK29hVityUE9o?=
 =?utf-8?B?QzNJMkZnWXJoSXQxVWpSMGZ1RjlwWVdFSE4vUjVmUFNsOXowWGZqblQ1TzFh?=
 =?utf-8?B?N3JuQW95RFA0OUZZSmJtWElMYW5uWXNndnk0dEJRbnZJVzNpdkFVSzF4MzBw?=
 =?utf-8?B?MEFZbWRiMXFPYjVCMnhKTkxDeUFJUmt0YnBCLzVEemEyYWdkeEpyVGlLWCs4?=
 =?utf-8?B?QjFnbzFZYkFNWDRrMEZ5U3BvTUlIN2Q3Q3kvb0x3cjcxWDN0NmFWSVJzdjNR?=
 =?utf-8?B?czhsYVpuWEVNT2d0MnA1L2NRbzl3L3JYVzQ5U3Z0UWlVR3dkSWlzMXoyY2pT?=
 =?utf-8?B?QTBrWWExeFRIMkR6ZGpXUFpiOVA0WGFoQndraG9pblZiMWhHaGZzWVhpUnNN?=
 =?utf-8?B?ejJNcTd2V3NYYnVCRUNrTk0xcXBwbWNtQXRSOExFaFVpSjU3VmxNZmxIYzVU?=
 =?utf-8?B?TFVLbmc0c3FCSzBDeTNKS1JhNHRJSy9aR3IveXlSYlE4WjV1V1Z3d2h2SlUw?=
 =?utf-8?B?bk82bGNDZkk0d04xRkdBcjNlMmJKK0NyYVpkRmViSDFxVmpwNFJOWlJuRDVQ?=
 =?utf-8?B?d2VqbVhSc1lnbWFINkFoQlFQRTVpS09BU1BjRlR6cEV5V09qMHNjNnMrb2Ex?=
 =?utf-8?B?MC9jdFRqNDZ2WXZiQVpNK2toTmdXSENteTdvMU9HekFpWS9DNGxZZURJWVRJ?=
 =?utf-8?B?UU9lM3hJeG9YOHRlV2ZhSVNoQWVwT0gyM1NPMGpGUyt6SnhwazFvNk1BTTk3?=
 =?utf-8?B?QVhzTDJLdjI1bE5OcU56WFlVYkFtdUdKdm5MdW5EbGE0MmtvTk5tRkJkbFRQ?=
 =?utf-8?B?NmpHT1dlc3ZIdGFLVy9IcUdWUWg5dlhiVElVclhYV3IzWU14NjJoaStpcVcx?=
 =?utf-8?B?cVRYZ1ZRM20yMGZ4TWRXRDMrdlY3T29FSEo4c2d5TXFCYUFjczlNZjMxQlBq?=
 =?utf-8?B?NmUrQXhNRThKYm5wL2ErV0ZXbm9OV21HK3Y5YzRjVyt6ZjFQZW51WU1nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHZZNlBzUlB5Nk5MbXFUZkxUK1AzaFpLakkvWk9QcEZFT3ZOeGNMUzcwSlVj?=
 =?utf-8?B?RHArRFpBbEJrTHVFM2lBNElQVjh2cmJ4MVlGbkExbTh0eWkyN0F0YW5PY3JO?=
 =?utf-8?B?WmNUcG1lWjB1dkw0eTNxWVRDSnh0UVd6NWxsbkFrNjhqM3Z3OHg5RlBlVE5n?=
 =?utf-8?B?SVVzZXZuNzQ1QnRsTDdKN2tTdDFZajdHMjF3SVpCVll1RTl6Y3FTbDBucVNU?=
 =?utf-8?B?bFN6U3JTRWxJcXp0bUZvWERhWm8xWm5nYldRYWpJRTgzbDVOVHMvd1FwNkN6?=
 =?utf-8?B?REo0VFFpUHFVdTNrcFRUeEVCVHBUMGN6OU1GOUp5Q2lrNTJ5MjdkUUdONVZu?=
 =?utf-8?B?Zm9YeG9hSVlmUkwzaFhxQjMvb293MlBieXpGN0xTQlVVRHVHaDlJUmZGNXp6?=
 =?utf-8?B?THJZbXgvN1lDakhUL2krSFJjSHJ5N1BhWk9rYlhKNkJQaTJPaDhKelo4dFVP?=
 =?utf-8?B?elArWG9uNHZmdnozZ2VFdjJxWSt2ZzUwT1RmZlZ6WW1JOHhqRzRsaVRBSXoy?=
 =?utf-8?B?MGdHVHJIL0ovU3NmbGtodmtRZVltQ0ZPUlF1alI5cHFyQWhpU0Y2SU1XR3B6?=
 =?utf-8?B?MEt5VFhsTXlreTRQWUVGdFhpdDU3YzMrWStmcnAxYkhVRzFKUWpuSS90UDhM?=
 =?utf-8?B?N0VmWVFrYUpNMk5zZ1ptN0Z2d3g3QmxwTlBIYzB1ZldmN0NnL2FZTmtmUXV2?=
 =?utf-8?B?blJ2dDBSYm5aeWVCVFR6TnZSbzlBRnpmdm1UV1ptcUJnd3QxVDJlaWh4RHhF?=
 =?utf-8?B?N0N2VVlXemFMbkNmK1pBejc1c0h0anNPZUtRUGJGQ3I1eEpLcmMzdWpVZWp1?=
 =?utf-8?B?NEg2RDJsVDFVSHlqOUlWTVAxN0VtazJZSEd6SWw4ZDQ0SUNsbDhCbHBZSEZG?=
 =?utf-8?B?MENVWXVadU53Z0ltOVJYamhLRnc1MTVUZXNxVTZaaDg0VENvM0YyTkQ5ZVdi?=
 =?utf-8?B?RkdKeVBCVmtiY3Arc0ZNdWcxYmV6b0p3WW1vNXM5aWJsOC9Za0xMdzdEVFRS?=
 =?utf-8?B?YkY5eUh1R3ByUXdMOXloY3k5eFV0S3dQS0ZaazhNYjFPUjNuWmkwYnhlTUFD?=
 =?utf-8?B?T0M0TnJkM2FwZXBHdXMwT3JzOUhtTDZQR2Y2ZzdQREtCaUE4Z1pDVXhhMFhw?=
 =?utf-8?B?WUtQTWhmSmhRd3piUFFna1RURlR6Qlk2ZlNJbEl0R2pVWHNmaHd3dWlaeTQx?=
 =?utf-8?B?cjREamlDZkNhd1dyVTIvY0RBSEJ1NzhHTHA0UUlGWlN5MzV5ODlyTFNTcmYv?=
 =?utf-8?B?REdoSWhwakczMFl5TXhXY2VySUxTNHBObmMxd1dnYmtyQnV5akZocXdnL25y?=
 =?utf-8?B?VDBDaHVtejRYYjJ3RHgxbGxzdU1FYm14WWNFYWxDSk56Z0FvR0tSU3BVOWJJ?=
 =?utf-8?B?UFFSSzJEMlVXQ0RCd1VlVmxKSWJtekV4Um1nN0JXb0VVSlMvYmxQTFFHdTJh?=
 =?utf-8?B?SGJUWEZUV2RwcHZjWDI1elFDRmxvTzNCeEJCekc1dU1NOENiWmM1bHRtazJl?=
 =?utf-8?B?bzVBQXVBQVZ0dlJZYU5PWU42WTZaUW41aGt0bGRiR2R3OWovMGdQWjE0d01N?=
 =?utf-8?B?bkZqdkNTbWJWWFd3VjB1V2RpaWRCQ0xZdHZ4b3hlK0tXQ3pqMUIxVGNTd2lU?=
 =?utf-8?B?cDRCUGM1ODAvMVVJOGp5N0lDTHZSZ3BVRGhHeEs3ZzlJOXNhcVkxenJNbHp5?=
 =?utf-8?B?NzdXL2ZGNWs0cnhnQ1B4WGdtdGh2Q2Jjbk83NFA3N2x2Z0FNZDlYdmFLeC94?=
 =?utf-8?B?N0hqd3h1V0RHMWg0L2ZjZVBKaVNHbHRCTUR1Z2ljeFdYM0JVd3NrcllHaDNB?=
 =?utf-8?B?Z1ZVVmRBNzUwMVJ5TmE1dDduT1lrZDlZL0RVSUpsbFBWQllOVm1EenhNMTRX?=
 =?utf-8?B?UUl6RVhJMVF4LzI5bDJmV2VEbmJUblNhb2g0bFdkUkdWeC9wTmo2YnZDYkww?=
 =?utf-8?B?dGxqSW13Z1BaT2IvVmxqWFlPcWx0bUtZVWV1dXN5YmVIWHR6WDVnWWZ4Q2hX?=
 =?utf-8?B?OFZUaFI3T0gwRklLc0ZtLzUyZ3o5RXdNK0x1VWswNzlUMHhZSFpnY1JJSEFm?=
 =?utf-8?B?YWlLYlB4ZzVGR01zckFFdzQrYWpteEVJbUp3bjV3RGQyQjVoUUh1Z3J3ajlk?=
 =?utf-8?B?RzEzRWJMUEp5N2pqVW14L1YvRXhQM1NRZkZZeFRaSDNiR3RzNDRKb3Q2dUk5?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7sc0eNZY28jPGUl2bPkcibc4twASpp9XsV3k4FGiysGI2uFvpbU1mFo+wlm7pwwUhcaT7Dm9iHf0FahDi3s0t9tb1dnv66qlQa2AS5TSWMQp4X9P6wsMCUPBHVxv2O3F4D2iyuqCJCP5wd/1GL4ix9HHSM9CyuK3PxLhXiW2gqtyi4H7MzqTiJjloFNlfGtSacuypL4JWYV2bn45slTclm8R9dGV8qzDK0tr13MxSWgqWFYDQZ+eZun2K77goGwxnTq+d1vl7A8rAHO3IoEOiYk6WdJVnv4asVXhHBgxis3wQFrEWSS51tUs2Cqair3nLgxO0RWjFfXOcfE9/jHiJ8Bh981laEuUKniPNJf2LXbbfRzJ76WB/hJny9IDmH4n/ufjYr11mZnWx+eNn92Z0N/moDnpwA46AMpKXpf9TCk0IUi99q1whUe1N9ldJvaPhKAts1e+Gjcl6WBE1kIvKGXh5BQrOKF5aXVRQ7SCDIu3XFao1nXkAsi++uCV/n6TMRkPDLT20cFBBbaOF54ezyHQjHedXl6mF13hk9mueV8H5o0ArMEPHbmP0+ffJ4f50L2G3li1t7Y25Y5UzL4YXSBxwrgvmDVPMFVIKXvihWA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd0eb8e-9c73-4d64-68cb-08dce89e5617
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 20:09:52.8265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /n320AOsqkVpAXWsNvCUElun/nS4oHxnl7Pm+pSA8g0C7RV8hzNB8PNeBhpQoYKZatyh+JXEqEoyJwvBWvSHFRhVfmDn6LXE/Q/OKVb6FIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_18,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410090126
X-Proofpoint-GUID: qogWwq9OHjTvDVSMkahrjNlDSH_nuZ6B
X-Proofpoint-ORIG-GUID: qogWwq9OHjTvDVSMkahrjNlDSH_nuZ6B
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

On 10/9/2024 3:06 PM, Peter Xu wrote:
> On Wed, Oct 09, 2024 at 02:43:44PM -0400, Steven Sistare wrote:
>> On 10/8/2024 3:48 PM, Peter Xu wrote:
>>> On Tue, Oct 08, 2024 at 04:11:38PM -0300, Fabiano Rosas wrote:
>>>> As of half an hour ago =) We could put a feature branch up and work
>>>> together, if you have more concrete thoughts on how this would look like
>>>> let me know.
>>>
>>> [I'll hijack this thread with one more email, as this is not cpr-relevant]
>>>
>>> I think I listed all the things I can think of in the wiki, so please go
>>> ahead.
>>>
>>> One trivial suggestion is we can start from the very simple, which is the
>>> handshake itself, with a self-bootstrap protocol, probably feature-bit
>>> based or whatever you prefer.  Then we set bit 0 saying "this QEMU knows
>>> how to handshake".
>>>
>>> Comparing to the rest requirement, IMHO we can make the channel
>>> establishment the 1st feature, then it's already good for merging, having
>>> feature bit 1 saying "this qemu understands named channel establishment".
>>>
>>> Then we add new feature bits on top of the handshake feature, by adding
>>> more feature bits.  Both QEMUs should first handshake on the feature bits
>>> they support and enable only the subset that all support.
>>>
>>> Or instead of bit, feature strings, etc. would all work which you
>>> prefer. Just to say we don't need to impl all the ideas there, as some of
>>> them might take more time (e.g. device tree check), and that list is
>>> probably not complete anyway.
>>
>> While writing a qtest for cpr-transfer, I discovered a problem that could be
>> solved with an early migration handshake, prior to cpr_save_state / cpr_load_state.
>>
>> There is currently no way to set migration caps on dest qemu before starting
>> cpr-transfer, because dest qemu blocks in cpr_state_load before creating any
>> devices or monitors. It is unblocked after the user sends the migrate command
>> to source qemu, but then the migration starts and it is too late to set migration
>> capabilities or parameters on the dest.
>>
>> Are you OK with that restriction (for now, until a handshake is implemented)?
>> If not, I have a problem.
>>
>> I can hack the qtest to make it work with the restriction.
> 
> Hmm, the test case is one thing, but if it's a problem, then.. how in real
> life one could set migration capabilities on dest qemu for cpr-transfer?

You will allow it via the migration handshake!
But right now, one can enable capabilities by adding -global migration.xxx=yyy
on the target command line.

> Now a similar question, and also what I overlooked previously, is how
> cpr-transfer should support "-incoming defer".  We need that because that's
> what Libvirt uses.. with an upcoming migrate_incoming QMP command.

Defer works.  Start dest qemu, issue the migrate command to source qemu.
Dest qemu finishes cpr_load_state and enters the main loop, listening for
montitor commands.

- Steve

