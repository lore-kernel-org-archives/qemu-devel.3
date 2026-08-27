Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F088C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzbBc-00080a-5g; Thu, 27 Aug 2026 10:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzbBb-0007zz-2O
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:34:35 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzbBZ-00020Q-Av
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:34:34 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RE7tUe2504237
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:34:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=EJGu6qbhPHslWkstyg9ovDwIPZ1158jhKI0OYJtOR
 tE=; b=qTCHul5XDGfU5/M9jzsbMzSEkqOn3ykYGzxVAI832f1atiVoyB+mgcGWz
 4dcS3exJOUaetGSq1BXTkoJvMDwwDh++5ZDkDCkiX4uDdNAnlNGyI6CsTm9wRbIs
 YzRsNMQ5YPYIY84d0WZAcK70SUUa0FjcJ1MDb43DWyDFb5vljkd88c7HjGZsrer3
 DKYOyuFxrq6oFiGV1J0E16WjyVHhRfgM4J8dmX6jLF5CTEWeBYEt2n4iEjcYr22A
 aTer4CpXQuQIQhJpvu8JrYsoG0h5VPF0zSDj8FxJPjUcDIy07SiOFUvQlHdKCYoI
 ynnfr4rmhIF4vEyAONn99Az1z6zOg==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021127.outbound.protection.outlook.com
 [40.93.194.127])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g97as73fa-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:34:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4hqjEWeWhJ4DwiD83umKMOfhdzfzWIsN1W+rXUhNjV3K3VgJlgEP65aRY/nSBQZLV08lusvf0rS+yC79nhXqHDPRJFH41pmRi0xHqlVEJO5ILoWmW6xFkTeYsXvfn42FC9rqC2KDR2OcuwbUxoAuEnb3XyD9H+S/7WdqvKeCjvORHoAg0v6yIaYqGqlvaH8rHe+IZxLyGQDvo6IRxwJlzo3kzpKOu5gyWrzCjfSTZuXVLcH/yfaxo/hcPIDrM9k2f6GPjje/P7Ny1g7Pe4kGIJqtV58IRFUAQAqg5gp3VnMbjgEW7e+NyXfsv+Fti+iCPQwW0iPp0j3TVsTeqUfJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJGu6qbhPHslWkstyg9ovDwIPZ1158jhKI0OYJtORtE=;
 b=jWp7fSWwU1HGSdgHjkrLXRMtiU9UCE9BdUXGda1u+Zsc0ptbXbaLgN7GgiXoGmONenMC5v3xLeja91Z4oRTjRQ3eNClH3Kg5dnrFZG5443GNr0gKcvI7TkLpD6sC1yOb89ZpbSAx3S9JlHz8YXOeMb/8yvU5l5qv9wambXewwVv6w4yM6M3hegSXp2Jr34AFRTkPomW77DywEjIbhemLNB0PNIBbjthX1s17RYtXw//QwuHzGXel7Aa7EPvcxFF0nWKb2tP073lEHLSEEuvHIaYX4d5RBbsNVL8XB++l2DqF430B3phGo5PaQNwIaJKnNG8FLlUNwU8DTYeoUNImZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJGu6qbhPHslWkstyg9ovDwIPZ1158jhKI0OYJtORtE=;
 b=hOMgSVINtCZfW4k6GKF8He3McOLMO9rIpKrWvt4k8Ps4KSPmgotNufzzeoHwXBKUzT83iEgMe88O+WaKMeoaOlP4/gA739/KD4X5LKBUtlICu9UgWS0jDEqE89j94/7F54S6gZNogtotrtt8im4BCHypGhMyYx+hBoQOcvmSNBdZd/7vDqoSqyRltHUntqoL7qzsA9/6j9YWFX/VEb4KtsI/XoJTiLnSYDv7xZOna/OlGWWJqlOpMhONMP8kJ8JnykhJgpCUqzrF4O00LdW1aUftk2yykvZkYrrgTeRF7Kc6CsK9EupWGfZIQnW7Of9YEYr2+BqPXsgfChROtOKB5w==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL3PR02MB8114.namprd02.prod.outlook.com (2603:10b6:208:35d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 14:34:31 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:34:30 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/16] hw/acpi/ich9.c: don't pass ICH9LPCPMRegs via opaque for
 ACPI_PM_PROP_GPE0_BLK prop
Date: Thu, 27 Aug 2026 15:33:28 +0100
Message-ID: <20260827143404.1393166-8-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
References: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0163.namprd04.prod.outlook.com
 (2603:10b6:806:125::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL3PR02MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: cb32716f-ae9c-4c83-5c90-08df04484e26
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: tZ8J1Gc6XJZ31kQBTUYybj0NjsRlSHWVYQoUA8KHfXRxa/0iWzYMEUT3qncxwx0ymQoRVjafdXr5wYoe61RQfbJt3f8bgPlXi2BZGiLDaUQbefE+IJRfnLApu/5gXpFybhYOZRBjPp2Wc7pCzS7Qfe2AygdiUNl/Y8ivf6eaRRMmD80hhbtYdI0QH29UvY3/OnL0OnsBoXB93j8SQSl5ZWzQy8sgrwikhKJOtIMXs0B7HIvH6AgAu+x33LNTOATLuz1NEwuazsr8nD6vBwcGDEwyH8XtEZSHsk0GcaA97vloISKbFQ++eCRGloqpH8kE6bz6sLrUm/eO8vsZfcSGinJurNMtrZXT7xnCeUUw4nTN2FWtQ0sq20QqZxDMuZBn9fOIoguRl2ZypKutUdVydsBY6lDCMuukKYTOil/h0aVMMV/hoBHapR8j5+aTF6GDOT433Z1EURThuTQrAP98eoOvWtACyTIZZElOrRntInQJFJOg8jfaE+J4gwBqFNqvOMySSoPgI5RpooBEBExM+oUm4zqQEMuPPCDY/3xz4Xhm5Ua5sAWvDntjfh6TSly0200FZEHBseDKL3s6sNfXdHPiwf4SkeBpCp5J93gYeSeHFoavh2mAGAkBh+NWSz1VZKkQcvUTDnvMeaMmf03aa91qEhJH7H9kMzHRWJq8JB4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjNaZkRWMi9takFHazd4QSs5WmxHNG5ab0xWOWp2OW9uR1h0a0Zxc1hKYkda?=
 =?utf-8?B?L3BsTG5CZmUzSWZvREVrU0ZpS0R1SnNhenhGY285NkhRSy9FcG10YXIzYVBk?=
 =?utf-8?B?YVJCVit3NEt6OWtGUmN1V3FINVNtNUNzUkh2SHBMNU5KcW5waDJFZy9Jd05k?=
 =?utf-8?B?TjZwc3plVjhpZWR1VVltM2Rzeks0VEV0UVdHOHJ1ckRMZ1RNdWFUbkNVbnVH?=
 =?utf-8?B?U0VhV3B6MlAyRGUzekhmUm9lVlNPa0ZIUFNqbm5MekVYb3FDMnM5cjVHTmpJ?=
 =?utf-8?B?MzYrUHZJUmZwMERRZlhaYzJkbGdvcURENTA2UjhCQUw4ekpRR3JzTFBUZlB1?=
 =?utf-8?B?Zi9mUzlmTmVtcmZOMEVyQk83Y0FkaWxNZVQ5eWVQQnV0SktzRHJkMGovMENQ?=
 =?utf-8?B?VThvRzdPVDJjWTBBV0Q5R2xjQzRjVTVvS2NMSG1WcDZNaXd0b1BZVU55K3hU?=
 =?utf-8?B?QndEdmtYcldqZXJBbEF3R3Zmdmc1MXVpRzNpNkZqbHJkRjFwcXNuOVI5dVhu?=
 =?utf-8?B?bXNadytoWitpZUVhaUxhRmlkYm85WjVsSkN4T1YvS3I3MXhCWUZTS0lLR1py?=
 =?utf-8?B?ZTZpS2pUeDc2eTUwcHdUTjlWQ2U3b0VPYTBEZ25HVjM2OXM4a3F0T0l3emF4?=
 =?utf-8?B?SGg2NVZ2eUphVllIbC8vRmpkREo1V3hnNFdkZW5tdHpuendlNFBlMGRxcy9l?=
 =?utf-8?B?VUFmazFsbUpYOUo5dU1YUzREelh1cjRLS1AycEZZNldJc2ljZWxPdHFzRUlj?=
 =?utf-8?B?MkY2MG1kdWZNeHBKNFlqazNBdXNDRUdzNi9ZdUllQVZKd2YvaDZLS0ZDZWF6?=
 =?utf-8?B?bmhWVG12TnE0a2l3bnp3OVZheE16Zi8xOUNXYTJtUHBsWlJtbGtxL01VTHFJ?=
 =?utf-8?B?YzVpUm1LbUIwMVVReFV5cElZOE9pWHFHWHJGamlhL3FpV3BIRDUrVisxMW9u?=
 =?utf-8?B?b0hqMkI5eHNMY0oxVTFSa1lHVUVpR25Db1JZVXVSeFdYU3VZM0NabFZWNW82?=
 =?utf-8?B?cHVGY1F3dnpkaSsxMnVXdVgxNm5FRm4zeE84c0t1VEQxNGlJSlBTWFViKytH?=
 =?utf-8?B?VHVGWDgyRHpnbFV5NnNhSWlmOFFrNytiaUNTVms5U1pZQnZQY0RiUnY3dlVo?=
 =?utf-8?B?T1BJVEVqUnN6dEdSMk9OZFUzK1VzWHAzWGpTU0RhUGdJdXJ4eXlJeG92WGhX?=
 =?utf-8?B?RTFyNlRuUHFuOWxjQVJVNFkvdHJtMnErYm9YSUgzSmFxUFo0VUVLV2ZXRnpK?=
 =?utf-8?B?TW45Wjh4Zlh5a01GOGhCa3E5K1R5TGtTZHczUEdrK0ZlU3F5cVNjRVJQRU0z?=
 =?utf-8?B?RGswREFyU2YvSlFXRG1zeW1uQ3pCQngvNWVHWXcwdVdYSEFncCtkU3ZDTlZS?=
 =?utf-8?B?NE1tUjN6aXNyc2U4OVBXVnpQTXpQUmZRTWlzRzR1bWpHVTZoVFlPNmdKdkdD?=
 =?utf-8?B?WGNNTDJLUllORWlNZThlaVZjMEhMUzRyVk5JdEN0V2NjaDBVRFZKRjlCNUgy?=
 =?utf-8?B?Z2FGWmxJdGk3bnlPNE1YaTBZMU81QWRqdm9tQUxJaFlZS1Q3S3NGNzlqUm1F?=
 =?utf-8?B?S0d1ZGY0ejEzUnVVQ3R1NlZJNzRtTUg1VGduTTJha0p6R0lmM21hc2hlRU1D?=
 =?utf-8?B?ODJvNXhwRGVNMjVtNkxTanBkTnltVE1UeDd1Ujd0KzUxdVdEOTJ6WnNiRU1T?=
 =?utf-8?B?eWw4T2RqbFRWTlRtdzJXTGNzQ1RZZ3lPcXhCNUxzQzdTUHpPVGcvQlcxQ1dw?=
 =?utf-8?B?V1RuQkhoWkVSMzJZSmczYkoxSVFSc3Z5LzdSU2I1YTNYdWFsRW8xNVhsdm9H?=
 =?utf-8?B?RjVDVHBWU2NCNHRuNzJiTEZIRHlKOHJYazMyTEpPRzlvS21UbzBhWkxyelQ0?=
 =?utf-8?B?RG45Z2VKVG5ERFBCV3hxWUlCb21HZ3RyZnZlais2WWM4ZnlqTTZKZUkvcXVr?=
 =?utf-8?B?ZS9tSmZoeWFXbW5jNnBncDZvVmp2TEI3VE13dXhacnhOb3pScERQVGFENE1F?=
 =?utf-8?B?QlRnckw5ZVl3N0RYVTB6bXpieHlyYWtFTVlzZ09DY3BaZDFOZm5CaUJOTU1I?=
 =?utf-8?B?dkE3dTd2ajEwQWFXSjVpd2t3dUF6a2dwRUNYUk9rcWhDMDVQQzRNaS8yQ2tV?=
 =?utf-8?B?NzhrUkF0dHgvWUJWNmRLNjRvWDVDTEVNU0V1Y3BDUXJuVVlPOHIrUGhNZDkw?=
 =?utf-8?B?QzR3Qm0xWGY4T3JScGRBNk9hUC83UW0xMUFhaXc5VEsrcFFTSnh0YjFRcitU?=
 =?utf-8?B?TzZiZE1ZZzFLcHFVNUpjamxRTUY4dWJ0alpxUzBWMWE5WGVQUXpxV1cydHFR?=
 =?utf-8?B?Qjl0M3crR08reS9xczJISVAzZ0lnN3dlREo0WEJhQU1YWm9PYkpIUEpBbHd5?=
 =?utf-8?Q?7dbsksl+VshOwMoE=3D?=
X-Exchange-RoutingPolicyChecked: Nyb1KevAsR4GszxBVmcdAfA+cJ5Q4W5BrZcgHaTu9c2kQ9wmt8/CyMpUuFossnv6k5YhsxlaS207A7jlrJy0bh7ZOFHRn9euKrlwQvvWbtyWgdJCcltL56P11czzGeaDsqywsqIGBukkrgSq8JTcYvkjwKOtwcP0VZDBWO9sclHht8lb7jmAoocSuV8X5oGODUOgug5pGVgE7MB8Nmb0DfyDd1UKRb9DlzLp/kn8ydeozTaP03MqCXShvk3FfcmlF5jWwNvUKAnmpxIfrB10DAC9swZ+78xPUwvE9UWQvl9AYoB0nZKk6Avgj9BRsS8NcHyl3+yoZqlPViQMnRb2Lw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb32716f-ae9c-4c83-5c90-08df04484e26
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:34:30.8854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FA7aaVu9iyeTn9zxrtj28SdrwOHJPruzCyMCfsknfdTvsJqqamyZKDJ7VnzNAGBQTwQTrLpRGDyYNapM6vDUuozsnBrUb5srFrcDQ6bOisw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8114
X-Authority-Analysis: v=2.4 cv=DJu/JSNb c=1 sm=1 tr=0 ts=6a904af8 cx=c_pps
 a=wuCIV2M2hcCPwYkL8T+rjw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=tlxghdvPRZsVr19qFskA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfX6aIrCCSn774Z
 ja5XW/MN8z2wYuiPQRv7pa4HNj+/QiUevU/da8MvnkZnq8RBmjGT4dGzgw7XqikTqQfVjidUEly
 LZ8GI2q9g04obZeeQhVg3PhsbDDfZl8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfX0jacPZtSn3Oa
 /TskjtRiCfO5xW2XDqK19q1fldsNR52YcXkeh1fQzAj5giN6wQ3u/QNZtBwLFO0ACgRvgl+p1gR
 tHsDm+nUcoWtTVdpx0c5t3n8OKRXmhcLfDw3ftV9yIXHUOff9RllsCM9okE+BRtyY6cJyFE78G3
 6oeG1yhXs6IPXbCn8gwkJx3Cb5QAONHPfVX+sUEJT1r21ydAXP4qcoCEhw+o61g91/QjVTeeqpZ
 XQAPE7Ar23MVqcCpQZL9kndwoWVKoN0FUPusTo/wkuxrgiRH+BPnAWu3xb1wqg6LDSKW2ZtB96Z
 8wP5nYjrYa+m+m+ETwwWxt8kBuyyttjJtWHvn23kJJslRGIskZ0k7bGcp6+8HDUgG4iRdOnM28n
 IkrjP5VCWmHG66kPqj3W5ew999fmdcIWUf6Nz2hCsOO8SLQei0llfUqI5f7iSaYO06Jj5Wq7uj7
 5LYvFndqXyJcGELxaqQ==
X-Proofpoint-GUID: BgG_9iiTBYSJVogVP0us54F8-n4dKyby
X-Proofpoint-ORIG-GUID: BgG_9iiTBYSJVogVP0us54F8-n4dKyby
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In order to convert to a class property, the ICH9LPCPMRegs instance must be
resolved by the getter/setter instead of being passed directly as an opaque.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20260825134320.1039012-8-mark.caveayland@nutanix.com>
---
 hw/acpi/ich9.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 5e8f8a7eaf..ac3f452dc3 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -342,7 +342,8 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_irq)
 static void ich9_pm_get_gpe0_blk(Object *obj, Visitor *v, const char *name,
                                  void *opaque, Error **errp)
 {
-    ICH9LPCPMRegs *pm = opaque;
+    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
+    ICH9LPCPMRegs *pm = &s->pm;
     uint32_t value = pm->pm_io_base + ICH9_PMIO_GPE0_STS;
 
     visit_type_uint32(v, name, &value, errp);
@@ -411,7 +412,7 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
                              OBJ_PROP_LINK_STRONG);
     object_property_add(obj, ACPI_PM_PROP_GPE0_BLK, "uint32",
                         ich9_pm_get_gpe0_blk,
-                        NULL, NULL, pm);
+                        NULL, NULL, NULL);
     object_property_add_uint32_ptr(obj, ACPI_PM_PROP_GPE0_BLK_LEN,
                                    &gpe0_len, OBJ_PROP_FLAG_READ);
     object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S3_DISABLED,
-- 
2.43.0


