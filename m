Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED12CD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXXb0-0002IZ-Pi; Thu, 11 Jun 2026 01:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1wXXay-0002He-S6
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:04:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1wXXau-0005fl-8E
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:04:48 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B0NQK51614529
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:04:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=6Dh/IJVSkW+xOv8n11gIPEsWA4g+H9pVBKe9Y+ZAJ/w=; b=Cc
 CLwISmRd6ZcVP1CV0ffiVlY9FBedLDo7pa1MXDJxJzjrAnkN+SSMQnHjGhdJ3uJG
 SZQf7QDyeF9b/oqat74vvyHClALr/yWhUwNhlZZXeuGy2H3MEJJf+G4E+sWfuU4V
 ZT23pjD4iY2jRvS3aZ+NRm+arep2RqLMeWGSHQTKqa3H92k7zC3nZo9+1c3lEy27
 kESTEWfKp7OoVdGbLUQnXyjIVtcd5IvR6j/rpMgFZ7PdktiD1zL7kPg3qOyR6oWw
 8c6uqhLxOnzqI5dvhtH184LmhN19lFLXdau93Ux2b1dyPO4FabGCKJdPPCfq/rfb
 7yl/F77OGmF2nOM/NZ8Q==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe79hnu8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:04:41 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-660668ea5cdso6388434d50.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:04:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781154281; cv=none;
 d=google.com; s=arc-20240605;
 b=PMt7pa7efdRWvoByKpgwEf2ahULZGjL6WL3Zpo88QCWSalYw7bWKe0soGsTYG3+SQ2
 SgtuXHwWT7BaqMihHkA5xlqPzRdNARW9KGFOEpyj2vkpCzMknJSVCac86nmg+xPjlXJB
 bOwDQA97+MQ+mcvwhRM4bjT8z+DSTb/zCFMh0XXmCTH1FMOJmB0MUseljvZdL4wS1z1R
 AE1QCvVNHzEh2ybBvz1uubqo7uYncjTRrKNIGDPMWxaV4dbKR25zC5Az+AK0lCiGfdJS
 krB9f+MMAK1aFJpT1Y94z1TRyXWI19SWb9fgb9s9q62mG80voGoTitCKkhYZqX4AEIJn
 rwdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=6Dh/IJVSkW+xOv8n11gIPEsWA4g+H9pVBKe9Y+ZAJ/w=;
 fh=IkB06zlptLNwZWqZZYeXbjXkoD1LHThvp6kPB9WHEGU=;
 b=hAbcaYQfyl5vGeB/ThMWsx3K+212YzX1PVC+hzXvhfwFNlQWPh9AG7/0ZaG6z7qFes
 TQc3lR8XY6Cp5G6/1ksMHhYRgf6IQvLr+p1ONsgC/tSFxdvBSCaz3tt0eb22oCfXgUye
 T0K6dPvl0O0FykBfuxeUwHgO1CBHkygOd3YMjp7BZMacXpvw+cvsLx2or6xSQKgnn5cV
 wMIst7uCfbUFApetjKlJwawh+kO1YifiFjxd4jXBzkGdE5G9AVvfmjf2cUi3Z/Kx7E/z
 sFDY2INFNOfLizPH4HWLMr/KCgH2bo63HLz52x/qMGWGNLlA7gMtXajrryRA6GsNTKWp
 mNtQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781154281; x=1781759081; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=6Dh/IJVSkW+xOv8n11gIPEsWA4g+H9pVBKe9Y+ZAJ/w=;
 b=hi+kRKTQPqFh585PTz7aAqYXWG91bPAIYatmMK4NtMhINumdjfo6Bsx+VFrZFy97c9
 J2D0ax9sK8FxOl7Gpi9OSS1Efofhdw4cEbIvyGGIGCwePQcVv3GaaC1YbJruDdXo/ZM+
 L/th079/grK2nj+2QznDEiiCU1ciGGhioU5n6tAFk6BH7IjEWmYL4Q+CUWiwi/cIh0GQ
 Fjh84OIRRA45cvR5x1j3XRoIN8ZzfmyGD8HTXV1nNOi2cMqwhd8ztvKOmDv9Hk7RnHo6
 65bVzmbRPBcSmhMENNac0jOXmSCsLlNqyUdRePrXRSMCkyHy3Qm/9nilV+umAnw6hUcT
 h+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781154281; x=1781759081;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Dh/IJVSkW+xOv8n11gIPEsWA4g+H9pVBKe9Y+ZAJ/w=;
 b=tUfwNMiv/xy6JQB/Img7LGFoxdLquajrpp3Z7yqngvGIqpvk/6PBPMppYTnu/rq96k
 gO9cKjA3drJtOTtbxPG3zmUe3Rx/Rnqt8s5YU3SKknP2Rp6f1hxXqvGW0iSqtb+cO+fG
 FORyt+5wCrUgZYIADWEVS6H3WBVIoA/bY80kZ2sUKKCLfvHhcLih25eZcVHkKZYeZlHm
 /2tUlTL9mczr4yo2vcuzHfuk5FYyljoJ6As157saX1aujVbUcipM0u3IQ+OECafLuznn
 g9dOhvAbu82SBKGWPt9WNuZSb8v10RfrpCLik7YAxHARcKPByz7T8IeT5gill/cVHkMo
 Zzkw==
X-Gm-Message-State: AOJu0YwERrtKt8C5cWol0Cb9wWZ+NKgvJFV0IWKDiPQJmUwmfZ/QAeEY
 nBC4EJdB4erSyFkqfwPuJHmGM+Hg5HY6da39DS3c4r/obGbZunHZfq+ktD4MZIY8e7a/hujl3Ll
 Y4y96mpJZGEa0C2vBj9Ow5uUTxpNZc05bK1OGNZyJwtThn6t3FsI1T5tWUhHZ7Om97xTpeizJ60
 yPxOPz/ENqZdhzTUyhFGfAVZuIfRMEAZFv
X-Gm-Gg: Acq92OFyoQJQv5LffQfS50WdRHqi4MuTOvdxuVtyXfydN7LZy5Jhsr747DKh5UFHVuq
 jav2QghZELkxsBq1zcLQkYyPY4yQMahPCDj3GlbAXBzCoCZ6Y40kJLCYDcEEKQYWKj4+rmCZkLz
 3OZsMml+fb76FA7tQ9ugYmfP6+IwDYCLrSMOLSA6a6F5YXFTujuxDwf2ITB6uZoqMjCgjdJBkMh
 t7JT3H84syvhglCZKM=
X-Received: by 2002:a05:690e:d53:b0:660:62e5:9303 with SMTP id
 956f58d0204a3-66269a0c71bmr878933d50.63.1781154280298; 
 Wed, 10 Jun 2026 22:04:40 -0700 (PDT)
X-Received: by 2002:a05:690e:d53:b0:660:62e5:9303 with SMTP id
 956f58d0204a3-66269a0c71bmr878903d50.63.1781154279586; Wed, 10 Jun 2026
 22:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260610214133.1882563-1-daniel.barboza@oss.qualcomm.com>
 <20260610214133.1882563-4-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260610214133.1882563-4-daniel.barboza@oss.qualcomm.com>
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 10:34:28 +0530
X-Gm-Features: AVVi8Cd594NeSdH4mlxDk2D-kSqV_XxngWv4NJbScGzQarTtTSgbYxZ-elCOzL4
Message-ID: <CAB19ukF9mC52EzikZ4DOEd3YO-Ju-W1oKXrS2gVoc_p1UtLMuA@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] hw/riscv: server platform reference machine
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, andrew.jones@oss.qualcomm.com,
 leif.lindholm@oss.qualcomm.com, uwu@icenowy.me,
 Fei Wu <wu.fei9@sanechips.com.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 8ZSfUtg8H2UEs2Dr2gVHQNaLQOIF650Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA0NyBTYWx0ZWRfX9atiQ2Scy2Bw
 JS1TXADl1GQGib/rAkPfNQwzICxS11byIeCo+PpsWgGuKe5UIrYC3YXcZqnHzgj0OcJ5Et6IXYu
 GTg9zFrmI7jT/hvpgak5o2Y4Lvh/V4/0Eni7ROk0o4wcRBLY2DUzJRKRpxb46jXB2lkANYDfSkf
 gC+n5+T81Rns1Z7EBiAoHIZboNbaukbxev8f5+F5eWy9xmM9talahF8/w0XcTdl5VkXyGU8vnvD
 hRqVvZG1VZYTsVpzyZybjXOTzh+AZQ6g1da3PYR6Zslntt77389oiei9MxDmJ7Ls3a+WAPaZk6I
 dNS01DQopnnofYSh2JwLyVEBRH6Tc3JKrwjD0n09ccOXw2pHinkddQtvDlXeYfazMmW0xqmVxeM
 spxVN8O6H5a82WbD+H2e7TGV5FzThfs72tqImeIITp44KpcqVkDVT0FzADGE34gQqhSiDVOs+1M
 lclYkp3PaTevLyVXezw==
X-Proofpoint-GUID: 8ZSfUtg8H2UEs2Dr2gVHQNaLQOIF650Q
X-Authority-Analysis: v=2.4 cv=fbydDUQF c=1 sm=1 tr=0 ts=6a2a41e9 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=uTRCLKPYAAAA:8
 a=jDA1q-D4uV3ZIR7hbWkA:9 a=yYh_aFlgw0uoKH3T:21 a=QEXdDO2ut3YA:10
 a=yHXA93iunegOHmWoMUFd:22 a=T-agBWn15iSmxapsA1lH:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA0NyBTYWx0ZWRfX2uZ/uhrpQNUE
 v3kxKe1EA2aSwLCiSesi5Az2/5oJSBG16qrDBNeU9lAbf2p1dM21YuGtwnKMjIUlct0bIKCCJvY
 F4AJbrY/sm0Ldce5+jy+eO5ANTe5KGg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110047
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=sunil.laxminarasimha@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: sunilvl@oss.qualcomm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jun 11, 2026 at 3:13=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> From: Fei Wu <wu.fei9@sanechips.com.cn>
>
> The RISC-V Server Platform specification [1] defines a standardized set
> of hardware and software capabilities, that portable system software,
> such as OS and hypervisors can rely on being present in a RISC-V server
> platform.
>
> The main features included in this emulation are:
>
> - Based on riscv virt machine type;
> - A new memory map as close as virt machine as possible;
> - An always present IOMMU platform device (riscv-iommu-sys) that uses
>   IRQs 36 to 39, one IRQ for queue, similar to the 'virt' board;
> - AIA;
> - PCIe AHCI;
> - PCIe NIC;
> - No virtio device;
> - No fw_cfg device;
> - No ACPI table provided;
> - Only minimal device tree nodes.
>
> [1] https://github.com/riscv-non-isa/riscv-server-platform
>
> Signed-off-by: Fei Wu <wu.fei9@sanechips.com.cn>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>  configs/devices/riscv64-softmmu/default.mak |    1 +
>  hw/riscv/Kconfig                            |   15 +
>  hw/riscv/meson.build                        |    1 +
>  hw/riscv/server_platform_ref.c              | 1389 +++++++++++++++++++
>  4 files changed, 1406 insertions(+)
>  create mode 100644 hw/riscv/server_platform_ref.c
>
> diff --git a/configs/devices/riscv64-softmmu/default.mak b/configs/device=
s/riscv64-softmmu/default.mak
> index a8e4d0ab33..ae3f62e2d4 100644
> --- a/configs/devices/riscv64-softmmu/default.mak
> +++ b/configs/devices/riscv64-softmmu/default.mak
> @@ -9,6 +9,7 @@
>  # CONFIG_SIFIVE_E=3Dn
>  # CONFIG_SIFIVE_U=3Dn
>  # CONFIG_RISCV_VIRT=3Dn
> +# CONFIG_RISCV_SERVER_PLATFORM_REF=3Dn
>  # CONFIG_MICROCHIP_PFSOC=3Dn
>  # CONFIG_SHAKTI_C=3Dn
>  # CONFIG_XIANGSHAN_KUNMINGHU=3Dn
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 2518b04175..1807c423ff 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -69,6 +69,21 @@ config RISCV_VIRT
>      select ACPI
>      select ACPI_PCI
>
> +config RISCV_SERVER_PLATFORM_REF
> +    bool
> +    default y
> +    depends on RISCV64
> +    select RISCV_NUMA
> +    select GOLDFISH_RTC
> +    select PCI
> +    select PCI_EXPRESS_GENERIC_BRIDGE
> +    select PFLASH_CFI01
> +    select SERIAL
> +    select RISCV_ACLINT
> +    select RISCV_APLIC
> +    select RISCV_IMSIC
> +    select RISCV_IOMMU
> +
>  config SHAKTI_C
>      bool
>      default y
> diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
> index 533472e22a..74944cca84 100644
> --- a/hw/riscv/meson.build
> +++ b/hw/riscv/meson.build
> @@ -4,6 +4,7 @@ riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('n=
uma.c'))
>  riscv_ss.add(files('riscv_hart.c'))
>  riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
>  riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
> +riscv_ss.add(when: 'CONFIG_RISCV_SERVER_PLATFORM_REF', if_true: files('s=
erver_platform_ref.c'))
>  riscv_ss.add(when: 'CONFIG_SHAKTI_C', if_true: files('shakti_c.c'))
>  riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
>  riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
> diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_re=
f.c
> new file mode 100644
> index 0000000000..7e626c6eb7
> --- /dev/null
> +++ b/hw/riscv/server_platform_ref.c
> @@ -0,0 +1,1389 @@
> +/*
> + * QEMU RISC-V Server Platform Reference Board (riscv-server-ref)
> + *
> + * Copyright (c) 2024 Intel, Inc.
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qemu/error-report.h"
> +#include "qemu/guest-random.h"
> +#include "qapi/error.h"
> +#include "qapi/qapi-visit-common.h"
> +#include "hw/core/boards.h"
> +#include "hw/core/loader.h"
> +#include "hw/core/sysbus.h"
> +#include "hw/core/qdev-properties.h"
> +#include "hw/char/serial.h"
> +#include "hw/block/flash.h"
> +#include "hw/ide/pci.h"
> +#include "hw/ide/ahci-pci.h"
> +#include "hw/pci/pci.h"
> +#include "hw/pci-host/gpex.h"
> +#include "hw/core/sysbus-fdt.h"
> +#include "hw/riscv/riscv_hart.h"
> +#include "hw/riscv/boot.h"
> +#include "hw/riscv/machines-qom.h"
> +#include "hw/riscv/numa.h"
> +#include "hw/riscv/iommu.h"
> +#include "hw/riscv/riscv-iommu-bits.h"
> +#include "hw/intc/riscv_aclint.h"
> +#include "hw/intc/riscv_aplic.h"
> +#include "hw/intc/riscv_imsic.h"
> +#include "chardev/char.h"
> +#include "hw/char/serial-mm.h"
> +#include "system/device_tree.h"
> +#include "system/runstate.h"
> +#include "system/system.h"
> +#include "system/tcg.h"
> +#include "system/qtest.h"
> +#include "target/riscv/cpu.h"
> +#include "target/riscv/pmu.h"
> +#include "net/net.h"
> +
> +#define RVSERVER_CPUS_MAX_BITS             9
> +#define RVSERVER_CPUS_MAX                  (1 << RVSERVER_CPUS_MAX_BITS)
> +#define RVSERVER_SOCKETS_MAX_BITS          2
> +#define RVSERVER_SOCKETS_MAX               (1 << RVSERVER_SOCKETS_MAX_BI=
TS)
> +
> +#define RVSERVER_IRQCHIP_NUM_MSIS 255
> +#define RVSERVER_IRQCHIP_NUM_SOURCES 96
> +#define RVSERVER_IRQCHIP_NUM_PRIO_BITS 3
> +#define RVSERVER_IRQCHIP_MAX_GUESTS_BITS 3
> +#define RVSERVER_IRQCHIP_MAX_GUESTS \
> +    ((1U << RVSERVER_IRQCHIP_MAX_GUESTS_BITS) - 1U)
> +
> +#define FDT_PCI_ADDR_CELLS    3
> +#define FDT_PCI_INT_CELLS     1
> +#define FDT_APLIC_INT_CELLS   2
> +#define FDT_APLIC_ADDR_CELLS  0
> +#define FDT_IMSIC_INT_CELLS   0
> +#define FDT_MAX_INT_CELLS     2
> +#define FDT_MAX_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS + =
\
> +                                 1 + FDT_MAX_INT_CELLS)
> +#define FDT_APLIC_INT_MAP_WIDTH (FDT_PCI_ADDR_CELLS + FDT_PCI_INT_CELLS =
+ \
> +                                 1 + FDT_APLIC_INT_CELLS)
> +
> +#define NUM_SATA_PORTS  6
> +
> +#define SYSCON_RESET     0x1
> +#define SYSCON_POWEROFF  0x2
> +
> +#define TYPE_RISCV_SERVER_REF_MACHINE MACHINE_TYPE_NAME("riscv-server-re=
f")
> +OBJECT_DECLARE_SIMPLE_TYPE(RISCVServerRefMachineState, RISCV_SERVER_REF_=
MACHINE)
> +
> +struct RISCVServerRefMachineState {
> +    /*< private >*/
> +    MachineState parent;
> +
> +    /*< public >*/
> +    Notifier machine_done;
> +    RISCVHartArrayState soc[RVSERVER_SOCKETS_MAX];
> +    DeviceState *irqchip[RVSERVER_SOCKETS_MAX];
> +    PFlashCFI01 *flash[2];
> +
> +    int fdt_size;
> +    int aia_guests;
> +    const MemMapEntry *memmap;
> +};
> +
> +enum {
> +    RVSERVER_DEBUG,
> +    RVSERVER_MROM,
> +    RVSERVER_RESET_SYSCON,
> +    RVSERVER_RTC,
> +    RVSERVER_IOMMU_SYS,
> +    RVSERVER_ACLINT,
> +    RVSERVER_APLIC_M,
> +    RVSERVER_APLIC_S,
> +    RVSERVER_UART0,
> +    RVSERVER_IMSIC_M,
> +    RVSERVER_IMSIC_S,
> +    RVSERVER_FLASH,
> +    RVSERVER_DRAM,
> +    RVSERVER_PCIE_MMIO,
> +    RVSERVER_PCIE_PIO,
> +    RVSERVER_PCIE_ECAM,
> +    RVSERVER_PCIE_MMIO_HIGH
> +};
> +
> +enum {
> +    RVSERVER_UART0_IRQ =3D 10,
> +    RVSERVER_RTC_IRQ =3D 11,
> +    RVSERVER_PCIE_IRQ =3D 0x20, /* 32 to 35 */
> +    IOMMU_SYS_IRQ =3D 0x24 /* 36 to 39 */
> +};
> +
> +/*
> + * The server soc reference machine physical address space used by some =
of the
> + * devices namely ACLINT, APLIC and IMSIC depend on number of Sockets, n=
umber
> + * of CPUs, and number of IMSIC guest files.
> + *
> + * Various limits defined by RVSERVER_SOCKETS_MAX_BITS, RVSERVER_CPUS_MA=
X_BITS,
> + * and RVSERVER_IRQCHIP_MAX_GUESTS_BITS are tuned for maximum utilizatio=
n of
> + * server reference machine physical address space.
> + */
> +
> +#define RVSERVER_IMSIC_GROUP_MAX_SIZE      (1U << IMSIC_MMIO_GROUP_MIN_S=
HIFT)
> +#if RVSERVER_IMSIC_GROUP_MAX_SIZE < \
> +    IMSIC_GROUP_SIZE(RVSERVER_CPUS_MAX_BITS, RVSERVER_IRQCHIP_MAX_GUESTS=
_BITS)
> +#error "Can't accomodate single IMSIC group in address space"
> +#endif
> +
> +#define RVSERVER_IMSIC_MAX_SIZE            (RVSERVER_SOCKETS_MAX * \
> +                                        RVSERVER_IMSIC_GROUP_MAX_SIZE)
> +#if 0x4000000 < RVSERVER_IMSIC_MAX_SIZE
> +#error "Can't accomodate all IMSIC groups in address space"
> +#endif
> +
> +static const MemMapEntry rvserver_ref_memmap[] =3D {
> +    [RVSERVER_DEBUG] =3D          {        0x0,         0x100 },
> +    [RVSERVER_MROM] =3D           {     0x1000,        0xf000 },
> +    [RVSERVER_RESET_SYSCON] =3D   {   0x100000,        0x1000 },
> +    [RVSERVER_RTC] =3D            {   0x101000,        0x1000 },
> +    [RVSERVER_IOMMU_SYS] =3D      {   0x102000,        0x1000 },
> +    [RVSERVER_ACLINT] =3D         {  0x2000000,       0x10000 },
> +    [RVSERVER_PCIE_PIO] =3D       {  0x3000000,       0x10000 },
> +    [RVSERVER_APLIC_M] =3D        {  0xc000000, APLIC_SIZE(RVSERVER_CPUS=
_MAX) },
> +    [RVSERVER_APLIC_S] =3D        {  0xd000000, APLIC_SIZE(RVSERVER_CPUS=
_MAX) },
> +    [RVSERVER_UART0] =3D          { 0x10000000,         0x100 },
> +    [RVSERVER_FLASH] =3D          { 0x20000000,     0x4000000 },
> +    [RVSERVER_IMSIC_M] =3D        { 0x24000000, RVSERVER_IMSIC_MAX_SIZE =
},
> +    [RVSERVER_IMSIC_S] =3D        { 0x28000000, RVSERVER_IMSIC_MAX_SIZE =
},
> +    [RVSERVER_PCIE_ECAM] =3D      { 0x30000000,    0x10000000 },
> +    [RVSERVER_PCIE_MMIO] =3D      { 0x40000000,    0x40000000 },
> +    [RVSERVER_DRAM] =3D           { 0x80000000, 0xff80000000ull },
> +    [RVSERVER_PCIE_MMIO_HIGH] =3D { 0x10000000000ull, 0x10000000000ull }=
,
> +};
> +
> +#define RVSERVER_FLASH_SECTOR_SIZE (256 * KiB)
> +
> +static PFlashCFI01 *rvserver_flash_create(RISCVServerRefMachineState *s,
> +                                          const char *name,
> +                                          const char *alias_prop_name)
> +{
> +    /*
> +     * Create a single flash device.  We use the same parameters as
> +     * the flash devices on the ARM virt board.
> +     */
>
It should be RISC-V virt. But can we add SD option as well along with flash=
?

> +    DeviceState *dev =3D qdev_new(TYPE_PFLASH_CFI01);
> +
> +    qdev_prop_set_uint64(dev, "sector-length", RVSERVER_FLASH_SECTOR_SIZ=
E);
> +    qdev_prop_set_uint8(dev, "width", 4);
> +    qdev_prop_set_uint8(dev, "device-width", 2);
> +    qdev_prop_set_bit(dev, "big-endian", false);
> +    qdev_prop_set_uint16(dev, "id0", 0x89);
> +    qdev_prop_set_uint16(dev, "id1", 0x18);
> +    qdev_prop_set_uint16(dev, "id2", 0x00);
> +    qdev_prop_set_uint16(dev, "id3", 0x00);
> +    qdev_prop_set_string(dev, "name", name);
> +
> +    object_property_add_child(OBJECT(s), name, OBJECT(dev));
> +    object_property_add_alias(OBJECT(s), alias_prop_name,
> +                              OBJECT(dev), "drive");
> +
> +    return PFLASH_CFI01(dev);
> +}
> +
> +static void rvserver_flash_map(PFlashCFI01 *flash,
> +                               hwaddr base, hwaddr size,
> +                               MemoryRegion *sysmem)
> +{
> +    DeviceState *dev =3D DEVICE(flash);
> +
> +    assert(QEMU_IS_ALIGNED(size, RVSERVER_FLASH_SECTOR_SIZE));
> +    assert(size / RVSERVER_FLASH_SECTOR_SIZE <=3D UINT32_MAX);
> +    qdev_prop_set_uint32(dev, "num-blocks", size / RVSERVER_FLASH_SECTOR=
_SIZE);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    memory_region_add_subregion(sysmem, base,
> +                                sysbus_mmio_get_region(SYS_BUS_DEVICE(de=
v),
> +                                                       0));
> +}
> +
> +static void rvserver_flash_maps(RISCVServerRefMachineState *s,
> +                                MemoryRegion *sysmem)
> +{
> +    hwaddr flashsize =3D rvserver_ref_memmap[RVSERVER_FLASH].size / 2;
> +    hwaddr flashbase =3D rvserver_ref_memmap[RVSERVER_FLASH].base;
> +
> +    rvserver_flash_map(s->flash[0], flashbase, flashsize, sysmem);
> +    rvserver_flash_map(s->flash[1], flashbase + flashsize, flashsize, sy=
smem);
> +}
> +
> +static void create_pcie_irq_map(RISCVServerRefMachineState *s,
> +                                void *fdt, char *nodename,
> +                                uint32_t irqchip_phandle)
> +{
> +    int pin, dev;
> +    uint32_t irq_map_stride =3D 0;
> +    uint32_t full_irq_map[PCI_NUM_PINS * PCI_NUM_PINS *
> +                          FDT_MAX_INT_MAP_WIDTH] =3D {};
> +    uint32_t *irq_map =3D full_irq_map;
> +
> +    /*
> +     * This code creates a standard swizzle of interrupts such that
> +     * each device's first interrupt is based on it's PCI_SLOT number.
> +     * (See pci_swizzle_map_irq_fn())
> +     *
> +     * We only need one entry per interrupt in the table (not one per
> +     * possible slot) seeing the interrupt-map-mask will allow the table
> +     * to wrap to any number of devices.
> +     */
> +    for (dev =3D 0; dev < PCI_NUM_PINS; dev++) {
> +        int devfn =3D dev * 0x8;
> +
> +        for (pin =3D 0; pin < PCI_NUM_PINS; pin++) {
> +            int irq_nr =3D RVSERVER_PCIE_IRQ +
> +                         ((pin + PCI_SLOT(devfn)) % PCI_NUM_PINS);
> +            int i =3D 0;
> +
> +            /* Fill PCI address cells */
> +            irq_map[i] =3D cpu_to_be32(devfn << 8);
> +            i +=3D FDT_PCI_ADDR_CELLS;
> +
> +            /* Fill PCI Interrupt cells */
> +            irq_map[i] =3D cpu_to_be32(pin + 1);
> +            i +=3D FDT_PCI_INT_CELLS;
> +
> +            /* Fill interrupt controller phandle and cells */
> +            irq_map[i++] =3D cpu_to_be32(irqchip_phandle);
> +            irq_map[i++] =3D cpu_to_be32(irq_nr);
> +            irq_map[i++] =3D cpu_to_be32(0x4);
> +
> +            if (!irq_map_stride) {
> +                irq_map_stride =3D i;
> +            }
> +            irq_map +=3D irq_map_stride;
> +        }
> +    }
> +
> +    qemu_fdt_setprop(fdt, nodename, "interrupt-map", full_irq_map,
> +                     PCI_NUM_PINS * PCI_NUM_PINS *
> +                     irq_map_stride * sizeof(uint32_t));
> +
> +    qemu_fdt_setprop_cells(fdt, nodename, "interrupt-map-mask",
> +                           0x1800, 0, 0, 0x7);
> +}
> +
> +static void create_fdt_socket_cpus(RISCVServerRefMachineState *s, int so=
cket,
> +                                   char *clust_name, uint32_t *phandle,
> +                                   uint32_t *intc_phandles)
> +{
> +    int cpu;
> +    uint32_t cpu_phandle;
> +    MachineState *ms =3D MACHINE(s);
> +    bool is_32_bit =3D riscv_is_32bit(&s->soc[0]);
>
Do we need this given the reference platform should adhere to RVA23S64?

> +    int8_t satp_mode_max;
> +
> +    for (cpu =3D s->soc[socket].num_harts - 1; cpu >=3D 0; cpu--) {
> +        RISCVCPU *cpu_ptr =3D &s->soc[socket].harts[cpu];
> +        satp_mode_max =3D cpu_ptr->cfg.max_satp_mode;
> +        g_autofree char *cpu_name =3D NULL;
> +        g_autofree char *core_name =3D NULL;
> +        g_autofree char *intc_name =3D NULL;
> +        g_autofree char *sv_name =3D NULL;
> +
> +        cpu_phandle =3D (*phandle)++;
> +
> +        cpu_name =3D g_strdup_printf("/cpus/cpu@%d",
> +            s->soc[socket].hartid_base + cpu);
> +        qemu_fdt_add_subnode(ms->fdt, cpu_name);
> +
> +        if (satp_mode_max !=3D -1) {
> +            sv_name =3D g_strdup_printf("riscv,%s",
> +                                      satp_mode_str(satp_mode_max, is_32=
_bit));
> +            qemu_fdt_setprop_string(ms->fdt, cpu_name, "mmu-type", sv_na=
me);
> +        }
> +
> +        riscv_isa_write_fdt(cpu_ptr, ms->fdt, cpu_name);
> +
> +        if (cpu_ptr->cfg.ext_zicbom) {
> +            qemu_fdt_setprop_cell(ms->fdt, cpu_name, "riscv,cbom-block-s=
ize",
> +                                  cpu_ptr->cfg.cbom_blocksize);
> +        }
> +
> +        if (cpu_ptr->cfg.ext_zicboz) {
> +            qemu_fdt_setprop_cell(ms->fdt, cpu_name, "riscv,cboz-block-s=
ize",
> +                                  cpu_ptr->cfg.cboz_blocksize);
> +        }
> +
> +        if (cpu_ptr->cfg.ext_zicbop) {
> +            qemu_fdt_setprop_cell(ms->fdt, cpu_name, "riscv,cbop-block-s=
ize",
> +                                  cpu_ptr->cfg.cbop_blocksize);
> +        }
> +
> +        qemu_fdt_setprop_string(ms->fdt, cpu_name, "compatible", "riscv"=
);
> +        qemu_fdt_setprop_string(ms->fdt, cpu_name, "status", "okay");
> +        qemu_fdt_setprop_cell(ms->fdt, cpu_name, "reg",
> +            s->soc[socket].hartid_base + cpu);
> +        qemu_fdt_setprop_string(ms->fdt, cpu_name, "device_type", "cpu")=
;
> +        riscv_socket_fdt_write_id(ms, cpu_name, socket);
> +        qemu_fdt_setprop_cell(ms->fdt, cpu_name, "phandle", cpu_phandle)=
;
> +
> +        intc_phandles[cpu] =3D (*phandle)++;
> +
> +        intc_name =3D g_strdup_printf("%s/interrupt-controller", cpu_nam=
e);
> +        qemu_fdt_add_subnode(ms->fdt, intc_name);
> +        qemu_fdt_setprop_cell(ms->fdt, intc_name, "phandle",
> +            intc_phandles[cpu]);
> +        qemu_fdt_setprop_string(ms->fdt, intc_name, "compatible",
> +            "riscv,cpu-intc");
> +        qemu_fdt_setprop(ms->fdt, intc_name, "interrupt-controller", NUL=
L, 0);
> +        qemu_fdt_setprop_cell(ms->fdt, intc_name, "#interrupt-cells", 1)=
;
> +
> +        core_name =3D g_strdup_printf("%s/core%d", clust_name, cpu);
> +        qemu_fdt_add_subnode(ms->fdt, core_name);
> +        qemu_fdt_setprop_cell(ms->fdt, core_name, "cpu", cpu_phandle);
> +    }
> +}
> +
> +static void create_fdt_socket_memory(RISCVServerRefMachineState *s,
> +                                     const MemMapEntry *memmap, int sock=
et)
> +{
> +    g_autofree char *mem_name =3D NULL;
> +    hwaddr addr, size;
> +    MachineState *ms =3D MACHINE(s);
> +
> +    addr =3D memmap[RVSERVER_DRAM].base + riscv_socket_mem_offset(ms, so=
cket);
> +    size =3D riscv_socket_mem_size(ms, socket);
> +    mem_name =3D g_strdup_printf("/memory@%"HWADDR_PRIx, addr);
> +    qemu_fdt_add_subnode(ms->fdt, mem_name);
> +    qemu_fdt_setprop_cells(ms->fdt, mem_name, "reg",
> +        addr >> 32, addr, size >> 32, size);
> +    qemu_fdt_setprop_string(ms->fdt, mem_name, "device_type", "memory");
> +    riscv_socket_fdt_write_id(ms, mem_name, socket);
> +}
> +
> +static void create_fdt_socket_aclint(RISCVServerRefMachineState *s,
> +                                     const MemMapEntry *memmap, int sock=
et,
> +                                     uint32_t *intc_phandles)
> +{
> +    int cpu;
> +    g_autofree char *name =3D NULL;
> +    hwaddr addr, size;
> +    uint32_t aclint_cells_size;
> +    g_autofree uint32_t *aclint_mtimer_cells =3D NULL;
> +    MachineState *ms =3D MACHINE(s);
> +
> +    aclint_mtimer_cells =3D g_new0(uint32_t, s->soc[socket].num_harts * =
2);
> +
> +    for (cpu =3D 0; cpu < s->soc[socket].num_harts; cpu++) {
> +        aclint_mtimer_cells[cpu * 2 + 0] =3D cpu_to_be32(intc_phandles[c=
pu]);
> +        aclint_mtimer_cells[cpu * 2 + 1] =3D cpu_to_be32(IRQ_M_TIMER);
> +    }
> +    aclint_cells_size =3D s->soc[socket].num_harts * sizeof(uint32_t) * =
2;
> +
> +    addr =3D memmap[RVSERVER_ACLINT].base +
> +           RISCV_ACLINT_DEFAULT_MTIMER_SIZE * socket;
> +    size =3D RISCV_ACLINT_DEFAULT_MTIMER_SIZE;
> +
> +    name =3D g_strdup_printf("/soc/mtimer@%"HWADDR_PRIx, addr);
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible",
> +        "riscv,aclint-mtimer");
> +    qemu_fdt_setprop_cells(ms->fdt, name, "reg",
> +        0x0, addr + RISCV_ACLINT_DEFAULT_MTIME,
> +        0x0, size - RISCV_ACLINT_DEFAULT_MTIME,
> +        0x0, addr + RISCV_ACLINT_DEFAULT_MTIMECMP,
> +        0x0, RISCV_ACLINT_DEFAULT_MTIME);
> +    qemu_fdt_setprop(ms->fdt, name, "interrupts-extended",
> +        aclint_mtimer_cells, aclint_cells_size);
> +    riscv_socket_fdt_write_id(ms, name, socket);
> +}
> +
> +static uint32_t imsic_num_bits(uint32_t count)
>
Can we make this API common so that it is not required to duplicate in
each platform?

> +{
> +    uint32_t ret =3D 0;
> +
> +    while (BIT(ret) < count) {
> +        ret++;
> +    }
> +
> +    return ret;
> +}
> +
> +static void create_fdt_one_imsic(RISCVServerRefMachineState *s,
> +                                 hwaddr base_addr,
> +                                 uint32_t *intc_phandles,
> +                                 uint32_t msi_phandle,
> +                                 bool m_mode, uint32_t imsic_guest_bits)
> +{
> +    int cpu, socket;
> +    g_autofree char *imsic_name =3D NULL;
> +    MachineState *ms =3D MACHINE(s);
> +    int socket_count =3D riscv_socket_count(ms);
> +    uint32_t imsic_max_hart_per_socket, imsic_addr, imsic_size;
> +    g_autofree uint32_t *imsic_cells =3D NULL;
> +    g_autofree uint32_t *imsic_regs =3D NULL;
> +    static const char * const imsic_compat[2] =3D {
> +        "qemu,imsics", "riscv,imsics"
> +    };
> +
> +    imsic_cells =3D g_new0(uint32_t, ms->smp.cpus * 2);
> +    imsic_regs =3D g_new0(uint32_t, socket_count * 4);
> +
> +    for (cpu =3D 0; cpu < ms->smp.cpus; cpu++) {
> +        imsic_cells[cpu * 2 + 0] =3D cpu_to_be32(intc_phandles[cpu]);
> +        imsic_cells[cpu * 2 + 1] =3D cpu_to_be32(m_mode ? IRQ_M_EXT : IR=
Q_S_EXT);
> +    }
> +
> +    imsic_max_hart_per_socket =3D 0;
> +    for (socket =3D 0; socket < socket_count; socket++) {
> +        imsic_addr =3D base_addr + socket * RVSERVER_IMSIC_GROUP_MAX_SIZ=
E;
> +        imsic_size =3D IMSIC_HART_SIZE(imsic_guest_bits) *
> +                     s->soc[socket].num_harts;
> +        imsic_regs[socket * 4 + 0] =3D 0;
> +        imsic_regs[socket * 4 + 1] =3D cpu_to_be32(imsic_addr);
> +        imsic_regs[socket * 4 + 2] =3D 0;
> +        imsic_regs[socket * 4 + 3] =3D cpu_to_be32(imsic_size);
> +        if (imsic_max_hart_per_socket < s->soc[socket].num_harts) {
> +            imsic_max_hart_per_socket =3D s->soc[socket].num_harts;
> +        }
> +    }
> +
> +    imsic_name =3D g_strdup_printf("/soc/interrupt-controller@%lx",
> +                                 (unsigned long)base_addr);
> +    qemu_fdt_add_subnode(ms->fdt, imsic_name);
> +    qemu_fdt_setprop_string_array(ms->fdt, imsic_name, "compatible",
> +                                  (char **)&imsic_compat,
> +                                  ARRAY_SIZE(imsic_compat));
> +
> +    qemu_fdt_setprop_cell(ms->fdt, imsic_name, "#interrupt-cells",
> +                          FDT_IMSIC_INT_CELLS);
> +    qemu_fdt_setprop(ms->fdt, imsic_name, "interrupt-controller", NULL, =
0);
> +    qemu_fdt_setprop(ms->fdt, imsic_name, "msi-controller", NULL, 0);
> +    qemu_fdt_setprop(ms->fdt, imsic_name, "interrupts-extended",
> +                     imsic_cells, ms->smp.cpus * sizeof(uint32_t) * 2);
> +    qemu_fdt_setprop(ms->fdt, imsic_name, "reg", imsic_regs,
> +                     socket_count * sizeof(uint32_t) * 4);
> +    qemu_fdt_setprop_cell(ms->fdt, imsic_name, "riscv,num-ids",
> +                          RVSERVER_IRQCHIP_NUM_MSIS);
> +
> +    if (imsic_guest_bits) {
> +        qemu_fdt_setprop_cell(ms->fdt, imsic_name, "riscv,guest-index-bi=
ts",
> +                              imsic_guest_bits);
> +    }
> +
> +    if (socket_count > 1) {
> +        qemu_fdt_setprop_cell(ms->fdt, imsic_name, "riscv,hart-index-bit=
s",
> +                              imsic_num_bits(imsic_max_hart_per_socket))=
;
> +        qemu_fdt_setprop_cell(ms->fdt, imsic_name, "riscv,group-index-bi=
ts",
> +                              imsic_num_bits(socket_count));
> +        qemu_fdt_setprop_cell(ms->fdt, imsic_name, "riscv,group-index-sh=
ift",
> +                              IMSIC_MMIO_GROUP_MIN_SHIFT);
> +    }
> +    qemu_fdt_setprop_cell(ms->fdt, imsic_name, "phandle", msi_phandle);
> +}
> +
> +static void create_fdt_imsic(RISCVServerRefMachineState *s,
> +                             const MemMapEntry *memmap,
> +                             uint32_t *phandle, uint32_t *intc_phandles,
> +                             uint32_t *msi_m_phandle, uint32_t *msi_s_ph=
andle)
> +{
> +    *msi_m_phandle =3D (*phandle)++;
> +    *msi_s_phandle =3D (*phandle)++;
> +
> +    /* M-level IMSIC node */
> +    create_fdt_one_imsic(s, memmap[RVSERVER_IMSIC_M].base, intc_phandles=
,
> +                         *msi_m_phandle, true, 0);
> +
> +    /* S-level IMSIC node */
> +    create_fdt_one_imsic(s, memmap[RVSERVER_IMSIC_S].base, intc_phandles=
,
> +                         *msi_s_phandle, false,
> +                         imsic_num_bits(s->aia_guests + 1));
> +
> +}
> +
> +/* Caller must free string after use.  Copied from hw/riscv/virt.c.  */
> +static char *fdt_get_aplic_nodename(unsigned long aplic_addr)
> +{
> +    return g_strdup_printf("/soc/interrupt-controller@%lx", aplic_addr);
> +}
> +
> +static void create_fdt_one_aplic(RISCVServerRefMachineState *s, int sock=
et,
> +                                 unsigned long aplic_addr, uint32_t apli=
c_size,
> +                                 uint32_t msi_phandle,
> +                                 uint32_t *intc_phandles,
> +                                 uint32_t aplic_phandle,
> +                                 uint32_t aplic_child_phandle,
> +                                 bool m_mode, int num_harts)
> +{
> +    int cpu;
> +    g_autofree char *aplic_name =3D fdt_get_aplic_nodename(aplic_addr);
> +    g_autofree uint32_t *aplic_cells =3D g_new0(uint32_t, num_harts * 2)=
;
> +    MachineState *ms =3D MACHINE(s);
> +    static const char * const aplic_compat[2] =3D {
> +        "qemu,aplic", "riscv,aplic"
> +    };
> +
> +    for (cpu =3D 0; cpu < num_harts; cpu++) {
> +        aplic_cells[cpu * 2 + 0] =3D cpu_to_be32(intc_phandles[cpu]);
> +        aplic_cells[cpu * 2 + 1] =3D cpu_to_be32(m_mode ? IRQ_M_EXT : IR=
Q_S_EXT);
> +    }
> +
> +    qemu_fdt_add_subnode(ms->fdt, aplic_name);
> +    qemu_fdt_setprop_string_array(ms->fdt, aplic_name, "compatible",
> +                                  (char **)&aplic_compat,
> +                                  ARRAY_SIZE(aplic_compat));
> +    qemu_fdt_setprop_cell(ms->fdt, aplic_name, "#address-cells",
> +                          FDT_APLIC_ADDR_CELLS);
> +    qemu_fdt_setprop_cell(ms->fdt, aplic_name,
> +                          "#interrupt-cells", FDT_APLIC_INT_CELLS);
> +    qemu_fdt_setprop(ms->fdt, aplic_name, "interrupt-controller", NULL, =
0);
> +
> +    qemu_fdt_setprop_cell(ms->fdt, aplic_name, "msi-parent", msi_phandle=
);
> +
> +    qemu_fdt_setprop_cells(ms->fdt, aplic_name, "reg",
> +                           0x0, aplic_addr, 0x0, aplic_size);
> +    qemu_fdt_setprop_cell(ms->fdt, aplic_name, "riscv,num-sources",
> +                          RVSERVER_IRQCHIP_NUM_SOURCES);
> +
> +    if (aplic_child_phandle) {
> +        qemu_fdt_setprop_cell(ms->fdt, aplic_name, "riscv,children",
> +                              aplic_child_phandle);
> +        qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegate",
> +                               aplic_child_phandle, 0x1,
> +                               RVSERVER_IRQCHIP_NUM_SOURCES);
> +    }
> +
> +    riscv_socket_fdt_write_id(ms, aplic_name, socket);
> +    qemu_fdt_setprop_cell(ms->fdt, aplic_name, "phandle", aplic_phandle)=
;
> +}
> +
> +static void create_fdt_socket_aplic(RISCVServerRefMachineState *s,
> +                                    const MemMapEntry *memmap, int socke=
t,
> +                                    uint32_t msi_m_phandle,
> +                                    uint32_t msi_s_phandle,
> +                                    uint32_t *phandle,
> +                                    uint32_t *intc_phandles,
> +                                    uint32_t *aplic_phandles,
> +                                    int num_harts)
> +{
> +    unsigned long aplic_addr;
> +    uint32_t aplic_m_phandle, aplic_s_phandle;
> +
> +    aplic_m_phandle =3D (*phandle)++;
> +    aplic_s_phandle =3D (*phandle)++;
> +
> +    /* M-level APLIC node */
> +    aplic_addr =3D memmap[RVSERVER_APLIC_M].base +
> +                 memmap[RVSERVER_APLIC_M].size * socket;
> +    create_fdt_one_aplic(s, socket, aplic_addr, memmap[RVSERVER_APLIC_M]=
.size,
> +                         msi_m_phandle, intc_phandles,
> +                         aplic_m_phandle, aplic_s_phandle,
> +                         true, num_harts);
> +
> +    /* S-level APLIC node */
> +    aplic_addr =3D memmap[RVSERVER_APLIC_S].base +
> +                 memmap[RVSERVER_APLIC_S].size * socket;
> +    create_fdt_one_aplic(s, socket, aplic_addr, memmap[RVSERVER_APLIC_S]=
.size,
> +                         msi_s_phandle, intc_phandles,
> +                         aplic_s_phandle, 0,
> +                         false, num_harts);
> +
> +    aplic_phandles[socket] =3D aplic_s_phandle;
> +}
> +
> +static void create_fdt_pmu(RISCVServerRefMachineState *s)
> +{
> +    g_autofree char *pmu_name =3D g_strdup_printf("/pmu");
> +    MachineState *ms =3D MACHINE(s);
> +    RISCVCPU *hart =3D &s->soc[0].harts[0];
> +
> +    qemu_fdt_add_subnode(ms->fdt, pmu_name);
> +    qemu_fdt_setprop_string(ms->fdt, pmu_name, "compatible", "riscv,pmu"=
);
> +    riscv_pmu_generate_fdt_node(ms->fdt, hart->pmu_avail_ctrs, pmu_name)=
;
> +}
> +
> +static void create_fdt_sockets(RISCVServerRefMachineState *s,
> +                               const MemMapEntry *memmap,
> +                               uint32_t *phandle,
> +                               uint32_t *irq_mmio_phandle,
> +                               uint32_t *irq_pcie_phandle,
> +                               uint32_t *msi_pcie_phandle)
> +{
> +    int socket, phandle_pos;
> +    MachineState *ms =3D MACHINE(s);
> +    uint32_t msi_m_phandle =3D 0, msi_s_phandle =3D 0;
> +    uint32_t xplic_phandles[MAX_NODES];
> +    g_autofree uint32_t *intc_phandles =3D NULL;
> +    int socket_count =3D riscv_socket_count(ms);
> +
> +    qemu_fdt_add_subnode(ms->fdt, "/cpus");
> +    qemu_fdt_setprop_cell(ms->fdt, "/cpus", "timebase-frequency",
> +                          RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ);
> +    qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#size-cells", 0x0);
> +    qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#address-cells", 0x1);
> +    qemu_fdt_add_subnode(ms->fdt, "/cpus/cpu-map");
> +
> +    intc_phandles =3D g_new0(uint32_t, ms->smp.cpus);
> +
> +    phandle_pos =3D ms->smp.cpus;
> +    for (socket =3D (socket_count - 1); socket >=3D 0; socket--) {
> +        g_autofree char *clust_name =3D NULL;
> +        phandle_pos -=3D s->soc[socket].num_harts;
> +
> +        clust_name =3D g_strdup_printf("/cpus/cpu-map/cluster%d", socket=
);
> +        qemu_fdt_add_subnode(ms->fdt, clust_name);
> +
> +        create_fdt_socket_cpus(s, socket, clust_name, phandle,
> +                               &intc_phandles[phandle_pos]);
> +
> +        create_fdt_socket_memory(s, memmap, socket);
> +
> +        create_fdt_socket_aclint(s, memmap, socket,
> +            &intc_phandles[phandle_pos]);
> +    }
> +
> +    create_fdt_imsic(s, memmap, phandle, intc_phandles,
> +        &msi_m_phandle, &msi_s_phandle);
> +    *msi_pcie_phandle =3D msi_s_phandle;
> +
> +    phandle_pos =3D ms->smp.cpus;
> +    for (socket =3D (socket_count - 1); socket >=3D 0; socket--) {
> +        phandle_pos -=3D s->soc[socket].num_harts;
> +
> +        create_fdt_socket_aplic(s, memmap, socket,
> +                                msi_m_phandle, msi_s_phandle, phandle,
> +                                &intc_phandles[phandle_pos],
> +                                xplic_phandles,
> +                                s->soc[socket].num_harts);
> +    }
> +
> +    for (socket =3D 0; socket < socket_count; socket++) {
> +        if (socket =3D=3D 0) {
> +            *irq_mmio_phandle =3D xplic_phandles[socket];
> +            *irq_pcie_phandle =3D xplic_phandles[socket];
> +        }
> +        if (socket =3D=3D 1) {
> +            *irq_pcie_phandle =3D xplic_phandles[socket];
> +        }
> +    }
> +
> +    riscv_socket_fdt_write_distance_matrix(ms);
> +}
> +
> +static void create_fdt_iommu_sys(RISCVServerRefMachineState *s,
> +                                 uint32_t irq_chip,
> +                                 uint32_t msi_phandle,
> +                                 uint32_t *iommu_sys_phandle)
> +{
> +    const char comp[] =3D "riscv,iommu";
> +    void *fdt =3D MACHINE(s)->fdt;
> +    uint32_t iommu_phandle;
> +    g_autofree char *iommu_node =3D NULL;
> +    hwaddr addr =3D s->memmap[RVSERVER_IOMMU_SYS].base;
> +    hwaddr size =3D s->memmap[RVSERVER_IOMMU_SYS].size;
> +    uint32_t iommu_irq_map[RISCV_IOMMU_INTR_COUNT] =3D {
> +        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_CQ,
> +        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_FQ,
> +        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_PM,
> +        IOMMU_SYS_IRQ + RISCV_IOMMU_INTR_PQ,
> +    };
> +
> +    iommu_node =3D g_strdup_printf("/soc/iommu@%"HWADDR_PRIx,
> +                                 s->memmap[RVSERVER_IOMMU_SYS].base);
> +    iommu_phandle =3D qemu_fdt_alloc_phandle(fdt);
> +    qemu_fdt_add_subnode(fdt, iommu_node);
> +
> +    qemu_fdt_setprop(fdt, iommu_node, "compatible", comp, sizeof(comp));
> +    qemu_fdt_setprop_cell(fdt, iommu_node, "#iommu-cells", 1);
> +    qemu_fdt_setprop_cell(fdt, iommu_node, "phandle", iommu_phandle);
> +
> +    qemu_fdt_setprop_cells(fdt, iommu_node, "reg",
> +                           addr >> 32, addr, size >> 32, size);
> +    qemu_fdt_setprop_cell(fdt, iommu_node, "interrupt-parent", irq_chip)=
;
> +
> +    qemu_fdt_setprop_cells(fdt, iommu_node, "interrupts",
> +        iommu_irq_map[0], FDT_IRQ_TYPE_EDGE_LOW,
> +        iommu_irq_map[1], FDT_IRQ_TYPE_EDGE_LOW,
> +        iommu_irq_map[2], FDT_IRQ_TYPE_EDGE_LOW,
> +        iommu_irq_map[3], FDT_IRQ_TYPE_EDGE_LOW);
> +
> +    qemu_fdt_setprop_cell(fdt, iommu_node, "msi-parent", msi_phandle);
> +
> +    *iommu_sys_phandle =3D iommu_phandle;
> +}
> +
> +static void create_fdt_pcie(RISCVServerRefMachineState *s,
> +                            const MemMapEntry *memmap,
> +                            uint32_t irq_pcie_phandle,
> +                            uint32_t msi_pcie_phandle,
> +                            uint32_t iommu_sys_phandle)
> +{
> +    g_autofree char *name =3D NULL;
> +    MachineState *ms =3D MACHINE(s);
> +
> +    name =3D g_strdup_printf("/soc/pci@%"HWADDR_PRIx,
> +                           memmap[RVSERVER_PCIE_ECAM].base);
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "#address-cells",
> +        FDT_PCI_ADDR_CELLS);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "#interrupt-cells",
> +        FDT_PCI_INT_CELLS);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "#size-cells", 0x2);
> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible",
> +        "pci-host-ecam-generic");
> +    qemu_fdt_setprop_string(ms->fdt, name, "device_type", "pci");
> +    qemu_fdt_setprop_cell(ms->fdt, name, "linux,pci-domain", 0);
> +    qemu_fdt_setprop_cells(ms->fdt, name, "bus-range", 0,
> +        memmap[RVSERVER_PCIE_ECAM].size / PCIE_MMCFG_SIZE_MIN - 1);
> +    qemu_fdt_setprop(ms->fdt, name, "dma-coherent", NULL, 0);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "msi-parent", msi_pcie_phandle)=
;
> +    qemu_fdt_setprop_cells(ms->fdt, name, "reg", 0,
> +        memmap[RVSERVER_PCIE_ECAM].base, 0, memmap[RVSERVER_PCIE_ECAM].s=
ize);
> +    qemu_fdt_setprop_sized_cells(ms->fdt, name, "ranges",
> +        1, FDT_PCI_RANGE_IOPORT, 2, 0,
> +        2, memmap[RVSERVER_PCIE_PIO].base, 2, memmap[RVSERVER_PCIE_PIO].=
size,
> +        1, FDT_PCI_RANGE_MMIO,
> +        2, memmap[RVSERVER_PCIE_MMIO].base,
> +        2, memmap[RVSERVER_PCIE_MMIO].base, 2, memmap[RVSERVER_PCIE_MMIO=
].size,
> +        1, FDT_PCI_RANGE_MMIO_64BIT,
> +        2, memmap[RVSERVER_PCIE_MMIO_HIGH].base,
> +        2, memmap[RVSERVER_PCIE_MMIO_HIGH].base, 2,
> +           memmap[RVSERVER_PCIE_MMIO_HIGH].size);
> +
> +    create_pcie_irq_map(s, ms->fdt, name, irq_pcie_phandle);
> +
> +    qemu_fdt_setprop_cells(ms->fdt, name, "iommu-map",
> +                           0, iommu_sys_phandle, 0, 0x10000);
> +}
> +
> +static void create_fdt_reset(RISCVServerRefMachineState *s,
> +                             const MemMapEntry *memmap,
> +                             uint32_t *phandle)
> +{
> +    char *name;
> +    uint32_t test_phandle;
> +    MachineState *ms =3D MACHINE(s);
> +
> +    test_phandle =3D (*phandle)++;
> +    name =3D g_strdup_printf("/soc/reset_syscon@%"HWADDR_PRIx,
> +                           memmap[RVSERVER_RESET_SYSCON].base);
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "syscon");
> +    qemu_fdt_setprop_cells(ms->fdt, name, "reg",
> +        0x0, memmap[RVSERVER_RESET_SYSCON].base,
> +        0x0, memmap[RVSERVER_RESET_SYSCON].size);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "phandle", test_phandle);
> +    test_phandle =3D qemu_fdt_get_phandle(ms->fdt, name);
> +    g_free(name);
> +
> +    name =3D g_strdup_printf("/soc/reboot");
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "syscon-reboot"=
);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "regmap", test_phandle);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "offset", 0x0);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "value", SYSCON_RESET);
> +    g_free(name);
> +
> +    name =3D g_strdup_printf("/soc/poweroff");
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "syscon-powerof=
f");
> +    qemu_fdt_setprop_cell(ms->fdt, name, "regmap", test_phandle);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "offset", 0x0);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "value", SYSCON_POWEROFF);
> +    g_free(name);
> +}
> +
> +static void create_fdt_uart(RISCVServerRefMachineState *s,
> +                            const MemMapEntry *memmap,
> +                            uint32_t irq_mmio_phandle)
> +{
> +    g_autofree char *name =3D NULL;
> +    MachineState *ms =3D MACHINE(s);
> +
> +    name =3D g_strdup_printf("/soc/serial@%"HWADDR_PRIx,
> +                           memmap[RVSERVER_UART0].base);
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "ns16550a");
> +    qemu_fdt_setprop_cells(ms->fdt, name, "reg",
> +        0x0, memmap[RVSERVER_UART0].base,
> +        0x0, memmap[RVSERVER_UART0].size);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "clock-frequency", 3686400);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent",
> +                          irq_mmio_phandle);
> +    qemu_fdt_setprop_cells(ms->fdt, name, "interrupts",
> +                           RVSERVER_UART0_IRQ, 0x4);
> +
> +    qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
> +}
> +
> +static void create_fdt_rtc(RISCVServerRefMachineState *s,
> +                           const MemMapEntry *memmap,
> +                           uint32_t irq_mmio_phandle)
> +{
> +    g_autofree char *name =3D NULL;
> +    MachineState *ms =3D MACHINE(s);
> +
> +    name =3D g_strdup_printf("/soc/rtc@%"HWADDR_PRIx,
> +                           memmap[RVSERVER_RTC].base);
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible",
> +        "google,goldfish-rtc");
> +    qemu_fdt_setprop_cells(ms->fdt, name, "reg",
> +        0x0, memmap[RVSERVER_RTC].base, 0x0, memmap[RVSERVER_RTC].size);
> +    qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent",
> +                          irq_mmio_phandle);
> +    qemu_fdt_setprop_cells(ms->fdt, name, "interrupts",
> +                           RVSERVER_RTC_IRQ, 0x4);
> +}
> +
> +static void create_fdt_flash(RISCVServerRefMachineState *s,
> +                             const MemMapEntry *memmap)
> +{
> +    MachineState *ms =3D MACHINE(s);
> +    hwaddr flashsize =3D rvserver_ref_memmap[RVSERVER_FLASH].size / 2;
> +    hwaddr flashbase =3D rvserver_ref_memmap[RVSERVER_FLASH].base;
> +    g_autofree char *name =3D g_strdup_printf("/flash@%"HWADDR_PRIx, fla=
shbase);
> +
> +    qemu_fdt_add_subnode(ms->fdt, name);
> +    qemu_fdt_setprop_string(ms->fdt, name, "compatible", "cfi-flash");
> +    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
> +                                 2, flashbase, 2, flashsize,
> +                                 2, flashbase + flashsize, 2, flashsize)=
;
> +    qemu_fdt_setprop_cell(ms->fdt, name, "bank-width", 4);
> +}
> +
> +static void finalize_fdt(RISCVServerRefMachineState *s)
> +{
> +    uint32_t phandle =3D 1, irq_mmio_phandle =3D 1, msi_pcie_phandle =3D=
 1;
> +    uint32_t irq_pcie_phandle =3D 1, iommu_sys_phandle;
> +
> +    create_fdt_sockets(s, rvserver_ref_memmap, &phandle, &irq_mmio_phand=
le,
> +                       &irq_pcie_phandle, &msi_pcie_phandle);
> +
> +    create_fdt_iommu_sys(s, irq_mmio_phandle, msi_pcie_phandle,
> +                         &iommu_sys_phandle);
> +
> +    create_fdt_pcie(s, rvserver_ref_memmap, irq_pcie_phandle,
> +                    msi_pcie_phandle, iommu_sys_phandle);
> +
> +    create_fdt_reset(s, rvserver_ref_memmap, &phandle);
> +
> +    create_fdt_uart(s, rvserver_ref_memmap, irq_mmio_phandle);
> +
> +    create_fdt_rtc(s, rvserver_ref_memmap, irq_mmio_phandle);
> +}
> +
> +static void create_fdt(RISCVServerRefMachineState *s,
> +                       const MemMapEntry *memmap)
> +{
> +    MachineState *ms =3D MACHINE(s);
> +    uint8_t rng_seed[32];
> +
> +    ms->fdt =3D create_device_tree(&s->fdt_size);
> +    if (!ms->fdt) {
> +        error_report("create_device_tree() failed");
> +        exit(1);
> +    }
> +
> +    qemu_fdt_setprop_string(ms->fdt, "/", "model", "qemu,riscv-server-re=
f");
> +    qemu_fdt_setprop_string(ms->fdt, "/", "compatible", "riscv-server-re=
f");
> +    qemu_fdt_setprop_cell(ms->fdt, "/", "#size-cells", 0x2);
> +    qemu_fdt_setprop_cell(ms->fdt, "/", "#address-cells", 0x2);
> +
> +    /*
> +     * This versioning scheme is for informing platform fw only. It is n=
either:
> +     * - A QEMU versioned machine type; a given version of QEMU will emu=
late
> +     *   a given version of the platform.
> +     * - A reflection of level of server platform support provided.
> +     *
> +     * machine-version-major: updated when changes breaking fw compatibi=
lity
> +     *                        are introduced.
> +     * machine-version-minor: updated when features are added that don't=
 break
> +     *                        fw compatibility.
> +     *
> +     * It's the same as the scheme in arm sbsa-ref.
> +     */
> +    qemu_fdt_setprop_cell(ms->fdt, "/", "machine-version-major", 0);
> +    qemu_fdt_setprop_cell(ms->fdt, "/", "machine-version-minor", 0);
> +
> +    qemu_fdt_add_subnode(ms->fdt, "/soc");
> +    qemu_fdt_setprop(ms->fdt, "/soc", "ranges", NULL, 0);
> +    qemu_fdt_setprop_string(ms->fdt, "/soc", "compatible", "simple-bus")=
;
> +    qemu_fdt_setprop_cell(ms->fdt, "/soc", "#size-cells", 0x2);
> +    qemu_fdt_setprop_cell(ms->fdt, "/soc", "#address-cells", 0x2);
> +
> +    qemu_fdt_add_subnode(ms->fdt, "/chosen");
> +
> +    /* Pass seed to RNG */
> +    qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
> +    qemu_fdt_setprop(ms->fdt, "/chosen", "rng-seed",
> +                     rng_seed, sizeof(rng_seed));
> +
> +    create_fdt_flash(s, memmap);
> +    create_fdt_pmu(s);
> +
> +}
> +
> +static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
> +                                          DeviceState *irqchip,
> +                                          RISCVServerRefMachineState *s)
> +{
> +    DeviceState *dev;
> +    PCIHostState *pci;
> +    PCIDevice *pdev_ahci;
> +    AHCIPCIState *ich9;
> +    DriveInfo *hd[NUM_SATA_PORTS];
> +    MemoryRegion *ecam_alias, *ecam_reg;
> +    MemoryRegion *mmio_alias, *high_mmio_alias, *mmio_reg;
> +    hwaddr ecam_base =3D rvserver_ref_memmap[RVSERVER_PCIE_ECAM].base;
> +    hwaddr ecam_size =3D rvserver_ref_memmap[RVSERVER_PCIE_ECAM].size;
> +    hwaddr mmio_base =3D rvserver_ref_memmap[RVSERVER_PCIE_MMIO].base;
> +    hwaddr mmio_size =3D rvserver_ref_memmap[RVSERVER_PCIE_MMIO].size;
> +    hwaddr high_mmio_base =3D rvserver_ref_memmap[RVSERVER_PCIE_MMIO_HIG=
H].base;
> +    hwaddr high_mmio_size =3D rvserver_ref_memmap[RVSERVER_PCIE_MMIO_HIG=
H].size;
> +    hwaddr pio_base =3D rvserver_ref_memmap[RVSERVER_PCIE_PIO].base;
> +    hwaddr pio_size =3D rvserver_ref_memmap[RVSERVER_PCIE_PIO].size;
> +    MachineClass *mc =3D MACHINE_GET_CLASS(s);
> +    qemu_irq irq;
> +    int i;
> +
> +    dev =3D qdev_new(TYPE_GPEX_HOST);
> +
> +    object_property_set_uint(OBJECT(GPEX_HOST(dev)), PCI_HOST_ECAM_BASE,
> +                            ecam_base, NULL);
> +    object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_ECAM_SIZE,
> +                            ecam_size, NULL);
> +    object_property_set_uint(OBJECT(GPEX_HOST(dev)),
> +                             PCI_HOST_BELOW_4G_MMIO_BASE,
> +                             mmio_base, NULL);
> +    object_property_set_int(OBJECT(GPEX_HOST(dev)),
> +                            PCI_HOST_BELOW_4G_MMIO_SIZE,
> +                            mmio_size, NULL);
> +    object_property_set_uint(OBJECT(GPEX_HOST(dev)),
> +                             PCI_HOST_ABOVE_4G_MMIO_BASE,
> +                             high_mmio_base, NULL);
> +    object_property_set_int(OBJECT(GPEX_HOST(dev)),
> +                            PCI_HOST_ABOVE_4G_MMIO_SIZE,
> +                            high_mmio_size, NULL);
> +    object_property_set_uint(OBJECT(GPEX_HOST(dev)), PCI_HOST_PIO_BASE,
> +                            pio_base, NULL);
> +    object_property_set_int(OBJECT(GPEX_HOST(dev)), PCI_HOST_PIO_SIZE,
> +                            pio_size, NULL);
> +
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    ecam_alias =3D g_new0(MemoryRegion, 1);
> +    ecam_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> +    memory_region_init_alias(ecam_alias, OBJECT(dev), "pcie-ecam",
> +                             ecam_reg, 0, ecam_size);
> +    memory_region_add_subregion(get_system_memory(), ecam_base, ecam_ali=
as);
> +
> +    mmio_alias =3D g_new0(MemoryRegion, 1);
> +    mmio_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
> +    memory_region_init_alias(mmio_alias, OBJECT(dev), "pcie-mmio",
> +                             mmio_reg, mmio_base, mmio_size);
> +    memory_region_add_subregion(get_system_memory(), mmio_base, mmio_ali=
as);
> +
> +    /* Map high MMIO space */
> +    high_mmio_alias =3D g_new0(MemoryRegion, 1);
> +    memory_region_init_alias(high_mmio_alias, OBJECT(dev), "pcie-mmio-hi=
gh",
> +                             mmio_reg, high_mmio_base, high_mmio_size);
> +    memory_region_add_subregion(get_system_memory(), high_mmio_base,
> +                                high_mmio_alias);
> +
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, pio_base);
> +
> +    for (i =3D 0; i < PCI_NUM_PINS; i++) {
> +        irq =3D qdev_get_gpio_in(irqchip, RVSERVER_PCIE_IRQ + i);
> +
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
> +        gpex_set_irq_num(GPEX_HOST(dev), i, RVSERVER_PCIE_IRQ + i);
> +    }
> +
> +    pci =3D PCI_HOST_BRIDGE(dev);
> +    pci_init_nic_devices(pci->bus, mc->default_nic);
> +    /* IDE disk setup.  */
> +    pdev_ahci =3D pci_create_simple(pci->bus, -1, TYPE_ICH9_AHCI);
> +    ich9 =3D ICH9_AHCI(pdev_ahci);
> +    g_assert(ARRAY_SIZE(hd) =3D=3D ich9->ahci.ports);
> +    ide_drive_get(hd, ich9->ahci.ports);
> +    ahci_ide_create_devs(&ich9->ahci, hd);
> +
> +    GPEX_HOST(dev)->gpex_cfg.bus =3D PCI_HOST_BRIDGE(GPEX_HOST(dev))->bu=
s;
> +    return dev;
> +}
> +
> +static DeviceState *rvserver_ref_create_aia(int aia_guests,
> +                                            const MemMapEntry *memmap,
> +                                            int socket,
> +                                            int base_hartid, int hart_co=
unt)
> +{
> +    int i;
> +    hwaddr addr;
> +    uint32_t guest_bits;
> +    DeviceState *aplic_s =3D NULL;
> +    DeviceState *aplic_m =3D NULL;
> +    bool msimode =3D true;
> +
> +    /* Per-socket M-level IMSICs */
> +    addr =3D memmap[RVSERVER_IMSIC_M].base +
> +           socket * RVSERVER_IMSIC_GROUP_MAX_SIZE;
> +    for (i =3D 0; i < hart_count; i++) {
> +        riscv_imsic_create(addr + i * IMSIC_HART_SIZE(0),
> +                           base_hartid + i, true, 1,
> +                           RVSERVER_IRQCHIP_NUM_MSIS);
> +    }
> +
> +    /* Per-socket S-level IMSICs */
> +    guest_bits =3D imsic_num_bits(aia_guests + 1);
> +    addr =3D memmap[RVSERVER_IMSIC_S].base +
> +           socket * RVSERVER_IMSIC_GROUP_MAX_SIZE;
> +    for (i =3D 0; i < hart_count; i++) {
> +        riscv_imsic_create(addr + i * IMSIC_HART_SIZE(guest_bits),
> +                           base_hartid + i, false, 1 + aia_guests,
> +                           RVSERVER_IRQCHIP_NUM_MSIS);
> +    }
> +
> +    /* Per-socket M-level APLIC */
> +    aplic_m =3D riscv_aplic_create(memmap[RVSERVER_APLIC_M].base +
> +                                 socket * memmap[RVSERVER_APLIC_M].size,
> +                                 memmap[RVSERVER_APLIC_M].size,
> +                                 (msimode) ? 0 : base_hartid,
> +                                 (msimode) ? 0 : hart_count,
> +                                 RVSERVER_IRQCHIP_NUM_SOURCES,
> +                                 RVSERVER_IRQCHIP_NUM_PRIO_BITS,
> +                                 msimode, true, NULL);
> +
> +    /* Per-socket S-level APLIC */
> +    aplic_s =3D riscv_aplic_create(memmap[RVSERVER_APLIC_S].base +
> +                                 socket * memmap[RVSERVER_APLIC_S].size,
> +                                 memmap[RVSERVER_APLIC_S].size,
> +                                 (msimode) ? 0 : base_hartid,
> +                                 (msimode) ? 0 : hart_count,
> +                                 RVSERVER_IRQCHIP_NUM_SOURCES,
> +                                 RVSERVER_IRQCHIP_NUM_PRIO_BITS,
> +                                 msimode, false, aplic_m);
> +
> +    (void)aplic_s;
>
This looks weird to me. Is this to resolve some compiler warning? Why
can't this function just return success / failure?

> +    return aplic_m;
> +}
> +
> +static uint64_t rvserver_reset_syscon_read(void *opaque, hwaddr addr,
> +                                           unsigned size)
> +{
> +    return 0;
> +}
> +
> +static void rvserver_reset_syscon_write(void *opaque, hwaddr addr,
> +                                        uint64_t val64, unsigned int siz=
e)
> +{
> +    switch (val64) {
> +    case SYSCON_POWEROFF:
> +        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> +        return;
> +    case SYSCON_RESET:
> +        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> +        return;
> +    default:
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps rvserver_reset_syscon_ops =3D {
> +    .read =3D rvserver_reset_syscon_read,
> +    .write =3D rvserver_reset_syscon_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN
> +};
> +
> +static void rvserver_ref_machine_done(Notifier *notifier, void *data)
> +{
> +    RISCVServerRefMachineState *s =3D container_of(
> +        notifier, RISCVServerRefMachineState, machine_done);
> +    const MemMapEntry *memmap =3D rvserver_ref_memmap;
> +    MachineState *machine =3D MACHINE(s);
> +    hwaddr start_addr =3D memmap[RVSERVER_DRAM].base;
> +    target_ulong firmware_end_addr, kernel_start_addr;
> +    const char *firmware_name =3D riscv_default_firmware_name(&s->soc[0]=
);
> +    uint64_t fdt_load_addr;
> +    uint64_t kernel_entry =3D 0;
> +    BlockBackend *pflash_blk0;
> +    RISCVBootInfo boot_info;
> +
> +    /*
> +     * An user provided dtb must include everything, including
> +     * dynamic sysbus devices. Our FDT needs to be finalized.
> +     */
> +    if (machine->dtb =3D=3D NULL) {
> +        finalize_fdt(s);
> +    }
> +
> +    firmware_end_addr =3D riscv_find_and_load_firmware(machine, firmware=
_name,
> +                                                     &start_addr, NULL);
> +
> +    pflash_blk0 =3D pflash_cfi01_get_blk(s->flash[0]);
> +    if (pflash_blk0) {
> +        if (machine->firmware && !strcmp(machine->firmware, "none")) {
> +            /*
> +             * Pflash was supplied but bios is none and not KVM guest,
> +             * let's overwrite the address we jump to after reset to
> +             * the base of the flash.
> +             */
> +            start_addr =3D rvserver_ref_memmap[RVSERVER_FLASH].base;
> +        } else {
> +            /*
> +             * Pflash was supplied but either KVM guest or bios is not n=
one.
> +             * In this case, base of the flash would contain S-mode payl=
oad.
> +             */
> +            riscv_setup_firmware_boot(machine);
> +            kernel_entry =3D rvserver_ref_memmap[RVSERVER_FLASH].base;
> +        }
> +    }
> +
> +    riscv_boot_info_init(&boot_info, &s->soc[0]);
> +
> +    if (machine->kernel_filename && !kernel_entry) {
> +        kernel_start_addr =3D riscv_calc_kernel_start_addr(&boot_info,
> +                                                         firmware_end_ad=
dr);
> +        riscv_load_kernel(machine, &boot_info, kernel_start_addr, true, =
NULL);
> +        kernel_entry =3D boot_info.image_low_addr;
> +    }
> +
> +    fdt_load_addr =3D riscv_compute_fdt_addr(memmap[RVSERVER_DRAM].base,
> +                                           memmap[RVSERVER_DRAM].size,
> +                                           machine, &boot_info);
> +
> +    riscv_load_fdt(fdt_load_addr, machine->fdt);
> +
> +    /* load the reset vector */
> +    riscv_setup_rom_reset_vec(machine, &s->soc[0], start_addr,
> +                              rvserver_ref_memmap[RVSERVER_MROM].base,
> +                              rvserver_ref_memmap[RVSERVER_MROM].size,
> +                              kernel_entry,
> +                              fdt_load_addr);
> +
> +}
> +
> +static bool rvserver_aclint_allowed(void)
> +{
> +    return tcg_enabled() || qtest_enabled();
> +}
> +
> +static void rvserver_ref_machine_init(MachineState *machine)
> +{
> +    const MemMapEntry *memmap =3D rvserver_ref_memmap;
> +    RISCVServerRefMachineState *s =3D RISCV_SERVER_REF_MACHINE(machine);
> +    MemoryRegion *system_memory =3D get_system_memory();
> +    MemoryRegion *mask_rom =3D g_new(MemoryRegion, 1);
> +    MemoryRegion *reset_syscon_io =3D g_new(MemoryRegion, 1);
> +    DeviceState *mmio_irqchip, *pcie_irqchip, *iommu_sys;
> +    int i, base_hartid, hart_count;
> +    int socket_count =3D riscv_socket_count(machine);
> +
> +    /* Check socket count limit */
> +    if (RVSERVER_SOCKETS_MAX < socket_count) {
> +        error_report("number of sockets/nodes should be less than %d",
> +            RVSERVER_SOCKETS_MAX);
> +        exit(1);
> +    }
> +
> +    if (!rvserver_aclint_allowed()) {
> +        error_report("'aclint' is only available with TCG acceleration")=
;
> +        exit(1);
>
Why exit here? What does it mean then - is the machine not supported in KVM=
?

Thanks,
Sunil

