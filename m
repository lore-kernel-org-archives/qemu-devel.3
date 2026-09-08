Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF9C8C79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 18:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x40oa-00006U-3t; Tue, 08 Sep 2026 14:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x40oU-0008WV-AY
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 14:44:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x40oQ-0003h6-3x
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 14:44:56 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688FdXS13429799
 for <qemu-devel@nongnu.org>; Tue, 8 Sep 2026 18:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 f8BKjPDMaTNDrgG2ZnNSSxuQM6rpMx1tvnb3vXkH3Ww=; b=nSR77Rh/WZbbD1Mq
 9UCtPjRxcPiDbMGjz1Zo8+unUAXlSNxAgJsmTONrMtlppXBxvKBlz7mjUICYzZZi
 VeFlssZo6QagQXQVG38uU9M8sKcvtjBbhZfenHMdLVWlBSh+C6rgniO0kYtJaPfv
 AuMz/YYSQOYsnNqiVkzOJJX5ezqq/9NxiEXwU4IXf/Ow7pQp1XP09KHCFBsov3ox
 BqNgPC01wAdNT/25nEQDxrumq1kd8JUEHmpDYhFV4xGwVFzS7URlMCGFBH7XmRGt
 BYMEEj2D3Nck8EdgZocZS6375wLPRZUommmAT4kSWaiOJ2Oem3PdXtBCB+rSmqsC
 WMGaNA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjhkj229c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 18:44:52 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93915f50a5cso1176906885a.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 11:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788893091; x=1789497891; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=f8BKjPDMaTNDrgG2ZnNSSxuQM6rpMx1tvnb3vXkH3Ww=;
 b=YfFKxSoAOn1j/UtnMzQsuE1O9yijQ/JSJC64jnXuqGSyomKrDAMnPDMV5hQBenmDpU
 DbBKD9zxvWwwQC/rC9i5Gi+KzwgBNbUiM2WQ2xLYbadHXB3iu+wL9lNx36tivdsOVUFE
 pCLuWpmQIJQArRg+5nyK9rR13Nza3fSInwpjOhvaqfSOjoGIC1wsIX8kYHFu+cPqvqma
 NhhtB7pX6Jhyk3GEVmF+/galb9ML+ja/2qgc4CGis1DnOvaIRdx5qFlj0KoVdw7QbDG/
 yzKZgmOaISqGYjr8DahYshRerPFytK3jzN7GmaXh+tAIrXPhILuyPdtfVDHZAc0GSVpP
 pXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788893091; x=1789497891;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f8BKjPDMaTNDrgG2ZnNSSxuQM6rpMx1tvnb3vXkH3Ww=;
 b=Olcm7WqJOCZoG8ZFzjcEcfhcAzaz5SfamixYVX5JCoJNFkzVYl5KTSU8ZqxFR3Gke4
 gdfphBlFnTXGSlHy442m/kJPfgN1xFYYIp/s4Zn2fwXK4PH+bWq2DHQO/Z4D0TiQJR09
 Ei49THU8/MJABk+Wj92Be9bM0sGawTpNSwvtx0fS1tID2kEAB43b/OOe9jeTHYpizeRJ
 Oi8lV62JCdtUoOAfrrXMjBNM8IeiQxmJjXB51Wv11BMMNkOp41bJf4nFCFcuc+NDHgYD
 vEKQOZiGtI+BZ/vyOA9drKy1sYDTaO2pp9Hr56ecAOKqBqji54TDKUuVjzqWxfI8rBss
 YK2A==
X-Gm-Message-State: AFuF++n21JinrTQLUb0Q9wgrERnz5m2dSFGxfVU+iaRzjaPvKPu6b5tT
 KV78zpc/vnQR6Jz8jc6iKbcIClK+5syRhB/ErZPnkGhVnNM82OhUPYCWsHJ3aGx8jwvltFiI6CV
 UfMaieu/rFVBQANF45meLX1Znf8ey/zQaOB4yq5Ddx4l1+19Vo9oq790UQA==
X-Gm-Gg: AYBFou1tORk/Pmvhq7i5vrKiKH467LlJZl9Ud6ehnBU/wYyJ+mz9z6eETbhueEBDIaj
 /qScyaXDTSyDKxvkOhyoxVETnBzLhFA+JH4oRoj0xC1PRVlwsEVSUeBaV0tuS8FRZLZx/2fftUE
 RZyHB/vixOuyvqbSOuL81uN1fr9BaTY1SrdjbOmDE59lBdY9kLHX/oA0EkBcFfVtYnPkVVg8J8H
 f+gGYzisxNnDg49zeLtlKYYc/3B+jI+OGy27wFgyB7d+hxCNxAaqj3/97BLgtZ91a+cYV7HkH5f
 mMyrGRkVMM3PxHS2mZl1Psz43xYhBelvu62kQoKyvKNLOCZLcXQ4DyCKJjHTOvjY0Zw4utImni4
 JBUHMWy1pWK7JiFj1sVtnHMFq6rCu9F5u6w4=
X-Received: by 2002:a05:620a:46a4:b0:939:79b0:e68 with SMTP id
 af79cd13be357-939b7911541mr795651085a.4.1788893091283; 
 Tue, 08 Sep 2026 11:44:51 -0700 (PDT)
X-Received: by 2002:a05:620a:46a4:b0:939:79b0:e68 with SMTP id
 af79cd13be357-939b7911541mr795610185a.4.1788893086010; 
 Tue, 08 Sep 2026 11:44:46 -0700 (PDT)
Received: from [192.168.68.102] ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9397f9f0734sm1217398385a.4.2026.09.08.11.44.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 11:44:44 -0700 (PDT)
Message-ID: <427a14f2-a9c3-487e-96e2-358b30f74bed@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 15:44:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/5] hw/riscv: server platform reference machine
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, leif.lindholm@oss.qualcomm.com,
 Nutty Liu <nutty.liu@hotmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260904195610.964829-1-daniel.barboza@oss.qualcomm.com>
 <20260904195610.964829-4-daniel.barboza@oss.qualcomm.com>
 <bwtqij7uqwnjxmasptgkjrw4ezp6d6hfubqx2erbsvtiby753e@izadxouq3pnv>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <bwtqij7uqwnjxmasptgkjrw4ezp6d6hfubqx2erbsvtiby753e@izadxouq3pnv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDIwMyBTYWx0ZWRfX5DVmwOM174vQ
 3cwsmZB+URP6UzyCGAv+/hKXJYsukl218IgIUWnb5gp8+3N6dKXRRDRrOwy482aVvCfRzypxBQb
 BZc/ifQJWBTM2P7QxuiAFq1zXV6eLWM=
X-Proofpoint-GUID: LRaExigkb1AskIANvkbdBSkaPsoAqYh5
X-Authority-Analysis: v=2.4 cv=VYjH+lp9 c=1 sm=1 tr=0 ts=6aa057a4 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=NEAV23lmAAAA:8 a=NLiCwHATAAAA:8 a=EUspDBNiAAAA:8 a=69EAbJreAAAA:8
 a=FRSEYCzRAAAA:8 a=0-83Z_8kP4zpp-VlHxUA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=F9tHCgz3TLBaZgltkx5D:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-ORIG-GUID: LRaExigkb1AskIANvkbdBSkaPsoAqYh5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDIwMyBTYWx0ZWRfX68RVnDudjxpY
 2y5flpfMUClTDt0jF3XGwqXEc9pv0wGXkjXbaIbNXvqv5mPIOpRiI4JQm7wR3REBKB95L4zAwPj
 Moxi+0qwYrRsUsCGYdMDwX6rUK4GGsqda5/XV4lHR6y3fuoBkr4THM5kIBCncPezivD/3oJjt3R
 IQ4XY0KonTMlZXfl9aaPgffNnwaIqHNlx3DP9yMlXtbHGgQdgmPAGQ3yzjq5dXy35s/5RR+Jlir
 i0UiVB/ByTGPFJef5hjcYrpLCaZPR7eBhc+aGDln8+P+zwA6WJh4rwltFggFtd86m9xiiiRS4so
 jiCJxngfOiAqCSoWXrSOZKGXOQb/9LurgVQnprZCsr/tBU+wLLgLVo+x7OZJUw3EgrCAY0uSt8D
 3SCYhTyOkiqu2v8fQKt0J2t+PIZyThlmOzGAhUDR7Qgnm2l4GhyByrMis5F1eXUoiFLVOCzP0O3
 bVsYwG5LeSdxOnsRV5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080203
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 9/8/2026 7:40 AM, Andrew Jones wrote:
> On Fri, Sep 04, 2026 at 04:56:08PM -0300, Daniel Henrique Barboza wrote:
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
>> - Only minimal device tree nodes;
>> - a platform bus for TPM support.
>>
>> A note about TPM support:  TPM devices in QEMU comes usually in two
>> flavors - emulated or passthrough.  A passthrough device requires a host
>> TPM device that the QEMU process can borrow and it's usually coupled
>> with KVM acceleration.
>>
>> To use the TPM emulator we'll need help from an external TPM emulator
>> called swtpm.  More info can be found in [2].  For our purposes this is
>> a process that, if running Ubuntu, can be installed via 'swtpm' package.
>> We'll go back to it shortly.
>>
>> For now, adding support for the emulated TPM device 'tpm-tis' (other TPM
>> flavors might work as well, 'tpm-tis' is the one tested with this work)
>> requires a platform bus.  Adding a platform bus will open the door for
>> more devices to be added in the board.  This is ok - a reference board
>> isn't a restricted board and users are free to add devices at their
>> leisure.
>>
>> Here's how to use tpm-tis with the riscv-server-ref board:
>>
>> - in a separated shell/term run 'swtpm' (--log is optional):
>>
>> $ mkdir /tmp/mytpm1
>> $ swtpm socket --tpmstate dir=/tmp/mytpm1 \
>> 	--ctrl type=unixio,path=/tmp/mytpm1/swtpm-sock \
>> 	--tpm2 \
>> 	--log level=20
>>
>> Then start QEMU with:
>>
>> $ qemu-system-riscv64 -M riscv-server-ref (...) \
>> 	-chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
>> 	-tpmdev emulator,id=tpm0,chardev=chrtpm\
>> 	-device tpm-tis-device,tpmdev=tpm0
>>
>> [1] https://github.com/riscv-non-isa/riscv-server-platform
>> [2] https://qemu-project.gitlab.io/qemu/specs/tpm.html
>>
>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
>> Reviewed-by: Chao Liu <chao.liu@processmission.com>
>> ---
>>   configs/devices/riscv64-softmmu/default.mak |   1 +
>>   hw/riscv/Kconfig                            |  16 +
>>   hw/riscv/meson.build                        |   1 +
>>   hw/riscv/server_platform_ref.c              | 769 ++++++++++++++++++++
>>   4 files changed, 787 insertions(+)
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
>> index d06ac26648..da59eb2155 100644
>> --- a/hw/riscv/Kconfig
>> +++ b/hw/riscv/Kconfig
>> @@ -69,6 +69,22 @@ config RISCV_VIRT
>>       select ACPI
>>       select ACPI_PCI
>>   
>> +config RISCV_SERVER_PLATFORM_REF
>> +    bool
>> +    default y
>> +    depends on RISCV64
>> +    imply TPM_TIS_SYSBUS
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
>> index 7aa3c1578d..cc5a019f7c 100644
>> --- a/hw/riscv/meson.build
>> +++ b/hw/riscv/meson.build
>> @@ -7,6 +7,7 @@ riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
>>   riscv_ss.add(files('riscv_hart.c'))
>>   riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
>>   riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
>> +riscv_ss.add(when: 'CONFIG_RISCV_SERVER_PLATFORM_REF', if_true: files('server_platform_ref.c'))
>>   riscv_ss.add(when: 'CONFIG_SHAKTI_C', if_true: files('shakti_c.c'))
>>   riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
>>   riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
>> diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
>> new file mode 100644
>> index 0000000000..cc74bf06a1
>> --- /dev/null
>> +++ b/hw/riscv/server_platform_ref.c
>> @@ -0,0 +1,769 @@
>> +/*
>> + * QEMU RISC-V Server Platform Reference Board (riscv-server-ref)
>> + *
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
>> +#include "hw/core/platform-bus.h"
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
>> +#include "hw/riscv/device-common.h"
>> +#include "hw/riscv/fdt-common.h"
>> +#include "hw/riscv/numa.h"
>> +#include "hw/riscv/iommu.h"
>> +#include "hw/riscv/riscv-iommu.h"
>> +#include "hw/riscv/riscv-iommu-bits.h"
>> +#include "hw/intc/riscv_aclint.h"
>> +#include "hw/intc/riscv_aplic.h"
>> +#include "hw/intc/riscv_imsic.h"
>> +#include "chardev/char.h"
>> +#include "hw/char/serial-mm.h"
>> +#include "system/device_tree.h"
>> +#include "system/runstate.h"
>> +#include "system/system.h"
>> +#include "system/kvm.h"
>> +#include "system/tcg.h"
>> +#include "kvm/kvm_riscv.h"
>> +#include "system/tpm.h"
>> +#include "system/qtest.h"
>> +#include "target/riscv/cpu.h"
>> +#include "net/net.h"
>> +
>> +#include "aia.h"
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
> 
> The server-soc spec (which the server platform spec depends on) says we
> need a minimum of 5 VS-mode interrupt files (IIC_040). That does require
> three bits, but we could set RVSERVER_IRQCHIP_MAX_GUESTS to 5 in order
> to set the minimum (which is our usual approach). Doing that would both
> keep our config minimized and allow testing of sparse imsic topologies
> by default. And aia_guests is still configurable on the command line for
> those that want to configure more.

Fair enough.  I'll set RVSERVER_IRQCHIP_MAX_GUESTS to 5.

> 
>> +
>> +#define NUM_SATA_PORTS  6

[...]

>> +static void rvserver_ref_machine_instance_init(Object *obj)
>> +{
>> +    RISCVServerRefMachineState *s = RISCV_SERVER_REF_MACHINE(obj);
>> +
>> +    s->flash[0] = riscv_flash_create(OBJECT(s), "riscv-server-ref.flash0",
>> +                                        "pflash0", RVSERVER_FLASH_SECTOR_SIZE);
>> +    s->flash[1] = riscv_flash_create(OBJECT(s), "riscv-server-ref.flash1",
>> +                                        "pflash1", RVSERVER_FLASH_SECTOR_SIZE);
> 
> More whitespace issues here. Might want to double check whole file with
> some tool.

I believe you caugh every single one of them.  Would be nice to have a 'lint' like
script to check for this kind of stuff though.


Thanks,
Daniel


