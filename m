Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943F1C54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 14:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfhjh-0007QC-Pu; Thu, 29 Feb 2024 09:50:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rfhjc-000741-Ph
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 09:50:09 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rfhja-0003D5-8X
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 09:50:08 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41TEgx54003684; Thu, 29 Feb 2024 14:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=IEUmALomZoCjasVF6suOcRvE3SrUeRboF11rOLupclY=;
 b=XsA+kSMTxj0loy97cWLLOyalpxSdM1JROKGd8B/ypiXko/d3KmKcPj43dnGxJOBd3jui
 duIDB2x2WW7LVToXe3YIJlqFHgP4nK8qzgLPipwVoVkTtRrFdMQfq3pS0ACyWqKzSa7L
 gMUf0m/BRfpxNHwGRwli09c842Wm9ayXX/I1FviQhTej4MmJFcoLMAXrk8nGRvtQT3E0
 uuvFQLxVJeF7hjUI1BExfIQjp9ylZwauCy+OGHZxZlbzLzRVLK0t2zH1sHt7R8dTYcO7
 +R7MNnlOtfQESJgGvi5JIbq0VJyL+Wm7hgBxi93U2f9poLlv9ouuP/HUxrkHz41jusYH fg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf90vdtv8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Feb 2024 14:50:02 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41TEPHfw004727; Thu, 29 Feb 2024 14:50:01 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wjrq69337-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Feb 2024 14:50:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DN4sB4cXHWqqyL3XDSO70kn9rfBEg1NEjwKGJp8nECms8iO5j+y2e5AShAbW411BRXb9BYvbcz9dAwM3DZfn/CnVCg5+VqGIwd6ls770CfOffNEZP0uz2VkVKWDEJv/Nr/gVo1i4sftx7VQkC6KHGMz9pqrxsNWo/OcaXP4/FLEDjFMXooIBC9gtidBOVh3PCagHqXVVOShXyVvOUVXtFgL4mPD9vh06avKfTQvGur/ENHI4voMat7Bmu9rYjpkQvJadDk8F0vY0ES/XzM9JHxNu27mYmutOLQtBF4Hsh/bHMNsKfNR399RXU5XXiS83Z1XFSlZs6hdPYDSon40zYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEUmALomZoCjasVF6suOcRvE3SrUeRboF11rOLupclY=;
 b=VIzjWGYQwSQ9xGg9klvW3FN3LYBY72Au/ZiWZTI+Z5ZN734pfrAwYFAcKuySlkwUh2lrkD+5lxB1HoHjRVtWOVeuv6aDwi9Gmo1pLakIz4YbACxnDrv+amH42CoYjgCEbBKI33/e8yPpN369CJP4QCgmDnHE3loh+Pr3rNrtl/qH9wqMC+a+KqnVrrdneRQ8Q3v8QIEgiQNIPhBc7FSObd0yh2KMBdzUABJH8+S1wuFDe3PJwqZpOy8Mhp1saZnHLEY2INUXbCH3/g1mHn1yK8ZtWualpRwCS+oP2o7s5NywHpCL8KT2UmBLF4Br022waPazW2qvodnwa3iZ5lIfig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEUmALomZoCjasVF6suOcRvE3SrUeRboF11rOLupclY=;
 b=SXtfN5VXnekyND9ZIyZllSMeQUKwrIirhTeoaay6UgiwpW5goca0/WBaQ7mH2De4MP4LLw56FoqtUIpGq6u7GD34ixQBEqTmDfCBYmyHTRc+w7pAFCCR6b5fS8gEnYs9VNgWU6I8/Wf83uqzD/imsLmGrydlYFq9ypS4OhQxgOc=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by CO1PR10MB4562.namprd10.prod.outlook.com (2603:10b6:303:93::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Thu, 29 Feb
 2024 14:49:59 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 14:49:59 +0000
Message-ID: <ff0fe577-659c-4028-b556-a00336e45a94@oracle.com>
Date: Thu, 29 Feb 2024 09:49:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: re-format cpr-reboot documentation
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>
References: <1709216115-3093-1-git-send-email-steven.sistare@oracle.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1709216115-3093-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR10CA0025.namprd10.prod.outlook.com
 (2603:10b6:208:120::38) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|CO1PR10MB4562:EE_
X-MS-Office365-Filtering-Correlation-Id: a29d2ded-d88b-4c44-abd4-08dc3935b3d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vWO9nOr9Y3qgxLevtrsmybaoDDrJjFHk8efle13XI3W5SiG3/EX+UqPggK26ngRreHtq8wO5fKVZFWGhSRoEXC2hRJoNah39ogwcaT7xUYEYLYeirYBBB4EgXVQ6guHGpzMmuaIaiNO7FDIFCwL6zYwpatsQQmgn3+Uu0/loRITimV/ujoR+kmH1DKpggIKBWaXxy1NyR8qUmy+glZgmrsTLI+IL5v6pvSq+r0vJX5VrUl11z2GQKvfcIqHe9oDa/u3IxmU9gihvxGF3cNB9AC82TLkzjdSxUW6Z1FXCnYRuoYohMH25YuY4T47dYZWjE+dAHqOLAHyIss0YS9UuNdVc5nvuO6WWOPpiEVrWS55jZeCU8eTTOJKJdpifFnTz4Bwp2B8O7yzSayMwj7CpMcqPbwRU4G3XBie+klH6+po+9DgsBzWFuyak6j9PhNXyUvoGewJFa20dPA1p0ygH1iLFR4JB7MVXJGyq16tbZk229o0kGuOawjwrBtvaKRz+RS20tts0JYRhy0EwXWiRfkZZcc4fYVZdIo6WWUSMEA1Trzo+67rMvLwpsmsXoCDdIVIlztV/uwxQzKafaqssPSkjo/JP6zQ6t8RxWcWvE+8li6HEQVdgKGkcsZqV9zBbhRbpn9/bBYozPNWhAswvMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eExIbk9iVzF2RlFuL0swTDgzbVJqUFpMMFpGVi9ITUtGb2dYSXpaaUJtOG5W?=
 =?utf-8?B?dElrNWw2Y1VwQXh0VDcrb1VkVmd1Q1dPeDNwVFVWN0RHSzh5Z2REWURSTHA2?=
 =?utf-8?B?MHRsNjNEVDZYSENoSUxDWVVpTURoS1Rodk9nUHVkcUlYR21lMndCenRiMHNV?=
 =?utf-8?B?UTJUdDA1TXJYbk9hRDIvSzZpTEZhSVlYMmQzOHFzNFU1b09rM3RjbFNweXdq?=
 =?utf-8?B?SUFoWGtoemNEeE1ZUjdSd0RoNmNuTnlXdmVLZ2JOaWlucE5uT3pkcUx4UnE1?=
 =?utf-8?B?RjVCUE5STHczNGZXNzUyNUZYMm5GVHFqS2huM2FsOVR5cEQwcUhONk9vTE5p?=
 =?utf-8?B?cmRKZXBNZ05waHNSWXI0R2h2U1JUUDdvakM4UHFMbksrYVhOUU1ZSnlSaG8r?=
 =?utf-8?B?bmxvVURXUm9VUVVtMnZEVVdmRzJqcVBvQ0Q2TW1MTmRxMmd4enhRVGdHYmoy?=
 =?utf-8?B?Y3U2VkVqYkh0MDExbE5kME5EWk9CZjRuNFpqOEgrK0xNWGFRZk9aNktQbnRK?=
 =?utf-8?B?dXY2SjJ6RExJWmM4NlpYeTlYMTRZVk5ZYmJHQVhpclU4dWxBcnk0UmJ6L1Fu?=
 =?utf-8?B?RGRnUWFDTnhvR1R0Yk95dXozNzZPM08zdnBhend4dnpObHNGVFNNS3BQUE9E?=
 =?utf-8?B?L1pZeWdBelRsS1hNY0pBRHRuamd5N2F3TlBOc1ljekVYMHYrMzBiRHlrZmxX?=
 =?utf-8?B?bHFCb0tLKytpL0Rwa0hwV2hMNkRSY3JPN1RLa05VbWw2RDYyYk9CVjRKKy94?=
 =?utf-8?B?SVQycXdkVFc4VDZiL1pOVkJ2QUsxUEJWcWNaMXRVVFFqd1V0OGlDWXovMEp1?=
 =?utf-8?B?QkRqMTE3OHQ1WW9WU3VvdG9DZDQvOVZEMDMrVmY3SElQMzB4S2ZuMnlmZFNm?=
 =?utf-8?B?UGtmNXEvejdlNmF4dWpoS0VHSS9zcFZQcjhTNGNBbGhLWG0zT09mdE1MVVdZ?=
 =?utf-8?B?UGVXUEZyajJETjVxWHNHMk5MNm1qNnloUVZNMWkzd0NJWGhYdGVZQkx5ZHhK?=
 =?utf-8?B?TUFFWjRkbHBLN1JXaVpuQjJGbTNMakZXNnE5cFBKMVpnNW8wTjhvMjRIV2Nh?=
 =?utf-8?B?aVNHQmRXNUVROHc1ODBHdDhzYlg3WUhnQnZnY0hUNHE1NlFFcWpEMUEyazBI?=
 =?utf-8?B?bWY3di90M3ozeDBUNjFsN0d4bVg0cmZQVGdjeXN1Z2o2ZVNDZFlMaytsYXdU?=
 =?utf-8?B?TU03RkppVWwzVldETlExWGY4dEI5RzdVZDF2V1hnU2t2TW1uUk1MRjJyeng5?=
 =?utf-8?B?NjB4czdqY1RDWjFicnoyK0pFblNaYXRCcEsvdDNYSHdsWjF0RmRQOHIrNjll?=
 =?utf-8?B?cllnMVdkc2hDYWo5WnU2VnFwbHFrdFRYWXl0bVo5UGlwMEcrR2p2WVZ0TkNl?=
 =?utf-8?B?YnZaN1JRL1NFMC9pTDRJZ0FLTnFaczhKL1FJS1A0dlF0cEpoamZXU3RqTk9z?=
 =?utf-8?B?M1gxbldTcFBaTDNwc1ZJMTRjeFhNejVVM294SUtsMkI4d0JqSlBoNTlFNkxh?=
 =?utf-8?B?M3A3cmYwN3lMcUUvTHdHZzlRM0trOURJcTM3RFEzdEJSd1VrMWZkajZvcXN1?=
 =?utf-8?B?bUtoa20vSVlIYkNsd3RrTUNabFlnN2JRS3FjQzZZb3pmMUIrVS9XWStMY093?=
 =?utf-8?B?bVBVb0pXdWFLUUQ0bllFaTJ5T2NSOTR5THFVMXlOZjNZaVZ3eDZnQ2UwZjYz?=
 =?utf-8?B?TTZJSW04Z2lIRWplak9oTElOTFlpdGY1SE5hVW5CUzA1enhZRitLbTBYVUdT?=
 =?utf-8?B?VkR3eGZxa1UvOVZLdytVNDBjTGZud3NxWDhKcldFREwrd3dwMHUxcFZRZnFG?=
 =?utf-8?B?VDRoYjV4cU80dG9vakRpUGYzcEpqVVI2MTFqQUJwem91SFYwL0JJRDFwUGFw?=
 =?utf-8?B?N01Sb1FFTkJwNUhKamJyQWhpS2tETDdFZFdjM1REN2R1czRPWllPZ3BRcXhM?=
 =?utf-8?B?Zi9tUkhwTE5JYXhWNGFuSTRzcWs5QXM4Qy90MVJScXYvRzg5bm9lUkNUMjlX?=
 =?utf-8?B?ZEhhV00xUmRiZ1RPeS9va3hzelczV2kzTFE2N0dqTGZGVHJ4UVFIZXR4anVl?=
 =?utf-8?B?aTNpVlNxdmE2OE45WWkzVElEdG16cGltTllDYk5jd2QvcHZHYU5Od2VkQlJO?=
 =?utf-8?B?VUo3aTlUM3NnRktlcHAzYlluQW16OFl5STRSVWlJK1Z4WUgxVDZsdXEwMXNU?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2AHC+zldWW+/iI3dJz1G7XGW0FWDF6iB7j/GPhQkLsc2NxUA8XhaQ2GOzlWt1aFosZzLe7AorJ9IpCYLPy3xUnib7LecLDcaOJVtm/FbujbOBRKpnXM+E4K9i8cgE98NLTiILFtpdu54vajt8H2xOUrSE57m3Gw2heepYw/XUtyQ/R/V1lbZP+Em+T0l1CkLwp4UaH9ZKzwEaX1z9qI0sKkAW3M1BzHef8za5dY/E9upAmEHf76STAkckp11cGCwQAHDrWIwVB5xdVKXGyhwJH1jjmXUIH0ENdTp0n5NYJ6+EQHyqd8hL4AbtYj8dtujzSZjUtIO1SI/a0OBm4V9eTw33R3TTzHi4OFJYysbP6uF4Evfwrx8eHTg9csW80pUcjLKTy5TBn4OOatxcc/PkFu9pqHDCMJnSjBOqKSONvdn3rOdQarE8pm9d3VroAw3JrEWV+12w+D0G0lf5j7+NBBmTE673rLSwwvqtwmakVN/N8BycorKyF2C3490lEIA9HN0uZAMvvx5CH2Ss2MbFWCvOoIe5yiIaBYDqrGp/3EdvvDFPyqNqK6OH4PpxIr7k4WZysG8pLgjTzsgQuF/e1DWK2aUH3DuCWNURUnKxko=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a29d2ded-d88b-4c44-abd4-08dc3935b3d5
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 14:49:59.4248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPSIJ5UKvSAEy+gOuxNw7tUbqn+2vd9aTtZJlCI+zHLWj1i272xQw2u10tP9fTFHFJiq/ZQZWBIZXoLamKzX6xmZEvMnezOz/5ZmN9epXOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4562
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402290113
X-Proofpoint-GUID: KTKplC6dmavjaScEi3-Kl0Qd0hkJS1ox
X-Proofpoint-ORIG-GUID: KTKplC6dmavjaScEi3-Kl0Qd0hkJS1ox
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

Please ignore this, I will send a V2 that incorporates additional comments from
Markus that I missed in my inbox.

- Steve

On 2/29/2024 9:15 AM, Steve Sistare wrote:
> Re-wrap the cpr-reboot documentation to 70 columns, use '@' for
> cpr-reboot references, and capitalize COLO.
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  qapi/migration.json | 36 +++++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index c6bfe2e..b69f62a 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -636,28 +636,30 @@
>  #
>  # @normal: the original form of migration. (since 8.2)
>  #
> -# @cpr-reboot: The migrate command stops the VM and saves state to the URI.
> -#     After quitting qemu, the user resumes by running qemu -incoming.
> +# @cpr-reboot: The migrate command stops the VM and saves state to
> +#     the URI.  After quitting qemu, the user resumes by running
> +#     qemu -incoming.
>  #
> -#     This mode allows the user to quit qemu, and restart an updated version
> -#     of qemu.  The user may even update and reboot the OS before restarting,
> -#     as long as the URI persists across a reboot.
> +#     This mode allows the user to quit qemu and restart an updated
> +#     version of qemu.  The user may even update and reboot the OS
> +#     before restarting, as long as the URI persists across a reboot.
>  #
> -#     Unlike normal mode, the use of certain local storage options does not
> -#     block the migration, but the user must not modify guest block devices
> -#     between the quit and restart.
> +#     Unlike normal mode, the use of certain local storage options
> +#     does not block the migration, but the user must not modify guest
> +#     block devices between the quit and restart.
>  #
> -#     This mode supports vfio devices provided the user first puts the guest
> -#     in the suspended runstate, such as by issuing guest-suspend-ram to the
> -#     qemu guest agent.
> +#     This mode supports vfio devices provided the user first puts
> +#     the guest in the suspended runstate, such as by issuing
> +#     guest-suspend-ram to the qemu guest agent.
>  #
> -#     Best performance is achieved when the memory backend is shared and the
> -#     @x-ignore-shared migration capability is set, but this is not required.
> -#     Further, if the user reboots before restarting such a configuration, the
> -#     shared backend must be be non-volatile across reboot, such as by backing
> -#     it with a dax device.
> +#     Best performance is achieved when the memory backend is shared
> +#     and the @x-ignore-shared migration capability is set, but this
> +#     is not required.  Further, if the user reboots before restarting
> +#     such a configuration, the shared backend must be be non-volatile
> +#     across reboot, such as by backing it with a dax device.
>  #
> -#     cpr-reboot may not be used with postcopy, colo, or background-snapshot.
> +#     @cpr-reboot may not be used with postcopy, background-snapshot,
> +#     or COLO.
>  #
>  #     (since 8.2)
>  ##

