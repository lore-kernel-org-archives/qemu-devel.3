Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE0E5C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 12:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tushf-0002IO-A1; Wed, 19 Mar 2025 08:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tush7-0001wV-6H
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 08:38:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tush4-00012p-MU
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 08:38:48 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J8fxBg014160;
 Wed, 19 Mar 2025 12:38:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=3Jxib+hEJN50DxR/d3Z8um5Gjgei+2JjOH3m1l4X9f8=; b=
 gDq5TP15efAT9OGuo0k2TJJgCFQWn5sdnm5WpItsJX6Mrza7WWE/rwvBrtx0Aub2
 PvrzQ0I+avHoNGCxteMLg+1Tz90mSBr50ueZ/gnVZVMRcZpEoMS3TPzCMWhwiwnq
 scnBnvKBen4AqWLq0if76g5hKO18Lubmq93nef4SVAUWbGGz2gvVp4PLg+ET9qH/
 D4C8OkD57xGEW371tIzbA2lttdDH/1YDdpI3F9MAPbVyjuSlBAIKiSC9dSQU3oIt
 +udmxkZqbkti84ugRNiZOP+jEeiLwRlsaKpcPSaAJ8Dsk5NZykJm8Op0Zri/0Rt7
 /za4SX/gfCCtDZalGd9zaw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1ka3byp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Mar 2025 12:38:43 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52JCMjId009582; Wed, 19 Mar 2025 12:38:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45dxm14g2b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Mar 2025 12:38:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3ogLd2tGh2hTq3TGclDvM2NsAdd54EMi0e/GfDNbCdi7WjPqMCDlXnaYWzew3HVw1t2yL5sWmGI+2VlzlDDM15nNu1YzzAQKy3uISFmRAHWBwcgtUvKLnA6Bv4GOnUqC/S8v7ACAIebJdTKKNzjI3zIpa5raU6QIZoOShuBKEExHOM3eAkGgAbECijPxORb6AZYoeM0TylY2BKFbEXk+/GmT/hGOdX/PQ1hO+z1cB9szPPEOc2FgpSblTy3fjhbNPc1GHAQvfyolhPBysPSTNPv1YpCiShFj+Zc0+iErVouteGEWgLiSZsXc06LheatQDR8rpTzzW4AeFoQRz4HMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Jxib+hEJN50DxR/d3Z8um5Gjgei+2JjOH3m1l4X9f8=;
 b=ATuU0Xi6SIuSLOyDlkummyiJqbtdPiFqU8cxlUOG35yx7G/2/4eEeajJKeFFFxU3AHU0gDl9y0AxARql8VBCyy2z0YS6pIK454PsB8Vc3So9VBfkOcbM8BMTDWr94sxDx/GalV+/ywmxu/Tel0Nm9/AVsrS/Ndc/Ombt2Rxvy0LSIyASiXkXFxk0OPUr0apCeBzr4MZ35CZMg0XeObpKXCJ9BLs/lVTDM0qRp4KJoPqOb8E92uUUhGVatiNkkd6LVtI5orIPq8GZRb4mOVQVTYJFVLllzY6RywPACooLnCYcPP+GXlAXxF9ciaUMbKk7wxc99B39P05p4TpBhv6dkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Jxib+hEJN50DxR/d3Z8um5Gjgei+2JjOH3m1l4X9f8=;
 b=HnyvuBUChNsdn6sZaG5Dqiz58hMq4unReM8CLmePq9qCqGRdsy+XwT2x2hDc7W2ZE4SuMebt8BPWHmabjKYZ7PyDRnoIJ9lYbfodpi7B2OTz5xPsrZ7ZZ7/EZrJ5ir/lfh5SXyqa+PjGYUBwfsU8fOtgyAZc0EoCtf+QXI9kjcc=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by LV3PR10MB7865.namprd10.prod.outlook.com (2603:10b6:408:1b8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 12:38:18 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%5]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 12:38:18 +0000
Message-ID: <7efbdfd3-12c7-4ac5-956b-21d295426b83@oracle.com>
Date: Wed, 19 Mar 2025 12:38:14 +0000
Subject: Re: [PATCH for-10.1 04/32] vfio: Make
 vfio_un/block_multiple_devices_migration() static
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-5-clg@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20250318095415.670319-5-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0071.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::22) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|LV3PR10MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f9f9c85-0c30-4c3e-5097-08dd66e2ed2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y1BBdG11alptWktzNEY1NllNdHRISjVMbjdOa0p1a09JTjN1R291bWFDNXVs?=
 =?utf-8?B?SWdNWnpoQ09pb2EyQ3ZmV2xQWkZQa0hvWkFpc2dPTjhaQlA5bXE4S1l0eG1Q?=
 =?utf-8?B?SzYxdjY0dGREZklrMmVlMFhGMUlPZFdhb0dENCtCWE9xQnhrNHpnVDdsczFn?=
 =?utf-8?B?VEVzL0tKbi91UWN2Q1lDNldjVVN3c2Z4RG1XYVJ4VUxuWVgxajhKb2RBcFdT?=
 =?utf-8?B?MUF6bXV1N05HTDNtME51TXAyL3MyUjcwVXVJY3lENnpoMjd1elFqY091WXYy?=
 =?utf-8?B?eHE1bW5pbFk3SHhmQXdZSnAzbnZZOVF5V2lQcVdPeDUzRFFLU0dPYnh5QzVp?=
 =?utf-8?B?SDlwc2YvdDQzbk5GNzRJa1dBK2ZMTUcxUW5Ud1hnN1ZGcHhXUkdXU1c3RHZJ?=
 =?utf-8?B?YUVIU1o1VE9RVlZKVW9NN1gxeGE5SDFnSGNtYmRxRlZHelVPL2hxVERmV05Y?=
 =?utf-8?B?SGJPeDFIQUZqNERKSlVCSHJTTnVQY0h3WVN5ZVNBa3NRZndURU81bjltR2w4?=
 =?utf-8?B?WEhnSHBKZG1raFFsR3BZT2szdC9qR1JQLzZyOHY3RG5DNkkzMFNjVDdEd1hO?=
 =?utf-8?B?ZnM4TUdnODZNbU5lOUdVK0llcHdrQ2RvYWR4ZGxxcWl0N3daeEpQNzlvVmd6?=
 =?utf-8?B?bk9UOU0zSnNhdGE3cXAzNHVnT3RaeGJxMWt5ZE81ckxVTXZSRVVEb1YxRFRP?=
 =?utf-8?B?UGFPRE5kT2Q1VnhxbURJVVFOeWhEU1J2MS9EemZYZjNnbVNwTDFHWVlIZlhk?=
 =?utf-8?B?aVhLMmZJS0lKR0tLZ3VHcHlwUUZXSUZOb3h5aXBmais3elFiODgwdVd2NEI1?=
 =?utf-8?B?cjFJMy90VlFLL3lHOGlkaEV2NVZ5RTgwdEVJREVVNFYwKzRyNmNsWkdESmhQ?=
 =?utf-8?B?amJibldMVmlsR0dmWU9yUVdtSGF6dE1wUEV1VkZyS2ZsaWF2eHpmK21ZeFJ5?=
 =?utf-8?B?MWZYNlUrWml6dVM4cnJUaG92K1NFU0NLbE0zRWFGckJYZjFxZUhOTVFsWnJt?=
 =?utf-8?B?cXhlSFlKaFBycHVrWTE0Vm1PNWw3RmFsMlRoVC9TaTlFZmR0dWkzM0FkUEti?=
 =?utf-8?B?UmZ0VVBWdnEvdk52RW5mM2VGdktmQ2Jwa1hKbU56Nlg1N3pGUVpzSGZSUCtK?=
 =?utf-8?B?M0hUUENqb3RPYStDb1l2VnMweUJZdENHUElmUWJSMmZJSzQ3VjJNMkRpVnZW?=
 =?utf-8?B?ZlNkSkpOMUU2ZW84bU5tdDUvcGl2dDdkTVd0aDdFbXdYYlJLbEdLQitOUGJT?=
 =?utf-8?B?ZVF2bi91YkF0RnR0b3Byb2U4N3ErbWh0blExNVpBRnBNb2hsQ0V2QXBwcFEr?=
 =?utf-8?B?NU4wKzQ1bDJPdnJsL2dGdW9SNndCZ3pmZXZnbTZUSUZkRTJPTmYxZFZ6SGR4?=
 =?utf-8?B?R1VyUXNjekJHSUZOQWk5M0xXYzNmUlNzZlN3dGM2RldHMEFSQThZVUZDQm11?=
 =?utf-8?B?elhVRDBRY1VMd0tEQ0N4UUpWRWF2ak83MEQzOUZzbThDb0V4V3hFUVBlU25a?=
 =?utf-8?B?WWJaNUtTMERLcHJNYjhIb29jT0lLQmxRYlNSMVFOd3lRRGYzbE9QWkN6b25K?=
 =?utf-8?B?aHVLVFVKZHBxemlBNmFHL1Y5TGpHclVpVVVRM2VLOHp5THJWTnRhcnY3dVJl?=
 =?utf-8?B?dEQ1enJxWDZiN0JtVnU5NFRiQnlHZUZQL3NBclJnY1pWejh0K3lHNSt2YTAw?=
 =?utf-8?B?eWdUMnhnVUVQc1FVWnBIb0sxbWRydGNCTUJRbkdsakljbWg1R04zNHhOYkhw?=
 =?utf-8?B?RWh3R0k1Qy8xbTE4VzA2ZDF6Y2ZCcEZkdmVKRU1zVTloWTVJWlo3RmJrVk0x?=
 =?utf-8?B?dFU0NmViS21iK3VhOE5VMm5kcXJ1bC9jNnFvKzRRZTlxWEJZemkzbW9PeFhI?=
 =?utf-8?Q?aGMVItd3atNWD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVBpS0tNS0RKRWFYbmlWV2hzQldFL2diSDg5cHo3ekEyTWZmMkhwYUlsUjVw?=
 =?utf-8?B?REVJYkF4T25NZTBqVnZCRFZKOHV2MHhMazFzRGErQyt3cmQxY01uQTk3ZzBs?=
 =?utf-8?B?bjVOVHdITEs2R1MvRjdjWktDRldFQ1hVT0pkd1NyUmRzUjNWOW05NGZCK0dR?=
 =?utf-8?B?NWFSM3RnRjdTZ09zeEN4YU93T0cxRC9aYnBFQkk3aW42SHErZEFLRGZrb2VG?=
 =?utf-8?B?QzRONnhNZXVWODJpaE5XYjc5OXdHbmxrUTNyZkJBSFUzMTFKd2hEeXMvY0VI?=
 =?utf-8?B?WVUrS3ZoU3djL3ZVL29VY3lXRlllTkNmYk5RUVNQOFZTOVptWmpubUszWVhF?=
 =?utf-8?B?eHNnOHhnOE1aZC82NVUzZ01pazN6N2tsRDlwb0JXQXFDUlBpSzZpNTQ3eTNJ?=
 =?utf-8?B?Vm5CeFptT0lmMlpvUG1mQUZNemRUakRYQS9SbXdoa25Ua2VZcHlUcjdPdVpr?=
 =?utf-8?B?U3Zia2dxR0RmRXpRcDlGbW5FM1pob2FqbE5LUUxPQVNQekcxVnFLcEQ0SjNI?=
 =?utf-8?B?WHh5OXN1RTJOZ0FmWFF6Tm9HbmJzZ1orWGVVMGlrNlJFUDNCY3czVDd4U0hU?=
 =?utf-8?B?enkySlN5M2NaOFd4YUs3N3RLZEl1MWpVYy9Pd0lPbEQ5OFJzcW1xL0Vodk9T?=
 =?utf-8?B?c0JraGNoTVgyVVRxWnZQQ0NJQ282cTR2elJwZnZReHI5UmhwejFjY29aVWlO?=
 =?utf-8?B?NWh3aGVCMkxHOUFmb1d0eFhuR2M4Y0R6VmtpUGIzcTVZT3h0SW9jeXNSdXlv?=
 =?utf-8?B?b1poL3Jjd2t5aURYdlN5eUxSZG1VeHUyb0dKcjYyRkg0bWZLQUt6ZFhTbjFZ?=
 =?utf-8?B?a21VSExrYmpGVjRIL2NiUytiTHgxSUxYeVR3ZkRoaDlMaHJQTUdJZmw4TmYx?=
 =?utf-8?B?ZGRnZzVCcDU1SFh1VDExdGhFUHhQbmRIN2RSdmVpTlVZeW1vekRDanhYcTZi?=
 =?utf-8?B?UHRHN2RQZlR6YnZ5NE9iZVlSL0pOMHZLd0lGQk5uWEY1bHplNFAxTHBiVVUr?=
 =?utf-8?B?Qy9MRjBjL3lZQmdVYldKYVVQNjNaUmdLaWF0dDNHWXMrOUxvYktya0pIcEx2?=
 =?utf-8?B?cDFaVGtIS1Z6alpXdHBRd2xoRzFkcjMyNytPbGJzVDREMGRTK1dSVGhqVWJR?=
 =?utf-8?B?YUZySEpUVlB1REkwdXNxTHhGVys0dzV3NnZMaTF0ZVE1MGFSczQ0NElaYjJT?=
 =?utf-8?B?MFN3UHUzTFhGUkQwUFg2VHF2bXNQRWkxSk1xeFdzUnQ1R3Ftc0xBNzJhV0Vm?=
 =?utf-8?B?NWt0QXp0aE5zWlFodWxxZEV5Z0ZUQjZjRWZyUTBYNDVCZ2RsZGlmZHFPU2p1?=
 =?utf-8?B?c0p4aVJrTTU2bWZLWWlrcWZTSVNGdEErclV3eXE4cFh5ZENHWWhaNjhkMGNB?=
 =?utf-8?B?ZTFWSzFWRGU0STF4Nzd6L3NaVzFUcSt1azhFMU9GTmUwbGY5YzBBMnhJenVW?=
 =?utf-8?B?eHV1OGw1aXhCYVVObnZEbFdJeUhJUXpDdlVURFZSK1Y5QThjSU8rQ0dVVE9v?=
 =?utf-8?B?L1g2dkxHVTJvTHZzOW5pUys0emt0WHd5cjk0RW1Bcm9lNjRFZmFoeXF2dEt5?=
 =?utf-8?B?TXB0T3N5bXk3Yml4ZzdFdDZpV3BtbVJhdXNleUlTWUZORm51ak1WMzlPUnZ6?=
 =?utf-8?B?bVI3dkNWa2pDK2dvbUpsTTNtL1V0T2tEK1VBWjdHRldwZ1J5Q0tPS3RWM3pm?=
 =?utf-8?B?cmdvS2JEWnZabk5SSTR6clY1emZqR0doMXhGT28reU9yYldRTzJCa3JsN0lW?=
 =?utf-8?B?ZHVpNXoxRDhkRE0zMGgxaUE3Z0tab0JTdXNwSGdNbW9jMnE5QjF3aTREck0x?=
 =?utf-8?B?WGhUWmtoWkQ2UW90N0tKclVQT2tneWIrekdLNks5aVJ5WlNMc0Y2aExPZGtq?=
 =?utf-8?B?elVBamdFRFRwTEVCN3kvQkYzajUwSktXUnQwME9KZzF5OGhSZ1NiSnFiZ1B3?=
 =?utf-8?B?blh1RkNxT3JCOWs0ZEUwL25Kd21BUzRyZUJaRnhSbkZwTHlIbGxsckZPZ05G?=
 =?utf-8?B?WXJlRW1INlgveUNoVmhwc2oraHgxWG9KNFlBTXdlR2Rwa2RJZWFCbFI0Mncx?=
 =?utf-8?B?VENlbW9qeE9QdHJhTy9pd2ZNUEVXSlBPYXYzT0FOcWdsbG02N3VoaG12L0dY?=
 =?utf-8?B?ZHFDOVJmTjA0bDhQNU5hRit1NmhDTnF1aWtQcThhUWlyd0czaVZtOVYzbEFj?=
 =?utf-8?B?L2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wjxlPxYv925hPDuXmvPBk4IJAAa1T/7/WxuLRCfQX8iMKJ9I1jvOanhY/XERH7xDEFjXSlqo9VPjLhHzuSuFcRJaBONrShrCT7nCIJ+kpYTW+Kt8zHMew2Y5C6adSEmwfUBl5aaUfu8myf+umYWydQ7yE3VTYun4GFnJPsUldC1sfowK3pzGkpVZKhN8maK1wdoOY2BuA+rO+TpuGyK5Rcv5JzfvNepmA3Bp2WpwLxHbw+yhWQm9Rm9sS0joeaPYlpx1o10TR/WDcUQ0wRXQmrmE78n9QvP3zpWrYTqxomIBvviVvSlfftRVW74DaOW62XJiHpMeh3FPpst5DFSX9MZpLLarzL5s0G6EcU3MlicW2FKqwws1VzsZbD79kpiQFMpj+CYSJspuaOyKUYdXh5zhnTuyvkFaBn2jHVTwsfKcheaWJAFyCQKBn4rk6SvFQGRDLxbjlon2QPui1TyFMk68Y/xMCw2GCQZ/GJ3PU3wKiy95VoTaU8OIRGdQceoN4Sdq0bIqBvyyET7Xock0qG0FNHFBOW/6YZcBOulXVgjkgnzpwiRvMi6FWBLDTWqx44GsJ/5LtDkq7A0ThgKSIMzNcE9xb5M760WobfkPBiE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9f9c85-0c30-4c3e-5097-08dd66e2ed2f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 12:38:18.7677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Csg1pULPbRxccsFFqJmTnPDcLGGssp+4JdDnk6ZEHxUDW/d8u/1za57Hx3q4/1zbpgwwNlsanNnGkhTeXlRRRHaUTWYFkHj6uvMkaxr/8k0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7865
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_04,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503190087
X-Proofpoint-GUID: E6AOzOrSpy5eZTcrwDAU5l7SNBtojOzl
X-Proofpoint-ORIG-GUID: E6AOzOrSpy5eZTcrwDAU5l7SNBtojOzl
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 18/03/2025 09:53, Cédric Le Goater wrote:
> Both of these routines are only used in file "migration.c". Move them
> there.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  include/hw/vfio/vfio-common.h |  2 --
>  hw/vfio/common.c              | 62 -----------------------------------
>  hw/vfio/migration.c           | 62 +++++++++++++++++++++++++++++++++++
>  3 files changed, 62 insertions(+), 64 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 5fc7ee76573375bc8464baee29ab88974fac3d3b..5f082e5a321d97e90066d48cd3c1eaad56912ccb 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -290,8 +290,6 @@ extern VFIODeviceList vfio_device_list;
>  extern const MemoryListener vfio_memory_listener;
>  extern int vfio_kvm_device_fd;
>  
> -int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
> -void vfio_unblock_multiple_devices_migration(void);
>  bool vfio_viommu_preset(VFIODevice *vbasedev);
>  bool vfio_device_state_is_running(VFIODevice *vbasedev);
>  bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 4205f4f7ec87e1a2a5e4110eabc8fde835d39c7f..ace7a4403bd49f35cf85009015b3ba315f80cd30 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -41,7 +41,6 @@
>  #include "trace.h"
>  #include "qapi/error.h"
>  #include "migration/misc.h"
> -#include "migration/blocker.h"
>  #include "migration/qemu-file.h"
>  #include "system/tcg.h"
>  #include "system/tpm.h"
> @@ -66,67 +65,6 @@ int vfio_kvm_device_fd = -1;
>   * Device state interfaces
>   */
>  
> -static Error *multiple_devices_migration_blocker;
> -
> -/*
> - * Multiple devices migration is allowed only if all devices support P2P
> - * migration. Single device migration is allowed regardless of P2P migration
> - * support.
> - */
> -static bool vfio_multiple_devices_migration_is_supported(void)
> -{
> -    VFIODevice *vbasedev;
> -    unsigned int device_num = 0;
> -    bool all_support_p2p = true;
> -
> -    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
> -        if (vbasedev->migration) {
> -            device_num++;
> -
> -            if (!(vbasedev->migration->mig_flags & VFIO_MIGRATION_P2P)) {
> -                all_support_p2p = false;
> -            }
> -        }
> -    }
> -
> -    return all_support_p2p || device_num <= 1;
> -}
> -
> -int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
> -{
> -    int ret;
> -
> -    if (vfio_multiple_devices_migration_is_supported()) {
> -        return 0;
> -    }
> -
> -    if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
> -        error_setg(errp, "Multiple VFIO devices migration is supported only if "
> -                         "all of them support P2P migration");
> -        return -EINVAL;
> -    }
> -
> -    if (multiple_devices_migration_blocker) {
> -        return 0;
> -    }
> -
> -    error_setg(&multiple_devices_migration_blocker,
> -               "Multiple VFIO devices migration is supported only if all of "
> -               "them support P2P migration");
> -    ret = migrate_add_blocker_normal(&multiple_devices_migration_blocker, errp);
> -
> -    return ret;
> -}
> -
> -void vfio_unblock_multiple_devices_migration(void)
> -{
> -    if (!multiple_devices_migration_blocker ||
> -        !vfio_multiple_devices_migration_is_supported()) {
> -        return;
> -    }
> -
> -    migrate_del_blocker(&multiple_devices_migration_blocker);
> -}
>  
>  bool vfio_viommu_preset(VFIODevice *vbasedev)
>  {
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 75096377ffecf62b3bab91102a00d723827ea4c7..951e073a20287c46ca199b1648782b59415d0d2a 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -1022,6 +1022,68 @@ static int vfio_migration_init(VFIODevice *vbasedev)
>      return 0;
>  }
>  
> +static Error *multiple_devices_migration_blocker;
> +
> +/*
> + * Multiple devices migration is allowed only if all devices support P2P
> + * migration. Single device migration is allowed regardless of P2P migration
> + * support.
> + */
> +static bool vfio_multiple_devices_migration_is_supported(void)
> +{
> +    VFIODevice *vbasedev;
> +    unsigned int device_num = 0;
> +    bool all_support_p2p = true;
> +
> +    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
> +        if (vbasedev->migration) {
> +            device_num++;
> +
> +            if (!(vbasedev->migration->mig_flags & VFIO_MIGRATION_P2P)) {
> +                all_support_p2p = false;
> +            }
> +        }
> +    }
> +
> +    return all_support_p2p || device_num <= 1;
> +}
> +
> +static int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
> +{
> +    int ret;
> +
> +    if (vfio_multiple_devices_migration_is_supported()) {
> +        return 0;
> +    }
> +
> +    if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
> +        error_setg(errp, "Multiple VFIO devices migration is supported only if "
> +                         "all of them support P2P migration");
> +        return -EINVAL;
> +    }
> +
> +    if (multiple_devices_migration_blocker) {
> +        return 0;
> +    }
> +
> +    error_setg(&multiple_devices_migration_blocker,
> +               "Multiple VFIO devices migration is supported only if all of "
> +               "them support P2P migration");
> +    ret = migrate_add_blocker_normal(&multiple_devices_migration_blocker, errp);
> +
> +    return ret;
> +}
> +
> +static void vfio_unblock_multiple_devices_migration(void)
> +{
> +    if (!multiple_devices_migration_blocker ||
> +        !vfio_multiple_devices_migration_is_supported()) {
> +        return;
> +    }
> +
> +    migrate_del_blocker(&multiple_devices_migration_blocker);
> +}
> +
>  static void vfio_migration_deinit(VFIODevice *vbasedev)
>  {
>      VFIOMigration *migration = vbasedev->migration;


