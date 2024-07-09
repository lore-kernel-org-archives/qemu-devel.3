Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487C5C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 09:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR6ig-0008W6-Ou; Tue, 09 Jul 2024 05:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sR6ie-0008V9-VK
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 05:01:05 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sR6ic-0006gj-EQ
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 05:01:04 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697th8e029608;
 Tue, 9 Jul 2024 09:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=IxMEKRENrsGvU8XBYQaaF7FPxvD46nhx+J7285/X7fg=; b=
 ZE/M4/kFeBXRAd6aO/Mfb4EkaiVcpqpytGn6CUPJxrR092mIQEiTemzLYXcS6l00
 WXi6+iW30OezE5o9wqqiRqdR7jE8WCXBKjgsRZAQxqVus9moS4mEBGC8sP4QPq7X
 aATTvfYU+FIHMevp6kDWQzrcZ715MdNjOgOrTm86SRzScpqDiMeD1H5zHHHwbpZt
 dJv/jJs+YjGrvYNsaM/kPmdyMN59gbw50S1sApGpKTn6249yczPC607+mItpoQpo
 7aKlViEcqOufZmFtHW8Q4ht/dXSPYcIs6TUS4SReB0Z0As60XkQnTA55YGwy6fYp
 j/RHe+Pp9IndDgrwKRLAag==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406xfsmfqj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 09:00:59 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 4698jluE036284; Tue, 9 Jul 2024 09:00:59 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 407tv10aav-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 09:00:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAIzENIDrBItqk0BIQRdi3ED3mSpGZ9sX5SUfZMd1ZjOHN74a4vEDRBmMKHQzQeDqxgW6XzgfKAOY4m4dY+6Je6KUB1yrwazaAWg6NyXpS73BnlXziiK1qG69gwWpyR9D/IabqjrnQtvozqCOURHjuJcKyPXorrtbkX5ms81hRPITSzoPxbjkArdmDBEJoOgpM/P4uiIdWQUl2MyCRMIPMzoikHEg5C2habPQcqLoOegnQx1xXAS8eVn7ybSGyrTPvjiqQnQv7m6wU5sGwU+1B5yXZ8hEDH1CSewQKHQDZkz68sdScq0KBos8G68BjroSNztj7AavsJYkjZbuixwwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxMEKRENrsGvU8XBYQaaF7FPxvD46nhx+J7285/X7fg=;
 b=MC/7NeRmke8pEuvYJIpt1YpQHH35tzobHZ/12QDYSEwI3XWtzZ4XpaJmPXchZn+882hn1q0d6foitUgPdZD3FzI3DoSmzXb3HUjdnp5ocmDC3+/7IAA5AW0vYw4uJvf+JAn1ej8p20daJEkySeTkJk58idb3iz30zEBQSAwGgj4ruTs1Pame2BtaKUMNkHaiWFNwrcIef6YYQTN764Z9MpMM+3myOgmKp7XNeeEPYnrP/XfL22tN8nU/O8bdbhVZs/HkjsFpJEkh7AYb1vmWuWXwHzy5MHofypx6dIjxQ90eSu8S2yGOtnUAA64z1CvCQ5LKFxJfp3rAmU7OHShdEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxMEKRENrsGvU8XBYQaaF7FPxvD46nhx+J7285/X7fg=;
 b=bj1mkpM15VBg84cLVvQZRvpKM0Pwu00LbKw6dPvCuAVOMW+GR+lLe9JP1HvIZhFi9DBQa6BY99oOl8/Gt2qZqBBeoRyfoU/4YTj3Xm8tKT2SG7KJQl85wsCuf6p16297lWxM7AgqPbQIbSJkkqctbPA3O0UdCLlbIBgzPcPeUJI=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by DM4PR10MB6109.namprd10.prod.outlook.com (2603:10b6:8:b5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 09:00:54 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 09:00:54 +0000
Message-ID: <e9cb0e8b-a3ee-42bc-844d-f81092ab8ac8@oracle.com>
Date: Tue, 9 Jul 2024 10:00:48 +0100
Subject: Re: [PATCH v3 04/10] vfio/iommufd: Introduce auto domain creation
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <20240708143420.16953-5-joao.m.martins@oracle.com>
 <SJ0PR11MB674442102F1373CF95BD245192DB2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB674442102F1373CF95BD245192DB2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0092.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fb::22) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|DM4PR10MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b9f10b6-b410-425c-92d3-08dc9ff5a3e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2RPWXdwN2FzekcvWU5wSjJHTVFFQjV2VnBaWXNqOWh0dUREQkZjVDMzL0Fj?=
 =?utf-8?B?WDVXYXpDRllxcU9jNE1zTkl0cFVwaWJvRE12WjlpcVFBVSs4Sng2OG13Mm1w?=
 =?utf-8?B?WVdOZXhGYXNCd212dE5xcm4vL3UwenZRbDdYMnVaeE1vRTNyNzNVd1Z1STJv?=
 =?utf-8?B?SXo3U0ZQcjl5eE9LeGhteUpmU2NITFFOQzZqY01FRlBOVmpVeFdFSHhBSlVP?=
 =?utf-8?B?WmJFeWRCenoxQUxTM1VDc1hxMlFRUnM3eHNyVG5aNk1pb2JRQXgvVlFldDQ5?=
 =?utf-8?B?S1NZQ3gzalNHYzVpVTlhaE5PcDhlMEQwci9jejU1dGNNVzNRcU9XN1I3c1N4?=
 =?utf-8?B?U3dEMnVPRThTU1d4dlBxRWFXVjN4MTRFQUVrVURCUmI3eklBd2JYYXZIdjli?=
 =?utf-8?B?NVk4TWFTc0hoRUtTNkExM0FFRDZRcjBYL1dJREhDR0NFUjNXeW90Mkw5OSt3?=
 =?utf-8?B?dHBPVjM2aGM4Z3lVU3k0NDNTQkcvcnVZenRKL3hFRUtSVnVNNmtVM0NOUFlz?=
 =?utf-8?B?SWhaczFkdjAvVTNjeXMrZlhYOFNaWHVVd0hOUXgzODFuV0Jtb0pENWMxRzUr?=
 =?utf-8?B?YWFzK3dDaEU1aEI5U3FjOTYyRW5jTHlOaVRKUFNxQ1dTRHBIaFNIclVRKzFn?=
 =?utf-8?B?aGNwNURQUFNqbENqTVNUTXBWUDlmTmkrZlBVOFk1azNJTGh6Vk9VZEpIa01B?=
 =?utf-8?B?WGpqL0NneCtCRTRDYkxzQ3dQeDUxNjFrNGcxYzNVdHh6alNtMm5UOWdQYU5k?=
 =?utf-8?B?K0lHdkxSYlA2TVpvZmxybkVRMHhwUkF2SVBwdTdOc05lQ1lpaThPVTMrZkNH?=
 =?utf-8?B?Y3ZtbnhyMUZGMlZVNWFuRWtkRGhESDBnVzZJT0VXSXhTb2dlQ0NESy9kUjAr?=
 =?utf-8?B?Ulg4QkZSaFZnakxQN2l3dTFCVkhZakpLRUJmK0xUUEVKeWtNOTIrOEtBV1Nu?=
 =?utf-8?B?ZjErWll0ak9Jakk2am9GbmxpRkpkTElWcXBka2tJYXpkOEs1Y2ltbWVxZFA5?=
 =?utf-8?B?dG1PTFFtT1d4K3dLMmJ4N2luczl4cm1BMEhxZkNLekFQdzlWczdWUmV5ZGNY?=
 =?utf-8?B?N2JNZUt1VW5Da01RNm95Zjl0Wk1FT3dra2s2eHFDY3Y3NjFwVTdxK21Nb2dL?=
 =?utf-8?B?VkJsZ1hPekx5VW5NTC9uaU1CU05tTEtvZlNKRUlWU0NTZWEyZnV5RnZtWGkz?=
 =?utf-8?B?bVIxNkNpRnp6alNRM0dmY3NPWnJCdUZqc2FKdE4ra1ZQNWFYaGNBcURpL2NP?=
 =?utf-8?B?MVhtTkh4NXhCNzFQQUpQYXhQOThMQ2RxcFpTQlhLS0JMOW9YbVdBUG9WWElB?=
 =?utf-8?B?NlJsclVSWFlyODlPejBPa09aRis4eXRwL1JTc3l3eHhKYzI0Rzh2dDBsTTk5?=
 =?utf-8?B?MnVZTDhSU05OQjloUGRURjh5Y1dGUm1xZkNnWldwelpzQUxPTlBMaDBHdi8w?=
 =?utf-8?B?N2NpUWI5K0dZRVNURC9IWWYzK2tpUnBYZk40a3cwU1R2SmJJUmJjVEQrOWNB?=
 =?utf-8?B?eHVjaTljTWdNR3ZHQjBxL0xGZ2I5ZWs3ZzI2QWNSRytVbVN5NTVkTjMzMzA5?=
 =?utf-8?B?NGxpUlREaTZLU1hVRnJ2bWdEcHdOVVhaOGpEc1lWRnlKUVVPM0lnM3FKbUtK?=
 =?utf-8?B?djZPejN6YndmMUZVbDYrMEs3RWJPaGpoMUwySFRRdFJMdmxxWDcwMDdyUCtU?=
 =?utf-8?B?cUtUajNPNFU2dlJCL0ZZUHZXQkhLeTFHNWpOSHB6RWxKcER0b0VSREp2YUMv?=
 =?utf-8?B?S0VKTlcvd3hydmJxVHkrdWlYbFkrZEUxSmtsLzNtWU4wUW04ZXBUUVJvSXZx?=
 =?utf-8?B?VE10dDgyUWtRay8xSUdyZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzBBRWJNOEdRWGdHb1VvdlV6MEhmSThUbWlOYnM3ZHFUY1VSaFNXZGZYeHhM?=
 =?utf-8?B?cE9HUEdwdmViYmtVTFJzTHplOXJPeHJYRlJVK1VIYVpnY2lGNUszOEVubWZ1?=
 =?utf-8?B?M3hJTkVyamFrMWdHOStpdzJwTzhyWjBIRXhXRGoxbVRMSzNrOFBZeFUvTFVE?=
 =?utf-8?B?aE9kU29seFRMUStINlp4UjhiZnVZL1NONHdVZkdWcnZkY1FOcGNjU2s2ejE1?=
 =?utf-8?B?cE5DeGtaUWFqUXh0ZTg2VFBvWk13V3RTNkFHVnJ1YnBOalZtRkZrZTZEMElo?=
 =?utf-8?B?d3REZitvWkJKS0FOQm8wdWNQSjRrRStISFBBRXpsMWk4ZkdiQVFidE9IcE9h?=
 =?utf-8?B?Si9wVms0UjZreGVGMGViU2VrNFJPMU90ZzNGNjh4WWdHMTEyZ05yV0hoOE9a?=
 =?utf-8?B?MlFDd0VGcGJoQXlwdFU4OTRNWm9sSEtSNURnL1hrQ2VQeUd5Sis5bTVSOTNk?=
 =?utf-8?B?b1N3M3ZPcWRXaVBuemhUUzR5ckN2UTYwTHM3VEFTZllaZG1qS205bVhhWFd2?=
 =?utf-8?B?WkRSV2FPUU5oVi9ZVEpVc08zdmU3NHdEbWJLVmZoMDRuT2I0a3JTV0dGaHNW?=
 =?utf-8?B?R1Bxem9CUmdaWVVGdk85Y05leVBQZFBQNjJDalhESGNnU21iYlhyVTZSVlBt?=
 =?utf-8?B?RXdOeGs1M1lhUTBKSWs2dkZZVEFmcVh6L3hIYklRSkFDa0hpVkgvUFNqTjFL?=
 =?utf-8?B?Z3k0WEU1SDk4TFhJN0tZOUczeVZlZnExODlQa3NBS3JIMjBxR3VkOHhONnI0?=
 =?utf-8?B?S0kzUTVhMWpSQWpHTERqb3pxRzY4NXpPUi82UmRtUGNUYjBGd0lBUHZ3NmRY?=
 =?utf-8?B?Q2NzaFA3eVRWOGt2TDNjZVBZMDdyclU4NXhjWlBJV3p6Tm03WXVRb3oyZm1t?=
 =?utf-8?B?TVQxTHY1YXZhYk9neitrUFdGL2tzc3V0dUlDb2xTMzVhTEF3VEhRalFsZHFx?=
 =?utf-8?B?QzI4ZTFpcXI0ZE10cjJTdWhYYkFqNXczbWpWN05ScmJzUHF1anFyQ09mcDZm?=
 =?utf-8?B?Qy92clc5VkNGUG4zcVJmZnNNOHRrdVAvZWFpOU01VzErYitLVE85dTQrMHh0?=
 =?utf-8?B?Ump4bzZveUV4KzVOVHA3cy9KWTlzUGJPYmtyYmxVaUlUL3hVdm1hWkMxak1V?=
 =?utf-8?B?dERzR0V2Y0JkNlA2cWV3Vjh3S1pmdDhRdFpsOVFGTS9INnhENERCNFlhOG00?=
 =?utf-8?B?N3loU0RqQ1lVeGQ4Y3h4VkNHRW1JVG5TUFNPN2Fuc3RNY1BiWjBBMWNyLzRp?=
 =?utf-8?B?T1NFZWJNcU51b0s5SlBsYzFjK3JyL2lqc3RVL2N4bEtRSkVtaW14WXR5SmYz?=
 =?utf-8?B?bmVYWWpTRUhXKzg1Kzkra2N1d0kxRVl4MEd4cGQrSFBWYzNhUWZ2a3puV2JW?=
 =?utf-8?B?Vy9IV1hsVm1jM0g1cTZhMUFnelBWMmpabHlnMHd1Z295UFlvVWdpMFM1endS?=
 =?utf-8?B?Vnd0Q1lkMTZVTnhnVGZGdDFNY2JTMU5xYmVDMGx3YUZOdUgrdkRVTThSaG0w?=
 =?utf-8?B?ZmFYNE0vZHc4T3Nnb1g4b251Q253dkl2UGVTaVNSQ0ZzSk1CUC8rQ1k1c3Vz?=
 =?utf-8?B?TEZ0OVJVdU1DVVAzSlNEazEvb1YyY2dONlJVMmFPcU1RNVk0MEtEOTJBdXRC?=
 =?utf-8?B?a01WSmkvT3dJeWgva28wNStIaFNKR0ZnYkJzQXNabC92QVhWT3k5aFNXM3RR?=
 =?utf-8?B?NktvZXYxK201N1VLcDAzM1o3Y0c3SDFxRndIbXZYNEJtRDgvUVhCKy9IVVJ1?=
 =?utf-8?B?bjN6NjRUWW5nK1Q2Qi81SWJ5aVZxbTk2Y2V4eG9LMENtTVpJZmN1d0xkL3JH?=
 =?utf-8?B?bG5NdHhIWEF4Z1VZblFHS2x4eUxIRXRhV3NXL1pmQUtpbDZOSXZISjJjZWRG?=
 =?utf-8?B?UUp4R2tsVEVxR0Q2NkNVOHNtdE9MT3d2WXlVWTVXTEJvK21nakRlMVJkNXhC?=
 =?utf-8?B?c2toWTEwMkVjMXpnczZlWlFLUndJblRKSDJGSHVkcFlOYkQycWhYbGJpMzhi?=
 =?utf-8?B?V0NVaFJiUm1obVVVenVuZ1RFNWg4U2NqRHh0bG1UeWQwU2xLVXg4T0NpMGpD?=
 =?utf-8?B?Q0IxM0FGdHpRVmE4dXJaVk1vNEhEQUpYTkFvZVpEd0w5YmpLbDIyNjhsbGph?=
 =?utf-8?B?disyNTk5YlJ2WUZSSTVvUHFXcGViYW43MXNhbTZacW9iSHQwRkZrK2Yza3Mr?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2suVGgWmjaYY4D5arNE4Nl3n9PUc88VVhi5VBpKJ2dUrq1uwFS6Hc5fimxx+yjlHNE+HPgmJFM0W62F4j5aIUrU2pLVgywHFj1dKZ6Mc/+/mbMrF6fCecLuhmIRfI8jL+qep+aG2hcNWihkVXAVR+LqfrWSOqFp/qoJlwJH2h5Cy2w8v4BbX6eIeuXxka/fTEaWFLpXAuj1GlHPQBY5XFfzigSYYXcIUCbGvkfChO2GXPu7Q7+cVWY4GNRP9Ucer7hNdux4MWUXFukf3dfBqOJOHWjichLY76D1p+W530GPAiqPdP0AY8c/ZqeK3qn1qFKA9iea8h52qczE7r1FCcdfBUOKD1OrbjeBFsZCh4xFx/rdleDbyS+CLR+HMKsJHg16uC2bdopvVBA7WMGWeEbju0VxZ+lcjzSXTVWr0zszgORDGPf+FTikfCyKdSTGpRBfQqEyJmU9xqotk7EC7CSt+tAJXv/X7ZZui4miMSzEJdEKeDNlM+ic/NUFu7+igYvMV6eW0XN1UYlfzy4TM5WQTqy2aN7Oeh7UFWMfyLLTgU57Izyurio+R16M9w6mXY4435RIDAaaBSoDfabK+eFUEl5W9AOusA3acN+BCY1s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9f10b6-b410-425c-92d3-08dc9ff5a3e6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 09:00:54.7810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/l2OCYUPGRP0oMMLq4dUg/fnfLe7ZZw1k9InzNbAiDF9GYAWj0l0RgEFAjozond4A7z+DTMj6DsQxLmsvYGjq8lInNia/NE3Ps8BzNEWk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6109
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_15,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407090059
X-Proofpoint-ORIG-GUID: TvzbKL0xTFmCmUaflhjA_yEDK8B6M1Kr
X-Proofpoint-GUID: TvzbKL0xTFmCmUaflhjA_yEDK8B6M1Kr
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 09/07/2024 07:26, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Subject: [PATCH v3 04/10] vfio/iommufd: Introduce auto domain creation
>>
>> There's generally two modes of operation for IOMMUFD:
>>
>> * The simple user API which intends to perform relatively simple things
>> with IOMMUs e.g. DPDK. It generally creates an IOAS and attach to VFIO
>> and mainly performs IOAS_MAP and UNMAP.
>>
>> * The native IOMMUFD API where you have fine grained control of the
>> IOMMU domain and model it accordingly. This is where most new feature
>> are being steered to.
>>
>> For dirty tracking 2) is required, as it needs to ensure that
>> the stage-2/parent IOMMU domain will only attach devices
>> that support dirty tracking (so far it is all homogeneous in x86, likely
>> not the case for smmuv3). Such invariant on dirty tracking provides a
>> useful guarantee to VMMs that will refuse incompatible device
>> attachments for IOMMU domains.
>>
>> Dirty tracking insurance is enforced via HWPT_ALLOC, which is
>> responsible for creating an IOMMU domain. This is contrast to the
>> 'simple API' where the IOMMU domain is created by IOMMUFD
>> automatically
>> when it attaches to VFIO (usually referred as autodomains) but it has
>> the needed handling for mdevs.
>>
>> To support dirty tracking with the advanced IOMMUFD API, it needs
>> similar logic, where IOMMU domains are created and devices attached to
>> compatible domains. Essentially mimmicing kernel
>> iommufd_device_auto_get_domain(). If this fails (i.e. mdevs) it falls back
>> to IOAS attach (which again is always the case for mdevs).
>>
>> The auto domain logic allows different IOMMU domains to be created when
>> DMA dirty tracking is not desired (and VF can provide it), and others where
>> it is. Here is not used in this way here given how VFIODevice migration
>> state is initialized after the device attachment. But such mixed mode of
>> IOMMU dirty tracking + device dirty tracking is an improvement that can
>> be added on. Keep the 'all of nothing' approach that we have been using
>> so far between container vs device dirty tracking.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>> include/hw/vfio/vfio-common.h |  9 ++++
>> include/sysemu/iommufd.h      |  4 ++
>> backends/iommufd.c            | 29 +++++++++++
>> hw/vfio/iommufd.c             | 91
>> +++++++++++++++++++++++++++++++++++
>> backends/trace-events         |  1 +
>> 5 files changed, 134 insertions(+)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>> common.h
>> index e8ddf92bb185..82c5a4aaa61e 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -95,10 +95,17 @@ typedef struct VFIOHostDMAWindow {
>>
>> typedef struct IOMMUFDBackend IOMMUFDBackend;
>>
>> +typedef struct VFIOIOASHwpt {
>> +    uint32_t hwpt_id;
>> +    QLIST_HEAD(, VFIODevice) device_list;
>> +    QLIST_ENTRY(VFIOIOASHwpt) next;
>> +} VFIOIOASHwpt;
>> +
>> typedef struct VFIOIOMMUFDContainer {
>>     VFIOContainerBase bcontainer;
>>     IOMMUFDBackend *be;
>>     uint32_t ioas_id;
>> +    QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
>> } VFIOIOMMUFDContainer;
>>
>> OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer,
>> VFIO_IOMMU_IOMMUFD);
>> @@ -134,6 +141,8 @@ typedef struct VFIODevice {
>>     HostIOMMUDevice *hiod;
>>     int devid;
>>     IOMMUFDBackend *iommufd;
>> +    VFIOIOASHwpt *hwpt;
>> +    QLIST_ENTRY(VFIODevice) hwpt_next;
>> } VFIODevice;
>>
>> struct VFIODeviceOps {
>> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
>> index 57d502a1c79a..35a8cec9780f 100644
>> --- a/include/sysemu/iommufd.h
>> +++ b/include/sysemu/iommufd.h
>> @@ -50,6 +50,10 @@ int
>> iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>> bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t
>> devid,
>>                                      uint32_t *type, void *data, uint32_t len,
>>                                      uint64_t *caps, Error **errp);
>> +int iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>> +                               uint32_t pt_id, uint32_t flags,
>> +                               uint32_t data_type, uint32_t data_len,
>> +                               void *data_ptr, uint32_t *out_hwpt);
>>
>> #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD
>> TYPE_HOST_IOMMU_DEVICE "-iommufd"
>> #endif
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index 2b3d51af26d2..f5f73eaf4a1a 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -208,6 +208,35 @@ int
>> iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>>     return ret;
>> }
>>
>> +int iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>> +                               uint32_t pt_id, uint32_t flags,
>> +                               uint32_t data_type, uint32_t data_len,
>> +                               void *data_ptr, uint32_t *out_hwpt)
>> +{
>> +    int ret, fd = be->fd;
>> +    struct iommu_hwpt_alloc alloc_hwpt = {
>> +        .size = sizeof(struct iommu_hwpt_alloc),
>> +        .flags = flags,
>> +        .dev_id = dev_id,
>> +        .pt_id = pt_id,
>> +        .data_type = data_type,
>> +        .data_len = data_len,
>> +        .data_uptr = (uint64_t)data_ptr,
>> +    };
>> +
>> +    ret = ioctl(fd, IOMMU_HWPT_ALLOC, &alloc_hwpt);
>> +    trace_iommufd_backend_alloc_hwpt(fd, dev_id, pt_id, flags, data_type,
>> +                                     data_len, (uint64_t)data_ptr,
>> +                                     alloc_hwpt.out_hwpt_id, ret);
>> +    if (ret) {
>> +        ret = -errno;
>> +        error_report("IOMMU_HWPT_ALLOC failed: %m");
>> +    } else {
>> +        *out_hwpt = alloc_hwpt.out_hwpt_id;
>> +    }
>> +    return ret;
>> +}
>> +
>> bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t
>> devid,
>>                                      uint32_t *type, void *data, uint32_t len,
>>                                      uint64_t *caps, Error **errp)
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 5a5993b17c2e..2ca9a32cc7b6 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -212,10 +212,95 @@ static bool
>> iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
>>     return true;
>> }
>>
>> +static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>> +                                         VFIOIOMMUFDContainer *container,
>> +                                         Error **errp)
>> +{
>> +    IOMMUFDBackend *iommufd = vbasedev->iommufd;
>> +    uint32_t flags = 0;
>> +    VFIOIOASHwpt *hwpt;
>> +    uint32_t hwpt_id;
>> +    int ret;
>> +
>> +    /* Try to find a domain */
>> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>> +        ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id,
>> NULL);
>> +        if (ret) {
>> +            /* -EINVAL means the domain is incompatible with the device. */
>> +            if (ret == -EINVAL) {
>> +                continue;
>> +            }
>> +
>> +            return false;
>> +        } else {
>> +            vbasedev->hwpt = hwpt;
>> +            QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>> +            return true;
>> +        }
>> +    }
>> +
>> +    ret = iommufd_backend_alloc_hwpt(iommufd,
>> +                                     vbasedev->devid,
>> +                                     container->ioas_id, flags,
>> +                                     IOMMU_HWPT_DATA_NONE, 0, NULL, &hwpt_id);
>> +    if (ret) {
>> +        /*
>> +         * When there's no domains allocated we can still attempt a hardware
>> +         * pagetable allocation for an mdev, which ends up returning -ENOENT
>> +         * This is benign and meant to fallback into IOAS attach, hence don't
>> +         * set errp.
>> +         */
>> +        return false;
>> +    }
>> +
>> +    hwpt = g_malloc0(sizeof(*hwpt));
>> +    hwpt->hwpt_id = hwpt_id;
>> +    QLIST_INIT(&hwpt->device_list);
>> +
>> +    ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
>> +    if (ret) {
>> +        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
>> +        g_free(hwpt);
>> +        return false;
>> +    }
>> +
>> +    vbasedev->hwpt = hwpt;
>> +    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>> +    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>> +    return true;
>> +}
>> +
>> +static void iommufd_cdev_autodomains_put(VFIODevice *vbasedev,
>> +                                         VFIOIOMMUFDContainer *container)
>> +{
>> +    VFIOIOASHwpt *hwpt = vbasedev->hwpt;
>> +
>> +    QLIST_REMOVE(vbasedev, hwpt_next);
>> +    if (QLIST_EMPTY(&hwpt->device_list)) {
>> +        QLIST_REMOVE(hwpt, next);
>> +        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
>> +        g_free(hwpt);
>> +    }
>> +}
>> +
>> static bool iommufd_cdev_attach_container(VFIODevice *vbasedev,
>>                                           VFIOIOMMUFDContainer *container,
>>                                           Error **errp)
>> {
>> +    if (iommufd_cdev_autodomains_get(vbasedev, container, errp)) {
>> +        return true;
>> +    }
>> +
>> +    /*
>> +     * iommufd_cdev_autodomains_get() may have an expected failure (-
>> ENOENT)
>> +     * for mdevs as they aren't real physical devices. @errp is only set
>> +     * when real failures happened i.e. failing to attach to a newly created
>> +     * hardware pagetable. These are fatal and should fail the attachment.
>> +     */
>> +    if (*errp) {
> 
> Better to use ERRP_GUARD()
> 

OK

> Thanks
> Zhenzhong
> 
>> +        return false;
>> +    }
>> +
>>     return !iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id,
>> errp);
>> }
>>
>> @@ -224,6 +309,11 @@ static void
>> iommufd_cdev_detach_container(VFIODevice *vbasedev,
>> {
>>     Error *err = NULL;
>>
>> +    if (vbasedev->hwpt) {
>> +        iommufd_cdev_autodomains_put(vbasedev, container);
>> +        return;
>> +    }
>> +
>>     if (!iommufd_cdev_detach_ioas_hwpt(vbasedev, &err)) {
>>         error_report_err(err);
>>     }
>> @@ -354,6 +444,7 @@ static bool iommufd_cdev_attach(const char *name,
>> VFIODevice *vbasedev,
>>     container =
>> VFIO_IOMMU_IOMMUFD(object_new(TYPE_VFIO_IOMMU_IOMMUFD));
>>     container->be = vbasedev->iommufd;
>>     container->ioas_id = ioas_id;
>> +    QLIST_INIT(&container->hwpt_list);
>>
>>     bcontainer = &container->bcontainer;
>>     vfio_address_space_insert(space, bcontainer);
>> diff --git a/backends/trace-events b/backends/trace-events
>> index 211e6f374adc..4d8ac02fe7d6 100644
>> --- a/backends/trace-events
>> +++ b/backends/trace-events
>> @@ -14,4 +14,5 @@ iommufd_backend_map_dma(int iommufd, uint32_t
>> ioas, uint64_t iova, uint64_t size
>> iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas,
>> uint64_t iova, uint64_t size, int ret) " Unmap nonexistent mapping:
>> iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
>> iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova,
>> uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64"
>> size=0x%"PRIx64" (%d)"
>> iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d
>> ioas=%d"
>> +iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t
>> pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr,
>> uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u
>> flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u
>> (%d)"
>> iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d
>> id=%d (%d)"
>> --
>> 2.17.2
> 


