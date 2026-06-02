Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E28CD6E56
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 03:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUFgP-0004Jb-5M; Mon, 01 Jun 2026 23:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wUFgN-0004JS-7H
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 23:20:47 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wUFgJ-00081W-20
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 23:20:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6ZmbOEs7jA6StECnfSTHAxEvd7WszdLbDOs25sf59Z0BGYW+5//Q8YXQqhy7lZGlKMSrE3Vk0POO0unRzEXgJNFn1+UNygxgkYlh/PT6VSnmXxM5xb2o1wVd+huUDScebSjWtSKmO/sYLRpyR4pOadCULuq2WQzHePmzog2bT8Pu1D+eDkVJZ11gJAbW5VxJSvImfaPn+xnVBZLC/gCGAHJM9C3PCg33tBqBCvPZy2YmPgxNUbcxDq7XhmhA/cqNTUt8nbN9boAb3xzQGqKPJI8CnY7JnyeZSMYy3ajUfYrCWIbPkEOjM1VlPaiiMApQfPQh2TVKk6T40nyxY33dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipRnVyhGiTWTM7N2erWAzn5M8dDT6QMqUJB+LZVfZpQ=;
 b=X8ANXJ9zVGeVuSU0EW+t5hMPneQBf34Ebr7nSW3OgsezHnvpSPVZhNlRymcLiFktiVhHHa1fFx6KPeWvAh9n7tJM8oET4AMeNfld7w9lOKTxzUUaWEcO/EmcyerNIuJ2IleeLu+6M3jDO6zeVxRAVU6MBK5A7i7C8OHJCak38NYhnpc2q+LozL4jO8i9Sjr3NH0y/1oi7j7SN/lCjLFGu42r2EAOnQPP7Fv8HPxA4hlVNUWPZFtTo8PT9GY7OBYoWD5UI3J9d5oC3f4wmc/wFv/cfMpXA5Ka/H+Z97e8d+wLfWHruzWTXHhW+tfPORGB2PnZlMaIV5OZ2T+YT6caWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipRnVyhGiTWTM7N2erWAzn5M8dDT6QMqUJB+LZVfZpQ=;
 b=PN9/9TieL5hLm6Z1zA1mapv6O4NECHnMSBJocYOoAqMpkeG0pOgm0UO2HSXJ8PnYK+zcrPjfiuOMc/N1Vzx0+3WP7p2xBog2rS2g4lC52S30fOTK11z+nlUkIYQVqfZmFWYCg/5+XaAKBp7jxp0OH/DtDzpJcgbHFF0iEDRy75gypbIAv1zfLwYW5nBCNevOIPZm2GI6uOtG6y6Cr3igvA60MOTG4rfXfnGXjKwioAmvl/7eTcEHaITILLpb49xMR7vzkt9dBV3Ny37yBR6bPqdijg+BZbM3S0fjI2gfWZQ3AvwWxVxQrTGW4bgv/Fcp6JRSMvG3CYfGI6jtWA2RMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by SA1PR18MB5718.namprd18.prod.outlook.com (2603:10b6:806:3ad::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 2 Jun 2026
 03:20:38 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.21.0071.014; Tue, 2 Jun 2026
 03:20:37 +0000
Message-ID: <c597c9d6-1155-491d-b85b-e49b7a58c13e@axiado.com>
Date: Tue, 2 Jun 2026 11:20:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] hw/gpio: Add Cadence GPIO controller
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260430091832.1846637-1-kchiu@axiado.com>
 <20260430091832.1846637-4-kchiu@axiado.com>
 <CAFEAcA8a6iSeqOf_PsMSEV_PaNm8NoBrH7DpOYFK+K=UjtiD-w@mail.gmail.com>
Content-Language: en-US
From: Kuan-Jui Chiu <kchiu@axiado.com>
In-Reply-To: <CAFEAcA8a6iSeqOf_PsMSEV_PaNm8NoBrH7DpOYFK+K=UjtiD-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0007.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::7)
 To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|SA1PR18MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b0c341f-1aa1-4324-d21c-08dec055ea9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|6133799003|56012099006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: lKnNY2qiBUnbTATsmCLj8uF/CTztyBCZGnyLR6y12HnOy/fc7V+WlUXfQ48Rf6k8hHMNIvTNEd3MDMUwlvpjw4DlLruik7loBfIwihJKCuMarsvO2sxoUgNHL6RLq/CddEePFLVHEWcrqMibX6CjuWp/w2lKfcOXQvIGQzExZql/DiOaz9P/Csc/auQm5BPTIfoYL9QeAol1mY+IMM88nqa11CmcthjxiWQIZLrLkXZBezDwoOwZPahGafu874ks1MDyWGrpcAoGOkQQRz3Fp8PaStnj7M+rr9tJ8SETd+hDo9bLtL6x85RjdBGEnC/R385RIKD/xXSWomorgtUHAvrNz5nHqS5YPs92UyaQjNMGbY5n1DxuF8iqLyR+Q3cXihDOLKYXSBWsiM9w7SslhN8ooYsBO6jSuoCIvzSNQN1X3ZNg8mKRxRk/pVbeXcSvmkS/l6JzJotIWnd+yCwMcpx533PfKNX+Rx4ZEvfeSHT28HNnjH24TPQXL0q+fS9tq/aOTUEsAvD61Lv20IH7A5WN9JsPi55Mv6VB6dDuNct8404nGZk3/DCnmp8SWvT2TiO2KAF/WvpTa7IFQzVxXjM/FcCoKHrz/J6Z7+kCEqR+MUgiNSK7baL41tqS+qR/4c93hDy47aqnfXh6aZHc4qUnXMVCfIYkEnDHjMTZIBcufYvaAN8RHA0OTQKKajBl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(6133799003)(56012099006)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3pUclhFN0NCcUhoUEFmdFRIWExMTkh3QmdrS1N3Y2NBL05HMnZjNldaeWpj?=
 =?utf-8?B?T0xxVE9yenFTRU02VVMzdGlXYWc1OS9teG1NQllwci8rTHdGMWdVVEVyMVZ1?=
 =?utf-8?B?NTRabDRJT2l3ZlpCU0tjRzYveEM2YnFuSE80eFJuOTA4K0NKdjhnbC9Jd0NN?=
 =?utf-8?B?VnRJY1d0ZXBWVzk1bXY2UXVhNzF6VWFxRVJlOUFSSXBUVGlxRzcwdjQ1d093?=
 =?utf-8?B?a3Iyd0pJSjUxc3BnZ2FpZ1RRNVgwWjFFSTZGN3o3a0Q4aytGL2J5cDVVR2dP?=
 =?utf-8?B?WVpWY3J2NnA1U3ZXVlpCL3BaUkFaSGZjTEV3L3Z3dTFieFhqVVNmOEZjSHkx?=
 =?utf-8?B?YTRVNjQvNzJnQ2xCWE5tc2hWZFV3dG9WMS9VZXFGWjVRMXRlU1pYOGI0MG9a?=
 =?utf-8?B?K3lreTNGWlA3R29nbWJwTkdCTk92YkN5Mk9MRXdqR2tVNDM2RkNkMzJjV2dD?=
 =?utf-8?B?d2hsdGpRT2drU2p1RnBsUzJDNVk0RzRZdzdxaHBaOWlrTGZKSlhnT01RNktT?=
 =?utf-8?B?Umlham1nT0tneFNCOG5NbVpWb3Z2Sm1Sd3YybmhkZituYnZCMy9kQ0xvVDZS?=
 =?utf-8?B?RG9mc1dKNm1WckwxZ3NaNTlrM3EwTVJuTFNSdFRsSjFuck9pMmloL2M4T2VE?=
 =?utf-8?B?VC9qM3pJd2ZRZU0ya2lCVktYRkx5UjFiQ0Izc1BGYndpdTNaVmJPLzY2MkIx?=
 =?utf-8?B?R25DWkkrUFRaN0N1YlIwZ2x6TGVuVENuTmE5UTR3a1QraW96SWV6YzJyams4?=
 =?utf-8?B?aTJCWDBaQytndC9qbU4vMjlPRkI4TXhUWll4NFMwUEpjNmdicWM1SFdlZjFI?=
 =?utf-8?B?ZnZwUFpvVnY4ZkRvV3VGZ2YyNk53RFcyNWJEbEFaR2lTRGg2K0FoNEM3UjVq?=
 =?utf-8?B?TjR5QmVKZGlsV3N3OTQvSGlZZ25McHg0K1VFdDJoY2k3aEtsUFNmcEhYa1Ew?=
 =?utf-8?B?WnpRUW1PS0xrVzRhWWltalVwVWhHeTBmYThOQ3JuR1ppQVRmb0pPOUFPYlhn?=
 =?utf-8?B?N2lNTmloc2g2eUhYMzJ1N25yeGc1U3hvVXVTbFF0N2FqSEF3WmtBdmJqZ0k2?=
 =?utf-8?B?QXpCLzVCT0tqQzV3M0NnbmlKczA3WTRIWFp6TUcyVkcyYVRob1crZ3UxN0Fm?=
 =?utf-8?B?WFgrbTJRREZ5UzhETmtML2NsdE1XY0h1eW9qUmNpeU51eFpPVkpEVUt1Wk00?=
 =?utf-8?B?UVgvaUJrVnZCVDQrVHY1bXFCVjBhbFBTemRscUo2czdFY24zQW9yWjg3c1lO?=
 =?utf-8?B?WWtqUGhEOUNaZklncXBlOWlKZjE4Y0gwYkZtdkVwbDJTU1ZVZ3lNczBrQTF0?=
 =?utf-8?B?QTB6RUV3RFdxVGNkOUVXUzNtdkYwdHIxMGpETmVuNkNUWldYSnVCL3ZtSzEy?=
 =?utf-8?B?bjlzZnVEZWVXSVJIRFFTS3ltWFgzK0dGbm0rdk05ak1HTWN4eTkyYnA1N1RH?=
 =?utf-8?B?UkgzQ2o1WkJhdWR4bGJBRk5IeFVmOG1jUm4wUFl2c0IrQmZVeFRzY1lKWERI?=
 =?utf-8?B?dDZtSmVwaUR2ZHpjc1B4TEFqcnFqNHJlblVXeVN4WDArb1h4TEVjbnljTmV3?=
 =?utf-8?B?Rk03TEJyOEtoMjFDaGVYazV3MTd0Ylg2cVRnNjFRZFRBVG93T3pSUU41d1dm?=
 =?utf-8?B?ZUdmOG5KY2tBeGJmRXJiTGJwSHhpMDR0V1gwVmF3VzNwb3NTYklQODFLTkxD?=
 =?utf-8?B?cWlENVJZUktoWTlwTDI0aUw5WmRuMXk0dWZ4RVlyYXNDdmVRWjBkUmwvZU1K?=
 =?utf-8?B?Y0craTV0dFd3T3RkYTNNbzcwenVNU0Zobm00Z0hYcEJwOXhYemF6c1ZoWTc3?=
 =?utf-8?B?cENQcWxwOVBYRHhwd1ZnMG1tR0V1S2FGUTd1eWJITlVOclF5M3JnOWdvUHNh?=
 =?utf-8?B?c3ltaW85OENDS3pZRGdPNlRRNHRoYk5sVDI2WnpqWnJGalZrQ2pQMEFNSUZB?=
 =?utf-8?B?dXc0MXp4cTFQYUdkM2hjak0xY1VSU3VQdUxEOTI2NnZDaG1IeVY3d2x0S1NP?=
 =?utf-8?B?ejJFY1JUV3hsZFBGRGN1OG5CSXBVajBTN083RTB0M3R2bmdYY29lTCtoN3g1?=
 =?utf-8?B?Si8xSXRjZWt1QXRyVW9HWGpMd0k1SGtyOHA0Mm9sSTh3WnpPWnp5dys4WC9E?=
 =?utf-8?B?S29lNlZ6YmRJTU55MlBOZmszSE85MUNJZDVFWjAyK3krYTdCWGdQdEs0RTF5?=
 =?utf-8?B?VmI3YjRLdlJ1aDhkcTJnWG5VN0ZaNy8vcUppUGJCOTl1UWY1NnBBUGNFWXNv?=
 =?utf-8?B?bnhxK3M5bERNQ0h0NGlvQW9IN3hueXc2QldVeDNlOEJPK0JscHJlMXE1QUdr?=
 =?utf-8?B?MVJITWNyZmdqckJJdXE5ODdrcjRLREhlTGQ4L2dOVnRkYTJ0dU42UT09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0c341f-1aa1-4324-d21c-08dec055ea9e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 03:20:37.6638 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZUD+1/FEu+D4KROXRnDQAgd/jY6TVaccMr9xG3ERJUxZhSgOgdunt9PYRNk4mYBqO5QqwZS+BIF0ymMeXnN9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB5718
Received-SPF: pass client-ip=2a01:111:f403:c107::1;
 envelope-from=kchiu@axiado.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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


Peter Maydell 於 2026/5/26 下午 10:18 寫道:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> On Thu, 30 Apr 2026 at 10:19, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>> This patch add a new model for Cadence GPIO controller which
>> supports 32 pins and interrupts for level-triggered/edge-triggered type on
>> input pins.
>>
>> Also define new trace functions for analysis purpose and new configuration to
>> enable this model.
>>
>> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
>> ---
>>   hw/gpio/Kconfig                |   3 +
>>   hw/gpio/cadence_gpio.c         | 301 +++++++++++++++++++++++++++++++++
>>   hw/gpio/meson.build            |   1 +
>>   hw/gpio/trace-events           |   5 +
>>   include/hw/gpio/cadence_gpio.h |  55 ++++++
>>   5 files changed, 365 insertions(+)
>>   create mode 100644 hw/gpio/cadence_gpio.c
>>   create mode 100644 include/hw/gpio/cadence_gpio.h
>>
>> diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
>> index a209294c20..fcc7c70bd5 100644
>> --- a/hw/gpio/Kconfig
>> +++ b/hw/gpio/Kconfig
>> @@ -30,3 +30,6 @@ config PCF8574
>>
>>   config ZAURUS_SCOOP
>>       bool
>> +
>> +config CADENCE_GPIO
>> +    bool
>> diff --git a/hw/gpio/cadence_gpio.c b/hw/gpio/cadence_gpio.c
>> new file mode 100644
>> index 0000000000..2410753abc
>> --- /dev/null
>> +++ b/hw/gpio/cadence_gpio.c
>> @@ -0,0 +1,301 @@
>> +/*
>> + * Cadence GPIO emulation.
>> + *
>> + * Author: Kuan-Jui Chiu <kchiu@axiado.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
> Is there an available data sheet for this device?
>
> What is the actual device model name? "Cadence GPIO" is
> extremely vague...


Axiado SoC is using Cadence IP for GPIO controller
I am afraid of that I can't share the data sheet publicly
Here is the link to Cadence official website
Artisan Foundation and Mixed‑Signal IP | Cadence 
<https://www.cadence.com/en_US/home/tools/silicon-solutions/artisan-ip.html#gpio>

> thanks
> -- PMM

