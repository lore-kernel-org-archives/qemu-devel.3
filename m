Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60BDC021A4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 20:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj25X-0008VT-Ko; Fri, 14 Feb 2025 15:15:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tj25U-0008Ub-Tv
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:15:00 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tj25S-0008OM-OU
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:15:00 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EGBYrQ007111;
 Fri, 14 Feb 2025 20:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=vYZtUfes7s0kXmCgXfCdnEdqTHaPgMQ+ne0srugB9YA=; b=
 ETBciJ/xqPWViwfxZB3/V21Rag4cWs+yWm4/Tpy3RekVJ8J8/UNYG8afo88FDsw1
 qSqLcGsEoOnpU5xiUjebTmY6vILEbYA4royOsmdTOw2vSGjYMe7uxVf9kRp45rgy
 KXwjkN/8dDB72SVshYbK5RkQ1mvlLreRvrmVLAtdcNMxQAdBla/Q04W79102p9bO
 RHZmyYlYPOVRhJTn8cgt8EpRgkzPVdFanXHQYXm4g/BtRjdbq22wriW4p0N5Gk7t
 BWKjFoSiuUhMrZ06P+uoSxV/Od/eq4wvCqTW6ZUNIIeZ9FjBAsx27jim9snrlRP7
 jrzrmwrQOuPUaATMP2bYaA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tgchxv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 20:14:55 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51EJUWO8033902; Fri, 14 Feb 2025 20:14:55 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44p6341v56-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 20:14:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGl0y4h6PN7E1K+UCZq300tG0tb5a3jHUDAPezNGH9TzDEXOC8yLRVT2Twoob+Jl9IRBsILRgGBdEPp+yhHHdExa6nlrgXYuTQ81aHrC20K4FNbo2lItaHOhZ6wEtFwlYh+IiqmCDyZ3enFey2yTE1y3phQs/szNVlzc6lyOVLdAdIv4XM8Qz5dlRAuY8FItj2/lqXOrVmU6HTsBovzGRgxiY1gYwhqKBla6ZwWAn1vHe150WNYHfC8kZ1zBfa8NZ/ytRt3ElJxAiXe6Oftl3u/E/p7rw1tthDrDbvKWW4y0ob9mzkrjnqna6imq9mrdTawDLkM2wKCQssRmNGA9tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYZtUfes7s0kXmCgXfCdnEdqTHaPgMQ+ne0srugB9YA=;
 b=B55trKtp93RoGMvVy6YlWFFeKzllT3CmNEFNS9HXRL3UWO3WAHLlMGwSZLXTzIxSHhFzrpnLlR05wDMztjpafpQZJYij4v8FbSTibYSNWqtiNzTQ7UOvGS0LcQO5LvFXQVhlAyn8mvCgN1r4VDL0eyF6J1DWbi6zroALG7svsmHrEM1GaDbINMpAJJyE0zTqEz12nX1NVshU9gEb9ODTJZmKj9yFklnwVzp4i+clkOhKh/hr95zBmOOdMWusfLCxK+I43HBFtDHMtZX1aDersQwF2Rs7EfuL+DXnIrhJ/6imIcpVUNyopHhXh90mCejTwFwdr3l+HNdoOUN6Fu0Rhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYZtUfes7s0kXmCgXfCdnEdqTHaPgMQ+ne0srugB9YA=;
 b=bpf5hhFWHt0JzQ2P7/ca0NdK8QbmywdnJ+OGrgtvUwmqBy7AOkecTBv4ULfhEtIuoe84VA2er+P8RM4iwqsTfu6B39EXS7WdIZT0WiWumzxfBGaBDwGyxMSDI7tMJbRji6z8b+TdJv2scp0cMtYt/Wsc17LTDGokkv58LbXu6jg=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DM3PR10MB7911.namprd10.prod.outlook.com (2603:10b6:0:1e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 20:14:51 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 20:14:51 +0000
Message-ID: <7824f145-7c39-4548-aea9-5f93d6d0ff2d@oracle.com>
Date: Fri, 14 Feb 2025 15:14:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 01/45] MAINTAINERS: Add reviewer for CPR
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
 <1739542467-226739-2-git-send-email-steven.sistare@oracle.com>
 <Z69ZBonqKbEh3ejA@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z69ZBonqKbEh3ejA@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0018.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::30) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DM3PR10MB7911:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ebd98e-a858-4500-6803-08dd4d343d1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Um1SanhxS2hyYzlrMDZPaTU3dW5nZXdaY2l6SjdhbkdLWE5QbzdSRisrMm5k?=
 =?utf-8?B?eWdtTnQ2dmRIN0diYWlIN2U2bmFhYVQwTVZtdWVMWWtLR2dDUXdFN0N5SWk1?=
 =?utf-8?B?ZW95YlFOdXcwZFloYkhINldXcGNNOUt5Vm5yQnRXeFNidkxUY1NiUzl6Vkx4?=
 =?utf-8?B?YlJzd3ZUak1PanZjUHh0cUQ3dTZMM3VBNU1nV1YxV1pRUHdFOS9aZ1NEWGFE?=
 =?utf-8?B?UTFTRnk0L3pKc1VST3h4R1JZL2VsUUtYOW81UmVEZjlzS2ZCSWFLeE1UcEJq?=
 =?utf-8?B?OTF6alhNUXlPUm9zRXpLa0wvYnpaMjRpUElTbThNbVVMa1RUajBncklCRnky?=
 =?utf-8?B?YVZodjhBUGdYQXBCZEZaRi9xQmxHM1gyT1dOcGF2amNtOUFiTjVRdWxzTnJN?=
 =?utf-8?B?R1FTeXN0TXgyampRZFYxQ0psRWltUmg4MlBwVlNmYmZYZ2Ixa0wrSll5YXJK?=
 =?utf-8?B?VjlWTzRRTmpSK2ZnQW5nWmJjdmRoSVJWaFk2S1dRSmIvUVBKVlp6bHNrWjVF?=
 =?utf-8?B?MTZHY3NTN0dJU0xlQVV4Und4S0lMNEJhSkZpRzZkaEZod1p6bURqemI5NUha?=
 =?utf-8?B?djBwUEVORUtjZ09qRi9GYjEwQ3JSS2pjc2dTWUF6dGFJQlRoQnJqMDZMRkFi?=
 =?utf-8?B?QkpzVjZZb0xURWQ0Kzd0OUtzL2dFcDF0dVhGdkN3YWtIY29kRXdZVHZJMzhz?=
 =?utf-8?B?VEJ2MGZER21VVHhaSXVvVEY4c0lSRURVSDRhOUpqVktPNHVpWERlY0k3QUps?=
 =?utf-8?B?VEthQUx2RDFuVHJxR3V5YUpTb0xpUUNpNlpMNVlGZENJY0IxQkJEK05MUlMw?=
 =?utf-8?B?TkY2YmJrNkZNYWlTZHZYa2JMVHJFekdsd0gvMk80NkhQREZzNS9LN284VVhB?=
 =?utf-8?B?TDZNeGloV09rdkRFbjkvUm1XN1FvdHlveGd4ZW9CbjkrV1pXUmdQN3Z1N25K?=
 =?utf-8?B?VkNBU0U4Q1VrekNJRytBUTVWd2tSbFVYMHJFbUFjaUhZR1ZzcE9YMWplbHhR?=
 =?utf-8?B?OEpjT2hFVEpyWjBTTXQ3aWN4c2c3ZDQ1aEppVEV6STJWRktzQ29VMnJjeTMy?=
 =?utf-8?B?aGQrb0o2MHJKOWE5Wnd5L2dkVlplMkcvdlRyU0pJelFha1puK3A5ZmRNVGty?=
 =?utf-8?B?enl5cmd1dmJheTJ3RFRST1FMWm5reEJpd3lrTnR3aS9JZWVKUytKcFpPRTVN?=
 =?utf-8?B?eUpLc1VCUnFGbmR2SXlabkZTMUNONExLaFFFUG55VW0yKzdab1NQRWhrSThz?=
 =?utf-8?B?RmEzUFY1UTFlOVRIcjZWYWN6N0l2WTN1dmFNdGFTNWhOZ3RCc01RVkVFMFJs?=
 =?utf-8?B?aHkrYVYxdllVQmF6bk81L1ViU3pkVk1Qa2YrNHlLbm93NkF4TEVvVDU5WU5w?=
 =?utf-8?B?Y2RKOUlQb3RCNmhjb04xTkFUQXZMUnZuMHRGc2liRFo0TENyRG9iRUtpMkc5?=
 =?utf-8?B?dFMzSjJYVlQra3N3aVJhd1BoRkJEcjBTaFNGQWkxT2lmOWt1dWtMTHpkM0VX?=
 =?utf-8?B?WEFkOEozMDhzYmRJNkxxR3VzV3hMZ1RyZkQ5VTR2blRBM3RQTGJUUzB4S3VZ?=
 =?utf-8?B?NEdubDVTMWV5RGpJWDZtTmsxOHdaSHIzTUZuNDFTZWlSa2xwaVlYYWNGSTdH?=
 =?utf-8?B?NzIrM2I2eTNpSGx3WDgrMjFZV3dwaUJlUE5GdUQ1bSs1TlV5RTlRUFpJcDZ2?=
 =?utf-8?B?ckV5WktlSE1wR0ozZzliY2ZRK2RRT2pVV0hFNVJNV3JGTjFUdkNJeHcxdUEv?=
 =?utf-8?B?UGFzQndwaGJhZjcrZ1o5ZnhML2VtOENHQm4xTDlRUkJKbzF6V1dIZkdqRE1M?=
 =?utf-8?B?YUZYdnE3SzR2MUVUSVNpQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akFlZko5ZlFIcFpYOCt5bzZuYzRvR3RRMnN5QXRZQnRpMlI2b3pGOU42aGY2?=
 =?utf-8?B?SGhFWmpVakZ0OTlaMVlYWHBrb1dUT0xBbDNSZEhsNncwN2dBVERGYWNDK3Vj?=
 =?utf-8?B?Wmg0SjYyYnQzSE5TS2RWaEcxVTNtTmNQM20zUE43QTMrZUZHRDdxYWkySzRY?=
 =?utf-8?B?VUUweHdaTjRqN1lyZmVpeUdYRmUvd0RySG5sdGhPQzAxQTFLajhYZ2RlM3Ar?=
 =?utf-8?B?cFJLMTBFTk5xZkpsR0RSQ1g2dUtlak5KUHB3ZGdXQ1l4QUtlQXZSQUd4ZkJR?=
 =?utf-8?B?UmxnekhrRVh6ZVZMUGlXcGpMQmRVam45NGhpVTR0aFBXV055eU9Nc2puS0hK?=
 =?utf-8?B?NlMwc3ZXRHJxRnRNa2V6UkhGS2JBL01hUzk2bkFwOFBEODhVYUZ1V1hXQ0M0?=
 =?utf-8?B?WWpobW93YnZpZTI3SHpEb3kwdy9abEFLSE43a3N6dnE4QkpEMm5OVTdPaGVj?=
 =?utf-8?B?R3hmNFpyKzVSYXoydVQ3UVgya1dreDVLNU1Kc2ZwQXcwSlMvMVkwVGJqdzUx?=
 =?utf-8?B?NWVSYjJIT2tYOTUwZDI5U3BxZDFlSWxEM2wzNGk2a0JEeVlqT25qb3B0WlNS?=
 =?utf-8?B?ZkNZU1VTaENTV2xnTmk5aFVMN0RSVmZyL0FnSFd1TGNMcFA2RU41cHJMYWdD?=
 =?utf-8?B?ZGdXRGNqL0NrYmFQcDIwdlNWOHdsZWpwUmRPSjdycnhhU29RWDNiNEYxS0N2?=
 =?utf-8?B?WHlIcHhyWUtpNDZXZG5LdG5oL2ZOQ0tqbzFubHVSbXc0QSs1T2duUGMwaDJ0?=
 =?utf-8?B?UG9COUZzODdiS1pNbmFycHB0OVN6VFRyc2s4ZEZkWUx0R2F1c2ZYa2hRenE1?=
 =?utf-8?B?dkVrVXc3Y3kvdjAzWXhzQ0dPNHpLMnQ0U1g2RmV5MTBEQ1ZzZUxyQURhSW1G?=
 =?utf-8?B?SVZ1dFpEbVZsL2ptNnB3VjhrdlNvU2t5UGY5ckMzMHVzTlhKVndmN0VnSXha?=
 =?utf-8?B?V2ZoZ3BST2RLbHV4cTJvOG5XQ21DRGtoQm1hUEgxZUUzelN4cG54NTJEVHVK?=
 =?utf-8?B?MjZxOGJuZ1MrRkp4azZJcW5FOUtZVEJpSHB0bUsxSGNkUlhUVll0LzJ1WUlt?=
 =?utf-8?B?SFF5NnFCUThhRkIrMUx6Vi9VNU1XTm91ZmxiRnIwTStlUm9iUko4MG9RejJS?=
 =?utf-8?B?U05zWW0zTWsxNUVOOFBZZ3M4UkNtRmtzaWV2QVRwbFZpaXFycDgxOUt4OUNk?=
 =?utf-8?B?N2VIMnV1NzlhVkxDYmw4ZFdUNGpMUWZIMlUrMFdndTN1OG1sRnY2bjhYY1Bn?=
 =?utf-8?B?YmhPR2gvaGFrV2ViSHY0NGxtS2c1QmU3b3JwUStNQUs0VWN2WW1QVU9jK21n?=
 =?utf-8?B?dnlvYzlnUHprTXpjV3hmbUZvWlZHeVFyd0hkSGRxUy9CalFYOXEvWTFOWC9B?=
 =?utf-8?B?ZzdnSDJXcFo1bHZZVlpUVWEycW9kb1djSzVrUEFib2xTbVRNaFVrL2dPakFk?=
 =?utf-8?B?VnlDK29XRk9Vb21WTG1GNnBSTmZQTGxGTU55N1h3YWZWRVlnS2RkT0I5OU5w?=
 =?utf-8?B?TUxKQ3I4ZTZUNGJtS3Znd3ltdEgydnJEL21XdXNQTHh2czZWOUFXTTBCZmtl?=
 =?utf-8?B?Skhub1JLbXlLUGIrdmRONWNQQ2VpNHcyamNnYlIrQjRpdUF0MTF0Smo1SURi?=
 =?utf-8?B?UXU3UTRUOXNNdGV1QUw3azBnNW5ERjZDU2hoQjVLN3lSTDhHWEF3YitUeXhp?=
 =?utf-8?B?eTdwN1VlZWhDUE51QS82cUNFN2p1TFd0NlBLRVpTVTNkUjUyMndIbnI4TWdP?=
 =?utf-8?B?d0dwb1pIQ1FvWE5RcWc0c3FQSUxIaTR4VThva2p6eUprdG1KVXVOT0IvWVNx?=
 =?utf-8?B?TzRaQ2hTMi8xMVhCWDZsQlB6bEEzRTlXTFlENkZ5SktLekplQ3hnRjBncHNZ?=
 =?utf-8?B?aHFsTk5xa2JzWVVjTmlPQ0o1SlNobzQ4QnErdVFKWmJzdmVHb2hUcG9JdlNk?=
 =?utf-8?B?NVFOK00vVjFieldidENWOE1MQXJkSVhza2RGLzFCaWplRlY0STJpckE3eXhu?=
 =?utf-8?B?UkluNnlzcXJ1d0szT1NvQ0docWllKzJGSmJSc1hrMlVKeFB6OE9TMzJpUGpn?=
 =?utf-8?B?Sjl4aDd0QlJyM0xNdGMyMmt5VFhuZ1A1d2lsWlI3WXcwUFhCSWU2ZzJNY0t6?=
 =?utf-8?B?eDl5bGxCeXVIREtRdkhhcGtTVEdWSmlHMytQaS81NlVXakliWGh0UmtzbkJ1?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BCQsuyR9KKIprDlB7NdZ5P74KmYl1z8l2tbE5QtheAyo8D3N3tuwATy9rKNEc7/HbwueRlUPKYXYEbBIihMDoLzPBBTcFL3Y/gzLpmxSIZlII2NoroxvH52DP42q9WHBSwJy10NpB0sqcdxuBdaRSI5UnjpTr3/coZU8TG0UqmG6+9bGJobLYlXZNWfBxiGtXV5D/GBnY7reXCsfA6mK7z2UBLJybZwYTixScZWqZzVXmoafbyUHx9g5lZkLpnKaGojvVt3ke86FHltt5V8PcMbWo+bzIkKyrX3NYRXV6V2LYAHyFYBMlAHYZhzhibNAOjaNXS8VNZDtXd6dN//5Tz0cTMqjh06AgWYTK5rjT1oOREqYvzvF+vVxi/GIOWL4yiiA4jQUOudbjaVkWIe4v9VCJr5j959jNDNILxQYdAdAbrbqxB6YQrtzYao5eT0ZNQhtttAnT/lX4qOv5Qlbi0FcZNYCnwuHnvLnDUst+xvORWPmjw9mqoYc2xOweJK8Owvg/hrSuT4SyvVr0JYnCGCeDM7pl2cBWCugdkTbd36uL/egxq1i0qe2pBPGCMoaIezChX430eZseYuv3PccPk4Po7Iw2Zo1GIWqEiAowDs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ebd98e-a858-4500-6803-08dd4d343d1b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 20:14:51.6682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5YNZqkrz8nOAz71h7ll8/UiX4rrZADg3jTQvnVH7gtBW4Wl6bqN7sk49RMZmdMIlFdMfIg4ax68NgKpYsHIdXDNi26VGPApq/Ni2QiuYQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7911
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140138
X-Proofpoint-GUID: sDWW6Ny_N1oAkwn1CkjDTUWb34F0zSNf
X-Proofpoint-ORIG-GUID: sDWW6Ny_N1oAkwn1CkjDTUWb34F0zSNf
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On 2/14/2025 9:53 AM, Peter Xu wrote:
> On Fri, Feb 14, 2025 at 06:13:43AM -0800, Steve Sistare wrote:
>> CPR is integrated with live migration, and has the same maintainers.
>> But, add a CPR section to add a reviewer.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   MAINTAINERS | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3848d37..2f9a6da 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2951,6 +2951,17 @@ F: include/qemu/co-shared-resource.h
>>   T: git https://gitlab.com/jsnow/qemu.git jobs
>>   T: git https://gitlab.com/vsementsov/qemu.git block
>>   
>> +CheckPoint and Restart (CPR)
>> +M: Peter Xu <peterx@redhat.com>
>> +M: Fabiano Rosas <farosas@suse.de>
>> +R: Steve Sistare <steven.sistare@oracle.com>
>> +S: Supported
>> +F: hw/vfio/cpr*
>> +F: include/migration/cpr.h
>> +F: migration/cpr*
>> +F: tests/qtest/migration/cpr*
>> +F: docs/devel/migration/CPR.rst
> 
> All above files are covered by either migration or vfio.
> 
> If the plan is to have CPR being part of existing subsystems, IMHO we could
> drop the M: entries here but keep R: only.  Or, make one M: entry for
> yourself.
> 
> With that, IIUC anyone using get_maintainers.pl will always get the right
> people to copy: it goes to VFIO if it's under the 1st entry (hw/vfio/cpr*),
> or it goes to migration if it's the rest four entries.  Meanwhile, if any
> of above is touched you'll get copied too.

OK, I'll remove the M entries - steve

>> +
>>   Compute Express Link
>>   M: Jonathan Cameron <jonathan.cameron@huawei.com>
>>   R: Fan Ni <fan.ni@samsung.com>
>> -- 
>> 1.8.3.1
>>
> 


