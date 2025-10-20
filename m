Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52123CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 13:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vApZE-0004ne-Ju; Mon, 20 Oct 2025 09:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vApZA-0004nB-HD
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 09:04:48 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vApZ5-0006Im-7N
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 09:04:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pG1GoFujlh4sB/xc/mnPeqaTsTCN4o07ILxsWQkGq4H57tYfY902RKwab5PupHj+926aHYNyYrIse/RpooDKxAZ7hkpU1n+Z5gkGbUazi6G4lmsNTr2Wu4RP4LLs2TjnPhiaI142xeNpONvCINL/sDENsmC77JsayVpTs5dfV3wKDD8vVBFCsVOMlMKNp1dI221q+h1JKtPpNjB6IJXISyVSIlPDk1B8vbpI/sBMScTDW+L2ccXjm+ruv7lr+spgr4hReVGNwKBuQ44+Pq91A6n2ItAIo25vsbeJosPNLUCgCIESUnjYMSbEe9ERWuRRT8psIbaC4ZUO9MKHWQmvDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPo309y7WWQs0F9CHyclekAGoavFcl3YH6/Ap9JEOF0=;
 b=MXSeSMMNO5N+lSoKc9KWxIWI0P7UBjOFvUa5/8R9O8h2FM1TgXd3Eos4P4Lqj7TYUxhK3GQuE/hIWVrPzDmNsNQt+VR1uFE7gvU280uZ9s8C8HLYYhYkxhQCekR26shvuJd8bhDLFAPltjZuLiktBZwqLW4rZVNQVXp0Sj9X55U30M0nrWXmWPcZWeLdJZhx7GYSGplsTtSbqgMj3Ge8Hv+D7GTYXrQis6JnBIiXIp76eVMBbrYn57tqlwSYLZn1q8jnwVtV/duvnjxFrE14AICSFhAUC2Bzb+opjOGVKbDqkvm2rSKXuaLf/XJh6RpyCHCGmRMDKz4isGMxqn0qWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPo309y7WWQs0F9CHyclekAGoavFcl3YH6/Ap9JEOF0=;
 b=UGBYAujWUvF5dQCk/nbFlDf+mY0zcWPIh4hUTk76mOlQdlYeJuANPsO3H9vsYw2rYzbDlb59kRR8wHs2GNxiFA3QZCqV03UphbZZv9y7Z68QV9xj99bz2k3gedSU1efqXyhszu8n/63zpKOggpKMeaU61RMrLcSh5Z0OGnDmOFWt1JNf3IF1YZJ/o898xAiJbpsvR5dT7nGvkFd8nqmfHYR3SReCBQ1KHulyA6atWQDrmogW1YuZri7J2adxK1wIFtviejnMQlraYuFXLxOQ+OzN9LgjAPoYx9siqKXF0MWuGStOukwlv+zhtA8ZN9oSNv4vTVD+iWydNlZ2DjIIcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SA5PPF9176ED2F1.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 13:04:33 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%7]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 13:04:33 +0000
Message-ID: <ca586528-1798-4d67-9d93-781f5bec533e@nvidia.com>
Date: Mon, 20 Oct 2025 16:04:27 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] vfio/iommufd: Query dirty bitmap before DMA unmap
To: Yi Liu <yi.l.liu@intel.com>, "Duan, Zhenzhong"
 <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "Hao, Xudong" <xudong.hao@intel.com>,
 "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>,
 "Gross, Mark" <mark.gross@intel.com>,
 "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
References: <20251017082234.517827-1-zhenzhong.duan@intel.com>
 <20251017082234.517827-3-zhenzhong.duan@intel.com>
 <e620aadd-c70b-43d3-9832-0cc1fc9d7c3c@nvidia.com>
 <IA3PR11MB9136BCC9994E40C674FE495792F5A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <e7cdcee2-1df1-40fd-8f46-42e8c75185d1@intel.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <e7cdcee2-1df1-40fd-8f46-42e8c75185d1@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::12) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SA5PPF9176ED2F1:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d6bc5f0-3f77-42a4-2d64-08de0fd93694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0ZXek5RU3FFVHdxYldTbzczVEExWEU1VmNqVnU2anM4TUI2czhQRExVNFhR?=
 =?utf-8?B?RGFQWlJIaTU5SlpIY1hoWUZnQVh4cDNvcDhFZnhKSGkvWUNTb3VMZld3cHRm?=
 =?utf-8?B?SmNpOGowd0swS2tyUUZMMnFiTWFTUm5qZGRRWmcwMnVzMmlvb1JVZmZCcWU1?=
 =?utf-8?B?NVpSckNkdVJrVjhqbzU5RitDUmhGU1J3c2hrRDRwUlZhYXVZY20ydU04YjBR?=
 =?utf-8?B?T2w1d2NSL0JTMkJqZVlIdmNDRVZJdlhNSWl6N2x0WDVNelRpNnNqUHk5MWRB?=
 =?utf-8?B?WFBncDcrYWJzZDRMQzZGdkVhc25GcDhPME5CRHp6ZzFaNjdBR3lVUmYwQ2pF?=
 =?utf-8?B?WDdDUmhjVlduR3NQdUhhZ29sOFdDdHRLY0NBNVJkOTlxL1o2MEVINTZ2cWJM?=
 =?utf-8?B?S0dONGFKOWN5YzNhRzN6cklhVFQxUzNuZDR4WUE2ME5zVVdtSWhPajBrcERr?=
 =?utf-8?B?VnlwbkM5MnFnVUlBLy9QVXFFZ25xT3g1bm0reTMvaitjTVFKL3Jib1RNYmRE?=
 =?utf-8?B?TU5CRzY4QklwTXB4UEw2andpeGcxYWNrdCtvZ1U5cnJMZCsxY2laMzZpRGNw?=
 =?utf-8?B?aXFxUmJjUEtVOFkxdVJ5MlNNRGVGMFNEVjJPMEU1QmI3MDY1enBWejBpSG96?=
 =?utf-8?B?bTBxdm1Pa0lkTXdaSnlkU1hVTUYweFZYdm1ENjdwNDdEeXNQeVBOUENWMDRy?=
 =?utf-8?B?Sm9HYWdUbC82a2dzUWt5NUhNVjd3OHVTa1Bsa0RxazM5blZpVTNjZmdUdDBX?=
 =?utf-8?B?Rm1FZ3BDK3g3T0thVVBiMUZuVjA3ZkhmTDR6K3BZMGpiQXpwSWVmMTl4OGxT?=
 =?utf-8?B?WDFMa2REeFlvYnphbDB1enVWc05HWlZROGUrZ1lMcm90R1BXQ29ydzJ4MHZk?=
 =?utf-8?B?SW1UeDB0b0J3L080S2R3b1hDSWY1Ty93TUEzY08zU3EyOGNwZG8yRHVJb0Uv?=
 =?utf-8?B?cDZGWE9jemFGY2QvWnV5b3B6SThOS05Wa2JGNnVxQ1VIWWVJWlVDMlVzZTdw?=
 =?utf-8?B?Y3F6QlQvSG4ydDc0eDJrcnljbVpuQ1ptTVZ5WHFuSVV5dzBjT1RpK1V3L04v?=
 =?utf-8?B?YXFSRUd5SFhOS2tQWnJXZVpMbWxPVWd1YUVrVDJuR0thK0NUOVFSZGUzYVdi?=
 =?utf-8?B?VVI2a1dyK0Mra1pRdW55NXBVeTBQN2MxR0FVTVdRSFpPWUU5NUFnZ1JoK2lN?=
 =?utf-8?B?dVNlbGRGTDltbzAzN0w0bnU1ZndzY1B2WlZBVm9QMURDWG1FQVkveXQxci9F?=
 =?utf-8?B?OW9aMG9EZmdId2NVaEsydzNWK21ZQnBZQ1hzUUdXZjVLaStyMTRxQnBXaDBj?=
 =?utf-8?B?OTB6cjhlYUkrZG1BRExNeXFXQVBoR0V4K3R6SVhINFYxaW1PUVN6eit6THJB?=
 =?utf-8?B?MitRMXBrLzc0dFFDa2lRZVJubENSbHgwMkd2aEc1emsyTXY5U3I1a1Z1MlA3?=
 =?utf-8?B?VmNDcVJpOVAycVJ5WElRVkwwUnM4S2E4YXN2UGdPc0s4dnZHdW5aTkthME4x?=
 =?utf-8?B?ZUFxMDFYb3VUcjZMdWZ1NnlMc3pISUpMQURzcmU3eERSMTRpWkZCaWxaTDJh?=
 =?utf-8?B?bElQaFVjNWRlSE01ZGFkYk56am9BeWhYTEx1NkRZTkZVNnZya3Jsa3RnQ1E5?=
 =?utf-8?B?SHVDN09YZUJMTmp6dTU5YkpOQzBncTlDd1AvK1ptOWxXUTNqZ29na281SXpZ?=
 =?utf-8?B?dVRpK3o5cEM4Rk5aQUtydDcwcGIrUE1ZSTJCMWExYTdZUmlYN3BaODRITUE0?=
 =?utf-8?B?c3ZuM3ExQmszQWRIL281OTJmQ3F6a1hIeXltNkM3WE9POVcwekNzcVp6RFNs?=
 =?utf-8?B?VTkycFpCYXhBU3JNcitzd2NPWGwzUEIxYms3eThBSjI5RDZadnFZRFhqcGFL?=
 =?utf-8?B?dk9JM0k2aUVpSVlkOHI4dGE3Y2o2ZER3b2RXQWNraDVNOGwyZHk3RnVmaGYz?=
 =?utf-8?Q?gQaRmk+KZWkvRhG8P1yrtGT3aX1siwZH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHIzN05TMUd1VDhZMHZJdlN0M0tTaFA0L20ySEdObTZTWW9SMkNSakRwZ2c5?=
 =?utf-8?B?Q0VQa2h2L21rS1lTTlVKZVQ4and1b0lBcmtZOGZPaWVNL3Brcjh6dENhbTN0?=
 =?utf-8?B?c25rWDFwMldxR2Vra0w0aEw2MDBRSG9vUGRiYXBKK1NvYzQxanhucFd1dm5m?=
 =?utf-8?B?c2s3US9CVmJNbnQ0TEc5b3hub1FKV1dVWnk1bFlnbWk1eGhQdFN3R1pXWVI5?=
 =?utf-8?B?ZENCa2ZxK3MvZDN0QnBCRS9vWWZ6d2pJVTVScWZWa3prbFk4eWJMYktCcmxW?=
 =?utf-8?B?Rm51djJPSzVKZUZvOGxPU2pUYVl2SEUzZUZNWWU2ZU9VWnNPaUVFMEw0L2s2?=
 =?utf-8?B?cDdycmthL24xdC95NXhHcnFnakJiclZBcWRsOG1JaHh1YkNoMkJ6NE5YR09p?=
 =?utf-8?B?UzlldnZBSW56SE0rQ0oxYStrMGNYZ0xNU3pxaVB1aWNLNTEwKzhmaUZvZERF?=
 =?utf-8?B?QkNSUlNMRWxkN1M4czFzQlhSelFxRFpieXBrcXl2SUNLeXlGTXB1bmQxQmtq?=
 =?utf-8?B?b3ZrOEQ4UkhTSzBrS0ltdFBkdW9hYmhmSkx0eWR0YS9nTTU2bE1Ka0IwcERr?=
 =?utf-8?B?Nk1ncmlDaVNOcUh0akphOW56QzFFS0ZsK3RRTTJIcnNWN0Q4bVJEcThkbGZL?=
 =?utf-8?B?Rm55ZkVUek5CaVdMWUVJUXpHbUhBeDZ3RVo4YzlVWjdpM1l5K0xYWmF5TzNy?=
 =?utf-8?B?ZkF2bzcxNTJhdTNvSTR5YndBWGZvaUpnWExqeTIzN3BWZWY2ck15Q0VvM3ND?=
 =?utf-8?B?VU5HNEY3WldKdlFVUWkvaERWanBYWlpTUG1adGJ3VjBncXNmL1dEUUJCeXAv?=
 =?utf-8?B?NG5OYlpJZ0tMdkkvekE4WFliUDVmczAza1hFUGU2M05OdUdjb3V2K3lhWWtu?=
 =?utf-8?B?dmMzd1RhZitnK3ZZT21OY3JwaUJod3BvVXgyL2hYdHU5WnlJVVVyY081dmsy?=
 =?utf-8?B?djdUTGI0S0ZZK3hacWdMeFNnSFh5ZngzTzI4ZlhwM0pESHplV2N5QmRKY3NY?=
 =?utf-8?B?Tnh1elorUFZzRGU3d1plYlNuei9ETjAwVFZlUC9NR2F5MXZBTkYrZnFuMFQ4?=
 =?utf-8?B?V3VtSTVRQXRKd1d6aVNVWDc4blNtYXNhYWZEV2ZQcGVIdDRXQnBQdDQzeVV4?=
 =?utf-8?B?LzRYZ2hCWi9TRit5L2svVGNPWmRzTVBHZ0V6aGNPRXRHZlNOVVlhZmNJUU05?=
 =?utf-8?B?blMyMnA5ZGx1UUJtOXRtbGxEdWRLMzJjZS9YY2NuaWFOQWo0SGxCdkNjd0wv?=
 =?utf-8?B?UUJrZXI2eHl4clN1RW1TTE9YUlZiTmJNTkZZS1Fwd3JGZWU3ZXJmRUZEMnJz?=
 =?utf-8?B?T1crNnFSSUdqOTlLUjAzMEswV0ErL2FzREEzQktUTlJaZ1AvckUxQ3RZam1C?=
 =?utf-8?B?K0tzN2M2M0dpcVJITEFQZEJyeFZPN3VacU1sRzV6Unl1UEVjT0xIUkEzWjhu?=
 =?utf-8?B?MGVaTTlJV0wzaDRUdCt0RmZjRmcwN0ROR05ZTGwrTEhPYXVaMVZ1eVppTmVV?=
 =?utf-8?B?RExKRExyTWhveTJkYW90SVoyWU15SjRJcTBacjJFZ3IreDRORTdCUnFkQnNU?=
 =?utf-8?B?MG1lL3lIcXRSV0l4S0U2REZZZExaaytUdFphNjgvOVNiK2ZIK0NPclVMNkgy?=
 =?utf-8?B?czBtVHpjMVJYOCt2blpEUHd6eFpwbDJyWE16MUhkWXBzRms1SFVMRGQxUC9i?=
 =?utf-8?B?RkRXRExvWmVUajE3bnFiYnJ3MEJHNFljR3NQckh0ak9IN0dQb2RsZDZwRGNs?=
 =?utf-8?B?WFc2aXU0Qlh3ZFdUMGZKN0tOM1dsZllmMm4vV2F3S2h0a0NOSGxTZEhaNFRq?=
 =?utf-8?B?VFhvZjdYYzEzaEp2WlByRjRNd2JCeXduL0FWOERRc2pIeXJnY25NRkEyNjJo?=
 =?utf-8?B?ZkhlRk0vam1NSGVueG80Qkl1dlFqTUpDbk5JTTNrczhlOTcyL29OdWRlWE52?=
 =?utf-8?B?Lys1QWdNMGFjd2JDMlFianVjWmxoY2xuNXBWaUhScWRmMVo2RTBCVTRmNDV6?=
 =?utf-8?B?cEZVeFhudDNQMjI5Q05FNnRINnBadFFJSWthbzdBenZhOURya2RqU3JBN2hU?=
 =?utf-8?B?OThCTjMzVXYvMHcxbGtJeW1VZi9zcGJ6ZE9rR3llYWVQWkRWVGZYVUJiREFX?=
 =?utf-8?Q?CKm0ZVtHcNu270GzNBbCSwroz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6bc5f0-3f77-42a4-2d64-08de0fd93694
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 13:04:33.4143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELw6U+N5mwxcD4GJDplxvS5kyXwnwLk0d/95BE0zVVeqMbH7btHkHQeYvE6Qx02opLVhE+RKPvGNnqbUh2FrrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9176ED2F1
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=avihaih@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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


On 20/10/2025 15:45, Yi Liu wrote:
> External email: Use caution opening links or attachments
>
>
> On 2025/10/20 18:00, Duan, Zhenzhong wrote:
>> Hi
>>
>>> -----Original Message-----
>>> From: Avihai Horon <avihaih@nvidia.com>
>>> Subject: Re: [PATCH v2 2/8] vfio/iommufd: Query dirty bitmap before DMA
>>> unmap
>>>
>>> Hi,
>>>
>>> On 17/10/2025 11:22, Zhenzhong Duan wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> When a existing mapping is unmapped, there could already be dirty bits
>>>> which need to be recorded before unmap.
>>>>
>>>> If query dirty bitmap fails, we still need to do unmapping or else 
>>>> there
>>>> is stale mapping and it's risky to guest.
>>>>
>>>> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>> Tested-by: Xudong Hao <xudong.hao@intel.com>
>>>> Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
>>>> ---
>>>>    hw/vfio/iommufd.c | 8 +++++++-
>>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>> index 976c0a8814..404e6249ca 100644
>>>> --- a/hw/vfio/iommufd.c
>>>> +++ b/hw/vfio/iommufd.c
>>>> @@ -74,7 +74,13 @@ static int iommufd_cdev_unmap(const
>>> VFIOContainer *bcontainer,
>>>>        if (iotlb && 
>>>> vfio_container_dirty_tracking_is_started(bcontainer)) {
>>>>            if
>>> (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
>>>> bcontainer->dirty_pages_supported) {
>>>> -            /* TODO: query dirty bitmap before DMA unmap */
>>>> +            ret = vfio_container_query_dirty_bitmap(bcontainer, iova,
>>> size,
>>>> +
>>> iotlb->translated_addr,
>>>> +
>>> &local_err);
>>>> +            if (ret) {
>>>> +                error_report_err(local_err);
>>>> +            }
>>>> +            /* Unmap stale mapping even if query dirty bitmap 
>>>> fails */
>>>>                return iommufd_backend_unmap_dma(be, ioas_id, iova,
>>> size);
>>>
>>> If query dirty bitmap fails, shouldn't we unmap and return the query
>>> bitmap error to fail migration? Otherwise, migration may succeed with
>>> some dirtied pages not being migrated.
>>
>> Oh, good catch. Will make below change:
>>
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -65,7 +65,7 @@ static int iommufd_cdev_unmap(const VFIOContainer 
>> *bcontainer,
>>       uint32_t ioas_id = container->ioas_id;
>>       bool need_dirty_sync = false;
>>       Error *local_err = NULL;
>> -    int ret;
>> +    int ret, unmap_ret;
>>
>>       if (unmap_all) {
>>           size = UINT64_MAX;
>> @@ -82,7 +82,14 @@ static int iommufd_cdev_unmap(const VFIOContainer 
>> *bcontainer,
>>                   error_report_err(local_err);
>>               }
>>               /* Unmap stale mapping even if query dirty bitmap fails */
>> -            return iommufd_backend_unmap_dma(be, ioas_id, iova, size);
>> +            unmap_ret = iommufd_backend_unmap_dma(be, ioas_id, iova, 
>> size);
>> +
>> +            /*
>> +             * If dirty tracking fails, return the failure to VFIO 
>> core to
>> +             * fail the migration, or else there will be dirty pages 
>> missed
>> +             * to be migrated.
>> +             */
>> +            return unmap_ret ? : ret;
>>           }
>
> do we need a async way to fail migration? This unmap path is not
> necessarily in the migration path.

I think in upper layers there is a check, if migration is active then 
migration error is set to fail it.

vfio_iommu_map_notify():

         ...
         ret = vfio_container_dma_unmap(bcontainer, iova,
                                        iotlb->addr_mask + 1, iotlb, false);
         if (ret) {
             error_setg(&local_err,
                        "vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                        "0x%"HWADDR_PRIx") = %d (%s)",
                        bcontainer, iova,
                        iotlb->addr_mask + 1, ret, strerror(-ret));
             if (migration_is_running()) {
                 migration_file_set_error(ret, local_err);
             } else {
                 error_report_err(local_err);
             }
         }

Thanks.


