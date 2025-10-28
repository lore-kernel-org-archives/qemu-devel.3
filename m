Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529F7CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 13:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDjcR-0005Fb-Qa; Tue, 28 Oct 2025 09:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vDjcQ-0005FJ-Ik
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 09:20:10 -0400
Received: from mail-westusazon11010048.outbound.protection.outlook.com
 ([52.101.85.48] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vDjcI-0002bA-2Z
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 09:20:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GgwskStlGlKO94iZeKkdDD8DQxOERlEAeCf7PlIxWa5ldXYOsg+T0NaukQ+5+CP+ONlp5t1c+ImsQu0Nyx8jQrae81w5K6ukzyAvjwtrZur96L8Szw2iGoENly/9vVcIUiFWqsbi0Gi4hfNN87izFN9vxSEadwoQqCeIcn5MUTlAswO8JV6cuPofyPAn17H2lSVGgLU1gTyjbP1SmoNVVGJ6p7/g7M5nO9Aplu7Qa0WaMzTZPeWFNhtQ/A1qPADBOrOXGtXzg88BbV/9pHp4tZEyoqZdaPIzzzTajre2wvCTB7SvdWEeRp7MAOMkD1a8LgLEFSllJO4wB4x2+UtyzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Do85LTcxDu/GXW4KmEm3Dpx8fIw78PtmJnPjFEjP2fM=;
 b=vTeknpzFk6pD8oPrtKcJZF/+3QLeZ0dEHunR6Gob4kARw+06YrUlD/RVJsO/yF7lGed5aipz/FVy/3TjfJAwlFaEyjTnPQ7iMpcphtPS6uVYcB/7+AGwu2FcehiKC/AD/+MUVq5hTi6rYkafCU2iavsnFgbX0qck+JUcoMtx0aPuxIdHWRE5lUaFWB3XAIJQlXY0gjZj2Bsi0a2JzJmkUGrZJCao2fWAIBZPiZqARUtimeOIsXc5hQOHWMbJt2xtBaJHckaPa8FOv7RjHZkMH2s1BgELhCDhNYvKuDoKjnYt6j4ji9G/uIyhQ84tTSyd4CpI7BwhrZ6nHeWzDdl9ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Do85LTcxDu/GXW4KmEm3Dpx8fIw78PtmJnPjFEjP2fM=;
 b=K6ATV9wPk74Fdh24+DNEwKr/9BkZ03S6xwog++r+emUegbpmFEBYSG3dptZ9k1nRHjjJNn+aZqIyakRzc7BuOEbxyYODzVQJzL/xsNu2kwfER8yvznMY2euvXtFxZNBPysv5c82mqr6DGRv7R+MNzJyKytJeA/ywDuypsnocDjpXieAKy9buKTHYEAJN0jlxaCQp+RPtK1N1fMIYffQy2J93jxVk+LxBt+7f0p6RdMLSADUmhn4MlJ1mSPE9YAOOHrWuG4vNKizHMMk0Nr3c9EPZRpdv8k4Zi4JU+9LFNLm332SHEmmVv7Er9zyPl7CGvzaxK7UTUioli368FrrZdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by IA1PR12MB7688.namprd12.prod.outlook.com (2603:10b6:208:420::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 13:14:48 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%7]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 13:14:47 +0000
Message-ID: <d1668b37-fb8b-44f0-9f85-fb68a999056a@nvidia.com>
Date: Tue, 28 Oct 2025 15:14:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] vfio/migration: Add migration blocker if VM memory
 is too large to cause unmap_bitmap failure
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "Hao, Xudong" <xudong.hao@intel.com>,
 "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>,
 Rohith S R <rohith.s.r@intel.com>, "Gross, Mark" <mark.gross@intel.com>,
 "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
References: <20251024020922.13053-1-zhenzhong.duan@intel.com>
 <20251024020922.13053-8-zhenzhong.duan@intel.com>
 <df474b7c-b210-43ba-9c0f-97526aaf5f93@nvidia.com>
 <IA3PR11MB91368D67E7C5D853161B7D0292FDA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <IA3PR11MB91368D67E7C5D853161B7D0292FDA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL0P290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::12) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|IA1PR12MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: 775e1bbb-6d6a-4001-68b7-08de1623f7cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnRyQkdhUDBDRm1ZWmRWNFYvRjdVOE9EWUNMWUg2TDhlYU1mSStkd1JHRkFJ?=
 =?utf-8?B?UlJVZWMrSEkvZHNyeitrc3dKRWtEV3Jvd2MzODV4MU5nWW1DTjlJNXNiMEwr?=
 =?utf-8?B?UXIvdXJwdlhWQzk0S0xZS2JpQ2lFVHc5alBFMEtJWU44NzZlNm9JK1NhdHNI?=
 =?utf-8?B?SUNJamZpYXFYUjRhNWx2S0M2Y0RIVUdkOU81ZWFObXFBWWdiZTBYY2ZjdDlX?=
 =?utf-8?B?K2ROYWluQ3lGMWVSRXpEaG4vb09rbm9pb3lnVDJ4Y2hzVGo0QWkxMUt0QXc5?=
 =?utf-8?B?aFNBYk10Q0hVallRcFdmWm5HMVNHNTh6amYrVXRFZDZYejRUWkc3VmxucFBF?=
 =?utf-8?B?Rkx0TVREd01ON1NyNEMyYk40VnFwZ2tuZGVLb1N0MnFkMjBkUHBpMGNYZC9H?=
 =?utf-8?B?WG82NFJwREtJaysxZjdNeUlRM0x4SU1lMDVIcFFVNzkvNjE0Qnh3T090MHlw?=
 =?utf-8?B?bTNWamRnZlBEUlNqbzhGKzB6eDAzZFhRK2FlaHZSZzRLa2V3eVRlTEhyKzlZ?=
 =?utf-8?B?N3hySzBObGx1M0ZQak5tdm9tdmFKb1FjQ0NCODdNWlJaOVFVTG1XajhVcThv?=
 =?utf-8?B?a282V1pPRUQ5Rkh1azUyOW5FMEI5dGZQZEIyalBZcS96WkVFaVN2T0lPY3ZJ?=
 =?utf-8?B?MVRIWnJVdjdRQVgzNjNrdnZwTlg1TWhTcVAxZ0p4QVp0b1BjcnFpZSt2Qi9D?=
 =?utf-8?B?cjFHNzZZbGx4WXRMcGhtTGdnQVFiY1B1emFHRGNKUWdLL2VXZjVNNTFCaUFB?=
 =?utf-8?B?N281T0txSklwTjZDZzUwR0VyR2lKU3diMGlwaVZtTkIxbW16bmtRaENLeGk1?=
 =?utf-8?B?c2JtSnE2Zm00MlNKMDBXc2FMaHJJcHhWN041M1QzMlZYNzFvQjhlTU1uUXpm?=
 =?utf-8?B?Q1MvWW9wdm10VFpYZjUzQ2IxQiszVWZFZ0R4VmZVWTBGZmphQzg5dmxTZUFH?=
 =?utf-8?B?N0tSUzZCOEdBNlBJdndlNjA4SWI2SGV4clpPQTc5Z0ZGaFNxTzUvNlE4Uzdz?=
 =?utf-8?B?UDlPZDBYREo4T0U3SGxLZ1c2REFkR05vTkVWOTRjUDZYNDJFakhRcE03dWR1?=
 =?utf-8?B?Tlhyd3ZtY3kzNHBTamV6d3NnaHNqMjk0ZVBtZkR0ZDRaWUJiaXhUbnpEUEpW?=
 =?utf-8?B?RVdyMll4NTg4TGhxUkRpWmZtQnA5Ykk0OE1VcWR1YXRPM0Jxb3krQzRjcFYx?=
 =?utf-8?B?S28vTThRM2FJZi9OVWtFcXAwSEcrYkswbXZBVWFyRk5razJ6Mm84Nm81Zloy?=
 =?utf-8?B?N3BzY29hcWFJekZLUStQa0ltdzJ0djhyK3JOOWpaWUpzR0RoY0Q4QXVWbFBK?=
 =?utf-8?B?cnlHc1pidGE1Ylo5aFJQaFA5TTBCTzl5UUxzZVNyOHRmaFhGMVBTaFUvRXFN?=
 =?utf-8?B?OE8zbk1Mbm5ESlM3NmlpOW1MbW0wRXFxYzlYL3JFR29tYWppMVhsZmZZYXIr?=
 =?utf-8?B?T2x0L0tMaWltVFhOUFFtN0NaK2Y4RjlqMUxkRDhmak9kNmpzRmU5RkVwcHky?=
 =?utf-8?B?Mlh3NHc3M2lNZ0MvWENNQk5vRHpvYnJkOWswR0R5UUtMdEZWN2JaYytiL0tt?=
 =?utf-8?B?KzlLWGxZZ0RyQmdxWjBSYmwrQkIwWHFDOEh2V2plSzBReEdDdHFmVVZwMkNL?=
 =?utf-8?B?WVVkVy94UTdnaEMrZmNXNFltL0JTWGg0b1dxVGRwMnh3eitWbFFtVndtK3dw?=
 =?utf-8?B?dlN1WDY5clI5Zkp6S204VTFHbG10R2lXOFY3aTgxU3YvaHRIRmQzNGcyRHpI?=
 =?utf-8?B?Vmp6MFE0WVladG0zbDZMZEh6NXZJcnZGbnN4TzlQcEZlajNUUVFKRnpHODlH?=
 =?utf-8?B?K3Jmd1F1L2l6U09wQWttL3BXeHJ5Tit2OHAzeWNteGN3ZzZybTVGaTdCalMz?=
 =?utf-8?B?VWRibzhqNXhOaGI0Ri9UU3E5aDBFUU1CdDF6RHJ5N0ZSU0pCSW5FZzNHdUU3?=
 =?utf-8?Q?7eMxtKias5PB7Uly6RvPW2yiK6UBTiAv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3VuKzdHN1QrcHlGN2lyWlFwKzRKdVdTViswOGtFZFhBK3JFbm9JZFRZQzcx?=
 =?utf-8?B?R1Nad3R1c0Z0QVE5QSs2OFIzZzFacWhPSERhSFJEUGRXMHFMbTlUWldEZ3N5?=
 =?utf-8?B?eE84anZGenBGWlBmWGtkSGtLdEN0RHNjbjRTZFpuQi9vcGIzUGlOTTNGdytv?=
 =?utf-8?B?SHY1WHZub3gwZmFKN1JpTmtXdERqZVNSb0dPWmhpc0VKQVdNRE5oZWVkM1Nx?=
 =?utf-8?B?OXNVVGxOYW9GTUVkamVmcXlYTG4yejBYWVFaR3lFN3ZEenc0UkpQdTRZYWlt?=
 =?utf-8?B?VTRwTk45S0xaWFBsbi9MaDZDSkQ3eWxFTDBlbkJsY2E2c2tzcGJkNEV0MDVX?=
 =?utf-8?B?dEw3Y2VJelBlbkFIVGJXU2hBamhJZ0M4Mm5ER00xekZkMWR5RE1TUnpmR2FJ?=
 =?utf-8?B?Tnc3UmpNRytLRGlWeWxWUFQ5Y2pIQjVUMitrcGttYTFlb3Z5dzA3RlZSSmdN?=
 =?utf-8?B?OTNFNXdhV0svR2V3dmp6VENHbTVWUFFmMUcwQjZVY0RlUlpCSlh0UWFRUmxl?=
 =?utf-8?B?YU9uTUZYRVBjOTZBUEs0ZDBqdGJLZFhpeGs5dEF6a0NYQWQyZm9kU1J3di9r?=
 =?utf-8?B?d1doOGN3WDdHT0JYZW9nQysyY3FtZ2QyYWVqb3p4aXplRSs2WnFJTDJ4ZXYz?=
 =?utf-8?B?TW5qU0VON2JhN2Z5VjRONWxaM3pVSTdaRW5GWFc3NWVIV0VUSWgvSFUwaXpq?=
 =?utf-8?B?UlBmc2ErcnowNGZVMlpqc0tkcDJlaC9YU01BL09Iak9EZXRSUUI2OHBOcTAz?=
 =?utf-8?B?UTU0ejlubnROU1krNEs0OEU4UHdvRkdOSjUwdnlXQkxUMkxMN29XdlVQYXU2?=
 =?utf-8?B?MUtSM2Z0aWphdmpFTUxYLyt2WkFYUkZ3LzJOWDJuSU02Nks0WXFUQ1c5aHJL?=
 =?utf-8?B?Nm1SQmdXK0NkRHRUUW5HaDdLbG5DWmZxM3htZHBtK3M2QjFObmdSOHFLZkVI?=
 =?utf-8?B?eGhtOCtkN2pxdVd0ek9hVkpEVFcwYVVjWUtGTG16OVVKUytRcFNOd3JTcEZh?=
 =?utf-8?B?RnNGeWd0NkFjZkluRmZXclBHLy8vTXI2Z2I5dTE3QUJGTXU2OHo5emVwMER0?=
 =?utf-8?B?VGswS2JicXlhdFJnNGxvV09paUhrK05zdGJqOTRBS0VydTlhQmFZbWp1ZmRa?=
 =?utf-8?B?b2tseXVPRkY1eWw3L0llK3ViNyswbkJwMGt5ZzlkZU9rNG1VV0NjVlBlVC9X?=
 =?utf-8?B?Z1NQNlUvTm5kai9sWENQaStrTUVYL0J3dko1WURPbmFOU3V3NEc5ZWJDSGJX?=
 =?utf-8?B?TjZlRGR5a01QajVtMmtnUjNCVDB6bXJlMEpoY1NocnZqQ1lRV1I0ekY1QzBX?=
 =?utf-8?B?RkQ2M0poNVlrcVVNVGVHWUJ4cjMwbFZ2WTJ3dzVZU1BIZDZkcmpPa1R6eFQ3?=
 =?utf-8?B?dzd0T3lOaFJPM2JuNnZ1U3B0bXFZcEpDN2Y5RVdLeG1idHNSY2FHbkhJZ0VW?=
 =?utf-8?B?cnRGZzJSc1pkZ3hSWndnaVBzMyszWGhaQWdGK3VjS0tvcDFnSHRRM1B1aUNM?=
 =?utf-8?B?VCtPakowcktPWExkd1R0Snp1M2VJVlZVdnZydGoxeHZMWmJwTWY3SUJWQi94?=
 =?utf-8?B?YWVVWjhtMkFPY2l2eHhSMlg3dTBMTHQxSVNwbGN3U1hkcUtLc0hHUnliUjN6?=
 =?utf-8?B?QlZOVGJTdUdnNTdKT0xtenZTcWVPZlJPMUZMV25kVTBmcTBVUENuZHBlZjNK?=
 =?utf-8?B?VExHQmluWW9xak5QZ1lFQVZmVnF2NE96enJVd2ZaVDBHRjI3SjFpUWtsem50?=
 =?utf-8?B?U2NDVmc0ZXVvRWZXK0tGTktFamU4UEliZ1Nzb0tMYTQ1NWVxc3QvemphZTQv?=
 =?utf-8?B?QWFxZ1lBUUZ4SFlpYWRnMnMrSXRDTWl5TnZhaEdzU3pCMGlZNzcyL3pmY2d0?=
 =?utf-8?B?Q0tscDY5a00yWHFBTnJlS1kxT3ZuWWlXTXNEU0plalRjNEZ1dkZmdURRYWI2?=
 =?utf-8?B?enJ5eGhRUmR2ak5PaVJteVlWRlJEQVN0WXFGVVRwYVV5SXRvWGlNbGhEMjRs?=
 =?utf-8?B?eFQ5SW0yTEtGaUtiaWFMZlo3d21FQVMyc0VQSm1iZmJmN01PYWpxSkZrYkVw?=
 =?utf-8?B?QjkxRERUeCtQRm9HMm5RT3FMNnF4UGorQURlV0R3ZkxIY2hpblhiNW1va1h3?=
 =?utf-8?Q?plQ34lE46TOJcIJbvBIee7tb8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 775e1bbb-6d6a-4001-68b7-08de1623f7cd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 13:14:47.3347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QY0uT31tmb6bgsHlN9Qp3gujDUFJTCJq38n1qEgJXJgkOUhH40gFWJs+bgR9nmxjKcR5Pi0XdlZn+ULHy9XTeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7688
Received-SPF: permerror client-ip=52.101.85.48;
 envelope-from=avihaih@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


On 28/10/2025 11:32, Duan, Zhenzhong wrote:
> External email: Use caution opening links or attachments
>
>
> Hi
>
>> -----Original Message-----
>> From: Avihai Horon <avihaih@nvidia.com>
>> Subject: Re: [PATCH v3 7/8] vfio/migration: Add migration blocker if VM
>> memory is too large to cause unmap_bitmap failure
>>
>> Hi,
>>
>> On 24/10/2025 5:09, Zhenzhong Duan wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> With default config, kernel VFIO IOMMU type1 driver limits dirty bitmap to
>>> 256MB for unmap_bitmap ioctl so the maximum guest memory region is no
>> more
>>> than 8TB size for the ioctl to succeed.
>>>
>>> Be conservative here to limit total guest memory to max value supported
>>> by unmap_bitmap ioctl or else add a migration blocker. IOMMUFD backend
>>> doesn't have such limit, one can use IOMMUFD backed device if there is a
>>> need to migration such large VM.
>>>
>>> Suggested-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    hw/vfio/iommufd.c   |  5 +++++
>>>    hw/vfio/migration.c | 33 +++++++++++++++++++++++++++++++++
>>>    2 files changed, 38 insertions(+)
>>>
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> index ba5c6b6586..8de765c769 100644
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -633,6 +633,11 @@ skip_ioas_alloc:
>>>        QLIST_INIT(&container->hwpt_list);
>>>
>>>        bcontainer = VFIO_IOMMU(container);
>>> +
>>> +    /* There is no limitation on dirty bitmap size in IOMMUFD */
>>> +    bcontainer->max_dirty_bitmap_size = UINT64_MAX;
>>> +    bcontainer->dirty_pgsizes = qemu_real_host_page_size();
>>> +
>>>        vfio_address_space_insert(space, bcontainer);
>>>
>>>        if (!iommufd_cdev_attach_container(vbasedev, container, errp)) {
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index 4c06e3db93..44bab024b7 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -16,6 +16,7 @@
>>>    #include <sys/ioctl.h>
>>>
>>>    #include "system/runstate.h"
>>> +#include "hw/boards.h"
>>>    #include "hw/vfio/vfio-device.h"
>>>    #include "hw/vfio/vfio-migration.h"
>>>    #include "migration/misc.h"
>>> @@ -1152,6 +1153,31 @@ static bool vfio_viommu_preset(VFIODevice
>> *vbasedev)
>>>        return vbasedev->bcontainer->space->as !=
>> &address_space_memory;
>>>    }
>>>
>>> +static bool vfio_dirty_tracking_exceed_limit(VFIODevice *vbasedev)
>>> +{
>>> +    VFIOContainer *bcontainer = vbasedev->bcontainer;
>>> +    uint64_t max_size, page_size;
>>> +
>> IIUC, this check is not relevant when using VFIO device dirty tracking,
>> so maybe bail early if VFIO device dirty tracking is used?
>> E.g.:
>>
>> if (vbasedev->dirty_pages_supported
>> && vbasedev->device_dirty_page_tracking != ON_OFF_AUTO_OFF) {
>>      return false;
>> }
>>
>> And replace this with vfio_device_dirty_pages_disabled() in patch #8?
> OK, will do.
> Previously, I thought 8TB is a size of super large that device dirty tracking will never support due to hardware limit.

Yes, it could be, but what confused me is that we check 
bcontainer->dirty_pages_supported also when using device DPT, although 
it's not relevant for it AFAIU.
So even with memory size < 8TB, if device DPT is used and 
bcontainer->dirty_pages_supported == false, migration would be blocked.

Thanks.


