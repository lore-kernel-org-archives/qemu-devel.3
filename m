Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66087C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 16:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ree7g-0003lr-Ka; Mon, 26 Feb 2024 11:46:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ree7H-0003iY-Oq
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:46:12 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ree7D-0005aK-9v
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:46:11 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41QGdvKa025133; Mon, 26 Feb 2024 16:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=D7rHqehx6yu0VwNdcXvwgIA6mWJAXhIXD61MdlhjoQw=;
 b=SnjSFWqnsOvPqIwHkbjAXbFHsKzykN8e7H8R0bDK4lP9EKk/pkzekej9e219MUZCQ4Lt
 HP88waCmCV9H+uw2Fmr13EaHx4hAHd6H8Q9avYg2HceHI0UWv+VNnasD3V1XUf5VGckK
 Hr9IHdPnyXI4QCmL6agU7tGEIvd52VkwSJobzPNaB95JNIYcY9kWzENlyASundUUFyxb
 clvQeRb65B57UWuuU1olG/Gc/+uHQakUP2asoogRnYB7chh5VQ6OaZzp04MNzl+16dgV
 UfJuwh4rdyLsv+1IBac696xf5S49fc3hDV3Kxw8cAQtpTIGTR/JV6iOHfrjBmgYXkWWB yw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8gdd66q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Feb 2024 16:46:05 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41QFn40n025532; Mon, 26 Feb 2024 16:46:04 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wf6wcasw7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Feb 2024 16:46:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFSsvttlX6A501xzonUVsjPZgbZl17moq9EZXPAqZfJ3sMpdEnW2tWxRRWzb0Yp7Fh1JjkKSvbMD+YiIeokSqS1vcngbKXGBZfvg6KIlmIEuycp8cSXzpYW0PG/p8oYMOeq3erMKNAw4gUmwONC2DaJQasD2vI8uAkqlhpQ3t+bDmV6QrtmXtzTTRW1xBl1UiHRrdhbLJl+0f/7xvS/1SPBSVdSZwMcfJxosEhkKAWfv1bhZY3sTFSwXXBidrxN5tXFtebtWd0b1mGUPTGC/5K558Tekapq5S5+Mtya3KXc85HYZrG/HCBB7/XvXYlprUEUQ8+kL1hlaNpz3KxmHrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7rHqehx6yu0VwNdcXvwgIA6mWJAXhIXD61MdlhjoQw=;
 b=cy1t2ZIJ9YlEsEo/oB+WYVaTGk2D7TcF4sabu0USa2G/mgIV+ni6Fl5qLJWR70iTwRr46lXq85rIBAMeGQRaWmrIqaqxD8uj+AF++CrwaqtYrW+uhsdZFAN8OVTW/uMQ9WbGSxpwt5Pbj9Ru3sXLPhuqML73poF5E/Yy70/xOaa8ZBazAPQOhtzOxEvt0e8X7nlO9k48rBFcQvp/P5tSwkjdhVCF73YIH0z4nvGTggDbD3+JbVGx2fh7/D8Q6JOSznpoM5fUMXwGqz1y3SUfjUs/aw6pik4LlMJozSyfDoMXWIMCw7oW6LF6e4pIjgnHwPQoq9ff0ULYbVg1PZ815A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7rHqehx6yu0VwNdcXvwgIA6mWJAXhIXD61MdlhjoQw=;
 b=nTZmdIwl5rmc3OxM0FEPb7vadqbcAsZ8/KM2rSXX12JYrV2qTQf/GSBT/LgQa4yQDkhK5W9mHX6dSPJoacjSAJPfKvHBSsuBlkEq4CdAeWe/KlfaRrg2ZLmqnlhPyQ9oHAI/OPo6Z1d3PI3Hluo7awAAVaxer5cjMO4Evz9IS7o=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by MN2PR10MB4222.namprd10.prod.outlook.com (2603:10b6:208:198::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Mon, 26 Feb
 2024 16:46:02 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7316.035; Mon, 26 Feb 2024
 16:46:02 +0000
Message-ID: <bf0a5747-f1be-4a27-a2b8-fcd5103d4997@oracle.com>
Date: Mon, 26 Feb 2024 11:45:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] migration: export fewer options
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>
References: <1708708404-197951-1-git-send-email-steven.sistare@oracle.com>
 <Zdv6OyvFG98siqc2@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zdv6OyvFG98siqc2@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0019.namprd21.prod.outlook.com
 (2603:10b6:a03:114::29) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|MN2PR10MB4222:EE_
X-MS-Office365-Filtering-Correlation-Id: 80954076-77e5-40d0-3bd0-08dc36ea6b14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vo/UduLNNmbyhWa2XB6YPezqakDrh3w9jupGpAb7GkN1kGZVzgfo3K3A/6s1Lru2hNLUCBx2ab2Mf5co///scjWvEt1f8ol6B+oCiQpclfU3oBgPSPpjjgfBSAzdhHtqkOOiTDyj7sPcgMjoX4ArKdvNYmk5GbHsbgAKFuzSWon9HRXHTX1JZcB86vzd0hlVoSw+Hy8H7EpIYjNoa/Mvg/FcrUA0PK0gpup1wh4vVfR/qOZt46JptblYgXfn7GrtrS7ArdrrPWzLLs+adRKJw077VN/SJUEuXWAzhcYcDtW+wyS6TYhv6cdRwbY98YaLYvZWu1haqTGukahkvgzns9CKO6ep0XLX3i5A1Fwqsjge4lM4ECRJ5dAFLBpffjfpfczRcdcaeeTM9YjB/MwbauPyq8Laf9qdIme2+Mx7ocoIFt8IJDHuBCfir7nJIFWXqEMrmz9lvaTytjuS0I0WEP6U756i+0akPnjbRjA9lSQzWPCSYisofjOd3/DF6M1TFHU2ObYQUpzFMvao5oNXAt/31Sj5YtCKlNlisDqRMXcnMw2yCK5yP+mzWkmb1RvIMjhZ3/kWpkpZOuHbuCe+KjKs7W3IHlurzfuxwro06aiF8NdLgqGFDrU7dXPRnnl3T/Ndnd/eaWj/hTiLVU246w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2dRSXV2K0RsNXR4dEhDdkJMbVZXdytlM2NkNXRkV2pxcDIrc1NzeVlReHpU?=
 =?utf-8?B?MlQ1aGh2TDBJSDJYVWFTOUovU2ZSOWQwM0kyTElxNER0ZjdYUEpkb2lkTzlz?=
 =?utf-8?B?WWJXSHQwUDV6aTFrZittSG9HcnVNUTFIV0tVL2htTEdEU0MyN0xuSHI0QWJL?=
 =?utf-8?B?SWNzQ3hDS2swMzRMYmU4b1JpMUpvZU82Q3d2RkV4R3BsbUhxTGgxNVpPdFdD?=
 =?utf-8?B?aUd1S3VERnBqdUdRV0ZGTkZMc0pyNGtITjZoR0xKeUVkYW5zbEgwS0dlYVdY?=
 =?utf-8?B?OEZZL21USzA1OXhIT0pPMUQrM3pWMFoxL2FRMStwSm1CK01TZlBheldrN21D?=
 =?utf-8?B?SEdLQmZHMjl4Zk5NY3BNejZGU3ZJTmc0bW1MMGx3R3R5N3NUUi9QVS9FL1VQ?=
 =?utf-8?B?OEd3alh0YzkrbU5yYzRZYUgrWHpyZ29kRnpmVEdwTFJzdDltOTNkbXk1c3c4?=
 =?utf-8?B?Q1VBeGpSTEhjVUFrTWRKZCtnUEZTR2tTYVBLUzk5czM4cWh0YjI1TUVOd1hT?=
 =?utf-8?B?NzFaWXZwKy9icTFINTNjYkpCeG5QVU9lVUgzNVlBdnpRbWVvaEI0TVB2dENG?=
 =?utf-8?B?U05kRndJeXdLRk16alRNcmwwS05SYlp1MmdaY3JVcUlFSFlzb3FUOE4xa0pp?=
 =?utf-8?B?WnpZNGRQNTdjK1JzV3RrMDNSR2FZWTE1aTNaWVhPVWtHczRrcm1pRlVhSFRz?=
 =?utf-8?B?Qmo1VDJEdG9PN0Y2ZzQwOUgzeGpTbm5ZZHIwZE1oMWZsZU1HbkhyWWwzTUJN?=
 =?utf-8?B?K3lzdmhtWDNjK25UazZBRWJzK3llNm42dVhnckF1czBRaldOckNnRWFqeE1h?=
 =?utf-8?B?dXNON0VyaTFvUkZlOE82ajdJeHBuRjc0NjFVZEVOUzl5eWt4MFVKWmRrWEY0?=
 =?utf-8?B?eEhnRDBBUENqUDlXTUp4TFFnU1hqUmFlVTl5cHFFcVRUQ3VycEdqdWJVRmFU?=
 =?utf-8?B?QTZ2Y0ZtRDdlSUZZU01jSWFVREhKWVZBVkd0YWNQNW5pZEtuYlZZWVZGNFY2?=
 =?utf-8?B?Q2pucy9FQXpuc0U5WTJ3ekhSUDFWYnljNlFBeHFtdlJlOW9oU2k4M1p3WUQ0?=
 =?utf-8?B?dzM3MkQ3aWtzem12cXZZVFFHWmNLTUIxSldEV1IzU0VDdGViaU5rWkg5Mmsr?=
 =?utf-8?B?aGZKZU8rNzF2MUZNVUFtUlIrTFR1cFpkYjNtc0NobnJCaDZyb0xtNGVQMVVL?=
 =?utf-8?B?TnlKb3lBUENEMHJoMURBbFI3K1hqUUlPRkwvZmZHdXVPcW8wdDVhdEdvYzhs?=
 =?utf-8?B?VXd1UVFvR3JNZDlGQThCR3VyZmwrT01KanRJMFNPdnY4N2RTQ0FZREdEK0NR?=
 =?utf-8?B?R2ZDd2hXQzFQd1ZNN2QrV2dhaWhuZm5qM0tUamJkejZjU2ZqalVVQVNjZ0Qx?=
 =?utf-8?B?QThzVnRmTTM0QVBJRTBrM0Q1NExQT3ZuM3RmNUFlMFJhSzdHQWJXaS8xVFRa?=
 =?utf-8?B?TnVwaGtmSHpsQjNJM1pUbURMNUVUSURLSExmMU9zWXI5Q3owb0QrYTloWEMx?=
 =?utf-8?B?WWxNWWpWQjlwNlkwSHU3RzNnbFlmWjlON3JremFkNUxtU3VlTmVmTTJOVUIy?=
 =?utf-8?B?dXdiY2dnWTZkeWdLRnBMMHVVOGs3TzdWeHZPRTlQT3BPN050bTRmMXdoVVZl?=
 =?utf-8?B?bXlaME45cG1tWnJnTSsvUng1N0xIb25PbnA2QUlCY2lQMHJQN1hTYm5aNTZ5?=
 =?utf-8?B?bEpsRHViVkcxUlFNNTVMVVFTb0EybWlmVTBUb2tQL05jdlA4aUNHeHlJQ2d5?=
 =?utf-8?B?VkFKTnMzSzhKTEo2MXArNnp1UytFcEtWLzVOdy8vNU9Eem03ODZSdlhRMlZQ?=
 =?utf-8?B?TUVJaHV2YmtSVTllRGlhemhRQm15NzFTWFlwT2haUzVlWTlVdlBsK0dlYlJn?=
 =?utf-8?B?V014YmgvT1VrMHZBWWZXR1k4azRMZmRFTzVIb0sxWjBlWlRIZ1A2T1FKTXpP?=
 =?utf-8?B?VGIwN0ZqbTh2Y3lxZWdTNkxieExjMlVPcmZBUTZaRHoxU1RSSU43NCtqeWJV?=
 =?utf-8?B?QTllSFRYSkt3ZTcvQVVJU1ZBTjVuNjRITzd6U1BnU1RyYVEzK3h1RG5KRnoz?=
 =?utf-8?B?TFRrclg2aDByckZQV2tSYk9JeUEzdVJXZHRmckZIbm9HSjl4TnZvSlhVMDFj?=
 =?utf-8?B?d3hEMUhRZ2NQMjliajZuYmwvU1p5SnN6b0RZYXB1VU5tOXJwZFdwbEtIYzBI?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QBkxUKtc2pZ4UsVSK2oEW/Vq4MIYWn8WS7GJwFoU9m11sluR7GlK2kY2AZR3u/7qN8KQcUVDmWUtXMgWqeR0aX6miRIkch9bZ3P0sneLws+k8G9I4nH1Ksf8l874uE3Cb2wiiXJIs5bkv4l/pLisO0dVDfJVVAr49+Sng5k2EKsJ4rK6J8gDlKEGYx+/IdhF09eRG5FdNvlPKQ4B7xyVWXtwXr5YnMy6bnIrgnEnXJqATbGn+6cXJQxGtXsv9k7yGZy7vFD2/km9hI1v8rAbuogvBO2Mgpg8GtpKntRR96spknol3I85/4eVcWS+AWyTw+mUgSQS4aAJC8gaoCpdP9JsidOwwzx5GwCTmjH5K65CIpLpkE48LEjERLdsWwqqU0fOO5EiqN3VzENbxfCAdIx5+DznPDY5NC6uydrjMD6mqmjfqAGvP1jmAd/Tz2UNzBRd86HStaeYJZ51VsnC8c1FFXgnS2Eules6t3N5t9UwlYy4EZtqWqP9FfhU+7rMSwRsMlT1wXhebgak/t4LR1a8yb8+jFgDtLncJRBOEapkNYXeki2M0Jr5Bu+v2QCKv/VJpSds2nXZKvatMAxtqd/PXLkMP45/xlkpGpuHlfk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80954076-77e5-40d0-3bd0-08dc36ea6b14
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 16:46:02.7580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rk97atX3pNeuJ2YUF3URhsOk2e4VIB4WfmnLk8n57L135RCkESZUx1O1+tfYeR2b8+/XmXtKtFm1WW3M9srj7oLJyH6eCIFlgyBf/RBGs0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4222
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402260127
X-Proofpoint-ORIG-GUID: Y2mEiwwzvh-dFWbUvgGKN2_4C-H69r3d
X-Proofpoint-GUID: Y2mEiwwzvh-dFWbUvgGKN2_4C-H69r3d
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

On 2/25/2024 9:40 PM, Peter Xu wrote:
> On Fri, Feb 23, 2024 at 09:13:24AM -0800, Steve Sistare wrote:
>> A small number of migration options are accessed by migration clients,
>> but to see them clients must include all of options.h, which is mostly
>> for migration core code.  migrate_mode() in particular will be needed by
>> multiple clients.
>>
>> Refactor the option declarations so clients can see the necessary few via
>> misc.h, which already exports a portion of the client API.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> Sounds reasonable, queued, thanks.
> 
>> ---
>> I suggest that eventually we should define a single file migration/client.h
>> which exports everything needed by the simpler clients: blockers, notifiers,
>> options, cpr, and state accessors.
> 
> What's the difference v.s. current migration/misc.h?

This file would be sufficient for most clients:

diff --git a/include/migration/client.h b/include/migration/client.h
new file mode 100644
index 0000000..a55e504
--- /dev/null
+++ b/include/migration/client.h
@@ -0,0 +1,6 @@
+#ifndef MIGRATION_CLIENT_H
+#define MIGRATION_CLIENT_H
+#include "migration/misc.h"
+#include "migration/blocker.h"
+#include "migration/client-options.h"
+#endif

Or, we could rename misc.h -> client.h and include blocker.h and client-options.h in it.

I just like the idea that most clients could include a single, obviously named file to
use the most-common exported API.  "misc.h" is not obvious, and not complete.

- Steve

