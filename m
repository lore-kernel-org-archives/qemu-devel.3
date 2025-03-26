Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A609DC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 14:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txRuU-0002L0-1W; Wed, 26 Mar 2025 10:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1txRuR-0002Kk-TY
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 10:39:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1txRuP-0007sP-N5
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 10:39:11 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QD2GJ3025173;
 Wed, 26 Mar 2025 14:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=W5SGlkLrEd9fHu+PQhTLKP0qWt46yHkLCl1SsgfxZjY=; b=
 nIcS6/fz0yL3I/9zapxOpfX/oQ39eR01cfE6azFOeMClI+XZBoqpyQFhblYIL6Rz
 1IOMiFuapVQVXn+2Uo3v175njgRmG9Db6lDHhjqoST/S2J0XGBCgQWLuu+698HQx
 BfG1iPYN6/alvkA0UTLsi8+e/B4MTRi3oFYwYorJnkPTMZ6Tf+/AP4/ODPIYfwZz
 nqHNrvc4DbHpT1x/KPdEB4dpvNFYeps67ynYv+bLLv4onjf0bN1Nj9EQXOA3tRJk
 UmzZLinecU6PfIfbD0c8HjBOLpQebCXs2fm58x2Ztls04svSDIMK71K+HYYTWl6V
 eXXD2Gw56fRftTj7wSExgg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hncrsjyj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Mar 2025 14:39:03 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52QD5AR1029569; Wed, 26 Mar 2025 14:39:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 45jjc2f124-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Mar 2025 14:39:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ojf8KuXvOaUbqFWNKzHRC9oLBgx5lH2j9MZeODkeZtkAcDlBE6OyTKKAyfI2gttjgByNCgO51P/8E3iDjL25Q6aplm4tzhS7LtD1FLWVPDGfSvrIAK3biQVOAwM9VGHvbCNDiPHDMRz9vBtJ6Nlgg8uA1+z8fIHQgVf9Zqy6NRluEykmC8UhCG8Ey+lsMTilcxF7NMumKWodIUd/lVM/2W+0/wFkPoDQeEfbsa62ARxf71T0efYaitlmhhTzNicLQmvmpG0zuHqTDmOtCwiuphlW0YA72y201pTazrGNPwGKLqE1E6vTJt339byfjnqz1pdHSG9U6Rwtur6vqn8C1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5SGlkLrEd9fHu+PQhTLKP0qWt46yHkLCl1SsgfxZjY=;
 b=RORGfVsGxuSmDkryWnBx7z6b/2h0xsuhDWquYC4zkwIbZL/bVQ459M1Y9gRBfpExVibyG43HriIMTYj1gF70spIem2aeG6FAl4HmejGo7dtqMqD3Uex7mqw/YR6n31l5hNV64Jil83VFiypNAKblOWZg25Rm/RtG1oFS5UI66HDYH6+WwiM54xhYzqR96g95a0MEVUgsy3o7ce0sQbDMXSS/QNkgSunFYi7fWCK293qpVqIxyQA6rd8IoQUZ42YqZs3CVTixnzc/R6nwCe7S4Yw5mdXxd7P+Ihs3toBYvkbTs14VDLxCA3tf+Tns6QEo5YbCbO5CQh2jHUYIBXZD1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5SGlkLrEd9fHu+PQhTLKP0qWt46yHkLCl1SsgfxZjY=;
 b=IuyFWN9QEdXMj/ONmNwZoLLV7DObb0fp+YhGuDeMQtgTHvcRqJ781q6R8zgIt4p9TdC4ysBAPCVOhWKsb7kJBZdDglj7UMjdnlXAg/viEvJoU/R/X41Ca1oVkx7HhPEyNmZIuddWgWICWLS01FE0YtQGyxySw20fKL8+POq2MyU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS7PR10MB5037.namprd10.prod.outlook.com (2603:10b6:5:3a9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 14:38:59 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 14:38:59 +0000
Message-ID: <7cdc6d56-ca84-4e85-9949-cd75160e05c1@oracle.com>
Date: Wed, 26 Mar 2025 10:38:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 v2 21/37] vfio: Introduce new files for CPR
 definitions and declarations
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>,
 Joao Martins <joao.m.martins@oracle.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-22-clg@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <20250326075122.1299361-22-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0061.namprd07.prod.outlook.com
 (2603:10b6:a03:60::38) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS7PR10MB5037:EE_
X-MS-Office365-Filtering-Correlation-Id: 188233f8-347f-4ee4-39c0-08dd6c73f21d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UTBkd1A0UjRGSHc0eTBpSEkvQ21XMGwxRFEraE9xM1hEdGtTbkpDM1dJREdI?=
 =?utf-8?B?SUJ6cHlSaXk5TjVUOE93dGMrKzlzYlZRRWI4ZnJDSUx2K1FmRWo2WXpsMlc1?=
 =?utf-8?B?ckJEM3U4QUdYSkt0L21pRnBVSzVNQkdrS1BOZmVLRkhlSENyMmsrVUo4UFFr?=
 =?utf-8?B?WWdOUmp3WGlrY1RlbkNuTUpyYVIyeHhtWHMxd0dpYy9tSExVd0VGd1ZkSWtW?=
 =?utf-8?B?NVJ1VHRIdW1icHZRUUgyam5BTUhLRGlJMXNsei95VnF2SWZpL05qY1I0K09p?=
 =?utf-8?B?WVhOMUZJZm8wdzc5THBSd1oyYUF6dTFjb1dWMjRXSkxsTS9wZ1c0cWNhVStj?=
 =?utf-8?B?L2VQWGxvd2NNRU9NczVmTExJYVB2cDRNbHZ2OTg0TytwNXV4eS9mcUQxTUJU?=
 =?utf-8?B?czRKUks4NDI2Y1p5VFE3SXArUlMwbHVQL3NwTFk0UlFLUHNxUXBrNmRTVStQ?=
 =?utf-8?B?UVY3VTF2bUNHcWNsdVJUZGZQOTY3OEtvb3RpSGtiRmhjK0h0SEhxMUNDTHl3?=
 =?utf-8?B?clh1cEJZVlNzSjdMd2p5OWtuTk5ObFJLN3lHSjZBNXdkdUxxaWdVUGI0MGxr?=
 =?utf-8?B?MWZGbklsVGFmUlpIYnZZRFdIN2g0bVZ0cFVMbEE5WlhRRE9zNTBUdll1VjZN?=
 =?utf-8?B?MFFHcmdaY0EyOUxUZCt2SkF2QnUzNTQ2eDFrU2xMZGV1MzE0anNndExQckt6?=
 =?utf-8?B?aERUTHkwYUhTanpkMXVMMUtxVHVueDlROXhQV0x0eEM2MWFxajVNMWljREt1?=
 =?utf-8?B?dHl4N1JobzNaQW5XNFRLaHVkL0E1RGNYeGVwOEFrYTZ6YWZydVBlSW1PMDJN?=
 =?utf-8?B?c1NMbUFaMG9Zb28vQk1QM1pmL3NwVVpkQnBxMFJjWUM3UzFTSnNHUEI0dnds?=
 =?utf-8?B?RXZkd0NMWU04ZllMenJ4eGZLako2U1FEckJCOUJlZkY1THBoSE9TSWZaZGtZ?=
 =?utf-8?B?ZFdHSklMZy9DMTFJdGlZNnJIVGJlYXF1S1B6QkdBSzBpZkRNNnViazRCakpB?=
 =?utf-8?B?aCtFMThXc1lhYmZGSXZubGJ5Mnc5cldXU1N0ZjkyT1V3MFIyTUQ5Ni9xQldk?=
 =?utf-8?B?bUNGU0NPZVpqVk0xanhoaVFSS3FGYnpUdlEySTR2V0lOVUxCaVRNS0d5ajFN?=
 =?utf-8?B?YkNvaFZzTDE3SzQxcEJIeWlLdFpWZ1FoUHFYUEpMQy9heVVtcFFLWTNiRjQy?=
 =?utf-8?B?VFVqZ2ErM3BkSCt0NUtkdjBkUjZLNE5nNlBhYXJLUStIUkk0aTc3MnQ1NnFv?=
 =?utf-8?B?bURFU2xJUUlCZmRmK3Fod21hZGdPZFNWRVdsMFRlV0M3QkdpcGlXTlhIdXpZ?=
 =?utf-8?B?VURlRUVqMTQxbXpiSk1qamErekRnSVRCYXpocFArNmRMWHI2dUxrWmFYTkM2?=
 =?utf-8?B?aVBFamRzd2FVaERTVEQ5cFI0R3l6NDVZcUJObElQR01oUlRnQ0tSd3N5bGd4?=
 =?utf-8?B?T1RTcmVUd05oZjNoem1oZmlGUHZtS0RvOExXcUpYVUJlckltMVU3OHRBWThW?=
 =?utf-8?B?NC9pY1I0ZjNsaEYzUmxqSjhrUFR2UEVlbFpwZ0ppdHpsYjhSTWZNT2tRWnMr?=
 =?utf-8?B?N1VkNTI5MmNQeDJmUnZtR28xdEV3NEtYNFYxanFVVm5hZWp5SVZ2eFZzc1Zr?=
 =?utf-8?B?Q21mSjdpMGg2dVNUWnhrWWoyWGdOREFIM2hyb0dob1JSL0ZkMURSbXkrMHRB?=
 =?utf-8?B?RzczYlRqVURJeGpFWTZ5UUFvWm1ZVXQwMkF5Q0V5NjRwaWFYN1lPYytpUVM1?=
 =?utf-8?B?dVF0RU9ldG0waStRT3I3YWdSVENIMzdRQUFXWmFLdmpTQ0FIa3haMXJJcU1o?=
 =?utf-8?B?M3BtbkV5VVZKK0EvY2oxWWpuTTc1d3R1VklnaENFazdoVFBhazl4cGEvMEVs?=
 =?utf-8?B?N1FUWDlGZkFWbnVDc3NHU1QzY2NQVzl6Q2tGc0RsWGhVcER3ZjdKSDZNTjhq?=
 =?utf-8?Q?jw/unI4iGvc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkxYRWRxYlUzTVkwTUsybkRMeEJweUdhMWs5RzV3NnZvOWlEYU5EK2hRZGsv?=
 =?utf-8?B?cFFFcC93allqSGVKeWlWS3FFZmVYRkNKMFBiam4zVE5OcTVBcGYrR3F4ZjlM?=
 =?utf-8?B?aUltMjk5UndKZGV4OVE0VldtQ0s2MElDOHF6TDdtaEpFUEE5Z2lvaDN0UGJl?=
 =?utf-8?B?UnpYRjRxRUhDOXlsUHlLNjY4dDd3OUZTb29RR0JWZWppcnVmbnBhN3RnNGVY?=
 =?utf-8?B?UUxHSGtzZ240SjJEWUFkdmV3QVdTZ2tWWDFrcENPeU9OeHZjQWk4M2NZek00?=
 =?utf-8?B?TTZrL2hoNEZhZlRDN3Y0d2p3QVhycktpcUkzeWQyZmxjb0xmSUFLSUlIRVhF?=
 =?utf-8?B?MlNJemd0bzM3dHNqZkU3RjFMbFcyR0VVTGtPaWxiVkpaazMvNFBPTG5MUm1i?=
 =?utf-8?B?b2lMWFVqTmsrZEhRMTY4TC9YZ2tpR292ZWpyT1BwSlZ0a28weWZidDdTa05G?=
 =?utf-8?B?UGhvRnZJRHJDbm8xRkV5bWZMQitTRlovVVUxQk05R1BhUjhmM1RGTndyRGti?=
 =?utf-8?B?M0Z4ZXdLMkhrNEp4bGhoYUd2MFlIdWpqd3RIdmVEdldUd3M1NEQxcThnUVNn?=
 =?utf-8?B?NkR0b0pHWkh5dUh6cmk0amxEbGFsNnN1eHhCWHFvYmduYTAyZVNSRllXbGRh?=
 =?utf-8?B?TmxnbVp4S3NYNmM0ZnBtelR2ZEVvdEJCQTNQUFJRbzA3enpYa3pTbXFLNFRH?=
 =?utf-8?B?REVLWFpxdHUvUEFKUUZqeE9pMkVMVGltQzFzNmJRb2cyVnh4eThUdFo3b3Fn?=
 =?utf-8?B?SFRVeXQzL2xPc0dsRy9pcGdtcjZHZEI1dGprUnNCVGhSOUNNL0t0NE9ZSVJm?=
 =?utf-8?B?VXVMaTI2eG9pRnpmYjhyT1E4UDVXaDA5R1BtK3NSSDN4ZXZYVHZlMWcydkVX?=
 =?utf-8?B?dFRwNGpSUlhjMW1hMFFuMVBqa1ErV21zS2xWNzA5ZnNtNEorTC83MUtDeDFL?=
 =?utf-8?B?ekhuVW90cG1nb0NKdFhZbGJRNFBSTlNHZG5JRitnbHF4eWpxTjJGY3hwRmho?=
 =?utf-8?B?MHRvOGRQVFpzMnBMKzBqZXhSajZ1b0R5dXhad2RKN3UxbklwSHBBREkxMVYy?=
 =?utf-8?B?UGNJNGREQjNDbFVOTDZBME1GdmtLVDNLTXd2ZzUyenpJa0JIK3Jjc0s5dUxB?=
 =?utf-8?B?TTdIeE5pYllYS0laZmdSSG1HMGdUcHVUTld2TTUzdDZVZ3NZbXhwZTVEWEhv?=
 =?utf-8?B?aFRmL3FNNElGMEF1WDAzV0ZGbHdqMTN0YU4rcGtESzB5eFZCemFNdEZwN2pK?=
 =?utf-8?B?V3BMTGxjYU9nb0JuWEVlWmx0ZnBiaGw4bjdJQ093TmcvVFlvZWI5VXIyYldJ?=
 =?utf-8?B?cE1rZFJSMHdjYnV2S045c1dEQlRuVGFiZDVNQ3Y1dG9yTWsrUDlLTmszOWd5?=
 =?utf-8?B?TE8wcTRFSUMvWkFyOVdiSHIrZTZLc0RyamhvZStncERjMXI1emJ2VjBWa2hx?=
 =?utf-8?B?RWRtZkZIVTBjUy9jamp2cTRGNS9sS2FDUzBlWDczVWl5NnAxNEZyaGUrOXJR?=
 =?utf-8?B?bDNkZW9FT0VNLzl1bFRpSXhscmNkYUtjem5acFF2NU9RblQxYzV1T2NWd1Jz?=
 =?utf-8?B?MW5RUjd0S1hSeGJ0SFFYNDhWaUpGeDZLeXJ2Mk9SMUhIb0pQQ0JETU9mbjBl?=
 =?utf-8?B?Qzc2VFpvM21Cbjh0YW93WTlPcnluYVZoVmNtNVZJUXFCWnU0djUxUXNuMW5o?=
 =?utf-8?B?eXFySVpnL1pod0FmVHRzbUFyZituZUdDdnlwa0Rld1NEcXBReGtTcmlJaGw5?=
 =?utf-8?B?aWNlUGlqL0w3cGxCWllqSjA3ZkF5WkZOd1BrU1JpSmlQbDIvdlI2NytZOGNS?=
 =?utf-8?B?VnV6ZFFWbFZnWnVJbEpnTFRIQytkbTdQUXhoM1c0VG1wakN5RzEvSW5JTDJB?=
 =?utf-8?B?M3JPR1VUM3phbkJUTHNoQm1pMlNENlFSWDRMYUN3bVdUSmtybUdxeFRPcXpZ?=
 =?utf-8?B?U3ZYZFRFVTBrWlduREJISjM4M014bXhYMGgrVGZVNXZoZW9rcW9nY3BpSFV3?=
 =?utf-8?B?UmdqSUlySkZlN2ZpMGJwcmZSNmllVkh5eVJOMStEdHdnTmhDVWxyeEZrb0Rn?=
 =?utf-8?B?Wm45Q0tpNS9lSFJmVWhQdGJJN2oyenN1clZMdktTYWdld09TZGR5dUp6VWxE?=
 =?utf-8?B?VHdiKzJyOS9nT3A3aEczNndUaGhheHZrWnhBbTRhRUdrWEltTEZuTFVCaEdq?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RuUonBXbnmrLYGtSpigPDXQrW1Y3c/lAAyhCjZd9+FmvNVOt36cAHwQepe7soHndOcfZSyhTeW/EcmWO2e/DDy/NBBM/VlWPBJOiqjgk52s70Bo7blBJR/APbMN1qT3KQGSg/KKCoUX9RDGwgiObPfw0zMHjYkViA4onhaHOS4q5UEfFby+jFJSqr6K4gq7UxVdrzf0/QVEmSdFpSlZW0q1KO/HolZTibV/BgPVL6qd08EDdJ4Y/nhJBTlhRhe6VBH+hS+vmi26WC1eqynqDpeQes/Mrh3R2XiOOxFwuTVgU47t0yPqNJQZNES50+a9F/6861b0t0ajfKL7wlcVSwQ9/YVOKo328rU5sV3P0tK9XFsmDYXHawIsAxuPbJVPIErN2AZ0RiHovXh8hbe+dBfZrWl2cdEmsmBB5cvHZPEJunq7YLoi8eWfh6azPPtJPiCdQYamK05sGxlG32Xh1/lYijArWHcF7gPFNchV+sjwiQLR0giEwfyTg2pqDWNmzPRxoH/Ix57S0uaUoR25aU6KVBk9MG2xJ7Y6ZD6WH6TSKE3uJHb/6ne7N/0Pr4FE2Ve+AgyOepKbDJxiUNaVuX8ItSJR1FSUux13cpBtxh5M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 188233f8-347f-4ee4-39c0-08dd6c73f21d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 14:38:59.7504 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dloFfdL6r+pHafU9KYNAo1x10/hW1HmrIP4gPkL2TKgVUFJBJ4nmiHSCipCwiOqle7GvYmhTIaPD5atOYphy5P9jL1/wpHYPRkuWVeed4sk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5037
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_07,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503260089
X-Proofpoint-GUID: I_a8xHIL2ZZZypvxzow_kjVyJNvDhGcK
X-Proofpoint-ORIG-GUID: I_a8xHIL2ZZZypvxzow_kjVyJNvDhGcK
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 3/26/2025 3:51 AM, Cédric Le Goater wrote:
> Gather all CPR related declarations into "vfio-cpr.h" to reduce exposure
> of VFIO internals in "hw/vfio/vfio-common.h". These were introduced in
> commit d9fa4223b30a ("vfio: register container for cpr").
> 
> Order file list in meson.build while at it.
> 
> Cc: Steve Sistare <steven.sistare@oracle.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/vfio-cpr.h            | 15 +++++++++++++++
>   include/hw/vfio/vfio-common.h |  3 ---
>   hw/vfio/container.c           |  1 +
>   hw/vfio/cpr.c                 |  1 +
>   hw/vfio/iommufd.c             |  1 +
>   hw/vfio/meson.build           |  2 +-
>   6 files changed, 19 insertions(+), 4 deletions(-)
>   create mode 100644 hw/vfio/vfio-cpr.h
> 
> diff --git a/hw/vfio/vfio-cpr.h b/hw/vfio/vfio-cpr.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..9e78b422623683509929f2982f0be465306f4e99
> --- /dev/null
> +++ b/hw/vfio/vfio-cpr.h
> @@ -0,0 +1,15 @@
> +/*
> + * VFIO CPR
> + *
> + * Copyright Red Hat, Inc. 2025

This, please:
   Copyright (c) 2025 Oracle and/or its affiliates.

I created the copied code, and I created this file vfio-cpr.h in my vfio cpr series.
Other than that:
   Reviewed-by: Steve Sistare <steven.sistare@oracle.com>

- Steve

> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_VFIO_CPR_H
> +#define HW_VFIO_CPR_H
> +
> +bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
> +void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer);
> +
> +#endif /* HW_VFIO_CPR_H */
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 75c48ebf5c21ea93aa8ac4c3aecc63172b633f0e..c587ed08feabd0c4845d824960dd0799e9ace69b 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -129,9 +129,6 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>   void vfio_detach_device(VFIODevice *vbasedev);
>   VFIODevice *vfio_get_vfio_device(Object *obj);
>   
> -bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
> -void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer);
> -
>   typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
>   extern VFIODeviceList vfio_device_list;
>   extern const MemoryListener vfio_memory_listener;
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 6e9378434377f4b03176a16157c337ab1286c53e..7436388a73a424b11e6bad9ce80b86c3792242dd 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -34,6 +34,7 @@
>   #include "pci.h"
>   #include "hw/vfio/vfio-container.h"
>   #include "vfio-helpers.h"
> +#include "vfio-cpr.h"
>   
>   #define TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO TYPE_HOST_IOMMU_DEVICE "-legacy-vfio"
>   
> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
> index 3d1c8d290a5e6b6d67e244931a9ef8c194a0b574..696987006b853227e76caedb3c7f4e4be31cfa06 100644
> --- a/hw/vfio/cpr.c
> +++ b/hw/vfio/cpr.c
> @@ -10,6 +10,7 @@
>   #include "migration/misc.h"
>   #include "qapi/error.h"
>   #include "system/runstate.h"
> +#include "vfio-cpr.h"
>   
>   static int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
>                                       MigrationEvent *e, Error **errp)
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 85b5a8146ac401af6be8109c28ea4c7a39e84521..a5bd189a86d70bd11ecb80384ac145a51979322b 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -27,6 +27,7 @@
>   #include "pci.h"
>   #include "vfio-iommufd.h"
>   #include "vfio-helpers.h"
> +#include "vfio-cpr.h"
>   
>   #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO             \
>               TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index 60caa366175edee6bc69c0febebaef84e752e346..1f89bd28c13dea55bcfff476ce99d51b453d8533 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -20,10 +20,10 @@ system_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
>   system_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
>   system_ss.add(when: 'CONFIG_VFIO', if_true: files(
>     'container-base.c',
> +  'cpr.c',
>     'device.c',
>     'migration.c',
>     'migration-multifd.c',
> -  'cpr.c',
>     'region.c',
>   ))
>   system_ss.add(when: ['CONFIG_VFIO', 'CONFIG_IOMMUFD'], if_true: files(


