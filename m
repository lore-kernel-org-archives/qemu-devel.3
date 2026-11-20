Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50943606A325
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 01:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebius.com header.i=@nebius.com header.a=rsa-sha256 header.s=selector1 header.b=XbAEGk4I
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUDMn-00017O-JG; Thu, 19 Nov 2026 20:24:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonkuchin@nebius.com>)
 id 1xUDMZ-0000yb-UA
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 20:24:28 -0500
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonkuchin@nebius.com>)
 id 1xUDMX-0000mk-8p
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 20:24:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rL1zc62Fy8a/9z++gY9GJr4EG+Iv/7x8Cm8eIkRq0h9lsxH+pfImJbm9QtqXzHaqNmhuq9S4ok9gDAQOnKMPR7LkT1H2s8z7RlwOvrU7x/EgKcwgFRiCvC1bfxXJM+gd5LeNETVikyTe2PXaxLBa3ZlqA4w0d+5R87/KbZmN1I9nWie652J5Th3PATGpGo74WLbcx48dIXoomZ5cB3IdnpRLk7iUPP0ct6kXHZnOKR2y3e743q9vopAYKh1burn08vYWYkB2/ZW5GLbDimkiFeuWnd9YEFo+JHzPbKwOqBn7zt0Ov3GIRl6IVOvMeG0+Fwj5PMYHjayFQJWXKk+dqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwJQ0Q6uh6BdsQ04Pzob8v/yn7nqr+fPmbRbuwspIZE=;
 b=xX5GtSIKyTHDQP7CjGRREk9jAHSXQCSbcoOFPcWPXi+PARL6Y3ImoEh2nGH439Pz/m15vklOfvii4/dYx8fCpNLKZNbkA3mAx1xUYAf2oMnkHTCarFLwx8QJpKfKk8K1K12pP9dm50U9giv8+hIoBFprEvh9brDBo7s/MbZ/FFQA3iNJedfOdzSoxespKhVR6z2j1RrmiWuupvcvbLsVhBGFpR24et7jbyo5HUEbd/AsLT8bXTMw/3oGQXf3ZblOj4IYMoVqr+HuzKgjaOT9mLl5/hEj3Gkbz4Ka4RdZSiQCGtgKkhfRwdfUQkzHVrA7pWDp2/ymObX3mk0mo+OZDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nebius.com; dmarc=pass action=none header.from=nebius.com;
 dkim=pass header.d=nebius.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nebius.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwJQ0Q6uh6BdsQ04Pzob8v/yn7nqr+fPmbRbuwspIZE=;
 b=XbAEGk4IqnvqJ84RsXI+6id7qIHCkA9/D1AgWpXW7Aah2vAWRQ4rsAfPwIIwtUlujKA4Z4W94t21XBFhjlRYKRU21V6VXabs1qWCP/gMi5f/9vdGhjVALHyP55kOLsAAR0IADQZslXxpeAqfLWM2n4kGZWEYalftUCZcWlhGhdwFlxX0vcvhoPA0bJcAac3TanMu+QWOn6+kB+jHaYLS+4DJKIRX45H5YjU5yBZ3+cOffHFIfLWqdlx31xxYDKH0gJHyGTQ5dNbCTN8XqSx5pL6oIILQuVwbU43Vv5sl4IgjLTNIFlUMf3aL3N3dCc+aKVQN/GuEzvTG5+m6JZEx/w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nebius.com;
Received: from PA3P190MB2470.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:4b7::24)
 by AM9P190MB1265.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:26c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 01:24:20 +0000
Received: from PA3P190MB2470.EURP190.PROD.OUTLOOK.COM
 ([fe80::ab4:8b02:737e:c2e5]) by PA3P190MB2470.EURP190.PROD.OUTLOOK.COM
 ([fe80::ab4:8b02:737e:c2e5%2]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 01:24:20 +0000
Message-ID: <cee3d3ec-67a2-4f53-a394-8422575b4729@nebius.com>
Date: Fri, 20 Nov 2026 02:24:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/acpi/aml-build: Ignore used ranges outside the
 requested window
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, NB-CoreTeam@nebius.com
References: <20261107-users-antonkuchin-to-send-fix-crs-replace-with-free-ranges-v1-0-0cede42456c4@nebius.com>
 <20261107-users-antonkuchin-to-send-fix-crs-replace-with-free-ranges-v1-1-0cede42456c4@nebius.com>
 <20261117072730-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Anton Kuchin <antonkuchin@nebius.com>
In-Reply-To: <20261117072730-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR04CA0177.eurprd04.prod.outlook.com
 (2603:10a6:20b:530::10) To PA3P190MB2470.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:102:4b7::24)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3P190MB2470:EE_|AM9P190MB1265:EE_
X-MS-Office365-Filtering-Correlation-Id: 08d8405c-afad-4ff2-f005-08df46a500d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|10070799003|366016|18002099003|22082099003|261009223027099003|11063799006|56012099006|10067099003|4143699003|261102123227099003|261028144727099003|261022105027099003|261026140227099003|261026121527099003|261022075727099003|261021121427099003|261021123027099003|5023799004;
X-Microsoft-Antispam-Message-Info: MKIktptSa8HZI4qUpBx9kICp0uGrIu/oXydetaATPTrX1GuSiI2Pqg+ZdWdTTpRPJ/9GXOEk4kf27PJnvEoB6Q64L+ciGU13kYCvhMxrTjmfb0h44IpwEAJAuSP4eykDKxOLLad46/qn/w6mGj9AxIyBVR2Sht/4Kd+qiygKhRJ6Vo3O7+ud8isIChf7OnYrer5glrww9ZMYDNkXKH4/NZhx45jbtvv+NbmRXJf0/n86WRmb3+xOvsvy5TCbv+QI5JS7LveLs+oW4U4jw57lTmZ9x8RcemiRBmF6uNqGmzkOXupEc/FayZqhfK6ePezmQunxvlEg0ZOw4X3K8mqj4obizU3rnnOF3ALgeOOiUf4iE5OJ49g4lqY+s6tURENxesCSB8xM1q7RIVz+vX15P978NrKT05JzirG7lodW4pZJXWJva53k7f34rpkpy4G+7OZJ5m5WQez0Covx81xC8ws0aLOKXighRERKDEQMImu6+KKJJgxsw4TvdoL+nlVxxlb/Bp/qZkhipzSgYicZ88YlFogHwjuRGww7ZFPHrxHooLJpNrhbemEyUOaMOiKlB+NyqdXP/h1IqsEmoQBZs4TIAH4qVPR7GSL/Z0KQlYn2RsVN7U3+tDWl5U1tUPdsArCnMGp/0CtyAVc2HP6hoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3P190MB2470.EURP190.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(10070799003)(366016)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(10067099003)(4143699003)(261102123227099003)(261028144727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261022075727099003)(261021121427099003)(261021123027099003)(5023799004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTYwUGxldUJCdHhQbTNEZXViWnB0THp2L0xQa281QnlFSUd6bmpZY08wd2FX?=
 =?utf-8?B?S2xhbUxMcHJiRXY5ME9jT0xzWkxJdzlvcXA4bWMrbzRjMW82ZXhXdVVGR3Qx?=
 =?utf-8?B?QSt5eGtTbkFKWGx6cmtpRkR6eTgzdU1CNWRLaC95bFFpekRKbnZtK3QrSGVX?=
 =?utf-8?B?R3JMamRhQWIzY0RRYlk4MFgwWUFaSUdzRWhtWTBEKzNKVXNKNHJZV0hCbEk3?=
 =?utf-8?B?MUFhQncrOE1uS0FGNngxeUZUTi96RkMwUGpIY0dJODJzNlVWVFBXVktBV0R6?=
 =?utf-8?B?WGtLeUZHZEtXTUVha2dsMDVoYUpuKzhqZUJKUUU5c2JTRzFxeDFZdmY0VEJJ?=
 =?utf-8?B?UGJtaUU3Qm4rR1lqL0llN21pUGxkWEFGeXVCdmY2OGNqK1V6em0xQVg3OHEy?=
 =?utf-8?B?Vi9jUEFna1hhZlFkM0ZkV1grRmdrL1Roa2NPc2QvWGpHejRSZ3Nzb1lxcVFm?=
 =?utf-8?B?aHBvM2ZnYTNSdUZmcTBOTko0RCswczV6UU1QWEU3V3grZEx3Sm5vR0J5dlc5?=
 =?utf-8?B?akF0SlhFRkJrVDVmTHB5VWZMU2srcnBPRmx2aTJoamhybFFhcUZlQnovR0tR?=
 =?utf-8?B?REhyZ2NCVmJSS0dHamJ6WWRBM0N3T0tybEZ0K1ppVmJUa2hGdDNGdzZTMFhm?=
 =?utf-8?B?OEN2TEFreDNBbzFiYVlqR0ZmOWh6S2ZSTzdQVVlHQXRSVFdVSVdPTXh0ekV3?=
 =?utf-8?B?bnNSRDlaZ2xBTjJkQ0s5eW1KeGRaUlBaaUVnTTlxQWpuYVpNeHlYQkdrT3o0?=
 =?utf-8?B?RVdxb2pRbG9xejUzR3hwKzV3R0p4WmJDR0tIZWdQRTlSbjZLaW9GZWU4M29n?=
 =?utf-8?B?K3k4VW01c1lXTVhNTm81THU4dXFPU2xnNjFIK0dOb2NDTWpTOU5yQ0hWakpP?=
 =?utf-8?B?SGJKalJDblA0d2tFU2dLSUFHczhxU2cza2dTY1FGZENtVjQ5b1RVeG5jNDBr?=
 =?utf-8?B?RlcxRnpGbEJDS2tna0thRXhBT3BPSVppNTZ5WmZwdTN4K3ZsMDUybUx1M2JD?=
 =?utf-8?B?Q1ZKY2tZbnREVjFRZFU1U2dyZWI1K0prL1dvZWcrLzBTMlltaEVKdVBvRGhl?=
 =?utf-8?B?NEpyQ0Q2USs1VUxzYndEb21uUE1TOWtTSGRZKzBkc2d6SFhIZ1RXdGxYWUZF?=
 =?utf-8?B?RHZtSzNITU1LS1NPSm9nOHVTcTF5MXhXUnpJOGRiU2FjZW53VWFZeE9IUytK?=
 =?utf-8?B?QVZVQkQxc0ZITzRnRGdVUHdUQWRFbktQendpTmdoZzlFakNBRHVONzBON2NZ?=
 =?utf-8?B?Q2hDMkxVSno5dUYzTWxrQmdoTTF3MURtTjUrN3BhVldQUEZiYTR5Z1BtbjR0?=
 =?utf-8?B?bkIrKzc3VVd4aVAvSmliVzQ2OEFmdHc2U0NNTDUwcnVhaXF6czZsQ3VuZHVl?=
 =?utf-8?B?TUVuamhrbU4zNzdEQURveGVtWmtuSkhZV0RnMHRaeHd4TFhRL1BqWXI2WVMr?=
 =?utf-8?B?MHNyT09udm9La3FyNU5Yc3pxRlpVZ2IrS2crZllWZXZHejZDMW1Ud00wcHly?=
 =?utf-8?B?RWRLa3RldUtiWW0rdVdkRnNRTEMyVlJyN2kxTGZiQXJjakk1dXcxaWVPTGRa?=
 =?utf-8?B?L25SWDdPc1JwMUlmT3ZEZ09idlQ5OTZTWFFJeXAyVFVkQ3E4U2NEY3VkNlJO?=
 =?utf-8?B?QUxUTXpyRU52ZlU0dmhDMjltS2g4YzJjd1BwK0ZlazE2TDUrN1lFMXhiMDZZ?=
 =?utf-8?B?UldXdHhOelhFNTFMTXd5Tmc5M3VGbHgxUm9UUUFjSWdpTmNhY1ZHRzBCMmtw?=
 =?utf-8?B?VlVGck1yNjFWNFQrZFBXbERNL0FjK09wUkdMbkZZTFhDak1pbjl4OWFGVVpT?=
 =?utf-8?B?MlkyQWhjanFjNittM01YZzdNbEtKMXdvSm5TNTlPNVlRZElwTk5uTW1SRnl4?=
 =?utf-8?B?ZnlJbkVlcW1EYW9RU08vVWJpVXZSeWNySW5PS2F6Y1VaZFozOEErOWRJV3V1?=
 =?utf-8?B?TWQ2TFRlYTI4d1ZaaWlrZHd2STA4ajlrK0w4SHZIcGVZV3RNRmd1YXNzWmlk?=
 =?utf-8?B?c3Y1M3NnaXAwOHU1RzZRN0lMQ0h2eTRoZGZBZTZMNU9ZOE5oWVFEOWhUbTBY?=
 =?utf-8?B?dHRaVDBZZzc2ZThLcHlNejlpYks3WVg5SUE0d3FKeXJGclppcm8yRXkvMUxL?=
 =?utf-8?B?S0VXa281Y2MrUUZNSVVHT0l2Y2JCSjdQSzBOTTdxYjNTUFZrTEhCc3MyeTdL?=
 =?utf-8?B?SDEzMUxLYzdPRlNISEJYOVh3QldNalVyb0Y1RHlRU3BITTFvd2EzNW14TjVN?=
 =?utf-8?B?OXZFaTRQb0RQamw3dE1jQlNPLzhYR1JQTEtNcjZmS0FjOXdXaTM1R0E1REhJ?=
 =?utf-8?B?VncySVBNQ0Nna0k5UDBKRitaNWloT0lhaWNCTFNNcjdLYVNrY3RBeXFOa0xh?=
 =?utf-8?Q?sKbd/eUJjS+HFCCLCMlzcipUH3NTlmxXC0IwFacAb3CYg?=
X-MS-Exchange-AntiSpam-MessageData-1: p0R8eRovESt1YA==
X-OriginatorOrg: nebius.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d8405c-afad-4ff2-f005-08df46a500d6
X-MS-Exchange-CrossTenant-AuthSource: PA3P190MB2470.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 01:24:20.8715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4eb23c52-f3a5-49bc-b555-0b061267a984
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YKdfyYMqDIPS2wZagMKVXG9ZCol9Cw5hr7l555sFsk4H/+TLbwWrnHjRHqpWzMwseavwNe9PRto/MYeHDHnc8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P190MB1265
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=antonkuchin@nebius.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 17/11/2026 13:28, Michael S. Tsirkin wrote:
> [Some people who received this message don't often get email from mst@redhat.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Sat, Nov 07, 2026 at 12:59:48AM +0100, Anton Kuchin wrote:
>> build_crs() collects used resources without any information about
>> valid address windows. These resources can therefore lie outside
>> the interval passed to crs_replace_with_free_ranges().
>>
>> crs_replace_with_free_ranges() assumed all used ranges lie within
>> the interval. Ranges outside it could therefore produce free ranges
>> extending below or above its bounds. As a result, the guest kernel
>> may assign a device an invalid address range.
>>
>> Skip ranges with limit below the interval start or with base above
>> the interval's end.
>>
>> Signed-off-by: Anton Kuchin <antonkuchin@nebius.com>
> 
> 
> Given it's a bugfix, pls figure out when was the bug
> introduced and include a Fixes: tag.
> 

Thanks! Forgot about this.

Fixes: dcdca29655f7 ("hw/acpi: remove from root bus 0 the crs resources 
used by other buses.")

>> ---
>>   hw/acpi/aml-build.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
>> index 990abc64cd8b..90837b513e69 100644
>> --- a/hw/acpi/aml-build.c
>> +++ b/hw/acpi/aml-build.c
>> @@ -124,7 +124,7 @@ static gint crs_range_compare(gconstpointer a, gconstpointer b)
>>   }
>>
>>   /*
>> - * crs_replace_with_free_ranges - given the 'used' ranges within [start - end]
>> + * crs_replace_with_free_ranges - given the 'used' ranges and [start - end]
>>    * interval, computes the 'free' ranges from the same interval.
>>    * Example: If the input array is { [a1 - a2],[b1 - b2] }, the function
>>    * will return { [base - a1], [a2 - b1], [b2 - limit] }.
>> @@ -140,6 +140,16 @@ void crs_replace_with_free_ranges(GPtrArray *ranges,
>>       for (i = 0; i < ranges->len; i++) {
>>           CrsRangeEntry *used = g_ptr_array_index(ranges, i);
>>
>> +        /* skip ranges below the window */
>> +        if (used->limit < free_base) {
>> +            continue;
>> +        }
>> +
>> +        /* skip ranges above the window */
>> +        if (used->base > end) {
>> +            break;
>> +        }
>> +
>>           if (free_base < used->base) {
>>               crs_range_insert(free_ranges, free_base, used->base - 1);
>>           }
>>
>> --
>> 2.43.0
> 


