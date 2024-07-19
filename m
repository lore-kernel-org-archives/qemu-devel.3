Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2CBC3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 17:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUrNu-0004ZD-Du; Fri, 19 Jul 2024 13:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sUrNs-0004Xs-0k
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 13:27:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sUrNp-0001LY-La
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 13:27:07 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JHQ2aU025894;
 Fri, 19 Jul 2024 17:27:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:from:to:cc:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=4xp6vO7GO45Jw0psr1xL6H9Yqc98UYF/vIC1Ei6+r58=; b=
 DC6s5SvX+2mNMpagvi60JUHd6WeOPdyj5HfI4UR5/Z/Nk3/yPyxV2U4tiruAwNJt
 m3cSGxfZXr2H2a8tF1gWezIbxtWv7PVJh0x4+l+t/TSmK5x4Tj2xY4rJmZaxgqKv
 Viv/X/nCz/KXSYwXBOsMXVGlm95yuUxNHSay5U6whvQxuct8Y6Ko617iMBcXomJF
 eHn5Nm7S2D3O5hDgCFgX+hN6QxYbWAQsdcqC77E4wunBXBePmNPUGnhahOYnOdv1
 +olPwcXoTTDwjt6szmxVUFGprnIRT1P4rEFHGeKfuqKHKyu0i3WHQ7kvxDP0LMmm
 MM6B7GDKzqdFThePnHbaRA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40fvhd002x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jul 2024 17:27:01 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46JG5EaF021750; Fri, 19 Jul 2024 17:27:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40dwew6hxm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jul 2024 17:27:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q20jXmuwAUvuwM1lSxxgdEBfcHHM2MP9YL9j7+3idvR6iSLcLEJnz06xTKEKhjOOESvo02u0j3WPz3S4a8ZSAvA2HE76ILiQMMRwdL67A+opzpTv3Kqdu//vp8ade0p3iYq5XxwjIMHjNX3Uvi8jVBBmcZ6pWmYav4v3CLD7uXEoHrKJbI4EwRpeU9JVR0vZ2Jgbr42gHULcpCqzb4I9pFSigclbcsK6h+FkbWyebN3PhUI983llpsoFimxVD+sJhxPJbiLqFEw4m7rsgVXDr/8V02qStFKhmkKr4+DIEsSqOx4rQ4cuRrQeMDn/XN1dPoz1HX7qVovI1px57Hh5GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xp6vO7GO45Jw0psr1xL6H9Yqc98UYF/vIC1Ei6+r58=;
 b=jPfpkHnEyl+EhGk5REzty1Y2aY5lBgANeGFJxXHoYerqR/4sz9m8seAZiTeVyKBDvKSeN3fnKQXiCa09hy0xh9H7ez7ITLBD3OyXhC+s1S2y93lhhr60IWzYYF7d07Nm2MEsp1+4/zFzAWKtvf0XEThclJHvCKDSNjVMAhlIGJPJXQ/DYAxlgMVuzVS+LMn5DD9onVnNFOPSpbIcZLB/mcM0L/YsavfbFxmHH6HOl80Mo3/n5a8HgajcZplzmw3NWrn5sGc+OB2o01QqVJwmXtVMaYSQeq4t7J+CZnM+D9cZKzrudPuUdWzAQkIx5T1EikZYBMelVbS/MEdAySZd1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xp6vO7GO45Jw0psr1xL6H9Yqc98UYF/vIC1Ei6+r58=;
 b=m+yuNjA9Is+SSJ7BygKnOtVc7nRPqgYmn6+QGZpWADgl+fgV1bhDuBMysiUD5YA2R8sr+WpCKVcd/JTBryF9Rh6cPkobLtrBAuqnLBqPGfOisbclIW+f1eOa0kGw1p543sCZaxj3lLVk27MCVB6Axgxm0RNrUecLXskGXTb0vK4=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SN7PR10MB6978.namprd10.prod.outlook.com (2603:10b6:806:34d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Fri, 19 Jul
 2024 17:26:58 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Fri, 19 Jul 2024
 17:26:58 +0000
Message-ID: <1304a8c4-be47-4b47-88dd-328a8f167e54@oracle.com>
Date: Fri, 19 Jul 2024 18:26:52 +0100
Subject: Re: [PATCH v5 12/13] vfio/migration: Don't block migration device
 dirty tracking is unsupported
From: Joao Martins <joao.m.martins@oracle.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
 <20240719120501.81279-13-joao.m.martins@oracle.com>
 <a8239962-c987-4ca1-b342-95fd8f03179e@redhat.com>
 <f5d64358-70e3-4217-8376-356c8aaac8ea@oracle.com>
Content-Language: en-US
In-Reply-To: <f5d64358-70e3-4217-8376-356c8aaac8ea@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0021.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::12) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SN7PR10MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 26255d85-b2a1-494b-e1f9-08dca817fe16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDhOeENiZWNrbXVNR0pqQjNhMDE4VUZNbklPYVZmN0psdjI3UkM0b2owWU5p?=
 =?utf-8?B?YlovQ2k1U3FBdkxJanovRzR4blZra2lmMHhWc1pNVXBBaXd5aCtyOFM3K3RE?=
 =?utf-8?B?bmF2Q1FCL2hINXZsQkhIWVBacC9ZbHhlVFA0RC9mUEVYUzN2aGU2KzcxY0R1?=
 =?utf-8?B?SFh2cFMyNzFQTUFGb3c0anI3MGpqMHVBenFtZ1NOWHUwbEhmeWhKSnVVUEVO?=
 =?utf-8?B?Ky8zTlFuZjViNTZZNEJHbytoeisyVXFPOHZpOWtjRVk4Tkk5U0Jwd2RuU3JF?=
 =?utf-8?B?QkdMTFllbFdRVG9mTzhFWldpT1NiRUoybXVTOHpHQkJZMzQ0SFJLRURoejhk?=
 =?utf-8?B?NnI4S2FwbmdnMWlDdEIwME0zTTZhWi9jWlJjVHBiSDV3Q0EvUTU5NlRvWklE?=
 =?utf-8?B?eFlqOEFGZDBLZG5KcXhmSmtiRDhvRjdnNENBWVNZWmhZR0FKcENJbkR5MWVl?=
 =?utf-8?B?bURKV0dCUVhXempGRzkwR0VRYmRsYjlpWHVpUFZYcjB3Tmd5S1ZKMTVzUkh4?=
 =?utf-8?B?bTdxeXNnYkJmRHZWRWtlcW9rWkk4T0NkZkR6dUNMVlVnUFIyeGt4NkF1VUtk?=
 =?utf-8?B?T3NvY0Rwbm0rNXR5UzFkdlJ5dDZENkxiM0tjTFlTY2IyeVZKeEl5VkNBZGEr?=
 =?utf-8?B?eUh3K3pMNi8ydUtIclY4T1JtODExcWY5cjl6L0FBZXhLVFlLWjRtbDlvVW42?=
 =?utf-8?B?R2tJSDVwbGNxTHJwbC9vTWdBaFVsK0kxaldxaThUMHU0aGZXVlRydDRHVmJD?=
 =?utf-8?B?aEhJV2QzZzdLVVBOYm9sWDJrNmFnWDd4NDdqQWx2VkRtNUhxamFpRjFWcXp3?=
 =?utf-8?B?cjUyaUFxY0dNK2MrY0IyQWRvRGxMV3BrSlp0dW4wUk1jOHdUdlJPelV5cWsx?=
 =?utf-8?B?bmpORmR5ZTlMMDMxT3BsYUtpeW8rQ1FpWkd1Tk1CUUlKdUJrL3REVkNIZ21X?=
 =?utf-8?B?T2pUKy82N1dOSXYyemw4cVgwTHdtSTA3L1RYM0hOdVRDUU5DenJyZGJ0dS9O?=
 =?utf-8?B?eS9mQWluZEdlem0zNDhmTXVYYW11cHZTS0JkejZkdWRnUnM2UDlCa1VHMjVo?=
 =?utf-8?B?OGNqek41bHRsSXV3bkZyRDAwQi85dHloYnY1R1lKZTJwVmtsa0VHdWd4ZDkz?=
 =?utf-8?B?NFpka0RzUnlMWVRHL0ZmOGJLVmkvUlNUeXlicnlHVWlpM1RsN0VoR1FDTlhJ?=
 =?utf-8?B?S29vVklPN0NFakVKV0VmSzhJWEZyQTBOSjh3OWNqa29yVkN1S2RNWE9PaXF5?=
 =?utf-8?B?amhCcnFxcER3NlFYL3NLdzJobytKZGxld01kaDgraXR0bHIyMitINk1xa3BW?=
 =?utf-8?B?U0ZVbVlYWW1laGk3U1NiRERoN1NMT0Fhc29uMDZzU3BZWjhUWTZTRzZyNE4r?=
 =?utf-8?B?M0NOazVPQ211SnBNbjZhV0d5SnZBZDNXY2ZyZEhwZWZLTFliRzZFK2wyMmgv?=
 =?utf-8?B?U2NKVS9wenM4K2hUay9nTWFXeC9MdUMzV3VCeFF6cVZSMEduSGxINE9YZWdT?=
 =?utf-8?B?a2VEU0VUekx2SHhoZERFdUZXWU16ZXZyVUI2RWJjYm15eHQ5U3ZkK0puZ3Zw?=
 =?utf-8?B?Y1NJVFdsUVRkTHRMd2hjd1pnb3dBS2hBTkhQTWRpRDI1MXFtYVdka0JFSmxS?=
 =?utf-8?B?MmFvcWY1Yjg2eHZBTXhneGpuQnV6cDVjS3RsWUw4N054cW5GT3BsSkpHdGZv?=
 =?utf-8?B?dXVjUjN0cFM5L3BxT090eWkzT2hlNlJNamlObEdqd045ankzQXpKcDNPL0Vo?=
 =?utf-8?B?NHlDSjM5NmRxNytIcEl5ZWdjVmVZd3BiZDVqa2o4NFA1Y2pMY0FLU0pXNElV?=
 =?utf-8?B?aHpZakN2YXN2akRpYi9WUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTh1NzRvRDJTSFhQb3lFeGRQdzdoaEdxL09ZZm50WjZJbWRsVmd3SFAwZDV5?=
 =?utf-8?B?UjFnV1h6TndlZzIrWEUwb3hyVTRBd3hhRVc4MWZ2UGZ5aWlMSmRSZHZLc1pQ?=
 =?utf-8?B?ZTdEcjFDbXdobjFoYTQ4NnFwQlZMOVo0cmRCZVhFNTk2NHFGeHI4Ty9hU1pE?=
 =?utf-8?B?Zlk4eW50WFBjZGR2K3N0bFJRZXNLNGNwb2JLdXgxT21uaVVmb3NTUmNzcHpP?=
 =?utf-8?B?ZktHRUJhVUN3dDhuT2ZVR0N2aUJIMzlHTE83enZyY3kyU3d5Y2lkaEZXamNz?=
 =?utf-8?B?akpKUjgrZkN6ZU1UWnJVVXJxV0ZZYmR4QjR0K3QzSE8rc1pqQkl4ellPWEho?=
 =?utf-8?B?d0NLZzlXdkEwN2ZmM0RWR1hvVjl5QXVpZFlMMVFrck1OUGpBRzhicnNjekNv?=
 =?utf-8?B?d1ZEZUh4K2ZtN1dFNThtQXYvV0t4SHR5NHI0WGhBTjhyckhvVFpwMGZ6NFhT?=
 =?utf-8?B?NWEyckxRNWxXVURMZXNORmkwYXYvZGYwOWJHNnpENTdpN2I4Yk1oR3ZicTNn?=
 =?utf-8?B?MGl3azNPQ3dYNm16eTVSdFJWcjN5MlNpRElSRHZxNUdWeEd1UGhVMVlPQll0?=
 =?utf-8?B?M1FnUEh5MERKU2ZLYkNQSnRiVW4vY3prUkhFYzlDektjWFdEaXRBQmIxMURM?=
 =?utf-8?B?ZzN1M2hSQTFSOGRHeHdHdXgzemhUaGxCWG9QU0Q5aU5ZMWJGWVkwOG5OcEcx?=
 =?utf-8?B?S2dRai9vdVZtbjZ0a2VqNzFhbVFlcHFQaU1iQUtSSVozekorU3FUditFV3Bz?=
 =?utf-8?B?dHptVDdscVlTc2cvTjcrNnN1My85eFZqK1N0emZqNmkvdm5YSldCd2FQakhX?=
 =?utf-8?B?eTlQY01UTDZRRlZSOFczM3lZSUV2ejh6UGJiQnZvZ0hHaDVKMEs4S3lQM0Fy?=
 =?utf-8?B?WUpidWtnclBMcnNDZk1xV0loOGtsM1pNOHVvem1qSzQveE1IQVdPZDIwdlBG?=
 =?utf-8?B?QXMvenM3Ylc5cElFTHJxMFZhMy9DWGFkenIwMzIxTEFKM21nblF3dEdRbmI1?=
 =?utf-8?B?d29acnBHYzUrMDBOaTdDMTdiSlVaWHUxanY3clFtN0JyWUFVSCt4eWprNFFo?=
 =?utf-8?B?akxjdVJya21INGpwNlZ6Z0FSbnFjNmdFMzUrNTZPRGVvSVFZOS8zTGZCNzQ2?=
 =?utf-8?B?bEl5RVVLeEVVZ05UVzlIUnRWN1VxQy9VSU12WXhidmlidGNpU1h5MWxWQlVa?=
 =?utf-8?B?Njkyd2gvZWxrN0VPaEg1Nm03RWNUTHZFQlNlVGR2a2gzME5GckZQcTIxYmlG?=
 =?utf-8?B?K0FvSFhMbUZKcVNTR1Jxenh1cXU3NGlIdHNLQVFVdGFsUlpNT20xc0VqWXZ0?=
 =?utf-8?B?V05aZDZJeWpjcjZZNkRtaXR1SFJ6NVdsUTlycWNjcEdIdFVzRWFFUi83MlRr?=
 =?utf-8?B?WW1CY0dFd2tqd2FRQmpkRk1JaWhwZEQyU21ZMENEU1VCbjFGOFp6WVpONk5B?=
 =?utf-8?B?ZXYrbzlMTXJvaldHdmVQaGdwQnhITE12THBCVGxpUUxJTzdDakhCcHZ4TlBa?=
 =?utf-8?B?QzFYcDVLMkN2TE9LSGdEZWp1eUFENDFLbWl0ME5MVXUrenFpUTlyWnZMZzR1?=
 =?utf-8?B?aFJIK2MrMUxwUU9pVWVvTjk0NDM5WGQwalE0aHIzS1pvcm9pM0xic1Z1T3pz?=
 =?utf-8?B?SkxGUFNJdlJFdHhQUjl6S1lxUThlVDRsRnV2RFdsQVRnQm0vcC9zYXZ1TlpD?=
 =?utf-8?B?ZFczam9meWtYWk85L2pjR05LaW8yNU40QUw3c2hKWTdQSlVGWnRwdTlEd1hk?=
 =?utf-8?B?VDdlRFk2eENTUUlvVGtYUE5uMzB2VTQxdlYvQ3VJTE51MWpYSk5JS2x4SU5N?=
 =?utf-8?B?QmtPWm9jZjQ1Qm1FRmZ4d28ra2dIKzc2L2Z5eExzZVlGcjV2YWdkWW9RRGRZ?=
 =?utf-8?B?UTI1WGYyMTg1c1FwdHRtQXp2bEhGL0JsUmN4MUowbHl0M1Vhb1U4Y2RzcVd5?=
 =?utf-8?B?RHYyTytqdlhQV1lPdHlvejV0TDlqWmFkV2hsN1d2RnZENExDeXJCWHJ3WGVN?=
 =?utf-8?B?a01Jd0FUeE9ZZzhwdDcrd2ZHdFY0dkZ0eGNnaWthRVlvYWpZZ0JKeVU0WVdR?=
 =?utf-8?B?UnRlOW5abUFLaHg0M2lmQWs4Y3lUOE9NOSs4UmlYWmlOTTJ2eGpRZmdYR1V1?=
 =?utf-8?B?S3YxbFNjR2M1V2J1WUdXUC93WmIxc3BHYW5pVXpMTUt6Z0JGRjZHM1pBSFhp?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yPzf25pLjOCx2c67TQxiF/mDsUNlk2haueCL59a7sXHGwJqHzrER6Mi3DpxfVjoXbRhvS5Zds6GUxzV1tL7OHRTaOgQbimg53Zzvb2x4BLo5SnUYRSdIPKtAs6H9z1waSzUECOay9llvOSpALha7GjT8ScgR4H0VPNwg/Ladnhhney298ZTQm3r3Ktxh6OGwk2Lhbp4NRsHcp0PUR4nkscvfJ5+AVtBjBveJrqgrELK//hZBNLa4FQo6BvfikoTxOkzglGdKMCSMyHeGyYQyT5+FsDZH3ZUi7GR3rVOnvfVWrN6nKCLgJG2epM5+GPtJfNqElcT4CoNbAgQx6v0LM7F5ttBYdaqP3GJKmwFgSeDU67MGtzRDIr8nzhsJXvl1Yh5DHCFAq8oE+TEA9yAWhO7uGK1rD8Z9aRb8Qv0zdJS91x6BWaiOi3UZtRav40bNZOJjeoT3DrZ1l4IpoD277yBl5TDex58UNdsEAPp4O7pal1Q+enKAOhhBokUzyiNXejz3eO4Z4dQvdn7vm7HIh4t+a13hQ5Maqy1+hVYmmU2G/i1+0tYzG9KbAA3jU+elClEB3AgBkYRKJxT+wNGFPApVNhCtQwsouwHjHluQkkI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26255d85-b2a1-494b-e1f9-08dca817fe16
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 17:26:58.2553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TW+NqRkwrEc92sdiTLCBtLWnu2TI+s3y1CInOPF4oOzpKEbiZoluvfjHTWQ83eyJj35mVJG6cv0+OG4voBiVUivZAeCj0lgrFw0lz/Nztno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6978
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407190132
X-Proofpoint-GUID: h11-AVLBaUwxKLJvHhBQDidwdQRet9F1
X-Proofpoint-ORIG-GUID: h11-AVLBaUwxKLJvHhBQDidwdQRet9F1
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

On 19/07/2024 15:24, Joao Martins wrote:
> On 19/07/2024 15:17, Cédric Le Goater wrote:
>> On 7/19/24 14:05, Joao Martins wrote:
>>> By default VFIO migration is set to auto, which will support live
>>> migration if the migration capability is set *and* also dirty page
>>> tracking is supported.
>>>
>>> For testing purposes one can force enable without dirty page tracking
>>> via enable-migration=on, but that option is generally left for testing
>>> purposes.
>>>
>>> So starting with IOMMU dirty tracking it can use to accomodate the lack of
>>> VF dirty page tracking allowing us to minimize the VF requirements for
>>> migration and thus enabling migration by default for those too.
>>>
>>> While at it change the error messages to mention IOMMU dirty tracking as
>>> well.
>>>
>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>> ---
>>>   include/hw/vfio/vfio-common.h |  1 +
>>>   hw/vfio/iommufd.c             |  2 +-
>>>   hw/vfio/migration.c           | 11 ++++++-----
>>>   3 files changed, 8 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>> index 7e530c7869dc..00b9e933449e 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -299,6 +299,7 @@ int vfio_devices_query_dirty_bitmap(const
>>> VFIOContainerBase *bcontainer,
>>>                   VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
>>>   int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
>>>                             uint64_t size, ram_addr_t ram_addr, Error **errp);
>>> +bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt);
>>>     /* Returns 0 on success, or a negative errno. */
>>>   bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> index 7dd5d43ce06a..a998e8578552 100644
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -111,7 +111,7 @@ static void iommufd_cdev_unbind_and_disconnect(VFIODevice
>>> *vbasedev)
>>>       iommufd_backend_disconnect(vbasedev->iommufd);
>>>   }
>>>   -static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>> +bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>>   {
>>>       return hwpt && hwpt->hwpt_flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>>   }
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index 34d4be2ce1b1..63ffa46c9652 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -1036,16 +1036,17 @@ bool vfio_migration_realize(VFIODevice *vbasedev,
>>> Error **errp)
>>>           return !vfio_block_migration(vbasedev, err, errp);
>>>       }
>>>   -    if (!vbasedev->dirty_pages_supported) {
>>> +    if (!vbasedev->dirty_pages_supported &&
>>> +        !iommufd_hwpt_dirty_tracking(vbasedev->hwpt)) {
>>
>>
>> Some platforms do not have IOMMUFD support and this call will need
>> some kind of abstract wrapper to reflect dirty tracking support in
>> the IOMMU backend.
>>
> 
> This was actually on purpose because only IOMMUFD presents a view of hardware
> whereas type1 supporting dirty page tracking is not used as means to 'migration
> is supported'.
> 
> The hwpt is nil in type1 and the helper checks that, so it should return false.
> 

Oh wait, maybe you're talking about CONFIG_IOMMUFD=n which I totally didn't
consider. Maybe this would be a elegant way to address it? Looks to pass my
build with CONFIG_IOMMUFD=n

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 61dd48e79b71..422ad4a5bdd1 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -300,7 +300,14 @@ int vfio_devices_query_dirty_bitmap(const VFIOContainerBase
*bcontainer,
                 VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
 int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
                           uint64_t size, ram_addr_t ram_addr, Error **errp);
+#ifdef CONFIG_IOMMUFD
 bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt);
+#else
+static inline bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
+{
+    return false;
+}
+#endif

 /* Returns 0 on success, or a negative errno. */
 bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);


