Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D65C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 19:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjlb6-0002TQ-NS; Mon, 11 Mar 2024 15:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rjlae-0002PU-Ti
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:45:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rjlac-0006W7-2L
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:45:40 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42BITo98021769; Mon, 11 Mar 2024 19:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=7K2VC1lm7blHQyqglYBbzhUYj5AFL7G1l592w4Sj6RA=;
 b=HPdHAiD/QU+z7JMG2toBEQmZ91v3V+O/QVAWqxQ3A72z/lWuu+iIqZxjB0dC3xEMIbh4
 EJM1nal4V71ctMjC7J80cdFFwcBFwgdPXWMVWaq/9zNa5nxch47dDsAF1spL32DwqW//
 kEN0a9ZinsYox31vNHVpuoOKO+vpw7GDytFYmO/K2AytGuujJSJ/qmu448Oyvz4oRgho
 gJFWNjdIAbNJNTeNFdAvvk9ZTZTb6Kk1OIAQtWg9wUgVLs02r/4XoIup0YkQjmK9isqt
 SSmu9z+Lyah0oMVOP2G5ccyachbMxGbvQqxPFTRtdKEVN15ZtkDia9lI/2Gugu8rUWCx mg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrepcv59p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Mar 2024 19:45:29 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42BJ88TO004791; Mon, 11 Mar 2024 19:45:28 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wre76bqdf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Mar 2024 19:45:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dfz/g0P/aznnaBuHUYUniLtTNrjtHReUjudDJhqyNgYKY5mlXMSOb+/Y/g0IukTXFgF1guQSZyj2LcjMPurC8h01qUrHcE1GfwrDpEkOASY26UQZo+OrWroeR1DwLsCbvnOISNGK6RZcmYLz6ULgEt6C3h0x8Wxx5kwUpbWXH9x9Rsdc1jTvMfzMuTOOmAAbTa5/IQ1xfULoO+isLqvF/YVN8owk+QkE8ZX6i+Y5fKBMXAGFvvykEKQ9piGLmUwAckSMWxVQovFEA3h1MqWDJasurmLnD72QsPrKKvaS/9Iuw1dlEbmM95aWL0s58UqvEJuOAdk0Ceef5Mjrt/CCGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7K2VC1lm7blHQyqglYBbzhUYj5AFL7G1l592w4Sj6RA=;
 b=TbyphqQqpriAXQ4vzspTSfXpXZavWI9TQ/Uo/HiZmnTU1EBWGtBudrMVYw+7VHO5n23LaXyI4FBvVCRT0IehxGYO/x5dm3VtJYhefjOseKbikAaqm8tkYE7n0/mNgG+APSVtRFRcPzMM9hDq7Q8MxRmcemC8989hqmoOtk+IHN/yhNXDD/uyTujAoL8KsVqNHtfUkMSi90vIchiO2zaU5OjsrMCFOvfM4j9vacKGoYznBI5vh+zxBic2ZV4hXvzDMQWxIcX/AzfHR/sCcojrno5/NizUIJDDsjF5/a7nOTwbB7Z9U371wqJeRRG9xE2Zv1vIVdyIlAxric2BpjfmxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7K2VC1lm7blHQyqglYBbzhUYj5AFL7G1l592w4Sj6RA=;
 b=WeVhTYFB9r5Rws2xKjMlwjB7pKme+vk612IbrroabbcqFB9P0SRHNx8zJ5RxDmEKgUeSYsi9AtaAdUccZqkoylxdtINEwhpfPSK4vPVifT4vJNQOLxjt7bFQBGq5vp9MbC7hQbsqrX2yi2K4zvyeE9f7sL5z4USBlhTKTz0wwmE=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by CY8PR10MB7314.namprd10.prod.outlook.com (2603:10b6:930:7b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 19:45:24 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::6130:f924:897d:7da]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::6130:f924:897d:7da%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 19:45:24 +0000
Message-ID: <93cbe4f1-6451-4dc3-8150-f62a99f83f4a@oracle.com>
Date: Mon, 11 Mar 2024 15:45:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 00/11] privatize migration.h
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Zhang Chen
 <chen.zhang@intel.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Jason Wang <jasowang@redhat.com>, Hyman Huang <yong.huang@smartx.com>,
 Song Gao <gaosong@loongson.cn>, Alistair Francis <alistair.francis@wdc.com>
References: <1710179338-294359-1-git-send-email-steven.sistare@oracle.com>
 <Ze9b7JULHLUoYGgV@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Ze9b7JULHLUoYGgV@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0022.namprd21.prod.outlook.com
 (2603:10b6:a03:114::32) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|CY8PR10MB7314:EE_
X-MS-Office365-Filtering-Correlation-Id: 820e8985-181a-4948-2a22-08dc4203cb74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /uE2vl1NtMO+TeiuMV3OGJn0vXOXkZrC4HAq+p3EkkX5XMc1iTkj84N5krm1MTP/yGDaRwPPZJltaM/LS2Lo/VJ9RTS5gXRohImK+ddy0iNZHHOsDHlPJe7l3Y/n2IMSI9gP6PU8hh43KkrusXr34kSt0eX/1Xxin5sbn6cl64zSExNCYQzKLG4GGZOaebBrsDqcwzXHGl927C66rW8BFr4YQP2JicedZFjiIGLJ/VE5veElvpDHvKjV5ItLsHgoTcZLhLScZ7SSnBRFDGDM1PnaIxPIVcMe0pAVWO+LxvXujH5bnGrAE0OyD0hmAda0ZoCM5Jg7xYMahLTDndI/zJObC9Lmj10+8F+KpuoKyzSc+kiYS4XxPfTedKqxbL5CQtmmmHIjO7jnVdpXPzu1vlxsIJstklb5Q09LcMHuimPIO7MyLLqEA+UYlp2p/S6ke4J01ycfZfyjcV+FANIx+LUqEjINbPBdq+WlA+QFh9KWUcwT2I0sWA7CXu925FdlryOSYHAH5Q3zsCjb5PJO6Tfr8Xulzljh6GKyZ3dZBKsRZcOmRlIxKQubtuzTOPm06JP3tLR9QjtjyVS248UU4JxwO9A0P13OxeIbZcR5lPA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlljSm5Fa3A4WDlHYUhHTmFBYUVsKzYvdzZmL2FjUlFnTnZtcFFQenBoazUy?=
 =?utf-8?B?WlBkRHB4ekVpY3lVS1JRVWJjYld3VnkyRUdPWWY5MUpHQ25IaS9oK2lCV25t?=
 =?utf-8?B?L3dHNHNndUUxYzFRS2RINytEdzRWWHJKZURSa0NNL0U3clVjNDgvSC92YUF5?=
 =?utf-8?B?WnhzYkNKaGVlalc5NHQyK29mempXUk9wbkYzOXlFNm9oRkxzQ1N6alNVdG53?=
 =?utf-8?B?L3FyU2JJWEN3SVNBTHNkRGR0TVM1TzVTRTF3T1J1bXJaWVd1Y1lwS3JQblYx?=
 =?utf-8?B?cG9LVWpsZE12S2dHWU9Pc3pzcS9mWDZ0TWdWYk56Q3lXWTVuQmpWeVpaeVBT?=
 =?utf-8?B?MDFaVFFIaTl6RTIzdm1ZSTJCYmxYWWlOUWwrVzl6QWphcW5FTlRGaXNhWm12?=
 =?utf-8?B?ZkdkKzY3MlpmTjRNeXM3VXdRZy9oWjhpSTM4ZUdmcmZBaHRrclMzMENhcU9t?=
 =?utf-8?B?c203TmNyS1hZYk1vZEk3R2tMTGRBYWpDcEJmSUZzUnlhTUJZTlJhc21lakJH?=
 =?utf-8?B?Q29kL3o5ekc2S0pYRGwvZUxKZjROYTVBWVNCSmtwMTVmaWhRaWlxRGNaVGFS?=
 =?utf-8?B?Qi9aMWRTUXFlOWlxZ2QwY0hnWXpwUWlzU0VRNUt1L1BNV3BSSnRWYzFobStU?=
 =?utf-8?B?UUdIdDJJQzVzQXdXMnBOc0ZFTzU0VGF6bE5va1ZnSFBaMWVSWmVqSDkrTXZV?=
 =?utf-8?B?dFJhRmlpbGNGeU1JWDIrS0RvekpNcGdVQjhldFIxeDhOb3BPRHdDNGxJUTRP?=
 =?utf-8?B?WFY5MDBBaW1uNGs5MFg5V2xuajBaNFBQblRxR1M0dlYyZGJGTHJVdU11MVRi?=
 =?utf-8?B?WHlVMFRzYzdLKzlSSmZIWFV5dkJ1ZTZIc3dGNjUrUTRFbm9BZVBmTStZSU9M?=
 =?utf-8?B?Z2FzcVdBTm9XVEUxd2dBdzd0empOV2R5Qkw2MUc4SkdFR2lSZTZxV1RSZjhX?=
 =?utf-8?B?NlpyZ1JuVHpNaWJlcGZWS2lSeVVKTTZ1Yktad3VTc01FY0JyaG9EVFRWcVZH?=
 =?utf-8?B?TExZWUR2RFhZMFlvaGZZemlUbFBSSjBFOUJMZE85N25wRmt2cXJkY3U2M1VR?=
 =?utf-8?B?Y0JQRGhOd2JibktFNUh1OXJCQWZ3NUhDZ0J4ekFIQnJZSjRhZUFUWEFDWm1J?=
 =?utf-8?B?SjRYN1JEdk5mQ1l6MGlIVFZweUlxeEZVMWR1S1EySDBWeXlWT2hYUkRmVlhR?=
 =?utf-8?B?a1kzclkwblRxYjE3TjhjRFA0WHVPTGlvcjk4U3VpT2RrQStBUHF1YWFFZjIy?=
 =?utf-8?B?NXNZVzNEcEtJcko2NEVaOGQ2bjFiNERjNVNlbFI1S2FZd2gySlorbGh3d242?=
 =?utf-8?B?YWs5SzEwbWhFSldqckcvUHR1SU56RXNZMldXRWR5UE9VRXltUnM4aTkxYmtS?=
 =?utf-8?B?a0lyTEVVcHlBVmQva2VzTkZRTlNXaGVna3ZqRXVILzZxQ29LVkFIbUdFa1Ur?=
 =?utf-8?B?YTQxVjc1aC8xK1ExZjN4WVQ1QXMzajhnb1J5WW8rMkxWekdDVEFsU0RYQytC?=
 =?utf-8?B?UUlRbDdJTDJXLzNoSW1ZYWFGejEremtTUzE4KzVTaG03Z1lXZGlUcjJrSHVW?=
 =?utf-8?B?eWpERE1ZZW1iSHV3WGMrZUw0MkUwb2JGWEd5Z3p2YjE1T2tsNkg2OUZ5RklI?=
 =?utf-8?B?VnNqMTZreGM4TFg0WldIQm1HWkRFZTNZODZmdHMrZE5SemJjc3pLWlovV0tk?=
 =?utf-8?B?U3pTTmVCcnM3clppV0cyN2UzdHVTbE1scVUxUFBpNUZiVXU5ZVhVeGpYcHFK?=
 =?utf-8?B?N2RiR0lYMEdpTEU3VElybWVXM0JhclMvZkdTSTAzVmxkTEttV1lxczZKcStH?=
 =?utf-8?B?Sm5FUk1QUWxTdm5nZGJqZ1VSdFNkUVkvVkM2N3VwaGsyRTFCZCt0RlhWaGZm?=
 =?utf-8?B?UHZQMGRWd3RRUjZ3OXZnRTNUK2V6UVdLWTlxZjZ2SVNTcXp3eUllUEpaVVVE?=
 =?utf-8?B?MEprSkxsdEVYRzdwaWJBZmFTK1c4MGNRV05YYkdNT2tPTlN0YUNQbjhTekk2?=
 =?utf-8?B?dmVZT3ROWGJqTG56M290eWVycG1sb1VadkFtMjQrOUhYOU9lcWtVaTdaR3R1?=
 =?utf-8?B?Y20xait6Z1RqbmRDMU5xeVJTcTRQdVNuWFZiL3FsNk5LS3orV0E3OFhic2U3?=
 =?utf-8?B?ckd1S0ljeXlOSWcraVdpMnZXYXZ0Y21va0RXSnRVZjJRengwMTdhdE9DZjRN?=
 =?utf-8?B?Vnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ai0ZMJApSkfGboxHa1pCcLBceebLCZRIvd6Zx0Lq7tk6uWkIiazglyuNCfmrulexUiIvBjyZ0hkxwAA/gt9Qug3YWENzvPH3x4z3I99qvqXC4WdaBUg+RpNg+dIphkh+cXKvEHrUAboh+FmjW6ptkZESIdIF9DfdtqbNHJtKO/7rrfC65gGD2vwX7S+7d1QF1mx7jugSnwOXeZMoqkM2bS2EcsV+NNp0aFDW95cPGdY9egnpNWf699ZK2u3jYqJk8wb1+jw2xRMrp5yl43qnD8H76Hv852JGr2jCW9ORtoADy+4Mybuo2RSwb6+BtfhVzEMs55cI6BKQ/g/uMq8K2ZcLKGKbKDi2wrCrzksztluLyiDaMSuzZulYNBVnTdKm6Q2bXy7ozZxZhkkb8o+4ewI83nuh2Vh0MzuDEXilaBJkElvfiMVqa52qEn0wfzERQvOWq3xxU5Nmd042wAZxYDiAEjwF77vNJnBZFD3IgX5N2WYkCh4fOwqlSmZ8tYGNyNur7nFer+7T+TH0LuQyb9FLaMFsHHqMzMgWcnJ+RUEawIBwn3Ukqk1HXc7bCO7ovHX/8GILs27yKSwbZuViiu/g9CG4g2uOI9GCw4zqAOY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 820e8985-181a-4948-2a22-08dc4203cb74
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 19:45:24.6761 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5tOD5W9CEaqB9dkWYZwEEkiDeQgntegJA41JEhSiGbJ0MDUu6jhBY6avhPiXU+0pUtULCOTaqZlS4NPkgdZTBqEn6OqI33GMcLwDVlbNloM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7314
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=974
 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403110151
X-Proofpoint-ORIG-GUID: BkhLGYMqWxAk06oA99Wbh_-ZZGNdoUSt
X-Proofpoint-GUID: BkhLGYMqWxAk06oA99Wbh_-ZZGNdoUSt
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/11/2024 3:30 PM, Peter Xu wrote:
> Steve,
> 
> On Mon, Mar 11, 2024 at 10:48:47AM -0700, Steve Sistare wrote:
>> Changes in V2:
>>    * rebase to migration-next, add RB
> 
> Not apply even to master branch.  Note that there're >=1 PULLs sent and
> merged since my last reply..  Perhaps you rebased to the "old" next?

I pulled from branch migration-next in https://gitlab.com/peterx/qemu a 
few hours ago, but I must have screwed up somewhere.  I'll figure it out
and post a V4.

- Steve

