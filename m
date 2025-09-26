Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2830CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 13:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v28LY-0008CI-Au; Fri, 26 Sep 2025 09:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v28LV-0008BU-Bd
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:18:45 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v28Kw-00044h-HJ
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:18:45 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QDHBsY028202;
 Fri, 26 Sep 2025 13:18:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=p69cq2Y5ZMINJD0qtiFp5zuaFis7FLEGRV7yroDELE4=; b=
 G2UviHyKma49EFEHG3Rrri65JUbYz3u6dzvx0fRgNwKoezU/C0zF42+xWlHNj1uf
 HxaIeULkCsJNXKW/a6nPYOB2gR+nnxJJLoDNxMrhSzttSi47TPrR0MhFuq5vgAK8
 gBlmlcp2iCRh4e4Dua9QHVM3WQiGKw6LfaYBqoIBlhUEjIHBHkdG3soPG6Mw4ZIj
 /ELzj5Pfl1uR19/1Ef1SA3u0qjAv3BRM9iRJzSQ0MoR4Nc85dLI0ZsDcTjGfP3Yg
 O7Uh0F+EuRvHZ+VDy3pdXvp7UDMybszK0Mmnn3FSBTxwefIj7L5pqwWLBtdTgbrj
 NR90Y6IKgAjYT2DDe4LvUg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49dud2r0tj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Sep 2025 13:18:01 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58QCDnYB010253; Fri, 26 Sep 2025 13:18:00 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013023.outbound.protection.outlook.com
 [40.93.196.23])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49dawkyp2f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Sep 2025 13:18:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMSG4UPpDk5sAMi0ZFfpUIOKu/iH2WhPT3BWtsnyysM4dXCQJj4g3QEcmaOqnfDPGS6+gi7iOlUaUEtHch/Zu0fhVNbWQ4fzBkvJ0BzA21eSGvLaHe52DxMcYClMQwQHiCb0q6tdt2rhopGP4XEyr3i5LiGMbXC2/L811SMM4pWS8xT6PukMIoybgeDCXsDD2XtQhufIXBfptDn6DzbMzEG5Vwyi/snzBr/yTo9RIe5seyfQOdUZZ6ULt5LNTL/QsqmGNoWWV6/1c9IDOGGkjmQwJeS4AhR3cQT33UtWGLXPOAd16GozE7rPx0DEDBjD84YObste9X4qu51tQG988A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p69cq2Y5ZMINJD0qtiFp5zuaFis7FLEGRV7yroDELE4=;
 b=DnyQvjNVrjaZJ1su7QsXHTtPLfKY3+xSJjt+nbEyLHDK4JUi6B1MAZnWN/XQkQedWXTxw6jF4ojOctpbZ7eoUDKGHZmFlA8qH3IpDnL9+PRpcMFK9+oJwkce48sW9UE4G68FfHgHWk0b2f0y9mu4vV+y3Yu5QcFRPOpIgM7fv2pTnix3quEt5gnHUoaOruQyprqgaeHflaGw+agAt3jdn7zPko8nJrfVgiqWk79dIrIcvXPdlgug9zvD1Jz7exLpFtwNhDZoHePYYOtLdBomdCKtvc1h0kLEOpdL256Y+bVP55Dag+RmlcNdbvrRa0GgXw4w4zfG4DMcALIbYyYYwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p69cq2Y5ZMINJD0qtiFp5zuaFis7FLEGRV7yroDELE4=;
 b=JPE3z/v7QlmLmG6szFWjXlpux6POb6Oozy930Um2Ua+DVw90Imv35Ph3NByTUv3kMcKHtWnnVpRH587K48s1irDr87QDLsTPUNIrNuqbE7cyKGPIYPcNi1mk/yZiC0IU0yCMenZwDDm9uAcZL1hDXufRIey2rh5Wxp5DxxoJmrQ=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA1PR10MB6898.namprd10.prod.outlook.com (2603:10b6:208:422::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Fri, 26 Sep
 2025 13:17:57 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9160.011; Fri, 26 Sep 2025
 13:17:57 +0000
Message-ID: <72aeaf62-cc9e-4ee1-a72f-145334b1aebb@oracle.com>
Date: Fri, 26 Sep 2025 09:17:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] accel/kvm: Fix SIGSEGV when execute "query-balloon"
 after CPR transfer
To: Markus Armbruster <armbru@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, clg@redhat.com,
 eric.auger@redhat.com
References: <20250926022540.1884023-1-zhenzhong.duan@intel.com>
 <87v7l5stsj.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87v7l5stsj.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0088.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::29) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA1PR10MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d8901a6-b419-4f7b-8d01-08ddfcff1c10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2FwR2tUYmZYZmQ2S055SW9jdTZITGhBajFjSDEvTExPZjBxQmx2OUhzYWVL?=
 =?utf-8?B?QnRkd2V1QTlpaW5seVRlT242V2R6M1U1VitXU0RtZWxMUU1hQVN2bVFQclk3?=
 =?utf-8?B?ZSs1RUZRUmZEd1psQ0pCV2EzSzkyOEw5MFV0MElZRjBjQWhhQzAxZGdWUHpk?=
 =?utf-8?B?c0FaYlBvcEdFekgxYWRDUktGaVA5b0RhL2krY3FWRHNIZ2lrOWp2V2VHZVp2?=
 =?utf-8?B?d2d2R1NHQVFkZ0cyYmdpTWg5cFRvTlZjVkpINml0SlE5akhZTFRERFB0M3M4?=
 =?utf-8?B?M3JLOFNpQ2lvY05pV3ZpZ3Q2ek52b292VXJyY2ZWcjRqTnh3QjFHS0ZmNEdw?=
 =?utf-8?B?eDhBdk9EQ25Hc2RpeERuKzFXaHBPVExoMGMveW9hRFpiNlY4WUdVZWprWWZ2?=
 =?utf-8?B?QWpNWWV6Z3AvZ0owbjBhMkpOVFdaUklTem1OVjFFdnhidkQveDk2WTQ5ZU80?=
 =?utf-8?B?MDJrZjVxTjVUczJJVVMzTjFtNHVRWFE1QVJJa1FIQmdVR3B4TVkzbGxJK0VI?=
 =?utf-8?B?bm11NkFmQmEzTTNYcmJZR2VTVzIzN1RueU9WVENoMHBHUTlka2N4V3hwS21o?=
 =?utf-8?B?dmJZRmJtY2tzUWt3ME8vdmlzbDNxZGNzUHk4dC9FTkVNMWJITmdjYmRKUjhs?=
 =?utf-8?B?U2ZhdEgvWjFlNmJQcXVWbisvZEg1VUFTLzc0RkNWRDVCZ1MxU2tiYUIyQ0tS?=
 =?utf-8?B?akFsWWdOZjdIRG1kSjc5L0JZRWIyQlFTbVdGMG5pNFBKb0F3TGtTQ0dGTnNx?=
 =?utf-8?B?RzNvbDh6U0JraWVyNXNRU05ZNnlLUkVNWWxnZitTSFdFZndEd2V1WmxBaGVP?=
 =?utf-8?B?ZFJQOGo2dGc1djdLL01QM1h1MWhHOTJqcVg3QTRXeUduU2p6L3Z0UVJmRk9H?=
 =?utf-8?B?eDhRcmQxRjFVMy9HajZwcEgwa0RpbFB1TkdPOGFVVmFGWlhUT2VkY25RY2lG?=
 =?utf-8?B?ZVJNSG1JZEM2NUQ0SG9JNlBRN3liS0NlRzFadS84WVFwcWx2YWFKMW5Kakd4?=
 =?utf-8?B?cDZ2NnhMSWR6bXIzS3lWTTd6ZnJZYm9iQWxJMkRjaTZjb0VpRWF0QXNCZ3Vx?=
 =?utf-8?B?THg3K1gxOUR3bGdMVHNEOEwzaDVYekVFUDFtbCtOM01EanM2QWlQTE16T3Bm?=
 =?utf-8?B?WEhwcFdXMy8wc1RTSWpnWmREay84UWFBSE8rZ1lpZVQ4cG5Rbms3cVB5UWtu?=
 =?utf-8?B?WU5ONmZaVXdJb0wreDNOV0xQQmxkelpOODlMbUlJSThVdStmL3M0akc3TEFh?=
 =?utf-8?B?T1NTMDErTGNNY0Yzdkc3TC9KV1gyZnpJZ2QrcHFyN3VrcW1aNzJQOTlZRDBj?=
 =?utf-8?B?aTM4WmNIbmkrKzVMOEZrWDZ5enlPTEdtbEd4UXpPdUNBTElBQm5HTXp5N2Z0?=
 =?utf-8?B?ZzJCTkFUZXJTTlRqUUtzQmtXLzdML295bSt6dkwwYW9VZWlqRG42YXhlaks5?=
 =?utf-8?B?U3lQNEY3MVlmYldOWTNtMGJQdXNxWWQ4ODRDQVNkd1VTYUdzNnBVYW5NdmQ3?=
 =?utf-8?B?cjRRaVUxbHlzT012T0NpTkhERDRtVTVuVUJsRE5VYndtRGttNnNmSGQvTElR?=
 =?utf-8?B?VTZicE54MWZuRWI1dEo1RlpJUkx0K3FrL21IbW1YQlczWUhiaGVtR2dKUlkv?=
 =?utf-8?B?dVdYSlM1WXJ4Q1Uyb2U2VTEyRWt4TVpzazMwQlJyMzdvWE82WlFESzlFOEJq?=
 =?utf-8?B?eHdPR1h5dnYxK0JhZFkydXR4K3dlb1dDZW1FWVo1TnBBTkRVMVQyWW1LMXpo?=
 =?utf-8?B?d2RNSG9iUjBsSm05OGFDSjUzVmc0ZkEzbHNiZHdvN05vTHpzSkZGcTU3SXZV?=
 =?utf-8?B?YTE4VTEwWmxCalFYU0U1Z1dLWGg4Ym15RVZoeWpFdWtlSDIySFZnMmMwZEEz?=
 =?utf-8?B?TG5zTUVBc24vYy81YnhPR09WSEhuTnordVZzQVZyOGJPdXdXRjd3UmlYcTVv?=
 =?utf-8?Q?ox33vhIj0EY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnZWZjB0RmxMM200N2tXWlBHOWVwWHhzSU11bW85cE1lZEJDWkdST2MycGw3?=
 =?utf-8?B?TmkraFN6YkMxcFNYVjd5cnVLWmJuQlBKY1MvS011Y0dIQkhSV3FqTFJwTUdh?=
 =?utf-8?B?TldadkxrQU9TeWFWdkNabW1FRm5URERiK2M4TGRzKzBQT3l2bVFMbS9qUFlk?=
 =?utf-8?B?dkJBSUt3L24xNXhYcWlCcVRvdHBaTlo1L0tuell2WDRQSVlJckZmdDRqVGZp?=
 =?utf-8?B?Z1hZQjV4R3pLQmFTeEpBazQ0MDRpYTIyK2VCSHF6cFMzNnB5eEtUMnNVcnlX?=
 =?utf-8?B?SGRVTlY2YXoxN0c1c01Ub0tvQy9oc0pwVDFHTGZ3VDV0SVdjWFRaYWxLZ3FU?=
 =?utf-8?B?cElrSUlFWXFZNWpiM0c1VXFWR3NwNEZ5MHNRTi8xblNnTUNWWGdYVzlBanhj?=
 =?utf-8?B?SG1RTUhneFlTY01Nd1pjN09EZ2dhMG9vcS8zdlNMbWRwMkEvMTE2cHUyL3RH?=
 =?utf-8?B?RHo3d2prQUMxc2xHY2VlR0NqWU8xMUk1TGdLRkR1WXhVQUR3L0tPREEyK3Mz?=
 =?utf-8?B?TzRmcW13OEh5VkFyUUhENkdKT1ZPK09CNGFwZzhRVjBFcmJ3eGxFYW5iWmRN?=
 =?utf-8?B?WVYybmRWWDZHZ2wrbXdveFJDTnJUV3czdnB0dWxOSW0zM1V0anE2Q3hwY1gx?=
 =?utf-8?B?THh0eUs2LzBoMmRFbmt5YVIvbGpWd3hUMXBrMWxIVzN4dEJ0NENaaFh5SUFJ?=
 =?utf-8?B?TWhFdzFNMDNZd09acTllWmRYUGNjS25VNTU4aU5yNUZYZ3BRdVUyRlllS3dn?=
 =?utf-8?B?NHZIcFlacmlWdTV6bEdvTVM3bHkrOUlTUnlwbjJBWjdKNmpJRG5ab20zRDVK?=
 =?utf-8?B?SFNBbnBnQVlWVitiYVVVaTU2bEhDOW05anVuMk84RldpQmFGSTV0NUViYThy?=
 =?utf-8?B?TFpVZ0JGcmJicy9HRnB1SHc2dFdOUGpqUXdYTVE1L3Fuckc4T2NWTXpvTVR2?=
 =?utf-8?B?VStjamI2czBJNWhTNWVjcHRZYUpOWFZSa25RMTJVK1gxK1NHMEFEcjZHU2Rw?=
 =?utf-8?B?anhMc0RXb1NQUGRTbFU0MEtiWjB1ZXZZc1prR1ZMSUFERkJ2NjU1NTJja2Zs?=
 =?utf-8?B?QzgvT2JqMVl1K2dkYlVYTktvQ1ljM1gwTStEQ2JrbGNzelpjayt6MjFUL2o1?=
 =?utf-8?B?OVl4Yk1wTG50cHdqTWh6a2I5ZDFKY3FEM0hsL2Z6ajkzZmNhb0NMTnlDK1BO?=
 =?utf-8?B?NGg2bDYrL2FjSXJiWkVJcDFkTUlDNzR2aVVjaVpCRzNWenpCNjEvWm9XSjhL?=
 =?utf-8?B?MHgvS3ZoeWVtWEgxSHV1V0duYjFIbUVFZ20wQ3hMT0tQNHAwakF2RXkrQlZ3?=
 =?utf-8?B?cmxLWkxPR1VGR1p2TUNIUWQrZDU2OXN1TWdxaDR4dVQvWUlSVzhTOWgrZTdI?=
 =?utf-8?B?a05RK1UvNVNmMGpVZkJYczJTWHcwSWpLaE9Ea0dmOGdYdllwTDc2cXlVNlk3?=
 =?utf-8?B?WEo5QWFBclBzQ2UvM0pma0wwZkpGZXc2UWRwUkxlb0M2UGh4T2w5bDlpeVdq?=
 =?utf-8?B?Q2d4RGVRTHlnSGEyMFlycWJPZytuOHptSXdBVmZiN0RUaWRkdE9xcGd3V3E4?=
 =?utf-8?B?Y1YwdjlNdTNsTE9qWmQvbEpmSHNXV1ROV0RMS0lUUUlWR1h1aGw4MWV5MVRB?=
 =?utf-8?B?Y0hnYnBhd1NFOG9icXBNb1JpN2RadjBCZW1PZ0E4MlNreHcrbUpaYzYrcWQ4?=
 =?utf-8?B?aDcwQ3FWNm85MnJpamlOdkxtNm1tZUtQRTRBVWpIaUlPQ3ovTmhENHY2ckpH?=
 =?utf-8?B?ZktPYjNBQyt2OGdXTU84eWZhZEtQbmFUa1ZxUENMbmhuUlAzQjgzSXVnVTA3?=
 =?utf-8?B?cG9MYnNDd052NlJxcElsd3dGNU9XQ1JQdDJ0cEtuMDBaQlBOQm5pN2xPOU1k?=
 =?utf-8?B?c1RBaGZrRGp4a296c3p3azRMTkxMczA0OGJqSzNQdUE0VnNiNjFoNU5sUFZ2?=
 =?utf-8?B?dG1nQ0JCVWNMV3kwR3l4d0h0T2NLRzAya2g2NUo1U0pmYmpRU0NNTlNDb1c2?=
 =?utf-8?B?WmNoT0NKL0k5dHlxVnB2eEtnVFJrYnd6SGI4WVRTeC8yRGVReldOQUozY1FP?=
 =?utf-8?B?ajFjcnAxenNaajFNb2QzR0cvdUtZWnR3VFJrN0t2UW5RK3Z1c0JvNjlZaWRU?=
 =?utf-8?B?WmJtdGcwUkxTQzVnckpuc0lJcU5QeFdwdVI5aDk2VEJDT1hUYlV4eHhtS2Fq?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gEx409QSxLhXaU+wfQtZ3ZSooYgxl9ujjiz88ZQ2sGxhr8szDwPdDvPfJRR9eTAmrQhfrP1DWCLDNmS2s6WVsQbV5hMCeiU8zFtszdkFf7cE4HXr3H/nmh8Gvnt0cuqTh+TjbZnwC9W+TKZhoD4w6s37hO5dcpZ9naGdVr6UkK7XKDF7VZdhAeS70KsNk38hJ8Ua0DJ1Guba7dFrzzru14lV/JghMGOXemNI/3EwiR/xl2ihPxGbEM32FohGsl0Yk0w4gPLBnxYFshsg0P0WFvdoXR5XyNKmOopyZ5msEIIwtS2Y6do9Ja5oYmKUfcKnZ1+I6KIr7YHsxi8Wk74y/OphpHccS2s2/8q6bya6Q8VXqa/DxloHEJvRSuStzNeMCabFvahD/lGhTG3uGKZGdRrAVr9H1ZOL+QCK4t24i7619l+4l6GJfN2FmcB4Zczdsb1jVQ4vm/9usLkUubGLuW2MwFtlTG9CsJy6TCrdqbnEmiizbYIg6mmK/XQeqGvwspsysMz3Wyi4vlAoy3T2LuF8pY7E3d23jiN+VfBut0Er07RfM3zIJbR99HHE44DDiuD9jdpPZALHKAZ/txnHHVKRXpIc0vZ6DQpVO6RjtJo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8901a6-b419-4f7b-8d01-08ddfcff1c10
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 13:17:57.6425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3NWvM61OvjPKbmL+blTJMqFt83s+nkXGtLsAg0I0YC0zuCh2XhpTsJmXKqWFCr0YoIJjJzI9WgM9e+woZhlfj6JJy91KVW0+39g4Xlywxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6898
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_04,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509260122
X-Authority-Analysis: v=2.4 cv=M+9A6iws c=1 sm=1 tr=0 ts=68d69289 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=QyXUC8HyAAAA:8 a=i2Y-thalyPeD3TXGFfoA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12090
X-Proofpoint-GUID: GLmKf64Np55LpWyeYAn9UqExbTJfsBAU
X-Proofpoint-ORIG-GUID: GLmKf64Np55LpWyeYAn9UqExbTJfsBAU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDEyMCBTYWx0ZWRfXzn5xw8LnxLAL
 6JIdFkPdpOt/l3MyKoyp8zeIVFK4yyEvWUewAQKtQz9euMJdWQX4KGaZeRG2z+MqYXj0BFhX4hm
 u3Vyp0uPGIlPe7nTKePjfpIS7gjDt7+eFrI5KBT8Wb4tpckLHya/6OcQBLIxqi8ZsmQ71tTVsEr
 lgX0WDuT4n4zYc6lqp3QV7/UpZN0UFqFhSjp87976Qf/pICyJultP8a+7chbvdD6xTJSa/CGMQa
 hd8vakw8lEqYCPGee8Boe02bXnk41HWnI55kj3+8EHYD2cXIpLe+0bE8q0FnaCXKXE2qIyRU2de
 di4dJgQXBIM0orUgTZxBS/C0TJM/p9WcmaY10gKK4w+MbAghwfsgz3/JIqb+aJ9x6vLkDGeP3Gw
 qrvL/dGYO43ucEKC4u0zjvCGsHfFX+CD9gQKzeSH8kUXOnyBPQc=
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 9/26/2025 12:48 AM, Markus Armbruster wrote:
> Zhenzhong Duan <zhenzhong.duan@intel.com> writes:
> 
>> After CPR transfer, source QEMU close kvm fd and free kvm_state,
>> "query-balloon" will check kvm_state->sync_mmu and trigger NULL
>> pointer reference.
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   accel/kvm/kvm-all.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index 9060599cd7..a3e2d11763 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -3479,7 +3479,7 @@ int kvm_device_access(int fd, int group, uint64_t attr,
>>   
>>   bool kvm_has_sync_mmu(void)
>>   {
>> -    return kvm_state->sync_mmu;
>> +    return kvm_state && kvm_state->sync_mmu;
>>   }
>>   
>>   int kvm_has_vcpu_events(void)
> 
> This dereference could signify there's a general assumption *kvm_state
> is valid, i.e. there might be more dereferences hiding in the code.
> 
> Have you checked?
> 
> Is freeing @kvm_state after CPR transfer useful?

There are other references to kvm_state which are checked by earlier cpr patches.
The risk/consequence of missing something is low, because this only occurs on source
QEMU after the target is live.

The KVM instance is closed to release KVM page table references and speed execv
during cpr-exec mode.

- Steve


