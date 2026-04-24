Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFEFFE51FC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGDJP-00052t-3l; Fri, 24 Apr 2026 05:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wGDJM-00052K-81
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:59:00 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchiu@axiado.com>) id 1wGDJK-0003WD-Ia
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:58:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMr7rqt5rx210WIh9uBUUcNwhlGyE6zQgILfBy+3mo+Zuql5ykLpiu8S3z1gXKeIV0kPy33u/pv746/r9r82ogpZRVsJwdENhIKB+TcJ6qYIb9HmXSP1Nczm8O1+SLYcva29EYgQEVxIf8rMfbFJcfsB4Ya9aqc66kTfnWBhoDItC9LJBK3SERo9TFS3BJ5pF8gXPRFED0vYcQSQ1C0NJZkFBZLyUm2rTOpCZNOeqp/LXITUItlN7zAlvtyUc6v3VFrd7gXVV63IdNt39kAHkL/AyDD2gG/GCrM+mwoIAfXHf7SNHe8jkfgPxg65qyKmEKRpAbg5/lG1AxGlF8AUNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7h6UOfxUcTS6g/1rnN03vJMVNuMwtx6O8+GOjQmZpqE=;
 b=BiwzpGaMwZtfIWB+/kRKHx5mOwdjgdBRfjRgDqPwX8M/HvG4Bacmg7uVJ691ljVok+PMHLZecK1vMimWrc59znJBLIH1Ydl2C9P9Hioiy1409Faa0NG6zw+ybwxTWMALIBG1K81q8A0NH5b6Rd1M3mzIvFCEgbq8lXcFb4RWnDfsJ32DDI1FhDZ2XP+c3DjF/O3PYkjIXncz2zC5XjyrMWjzVcIRo58WK+J2VKc1ZML5VkO07rDzonKNRv89YqyyBZ36aIzm80jsG8XXh6+f/wYyTf5Dj9AzzQwm/mmFkTpAjT/uWzM1YPocKhkU9ZRh7FkMAd60MEwcR/zvQS6YXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7h6UOfxUcTS6g/1rnN03vJMVNuMwtx6O8+GOjQmZpqE=;
 b=k7KR2iGOkdHwIkqIi+NouRUH21/PjZJqJYxKvDAcdADcHlL6bCtk2bqx1RvzslvxvGry1fqKbfQYBsK7R6chDYm+ka100pv+gwUA2Y4CWMUkHSnA/+DPhthsGPefNI/8TzQpBL55PRG+ah7MtqpaVKmJu67poFPe2j6XveWzTzq6MdJxhZZoHBcW/TtfpC0TQs3ZrA0fEgHeCB+zlA8OC4/PRPBdwQxYpvmgadPIoR6+1ATH6wtYUJOkLqVTvI/6Un1r24UXu71q5d/VJTl1ZcXhEaMJjMqsXjaRnYyhcXth/i4JUQhETJ+5arIU4D1x79uK2nhwNkmTxIgK6sZ7Ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19)
 by LV8PR18MB5653.namprd18.prod.outlook.com (2603:10b6:408:191::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 09:58:54 +0000
Received: from SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba]) by SJ0PR18MB4479.namprd18.prod.outlook.com
 ([fe80::eaf4:3aec:73e:d5ba%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 09:58:54 +0000
Message-ID: <82bb4227-417d-4745-885f-4f74f55b102b@axiado.com>
Date: Fri, 24 Apr 2026 17:58:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] hw/arm: Add Axiado EVK board
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260306121511.1781020-1-kchiu@axiado.com>
 <20260306121511.1781020-3-kchiu@axiado.com>
 <CAFEAcA-yDSiumFrj4R88B0ZrB_jjK1JEJBQok7wUi=yN+vTNGA@mail.gmail.com>
Content-Language: en-US
From: Kuan-Jui Chiu <kchiu@axiado.com>
In-Reply-To: <CAFEAcA-yDSiumFrj4R88B0ZrB_jjK1JEJBQok7wUi=yN+vTNGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0051.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::11) To SJ0PR18MB4479.namprd18.prod.outlook.com
 (2603:10b6:a03:37f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR18MB4479:EE_|LV8PR18MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: b34beff7-f752-4cb4-f6cb-08dea1e81831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003|18096099003;
X-Microsoft-Antispam-Message-Info: UrYM/0RD7yZ0lhbExazL166EmXl4tBzf2JuPEusvFaW56QZvxWTu6SgGesrpnxaKteY/4AJ4IPJCh/o98ndm8/JfjD9ZeymAu+LBqrYoBy2Wmi52Fm4LGulsONkYQd4w+XwATEYqLUDDLDppsn2CNbV9XdMnVqnHZCxWy6EnO/MMAiIt5jeprs5v3t4n1eoMcGYdK3RgiXjWby29piKt8j4Oh+MkLYyDN/fudsKc8QDZJbfB2cOKG0dyfrUE3U1AoSk1DBu46mM1xQs++/bIlnX3dp4Z/YxMv9k9DcM5Z+4w4hlFaxqOsltSuH6C4c+AxGSi1stb4EDwp+A2E15l0H0u/XwIqzVVpFE4SLHfetCFZFubVGQO/ZAZ6kODH3o9rZIZhgHmZ00XgyS7E6CgvN4ny+h1yz/7duOi2yxv2IEW3tbnd0c1jj5d4TtgF3GUYjDt255j8YcYGlvK/qLg/0rphSSFbhmgNnunLj0s99c/Xv6XvGUrqtBag6qSf0XdwotCeTay7+AVTNjYtROogeBNiUGb6YsVxOCyo/Y1GKt4b7w3oQXJuvSdAF5cM9xRtvDSHNHMvjgpEwMKpPUnQdZPebsmAZ5CgF6vEeaSUB4SzJybS8dS854Hz/3OSTcRuQXcyvlABkkDtfxXRMzPTor+cijY+Pe5e8DsShv38ic6zp5D/I5+pOa1eePeERaZ8dglwBHUzqgp/Wewuo5hkF3gKg97KBehfi8TIriv6nA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR18MB4479.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(18096099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkFGSVhsQ1RRaVVDZEoyUnFSMFV0ZEdzNHFuekNEaUpNbEkyeHo2MStBMENK?=
 =?utf-8?B?ZHJjUzhxcnJxeElPNXpEeXFIcFBBZUFtNm1CSkkxTGR1elZydkJoa0RVdlZo?=
 =?utf-8?B?WmhLYXhrVmh5UDZTTmdWY05iWVlWT0RFRVZXLzhreG4zYzRWYzBDLy8zL05l?=
 =?utf-8?B?TFJXY1pjUzFuRHZDUHREQUhBaTNHOE81NC9GSWF3S1dMQ0NLMlNuTDMvT1Jk?=
 =?utf-8?B?VlV2MXFUV2t4dnhLNUkxeGl4S1FjakM4ZFpBUmFGckNHaHJ5dExSekQyd1lZ?=
 =?utf-8?B?UzZiS0lIOEI3M0JGbG41b0dhZWtGT2dmaG9aN3JXdmRTamNZWU1Ma1ZOUmNk?=
 =?utf-8?B?ZkhlK1REZTBrd3c1NlFFMnNETjF1YUhUdDNBcDl0QnFNRjc5Z3MzemJaZGRJ?=
 =?utf-8?B?NnoyYnpDMU90aVhLTmhLbDA5UnJ5NmNLTVpmSHQwNG1xc2hsN050eXdOV09E?=
 =?utf-8?B?MnZJOGxCVTNXZm9QVTlTT2NsOElXOUtlTDBkaSs4aFpQSHYwS0pSdDJ5WWhq?=
 =?utf-8?B?K08rR2pCaUZSQUVTUmFsTkFjZzNIQUEyQXI0a25jbmp3ZUxocEhlQ0t5b0VR?=
 =?utf-8?B?N0Jiam5kdHgvODc4TWdtUjAyQ2VRMEhnc1Y4NGNmMHVIQ3VoRGQzSTNRNk9D?=
 =?utf-8?B?YXkyTVBMVy9PelNkUVptUVZEc3ZSWWVuTGg0c0UrRkYrZzZSRzN4ZVZYSzlI?=
 =?utf-8?B?aDJhQitKa2pIVG1DcDJONU1aditMWEJCKzFuSDRWTUcrb0wwRDIrQWp5bko5?=
 =?utf-8?B?OEhFQktYNHhmYVNRd1RNcnM1WFFHQVVtQ1RuRDU2Vk9oZGxxWFh5RTQ1bTFz?=
 =?utf-8?B?RlBHT0xoTWJJZW82eGZJZjZCWk9LcENnM2lWQVgwZU1uSUZnU3ZRQXpDWHBx?=
 =?utf-8?B?L0xiNk5OM2c3UUN3ZThnOC82dXVtbFFPVHp5MkI5Um0zT3p0c3dOWm5LY2Vo?=
 =?utf-8?B?TmdBV1B4SmNCMEY1UDhHL0RJZVM0MGRWaTdZN2s5cnh3Wm1YSXMzdWJ6U3d1?=
 =?utf-8?B?Z2hqbWhzZzVMWFhwNmZYOGdJK09ldU1kRWNDbkxISlBmQXNxeHpuWWU3dzcw?=
 =?utf-8?B?Wllhci9WYWkrenBjSVZCVFkyK1k0YWU2bXFsUXFqdmx2a1ZFVHRWYW9TVjFl?=
 =?utf-8?B?R3RCRlRhejhVcDhWUGtvQ011Y1R0RTZ5ZjZrKyt4N2Jnb0R3WmlOaHZ3djdv?=
 =?utf-8?B?RkVsNElSeXRiUlpOQk96b3R3MGxzVnU3V2dYalFjUTg0SGdNelVNdWVpazFp?=
 =?utf-8?B?blR0dlB4bGtCV0RPMEdSaDVYTVRSMHFwelN6QW1TaFdXRDh4WWcxWnNTZjlY?=
 =?utf-8?B?SktKZk1ITlFwUGZpdXRhdktCbVRPMXlRd1lRbDM1K2h2Q2EwUXplbFlvREV3?=
 =?utf-8?B?elVwQUYyQkhKdVIrSFptekFXYWsrdUcwRXc2OFpaZVk1bGJ3OWFiVWs3ek1P?=
 =?utf-8?B?S1Y3allUbVJmMURxeWpqa2VpK3dSbEJXU1dGMzJoZTdKaThENi8vMnVxbk1P?=
 =?utf-8?B?am5Td1NFR3puR01ISm0ra1hZajFQc1ZZSC9RTkk1Y3JIUWJWYUxuSzV3alJG?=
 =?utf-8?B?RFZ4UGRZTEZXQUxKZm5nWEk3SXZERDRKS2tQVkhwVHBoYVdLRkVvUmpsaThR?=
 =?utf-8?B?dTlWVzhmc0syQUpZZENaRG1UQmpWdFFlYkdmTHpIU2htSzY0VThTWUY4UzdN?=
 =?utf-8?B?ZlltVHlrTzd6dEs3OHpEbUkxb1VBZGk4UUxTK0NhbXNtM3pCMWhWZ1FEbUs5?=
 =?utf-8?B?NHFzVEZ2TkVHekllQ0s0WjRzVXJPTmhjYkwyUmJPeW13TDNSc1VldnpJaEpD?=
 =?utf-8?B?NFBaZXVnUUwvUllKb05HcDZ3NlQ5bW9oQjdxRjMzdStjL1p3c2JwQjhqTno3?=
 =?utf-8?B?aFhqZW5vYVVJK2phVklrMDdUd2R2ZU1VOVlWN0JWbUJRS3FWdkdES0FqdGRO?=
 =?utf-8?B?NkR5V20wUTluVHhXbnFSTmk4OGhOZVJFWElyQkZDMjZNUm5sb0lIY3RUTmlZ?=
 =?utf-8?B?VmprOWxBVlN6U05PdUhDZVBXQ3k2aFF4MUdxVE5hNUdHUElkcEIwWUc4bS9i?=
 =?utf-8?B?Tk1XVHhSbkVKZkJ1TVMrcWduM3ZaTWdaUXdZZFFvcnZ2bzQxcTJ0M1lqcUp5?=
 =?utf-8?B?RzJmaEh0N2FWekJvZitOQ2dEU1RuYnE1UE1tc0cxNW5qQ3hnZXRuOFVleGVt?=
 =?utf-8?B?VU4xaWhEb2ZSSitQMlVpdjlkdTdDTjd5dEFlL0xKRW5NMjRmd2Q1SVBWZHNF?=
 =?utf-8?B?RlFuMndMR3NueFBGTEI2WHkycVlMUm9FRVFlaHR0L0RNSUtUN2N3MFFkNm4y?=
 =?utf-8?B?R1FYQUYyNWw3U1NXdnQ4L0pzUzRRV3kvUy9UVGtXUE45ZjkrM0RCUT09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b34beff7-f752-4cb4-f6cb-08dea1e81831
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB4479.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 09:58:54.5713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2u8RaDA+X+0bti/ZSxj1kaiuZnaJnbDruYS6xlNJeMzSbe1o15MJQOYgF6oJsdY4dwc0HSjDVMj/1FsIwy0iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5653
Received-SPF: pass client-ip=2a01:111:f403:c10c::1;
 envelope-from=kchiu@axiado.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Hi Peter

Please check my replies below

I will send v2 patch soon

If you still have concerns, please let me know

Peter Maydell 於 2026/4/9 下午 11:22 寫道:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> On Fri, 6 Mar 2026 at 12:16, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>> This patch adds a new model for Axiado SCM3003 EVK with Axiado SoC AX3000
>>
>> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
>> ---
>>   hw/arm/axiado-boards.c         | 78 ++++++++++++++++++++++++++++++++++
>>   hw/arm/axiado-evk.c            | 38 +++++++++++++++++
>>   hw/arm/meson.build             |  4 +-
>>   include/hw/arm/axiado-boards.h | 41 ++++++++++++++++++
>>   4 files changed, 160 insertions(+), 1 deletion(-)
>>   create mode 100644 hw/arm/axiado-boards.c
>>   create mode 100644 hw/arm/axiado-evk.c
>>   create mode 100644 include/hw/arm/axiado-boards.h
>>
>> +static const TypeInfo axiado_machine_types[] = {
>> +    {
>> +        .name          = TYPE_AXIADO_MACHINE,
>> +        .parent        = TYPE_MACHINE,
>> +        .instance_size = sizeof(AxiadoMachineState),
>> +        .class_size    = sizeof(AxiadoMachineClass),
>> +        .class_init    = axiado_machine_class_init,
>> +        .interfaces    = aarch64_machine_interfaces,
>> +        .abstract      = true,
>> +    }
>> +};
> Are we really going to have lots of Axiado machines such
> that we need all this machinery with an abstract base class?
> The simple thing is to define one machine that directly
> instantiates the SoC, etc.

Yes, I will create another axiado-scm3002 (maybe more) in future for our 
EVK support in QEMU

There are a little difference between these two EVKs

>> +DEFINE_TYPES(axiado_evk_types)
>> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
>> index c3c96c0a70..993a95d33a 100644
>> --- a/hw/arm/meson.build
>> +++ b/hw/arm/meson.build
>> @@ -106,7 +106,9 @@ arm_common_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
>>   arm_common_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
>>   arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
>>   arm_common_ss.add(when: ['CONFIG_AXIADO_SOC', 'TARGET_AARCH64'], if_true: files(
>> -  'axiado-soc.c'))
>> +  'axiado-soc.c',
>> +  'axiado-boards.c',
>> +  'axiado-evk.c'))
> Don't hook everything under a single KConfig symbol like this.
> You should generally speaking have separate Kconfig symbols for:
>   - each separate devices that is part of the SoC
>   - the SoC itself
>   - the board
>
> and the Kconfig stanza for the board says it needs the SoC,
> the SoC says it needs all the devices, and so on. The way
> we do the various imx6 boards is an example of this.
No problem, I will create two configs : one for Axiado SoCs, another for 
Axiado EVKs which select AXIADO_SOC by default
> thanks
> -- PMM

