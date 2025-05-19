Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C096C3DA6D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 15:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH2mR-0005zn-UR; Mon, 19 May 2025 11:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uH2mO-0005yB-NC
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:51:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uH2mM-0000RD-00
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:51:52 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JEdBNG001163;
 Mon, 19 May 2025 15:51:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=cGEgyIDoEmiU2D/yFBx9ObN16sjVP84jUFrwtpHsj50=; b=
 V9Jiw1JTIxCGMnPeWTVVzW//qOM70j5X5qvBJ+qCociTp01VTqtIxHwuk+I+Tl90
 0JlF0q7hA97DgezBT6i/LPpYiBIf2ZiX2OKIgsziJulWcCKZNQnz42eAG5UxE7aF
 HQA37m6+dklgsXYEeIAQS5F4x7l0+MFS241dHWdH1M6Nx//MhWVjE4lHWeXQC5DW
 j2ch9+hBQDgp/llJ7fyp6nD5fr8ywOPGZPavG5DnwOyrShvnLANbOexPynO097FE
 xKFjFD6LNjb77delinXNfmUYO8lJIrDIFHej2Ru1pnqUiA5hyWvKdE7FnBUP4HrA
 2FXOqjSlXh/YBIvi4zDPow==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pjbcuans-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 May 2025 15:51:45 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54JFIGmL000805; Mon, 19 May 2025 15:51:44 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46pgw6vuv8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 May 2025 15:51:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMzeIYCnKFYF2qI117H0FF3EEuFdmQb0i1HBFAq4Ri7u6pSij2AFFCbk2XUVu2hDVf3KdGt3izMsfg/ML1qVCNUVRM3dBJ0IV0cF8Bp66Lj15LHpQlT9xZViTVSwzl5xSeWkrxzCf3UlJAN/MrfxEyGymybMbBHm0+jkbb3udBplZkJptqe7Lzue/aaZL4yPxwmTQBJ/U/pfyTTAir46/cXmJEXFB0JMfgxBd8n8Oz03MFt5w3krB+Ks88z+p2+ta98zTHXznzrl2Gz97wRh0qqW28P2PrwxJC8wZMhNWmzKVbL1xeqddGv02GhFju39btTRnIS6WQ/6axTQjqcc+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGEgyIDoEmiU2D/yFBx9ObN16sjVP84jUFrwtpHsj50=;
 b=lrxvq/PSsyP3s/5M1/pCHkeJWNcEJP0ni+Wsza0KU5O0SPudMTOwWVyqI+1pM2K5jiY6Lc6IqXwW6pMq+3OU2PtczTHYPudmnOSGD8PNPt7Mg5UHWhBnicuVm382yiELaIJm25JqABQUG9k9w7HI1EULl8qjVWLxrX7DfyseBC/vPPTVGjiV6hLmo917uwAaGgn982WXVKwG+TGoM1BphcKvxzNk7cjZ1K+klyN2QR/ZChb4sK27XYRN9lMVXNFOSXWK3op9EJ88QW1c2Ex+wkj7OINHEEux1ujsXKxcn3pVQ3wInILaiKhP/s6+sUTpwVnoPJ3Jm1+on0QaocFrmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGEgyIDoEmiU2D/yFBx9ObN16sjVP84jUFrwtpHsj50=;
 b=nKpOb8uC9e/8VsaDmNlaC/9f/GyW3mgUgz4meVsM+XG4iqPvjVPExHNJU4hia4hG7nECfbNQw5wDucekONm7G0UFXet6ekoRRAnuC6BcCJd1eWIJIKii3ruRNcQQUouBY0uewNJ2XIBHMxWQWhauWrfnOdRASVuY91Hm7rZ0YOs=
Received: from CH3PR10MB7436.namprd10.prod.outlook.com (2603:10b6:610:158::7)
 by PH7PR10MB5816.namprd10.prod.outlook.com (2603:10b6:510:127::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Mon, 19 May
 2025 15:51:42 +0000
Received: from CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54]) by CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 15:51:42 +0000
Message-ID: <c0a4593c-dbfe-4e9e-a90f-d173b388e34b@oracle.com>
Date: Mon, 19 May 2025 11:51:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 28/42] backends/iommufd: iommufd_backend_map_file_dma
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-29-git-send-email-steven.sistare@oracle.com>
 <SJ0PR11MB6744903C16544B81D8317DDF9293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <SJ0PR11MB6744903C16544B81D8317DDF9293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::6) To CH3PR10MB7436.namprd10.prod.outlook.com
 (2603:10b6:610:158::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7436:EE_|PH7PR10MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: fc468141-555a-4b96-7b51-08dd96ed0cba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzIyYmMyU2N0elMrazVzYnV2SG52cmdmN3NFOGpxQnlxMlppS2pzRkxyZXVV?=
 =?utf-8?B?WGVTdHJkLzhCZmgrdmNKZkVhbkk0TUk5OC8zT3E1dE5xajA0M29Dc2E1OXFl?=
 =?utf-8?B?NE0yR2JsU1d2WmppU0lYc25FeGZxd2JpNk5UU2M3QTdOVko4cllGaFFBUVdC?=
 =?utf-8?B?dGJPRXlzb1VsTXVRMUVpN0RPOVI5SEgvOGg2eUhTSndkK0pVd3NMaklvNzE5?=
 =?utf-8?B?aTI1a2VTV1lERXh6YTRnN090TmJCOGp0MHZGM3hINDRKclNSdTRUdWJYN1VB?=
 =?utf-8?B?ZURsbmhaVERMZkswazdDcnAxWm9zcHYyMzh2UzdpNWpRT0ExSysyZVlYdmlC?=
 =?utf-8?B?V3dqU1lnRjl5TkhnR1BJSFdYWml4NytkNTVYcVVrUzJjSm4xclhTWnJ5eDhm?=
 =?utf-8?B?UVkwWUtOTTR4N1FCMGpYODhVWndaeW5iOXgwN0tVM3ZsQmJ3YVc5a1FTaVJH?=
 =?utf-8?B?TUNMTVg2TlFFdU9jOGVYSW1BbFcwM0dkWnBabWx5am1FU1ArbG0yd0JpVFpG?=
 =?utf-8?B?LzJFK0tiUGU5VS9tNHBSczhyak9haFowYlZ1YW9NbkJ3UHdpVGlJK2VJZzdD?=
 =?utf-8?B?RDBsQ1Jld0hIVk1sSUwvaFBXcUtFNGFnNER4OVNjVXpUbEJ2VlVQNGNPT0w0?=
 =?utf-8?B?bjBLVGxRNnFIY1RaYW91SkVCNlh2QUViaEtEZjAwa2xnR3IzMnZNbG5xSFVz?=
 =?utf-8?B?ZlBBUXVVeUh2SllGamt6c2hIaGJrQ1pWQzhIYjBNOGdia3BOYm5MLzd4cW53?=
 =?utf-8?B?aWRIRTRpeGNPdlBZS0hIWkV0RWtpamN0VElLN04xV0xWUjlUMDZWV3JidkE0?=
 =?utf-8?B?M0hhV3VIUHNOYTRTV3l2czRzRTdnMEdqdStlc0Z5N1Q4RFo4V1JpaDZxWlZL?=
 =?utf-8?B?bDBpTlg2RGU5OGlCZ1UvNTRrSEZSR0loVFplNzlsZ3RvMEFETjVXY0RWU1NR?=
 =?utf-8?B?NG5EYVZNaEpXSUZaOGNrODAyU05IZE5NTHovYVZCaVZvRVVDcFF1UUJ5dGRC?=
 =?utf-8?B?enNFSmJJZkZyWHdtcUJqS0FoeXdVd3ppZ3FhNEk1VXVIT1VzN1BadU5YVDNB?=
 =?utf-8?B?ZGVvNE5JblFsWjdJQXFaUXp3R1pOYTZPdkQ3Q2k0NTdna21EdG85SUJ3N3ZU?=
 =?utf-8?B?RmtlUGtjaW5TZVR5OThibXJmcmhXV1dLNXBvcXBhNnBuYzlmbkNwek90VVly?=
 =?utf-8?B?SEJ6ZXdQTitPVlAwMW55V1pxRGorNU5nUGxPb0VUVkVqWEZKengyUHZUM1Zk?=
 =?utf-8?B?di9vQ1ZZNnBrRkhNUHlMbDJET3ZhUFN0OW1odW0rempxVnVOMXJCSVNacy9k?=
 =?utf-8?B?VDdxTVBYYzQwbkkwMDRxWDRIbGhhMzFCM29jUmg1UXpaQmVJamZBU1MwaU51?=
 =?utf-8?B?UDY4eGE0dEtYZ0JkbGY3TGRyMGw4azB3cnBuMUNVTFVCS1ZzQUQxTnUrZXZH?=
 =?utf-8?B?ZU95SXl6aXl4L2RXR0M2dDZiUGVSVTBpcU0zakNiRk1nQm1PYWZrMUxRcUpk?=
 =?utf-8?B?eXQwRzAvVWV5MHBKd1NEV096SnhGSVQ4ZWJwVkF0SjZyTlJ2YXEwVS91VGxT?=
 =?utf-8?B?NWlMeDRBdVBJUkp3WmhCRFM0VWl6UlhiWnpvM3JwbWRmSEQ2dVl0Y3pNTmNL?=
 =?utf-8?B?NTZhaCtkVjFrQnpDVllialN3OEh2eUF4QXEzbWpPdWwxTyszVG13MUdKQzJL?=
 =?utf-8?B?WU9Ib0xqbWtoanpmbmJoNlQzblVkbE9iZXQ0ZENQaUNLVTcwd2h2eGFmQkJU?=
 =?utf-8?B?NzI3TTFRU0V2eVdRdFdBaVJWeHNCbVp1b0tFcnZMZHkvaFVoVXJGR2dzZ0k0?=
 =?utf-8?B?Q0JiZTU0dWcxbXBwb0tRTkttQStEVEVpeFJJNmM1S1RVaTEyWkFkMDQ5Y0tp?=
 =?utf-8?B?NkVURGVoSW1idTFlcm5sV3Nzd1BFWmVMUlZHcnBmNkc5VDgwanBDY2VPSE5u?=
 =?utf-8?Q?sTJL+UaIIQE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7436.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWRUNTFHQ1YraHlhS0MrZ3VYK1VkazYzNjBGMndwOUlpOUlFTFkyNHdSdDhF?=
 =?utf-8?B?bFhTRkpOTkVNajJGQ3Z5c1pUdUlrOHpLbnhqYjMvZ0xNOHJXcUlhNXc1Z3Q0?=
 =?utf-8?B?bXVkZldRa1RYZmRnSXJyWWhiSXBqam5nUU9JME9QYnRyUi96bDhkSHcySG0v?=
 =?utf-8?B?MStTWlZ1NWtpWFQ1T3NOYmd5cjVzdFRyeHNJVm03MzlHMk9YMHdzLzU5ejFE?=
 =?utf-8?B?alVEWVpvanN3V0Z0empNeG42QUh1cEJKWmpPejNEL3FuVGlsL0NhZXp3dFZW?=
 =?utf-8?B?MEpyMGdJRWczVG9wVWZxNElxM1JhendCUUlHMkNkbTN6RVozRjZvRmZJRFpM?=
 =?utf-8?B?WmNOM1JoZEhWZzVNdk1JcGMwV2ZyU2VDZldiRXE0K25XRHVWTUJqWVYxZTZE?=
 =?utf-8?B?bXVRa3B6V1UvSDhMNUYvZ3lZVEowYTMwUmY3OU5SNzFMbTNFZ0Y2eXUwYkxk?=
 =?utf-8?B?L0Z1cmFlL3VicG5lNXF2T0pXZlJPcTNWeDkyVGhjbGJpajhtYlVuNTRveWd0?=
 =?utf-8?B?blFySlpSN2s5SkNVWW53WVdLcm4yT0JsYVErbms4OWwwL1djd0xFNU1uYmRt?=
 =?utf-8?B?cjk0Q1lSWG5jaXE4Njd6RWJpc2dzQWMwT1dxOXIvSDhRbzEyRmhyWEJhQmtO?=
 =?utf-8?B?c0JxRFdVVWZTRkhjOS9tNHZ2c2VDUUxtc2hXWHFXKy9ucW01MXZWYlN0dXhm?=
 =?utf-8?B?Rm5LZkc2cCtZbkIrZmV4bFplS0p3NDU1TjhIRmVGckE2cm5MbFprZ29UMG9p?=
 =?utf-8?B?eC9VbWNNa05JM0RZdDU0S3VWc0dOS2VaRTNqdnA0ZWx6a0RwNmFJSnVlclJH?=
 =?utf-8?B?SGpXcUkyS3dJT1ArNXdnYjVnUmg0NjNhYWV1ZW1LYkNYdjZzZ1Q4b0t4eXBD?=
 =?utf-8?B?U2lUY2dzK3ZVZDh4dGNDTWpuaE52UnFRVm5ob25YUkpFL3prRmh5amdxSVU2?=
 =?utf-8?B?VEZ6MWU3REphK2p1LzV4L1dPbjhnQlp0R2dsSHZrdmNWS2xnODhJWW1SaGRJ?=
 =?utf-8?B?OWxxUy9OSllCUUZHUUNmSkxEcXZ1TWZPYkVPajJ0SmxGcUFvdjlSMUljSzI5?=
 =?utf-8?B?amxjaHRYNnNHSEJHSm4yalZXVDBJVkkvY3VGdWhXQ0IyRXVybVBOVk82Szhj?=
 =?utf-8?B?cGdKQWxPbjlzRUtLOEpiZDluelViak1mVGQ4ajJlVkpLZnl3TmsvV2haN0ZG?=
 =?utf-8?B?Z3hCV0M5ZCtYVTYwYVdnTFdqSmpUOTZvYUh4Mld0VHV3SzZvUUh0N0NJc081?=
 =?utf-8?B?cFB6aTVOQnVUWkR5TUhuVUJYc2E0NVhYTVNscDlXZVZCRXVBRGF1R2dqOC9l?=
 =?utf-8?B?ZzVjRUN4QU9PSjNxODhXU2dPK3VXRWZ6Z1E1bFIvWFdQNFJCcFNQVGdQVmt2?=
 =?utf-8?B?MUZTZ1E5V2VaN3FKMXUzVE5mdzd2S2xZMm5scXZjZ20vWGlSeDhzVUo3Q1Vt?=
 =?utf-8?B?ZDVZb1lLenpSSHFVMXpvYWhmVG1xM2dMQTdOb21jT3Zzdk16SjcvQkJMVXMw?=
 =?utf-8?B?WUpsSzErcmZHQnZEbEVtZ2pLL2d1d2FIcitraUQ2VmZJWG9KNEdHNUw4UUdy?=
 =?utf-8?B?dmIyYWRmOTlLU3ZRZjFIRWRTVmpxNDd3N1k4N0NkMVRDdkI3dlArT0w3a2NV?=
 =?utf-8?B?ODZycDBtcHYza2xhNVNpRFF4VEwzdkRPWTFBZU8vZXY0Y0x0M2ljZ25rbnM2?=
 =?utf-8?B?UDUwQ3ZVY2x0RzZFYThmQS9BZkxzaWRLQTlWeHZtdFp5dHZUQVgvWk5BVkxs?=
 =?utf-8?B?eWdYVEx1NFJ4MDVnT05uRkwxQ1ZMTk9pQWV1em8vWW0zc1k3N2ROaFlvT2Vo?=
 =?utf-8?B?Wm1rR1VvRCswSkZNL2lSdVRkeEttYmVyc1REbDhhRDBIOWNiQmlQMkhIS3Rn?=
 =?utf-8?B?MTNadFNidm44Y1AwTlFOOGlNNnQ3M3o2NlRXSzF5Um5xNnB2QzhxMjFreGlW?=
 =?utf-8?B?ek54RS9oWm1BU0s5Uk5FdWM0Z1VzNmRaZXlKRFlOTStEaE4zUEF0eTVGQWlo?=
 =?utf-8?B?SEFCaGF0U05Ta1NJT0gwekg2MENNN1hqVEdTS2k3ZldhZkYrazJJMmlINEVX?=
 =?utf-8?B?eU1MOTJjWHN3NDBWUHA2Umt0MUhZWkdQSUhqb01hb2plbjhtSXJWTjd0dTVH?=
 =?utf-8?B?alNoYno2Mk9ZeFFRSFdsOXl6d2hRLzJ4b3hiV1AybzhUL0gvVXpHd3NuN1l1?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: X0FkegQCLCAxfdfqiENIhf+bjH+NinVVW20dVvbot1CcJgiblNA/ex5J2oDPqt4dTc4V+MCrzLP3YCkMBTVgrUgKigxfPnSPLcSPdi7t1BEMCaJfU8F2WM9INUy9VnHCtWOr2fADPrW+qihvsex7tkF9thBUUvJ7RhnFLlR1cb0X8G29hFhNdAkfQMM9D92OXal7ubhFcvEhcxvZx1fBkXcO/9XFX6ykzd9VYy2AO7aSmdaKfGlNs+0m25CYNEFnLYVHGeKqKhyip83oForfO8DpO7f7aETxCI7z8ZqBIRyEbCCi1z5S1WvEuUqfwWDh+5f2FF3oi4kBeR82gBjlRfwz8nH3NYi+nro6DtrQag5Mq2KO2O45wf9afnJn1+S+OX8TddZ/18i9fusJNgs3C7lt+74srvdZPsI0C0Uwga47jfzk/SC3/dKE3bTp5QsIGbXRG7LFZ2n6pqCKP3fEZRAGi4IuMu8RHf+ROeMUEOXvmn6xVWHx1MWaaI7X/e5QzLkW0O++lj7aWBQOA8fnyrfinA6F4/xHXZXNw+AZANqwH/HGS0mmGyqZXp/rfq3tUvUlGDikMlva38ESB6hmZ/C7BxMCd3UXX0Qccv0/ZFA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc468141-555a-4b96-7b51-08dd96ed0cba
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7436.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 15:51:42.3369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AWXBYyMgsEbT/TyVBRaaJVST7Ck733ipHoXmLrJ0E8voT36ZlC8kq+57xmH4N3aDv81+ZUPxiVes8Lnl1yNHugXLIyxapUZ3R0MLIHY8ccQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5816
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505190147
X-Authority-Analysis: v=2.4 cv=ec09f6EH c=1 sm=1 tr=0 ts=682b5392 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=8-jrWAhPRY5UD33dpEIA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:14694
X-Proofpoint-GUID: Lv6yVvkbSth0FphOTHLBz0c6H6PzSa0S
X-Proofpoint-ORIG-GUID: Lv6yVvkbSth0FphOTHLBz0c6H6PzSa0S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE0OCBTYWx0ZWRfXyRfwjAttOOE9
 Fw0rJPlL7m4fn/yxUU8fOU8OZGHbk5MnMeo7XfOC3IxE9qJsOBBlTK56hXo7DiHGvlmSVUMvFTc
 10NAYtNfvfrOPCxs3ginDWo8TpWF7S+37FqMXyJSpkli6xAa1PTgwK039p3M0/aFPhdt/KDFjAy
 SfoCXujvJae02McyfSnk8s8JWi34xc0eEoDHWZ3qPpZL/wX/3PEIvmZwbZz/xzdMnSYwsnO1aRo
 X/ALBc3XOATJsjkq6vhE01pilKrbGz0Xd60LofnoahuJGWVLFWuknwjHmcMBVrffWNPUm1at5mC
 FaRgh/PLCFaaXV+++SpNqsN17m/56zF80FRMfvOa8YbgRsbNA6EyEeUWAJ52Po0XSxZHeioi1tU
 82ZJOjIAtxS5QbJw1zyM7e/jDP7GaoYMYZbgcF3OjV2yJbHOUjbqDxZHebOIvCSVn9PTtG0t
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 5/16/2025 4:26 AM, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Steve Sistare <steven.sistare@oracle.com>
>> Subject: [PATCH V3 28/42] backends/iommufd:
>> iommufd_backend_map_file_dma
>>
>> Define iommufd_backend_map_file_dma to implement IOMMU_IOAS_MAP_FILE.
>> This will be called as a substitute for iommufd_backend_map_dma, so
>> the error conditions for BARs are copied as-is from that function.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>> backends/iommufd.c       | 36 ++++++++++++++++++++++++++++++++++++
>> backends/trace-events    |  1 +
>> include/system/iommufd.h |  3 +++
>> 3 files changed, 40 insertions(+)
>>
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index b73f75c..5c1958f 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -172,6 +172,42 @@ int iommufd_backend_map_dma(IOMMUFDBackend
>> *be, uint32_t ioas_id, hwaddr iova,
>>      return ret;
>> }
>>
>> +int iommufd_backend_map_file_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>> +                                 hwaddr iova, ram_addr_t size,
>> +                                 int mfd, unsigned long start, bool readonly)
>> +{
>> +    int ret, fd = be->fd;
>> +    struct iommu_ioas_map_file map = {
>> +        .size = sizeof(map),
>> +        .flags = IOMMU_IOAS_MAP_READABLE |
>> +                 IOMMU_IOAS_MAP_FIXED_IOVA,
>> +        .ioas_id = ioas_id,
>> +        .fd = mfd,
>> +        .start = start,
>> +        .iova = iova,
>> +        .length = size,
>> +    };
>> +
>> +    if (!readonly) {
>> +        map.flags |= IOMMU_IOAS_MAP_WRITEABLE;
>> +    }
>> +
>> +    ret = ioctl(fd, IOMMU_IOAS_MAP_FILE, &map);
>> +    trace_iommufd_backend_map_file_dma(fd, ioas_id, iova, size, mfd, start,
>> +                                       readonly, ret);
>> +    if (ret) {
>> +        ret = -errno;
>> +
>> +        /* TODO: Not support mapping hardware PCI BAR region for now. */
>> +        if (errno == EFAULT) {
>> +            warn_report("IOMMU_IOAS_MAP_FILE failed: %m, PCI BAR?");
>> +        } else {
>> +            error_report("IOMMU_IOAS_MAP_FILE failed: %m");
> 
> No need to print error here as caller does the same thing.

OK.  I was copying iommufd_backend_map_dma, but I see it has recently
dropped the error_report.

- Steve

>> +        }
>> +    }
>> +    return ret;
>> +}
>> +
>> int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>>                                hwaddr iova, ram_addr_t size)
>> {
>> diff --git a/backends/trace-events b/backends/trace-events
>> index 40811a3..f478e18 100644
>> --- a/backends/trace-events
>> +++ b/backends/trace-events
>> @@ -11,6 +11,7 @@ iommufd_backend_connect(int fd, bool owned, uint32_t
>> users) "fd=%d owned=%d user
>> iommufd_backend_disconnect(int fd, uint32_t users) "fd=%d users=%d"
>> iommu_backend_set_fd(int fd) "pre-opened /dev/iommu fd=%d"
>> iommufd_backend_map_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t
>> size, void *vaddr, bool readonly, int ret) " iommufd=%d ioas=%d
>> iova=0x%"PRIx64" size=0x%"PRIx64" addr=%p readonly=%d (%d)"
>> +iommufd_backend_map_file_dma(int iommufd, uint32_t ioas, uint64_t iova,
>> uint64_t size, int fd, unsigned long start, bool readonly, int ret) " iommufd=%d
>> ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" fd=%d start=%ld readonly=%d
>> (%d)"
>> iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t
>> iova, uint64_t size, int ret) " Unmap nonexistent mapping: iommufd=%d ioas=%d
>> iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
>> iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova,
>> uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64"
>> size=0x%"PRIx64" (%d)"
>> iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d
>> ioas=%d"
>> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
>> index cbab75b..ac700b8 100644
>> --- a/include/system/iommufd.h
>> +++ b/include/system/iommufd.h
>> @@ -43,6 +43,9 @@ void iommufd_backend_disconnect(IOMMUFDBackend
>> *be);
>> bool iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
>>                                  Error **errp);
>> void iommufd_backend_free_id(IOMMUFDBackend *be, uint32_t id);
>> +int iommufd_backend_map_file_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>> +                                 hwaddr iova, ram_addr_t size, int fd,
>> +                                 unsigned long start, bool readonly);
>> int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>> hwaddr iova,
>>                              ram_addr_t size, void *vaddr, bool readonly);
>> int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>> --
>> 1.8.3.1
> 


