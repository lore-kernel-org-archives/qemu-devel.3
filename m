Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524BAC3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 17:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFyl3-0005Lc-Dh; Fri, 16 May 2025 13:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uFyl1-0005LG-Hp
 for qemu-devel@nongnu.org; Fri, 16 May 2025 13:22:03 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uFyky-0004oG-Tx
 for qemu-devel@nongnu.org; Fri, 16 May 2025 13:22:03 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GGfs8h000992;
 Fri, 16 May 2025 17:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=dcDobH2u9VqtgSZVi4c/UgmAiPeBo37l5PA+tEG8rEQ=; b=
 c/UD6sGUy423QRZlihlVVhlJQEn+yajJ/9AW+/9UNXy6Chr2vtma/Qhx2gP2JQEc
 WATMPTqB7lM6sGGUp9OyplOB6NygPHwK9bw5nJviEaBEf0LlnXA0VC0C/AF45/p7
 uG0itjlQoC9SOhMeyHe5bRWHP0cbw5r+9Iuq8KJIJO8zPR9a0sp3HklQTo993AyW
 +RpDhsLn6KQQweN0Z5MUyb93EFa4+ScPNboZJ5Jd6rXwmnhtI+rKPopBPgQGXcdR
 qllii4ai5CrzmByI+vzc5xQSdHHJpO5Tu7Xeh4Teg947lm2qo/nXNMGb/SF5Uxg9
 SPe6KqLRX6YPec57bgUPDg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46nre01v2g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 May 2025 17:21:57 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54GFYGaf033385; Fri, 16 May 2025 17:21:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46mbsc3cbg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 May 2025 17:21:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gAutMUV1Qp9XeK3RnXJfsynasUYXyKptVLB15kHXE/iaQ/jIBkHKdBcUqHdf37m6e8PuaHcV0QcLJGivG877Gbd3/2W1VYf9apTCr0tutuftHOkrIuj85btK43tZlN9U1lh6WUxj+PYb8sf4zIP5M0vvCErBZm25yjVArJa1Fxv1LfQK8Td3lQ96mu6V4d6HsonDeNFpFSy4n5EYrlgNJyTKVHEhBNSG/yAJwCY+tDcHiXR6wmoCGKC6R0SDrF8Xd6oSRmOcTeC8SBjnkJYtCRXEt5UmhB8qruITOt4hfw1jo2kFc9o6zPdPo8oqGtfRxjNH+sXDMUzrSN7FXMU2CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcDobH2u9VqtgSZVi4c/UgmAiPeBo37l5PA+tEG8rEQ=;
 b=AoLuNFboe9wRjPzcw300IJPCy15iSrk/FZUwM1UTZiRp78qLz/WI9wBhaCvnhQee6wH2+2hjgQp9d9TVKLoceyC2H0mW2Z5KW6lqHYZdnslJ6gJsBzFXy8mKDjUYJdo+teeFoG6A/7fk7OYZ+nFeE0m36sLzDM+7K0z3mGnX2fIcHLCbjqb6yvI6Eig25GJAovPWJMKRgN2Fb2BBBwk5teIxULqQBusL95vC9xvGCcj0lsma/1G5QA+fpNl/fiGBmo4+hSrpcmNEBdP0AIuhuOkyeCSygz0GdkDKelSLzoTKklM4NzIs1pzM1sB88sKXhaM6Mj0wyY1tyFusmDvvVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcDobH2u9VqtgSZVi4c/UgmAiPeBo37l5PA+tEG8rEQ=;
 b=zTb9yAgUhpU3qUbGZqNh/ufUtzStB13fDSdPmmka9ahOQpHP/X6PuzEtvPgiwS/y+6rNO0PC02JuFjH8Ycw6uUs+eIr5paFA/4sH3K4Qz0BLCj5RO0SB5m4VReZb8yLspLBMiczkS50BMUPjQJjpBl6+lQbTn04BTSQ7d8vw2rM=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DM4PR10MB6863.namprd10.prod.outlook.com (2603:10b6:8:104::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Fri, 16 May
 2025 17:21:53 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 17:21:51 +0000
Message-ID: <dfbc8c7c-9f35-42c4-8fa0-0bae8a789f6f@oracle.com>
Date: Fri, 16 May 2025 13:21:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 06/42] vfio/container: register container for cpr
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-7-git-send-email-steven.sistare@oracle.com>
 <161947a0-f3fb-4ddb-b6c1-6e1a1e4d6849@redhat.com>
 <2f36f035-6704-4a73-a9e7-953c27fb32d2@oracle.com>
 <d989b8a9-16cb-4b5f-b6cb-299ce93883f5@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <d989b8a9-16cb-4b5f-b6cb-299ce93883f5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR02CA0041.namprd02.prod.outlook.com
 (2603:10b6:408:e5::16) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DM4PR10MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: 12c7e9d1-f674-4844-16c3-08dd949e258f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2xrd2VaSGFrNCtxOEJNR2VzMU01SXBMTlh4NUhZUGJScUJrdVBnZFo1K2Fk?=
 =?utf-8?B?dnBCS01LNEZQUnJIY3NJVkV5Y0wxTnFpNldub1NVTW9peU9pc1FmbDAyL0F0?=
 =?utf-8?B?bnorWmdzYnRHNkt0TmtsaWswYnZpSkM5bDZsK083Z3U0dmVLdkN4VzJZMjdD?=
 =?utf-8?B?LzQ0cVA3K2Mxa1h5dzNTbmhPdjlTZ1d4Y2h2dEpHU09DL29kcVhCS0kxQVRZ?=
 =?utf-8?B?clo1MHQ0UmNiSWpMRTJua0EyWVZRM1BINXcwbGV5SVpkZHhMOElwL3pPNGdP?=
 =?utf-8?B?Uy9pUWlpOThmcmlvN0phdVpoZFZDNWowdDRXKzhEU3ZIRVNSTFJySDBDTDNV?=
 =?utf-8?B?c1JxZkYyeHRLd2NMc0VUVmFlcmVSVGp4OEhFdEltSHNUMmMvUkpLNEJOL3FR?=
 =?utf-8?B?LytWeDQ5U2RFcFNQRHFZK0RycEpLS0hCNE1YVTRPeHUzMksraU9XYWlQTXJp?=
 =?utf-8?B?alRpdmJKL0FjWXZyditaZFgxMUd1aWpTdnlQK2NxcnFnZlJIcysxWG5MNmZW?=
 =?utf-8?B?TkNGRnN1NUZKZ05vZ1YyRS9OcUQ4NFFhNDU1VXBBMk9nbDU5K3E1QXl4dEt3?=
 =?utf-8?B?VFJ1d3NhSlY2RHRaVWw4SklicXVWMEhXdzhMN3RoTzRyRkxHTjVBU1JUOWph?=
 =?utf-8?B?YjllMHArL0RXYzF6MEwxUVBFTkpJYmF3RFVST2lSYWJoejZXU0pCbm9Hckxw?=
 =?utf-8?B?YTR1WjN6eksycVg0cHJucU5mbXhwMmZaTGFwQ0UrUVRKbHNIaG5BVGdPNDZa?=
 =?utf-8?B?Z1gyN2dpSnJud1A0c25PRE1QSjlRUFJyWDVRb1drdVc1dzdFYWVNKzlQTjJH?=
 =?utf-8?B?UmNnYzVSWlEzVjk4UHF2UFJocDlON3J0YzdUVjFna29taksvUjlTbVU4Y2hM?=
 =?utf-8?B?Z0l3QjBvSGV0TTNZR3d3bVZoMVNzM3ZsR0pjcVlpNVUvelZpU3RVbnVkbktF?=
 =?utf-8?B?dTREb1Z2MlVpWkZJYzhJMi9VaFVqZ3JGTUp2Q0dlUHhad1c4UEhYWE5zdUJk?=
 =?utf-8?B?dDdKV01saktGUDhrTUs3UC9iRXkxZE9qaHJIZDlySXVsTzJ5SkFuVzJtQTJU?=
 =?utf-8?B?bEkvbDJNaGdGSnRoRzRNdHBOdjR5RHB2OXB3cmcySUJ2bzArMnc0cE9INkdQ?=
 =?utf-8?B?bWRESTFVeFFQQTFCUDlnWXpKWDZLVHhDeCt4Z1ZhTzRaU0VUOWd4RXp6ODhn?=
 =?utf-8?B?dGloa1VURVJ5SEZJTktJZzExN3VTUVhxRUFXWHpWaEk5N3p0OHN4M3g3VEJ5?=
 =?utf-8?B?WEw1dnpNN3V3bVk2WGNJelFIMysrTkpDc0dmemdlekVYWHRnSXFuNlVlOTh4?=
 =?utf-8?B?d3o5UjUyaEhvUHB2c1JOYUVIU0FVR2hrYWZqN2lsaUN0cmFWdjVKL3p4eWFE?=
 =?utf-8?B?Z0xySzNkWGN1Q0lHVXVHbWJXME5JK0FVczJFQnJxVFdxQ0c5WWZ0Y2F3WVJJ?=
 =?utf-8?B?NndYMERwcVZFTHBnNWpqOTYzK2YvcWtlWTAxMEFwWjEra2pBZkxNczFLQ2Vl?=
 =?utf-8?B?Ry9wNWNPb1h3UnZQbEd3WXdWNWlJZkhOWCtBVWlhakxmc0l3Z2FwK0lBZE5U?=
 =?utf-8?B?VFJZSFlEY3ZlUG4rZnVDdHhkRGhydC9zNk9qdkNianZycGx5d3llL2p5Vlly?=
 =?utf-8?B?bnRzWkZCTklhYlNLSWlxemdvcDlyb1QvWU16VG83K2dFTVRZNG1sVzQ4c2dI?=
 =?utf-8?B?c0N2bEIyWCs3bTh5OFNIUjIyK29LVjgzNnVabXpIeVV1MmN6ZStFbWNsUXZk?=
 =?utf-8?B?NE1IcGdOMnpoOTI5UEhHeDRZT3dnVDBuN1NjNE9oNlJIQjdhTUU3M1cwcnQ0?=
 =?utf-8?B?N051alhxRUtzQXNydWo1ek1XcVhKRnMvRHlFNUdqY3RqZVFZOVY2b3B4VURT?=
 =?utf-8?B?NzJKNXNnOWpYVndkSnVKcmRFMXpJc0JPY1hzSERCdlVUaHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGRKV2hqeEI3MWVucTZxb0M3ZjcrdlpSRFV2QXB1Tk1LdlYxNjl6Y01yL1BD?=
 =?utf-8?B?S1ZaQ2J5KzFOMGJXUnFPUVZub2UvaDBuZnRLeUpQcTZGOThWWFYyS1JoSlJK?=
 =?utf-8?B?cDdNVkNPcGw3MVh3RUI2WGpNVzBreXluWTFKZm85cFp4elRaMW9QMEp4dUU1?=
 =?utf-8?B?b3B0dGR3SURZQUlEdmdBNjRnMFg0WHp4WmJRa3hkOEdmS01EWHFYSVlHTVVo?=
 =?utf-8?B?bmlCQjYvNGdVSW51dXdzTllHTTBJYk02dWIvS3RtOUcwU1JKQ2FiWWFYVEU4?=
 =?utf-8?B?R1R0K2xCTmhKUHp1L2VmcmFZdWNkdXRrZzZkSUFzVWFIbU9ySWdnZG90bEdt?=
 =?utf-8?B?WEFIUDJRdXlGdEtGcTRGcTVwNG1FUGxuZUdtMWVHQ1hoWnpHejVVVGpwOENU?=
 =?utf-8?B?V2RoVEQ1eTQwNXFzOUZtak03dW9hc2tOVTFIYS82dVhuOU5aeDNKWWFQU3pF?=
 =?utf-8?B?bXpMQk9yMEZtWG1RcHAzYUVQdlNhcjhBdjgrd044NkRUUytKbWZvTy9Fb2V0?=
 =?utf-8?B?QVhjZm1udlJhaGUyL2NNcU1ZQ09iRDZTcTlnWFE4UEtsa2UwSU4zMkRLT1N0?=
 =?utf-8?B?M2Q3MWhLdjZzZHhEaWZ3QkVsaVNnbDEzT3dJK0gvenFmaFVKdGNNRVZ6Vmhx?=
 =?utf-8?B?RDdCa2YxZ0I5aWh3cjNWRzhCRFhBV24wZXc1L0QxTGlhVnJVbS9XRkVLQmMr?=
 =?utf-8?B?cXhCZ1ZpK1NFeHRKT3VjMFRLY2FubVJwQk1IQXYyT0VNYjBKTnl6TXZ4cE02?=
 =?utf-8?B?aEphVzZCV3RPOGREdGxSZGFEMmtUWkk3N2tScEFmWS8xSEtCUGFiQmdLbDlX?=
 =?utf-8?B?RGZMTjRUYXBEL2FkS1dxSVhlTThzdGZ1dnNTUVBlT01hSWh2TzhZOTFJalJE?=
 =?utf-8?B?c2o3VmFBUXdKa0hjUVhPL0RKcVh1UWRiMnlWODZ0aHhKQnBYNkhuUDNMMWht?=
 =?utf-8?B?R3JBSks1NlJ3MW9YYWxpcHhvZCtLUXlESVlvTCtjT3lLOXpkMFFQSWRuQnlZ?=
 =?utf-8?B?V0RtdVJmYzFzUmtBWXcyYkJpUW9kNXd4Sll1c1BpamJEVHQrWlFiZ1B3YnJh?=
 =?utf-8?B?MlRYQUFxRmUzSTk3R0FRN2c1ZEpKcXJJV0ZzR3ZyMEZCNXVpdGpDWmxlcHV4?=
 =?utf-8?B?MUJzVXhQYWg1a3RMMEJZM0ZDZ0cxT1JVTXJoblNXclRNTW05K050SzhOYVBQ?=
 =?utf-8?B?RW1nVW5TZTJYSnRmWnBPSmNseHBqOXVudE0xdndiZXF2QzZORk1hSTVncnNS?=
 =?utf-8?B?R0hVNVZPZVA4NWwzQkxhZGZ0d25WRW9TNUFFQ1h3bEFXVkNIbTlVYUFGTnFF?=
 =?utf-8?B?bzhwZ0FXRTVvSmxhZEFQd3RFM3FhYXo2dHozS2EybmwwT2FreTVPUi9oS3FM?=
 =?utf-8?B?TkVFWnRUL0UxTnMxNU9Cc05iM1lpMmplTFQ0S3NXR3JXTEg5TUtYSUtQV3M1?=
 =?utf-8?B?eVp3dCs1UjZTN3hZY2s5ZVNFdmwrSWwwWFlWUWxHd2tPZnV0TjA2VTB1Vy84?=
 =?utf-8?B?QlNpM05pbndLZFRtdDZnR0RDcWF0WkVVWEU0d3BaRk9qbkVMSlRTNEV1Y2FE?=
 =?utf-8?B?MUdwSkRINkZYRkdRaWc1QmxjeTVqYmdKSncrcFEwMm1GQVJIWlJwRVg0WmMw?=
 =?utf-8?B?YlZoZVlabVBSUGxGbGt5d2tmeW1PNXEvOEZLWHZ1ZnJnUWlLcTdjbEZYajFY?=
 =?utf-8?B?VHZMTmNzS05NS3FIWWZnR3JkQm9ZcmJsMHpEVkJXUlZQWjFYc09KNXRreVVh?=
 =?utf-8?B?NmkyUFoyYXZweGVqSHBtb2xhZVE0Um5XVVdab3hidlcvRktmMkZ0a3hHOVo4?=
 =?utf-8?B?cTJxamRzZXNaNzZRZlpVZThtaVlxcHhaZmYxN1l2TEJrcjFlR25wTWpZWERP?=
 =?utf-8?B?ZUJIUkNrWW9pMmJqd0tOTkRXL2lPNHRNUG9hSHJIallJbHVybXVlNmVwdzF2?=
 =?utf-8?B?KytlU2lZQjJQeFhwUHczem92SFRKU2MxQlJNWlBySm5wV091WGR4UkNnNjBC?=
 =?utf-8?B?TmcxZGZKWmh0M1FYOFRlU0lkSjI1SktQSFoyT1B3Y0Z1UUZrZWNkZlNpTWsx?=
 =?utf-8?B?RXQ1eWlqQVpadGdFZno0NG1vTUkxcU5NT1dQRGdWS0V0UXBEbnhQQ0VZRWZV?=
 =?utf-8?B?UE4vNGtoVTRqUi9KYkFkci9sMjB3cmVnbTdEMmZmN0FoMm53OEJzK0RWN3g3?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NbiryYVJnhAdMQ4Tpvlgp+yJDb0u0gISPpEksGyD3vLcgxWB322dlVAv+mmD/g78ZQ0d64jZ3irtYppziIO6hqVGSiXtMvCIUF0Pv1/LCQfe9bP9DsX+u3u7IywXQbxZZUIOGwtPfaNcT1qhR28DtwYCXNLfi8lmD4YAfybksVoTEuFMhr5vPtuqejwmagj7TnMhDYp0N0rFjz6FjrjK5wYUYA8qehf5XFphNze/jRAzbD0fZZ4gwAwE+QEdusqdN5Ws3SAcxQhP+wZAK4ifV6o2kkc7ostjRjSevHSSzyIY3QcUf8Z5dvoF5PdifZGFmqhp4OwXnRLGJrvir57g0v/0qmPI5S72JLrXuCnUd+M9A1tcUkulRts0kv3XIWfIA+V0Nvqh24v1J2mc2pPePYxIo//ic1l8FJQZY4SOBEgtb7Xm9QtGSOFueEjeLg4/09/x5vcuvGYYtguiphyN4eTIRJSf5Xs3g81PfnjabDY331rkITSCTO77wmfiVTS7b2mF+E7BU+k058mkcvWsw6OG/6nIq7F9YGp3uIPJuu3ZnZQWF9MguWc1liNHWyDgGdB4qrS+Vjz0oi8W9O1NgmH70fvLz55WvAEpq+7UnpQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c7e9d1-f674-4844-16c3-08dd949e258f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 17:21:51.6234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lj8WFIytfqXJGP1vKy+VYNgr+cak0qyiNQ9bHCgmNCISJNgoaGn+Psl0VIMqri69yJ5o2mkmkIUW/16MDY+frOq2j8N6UqgchZrVLxQV/vs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6863
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505160169
X-Proofpoint-GUID: WBqyWQEz82Pn2s6zjrRAEKPg0PQUCtfz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE3MCBTYWx0ZWRfX0srRlQvfN80C
 98S+BW+CPWvmhKqVHIyejD/aHAB71306KwrjGueAA05sdtRRB9e+NkgunTID+AkeI1+8tiHxZkh
 gHoobVlFB0ixw+v8zaNvNSbBaN08yWKqHwSVUCfDPojBZvhZR5jiAEe5e/TD3lslaIA/Ry34OVF
 kVrYIOqi6Y+QwjvXT/OcONMpg/wcXse6jW4DZ6a8K9o1w92n01c54rAG4kttxB/dh8SPxOo2TrW
 LQ9t8pDYF+0wKmyjMb1mU6JWxgtiUuYwdP2/QU7Ln8s7inpwSTpbCdL96BQG17rRAQqF7NHet0l
 DgJ2KNDE8A+5dHjqcvMUjUoIvFvG2FvoER5ImuwM+t8X2giTDeKyBKhTwo50xGDGFyCTUJunBNa
 23RDjIN811jLAzQKLz2F16QKCmmwfSsZdbUPCkGrJPPka6MOSkRXPLjObMv8TSR1dbFaFLzs
X-Proofpoint-ORIG-GUID: WBqyWQEz82Pn2s6zjrRAEKPg0PQUCtfz
X-Authority-Analysis: v=2.4 cv=O9s5vA9W c=1 sm=1 tr=0 ts=68277435 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=t5MAlOEddGjKwt0j8K8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13185
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/16/2025 12:20 PM, Cédric Le Goater wrote:
> On 5/15/25 21:06, Steven Sistare wrote:
>> On 5/15/2025 3:54 AM, Cédric Le Goater wrote:
>>> On 5/12/25 17:32, Steve Sistare wrote:
>>>> Register a legacy container for cpr-transfer, replacing the generic CPR
>>>> register call with a more specific legacy container register call.  Add a
>>>> blocker if the kernel does not support VFIO_UPDATE_VADDR or VFIO_UNMAP_ALL.
>>>>
>>>> This is mostly boiler plate.  The fields to to saved and restored are added
>>>> in subsequent patches.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>>   hw/vfio/container.c              |  6 ++--
>>>>   hw/vfio/cpr-legacy.c             | 70 ++++++++++++++++++++++++++++++++++++++++
>>>>   hw/vfio/cpr.c                    |  5 ++-
>>>>   hw/vfio/meson.build              |  1 +
>>>>   include/hw/vfio/vfio-container.h |  2 ++
>>>>   include/hw/vfio/vfio-cpr.h       | 14 ++++++++
>>>>   6 files changed, 92 insertions(+), 6 deletions(-)
>>>>   create mode 100644 hw/vfio/cpr-legacy.c
>>>>
>>>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>>>> index eb56f00..85c76da 100644
>>>> --- a/hw/vfio/container.c
>>>> +++ b/hw/vfio/container.c
>>>> @@ -642,7 +642,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>>>>       new_container = true;
>>>>       bcontainer = &container->bcontainer;
>>>> -    if (!vfio_cpr_register_container(bcontainer, errp)) {
>>>> +    if (!vfio_legacy_cpr_register_container(container, errp)) {
>>>>           goto fail;
>>>>       }
>>>> @@ -678,7 +678,7 @@ fail:
>>>>           vioc->release(bcontainer);
>>>>       }
>>>>       if (new_container) {
>>>> -        vfio_cpr_unregister_container(bcontainer);
>>>> +        vfio_legacy_cpr_unregister_container(container);
>>>>           object_unref(container);
>>>>       }
>>>>       if (fd >= 0) {
>>>> @@ -719,7 +719,7 @@ static void vfio_container_disconnect(VFIOGroup *group)
>>>>           VFIOAddressSpace *space = bcontainer->space;
>>>>           trace_vfio_container_disconnect(container->fd);
>>>> -        vfio_cpr_unregister_container(bcontainer);
>>>> +        vfio_legacy_cpr_unregister_container(container);
>>>>           close(container->fd);
>>>>           object_unref(container);
>>>> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
>>>> new file mode 100644
>>>> index 0000000..fac323c
>>>> --- /dev/null
>>>> +++ b/hw/vfio/cpr-legacy.c
>>>> @@ -0,0 +1,70 @@
>>>> +/*
>>>> + * Copyright (c) 2021-2025 Oracle and/or its affiliates.
>>>> + *
>>>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>>>> + * See the COPYING file in the top-level directory.
>>>
>>> Please add a SPDX-License-Identifier tag.
>>
>> Sure.  I'll do the same for my other new files.
> 
> and remove the License boiler plate too please.

Yes.  I understood you wanted me to replace one with the other.

- Steve

> 
> A newer version of checkpatch will complain with :
> 
>    ERROR: New file 'hw/vfio/cpr-legacy.c' requires 'SPDX-License-Identifier'
>    ERROR: New file 'hw/vfio/cpr-legacy.c' must not have license boilerplate header text unless this file is copied from existing code with such  text already present.
>    WARNING: added, moved or deleted file(s):
> 
>      hw/vfio/cpr-legacy.c
> 
>    Does MAINTAINERS need updating?
> 
>    total: 2 errors, 1 warnings, 152 lines checked
> 
> 
> Thanks,
> 
> C.
> 
> 
>>
>>>> + */
>>>> +
>>>> +#include <sys/ioctl.h>
>>>> +#include <linux/vfio.h>
>>>> +#include "qemu/osdep.h"
>>>> +#include "hw/vfio/vfio-container.h"
>>>> +#include "hw/vfio/vfio-cpr.h"
>>>> +#include "migration/blocker.h"
>>>> +#include "migration/cpr.h"
>>>> +#include "migration/migration.h"
>>>> +#include "migration/vmstate.h"
>>>> +#include "qapi/error.h"
>>>> +
>>>> +static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
>>>> +{
>>>> +    if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UPDATE_VADDR)) {
>>>> +        error_setg(errp, "VFIO container does not support VFIO_UPDATE_VADDR");
>>>> +        return false;
>>>> +
>>>> +    } else if (!ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UNMAP_ALL)) {
>>>> +        error_setg(errp, "VFIO container does not support VFIO_UNMAP_ALL");
>>>> +        return false;
>>>> +
>>>> +    } else {
>>>> +        return true;
>>>> +    }
>>>> +}
>>>> +
>>>> +static const VMStateDescription vfio_container_vmstate = {
>>>> +    .name = "vfio-container",
>>>> +    .version_id = 0,
>>>> +    .minimum_version_id = 0,
>>>> +    .needed = cpr_needed_for_reuse,
>>>> +    .fields = (VMStateField[]) {
>>>> +        VMSTATE_END_OF_LIST()
>>>> +    }
>>>> +};
>>>> +
>>>> +bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
>>>> +{
>>>> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>>>> +    Error **cpr_blocker = &container->cpr.blocker;
>>>> +
>>>> +    migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
>>>> +                                vfio_cpr_reboot_notifier,
>>>> +                                MIG_MODE_CPR_REBOOT);
>>>> +
>>>> +    if (!vfio_cpr_supported(container, cpr_blocker)) {
>>>> +        return migrate_add_blocker_modes(cpr_blocker, errp,
>>>> +                                         MIG_MODE_CPR_TRANSFER, -1) == 0;
>>>> +    }
>>>> +
>>>> +    vmstate_register(NULL, -1, &vfio_container_vmstate, container);
>>>> +
>>>> +    return true;
>>>> +}
>>>> +
>>>> +void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
>>>> +{
>>>> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>>>> +
>>>> +    migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
>>>> +    migrate_del_blocker(&container->cpr.blocker);
>>>> +    vmstate_unregister(NULL, &vfio_container_vmstate, container);
>>>> +}
>>>> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
>>>> index 0210e76..0e59612 100644
>>>> --- a/hw/vfio/cpr.c
>>>> +++ b/hw/vfio/cpr.c
>>>> @@ -7,13 +7,12 @@
>>>>   #include "qemu/osdep.h"
>>>>   #include "hw/vfio/vfio-device.h"
>>>> -#include "migration/misc.h"
>>>>   #include "hw/vfio/vfio-cpr.h"
>>>>   #include "qapi/error.h"
>>>>   #include "system/runstate.h"
>>>> -static int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
>>>> -                                    MigrationEvent *e, Error **errp)
>>>> +int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
>>>> +                             MigrationEvent *e, Error **errp)
>>>>   {
>>>>       if (e->type == MIG_EVENT_PRECOPY_SETUP &&
>>>>           !runstate_check(RUN_STATE_SUSPENDED) && !vm_get_suspended()) {
>>>> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
>>>> index bccb050..73d29f9 100644
>>>> --- a/hw/vfio/meson.build
>>>> +++ b/hw/vfio/meson.build
>>>> @@ -21,6 +21,7 @@ system_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
>>>>   system_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
>>>>   system_ss.add(when: 'CONFIG_VFIO', if_true: files(
>>>>     'cpr.c',
>>>> +  'cpr-legacy.c',
>>>>     'device.c',
>>>>     'migration.c',
>>>>     'migration-multifd.c',
>>>> diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
>>>> index afc498d..21e5807 100644
>>>> --- a/include/hw/vfio/vfio-container.h
>>>> +++ b/include/hw/vfio/vfio-container.h
>>>> @@ -10,6 +10,7 @@
>>>>   #define HW_VFIO_CONTAINER_H
>>>>   #include "hw/vfio/vfio-container-base.h"
>>>> +#include "hw/vfio/vfio-cpr.h"
>>>>   typedef struct VFIOContainer VFIOContainer;
>>>>   typedef struct VFIODevice VFIODevice;
>>>> @@ -29,6 +30,7 @@ typedef struct VFIOContainer {
>>>>       int fd; /* /dev/vfio/vfio, empowered by the attached groups */
>>>>       unsigned iommu_type;
>>>>       QLIST_HEAD(, VFIOGroup) group_list;
>>>> +    VFIOContainerCPR cpr;
>>>>   } VFIOContainer;
>>>>   OBJECT_DECLARE_SIMPLE_TYPE(VFIOContainer, VFIO_IOMMU_LEGACY);
>>>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>>>> index 750ea5b..f864547 100644
>>>> --- a/include/hw/vfio/vfio-cpr.h
>>>> +++ b/include/hw/vfio/vfio-cpr.h
>>>> @@ -9,8 +9,22 @@
>>>>   #ifndef HW_VFIO_VFIO_CPR_H
>>>>   #define HW_VFIO_VFIO_CPR_H
>>>> +#include "migration/misc.h"
>>>> +
>>>> +typedef struct VFIOContainerCPR {
>>>> +    Error *blocker;
>>>> +} VFIOContainerCPR;
>>>> +
>>>> +struct VFIOContainer;
>>>>   struct VFIOContainerBase;
>>>> +bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
>>>> +                                        Error **errp);
>>>> +void vfio_legacy_cpr_unregister_container(struct VFIOContainer *container);
>>>> +
>>>> +int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier, MigrationEvent *e,
>>>> +                             Error **errp);
>>>> +
>>>>   bool vfio_cpr_register_container(struct VFIOContainerBase *bcontainer,
>>>>                                    Error **errp);
>>>>   void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
>>>
>>> what about vfio_cpr_un/register_container ? Shouldn't we remove them ?
>>
>> At this patch in the series, those are still used by iommufd containers.
>> Those uses are removed in "vfio/iommufd: register container for cpr", and
>> vfio_cpr_un/register_container are deleted by the last patch in the series.
>>
>> - Steve
>>
> 


