Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF235CD98D6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 12:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXemM-00048P-GU; Thu, 11 Jun 2026 08:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wXemK-00047u-SI
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:45:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wXemG-0000Sc-3e
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:45:00 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BCT22O597959
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 12:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IyRx7dddZR8soh1Bmw+T08I6txzI0HxntV3J6GCJvVU=; b=L4m3ZKvBQ13XKQ0M
 fqwOXfj/k+Y2T3VdjC3DQ5WHXZBCs0KSavR6u8ZFKl1wivqlDw86WH/LNBi+J8mG
 d508qlKAo8/g5aZXP1SQy7g3lUZVJiXcofHQkTd32KOaeHtUVi08RyWrqhu6sHPD
 2uGfIGTPc9R6a1eCL9boScjtnO1E0X8e9DQQ9inMnPFn39OtVQFKQ8hXKwpyzXA/
 K9YS5zqTe1JhNVKeFokmQXOhNTxdy+/jX/5zIn47WwKPcxLMBpUzqRIdLJrYEMw9
 G90sIThfuPuO+vr4mfq3AcLhI4Bcxy3tJqtdWifvD6RN4ArvH3VNLItFR3ZaWjg/
 Aj9GEQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe71kh75-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 12:44:54 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-59ec5a8fed0so1197327e0c.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781181894; x=1781786694; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IyRx7dddZR8soh1Bmw+T08I6txzI0HxntV3J6GCJvVU=;
 b=Yz/lVFGfwpr/jPb/ly7325YAXX5pt7XrDYYdubRjY8Krihvvw9kfkJt0as+0ZFSOAH
 LrAv9MBOXvNjub/3aKCrKeK+cWC3diCgW00n8Z5rs2JMJFvSFBCo08SqAgY5fV7gTrGO
 ukK0e9Op9Su+WYONVL7iixDtkMasFcIq3wU0/3ADdmQ18SNiLqS6x9B7St80qJ0T6b1d
 W3ZMEjhEZbHEumIB+8kbZ5ntNoUPiW2LGX7U1qpKyGjO2lUjXx6ZSSl+FwWEMFtgY8fL
 EsUNHHgbpH7rIcjPMjqGgcv+/iPh42lGM1K07obO9N/ZOY6RMsNLP3ieJFsTF360NNS7
 kQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781181894; x=1781786694;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IyRx7dddZR8soh1Bmw+T08I6txzI0HxntV3J6GCJvVU=;
 b=iOVD/sXl52viy4oqBWpd1qEhmN9tgQKMXjwfiBFwZURNB7s7RYV1Lu5ZG7w+AP2cVA
 GVFU/s36dxdKjrhQ1wZK6eKlIx3pbtAD4gso3tIoIWNRkOgfiHw2ViUIVaszhRnn4WqF
 c47XKHxnSGif+UuHEz0fgr3n+WAm05fk+uGCmmR0mPKiwPe0MuEStfQKlFuulKYIN+HL
 //aE5WCROz1b5YNWSEso5m8ksRSSa2frKjE9+RpUxzPbKbEkKOFm5BwuejhOKxxVpqEG
 rR7jLavEvnrHg6/GU2Jjq66E/sy/jtQvuDJkdbeEH4TpuzxB7AsH77ivHBg6uLIztJ7k
 P1ZQ==
X-Gm-Message-State: AOJu0Yz4m6bkI8MsbPEAZ5h3gC44s6kVQz8xBapM297eJXPlCL6BPRX7
 v7CjBI4zPdVKouB3kmdRi7lvb+RyB3WY8+L7uOGLA5750iYS3DgMiyaDSF16CVWF/VcgXDhH7Og
 83cpMdwSf+N0zplCuaOnAxylPgyukpwkEUxIQfLll5foD5YKDbyBwpQmZhg==
X-Gm-Gg: Acq92OGJwgrI1llYNvUQbqqJo/kBYt33m5uLEwASU0xJOW9ka0vXqgEj72T814l1v4y
 vqhilJJTI8PjnHhWE4hgiJ9dJHRpzmiPq/DzioIhai1BG0iT3LLcdLDdtNk721piGkFpuxU0vFc
 tnJ/1c4HLdFHxI/Tb/KQzhuleSu+v7NVCnjlr6rOyey6pwJBc+4gdu8M6QmWNiGLaAKH2fVZB3r
 9A0i85+LfPKV2SxZuTvTH14aFvVMW+fzsQXDtlEc1u1uuRPKy0ma2tkNKcEvjkTRg1Qseil50LJ
 +JkYKLN6C4m0k4yhW1LoW3g82xNQVzCMRKyvw54fb6zvxaO6rKwm7Am11dDq/TkHSLqw02xOSoQ
 QvlUkkwvl7Oa3ZmamPRKzm8NxcOSFvOdyw6TnrBtLESSR0ouHkveVY3RzrrinoAxeAsp2MPc3E/
 GfC8NJyXLt+QUMZzCitwTVCj4Z
X-Received: by 2002:a05:6122:650b:b0:56b:942f:b870 with SMTP id
 71dfb90a1353d-5bad78a1a18mr564465e0c.0.1781181893790; 
 Thu, 11 Jun 2026 05:44:53 -0700 (PDT)
X-Received: by 2002:a05:6122:650b:b0:56b:942f:b870 with SMTP id
 71dfb90a1353d-5bad78a1a18mr564443e0c.0.1781181893035; 
 Thu, 11 Jun 2026 05:44:53 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc1:7652:1546:4c73:fb08:d27c?
 ([2804:7f0:bcc1:7652:1546:4c73:fb08:d27c])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-96662f838a0sm825368241.7.2026.06.11.05.44.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 05:44:52 -0700 (PDT)
Message-ID: <7fcabc0b-fa18-4a57-b629-5e2d899e1053@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 09:44:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/7] hw/riscv: server platform reference machine
To: sunilvl@oss.qualcomm.com
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, andrew.jones@oss.qualcomm.com,
 leif.lindholm@oss.qualcomm.com, uwu@icenowy.me,
 Fei Wu <wu.fei9@sanechips.com.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260610214133.1882563-1-daniel.barboza@oss.qualcomm.com>
 <20260610214133.1882563-4-daniel.barboza@oss.qualcomm.com>
 <CAB19ukF9mC52EzikZ4DOEd3YO-Ju-W1oKXrS2gVoc_p1UtLMuA@mail.gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAB19ukF9mC52EzikZ4DOEd3YO-Ju-W1oKXrS2gVoc_p1UtLMuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -ELwZWi6zjX5If8NgVzpguKpKAU_n_hg
X-Proofpoint-GUID: -ELwZWi6zjX5If8NgVzpguKpKAU_n_hg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEyOCBTYWx0ZWRfX7apmMJMt72CY
 m61sKG0R/wz72V3b66wSbvTS3WaJc5S8M4qj4vhOt6vhp1tPcr0cHqD2RDcvrKFHKpzVzGwIDHQ
 vgKjzNiAXq6q7CFRHUPrh3Q/02mDo0HfNyEM8k12RkdqWgx9mpdtjouFi7ZOxLcGM3AwCuoo8mL
 xhZ/eqWl5NCgqqPFKBW4CzYXaE1ghmHOTBqc5Yl9198D3KevmXLa+X3WmA7hiERjsXO8Uxdzc8d
 WCYDMrYNSOYGyrOAIbGqFfH3YWWbe0uytxsbWFDLX5Zdw+T+u6S340Nrw9CPphsopSL4krf2RP3
 oLJds3QVX5QyZ4As/1rPu/ntNOJqcjTT4vDXmNfqo6kp5UU51x9sE61mAtLBeJyf0K/6Q1r1SZA
 cSXt6n6X3xqw6DoiYvBHsCDlfz62bRjd6j4D2TQX0ijmjz4k++LwOIAQGVQJKaKPLd9DEnunMgW
 n6PsIHuEmoOpFI+a81g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEyOCBTYWx0ZWRfXypMpj13egsca
 +E8vTNE19aqmAG95k97n7VF/nrpniLcKk3aR+PYfUv2z4/YB5tUUSbSIejPataPX8/gnZHQH/0j
 W7HFpAQxJduEV7/u9QE1BWhNYQVYFcE=
X-Authority-Analysis: v=2.4 cv=Lf0MLDfi c=1 sm=1 tr=0 ts=6a2aadc7 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=uTRCLKPYAAAA:8 a=CFPHe31M92YfO3oGG5UA:9
 a=vEUFQiweiXs7-TW_:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22 a=T-agBWn15iSmxapsA1lH:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110128
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 6/11/2026 2:04 AM, Sunil V L wrote:
> On Thu, Jun 11, 2026 at 3:13 AM Daniel Henrique Barboza
> <daniel.barboza@oss.qualcomm.com> wrote:
>>
>> From: Fei Wu <wu.fei9@sanechips.com.cn>
>>
>> The RISC-V Server Platform specification [1] defines a standardized set
>> of hardware and software capabilities, that portable system software,
>> such as OS and hypervisors can rely on being present in a RISC-V server
>> platform.
>>
>> The main features included in this emulation are:
>>
>> - Based on riscv virt machine type;
>> - A new memory map as close as virt machine as possible;
>> - An always present IOMMU platform device (riscv-iommu-sys) that uses
>>    IRQs 36 to 39, one IRQ for queue, similar to the 'virt' board;
>> - AIA;
>> - PCIe AHCI;
>> - PCIe NIC;
>> - No virtio device;
>> - No fw_cfg device;
>> - No ACPI table provided;
>> - Only minimal device tree nodes.
>>
>> [1] https://github.com/riscv-non-isa/riscv-server-platform
>>
>> Signed-off-by: Fei Wu <wu.fei9@sanechips.com.cn>
>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> ---
>>   configs/devices/riscv64-softmmu/default.mak |    1 +
>>   hw/riscv/Kconfig                            |   15 +
>>   hw/riscv/meson.build                        |    1 +
>>   hw/riscv/server_platform_ref.c              | 1389 +++++++++++++++++++
>>   4 files changed, 1406 insertions(+)
>>   create mode 100644 hw/riscv/server_platform_ref.c
>>
>> diff --git a/configs/devices/riscv64-softmmu/default.mak b/configs/devices/riscv64-softmmu/default.mak
>> index a8e4d0ab33..ae3f62e2d4 100644
>> --- a/configs/devices/riscv64-softmmu/default.mak
>> +++ b/configs/devices/riscv64-softmmu/default.mak
>> @@ -9,6 +9,7 @@
>>   # CONFIG_SIFIVE_E=n
>>   # CONFIG_SIFIVE_U=n
>>   # CONFIG_RISCV_VIRT=n
>> +# CONFIG_RISCV_SERVER_PLATFORM_REF=n
>>   # CONFIG_MICROCHIP_PFSOC=n
>>   # CONFIG_SHAKTI_C=n
>>   # CONFIG_XIANGSHAN_KUNMINGHU=n
>> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
>> index 2518b04175..1807c423ff 100644
>> --- a/hw/riscv/Kconfig
>> +++ b/hw/riscv/Kconfig
>> @@ -69,6 +69,21 @@ config RISCV_VIRT
>>       select ACPI
>>       select ACPI_PCI
>>
>> +config RISCV_SERVER_PLATFORM_REF
>> +    bool
>> +    default y
>> +    depends on RISCV64
>> +    select RISCV_NUMA
>> +    select GOLDFISH_RTC
>> +    select PCI
>> +    select PCI_EXPRESS_GENERIC_BRIDGE
>> +    select PFLASH_CFI01
>> +    select SERIAL
>> +    select RISCV_ACLINT
>> +    select RISCV_APLIC
>> +    select RISCV_IMSIC
>> +    select RISCV_IOMMU
>> +
>>   config SHAKTI_C
>>       bool
>>       default y
>> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
>> index 533472e22a..74944cca84 100644
>> --- a/hw/riscv/meson.build
>> +++ b/hw/riscv/meson.build
>> @@ -4,6 +4,7 @@ riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
>>   riscv_ss.add(files('riscv_hart.c'))
>>   riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
>>   riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
>> +riscv_ss.add(when: 'CONFIG_RISCV_SERVER_PLATFORM_REF', if_true: files('server_platform_ref.c'))
>>   riscv_ss.add(when: 'CONFIG_SHAKTI_C', if_true: files('shakti_c.c'))
>>   riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
>>   riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
>> diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
>> new file mode 100644
>> index 0000000000..7e626c6eb7
>> --- /dev/null
>> +++ b/hw/riscv/server_platform_ref.c
>> @@ -0,0 +1,1389 @@
>> +/*
>> + * QEMU RISC-V Server Platform Reference Board (riscv-server-ref)
>> + *
>> + * Copyright (c) 2024 Intel, Inc.
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/units.h"
>> +#include "qemu/error-report.h"
>> +#include "qemu/guest-random.h"
>> +#include "qapi/error.h"
>> +#include "qapi/qapi-visit-common.h"
>> +#include "hw/core/boards.h"
>> +#include "hw/core/loader.h"
>> +#include "hw/core/sysbus.h"
>> +#include "hw/core/qdev-properties.h"
>> +#include "hw/char/serial.h"
>> +#include "hw/block/flash.h"
>> +#include "hw/ide/pci.h"
>> +#include "hw/ide/ahci-pci.h"
>> +#include "hw/pci/pci.h"
>> +#include "hw/pci-host/gpex.h"
>> +#include "hw/core/sysbus-fdt.h"
>> +#include "hw/riscv/riscv_hart.h"
>> +#include "hw/riscv/boot.h"
>> +#include "hw/riscv/machines-qom.h"
>> +#include "hw/riscv/numa.h"
>> +#include "hw/riscv/iommu.h"
>> +#include "hw/riscv/riscv-iommu-bits.h"
>> +#include "hw/intc/riscv_aclint.h"
>> +#include "hw/intc/riscv_aplic.h"
>> +#include "hw/intc/riscv_imsic.h"
>> +#include "chardev/char.h"
>> +#include "hw/char/serial-mm.h"
>> +#include "system/device_tree.h"
>> +#include "system/runstate.h"
>> +#include "system/system.h"
>> +#include "system/tcg.h"
>> +#include "system/qtest.h"
>> +#include "target/riscv/cpu.h"
>> +#include "target/riscv/pmu.h"
>> +#include "net/net.h"
>> +
>> +#define RVSERVER_CPUS_MAX_BITS             9
>> +#define RVSERVER_CPUS_MAX                  (1 << RVSERVER_CPUS_MAX_BITS)
>> +#define RVSERVER_SOCKETS_MAX_BITS          2
>> +#define RVSERVER_SOCKETS_MAX               (1 << RVSERVER_SOCKETS_MAX_BITS)
>> +
>> +#define RVSERVER_IRQCHIP_NUM_MSIS 255
>> +#define RVSERVER_IRQCHIP_NUM_SOURCES 96
>> +#define RVSERVER_IRQCHIP_NUM_PRIO_BITS 3
>> +#define RVSERVER_IRQCHIP_MAX_GUESTS_BITS 3
>> +#define RVSERVER_IRQCHIP_MAX_GUESTS \
>> +    ((1U << RVSERVER_IRQCHIP_MAX_GUESTS_BITS) - 1U)
>> +
>> +#define FDT_PCI_ADDR_CELLS    3
>> +#define FDT_PCI_INT_CELLS     1
>> +#define FDT_APLIC_INT_CELLS   2
>> +#define FDT_APLIC_ADDR_CELLS  0
>> +#define FDT_IMSIC_INT_CELLS   0
>> +#define FDT_MAX_INT_CELLS     2
>> +#define FDT_MAX_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
>> +                                 1 + FDT_MAX_INT_CELLS)
>> +#define FDT_APLIC_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + \
>> +                                 1 + FDT_APLIC_INT_CELLS)
>> +
>> +#define NUM_SATA_PORTS  6
>> +
>> +#define SYSCON_RESET     0x1
>> +#define SYSCON_POWEROFF  0x2
>> +
>> +#define TYPE_RISCV_SERVER_REF_MACHINE MACHINE_TYPE_NAME("riscv-server-ref")
>> +OBJECT_DECLARE_SIMPLE_TYPE(RISCVServerRefMachineState, RISCV_SERVER_REF_MACHINE)
>> +
>> +struct RISCVServerRefMachineState {
>> +    /*< private >*/
>> +    MachineState parent;
>> +
>> +    /*< public >*/
>> +    Notifier machine_done;
>> +    RISCVHartArrayState soc[RVSERVER_SOCKETS_MAX];
>> +    DeviceState *irqchip[RVSERVER_SOCKETS_MAX];
>> +    PFlashCFI01 *flash[2];
>> +
>> +    int fdt_size;
>> +    int aia_guests;
>> +    const MemMapEntry *memmap;
>> +};
>> +
>> +enum {
>> +    RVSERVER_DEBUG,
>> +    RVSERVER_MROM,
>> +    RVSERVER_RESET_SYSCON,
>> +    RVSERVER_RTC,
>> +    RVSERVER_IOMMU_SYS,
>> +    RVSERVER_ACLINT,
>> +    RVSERVER_APLIC_M,
>> +    RVSERVER_APLIC_S,
>> +    RVSERVER_UART0,
>> +    RVSERVER_IMSIC_M,
>> +    RVSERVER_IMSIC_S,
>> +    RVSERVER_FLASH,
>> +    RVSERVER_DRAM,
>> +    RVSERVER_PCIE_MMIO,
>> +    RVSERVER_PCIE_PIO,
>> +    RVSERVER_PCIE_ECAM,
>> +    RVSERVER_PCIE_MMIO_HIGH
>> +};
>> +
>> +enum {
>> +    RVSERVER_UART0_IRQ = 10,
>> +    RVSERVER_RTC_IRQ = 11,
>> +    RVSERVER_PCIE_IRQ = 0x20, /* 32 to 35 */
>> +    IOMMU_SYS_IRQ = 0x24 /* 36 to 39 */
>> +};
>> +
>> +/*
>> + * The server soc reference machine physical address space used by some of the
>> + * devices namely ACLINT, APLIC and IMSIC depend on number of Sockets, number
>> + * of CPUs, and number of IMSIC guest files.
>> + *
>> + * Various limits defined by RVSERVER_SOCKETS_MAX_BITS, RVSERVER_CPUS_MAX_BITS,
>> + * and RVSERVER_IRQCHIP_MAX_GUESTS_BITS are tuned for maximum utilization of
>> + * server reference machine physical address space.
>> + */
>> +
>> +#define RVSERVER_IMSIC_GROUP_MAX_SIZE      (1U << IMSIC_MMIO_GROUP_MIN_SHIFT)
>> +#if RVSERVER_IMSIC_GROUP_MAX_SIZE < \
>> +    IMSIC_GROUP_SIZE(RVSERVER_CPUS_MAX_BITS, RVSERVER_IRQCHIP_MAX_GUESTS_BITS)
>> +#error "Can't accomodate single IMSIC group in address space"
>> +#endif
>> +
>> +#define RVSERVER_IMSIC_MAX_SIZE            (RVSERVER_SOCKETS_MAX * \
>> +                                        RVSERVER_IMSIC_GROUP_MAX_SIZE)
>> +#if 0x4000000 < RVSERVER_IMSIC_MAX_SIZE
>> +#error "Can't accomodate all IMSIC groups in address space"
>> +#endif
>> +
>> +static const MemMapEntry rvserver_ref_memmap[] = {
>> +    [RVSERVER_DEBUG] =          {        0x0,         0x100 },
>> +    [RVSERVER_MROM] =           {     0x1000,        0xf000 },
>> +    [RVSERVER_RESET_SYSCON] =   {   0x100000,        0x1000 },
>> +    [RVSERVER_RTC] =            {   0x101000,        0x1000 },
>> +    [RVSERVER_IOMMU_SYS] =      {   0x102000,        0x1000 },
>> +    [RVSERVER_ACLINT] =         {  0x2000000,       0x10000 },
>> +    [RVSERVER_PCIE_PIO] =       {  0x3000000,       0x10000 },
>> +    [RVSERVER_APLIC_M] =        {  0xc000000, APLIC_SIZE(RVSERVER_CPUS_MAX) },
>> +    [RVSERVER_APLIC_S] =        {  0xd000000, APLIC_SIZE(RVSERVER_CPUS_MAX) },
>> +    [RVSERVER_UART0] =          { 0x10000000,         0x100 },
>> +    [RVSERVER_FLASH] =          { 0x20000000,     0x4000000 },
>> +    [RVSERVER_IMSIC_M] =        { 0x24000000, RVSERVER_IMSIC_MAX_SIZE },
>> +    [RVSERVER_IMSIC_S] =        { 0x28000000, RVSERVER_IMSIC_MAX_SIZE },
>> +    [RVSERVER_PCIE_ECAM] =      { 0x30000000,    0x10000000 },
>> +    [RVSERVER_PCIE_MMIO] =      { 0x40000000,    0x40000000 },
>> +    [RVSERVER_DRAM] =           { 0x80000000, 0xff80000000ull },
>> +    [RVSERVER_PCIE_MMIO_HIGH] = { 0x10000000000ull, 0x10000000000ull },
>> +};
>> +
>> +#define RVSERVER_FLASH_SECTOR_SIZE (256 * KiB)
>> +
>> +static PFlashCFI01 *rvserver_flash_create(RISCVServerRefMachineState *s,
>> +                                          const char *name,
>> +                                          const char *alias_prop_name)
>> +{
>> +    /*
>> +     * Create a single flash device.  We use the same parameters as
>> +     * the flash devices on the ARM virt board.
>> +     */
>>
> It should be RISC-V virt. But can we add SD option as well along with flash?
> 
>> +    DeviceState *dev = qdev_new(TYPE_PFLASH_CFI01);
>> +
>> +    qdev_prop_set_uint64(dev, "sector-length", RVSERVER_FLASH_SECTOR_SIZE);
>> +    qdev_prop_set_uint8(dev, "width", 4);
>> +    qdev_prop_set_uint8(dev, "device-width", 2);
>> +    qdev_prop_set_bit(dev, "big-endian", false);
>> +    qdev_prop_set_uint16(dev, "id0", 0x89);
>> +    qdev_prop_set_uint16(dev, "id1", 0x18);
>> +    qdev_prop_set_uint16(dev, "id2", 0x00);
>> +    qdev_prop_set_uint16(dev, "id3", 0x00);
>> +    qdev_prop_set_string(dev, "name", name);
>> +
>> +    object_property_add_child(OBJECT(s), name, OBJECT(dev));
>> +    object_property_add_alias(OBJECT(s), alias_prop_name,
>> +                              OBJECT(dev), "drive");
>> +
>> +    return PFLASH_CFI01(dev);
>> +}
>> +
>> +static void rvserver_flash_map(PFlashCFI01 *flash,
>> +                               hwaddr base, hwaddr size,
>> +                               MemoryRegion *sysmem)
>> +{
>> +    DeviceState *dev = DEVICE(flash);
>> +
>> +    assert(QEMU_IS_ALIGNED(size, RVSERVER_FLASH_SECTOR_SIZE));
>> +    assert(size / RVSERVER_FLASH_SECTOR_SIZE <= UINT32_MAX);
>> +    qdev_prop_set_uint32(dev, "num-blocks", size / RVSERVER_FLASH_SECTOR_SIZE);
>> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>> +
>> +    memory_region_add_subregion(sysmem, base,
>> +                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
>> +                                                       0));
>> +}
>> +
>> +static void rvserver_flash_maps(RISCVServerRefMachineState *s,
>> +                                MemoryRegion *sysmem)
>> +{
>> +    hwaddr flashsize = rvserver_ref_memmap[RVSERVER_FLASH].size / 2;
>> +    hwaddr flashbase = rvserver_ref_memmap[RVSERVER_FLASH].base;
>> +
>> +    rvserver_flash_map(s->flash[0], flashbase, flashsize, sysmem);
>> +    rvserver_flash_map(s->flash[1], flashbase + flashsize, flashsize, sysmem);
>> +}
>> +
>> +static void create_pcie_irq_map(RISCVServerRefMachineState *s,
>> +                                void *fdt, char *nodename,
>> +                                uint32_t irqchip_phandle)
>> +{
>> +    int pin, dev;
>> +    uint32_t irq_map_stride = 0;
>> +    uint32_t full_irq_map[PCI_NUM_PINS * PCI_NUM_PINS *
>> +                          FDT_MAX_INT_MAP_WIDTH] = {};
>> +    uint32_t *irq_map = full_irq_map;
>> +
>> +    /*
>> +     * This code creates a standard swizzle of interrupts such that
>> +     * each device's first interrupt is based on it's PCI_SLOT number.
>> +     * (See pci_swizzle_map_irq_fn())
>> +     *
>> +     * We only need one entry per interrupt in the table (not one per
>> +     * possible slot) seeing the interrupt-map-mask will allow the table
>> +     * to wrap to any number of devices.
>> +     */
>> +    for (dev = 0; dev < PCI_NUM_PINS; dev++) {
>> +        int devfn = dev * 0x8;
>> +
>> +        for (pin = 0; pin < PCI_NUM_PINS; pin++) {
>> +            int irq_nr = RVSERVER_PCIE_IRQ +
>> +                         ((pin + PCI_SLOT(devfn)) % PCI_NUM_PINS);
>> +            int i = 0;
>> +
>> +            /* Fill PCI address cells */
>> +            irq_map[i] = cpu_to_be32(devfn << 8);
>> +            i += FDT_PCI_ADDR_CELLS;
>> +
>> +            /* Fill PCI Interrupt cells */
>> +            irq_map[i] = cpu_to_be32(pin + 1);
>> +            i += FDT_PCI_INT_CELLS;
>> +
>> +            /* Fill interrupt controller phandle and cells */
>> +            irq_map[i++] = cpu_to_be32(irqchip_phandle);
>> +            irq_map[i++] = cpu_to_be32(irq_nr);
>> +            irq_map[i++] = cpu_to_be32(0x4);
>> +
>> +            if (!irq_map_stride) {
>> +                irq_map_stride = i;
>> +            }
>> +            irq_map += irq_map_stride;
>> +        }
>> +    }
>> +
>> +    qemu_fdt_setprop(fdt, nodename, "interrupt-map", full_irq_map,
>> +                     PCI_NUM_PINS * PCI_NUM_PINS *
>> +                     irq_map_stride * sizeof(uint32_t));
>> +
>> +    qemu_fdt_setprop_cells(fdt, nodename, "interrupt-map-mask",
>> +                           0x1800, 0, 0, 0x7);
>> +}
>> +
>> +static void create_fdt_socket_cpus(RISCVServerRefMachineState *s, int socket,
>> +                                   char *clust_name, uint32_t *phandle,
>> +                                   uint32_t *intc_phandles)
>> +{
>> +    int cpu;
>> +    uint32_t cpu_phandle;
>> +    MachineState *ms = MACHINE(s);
>> +    bool is_32_bit = riscv_is_32bit(&s->soc[0]);
>>
> Do we need this given the reference platform should adhere to RVA23S64?

Nope.  This is a reminant from the copy/pasting we did from virt.c.

And following up on your other comments here: I am also not please with the
amonut of repetition going on, in particular with FDT functions, something
that I nagged about it last year or so.

I was postponing this cleanup for the next QEMU release but I think it's getting
annoying to deal with all the repetitive boilerplate code that we have to deal
with, let alone in the downstream boards that we use internally for proprietary
work.

Guess it's time to do something about it.  I'll see what I can do.


Thanks,
Daniel

> 
>> +    int8_t satp_mode_max;
>> +
>> +    for (cpu = s->soc[socket].num_harts - 1; cpu >= 0; cpu--) {
>> +        RISCVCPU *cpu_ptr = &s->soc[socket].harts[cpu];
>> +        satp_mode_max = cpu_ptr->cfg.max_satp_mode;
>> +        g_autofree char *cpu_name = NULL;
>> +        g_autofree char *core_name = NULL;
>> +        g_autofree char *intc_name = NULL;
>> +        g_autofree char *sv_name = NULL;
>> +
>> +        cpu_phandle = (*phandle)++;
>> +
>> +        cpu_name = g_strdup_printf("/cpus/cpu@%d",
>> +            s->soc[socket].hartid_base + cpu);
>> +        qemu_fdt_add_subnode(ms->fdt, cpu_name);
>> +
>> +        if (satp_mode_max != -1) {
>> +            sv_name = g_strdup_printf("riscv,%s",
>> +                                      satp_mode_str(satp_mode_max, is_32_bit));
>> +            qemu_fdt_setprop_string(ms->fdt, cpu_name, "mmu-type", sv_name);
>> +        }
>> +
>> +        riscv_isa_write_fdt(cpu_ptr, ms->fdt, cpu_name);
>> +
>> +        if (cpu_ptr->cfg.ext_zicbom) {
>> +            qemu_fdt_setprop_cell(ms->fdt, cpu_name, "riscv,cbom-block-size",
>> +                                  cpu_ptr->cfg.cbom_blocksize);
>> +        }
>> +
>> +        if (cpu_ptr->cfg.ext_zicboz) {
>> +            qemu_fdt_setprop_cell(ms->fdt, cpu_name, "riscv,cboz-block-size",
>> +                                  cpu_ptr->cfg.cboz_blocksize);
>> +        }
>> +
>> +        if (cpu_ptr->cfg.ext_zicbop) {
>> +            qemu_fdt_setprop_cell(ms->fdt, cpu_name, "riscv,cbop-block-size",
>> +                                  cpu_ptr->cfg.cbop_blocksize);
>> +        }
>> +
>> +        qemu_fdt_setprop_string(ms->fdt, cpu_name, "compatible", "riscv");
>> +        qemu_fdt_setprop_string(ms->fdt, cpu_name, "status", "okay");
>> +        qemu_fdt_setprop_cell(ms->fdt, cpu_name, "reg",
>> +            s->soc[socket].hartid_base + cpu);
>> +        qemu_fdt_setprop_string(ms->fdt, cpu_name, "device_type", "cpu");
>> +        riscv_socket_fdt_write_id(ms, cpu_name, socket);
>> +        qemu_fdt_setprop_cell(ms->fdt, cpu_name, "phandle", cpu_phandle);
>> +
>> +        intc_phandles[cpu] = (*phandle)++;
>> +
>> +        intc_name = g_strdup_printf("%s/interrupt-controller", cpu_name);
>> +        qemu_fdt_add_subnode(ms->fdt, intc_name);
>> +        qemu_fdt_setprop_cell(ms->fdt, intc_name, "phandle",
>> +            intc_phandles[cpu]);
>> +        qemu_fdt_setprop_string(ms->fdt, intc_name, "compatible",
>> +            "riscv,cpu-intc");
>> +        qemu_fdt_setprop(ms->fdt, intc_name, "interrupt-controller", NULL, 0);
>> +        qemu_fdt_setprop_cell(ms->fdt, intc_name, "#interrupt-cells", 1);
>> +
>> +        core_name = g_strdup_printf("%s/core%d", clust_name, cpu);
>> +        qemu_fdt_add_subnode(ms->fdt, core_name);
>> +        qemu_fdt_setprop_cell(ms->fdt, core_name, "cpu", cpu_phandle);
>> +    }
>> +}
>> +
>> +static void create_fdt_socket_memory(RISCVServerRefMachineState *s,
>> +                                     const MemMapEntry *memmap, int socket)
>> +{
>> +    g_autofree char *mem_name = NULL;
>> +    hwaddr addr, size;
>> +    MachineState *ms = MACHINE(s);
>> +
>> +    addr = memmap[RVSERVER_DRAM].base + riscv_socket_mem_offset(ms, socket);
>> +    size = riscv_socket_mem_size(ms, socket);
>> +    mem_name = g_strdup_printf("/memory@%"HWADDR_PRIx, addr);
>> +    qemu_fdt_add_subnode(ms->fdt, mem_name);
>> +    qemu_fdt_setprop_cells(ms->fdt, mem_name, "reg",
>> +        addr >> 32, addr, size >> 32, size);
>> +    qemu_fdt_setprop_string(ms->fdt, mem_name, "device_type", "memory");
>> +    riscv_socket_fdt_write_id(ms, mem_name, socket);
>> +}
>> +
>> +static void create_fdt_socket_aclint(RISCVServerRefMachineState *s,
>> +                                     const MemMapEntry *memmap, int socket,
>> +                                     uint32_t *intc_phandles)
>> +{
>> +    int cpu;
>> +    g_autofree char *name = NULL;
>> +    hwaddr addr, size;
>> +    uint32_t aclint_cells_size;
>> +    g_autofree uint32_t *aclint_mtimer_cells = NULL;
>> +    MachineState *ms = MACHINE(s);
>> +
>> +    aclint_mtimer_cells = g_new0(uint32_t, s->soc[socket].num_harts * 2);
>> +
>> +    for (cpu = 0; cpu < s->soc[socket].num_harts; cpu++) {
>> +        aclint_mtimer_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
>> +        aclint_mtimer_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_M_TIMER);
>> +    }
>> +    aclint_cells_size = s->soc[socket].num_harts * sizeof(uint32_t) * 2;
>> +
>> +    addr = memmap[RVSERVER_ACLINT].base +
>> +           RISCV_ACLINT_DEFAULT_MTIMER_SIZE * socket;
>> +    size = RISCV_ACLINT_DEFAULT_MTIMER_SIZE;
>> +
>> +    name = g_strdup_printf("/soc/mtimer@%"HWADDR_PRIx, addr);
>> +    qemu_fdt_add_subnode(ms->fdt, name);
>> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible",
>> +        "riscv,aclint-mtimer");
>> +    qemu_fdt_setprop_cells(ms->fdt, name, "reg",
>> +        0x0, addr + RISCV_ACLINT_DEFAULT_MTIME,
>> +        0x0, size - RISCV_ACLINT_DEFAULT_MTIME,
>> +        0x0, addr + RISCV_ACLINT_DEFAULT_MTIMECMP,
>> +        0x0, RISCV_ACLINT_DEFAULT_MTIME);
>> +    qemu_fdt_setprop(ms->fdt, name, "interrupts-extended",
>> +        aclint_mtimer_cells, aclint_cells_size);
>> +    riscv_socket_fdt_write_id(ms, name, socket);
>> +}
>> +
>> +static uint32_t imsic_num_bits(uint32_t count)
>>
> Can we make this API common so that it is not required to duplicate in
> each platform?
> 
>> +{
>> +    uint32_t ret = 0;
>> +
>> +    while (BIT(ret) < count) {
>> +        ret++;
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static void create_fdt_one_imsic(RISCVServerRefMachineState *s,
>> +                                 hwaddr base_addr,
>> +                                 uint32_t *intc_phandles,
>> +                                 uint32_t msi_phandle,
>> +                                 bool m_mode, uint32_t imsic_guest_bits)
>> +{
>> +    int cpu, socket;
>> +    g_autofree char *imsic_name = NULL;
>> +    MachineState *ms = MACHINE(s);
>> +    int socket_count = riscv_socket_count(ms);
>> +    uint32_t imsic_max_hart_per_socket, imsic_addr, imsic_size;
>> +    g_autofree uint32_t *imsic_cells = NULL;
>> +    g_autofree uint32_t *imsic_regs = NULL;
>> +    static const char * const imsic_compat[2] = {
>> +        "qemu,imsics", "riscv,imsics"
>> +    };
>> +
>> +    imsic_cells = g_new0(uint32_t, ms->smp.cpus * 2);
>> +    imsic_regs = g_new0(uint32_t, socket_count * 4);
>> +
>> +    for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
>> +        imsic_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
>> +        imsic_cells[cpu * 2 + 1] = cpu_to_be32(m_mode ? IRQ_M_EXT : IRQ_S_EXT);
>> +    }
>> +
>> +    imsic_max_hart_per_socket = 0;
>> +    for (socket = 0; socket < socket_count; socket++) {
>> +        imsic_addr = base_addr + socket * RVSERVER_IMSIC_GROUP_MAX_SIZE;
>> +        imsic_size = IMSIC_HART_SIZE(imsic_guest_bits) *
>> +                     s->soc[socket].num_harts;
>> +        imsic_regs[socket * 4 + 0] = 0;
>> +        imsic_regs[socket * 4 + 1] = cpu_to_be32(imsic_addr);
>> +        imsic_regs[socket * 4 + 2] = 0;
>> +        imsic_regs[socket * 4 + 3] = cpu_to_be32(imsic_size);
>> +        if (imsic_max_hart_per_socket < s->soc[socket].num_harts) {
>> +            imsic_max_hart_per_socket = s->soc[socket].num_harts;
>> +        }
>> +    }
>> +
>> +    imsic_name = g_strdup_printf("/soc/interrupt-controller@%lx",
>> +                                 (unsigned long)base_addr);
>> +    qemu_fdt_add_subnode(ms->fdt, imsic_name);
>> +    qemu_fdt_setprop_string_array(ms->fdt, imsic_name, "compatible",
>> +                                  (char **)&imsic_compat,
>> +                                  ARRAY_SIZE(imsic_compat));
>> +
>> +    qemu_fdt_setprop_cell(ms->fdt, imsic_name, "#interrupt-cells",
>> +                          FDT_IMSIC_INT_CELLS);
>> +    qemu_fdt_setprop(ms->fdt, imsic_name, "interrupt-controller", NULL, 0);
>> +    qemu_fdt_setprop(ms->fdt, imsic_name, "msi-controller", NULL, 0);
>> +    qemu_fdt_setprop(ms->fdt, imsic_name, "interrupts-extended",
>> +                     imsic_cells, ms->smp.cpus * sizeof(uint32_t) * 2);
>> +    qemu_fdt_setprop(ms->fdt, imsic_name, "reg", imsic_regs,
>> +                     socket_count * sizeof(uint32_t) * 4);
>> +    qemu_fdt_setprop_cell(ms->fdt, imsic_name, "riscv,num-ids",
>> +                          RVSERVER_IRQCHIP_NUM_MSIS);
>> +
>> +    if (imsic_guest_bits) {
>> +        qemu_fdt_setprop_cell(ms->fdt, imsic_name, "riscv,guest-index-bits",
>> +                              imsic_guest_bits);
>> +    }
>> +
>> +    if (socket_count > 1) {
>> +        qemu_fdt_setprop_cell(ms->fdt, imsic_name, "riscv,hart-index-bits",
>> +                              imsic_num_bits(imsic_max_hart_per_socket));
>> +        qemu_fdt_setprop_cell(ms->fdt, imsic_name, "riscv,group-index-bits",
>> +                              imsic_num_bits(socket_count));
>> +        qemu_fdt_setprop_cell(ms->fdt, imsic_name, "riscv,group-index-shift",
>> +                              IMSIC_MMIO_GROUP_MIN_SHIFT);
>> +    }
>> +    qemu_fdt_setprop_cell(ms->fdt, imsic_name, "phandle", msi_phandle);
>> +}
>> +
>> +static void create_fdt_imsic(RISCVServerRefMachineState *s,
>> +                             const MemMapEntry *memmap,
>> +                             uint32_t *phandle, uint32_t *intc_phandles,
>> +                             uint32_t *msi_m_phandle, uint32_t *msi_s_phandle)
>> +{
>> +    *msi_m_phandle = (*phandle)++;
>> +    *msi_s_phandle = (*phandle)++;
>> +
>> +    /* M-level IMSIC node */
>> +    create_fdt_one_imsic(s, memmap[RVSERVER_IMSIC_M].base, intc_phandles,
>> +                         *msi_m_phandle, true, 0);
>> +
>> +    /* S-level IMSIC node */
>> +    create_fdt_one_imsic(s, memmap[RVSERVER_IMSIC_S].base, intc_phandles,
>> +                         *msi_s_phandle, false,
>> +                         imsic_num_bits(s->aia_guests + 1));
>> +
>> +}
>> +
>> +/* Caller must free string after use.  Copied from hw/riscv/virt.c.  */
>> +static char *fdt_get_aplic_nodename(unsigned long aplic_addr)
>> +{
>> +    return g_strdup_printf("/soc/interrupt-controller@%lx", aplic_addr);
>> +}
>> +
>> +static void create_fdt_one_aplic(RISCVServerRefMachineState *s, int socket,
>> +                                 unsigned long aplic_addr, uint32_t aplic_size,
>> +                                 uint32_t msi_phandle,
>> +                                 uint32_t *intc_phandles,
>> +                                 uint32_t aplic_phandle,
>> +                                 uint32_t aplic_child_phandle,
>> +                                 bool m_mode, int num_harts)
>> +{
>> +    int cpu;
>> +    g_autofree char *aplic_name = fdt_get_aplic_nodename(aplic_addr);
>> +    g_autofree uint32_t *aplic_cells = g_new0(uint32_t, num_harts * 2);
>> +    MachineState *ms = MACHINE(s);
>> +    static const char * const aplic_compat[2] = {
>> +        "qemu,aplic", "riscv,aplic"
>> +    };
>> +
>> +    for (cpu = 0; cpu < num_harts; cpu++) {
>> +        aplic_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
>> +        aplic_cells[cpu * 2 + 1] = cpu_to_be32(m_mode ? IRQ_M_EXT : IRQ_S_EXT);
>> +    }
>> +
>> +    qemu_fdt_add_subnode(ms->fdt, aplic_name);
>> +    qemu_fdt_setprop_string_array(ms->fdt, aplic_name, "compatible",
>> +                                  (char **)&aplic_compat,
>> +                                  ARRAY_SIZE(aplic_compat));
>> +    qemu_fdt_setprop_cell(ms->fdt, aplic_name, "#address-cells",
>> +                          FDT_APLIC_ADDR_CELLS);
>> +    qemu_fdt_setprop_cell(ms->fdt, aplic_name,
>> +                          "#interrupt-cells", FDT_APLIC_INT_CELLS);
>> +    qemu_fdt_setprop(ms->fdt, aplic_name, "interrupt-controller", NULL, 0);
>> +
>> +    qemu_fdt_setprop_cell(ms->fdt, aplic_name, "msi-parent", msi_phandle);
>> +
>> +    qemu_fdt_setprop_cells(ms->fdt, aplic_name, "reg",
>> +                           0x0, aplic_addr, 0x0, aplic_size);
>> +    qemu_fdt_setprop_cell(ms->fdt, aplic_name, "riscv,num-sources",
>> +                          RVSERVER_IRQCHIP_NUM_SOURCES);
>> +
>> +    if (aplic_child_phandle) {
>> +        qemu_fdt_setprop_cell(ms->fdt, aplic_name, "riscv,children",
>> +                              aplic_child_phandle);
>> +        qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegate",
>> +                               aplic_child_phandle, 0x1,
>> +                               RVSERVER_IRQCHIP_NUM_SOURCES);
>> +    }
>> +
>> +    riscv_socket_fdt_write_id(ms, aplic_name, socket);
>> +    qemu_fdt_setprop_cell(ms->fdt, aplic_name, "phandle", aplic_phandle);
>> +}
>> +
>> +static void create_fdt_socket_aplic(RISCVServerRefMachineState *s,
>> +                                    const MemMapEntry *memmap, int socket,
>> +                                    uint32_t msi_m_phandle,
>> +                                    uint32_t msi_s_phandle,
>> +                                    uint32_t *phandle,
>> +                                    uint32_t *intc_phandles,
>> +                                    uint32_t *aplic_phandles,
>> +                                    int num_harts)
>> +{
>> +    unsigned long aplic_addr;
>> +    uint32_t aplic_m_phandle, aplic_s_phandle;
>> +
>> +    aplic_m_phandle = (*phandle)++;
>> +    aplic_s_phandle = (*phandle)++;
>> +
>> +    /* M-level APLIC node */
>> +    aplic_addr = memmap[RVSERVER_APLIC_M].base +
>> +                 memmap[RVSERVER_APLIC_M].size * socket;
>> +    create_fdt_one_aplic(s, socket, aplic_addr, memmap[RVSERVER_APLIC_M].size,
>> +                         msi_m_phandle, intc_phandles,
>> +                         aplic_m_phandle, aplic_s_phandle,
>> +                         true, num_harts);
>> +
>> +    /* S-level APLIC node */
>> +    aplic_addr = memmap[RVSERVER_APLIC_S].base +
>> +                 memmap[RVSERVER_APLIC_S].size * socket;
>> +    create_fdt_one_aplic(s, socket, aplic_addr, memmap[RVSERVER_APLIC_S].size,
>> +                         msi_s_phandle, intc_phandles,
>> +                         aplic_s_phandle, 0,
>> +                         false, num_harts);
>> +
>> +    aplic_phandles[socket] = aplic_s_phandle;
>> +}
>> +
>> +static void create_fdt_pmu(RISCVServerRefMachineState *s)
>> +{
>> +    g_autofree char *pmu_name = g_strdup_printf("/pmu");
>> +    MachineState *ms = MACHINE(s);
>> +    RISCVCPU *hart = &s->soc[0].harts[0];
>> +
>> +    qemu_fdt_add_subnode(ms->fdt, pmu_name);
>> +    qemu_fdt_setprop_string(ms->fdt, pmu_name, "compatible", "riscv,pmu");
>> +    riscv_pmu_generate_fdt_node(ms->fdt, hart->pmu_avail_ctrs, pmu_name);
>> +}
>> +
>> +static void create_fdt_sockets(RISCVServerRefMachineState *s,
>> +                               const MemMapEntry *memmap,
>> +                               uint32_t *phandle,
>> +                               uint32_t *irq_mmio_phandle,
>> +                               uint32_t *irq_pcie_phandle,
>> +                               uint32_t *msi_pcie_phandle)
>> +{
>> +    int socket, phandle_pos;
>> +    MachineState *ms = MACHINE(s);
>> +    uint32_t msi_m_phandle = 0, msi_s_phandle = 0;
>> +    uint32_t xplic_phandles[MAX_NODES];
>> +    g_autofree uint32_t *intc_phandles = NULL;
>> +    int socket_count = riscv_socket_count(ms);
>> +
>> +    qemu_fdt_add_subnode(ms->fdt, "/cpus");
>> +    qemu_fdt_setprop_cell(ms->fdt, "/cpus", "timebase-frequency",
>> +                          RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
>> +    qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#size-cells", 0x0);
>> +    qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#address-cells", 0x1);
>> +    qemu_fdt_add_subnode(ms->fdt, "/cpus/cpu-map");
>> +
>> +    intc_phandles = g_new0(uint32_t, ms->smp.cpus);
>> +
>> +    phandle_pos = ms->smp.cpus;
>> +    for (socket = (socket_count - 1); socket >= 0; socket--) {
>> +        g_autofree char *clust_name = NULL;
>> +        phandle_pos -= s->soc[socket].num_harts;
>> +
>> +        clust_name = g_strdup_printf("/cpus/cpu-map/cluster%d", socket);
>> +        qemu_fdt_add_subnode(ms->fdt, clust_name);
>> +
>> +        create_fdt_socket_cpus(s, socket, clust_name, phandle,
>> +                               &intc_phandles[phandle_pos]);
>> +
>> +        create_fdt_socket_memory(s, memmap, socket);
>> +
>> +        create_fdt_socket_aclint(s, memmap, socket,
>> +            &intc_phandles[phandle_pos]);
>> +    }
>> +
>> +    create_fdt_imsic(s, memmap, phandle, intc_phandles,
>> +        &msi_m_phandle, &msi_s_phandle);
>> +    *msi_pcie_phandle = msi_s_phandle;
>> +
>> +    phandle_pos = ms->smp.cpus;
>> +    for (socket = (socket_count - 1); socket >= 0; socket--) {
>> +        phandle_pos -= s->soc[socket].num_harts;
>> +
>> +        create_fdt_socket_aplic(s, memmap, socket,
>> +                                msi_m_phandle, msi_s_phandle, phandle,
>> +                                &intc_phandles[phandle_pos],
>> +                                xplic_phandles,
>> +                                s->soc[socket].num_harts);
>> +    }
>> +
>> +    for (socket = 0; socket < socket_count; socket++) {
>> +        if (socket == 0) {
>> +            *irq_mmio_phandle = xplic_phandles[socket];
>> +            *irq_pcie_phandle = xplic_phandles[socket];
>> +        }
>> +        if (socket == 1) {
>> +            *irq_pcie_phandle = xplic_phandles[socket];
>> +        }
>> +    }
>> +
>> +    riscv_socket_fdt_write_distance_matrix(ms);
>> +}
>> +
>> +static void create_fdt_iommu_sys(RISCVServerRefMachineState *s,
>> +                                 uint32_t irq_chip,
>> +                                 uint32_t msi_phandle,
>> +                                 uint32_t *iommu_sys_phandle)
>> +{
>> +    const char comp[] = "riscv,iommu";
>> +    void *fdt = MACHINE(s)->fdt;
>> +    uint32_t iommu_phandle;
>> +    g_autofree char *iommu_node = NULL;
>> +    hwaddr addr = s->memmap[RVSERVER_IOMMU_SYS].base;
>> +    hwaddr size = s->memmap[RVSERVER_IOMMU_SYS].size;
>> +    uint32_t iommu_irq_map[RISCV_IOMMU_INTR_COUNT] = {
>> +        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_CQ,
>> +        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_FQ,
>> +        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_PM,
>> +        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_PQ,
>> +    };
>> +
>> +    iommu_node = g_strdup_printf("/soc/iommu@%"HWADDR_PRIx,
>> +                                 s->memmap[RVSERVER_IOMMU_SYS].base);
>> +    iommu_phandle = qemu_fdt_alloc_phandle(fdt);
>> +    qemu_fdt_add_subnode(fdt, iommu_node);
>> +
>> +    qemu_fdt_setprop(fdt, iommu_node, "compatible", comp, sizeof(comp));
>> +    qemu_fdt_setprop_cell(fdt, iommu_node, "#iommu-cells", 1);
>> +    qemu_fdt_setprop_cell(fdt, iommu_node, "phandle", iommu_phandle);
>> +
>> +    qemu_fdt_setprop_cells(fdt, iommu_node, "reg",
>> +                           addr >> 32, addr, size >> 32, size);
>> +    qemu_fdt_setprop_cell(fdt, iommu_node, "interrupt-parent", irq_chip);
>> +
>> +    qemu_fdt_setprop_cells(fdt, iommu_node, "interrupts",
>> +        iommu_irq_map[0], FDT_IRQ_TYPE_EDGE_LOW,
>> +        iommu_irq_map[1], FDT_IRQ_TYPE_EDGE_LOW,
>> +        iommu_irq_map[2], FDT_IRQ_TYPE_EDGE_LOW,
>> +        iommu_irq_map[3], FDT_IRQ_TYPE_EDGE_LOW);
>> +
>> +    qemu_fdt_setprop_cell(fdt, iommu_node, "msi-parent", msi_phandle);
>> +
>> +    *iommu_sys_phandle = iommu_phandle;
>> +}
>> +
>> +static void create_fdt_pcie(RISCVServerRefMachineState *s,
>> +                            const MemMapEntry *memmap,
>> +                            uint32_t irq_pcie_phandle,
>> +                            uint32_t msi_pcie_phandle,
>> +                            uint32_t iommu_sys_phandle)
>> +{
>> +    g_autofree char *name = NULL;
>> +    MachineState *ms = MACHINE(s);
>> +
>> +    name = g_strdup_printf("/soc/pci@%"HWADDR_PRIx,
>> +                           memmap[RVSERVER_PCIE_ECAM].base);
>> +    qemu_fdt_add_subnode(ms->fdt, name);
>> +    qemu_fdt_setprop_cell(ms->fdt, name, "#address-cells",
>> +        FDT_PCI_ADDR_CELLS);
>> +    qemu_fdt_setprop_cell(ms->fdt, name, "#interrupt-cells",
>> +        FDT_PCI_INT_CELLS);
>> +    qemu_fdt_setprop_cell(ms->fdt, name, "#size-cells", 0x2);
>> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible",
>> +        "pci-host-ecam-generic");
>> +    qemu_fdt_setprop_string(ms->fdt, name, "device_type", "pci");
>> +    qemu_fdt_setprop_cell(ms->fdt, name, "linux,pci-domain", 0);
>> +    qemu_fdt_setprop_cells(ms->fdt, name, "bus-range", 0,
>> +        memmap[RVSERVER_PCIE_ECAM].size / PCIE_MMCFG_SIZE_MIN - 1);
>> +    qemu_fdt_setprop(ms->fdt, name, "dma-coherent", NULL, 0);
>> +    qemu_fdt_setprop_cell(ms->fdt, name, "msi-parent", msi_pcie_phandle);
>> +    qemu_fdt_setprop_cells(ms->fdt, name, "reg", 0,
>> +        memmap[RVSERVER_PCIE_ECAM].base, 0, memmap[RVSERVER_PCIE_ECAM].size);
>> +    qemu_fdt_setprop_sized_cells(ms->fdt, name, "ranges",
>> +        1, FDT_PCI_RANGE_IOPORT, 2, 0,
>> +        2, memmap[RVSERVER_PCIE_PIO].base, 2, memmap[RVSERVER_PCIE_PIO].size,
>> +        1, FDT_PCI_RANGE_MMIO,
>> +        2, memmap[RVSERVER_PCIE_MMIO].base,
>> +        2, memmap[RVSERVER_PCIE_MMIO].base, 2, memmap[RVSERVER_PCIE_MMIO].size,
>> +        1, FDT_PCI_RANGE_MMIO_64BIT,
>> +        2, memmap[RVSERVER_PCIE_MMIO_HIGH].base,
>> +        2, memmap[RVSERVER_PCIE_MMIO_HIGH].base, 2,
>> +           memmap[RVSERVER_PCIE_MMIO_HIGH].size);
>> +
>> +    create_pcie_irq_map(s, ms->fdt, name, irq_pcie_phandle);
>> +
>> +    qemu_fdt_setprop_cells(ms->fdt, name, "iommu-map",
>> +                           0, iommu_sys_phandle, 0, 0x10000);
>> +}
>> +
>> +static void create_fdt_reset(RISCVServerRefMachineState *s,
>> +                             const MemMapEntry *memmap,
>> +                             uint32_t *phandle)
>> +{
>> +    char *name;
>> +    uint32_t test_phandle;
>> +    MachineState *ms = MACHINE(s);
>> +
>> +    test_phandle = (*phandle)++;
>> +    name = g_strdup_printf("/soc/reset_syscon@%"HWADDR_PRIx,
>> +                           memmap[RVSERVER_RESET_SYSCON].base);
>> +    qemu_fdt_add_subnode(ms->fdt, name);
>> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "syscon");
>> +    qemu_fdt_setprop_cells(ms->fdt, name, "reg",
>> +        0x0, memmap[RVSERVER_RESET_SYSCON].base,
>> +        0x0, memmap[RVSERVER_RESET_SYSCON].size);
>> +    qemu_fdt_setprop_cell(ms->fdt, name, "phandle", test_phandle);
>> +    test_phandle = qemu_fdt_get_phandle(ms->fdt, name);
>> +    g_free(name);
>> +
>> +    name = g_strdup_printf("/soc/reboot");
>> +    qemu_fdt_add_subnode(ms->fdt, name);
>> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "syscon-reboot");
>> +    qemu_fdt_setprop_cell(ms->fdt, name, "regmap", test_phandle);
>> +    qemu_fdt_setprop_cell(ms->fdt, name, "offset", 0x0);
>> +    qemu_fdt_setprop_cell(ms->fdt, name, "value", SYSCON_RESET);
>> +    g_free(name);
>> +
>> +    name = g_strdup_printf("/soc/poweroff");
>> +    qemu_fdt_add_subnode(ms->fdt, name);
>> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "syscon-poweroff");
>> +    qemu_fdt_setprop_cell(ms->fdt, name, "regmap", test_phandle);
>> +    qemu_fdt_setprop_cell(ms->fdt, name, "offset", 0x0);
>> +    qemu_fdt_setprop_cell(ms->fdt, name, "value", SYSCON_POWEROFF);
>> +    g_free(name);
>> +}
>> +
>> +static void create_fdt_uart(RISCVServerRefMachineState *s,
>> +                            const MemMapEntry *memmap,
>> +                            uint32_t irq_mmio_phandle)
>> +{
>> +    g_autofree char *name = NULL;
>> +    MachineState *ms = MACHINE(s);
>> +
>> +    name = g_strdup_printf("/soc/serial@%"HWADDR_PRIx,
>> +                           memmap[RVSERVER_UART0].base);
>> +    qemu_fdt_add_subnode(ms->fdt, name);
>> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "ns16550a");
>> +    qemu_fdt_setprop_cells(ms->fdt, name, "reg",
>> +        0x0, memmap[RVSERVER_UART0].base,
>> +        0x0, memmap[RVSERVER_UART0].size);
>> +    qemu_fdt_setprop_cell(ms->fdt, name, "clock-frequency", 3686400);
>> +    qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent",
>> +                          irq_mmio_phandle);
>> +    qemu_fdt_setprop_cells(ms->fdt, name, "interrupts",
>> +                           RVSERVER_UART0_IRQ, 0x4);
>> +
>> +    qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
>> +}
>> +
>> +static void create_fdt_rtc(RISCVServerRefMachineState *s,
>> +                           const MemMapEntry *memmap,
>> +                           uint32_t irq_mmio_phandle)
>> +{
>> +    g_autofree char *name = NULL;
>> +    MachineState *ms = MACHINE(s);
>> +
>> +    name = g_strdup_printf("/soc/rtc@%"HWADDR_PRIx,
>> +                           memmap[RVSERVER_RTC].base);
>> +    qemu_fdt_add_subnode(ms->fdt, name);
>> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible",
>> +        "google,goldfish-rtc");
>> +    qemu_fdt_setprop_cells(ms->fdt, name, "reg",
>> +        0x0, memmap[RVSERVER_RTC].base, 0x0, memmap[RVSERVER_RTC].size);
>> +    qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent",
>> +                          irq_mmio_phandle);
>> +    qemu_fdt_setprop_cells(ms->fdt, name, "interrupts",
>> +                           RVSERVER_RTC_IRQ, 0x4);
>> +}
>> +
>> +static void create_fdt_flash(RISCVServerRefMachineState *s,
>> +                             const MemMapEntry *memmap)
>> +{
>> +    MachineState *ms = MACHINE(s);
>> +    hwaddr flashsize = rvserver_ref_memmap[RVSERVER_FLASH].size / 2;
>> +    hwaddr flashbase = rvserver_ref_memmap[RVSERVER_FLASH].base;
>> +    g_autofree char *name = g_strdup_printf("/flash@%"HWADDR_PRIx, flashbase);
>> +
>> +    qemu_fdt_add_subnode(ms->fdt, name);
>> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "cfi-flash");
>> +    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
>> +                                 2, flashbase, 2, flashsize,
>> +                                 2, flashbase + flashsize, 2, flashsize);
>> +    qemu_fdt_setprop_cell(ms->fdt, name, "bank-width", 4);
>> +}
>> +
>> +static void finalize_fdt(RISCVServerRefMachineState *s)
>> +{
>> +    uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
>> +    uint32_t irq_pcie_phandle = 1, iommu_sys_phandle;
>> +
>> +    create_fdt_sockets(s, rvserver_ref_memmap, &phandle, &irq_mmio_phandle,
>> +                       &irq_pcie_phandle, &msi_pcie_phandle);
>> +
>> +    create_fdt_iommu_sys(s, irq_mmio_phandle, msi_pcie_phandle,
>> +                         &iommu_sys_phandle);
>> +
>> +    create_fdt_pcie(s, rvserver_ref_memmap, irq_pcie_phandle,
>> +                    msi_pcie_phandle, iommu_sys_phandle);
>> +
>> +    create_fdt_reset(s, rvserver_ref_memmap, &phandle);
>> +
>> +    create_fdt_uart(s, rvserver_ref_memmap, irq_mmio_phandle);
>> +
>> +    create_fdt_rtc(s, rvserver_ref_memmap, irq_mmio_phandle);
>> +}
>> +
>> +static void create_fdt(RISCVServerRefMachineState *s,
>> +                       const MemMapEntry *memmap)
>> +{
>> +    MachineState *ms = MACHINE(s);
>> +    uint8_t rng_seed[32];
>> +
>> +    ms->fdt = create_device_tree(&s->fdt_size);
>> +    if (!ms->fdt) {
>> +        error_report("create_device_tree() failed");
>> +        exit(1);
>> +    }
>> +
>> +    qemu_fdt_setprop_string(ms->fdt, "/", "model", "qemu,riscv-server-ref");
>> +    qemu_fdt_setprop_string(ms->fdt, "/", "compatible", "riscv-server-ref");
>> +    qemu_fdt_setprop_cell(ms->fdt, "/", "#size-cells", 0x2);
>> +    qemu_fdt_setprop_cell(ms->fdt, "/", "#address-cells", 0x2);
>> +
>> +    /*
>> +     * This versioning scheme is for informing platform fw only. It is neither:
>> +     * - A QEMU versioned machine type; a given version of QEMU will emulate
>> +     *   a given version of the platform.
>> +     * - A reflection of level of server platform support provided.
>> +     *
>> +     * machine-version-major: updated when changes breaking fw compatibility
>> +     *                        are introduced.
>> +     * machine-version-minor: updated when features are added that don't break
>> +     *                        fw compatibility.
>> +     *
>> +     * It's the same as the scheme in arm sbsa-ref.
>> +     */
>> +    qemu_fdt_setprop_cell(ms->fdt, "/", "machine-version-major", 0);
>> +    qemu_fdt_setprop_cell(ms->fdt, "/", "machine-version-minor", 0);
>> +
>> +    qemu_fdt_add_subnode(ms->fdt, "/soc");
>> +    qemu_fdt_setprop(ms->fdt, "/soc", "ranges", NULL, 0);
>> +    qemu_fdt_setprop_string(ms->fdt, "/soc", "compatible", "simple-bus");
>> +    qemu_fdt_setprop_cell(ms->fdt, "/soc", "#size-cells", 0x2);
>> +    qemu_fdt_setprop_cell(ms->fdt, "/soc", "#address-cells", 0x2);
>> +
>> +    qemu_fdt_add_subnode(ms->fdt, "/chosen");
>> +
>> +    /* Pass seed to RNG */
>> +    qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
>> +    qemu_fdt_setprop(ms->fdt, "/chosen", "rng-seed",
>> +                     rng_seed, sizeof(rng_seed));
>> +
>> +    create_fdt_flash(s, memmap);
>> +    create_fdt_pmu(s);
>> +
>> +}
>> +
>> +static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
>> +                                          DeviceState *irqchip,
>> +                                          RISCVServerRefMachineState *s)
>> +{
>> +    DeviceState *dev;
>> +    PCIHostState *pci;
>> +    PCIDevice *pdev_ahci;
>> +    AHCIPCIState *ich9;
>> +    DriveInfo *hd[NUM_SATA_PORTS];
>> +    MemoryRegion *ecam_alias, *ecam_reg;
>> +    MemoryRegion *mmio_alias, *high_mmio_alias, *mmio_reg;
>> +    hwaddr ecam_base = rvserver_ref_memmap[RVSERVER_PCIE_ECAM].base;
>> +    hwaddr ecam_size = rvserver_ref_memmap[RVSERVER_PCIE_ECAM].size;
>> +    hwaddr mmio_base = rvserver_ref_memmap[RVSERVER_PCIE_MMIO].base;
>> +    hwaddr mmio_size = rvserver_ref_memmap[RVSERVER_PCIE_MMIO].size;
>> +    hwaddr high_mmio_base = rvserver_ref_memmap[RVSERVER_PCIE_MMIO_HIGH].base;
>> +    hwaddr high_mmio_size = rvserver_ref_memmap[RVSERVER_PCIE_MMIO_HIGH].size;
>> +    hwaddr pio_base = rvserver_ref_memmap[RVSERVER_PCIE_PIO].base;
>> +    hwaddr pio_size = rvserver_ref_memmap[RVSERVER_PCIE_PIO].size;
>> +    MachineClass *mc = MACHINE_GET_CLASS(s);
>> +    qemu_irq irq;
>> +    int i;
>> +
>> +    dev = qdev_new(TYPE_GPEX_HOST);
>> +
>> +    object_property_set_uint(OBJECT(GPEX_HOST(dev)), PCI_HOST_ECAM_BASE,
>> +                            ecam_base, NULL);
>> +    object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_ECAM_SIZE,
>> +                            ecam_size, NULL);
>> +    object_property_set_uint(OBJECT(GPEX_HOST(dev)),
>> +                             PCI_HOST_BELOW_4G_MMIO_BASE,
>> +                             mmio_base, NULL);
>> +    object_property_set_int(OBJECT(GPEX_HOST(dev)),
>> +                            PCI_HOST_BELOW_4G_MMIO_SIZE,
>> +                            mmio_size, NULL);
>> +    object_property_set_uint(OBJECT(GPEX_HOST(dev)),
>> +                             PCI_HOST_ABOVE_4G_MMIO_BASE,
>> +                             high_mmio_base, NULL);
>> +    object_property_set_int(OBJECT(GPEX_HOST(dev)),
>> +                            PCI_HOST_ABOVE_4G_MMIO_SIZE,
>> +                            high_mmio_size, NULL);
>> +    object_property_set_uint(OBJECT(GPEX_HOST(dev)), PCI_HOST_PIO_BASE,
>> +                            pio_base, NULL);
>> +    object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_PIO_SIZE,
>> +                            pio_size, NULL);
>> +
>> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>> +
>> +    ecam_alias = g_new0(MemoryRegion, 1);
>> +    ecam_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
>> +    memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
>> +                             ecam_reg, 0, ecam_size);
>> +    memory_region_add_subregion(get_system_memory(), ecam_base, ecam_alias);
>> +
>> +    mmio_alias = g_new0(MemoryRegion, 1);
>> +    mmio_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
>> +    memory_region_init_alias(mmio_alias, OBJECT(dev), "pcie-mmio",
>> +                             mmio_reg, mmio_base, mmio_size);
>> +    memory_region_add_subregion(get_system_memory(), mmio_base, mmio_alias);
>> +
>> +    /* Map high MMIO space */
>> +    high_mmio_alias = g_new0(MemoryRegion, 1);
>> +    memory_region_init_alias(high_mmio_alias, OBJECT(dev), "pcie-mmio-high",
>> +                             mmio_reg, high_mmio_base, high_mmio_size);
>> +    memory_region_add_subregion(get_system_memory(), high_mmio_base,
>> +                                high_mmio_alias);
>> +
>> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, pio_base);
>> +
>> +    for (i = 0; i < PCI_NUM_PINS; i++) {
>> +        irq = qdev_get_gpio_in(irqchip, RVSERVER_PCIE_IRQ + i);
>> +
>> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
>> +        gpex_set_irq_num(GPEX_HOST(dev), i, RVSERVER_PCIE_IRQ + i);
>> +    }
>> +
>> +    pci = PCI_HOST_BRIDGE(dev);
>> +    pci_init_nic_devices(pci->bus, mc->default_nic);
>> +    /* IDE disk setup.  */
>> +    pdev_ahci = pci_create_simple(pci->bus, -1, TYPE_ICH9_AHCI);
>> +    ich9 = ICH9_AHCI(pdev_ahci);
>> +    g_assert(ARRAY_SIZE(hd) == ich9->ahci.ports);
>> +    ide_drive_get(hd, ich9->ahci.ports);
>> +    ahci_ide_create_devs(&ich9->ahci, hd);
>> +
>> +    GPEX_HOST(dev)->gpex_cfg.bus = PCI_HOST_BRIDGE(GPEX_HOST(dev))->bus;
>> +    return dev;
>> +}
>> +
>> +static DeviceState *rvserver_ref_create_aia(int aia_guests,
>> +                                            const MemMapEntry *memmap,
>> +                                            int socket,
>> +                                            int base_hartid, int hart_count)
>> +{
>> +    int i;
>> +    hwaddr addr;
>> +    uint32_t guest_bits;
>> +    DeviceState *aplic_s = NULL;
>> +    DeviceState *aplic_m = NULL;
>> +    bool msimode = true;
>> +
>> +    /* Per-socket M-level IMSICs */
>> +    addr = memmap[RVSERVER_IMSIC_M].base +
>> +           socket * RVSERVER_IMSIC_GROUP_MAX_SIZE;
>> +    for (i = 0; i < hart_count; i++) {
>> +        riscv_imsic_create(addr + i * IMSIC_HART_SIZE(0),
>> +                           base_hartid + i, true, 1,
>> +                           RVSERVER_IRQCHIP_NUM_MSIS);
>> +    }
>> +
>> +    /* Per-socket S-level IMSICs */
>> +    guest_bits = imsic_num_bits(aia_guests + 1);
>> +    addr = memmap[RVSERVER_IMSIC_S].base +
>> +           socket * RVSERVER_IMSIC_GROUP_MAX_SIZE;
>> +    for (i = 0; i < hart_count; i++) {
>> +        riscv_imsic_create(addr + i * IMSIC_HART_SIZE(guest_bits),
>> +                           base_hartid + i, false, 1 + aia_guests,
>> +                           RVSERVER_IRQCHIP_NUM_MSIS);
>> +    }
>> +
>> +    /* Per-socket M-level APLIC */
>> +    aplic_m = riscv_aplic_create(memmap[RVSERVER_APLIC_M].base +
>> +                                 socket * memmap[RVSERVER_APLIC_M].size,
>> +                                 memmap[RVSERVER_APLIC_M].size,
>> +                                 (msimode) ? 0 : base_hartid,
>> +                                 (msimode) ? 0 : hart_count,
>> +                                 RVSERVER_IRQCHIP_NUM_SOURCES,
>> +                                 RVSERVER_IRQCHIP_NUM_PRIO_BITS,
>> +                                 msimode, true, NULL);
>> +
>> +    /* Per-socket S-level APLIC */
>> +    aplic_s = riscv_aplic_create(memmap[RVSERVER_APLIC_S].base +
>> +                                 socket * memmap[RVSERVER_APLIC_S].size,
>> +                                 memmap[RVSERVER_APLIC_S].size,
>> +                                 (msimode) ? 0 : base_hartid,
>> +                                 (msimode) ? 0 : hart_count,
>> +                                 RVSERVER_IRQCHIP_NUM_SOURCES,
>> +                                 RVSERVER_IRQCHIP_NUM_PRIO_BITS,
>> +                                 msimode, false, aplic_m);
>> +
>> +    (void)aplic_s;
>>
> This looks weird to me. Is this to resolve some compiler warning? Why
> can't this function just return success / failure?
> 
>> +    return aplic_m;
>> +}
>> +
>> +static uint64_t rvserver_reset_syscon_read(void *opaque, hwaddr addr,
>> +                                           unsigned size)
>> +{
>> +    return 0;
>> +}
>> +
>> +static void rvserver_reset_syscon_write(void *opaque, hwaddr addr,
>> +                                        uint64_t val64, unsigned int size)
>> +{
>> +    switch (val64) {
>> +    case SYSCON_POWEROFF:
>> +        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
>> +        return;
>> +    case SYSCON_RESET:
>> +        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>> +        return;
>> +    default:
>> +        break;
>> +    }
>> +}
>> +
>> +static const MemoryRegionOps rvserver_reset_syscon_ops = {
>> +    .read = rvserver_reset_syscon_read,
>> +    .write = rvserver_reset_syscon_write,
>> +    .endianness = DEVICE_LITTLE_ENDIAN
>> +};
>> +
>> +static void rvserver_ref_machine_done(Notifier *notifier, void *data)
>> +{
>> +    RISCVServerRefMachineState *s = container_of(
>> +        notifier, RISCVServerRefMachineState, machine_done);
>> +    const MemMapEntry *memmap = rvserver_ref_memmap;
>> +    MachineState *machine = MACHINE(s);
>> +    hwaddr start_addr = memmap[RVSERVER_DRAM].base;
>> +    target_ulong firmware_end_addr, kernel_start_addr;
>> +    const char *firmware_name = riscv_default_firmware_name(&s->soc[0]);
>> +    uint64_t fdt_load_addr;
>> +    uint64_t kernel_entry = 0;
>> +    BlockBackend *pflash_blk0;
>> +    RISCVBootInfo boot_info;
>> +
>> +    /*
>> +     * An user provided dtb must include everything, including
>> +     * dynamic sysbus devices. Our FDT needs to be finalized.
>> +     */
>> +    if (machine->dtb == NULL) {
>> +        finalize_fdt(s);
>> +    }
>> +
>> +    firmware_end_addr = riscv_find_and_load_firmware(machine, firmware_name,
>> +                                                     &start_addr, NULL);
>> +
>> +    pflash_blk0 = pflash_cfi01_get_blk(s->flash[0]);
>> +    if (pflash_blk0) {
>> +        if (machine->firmware && !strcmp(machine->firmware, "none")) {
>> +            /*
>> +             * Pflash was supplied but bios is none and not KVM guest,
>> +             * let's overwrite the address we jump to after reset to
>> +             * the base of the flash.
>> +             */
>> +            start_addr = rvserver_ref_memmap[RVSERVER_FLASH].base;
>> +        } else {
>> +            /*
>> +             * Pflash was supplied but either KVM guest or bios is not none.
>> +             * In this case, base of the flash would contain S-mode payload.
>> +             */
>> +            riscv_setup_firmware_boot(machine);
>> +            kernel_entry = rvserver_ref_memmap[RVSERVER_FLASH].base;
>> +        }
>> +    }
>> +
>> +    riscv_boot_info_init(&boot_info, &s->soc[0]);
>> +
>> +    if (machine->kernel_filename && !kernel_entry) {
>> +        kernel_start_addr = riscv_calc_kernel_start_addr(&boot_info,
>> +                                                         firmware_end_addr);
>> +        riscv_load_kernel(machine, &boot_info, kernel_start_addr, true, NULL);
>> +        kernel_entry = boot_info.image_low_addr;
>> +    }
>> +
>> +    fdt_load_addr = riscv_compute_fdt_addr(memmap[RVSERVER_DRAM].base,
>> +                                           memmap[RVSERVER_DRAM].size,
>> +                                           machine, &boot_info);
>> +
>> +    riscv_load_fdt(fdt_load_addr, machine->fdt);
>> +
>> +    /* load the reset vector */
>> +    riscv_setup_rom_reset_vec(machine, &s->soc[0], start_addr,
>> +                              rvserver_ref_memmap[RVSERVER_MROM].base,
>> +                              rvserver_ref_memmap[RVSERVER_MROM].size,
>> +                              kernel_entry,
>> +                              fdt_load_addr);
>> +
>> +}
>> +
>> +static bool rvserver_aclint_allowed(void)
>> +{
>> +    return tcg_enabled() || qtest_enabled();
>> +}
>> +
>> +static void rvserver_ref_machine_init(MachineState *machine)
>> +{
>> +    const MemMapEntry *memmap = rvserver_ref_memmap;
>> +    RISCVServerRefMachineState *s = RISCV_SERVER_REF_MACHINE(machine);
>> +    MemoryRegion *system_memory = get_system_memory();
>> +    MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
>> +    MemoryRegion *reset_syscon_io = g_new(MemoryRegion, 1);
>> +    DeviceState *mmio_irqchip, *pcie_irqchip, *iommu_sys;
>> +    int i, base_hartid, hart_count;
>> +    int socket_count = riscv_socket_count(machine);
>> +
>> +    /* Check socket count limit */
>> +    if (RVSERVER_SOCKETS_MAX < socket_count) {
>> +        error_report("number of sockets/nodes should be less than %d",
>> +            RVSERVER_SOCKETS_MAX);
>> +        exit(1);
>> +    }
>> +
>> +    if (!rvserver_aclint_allowed()) {
>> +        error_report("'aclint' is only available with TCG acceleration");
>> +        exit(1);
>>
> Why exit here? What does it mean then - is the machine not supported in KVM?
> 
> Thanks,
> Sunil


