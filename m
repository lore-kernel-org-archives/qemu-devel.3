Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B1CF364B1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 20:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAvcD-0006Af-Ja; Thu, 09 Apr 2026 16:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAvcC-0006AP-6M
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 16:04:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAvc1-0007iX-HD
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 16:04:28 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639G2pYH2247197
 for <qemu-devel@nongnu.org>; Thu, 9 Apr 2026 20:04:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vYvoKDx6ePzvZt2YkP1XKAMQOei9zq2HmsiBrTdLUqc=; b=iBOXAbxzAIk82Bs6
 /lPEaiNphm8Qk9sJabxoY0MjY5S21fp8rpI/JKKViaH9dQEnGPXprQQ4qSsPHPcW
 m6osfgjdBnbHeWGT+/PqBPP7PaHLGIrhpcxUkE3caRPVzTK2oKnRnXO385LIdjyD
 KjnbcP1Q8543Pdfv2wrqCwKtPG/SfMD1nIdxzqyEzbKrlFHCg+sY6Ax4tfhJ0oKi
 0ytVqfQv3hmytewM+0TJ0L1RzqB+Q00vo2d23dOgeuoPXji/FyHMh2yUg7nXojZo
 6UNip08fELkm1vkzwbVU28WVNVjwcFHkTOM7K5FUiWRPxYN1/hcDh1a9iUchsP6b
 GzOwBA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4de3s6uqr2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 20:04:22 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-126e8ee6227so1732383c88.0
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 13:04:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775765062; cv=none;
 d=google.com; s=arc-20240605;
 b=awEJPR5cbLtVrcZod3Vf0crAYiva74QXTLply1XOlAuLxqcmF8njwqsyjrhfutjaM8
 O2Rh445wKQEjoEOi4sjzGt9/WnCEsbQbvwuOWjm5+gh8HyQGNFPOlxdIIrodhjTqThoU
 n1Sq/ttU9fJJ70XfZsZwqgn//nVMER3OmQix9ElitzmgqP9zSydsEG47mZ0ghWKEc7m6
 RlwT9+nYlVStBEt7jr7cIhObmnF+YHiqy6DmS7xSj00II21JORVULnGHjjtpsqQL+I2R
 jjoFEUR4e92jkErN03xtN31rb2x+iuxuScs6MpP99++QrBbMOaVqWw+cvDXx1+PzWUqR
 VLMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vYvoKDx6ePzvZt2YkP1XKAMQOei9zq2HmsiBrTdLUqc=;
 fh=FhZmaLtogkjmTn+kMmUp2dZZj8HLCDdbeRx/6RmFIFo=;
 b=SdhMccqdgdE+ArXplkFwtQOZlLXZzome9bbjc/9qTRBrkP9/c8W+B85JNJqHvhA6Vc
 eQ7dZokwl8OZyMZuAby4ro5DM8nIJM5+T4pL2GK2igW5vyEoWVotvcCDNGUu+JFUYRng
 OSgV0D7FK9SchrZzI4346ADj+RmoOauoPX0xY3duoxiJIqTjUKG62DIq5pB6lBYIBVFW
 OK6Uliw5EUTsYnp5hwzJBZD5d3ZtFV2pBZ3Dw8kN7PvPWhP9ueJi/VeSP5Gmh6WQJzub
 U9YMmmUhpxGopmBYjkFgYI60hQ+AQctdXJk5YHZ2J/AK/DNAcre0OlaZADEPPKubFKqP
 8GGg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775765062; x=1776369862; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vYvoKDx6ePzvZt2YkP1XKAMQOei9zq2HmsiBrTdLUqc=;
 b=Lbnf62LSn1oXbj8LbQ5KUMJ5VtzMGzayft1TUVaSgu9f4qh6qcORcR1i2kOtRR30eW
 cgD9I+Tlx/YOhRFqADj/b+SEJgPqWnygl1vDSiRQFsPPG09OCvpIaNy9m/u+DspdokJ+
 H96iUxqw+ztUs2hnKiiaURN4iypAKUX8MwCoommy2E1++U4i4jjgcvQSOfUI+jGx9Qro
 NigIXWUBMJex6uFwiz4LPqQOC0HTSkmuKzaWmKJe286RyxfdHt03DWoNhx+oO6YILdft
 KkgPZzKVgR30020gSKLWdoD6cJGmNU+SsM/skoSc/5eyVWznyKO3fLwLVgt8+qQQv+u1
 uGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775765062; x=1776369862;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vYvoKDx6ePzvZt2YkP1XKAMQOei9zq2HmsiBrTdLUqc=;
 b=bdafoAGJp7iRuoMFWwE/Wf5zZPuBrCPSp74KZwN2bH1Q6LHx+3Kuothw5+/jgokTj3
 Bop6yA6SQ3PDC04iNmm0T/8BA/h7pExdXT/W0dh/D2ENhsc9uEHRkQVoYzjZFIV5R+Iq
 trAPgR6rv0PP+Y+7mOy6D3b0S5PU1htf5qjn758pYigFZZc5XYitZyC+ybF6PtZm9hCq
 roC1LGNMRw0NyAYg2p+NAL1qXvRX4ySNrzj3+QTn7FQwnKlNh/FCx2MdLgI7eN6LUauK
 Faxrn7Ak73mm5DhUMDJaWcyQ9fLVBrHyJfSvKJHK6XY1u23k5fCk28S4ebggpG/3Zky2
 VkBQ==
X-Gm-Message-State: AOJu0Yym2mn6AiDcehz6UToRPKu1hX0NKsVWOaIbmYNHkRleKmVyWfRO
 gpJTQlQkE3GrA7u8VLufToF8O+qBL77rpBY4Fq8YHFljBmQLyUAOXZr0kiz2zVxg/v7tgYeo3nO
 iRKFu7SC9m0Ud9zqgPsMBlty+78jEOp2/VFm3Kz2PrzluCKJdM1i4dlg2PZQQJcxIQ0p0ktOlIE
 H2k20fcLpzgwwnIVuqTqmfbM7+s4CdtD1/
X-Gm-Gg: AeBDieuuyFreEbHvJxHchaLcg5NbN9gX2JXR2toN5Fe10REIMqGTVtqkKe4f7iRgkT3
 ZK9986INPineKqcvHsZK2yneUcIHrOb8o5RL9+3e3Hpxl1BxbDt9Mmj6pRVWdZqE8R3BddzqOdg
 qyn+VX0ccpiovEq/a5E7PkPLSCu1THbv1JTXdtmLAlsnmTTSec3uOnYQ7ACJ2GPNABcjPgHI+GF
 DuoMrE=
X-Received: by 2002:a05:7022:fa04:b0:12b:ec15:69d2 with SMTP id
 a92af1059eb24-12c34efcc4dmr251250c88.33.1775765061782; 
 Thu, 09 Apr 2026 13:04:21 -0700 (PDT)
X-Received: by 2002:a05:7022:fa04:b0:12b:ec15:69d2 with SMTP id
 a92af1059eb24-12c34efcc4dmr251198c88.33.1775765060962; Thu, 09 Apr 2026
 13:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260408042149.1902796-1-brian.cain@oss.qualcomm.com>
 <20260408042149.1902796-9-brian.cain@oss.qualcomm.com>
 <CAJpW4SULdJ=zWw+ir3FBaVFvidzwTiHhGZ361A1BETHADThteQ@mail.gmail.com>
In-Reply-To: <CAJpW4SULdJ=zWw+ir3FBaVFvidzwTiHhGZ361A1BETHADThteQ@mail.gmail.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Thu, 9 Apr 2026 15:04:04 -0500
X-Gm-Features: AQROBzBDU2yPxW6HUHopxeawEEFv_UXfo2yv6MPxVGbhnFu8C2JZBz9IQRMEWsQ
Message-ID: <CAEqNhNa2=HUbTtvQ-J_8BGTsrW89-aiQJtjs5G4GLn8gNCuPOQ@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] hw/hexagon: Define hexagon "virt" machine
To: Sid Manning <sid.manning@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, ale@rev.ng, anjo@rev.ng,
 Brian Cain <bcain@quicinc.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: awLOXrhwYearQilAOjqovowakkMWbepu
X-Proofpoint-GUID: awLOXrhwYearQilAOjqovowakkMWbepu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE4NCBTYWx0ZWRfX9Fbew8UUcn7i
 5gZDbp3W1nMOREvH7fTy8z5lzfC02AKxpsjflu4T6dwALR3i2wpvsX3wX42xO1M11nmmd99L6b6
 luUlNM6VY6BR7oh5jWIr/zsUEDo9uCg4L7yqnDL3C3D8tbsaomfq525e32jWcKmI1iQoxvRgPoA
 28Yal0ShrwjtTlwE8bEfgFHQ23RZIBMwIkaorXnlwktJDZcibqtpmyxN8gTptvL4zH/0NX0uknP
 oIBN6536ZmFahNQYryH33eRRmpum2SLtEhswmKfpfJqdKEQcDRc9EDm1z3d3MUc34Xezrz7svzc
 yjxRH7WN6Rlj/VKukJm4MI+sV1r7iuklo50598MeE0oAh5TBmV+yieRRwTN1GeAbeY+7RungW+h
 dK7Lj0v8k8JfdXhtfxfD3GHMFSpP69kcgNwKk/GLJfePMbYk1bciWt7wwdDhceBd+edFJnS736I
 /0/vfjrcKDOa0gKIjCw==
X-Authority-Analysis: v=2.4 cv=TZemcxQh c=1 sm=1 tr=0 ts=69d80646 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=pIIDZHQ5010CrP4ofVMA:9 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090184
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Wed, Apr 8, 2026 at 2:22=E2=80=AFPM Sid Manning <sid.manning@oss.qualcom=
m.com> wrote:
>
>
>
> On Tue, Apr 7, 2026 at 11:22=E2=80=AFPM Brian Cain <brian.cain@oss.qualco=
mm.com> wrote:
>>
>> From: Brian Cain <bcain@quicinc.com>
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>  configs/devices/hexagon-softmmu/default.mak |   1 +
>>  configs/targets/hexagon-softmmu.mak         |   1 +
>>  include/hw/hexagon/virt.h                   |  43 ++
>>  hw/hexagon/virt.c                           | 456 ++++++++++++++++++++
>>  target/hexagon/cpu.c                        |   2 +
>>  hw/hexagon/Kconfig                          |  10 +
>>  hw/hexagon/meson.build                      |   2 +
>>  tests/qemu-iotests/testenv.py               |   1 +
>>  8 files changed, 516 insertions(+)
>>  create mode 100644 include/hw/hexagon/virt.h
>>  create mode 100644 hw/hexagon/virt.c
>>
>> diff --git a/configs/devices/hexagon-softmmu/default.mak b/configs/devic=
es/hexagon-softmmu/default.mak
>> index 08e709aea72..37b4f9f3237 100644
>> --- a/configs/devices/hexagon-softmmu/default.mak
>> +++ b/configs/devices/hexagon-softmmu/default.mak
>> @@ -3,5 +3,6 @@
>>  # Uncomment the following lines to disable these optional devices:
>>
>>  # Boards are selected by default, uncomment to keep out of the build.
>> +# CONFIG_HEX_VIRT=3Dy
>>  # CONFIG_HEX_DSP=3Dy
>>  # CONFIG_L2VIC=3Dy
>> diff --git a/configs/targets/hexagon-softmmu.mak b/configs/targets/hexag=
on-softmmu.mak
>> index fdfa29b4f39..a77c100f0c5 100644
>> --- a/configs/targets/hexagon-softmmu.mak
>> +++ b/configs/targets/hexagon-softmmu.mak
>> @@ -5,3 +5,4 @@ TARGET_XML_FILES=3Dhexagon-core.xml hexagon-hvx.xml
>>  TARGET_LONG_BITS=3D32
>>  TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
>>  TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
>> +TARGET_NEED_FDT=3Dy
>> diff --git a/include/hw/hexagon/virt.h b/include/hw/hexagon/virt.h
>> new file mode 100644
>> index 00000000000..a54eac5cf00
>> --- /dev/null
>> +++ b/include/hw/hexagon/virt.h
>> @@ -0,0 +1,43 @@
>> +/*
>> + * Definitions for hexagon virt board.
>> + *
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef HW_HEXAGONVIRT_H
>> +#define HW_HEXAGONVIRT_H
>> +
>> +#include "hw/core/boards.h"
>> +#include "target/hexagon/cpu.h"
>> +
>> +struct HexagonVirtMachineState {
>> +    /*< private >*/
>> +    MachineState parent_obj;
>> +
>> +    int fdt_size;
>> +    MemoryRegion *sys;
>> +    MemoryRegion cfgtable;
>> +    MemoryRegion ram;
>> +    MemoryRegion tcm;
>> +    MemoryRegion vtcm;
>> +    MemoryRegion bios;
>> +    DeviceState *l2vic;
>> +    Clock *apb_clk;
>> +};
>> +
>> +void hexagon_load_fdt(const struct HexagonVirtMachineState *vms);
>> +
>> +enum {
>> +    VIRT_UART0,
>> +    VIRT_QTMR0,
>> +    VIRT_QTMR1,
>> +    VIRT_GPT,
>> +    VIRT_MMIO,
>> +    VIRT_FDT,
>> +};
>> +
>> +#define TYPE_HEXAGON_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
>> +OBJECT_DECLARE_SIMPLE_TYPE(HexagonVirtMachineState, HEXAGON_VIRT_MACHIN=
E)
>> +
>> +#endif /* HW_HEXAGONVIRT_H */
>> diff --git a/hw/hexagon/virt.c b/hw/hexagon/virt.c
>> new file mode 100644
>> index 00000000000..49ee1aad2fe
>> --- /dev/null
>> +++ b/hw/hexagon/virt.c
>> @@ -0,0 +1,456 @@
>> +/*
>> + * Hexagon virt emulation
>> + *
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "hw/hexagon/virt.h"
>> +#include "elf.h"
>> +#include "hw/char/pl011.h"
>> +#include "hw/core/clock.h"
>> +#include "hw/core/sysbus-fdt.h"
>> +#include "hw/hexagon/hexagon.h"
>> +#include "hw/hexagon/hexagon_globalreg.h"
>> +#include "hw/hexagon/hexagon_tlb.h"
>> +#include "hw/core/loader.h"
>> +#include "hw/core/qdev-properties.h"
>> +#include "hw/core/qdev-clock.h"
>> +#include "hw/core/register.h"
>> +#include "qemu/error-report.h"
>> +#include "qemu/guest-random.h"
>> +#include "qemu/units.h"
>> +#include "elf.h"
>> +#include "machine_cfg_v68n_1024.h.inc"
>> +#include "system/address-spaces.h"
>> +#include "system/device_tree.h"
>> +#include "system/reset.h"
>> +#include "system/system.h"
>> +#include <libfdt.h>
>> +
>> +static const int VIRTIO_DEV_COUNT =3D 8;
>> +
>> +static const MemMapEntry base_memmap[] =3D {
>> +    [VIRT_UART0] =3D { 0x10000000, 0x00000200 },
>> +    [VIRT_MMIO] =3D { 0x11000000, 0x1000000, },
>> +    [VIRT_GPT] =3D { 0xab000000, 0x00001000 },
>> +    [VIRT_FDT] =3D { 0x99800000, 0x00400000 },
>> +};
>> +
>> +static const int irqmap[] =3D {
>> +    [VIRT_MMIO] =3D 18, /* ...to 18 + VIRTIO_DEV_COUNT - 1 */
>> +    [VIRT_GPT] =3D 12,
>> +    [VIRT_UART0] =3D 15,
>> +    [VIRT_QTMR0] =3D 2,
>> +    [VIRT_QTMR1] =3D 4,
>> +};
>> +
>> +
>> +static void create_fdt(HexagonVirtMachineState *vms)
>> +{
>> +    MachineState *ms =3D MACHINE(vms);
>> +    void *fdt =3D create_device_tree(&vms->fdt_size);
>> +    uint8_t rng_seed[32];
>> +
>> +    if (!fdt) {
>> +        error_report("create_device_tree() failed");
>> +        exit(1);
>> +    }
>> +
>> +    ms->fdt =3D fdt;
>> +
>> +    qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
>> +    qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x1);
>> +    qemu_fdt_setprop_string(fdt, "/", "model", "hexagon-virt,qemu");
>> +    qemu_fdt_setprop_string(fdt, "/", "compatible", "qcom,sm8150");
>> +
>> +    qemu_fdt_add_subnode(fdt, "/soc");
>> +    qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
>> +    qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x1);
>> +    qemu_fdt_setprop(fdt, "/soc", "ranges", NULL, 0);
>> +
>> +    qemu_fdt_add_subnode(fdt, "/chosen");
>> +    qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
>> +    qemu_fdt_setprop(fdt, "/chosen", "rng-seed", rng_seed, sizeof(rng_s=
eed));
>> +}
>> +
>> +static void fdt_add_hvx(HexagonVirtMachineState *vms,
>> +                        const struct hexagon_machine_config *m_cfg,
>> +                        Error **errp)
>> +{
>> +    const MachineState *ms =3D MACHINE(vms);
>> +    uint32_t vtcm_size_bytes =3D m_cfg->cfgtable.vtcm_size_kb * 1024;
>> +    if (vtcm_size_bytes > 0) {
>> +        memory_region_init_ram(&vms->vtcm, NULL, "vtcm.ram", vtcm_size_=
bytes,
>> +                               errp);
>> +        memory_region_add_subregion(vms->sys, m_cfg->cfgtable.vtcm_base=
 << 16,
>> +                                    &vms->vtcm);
>> +
>> +        qemu_fdt_add_subnode(ms->fdt, "/soc/vtcm");
>> +        qemu_fdt_setprop_string(ms->fdt, "/soc/vtcm", "compatible",
>> +                                "qcom,hexagon_vtcm");
>> +
>> +        assert(sizeof(m_cfg->cfgtable.vtcm_base) =3D=3D sizeof(uint32_t=
));
>> +        qemu_fdt_setprop_cells(ms->fdt, "/soc/vtcm", "reg", 0,
>> +                               m_cfg->cfgtable.vtcm_base << 16,
>> +                               vtcm_size_bytes);
>> +    }
>> +
>> +    if (m_cfg->cfgtable.ext_contexts > 0) {
>> +        qemu_fdt_add_subnode(ms->fdt, "/soc/hvx");
>> +        qemu_fdt_setprop_string(ms->fdt, "/soc/hvx", "compatible",
>> +                                "qcom,hexagon-hvx");
>> +        qemu_fdt_setprop_cells(ms->fdt, "/soc/hvx", "qcom,hvx-max-ctxts=
",
>> +                               m_cfg->cfgtable.ext_contexts);
>> +        qemu_fdt_setprop_cells(ms->fdt, "/soc/hvx", "qcom,hvx-vlength",
>> +                               m_cfg->cfgtable.hvx_vec_log_length);
>> +    }
>> +}
>> +
>> +static int32_t irq_hvm_ic_phandle =3D -1;
>> +static void fdt_add_hvm_pic_node(HexagonVirtMachineState *vms,
>> +                                 const struct hexagon_machine_config *m=
_cfg)
>> +{
>> +    MachineState *ms =3D MACHINE(vms);
>> +    irq_hvm_ic_phandle =3D qemu_fdt_alloc_phandle(ms->fdt);
>> +
>> +    qemu_fdt_setprop_cell(ms->fdt, "/soc", "interrupt-parent",
>> +                          irq_hvm_ic_phandle);
>> +
>> +    qemu_fdt_add_subnode(ms->fdt, "/soc/interrupt-controller");
>> +    qemu_fdt_setprop_cell(ms->fdt, "/soc/interrupt-controller",
>> +                          "#address-cells", 2);
>> +    qemu_fdt_setprop_cell(ms->fdt, "/soc/interrupt-controller",
>> +                          "#interrupt-cells", 2);
>> +    qemu_fdt_setprop_string(ms->fdt, "/soc/interrupt-controller", "comp=
atible",
>> +                            "qcom,h2-pic,hvm-pic");
>> +    qemu_fdt_setprop(ms->fdt, "/soc/interrupt-controller",
>> +                     "interrupt-controller", NULL, 0);
>> +    qemu_fdt_setprop_cell(ms->fdt, "/soc/interrupt-controller", "phandl=
e",
>> +                          irq_hvm_ic_phandle);
>> +
>> +    sysbus_mmio_map(SYS_BUS_DEVICE(vms->l2vic), 1,
>> +                    m_cfg->cfgtable.fastl2vic_base << 16);
>> +}
>> +
>> +
>> +static void fdt_add_gpt_node(HexagonVirtMachineState *vms)
>> +{
>> +    g_autofree char *name =3D NULL;
>> +    MachineState *ms =3D MACHINE(vms);
>> +
>> +    name =3D g_strdup_printf("/soc/gpt@%" PRIx64,
>> +                           (int64_t)base_memmap[VIRT_GPT].base);
>> +    qemu_fdt_add_subnode(ms->fdt, name);
>> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible",
>> +                            "qcom,h2-timer,hvm-timer");
>> +    qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", irqmap[VIRT_GPT=
], 0);
>> +    qemu_fdt_setprop_cells(ms->fdt, name, "reg", 0x0,
>> +                           base_memmap[VIRT_GPT].base,
>> +                           base_memmap[VIRT_GPT].size);
>> +}
>> +
>> +static int32_t clock_phandle =3D -1;
>> +static void fdt_add_clocks(const HexagonVirtMachineState *vms)
>> +{
>> +    MachineState *ms =3D MACHINE(vms);
>> +    clock_phandle =3D qemu_fdt_alloc_phandle(ms->fdt);
>> +    qemu_fdt_add_subnode(ms->fdt, "/apb-pclk");
>> +    qemu_fdt_setprop_string(ms->fdt, "/apb-pclk", "compatible", "fixed-=
clock");
>> +    qemu_fdt_setprop_cell(ms->fdt, "/apb-pclk", "#clock-cells", 0x0);
>> +    qemu_fdt_setprop_cell(ms->fdt, "/apb-pclk", "clock-frequency", 2400=
0000);
>> +    qemu_fdt_setprop_string(ms->fdt, "/apb-pclk", "clock-output-names",
>> +                            "clk24mhz");
>> +    qemu_fdt_setprop_cell(ms->fdt, "/apb-pclk", "phandle", clock_phandl=
e);
>> +}
>> +
>> +static void fdt_add_uart(const HexagonVirtMachineState *vms, int uart)
>> +{
>> +    char *nodename;
>> +    hwaddr base =3D base_memmap[uart].base;
>> +    hwaddr size =3D base_memmap[uart].size;
>> +    assert(uart =3D=3D 0);
>> +    int irq =3D irqmap[VIRT_UART0 + uart];
>> +    const char compat[] =3D "arm,pl011\0arm,primecell";
>> +    const char clocknames[] =3D "uartclk\0apb_pclk";
>> +    MachineState *ms =3D MACHINE(vms);
>> +    DeviceState *dev;
>> +    SysBusDevice *s;
>> +
>> +    dev =3D qdev_new(TYPE_PL011);
>> +    s =3D SYS_BUS_DEVICE(dev);
>> +    qdev_prop_set_chr(dev, "chardev", serial_hd(0));
>> +    qdev_connect_clock_in(dev, "clk", vms->apb_clk);
>> +    sysbus_realize_and_unref(s, &error_fatal);
>> +    sysbus_mmio_map(s, 0, base);
>> +    if (vms->l2vic) {
>> +        sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->l2vic, irq));
>> +    }
>> +
>> +    nodename =3D g_strdup_printf("/pl011@%" PRIx64, base);
>> +    qemu_fdt_add_subnode(ms->fdt, nodename);
>> +
>> +    /* Note that we can't use setprop_string because of the embedded NU=
L */
>> +    qemu_fdt_setprop(ms->fdt, nodename, "compatible", compat, sizeof(co=
mpat));
>> +    qemu_fdt_setprop_cells(ms->fdt, nodename, "reg", 0, base, size);
>> +    if (vms->l2vic) {
>> +        qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
>> +                               32 + irq, 0);
>> +        qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
>> +                              irq_hvm_ic_phandle);
>> +    }
>> +    qemu_fdt_setprop_cells(ms->fdt, nodename, "clocks", clock_phandle,
>> +                           clock_phandle);
>> +    qemu_fdt_setprop(ms->fdt, nodename, "clock-names", clocknames,
>> +                     sizeof(clocknames));
>> +
>> +    qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nodename=
);
>> +    qemu_fdt_add_subnode(ms->fdt, "/aliases");
>> +    qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", nodename);
>> +
>> +    g_free(nodename);
>> +}
>> +
>> +static void fdt_add_cpu_nodes(const HexagonVirtMachineState *vms)
>> +{
>> +    MachineState *ms =3D MACHINE(vms);
>> +    qemu_fdt_add_subnode(ms->fdt, "/cpus");
>> +    qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#address-cells", 0x1);
>> +    qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#size-cells", 0x0);
>> +
>> +    /* cpu nodes */
>> +    for (int num =3D ms->smp.cpus - 1; num >=3D 0; num--) {
>> +        char *nodename =3D g_strdup_printf("/cpus/cpu@%d", num);
>> +        qemu_fdt_add_subnode(ms->fdt, nodename);
>> +        qemu_fdt_setprop_string(ms->fdt, nodename, "device_type", "cpu"=
);
>> +        qemu_fdt_setprop_cell(ms->fdt, nodename, "reg", num);
>> +        qemu_fdt_setprop_cell(ms->fdt, nodename, "phandle",
>> +                              qemu_fdt_alloc_phandle(ms->fdt));
>> +        g_free(nodename);
>> +    }
>> +}
>> +
>> +
>> +static void fdt_add_virtio_devices(const HexagonVirtMachineState *vms)
>> +{
>> +    MachineState *ms =3D MACHINE(vms);
>> +    /* VirtIO MMIO devices */
>> +    for (int i =3D 0; i < VIRTIO_DEV_COUNT; i++) {
>> +        char *nodename;
>> +        int irq =3D irqmap[VIRT_MMIO] + i;
>> +        size_t size =3D base_memmap[VIRT_MMIO].size;
>> +        hwaddr base =3D base_memmap[VIRT_MMIO].base + i * size;
>> +
>> +        nodename =3D g_strdup_printf("/virtio_mmio@%" PRIx64, base);
>> +        qemu_fdt_add_subnode(ms->fdt, nodename);
>> +        qemu_fdt_setprop_string(ms->fdt, nodename, "compatible", "virti=
o,mmio");
>> +        qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg", 2, base,=
 1,
>> +                                     size);
>> +        qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts", irq, 0)=
;
>> +        qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
>> +                              irq_hvm_ic_phandle);
>> +
>> +        sysbus_create_simple(
>> +            "virtio-mmio", base,
>> +            qdev_get_gpio_in(vms->l2vic, irqmap[VIRT_MMIO] + i));
>> +
>> +        g_free(nodename);
>> +    }
>> +}
>> +
>> +static void virt_instance_init(Object *obj)
>> +{
>> +    HexagonVirtMachineState *vms =3D HEXAGON_VIRT_MACHINE(obj);
>> +
>> +    create_fdt(vms);
>> +}
>> +
>> +void hexagon_load_fdt(const HexagonVirtMachineState *vms)
>> +{
>> +    MachineState *ms =3D MACHINE(vms);
>> +    hwaddr fdt_addr =3D base_memmap[VIRT_FDT].base;
>> +    uint32_t fdtsize =3D vms->fdt_size;
>> +
>> +    g_assert(fdtsize <=3D base_memmap[VIRT_FDT].size);
>> +    /* copy in the device tree */
>> +    rom_add_blob_fixed_as("fdt", ms->fdt, fdtsize, fdt_addr,
>> +                          &address_space_memory);
>> +    qemu_register_reset_nosnapshotload(
>> +        qemu_fdt_randomize_seeds,
>> +        rom_ptr_for_as(&address_space_memory, fdt_addr, fdtsize));
>> +}
>> +
>> +static uint64_t load_kernel(const HexagonVirtMachineState *vms)
>> +{
>> +    MachineState *ms =3D MACHINE(vms);
>> +    uint64_t entry =3D 0;
>> +    if (load_elf_ram_sym(ms->kernel_filename, NULL, NULL, NULL, &entry,=
 NULL,
>> +                         NULL, NULL, 0, EM_HEXAGON, 0, 0, &address_spac=
e_memory,
>> +                         false, NULL) > 0) {
>> +        return entry;
>> +    }
>> +    error_report("error loading '%s'", ms->kernel_filename);
>> +    exit(1);
>> +}
>> +
>> +static uint64_t load_bios(HexagonVirtMachineState *vms)
>> +{
>> +    MachineState *ms =3D MACHINE(vms);
>> +    uint64_t bios_addr =3D 0x0;  /* Load BIOS at reset vector address 0=
x0 */
>> +    int bios_size;
>> +
>> +    bios_size =3D load_image_targphys(ms->firmware ?: "",
>> +                                    bios_addr, 64 * 1024, NULL);
>> +    if (bios_size < 0) {
>> +        error_report("Could not load BIOS '%s'", ms->firmware ?: "");
>> +        exit(1);
>> +    }
>> +
>> +    return bios_addr;  /* Return entry point at address 0x0 */
>> +}
>> +
>> +static void do_cpu_reset(void *opaque)
>> +{
>> +    HexagonCPU *cpu =3D opaque;
>> +    CPUState *cs =3D CPU(cpu);
>> +    cpu_reset(cs);
>> +}
>> +
>> +static void virt_init(MachineState *ms)
>> +{
>> +    HexagonVirtMachineState *vms =3D HEXAGON_VIRT_MACHINE(ms);
>> +    const struct hexagon_machine_config *m_cfg =3D &v68n_1024;
>
> This is v68 but in virt_class_init  mc->default_cpu_type is set to v73, s=
hould that be 68?

Fixed these, thanks Sid!

https://github.com/quic/qemu/tree/bcain/sysemu_review  e5f9d63 has the
requested changes, will give it a ~couple of days and send a new round
of patches for review w/the fixes.

Here's a range-diff:

 1:  d2341f42a80 !  1:  846fe3f0958 hw/hexagon: Add globalreg model
    @@ Commit message
         interface to the system registers.

         Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
    +    Reviewed-by: Sid Manning <sid.manning@oss.qualcomm.com>

      ## include/hw/hexagon/hexagon_globalreg.h (new) ##
     @@
    @@ hw/hexagon/hexagon_globalreg.c (new)
     +    s->regs[HEX_SREG_PMUCNT7] =3D INVALID_REG_VAL;
     +}
     +
    -+static void hexagon_globalreg_realize(DeviceState *dev, Error **errp)
    -+{
    -+}
    -+
     +void hexagon_globalreg_reset(HexagonGlobalRegState *s)
     +{
     +    do_hexagon_globalreg_reset(s);
    @@ hw/hexagon/hexagon_globalreg.c (new)
     +    DeviceClass *dc =3D DEVICE_CLASS(klass);
     +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
     +
    -+    dc->realize =3D hexagon_globalreg_realize;
     +    rc->phases.hold =3D hexagon_globalreg_reset_hold;
     +    dc->vmsd =3D &vmstate_hexagon_globalreg;
     +    dc->user_creatable =3D false;
 2:  21483a7154e =3D  2:  e3ed41133e7 hw/hexagon: Add global register traci=
ng
 3:  76011b26056 =3D  3:  735792b3493 hw/hexagon: Add machine configs for s=
ysemu
 4:  8b58db4d79b =3D  4:  9bbc363926a hw/hexagon: Add v68, sa8775-cdsp0 def=
s
 5:  50c227946bc =3D  5:  db09e484815 hw/hexagon: Add support for cfgbase
 6:  58150cb26eb =3D  6:  ad4b71cf913 hw/hexagon: Modify "Standalone" symbo=
ls
 7:  d6a21abad25 =3D  7:  81f67470f1f target/hexagon: add build config for =
softmmu
 8:  fdfbf4bd5f5 !  8:  48c194c1b33 hw/hexagon: Define hexagon "virt" machi=
ne
    @@ hw/hexagon/virt.c (new)
     +    cpu_model =3D ms->cpu_type;
     +
     +    if (!cpu_model) {
    -+        cpu_model =3D HEXAGON_CPU_TYPE_NAME("v73");
    ++        cpu_model =3D HEXAGON_CPU_TYPE_NAME("v68");
     +    }
     +
     +    gsregs_dev =3D qdev_new(TYPE_HEXAGON_GLOBALREG);
    @@ hw/hexagon/virt.c (new)
     +
     +    mc->desc =3D "Hexagon Virtual Machine";
     +    mc->init =3D virt_init;
    -+    mc->default_cpu_type =3D HEXAGON_CPU_TYPE_NAME("v73");
    ++    mc->default_cpu_type =3D HEXAGON_CPU_TYPE_NAME("v68");
     +    mc->default_ram_size =3D 4 * GiB;
     +    mc->max_cpus =3D 8;
     +    mc->default_cpus =3D 8;
 9:  8e81fac5f64 =3D  9:  e5f9d632610 tests/qtest: Add hexagon boot-serial-=
test





>> +    const char *cpu_model;
>> +    DeviceState *gsregs_dev;
>> +    DeviceState *tlb_dev;
>> +    HexagonCPU *cpu_0;
>> +
>> +    qemu_fdt_setprop_string(ms->fdt, "/chosen", "bootargs", ms->kernel_=
cmdline);
>> +
>> +    vms->sys =3D get_system_memory();
>> +
>> +    /* Create APB clock for peripherals */
>> +    vms->apb_clk =3D clock_new(OBJECT(ms), "apb-pclk");
>> +    clock_set_hz(vms->apb_clk, 24000000);
>> +
>> +    memory_region_init_ram(&vms->ram, NULL, "ddr.ram", ms->ram_size,
>> +                           &error_fatal);
>> +    memory_region_add_subregion(vms->sys, 0x0, &vms->ram);
>> +
>> +    if (m_cfg->l2tcm_size) {
>> +        memory_region_init_ram(&vms->tcm, NULL, "tcm.ram", m_cfg->l2tcm=
_size,
>> +                               &error_fatal);
>> +        memory_region_add_subregion(vms->sys, m_cfg->cfgtable.l2tcm_bas=
e << 16,
>> +                                    &vms->tcm);
>> +    }
>> +
>> +    memory_region_init_rom(&vms->cfgtable, NULL, "config_table.rom",
>> +                           sizeof(m_cfg->cfgtable), &error_fatal);
>> +    memory_region_add_subregion(vms->sys, m_cfg->cfgbase, &vms->cfgtabl=
e);
>> +    fdt_add_hvx(vms, m_cfg, &error_fatal);
>> +    cpu_model =3D ms->cpu_type;
>> +
>> +    if (!cpu_model) {
>> +        cpu_model =3D HEXAGON_CPU_TYPE_NAME("v73");
>> +    }
>> +
>> +    gsregs_dev =3D qdev_new(TYPE_HEXAGON_GLOBALREG);
>> +    object_property_add_child(OBJECT(ms), "global-regs", OBJECT(gsregs_=
dev));
>> +    qdev_prop_set_uint64(gsregs_dev, "config-table-addr", m_cfg->cfgbas=
e);
>> +    qdev_prop_set_uint32(gsregs_dev, "dsp-rev", v68_rev);
>> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(gsregs_dev), &error_fatal);
>> +
>> +    tlb_dev =3D qdev_new(TYPE_HEXAGON_TLB);
>> +    object_property_add_child(OBJECT(ms), "tlb", OBJECT(tlb_dev));
>> +    qdev_prop_set_uint32(tlb_dev, "num-entries",
>> +                         m_cfg->cfgtable.jtlb_size_entries);
>> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(tlb_dev), &error_fatal);
>> +
>> +    cpu_0 =3D NULL;
>> +    for (int i =3D 0; i < ms->smp.cpus; i++) {
>> +        HexagonCPU *cpu =3D HEXAGON_CPU(object_new(ms->cpu_type));
>> +        qemu_register_reset(do_cpu_reset, cpu);
>> +
>> +        if (i =3D=3D 0) {
>> +            cpu_0 =3D cpu;
>> +            if (ms->kernel_filename) {
>> +                uint64_t entry =3D load_kernel(vms);
>> +                qdev_prop_set_uint32(DEVICE(cpu_0), "exec-start-addr", =
entry);
>> +            } else if (ms->firmware) {
>> +                uint64_t entry =3D load_bios(vms);
>> +                qdev_prop_set_uint32(DEVICE(cpu_0), "exec-start-addr", =
entry);
>> +            }
>> +        }
>> +        qdev_prop_set_uint32(DEVICE(cpu), "htid", i);
>> +        qdev_prop_set_bit(DEVICE(cpu), "start-powered-off", (i !=3D 0))=
;
>> +        object_property_set_link(OBJECT(cpu), "global-regs",
>> +                                 OBJECT(gsregs_dev), &error_fatal);
>> +        object_property_set_link(OBJECT(cpu), "tlb",
>> +                                 OBJECT(tlb_dev), &error_fatal);
>> +
>> +        if (!qdev_realize_and_unref(DEVICE(cpu), NULL, &error_fatal)) {
>> +            return;
>> +        }
>> +    }
>> +    /* TODO: enable l2vic when l2vic device arrives */
>> +    if (object_class_by_name("l2vic")) {
>> +        vms->l2vic =3D sysbus_create_varargs(
>> +            "l2vic", m_cfg->l2vic_base,
>> +            qdev_get_gpio_in(DEVICE(cpu_0), 0),
>> +            qdev_get_gpio_in(DEVICE(cpu_0), 1),
>> +            qdev_get_gpio_in(DEVICE(cpu_0), 2),
>> +            qdev_get_gpio_in(DEVICE(cpu_0), 3),
>> +            qdev_get_gpio_in(DEVICE(cpu_0), 4),
>> +            qdev_get_gpio_in(DEVICE(cpu_0), 5),
>> +            qdev_get_gpio_in(DEVICE(cpu_0), 6),
>> +            qdev_get_gpio_in(DEVICE(cpu_0), 7), NULL);
>> +
>> +        fdt_add_hvm_pic_node(vms, m_cfg);
>> +        fdt_add_virtio_devices(vms);
>> +        fdt_add_gpt_node(vms);
>> +    }
>> +
>> +    fdt_add_cpu_nodes(vms);
>> +    fdt_add_clocks(vms);
>> +    fdt_add_uart(vms, VIRT_UART0);
>> +
>> +    rom_add_blob_fixed_as("config_table.rom", &m_cfg->cfgtable,
>> +                          sizeof(m_cfg->cfgtable), m_cfg->cfgbase,
>> +                          &address_space_memory);
>> +
>> +
>> +    hexagon_load_fdt(vms);
>> +}
>> +
>> +
>> +static void virt_class_init(ObjectClass *oc, const void *data)
>> +{
>> +    MachineClass *mc =3D MACHINE_CLASS(oc);
>> +
>> +    mc->desc =3D "Hexagon Virtual Machine";
>> +    mc->init =3D virt_init;
>> +    mc->default_cpu_type =3D HEXAGON_CPU_TYPE_NAME("v73");
>> +    mc->default_ram_size =3D 4 * GiB;
>> +    mc->max_cpus =3D 8;
>> +    mc->default_cpus =3D 8;
>> +    mc->is_default =3D false;
>> +    mc->default_kernel_irqchip_split =3D false;
>> +    mc->block_default_type =3D IF_VIRTIO;
>> +    mc->default_boot_order =3D NULL;
>> +    mc->no_cdrom =3D 1;
>> +    mc->numa_mem_supported =3D false;
>> +    mc->default_nic =3D "virtio-mmio-bus";
>> +}
>> +
>> +
>> +static const TypeInfo virt_machine_types[] =3D { {
>> +    .name =3D TYPE_HEXAGON_VIRT_MACHINE,
>> +    .parent =3D TYPE_MACHINE,
>> +    .instance_size =3D sizeof(HexagonVirtMachineState),
>> +    .class_init =3D virt_class_init,
>> +    .instance_init =3D virt_instance_init,
>> +} };
>> +
>> +DEFINE_TYPES(virt_machine_types)
>> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
>> index 355abb4fd24..01781a76caf 100644
>> --- a/target/hexagon/cpu.c
>> +++ b/target/hexagon/cpu.c
>> @@ -68,6 +68,8 @@ static ObjectClass *hexagon_cpu_class_by_name(const ch=
ar *cpu_model)
>>
>>  static const Property hexagon_cpu_properties[] =3D {
>>  #if !defined(CONFIG_USER_ONLY)
>> +    DEFINE_PROP_LINK("tlb", HexagonCPU, tlb, TYPE_HEXAGON_TLB,
>> +                     HexagonTLBState *),
>>      DEFINE_PROP_UINT32("exec-start-addr", HexagonCPU, boot_addr, 0xffff=
ffff),
>>      DEFINE_PROP_LINK("global-regs", HexagonCPU, globalregs,
>>          TYPE_HEXAGON_GLOBALREG, HexagonGlobalRegState *),
>> diff --git a/hw/hexagon/Kconfig b/hw/hexagon/Kconfig
>> index 7b9577f68f7..dc74751d21e 100644
>> --- a/hw/hexagon/Kconfig
>> +++ b/hw/hexagon/Kconfig
>> @@ -3,3 +3,13 @@ config HEX_DSP
>>      default y
>>      depends on HEXAGON && TCG
>>      imply PTIMER
>> +
>> +config HEX_VIRT
>> +    bool
>> +    default y
>> +    depends on HEX_DSP && FDT
>> +    select DEVICE_TREE
>> +    select VIRTIO_MMIO
>> +    select PL011
>> +    select VIRTIO_BLK
>> +    select VIRTIO_SCSI
>> diff --git a/hw/hexagon/meson.build b/hw/hexagon/meson.build
>> index f528d2bc4ab..5b6a5e11a17 100644
>> --- a/hw/hexagon/meson.build
>> +++ b/hw/hexagon/meson.build
>> @@ -4,3 +4,5 @@ hexagon_ss.add(files('hexagon_globalreg.c'))
>>  hexagon_ss.add(when: 'CONFIG_HEX_DSP', if_true: files('hexagon_dsp.c'))
>>
>>  hw_arch +=3D {'hexagon': hexagon_ss}
>> +
>> +hexagon_ss.add(when: 'CONFIG_HEX_VIRT', if_true: files('virt.c'))
>> diff --git a/tests/qemu-iotests/testenv.py b/tests/qemu-iotests/testenv.=
py
>> index c357e6ebf50..86bcdf7cfad 100644
>> --- a/tests/qemu-iotests/testenv.py
>> +++ b/tests/qemu-iotests/testenv.py
>> @@ -259,6 +259,7 @@ def __init__(self, source_dir: str, build_dir: str,
>>              ('arm', 'virt'),
>>              ('aarch64', 'virt'),
>>              ('avr', 'mega2560'),
>> +            ('hexagon', 'virt'),
>>              ('m68k', 'virt'),
>>              ('or1k', 'virt'),
>>              ('riscv32', 'virt'),
>> --
>> 2.34.1
>>

