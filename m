Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2E7CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 08:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEO0S-0005Hs-C1; Thu, 30 Oct 2025 04:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vEO0B-0005DY-39
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:27:23 -0400
Received: from mail-northcentralusazon11013014.outbound.protection.outlook.com
 ([40.107.201.14] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vEO04-0004aN-RI
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:27:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=orTro5om/aYa03vlFvTnI0EEJvSBQb9RsLP/vKndiKGZG1EuqpfsuTk9i9Ve+c1wXpXbLkugyAgc7vaZorod1vqltCazpvEVeHSzt+5UWlS6zSai0ih5LxFgaxQ4Pvm2yMdH+w90ik1UEu7Cmzdq7Gs4V8BMSZCs/3aDlfMxdDLGtw0+ZLrB5H13KBoQ8ibsqy9irMLjvSqeMUZ+6FXgigsKO4P71N7JkxXHUvjM054UzZtO6TlCcIfQw3fv/Be3M/ymug/ZygjLNXmz6GHgNvQryJvViijVvVWH53I4uiwWFJx95csMFIB2U2Sf9ZIb1dmOnfRKdXhrVOQfMCHisA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xIBZlqKDNWAQmaOVmFbYd8c2EPELA3/ywP/DkIh2w8=;
 b=ohRpl88JagzSkRx0wMkAg7D53KXJgLGg+7HG1pyagAsOICYtAMrYVqzjY+xObn4grfBgGKocO1zTGONEcS4sBG27aoU4NVR/RPu4Y7qdCGsMbrbiW1oPC+TGrrMz9FNc1QFH8xZcldFtUmRlEP/ylKPGZGbLhvGxK6TBLm8WpfT8jj8JpOhLgRcHLTohbL/QKRgpCDa3TwOaG1TeTgu5pPw5T0i4f22cWHTA99GvTs8VWG+ElgUWEFqI3zCr5LqWeNXIetCA9IhxLkoSmNdyaFU6nhh43Vp7ya4oJQyF/tgHfgibjyXI3onRjZa0DttyDddZ2Vv/YYbfCA32ci+T0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xIBZlqKDNWAQmaOVmFbYd8c2EPELA3/ywP/DkIh2w8=;
 b=CxjL+ZI/Sb8mluALYTAdUCe65Mr7+EBEM5N6hCAOSWhUjPhu3i8kDVSLSL0k/b/aZxqLEDMdGZTpukmQ3j+n/ek0AXh0Qse8vGVizKZu2hpB6sDxSpszmPh9X1R8EqrnB0SAJ3jXYtST20vUWvR093FwEdgI720RVorCKT3t+Bkp6b3lP1Uzdum5E3E0fmJJh1558EdS/DMu36joUwKFWAuTZlNcAfp013friOYg2sV3Y0fAgSRgSKMQkM5gliO2QK0+CwE/x5pyZ0CJ9IHb46+BX+3Dff7bA2qOf5cO6AznViXHjKTNDfxF16EDJ2tOMRu/OfvHzY5SzT2wWA5OHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by PH8PR12MB6818.namprd12.prod.outlook.com (2603:10b6:510:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Thu, 30 Oct
 2025 08:22:05 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%7]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 08:22:05 +0000
Message-ID: <eb2e5419-7a63-47be-adaf-e34709d8310f@nvidia.com>
Date: Thu, 30 Oct 2025 10:21:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/10] vfio/migration: Fix a check on
 vbasedev->iommu_dirty_tracking
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yi.l.liu@intel.com, clement.mathieu--drif@eviden.com, eric.auger@redhat.com,
 joao.m.martins@oracle.com, xudong.hao@intel.com, giovanni.cabiddu@intel.com,
 rohith.s.r@intel.com, mark.gross@intel.com, arjan.van.de.ven@intel.com
References: <20251029095354.56305-1-zhenzhong.duan@intel.com>
 <20251029095354.56305-9-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20251029095354.56305-9-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::14) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|PH8PR12MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: adffb20d-9b7e-4a1e-72bd-08de178d68ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUlGOXlCMmxwSlFVT1lNM3crRy9Bcm5XUWtvRDFEdU9WeVJKS3hkTFhUZU5H?=
 =?utf-8?B?MnRwd21kak4waitDOFgraDRIeVVoakZnNGt1M3M2Q1JhK0xOdVZER1o0RCsy?=
 =?utf-8?B?QitWUTNSRi9NR2F4YWNIeEFNazJpOVlxaEFhYmMzbTVudFZzUGpoNUVQK3Fo?=
 =?utf-8?B?d3EwWWxNT0FobmlnNmtIaWhuNERPLzlHc2dWTmI0c3l5VXkwZmlNdytmUlk5?=
 =?utf-8?B?VUM2aThqU0NSRmplbWNIN3Z4a045anpOV3ZXbWlYLzNHNHI4dHpxV0h6TXJu?=
 =?utf-8?B?emZmUjZLdm85eVVvQ0Rkc0VxeW9QYWpVdEoxR2tJMFNhSm1vaUV3K0FvNmFL?=
 =?utf-8?B?ZEk1MG85eTNVeGVsVHVUK0RDdDRJWHNBdFI5MWFYSStlQXJpcTRWbFhVZ2lJ?=
 =?utf-8?B?VnZxdDdGL0lybmIwVmFwWnpaWnMzTllYNzdQU0I2R09sNlBuT2wvL084c3A1?=
 =?utf-8?B?TjByci9pVG8vK1oydUREQ0Y4SWZpQUJ4OGV0TmpCUTlzY2NuSEdDQjdPajJm?=
 =?utf-8?B?eGdNb3ZZWjJPc3NTVkpoYlU2ZlltTm9CeDNPaW1VWHI0bFJHTXU1MjBkRDFS?=
 =?utf-8?B?UnB3WmV5d0tFdVhPKzFGQXljZXZuREMxQ3V2cVgvSnR4TjRaejlMWDErbjM3?=
 =?utf-8?B?S1JCL3hodS9nVjg3Qm10eFhlQzFCRmptamZ2NURqcFBQbGdoYVpQa2xDR0dV?=
 =?utf-8?B?VWNlRTM4Z2VTd3FvcUhIb0NiUzNkWU1LQUc5RWhkZVBqRG1HbDMwbzlBT2FV?=
 =?utf-8?B?ZHFYNFg3eGlNeHpwNVRZYUZlS0NaZDk1SjdVUnFZMnhXa3JzQ0VSVW5aak5a?=
 =?utf-8?B?eThWQkhyTU5NblQ2cGFYSVF3YzIvWmNzUVhOQWd2WmJneDZOMDRMaUZQaFhJ?=
 =?utf-8?B?WHBTaXEyNk92Y0diOFFOSXdYTFh4U1BBM3FQWHo0WVZXUEMwK1JialVpODdI?=
 =?utf-8?B?b3d0Uk5lQ2Z1a1ZncFluV2JqaS9PaGpMSjFSdkV1SlloY2hpUG5MNWwzU1hK?=
 =?utf-8?B?ZHE5enFVZlo1SVVoTkVCa1VOZ1hwTEZqQTdPRHhZMCtmVTJYQjdhUzduV29t?=
 =?utf-8?B?U2ljL0FDZDRPaC83ZGdmVjYvb2l0eHErVEFmM3JBSFg5MCtvVkx6aE43RlRq?=
 =?utf-8?B?SGZIVDdMYURWek16b2lHUEhkcUJsYjJYT2o2dDRDVGlHWmU5dWNNenVvZUhY?=
 =?utf-8?B?ZGVxV2s2bE1pc1BtZHY0MWwwY1hMZitlRFY0MVV6Ris2ZTVtallRNHdMUmhC?=
 =?utf-8?B?U0w1NVRMZmpYcE1KKzRjTTZ4alFYNmM2TllPVm1hTklMRjNDTUxzUnFvS294?=
 =?utf-8?B?cEh6RTFEazN5ZkNaK3hnVEpSckN6MkZqVnk0b1dFSkQvbkpOelZrZVRLa3lW?=
 =?utf-8?B?ZjVsNENrdmJOYzMyREwzdFF4UkNuYWZNSm5SWkt1TEpEQ0F6Q01IYUJSUDZy?=
 =?utf-8?B?cjlnZjlyb3lDUjZoQkNpcUt4ejkxYnlKWGxXaGRXcS9sanRyMTZYSW83dHQw?=
 =?utf-8?B?c3R6Q0dyWHYxeGV2YnMxdU5KQmI5d0crcEdEQXphZ013QmJyM21pTEJuYldw?=
 =?utf-8?B?T1ppM0RUd2pzMi9xeS9SQURpcjFyQUc0UnBldlhOdlgxWFJhZEhIZGFUUkRE?=
 =?utf-8?B?cEpUTFdhNlpVRE5rTGhhTGVUdWtWZEdsSFhXTHZhVnZ2TjA2c2xTK3d6TU1n?=
 =?utf-8?B?WDV1bThlUVI0UzBVNkFrTnFUNnFDRkhrL2l2djhuMFJRK282WVdKY0c4amF5?=
 =?utf-8?B?cVI1YjVscmYvZEFMbzhvalNQeFh0UldvTVJTRHJ3K0hKZUlBOEJuYkxhVExy?=
 =?utf-8?B?SFdYNHRNMHRjbG02YmFIeTZOd1NNNE9hbjg1TmtMYlh2ekw3ZDdkd3pYaVI3?=
 =?utf-8?B?WWJFSW5KY2RNVHlITCs5TWg5RnI2VUZmU283YW0rSno3UEtUY3hMVndXZXdG?=
 =?utf-8?Q?tanBkvOvimw8cjF7a2GwfOE+UBG6kBSK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE54NHQzZWF2U092R2IreUpscjhRZFhVSXVrdGxHSS9nSm1mTU5CWEJuNTBK?=
 =?utf-8?B?eWFyb0l1aUF3ZmhKUy9qdWhCWVNrOSttUkUrZUtLYU5PTHdxQXR3U3BjaGdI?=
 =?utf-8?B?aUwxMk9xQnA3RGZvT1FGN1E4ZUZ5N1lCNmI2MmtHeUpBc1crNXFMeFhnaDhB?=
 =?utf-8?B?UnMwUDdLMllmKzVEZjBXSEVtWHpEVks3dHhpQ0ZibXgyOFlYdnM5Y0xXYTg0?=
 =?utf-8?B?NWZmWkJic1pKdEVVaG9kTkxzRXFnUmRRaTV2SldxOTh4THpjcVhlbUZqYmdy?=
 =?utf-8?B?MDFaNjZESWhYQzdxT0pGeWQ4Rm1wbGRoTXVNcld1M1cxMzhYRWlDaDlKNWU3?=
 =?utf-8?B?VWVKdmhJNjNUSkxuZzRYRHNLcTJNT0FUaWszWFN5SnhGRGNKK2cvQTRsZkha?=
 =?utf-8?B?R2xXeVJ4OHJKM21hb0FDSlduZ3VkVjA1VlFaV1ZucTUzd0RVcmhoR1FseVMx?=
 =?utf-8?B?d0wraE5rTEVhZXRNdHlRajAwQ3dMcS9KTUdYRHh5MnlCTTBoZTJrZE1GMGpR?=
 =?utf-8?B?MDdjUDZiOThlWFBBKzAwWmZUSUpoQUkxN1FpMkorY0VXYUlGQ1BEM3ZJVVhu?=
 =?utf-8?B?OXNyWk1OWnBJR0xkRnJBdjZFOWl6TTdkTjdaVHFvbjhBbE5qa29ubXRFVjd2?=
 =?utf-8?B?RkxzdnEveVF1SnB1dzlnVUJiQzZhZEN3TFpQU2JPOEZuQ1U3cUJtcWE3eEFa?=
 =?utf-8?B?NWZYOXdwS1RjQ0tvNERUVFBKK3IxSlFFM3BKcmx3OGJHZWduQzFvYVZCaTJy?=
 =?utf-8?B?RGFuTDBCMWhiU01va1h4cGpDMkFEcDl5dURQVURUVnVnUHRIcTlDUjJOVWx5?=
 =?utf-8?B?K2ZMMVh4Wk9jRlVlcnVWcXIrKzVoYUdQL1FCWEMvZU1FdVQ2aW5hcXp6Y2Q1?=
 =?utf-8?B?OHBqUGY1VW80V2JLWkpLVGloRmhwQVZnRDU5OEZjdU0xTm4yZjJacWIyTzFF?=
 =?utf-8?B?bmFNWEx3M2dWV1gvSENJSmQ2YlJpVm5RSExGU0N0RnUwTm5DZSs3ZTY1Tllv?=
 =?utf-8?B?S1pXWGlORTVIbnVmVUZJelpvY2Fsd2s4RVVkY0wxdWVSVXJYV3c3MnN5Sm9x?=
 =?utf-8?B?V3Nub0dtTWs1YVZLZXZIdDFKUHlHMXhOWWxucUdub0JCUHFybzJRd2lLWGIx?=
 =?utf-8?B?ZkJubWFGY2haRm9FOHo1SGFkN3VCamt3UUhDajJudkEyTm5kMGEzQ3R1QUFm?=
 =?utf-8?B?QnRFNVF0M0xNVkp1ay85Tzd1VkIzMUVyNmdyZ2N4MkZGMHNYRTVQM2FJYm8x?=
 =?utf-8?B?UklmaU1vN1NjbHE3ODl1SHBTZGtiK0RUQ0Y4NnZDSmtMOHZjc3BMdmg5ejJx?=
 =?utf-8?B?cG5UZk5pS3U5UFI4b242MTAyWUJNS1JuQ0NlbGQrNUgxMnBtUzNoVGprRHBB?=
 =?utf-8?B?elZSUlNSVEZ1QWZPdXhvWEkrRU4wUXA5TnBHS05UL0hKZzk4QzhyV0VyMG1S?=
 =?utf-8?B?K09zWCtCYUZoWDVtZVI5bWpCckxCTkUwTzFERnFyeVVobmsyaU1CMWRMckp4?=
 =?utf-8?B?MU14WU02dDkwZDJ0ckpwV1A2eEZmWEJKd3h2TmE5Rng4c2RFMW1XMlE5M0JL?=
 =?utf-8?B?ZVE1dnRVK3hCR250ZmpGbTV0UkNPYjZzUWMvSkVsTzQ1MXRLYmhpMDJzSGV0?=
 =?utf-8?B?QUJZYjZZQnZueFFiY0lFSnFaUzR3dTVpcTBGNTkvb0JNMU8wL3gwYkVFVEtH?=
 =?utf-8?B?SXk2UTZaNVNJK2xDMGMxNC9MRU9NNWN6OHBXL0tDQVhjR0NncUVmZVR0dXFq?=
 =?utf-8?B?N0N3dDV5SWdvOHNwajdVSEpkbjVaQUNNeHdiWU1Fc2VrWSs3Y09WQ1lGL0RO?=
 =?utf-8?B?a2Q3M2VHcVdjd3NVKzQwMUxiOGxIU1k4Vjg1cHRBUVovdmY5WkFCZWtacURR?=
 =?utf-8?B?Z2FsNHFzdnYrSG8ydnR2RkE1QXBCYXFNUDZWYVdPWWJxb01iYmdSMG1Kd2Y3?=
 =?utf-8?B?T2g0dkhhZENBV1pCU0FBR2plWnNtRXd1MVpCVVpWVHBXdXZPejhQc0F3b1RK?=
 =?utf-8?B?YlVySm5UNVQ1ckphRnNBRUh3ZDVGcm1Ba2ZUTkp0THZJaWJFUWUxcThKYWZ1?=
 =?utf-8?B?S0FyRXBkZnBxK3VqZ3RHYXV3MlhJREc1dTl0cVQ0STJ2L2NuVVNvenlSYWVo?=
 =?utf-8?Q?VV6wxrpW8dQVHVBKFBG/F/wRP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adffb20d-9b7e-4a1e-72bd-08de178d68ee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 08:22:05.4252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCaIo5tY5mYe2dtK2ujc138GZNacabJSRKc52YjDJS41i0hUJ03R+ZWOntbNTEGf4/ABO0XiGOZFdDRP/Z5XFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6818
Received-SPF: permerror client-ip=40.107.201.14;
 envelope-from=avihaih@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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


On 29/10/2025 11:53, Zhenzhong Duan wrote:
> External email: Use caution opening links or attachments
>
>
> VFIO IOMMU type1 claims to support IOMMU dirty tracking by setting
> bcontainer->dirty_pages_supported, but in vfio_migration_realize()
> vbasedev->iommu_dirty_tracking is checked, we should pass
> bcontainer->dirty_pages_supported to vbasedev->iommu_dirty_tracking
> in legacy backend so that the check is accurate.
>
> Fixes: 30b916778517 ("vfio/common: Allow disabling device dirty page tracking")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/container-legacy.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
> index dd9c4a6a5a..fa726a2733 100644
> --- a/hw/vfio/container-legacy.c
> +++ b/hw/vfio/container-legacy.c
> @@ -845,6 +845,7 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
>                               VFIODevice *vbasedev, Error **errp)
>   {
>       g_autofree struct vfio_device_info *info = NULL;
> +    VFIOContainer *bcontainer = VFIO_IOMMU(group->container);
>       int fd;
>
>       fd = vfio_cpr_group_get_device_fd(group->fd, name);
> @@ -883,7 +884,8 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
>           }
>       }
>
> -    vfio_device_prepare(vbasedev, VFIO_IOMMU(group->container), info);
> +    vfio_device_prepare(vbasedev, bcontainer, info);
> +    vbasedev->iommu_dirty_tracking = bcontainer->dirty_pages_supported;

IIRC, we intentionally don't consider VFIO IOMMU type1 dirty tracking as 
a real dirty tracker, because all it does is mark the whole tracked 
address range as dirty (which is the same as not having dirty tracking 
support at all).
Thus, when vbasedev->iommu_dirty_tracking was introduced, we 
intentionally set it only if IOMMUFD dirty tracking was supported.

So, I don't think this patch is needed.

BTW, do you have a real production use case for migration with VFIO 
IOMMU type1 dirty tracking? I mean, is the scenario you described in 
patch #7 a real use case or you just fixed it for completeness?
If there is no use case, maybe patch #9 is not really needed?

Thanks.


