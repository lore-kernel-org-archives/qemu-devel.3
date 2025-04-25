Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C300CC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 19:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8OVt-0004q1-Bs; Fri, 25 Apr 2025 15:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1u8OVl-0004pf-23
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 15:14:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1u8OVh-0002wD-IA
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 15:14:55 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PJ5FLL023958;
 Fri, 25 Apr 2025 19:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=Ez6s6FlRv1eEtfYgCsnB6h+1fJSSOL+/h7YdJfkJBVw=; b=
 okrqdNL3tF6OQBDar2A7rO30k2K7pMmPe6hvmvyV0hAs+GBHl3Y/JemGL9OZGM8F
 umbecYyZRv9c7X/qhs5io/zxfmFhZPTUrWwQOSBBKc7usuj4WRSuQc+tDxewGnva
 Vl6c39M5XOCyMG1elN+x4b9RNuBd8Vq789a+AXrexz86Fu9X9biRW2lv9UIN537v
 JauLqRBg6VCeYFrhMQI2EAA891YhLHk0CtdMLMdo7S6/mTi19WJlYVOu8aLz+z6G
 cEvl2JLRfQk2ubyU5a9SxUq2SYYlbbVhxX9sveHlKFdp0m617e7V3laM7jHIGQ8V
 A8XLa335m70Xk/FZjmQGmw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468fyk82t4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Apr 2025 19:14:46 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53PHfiNv013920; Fri, 25 Apr 2025 19:14:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 466jxs1g5d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Apr 2025 19:14:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOugpHoeXCELQUmYe3w9Yz93YpRBl4YZW9InQ4OvCu7rWwew5ok9ekjigmgK35LMDCeNYIDirkzKDEUUR+34UbCw6PGc5czM6pAxnzlbd8ExySv8ovO6esf76HB6JU0gsEU9OVd9RJw09m4sTFYGPuBWsuwpfvkR2mPXcv9Ug8b/iuMx943j+9+mJTpINMaXwuWVYdNYOEug8xTVfDggVEd8XbkEGmCwsajSKSJea2cW5w/6BPhS/CG+tIaE4BCB7gScowmTmqH3WwLUqhjdP2PpY3ZpvEjZeHxOFs3y9j/I5QvB81UjR4qqlrlwro9PwsaAcWVz0BCmRKi/SwMTtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ez6s6FlRv1eEtfYgCsnB6h+1fJSSOL+/h7YdJfkJBVw=;
 b=RM4ZMrPIHX69Ocf3fnOfw5Gi7HdJWKu9VHEOGryG23gmNwymAZs6wcB3j9FAqoVhLBuHvDxR7rcNs696mMb330W0XH0+HsJRTchvNLUqZ1mgVNJYoRJIjWknx3jQ8yMc5WbLBvrXWB9haTZeeltLUOJUj5520Ik8gSt0F1AxrYymqR3YtcpXNKX5QIuID5P7X47xkA86YaWti3ddrg0EOngMVzhwTeVaQTF85o4LMdl0jcSINj2ZrEsQklYBvXKRO9evU73WOAoAEVIRW65QPtEt09VGysWcn+hZn4Upt+7bRSweqzXhDPIUVtCTWf3FKVJ0m8aT2Vg5CY+SBMRlcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ez6s6FlRv1eEtfYgCsnB6h+1fJSSOL+/h7YdJfkJBVw=;
 b=PRnMcz6WhP7KZBqqZQ+/wMSeHe0+y+Xojl6j/v1t/NYLZ0OYuo31850CsV4ILTbuKXVkTDCVwiq+GGmKVhOHspNp5j/EUV7+CQzgV2QRTs6NnzOnrb3jmdvANAELrf2Os1ylw6LlCef2U0Mel0i6zULO11IyGtYYfbpS3xs5YvQ=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BLAPR10MB4851.namprd10.prod.outlook.com (2603:10b6:208:332::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 25 Apr
 2025 19:14:43 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 19:14:43 +0000
Message-ID: <c5393bf7-a7a9-4f19-b738-9b94da225009@oracle.com>
Date: Fri, 25 Apr 2025 15:14:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: Register/unregister container for CPR only once for
 each container
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20250424063355.3855174-1-zhenzhong.duan@intel.com>
 <a697798e-8ce6-47da-8d77-7615486e672c@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <a697798e-8ce6-47da-8d77-7615486e672c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0144.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::29) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BLAPR10MB4851:EE_
X-MS-Office365-Filtering-Correlation-Id: fa5789c4-01fa-40c7-ff5c-08dd842d6f2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3RQVVI1UXdCdTFQN2hFdExqUnJzSXZhemY4R1Bmc1pOSmcxU3pSdjZjMHdi?=
 =?utf-8?B?VnBoRFhiR1lRb0dnYXVSek03MVhDczVwaUVyY2ZiTm5lMkVNTUdETG1pZjJi?=
 =?utf-8?B?aXJ5UHFDcW1uU1lGdDN1M1BqMHFsb0ZKcWVhWE9ibXViV2t5bWpwbGFNS3dx?=
 =?utf-8?B?SjN6Y05MTGVwL3I1dHQzUmpIZlpac0x6YUZzTk1SK2NNcUdZQlRaWi9Jdmh5?=
 =?utf-8?B?M2wzRjNLT0FFY28vdnlPOEZDdU8zN0UzR1lEdk1QNThKMjgwaWxNMjgwOUdQ?=
 =?utf-8?B?aS9jLzZ6aVVkRUdzUThVUWtCWWNYeWM0ckRnK3E0SkRKVXZHM0NBT2x6Wldv?=
 =?utf-8?B?OFhVeFZUWmtwVTVlYXBOZVcycmJnb3lwa2ZDd1pEaVVoQTFFaWtVc3RBajRV?=
 =?utf-8?B?VDIwU1d6bVFYbVo2UVozanFZQy92bVpPTERqQTVESnBETUZIMEVGRzZ3anZl?=
 =?utf-8?B?RHlWVTEra2Z5bFArV2QxYStkdnVWbEQyUjdkS09pK080ZDUxZ3BVOVpReUsr?=
 =?utf-8?B?TVRjbUdzMlRTTEoxM2FjcFVxLzhhODNLWVRuMDVzVHZtQThQbjhZdzlqSWUr?=
 =?utf-8?B?ZmUxRm1WbFRqMVY2SFQvcmlVVWw1S0JuQ29yQWZKRG9CMG1xY1J3a2p0dTZE?=
 =?utf-8?B?V1JXcXpTNE53SHFZaEE5RG5teldJSjJCTjNzN3pRUzMzL3RacGQ2UVJTWTVu?=
 =?utf-8?B?R2Fjc0RyYWdKS2cyRzFvRVpvZnRIVWczeDhzYXorNzVmUzZ6NHlUNzloMkx6?=
 =?utf-8?B?SGhtWHIyalB3YjljRWlYOG1QSWpSSHlLMUo3OEQyampkQVpGRzdqQVkwZFYv?=
 =?utf-8?B?aHFqOSsxZXdSTEREd2JzblI4VjRENHRGTUZrQzdMbFE5ZlFScW9kU3ppZ1V5?=
 =?utf-8?B?YU1GcVVrL1hXcXhEYXZwaEU0amhhMmhYWXJMSnp3OS9MbDBsS3RMb0hWNGpT?=
 =?utf-8?B?YmRETWozeHJ3WVZLV05aYXNrQ2Z2bmo0MlNNRVVuOVEyY3VhL21DeUhDMENa?=
 =?utf-8?B?Z2ZWSlFDZ0NiYmxhYUJDemZPQURDd0Qwdjd5UlVvOUhJbnFqQU5yenE5U0x3?=
 =?utf-8?B?eld5cko0cXllUHlXeGRTdm9lR1RVY1kxMEczQVFEaHFDNWhiSG9qaHExU01a?=
 =?utf-8?B?UHN6aXZqRW51Mi9sdUpJckhzRVR2VlczNHRzQXc3RzRwYVljMzhjOTZIN0VQ?=
 =?utf-8?B?M21GQlZBMXFrdmE3bnp5SHB3anJxK2YxdDdwaVVJZlhWWCtLWkpJemhaWGQ2?=
 =?utf-8?B?Z0NsSUk5SjVvb2k4WHNXekZOWXZKYitPdTdSMEhOUUc2d2IzNXFOSEdVYXBs?=
 =?utf-8?B?MTh2eUU0TWpDRXFxc3dMYkFWc0FaSGlsTldaU2NTSlZvbG0vaXdIV3l6T29h?=
 =?utf-8?B?VW5YM1BSQS9LQ0lJSkdIa3NBTFYrejJEYmk5QnpSMUl5bzY5NnZjY0habGdz?=
 =?utf-8?B?R3hZZkl4d2g5aFVGdmRvRjBTWmRJZ1paT3dkQk00bFgyT3pVcDJtL0gyc2Vu?=
 =?utf-8?B?aVZQVG94Zmk3Uld3anArUURUL2NsY1ErNnBVK2t0NzBuSVlTSzNDcHQzckgz?=
 =?utf-8?B?a0pSSHdoWW5RenRHczdHZU5XOFdsZzJieDk5YnE4cVZ1a3JWZTV4NnVFNjlR?=
 =?utf-8?B?bEF1NHd1Ym93Ly95YnJ4TFNjenRWa2puZkhjWTJoSHY0ZTY0VVlRdFIwS1R2?=
 =?utf-8?B?dkZsRExrNzU5NWo2Z0c3by82UWdSZGQrbFFzTm9VTmIzWWFDK3VJcHhZK1Ja?=
 =?utf-8?B?RXhkUWd0ZmNmSlYzUWptSDV1NXJaTDRSdTJCRi91SnJsRGJPb0Z0RWdyakla?=
 =?utf-8?B?ZTRpWDJYSXpnL1RqSXVYM1RhcTRpS3MwZTN4ZHplMTV2OUhrdkZoU3VVaWx1?=
 =?utf-8?B?UXBmMHNwdTVNbzJMMUt4OVc4dEg0a0VwNFA4ZVlFNDhuRGRuRjJobC9jN1NI?=
 =?utf-8?Q?KA4ojwkWy+Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWhkSEpYRm56SnBaeXJORzE5WFBJM0JLS2lOVEpNQzB5WGJoWXJKSmkxanlO?=
 =?utf-8?B?aFk0TFFuUFVVTFlhZ2VWdCtFWHBscHlnZVdma1dnb3UrdTBVSExUalBhL2lN?=
 =?utf-8?B?YzAvTlk2ekdVZlRPWWtoTTYvUnp5YndLY3BCbVpHSHNTQ3oxNEx3aDhIN3BO?=
 =?utf-8?B?UEtBU2tvWWZkcjd0YTM0cnZuTE9MOFViSnV5NUdvellaazNEd25TVW1oUEYv?=
 =?utf-8?B?WEJSSDVvOHIxUnBDRGVYbkswdy9iTkE3ZlpTMnJOYlZ3MlBTeVZhL1NuWGpu?=
 =?utf-8?B?OFl0amNXWXhFbWdyM1BsSmFpejFaNk9nZHN5WTBDS0FEOVd0VGxENGJBMFU1?=
 =?utf-8?B?bFpQK2tiSTYwSnE0MUkveXVPdmRuVVYyK2J3SzVvS04wSDVzMlJ4QlNQcWhS?=
 =?utf-8?B?WjhXZzZRelp2OUx2QjJwWU1rVjE0M3pXS0VEYjdFbHEwVE56UWdqNUlDQWpq?=
 =?utf-8?B?OU5mZVVTQ05EYzFUUzlHNWhxQ1Z5dU1XQk9LK1dFaDRhRFRQUGhYSU1kVUo5?=
 =?utf-8?B?V2VGODNpMXdsVlhqTTgyaVNlbGYycjY5cCtFLzJWbW5kTE5HT0tEWlNMd2NY?=
 =?utf-8?B?cC9QSjFKWUNnWmowWVQ5bVU1aDZMSXcyeUFOREpxTm5adGNyRUg4QlBZUjJW?=
 =?utf-8?B?aXg1Yy9UV0hJUGlnQ1RvZmNrWW5Ca2t5Z0NQczkvazl0bUtXUk43OHdKMGh1?=
 =?utf-8?B?Tyt6MFN3WitYVlNPNUZYdW5sMlhvRzJRME9ETGlGNzBIWng2VVY0bUwrOHp5?=
 =?utf-8?B?MnZuMTVGeDlhSUQvbWJnL3dldkt6c1QvRkt2dG5mRGV5cExyVTRvTW9kaFc4?=
 =?utf-8?B?VTNoQ1JXU1AzaHBPSmsxcDByNnA0QkJnMEtORTF6K2tUczZPVHZxbEFtQU5U?=
 =?utf-8?B?WFNLVlZKYkczQjF4UjMyak9vUFZ6Wk9SY2lXK1h2SEh2V3lINDNaR3lDV21x?=
 =?utf-8?B?aTBZN2QxbmFvUGRaT2Jzd0phNUVCVWVQSFJZWjJlMTAvV1NwaXBYa28yeDI0?=
 =?utf-8?B?eDBKUUVTVnlJanZwbnR5NDdjaHNuRkJ2dFMwaURjZ2xDeERPNTc4WkJFdjh6?=
 =?utf-8?B?RnRlZ0RCaTRRMENXZ3NSelFKd2o5NmZwekhXWm5lK0lpanZzOHp3SFRQWTFx?=
 =?utf-8?B?TzZWUjdrUVNEbjZ2czY2MFVqak5NZlFwOW83V25CMXhmd21CM1Vaai9RT3Qv?=
 =?utf-8?B?dktlek9IY1dSV1BMVUhaUG53ZVFlZzJYWVk5dHg1OFh5U1dsQmVsNGI4WEU1?=
 =?utf-8?B?ckdEQ1hnKzFRVzhwcVN5RExvS2ZkS21uYzdYbEVyaWJKb3JKS082T3hpUmxu?=
 =?utf-8?B?NzJWYUViTVVDMnVvakpKbkJ0M2RvTTdUWGt6Q1pVemNRb2pFWExwaDZNTElh?=
 =?utf-8?B?bnNETHJDWUU0Rm9MTWN3cDdiSGhwR3gyb3JSTGp4WnVaais0R1lUZVlIdWwv?=
 =?utf-8?B?THdJRWZJeTRiTkJZWDM3ODAxWmkxZXR3Qyt4RnhsREY4VU5rbTgranlWYzVq?=
 =?utf-8?B?QnpzZ0NROUNwMGJoUjhYdUhDY2trN1g2eXhOeGdFa2pyY3NTVnBoT3J0WkN3?=
 =?utf-8?B?QlZUZUplNDZWdWhpMExOZkVzaEV6MkNoUThsRzBuWDNIaXg1WXRXWDMyVXBI?=
 =?utf-8?B?bUp2MW1DTWQwZ2xZa2gzOUdEdFJuNFJxVnBzTFo0YmxrVThNZUQxOEsvV2N5?=
 =?utf-8?B?RkU1WTROOTlLbjVadHB4VFcvelVhK0ZFR2NaNmV4aXhjUEZwL3lEcldkY3Vk?=
 =?utf-8?B?WlpvL0VaOTc4WE9JNFpGWGwveFNqNFY0VFNTM1VIMkwwSUM2bmYzbXg4Q0hl?=
 =?utf-8?B?QXYrc1JFR01IUE1NUk9NSHlqWEFSWUpXY2lIVEpRUFBsSjVvMFVOYnhjTFNa?=
 =?utf-8?B?ZU45N1lPT0lqWE1tcDd4cUFGMDRLVmpzYldDQTBlMFRuNVlQNWU3VE5ITnVZ?=
 =?utf-8?B?NkY1VE5PWDk5YXk3ZHJoVTVlaU1xVFlXT1RGM0IrWWgzQy93aU16c1dlM2k3?=
 =?utf-8?B?Qmo2dkJqWVRqVk4wdVVmMlVneHNIZDlUVDRka0REV2ZaekRoR2xPWGR3WHhp?=
 =?utf-8?B?NWJYdDROSEpiMDdNM012ZUdGYWJ1c3plZDNXZGtQQ1JRTlBicnRCN0N0TUZH?=
 =?utf-8?B?blFRWGhDb1pBZ1hWUUhNWEVVTERUajdacTl6OTVzVDM1dEptdHJML1J5YzVw?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cM1+1nBxI5oh+RwLm5XR0zKPra2lWdxJqXuVBD2qr6Q8XacG/iR0+SCE4bxwdT8148F89Fih8auIChPNbWSVdyqBv4KIWyTQSPtWgJg6iup8zE8Yk8b1gHWVWjG5y6HAv/Kr/D1Toi/4vADPUX47qAMYCOLg5NUz1Fcz7RFL8+iXZR35/gwdiga5SJDCBaA0c8mp02CBO/MaVFmvckHz9W62PzjFWAU2B8iwdcx2KAL3WA4qMs+0rKfQkMfRxdy3s5i0XGhvgTC5GrSoHiA3d7miahAITK25rnTYxviFrYVc+1kc+DvKnWpcJDjN7uR7cW/i1JYIULdxbK5zMC4FRZi8x7cJEh5HhJDM1t6GussL9AP3DMjFLWEccXa6N9fJJDKWZyHUXpEIGCSm1bvxXd3+FfDnS9MSHIJCzssz6Db0VSSlIV8y9m/tqSlZtWwFtcMMO0feFEsf4gz72Bf1/Xf92dN99GMMQEFuuPOyE0u7F6wRoEVRPeMcYmaluSbvzvsjQzo3e9WaabmPwGG80o39/D7ExAt0igKzW2c6hQ9ytRqwYzsZ1sAipa1VOzkZ1V3AdpfjIlpHsn0Ki0xUAJ+hQG3tfC70B1mKC4DobfI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5789c4-01fa-40c7-ff5c-08dd842d6f2e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 19:14:43.3058 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Frf+MB7V6BoxZ7zmKCnIOOwvRzIvfCmaBFUoUENifysOQMF3rbzo6Qfa47JgJUGKrT6GFVZGchWEosqATrqeVhe5jw9FGaw1cRyFF/69SaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4851
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504250137
X-Proofpoint-GUID: I3oOrHMcU_cuHg4xZUqHo_Gww5pwIK7Y
X-Proofpoint-ORIG-GUID: I3oOrHMcU_cuHg4xZUqHo_Gww5pwIK7Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDEzNyBTYWx0ZWRfX0YEaSYVDNfAV
 DB/dMmFlYebM9sq8vsU0XigcwJfHdZdQQFDXpGtwRr8nRFAKcYEPW62vQWTTlHCqz72nL74+vd4
 c+txiWntr8D5Z6I0pQ+kHkmjp6UZJbxVIuSOcMyhqvfaCvhStTivpLn1eyX3a8B3Lyh3t7jU5+J
 ghfk3V0l2rAFkeqoWMHt+PlRQ3J6YJOjPrn8WbaW7nz57neDSZ1cNGrZCNf0E/+qp1/UaqrPiaQ
 RXsrIM+KCmNjO7W7p4j8nZsB4Uiyg9ZkykMJeoKlzCDDBXDS+4it4q9C46rh7klf2prV0Wj2Bt5
 zw4+f6FKMgsOPhsuYDMY1POjKmOyxok93is2VLWgXaBqdYQn1cy4cAIZg8Fppqs46F5cPRqAsat
 mYKrI8JO
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

On 4/25/2025 3:59 AM, Cédric Le Goater wrote:
> On 4/24/25 08:33, Zhenzhong Duan wrote:
>> vfio_cpr_register_container and vfio_cpr_unregister_container are container
>> scoped function. Calling them for each device attaching/detaching would
>> corrupt CPR reboot notifier list, i.e., when two VFIO devices are attached
>> to same container and have same notifier registered twice.
>>
>> Fixes: d9fa4223b30a ("vfio: register container for cpr")
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>> btw: untested as I have no env with two migration capable devices,
>>       appreciate if someone have env to help test, thanks
>>
>>   hw/vfio/iommufd.c | 14 ++++++--------
>>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> Applied to vfio-next.

Looks good - steve



