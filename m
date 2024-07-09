Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5672CC3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 09:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR6v5-0000B4-O0; Tue, 09 Jul 2024 05:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sR6v4-0000Aa-1Y
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 05:13:54 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sR6v1-0000g4-C9
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 05:13:53 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697tYBe024843;
 Tue, 9 Jul 2024 09:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=Y/QB3SeZB9MkfbaGbt/wnF7oWt7uFrVwJQ/b5AZbm24=; b=
 Qb3LYffppfEDNYunM5Z+BlRbyWzgn1OgVswhsL+AEoZkgu4aM/4Z2qaVdkHt2jVK
 uXyvlG+bvMltCPQsAPydGQIA1JQ3+kgpKj8VjbBvTFiuWiOm29clliz+xn2S34q4
 VdIK9PDlQSYHge0fSlZr6Q5uV1k7SCC1WDGU+AkoKyK8Nhs979uFmSO7sC4lRBcV
 2ZibFpsc3cXzoHcsMyEZm1Ck2XhpXm5qiQcoFAQVm6H13l87mtuIn3sb8OmTkTtY
 FWpTWrEjFN3UwnbZ7V2clV3urjQEvs7HE8B65sUv/+/KxGhTgS4zKuJShUhaUieE
 x0ijqX4PXxo0emEa35odHQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wky4hkm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 09:13:47 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 4697SPQa007435; Tue, 9 Jul 2024 09:13:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 407tu2x0xp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 09:13:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EexTigIvPaVLvlYgL1N0SMJzbxAaGDMwitVw7rhg7Jw6/yIzvFO33Jkcz8/PEVZONces2il1jvNSZfOK6PhXsVOr8aLCuaXq8xEDMMYR3QGSjXpLmY6HheM7TK1Xyyy22TeDY+u3sJOPNL0irnf5WKfPdoKO9bDu0OVGzrSClzmkhMaqKcBm/vWgDQZoXsUDgs1rETOLQTLJSx135/VbCq7CoZYGAUjJOhKRxrEuuVSJrTg7CQkzejaeRo/cq0QK51qZH57K6e3A9XYvIpApnoX24FZLOamMnyWNzf6B9KOfSIwMzMoGiwYVPn40/PgrlW1KJiJ5RSgz7eerPGXfbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/QB3SeZB9MkfbaGbt/wnF7oWt7uFrVwJQ/b5AZbm24=;
 b=ZVqIG0EgatcqybUIEAlFCIk2+Yg3+2VaT69jYRVLiFYIWPaHiLw4HwlEgGTvSXGsxIIvkmnB2Ij3KicVA5WSazUUCyrELh5LmojW9MDSBCQleHUIg5z7t1vXuNGVcAOrc/biZhuGkIg9DkM0rEObTdnMBiHyEsMHWD8QN7pTWz2jbhKUEoxSkBj1lP045bNoT20vYtyrV7HImDERevqCWa5Rj4wHzeW/P2JwdkRDJtfD5f+FeyaF0SIbAhvap+byfl87P8KkoOIez0Er8BTiiguU0PEO57a85rKKxg9eYmfkBEJ7nddll6Ue3QDUr8XC6RyTiMGSu6O1/vTmD75kwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/QB3SeZB9MkfbaGbt/wnF7oWt7uFrVwJQ/b5AZbm24=;
 b=RRNadPhyV+327DapHfyVV979EX7zd4alWXtoc6gb9IjnYPgATdZBkQ/JJLAQTYOSrQMlra44sfD9nM6Xcwjzkua2vqYvKHuyKYlo5JK0jXEmBzlMIX7WW0TUOJruqtIz9IWxA6JlWZoPVJvvUr3HZ3Xyu6MznH8+J9Am4Ed6G1k=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by LV3PR10MB7794.namprd10.prod.outlook.com (2603:10b6:408:1b3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 09:13:43 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 09:13:43 +0000
Message-ID: <5844a2f3-2626-489c-a62f-f6a0b324cf01@oracle.com>
Date: Tue, 9 Jul 2024 10:13:36 +0100
Subject: Re: [PATCH v3 07/10] vfio/iommufd: Implement
 VFIOIOMMUClass::query_dirty_bitmap support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <20240708143420.16953-8-joao.m.martins@oracle.com>
 <7dd75280-47a7-4d66-8b39-7347e9194a9e@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <7dd75280-47a7-4d66-8b39-7347e9194a9e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0160.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f9::22) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|LV3PR10MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd022de-18e8-4053-c8a9-08dc9ff76e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHNsWWptdS9lNnFKaEFPRTR5bDVDS3B3WnVRY1NLQlk1Qldxa3JiWmNhbm1G?=
 =?utf-8?B?bnozNEVlby84YWt5OG4zU3BXTjh2SXE0TjFZOXkrZHkyM0tvaktkWDhVOGND?=
 =?utf-8?B?L2NScWFnYkgrbVlUemM1SVluTjFLemh5QytZc0Z3YlJaU3JoWFV4VWlmMk43?=
 =?utf-8?B?Q0JXREx2NFdiOEVKc3hrSzF4SkdiTEhpVzZOanR4TDQ1NCtkQjlEQkRBbThx?=
 =?utf-8?B?ZnNGdHpGRnlqRnBBT2JjUUNMN1pmM0FvckM0TGVpY2RHY2JhOTZBVDlmMWt1?=
 =?utf-8?B?MEJmbDlUU21nR2djNUVjY1RsY09EdDlRbTBpcTgzN0h0TTA2bTdRWmJib0li?=
 =?utf-8?B?UXE4MjlIUDZrRVRmaDk2ZzFURlMvQkI0c2loVXVueVhNUTFSWFF4V0hBOHp2?=
 =?utf-8?B?MHUrSUJLdG9iMDRDY01PdmgyaEdxZURxRklCK1ViVlplVzNxeFNLaVNwaTRC?=
 =?utf-8?B?c1RKWis2dTdzckRMOWtERVRLaHBIZlh3WUk1VXZhaFFEZkxTL09KQVlkZjc1?=
 =?utf-8?B?WktDdFNNZzdkRzZ4a01IbXRaRndjd3RkUm1SeGZHZThzTDBxQndPZzVHc2Rm?=
 =?utf-8?B?THNDc3ZPZFhNa3JPQzd6WFRzbW1QaTE0VzRhMUhNSVBhSlVnbnc1ekpVNkhQ?=
 =?utf-8?B?WXVUdVF4WUx4Y0RrcG1QVG9MMERzTXFwWUNBTnZhK1JBKzE4eDlKM3JsOHU2?=
 =?utf-8?B?TUtZRVVOTGxoVE1nOForRUw3ZTZoc2JoMTFmUFc2dHdjb2VBaGJFRXZrb3ky?=
 =?utf-8?B?TUhoMFFtdHRCL3Zlb2pScHhEMFlTZ2JUL1BoQ0lOSFB2VEw1Y2YvM0U0Y2x5?=
 =?utf-8?B?YUZ3cCtYenlYMC92Q2o5bEVOM2RCVmREZ0VDMG9hcUFPZnM2d2dqcDdrb3hO?=
 =?utf-8?B?MlgwRTlXdlBJQy9OcnJ5bmVtMnBwQnF2T1BhU0Z6NkhCdkZnREhkV0J6VWla?=
 =?utf-8?B?M2JzM3FMK1RnYnpHb3hydE1wZExwcVFnUVdRNGdXZEcxSnE3UExiN3luaU5S?=
 =?utf-8?B?Y29ZNWM0Vk1rd1ZiNXlRQmQ3ZTlVdXZkTVpaRVl2ZUZMajdmS1hFSGExc2lF?=
 =?utf-8?B?MWJ2b3Bnb3oybVEwRGh0UnNzQjJmTXI3elczN2Q3OXhkUjFTOWNXR1gxbjha?=
 =?utf-8?B?enJHWlRWeU5wZU8wY1dWeUc3K2hrYk1jaDlEaEhBQ1JYdm1MejB3WHV1Wlhj?=
 =?utf-8?B?SFhHT3VLNE00eHR2a3cxZE1VaE9uQzE2QVBKZU5Ba1Vtc2k1RHdxNmVlYktO?=
 =?utf-8?B?akNzS0lHQWJ0QUhiTGxoRUYvV3ROcUVtT2o5VGg1MW1reTFxUEJJWUFlamp4?=
 =?utf-8?B?NVVCS3ZsUFlwQmVVQlNuckVmTDMxUDk1OStmNk8zcjVGM0ZIbUtHWm92dCth?=
 =?utf-8?B?dVIzMXZuRTd3bCtSdGV4cDgwdXZoVTV6ckVEM1BwSXFWMGVBWGUrTElTclRZ?=
 =?utf-8?B?S2EwWGFuendUcWFMMXFpS1cyNDBpR0xLQXdKSkNqNG9GLzZiYXd6MWVOSmNG?=
 =?utf-8?B?Rko2WkVxRzc0N0lSNkZPUER6azBpWmZENFdqT01XZFdGWFF2YkozZFV3MHdk?=
 =?utf-8?B?Rm94RWM1cVBGVVZFTUlsbERESlpkcU4zdk1Lakl1Q2grU2dmbUo0V3FEdFhC?=
 =?utf-8?B?L1F0VFBsNE5Dc0ZEQkl2SGk1OHJFVC9CZittZEdHdlZtYzFjckVvM1BsN1g5?=
 =?utf-8?B?ek85KzcrVXlsVzYvalNaZ3NJblA0WC85NHl6UXp6c3hvZVhHWFhIY0R4YnMx?=
 =?utf-8?B?T2h3UEpham8zRmJxZGg4NktnYXZzalhHaVFjQUwwTEhLRWxtSXd3ZTZCaHpF?=
 =?utf-8?B?TTFiTmYwOEpMc3B6K0NOQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW5waVRWd0NiUFZkVnVJS0QrekNheUQrYU1zeW1wdjlyUVhuRHcwK0tOMjdP?=
 =?utf-8?B?RnlRSGY4d2ZRdlBtS2RXU1VoNTNKVUpkengvWlBRczRMblY1UGtQWTBkbWh5?=
 =?utf-8?B?bnpYelpZQVlyY2dYa2lsZVZ3dmJZUUtPVzc3WHhDMm1Kem1uaGNQWENxSWl3?=
 =?utf-8?B?M1NJY1lTRWVtcDFPcE05VVVQRnM3M0hUeURoSzVvV3BkcVJmcHV1NHFsZTJD?=
 =?utf-8?B?TzI5Wnc0bEM2ejJOUXNXd1VmaGFLUUdsQUt6ZlZaTk9Sa2hLTjR0TnNGTU14?=
 =?utf-8?B?M3hacTZZTU92UnBncDBmOTBpVWUrdHdoc3VXandqaUdiZ1pnOXNSL3ZmM204?=
 =?utf-8?B?SUl0MkdUempuK0E1bWFjSFY3OUVrdmxYampZSDRwb2lHOVBqc0NXaVRQRGJn?=
 =?utf-8?B?UHp2R2ZON3NaZlRYNlRlV0tMWm5xZDkxc1F5amdCRVB2emJGQWxVKys2RkEz?=
 =?utf-8?B?RzJwSVp3VnJkZjU5N2t1RkdPd0pRbzlFSFhOSXlZajduNnp2MjBVNEJQSkFl?=
 =?utf-8?B?RktxQ245K3A5amJVVXVoYzgzSTBQV3FJbVMvcXNjS1JmdUFCMEw0bkI3Nm1L?=
 =?utf-8?B?ZTA1Wk80cjJXWE03VDNZOWx4THJ1ZjAvRjRha1NiL08xM1F5RThYVUJ1OVRZ?=
 =?utf-8?B?LysvY2lNb3hyK3RVa1VIM2E1eDlkU2hmOTZaTkY1Q2NGVWJzNEMxc2xmWlZK?=
 =?utf-8?B?WWtsd0lmWEJycy9uaHZ0YjNQaFh6bzEzN0Rwa0hrYlF6aW5CeUxEaUFQdEtF?=
 =?utf-8?B?UjVtWVRkYUxUU0QzUXo5NThtZFo5a2YvOUhPWWZTSjRyZllaSHI1eGV2S2tn?=
 =?utf-8?B?RGl2SDJieUJKalJUSTc2ejJVT3JVQVVMRnFUMlBEMG9vaEd3dlM0ODRXdXB3?=
 =?utf-8?B?VWd2eUJIZmQ0RUVIN0U0dSs2a2NwRVdXblpMUnVGNEVWZy9weWVRSUt3c1dD?=
 =?utf-8?B?Q2tBSW9aWE1VSmY2SjVoZFhKWS90VkVDaTZFRVRKOXMxQ3FoWTF1TTJkSmo4?=
 =?utf-8?B?Zmx5UytCeGY3QjFNekdQZWZMSmVXeEw2aDdDcHloNFlJS3B4YWw5NVNMaGcx?=
 =?utf-8?B?S0FBUlZoWUVXTEhxZTVxQmlVK2lMakF0bnVDQXQrWFdnLzF0K3FWTXNIQ3Z4?=
 =?utf-8?B?dkR2bHFqT0syY05ndHJIUGNPMWl1N0VMeEREVFVnZitHNEZLZ0lhTFY2dlV5?=
 =?utf-8?B?eGpsc2ZLQXpGV0lOa0FGU3ROLzBKMDhqS1U4V3ZQS3JYTFRsdkZoZGF4NmNJ?=
 =?utf-8?B?Q3dRRTZIWTBlY1Q4WmY1bnIvWG44Vmg5RVFVejBpaFh4b1h2Q29BeFFYNXJ1?=
 =?utf-8?B?SUM0QkNETnBBU1JFQzhnbzZKUXJLU3dYS0VGSE1HOU1qaFRrbm1mTzVudEQ5?=
 =?utf-8?B?STRIMDR2ZHc2ZWhSS1JNV1h6NlV5L3lFOHgrRTlQYnRYYzV6UGNWN2JEdnZx?=
 =?utf-8?B?NC9ubk93aitmeGhEOVcxOHAvODdnclZhdGlhYVpuNWNFT05IcTN0VkdHUVB4?=
 =?utf-8?B?K3E3QXZmbGcvWmNUMGJjNkxTRjRBb1RtUm9XR0R6bTVTZTRweW94dlY2dlpS?=
 =?utf-8?B?ZWV2R1JnWFN6MTlELzdoUkdBcDlWS2Vmc1hNc2QyQTZBc1Flc3kwVDJneUhF?=
 =?utf-8?B?Ymc5K3dIbWtjRUVkdVBNZGJ4elIrQlgrNTkyMHNXZUdWSWRWNGY5MVVTREJt?=
 =?utf-8?B?ZjhDVFhXSFFyZHlFVlAxSlB4ZVlmbWNMUTBUK05TZ08yK1RsdWlpaVhzVTVX?=
 =?utf-8?B?U2tKYWNNUDlhMHhpckJ5Nk13bXRoUThRWXFzUldHT1dFeUdwMDNocmFEV3c1?=
 =?utf-8?B?QXcvVkVxcWtkLzNzY0NpdVUrZHlUZGUrb2lFSHpUMDNEMnJCRGk5OEhqS0JL?=
 =?utf-8?B?ZVp5OGlwWXZSWW84OXBoaTd2MWhNaWVNYUlZdTFOSUpVZkJFSVNTcEp1NWtl?=
 =?utf-8?B?NGFaL2x4bWRzT0VDdmNxOWxCN2lzaVNLTEV2MENqdFQ3WDE5VTNuKzhmT0c5?=
 =?utf-8?B?RnFaNmVEZHdPOFdmcXoxc1dwT2NUaUx5TzJBU0s3SjJFL01EY3RUQlpETFZi?=
 =?utf-8?B?bU5xbm01cU56WSsvS1hjSFhJNTNUeTB4bFVaN3NFY2pPZnczbjVUTTJQV01X?=
 =?utf-8?B?VzkvWXA4MUdiTDY0cU9kMHhCeXdMaW9sUHRwcEpDSlBQVEhzUjhuVTNyZk16?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bfoi6wbpajxxiOwmNFOdCVGBLWxCUYVceka9PF5+BVtCRaeufDH1PhYlFC6l6bvMeG28aEv4NgNU4sKVCLvtEK0cRzsbCdncmrfjTHuh2cqopDjdKsNb8rTFIvBhyxp4y81fLDNL/1//Fv5Sv01Oa5Fl1wrLgF9qRuSC/q9gMvyRBZhrtFz0hmt8bUTWE4l4cX9kURg3Y7xusMadH6k055lb617dmcy5tr1IL2X8IUAWdbUTdRaGAlWXe3N5wxB8S8eoCgj/0UJ6YoYAV1550NHovZ6gqTP9IVz+vfvqB0qsVofmqQwJDZv7z2GFdfrTDsqEunyH/2CgmsoQ9DiNKZ2NAjcMwTVSjbFXRrELMwQW+oGK8m2n+pzC8r1K5yPTI7J406P2KVyTkMmL+rfZurUemWJyf3I+o7X4Gz6lxS4+douRsGC/ZcB9rxneRIiSGkYunwLWpsahBT/JCyfi3yrrjDJDQH2Y+6D4Wvv3YAppWV9VhbB42JBRT+7pwee9aBu64Ox85E1UI3q3rqh1Hh1sLVVva6CzCzpE090EeBuZz5OC3TVZrnh+gMxXoKFwQgENX0fLiEfXWYZ/cWnmcGdOumt/BtpB75hHeh14drw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd022de-18e8-4053-c8a9-08dc9ff76e32
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 09:13:43.6727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTmalRVaBvXQKwvzes9rGaAOa953t+6WuccDh5MN3619argd+pRU5TO39MmF/BjeeF8gXDaxXcQCqUPxlX1q6VZjL3pRm+YKFNqRfDyYktI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7794
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_15,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407090061
X-Proofpoint-ORIG-GUID: 8NAuB-SAslpduPf50Fs53ZIX7YV5jP8i
X-Proofpoint-GUID: 8NAuB-SAslpduPf50Fs53ZIX7YV5jP8i
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

On 09/07/2024 08:05, Cédric Le Goater wrote:
> On 7/8/24 4:34 PM, Joao Martins wrote:
>> ioctl(iommufd, IOMMU_HWPT_GET_DIRTY_BITMAP, arg) is the UAPI
>> that fetches the bitmap that tells what was dirty in an IOVA
>> range.
>>
>> A single bitmap is allocated and used across all the hwpts
>> sharing an IOAS which is then used in log_sync() to set Qemu
>> global bitmaps.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>   include/sysemu/iommufd.h |  3 +++
>>   backends/iommufd.c       | 26 ++++++++++++++++++++++++++
>>   hw/vfio/iommufd.c        | 34 ++++++++++++++++++++++++++++++++++
>>   backends/trace-events    |  1 +
>>   4 files changed, 64 insertions(+)
>>
>> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
>> index 1470377f55ba..223f1ea14e84 100644
>> --- a/include/sysemu/iommufd.h
>> +++ b/include/sysemu/iommufd.h
>> @@ -56,6 +56,9 @@ int iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t
>> dev_id,
>>                                  void *data_ptr, uint32_t *out_hwpt);
>>   int iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
>>                                          bool start);
>> +int iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
>> +                                     uint64_t iova, ram_addr_t size,
>> +                                     uint64_t page_size, uint64_t *data);
>>     #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
>>   diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index 69daabc27473..b2d3bbd7c31b 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -257,6 +257,32 @@ int iommufd_backend_set_dirty_tracking(IOMMUFDBackend
>> *be, uint32_t hwpt_id,
>>       return ret;
>>   }
>>   +int iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
>> +                                     uint64_t iova, ram_addr_t size,
>> +                                     uint64_t page_size, uint64_t *data)
>> +{
>> +    int ret;
>> +    struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap = {
>> +        .size = sizeof(get_dirty_bitmap),
>> +        .hwpt_id = hwpt_id,
>> +        .iova = iova,
>> +        .length = size,
>> +        .page_size = page_size,
>> +        .data = (uintptr_t)data,
>> +    };
>> +
>> +    ret = ioctl(be->fd, IOMMU_HWPT_GET_DIRTY_BITMAP, &get_dirty_bitmap);
>> +    trace_iommufd_backend_get_dirty_bitmap(be->fd, hwpt_id, iova, size,
>> +                                           page_size, ret);
>> +    if (ret) {
>> +        error_report("IOMMU_HWPT_GET_DIRTY_BITMAP (iova: 0x%"PRIx64
>> +                     " size: 0x%"PRIx64") failed: %s", iova,
>> +                     size, strerror(errno));
>> +    }
>> +
>> +    return !ret ? 0 : -errno;
>> +}
>> +
>>   bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>>                                        uint32_t *type, void *data, uint32_t len,
>>                                        uint64_t *caps, Error **errp)
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 158a98cb3b12..9fad47baed9e 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -25,6 +25,7 @@
>>   #include "qemu/cutils.h"
>>   #include "qemu/chardev_open.h"
>>   #include "pci.h"
>> +#include "exec/ram_addr.h"
>>     static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>>                               ram_addr_t size, void *vaddr, bool readonly)
>> @@ -152,6 +153,38 @@ err:
>>       return ret;
>>   }
>>   +static int iommufd_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>> +                                      VFIOBitmap *vbmap, hwaddr iova,
>> +                                      hwaddr size, Error **errp)
>> +{
>> +    VFIOIOMMUFDContainer *container = container_of(bcontainer,
>> +                                                   VFIOIOMMUFDContainer,
>> +                                                   bcontainer);
>> +    int ret;
>> +    VFIOIOASHwpt *hwpt;
>> +    unsigned long page_size;
>> +
>> +    page_size = qemu_real_host_page_size();
>> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>> +        if (!iommufd_hwpt_dirty_tracking(hwpt)) {
>> +            continue;
>> +        }
>> +
>> +        ret = iommufd_backend_get_dirty_bitmap(container->be, hwpt->hwpt_id,
>> +                                               iova, size, page_size,
>> +                                               vbmap->bitmap);
>> +        if (ret) {
>> +            error_setg_errno(errp, ret,
>> +                             "Failed to get dirty bitmap report, hwpt_id %u,
>> iova: "
>> +                             "0x%" HWADDR_PRIx ", size: 0x%" HWADDR_PRIx,
>> +                             hwpt->hwpt_id, iova, size);
> 
> This error looks redundant with the one printed out in
> iommufd_backend_get_dirty_bitmap(). Couldn't we add an 'Error **'
> parameter and simply return a bool ?
> 

I'll add it.

Just as a sidebar: This is a odd pattern which seems somewhat spread, that
somehow we only care about @errno as something to put on a message, rather then
letting the user know what exact error code it had returned programmatically.
Here in this series it is only important for the device attach so likely doesn't
justify a Error structure enhancement, hence the rest of functions I introduced
here can just adopt bool+errp.


