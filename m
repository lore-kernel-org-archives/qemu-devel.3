Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975BB606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=VZjjtuKv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMtzC-0003B5-1A; Fri, 30 Oct 2026 17:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xMtz9-0003Ab-Uh; Fri, 30 Oct 2026 17:18:04 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tdave@nvidia.com>)
 id 1xMtz7-0008A1-I0; Fri, 30 Oct 2026 17:18:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PrAPItUHY5nN6KY4iNSZHnUTQF6f2tEdRDv2NG9sOEcvJz/M3AGogOUTydMxjZI9Cch+ugSMpahC5ig7Cw6WkHFioTmczxMNMSQ7zBzo2YzGd8y2y0diKnYumPeS4Js6TADLUyBN0+B83OH5Sxay4A/z6s+CaG19xdXcGn5/lIkf7SDcp3IiMQSIl3kyvOESvyB4zFZax3h0wL/TYxzZ3KS9UtRzLWp51+1+JNrw33xFL9H5ZKEtH5dXfRI8ZZbDByRZJxPVHkIIpf8hImNuewh7vBOQS89BSDUqyozrn5EwoajGBJvONzg0+ypEZRj7H+taLtn8lkubdr968/aVeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlOa6uYVJ3bqLw6UN+QdNsBfoZa1ncnnlKhg/T9cEbY=;
 b=vMf4xtFjpPdzsVeq/dWtrMPQA270HIVKfiwSw9QITH2e9F4F52/8Zyvg4Tuppx/omIgyFCCe9sJWAw45W1Tm3zEKTL18Y8AS4akQtJvi1TStb9sLmdc6mzBlvRvPjvDSJ+Yw5v7KzKM9gEaB5OtISYv1kpXRhE8FZASf1LOE3G2lg8lEfd7sDFcOmTT1dvjzgBCiOGWbKFtk0EQcxFbPxZfywCIN+QiCZwyzpcMacWPJzz8BgKo7iiWwhNscpBavcHt0KAfJBx9MKg8OUSPIisA9JRjbutYFge0G8jy+HUuESHgPxhpOS/1d+D+OFyMviAtzllMrQtYr82qINcqWQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlOa6uYVJ3bqLw6UN+QdNsBfoZa1ncnnlKhg/T9cEbY=;
 b=VZjjtuKvgyoJHJXu/n+Iu5q2JJYKa27lOWt6YZJkDV9PhPkDMuumlOJDUIH3OglFdD3e8uhABVFDXIgehAIENzHGk1+aJ+rG5E8iyqqEZCejtuji2kVnRV7JDvolhsxwNQ5yNyKxZ466luqj+OVPbiCZaVHaEgTRFHqPViyrger2g7nUNNGOABF8NLNkXQVJ85HN589SzS0H9DpYFg0TEzuGKl+GT1WltyKuN3O59hFYNYJ9/aTuJCkfPEwjMVxclnOHI/EHZA1WSf3p+qEVmm+ZkrkklbOA6B5hQdJkXQ2H/grnc0tQRj3G4Jl7x4vjApAwxQ0WPSC+9s0l1OwWTw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17) by DS7PR12MB8347.namprd12.prod.outlook.com
 (2603:10b6:8:e5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 21:17:55 +0000
Received: from IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1]) by IA3PR12MB923065.namprd12.prod.outlook.com
 ([fe80::1c83:bf47:4202:50b1%5]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 21:17:55 +0000
Message-ID: <359d67a3-e319-439a-95d9-a3f7e2879bd7@nvidia.com>
Date: Fri, 30 Oct 2026 16:17:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] pci: add fixed BAR fw_cfg blob export
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>, "marcel@redhat.com" <marcel@redhat.com>,
 "devel@edk2.groups.io" <devel@edk2.groups.io>,
 Alex Williamson <alwilliamson@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20260916185554.917526-1-tdave@nvidia.com>
 <20260916185554.917526-4-tdave@nvidia.com>
 <SJ0PR12MB8614AAEC9254E91FC71BC96DAB602@SJ0PR12MB8614.namprd12.prod.outlook.com>
From: Tushar Dave <tdave@nvidia.com>
Content-Language: en-US
In-Reply-To: <SJ0PR12MB8614AAEC9254E91FC71BC96DAB602@SJ0PR12MB8614.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8P220CA0041.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:2d9::20) To IA3PR12MB923065.namprd12.prod.outlook.com
 (2603:10b6:208:627::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR12MB923065:EE_|DS7PR12MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: 36518550-f433-4e60-11ca-08df36cb43ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|261026140227099003|261026121527099003|260925022911599003|260925021911599003|260925021311599003|11063799006|5023799004|4143699003|56012099006|261026130827099003|261026135527099003|261021135927099003|261022113327099003|261009223027099003|261022105027099003|10067099003|261021133027099003|261028144727099003|261021130227099003|261022115727099003|261021123027099003|261021121427099003|261022075727099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: DpsKw/yJZjVVggQc3CwQxwEcZh9omy8z1DUCen1fLbUTXiZdF67A6yHuv7FdJfewU7qX6BWq0ONd4lC/MscXIf2NT/+RK6C+6cNW0C/Gd8dfseOkyHEXr1p1lheI3QzEbsEgoBXz4pbb6OozBnYw90dONSHBN31D0iOGJJ0Wjs9TDsOJpnIciqia3+FJUBBrQSRuFqTNCNFQfY7lklBSrot6tbe/vM7TYUDXQLV0F48M1BCbHxnukdTXBeECKHCva4wlsDxErzsw9SEbY88qHMZZiHKiX4kReoxC02iDcDEYpTFlL30I6zgAso6ypPx33bfoCQusEOk/9YGbVvViSU/TLIQwazBef0eGkUtD5tfciL1r7iCyoKs61MNrfmcej29SJhF4/H9a0mmmtNkwmXw3HlyfmIUyG/pj5ZBsW0Hpwa3w7aScZg4DGp6++ddWGgFznztKuSwjxhQ5X+2y9CrCX1evk1bWtL7iJxqyyFxm/YCLCxbb23r8/w+6gKwEuXZkB/QNxZdZkK6Wn5lvfHoorw3EusMZril5OY62Z4QkPGGpAHUcNTg9YY2sbAtbr8Q6vm6qV7nTyIZJmFUBGv+2yqBsLNQpBkYJE8IHTyVvFSeUcRhygq7PyyhHTRw1p+YCH332XCN8LQaYvVih+vGPihWDp+7G5EsQeNB7iEQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR12MB923065.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261026140227099003)(261026121527099003)(260925022911599003)(260925021911599003)(260925021311599003)(11063799006)(5023799004)(4143699003)(56012099006)(261026130827099003)(261026135527099003)(261021135927099003)(261022113327099003)(261009223027099003)(261022105027099003)(10067099003)(261021133027099003)(261028144727099003)(261021130227099003)(261022115727099003)(261021123027099003)(261021121427099003)(261022075727099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3Q0UnFwekFWbjlNUXk3RnAzQ09ra1BQQ0lqcFpMWDVjNWwyTHB4TW5uMTRM?=
 =?utf-8?B?cW42RGt2R2tkeXNWemI0ZkhPcUM2WEphWDBlQkducnFmQkxjbUc2T01mQXdr?=
 =?utf-8?B?RlRCZUk4WndtVk1RelQ0aGo3WE9EaDMyY3JMZFU0VjhRQy9xSVFFbHZ0ejkx?=
 =?utf-8?B?Vkh5aENwTGo0clE3czFYeTFkaTZFZm4wOFp0NTc2V2c2MjM0RFlhYy8xNUZm?=
 =?utf-8?B?c21KamF5KzBjbTMydzBPYkxaQ29rWU5rZ2xKMWxMM0ZHM0hkamhha1o5VldC?=
 =?utf-8?B?azFTU0RkMm1LZjZDWHR1QzErRmZKZjc5YUJDOHE0YTZ1c0tLU0M2Ky9EWWtp?=
 =?utf-8?B?cW5NZU5iVHR4dEtXcnRWU3c4cmg3cDgwTUx6d2ZVZ1VnNnVGRFhZNS9KMkxh?=
 =?utf-8?B?cnlET1ZNTC9HUnVjOVVMakpGZ09nNGNxTVBEaXNTWjZ1U3VRRWlab1QzT2g1?=
 =?utf-8?B?anRWR2xvMmg5a0VoanJQbThnUzd5cm1jdDdFSG90ajR5WUVuQ0lIWFFwbWNL?=
 =?utf-8?B?VVpsbzN2bWN6Wm1MRWZTYXNDNmJFWnNhemgxZmxoaHBOS0x6MTBZY3I0cmh5?=
 =?utf-8?B?Nk5DVzdwNGZlK3lES3N1VUE4UlFnRlJCUlJranY0SSsvWFZCUzQ4NGJJakND?=
 =?utf-8?B?TkcyeUxydmwvZEY4T1praUZVUGNTV1lCZEh0aC9UNWNXeHJFZHI4Y2l5YVZB?=
 =?utf-8?B?VnBwRk83bjhXM2k0V0lUUHpBQWtzQ3czTzFkc2ZsZkhCeklBSWtuTnl5RUtD?=
 =?utf-8?B?Q3JIUVFhYVdOTWlaMDk2V0dJR1ZUam96d2pMT05WQ1M5MExyV0dxZFkrZ21j?=
 =?utf-8?B?dzJLdWNPYVlnOTcrbzBudk5LVExHVXI5Z3d4dVBTNW1jakpUN2YvMHZQMFJa?=
 =?utf-8?B?c2Jsak5yd2FMVDQxM3VmWGJvQjRxUVY1dnZMNnBzVy9Pak5Yc0hWUFNGVFlq?=
 =?utf-8?B?cjJzYWNnWTNsemZCWFBsQ3IyaFp6UDJPd2t5djdvL21SK0dHTUxON2xZRmxy?=
 =?utf-8?B?Z0sxcDZoZmoyNTMwRGNPQTdPcmVFVmFFbHVmeHVpcmlUMFhjWnM1eDJibWZy?=
 =?utf-8?B?d1R4U0NIVkhLdEsrMUJVdzNPQWxyU241Mk16RFBtaWh1ZUJ1azFDREpzSENv?=
 =?utf-8?B?Smw0MkJ4a3ZNTmRsaThVcHNXSzkyR1lzdG5uR0xtOWhobUhoVmV1VjdDdnRa?=
 =?utf-8?B?ZVY3NGVPTi9mWVZMU2ppZ3g1bmEyVXIrSm4wNHcvY2RKQ0V6WEp0Qmx1TjUw?=
 =?utf-8?B?T2FlaXYrSW1abXZmS2lXSDRuM2N1a2lqWVpTUWsxeVFLQUxZYjA1QnZ4Qkly?=
 =?utf-8?B?OVYxV1I0dHd3dmZNS2pGNzZ5cEtlTFJOMkJ3SGJTL01XVjloN1g4WWs2VGxK?=
 =?utf-8?B?UVNYbkxyL3hka1VBVkN2OCt2c2U2a3NxU3h4MW94MGRWQlpMbjBTVzRMSGsz?=
 =?utf-8?B?WU8xRGs1T1Z1RW9KRlh0b0ZQY3ZxQ1U0VkJqNkNURlpROUpNV3NpL3hBTHhL?=
 =?utf-8?B?UUliVTU0NVF0ZUJFbzQ1WklFRFNvUGpPNm9vR0o3aldGb3E4cFh3dVNTendF?=
 =?utf-8?B?NlBJOHkyVjF4aElNdThadjJnMThCNVZZSytEM3k3NFpNKzdJb1hTYUhiYVB5?=
 =?utf-8?B?OGIyamhKVEU4M2dFaVJxUjZDZGgrODNRM3hWcGc4S05SZzFPRmthV0pUckdq?=
 =?utf-8?B?YUd4MEFpdWFMcUpLQlplNE5lMi9DdGpQclpxTVdFMmRvaTdGNjlLUWt2VVhE?=
 =?utf-8?B?ZEc1RmRNeEZ0SkladHBpNFZnL29qNmN4WEI3YURrS2UzZlNhNFVtRGpobzhG?=
 =?utf-8?B?QnMyempKaDJqY3Z5dHRmZHFqWGVKOHVyU29mTTI2aDYwTjJFbXVuRkRWRWhz?=
 =?utf-8?B?ZGU5OW9qSkNzOS9nRGlPeFdKQ0FVTkkzbFBkNFdjMzl6S2xITFgyNW5pVER6?=
 =?utf-8?B?RFJoVkVtQWRUSUo0NXV2QnFZd1ZvTWRBZFJ6K2x3aUZ3ZUVtVUpFS3ZrUW9m?=
 =?utf-8?B?Q2Z0U3A2Rmp5NEpTcUc5N3dTdFB2S0VIUXFZQUVLU3d1a056M2dqM2dsYWFm?=
 =?utf-8?B?Zllsb0ZFREFiOEdqbjllRmVxcjdmUDVHUlVjOGpkNmliN3ZxRGlRNXFpSzlJ?=
 =?utf-8?B?RUFlRnRnOWpiZm1FblF3TjkzSzByWDFvdlh4b3VQaXRmRjBaNklUd29QcklU?=
 =?utf-8?B?RjNNRnd4N1MwaXV4eVdBcnNYVjB4ZDBRUDM5eWdETFJRN2dqOFpqcWZOZE1r?=
 =?utf-8?B?YVhCYW0wUStOUmk5TjdaVThpcXA0QWJsL3VwMXkwL1VFOWFwcm44OGh4RTNY?=
 =?utf-8?B?Wnc4WWQzMlEyU2VONzBwZUV4ZEEzWWcwY3U1c04wZEhSVU44eU1Hdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36518550-f433-4e60-11ca-08df36cb43ce
X-MS-Exchange-CrossTenant-AuthSource: IA3PR12MB923065.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 21:17:55.4554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HO90sDzelliqDC8J0IFmdekizPcY6f+mZTl+uo3z9zVA5+P1IujrduzgbObBWqHoDJD2YDxrVYSOEcitQBDqaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8347
Received-SPF: pass client-ip=2a01:111:f403:c110::3;
 envelope-from=tdave@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/27/2026 11:04 AM, Shameer Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Tushar Dave <tdave@nvidia.com>
>> Sent: 16 September 2026 19:56
>> To: qemu-devel@nongnu.org
>> Cc: qemu-arm@nongnu.org; peter.maydell@linaro.org; mst@redhat.com;
>> marcel@redhat.com; devel@edk2.groups.io; Alex Williamson
>> <alwilliamson@nvidia.com>; Jason Gunthorpe <jgg@nvidia.com>; Shameer
>> Kolothum Thodi <skolothumtho@nvidia.com>
>> Subject: [PATCH 3/5] pci: add fixed BAR fw_cfg blob export
>>
>> Introduce a fixed BAR fw_cfg blob exporter that serializes PCI
>> device and BAR information into the "etc/fixed-bars" fw_cfg file.
>>
>> The blob contains an entry for every PCI function with memory BARs.
>> Each entry carries the device's vendor and device ID, whether it
>> has a fixed BAR configuration, and its firmware device path. Fixed
>> BAR entries also include the configured BAR address, size, and type
>> information for each BAR.
>>
>> Signed-off-by: Tushar Dave <tdave@nvidia.com>
>> ---
>>  hw/pci/meson.build          |   1 +
>>  hw/pci/pci-fixed-bar-blob.c | 305
>> ++++++++++++++++++++++++++++++++++++
>>  hw/pci/pci-fixed-bar.h      |  63 ++++++++
>>  3 files changed, 369 insertions(+)
>>  create mode 100644 hw/pci/pci-fixed-bar-blob.c
>>  create mode 100644 hw/pci/pci-fixed-bar.h
>>
>> diff --git a/hw/pci/meson.build b/hw/pci/meson.build
>> index 150085c997..b81cc056c0 100644
>> --- a/hw/pci/meson.build
>> +++ b/hw/pci/meson.build
>> @@ -20,6 +20,7 @@ pci_ss.add(files('pcie.c', 'pcie_aer.c'))
>>  pci_ss.add(files('pcie_doe.c'))
>>  system_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pcie_port.c',
>> 'pcie_host.c'))
>>  system_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pci-fixed-bar-
>> validate.c'))
>> +system_ss.add(when: 'CONFIG_PCI_EXPRESS', if_true: files('pci-fixed-bar-
>> blob.c'))
>>  system_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
>>
>>  stub_ss.add(files('pci-stub.c'))
>> diff --git a/hw/pci/pci-fixed-bar-blob.c b/hw/pci/pci-fixed-bar-blob.c
>> new file mode 100644
>> index 0000000000..b9fdc6b7d4
>> --- /dev/null
>> +++ b/hw/pci/pci-fixed-bar-blob.c
>> @@ -0,0 +1,305 @@
>> +/*
>> + * Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights
>> reserved
>> + * Write validated fixed-BAR device info to the etc/fixed-bars fw_cfg blob.
>> + *
>> + * Written by Tushar Dave
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/nvram/fw_cfg.h"
>> +#include "hw/pci/pci.h"
>> +#include "hw/pci/pci_bridge.h"
>> +#include "hw/pci/pci_host.h"
>> +#include "hw/pci/pcie_port.h"
>> +#include "hw/core/qdev.h"
>> +#include "qemu/error-report.h"
>> +#include "pci-internal.h"
>> +#include "pci-fixed-bar.h"
>> +#include "pci-fixed-bar-validate.h"
>> +
>> +typedef struct {
>> +    uint8_t  bar;
>> +    uint32_t flags;
>> +    uint64_t addr;
>> +    uint64_t size;
>> +} BarInfo;
>> +
>> +/* One PCI function entry to be written to the blob. */
>> +typedef struct {
>> +    uint8_t  rp_bus;     /* primary bus of the root port this device is under */
>> +    uint16_t vendor_id;
>> +    uint16_t device_id;
>> +    bool     is_fixed;
>> +    char     fw_path[QEMU_FIXED_BARS_MAX_PATH];
>> +    GArray  *bars;  /* array of BarInfo */
>> +} DeviceInfo;
>> +
>> +typedef struct {
>> +    GArray *devices;
>> +    PCIBus *root_bus;
>> +} CollectCtx;
>> +
>> +static void collect_device(PCIBus *bus, PCIDevice *pdev, void *opaque);
>> +
>> +/* Visit every device on this bus, in devfn order. */
>> +static void collect_bus(PCIBus *bus, void *opaque)
>> +{
>> +    pci_for_each_device_under_bus(bus, collect_device, opaque);
>> +}
>> +
>> +/*
>> + * Primary bus number of the nearest TYPE_PCIE_ROOT_PORT ancestor of
>> bus
>> + * — i.e. the bus the root port device itself lives on, not its
>> + * secondary bus. Falls back to the host bridge's own bus number if bus
>> + * isn't under any root port (e.g. a device directly on the host
>> + * bridge's primary bus).
>> + */
>> +static uint8_t find_root_port_bus(PCIBus *bus, PCIBus *host_bus)
>> +{
>> +    PCIDevice *parent;
>> +
>> +    while (bus) {
>> +        parent = bus->parent_dev;
>> +        if (!parent) {
>> +            break;
>> +        }
>> +        if (object_dynamic_cast(OBJECT(parent), TYPE_PCIE_ROOT_PORT)) {
>> +            return pci_bus_num(pci_get_bus(parent));
>> +        }
>> +        bus = pci_get_bus(parent);
>> +    }
>> +    return pci_bus_num(host_bus);
>> +}
>> +
>> +static void collect_device(PCIBus *bus, PCIDevice *pdev, void *opaque)
>> +{
>> +    CollectCtx *ctx = opaque;
>> +    bool has_mem_bar = false;
>> +    bool is_64bit, is_pref;
>> +    DeviceInfo dev;
>> +    PCIIORegion *r;
>> +    PCIBus *sec;
>> +    BarInfo bi;
>> +    int i;
>> +
>> +    for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
>> +        r = &pdev->io_regions[i];
>> +        if (r->size && !(r->type & PCI_BASE_ADDRESS_SPACE_IO)) {
>> +            has_mem_bar = true;
>> +            break;
>> +        }
>> +    }
>> +
>> +    /*
>> +     * Every device with a memory BAR gets an entry, fixed or not — not
>> +     * just ones with fixed-bar-N= set. This preserves the exact device
>> +     * sequence CheckDevice() needs for positional VID:DID matching (see
>> +     * collect_all_host_bridges()); only fixed devices carry BAR records
>> +     * (dev.bars stays empty, dev.is_fixed false, otherwise).
>> +     */
>> +    if (has_mem_bar) {
>> +        g_autofree char *fw_path = qdev_get_fw_dev_path(DEVICE(pdev));
>> +
>> +        memset(&dev, 0, sizeof(dev));
>> +        dev.rp_bus    = find_root_port_bus(bus, ctx->root_bus);
>> +        dev.vendor_id = pci_get_word(pdev->config + PCI_VENDOR_ID);
>> +        dev.device_id = pci_get_word(pdev->config + PCI_DEVICE_ID);
>> +        dev.is_fixed  = false;
>> +        for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
>> +            if (pdev->fixed_bar_addr[i] != PCI_BAR_UNMAPPED) {
>> +                dev.is_fixed = true;
>> +                break;
>> +            }
>> +        }
>> +        if (fw_path) {
>> +            g_strlcpy(dev.fw_path, fw_path, sizeof(dev.fw_path));
>> +        }
>> +        dev.bars = g_array_new(false, true, sizeof(BarInfo));
>> +
>> +        if (dev.is_fixed) {
>> +            for (i = 0; i < PCI_NUM_REGIONS - 1; i++) {
>> +                r = &pdev->io_regions[i];
>> +                if (!r->size || (r->type & PCI_BASE_ADDRESS_SPACE_IO)) {
>> +                    continue;
>> +                }
>> +                is_64bit = !!(r->type & PCI_BASE_ADDRESS_MEM_TYPE_64);
>> +                is_pref  = !!(r->type & PCI_BASE_ADDRESS_MEM_PREFETCH);
>> +
>> +                memset(&bi, 0, sizeof(bi));
>> +                bi.bar   = i;
>> +                bi.addr  = (uint64_t)pdev->fixed_bar_addr[i];
>> +                bi.size  = r->size;
>> +                bi.flags = (is_64bit ? QEMU_FIXED_BAR_F_MEM64 : 0) |
>> +                           (is_pref  ? QEMU_FIXED_BAR_F_PREF  : 0);
>> +                g_array_append_val(dev.bars, bi);
>> +            }
>> +        }
>> +        g_array_append_val(ctx->devices, dev);
>> +    }
>> +
>> +    if (!object_dynamic_cast(OBJECT(pdev), TYPE_PCI_BRIDGE)) {
>> +        return;
>> +    }
>> +    sec = pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
>> +    if (sec) {
>> +        collect_bus(sec, opaque);
>> +    }
>> +}
>> +
>> +static gint cmp_host_bus_num(gconstpointer a, gconstpointer b)
>> +{
>> +    PCIHostState *ha = *(PCIHostState **)a;
>> +    PCIHostState *hb = *(PCIHostState **)b;
>> +    return (gint)pci_bus_num(ha->bus) - (gint)pci_bus_num(hb->bus);
>> +}
>> +
>> +/*
>> + * EFI_INCOMPATIBLE_PCI_DEVICE_SUPPORT_PROTOCOL's CheckDevice
>> interface
>> + * (UEFI PI Spec 1.2 Vol 5) only passes VendorId/DeviceId/RevisionId/
>> + * SubsystemVendorId/SubsystemDeviceId, no BDF — so in EDK2 we can't
>> + * match a blob entry to a specific device directly using BDF. To work
>> + * around that, we prepare the blob entries in the same order PciBusDxe
>> + * discovers devices, so matching by VID:DID inherently works.
>> + */
> 
> The blob now also includes firmware device paths for future matching, right?
> Should we mention that as well?

Sure I'll add a note.

>  
>> +static void collect_all_host_bridges(CollectCtx *ctx)
>> +{
>> +    PCIHostState *hb;
>> +    GPtrArray *sorted;
>> +    guint i;
>> +
>> +    sorted = g_ptr_array_new();
>> +    QLIST_FOREACH(hb, &pci_host_bridges, next) {
>> +        if (hb->bus) {
>> +            g_ptr_array_add(sorted, hb);
>> +        }
>> +    }
>> +    g_ptr_array_sort(sorted, cmp_host_bus_num);
>> +
>> +    for (i = 0; i < sorted->len; i++) {
>> +        hb = g_ptr_array_index(sorted, i);
>> +        ctx->root_bus = hb->bus;
>> +        collect_bus(hb->bus, ctx);
>> +    }
>> +
>> +    g_ptr_array_free(sorted, true);
>> +}
>> +
>> +static uint8_t *create_blob(CollectCtx *ctx, size_t *blob_size)
>> +{
>> +    QemuFixedBarsDevice *dout;
>> +    QemuFixedBarsBar *bout;
>> +    QemuFixedBarsHdr *hdr;
>> +    DeviceInfo *dev;
>> +    uint8_t *blob;
>> +    uint8_t *ptr;
>> +    BarInfo *bi;
>> +    size_t sz;
>> +    guint d, b;
>> +
>> +    sz = sizeof(QemuFixedBarsHdr);
>> +    for (d = 0; d < ctx->devices->len; d++) {
>> +        dev = &g_array_index(ctx->devices, DeviceInfo, d);
>> +        sz += sizeof(QemuFixedBarsDevice);
>> +        sz += dev->bars->len * sizeof(QemuFixedBarsBar);
>> +    }
>> +
>> +    blob = g_malloc0(sz);
>> +    hdr  = (QemuFixedBarsHdr *)blob;
>> +    hdr->version     = cpu_to_le32(QEMU_FIXED_BARS_VERSION);
>> +    hdr->num_devices = cpu_to_le32(ctx->devices->len);
>> +
>> +    ptr = blob + sizeof(*hdr);
>> +    for (d = 0; d < ctx->devices->len; d++) {
>> +        dev  = &g_array_index(ctx->devices, DeviceInfo, d);
>> +        dout = (QemuFixedBarsDevice *)ptr;
>> +
>> +        dout->vendor_id = cpu_to_le16(dev->vendor_id);
>> +        dout->device_id = cpu_to_le16(dev->device_id);
>> +        dout->dev_flags = dev->is_fixed ? QEMU_FIXED_BARS_DEV_F_FIXED : 0;
>> +        dout->rp_bus    = dev->rp_bus;
>> +        dout->num_bars  = dev->bars->len;
>> +        dout->reserved  = 0;
>> +        memcpy(dout->fw_path, dev->fw_path, sizeof(dout->fw_path));
>> +        ptr += sizeof(QemuFixedBarsDevice);
>> +
>> +        for (b = 0; b < dev->bars->len; b++) {
>> +            bi   = &g_array_index(dev->bars, BarInfo, b);
>> +            bout = (QemuFixedBarsBar *)ptr;
>> +
>> +            bout->bar     = bi->bar;
>> +            bout->flags   = cpu_to_le32(bi->flags);
>> +            bout->address = cpu_to_le64(bi->addr);
>> +            bout->size    = cpu_to_le64(bi->size);
>> +            ptr += sizeof(QemuFixedBarsBar);
>> +        }
>> +    }
>> +
>> +    *blob_size = sz;
>> +    return blob;
>> +}
>> +
>> +/*
>> + * fixed_bars_write_blob - validate fixed BAR addresses and write fw_cfg
>> blob.
>> + *
>> + * @fw_cfg:       fw_cfg state to write the etc/fixed-bars blob into.
>> + * @mmio32_base:  base of the machine's 32-bit PCIe MMIO aperture.
>> + * @mmio32_size:  size of the machine's 32-bit PCIe MMIO aperture.
>> + * @mmio64_base:  base of the machine's 64-bit PCIe MMIO aperture.
>> + * @mmio64_size:  size of the machine's 64-bit PCIe MMIO aperture.
>> + *
>> + * Returns true if any fixed BAR device was found and the blob was
>> + * written, false if there was nothing to do. Aborts if any BAR
>> + * address fails validation.
>> + */
>> +bool fixed_bars_write_blob(FWCfgState *fw_cfg,
>> +                           uint64_t mmio32_base,
>> +                           uint64_t mmio32_size,
>> +                           uint64_t mmio64_base,
>> +                           uint64_t mmio64_size)
>> +{
>> +    FixedBarsInfo info;
>> +    CollectCtx ctx;
>> +    uint8_t *blob;
>> +    size_t blob_size;
>> +    guint d;
>> +
>> +    if (!mmio32_size || !mmio64_size) {
>> +        error_report("fixed-bar: zero-size PCIe MMIO aperture "
>> +                     "(32-bit=0x%"PRIx64", 64-bit=0x%"PRIx64")",
>> +                     mmio32_size, mmio64_size);
>> +        exit(1);
>> +    }
>> +    if (mmio32_size - 1 > UINT64_MAX - mmio32_base ||
>> +        mmio64_size - 1 > UINT64_MAX - mmio64_base) {
>> +        error_report("fixed-bar: PCIe MMIO aperture base+size overflows "
>> +                     "(32-bit base=0x%"PRIx64" size=0x%"PRIx64", "
>> +                     "64-bit base=0x%"PRIx64" size=0x%"PRIx64")",
>> +                     mmio32_base, mmio32_size, mmio64_base, mmio64_size);
>> +        exit(1);
>> +    }
>> +
>> +    info.mmio32_base = mmio32_base;
>> +    info.mmio32_limit = mmio32_base + mmio32_size - 1;
>> +    info.mmio64_base = mmio64_base;
>> +    info.mmio64_limit = mmio64_base + mmio64_size - 1;
>> +
>> +    if (!fixed_bars_validate(&info)) {
>> +        return false;
>> +    }
>> +
>> +    ctx.devices  = g_array_new(false, true, sizeof(DeviceInfo));
>> +    ctx.root_bus = NULL;
>> +    collect_all_host_bridges(&ctx);
>> +
>> +    blob = create_blob(&ctx, &blob_size);
>> +    fw_cfg_add_file(fw_cfg, FW_CFG_FIXED_BARS, blob, blob_size);
>> +
>> +    for (d = 0; d < ctx.devices->len; d++) {
>> +        g_array_free(g_array_index(ctx.devices, DeviceInfo, d).bars, true);
>> +    }
>> +    g_array_free(ctx.devices, true);
>> +
>> +    return true;
>> +}
>> diff --git a/hw/pci/pci-fixed-bar.h b/hw/pci/pci-fixed-bar.h
>> new file mode 100644
>> index 0000000000..0d4e31b301
>> --- /dev/null
>> +++ b/hw/pci/pci-fixed-bar.h
>> @@ -0,0 +1,63 @@
>> +/*
>> + * Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights
>> reserved
>> + * Fixed-BAR — QEMU side declarations.
>> + *
>> + * Written by Tushar Dave
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +#ifndef HW_PCI_FIXED_BAR_H
>> +#define HW_PCI_FIXED_BAR_H
>> +
>> +#include "hw/nvram/fw_cfg.h"
>> +#include "hw/pci/pci_bus.h"
>> +
>> +#define FW_CFG_FIXED_BARS        "etc/fixed-bars"
>> +#define QEMU_FIXED_BARS_VERSION  1
>> +#define QEMU_FIXED_BARS_MAX_PATH 128
>> +
>> +/*
>> + * On-wire layout (little-endian, packed):
>> + *
>> + *   QemuFixedBarsHdr
>> + *
>> + *   For each device (num_devices total):
>> + *     QemuFixedBarsDevice               -- device header
>> + *     QemuFixedBarsBar[num_bars]        -- one record per BAR (FIXED only)
>> + */
> 
> Could we document this new etc/fixed-bars format under docs/specs/ ?

Yes, I will add it into docs/specs/pci-fixed-bars.rst

-Tushar
> 
> Thanks,
> Shameer


