Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F406510F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYdR-00030i-S0; Wed, 08 Apr 2026 15:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sid.manning@oss.qualcomm.com>)
 id 1wAYTv-0008Po-MP
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:22:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sid.manning@oss.qualcomm.com>)
 id 1wAYTq-0002SM-OG
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:22:31 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 638HXfBT250047
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 19:22:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=VzpLI4JoNdarYfbRQ9xNI/5o
 gWnvJcWkOG3+jAa4A1c=; b=FmCLBfm1BlnDRfK5mvbaCW50OiHHZa5EyYT7HGzK
 xyWTzycXoCMOsYj91scYadK7W5N+KbjvVsjmxO0FI5CmM/05ZVayAzEIWRwNWNio
 gNvMRnmlpzG4XNWTuh1BXG1cQ5RMh5py8GJaiMOsPaYS5i9bgtN+70jLHoBn/ejC
 /hz359YjridvzsTpFEILgpmn1e54T3lVuA6LaE5P5KWY5LXpjNcPjtZ+cBb1GM8I
 8ybO6XqGAEIg/P4zT+L1GJOeUQiZXzXimHxZGvpn4sT2RRgdwGbOxzmxUC18BoTf
 nHj0ZkzMTAhQER09K4Mi/GR2hJNBoVeTVivwGyGjWq4xIA==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd8x9crd3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 19:22:24 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-644548b1d9aso149103d50.1
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 12:22:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775676143; cv=none;
 d=google.com; s=arc-20240605;
 b=gigbRr1vwklKKihCK64KSl4Qro30ygakmVazdeFb5XNxxrgPYXDznKqQ5h8A70rb24
 xkPRam6PSPtScjhwc/GtpGrMvOm1JpgE73lC+Y1/lc7dyvENS2LEL/oj6HI/CIEEIhG6
 81dhjtu4rYXDs7wYJiSN+VCYqjD4aB8HltPpkPUcloVLiuuC+24RF5olvPCNa57Lp6Sr
 ovyiZfVGwOvoAo56tjllFaX8R2jgJlNVk5+nUkAMNSzl3X4Yo75wsiZPuII3o9Z/Recl
 SEP5oViVJmkDeyIRjFEz+GwK+zJj5YYX+U7/nhZck+x4mhWetZRuxMsJL6n4w3cqr5ZR
 PCMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VzpLI4JoNdarYfbRQ9xNI/5ogWnvJcWkOG3+jAa4A1c=;
 fh=M1Q5IIDxPU7nrtIqkOxp+05smWNr/V1Cw40ICQ7seqY=;
 b=aqtwdL+VYCwJnyTxcKwbIwxrw1K9RG3ELL3Osdhyyyuqn+uO7PQ2jNwYTAWROs8KtM
 uqeRSqDcZ763xUYhuizf7tbMZFYoFMxX4R6S5tmcf2Q9JaSMVW9NkSdP6ZX9XRLAYCL/
 sTJL+ETzGdyR9aDEPA6cSNL48tY6Qb/6CR/CgjRyrVqtC88W+vl9ycR7QXI8ZCtJobl7
 m2xdki34nPxPKL/YYbmjfaBJV0L3uOSXKX9VA3T4+FiMBAhgFm08xv9iAzcVFXHe3fzm
 mOvRpha9teGXRYgHSJkubaKFikdh1fZ66ix3ENzPBcFVLubYsfWSwZeCizIdal3kfeUY
 buLA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775676143; x=1776280943; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VzpLI4JoNdarYfbRQ9xNI/5ogWnvJcWkOG3+jAa4A1c=;
 b=gwR5t+5I5znIOkeIRsUUzRPo8EKdKGEaAg2fuDQTGeoHbnfO5UofRS7csebGf9t2zb
 i5ry96h+PBWeSt03Pt9JN9v8siW8l4Zk5UtMfdwbHlQYOTRSq5ZUUXqOwqx2S9eTEecB
 J7w4xRVodMn0QkIuiLaPC8utwSEe2r8SI0pd0a0O5vZcOUUIw8TLmu9oHRdYx0SaTEeu
 RNdHvy0XRn6MpykIKqoOowKAp+EcCBAEbbcQQwvHEVsjZSAPq0Q8IGtWrAQwlRZvz7jZ
 RI1HIyWcaty3SrAUSLLZyWPF22KWZ0/2i5YblXVmS3E8DPYCMd/tvvDpocw47AzB0t6S
 Ygcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775676143; x=1776280943;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VzpLI4JoNdarYfbRQ9xNI/5ogWnvJcWkOG3+jAa4A1c=;
 b=j314Wzn4RafVvXJieuPRkwaYkuyFsGeGQu0mfcmIVr1kr+nVOxK7ZQ6ZJaBWZdy6VE
 1FZ2P3OMsgofKOgKaUR3acrEoPNShbbcEsjcWP7VSK+mfNEIHlrB9U1ra0lwAuuTNLSH
 1ux3To0yTKARJQ5jcOST468lzrVABNzXX3yzMJ3PeXTPhLkW8d1Wi+XzXXiPh0/rDjRR
 1dRlrK3s14TglZuoLzDZrOurrJANUu7EIFeCb+7rc8QaYBvNuACLPOajdr32oAZPvxxc
 NtKloVGIZybGxEFF+4/7LL7LJosNqK8bmTelrH1SvTEcNtZ2OWCFgwNHNVjolzqgLVnn
 N7+A==
X-Gm-Message-State: AOJu0Ywd8BotGi5ZPxzqv3Y6YStZuNg+SjYZ4rg0hNEHd95I1EPi3dIm
 nODG7c6yimnl1GnLiDO/NlTINrDqDkkGf7qTsRkjhZieLJvwRQlfmYjqIorTw68+WFl0gFZOADP
 SsI4x4siBKJfYuiGeJQvbBjwIToWUztKSAqNY+ryJj/IOq1+i0vp0vnJzNWmPDGCM5bT1ebUWf1
 pB6OhWvCbdrY86i/yZJ9aWLpZIKx8VwRlx
X-Gm-Gg: AeBDieuiOtX+B18yoTFmp7u4vz4g0/zzdIoI+gSreAqgqVgZY6eYnBiwCW5oBOREJQA
 4VyLCg3K7+9HdTcv8EUN+unU190GHSt0dvi6oOVWwZ5gDDckZBQbxQWx5SZtcq7u7h1GfOPo2uX
 UpzIiZwzMqlBfeB72KpJXlFoSi+SUuiXUDzhLxruKYZ1BuxG0w/G35TOr1R+ScS7e3ke+Jd1xRx
 Ztv1+E=
X-Received: by 2002:a53:bb85:0:b0:64f:bdcf:a494 with SMTP id
 956f58d0204a3-65048873b5dmr15467738d50.58.1775676143031; 
 Wed, 08 Apr 2026 12:22:23 -0700 (PDT)
X-Received: by 2002:a53:bb85:0:b0:64f:bdcf:a494 with SMTP id
 956f58d0204a3-65048873b5dmr15467709d50.58.1775676142343; Wed, 08 Apr 2026
 12:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260408042149.1902796-1-brian.cain@oss.qualcomm.com>
 <20260408042149.1902796-9-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260408042149.1902796-9-brian.cain@oss.qualcomm.com>
From: Sid Manning <sid.manning@oss.qualcomm.com>
Date: Wed, 8 Apr 2026 14:22:09 -0500
X-Gm-Features: AQROBzBVK6X0lr-7wENnvmVwCu-KlcSDtSZOkVJ1SFPJp4LRJeIQcJ1NHPRmti0
Message-ID: <CAJpW4SULdJ=zWw+ir3FBaVFvidzwTiHhGZ361A1BETHADThteQ@mail.gmail.com>
Subject: Re: [PATCH v4 8/9] hw/hexagon: Define hexagon "virt" machine
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, ale@rev.ng, anjo@rev.ng,
 Brian Cain <bcain@quicinc.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000b36796064ef7d148"
X-Authority-Analysis: v=2.4 cv=Rr716imK c=1 sm=1 tr=0 ts=69d6aaf0 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=LZxu0lJlvx2sLTx_hnAA:9 a=QEXdDO2ut3YA:10
 a=cJMQb2-ojAbFt5Aj4qQA:9 a=W7m0g9nuS2lKi5jU:21 a=lqcHg5cX4UMA:10
 a=nd2WpGr1bMy9NW-iytEl:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE4MSBTYWx0ZWRfXx/NsFjK2EIWK
 Aaer8fTKguVC5Ig/8BVM4SUyRpcrpP1HeKd9ZNU3wKMjKrI0jD45eg6NU6fr+6SEuKqszEdZZYq
 VDquaWEpiXUO5Zzbh8/jjMeutz0DikGwByjZCRQNY/9mYIZ0/4TEyM1TG74vwUwKOHyO1R0Or11
 15yEZRcNdNWjcZMRab9KWv3yHkpBoWME5IovxLc8ecxPOuTyJLdciwQ9eIqvnQEFr/QQndfG/jS
 zBy5Zkw4bz0dOdWmkokC8TBZQYJ9F0xyTU+wkx1SnnWE2BsxMSNAN1d/J5Uw6mDmWKkY/aNCeAT
 C3RqF+iUGKMp0JtwdDFqHLolXiUHEBSJ3WFYo0B+Bl7V5aLcgurEV+NTrfn5j9n6eZpr3r1YpBB
 xxJBGcwa0Ly6pUHvNBRcOTfd7Rv0N5wSV0V1soTcrjIfJVdUAO6s5/tNZ/znXNrlHDXAhDc+U1z
 iKKsmiVBlYNcteqLUoQ==
X-Proofpoint-ORIG-GUID: bNdc0tvdgC55qqlrSqI91NfhBemysanv
X-Proofpoint-GUID: bNdc0tvdgC55qqlrSqI91NfhBemysanv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080181
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=sid.manning@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 08 Apr 2026 15:32:16 -0400
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

--000000000000b36796064ef7d148
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 11:22=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com>
wrote:

> From: Brian Cain <bcain@quicinc.com>
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  configs/devices/hexagon-softmmu/default.mak |   1 +
>  configs/targets/hexagon-softmmu.mak         |   1 +
>  include/hw/hexagon/virt.h                   |  43 ++
>  hw/hexagon/virt.c                           | 456 ++++++++++++++++++++
>  target/hexagon/cpu.c                        |   2 +
>  hw/hexagon/Kconfig                          |  10 +
>  hw/hexagon/meson.build                      |   2 +
>  tests/qemu-iotests/testenv.py               |   1 +
>  8 files changed, 516 insertions(+)
>  create mode 100644 include/hw/hexagon/virt.h
>  create mode 100644 hw/hexagon/virt.c
>
> diff --git a/configs/devices/hexagon-softmmu/default.mak
> b/configs/devices/hexagon-softmmu/default.mak
> index 08e709aea72..37b4f9f3237 100644
> --- a/configs/devices/hexagon-softmmu/default.mak
> +++ b/configs/devices/hexagon-softmmu/default.mak
> @@ -3,5 +3,6 @@
>  # Uncomment the following lines to disable these optional devices:
>
>  # Boards are selected by default, uncomment to keep out of the build.
> +# CONFIG_HEX_VIRT=3Dy
>  # CONFIG_HEX_DSP=3Dy
>  # CONFIG_L2VIC=3Dy
> diff --git a/configs/targets/hexagon-softmmu.mak
> b/configs/targets/hexagon-softmmu.mak
> index fdfa29b4f39..a77c100f0c5 100644
> --- a/configs/targets/hexagon-softmmu.mak
> +++ b/configs/targets/hexagon-softmmu.mak
> @@ -5,3 +5,4 @@ TARGET_XML_FILES=3Dhexagon-core.xml hexagon-hvx.xml
>  TARGET_LONG_BITS=3D32
>  TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy
>  TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
> +TARGET_NEED_FDT=3Dy
> diff --git a/include/hw/hexagon/virt.h b/include/hw/hexagon/virt.h
> new file mode 100644
> index 00000000000..a54eac5cf00
> --- /dev/null
> +++ b/include/hw/hexagon/virt.h
> @@ -0,0 +1,43 @@
> +/*
> + * Definitions for hexagon virt board.
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_HEXAGONVIRT_H
> +#define HW_HEXAGONVIRT_H
> +
> +#include "hw/core/boards.h"
> +#include "target/hexagon/cpu.h"
> +
> +struct HexagonVirtMachineState {
> +    /*< private >*/
> +    MachineState parent_obj;
> +
> +    int fdt_size;
> +    MemoryRegion *sys;
> +    MemoryRegion cfgtable;
> +    MemoryRegion ram;
> +    MemoryRegion tcm;
> +    MemoryRegion vtcm;
> +    MemoryRegion bios;
> +    DeviceState *l2vic;
> +    Clock *apb_clk;
> +};
> +
> +void hexagon_load_fdt(const struct HexagonVirtMachineState *vms);
> +
> +enum {
> +    VIRT_UART0,
> +    VIRT_QTMR0,
> +    VIRT_QTMR1,
> +    VIRT_GPT,
> +    VIRT_MMIO,
> +    VIRT_FDT,
> +};
> +
> +#define TYPE_HEXAGON_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
> +OBJECT_DECLARE_SIMPLE_TYPE(HexagonVirtMachineState, HEXAGON_VIRT_MACHINE=
)
> +
> +#endif /* HW_HEXAGONVIRT_H */
> diff --git a/hw/hexagon/virt.c b/hw/hexagon/virt.c
> new file mode 100644
> index 00000000000..49ee1aad2fe
> --- /dev/null
> +++ b/hw/hexagon/virt.c
> @@ -0,0 +1,456 @@
> +/*
> + * Hexagon virt emulation
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/hexagon/virt.h"
> +#include "elf.h"
> +#include "hw/char/pl011.h"
> +#include "hw/core/clock.h"
> +#include "hw/core/sysbus-fdt.h"
> +#include "hw/hexagon/hexagon.h"
> +#include "hw/hexagon/hexagon_globalreg.h"
> +#include "hw/hexagon/hexagon_tlb.h"
> +#include "hw/core/loader.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/core/qdev-clock.h"
> +#include "hw/core/register.h"
> +#include "qemu/error-report.h"
> +#include "qemu/guest-random.h"
> +#include "qemu/units.h"
> +#include "elf.h"
> +#include "machine_cfg_v68n_1024.h.inc"
> +#include "system/address-spaces.h"
> +#include "system/device_tree.h"
> +#include "system/reset.h"
> +#include "system/system.h"
> +#include <libfdt.h>
> +
> +static const int VIRTIO_DEV_COUNT =3D 8;
> +
> +static const MemMapEntry base_memmap[] =3D {
> +    [VIRT_UART0] =3D { 0x10000000, 0x00000200 },
> +    [VIRT_MMIO] =3D { 0x11000000, 0x1000000, },
> +    [VIRT_GPT] =3D { 0xab000000, 0x00001000 },
> +    [VIRT_FDT] =3D { 0x99800000, 0x00400000 },
> +};
> +
> +static const int irqmap[] =3D {
> +    [VIRT_MMIO] =3D 18, /* ...to 18 + VIRTIO_DEV_COUNT - 1 */
> +    [VIRT_GPT] =3D 12,
> +    [VIRT_UART0] =3D 15,
> +    [VIRT_QTMR0] =3D 2,
> +    [VIRT_QTMR1] =3D 4,
> +};
> +
> +
> +static void create_fdt(HexagonVirtMachineState *vms)
> +{
> +    MachineState *ms =3D MACHINE(vms);
> +    void *fdt =3D create_device_tree(&vms->fdt_size);
> +    uint8_t rng_seed[32];
> +
> +    if (!fdt) {
> +        error_report("create_device_tree() failed");
> +        exit(1);
> +    }
> +
> +    ms->fdt =3D fdt;
> +
> +    qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 0x2);
> +    qemu_fdt_setprop_cell(fdt, "/", "#size-cells", 0x1);
> +    qemu_fdt_setprop_string(fdt, "/", "model", "hexagon-virt,qemu");
> +    qemu_fdt_setprop_string(fdt, "/", "compatible", "qcom,sm8150");
> +
> +    qemu_fdt_add_subnode(fdt, "/soc");
> +    qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
> +    qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x1);
> +    qemu_fdt_setprop(fdt, "/soc", "ranges", NULL, 0);
> +
> +    qemu_fdt_add_subnode(fdt, "/chosen");
> +    qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
> +    qemu_fdt_setprop(fdt, "/chosen", "rng-seed", rng_seed,
> sizeof(rng_seed));
> +}
> +
> +static void fdt_add_hvx(HexagonVirtMachineState *vms,
> +                        const struct hexagon_machine_config *m_cfg,
> +                        Error **errp)
> +{
> +    const MachineState *ms =3D MACHINE(vms);
> +    uint32_t vtcm_size_bytes =3D m_cfg->cfgtable.vtcm_size_kb * 1024;
> +    if (vtcm_size_bytes > 0) {
> +        memory_region_init_ram(&vms->vtcm, NULL, "vtcm.ram",
> vtcm_size_bytes,
> +                               errp);
> +        memory_region_add_subregion(vms->sys, m_cfg->cfgtable.vtcm_base
> << 16,
> +                                    &vms->vtcm);
> +
> +        qemu_fdt_add_subnode(ms->fdt, "/soc/vtcm");
> +        qemu_fdt_setprop_string(ms->fdt, "/soc/vtcm", "compatible",
> +                                "qcom,hexagon_vtcm");
> +
> +        assert(sizeof(m_cfg->cfgtable.vtcm_base) =3D=3D sizeof(uint32_t)=
);
> +        qemu_fdt_setprop_cells(ms->fdt, "/soc/vtcm", "reg", 0,
> +                               m_cfg->cfgtable.vtcm_base << 16,
> +                               vtcm_size_bytes);
> +    }
> +
> +    if (m_cfg->cfgtable.ext_contexts > 0) {
> +        qemu_fdt_add_subnode(ms->fdt, "/soc/hvx");
> +        qemu_fdt_setprop_string(ms->fdt, "/soc/hvx", "compatible",
> +                                "qcom,hexagon-hvx");
> +        qemu_fdt_setprop_cells(ms->fdt, "/soc/hvx", "qcom,hvx-max-ctxts"=
,
> +                               m_cfg->cfgtable.ext_contexts);
> +        qemu_fdt_setprop_cells(ms->fdt, "/soc/hvx", "qcom,hvx-vlength",
> +                               m_cfg->cfgtable.hvx_vec_log_length);
> +    }
> +}
> +
> +static int32_t irq_hvm_ic_phandle =3D -1;
> +static void fdt_add_hvm_pic_node(HexagonVirtMachineState *vms,
> +                                 const struct hexagon_machine_config
> *m_cfg)
> +{
> +    MachineState *ms =3D MACHINE(vms);
> +    irq_hvm_ic_phandle =3D qemu_fdt_alloc_phandle(ms->fdt);
> +
> +    qemu_fdt_setprop_cell(ms->fdt, "/soc", "interrupt-parent",
> +                          irq_hvm_ic_phandle);
> +
> +    qemu_fdt_add_subnode(ms->fdt, "/soc/interrupt-controller");
> +    qemu_fdt_setprop_cell(ms->fdt, "/soc/interrupt-controller",
> +                          "#address-cells", 2);
> +    qemu_fdt_setprop_cell(ms->fdt, "/soc/interrupt-controller",
> +                          "#interrupt-cells", 2);
> +    qemu_fdt_setprop_string(ms->fdt, "/soc/interrupt-controller",
> "compatible",
> +                            "qcom,h2-pic,hvm-pic");
> +    qemu_fdt_setprop(ms->fdt, "/soc/interrupt-controller",
> +                     "interrupt-controller", NULL, 0);
> +    qemu_fdt_setprop_cell(ms->fdt, "/soc/interrupt-controller", "phandle=
",
> +                          irq_hvm_ic_phandle);
> +
> +    sysbus_mmio_map(SYS_BUS_DEVICE(vms->l2vic), 1,
> +                    m_cfg->cfgtable.fastl2vic_base << 16);
> +}
> +
> +
> +static void fdt_add_gpt_node(HexagonVirtMachineState *vms)
> +{
> +    g_autofree char *name =3D NULL;
> +    MachineState *ms =3D MACHINE(vms);
> +
> +    name =3D g_strdup_printf("/soc/gpt@%" PRIx64,
> +                           (int64_t)base_memmap[VIRT_GPT].base);
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible",
> +                            "qcom,h2-timer,hvm-timer");
> +    qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", irqmap[VIRT_GPT]=
,
> 0);
> +    qemu_fdt_setprop_cells(ms->fdt, name, "reg", 0x0,
> +                           base_memmap[VIRT_GPT].base,
> +                           base_memmap[VIRT_GPT].size);
> +}
> +
> +static int32_t clock_phandle =3D -1;
> +static void fdt_add_clocks(const HexagonVirtMachineState *vms)
> +{
> +    MachineState *ms =3D MACHINE(vms);
> +    clock_phandle =3D qemu_fdt_alloc_phandle(ms->fdt);
> +    qemu_fdt_add_subnode(ms->fdt, "/apb-pclk");
> +    qemu_fdt_setprop_string(ms->fdt, "/apb-pclk", "compatible",
> "fixed-clock");
> +    qemu_fdt_setprop_cell(ms->fdt, "/apb-pclk", "#clock-cells", 0x0);
> +    qemu_fdt_setprop_cell(ms->fdt, "/apb-pclk", "clock-frequency",
> 24000000);
> +    qemu_fdt_setprop_string(ms->fdt, "/apb-pclk", "clock-output-names",
> +                            "clk24mhz");
> +    qemu_fdt_setprop_cell(ms->fdt, "/apb-pclk", "phandle", clock_phandle=
);
> +}
> +
> +static void fdt_add_uart(const HexagonVirtMachineState *vms, int uart)
> +{
> +    char *nodename;
> +    hwaddr base =3D base_memmap[uart].base;
> +    hwaddr size =3D base_memmap[uart].size;
> +    assert(uart =3D=3D 0);
> +    int irq =3D irqmap[VIRT_UART0 + uart];
> +    const char compat[] =3D "arm,pl011\0arm,primecell";
> +    const char clocknames[] =3D "uartclk\0apb_pclk";
> +    MachineState *ms =3D MACHINE(vms);
> +    DeviceState *dev;
> +    SysBusDevice *s;
> +
> +    dev =3D qdev_new(TYPE_PL011);
> +    s =3D SYS_BUS_DEVICE(dev);
> +    qdev_prop_set_chr(dev, "chardev", serial_hd(0));
> +    qdev_connect_clock_in(dev, "clk", vms->apb_clk);
> +    sysbus_realize_and_unref(s, &error_fatal);
> +    sysbus_mmio_map(s, 0, base);
> +    if (vms->l2vic) {
> +        sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->l2vic, irq));
> +    }
> +
> +    nodename =3D g_strdup_printf("/pl011@%" PRIx64, base);
> +    qemu_fdt_add_subnode(ms->fdt, nodename);
> +
> +    /* Note that we can't use setprop_string because of the embedded NUL
> */
> +    qemu_fdt_setprop(ms->fdt, nodename, "compatible", compat,
> sizeof(compat));
> +    qemu_fdt_setprop_cells(ms->fdt, nodename, "reg", 0, base, size);
> +    if (vms->l2vic) {
> +        qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
> +                               32 + irq, 0);
> +        qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
> +                              irq_hvm_ic_phandle);
> +    }
> +    qemu_fdt_setprop_cells(ms->fdt, nodename, "clocks", clock_phandle,
> +                           clock_phandle);
> +    qemu_fdt_setprop(ms->fdt, nodename, "clock-names", clocknames,
> +                     sizeof(clocknames));
> +
> +    qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nodename)=
;
> +    qemu_fdt_add_subnode(ms->fdt, "/aliases");
> +    qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", nodename);
> +
> +    g_free(nodename);
> +}
> +
> +static void fdt_add_cpu_nodes(const HexagonVirtMachineState *vms)
> +{
> +    MachineState *ms =3D MACHINE(vms);
> +    qemu_fdt_add_subnode(ms->fdt, "/cpus");
> +    qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#address-cells", 0x1);
> +    qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#size-cells", 0x0);
> +
> +    /* cpu nodes */
> +    for (int num =3D ms->smp.cpus - 1; num >=3D 0; num--) {
> +        char *nodename =3D g_strdup_printf("/cpus/cpu@%d", num);
> +        qemu_fdt_add_subnode(ms->fdt, nodename);
> +        qemu_fdt_setprop_string(ms->fdt, nodename, "device_type", "cpu")=
;
> +        qemu_fdt_setprop_cell(ms->fdt, nodename, "reg", num);
> +        qemu_fdt_setprop_cell(ms->fdt, nodename, "phandle",
> +                              qemu_fdt_alloc_phandle(ms->fdt));
> +        g_free(nodename);
> +    }
> +}
> +
> +
> +static void fdt_add_virtio_devices(const HexagonVirtMachineState *vms)
> +{
> +    MachineState *ms =3D MACHINE(vms);
> +    /* VirtIO MMIO devices */
> +    for (int i =3D 0; i < VIRTIO_DEV_COUNT; i++) {
> +        char *nodename;
> +        int irq =3D irqmap[VIRT_MMIO] + i;
> +        size_t size =3D base_memmap[VIRT_MMIO].size;
> +        hwaddr base =3D base_memmap[VIRT_MMIO].base + i * size;
> +
> +        nodename =3D g_strdup_printf("/virtio_mmio@%" PRIx64, base);
> +        qemu_fdt_add_subnode(ms->fdt, nodename);
> +        qemu_fdt_setprop_string(ms->fdt, nodename, "compatible",
> "virtio,mmio");
> +        qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg", 2, base, =
1,
> +                                     size);
> +        qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts", irq, 0);
> +        qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
> +                              irq_hvm_ic_phandle);
> +
> +        sysbus_create_simple(
> +            "virtio-mmio", base,
> +            qdev_get_gpio_in(vms->l2vic, irqmap[VIRT_MMIO] + i));
> +
> +        g_free(nodename);
> +    }
> +}
> +
> +static void virt_instance_init(Object *obj)
> +{
> +    HexagonVirtMachineState *vms =3D HEXAGON_VIRT_MACHINE(obj);
> +
> +    create_fdt(vms);
> +}
> +
> +void hexagon_load_fdt(const HexagonVirtMachineState *vms)
> +{
> +    MachineState *ms =3D MACHINE(vms);
> +    hwaddr fdt_addr =3D base_memmap[VIRT_FDT].base;
> +    uint32_t fdtsize =3D vms->fdt_size;
> +
> +    g_assert(fdtsize <=3D base_memmap[VIRT_FDT].size);
> +    /* copy in the device tree */
> +    rom_add_blob_fixed_as("fdt", ms->fdt, fdtsize, fdt_addr,
> +                          &address_space_memory);
> +    qemu_register_reset_nosnapshotload(
> +        qemu_fdt_randomize_seeds,
> +        rom_ptr_for_as(&address_space_memory, fdt_addr, fdtsize));
> +}
> +
> +static uint64_t load_kernel(const HexagonVirtMachineState *vms)
> +{
> +    MachineState *ms =3D MACHINE(vms);
> +    uint64_t entry =3D 0;
> +    if (load_elf_ram_sym(ms->kernel_filename, NULL, NULL, NULL, &entry,
> NULL,
> +                         NULL, NULL, 0, EM_HEXAGON, 0, 0,
> &address_space_memory,
> +                         false, NULL) > 0) {
> +        return entry;
> +    }
> +    error_report("error loading '%s'", ms->kernel_filename);
> +    exit(1);
> +}
> +
> +static uint64_t load_bios(HexagonVirtMachineState *vms)
> +{
> +    MachineState *ms =3D MACHINE(vms);
> +    uint64_t bios_addr =3D 0x0;  /* Load BIOS at reset vector address 0x=
0 */
> +    int bios_size;
> +
> +    bios_size =3D load_image_targphys(ms->firmware ?: "",
> +                                    bios_addr, 64 * 1024, NULL);
> +    if (bios_size < 0) {
> +        error_report("Could not load BIOS '%s'", ms->firmware ?: "");
> +        exit(1);
> +    }
> +
> +    return bios_addr;  /* Return entry point at address 0x0 */
> +}
> +
> +static void do_cpu_reset(void *opaque)
> +{
> +    HexagonCPU *cpu =3D opaque;
> +    CPUState *cs =3D CPU(cpu);
> +    cpu_reset(cs);
> +}
> +
> +static void virt_init(MachineState *ms)
> +{
> +    HexagonVirtMachineState *vms =3D HEXAGON_VIRT_MACHINE(ms);
> +    const struct hexagon_machine_config *m_cfg =3D &v68n_1024;
>
This is v68 but in virt_class_init  mc->default_cpu_type is set to v73,
should that be 68?


+    const char *cpu_model;
> +    DeviceState *gsregs_dev;
> +    DeviceState *tlb_dev;
> +    HexagonCPU *cpu_0;
> +
> +    qemu_fdt_setprop_string(ms->fdt, "/chosen", "bootargs",
> ms->kernel_cmdline);
> +
> +    vms->sys =3D get_system_memory();
> +
> +    /* Create APB clock for peripherals */
> +    vms->apb_clk =3D clock_new(OBJECT(ms), "apb-pclk");
> +    clock_set_hz(vms->apb_clk, 24000000);
> +
> +    memory_region_init_ram(&vms->ram, NULL, "ddr.ram", ms->ram_size,
> +                           &error_fatal);
> +    memory_region_add_subregion(vms->sys, 0x0, &vms->ram);
> +
> +    if (m_cfg->l2tcm_size) {
> +        memory_region_init_ram(&vms->tcm, NULL, "tcm.ram",
> m_cfg->l2tcm_size,
> +                               &error_fatal);
> +        memory_region_add_subregion(vms->sys, m_cfg->cfgtable.l2tcm_base
> << 16,
> +                                    &vms->tcm);
> +    }
> +
> +    memory_region_init_rom(&vms->cfgtable, NULL, "config_table.rom",
> +                           sizeof(m_cfg->cfgtable), &error_fatal);
> +    memory_region_add_subregion(vms->sys, m_cfg->cfgbase, &vms->cfgtable=
);
> +    fdt_add_hvx(vms, m_cfg, &error_fatal);
> +    cpu_model =3D ms->cpu_type;
> +
> +    if (!cpu_model) {
> +        cpu_model =3D HEXAGON_CPU_TYPE_NAME("v73");
> +    }
> +
> +    gsregs_dev =3D qdev_new(TYPE_HEXAGON_GLOBALREG);
> +    object_property_add_child(OBJECT(ms), "global-regs",
> OBJECT(gsregs_dev));
> +    qdev_prop_set_uint64(gsregs_dev, "config-table-addr", m_cfg->cfgbase=
);
> +    qdev_prop_set_uint32(gsregs_dev, "dsp-rev", v68_rev);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(gsregs_dev), &error_fatal);
> +
> +    tlb_dev =3D qdev_new(TYPE_HEXAGON_TLB);
> +    object_property_add_child(OBJECT(ms), "tlb", OBJECT(tlb_dev));
> +    qdev_prop_set_uint32(tlb_dev, "num-entries",
> +                         m_cfg->cfgtable.jtlb_size_entries);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(tlb_dev), &error_fatal);
> +
> +    cpu_0 =3D NULL;
> +    for (int i =3D 0; i < ms->smp.cpus; i++) {
> +        HexagonCPU *cpu =3D HEXAGON_CPU(object_new(ms->cpu_type));
> +        qemu_register_reset(do_cpu_reset, cpu);
> +
> +        if (i =3D=3D 0) {
> +            cpu_0 =3D cpu;
> +            if (ms->kernel_filename) {
> +                uint64_t entry =3D load_kernel(vms);
> +                qdev_prop_set_uint32(DEVICE(cpu_0), "exec-start-addr",
> entry);
> +            } else if (ms->firmware) {
> +                uint64_t entry =3D load_bios(vms);
> +                qdev_prop_set_uint32(DEVICE(cpu_0), "exec-start-addr",
> entry);
> +            }
> +        }
> +        qdev_prop_set_uint32(DEVICE(cpu), "htid", i);
> +        qdev_prop_set_bit(DEVICE(cpu), "start-powered-off", (i !=3D 0));
> +        object_property_set_link(OBJECT(cpu), "global-regs",
> +                                 OBJECT(gsregs_dev), &error_fatal);
> +        object_property_set_link(OBJECT(cpu), "tlb",
> +                                 OBJECT(tlb_dev), &error_fatal);
> +
> +        if (!qdev_realize_and_unref(DEVICE(cpu), NULL, &error_fatal)) {
> +            return;
> +        }
> +    }
> +    /* TODO: enable l2vic when l2vic device arrives */
> +    if (object_class_by_name("l2vic")) {
> +        vms->l2vic =3D sysbus_create_varargs(
> +            "l2vic", m_cfg->l2vic_base,
> +            qdev_get_gpio_in(DEVICE(cpu_0), 0),
> +            qdev_get_gpio_in(DEVICE(cpu_0), 1),
> +            qdev_get_gpio_in(DEVICE(cpu_0), 2),
> +            qdev_get_gpio_in(DEVICE(cpu_0), 3),
> +            qdev_get_gpio_in(DEVICE(cpu_0), 4),
> +            qdev_get_gpio_in(DEVICE(cpu_0), 5),
> +            qdev_get_gpio_in(DEVICE(cpu_0), 6),
> +            qdev_get_gpio_in(DEVICE(cpu_0), 7), NULL);
> +
> +        fdt_add_hvm_pic_node(vms, m_cfg);
> +        fdt_add_virtio_devices(vms);
> +        fdt_add_gpt_node(vms);
> +    }
> +
> +    fdt_add_cpu_nodes(vms);
> +    fdt_add_clocks(vms);
> +    fdt_add_uart(vms, VIRT_UART0);
> +
> +    rom_add_blob_fixed_as("config_table.rom", &m_cfg->cfgtable,
> +                          sizeof(m_cfg->cfgtable), m_cfg->cfgbase,
> +                          &address_space_memory);
> +
> +
> +    hexagon_load_fdt(vms);
> +}
> +
> +
> +static void virt_class_init(ObjectClass *oc, const void *data)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +
> +    mc->desc =3D "Hexagon Virtual Machine";
> +    mc->init =3D virt_init;
> +    mc->default_cpu_type =3D HEXAGON_CPU_TYPE_NAME("v73");
> +    mc->default_ram_size =3D 4 * GiB;
> +    mc->max_cpus =3D 8;
> +    mc->default_cpus =3D 8;
> +    mc->is_default =3D false;
> +    mc->default_kernel_irqchip_split =3D false;
> +    mc->block_default_type =3D IF_VIRTIO;
> +    mc->default_boot_order =3D NULL;
> +    mc->no_cdrom =3D 1;
> +    mc->numa_mem_supported =3D false;
> +    mc->default_nic =3D "virtio-mmio-bus";
> +}
> +
> +
> +static const TypeInfo virt_machine_types[] =3D { {
> +    .name =3D TYPE_HEXAGON_VIRT_MACHINE,
> +    .parent =3D TYPE_MACHINE,
> +    .instance_size =3D sizeof(HexagonVirtMachineState),
> +    .class_init =3D virt_class_init,
> +    .instance_init =3D virt_instance_init,
> +} };
> +
> +DEFINE_TYPES(virt_machine_types)
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 355abb4fd24..01781a76caf 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -68,6 +68,8 @@ static ObjectClass *hexagon_cpu_class_by_name(const cha=
r
> *cpu_model)
>
>  static const Property hexagon_cpu_properties[] =3D {
>  #if !defined(CONFIG_USER_ONLY)
> +    DEFINE_PROP_LINK("tlb", HexagonCPU, tlb, TYPE_HEXAGON_TLB,
> +                     HexagonTLBState *),
>      DEFINE_PROP_UINT32("exec-start-addr", HexagonCPU, boot_addr,
> 0xffffffff),
>      DEFINE_PROP_LINK("global-regs", HexagonCPU, globalregs,
>          TYPE_HEXAGON_GLOBALREG, HexagonGlobalRegState *),
> diff --git a/hw/hexagon/Kconfig b/hw/hexagon/Kconfig
> index 7b9577f68f7..dc74751d21e 100644
> --- a/hw/hexagon/Kconfig
> +++ b/hw/hexagon/Kconfig
> @@ -3,3 +3,13 @@ config HEX_DSP
>      default y
>      depends on HEXAGON && TCG
>      imply PTIMER
> +
> +config HEX_VIRT
> +    bool
> +    default y
> +    depends on HEX_DSP && FDT
> +    select DEVICE_TREE
> +    select VIRTIO_MMIO
> +    select PL011
> +    select VIRTIO_BLK
> +    select VIRTIO_SCSI
> diff --git a/hw/hexagon/meson.build b/hw/hexagon/meson.build
> index f528d2bc4ab..5b6a5e11a17 100644
> --- a/hw/hexagon/meson.build
> +++ b/hw/hexagon/meson.build
> @@ -4,3 +4,5 @@ hexagon_ss.add(files('hexagon_globalreg.c'))
>  hexagon_ss.add(when: 'CONFIG_HEX_DSP', if_true: files('hexagon_dsp.c'))
>
>  hw_arch +=3D {'hexagon': hexagon_ss}
> +
> +hexagon_ss.add(when: 'CONFIG_HEX_VIRT', if_true: files('virt.c'))
> diff --git a/tests/qemu-iotests/testenv.py b/tests/qemu-iotests/testenv.p=
y
> index c357e6ebf50..86bcdf7cfad 100644
> --- a/tests/qemu-iotests/testenv.py
> +++ b/tests/qemu-iotests/testenv.py
> @@ -259,6 +259,7 @@ def __init__(self, source_dir: str, build_dir: str,
>              ('arm', 'virt'),
>              ('aarch64', 'virt'),
>              ('avr', 'mega2560'),
> +            ('hexagon', 'virt'),
>              ('m68k', 'virt'),
>              ('or1k', 'virt'),
>              ('riscv32', 'virt'),
> --
> 2.34.1
>
>

--000000000000b36796064ef7d148
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Apr 7, =
2026 at 11:22=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qu=
alcomm.com">brian.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">From: Brian Cain &lt;<a href=3D"mail=
to:bcain@quicinc.com" target=3D"_blank">bcain@quicinc.com</a>&gt;<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0configs/devices/hexagon-softmmu/default.mak |=C2=A0 =C2=A01 +<br>
=C2=A0configs/targets/hexagon-softmmu.mak=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
|=C2=A0 =C2=A01 +<br>
=C2=A0include/hw/hexagon/virt.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 43 ++<br>
=C2=A0hw/hexagon/virt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 456 ++++++++++++++++++++<br>
=C2=A0target/hexagon/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +<br>
=C2=A0hw/hexagon/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 10 +<br>
=C2=A0hw/hexagon/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +<br>
=C2=A0tests/qemu-iotests/testenv.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A08 files changed, 516 insertions(+)<br>
=C2=A0create mode 100644 include/hw/hexagon/virt.h<br>
=C2=A0create mode 100644 hw/hexagon/virt.c<br>
<br>
diff --git a/configs/devices/hexagon-softmmu/default.mak b/configs/devices/=
hexagon-softmmu/default.mak<br>
index 08e709aea72..37b4f9f3237 100644<br>
--- a/configs/devices/hexagon-softmmu/default.mak<br>
+++ b/configs/devices/hexagon-softmmu/default.mak<br>
@@ -3,5 +3,6 @@<br>
=C2=A0# Uncomment the following lines to disable these optional devices:<br=
>
<br>
=C2=A0# Boards are selected by default, uncomment to keep out of the build.=
<br>
+# CONFIG_HEX_VIRT=3Dy<br>
=C2=A0# CONFIG_HEX_DSP=3Dy<br>
=C2=A0# CONFIG_L2VIC=3Dy<br>
diff --git a/configs/targets/hexagon-softmmu.mak b/configs/targets/hexagon-=
softmmu.mak<br>
index fdfa29b4f39..a77c100f0c5 100644<br>
--- a/configs/targets/hexagon-softmmu.mak<br>
+++ b/configs/targets/hexagon-softmmu.mak<br>
@@ -5,3 +5,4 @@ TARGET_XML_FILES=3Dhexagon-core.xml hexagon-hvx.xml<br>
=C2=A0TARGET_LONG_BITS=3D32<br>
=C2=A0TARGET_NOT_USING_LEGACY_LDST_PHYS_API=3Dy<br>
=C2=A0TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy<br>
+TARGET_NEED_FDT=3Dy<br>
diff --git a/include/hw/hexagon/virt.h b/include/hw/hexagon/virt.h<br>
new file mode 100644<br>
index 00000000000..a54eac5cf00<br>
--- /dev/null<br>
+++ b/include/hw/hexagon/virt.h<br>
@@ -0,0 +1,43 @@<br>
+/*<br>
+ * Definitions for hexagon virt board.<br>
+ *<br>
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+<br>
+#ifndef HW_HEXAGONVIRT_H<br>
+#define HW_HEXAGONVIRT_H<br>
+<br>
+#include &quot;hw/core/boards.h&quot;<br>
+#include &quot;target/hexagon/cpu.h&quot;<br>
+<br>
+struct HexagonVirtMachineState {<br>
+=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
+=C2=A0 =C2=A0 MachineState parent_obj;<br>
+<br>
+=C2=A0 =C2=A0 int fdt_size;<br>
+=C2=A0 =C2=A0 MemoryRegion *sys;<br>
+=C2=A0 =C2=A0 MemoryRegion cfgtable;<br>
+=C2=A0 =C2=A0 MemoryRegion ram;<br>
+=C2=A0 =C2=A0 MemoryRegion tcm;<br>
+=C2=A0 =C2=A0 MemoryRegion vtcm;<br>
+=C2=A0 =C2=A0 MemoryRegion bios;<br>
+=C2=A0 =C2=A0 DeviceState *l2vic;<br>
+=C2=A0 =C2=A0 Clock *apb_clk;<br>
+};<br>
+<br>
+void hexagon_load_fdt(const struct HexagonVirtMachineState *vms);<br>
+<br>
+enum {<br>
+=C2=A0 =C2=A0 VIRT_UART0,<br>
+=C2=A0 =C2=A0 VIRT_QTMR0,<br>
+=C2=A0 =C2=A0 VIRT_QTMR1,<br>
+=C2=A0 =C2=A0 VIRT_GPT,<br>
+=C2=A0 =C2=A0 VIRT_MMIO,<br>
+=C2=A0 =C2=A0 VIRT_FDT,<br>
+};<br>
+<br>
+#define TYPE_HEXAGON_VIRT_MACHINE MACHINE_TYPE_NAME(&quot;virt&quot;)<br>
+OBJECT_DECLARE_SIMPLE_TYPE(HexagonVirtMachineState, HEXAGON_VIRT_MACHINE)<=
br>
+<br>
+#endif /* HW_HEXAGONVIRT_H */<br>
diff --git a/hw/hexagon/virt.c b/hw/hexagon/virt.c<br>
new file mode 100644<br>
index 00000000000..49ee1aad2fe<br>
--- /dev/null<br>
+++ b/hw/hexagon/virt.c<br>
@@ -0,0 +1,456 @@<br>
+/*<br>
+ * Hexagon virt emulation<br>
+ *<br>
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qapi/error.h&quot;<br>
+#include &quot;hw/hexagon/virt.h&quot;<br>
+#include &quot;elf.h&quot;<br>
+#include &quot;hw/char/pl011.h&quot;<br>
+#include &quot;hw/core/clock.h&quot;<br>
+#include &quot;hw/core/sysbus-fdt.h&quot;<br>
+#include &quot;hw/hexagon/hexagon.h&quot;<br>
+#include &quot;hw/hexagon/hexagon_globalreg.h&quot;<br>
+#include &quot;hw/hexagon/hexagon_tlb.h&quot;<br>
+#include &quot;hw/core/loader.h&quot;<br>
+#include &quot;hw/core/qdev-properties.h&quot;<br>
+#include &quot;hw/core/qdev-clock.h&quot;<br>
+#include &quot;hw/core/register.h&quot;<br>
+#include &quot;qemu/error-report.h&quot;<br>
+#include &quot;qemu/guest-random.h&quot;<br>
+#include &quot;qemu/units.h&quot;<br>
+#include &quot;elf.h&quot;<br>
+#include &quot;machine_cfg_v68n_1024.h.inc&quot;<br>
+#include &quot;system/address-spaces.h&quot;<br>
+#include &quot;system/device_tree.h&quot;<br>
+#include &quot;system/reset.h&quot;<br>
+#include &quot;system/system.h&quot;<br>
+#include &lt;libfdt.h&gt;<br>
+<br>
+static const int VIRTIO_DEV_COUNT =3D 8;<br>
+<br>
+static const MemMapEntry base_memmap[] =3D {<br>
+=C2=A0 =C2=A0 [VIRT_UART0] =3D { 0x10000000, 0x00000200 },<br>
+=C2=A0 =C2=A0 [VIRT_MMIO] =3D { 0x11000000, 0x1000000, },<br>
+=C2=A0 =C2=A0 [VIRT_GPT] =3D { 0xab000000, 0x00001000 },<br>
+=C2=A0 =C2=A0 [VIRT_FDT] =3D { 0x99800000, 0x00400000 },<br>
+};<br>
+<br>
+static const int irqmap[] =3D {<br>
+=C2=A0 =C2=A0 [VIRT_MMIO] =3D 18, /* ...to 18 + VIRTIO_DEV_COUNT - 1 */<br=
>
+=C2=A0 =C2=A0 [VIRT_GPT] =3D 12,<br>
+=C2=A0 =C2=A0 [VIRT_UART0] =3D 15,<br>
+=C2=A0 =C2=A0 [VIRT_QTMR0] =3D 2,<br>
+=C2=A0 =C2=A0 [VIRT_QTMR1] =3D 4,<br>
+};<br>
+<br>
+<br>
+static void create_fdt(HexagonVirtMachineState *vms)<br>
+{<br>
+=C2=A0 =C2=A0 MachineState *ms =3D MACHINE(vms);<br>
+=C2=A0 =C2=A0 void *fdt =3D create_device_tree(&amp;vms-&gt;fdt_size);<br>
+=C2=A0 =C2=A0 uint8_t rng_seed[32];<br>
+<br>
+=C2=A0 =C2=A0 if (!fdt) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;create_device_tree() failed=
&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 ms-&gt;fdt =3D fdt;<br>
+<br>
+=C2=A0 =C2=A0 qemu_fdt_setprop_cell(fdt, &quot;/&quot;, &quot;#address-cel=
ls&quot;, 0x2);<br>
+=C2=A0 =C2=A0 qemu_fdt_setprop_cell(fdt, &quot;/&quot;, &quot;#size-cells&=
quot;, 0x1);<br>
+=C2=A0 =C2=A0 qemu_fdt_setprop_string(fdt, &quot;/&quot;, &quot;model&quot=
;, &quot;hexagon-virt,qemu&quot;);<br>
+=C2=A0 =C2=A0 qemu_fdt_setprop_string(fdt, &quot;/&quot;, &quot;compatible=
&quot;, &quot;qcom,sm8150&quot;);<br>
+<br>
+=C2=A0 =C2=A0 qemu_fdt_add_subnode(fdt, &quot;/soc&quot;);<br>
+=C2=A0 =C2=A0 qemu_fdt_setprop_cell(fdt, &quot;/soc&quot;, &quot;#address-=
cells&quot;, 0x2);<br>
+=C2=A0 =C2=A0 qemu_fdt_setprop_cell(fdt, &quot;/soc&quot;, &quot;#size-cel=
ls&quot;, 0x1);<br>
+=C2=A0 =C2=A0 qemu_fdt_setprop(fdt, &quot;/soc&quot;, &quot;ranges&quot;, =
NULL, 0);<br>
+<br>
+=C2=A0 =C2=A0 qemu_fdt_add_subnode(fdt, &quot;/chosen&quot;);<br>
+=C2=A0 =C2=A0 qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));<br>
+=C2=A0 =C2=A0 qemu_fdt_setprop(fdt, &quot;/chosen&quot;, &quot;rng-seed&qu=
ot;, rng_seed, sizeof(rng_seed));<br>
+}<br>
+<br>
+static void fdt_add_hvx(HexagonVirtMachineState *vms,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 const struct hexagon_machine_config *m_cfg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 const MachineState *ms =3D MACHINE(vms);<br>
+=C2=A0 =C2=A0 uint32_t vtcm_size_bytes =3D m_cfg-&gt;cfgtable.vtcm_size_kb=
 * 1024;<br>
+=C2=A0 =C2=A0 if (vtcm_size_bytes &gt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_init_ram(&amp;vms-&gt;vtcm, NULL=
, &quot;vtcm.ram&quot;, vtcm_size_bytes,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_add_subregion(vms-&gt;sys, m_cfg=
-&gt;cfgtable.vtcm_base &lt;&lt; 16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;vms-&gt;vtcm);<br=
>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fdt_add_subnode(ms-&gt;fdt, &quot;/soc/vt=
cm&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fdt_setprop_string(ms-&gt;fdt, &quot;/soc=
/vtcm&quot;, &quot;compatible&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;qcom,hexagon_vtcm&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(sizeof(m_cfg-&gt;cfgtable.vtcm_base) =
=3D=3D sizeof(uint32_t));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fdt_setprop_cells(ms-&gt;fdt, &quot;/soc/=
vtcm&quot;, &quot;reg&quot;, 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0m_cfg-&gt;cfgtable.vtcm_base &lt;&lt;=
 16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vtcm_size_bytes);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (m_cfg-&gt;cfgtable.ext_contexts &gt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fdt_add_subnode(ms-&gt;fdt, &quot;/soc/hv=
x&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fdt_setprop_string(ms-&gt;fdt, &quot;/soc=
/hvx&quot;, &quot;compatible&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;qcom,hexagon-hvx&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fdt_setprop_cells(ms-&gt;fdt, &quot;/soc/=
hvx&quot;, &quot;qcom,hvx-max-ctxts&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0m_cfg-&gt;cfgtable.ext_contexts);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fdt_setprop_cells(ms-&gt;fdt, &quot;/soc/=
hvx&quot;, &quot;qcom,hvx-vlength&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0m_cfg-&gt;cfgtable.hvx_vec_log_length=
);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static int32_t irq_hvm_ic_phandle =3D -1;<br>
+static void fdt_add_hvm_pic_node(HexagonVirtMachineState *vms,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct hexagon_machine_c=
onfig *m_cfg)<br>
+{<br>
+=C2=A0 =C2=A0 MachineState *ms =3D MACHINE(vms);<br>
+=C2=A0 =C2=A0 irq_hvm_ic_phandle =3D qemu_fdt_alloc_phandle(ms-&gt;fdt);<b=
r>
+<br>
+=C2=A0 =C2=A0 qemu_fdt_setprop_cell(ms-&gt;fdt, &quot;/soc&quot;, &quot;in=
terrupt-parent&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 irq_hvm_ic_phandle);<br>
+<br>
+=C2=A0 =C2=A0 qemu_fdt_add_subnode(ms-&gt;fdt, &quot;/soc/interrupt-contro=
ller&quot;);<br>
+=C2=A0 =C2=A0 qemu_fdt_setprop_cell(ms-&gt;fdt, &quot;/soc/interrupt-contr=
oller&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;#address-cells&quot;, 2);<br>
+=C2=A0 =C2=A0 qemu_fdt_setprop_cell(ms-&gt;fdt, &quot;/soc/interrupt-contr=
oller&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;#interrupt-cells&quot;, 2);<br>
+=C2=A0 =C2=A0 qemu_fdt_setprop_string(ms-&gt;fdt, &quot;/soc/interrupt-con=
troller&quot;, &quot;compatible&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &quot;qcom,h2-pic,hvm-pic&quot;);<br>
+=C2=A0 =C2=A0 qemu_fdt_setprop(ms-&gt;fdt, &quot;/soc/interrupt-controller=
&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&quot;interrupt-controller&quot;, NULL, 0);<br>
+=C2=A0 =C2=A0 qemu_fdt_setprop_cell(ms-&gt;fdt, &quot;/soc/interrupt-contr=
oller&quot;, &quot;phandle&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 irq_hvm_ic_phandle);<br>
+<br>
+=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(vms-&gt;l2vic), 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 m_cf=
g-&gt;cfgtable.fastl2vic_base &lt;&lt; 16);<br>
+}<br>
+<br>
+<br>
+static void fdt_add_gpt_node(HexagonVirtMachineState *vms)<br>
+{<br>
+=C2=A0 =C2=A0 g_autofree char *name =3D NULL;<br>
+=C2=A0 =C2=A0 MachineState *ms =3D MACHINE(vms);<br>
+<br>
+=C2=A0 =C2=A0 name =3D g_strdup_printf(&quot;/soc/gpt@%&quot; PRIx64,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0(int64_t)base_memmap[VIRT_GPT].base);<br>
+=C2=A0 =C2=A0 qemu_fdt_add_subnode(ms-&gt;fdt, name);<br>
+=C2=A0 =C2=A0 qemu_fdt_setprop_string(ms-&gt;fdt, name, &quot;compatible&q=
uot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &quot;qcom,h2-timer,hvm-timer&quot;);<br>
+=C2=A0 =C2=A0 qemu_fdt_setprop_cells(ms-&gt;fdt, name, &quot;interrupts&qu=
ot;, irqmap[VIRT_GPT], 0);<br>
+=C2=A0 =C2=A0 qemu_fdt_setprop_cells(ms-&gt;fdt, name, &quot;reg&quot;, 0x=
0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0base_memmap[VIRT_GPT].base,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0base_memmap[VIRT_GPT].size);<br>
+}<br>
+<br>
+static int32_t clock_phandle =3D -1;<br>
+static void fdt_add_clocks(const HexagonVirtMachineState *vms)<br>
+{<br>
+=C2=A0 =C2=A0 MachineState *ms =3D MACHINE(vms);<br>
+=C2=A0 =C2=A0 clock_phandle =3D qemu_fdt_alloc_phandle(ms-&gt;fdt);<br>
+=C2=A0 =C2=A0 qemu_fdt_add_subnode(ms-&gt;fdt, &quot;/apb-pclk&quot;);<br>
+=C2=A0 =C2=A0 qemu_fdt_setprop_string(ms-&gt;fdt, &quot;/apb-pclk&quot;, &=
quot;compatible&quot;, &quot;fixed-clock&quot;);<br>
+=C2=A0 =C2=A0 qemu_fdt_setprop_cell(ms-&gt;fdt, &quot;/apb-pclk&quot;, &qu=
ot;#clock-cells&quot;, 0x0);<br>
+=C2=A0 =C2=A0 qemu_fdt_setprop_cell(ms-&gt;fdt, &quot;/apb-pclk&quot;, &qu=
ot;clock-frequency&quot;, 24000000);<br>
+=C2=A0 =C2=A0 qemu_fdt_setprop_string(ms-&gt;fdt, &quot;/apb-pclk&quot;, &=
quot;clock-output-names&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &quot;clk24mhz&quot;);<br>
+=C2=A0 =C2=A0 qemu_fdt_setprop_cell(ms-&gt;fdt, &quot;/apb-pclk&quot;, &qu=
ot;phandle&quot;, clock_phandle);<br>
+}<br>
+<br>
+static void fdt_add_uart(const HexagonVirtMachineState *vms, int uart)<br>
+{<br>
+=C2=A0 =C2=A0 char *nodename;<br>
+=C2=A0 =C2=A0 hwaddr base =3D base_memmap[uart].base;<br>
+=C2=A0 =C2=A0 hwaddr size =3D base_memmap[uart].size;<br>
+=C2=A0 =C2=A0 assert(uart =3D=3D 0);<br>
+=C2=A0 =C2=A0 int irq =3D irqmap[VIRT_UART0 + uart];<br>
+=C2=A0 =C2=A0 const char compat[] =3D &quot;arm,pl011\0arm,primecell&quot;=
;<br>
+=C2=A0 =C2=A0 const char clocknames[] =3D &quot;uartclk\0apb_pclk&quot;;<b=
r>
+=C2=A0 =C2=A0 MachineState *ms =3D MACHINE(vms);<br>
+=C2=A0 =C2=A0 DeviceState *dev;<br>
+=C2=A0 =C2=A0 SysBusDevice *s;<br>
+<br>
+=C2=A0 =C2=A0 dev =3D qdev_new(TYPE_PL011);<br>
+=C2=A0 =C2=A0 s =3D SYS_BUS_DEVICE(dev);<br>
+=C2=A0 =C2=A0 qdev_prop_set_chr(dev, &quot;chardev&quot;, serial_hd(0));<b=
r>
+=C2=A0 =C2=A0 qdev_connect_clock_in(dev, &quot;clk&quot;, vms-&gt;apb_clk)=
;<br>
+=C2=A0 =C2=A0 sysbus_realize_and_unref(s, &amp;error_fatal);<br>
+=C2=A0 =C2=A0 sysbus_mmio_map(s, 0, base);<br>
+=C2=A0 =C2=A0 if (vms-&gt;l2vic) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms-=
&gt;l2vic, irq));<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 nodename =3D g_strdup_printf(&quot;/pl011@%&quot; PRIx64, ba=
se);<br>
+=C2=A0 =C2=A0 qemu_fdt_add_subnode(ms-&gt;fdt, nodename);<br>
+<br>
+=C2=A0 =C2=A0 /* Note that we can&#39;t use setprop_string because of the =
embedded NUL */<br>
+=C2=A0 =C2=A0 qemu_fdt_setprop(ms-&gt;fdt, nodename, &quot;compatible&quot=
;, compat, sizeof(compat));<br>
+=C2=A0 =C2=A0 qemu_fdt_setprop_cells(ms-&gt;fdt, nodename, &quot;reg&quot;=
, 0, base, size);<br>
+=C2=A0 =C2=A0 if (vms-&gt;l2vic) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fdt_setprop_cells(ms-&gt;fdt, nodename, &=
quot;interrupts&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A032 + irq, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fdt_setprop_cell(ms-&gt;fdt, nodename, &q=
uot;interrupt-parent&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 irq_hvm_ic_phandle);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 qemu_fdt_setprop_cells(ms-&gt;fdt, nodename, &quot;clocks&qu=
ot;, clock_phandle,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0clock_phandle);<br>
+=C2=A0 =C2=A0 qemu_fdt_setprop(ms-&gt;fdt, nodename, &quot;clock-names&quo=
t;, clocknames,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0sizeof(clocknames));<br>
+<br>
+=C2=A0 =C2=A0 qemu_fdt_setprop_string(ms-&gt;fdt, &quot;/chosen&quot;, &qu=
ot;stdout-path&quot;, nodename);<br>
+=C2=A0 =C2=A0 qemu_fdt_add_subnode(ms-&gt;fdt, &quot;/aliases&quot;);<br>
+=C2=A0 =C2=A0 qemu_fdt_setprop_string(ms-&gt;fdt, &quot;/aliases&quot;, &q=
uot;serial0&quot;, nodename);<br>
+<br>
+=C2=A0 =C2=A0 g_free(nodename);<br>
+}<br>
+<br>
+static void fdt_add_cpu_nodes(const HexagonVirtMachineState *vms)<br>
+{<br>
+=C2=A0 =C2=A0 MachineState *ms =3D MACHINE(vms);<br>
+=C2=A0 =C2=A0 qemu_fdt_add_subnode(ms-&gt;fdt, &quot;/cpus&quot;);<br>
+=C2=A0 =C2=A0 qemu_fdt_setprop_cell(ms-&gt;fdt, &quot;/cpus&quot;, &quot;#=
address-cells&quot;, 0x1);<br>
+=C2=A0 =C2=A0 qemu_fdt_setprop_cell(ms-&gt;fdt, &quot;/cpus&quot;, &quot;#=
size-cells&quot;, 0x0);<br>
+<br>
+=C2=A0 =C2=A0 /* cpu nodes */<br>
+=C2=A0 =C2=A0 for (int num =3D ms-&gt;smp.cpus - 1; num &gt;=3D 0; num--) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *nodename =3D g_strdup_printf(&quot;/cpus=
/cpu@%d&quot;, num);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fdt_add_subnode(ms-&gt;fdt, nodename);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fdt_setprop_string(ms-&gt;fdt, nodename, =
&quot;device_type&quot;, &quot;cpu&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fdt_setprop_cell(ms-&gt;fdt, nodename, &q=
uot;reg&quot;, num);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fdt_setprop_cell(ms-&gt;fdt, nodename, &q=
uot;phandle&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fdt_alloc_phandle(ms-&gt;fdt));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(nodename);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+<br>
+static void fdt_add_virtio_devices(const HexagonVirtMachineState *vms)<br>
+{<br>
+=C2=A0 =C2=A0 MachineState *ms =3D MACHINE(vms);<br>
+=C2=A0 =C2=A0 /* VirtIO MMIO devices */<br>
+=C2=A0 =C2=A0 for (int i =3D 0; i &lt; VIRTIO_DEV_COUNT; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *nodename;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int irq =3D irqmap[VIRT_MMIO] + i;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t size =3D base_memmap[VIRT_MMIO].size;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hwaddr base =3D base_memmap[VIRT_MMIO].base + =
i * size;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 nodename =3D g_strdup_printf(&quot;/virtio_mmi=
o@%&quot; PRIx64, base);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fdt_add_subnode(ms-&gt;fdt, nodename);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fdt_setprop_string(ms-&gt;fdt, nodename, =
&quot;compatible&quot;, &quot;virtio,mmio&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fdt_setprop_sized_cells(ms-&gt;fdt, noden=
ame, &quot;reg&quot;, 2, base, 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fdt_setprop_cells(ms-&gt;fdt, nodename, &=
quot;interrupts&quot;, irq, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fdt_setprop_cell(ms-&gt;fdt, nodename, &q=
uot;interrupt-parent&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 irq_hvm_ic_phandle);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_create_simple(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;virtio-mmio&quot;, base,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(vms-&gt;l2vic, =
irqmap[VIRT_MMIO] + i));<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(nodename);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void virt_instance_init(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 HexagonVirtMachineState *vms =3D HEXAGON_VIRT_MACHINE(obj);<=
br>
+<br>
+=C2=A0 =C2=A0 create_fdt(vms);<br>
+}<br>
+<br>
+void hexagon_load_fdt(const HexagonVirtMachineState *vms)<br>
+{<br>
+=C2=A0 =C2=A0 MachineState *ms =3D MACHINE(vms);<br>
+=C2=A0 =C2=A0 hwaddr fdt_addr =3D base_memmap[VIRT_FDT].base;<br>
+=C2=A0 =C2=A0 uint32_t fdtsize =3D vms-&gt;fdt_size;<br>
+<br>
+=C2=A0 =C2=A0 g_assert(fdtsize &lt;=3D base_memmap[VIRT_FDT].size);<br>
+=C2=A0 =C2=A0 /* copy in the device tree */<br>
+=C2=A0 =C2=A0 rom_add_blob_fixed_as(&quot;fdt&quot;, ms-&gt;fdt, fdtsize, =
fdt_addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &amp;address_space_memory);<br>
+=C2=A0 =C2=A0 qemu_register_reset_nosnapshotload(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_fdt_randomize_seeds,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rom_ptr_for_as(&amp;address_space_memory, fdt_=
addr, fdtsize));<br>
+}<br>
+<br>
+static uint64_t load_kernel(const HexagonVirtMachineState *vms)<br>
+{<br>
+=C2=A0 =C2=A0 MachineState *ms =3D MACHINE(vms);<br>
+=C2=A0 =C2=A0 uint64_t entry =3D 0;<br>
+=C2=A0 =C2=A0 if (load_elf_ram_sym(ms-&gt;kernel_filename, NULL, NULL, NUL=
L, &amp;entry, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0NULL, NULL, 0, EM_HEXAGON, 0, 0, &amp;address_space_memory=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0false, NULL) &gt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return entry;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 error_report(&quot;error loading &#39;%s&#39;&quot;, ms-&gt;=
kernel_filename);<br>
+=C2=A0 =C2=A0 exit(1);<br>
+}<br>
+<br>
+static uint64_t load_bios(HexagonVirtMachineState *vms)<br>
+{<br>
+=C2=A0 =C2=A0 MachineState *ms =3D MACHINE(vms);<br>
+=C2=A0 =C2=A0 uint64_t bios_addr =3D 0x0;=C2=A0 /* Load BIOS at reset vect=
or address 0x0 */<br>
+=C2=A0 =C2=A0 int bios_size;<br>
+<br>
+=C2=A0 =C2=A0 bios_size =3D load_image_targphys(ms-&gt;firmware ?: &quot;&=
quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bios_addr, 64 * 1024, =
NULL);<br>
+=C2=A0 =C2=A0 if (bios_size &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Could not load BIOS &#39;%s=
&#39;&quot;, ms-&gt;firmware ?: &quot;&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return bios_addr;=C2=A0 /* Return entry point at address 0x0=
 */<br>
+}<br>
+<br>
+static void do_cpu_reset(void *opaque)<br>
+{<br>
+=C2=A0 =C2=A0 HexagonCPU *cpu =3D opaque;<br>
+=C2=A0 =C2=A0 CPUState *cs =3D CPU(cpu);<br>
+=C2=A0 =C2=A0 cpu_reset(cs);<br>
+}<br>
+<br>
+static void virt_init(MachineState *ms)<br>
+{<br>
+=C2=A0 =C2=A0 HexagonVirtMachineState *vms =3D HEXAGON_VIRT_MACHINE(ms);<b=
r>
+=C2=A0 =C2=A0 const struct hexagon_machine_config *m_cfg =3D &amp;v68n_102=
4;<br></blockquote><div>This is v68 but in virt_class_init=C2=A0 mc-&gt;def=
ault_cpu_type is set to v73, should that be 68?</div><div><br></div><div><b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 const char *cpu_model;<br>
+=C2=A0 =C2=A0 DeviceState *gsregs_dev;<br>
+=C2=A0 =C2=A0 DeviceState *tlb_dev;<br>
+=C2=A0 =C2=A0 HexagonCPU *cpu_0;<br>
+<br>
+=C2=A0 =C2=A0 qemu_fdt_setprop_string(ms-&gt;fdt, &quot;/chosen&quot;, &qu=
ot;bootargs&quot;, ms-&gt;kernel_cmdline);<br>
+<br>
+=C2=A0 =C2=A0 vms-&gt;sys =3D get_system_memory();<br>
+<br>
+=C2=A0 =C2=A0 /* Create APB clock for peripherals */<br>
+=C2=A0 =C2=A0 vms-&gt;apb_clk =3D clock_new(OBJECT(ms), &quot;apb-pclk&quo=
t;);<br>
+=C2=A0 =C2=A0 clock_set_hz(vms-&gt;apb_clk, 24000000);<br>
+<br>
+=C2=A0 =C2=A0 memory_region_init_ram(&amp;vms-&gt;ram, NULL, &quot;ddr.ram=
&quot;, ms-&gt;ram_size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_fatal);<br>
+=C2=A0 =C2=A0 memory_region_add_subregion(vms-&gt;sys, 0x0, &amp;vms-&gt;r=
am);<br>
+<br>
+=C2=A0 =C2=A0 if (m_cfg-&gt;l2tcm_size) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_init_ram(&amp;vms-&gt;tcm, NULL,=
 &quot;tcm.ram&quot;, m_cfg-&gt;l2tcm_size,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_fatal);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_add_subregion(vms-&gt;sys, m_cfg=
-&gt;cfgtable.l2tcm_base &lt;&lt; 16,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;vms-&gt;tcm);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 memory_region_init_rom(&amp;vms-&gt;cfgtable, NULL, &quot;co=
nfig_table.rom&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0sizeof(m_cfg-&gt;cfgtable), &amp;error_fatal);<br>
+=C2=A0 =C2=A0 memory_region_add_subregion(vms-&gt;sys, m_cfg-&gt;cfgbase, =
&amp;vms-&gt;cfgtable);<br>
+=C2=A0 =C2=A0 fdt_add_hvx(vms, m_cfg, &amp;error_fatal);<br>
+=C2=A0 =C2=A0 cpu_model =3D ms-&gt;cpu_type;<br>
+<br>
+=C2=A0 =C2=A0 if (!cpu_model) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_model =3D HEXAGON_CPU_TYPE_NAME(&quot;v73&=
quot;);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 gsregs_dev =3D qdev_new(TYPE_HEXAGON_GLOBALREG);<br>
+=C2=A0 =C2=A0 object_property_add_child(OBJECT(ms), &quot;global-regs&quot=
;, OBJECT(gsregs_dev));<br>
+=C2=A0 =C2=A0 qdev_prop_set_uint64(gsregs_dev, &quot;config-table-addr&quo=
t;, m_cfg-&gt;cfgbase);<br>
+=C2=A0 =C2=A0 qdev_prop_set_uint32(gsregs_dev, &quot;dsp-rev&quot;, v68_re=
v);<br>
+=C2=A0 =C2=A0 sysbus_realize_and_unref(SYS_BUS_DEVICE(gsregs_dev), &amp;er=
ror_fatal);<br>
+<br>
+=C2=A0 =C2=A0 tlb_dev =3D qdev_new(TYPE_HEXAGON_TLB);<br>
+=C2=A0 =C2=A0 object_property_add_child(OBJECT(ms), &quot;tlb&quot;, OBJEC=
T(tlb_dev));<br>
+=C2=A0 =C2=A0 qdev_prop_set_uint32(tlb_dev, &quot;num-entries&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0m_cfg-&gt;cfgtable.jtlb_size_entries);<br>
+=C2=A0 =C2=A0 sysbus_realize_and_unref(SYS_BUS_DEVICE(tlb_dev), &amp;error=
_fatal);<br>
+<br>
+=C2=A0 =C2=A0 cpu_0 =3D NULL;<br>
+=C2=A0 =C2=A0 for (int i =3D 0; i &lt; ms-&gt;smp.cpus; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 HexagonCPU *cpu =3D HEXAGON_CPU(object_new(ms-=
&gt;cpu_type));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_register_reset(do_cpu_reset, cpu);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_0 =3D cpu;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ms-&gt;kernel_filename) {<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t entry =3D=
 load_kernel(vms);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_uint=
32(DEVICE(cpu_0), &quot;exec-start-addr&quot;, entry);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (ms-&gt;firmware) {<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t entry =3D=
 load_bios(vms);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_uint=
32(DEVICE(cpu_0), &quot;exec-start-addr&quot;, entry);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_uint32(DEVICE(cpu), &quot;htid&q=
uot;, i);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_bit(DEVICE(cpu), &quot;start-pow=
ered-off&quot;, (i !=3D 0));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_link(OBJECT(cpu), &quot;gl=
obal-regs&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OBJECT(gsregs_dev), &amp;error=
_fatal);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_link(OBJECT(cpu), &quot;tl=
b&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OBJECT(tlb_dev), &amp;error_fa=
tal);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!qdev_realize_and_unref(DEVICE(cpu), NULL,=
 &amp;error_fatal)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 /* TODO: enable l2vic when l2vic device arrives */<br>
+=C2=A0 =C2=A0 if (object_class_by_name(&quot;l2vic&quot;)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vms-&gt;l2vic =3D sysbus_create_varargs(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;l2vic&quot;, m_cfg-&gt;l2v=
ic_base,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(cpu_0), =
0),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(cpu_0), =
1),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(cpu_0), =
2),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(cpu_0), =
3),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(cpu_0), =
4),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(cpu_0), =
5),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(cpu_0), =
6),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(cpu_0), =
7), NULL);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fdt_add_hvm_pic_node(vms, m_cfg);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fdt_add_virtio_devices(vms);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fdt_add_gpt_node(vms);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 fdt_add_cpu_nodes(vms);<br>
+=C2=A0 =C2=A0 fdt_add_clocks(vms);<br>
+=C2=A0 =C2=A0 fdt_add_uart(vms, VIRT_UART0);<br>
+<br>
+=C2=A0 =C2=A0 rom_add_blob_fixed_as(&quot;config_table.rom&quot;, &amp;m_c=
fg-&gt;cfgtable,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 sizeof(m_cfg-&gt;cfgtable), m_cfg-&gt;cfgbase,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &amp;address_space_memory);<br>
+<br>
+<br>
+=C2=A0 =C2=A0 hexagon_load_fdt(vms);<br>
+}<br>
+<br>
+<br>
+static void virt_class_init(ObjectClass *oc, const void *data)<br>
+{<br>
+=C2=A0 =C2=A0 MachineClass *mc =3D MACHINE_CLASS(oc);<br>
+<br>
+=C2=A0 =C2=A0 mc-&gt;desc =3D &quot;Hexagon Virtual Machine&quot;;<br>
+=C2=A0 =C2=A0 mc-&gt;init =3D virt_init;<br>
+=C2=A0 =C2=A0 mc-&gt;default_cpu_type =3D HEXAGON_CPU_TYPE_NAME(&quot;v73&=
quot;);<br>
+=C2=A0 =C2=A0 mc-&gt;default_ram_size =3D 4 * GiB;<br>
+=C2=A0 =C2=A0 mc-&gt;max_cpus =3D 8;<br>
+=C2=A0 =C2=A0 mc-&gt;default_cpus =3D 8;<br>
+=C2=A0 =C2=A0 mc-&gt;is_default =3D false;<br>
+=C2=A0 =C2=A0 mc-&gt;default_kernel_irqchip_split =3D false;<br>
+=C2=A0 =C2=A0 mc-&gt;block_default_type =3D IF_VIRTIO;<br>
+=C2=A0 =C2=A0 mc-&gt;default_boot_order =3D NULL;<br>
+=C2=A0 =C2=A0 mc-&gt;no_cdrom =3D 1;<br>
+=C2=A0 =C2=A0 mc-&gt;numa_mem_supported =3D false;<br>
+=C2=A0 =C2=A0 mc-&gt;default_nic =3D &quot;virtio-mmio-bus&quot;;<br>
+}<br>
+<br>
+<br>
+static const TypeInfo virt_machine_types[] =3D { {<br>
+=C2=A0 =C2=A0 .name =3D TYPE_HEXAGON_VIRT_MACHINE,<br>
+=C2=A0 =C2=A0 .parent =3D TYPE_MACHINE,<br>
+=C2=A0 =C2=A0 .instance_size =3D sizeof(HexagonVirtMachineState),<br>
+=C2=A0 =C2=A0 .class_init =3D virt_class_init,<br>
+=C2=A0 =C2=A0 .instance_init =3D virt_instance_init,<br>
+} };<br>
+<br>
+DEFINE_TYPES(virt_machine_types)<br>
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c<br>
index 355abb4fd24..01781a76caf 100644<br>
--- a/target/hexagon/cpu.c<br>
+++ b/target/hexagon/cpu.c<br>
@@ -68,6 +68,8 @@ static ObjectClass *hexagon_cpu_class_by_name(const char =
*cpu_model)<br>
<br>
=C2=A0static const Property hexagon_cpu_properties[] =3D {<br>
=C2=A0#if !defined(CONFIG_USER_ONLY)<br>
+=C2=A0 =C2=A0 DEFINE_PROP_LINK(&quot;tlb&quot;, HexagonCPU, tlb, TYPE_HEXA=
GON_TLB,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0HexagonTLBState *),<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_UINT32(&quot;exec-start-addr&quot;, Hexagon=
CPU, boot_addr, 0xffffffff),<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_LINK(&quot;global-regs&quot;, HexagonCPU, g=
lobalregs,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TYPE_HEXAGON_GLOBALREG, HexagonGlobalRegS=
tate *),<br>
diff --git a/hw/hexagon/Kconfig b/hw/hexagon/Kconfig<br>
index 7b9577f68f7..dc74751d21e 100644<br>
--- a/hw/hexagon/Kconfig<br>
+++ b/hw/hexagon/Kconfig<br>
@@ -3,3 +3,13 @@ config HEX_DSP<br>
=C2=A0 =C2=A0 =C2=A0default y<br>
=C2=A0 =C2=A0 =C2=A0depends on HEXAGON &amp;&amp; TCG<br>
=C2=A0 =C2=A0 =C2=A0imply PTIMER<br>
+<br>
+config HEX_VIRT<br>
+=C2=A0 =C2=A0 bool<br>
+=C2=A0 =C2=A0 default y<br>
+=C2=A0 =C2=A0 depends on HEX_DSP &amp;&amp; FDT<br>
+=C2=A0 =C2=A0 select DEVICE_TREE<br>
+=C2=A0 =C2=A0 select VIRTIO_MMIO<br>
+=C2=A0 =C2=A0 select PL011<br>
+=C2=A0 =C2=A0 select VIRTIO_BLK<br>
+=C2=A0 =C2=A0 select VIRTIO_SCSI<br>
diff --git a/hw/hexagon/meson.build b/hw/hexagon/meson.build<br>
index f528d2bc4ab..5b6a5e11a17 100644<br>
--- a/hw/hexagon/meson.build<br>
+++ b/hw/hexagon/meson.build<br>
@@ -4,3 +4,5 @@ hexagon_ss.add(files(&#39;hexagon_globalreg.c&#39;))<br>
=C2=A0hexagon_ss.add(when: &#39;CONFIG_HEX_DSP&#39;, if_true: files(&#39;he=
xagon_dsp.c&#39;))<br>
<br>
=C2=A0hw_arch +=3D {&#39;hexagon&#39;: hexagon_ss}<br>
+<br>
+hexagon_ss.add(when: &#39;CONFIG_HEX_VIRT&#39;, if_true: files(&#39;virt.c=
&#39;))<br>
diff --git a/tests/qemu-iotests/testenv.py b/tests/qemu-iotests/testenv.py<=
br>
index c357e6ebf50..86bcdf7cfad 100644<br>
--- a/tests/qemu-iotests/testenv.py<br>
+++ b/tests/qemu-iotests/testenv.py<br>
@@ -259,6 +259,7 @@ def __init__(self, source_dir: str, build_dir: str,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(&#39;arm&#39;, &#39;virt&#=
39;),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(&#39;aarch64&#39;, &#39;vi=
rt&#39;),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(&#39;avr&#39;, &#39;mega25=
60&#39;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (&#39;hexagon&#39;, &#39;virt&#3=
9;),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(&#39;m68k&#39;, &#39;virt&=
#39;),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(&#39;or1k&#39;, &#39;virt&=
#39;),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(&#39;riscv32&#39;, &#39;vi=
rt&#39;),<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--000000000000b36796064ef7d148--

