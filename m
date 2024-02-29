Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036F5C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 13:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfgeJ-0004wc-La; Thu, 29 Feb 2024 08:40:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rfgeB-0004oF-Cp
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 08:40:27 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rfge8-0000c3-QH
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 08:40:27 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41T9nfDr012463; Thu, 29 Feb 2024 13:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=wOL1hbL5dfkctiJvmGVHGHXjruD8Z58o4EWomOB88b0=;
 b=lvKcIz3584IyV/C+gku6tXtALciEStPLziVmpwZEgin4fbnVXCllbzkfr58eMATpBKVZ
 XaFBjFvJsmEmJoGPfxvECYu2NM3p1qynxNFk7z/EB0flxzjeTnIddAgtbC/RD1y1vK5l
 /zKhH3MY4Q5SmrO56N5c28VEBwZbdTLI1FqSf9kKTynaNKprCrR9CSOz0/1ZwkBi24wP
 miIKEOVKQTomnt4mhkARbn4AD8AN0PFwbvL3pV+IJypqpEu1O0gIosIufSHR+YQS5Hm9
 ACN+5j+l5z0UUbyS+03C2rvnA04Zx5HBZpN3BjaoEijV9IGfu3kpAOs1Uq6VZ63de3dp 7Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf82ud6ht-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Feb 2024 13:40:23 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41TCu4FM009387; Thu, 29 Feb 2024 13:40:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wjrqk5y1a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Feb 2024 13:40:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihwxGmE4v1Cbpjp4qEVKNNjUaw2rTbDk3zyJEJNZu9FzcF/RIWaY0Mj8Wrr+w4WOLdW0K7aSD0qpqgmEtlQgHnxxgjAYm3DVtkNzsgISfIIWsRPuVSUL1p05JFtJxEPBa1t9U+w/nIKlovTrUNyp48hWsaUeVG+n0i2NmRDFPMUZ6jtnM/SzZRMIoNpWjM5eI1d7lME4bomR9kvahzhBnWWtx6e8myL06zZKScD+V/1T2xE+MJnAXkIRBIMdJcNWiqoHnENsVHijU2EyC1LOadEHs6IKxvr9GXaNcH1Nhg5J/ad1uObTZeXMc6q16IQItUepALHxQovfXND/WFC9RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOL1hbL5dfkctiJvmGVHGHXjruD8Z58o4EWomOB88b0=;
 b=iO59lickqXjIsRgMLbYEdV37kriSEebv1fG9I4HIt2v8L1N9g/dCE/2neUYt/q5Z9M6By0hhfcEkwiG6TL0Xem+es+b39+kO7Ms5fAlmON0zG7qCLxpXgc3yfJqZm3NyNtLPTpUEWvxNcUGdSoBGTwSoFA4sIHw7NgHy+RZQEjF5/7AMFK+xOvxMJZMMiZM1D4SCrJNRSpvlnp3ufVTzYHSzy+GKu+dno0ZKYlWYLMfdASfFMy+Scd3YUzdJeL5MNLwSL1m+fyq8Sd9N5wVec/YPqplBb3JVWi69KjRUtNMuMScenAK9BVloLPs4YsfF5ID0yfXB3bXELeWegZg4rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOL1hbL5dfkctiJvmGVHGHXjruD8Z58o4EWomOB88b0=;
 b=ap4aLj24HlE7R1umpNdGSoXUxtgAQE8EEVo0gXlSNSzyw4Z08bHrr/13bL39xKE4rg26Sn3b/hNvAwptYSKBcXXF2aIhn9oNh1QiaFQZjcrWE7LI8BEKZGUKiTU5YFbnvVNzfyyTN3EjUtxgP0lWIQ82e58dr2bJsE1m3thhLCU=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SA3PR10MB6952.namprd10.prod.outlook.com (2603:10b6:806:31b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 13:40:20 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 13:40:20 +0000
Message-ID: <b76be935-9074-461f-8630-6a27fab274c3@oracle.com>
Date: Thu, 29 Feb 2024 08:40:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 11/14] vfio: register container for cpr
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
 <1708622920-68779-12-git-send-email-steven.sistare@oracle.com>
 <4b75e51c-6798-4b3d-8841-7009dd34517a@redhat.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <4b75e51c-6798-4b3d-8841-7009dd34517a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0195.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::20) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SA3PR10MB6952:EE_
X-MS-Office365-Filtering-Correlation-Id: e871ac6c-b3f1-4591-5bf2-08dc392bf8ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1QsSmqUiJ/nR0xfxalgMeSv1nAuo/yIxiH7qdAWGVN+A33iyC+FAa1gojNPPCstHuvTUWK0mW2y6XLBOWMZUrIGyb8WaXNYiJ9OgcBf3dmpu4Wy9iN5HUmWCL4rF5yaQ+KpNRU1ki/IJOvBO8hrTaA4bF2KqEJezGOfDOnrRNTAqyiJGpz3/ROIp+P2/9XGkxbc9gEufY+swqnRBrkgOZVrqm2l7oRbcMqR/XbdMcZTKUJMWKoZNMUve4yVJc9il410ay1pBjhKObUnqgBuAeBVzLWZDm+uhvt6cjdhnUuZWGi/8bma/plfC6wGmagbuDAjGZM9Z3+sC5tr7FDFnhbFqCRQ07ft10Id8nt3CgE+X6STIrqlRqrMN2ZfhTftxfw7fJeOM5KrKI0AmtlsrkqWcylkVqr/01T+fwz1O9OAH9pcNY8J5ffS8Mfeur5cV65gPK2wiNp58uVjrv8VKmCo38N7I8XNIsEFwGT4Kzg2++9qjqu389nB4JqRWyU9QTxEfazicTAdF8F1lbBsyeVIqpi0YUFX03GVIzd2gZtKjK4o5hnt+KQE8Wx1pWRfZ54oTCM4ejehDvV0qYOiWm0vbf2LKOvXeq0m0abbmSePf98HRR1jwf6fWeG9DpskBaKkOAwWW2GmNi3ie1g9/Nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0dxV1F6SDBmbzBqeDJVQ3l3dDFVS0lIUTdvZzg3cy9Fa2FEeU9nY2Q1OXQ1?=
 =?utf-8?B?MmVMa3d2dmhnTitOMWtGdERKR0J0cGhZNVlkYWRUUWp0UjYxb2RpUEFSRXVa?=
 =?utf-8?B?ckQ5RHFwVzdGTVp6MW94R2ZHMXlSWDBpZlF5WWNjUkNRMnp6NHJsSEVDQmJn?=
 =?utf-8?B?UWplRmFKSXBiVjRCaG9aZnBQM0g3aHQxazd2bk5SdzBxZFVLWXFHUjRzOGw1?=
 =?utf-8?B?MDNXNkZxbFV4ZjU2NDBWU05obm1hcndneXNneU41ejJnVWNzRWplOVpjYWdy?=
 =?utf-8?B?UDhOUHgxZnRRQUhOZGVMc202MURmMVVoY3JqWnRJZVBscXhuRGVSZktoVVZY?=
 =?utf-8?B?M3pJOE80eWJzZWlJaVhnd1Jpd0pQWlJxdEhUNUJUZXFPbS9JaXRkc1dYTnMr?=
 =?utf-8?B?aTRIVDZyK0s2eGF0WW9icERXd3ZoaTl1N0w2WmZtVHNCUFhvcjFnT3grNnE0?=
 =?utf-8?B?eEFkU1Fya3pTV2RJL0t3aERPOWpDUWpVL1ZKUGlZL2M4a3JMcGxFMElDOXVE?=
 =?utf-8?B?Vnh5bFpWUHdqQ04yY0Flc0VvNVF3T3pCMWVlYkxla1czNU50UXYvQXVaV0Fz?=
 =?utf-8?B?Y2ZiYTdraTlQV0crdUtMZzE5cjkxcnd6QWtJcWFDUVdGRXp3SCs4czRFaUJD?=
 =?utf-8?B?QjE5b3ljMmlZME9ZUlo5QTBDanRVaFdoSVBmOHVBRFRFcCtTR3ZLL3BQMndL?=
 =?utf-8?B?Z2NIMFdubWN0MHNXUENJOWFSWTBYNGhLRG9KaEJxbHdUcWJSNk5PSWlCMUtj?=
 =?utf-8?B?K1QzWFpRSVR4Z1M2OUtlSVFzZFpNUXZSWWZveGNlM0wrMUtmcXhjaFhkZ0xO?=
 =?utf-8?B?M1FqbFZ0NGgzc0l4MzNKOGNWcGVLVDdTK0k5bVBaNTBFMU9GNHVLNEZVS1Ru?=
 =?utf-8?B?NDYwYjlseGhlckNFVTBkb0NYVHF6TFI2QnZ1UTBmeEFReStHTzdidHljRFlR?=
 =?utf-8?B?QmREVUtoQkpJUjUxTWF4QjYxTWE4UC9ZcmtYT0xoOEdML0IyYUIrZ084dGts?=
 =?utf-8?B?K2huR1FhdmZPWWNzTnlmcEtiWWpVUHIxL0tTd21kbmRBVFRjMzFDajE2UEsv?=
 =?utf-8?B?QndnVmFDMFNPZnhhMjFsOWN2OG1CeEVGc3cxMFhsSkNNVWtQNnBQa0x1UXBR?=
 =?utf-8?B?akJHcnlTdnk3WFpQazRFRHB0ZGUzUVgzRGh1c3N3VWtUQjVmdjRwTlFxM3ZL?=
 =?utf-8?B?Rm1Tb3R6dEFQUUVrQ2ZkZEZtMCtNUkFRL3NpdTc0aDYrUTR3TnFZNTRSR2tB?=
 =?utf-8?B?cXNXejV2ZWdRUlBuVTdQRm44SnFlWnBVNWhhTzlWcStEZWx2VUpndmJrRk5C?=
 =?utf-8?B?Sjh0ZEIvWGFVR3c5S0paUEFHd0JieFdta2J5a1FMRFppenRVSkptRlU2ems1?=
 =?utf-8?B?U2VVVUdUclZzYTV2NGc1M3JmdTN0U0VTdDVsa0RRUFlhaUJkdWNsNCszeHpu?=
 =?utf-8?B?bEY0UVh2TlA5czdNM3RmNE5Jcy9MUEJIZVJFcTNEdGN0dUNlUnNHb3dXMzBV?=
 =?utf-8?B?RWlNSlc0dlZ4bnc3UCszQUo0RU1NdTZvY09mNGJMNzA5bWl2MnZrQjZzN1FF?=
 =?utf-8?B?ZW5GQU9zTHFiRU5RODd3RFVoazhnRkpqeFFmRXduRHNnNjhzbTB5YTNNZ2ZN?=
 =?utf-8?B?K0tqSUVJbVBvU09xOVBSS0tFWFhKQStOK2p2VW5ETlFmZ3lJZUNDTENxR05X?=
 =?utf-8?B?RE9CckdsWHhwekgvaWVDYTdXTGNmdDFZZEV6SWEyRjJzZzgrbExyakJ1MEVF?=
 =?utf-8?B?WTdPRlo5KzhKZVJBdFZxcmFxQVY0U3RaWXFCdkZZZjdRMkJpbmx5V3QwWVJa?=
 =?utf-8?B?MlRtMHFJR2p2RkxOSFN2cDdmM1hoQUZIK3NCZXlPdVdYV0V0U1doaTZnZTdY?=
 =?utf-8?B?UXN1SnlNUjhYdE1VS0xKem1BOCtkUmVyV2ZCOEZGbmZLMXZOWDkwbnBUZnU5?=
 =?utf-8?B?Sno2bmlyUVVqdTBxN21ZZXVROGR1cmZCRzJsY0c1ekh6ajZsL3J5RXJqU1Zw?=
 =?utf-8?B?ekNYeFNKcDc0blk5YjBDenpOYUM1WWErT0xsMlI0cVF3NGhzU3FMTHNKdmQz?=
 =?utf-8?B?VU0wc2ZudTZUVzJDQkFhKzN4eCthaGI5Z01LdklvZkxYc2Qya1YreFBQTzQw?=
 =?utf-8?B?ZHhIay9aTHhtd2pQM1M3dFVjZEZlejl2NTd5SnE1MXZBSEJvZk9kUHNqOVIy?=
 =?utf-8?B?WEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cH+0almxbyZGCIHRtfOXapU/e59/vu/h4q/nAVskWTVMK6eGOH1XQs9JuIx/v+3q2NQZ1XTW5r3b6Vhxgxh4WuTzWm+B2VoNBP6hIKcHNnxeavJabeTDkzWCdG6n9t8ojSUTUYKWjgzWe8kZDhT5PuFA7nFyQsiLMYiJ3lWmSDSEuH0ViFoudKIBGT6MCAPK0aq5oXSSx+6f2L6wbsQ1S4i1+NlVeNyZ3R1f4yTlfHQ9zAsv0JDbaN/TBuTFoM9AiUinJ8epVwe4sPIstAjtalHVKkoH/336YMcdTMtReNXgOz5TQijfkF96lyp3fnTZa/e2oZba4I7+/Mox/zzk0ofuokHM7UKSws1B/SN55108WzVKprsq6dYraaSXUkAqJGDLmMbDlpPVKcrLzD/bzV8NpAW7DRgAo0JfxPwrQBop/DXLSTAG0bNuASpI+CP8yYoCmXY8gSCUgly/mhwwvGy/vXII0NthX4HlnxiLhLP2WRB6aZrdWti3DHA1B0ppHE04/4Qw1LT13L32Mvjq5A1XeIq5j771kxWsZujOylPMbGD4mkaXKJPM15BF5pkngqvbOqlfrqEUhTKmj0xmZPJzGXkHt+H5L4sha+9/IJk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e871ac6c-b3f1-4591-5bf2-08dc392bf8ff
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 13:40:20.4899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZTTFih9Fq/AysrdwWW6xn/WOhnfMPYBBNDFIOCiB+rYOomlG4VSKoTFfNfKXwAhE3UOYDOqtcv5UEy5Oa7h7wTEkEU5bWQfpbdZK5nqj6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6952
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 suspectscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402290105
X-Proofpoint-GUID: aK_okhFHAUboWTqyw0Yx4fp_zTV1TmyD
X-Proofpoint-ORIG-GUID: aK_okhFHAUboWTqyw0Yx4fp_zTV1TmyD
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



On 2/29/2024 3:35 AM, Cédric Le Goater wrote:
> Hello Steve,
> 
> On 2/22/24 18:28, Steve Sistare wrote:
>> Define entry points to perform per-container cpr-specific initialization
>> and teardown.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/vfio/container.c           | 11 ++++++++++-
>>   hw/vfio/cpr.c                 | 19 +++++++++++++++++++
>>   hw/vfio/iommufd.c             |  6 ++++++
>>   hw/vfio/meson.build           |  1 +
>>   include/hw/vfio/vfio-common.h |  3 +++
>>   5 files changed, 39 insertions(+), 1 deletion(-)
>>   create mode 100644 hw/vfio/cpr.c
>>
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index bd25b9f..096d77e 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -621,10 +621,15 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>>           goto free_container_exit;
>>       }
>>   +    ret = vfio_cpr_register_container(bcontainer, errp);
>> +    if (ret) {
>> +        goto free_container_exit;
>> +    }
>> +
>>       ret = vfio_ram_block_discard_disable(container, true);
>>       if (ret) {
>>           error_setg_errno(errp, -ret, "Cannot set discarding of RAM broken");
>> -        goto free_container_exit;
>> +        goto unregister_container_exit;
>>       }
>>         assert(bcontainer->ops->setup);
>> @@ -667,6 +672,9 @@ listener_release_exit:
>>   enable_discards_exit:
>>       vfio_ram_block_discard_disable(container, false);
>>   +unregister_container_exit:
>> +    vfio_cpr_unregister_container(bcontainer);
>> +
>>   free_container_exit:
>>       g_free(container);
>>   @@ -710,6 +718,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
>>           vfio_container_destroy(bcontainer);
>>             trace_vfio_disconnect_container(container->fd);
>> +        vfio_cpr_unregister_container(bcontainer);
>>           close(container->fd);
>>           g_free(container);
>>   diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
>> new file mode 100644
>> index 0000000..3bede54
>> --- /dev/null
>> +++ b/hw/vfio/cpr.c
>> @@ -0,0 +1,19 @@
>> +/*
>> + * Copyright (c) 2021-2024 Oracle and/or its affiliates.
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/vfio/vfio-common.h"
>> +#include "qapi/error.h"
>> +
>> +int vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp)
>> +{
>> +    return 0;
>> +}
>> +
>> +void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer)
>> +{
>> +}
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 9bfddc1..e1be224 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -411,6 +411,11 @@ found_container:
>>           goto err_listener_register;
>>       }
>>   +    ret = vfio_cpr_register_container(bcontainer, errp);
>> +    if (ret) {
>> +        goto err_listener_register;
>> +    }
>> +
>>       /*
>>        * TODO: examine RAM_BLOCK_DISCARD stuff, should we do group level
>>        * for discarding incompatibility check as well?
>> @@ -461,6 +466,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
>>           iommufd_cdev_ram_block_discard_disable(false);
>>       }
>>   +    vfio_cpr_unregister_container(bcontainer);
>>       iommufd_cdev_detach_container(vbasedev, container);
>>       iommufd_cdev_container_destroy(container);
>>       vfio_put_address_space(space);
>> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
>> index bb98493..bba776f 100644
>> --- a/hw/vfio/meson.build
>> +++ b/hw/vfio/meson.build
>> @@ -5,6 +5,7 @@ vfio_ss.add(files(
>>     'container-base.c',
>>     'container.c',
>>     'migration.c',
>> +  'cpr.c',
>>   ))
>>   vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
>>   vfio_ss.add(when: 'CONFIG_IOMMUFD', if_true: files(
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 4a6c262..b9da6c0 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -205,6 +205,9 @@ void vfio_detach_device(VFIODevice *vbasedev);
>>   int vfio_kvm_device_add_fd(int fd, Error **errp);
>>   int vfio_kvm_device_del_fd(int fd, Error **errp);
>>   +int vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
> 
> Should we return bool since we have an errp ? the returned value
> is not an errno AFAICT.
> 
> Anyhow,
> 
> Reviewed-by: Cédric Le Goater <clg@redhat.com>

Hi Cedric,  vfio_cpr_register_container sometimes returns the value returned from 
migrate_add_blocker_modes, which is an errno.

Thanks for reviewing these!

- Steve
 
>> +void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer);
>> +
>>   extern const MemoryRegionOps vfio_region_ops;
>>   typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
>>   typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
> 

