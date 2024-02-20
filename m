Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EAA2C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 11:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcNql-00051F-PN; Tue, 20 Feb 2024 05:59:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rcNqj-00050d-CB
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 05:59:45 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rcNqh-00055t-0T
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 05:59:45 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41K8xTuH021617; Tue, 20 Feb 2024 10:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=mPWpirL4GnWzvD/rLwrCKpbwoAu1ohTxrkCIgUA7dOk=;
 b=SZdsQgPXKrAKuRC0dwiX9LYHBzdtlPiZiylNSps+3Ur46EnXriDmndvIVObEaTzvSxRZ
 GN749X8f+RkY7CwTMU7mvv5ERSWAa88rKOF8J0zb+hpW88chcieh3GvXayE9XOjbLfNC
 ax8koCR1RwOf5EMzzTzysckpqX2Ih5Tj2xjzSjsdvJZDavj6liotEAN4ac0lkjB6joak
 iFcITn35EQoaKsCetW4vlf7srAuHS2RoQnPPOSCEeIW40oGG/0v00Yz2Wln2JeVTPzm7
 m0sKpAS9gD7oBZWODhV/momV9tygd0kCFu4XeZuERclMqcfPBKC21MfkbqWdmSD6Zvo2 0A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wanbvea2j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Feb 2024 10:59:38 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41KA12k2032844; Tue, 20 Feb 2024 10:59:37 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak873536-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Feb 2024 10:59:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtmBaYZDYPzxby31f34ZwOZ4uJD3JoG7lsG3DXjJ7/xesy42/eo6edYJyx7I2A9gpor2vzDRVqKQ/W5cDnLmzXRhfq+gGy4Z3uiZ8oV/ewk4kGK9vIHh20KV/eQY/ex1FbnKCa0iUlqTo7V003REfenGTJ5O7gTY7VHxEBMjbkhtMZlSwbvRnDmw+6Kdz1ZD3ykOUPS29kLsx83xltHj3qRzIZogxx4vX6BLJV2CiqxJKc/ShIZiY1wP2fqsIoYcETJuYOtHUAA5qFET5f3wM8FXF3HrteO2Awo7RVuienV5jISINycKpP+DmOmBEpoBXnaCSC/Xr0IOqASZbf4rNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPWpirL4GnWzvD/rLwrCKpbwoAu1ohTxrkCIgUA7dOk=;
 b=Ma39vtOzVVuD00lpDXzbMGhMfiyDtucWeM/72RGECMi8I25EXDit8RZSBs4j0oRrSN3Xs7D2xKVR39+kzrbqiNVujYivxXjtM8WA8iZORSWBSUIChxV6ncZYfpWOya4OOEUF9UJl5U8qkVUjqNOSx4DoAmo8t+KVK0ZOLrFddLcdu+GfmFntC27xlmfsMmNfOysF/RX0i7Tp2hSfI6ctKORov1K0CpCGNRpPNUbqxT5zHSOroaa+t0oL+WdSe+xp5Chk2mqP4Yy7Epzj/joPsI+lPpPMqQojJXQbSqopjCjR3heV8C63LGefeNlzvNn8HJzUKrPHdF4nj4dFGmoMlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPWpirL4GnWzvD/rLwrCKpbwoAu1ohTxrkCIgUA7dOk=;
 b=Qkz0A2KTh01sv4t/J5slqXeKKZXlq1ShANeylkh5lrokQHmQO78/HFROYEOI3KYDZ2BzJnztjkEyybvBSf53qVHiGPJnfwipzCQ3KJIkIZd59IVkZBLkRHlWT9w/NBHdXDbyI+CoIoN6FVOifAurOXJqKXoDeiDsdOEbJeaTVBk=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by PH0PR10MB4806.namprd10.prod.outlook.com (2603:10b6:510:3a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Tue, 20 Feb
 2024 10:59:35 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 10:59:35 +0000
Message-ID: <096b9798-7534-41aa-ba3d-12f98c00c59f@oracle.com>
Date: Tue, 20 Feb 2024 10:59:29 +0000
Subject: Re: [PATCH RFCv2 5/8] vfio/iommufd: Implement
 VFIOIOMMUClass::query_dirty_bitmap support
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20240212135643.5858-1-joao.m.martins@oracle.com>
 <20240212135643.5858-6-joao.m.martins@oracle.com>
 <717d6632-9038-4ffb-8193-511e62da5311@nvidia.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <717d6632-9038-4ffb-8193-511e62da5311@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0388.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::16) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|PH0PR10MB4806:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cc4e0cb-1663-4399-d97d-08dc32030654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: at//0Hg90O1+ZybenoLndLVfA0+t5TwFAC62uO3cjrd3wy3lEXknSJUUvCxqXNJ7aWRHWWJfXaYkgHvMyqICxEQwvklGWL8V79tUWHNp3ztOxMF8EC7JZnyYR+Gd9kKUHe2X6mIBwCOPyRDwvWUEm7F9gr1+WOGpTWT9CfjNoNQ/E4m3vfa2/uLskCl9Kb5r7WkhVExeOrtFRRRHWAZIxw9Tzl153vIsRqR44kzj/5eMYcx46WCrZl8R8aoorTOWlUbOY8ZarFd5TQlDU3X2xxtncKECUFfqEwEtQARgziemBdTpMdZhtP59eXFZN4KXErbEHmOl7X8YBsXsvieW+5JEzZDyW0hC+bFJVymbTQ5T8DG2aPMamMrYtuJlRjNdEgXc1owZLn+v1ZJzi/bdp+zLkKOc8KeFdGI8NjNl01jFWJCZQak5FC39sC908KvHLo9yNRW34O1KzzmTMn255Y2PFCZbDzsNNWCiKh6eJz2+p1wSxIXVILPnhOwALm0eZRnkf/ap9WklGb14gmfBZU1o08Caukmw2litLM65xp6MqatNf+TaqYxLEWMrWmaf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(230273577357003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVNCOWpOS0V1Y0dRQTZKQ1ZFUjR6Qy9XSGtMQmw1OG0wRUpGdzBBWmJvcW5z?=
 =?utf-8?B?RFhIRVIxMU04ckV2c0JnYzlXR3d6RkdGMitwYmNNUnVtU3VpRXczY3FWZlNZ?=
 =?utf-8?B?RktsdHpsN3VNd1lRcXF2eWxjRXk5RDNtSWZ0ZmQzMHNZMGN3N2JySVlJTFFm?=
 =?utf-8?B?aHNLZmJobzFjNkkwL1htRU5sREtHVVVmNEVCeWY1RUlwMWRGcFZRaWRIdDNZ?=
 =?utf-8?B?dGc2OVFvTXlOQmJUYVlDbkdoSGExRytQMUhlbmN6b3E1a3M3TC82dURWN3FX?=
 =?utf-8?B?c1BPVFIydWNBK0hoT0NsRUI0SlJsL2h6aCsyRkVuMVdNVHNSMGo4NnRTSnRa?=
 =?utf-8?B?ZGsyYXRveVJqRDlvbjhzMXhid08rQWhZeDNUdWV0RlVhUElWbjhQOUdjWW94?=
 =?utf-8?B?SDBTNG5VZTJZMHpIcWI1dGJTY0tvTmNkU0toak1UV0VnOXhOeVhYUFd6QjIr?=
 =?utf-8?B?dUNhNGh1TEY1UnJkSWgwRk15T1dUclpXdS9VT1FjVXg1N3ZHbENlOG5pT3hP?=
 =?utf-8?B?Mm01azBGa20waXFKUzFtVERyd20yWnlhVlJJZWQ0K0hzQnFXSmRLdFk4UGp3?=
 =?utf-8?B?c0pjaGVlV2RuU0pRM3ZtekJRZ0FsaU9sTWF0YzFYY3ZSUW16a0Q4VG1BQjdR?=
 =?utf-8?B?dGtodVprRG1FK2ttUW1MTzlmMGxNQnRMY1pIZlArZ3drWGk4UjJoNWU4dllw?=
 =?utf-8?B?dHBLWWNyVGQzVk5YeDJudkpTUE5Hd3dJWVR2b1VmNzlFa3REbGZRVldVRlFx?=
 =?utf-8?B?anBaMXFFL2dULzNZa3I0dmpRbTZzb0tJRUs2RVJsV0drS3AxMXV3MGY3WjNC?=
 =?utf-8?B?eXhSeVVYM0E2YkNnYk5mSHo2a0V3cGQzL0FwUUsxL2JXalN3YlVHOFVPck9J?=
 =?utf-8?B?bndvVWdIUm0xNE5zVzNscm1FK0RZWGRCaDhKVnFpNm9JN21WemY5N05pL2o2?=
 =?utf-8?B?TmV3bk1PbzJjQkhTUXJBRmVVenJ0ZklPODZjUEhGOVpxdmV5ZE40TU1jOVZH?=
 =?utf-8?B?UFhnQmtadS9TU1UwUjR3NHI4YzVtTGNhQjhoNGdWUjdQUjR5ZFhWanVhWW5K?=
 =?utf-8?B?MExqcGh2cTd0VjQwdTJ5RWJOY0k4bU4rVERZT2t5Y1BvTFg1YTJnczV6U0JY?=
 =?utf-8?B?WVBUa0ZLZGpGZjFTeEpQZWxWTVRmd2xVTUlnMG5IZmZEN3JwcW9HRWVnd1NN?=
 =?utf-8?B?YktyL2hzU2xTRDQ1czlzZ3Q1TXNWRDcweHRqTGxvQmdoYVhZaDBqZ2ZNVTRV?=
 =?utf-8?B?Z0djeTFNL2FmWko4K3dsWjZLWWxwazFQcTdEQlFPV3JWMlV3Yk9NNFNRV1A4?=
 =?utf-8?B?K2xGaDRHUHpwNjlFSkpIbWpBYks0TUFUaW1mTU93WURIWnN4bzFXazZRMllT?=
 =?utf-8?B?bXFrMDJZKzQxS25ZeFE2MWZ1TkdnN2R5ZFNlOGM3VmRXUjROOFhBdGFnc2p6?=
 =?utf-8?B?ZGhXTUVTRzF2NTFSYTY0bThFSXIzaHB0bHRkMjZVR1NTN1NDMVBzUWZrOHMw?=
 =?utf-8?B?RXpYN2F5NzByZXBhYWVodSs1QVhYWjZneE9GOEJJZ1ZueUlld3JweHBiM1FN?=
 =?utf-8?B?SEs3UFBZU0x3UXZlT1M5ZkRKQWVKamlqR3lrUFNpS1hWYitlQ0IwSDBxV0p5?=
 =?utf-8?B?RTVjSWM3SjRMVmhmRWk5Vy93V3lHTXN0QTQwTkRwQ0tDK3F4Q0JQdkJ2V1R1?=
 =?utf-8?B?YndQdmJja0tYR25zVUU5c2t4NkJ3OWhuNWliRGlnZ21wYzlXOVd4K2FmOUUw?=
 =?utf-8?B?VWJmZ1FJQzBlQ3c3Umxqdkc0MGppODJib1gzUWdiRkhzZ0FnYlZYWk03OHdS?=
 =?utf-8?B?cTQwMmMyZkNLYVhETjc5eDJJUzlJVkZPUWpMeWtHWWUxSnZlOHNVMUlXSDdy?=
 =?utf-8?B?ZUcxN3NhbDJ1NEt6M2d0ZllEanpucDFjVUdTbXJLZ0tFUnhnRHFFY0NlQWtT?=
 =?utf-8?B?SmhobXl0Mnd3NlpvQ3BacnhhNFhneEZFSEdOaHNNZW91N0l3MVdwOFRvektH?=
 =?utf-8?B?YkpWYmxPbTJyVjc3UXJ6QVRtK2ljNzNaT2RuQ3RIU09pTlRyd1k4YVBUVm0z?=
 =?utf-8?B?K3pyNzlFOWV2dEZ3SmpyQUFIZDJTTUtSVHRhdmZJY240R08vV1crQ1lvUFp4?=
 =?utf-8?B?MEZMNlI1NTlFVzhaRmRSN0xZYmJBZHkzVHhtQnhmbUg0UnAyTU1TVkNFZjhl?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9xU8OAlKTJJBSafKK8cfbvSTbcvcl/fA84X2hsBK/VycPcesknXWi84Cn7umYwNoBWh+IMFV25Jk2LJoz6O+LtPlJXBQnXuOBWtpZFpnyFnZ2bNKbWEW6CfPaiCa3pzIXTkEo0CcGgSBIfH2yiItgtlHv/6xUYcQhV6NmUvkkwWeD9yoD3iPMSU7fBfX3Wy4iHJeJws+TFGH4r/tLxyNhNiUPX7whAj/FpqllqCoGPS+JUqMN3xvgyhWrJRHgG4dBkEOwmEyrodv5pTCfVaeRIRkgJk5XgVNvadE7yCZGZhzqgGXNTGqNXJ6PO2S2GZHn0SGQEym+78+AehfgPkXTYB/sAJt2jkrhhYLgm0sO+/pga2Ng5m6bRejr/D9MmKrVZHm8wQHvjz9eu1CmEFcf4dwB8ScdeqzxqJtN5aP7vH46OS+vGjfvb02999hB3Eh+/VS8aT1gW1xb6BJuMA7c6aqHXUj88ZmkSDCIhyQ0B07a4Q+aJB6GpKjS8yij5KtfJp1DonDMYtaa/xE/Kaa3a6W4juFoYEpFDuBCYqGPtl4jyJdDeoNsS0ri48585SKmAu5US8NwRn8Y1SVHsM7t+juAe9MtQM7OVmON4SiLIA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc4e0cb-1663-4399-d97d-08dc32030654
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 10:59:35.4400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHVlsVw/H9fDQe+Taz/dLtBNjJyA/OkQBCjwlPCeG/zvmWjixuAMd3/V31aXMQbQ/x5KinkCSLykcbnbjh3n7tJnCXwfw+USXfKf6ZkNJ3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4806
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402200078
X-Proofpoint-GUID: gcMmTeOFR8LkXHmTsHL9teUGemgA6z-l
X-Proofpoint-ORIG-GUID: gcMmTeOFR8LkXHmTsHL9teUGemgA6z-l
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 19/02/2024 09:30, Avihai Horon wrote:
> Hi Joao,
> 
> On 12/02/2024 15:56, Joao Martins wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> ioctl(iommufd, IOMMU_HWPT_GET_DIRTY_BITMAP, arg) is the UAPI
>> that fetches the bitmap that tells what was dirty in an IOVA
>> range.
>>
>> A single bitmap is allocated and used across all the hwpts
>> sharing an IOAS which is then used in log_sync() to set Qemu
>> global bitmaps.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>   backends/iommufd.c       | 24 ++++++++++++++++++++++++
>>   backends/trace-events    |  1 +
>>   hw/vfio/iommufd.c        | 30 ++++++++++++++++++++++++++++++
>>   include/sysemu/iommufd.h |  3 +++
>>   4 files changed, 58 insertions(+)
>>
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index 954de61c2da0..dd676d493c37 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -259,6 +259,30 @@ int iommufd_backend_set_dirty_tracking(IOMMUFDBackend
>> *be, uint32_t hwpt_id,
>>       return !ret ? 0 : -errno;
>>   }
>>
>> +int iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
>> +                                     uint64_t iova, ram_addr_t size,
>> +                                     uint64_t page_size, uint64_t *data)
>> +{
>> +    int ret;
>> +    struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap = {
>> +        .size = sizeof(get_dirty_bitmap),
>> +        .hwpt_id = hwpt_id,
>> +        .iova = iova, .length = size,
>> +        .page_size = page_size, .data = (uintptr_t)data,
> 
> Member per line for readability?
> 

Yeap

>> +    };
>> +
>> +    ret = ioctl(be->fd, IOMMU_HWPT_GET_DIRTY_BITMAP, &get_dirty_bitmap);
>> +    trace_iommufd_backend_get_dirty_bitmap(be->fd, hwpt_id, iova, size,
>> +                                           page_size, ret);
>> +    if (ret) {
>> +        error_report("IOMMU_HWPT_GET_DIRTY_BITMAP (iova: 0x%"PRIx64
>> +                     " size: 0x%"PRIx64") failed: %s", iova,
>> +                     size, strerror(errno));
>> +    }
>> +
>> +    return !ret ? 0 : -errno;
>> +}
>> +
>>   static const TypeInfo iommufd_backend_info = {
>>       .name = TYPE_IOMMUFD_BACKEND,
>>       .parent = TYPE_OBJECT,
>> diff --git a/backends/trace-events b/backends/trace-events
>> index feba2baca5f7..11a27cb114b6 100644
>> --- a/backends/trace-events
>> +++ b/backends/trace-events
>> @@ -17,3 +17,4 @@ iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id,
>> uint32_t pt_id, uint32_
>>   iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas, int ret) " iommufd=%d
>> ioas=%d (%d)"
>>   iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d
>> id=%d (%d)"
>>   iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int
>> ret) " iommufd=%d hwpt=%d enable=%d (%d)"
>> +iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t
>> iova, uint64_t size, uint64_t page_size, int ret) " iommufd=%d hwpt=%d
>> iova=0x%"PRIx64" size=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
> 
> s/hwpt=%d/hwpt=%u
> 
/me nods

>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 361e659288fd..79b13bd262cc 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -25,6 +25,7 @@
>>   #include "qemu/cutils.h"
>>   #include "qemu/chardev_open.h"
>>   #include "pci.h"
>> +#include "exec/ram_addr.h"
>>   #include "migration/migration.h"
>>
>>   static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>> @@ -142,6 +143,34 @@ err:
>>       return ret;
>>   }
>>
>> +static int iommufd_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>> +                                      VFIOBitmap *vbmap, uint64_t iova,
>> +                                      uint64_t size)
>> +{
>> +    VFIOIOMMUFDContainer *container = container_of(bcontainer,
>> +                                                   VFIOIOMMUFDContainer,
>> +                                                   bcontainer);
>> +    int ret;
>> +    VFIOIOASHwpt *hwpt;
>> +    unsigned long page_size;
>> +
>> +    if (!bcontainer->dirty_pages_supported) {
> 
> Do we need this check?
> IIUC, if we got to iommufd_query_dirty_bitmap(), it means
> bcontainer->dirty_pages_supported is already true.
> 

Not quite. Look again at vfio_get_dirty_bitmap(); furthermore
vfio_container_query_dirty_bitmap() doesn't check for dirty_pages_supported.

I guess this check should be better placed into container-base class rather than
here.

> Thanks.
> 
>> +        return 0;
>> +    }
>> +
>> +    page_size = qemu_real_host_page_size();
>> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>> +        ret = iommufd_backend_get_dirty_bitmap(container->be, hwpt->hwpt_id,
>> +                                               iova, size, page_size,
>> +                                               vbmap->bitmap);
>> +        if (ret) {
>> +            break;
>> +        }
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>>   static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
>>   {
>>       long int ret = -ENOTTY;
>> @@ -765,6 +794,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass
>> *klass, void *data)
>>       vioc->pci_hot_reset = iommufd_cdev_pci_hot_reset;
>>       vioc->host_iommu_device_init = vfio_cdev_host_iommu_device_init;
>>       vioc->set_dirty_page_tracking = iommufd_set_dirty_page_tracking;
>> +    vioc->query_dirty_bitmap = iommufd_query_dirty_bitmap;
>>   };
>>
>>   static const TypeInfo types[] = {
>> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
>> index 562c189dd92c..ba19b7ea4c19 100644
>> --- a/include/sysemu/iommufd.h
>> +++ b/include/sysemu/iommufd.h
>> @@ -55,5 +55,8 @@ int iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id,
>>                                  void *data_ptr, uint32_t *out_hwpt);
>>   int iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
>>                                          bool start);
>> +int iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
>> +                                     uint64_t iova, ram_addr_t size,
>> +                                     uint64_t page_size, uint64_t *data);
>>
>>   #endif
>> -- 
>> 2.39.3
>>


