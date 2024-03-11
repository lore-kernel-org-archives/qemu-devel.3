Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56778C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 20:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjmMY-00050N-Ej; Mon, 11 Mar 2024 16:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rjmMR-0004vp-Qm
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:35:06 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rjmMP-0006Mi-8W
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:35:03 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42BG46Va011913; Mon, 11 Mar 2024 20:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=5yCjNF/ZFKCS+ZqMMXtEt83e3Mb8v+Gv/XZltI00UtU=;
 b=BV/sixHfAkSJwuSKtjomLNC3FqjXCtCN8kHPfKJuWpzNrpwp2RRRrIZsAiS1wSIAfl/f
 2r2p5L2eYPa4Ze+w6eHV5BftLOkkd5vy/7MON1pFtQhrWmxyGMLUNCpSOQl/D44RovKF
 PnWyEaz+Ix5LeCRQEH7Q+aZTO+CE2vhHxWhWvL6S3PQnpifQV+JQh7BH48DCPXmS4cx4
 fioGCVyZ3rb1guv9qxrWivIL5oMl3gRwsY1VJSGgvM2fFEW1TLILd9ZBAm/nkQ2UKSL+
 xXF+zxIl26byfgmzd1OoK+3Lx0ChCGGsfsoYOWYgJN5FblGGoKU79ng3eiWtRTEHoAa7 +g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wre6ecc23-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Mar 2024 20:34:52 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 42BJ77aK004864; Mon, 11 Mar 2024 20:34:52 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wre76dkmk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Mar 2024 20:34:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sxh/QUuIEWXIb0Lw0LwCKszgr5iN6QXUMkZHdvBajc1ov8hzlTCM7BWX5Kx5kvyZipDwOkKFrFbD71Z85ok9BM9FxCCyPF9EgEUi85AnKocmxLFFs+3owyk3X6d3thN6T8nYEIWusW7liPkP7tgfhdGkXDtIIRAFZpsuBdvVdqJZ9YvK8O2Dy9p1Jf6RTVkAvfY295Y6hY8pciCUu4oW3t3pO+OUf5Uruy/tKc0JJT8xc0rqPRPMgAbCiC8ESCZjSCjrd42XLWgFndcSsEJoss4X2hVc5aEsqkA8ciBzdh/9A7TVvmWb+p9kjUZM83Q4xDls0TX2v9f1/XKm8ZZjvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yCjNF/ZFKCS+ZqMMXtEt83e3Mb8v+Gv/XZltI00UtU=;
 b=edaQElKBUaozVwAsBZ5X7rtEvs7Bi8gupw2wyiqSODrbuTZC/dNMoFPNySji+IZ1TpjaDTkd2iLdI8E5BrGAGZjzKkOFvn7jlUDD049nzDs8WSGlBGNwSkx3DMp8fFZ3h4W+28/RaK/T8wd6/IIHVme+w2GhHaurOxG7J7YdzQQ7b1K9P0weNzlCyyXvD4qEJZloTNBHFdIGPBgmYuUO35TwAoMqbZbhPa+O2loUjU6TqHDoaEYIzF0nuE+Mp3kzglCR4fqyjU6XAvlYimgcKfrl1ezzqqTkExJt/jO7IF5yD9C57Tsw570FcXmSpSFwUdgv51qCpDPuaMBssRwqqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yCjNF/ZFKCS+ZqMMXtEt83e3Mb8v+Gv/XZltI00UtU=;
 b=czcNRf4Gj3AksZwg7QUVwHyQOPtYS1c877NdMtIZ1XXoeieSce2JhcwaC1Y5fis3ZbC2TeF14RunOXSp2JeUrBVLRdqDcUpY/Rq+7EF2+RlyNQzGUHDm1b6GQPCMkXM+765rZ9yRjtLc6zUwxl2exWHROqtc3NVOGyKKqIzX34c=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by PH0PR10MB6981.namprd10.prod.outlook.com (2603:10b6:510:282::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 20:34:49 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::6130:f924:897d:7da]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::6130:f924:897d:7da%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 20:34:47 +0000
Message-ID: <46f51198-3270-4818-b861-f73a584cf9b6@oracle.com>
Date: Mon, 11 Mar 2024 16:34:41 -0400
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
 <Ze9b7JULHLUoYGgV@x1n> <93cbe4f1-6451-4dc3-8150-f62a99f83f4a@oracle.com>
 <fb3d25ca-4a46-4a59-b172-cade9dbcbe55@oracle.com> <Ze9pcgtMPVFM2CX8@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Ze9pcgtMPVFM2CX8@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::7) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|PH0PR10MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b495f0e-7c51-4be4-1bd2-08dc420ab181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jt803phqZoBdsv7/kX2rSWRjTPPSCEOENJeGiVdq1Jm5nDUbS3uCfm6NIrWmZZxM8vI5FYViUxCE28tmpdlublKWlk/4v4SwTI+P1wd1M90xTMWvWhe4lR9eCJlhV3K5lIXfUvOYREf1tkzoudVFomro8E1mauJ92uZ7tZS+ZJciw7K+gXsFL0Kkc3jY5PhG5UjuE5XBZzVQrN2Npj3rWcD3+RWGTt5q5yYRBZ4zYAUd3sNQEN+lSM0gNuiQrmNGzaDr8MkiCeizY60KMnrNYOhOoQCPjQMh+v+1tyQEIaeummkDfRaAcjmI5wiaWqfSFaLaVqWu9VBVPv37YhAX5Po+JqZkTMZPctNUhiUQN2PS8jG6MONMV8ikNR06R/CoVnHsK2L5RAT2SgGOO1SiEgjmsERbtqsXRbQAQsb1PeAvbBJCmO1O9RUyCzJJ8Es3vg8oWxmBCXHNLar/Y+ba0uTtblQg/Dp38e64PYEZV1jgpJ/PvgC6TJXIXautJFjNwQAhZsDFlcFxZSVxGcKmUYqiqmXhKkAD+uNXWJ17WiYey3ZfBuSifDQPacdd8j+H9Av2f/Vj/GfWdbST2B36eVzi8rk03D7UBP319PISYZ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXpZbnpjWGlhNDB3VHdiTENlWVZPM1kwNVBGSlVuK1l4cHdZOVFkODB4Z0xJ?=
 =?utf-8?B?b3lLM2JxcW93SVN2SGExZitqLzB1Ty9RNHI0b3VqdFhHRzF5VkZvTDNNcWdn?=
 =?utf-8?B?Um4yL3JCRGNqZ0gzazlJMGxueCthSzhzaWp5eDRwWVZYQXYvb0R3eU9lamtx?=
 =?utf-8?B?V2lMTmpxYTI1Y3JmT0YzWUg3MFNONkJSbk40NjZOOTd6MGZZU3BnOFdiTDdY?=
 =?utf-8?B?enNHK2hOaEs4Q1N1aklHTnA1L0NjUE03Y1RLcFV2MUR1a0lPUjM3ZU1GTkpR?=
 =?utf-8?B?TTJta2lnSFp3VmhKd3hEbXlLYmVFemZSbm1SdThBWGxLMzd3Qzc5NTB1RTVh?=
 =?utf-8?B?N3F0VEJGUkVUUnZBOHN4SmpYNTlXUlhBK3F2b29lUlpKVGRZaG9GMUhmNUUz?=
 =?utf-8?B?QUJ6cXN5WStSZ2QwdjhBSGJKSG42MHZhd09LQksyMllFTElrNU1MTm1oYnZH?=
 =?utf-8?B?anN6Y0JLNlQzTUlyZTdDcmJHZlFBc2VqOTFEOUlveVVxRHdoQVMzQ012aVFz?=
 =?utf-8?B?dGNua1Q0TjJWSTYvRU03emx0NGFNRS9QNVdlU3duUjFDa0xVallPSms3VDI4?=
 =?utf-8?B?WEN2QlZFTUc2YkxDTUorTFozSFJOQnlaTHBDTGFTMWdUQmNXVzhaZ1lIMDVS?=
 =?utf-8?B?a1ZSdGNoTmRQQTVVSWUzK211ampkTjRGbTkzZFpnaXJweGdsWFFSVE9RdExD?=
 =?utf-8?B?ODVkdi9XRGZpZCtjaGJhRGlCVU1wejIrM3F6eGN0T2QyY3hwdGZJc2JQNnhj?=
 =?utf-8?B?RGFOUGtHWUlsVlRIdWs2QWc2SzZxbjhFRWE1SnpYd3dTRFZEVDhXM3lUTnlQ?=
 =?utf-8?B?bUltQ3o2OWVYSTkwNnBSalRrYTQwbTBQamQ0L00rL1dRUFhNcHJSVXczS1o5?=
 =?utf-8?B?NGJIUDQ5TlAzejNORHI1TkFMcXN4aWNHeVpUZkkzcVg5N2tTdkRZQzlRSVBq?=
 =?utf-8?B?TktITTkvbUo3VUNESmlLWVc3OFRWZllKNjJPeGhRNTBwZG5NWTlOVTRkREtp?=
 =?utf-8?B?TTB5RjZ4QTU2UXduZXNaMUE3bjNXY0VjZGJ2U25wUUtJc1pyN0s2dDNzeEEw?=
 =?utf-8?B?MHVucEVwWHJzTzc1Z29jVWR6QzFXem1YOFMrM3pndU5hWXFXZWNRWTlnYVFJ?=
 =?utf-8?B?OWZhU1NMNWxMbXFaQkVsUC9DdVRVUjN0WGlrNFg1NS9YZ3dIQ1VKc0EzNzZa?=
 =?utf-8?B?ZGk0dU5hRWZPMURqVTBDSWYxS3IvZzFlUVRxTzFObFlFYmZTRlYyVExWR3Zw?=
 =?utf-8?B?STg0T2NRTVlQU0VNR29CTmluMFdmcW5UUCthVWF0NHVaL09udlYxNXA4Um0x?=
 =?utf-8?B?bHRqY2pQVDBsTVVUaXl1MTd0L0NnbUZURXkyckQ0N3hRSFhucUJKSXpwcVZH?=
 =?utf-8?B?QnVWelgxWDJMNlE4Uk94NlNGaVZCTUVnQ0Z3K1lpVkpQS1R3M3QvbHdXdk9n?=
 =?utf-8?B?NHJVdjRVeUlxUjBRUk9xMFNDYmtWUGtKL2ZkNDFXYWdMMWpEKzVOQmZPemh1?=
 =?utf-8?B?VHZ5aS9ISXJZYVNHR2VVMXJENWlsMHFyZ1VoNndwQlloelNRU0l3SXR5QVF4?=
 =?utf-8?B?cW1pNHdYZEd2ZlN5UHY3Z1A3My9VSXE5TlpqbXhpc1RVYzNTQ2VrWmErSkJP?=
 =?utf-8?B?ZG5pL2lUOThLNmh5OEJmZzh5ZW15NHZYalViVWZFZHp4SHpOYW1tVlMyOTZQ?=
 =?utf-8?B?ZUxZQ2Fnb2xtN2xLUmRxUWE3N2QxMmN3NThORTJXZGltOGlJZ1JTUTlKN2ZE?=
 =?utf-8?B?K1FXeWJhTUxCcitINWdVclpRQnVhOFFscDhJbHJyVExtQWRYMzRReFdQSkJ1?=
 =?utf-8?B?aC9UTEV2T0lzWDJOVHZoMjVSV0dlTllZMFZJT0lwZjNoTHh5ZlRJK1JNYThE?=
 =?utf-8?B?c2xER1JnRzVhR2JNZVMyRWUvUU5HL3NnVDYwd25HcWdlOXFoNDcvZnhyUDU3?=
 =?utf-8?B?UmFDY0plTXp0aDg2VWVQZTBuYnA0aDVtV1ZYK08wZHBaZHg5dkdoQ3JPd1F4?=
 =?utf-8?B?ZDhNYW5kdFJhNVlGcGM2RFFTWFBZamYzMUJXdWZCdXJwdGxWbVJhZnpqRUdS?=
 =?utf-8?B?aDljRDdwM2Q4UEVYNk01dGZuejYva2Z0T1hRaUxjK3l2RVBKWEpOeCtVV1pT?=
 =?utf-8?B?bE83WEs0RjZCRXV0OTNkVlBLMXo3TXd4S0hRblFRRlUybHlaTjAxTjhrN1R2?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LBk1qDrgCrdyYMXMvvuJ4roCtn+ZlDV4772v5sBrkNws2ZMIRM/WZhvn1DLnkhuW42aMN3js+3vL7KbuUhkgWAtwU5Ba+6HVW1UQEhWpr1jhXF3pjT9V8KAmJ29TQFWT1LSeae9/QM2IESF0UDifUYqw5xuYK3BxWrQlROOa3/GVi2NYDwB1Nee9j4IYHCw91q5+8sGK2o31kPeQryGTvo+KthJIMNu3s9dH1IR7aPG8r7JwV3LB65yVTgik8CxhPyMIz3WOyrNIe78P7r2OotHhK0DYdUpCMnK9BeKtxzJyiLIgl3L4c9nhzbyvYV0H/FgNUppPJTXK7WuBCJR3sIoAfc3x8UEIWUGHzwpAXjE3e9wlrYGutxU7pWVvRP6CLi8yzx9G1UrODLLPpn2v9nI943HJSADDtyIAIJEa1z/pVgk9E9eWtb1ZTExyqos35PrEzWIUa7ENFJxzuQ2nV8DIuE1sStdPQJuaKMVYNUpcFP+mKci7ZWhE/41+OF1BfGPAPT0RXYiS4x85t++xjJ3iJlK172k8EBs5JsRtSE0q4MQ9kQXmIMgexSCIB2s1KZi+wrxVz4ZMvcoYzUJqWQnlW11FaopaCyAMC1iUxKQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b495f0e-7c51-4be4-1bd2-08dc420ab181
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 20:34:47.6113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Oogbun+QTlRU51dbHHLFjJLqRl07oSa1itSEQSEHM+X+s8ANt/xigM2oSVxEh5ZHwti5qMOlsz7jFexOmRWaG5gC4CHH+OtEYZQ0xF8xz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6981
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403110158
X-Proofpoint-GUID: cvajPBndRE3dY38sqCqtQ_T-LfKEtZbN
X-Proofpoint-ORIG-GUID: cvajPBndRE3dY38sqCqtQ_T-LfKEtZbN
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 3/11/2024 4:28 PM, Peter Xu wrote:
> On Mon, Mar 11, 2024 at 04:24:14PM -0400, Steven Sistare wrote:
>> On 3/11/2024 3:45 PM, Steven Sistare wrote:
>>> On 3/11/2024 3:30 PM, Peter Xu wrote:
>>>> Steve,
>>>>
>>>> On Mon, Mar 11, 2024 at 10:48:47AM -0700, Steve Sistare wrote:
>>>>> Changes in V2:
>>>>>     * rebase to migration-next, add RB
>>>>
>>>> Not apply even to master branch.  Note that there're >=1 PULLs sent and
>>>> merged since my last reply..  Perhaps you rebased to the "old" next?
>>>
>>> I pulled from branch migration-next in https://gitlab.com/peterx/qemu a
>>> few hours ago, but I must have screwed up somewhere.  I'll figure it out
>>> and post a V4.
>>
>> My pull was a fiew hours old, but my patches still apply cleanly to the
>> most recent tip:
>>    a1bb5dd169f4 ("migration: Fix format in error message")
>>
>> I can sent that as V3, but ...
>> Note that you must apply "migration: export fewer options" before
>> "privatize migration.h".  If that does not help, I will send V3.
> 
> Ouch, I forgot that dependency... Sorry.
> 
> Yeah it works now.  No need to resend for now.

Great! - steve

