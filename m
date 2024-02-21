Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DB5C5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 17:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcpz9-0000RE-ED; Wed, 21 Feb 2024 12:02:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rcpyy-00008v-7Y
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:02:10 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rcpyl-0003Hx-6i
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:02:07 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41LDiU7g017552; Wed, 21 Feb 2024 17:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=r1pXkcpv6P35cTaLdlf+bUoCEV7aupuSpqOlX+iwIUk=;
 b=FKIK+BevDGmRTM4SQ7JfA2tmmS9zxC+aNeOeHip9mEKt0WoRD4noiJB1ip/iRryj9Rea
 w1POXYXWk7XwRZTJxQL++VdylxLtdTvQ8ccmkOBuOp1CRrZsr7xGRgQTh61WGjvyGQD5
 ZhGSHGhq1a1jovn5HtqAnrLUAEpGbOKcUohvadmHRw7SzhjH7CGJg5P5nMFPXHaBKzUp
 Ufs2NnXL+b8UvBuljUM/FmoG/OmKcfyOcnZOxJxMgYDuOzY6VVIfKz726tBkf4PCGtFC
 Dt/ZmFCA5/6XjalEu6eibQgDvOHYFhqgjhwHnP5565hqx+h+M0BxEqjpmAnPZCWD0Xl+ EQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wd4knt3mc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Feb 2024 17:01:52 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41LGHWFZ021335; Wed, 21 Feb 2024 17:01:51 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak89mc79-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Feb 2024 17:01:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7W9CyLVYxrBGCmhU2IKIikn+RqDe0x5FrybT2NuXw3QBhGI1tso5Z8voF+/VCRs8pqY2ZNRVlcrfMvwecB3eVyPLzeJZFn3wB6XOX9W/SyHM7g8ZIvJHZbC6ccEdm13/r5Dtbivb06IfzKdcgjpj1LTRHjVjh56t1peBT66/qbsAdNC8QijJYKAZMRUI2zxzgLmJSeZYWyU+keRsj9yU4R9ObR5e52bwVllTpvOZ9Uh1kh7DjC+0BjvLATE6GzqR2Gp2InDnTEMDya2zF1eMc6ssOCe1VUTH6znonRE9W8y9ySVo9pyeZ4gYfpVYPYgu8ltm9x4/KcNv7AP4tm+Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1pXkcpv6P35cTaLdlf+bUoCEV7aupuSpqOlX+iwIUk=;
 b=ZCNVQg3RDxJktZKRDkwS4IJZd7rF1UaILy+3CUqjgMXV27Ckrtup4GWW03FepOES9+GlEbgUYObgdTSl2z/CqbUv8w8jlU4jeNoc8BifudFDKR9T/2BrWjYJArZ4m+cvWB34yFg84/cDqBU58W0Q/gf3xLjCKWIErRRm5uxLqe8aGQll6a8QEMTQ7e1G90YOLsZRiOSg/AtfnHM0LkJ6qeo5kNg2xsiwOr5g+Ctr5MwPJqsJmD4KY/fJMps6JMF2JZdZ3kOjZLAfOjt0B+98yo7p7I2Zj0k/oW2txdZ6UmmjvXyR/rFLxB5n9ybIcNZdiH44wKn4mZ+WO35vO0F2yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1pXkcpv6P35cTaLdlf+bUoCEV7aupuSpqOlX+iwIUk=;
 b=B2JJ7rZHxyEpuB8NUVbhCIsYoLvepuicVsEKUtqQGKnnAMQ4F5ohxr+EnheoAugo+TPVTFj6l6Y6b+I1txJUQ+IkkCgVXO8ApQlqUxGZb7S9FK0wB1gixHTpTi116gZPRDCBbRe0+yl81nfhhvlMJJkRJaw/itG3gu+odfcUeOA=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by LV8PR10MB7775.namprd10.prod.outlook.com (2603:10b6:408:1ed::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 17:01:48 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 17:01:48 +0000
Message-ID: <625375a5-3229-430d-a29f-1ab28510f204@oracle.com>
Date: Wed, 21 Feb 2024 12:01:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 4/5] util: strList unit tests
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <1705099758-211963-1-git-send-email-steven.sistare@oracle.com>
 <1705099758-211963-5-git-send-email-steven.sistare@oracle.com>
 <87edd63qfq.fsf@pond.sub.org>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87edd63qfq.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::30) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|LV8PR10MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 11a04eeb-34a8-400a-12d1-08dc32fecabd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: soLyu2gqvwKW78biktz07Vrl29T5r1DKX6U7hByGc7Ah5IbkLlJNfh051OzeTyq35SSqcbkXt999RBS6Mg6Pv46UAOcsX7LRm3YRy9bmINnWx/aPsA9uyhu1moLDqUf8/UnkB6sFx0JZnlMw5KMWLsky96xInDYmZzfocN2LjW82NMACfZPiBlzpgBJXtRmS32mt4oPBatMBX/KEvEr70C0YE2bi0xVVa7gf9HsWuxbuWQsDNx9hKqbpmvxQTg+qGX5IILWPemtrTZIzIrZiczuQBIvcpzDk6aZsYBBRp7gi9j9exPvxKQZC5HsNr1YTxkSiksmg4T4zBi653RPutReyrCerUXgA3KuQGztE+jRzp+eN9UX3xp97MF/mFKlt2sxzLGH2+8NujVNf1X2lEVJXHoiLHbfcOLb2yAvjofypgJ1qIuXPORnXeZYLA3Gbj7H2PS8/bOUzQ/1frQiw5V3WmlOv9nGAz4SO8lfqIqCxqah631Td8036Ln7w0JQBijL5Ompf2HB+7y9xZpJ6WJMk0UnlvWzc577dWZlPCO4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjE0aERLa3pvMG5wZit4VkgzbVRlc2hEMTRVZCtGV0xKb0ZtQytrNWowVWFw?=
 =?utf-8?B?TDJ1M21Xc1ZaTnVBaXFRdXFYeVExaFBiMEN2cjhwNkpwL013R3NhMCtic2pH?=
 =?utf-8?B?eHZSbU9XTlBod25UR25DTHJZdlJtL2JpcGZjdWIzdW5uN2JJZERlNTY0S1la?=
 =?utf-8?B?WVRNaHFXUHBBN04rZnNmN0Qzaldmc3hhU3VqUHd3eVplRXJmMUROS0t3aldK?=
 =?utf-8?B?Vk1ta1k2VnhEdkFGR2tvWVZYbEJXU09VZ2JQMHBNcnIvMGJNNHZXUEU5TGk3?=
 =?utf-8?B?ZjRaamxxUW1hbXBDQjl0QU8wMmI5VVBSWEtvWUVRSk85MVFrK0VqN21aaEs0?=
 =?utf-8?B?VE9nRVd1c0NOdkdoT2cwb2dobU5SRXZYQ1NoV1VUS3ZhZnNVNEU1U1hSa1oy?=
 =?utf-8?B?c2ZabjMySGNmNFZ2L3NKcTNORER6am1YZnNNSmIwWkN6bEJrQUJkSjU5VGZs?=
 =?utf-8?B?OG1NclVzSE1peEFhVWNZWEdOd3hZVC9TN2F0L0lnQkhIU3NwUmpuQjNLdFVL?=
 =?utf-8?B?clU4bWtWYTRBcDBhb2IyQjVKQStQN0RPZFdlZkQwWUg5L29VTnVvUUozWXVO?=
 =?utf-8?B?NTRFR2oyNjBIWEMyVU5oL3RWa2Y5L2plWnJpaWlEdmJYZ1ZBcUFFK1JyMGlv?=
 =?utf-8?B?NVBna3hJc2VMOGRkcU12VUtHWWFwN3o3ZWM4V2NTVElQbWo0WFo4bkJEdmhj?=
 =?utf-8?B?cDlMQ0RjYXNxeGtMcStKakJFazRRdWxkdEl0dlN2VXd0VEYwelVqOXBwajg4?=
 =?utf-8?B?Ums4cHg0QURIUHliU1FGWTVKcU54Mkl6UjVxZ2VQMk5MaHZVS0dZKzdnM2k0?=
 =?utf-8?B?MWxHUlYrdG5lQ0JvTlhEcUtyeWxDMUd0T1lLYkp5bXRvdm5zOHJtQ1R5YUNj?=
 =?utf-8?B?NmI3MnZkNU1xNjQ1N09rdHowMkNpQTA4dUwxNzZrRFFJV01KT3BTVXlDTnhw?=
 =?utf-8?B?Nk4vMDRlVHgyTnlTZzNlMHo1SGZMUGNic1p4RHhnVjFKVFpQbjQxS3VRTkh1?=
 =?utf-8?B?SEh5eEdKODBVczdCbXBkT1ErOXNYdUNNK0xtVGVjNHEybGNtanpaa2pTajhw?=
 =?utf-8?B?eS93YUxnd1JOd2x2Vml1V1N5dXV4RjJDVDVqd3BKQ29OblZiRE43VXlWZy81?=
 =?utf-8?B?aWpiaDBRamwxSVByYStjemxSa1M5RTg4b0ZLcC9nWk5OQmYycGxiOWtFYUNV?=
 =?utf-8?B?MjRLN3NhWjFUbEprMFJLTXNUaFJiV1ZkR1c1OHdLdVZEU2o5NHlXekllSU9k?=
 =?utf-8?B?a3VIazlHOWQ4ZjZITDRTUThGcVhrbVVJWWwwdmxYbDFpSDRTc3NpUTJaazh6?=
 =?utf-8?B?RGpLK25DVitqZGQ3d3Zob3FrSGxVbXduZmFEODFZTWZVN1VQcy9vaWNIREZ5?=
 =?utf-8?B?eEEvSStZSFNiZVplL0xzbmQyNU5LcG9lbnh0U3hSL0R5OEdTYnZ0S0JTOGxN?=
 =?utf-8?B?TTFTVDdJUDF1dzJEQXdJaVJzVEwwdERXZEJpaWwwS3BVV3orWWhaOHM5MXBF?=
 =?utf-8?B?NlRJTk95Ym0wSVp2VFFDb2ZvTVY3d0lGak5Yak5zNjBHTGcyZjN5a3lWdm9z?=
 =?utf-8?B?S3gzUHlPZUF6TUdYeDNYNzlGZ09EUCtJV2E1bWFtUTd6RlBsMllWanREaWt2?=
 =?utf-8?B?ZjdDbnBWbTk0QjBvWm1MOVcxRldMdWY2b2IwZjF0QjZ3MHRhOFRzQjlBTUR1?=
 =?utf-8?B?VFZpWmFLR1AzK2JjQk5xQndXV2lDSmV6MGNsQ2FtWHlzaGdVN3ZrQ1pPdnBS?=
 =?utf-8?B?RG9wVFlTelNtK05OdEpBZ2dZODVCc1NyL3RTb2x1N2srQ0xadU05UmdLVVhC?=
 =?utf-8?B?Y1VEMHNnMTVYLzFyR1JaZmU0S2t0TFpHdmhGVkZqRE01dG10Wk4yVTJtMVRa?=
 =?utf-8?B?cnJOL3JqLzlab05TcG1MQndCN2tmU05HbWZrRzRVN2xad21YR2dCMjlvUGw1?=
 =?utf-8?B?TXdaTTYvMWl5dEFwMU1PUzlLdW5SWWsvQkdGR1k5V0xOWjg4NTdTelVRZWJp?=
 =?utf-8?B?N1Q3cHBab1IwbkpBdmN3T0dZN1VsaENGR1VTcU9QL2xCSXNaNEVoQWx3TTNq?=
 =?utf-8?B?NDBRbHhhVTNtd2cxaEZQN3pyVlExSCs2eTM5UWxVcW5SaTB4YnNadzdwOWlv?=
 =?utf-8?B?dlNtZXBMeDdsajZtblh6TGRqemxBa2ZwMmJmMlkxQmhoUWRuTzN4QlBhOERy?=
 =?utf-8?B?SWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kkGfSkr5rr4XdcK5J+zOPVfblgWxd5UGD5g2dx9/gYZFDYK9t28hes/tFgSttgJ0LL3shkZicPOjJ+neZgunrXQcY0VWsEE4pH0BKdNJ2Bi2UhoiYglTzQq83cYrl+1JwiyEuzTbq25RvcXo5OKxVlHQnlaXmob+bMndSir/PW6iqEy4zPsSR60AjNbvmfUPciUNj3kDlToOBLCUJhnpb4rmI8QaXshkO2/hitOEPYE2koyQGjpxx4A7zgI3Oy4q8HfsIaxQ2LSdneZ4VeMpwDwMdvc6eH/JwR1xRuNyrTTVrVlKdPkihyJP8ntOwdjNR0dICuY8pcLBuGrxr93k15DMIMg8YDDl/D1gKEGtifid68p/kR8mQNV+OgLPheHzHzKnv7Pn5iyE/sdKO6Qy2vZYXy4MnW9YdAsku/7uHtSMwK/ysK9T2Cew2T/mic0qtRUDhO9uGPNvcUTbsDG0W8GOGbqmKbxy1C29oGJkekKsVGGlL5Ko8Jkw7TpUJYOBVGS4+hb6HhWmQSLw+Tlym4sR8ATAtFS8k7+iQH1X2MafhJQwmpd4KgvjuyFJTHuhpgSiIpRgBIHeXcLVwxWKxU3QhI0aLvETWLuLggGsRy8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a04eeb-34a8-400a-12d1-08dc32fecabd
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 17:01:48.5532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ZNObaXIPEXEmH74VZVPoZ8Zl8A3mwu4OS4LIAOcAKf/atzMlMWHLuZ/njcCqhQo2oEW1CR09fkCLR2U8jz+c3sfTw4BS7V7i3g8xOdIg0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7775
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_04,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402210132
X-Proofpoint-ORIG-GUID: h88gy-q3XqLQohwzpKrHkI6YbM515o8U
X-Proofpoint-GUID: h88gy-q3XqLQohwzpKrHkI6YbM515o8U
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/21/2024 8:19 AM, Markus Armbruster wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>>  tests/unit/meson.build    |  1 +
>>  tests/unit/test-strList.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 81 insertions(+)
>>  create mode 100644 tests/unit/test-strList.c
>>
>> diff --git a/tests/unit/meson.build b/tests/unit/meson.build
>> index 69f9c05..113d12e 100644
>> --- a/tests/unit/meson.build
>> +++ b/tests/unit/meson.build
>> @@ -35,6 +35,7 @@ tests = {
>>    'test-rcu-simpleq': [],
>>    'test-rcu-tailq': [],
>>    'test-rcu-slist': [],
>> +  'test-strList': [],
>>    'test-qdist': [],
>>    'test-qht': [],
>>    'test-qtree': [],
>> diff --git a/tests/unit/test-strList.c b/tests/unit/test-strList.c
>> new file mode 100644
>> index 0000000..49a1cfd
>> --- /dev/null
>> +++ b/tests/unit/test-strList.c
>> @@ -0,0 +1,80 @@
>> +/*
>> + * Copyright (c) 2022 - 2024 Oracle and/or its affiliates.
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/strList.h"
>> +
>> +static strList *make_list(int length)
>> +{
>> +    strList *head = 0, *list, **prev = &head;
>> +
>> +    while (length--) {
>> +        list = *prev = g_new0(strList, 1);
>> +        list->value = g_strdup("aaa");
>> +        prev = &list->next;
>> +    }
>> +    return head;
>> +}
>> +
>> +static void test_length(void)
>> +{
>> +    strList *list;
>> +    int i;
>> +
>> +    for (i = 0; i < 5; i++) {
>> +        list = make_list(i);
>> +        g_assert_cmpint(i, ==, QAPI_LIST_LENGTH(list));
>> +        qapi_free_strList(list);
>> +    }
>> +}
>> +
>> +struct {
>> +    const char *string;
>> +    const char *delim;
>> +    const char *args[5];
>> +} list_data[] = {
>> +    { 0, ",", { 0 } },
>> +    { "", ",", { 0 } },
>> +    { "a", ",", { "a", 0 } },
>> +    { "a,b", ",", { "a", "b", 0 } },
>> +    { "a,b,c", ",", { "a", "b", "c", 0 } },
>> +    { "first last", " ", { "first", "last", 0 } },
>> +    { "a:", ":", { "a", "", 0 } },
>> +    { "a::b", ":", { "a", "", "b", 0 } },
>> +    { ":", ":", { "", "", 0 } },
>> +    { ":a", ":", { "", "a", 0 } },
>> +    { "::a", ":", { "", "", "a", 0 } },
>> +};
> 
> NULL instead of 0, please.

ok.

>> +
>> +static void test_strv(void)
>> +{
>> +    int i, j;
>> +    const char **expect;
>> +    strList *list;
>> +    GStrv args;
> 
> I'd prefer char **argv;

ok.

>> +
>> +    for (i = 0; i < ARRAY_SIZE(list_data); i++) {
>> +        expect = list_data[i].args;
>> +        list = strList_from_string(list_data[i].string, list_data[i].delim);
>> +        args = strv_from_strList(list);
>> +        qapi_free_strList(list);
>> +        for (j = 0; expect[j] && args[j]; j++) {
> 
> Loop stops when either array element is null.  That's wrong, we need to
> exhaust both arrays: || instead of &&.

|| is not safe.  After one array is exhausted, [j] will be out of bounds for
the other.  The g_assert_null calls guarantee the arrays are the same length
and all elements have been compared.

- Steve

>> +            g_assert_cmpstr(expect[j], ==, args[j]);
>> +        }
>> +        g_assert_null(expect[j]);
>> +        g_assert_null(args[j]);
>> +        g_strfreev(args);
>> +    }
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +    g_test_init(&argc, &argv, NULL);
>> +    g_test_add_func("/test-string/length", test_length);
>> +    g_test_add_func("/test-string/strv", test_strv);
>> +    return g_test_run();
>> +}
> 

