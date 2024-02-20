Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F04C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 13:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcQ0d-0007fz-AF; Tue, 20 Feb 2024 08:18:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rcQ0b-0007eJ-Vt
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 08:18:06 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1rcQ0Z-0007Sk-BA
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 08:18:05 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41K8wuhX001739; Tue, 20 Feb 2024 13:17:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=l8hlrECKb2uxAwPcgIbrDOmle2SrxrPD0gqIHq/ix00=;
 b=Uwcd2XJZnX3ePzsGzwhr5uCwhsnPytYt0gWYRsWVkPFPCseLO03DXAFp4MVJRCma7ar7
 BbhdgOEA73Z+MudQVLSNUcDgq+hkd2idBT5dme/rBJ7euY6jSqfPrCg8GIhAnRQbDFBs
 BoSFEtoyvjhFOy0HIJEhr9L8H+9g3RXbOlDYOVXf/wAvzyDGtAxTLzNY/uKsapcxy/nN
 BzYM2M33h2n0G/LkgsyInUa0d6Y+uLzlj3dRIZqY6eD9atqcZzdDJFyeg+ouryvlyITU
 5tRG0Co0WKvC+ZpY8H6LFa7hKXtZieMscYnXVmRcKs9KPsHpC/EaCDTLq5uNCaJCvOGK bA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakk3xrn7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Feb 2024 13:17:57 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41KBsGQk032772; Tue, 20 Feb 2024 13:17:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak877qn3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Feb 2024 13:17:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkQ0tfVtojFIzbmKs4GjfmZyDvBOppVRLp3A+QDH+bSUhrZ4t6/0SYDoIXMA6OedyyfA7mw6CMePjMLKvxqGV6g4WiJ/yRyAW03T1ZHZ13L3xYMkMglqP4KAOsVzgXDj/zKUx+I7RV3q0ZTYUmrwzwgCsjb5yKO7csfpuw90O7jWQUFLwA5LF3T6+1cU+ojUQ7P2mOTquraaI3e0vyP3wiI9zbC4AKaUgqhCs006fq9IrpVvNDJxTBWxrgHjYXqe68MyA3u8axWCBKpHEABfyBhx28PYmesu0FhtYu3rm+T5vuRuVYUOtd5QgpJllO3CjEmSQwFyyfPzRmJdHoYSGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8hlrECKb2uxAwPcgIbrDOmle2SrxrPD0gqIHq/ix00=;
 b=Jfa1xdJKtYhZCU6h8fB5bUUOQhSnJz5k85ey7RvwjfVG1qLQpaa1LmsxNmYvtOy12W78dq772Zy0W4oYAe+xfnFFrVyVY0Mih2rfXpuAkKiyt7NWn6/MCSYYznfgwyFzUcKlSFplXsMfpVvq3XGsUJXfXknybT2DPGci3Eg1zRrXSNSkxNGdriBODSGVsMi1zBP9in+HqSof6G6Rk7jkc/wdWw+Vd4tMrKDK+1I1ITTBNucDiFpstXJZ0ELsJEN/lQ8XQSz495fjG2nfrH5BcMDboy14poeFk2P2LmIkyiSe4raOJeyGWTHUHbhXrviHqYCH5ELNxxJtl5zTg7Ed5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8hlrECKb2uxAwPcgIbrDOmle2SrxrPD0gqIHq/ix00=;
 b=DrbLL4FDhsqV9lZQJLnBIk1mgxkazg8dWvTZBtgYtIsHu2YyQcfkG++vLrZ+QZtJfjgxVaGvc6nu0QDaQ0x5t6mMB8C6dNJhmv1c/NNP3SUVk/eOiMmMuvJny70EvNjqf7BiH8WJiHz8pwF4TgwuH9DtxqZpAb0Qy1fD/VpPZqk=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by BY5PR10MB4307.namprd10.prod.outlook.com (2603:10b6:a03:212::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.40; Tue, 20 Feb
 2024 13:17:54 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::3356:4cc1:701e:dde3%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 13:17:54 +0000
Message-ID: <587893f2-6343-448f-9786-18236f3e9e6d@oracle.com>
Date: Tue, 20 Feb 2024 13:17:47 +0000
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
 <096b9798-7534-41aa-ba3d-12f98c00c59f@oracle.com>
 <8bbe2964-f0f7-4845-bd58-76aeb8067f33@nvidia.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <8bbe2964-f0f7-4845-bd58-76aeb8067f33@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0679.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::12) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|BY5PR10MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: bd0f6641-4cf0-4d4f-653e-08dc3216591e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +jb2HDwkqen90X0OYmNnpQk7ds8eKTlnmL+6JGDOje5ggqOLHm4XvTKH9o+G63a8PvXGF4up0hnu77rXb7UAc5R2B19UJIMKl0WlIWxpygmt8RXbiCIu/Dl7NFMKZjcAEK/iZy8eHpSeEoG/w2u3YR9seqwG4iOARuUzavzwznps6WPMVVql4qTiiwhTA8kUJ7gfRR2inD2u4nFoA2RRO+L3xdJAmcKQ0xxhvpFsQPFpMtykQVcSP1J+s06H72YW4BXbk26QN2Br45KZX5BSDUhrXHmoo0h8hjI8ydN32j1vZ2zoOzSqoy8GHvPxhjOpVKHARygiSesHNQWUx7j1R+1LxPzVHUvlf600pyWVg+8pC0POHbHHBG1h4ImQhfAq3OdJ8Ja1ZImElEfWD0vXm/pLtw/EUD0mhTsLf0d+VS7jSD8e1XLkUggrl9qdkVGc7HJgx/sWjTZ+h9WP1YeXx/lpesNUS7ZH1OAoKmYG1L574rC6W02Rym53azh/JMp2+ZmSsfg/IK+AJSwWP9wyC4HcNYU0O4RHRmjtOkX//i55zJtey2E0VdSsAjEFIkf7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(230273577357003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEUvVm85and2TlA5TDB6cTRBeGpncDZ3dlU5dExNVWEyMFVHZkhqeDZXZVJC?=
 =?utf-8?B?a2lKay9mN1NuSjQrSkNtejQxbDJUSlZtcFRqTlYzQ2pUOTJ1Y21jaktveHUx?=
 =?utf-8?B?ZEZ5U0ZMakRqYUExMjRKKzR4VDRreUozcU5WOVV6dndOc2FubDhpMnU5MTMw?=
 =?utf-8?B?Y3hLdzQyMEx5cDR1MXVxM3pwOFlVZ1kxdmVBcW9lTk5vcEsydkZOdHZHakxz?=
 =?utf-8?B?MldjdFBwLzVSZkd2a3Z2Nk1CbklIQzU1a0wrZ1F5RzFLSDFoallpQUY0TStJ?=
 =?utf-8?B?bVhnMHZHTkJRWExLZVN1OVRuOUt1VkFxbG9UdGI2eG1VcVpkVXh6aU1RdFNO?=
 =?utf-8?B?M1VmOENrUEgvNHhHU3hPQUJUbjJkelhYd1BPeUFqN3RvRWlQT2VPMklwd0Zj?=
 =?utf-8?B?VUZaeDlyRmhNWHZrSGdhaGxuUzZXZzFML0U1WWkrWnBmZTQwa1AvMi9Fb01p?=
 =?utf-8?B?OXhPUzBheFRBblBPY0MzL2xSYmN4anRuVWMzbmozaTEralo0RTlvcC9RQlQx?=
 =?utf-8?B?U3p6aGR2V25UVzFMMzVLVjl4a1puZ01lbjJQUFJIa0pXWnd6ZWx3Y21wa3Jh?=
 =?utf-8?B?MDJES1JjQ0p6RlpWdjdWSGlBa3duZkdiNnJCZFpHSnQ5MnR3TUgwUGdTZTlR?=
 =?utf-8?B?c2ltbXZVcXNCbjJXTW1vRy90QTlZOS9ucTdIWVJXazBJZ0wwcVBrZU94RVhV?=
 =?utf-8?B?VUo1Qld1OHZjU01PcU1Sc0grNzQvTjVKREt6MWY3VkFHbnd5ZmJPM0lwVzVz?=
 =?utf-8?B?TTRWOUNpNUk4TGVsQzBCbG1FSUVNVGZGdm1KQWJjdGk5bkVoMVZqV2pBa3dh?=
 =?utf-8?B?N0thZDZhN0pXZ29qRWxMQ084dW5tMThLdDAvOFhMM1phcTZldE9pUm41TzJh?=
 =?utf-8?B?S2E2cVQzQlZVOHpVWndBU044Q2VPWk9UTksrVlJaMGNLSXl6bnkyZGs1T1hX?=
 =?utf-8?B?c1RIbHEvaHNrblczajNxWW1TcVJEcUczNDF6TTFodHQ1M3JzWlloWDJLU1hx?=
 =?utf-8?B?b25QV1VaOHhuV1NEQkdoYXVuUTQyUkV3aGFzdVRIY3VkSUo0c3JEQ3JXelBh?=
 =?utf-8?B?anpoYUpNQkxITEFMa2Q2THJBZldlZFNFZlhQMFh2SkFJaSsvWFFOeFB2cHAz?=
 =?utf-8?B?M01JN0RaNk1pZHlmWHNjaEYvQkVTdHJRS1owOEw0aHRoUzl3dFkreHJRdXJs?=
 =?utf-8?B?Q1lncDh3Z1lXZVFXYUhVYUJIck1MamlsQnFyNkJuNkRkc0tUY3pnQWwxLzQ4?=
 =?utf-8?B?OVFSdzNBOFEvZ25jczBTN09zRWs5eTBlcUVWbFNtb2ZLRUZmUEh1Sm0yVkpv?=
 =?utf-8?B?eEFIMFEyQVZOYmdSc1Ird2t1Mlh1Y3dtQ25yQmdMOUtyVElqNUc4SEhFTk1j?=
 =?utf-8?B?RzZJR0swSUpQdG5XUmZtVktpL09rOGJtdkpXbFZHM01mSUlxNGx2WGlLajNW?=
 =?utf-8?B?Z3NMUjdRM1ZoU0NjbXVaNkViNVFORWYrT2Mwc3pOdnl5TXNSdG4xMHBXcFVL?=
 =?utf-8?B?SmlrR29TYk1GbXpvQmYxRXFRelFTRWFJMlpDOGxoMzhmb1lOZmQ4Y0YxUmZq?=
 =?utf-8?B?YzFMRkdyRWJ3QTRTbHZTVzEvQUV3Sm5LTnk0cGo3SGNjQ0crREpQVHZBKytw?=
 =?utf-8?B?K0JNMVg1UWpsNXNHcG5BblRaUkp3ZFlYdEdESFVId1ZQb0x4MkFJOXc5U1Ru?=
 =?utf-8?B?QTVGTGFESUt3WDFKbWdXZVlOSW8zZ2ljZy9jWUNBck9DMHNQTW0zVHZidmRC?=
 =?utf-8?B?NXNWcENqa3QyY1JUQWpSNi9UbE85R2NBc1h1T1lUZVB2bldiUUZua0VlWDY3?=
 =?utf-8?B?MkthZkZUNzVrNnFkWDJXV1RNV0RNeUprSFM4eExWZkFaZVM4OHp0L3k1Rmo3?=
 =?utf-8?B?d1h6aG1zRzhVM2lJYnh0MWdzS0pKMmxkZDlEejdXcUhuc0ZlL3VmQS9BeGxY?=
 =?utf-8?B?bEhCVFAzaTFmb240cWpHak9XbnBKWlUycGUrNFZtby82Y0ZSL1AyZmh1aVVm?=
 =?utf-8?B?MzJQUXBER2E5bjJQd2RtM3drRUg3akptb0YzOGNwTVpJQzBFY2o2QU4xT3E3?=
 =?utf-8?B?TnZaR2ZLY3VLWG91V2cvWng1a3lXcEJXTjRZNVRzL0U0ZXJQSksvSEVUalpw?=
 =?utf-8?B?V2Y0THFQMjZJWFlSdE1lMEtINEJLdjQ3YS9HdEJUc0dwOW1jVkJxT05KWTBM?=
 =?utf-8?B?MVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rAaQupjZxwX9dur5LBuR4z9Sam0qjRRC79uH3RzXeskLsN4SOPvCADiUTunIjdXC4QZ1oZkV+UI9GlaaBimYIT3fTOxiEPxdZ8ujCvcEugX3KjYkmoKxeTufcmFaGKtiByeOqhmAewbo0HCD3NqZPfQJvSUDc2LnPu3E7lGRlDVW+92NAl8isrYzZxd2icbduZHQNk/KfgMMTF5UL2+1vUhU4mAALHRTP7buLW6s7svF8hzhsNPhIpvEl1klohm2hD6Q+iCPK2GLF29Odx1grcjnUE60BwjuD1o7YmasJ8Ddc1KqbjaD6SjjTX9ro5NUJyjAtrUue19ZKwN5ObkicH3WG3m85+U9SevBmSbfnUJ7Xqo4E1llArBrppubEYHhio6oQqu2uCgTxj94/J/R/dELpG1PATZRwRYbajC0JcDxqVGCn22STYOAVBiTAP0Y0wvROR7tMy9QhOQ2vqUvpxMIkHzaYT62Ei1UZ5gWZ6ygw79QYGb7jjpLflfHAXSXa2Wyytx9yzq5SMez6Bf5NjWvZCXHIWemETHssoWWlQyY69ySxjauX/K1dWuDEoqczeerqutpEGdKHrDqE/NMuJa7eAWhani4PYxq03Ok9ho=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0f6641-4cf0-4d4f-653e-08dc3216591e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 13:17:54.8176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4FXk5q/+tmaCTlF43lkXo06dq2dpESP2ODcFrgJwx//Wp/SQyciMSkwj4sPLE9VZCYuLNzabtKFhmXi9nu8IiDoWIe6eyZnRkOlfb+y0Fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4307
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402200095
X-Proofpoint-ORIG-GUID: 3_A1ztL7tZe8xHC3y85xSQpx_vwHERQw
X-Proofpoint-GUID: 3_A1ztL7tZe8xHC3y85xSQpx_vwHERQw
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 20/02/2024 12:52, Avihai Horon wrote:
> 
> On 20/02/2024 12:59, Joao Martins wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 19/02/2024 09:30, Avihai Horon wrote:
>>> Hi Joao,
>>>
>>> On 12/02/2024 15:56, Joao Martins wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> ioctl(iommufd, IOMMU_HWPT_GET_DIRTY_BITMAP, arg) is the UAPI
>>>> that fetches the bitmap that tells what was dirty in an IOVA
>>>> range.
>>>>
>>>> A single bitmap is allocated and used across all the hwpts
>>>> sharing an IOAS which is then used in log_sync() to set Qemu
>>>> global bitmaps.
>>>>
>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>> ---
>>>>    backends/iommufd.c       | 24 ++++++++++++++++++++++++
>>>>    backends/trace-events    |  1 +
>>>>    hw/vfio/iommufd.c        | 30 ++++++++++++++++++++++++++++++
>>>>    include/sysemu/iommufd.h |  3 +++
>>>>    4 files changed, 58 insertions(+)
>>>>
>>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>>> index 954de61c2da0..dd676d493c37 100644
>>>> --- a/backends/iommufd.c
>>>> +++ b/backends/iommufd.c
>>>> @@ -259,6 +259,30 @@ int iommufd_backend_set_dirty_tracking(IOMMUFDBackend
>>>> *be, uint32_t hwpt_id,
>>>>        return !ret ? 0 : -errno;
>>>>    }
>>>>
>>>> +int iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
>>>> +                                     uint64_t iova, ram_addr_t size,
>>>> +                                     uint64_t page_size, uint64_t *data)
>>>> +{
>>>> +    int ret;
>>>> +    struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap = {
>>>> +        .size = sizeof(get_dirty_bitmap),
>>>> +        .hwpt_id = hwpt_id,
>>>> +        .iova = iova, .length = size,
>>>> +        .page_size = page_size, .data = (uintptr_t)data,
>>> Member per line for readability?
>>>
>> Yeap
>>
>>>> +    };
>>>> +
>>>> +    ret = ioctl(be->fd, IOMMU_HWPT_GET_DIRTY_BITMAP, &get_dirty_bitmap);
>>>> +    trace_iommufd_backend_get_dirty_bitmap(be->fd, hwpt_id, iova, size,
>>>> +                                           page_size, ret);
>>>> +    if (ret) {
>>>> +        error_report("IOMMU_HWPT_GET_DIRTY_BITMAP (iova: 0x%"PRIx64
>>>> +                     " size: 0x%"PRIx64") failed: %s", iova,
>>>> +                     size, strerror(errno));
>>>> +    }
>>>> +
>>>> +    return !ret ? 0 : -errno;
>>>> +}
>>>> +
>>>>    static const TypeInfo iommufd_backend_info = {
>>>>        .name = TYPE_IOMMUFD_BACKEND,
>>>>        .parent = TYPE_OBJECT,
>>>> diff --git a/backends/trace-events b/backends/trace-events
>>>> index feba2baca5f7..11a27cb114b6 100644
>>>> --- a/backends/trace-events
>>>> +++ b/backends/trace-events
>>>> @@ -17,3 +17,4 @@ iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id,
>>>> uint32_t pt_id, uint32_
>>>>    iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas, int ret) " iommufd=%d
>>>> ioas=%d (%d)"
>>>>    iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d
>>>> id=%d (%d)"
>>>>    iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int
>>>> ret) " iommufd=%d hwpt=%d enable=%d (%d)"
>>>> +iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t
>>>> iova, uint64_t size, uint64_t page_size, int ret) " iommufd=%d hwpt=%d
>>>> iova=0x%"PRIx64" size=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
>>> s/hwpt=%d/hwpt=%u
>>>
>> /me nods
>>
>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>> index 361e659288fd..79b13bd262cc 100644
>>>> --- a/hw/vfio/iommufd.c
>>>> +++ b/hw/vfio/iommufd.c
>>>> @@ -25,6 +25,7 @@
>>>>    #include "qemu/cutils.h"
>>>>    #include "qemu/chardev_open.h"
>>>>    #include "pci.h"
>>>> +#include "exec/ram_addr.h"
>>>>    #include "migration/migration.h"
>>>>
>>>>    static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr
>>>> iova,
>>>> @@ -142,6 +143,34 @@ err:
>>>>        return ret;
>>>>    }
>>>>
>>>> +static int iommufd_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>>>> +                                      VFIOBitmap *vbmap, uint64_t iova,
>>>> +                                      uint64_t size)
>>>> +{
>>>> +    VFIOIOMMUFDContainer *container = container_of(bcontainer,
>>>> +                                                   VFIOIOMMUFDContainer,
>>>> +                                                   bcontainer);
>>>> +    int ret;
>>>> +    VFIOIOASHwpt *hwpt;
>>>> +    unsigned long page_size;
>>>> +
>>>> +    if (!bcontainer->dirty_pages_supported) {
>>> Do we need this check?
>>> IIUC, if we got to iommufd_query_dirty_bitmap(), it means
>>> bcontainer->dirty_pages_supported is already true.
>>>
>> Not quite. Look again at vfio_get_dirty_bitmap(); furthermore
>> vfio_container_query_dirty_bitmap() doesn't check for dirty_pages_supported.
> 
> vfio_get_dirty_bitmap() has this check at the beginning:
> 
> if (!bcontainer->dirty_pages_supported && !all_device_dirty_tracking) {
>     cpu_physical_memory_set_dirty_range(ram_addr, size,
>                                         tcg_enabled() ? DIRTY_CLIENTS_ALL :
>                                         DIRTY_CLIENTS_NOCODE);
>     return 0;
> }
> 
> So if bcontainer->dirty_pages_supported is false we will mark all dirty and
> return (and not call vfio_container_query_dirty_bitmap()).
> 
> Or am I missing something?
> 

Nah, I just lacked coffee.

You're right, while I read that check there, I misread what
vfio_devices_all_device_dirty_tracking() returns. And if that returns false it
means we need IOMMU dirty tracking and it was already tested false, otherwise
device dirty tracking is used instead.

	Joao

