Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D401C19F32
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Mar 2025 14:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tokGV-0008Fx-6H; Sun, 02 Mar 2025 09:25:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tokGT-0008FN-9p
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 09:25:57 -0500
Received: from mail-bn8nam11on2061c.outbound.protection.outlook.com
 ([2a01:111:f403:2414::61c]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tokGQ-00028F-Qd
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 09:25:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/aaee4sEM2/g/0eLvXPJic3kvQL54wb8JLkTOAemvD5KpCjPOn9JzAjx4Weu/uuHGQmsDjVDzGnQdsvSV7RVVMYx/svuI27q+MBf2dD0cZqqyh90qcpkFSnp+ngiH3swAgYwyxIrteDm58zyW5YirJcdgq8souByIDEZrfR4edfGX46EEXlQprV9Fmwb+j5KijYEuFSsPI+gCdLR9tT5DYP1mK+NF/0x8h9kBATHQP0NFsW3ZMZoHMVLMjCZT7KY0qCtXxOJfmpCjBINhW7GnQBqSwaZRJ0CO/MxtK2sOMXfWJeqL5v6GzlUWcIpuQrP64xbiI/H+2QpctbuXVEOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+TW6WWpQngCduzMG3Okmmo78VRnhF5KJcOtDQw7w+E=;
 b=M0A6Fppd/C5UXRZIKa7bMUGDtlk+sUfddNz5ySzZ7OnCHDlNBuYdmQyvguSEGxDXvVlgDrprblRwnr5gs2Va2iJqokEeDavEZLT592GR5b3uS+CDhjGy4FPOvkIUPPmP+3J3CJPoGbeg5iWbAOYwsCaT23tJMMptpzwy/GoNHdWSrGvgSx84Zb62vsJ8mtnT5khpxHZib0EKNuuwKtEAWP74+V/pC1mychTx+e3NK6wrHG4v9Vemze/uN0FPw9ATqSgxTwQCjXeXOfYLlgbm33HdQ0FgHBTta5tivxoxEtA5q5GTRFMXzQKDiy9SrQKCA4VUQ4mK/ugU9GvCUk/83g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+TW6WWpQngCduzMG3Okmmo78VRnhF5KJcOtDQw7w+E=;
 b=suOdwj6t7uB18WBth/VT7BnsV+zLG3v6AQ2EmkCUizlD0jCODPZBv519Y4ytVDGSGGXadtVi293SVBv5yuL1favfb6eM4kFBF2Nwb73f08hUKD/euOxr3qzEU1XaINQWSHs9iA9SygkpacycGkL0edEq1D5ZKZ2AkVg3LYmvJ7eUJs6RGiRMcF3Fc4DDgltapUbpSMImvxTPccgrggbMse1uXguuE3FI6Af81Kc0HuWuLcjCXv8t6sd2kd/aLy58cNcktaxp01kKy58svD9lGsxjyLO9Tj8JdVNswlhCgW9BtkrkOwhKV4cj6eqD5F+hp3FWMYvzDArujwqP1Fe0uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by CH3PR12MB7740.namprd12.prod.outlook.com (2603:10b6:610:145::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Sun, 2 Mar
 2025 14:25:50 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 14:25:50 +0000
Message-ID: <b9284c9a-149a-4965-a4fa-ec092e3fb7d0@nvidia.com>
Date: Sun, 2 Mar 2025 16:25:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 28/36] vfio/migration: Multifd device state transfer
 support - config loading support
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <47be7bf2f46923e2a9d2b75b1d35c6b2915c20c8.1739994627.git.maciej.szmigiero@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <47be7bf2f46923e2a9d2b75b1d35c6b2915c20c8.1739994627.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::15) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|CH3PR12MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: f64f800b-22dd-4a71-3f0d-08dd59962187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHdsby9EMjFhNFl6U0wvWGdUWDFFc1RxWm5LamVQa3FSYXlvSmRkSzYwWWlh?=
 =?utf-8?B?L1J6VGw4ZnJhT01qcTFsbDJkTzFPQURWd281ZFF1YW82andOQkpVUk1zOFJl?=
 =?utf-8?B?b09XdzlGVUhJaVlRUjk1UG1waFl3N1BjbG9FQnluanhXeGhnRUlFUGhwcFBE?=
 =?utf-8?B?SnpNY3E2djR6S0dZejdEa0V1WmR3OE90V1AvOHRLQmF6dDFjZkJiRjRUcW5k?=
 =?utf-8?B?MWJzSkRXL3BVMldUWDYrZE1pTjJWQ20ySHNNb2JiMXR3dkRDaEdIOFlFVGJM?=
 =?utf-8?B?Q3hubjc4WmNVNGpiemVkNi9BTS8weExjdks1ZWdLRHRvNE93RGJ4RFFUWlJu?=
 =?utf-8?B?WUdqdVQ0MisrL0ZIckRKSFQ0VGFmVS9hUGpHa1VTNnpVcDhTQkF1TjRLbkV3?=
 =?utf-8?B?WWtRbE43S201UWRQbDEzWHR6RTFnMjBoQlZ6YjlFK3JjQTdlZitGMi9ObmNv?=
 =?utf-8?B?MC9tQWF3Wi9YNU1CcEhuRjV3VXAzU1dBYWozdjNXYWp4bGR1TmpCVDFsL2c5?=
 =?utf-8?B?a2dGVTBDK3pCU2prRXN2d3VDY2x6WHE4SEZqTmFNZ25ueWd0aTI2NEY1VEZF?=
 =?utf-8?B?NVVZMzZZR3VCMEtQMGVlREZ4L01XMEkvSXd3UG8vancrbHc2UXFJNG8ySnR5?=
 =?utf-8?B?NmZMWkUwRFEzTFNZVWxJekdFZmtLR2JWWnRKOVhiUlhSQUVCM29hVW5SeWhs?=
 =?utf-8?B?M0IwbVI3QUZNZStaRkNIVlRjYkVGRURkc1VTNnpTLzl6Nys4VmlqZ2Z6NUhh?=
 =?utf-8?B?Y3hsNis2WEFaa1BMYkRwWEFDYnlGdDJ0MGpQbFF0QzRmZTZJL3V3M2xUWWxJ?=
 =?utf-8?B?WFpzSS9GNlNJNE5nNHVJekxnc0F4MEtPOWJnT0pqMUMwV0RNQzJtSTJvcjlN?=
 =?utf-8?B?RVlubjg0YkdyU1JleVF4OHBkZ2hxbVdXR1ZsRTJmQTNwT09nOHlFb0VOaENa?=
 =?utf-8?B?NGZwZFU1dGlHVmF0bmxkdzlxaUxXaHhBejRiTHdiemRJdTJXcWFSYUhvbFg4?=
 =?utf-8?B?dWFYcHdDZ050ckxPNnFrQ0tzQnlaaytsbFBXRkZ6R09kUExuakVQaEJVWVdm?=
 =?utf-8?B?Z3A5Qm9neHdiUjlOYjQzZnhXTGxhMHM0bVowZjFabUVUOGFKZ0xSN0tJT3Ir?=
 =?utf-8?B?aUJOcDhOWUpmWHhLUHIxZkFpWEt0SEF0eGM0MWJwdmJkY1FVcnRzT0xJR2t1?=
 =?utf-8?B?aFJEdnNhei90WUlBbnloeURMQktONnNRZnlLVEp1czJZMFc0S0ZNWjM5RzFu?=
 =?utf-8?B?YjhaaEg4NmpRVkg4ZnRoMjlBYWdFVks0eWpiL3U0d2lnNFNoMUcvZWxhU0d3?=
 =?utf-8?B?YmorSlExVGdLM2t5bWdldGdsclZJWFRtcUMvTDVDbC9wRzVKTWJUSm1oTEd1?=
 =?utf-8?B?c0JDMERFRXdialoxWnRiaEUvdGZvZVhYWHdTWnl3NGlFZEdjdHVreXFybnJ3?=
 =?utf-8?B?czJ4eWVKRjNYdFBBeWFpRzhYRThqRURGNXl5bmwwcDk0SDlBby9sTytUM1RS?=
 =?utf-8?B?aURRMkZ3ckJsTnE3UUhpR3FQbm1RRnFhTTRHdDBYdjJiS3lJUjFmSlUzM2xx?=
 =?utf-8?B?ejJrM0l0R3EwSmIwa01Kbnd1M1M3NmVEVjd4cmlXZklwU0lyY2lLRjlDU2lB?=
 =?utf-8?B?ODdBTmV1d0tFMFZhUUNaMnpMR1hyNGo3UGtETEhiZzVmdThYaXl4Y2FvVGtw?=
 =?utf-8?B?UnNMZnU0WUJ1SDc4Q0pJZkFrZ3R0T3BZTldpVGlhSW04SXlJVmhkSWdtQjZp?=
 =?utf-8?B?dWdwZkhaK0VRVFN2dkRwK3g0SVRKaGxmT2c5a09NZlF6em05bU42a0dnY1lE?=
 =?utf-8?B?TnNhTzlSYVBTOTExbkdZMURJUVJJaVVVTkpGZE9GNVEvYWNudXdhUGxqVWU1?=
 =?utf-8?Q?SWcTTXEL/hFyv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmZnVHpkZk0vOHhITzgzcStQUUlrai9TOFRONG1RT1A2ektxZDliZTh0MkJZ?=
 =?utf-8?B?bGtpN1FXd2V6WTdwa1lJTUtzYUE2R1EwaG9NdVhwMlVXNzJWTjJldmovM0Zp?=
 =?utf-8?B?WlUwMkQxeDBGcFhJVnU2dnJNVWlTamgySmJnNlZmZCtMb3VjRXNscjkwNjly?=
 =?utf-8?B?Q005eU1CU3FnbjZMRlovR3MvM0ZrTEVUbFhCTnZWUURWeDZVN3RoNlQ4SjFh?=
 =?utf-8?B?SXZXaTR1TDFTcEd3RTg5UTFZQjlUd2pHQ0RVTC9TMDJxT1Q1Z2NSWGtVY1Bh?=
 =?utf-8?B?WFVrNFNQODJPOWsyUFdtMml0RUVNajREYy9FanYvVzV0a002UXEvOVBOWEN3?=
 =?utf-8?B?OTBKREhlQ3hPTWNUMC81d2grdmpVQUg0SmhOS0ROaXNnOFJnVWlBZi83ck9F?=
 =?utf-8?B?QWxHSnhHVmNLWXRIRWxLcFBGQjhhZi95dWw5NWlEcWlpSkZOWHM4YWxlNkZN?=
 =?utf-8?B?MHVpcUIzc3N0Z3JwWTgwdCs3YnhHcFZWaFpPeVZDVHFlWnJTWHo1SG5QaEhz?=
 =?utf-8?B?WlRHUE1Ld3g3Y1pwSVBVa01KTWR2Zk9ENUFaeGxPSGk4TlpUNFkvY0lUKytM?=
 =?utf-8?B?WTJJTVpEUVFxRStrN1R0NmlJWDYycWlvZ3RxNDVmMmhUU1ExN1FlNmkvbTFn?=
 =?utf-8?B?WG54ZEU5L1FqMkRiRFRrNVpsUHdGa2NwZXhHNlBWYk5WdUJjNFdGMDhJVzZl?=
 =?utf-8?B?OGV1aGZLNGN4ZE1VSkFxeGczbThkOGIvQzdWSUdocXBmdWg3dUJlZ0lEWjNj?=
 =?utf-8?B?WTBNeEI2SUxJeVFQbkJxMzVNdSs0bnFsQWhvR2lHVXJyWkIyY3FrV1lDcThI?=
 =?utf-8?B?NTlVd0FSb0hzdEZUWUxJWWFhT3k5WHBSdHpMTE0rWGdoeTNVdG5JbUVwNGlX?=
 =?utf-8?B?M2JiKzQ0Q1dsWnlNZlVtVDFWME9ERDhaR0F6RDM2SjhiZ2pDNTRNTnNZdDcv?=
 =?utf-8?B?QnhsTWIyZzBERE9UNVg5cW05ZTNoSHhNdnFidG1RaVh5M0xmcmM0d3VQSlV4?=
 =?utf-8?B?cUFvRkJtb2l3eG4zd1ZJeGtFMFdEbk5OUDg2R0NDZDQ5T3hoWms2SjBqSFg5?=
 =?utf-8?B?dnNIRkFJYkI3SHJ6YTJ3c1N5U0ZxQWM4MnIxV2NLYmVTM1l4Y2QxUER5VHNO?=
 =?utf-8?B?dThjTmRneFd6Y2hnYjBuUkxManRlY2llT1NoODZGckFrSUt3NUNYdmJLNWpZ?=
 =?utf-8?B?R1B0MXNCT3J3cEEwWFVMWENDK2dXZTdzckpmQVZwSXRUTVlQUEpvb3YvWE9r?=
 =?utf-8?B?M281YzNKK0pvSXkxRnpFZjV6TmJIbXQ3MUkzNVlGZzB1RTZQME1XaUhuVWlj?=
 =?utf-8?B?c0hMTFgzV2hBNTFJYWZOdysrRWRDWTBXMmZFNW52bkNVbU1ST2hpYjVxQ3FI?=
 =?utf-8?B?Z0RnRTJrc2dvNXl6ZWRGVlJLMmJHcHQ2YVdDQUlmTzZnMGZ5ODZJODFzZ0F1?=
 =?utf-8?B?ZkU0Y2Q4bExNNUxWOVJINDkrN0pNZVRWUmZWTUFqUXUvRkcwMWcreXN1R05I?=
 =?utf-8?B?NlJrWG5jYks2YjZoMHdKSkZaS2Q1MWc3NG5qSE1lZGxubXJON3hXT1RmUGla?=
 =?utf-8?B?czBUOGo4MnMyVmVLZFhsVEV1MWxXSkdnU0FyaTRDMk12RWxueGNWUmNyU2JZ?=
 =?utf-8?B?UDdjeUIzZTFYa0tUWWtyYUVKZzlDLy8rSXVwazhuT1ZDbDZVMThYK1RFK2Jx?=
 =?utf-8?B?Z2crVzl0VkN3b2VSbjdSY2cwY0tKN3NGRUd3M1RYcHg4WE1oRTErU2U2bkZI?=
 =?utf-8?B?eWtzK3k3d0tCR1VsL2MwVWNKN1ZMcFl4TGptRTJjZG1Fd3RieWVJNmE1U1dW?=
 =?utf-8?B?SmFPQjVjMG43c0xIaXVXSVFQMEtZWjZKYzR4QWVnOXRnbzJRL0UzMUtmK01z?=
 =?utf-8?B?RGEwcUtpelZYS0FBUmd5UGVKa1V3VjdaZzFNRjhpdExqSHpKTWYrSlM5eHE0?=
 =?utf-8?B?bXByb0s4UXpPZlhvTGhlSWd3ZTJuWHFnVFJKaldWYk1jcDd0Z2hXSUlDTlZL?=
 =?utf-8?B?ckhySWZxR1BGMTh4anZKRENvNW1KbTNsZ3JSbzBnZks4VTV6K0VsMmoxQUNY?=
 =?utf-8?B?VkUxWmpIc0pSbHZGYjJHMEx4enJ5SXhFZzBpK2pHcG5rZzEwT0VUby9ISXcy?=
 =?utf-8?Q?p7CRgZGJH6pQhDpIsbxi5HVOv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f64f800b-22dd-4a71-3f0d-08dd59962187
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2025 14:25:50.1252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7G8ham7Sia1gwwEUhKtl+0weJHfK5qz55wirZHiNH7u/nhpSXjDcypfUmD+pCPcVqG0gxCkMy1rbGwVsRH/TKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7740
Received-SPF: softfail client-ip=2a01:111:f403:2414::61c;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 19/02/2025 22:34, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> Load device config received via multifd using the existing machinery
> behind vfio_load_device_config_state().
>
> Also, make sure to process the relevant main migration channel flags.
>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/vfio/migration-multifd.c   | 47 ++++++++++++++++++++++++++++++++++-
>   hw/vfio/migration.c           |  8 +++++-
>   include/hw/vfio/vfio-common.h |  2 ++
>   3 files changed, 55 insertions(+), 2 deletions(-)
>
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index b3a88c062769..7200f6f1c2a2 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -15,6 +15,7 @@
>   #include "qemu/lockable.h"
>   #include "qemu/main-loop.h"
>   #include "qemu/thread.h"
> +#include "io/channel-buffer.h"
>   #include "migration/qemu-file.h"
>   #include "migration-multifd.h"
>   #include "trace.h"
> @@ -186,7 +187,51 @@ bool vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
>
>   static int vfio_load_bufs_thread_load_config(VFIODevice *vbasedev)
>   {
> -    return -EINVAL;
> +    VFIOMigration *migration = vbasedev->migration;
> +    VFIOMultifd *multifd = migration->multifd;
> +    VFIOStateBuffer *lb;
> +    g_autoptr(QIOChannelBuffer) bioc = NULL;
> +    QEMUFile *f_out = NULL, *f_in = NULL;

Can we move patch #29 before this one and use g_autoptr() for f_out an f_in?

> +    uint64_t mig_header;
> +    int ret;
> +
> +    assert(multifd->load_buf_idx == multifd->load_buf_idx_last);
> +    lb = vfio_state_buffers_at(&multifd->load_bufs, multifd->load_buf_idx);
> +    assert(lb->is_present);
> +
> +    bioc = qio_channel_buffer_new(lb->len);
> +    qio_channel_set_name(QIO_CHANNEL(bioc), "vfio-device-config-load");
> +
> +    f_out = qemu_file_new_output(QIO_CHANNEL(bioc));
> +    qemu_put_buffer(f_out, (uint8_t *)lb->data, lb->len);
> +
> +    ret = qemu_fflush(f_out);
> +    if (ret) {
> +        g_clear_pointer(&f_out, qemu_fclose);
> +        return ret;
> +    }
> +
> +    qio_channel_io_seek(QIO_CHANNEL(bioc), 0, 0, NULL);
> +    f_in = qemu_file_new_input(QIO_CHANNEL(bioc));
> +
> +    mig_header = qemu_get_be64(f_in);
> +    if (mig_header != VFIO_MIG_FLAG_DEV_CONFIG_STATE) {
> +        g_clear_pointer(&f_out, qemu_fclose);
> +        g_clear_pointer(&f_in, qemu_fclose);
> +        return -EINVAL;
> +    }
> +
> +    bql_lock();
> +    ret = vfio_load_device_config_state(f_in, vbasedev);
> +    bql_unlock();
> +
> +    g_clear_pointer(&f_out, qemu_fclose);
> +    g_clear_pointer(&f_in, qemu_fclose);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    return 0;
>   }
>
>   static VFIOStateBuffer *vfio_load_state_buffer_get(VFIOMultifd *multifd)
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 85f54cb22df2..b962309f7c27 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -264,7 +264,7 @@ static int vfio_save_device_config_state(QEMUFile *f, void *opaque,
>       return ret;
>   }
>
> -static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
> +int vfio_load_device_config_state(QEMUFile *f, void *opaque)
>   {
>       VFIODevice *vbasedev = opaque;
>       uint64_t data;
> @@ -728,6 +728,12 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
>           switch (data) {
>           case VFIO_MIG_FLAG_DEV_CONFIG_STATE:
>           {
> +            if (vfio_multifd_transfer_enabled(vbasedev)) {
> +                error_report("%s: got DEV_CONFIG_STATE but doing multifd transfer",
> +                             vbasedev->name);

To make clearer, maybe change to:
"%s: got DEV_CONFIG_STATE in main migration channel but doing multifd 
transfer"

Thanks.

> +                return -EINVAL;
> +            }
> +
>               return vfio_load_device_config_state(f, opaque);
>           }
>           case VFIO_MIG_FLAG_DEV_SETUP_STATE:
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index ab110198bd6b..ce2bdea8a2c2 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -298,6 +298,8 @@ void vfio_add_bytes_transferred(unsigned long val);
>   bool vfio_device_state_is_running(VFIODevice *vbasedev);
>   bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
>
> +int vfio_load_device_config_state(QEMUFile *f, void *opaque);
> +
>   #ifdef CONFIG_LINUX
>   int vfio_get_region_info(VFIODevice *vbasedev, int index,
>                            struct vfio_region_info **info);

