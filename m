Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5932CC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 05:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tntHu-0002Fi-Ap; Fri, 28 Feb 2025 00:51:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tntHq-0002F8-Ih; Fri, 28 Feb 2025 00:51:50 -0500
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tntHm-0000bz-7T; Fri, 28 Feb 2025 00:51:50 -0500
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-8622c3be2f4so690774241.1; 
 Thu, 27 Feb 2025 21:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740721904; x=1741326704; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IJnWCn/4ek3LZ9eDFJfPpGeZOHFBV9oM4STgSaLL53E=;
 b=Sp8c3YPS8OK6GMIIvzY21/aL9auPmJogydig0Q23BYhdcdj5Ho/WFUhgBbipGXszC/
 vgwnOaCyLup3AcQEXYO/Ehd4VsAJMqzTjYpaIViKfBl0TbdYq13cafMXdZQzZdhvKjTc
 E6fM3uFL3hUAKts4tRUAnpVkHcBGDO1zYcdgv+GguB1Xdcjp3PCA2pyHAUxRh1bRRI3b
 qrzdTuN99iS2TdGgKYhSbAoF9UREH+vxxoV31X0B2Sc6v1wvc8W1Nf311d+H88POvXHe
 w81M8EEVeK/xh1U4CDMulqRoqMxx+w2WiWuzj2ecYn/yHBSe2AOGfgKFANDpmdLMEKaC
 PZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740721904; x=1741326704;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IJnWCn/4ek3LZ9eDFJfPpGeZOHFBV9oM4STgSaLL53E=;
 b=LUwyqQSCiF80E4kzSa70xzMjxGX+XaCHlXspbzheHUg4wD8GEg+CHhel9qBnml7zF9
 z9NVGKVt7QwAego0hSeGd2asAfp+M1kRPuUhrP7ARhVlcsrkg/COU2WsE7+T2It3wTeu
 0394JV037aLKsxR+kN+7SaK0TzvP3KN44eVTam+ijiF7cbPvCGsJ9hjbDBh+B2erkgeB
 13rSfBgnuUDkQt4Kiik82FkZiq6xOD4/cz7uqK639R0vsBjJiKr8NKJZmktVBSXvofeK
 2P6uxwAFsiwkcWzuxSotkslxzlLklLLTTO6VaPGUt0VpkXSjVNjs/MZO1LRU0DsITHR+
 IP3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiPMYo8AOKByyFS6I85Xx20jnjQ7gUDIa25f13UfZFgvbsgYZ43/XSNvgHLebuq4mEy+PJ+jNrz6fi@nongnu.org
X-Gm-Message-State: AOJu0YwJLGPLS3Ap5lbS9sm0N/NpGWFEFfTIx5Jex0MsS59HGYDAVIVY
 5iOg14wXHLvPW4IVb0ao6dQfAZ86qey16gWezrJmv9hLUbepKelG/bHCb8AmXkxS9qM1tgQ6ukO
 XeiK/U+qGgTKg5nS5LJYq1vGr0Yc=
X-Gm-Gg: ASbGnctChRmkhqQxZmrT6shL8JxnFtbAJBHrEYEWeQ1SrUgtmiBpr0lJEVGOT+TVEL+
 pMtSp+QvQJ1wAN4CABp6VNXRHkJIG2a6IsR4FhaT2HXwDmrK2cVZqOmkAKNxIMqg4XJ7fYBs6QH
 MkKLEl2WlxnUCr80lXoKz/fEST47lSscA0lfik
X-Google-Smtp-Source: AGHT+IEHEK7JM/xOI3K3vyNAcw0wdsnx5Q7NOAtUtNgkgCsDMVaGzG7IJUQCJ9EmDMGavdpKmsa6/8RgCEqyg+Gzceo=
X-Received: by 2002:a05:6102:dcc:b0:4bb:5d61:1264 with SMTP id
 ada2fe7eead31-4c044fb5998mr1866770137.24.1740721903993; Thu, 27 Feb 2025
 21:51:43 -0800 (PST)
MIME-Version: 1.0
References: <20250122083617.3940240-1-ethan84@andestech.com>
 <20250122084655.3968598-1-ethan84@andestech.com>
In-Reply-To: <20250122084655.3968598-1-ethan84@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Feb 2025 15:51:17 +1000
X-Gm-Features: AQ5f1JqvDXxbnScSqUk11hngT0bobZwg-R0dVEzXDS4secz7ydXE29N8iHDlv6I
Message-ID: <CAKmqyKMv+Rp5VYbXCDC_i9daUkn1NDnDQ7vChAJ=nEpvFD1bxw@mail.gmail.com>
Subject: Re: [PATCH v10 6/8] hw/misc/riscv_iopmp: Add RISC-V IOPMP device
To: Ethan Chen <ethan84@andestech.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x934.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jan 22, 2025 at 6:48=E2=80=AFPM Ethan Chen via <qemu-devel@nongnu.o=
rg> wrote:
>
> Support IOPMP specification v0.9.2RC3.
> The specification url:
> https://github.com/riscv-non-isa/iopmp-spec/releases/tag/v0.9.2-RC3
>
> The IOPMP checks whether memory access from a device or CPU is valid.
> This implementation uses an IOMMU to modify the address space accessed
> by the device.
>
> For device access with IOMMUAccessFlags specifying read or write
> (IOMMU_RO or IOMMU_WO), the IOPMP checks the permission in
> iopmp_translate. If the access is valid, the target address space is
> downstream_as. If the access is blocked, it will be redirected to
> blocked_rwx_as.
>
> For CPU access with IOMMUAccessFlags not specifying read or write
> (IOMMU_NONE), the IOPMP translates the access to the corresponding
> address space based on the permission. If the access has full permission
> (rwx), the target address space is downstream_as. If the access has
> limited permission, the target address space is blocked_ followed by
> the lacked permissions.
>
> The operation of a blocked region can trigger an IOPMP interrupt, a bus
> error, or it can respond with success and fabricated data, depending on
> the value of the IOPMP ERR_CFG register.
>
> Support Properties and Default Values of the IOPMP Device
> The following are the supported properties and their default values for t=
he
> IOPMP device. If a property has no description here, please refer to the
> IOPMP specification for details:
>
> * mdcfg_fmt: 1 (Options: 0/1/2)
> * srcmd_fmt: 0 (Options: 0/1/2)
> * tor_en: true (Options: true/false)
> * sps_en: false (Options: true/false)
> * prient_prog: true (Options: true/false)
> * rrid_transl_en: false (Options: true/false)
> * rrid_transl_prog: false (Options: true/false)
> * chk_x: true (Options: true/false)
> * no_x: false (Options: true/false)
> * no_w: false (Options: true/false)
> * stall_en: false (Options: true/false)
> * peis: true (Options: true/false)
> * pees: true (Options: true/false)
> * mfr_en: true (Options: true/false)
> * md_entry_num: 5 (IMP: Valid only for mdcfg_fmt 1/2)
> * md_num: 8 (Range: 0-63)
> * rrid_num: 16 (Range: srcmd_fmt =E2=89=A0 2: 0-65535, srcmd_fmt =3D 2: 0=
-32)
> * entry_num: 48
>   (Range: 0-IMP. For mdcfg_fmt =3D 1, it is fixed as md_num * (md_entry_n=
um + 1).
>    Entry registers must not overlap with other registers.)
> * prio_entry: 65535
>   (Range: 0-IMP. If prio_entry > entry_num, it will be set to entry_num.)
> * rrid_transl: 0x0 (Range: 0-65535)
> * entry_offset: 0x4000
>   (IMP: Entry registers must not overlap with other registers.)
> * err_rdata: 0x0
>   (uint32. Specifies the value used in responses to read transactions whe=
n
>    errors are suppressed)
> * msi_en: false (Options: true/false)
> * msidata: 12 (Range: 1-1023)
> * stall_violation_en: true (Options: true/false)
> * err_msiaddr: 0x24000000 (low-part 32-bit address)
> * err_msiaddrh: 0x0 (high-part 32-bit address)
> * msi_rrid: 0
>   (Range: 0-65535. Specifies the rrid used by the IOPMP to send the MSI.)
>
> Signed-off-by: Ethan Chen <ethan84@andestech.com>
> ---
>  hw/misc/Kconfig               |    4 +
>  hw/misc/meson.build           |    1 +
>  hw/misc/riscv_iopmp.c         | 2182 +++++++++++++++++++++++++++++++++
>  hw/misc/trace-events          |    4 +
>  include/hw/misc/riscv_iopmp.h |  191 +++
>  5 files changed, 2382 insertions(+)
>  create mode 100644 hw/misc/riscv_iopmp.c
>  create mode 100644 include/hw/misc/riscv_iopmp.h
>
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 8f9ce2f68c..e4ad9cf9fe 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -220,4 +220,8 @@ config IOSB
>  config XLNX_VERSAL_TRNG
>      bool
>
> +config RISCV_IOPMP
> +    bool
> +    select STREAM
> +
>  source macio/Kconfig
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 55f493521b..88f2bb6b88 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -34,6 +34,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: fi=
les('sifive_e_prci.c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true: files('sifive_e_aon.=
c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.=
c'))
>  system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prc=
i.c'))
> +specific_ss.add(when: 'CONFIG_RISCV_IOPMP', if_true: files('riscv_iopmp.=
c'))
>
>  subdir('macio')
>
> diff --git a/hw/misc/riscv_iopmp.c b/hw/misc/riscv_iopmp.c
> new file mode 100644
> index 0000000000..ab8f616c03
> --- /dev/null
> +++ b/hw/misc/riscv_iopmp.c
> @@ -0,0 +1,2182 @@
> +/*
> + * QEMU RISC-V IOPMP (Input Output Physical Memory Protection)
> + *
> + * Copyright (c) 2023-2025 Andes Tech. Corp.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "trace.h"
> +#include "exec/exec-all.h"
> +#include "exec/address-spaces.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/sysbus.h"
> +#include "hw/misc/riscv_iopmp.h"
> +#include "memory.h"
> +#include "hw/irq.h"
> +#include "hw/registerfields.h"
> +#include "trace.h"
> +#include "qemu/main-loop.h"
> +#include "hw/stream.h"
> +#include "hw/misc/riscv_iopmp_txn_info.h"
> +
> +#define TYPE_RISCV_IOPMP_IOMMU_MEMORY_REGION "riscv-iopmp-iommu-memory-r=
egion"
> +
> +REG32(VERSION, 0x00)
> +    FIELD(VERSION, VENDOR, 0, 24)
> +    FIELD(VERSION, SPECVER , 24, 8)
> +REG32(IMPLEMENTATION, 0x04)
> +    FIELD(IMPLEMENTATION, IMPID, 0, 32)
> +REG32(HWCFG0, 0x08)
> +    FIELD(HWCFG0, MDCFG_FMT, 0, 2)
> +    FIELD(HWCFG0, SRCMD_FMT, 2, 2)
> +    FIELD(HWCFG0, TOR_EN, 4, 1)
> +    FIELD(HWCFG0, SPS_EN, 5, 1)
> +    FIELD(HWCFG0, USER_CFG_EN, 6, 1)
> +    FIELD(HWCFG0, PRIENT_PROG, 7, 1)
> +    FIELD(HWCFG0, RRID_TRANSL_EN, 8, 1)
> +    FIELD(HWCFG0, RRID_TRANSL_PROG, 9, 1)
> +    FIELD(HWCFG0, CHK_X, 10, 1)
> +    FIELD(HWCFG0, NO_X, 11, 1)
> +    FIELD(HWCFG0, NO_W, 12, 1)
> +    FIELD(HWCFG0, STALL_EN, 13, 1)
> +    FIELD(HWCFG0, PEIS, 14, 1)
> +    FIELD(HWCFG0, PEES, 15, 1)
> +    FIELD(HWCFG0, MFR_EN, 16, 1)
> +    FIELD(HWCFG0, MD_ENTRY_NUM, 17, 7)
> +    FIELD(HWCFG0, MD_NUM, 24, 6)
> +    FIELD(HWCFG0, ADDRH_EN, 30, 1)
> +    FIELD(HWCFG0, ENABLE, 31, 1)
> +REG32(HWCFG1, 0x0C)
> +    FIELD(HWCFG1, RRID_NUM, 0, 16)
> +    FIELD(HWCFG1, ENTRY_NUM, 16, 16)
> +REG32(HWCFG2, 0x10)
> +    FIELD(HWCFG2, PRIO_ENTRY, 0, 16)
> +    FIELD(HWCFG2, RRID_TRANSL, 16, 16)
> +REG32(ENTRYOFFSET, 0x14)
> +    FIELD(ENTRYOFFSET, OFFSET, 0, 32)
> +REG32(MDSTALL, 0x30)
> +    FIELD(MDSTALL, EXEMPT, 0, 1)
> +    FIELD(MDSTALL, MD, 1, 31)
> +REG32(MDSTALLH, 0x34)
> +    FIELD(MDSTALLH, MD, 0, 32)
> +REG32(RRIDSCP, 0x38)
> +    FIELD(RRIDSCP, RRID, 0, 16)
> +    FIELD(RRIDSCP, OP, 30, 2)
> +    FIELD(RRIDSCP, STAT, 30, 2)
> +REG32(MDLCK, 0x40)
> +    FIELD(MDLCK, L, 0, 1)
> +    FIELD(MDLCK, MD, 1, 31)
> +REG32(MDLCKH, 0x44)
> +    FIELD(MDLCKH, MDH, 0, 32)
> +REG32(MDCFGLCK, 0x48)
> +    FIELD(MDCFGLCK, L, 0, 1)
> +    FIELD(MDCFGLCK, F, 1, 7)
> +REG32(ENTRYLCK, 0x4C)
> +    FIELD(ENTRYLCK, L, 0, 1)
> +    FIELD(ENTRYLCK, F, 1, 16)
> +REG32(ERR_CFG, 0x60)
> +    FIELD(ERR_CFG, L, 0, 1)
> +    FIELD(ERR_CFG, IE, 1, 1)
> +    FIELD(ERR_CFG, RS, 2, 1)
> +    FIELD(ERR_CFG, MSI_EN, 3, 1)
> +    FIELD(ERR_CFG, STALL_VIOLATION_EN, 4, 1)
> +    FIELD(ERR_CFG, MSIDATA, 8, 11)
> +REG32(ERR_INFO, 0x64)
> +    FIELD(ERR_INFO, V, 0, 1)
> +    FIELD(ERR_INFO, TTYPE, 1, 2)
> +    FIELD(ERR_INFO, MSI_WERR, 3, 1)
> +    FIELD(ERR_INFO, ETYPE, 4, 4)
> +    FIELD(ERR_INFO, SVC, 8, 1)
> +REG32(ERR_REQADDR, 0x68)
> +    FIELD(ERR_REQADDR, ADDR, 0, 32)
> +REG32(ERR_REQADDRH, 0x6C)
> +    FIELD(ERR_REQADDRH, ADDRH, 0, 32)
> +REG32(ERR_REQID, 0x70)
> +    FIELD(ERR_REQID, RRID, 0, 16)
> +    FIELD(ERR_REQID, EID, 16, 16)
> +REG32(ERR_MFR, 0x74)
> +    FIELD(ERR_MFR, SVW, 0, 16)
> +    FIELD(ERR_MFR, SVI, 16, 12)
> +    FIELD(ERR_MFR, SVS, 31, 1)
> +REG32(ERR_MSIADDR, 0x78)
> +REG32(ERR_MSIADDRH, 0x7C)
> +REG32(MDCFG0, 0x800)
> +    FIELD(MDCFG0, T, 0, 16)
> +REG32(SRCMD_EN0, 0x1000)
> +    FIELD(SRCMD_EN0, L, 0, 1)
> +    FIELD(SRCMD_EN0, MD, 1, 31)
> +REG32(SRCMD_ENH0, 0x1004)
> +    FIELD(SRCMD_ENH0, MDH, 0, 32)
> +REG32(SRCMD_R0, 0x1008)
> +    FIELD(SRCMD_R0, MD, 1, 31)
> +REG32(SRCMD_RH0, 0x100C)
> +    FIELD(SRCMD_RH0, MDH, 0, 32)
> +REG32(SRCMD_W0, 0x1010)
> +    FIELD(SRCMD_W0, MD, 1, 31)
> +REG32(SRCMD_WH0, 0x1014)
> +    FIELD(SRCMD_WH0, MDH, 0, 32)
> +REG32(SRCMD_PERM0, 0x1000)
> +REG32(SRCMD_PERMH0, 0x1004)
> +
> +FIELD(ENTRY_ADDR, ADDR, 0, 32)
> +FIELD(ENTRY_ADDRH, ADDRH, 0, 32)
> +
> +FIELD(ENTRY_CFG, R, 0, 1)
> +FIELD(ENTRY_CFG, W, 1, 1)
> +FIELD(ENTRY_CFG, X, 2, 1)
> +FIELD(ENTRY_CFG, A, 3, 2)
> +FIELD(ENTRY_CFG, SIE, 5, 3)
> +FIELD(ENTRY_CFG, SIRE, 5, 1)
> +FIELD(ENTRY_CFG, SIWE, 6, 1)
> +FIELD(ENTRY_CFG, SIXE, 7, 1)
> +FIELD(ENTRY_CFG, SEE, 8, 3)
> +FIELD(ENTRY_CFG, SERE, 8, 1)
> +FIELD(ENTRY_CFG, SEWE, 9, 1)
> +FIELD(ENTRY_CFG, SEXE, 10, 1)
> +
> +FIELD(ENTRY_USER_CFG, IM, 0, 32)
> +
> +/* Offsets to SRCMD_EN(i) */
> +#define SRCMD_EN_OFFSET  0x0
> +#define SRCMD_ENH_OFFSET 0x4
> +#define SRCMD_R_OFFSET   0x8
> +#define SRCMD_RH_OFFSET  0xC
> +#define SRCMD_W_OFFSET   0x10
> +#define SRCMD_WH_OFFSET  0x14
> +
> +/* Offsets to SRCMD_PERM(i) */
> +#define SRCMD_PERM_OFFSET  0x0
> +#define SRCMD_PERMH_OFFSET 0x4
> +
> +/* Offsets to ENTRY_ADDR(i) */
> +#define ENTRY_ADDR_OFFSET     0x0
> +#define ENTRY_ADDRH_OFFSET    0x4
> +#define ENTRY_CFG_OFFSET      0x8
> +#define ENTRY_USER_CFG_OFFSET 0xC
> +
> +#define IOPMP_MAX_MD_NUM                63
> +#define IOPMP_MAX_RRID_NUM              32
> +#define IOPMP_SRCMDFMT0_MAX_RRID_NUM    65535
> +#define IOPMP_SRCMDFMT2_MAX_RRID_NUM    32
> +#define IOPMP_MAX_ENTRY_NUM             65535
> +
> +/* The ids of iopmp are temporary */
> +#define VENDER_VIRT                     0
> +#define SPECVER_0_9_2                   92
> +#define IMPID_0_9_2                     92
> +
> +typedef enum {
> +    RS_ERROR,
> +    RS_SUCCESS,
> +} iopmp_reaction;
> +
> +typedef enum {
> +    RWE_ERROR,
> +    RWE_SUCCESS,
> +} iopmp_write_reaction;
> +
> +typedef enum {
> +    RXE_ERROR,
> +    RXE_SUCCESS_VALUE,
> +} iopmp_exec_reaction;
> +
> +typedef enum {
> +    ERR_INFO_TTYPE_NOERROR,
> +    ERR_INFO_TTYPE_READ,
> +    ERR_INFO_TTYPE_WRITE,
> +    ERR_INFO_TTYPE_FETCH
> +} iopmp_err_info_ttype;
> +
> +typedef enum {
> +    ERR_INFO_ETYPE_NOERROR,
> +    ERR_INFO_ETYPE_READ,
> +    ERR_INFO_ETYPE_WRITE,
> +    ERR_INFO_ETYPE_FETCH,
> +    ERR_INFO_ETYPE_PARHIT,
> +    ERR_INFO_ETYPE_NOHIT,
> +    ERR_INFO_ETYPE_RRID,
> +    ERR_INFO_ETYPE_USER,
> +    ERR_INFO_ETYPE_STALL
> +} iopmp_err_info_etype;
> +
> +typedef enum {
> +    IOPMP_ENTRY_NO_HIT,
> +    IOPMP_ENTRY_PAR_HIT,
> +    IOPMP_ENTRY_HIT
> +} iopmp_entry_hit;
> +
> +typedef enum {
> +    IOPMP_AMATCH_OFF,  /* Null (off)                            */
> +    IOPMP_AMATCH_TOR,  /* Top of Range                          */
> +    IOPMP_AMATCH_NA4,  /* Naturally aligned four-byte region    */
> +    IOPMP_AMATCH_NAPOT /* Naturally aligned power-of-two region */
> +} iopmp_am_t;
> +
> +typedef enum {
> +    IOPMP_ACCESS_READ  =3D 1,
> +    IOPMP_ACCESS_WRITE =3D 2,
> +    IOPMP_ACCESS_FETCH =3D 3
> +} iopmp_access_type;
> +
> +typedef enum {
> +    IOPMP_NONE =3D 0,
> +    IOPMP_RO   =3D 1,
> +    IOPMP_WO   =3D 2,
> +    IOPMP_RW   =3D 3,
> +    IOPMP_XO   =3D 4,
> +    IOPMP_RX   =3D 5,
> +    IOPMP_WX   =3D 6,
> +    IOPMP_RWX  =3D 7,
> +} iopmp_permission;
> +
> +typedef enum {
> +    RRIDSCP_OP_QUERY =3D 0,
> +    RRIDSCP_OP_STALL =3D 1,
> +    RRIDSCP_OP_NO_STALL =3D 2,
> +    RRIDSCP_OP_RESERVED =3D 3,
> +} rridscp_op;
> +
> +typedef enum {
> +    RRIDSCP_STAT_NOT_IMPL =3D 0,
> +    RRIDSCP_STAT_STALL =3D 1,
> +    RRIDSCP_STAT_NO_STALL =3D 2,
> +    RRIDSCP_STAT_RRID_NO_IMPL =3D 3,
> +} rridscp_stat;
> +
> +typedef struct entry_range {
> +    int md;
> +    /* Index of entry array */
> +    int start_idx;
> +    int end_idx;
> +} entry_range;
> +
> +static void iopmp_iommu_notify(RISCVIOPMPState *s)
> +{
> +    IOMMUTLBEvent event =3D {
> +        .entry =3D {
> +            .iova =3D 0,
> +            .translated_addr =3D 0,
> +            .addr_mask =3D -1ULL,
> +            .perm =3D IOMMU_NONE,
> +        },
> +        .type =3D IOMMU_NOTIFIER_UNMAP,
> +    };
> +
> +    for (int i =3D 0; i < s->rrid_num; i++) {
> +        memory_region_notify_iommu(&s->iommu, i, event);
> +    }
> +}
> +
> +static void iopmp_msi_send(RISCVIOPMPState *s)
> +{
> +    MemTxResult result;
> +    uint64_t addr =3D ((uint64_t)(s->regs.err_msiaddrh) << 32) |
> +                    s->regs.err_msiaddr;
> +    address_space_stl_le(&address_space_memory, addr,
> +                         FIELD_EX32(s->regs.err_cfg, ERR_CFG, MSIDATA),
> +                         (MemTxAttrs){.requester_id =3D s->msi_rrid}, &r=
esult);
> +    if (result !=3D MEMTX_OK) {
> +        s->regs.err_info =3D FIELD_DP32(s->regs.err_info, ERR_INFO, MSI_=
WERR, 1);
> +    }
> +}
> +
> +static void iopmp_decode_napot(uint64_t a, uint64_t *sa,
> +                               uint64_t *ea)
> +{
> +    /*
> +     * aaaa...aaa0   8-byte NAPOT range
> +     * aaaa...aa01   16-byte NAPOT range
> +     * aaaa...a011   32-byte NAPOT range
> +     * ...
> +     * aa01...1111   2^XLEN-byte NAPOT range
> +     * a011...1111   2^(XLEN+1)-byte NAPOT range
> +     * 0111...1111   2^(XLEN+2)-byte NAPOT range
> +     *  1111...1111   Reserved
> +     */
> +
> +    a =3D (a << 2) | 0x3;
> +    *sa =3D a & (a + 1);
> +    *ea =3D a | (a + 1);
> +}
> +
> +static void iopmp_update_rule(RISCVIOPMPState *s, uint32_t entry_index)
> +{
> +    uint8_t this_cfg =3D s->regs.entry[entry_index].cfg_reg;
> +    uint64_t this_addr =3D s->regs.entry[entry_index].addr_reg |
> +                         ((uint64_t)s->regs.entry[entry_index].addrh_reg=
 << 32);
> +    uint64_t prev_addr =3D 0u;
> +    uint64_t sa =3D 0u;
> +    uint64_t ea =3D 0u;
> +
> +    if (entry_index >=3D 1u) {
> +        prev_addr =3D s->regs.entry[entry_index - 1].addr_reg |
> +                    ((uint64_t)s->regs.entry[entry_index - 1].addrh_reg =
<< 32);
> +    }
> +
> +    switch (FIELD_EX32(this_cfg, ENTRY_CFG, A)) {
> +    case IOPMP_AMATCH_OFF:
> +        sa =3D 0u;
> +        ea =3D -1;
> +        break;
> +
> +    case IOPMP_AMATCH_TOR:
> +        sa =3D (prev_addr) << 2; /* shift up from [xx:0] to [xx+2:2] */
> +        ea =3D ((this_addr) << 2) - 1u;
> +        if (sa > ea) {
> +            sa =3D ea =3D 0u;
> +        }
> +        break;
> +
> +    case IOPMP_AMATCH_NA4:
> +        sa =3D this_addr << 2; /* shift up from [xx:0] to [xx+2:2] */
> +        ea =3D (sa + 4u) - 1u;
> +        break;
> +
> +    case IOPMP_AMATCH_NAPOT:
> +        iopmp_decode_napot(this_addr, &sa, &ea);
> +        break;
> +
> +    default:
> +        sa =3D 0u;
> +        ea =3D 0u;
> +        break;
> +    }
> +
> +    s->entry_addr[entry_index].sa =3D sa;
> +    s->entry_addr[entry_index].ea =3D ea;
> +    iopmp_iommu_notify(s);
> +}
> +
> +static uint64_t iopmp_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    RISCVIOPMPState *s =3D RISCV_IOPMP(opaque);
> +    uint32_t rz =3D 0;
> +    uint32_t offset, idx;
> +    /* Start value for ERR_MFR.svi */
> +    uint16_t svi_s;
> +
> +    switch (addr) {
> +    case A_VERSION:
> +        rz =3D FIELD_DP32(rz, VERSION, VENDOR, VENDER_VIRT);
> +        rz =3D FIELD_DP32(rz, VERSION, SPECVER, SPECVER_0_9_2);
> +        break;
> +    case A_IMPLEMENTATION:
> +        rz =3D IMPID_0_9_2;
> +        break;
> +    case A_HWCFG0:
> +        rz =3D FIELD_DP32(rz, HWCFG0, MDCFG_FMT, s->mdcfg_fmt);
> +        rz =3D FIELD_DP32(rz, HWCFG0, SRCMD_FMT, s->srcmd_fmt);
> +        rz =3D FIELD_DP32(rz, HWCFG0, TOR_EN, s->tor_en);
> +        rz =3D FIELD_DP32(rz, HWCFG0, SPS_EN, s->sps_en);
> +        rz =3D FIELD_DP32(rz, HWCFG0, USER_CFG_EN, 0);
> +        rz =3D FIELD_DP32(rz, HWCFG0, PRIENT_PROG, s->prient_prog);
> +        rz =3D FIELD_DP32(rz, HWCFG0, RRID_TRANSL_EN, s->rrid_transl_en)=
;
> +        rz =3D FIELD_DP32(rz, HWCFG0, RRID_TRANSL_PROG, s->rrid_transl_p=
rog);
> +        rz =3D FIELD_DP32(rz, HWCFG0, CHK_X, s->chk_x);
> +        rz =3D FIELD_DP32(rz, HWCFG0, NO_X, s->no_x);
> +        rz =3D FIELD_DP32(rz, HWCFG0, NO_W, s->no_w);
> +        rz =3D FIELD_DP32(rz, HWCFG0, STALL_EN, s->stall_en);
> +        rz =3D FIELD_DP32(rz, HWCFG0, PEIS, s->peis);
> +        rz =3D FIELD_DP32(rz, HWCFG0, PEES, s->pees);
> +        rz =3D FIELD_DP32(rz, HWCFG0, MFR_EN, s->mfr_en);
> +        rz =3D FIELD_DP32(rz, HWCFG0, MD_ENTRY_NUM, s->md_entry_num);
> +        rz =3D FIELD_DP32(rz, HWCFG0, MD_NUM, s->md_num);
> +        rz =3D FIELD_DP32(rz, HWCFG0, ADDRH_EN, 1);
> +        rz =3D FIELD_DP32(rz, HWCFG0, ENABLE, s->enable);
> +        break;
> +    case A_HWCFG1:
> +        rz =3D FIELD_DP32(rz, HWCFG1, RRID_NUM, s->rrid_num);
> +        rz =3D FIELD_DP32(rz, HWCFG1, ENTRY_NUM, s->entry_num);
> +        break;
> +    case A_HWCFG2:
> +        rz =3D FIELD_DP32(rz, HWCFG2, PRIO_ENTRY, s->prio_entry);
> +        rz =3D FIELD_DP32(rz, HWCFG2, RRID_TRANSL, s->rrid_transl);
> +        break;
> +    case A_ENTRYOFFSET:
> +        rz =3D s->entry_offset;
> +        break;
> +    case A_MDSTALL:
> +        if (s->stall_en) {
> +            rz =3D s->regs.mdstall;
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\n",
> +                          __func__, (int)addr);
> +        }
> +        break;
> +    case A_MDSTALLH:
> +        if (s->stall_en && s->md_num > 31) {
> +            rz =3D s->regs.mdstallh;
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\n",
> +                          __func__, (int)addr);
> +        }
> +        break;
> +    case A_RRIDSCP:
> +        if (s->stall_en) {
> +            rz =3D s->regs.rridscp;
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\n",
> +                          __func__, (int)addr);
> +        }
> +        break;
> +    case A_ERR_CFG:
> +        rz =3D s->regs.err_cfg;
> +        break;
> +    case A_MDLCK:
> +        if (s->srcmd_fmt =3D=3D 1) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\n",
> +                __func__, (int)addr);
> +        } else {
> +            rz =3D s->regs.mdlck;
> +        }
> +        break;
> +    case A_MDLCKH:
> +        if (s->md_num < 31 || s->srcmd_fmt =3D=3D 1) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\n",
> +                __func__, (int)addr);
> +        } else {
> +            rz =3D s->regs.mdlckh;
> +        }
> +        break;
> +    case A_MDCFGLCK:
> +        if (s->mdcfg_fmt !=3D 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\n",
> +                          __func__, (int)addr);
> +            break;
> +        }
> +        rz =3D s->regs.mdcfglck;
> +        break;
> +    case A_ENTRYLCK:
> +        rz =3D s->regs.entrylck;
> +        break;
> +    case A_ERR_REQADDR:
> +        rz =3D s->regs.err_reqaddr & UINT32_MAX;
> +        break;
> +    case A_ERR_REQADDRH:
> +        rz =3D s->regs.err_reqaddr >> 32;
> +        break;
> +    case A_ERR_REQID:
> +        rz =3D s->regs.err_reqid;
> +        break;
> +    case A_ERR_INFO:
> +        rz =3D s->regs.err_info;
> +        break;
> +    case A_ERR_MFR:
> +        if (!s->mfr_en) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\n",
> +                          __func__, (int)addr);
> +            break;
> +        }
> +        svi_s =3D s->svi;
> +        s->regs.err_info =3D FIELD_DP32(s->regs.err_info, ERR_INFO, SVC,=
 0);
> +        while (1) {
> +            if (s->svw[s->svi]) {
> +                if (rz =3D=3D 0) {
> +                    /* First svw is found */
> +                    rz =3D FIELD_DP32(rz, ERR_MFR, SVW, s->svw[s->svi]);
> +                    rz =3D FIELD_DP32(rz, ERR_MFR, SVI, s->svi);
> +                    rz =3D FIELD_DP32(rz, ERR_MFR, SVS, 1);
> +                    /* Clear svw after read */
> +                    s->svw[s->svi] =3D 0;
> +                } else {
> +                    /* Other subsequent violation exists */
> +                    s->regs.err_info =3D FIELD_DP32(s->regs.err_info, ER=
R_INFO,
> +                                                  SVC, 1);
> +                    break;
> +                }
> +            }
> +            s->svi++;
> +            if (s->svi > (s->rrid_num / 16) + 1) {
> +                s->svi =3D 0;
> +            }
> +            if (svi_s =3D=3D s->svi) {
> +                /* rounded back to the same value */
> +                break;
> +            }
> +        }
> +        /* Set svi for next read */
> +        s->svi =3D FIELD_DP32(rz, ERR_MFR, SVI, s->svi);
> +        break;
> +    case A_ERR_MSIADDR:
> +        rz =3D s->regs.err_msiaddr;
> +        break;
> +    case A_ERR_MSIADDRH:
> +        rz =3D s->regs.err_msiaddrh;
> +        break;
> +
> +    default:
> +        if (s->mdcfg_fmt =3D=3D 0 &&
> +            addr >=3D A_MDCFG0 &&
> +            addr <=3D A_MDCFG0 + 4 * (s->md_num - 1)) {
> +            offset =3D addr - A_MDCFG0;
> +            if (offset % 4) {
> +                rz =3D 0;
> +                qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\n",
> +                              __func__, (int)addr);
> +            } else {
> +                idx =3D offset >> 2;
> +                rz =3D s->regs.mdcfg[idx];
> +            }
> +        } else if (s->srcmd_fmt =3D=3D 0 &&
> +                   addr >=3D A_SRCMD_EN0 &&
> +                   addr <=3D A_SRCMD_WH0 + 32 * (s->rrid_num - 1)) {
> +            offset =3D addr - A_SRCMD_EN0;
> +            idx =3D offset >> 5;
> +            offset &=3D 0x1f;
> +
> +            if (s->sps_en || offset <=3D SRCMD_ENH_OFFSET) {
> +                switch (offset) {
> +                case SRCMD_EN_OFFSET:
> +                    rz =3D s->regs.srcmd_en[idx];
> +                    break;
> +                case SRCMD_ENH_OFFSET:
> +                    if (s->md_num > 31) {
> +                        rz =3D s->regs.srcmd_enh[idx];
> +                    } else {
> +                        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\=
n",
> +                                      __func__, (int)addr);
> +                    }
> +                    break;
> +                case SRCMD_R_OFFSET:
> +                    rz =3D s->regs.srcmd_r[idx];
> +                    break;
> +                case SRCMD_RH_OFFSET:
> +                    if (s->md_num > 31) {
> +                        rz =3D s->regs.srcmd_rh[idx];
> +                    } else {
> +                        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\=
n",
> +                                      __func__, (int)addr);
> +                    }
> +                    break;
> +                case SRCMD_W_OFFSET:
> +                    rz =3D s->regs.srcmd_w[idx];
> +                    break;
> +                case SRCMD_WH_OFFSET:
> +                    if (s->md_num > 31) {
> +                        rz =3D s->regs.srcmd_wh[idx];
> +                    } else {
> +                        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\=
n",
> +                                      __func__, (int)addr);
> +                    }
> +                    break;
> +                default:
> +                    qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\n",
> +                                  __func__, (int)addr);
> +                    break;
> +                }
> +            } else {
> +                 qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\n",
> +                               __func__, (int)addr);
> +            }
> +        } else if (s->srcmd_fmt =3D=3D 2 &&
> +                   addr >=3D A_SRCMD_PERM0 &&
> +                   addr <=3D A_SRCMD_PERMH0 + 32 * (s->md_num - 1)) {
> +            offset =3D addr - A_SRCMD_PERM0;
> +            idx =3D offset >> 5;
> +            offset &=3D 0x1f;
> +            switch (offset) {
> +            case SRCMD_PERM_OFFSET:
> +                rz =3D s->regs.srcmd_perm[idx];
> +                break;
> +            case SRCMD_PERMH_OFFSET:
> +                if (s->rrid_num > 16) {
> +                    rz =3D s->regs.srcmd_permh[idx];
> +                } else {
> +                    qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\n",
> +                                  __func__, (int)addr);
> +                }
> +                break;
> +            default:
> +                qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\n",
> +                                __func__, (int)addr);
> +                break;
> +            }
> +        } else if (addr >=3D s->entry_offset &&
> +                   addr <=3D s->entry_offset + ENTRY_USER_CFG_OFFSET +
> +                           16 * (s->entry_num - 1)) {
> +            offset =3D addr - s->entry_offset;
> +            idx =3D offset >> 4;
> +            offset &=3D 0xf;
> +
> +            switch (offset) {
> +            case ENTRY_ADDR_OFFSET:
> +                rz =3D s->regs.entry[idx].addr_reg;
> +                break;
> +            case ENTRY_ADDRH_OFFSET:
> +                rz =3D s->regs.entry[idx].addrh_reg;
> +                break;
> +            case ENTRY_CFG_OFFSET:
> +                rz =3D s->regs.entry[idx].cfg_reg;
> +                break;
> +            default:
> +                qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\n",
> +                              __func__, (int)addr);
> +                break;
> +            }
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\n",
> +                          __func__, (int)addr);
> +        }
> +        break;
> +    }
> +    trace_iopmp_read(addr, rz);
> +    return rz;
> +}
> +
> +static void update_rrid_stall(RISCVIOPMPState *s)
> +{
> +    bool exempt =3D FIELD_EX32(s->regs.mdstall, MDSTALL, EXEMPT);
> +    uint64_t stall_by_md =3D ((uint64_t)s->regs.mdstall |
> +                            ((uint64_t)s->regs.mdstallh << 32)) >> 1;
> +    uint64_t srcmd_en;
> +    bool reduction_or;
> +    if (s->srcmd_fmt !=3D 2) {
> +        for (int rrid =3D 0; rrid < s->rrid_num; rrid++) {
> +            srcmd_en =3D ((uint64_t)s->regs.srcmd_en[rrid] |
> +                        ((uint64_t)s->regs.srcmd_enh[rrid] << 32)) >> 1;
> +            reduction_or =3D 0;
> +            if (srcmd_en & stall_by_md) {
> +                reduction_or =3D 1;
> +            }
> +            s->rrid_stall[rrid] =3D exempt ^ reduction_or;
> +        }
> +    } else {
> +        for (int rrid =3D 0; rrid < s->rrid_num; rrid++) {
> +            if (stall_by_md) {
> +                s->rrid_stall[rrid] =3D 1;
> +            } else {
> +                s->rrid_stall[rrid] =3D 0;
> +            }
> +        }
> +    }
> +    iopmp_iommu_notify(s);
> +}
> +
> +static inline void resume_stall(RISCVIOPMPState *s)
> +{
> +    for (int rrid =3D 0; rrid < s->rrid_num; rrid++) {
> +        s->rrid_stall[rrid] =3D 0;
> +    }
> +    iopmp_iommu_notify(s);
> +}
> +
> +static void
> +iopmp_write(void *opaque, hwaddr addr, uint64_t value, unsigned size)
> +{
> +    RISCVIOPMPState *s =3D RISCV_IOPMP(opaque);
> +    uint32_t offset, idx;
> +    uint32_t value32 =3D value;
> +    uint64_t mdlck;
> +    uint32_t value_f;
> +    uint32_t rrid;
> +    uint32_t op;
> +    trace_iopmp_write(addr, value32);
> +
> +    switch (addr) {
> +    case A_VERSION: /* RO */
> +        break;
> +    case A_IMPLEMENTATION: /* RO */
> +        break;
> +    case A_HWCFG0:
> +        if (FIELD_EX32(value32, HWCFG0, RRID_TRANSL_PROG)) {
> +            /* W1C */
> +            s->rrid_transl_prog =3D 0;
> +        }
> +        if (FIELD_EX32(value32, HWCFG0, PRIENT_PROG)) {
> +            /* W1C */
> +            s->prient_prog =3D 0;
> +        }
> +        if (!s->enable && s->mdcfg_fmt =3D=3D 2) {
> +            /* Locked by enable bit */
> +            s->md_entry_num =3D FIELD_EX32(value32, HWCFG0, MD_ENTRY_NUM=
);
> +        }
> +        if (FIELD_EX32(value32, HWCFG0, ENABLE)) {
> +            /* W1S */
> +            s->enable =3D 1;
> +            iopmp_iommu_notify(s);
> +        }
> +        break;
> +    case A_HWCFG1: /* RO */
> +        break;
> +    case A_HWCFG2:
> +        if (s->prient_prog) {
> +            s->prio_entry =3D FIELD_EX32(value32, HWCFG2, PRIO_ENTRY);
> +            iopmp_iommu_notify(s);
> +        }
> +        if (s->rrid_transl_prog) {
> +            s->rrid_transl =3D FIELD_EX32(value32, HWCFG2, RRID_TRANSL);
> +            iopmp_iommu_notify(s);
> +        }
> +        break;
> +    case A_ENTRYOFFSET:
> +        break;
> +    case A_MDSTALL:
> +        if (s->stall_en) {
> +            s->regs.mdstall =3D value32;
> +            if (value32) {
> +                s->is_stalled =3D 1;
> +            } else {
> +                /* Resume if stall, stallh =3D=3D 0 */
> +                if (s->regs.mdstallh =3D=3D 0) {
> +                    s->is_stalled =3D 0;
> +                }
> +            }
> +            update_rrid_stall(s);
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\n",
> +                          __func__, (int)addr);
> +        }
> +        break;
> +    case A_MDSTALLH:
> +        if (s->stall_en) {
> +            s->regs.mdstallh =3D value32;
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\n",
> +                          __func__, (int)addr);
> +        }
> +        break;
> +    case A_RRIDSCP:
> +        if (s->stall_en) {
> +            rrid =3D FIELD_EX32(value32, RRIDSCP, RRID);
> +            op =3D FIELD_EX32(value32, RRIDSCP, OP);
> +            if (op =3D=3D RRIDSCP_OP_RESERVED) {
> +                break;
> +            }
> +            s->regs.rridscp =3D value32;
> +            if (rrid > s->rrid_num) {
> +                s->regs.rridscp =3D FIELD_DP32(s->regs.rridscp, RRIDSCP,=
 STAT,
> +                                             RRIDSCP_STAT_RRID_NO_IMPL);
> +                break;
> +            }
> +            switch (op) {
> +            case RRIDSCP_OP_QUERY:
> +                if (s->is_stalled) {
> +                    s->regs.rridscp =3D
> +                        FIELD_DP32(s->regs.rridscp, RRIDSCP, STAT,
> +                                    0x2 >> s->rrid_stall[rrid]);
> +                } else {
> +                    s->regs.rridscp =3D FIELD_DP32(s->regs.rridscp, RRID=
SCP,
> +                                                    STAT,
> +                                                    RRIDSCP_STAT_NO_STAL=
L);
> +                }
> +                break;
> +            case RRIDSCP_OP_STALL:
> +                s->rrid_stall[rrid] =3D 1;
> +                break;
> +            case RRIDSCP_OP_NO_STALL:
> +                s->rrid_stall[rrid] =3D 0;
> +                break;
> +            default:
> +                break;
> +            }
> +            if (s->is_stalled) {
> +                iopmp_iommu_notify(s);
> +            }
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\n",
> +                          __func__, (int)addr);
> +        }
> +        break;
> +    case A_ERR_CFG:
> +        if (!FIELD_EX32(s->regs.err_cfg, ERR_CFG, L)) {
> +            s->regs.err_cfg =3D FIELD_DP32(s->regs.err_cfg, ERR_CFG, L,
> +                FIELD_EX32(value32, ERR_CFG, L));
> +            s->regs.err_cfg =3D FIELD_DP32(s->regs.err_cfg, ERR_CFG, IE,
> +                FIELD_EX32(value32, ERR_CFG, IE));
> +            s->regs.err_cfg =3D FIELD_DP32(s->regs.err_cfg, ERR_CFG, RS,
> +                FIELD_EX32(value32, ERR_CFG, RS));
> +            s->regs.err_cfg =3D FIELD_DP32(s->regs.err_cfg, ERR_CFG, MSI=
_EN,
> +                FIELD_EX32(value32, ERR_CFG, MSI_EN));
> +            s->regs.err_cfg =3D FIELD_DP32(s->regs.err_cfg, ERR_CFG,
> +                STALL_VIOLATION_EN, FIELD_EX32(value32, ERR_CFG,
> +                                               STALL_VIOLATION_EN));
> +            s->regs.err_cfg =3D FIELD_DP32(s->regs.err_cfg, ERR_CFG, MSI=
DATA,
> +                FIELD_EX32(value32, ERR_CFG, MSIDATA));
> +        }
> +        break;
> +    case A_MDLCK:
> +        if (s->srcmd_fmt =3D=3D 1) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\n",
> +                          __func__, (int)addr);
> +        } else if (!FIELD_EX32(s->regs.mdlck, MDLCK, L)) {
> +            /* sticky to 1 */
> +            s->regs.mdlck |=3D value32;
> +            if (s->md_num <=3D 31) {
> +                s->regs.mdlck =3D extract32(s->regs.mdlck, 0, s->md_num =
+ 1);
> +            }
> +        }
> +        break;
> +    case A_MDLCKH:
> +        if (s->md_num < 31 || s->srcmd_fmt =3D=3D 1) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\n",
> +                          __func__, (int)addr);
> +        } else if (!FIELD_EX32(s->regs.mdlck, MDLCK, L)) {
> +            /* sticky to 1 */
> +            s->regs.mdlckh |=3D value32;
> +            s->regs.mdlck =3D extract32(s->regs.mdlck, 0, s->md_num - 31=
);
> +        }
> +        break;
> +    case A_MDCFGLCK:
> +        if (s->mdcfg_fmt !=3D 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\n",
> +                __func__, (int)addr);
> +            break;
> +        }
> +        if (!FIELD_EX32(s->regs.mdcfglck, MDCFGLCK, L)) {
> +            value_f =3D FIELD_EX32(value32, MDCFGLCK, F);
> +            if (value_f > FIELD_EX32(s->regs.mdcfglck, MDCFGLCK, F)) {
> +                s->regs.mdcfglck =3D FIELD_DP32(s->regs.mdcfglck, MDCFGL=
CK, F,
> +                                              value_f);
> +            }
> +            s->regs.mdcfglck =3D FIELD_DP32(s->regs.mdcfglck, MDCFGLCK, =
L,
> +                                          FIELD_EX32(value32, MDCFGLCK, =
L));
> +        }
> +        break;
> +    case A_ENTRYLCK:
> +        if (!(FIELD_EX32(s->regs.entrylck, ENTRYLCK, L))) {
> +            value_f =3D FIELD_EX32(value32, ENTRYLCK, F);
> +            if (value_f > FIELD_EX32(s->regs.entrylck, ENTRYLCK, F)) {
> +                s->regs.entrylck =3D FIELD_DP32(s->regs.entrylck, ENTRYL=
CK, F,
> +                                              value_f);
> +            }
> +            s->regs.entrylck =3D FIELD_DP32(s->regs.entrylck, ENTRYLCK, =
L,
> +                                          FIELD_EX32(value32, ENTRYLCK, =
L));
> +        }
> +    case A_ERR_REQADDR: /* RO */
> +        break;
> +    case A_ERR_REQADDRH: /* RO */
> +        break;
> +    case A_ERR_REQID: /* RO */
> +        break;
> +    case A_ERR_INFO:
> +        if (FIELD_EX32(value32, ERR_INFO, V)) {
> +            s->regs.err_info =3D FIELD_DP32(s->regs.err_info, ERR_INFO, =
V, 0);
> +            qemu_set_irq(s->irq, 0);
> +        }
> +        if (FIELD_EX32(value32, ERR_INFO, MSI_WERR)) {
> +            s->regs.err_info =3D FIELD_DP32(s->regs.err_info, ERR_INFO, =
MSI_WERR,
> +                                          0);
> +        }
> +        break;
> +    case A_ERR_MFR:
> +        s->svi =3D FIELD_EX32(value32, ERR_MFR, SVI);
> +        break;
> +    case A_ERR_MSIADDR:
> +        if (!FIELD_EX32(s->regs.err_cfg, ERR_CFG, L)) {
> +            s->regs.err_msiaddr =3D value32;
> +        }
> +        break;
> +
> +    case A_ERR_MSIADDRH:
> +        if (!FIELD_EX32(s->regs.err_cfg, ERR_CFG, L)) {
> +            s->regs.err_msiaddrh =3D value32;
> +        }
> +        break;
> +
> +    default:
> +        if (s->mdcfg_fmt =3D=3D 0 &&
> +            addr >=3D A_MDCFG0 &&
> +            addr <=3D A_MDCFG0 + 4 * (s->md_num - 1)) {
> +            offset =3D addr - A_MDCFG0;
> +            if (offset % 4) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\n",
> +                              __func__, (int)addr);
> +            } else {
> +                idx =3D offset >> 2;
> +                s->regs.mdcfg[idx] =3D FIELD_EX32(value32, MDCFG0, T);
> +                iopmp_iommu_notify(s);
> +            }
> +        } else if (s->srcmd_fmt =3D=3D 0 &&
> +                   addr >=3D A_SRCMD_EN0 &&
> +                   addr <=3D A_SRCMD_WH0 + 32 * (s->rrid_num - 1)) {
> +            offset =3D addr - A_SRCMD_EN0;
> +            idx =3D offset >> 5;
> +            offset &=3D 0x1f;
> +
> +            if (offset % 4 || (!s->sps_en && offset > SRCMD_ENH_OFFSET))=
 {
> +                qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\n",
> +                              __func__, (int)addr);
> +            } else if (FIELD_EX32(s->regs.srcmd_en[idx], SRCMD_EN0, L) =
=3D=3D 0) {
> +                /* MD field is protected by mdlck */
> +                value32 =3D (value32 & ~s->regs.mdlck) |
> +                          (s->regs.srcmd_en[idx] & s->regs.mdlck);
> +                iopmp_iommu_notify(s);
> +                switch (offset) {
> +                case SRCMD_EN_OFFSET:
> +                    s->regs.srcmd_en[idx] =3D
> +                        FIELD_DP32(s->regs.srcmd_en[idx], SRCMD_EN0, L,
> +                                   FIELD_EX32(value32, SRCMD_EN0, L));
> +                    s->regs.srcmd_en[idx] =3D
> +                        FIELD_DP32(s->regs.srcmd_en[idx], SRCMD_EN0, MD,
> +                                   FIELD_EX32(value32, SRCMD_EN0, MD));
> +                    if (s->md_num <=3D 31) {
> +                        s->regs.srcmd_en[idx] =3D extract32(s->regs.srcm=
d_en[idx],
> +                                                          0, s->md_num +=
 1);
> +                    }
> +                    break;
> +                case SRCMD_ENH_OFFSET:
> +                    if (s->md_num > 31) {
> +                        s->regs.srcmd_enh[idx] =3D value32;
> +                        s->regs.srcmd_enh[idx] =3D
> +                            extract32(s->regs.srcmd_enh[idx], 0,
> +                                      s->md_num - 31);
> +                    } else {
> +                        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\=
n",
> +                                      __func__, (int)addr);
> +                    }
> +                    break;
> +                case SRCMD_R_OFFSET:
> +                    s->regs.srcmd_r[idx] =3D
> +                        FIELD_DP32(s->regs.srcmd_r[idx], SRCMD_R0, MD,
> +                                   FIELD_EX32(value32, SRCMD_R0, MD));
> +                    if (s->md_num <=3D 31) {
> +                        s->regs.srcmd_r[idx] =3D extract32(s->regs.srcmd=
_r[idx],
> +                                                         0, s->md_num + =
1);
> +                    }
> +                    break;
> +                case SRCMD_RH_OFFSET:
> +                    if (s->md_num > 31) {
> +                        s->regs.srcmd_rh[idx] =3D value32;
> +                        s->regs.srcmd_rh[idx] =3D
> +                            extract32(s->regs.srcmd_rh[idx], 0,
> +                                      s->md_num - 31);
> +                    } else {
> +                        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\=
n",
> +                                      __func__, (int)addr);
> +                    }
> +                    break;
> +                case SRCMD_W_OFFSET:
> +                    s->regs.srcmd_w[idx] =3D
> +                        FIELD_DP32(s->regs.srcmd_w[idx], SRCMD_W0, MD,
> +                                   FIELD_EX32(value32, SRCMD_W0, MD));
> +                    if (s->md_num <=3D 31) {
> +                        s->regs.srcmd_w[idx] =3D extract32(s->regs.srcmd=
_w[idx],
> +                                                         0, s->md_num + =
1);
> +                    }
> +                    break;
> +                case SRCMD_WH_OFFSET:
> +                    if (s->md_num > 31) {
> +                        s->regs.srcmd_wh[idx] =3D value32;
> +                        s->regs.srcmd_wh[idx] =3D
> +                            extract32(s->regs.srcmd_wh[idx], 0,
> +                                      s->md_num - 31);
> +                    } else {
> +                        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\=
n",
> +                                      __func__, (int)addr);
> +                    }
> +                    break;
> +                default:
> +                    break;
> +                }
> +            }
> +        } else if (s->srcmd_fmt =3D=3D 2 &&
> +                   addr >=3D A_SRCMD_PERM0 &&
> +                   addr <=3D A_SRCMD_PERMH0 + 32 * (s->md_num - 1)) {
> +            offset =3D addr - A_SRCMD_PERM0;
> +            idx =3D offset >> 5;
> +            offset &=3D 0x1f;
> +            /* mdlck lock bit is removed */
> +            mdlck =3D ((uint64_t)s->regs.mdlck |
> +                     ((uint64_t)s->regs.mdlckh << 32)) >> 1;
> +            iopmp_iommu_notify(s);
> +            switch (offset) {
> +            case SRCMD_PERM_OFFSET:
> +                /* srcmd_perm[md] is protect by mdlck */
> +                if (((mdlck >> idx) & 0x1) =3D=3D 0) {
> +                    s->regs.srcmd_perm[idx] =3D value32;
> +                }
> +                if (s->rrid_num <=3D 16) {
> +                    s->regs.srcmd_perm[idx] =3D extract32(s->regs.srcmd_=
perm[idx],
> +                                                        0, 2 * s->rrid_n=
um);
> +                }
> +                break;
> +            case SRCMD_PERMH_OFFSET:
> +                if (s->rrid_num > 16) {
> +                    if (((mdlck >> idx) & 0x1) =3D=3D 0) {
> +                        s->regs.srcmd_permh[idx] =3D value32;
> +                    }
> +                    s->regs.srcmd_permh[idx] =3D
> +                        extract32(s->regs.srcmd_permh[idx], 0,
> +                                  2 * (s->rrid_num - 16));
> +                } else {
> +                    qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\n",
> +                                  __func__, (int)addr);
> +                }
> +                break;
> +            default:
> +                qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\n",
> +                                __func__, (int)addr);
> +                break;
> +            }
> +        } else if (addr >=3D s->entry_offset &&
> +                   addr <=3D s->entry_offset + ENTRY_USER_CFG_OFFSET
> +                           + 16 * (s->entry_num - 1)) {
> +            offset =3D addr - s->entry_offset;
> +            idx =3D offset >> 4;
> +            offset &=3D 0xf;
> +
> +            /* index < ENTRYLCK_F is protected */
> +            if (idx >=3D FIELD_EX32(s->regs.entrylck, ENTRYLCK, F)) {
> +                switch (offset) {
> +                case ENTRY_ADDR_OFFSET:
> +                    s->regs.entry[idx].addr_reg =3D value32;
> +                    break;
> +                case ENTRY_ADDRH_OFFSET:
> +                    s->regs.entry[idx].addrh_reg =3D value32;
> +                    break;
> +                case ENTRY_CFG_OFFSET:
> +                    s->regs.entry[idx].cfg_reg =3D value32;
> +                    if (!s->tor_en &&
> +                        FIELD_EX32(s->regs.entry[idx].cfg_reg,
> +                                   ENTRY_CFG, A) =3D=3D IOPMP_AMATCH_TOR=
) {
> +                        s->regs.entry[idx].cfg_reg =3D
> +                            FIELD_DP32(s->regs.entry[idx].cfg_reg, ENTRY=
_CFG, A,
> +                                       IOPMP_AMATCH_OFF);
> +                    }
> +                    if (!s->peis) {
> +                        s->regs.entry[idx].cfg_reg =3D
> +                            FIELD_DP32(s->regs.entry[idx].cfg_reg, ENTRY=
_CFG,
> +                                       SIE, 0);
> +                    }
> +                    if (!s->pees) {
> +                        s->regs.entry[idx].cfg_reg =3D
> +                            FIELD_DP32(s->regs.entry[idx].cfg_reg, ENTRY=
_CFG,
> +                                       SEE, 0);
> +                    }
> +                    break;
> +                case ENTRY_USER_CFG_OFFSET:
> +                    /* Does not support user customized permission */
> +                    break;
> +                default:
> +                    qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\n",
> +                                  __func__, (int)addr);
> +                    break;
> +                }
> +                iopmp_update_rule(s, idx);
> +                if (idx + 1 < s->entry_num &&
> +                    FIELD_EX32(s->regs.entry[idx + 1].cfg_reg, ENTRY_CFG=
, A) =3D=3D
> +                    IOPMP_AMATCH_TOR) {
> +                        iopmp_update_rule(s, idx + 1);
> +                }
> +            }
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\n", __func__=
,
> +                          (int)addr);
> +        }
> +    }
> +}
> +
> +static void apply_sps_permission(RISCVIOPMPState *s, int rrid, int md, i=
nt *cfg)
> +{
> +    uint64_t srcmd_r, srcmd_w;
> +    srcmd_r =3D ((uint64_t)s->regs.srcmd_rh[rrid]) << 32 | s->regs.srcmd=
_r[rrid];
> +    srcmd_w =3D ((uint64_t)s->regs.srcmd_wh[rrid]) << 32 | s->regs.srcmd=
_w[rrid];
> +    if (((srcmd_r >> (md + 1)) & 0x1) =3D=3D 0) {
> +        /* remove r&x permission and error suppression */
> +        *cfg =3D FIELD_DP32(*cfg, ENTRY_CFG, R, 0);
> +        *cfg =3D FIELD_DP32(*cfg, ENTRY_CFG, X, 0);
> +        *cfg =3D FIELD_DP32(*cfg, ENTRY_CFG, SIRE, 0);
> +        *cfg =3D FIELD_DP32(*cfg, ENTRY_CFG, SERE, 0);
> +        *cfg =3D FIELD_DP32(*cfg, ENTRY_CFG, SIXE, 0);
> +        *cfg =3D FIELD_DP32(*cfg, ENTRY_CFG, SEXE, 0);
> +    }
> +    if (((srcmd_w >> (md + 1)) & 0x1) =3D=3D 0) {
> +        /* remove w permission and error suppression */
> +        *cfg =3D FIELD_DP32(*cfg, ENTRY_CFG, W, 0);
> +        *cfg =3D FIELD_DP32(*cfg, ENTRY_CFG, SIWE, 0);
> +        *cfg =3D FIELD_DP32(*cfg, ENTRY_CFG, SEWE, 0);
> +    }
> +}
> +
> +static void apply_srcmdperm(RISCVIOPMPState *s, int rrid, int md, int *c=
fg)
> +{
> +    uint64_t srcmd_perm =3D ((uint64_t)s->regs.srcmd_permh[md]) << 32 |
> +                          s->regs.srcmd_perm[md];
> +
> +    if (((srcmd_perm >> (2 * rrid)) & 0x1)) {
> +        /* add r&x permission */
> +        *cfg =3D FIELD_DP32(*cfg, ENTRY_CFG, R, 1);
> +        *cfg =3D FIELD_DP32(*cfg, ENTRY_CFG, X, 1);
> +    }
> +    if (((srcmd_perm >> (2 * rrid + 1)) & 0x1)) {
> +        /* add w permission */
> +        *cfg =3D FIELD_DP32(*cfg, ENTRY_CFG, W, 1);
> +    }
> +}
> +
> +static inline void apply_no_chk_x(int *cfg)
> +{
> +    /* Use read permission for fetch */
> +    *cfg =3D FIELD_DP32(*cfg, ENTRY_CFG, X, FIELD_EX32(*cfg, ENTRY_CFG, =
R));
> +}
> +
> +/*
> + * entry_range_list: The entry ranges from SRCMD and MDCFG to match
> + * entry_idx: matched priority entry index or first non-priority entry i=
ndex
> + * cfg: entry cfg for matched priority entry and overlap permission and
> + *           supression of matched on-priority entries
> + * iopmp_tlb_size: If entire tlb has the same permission, the value is
> + *                 TARGET_PAGE_SIZE, otherwise is 1.
> + */
> +static iopmp_entry_hit match_entry_range(RISCVIOPMPState *s, int rrid,
> +                                         GSList *entry_range_list,
> +                                         hwaddr sa, hwaddr ea,
> +                                         int *entry_idx, int *cfg,
> +                                         hwaddr *iopmp_tlb_size)
> +{
> +    entry_range *range;
> +    iopmp_entry_hit result =3D IOPMP_ENTRY_NO_HIT;
> +    *iopmp_tlb_size =3D TARGET_PAGE_SIZE;
> +    *cfg =3D 0;
> +    int i =3D 0;
> +    int s_idx, e_idx;
> +    hwaddr tlb_sa =3D sa & ~(TARGET_PAGE_SIZE - 1);
> +    hwaddr tlb_ea =3D (ea & ~(TARGET_PAGE_SIZE - 1)) + TARGET_PAGE_SIZE =
- 1;
> +    int tlb_cfg =3D 0;
> +    int md;
> +    int curr_cfg;
> +
> +    while (entry_range_list) {
> +        range =3D (entry_range *)entry_range_list->data;
> +        s_idx =3D range->start_idx;
> +        e_idx =3D range->end_idx;
> +        md =3D range->md;
> +        if (e_idx > s->entry_num) {
> +            e_idx =3D s->entry_num;
> +        }
> +        for (i =3D s_idx; i < e_idx; i++) {
> +            if (FIELD_EX32(s->regs.entry[i].cfg_reg, ENTRY_CFG, A) =3D=
=3D
> +                IOPMP_AMATCH_OFF) {
> +                continue;
> +            }
> +
> +            if (i < s->prio_entry) {
> +                if (iopmp_tlb_size !=3D NULL &&
> +                    *iopmp_tlb_size =3D=3D TARGET_PAGE_SIZE) {
> +                    if ((s->entry_addr[i].sa >=3D tlb_sa &&
> +                         s->entry_addr[i].sa <=3D tlb_ea) ||
> +                        (s->entry_addr[i].ea >=3D tlb_sa &&
> +                         s->entry_addr[i].ea <=3D tlb_ea)) {
> +                        /*
> +                         * A higher priority entry in the same TLB page,
> +                         * but it does not occupy the entire page.
> +                         */
> +                        *iopmp_tlb_size =3D 1;

I'm not clear on what we are doing here

> +                    }
> +                }
> +                if (sa >=3D s->entry_addr[i].sa &&
> +                    sa <=3D s->entry_addr[i].ea) {
> +                        if (ea >=3D s->entry_addr[i].sa &&
> +                            ea <=3D s->entry_addr[i].ea) {
> +                                *entry_idx =3D i;
> +                                *cfg =3D s->regs.entry[i].cfg_reg;
> +                                if (s->sps_en) {
> +                                    apply_sps_permission(s, rrid, md, cf=
g);
> +                                }
> +                                if (s->srcmd_fmt =3D=3D 2) {
> +                                    apply_srcmdperm(s, rrid, md, cfg);
> +                                }
> +                                if (!s->chk_x) {
> +                                    apply_no_chk_x(cfg);
> +                                }
> +                                return IOPMP_ENTRY_HIT;
> +                        } else {
> +                            *entry_idx =3D i;
> +                            return IOPMP_ENTRY_PAR_HIT;
> +                        }
> +                } else if (ea >=3D s->entry_addr[i].sa &&
> +                           ea <=3D s->entry_addr[i].ea) {
> +                    *entry_idx =3D i;
> +                    return IOPMP_ENTRY_PAR_HIT;
> +                } else if (sa < s->entry_addr[i].sa &&
> +                           ea > s->entry_addr[i].ea) {
> +                    *entry_idx =3D i;
> +                    return IOPMP_ENTRY_PAR_HIT;
> +                }
> +            } else {
> +                /* Try to check entire tlb permission */
> +                if (*iopmp_tlb_size !=3D 1 &&
> +                    tlb_sa >=3D s->entry_addr[i].sa &&
> +                    tlb_sa <=3D s->entry_addr[i].ea) {

Is this right?

tlb_sa is the start address rounded down to allign with the TLB size.
Doesn't that mean we can incorrectly match with something outside the
range?

It's probably worth trying to simplify this huge if machine with some
helper functions for the repeated code as it's hard to follow

Alistair

> +                    if (tlb_ea >=3D s->entry_addr[i].sa &&
> +                        tlb_ea <=3D s->entry_addr[i].ea) {
> +                        result =3D IOPMP_ENTRY_HIT;
> +                        curr_cfg =3D s->regs.entry[i].cfg_reg;
> +                        if (*entry_idx =3D=3D -1) {
> +                            /* record first matched non-priorty entry */
> +                            *entry_idx =3D i;
> +                        }
> +                        if (s->sps_en) {
> +                            apply_sps_permission(s, rrid, md, &curr_cfg)=
;
> +                        }
> +                        if (s->srcmd_fmt =3D=3D 2) {
> +                            apply_srcmdperm(s, rrid, md, &curr_cfg);
> +                        }
> +                        if (!s->chk_x) {
> +                            apply_no_chk_x(&curr_cfg);
> +                        }
> +                        tlb_cfg |=3D curr_cfg;
> +                        if ((tlb_cfg & 0x7) =3D=3D 0x7) {
> +                            /* Already have RWX permission */
> +                            *cfg =3D tlb_cfg;
> +                            return result;
> +                        }
> +                    }
> +                }
> +                if (sa >=3D s->entry_addr[i].sa &&
> +                    sa <=3D s->entry_addr[i].ea) {
> +                    if (ea >=3D s->entry_addr[i].sa &&
> +                        ea <=3D s->entry_addr[i].ea) {
> +                        result =3D IOPMP_ENTRY_HIT;
> +                        if (*entry_idx =3D=3D -1) {
> +                            /* record first matched non-priorty entry */
> +                            *entry_idx =3D i;
> +                        }
> +                        curr_cfg =3D s->regs.entry[i].cfg_reg;
> +                        if (s->sps_en) {
> +                            apply_sps_permission(s, rrid, md, &curr_cfg)=
;
> +                        }
> +                        if (s->srcmd_fmt =3D=3D 2) {
> +                            apply_srcmdperm(s, rrid, md, &curr_cfg);
> +                        }
> +                        if (!s->chk_x) {
> +                            apply_no_chk_x(&curr_cfg);
> +                        }
> +                        *cfg |=3D curr_cfg;
> +                        if ((*cfg & 0x7) =3D=3D 0x7 && *iopmp_tlb_size =
=3D=3D 1) {
> +                            /*
> +                             * Already have RWX permission and a higher =
priority
> +                             * entry in the same TLB page, checking the
> +                             * next non-priority entry is unnecessary
> +                             */
> +                            return result;
> +                        }
> +                    }
> +                }
> +            }
> +        }
> +        entry_range_list =3D entry_range_list->next;
> +    }
> +    if (result =3D=3D IOPMP_ENTRY_HIT && (*cfg & 0x7) !=3D (tlb_cfg & 0x=
7)) {
> +        /*
> +         * For non-priority entry hit, if the tlb permssion is different=
 to
> +         * matched entries permssion, reduce iopmp_tlb_size
> +         */
> +        *iopmp_tlb_size =3D 1;
> +    }
> +    return result;
> +}
> +
> +static void entry_range_list_data_free(gpointer data)
> +{
> +    entry_range *range =3D (entry_range *)data;
> +    g_free(range);
> +}
> +
> +static iopmp_entry_hit match_entry_srcmd(RISCVIOPMPState *s, int rrid,
> +                                         hwaddr start_addr, hwaddr end_a=
ddr,
> +                                         int *match_entry_idx, int *cfg,
> +                                         hwaddr *iopmp_tlb_size)
> +{
> +    iopmp_entry_hit result =3D IOPMP_ENTRY_NO_HIT;
> +    GSList *entry_range_list =3D NULL;
> +    uint64_t srcmd_en;
> +    int k;
> +    entry_range *range;
> +    int md_idx;
> +    if (s->srcmd_fmt =3D=3D 1) {
> +        range =3D g_malloc(sizeof(*range));
> +        md_idx =3D rrid;
> +        range->md =3D md_idx;
> +        if (s->mdcfg_fmt =3D=3D 0) {
> +            if (md_idx > 0) {
> +                range->start_idx =3D FIELD_EX32(s->regs.mdcfg[md_idx - 1=
],
> +                                              MDCFG0, T);
> +            } else {
> +                range->start_idx =3D 0;
> +            }
> +            range->end_idx =3D FIELD_EX32(s->regs.mdcfg[md_idx], MDCFG0,=
 T);
> +        } else {
> +            k =3D s->md_entry_num + 1;
> +            range->start_idx =3D md_idx * k;
> +            range->end_idx =3D (md_idx + 1) * k;
> +        }
> +        entry_range_list =3D g_slist_append(entry_range_list, range);
> +    } else {
> +        for (md_idx =3D 0; md_idx < s->md_num; md_idx++) {
> +            srcmd_en =3D ((uint64_t)s->regs.srcmd_en[rrid] |
> +                        ((uint64_t)s->regs.srcmd_enh[rrid] << 32)) >> 1;
> +            range =3D NULL;
> +            if (s->srcmd_fmt =3D=3D 2) {
> +                /* All entries are needed to be checked in srcmd_fmt2 */
> +                srcmd_en =3D -1;
> +            }
> +            if (srcmd_en & (1ULL << md_idx)) {
> +                range =3D g_malloc(sizeof(*range));
> +                range->md =3D md_idx;
> +                if (s->mdcfg_fmt =3D=3D 0) {
> +                    if (md_idx > 0) {
> +                        range->start_idx =3D FIELD_EX32(s->regs.mdcfg[md=
_idx - 1],
> +                                                      MDCFG0, T);
> +                    } else {
> +                        range->start_idx =3D 0;
> +                    }
> +                    range->end_idx =3D FIELD_EX32(s->regs.mdcfg[md_idx],
> +                                                MDCFG0, T);
> +                } else {
> +                    k =3D s->md_entry_num + 1;
> +                    range->start_idx =3D md_idx * k;
> +                    range->end_idx =3D (md_idx + 1) * k;
> +                }
> +            }
> +            /*
> +             * There is no more memory domain after it enconter an inval=
id
> +             * mdcfg. Note that the behavior of mdcfg(t+1).f < mdcfg(t).=
f is
> +             * implementation-dependent.
> +             */
> +            if (range !=3D NULL) {
> +                if (range->end_idx < range->start_idx) {
> +                    break;
> +                }
> +                entry_range_list =3D g_slist_append(entry_range_list, ra=
nge);
> +            }
> +        }
> +    }
> +    result =3D match_entry_range(s, rrid, entry_range_list, start_addr, =
end_addr,
> +                               match_entry_idx, cfg, iopmp_tlb_size);
> +    g_slist_free_full(entry_range_list, entry_range_list_data_free);
> +    return result;
> +}
> +
> +static MemTxResult iopmp_error_reaction(RISCVIOPMPState *s, uint32_t rri=
d,
> +                                        uint32_t eid, hwaddr addr,
> +                                        uint32_t etype, uint32_t ttype,
> +                                        uint32_t cfg, uint64_t *data)
> +{
> +    uint32_t error_id =3D 0;
> +    uint32_t error_info =3D 0;
> +    int offset;
> +    /* interrupt enable regarding the access */
> +    int ie;
> +    /* bus error enable */
> +    int be;
> +    int error_record;
> +
> +    if (etype >=3D ERR_INFO_ETYPE_READ && etype <=3D ERR_INFO_ETYPE_WRIT=
E) {
> +        offset =3D etype - ERR_INFO_ETYPE_READ;
> +        ie =3D (FIELD_EX32(s->regs.err_cfg, ERR_CFG, IE) &&
> +              !extract32(cfg, R_ENTRY_CFG_SIRE_SHIFT + offset, 1));
> +        be =3D (!FIELD_EX32(s->regs.err_cfg, ERR_CFG, RS) &&
> +              !extract32(cfg, R_ENTRY_CFG_SERE_SHIFT + offset, 1));
> +    } else {
> +        ie =3D extract32(s->regs.err_cfg, R_ERR_CFG_IE_SHIFT, 1);
> +        be =3D !extract32(s->regs.err_cfg, R_ERR_CFG_RS_SHIFT, 1);
> +    }
> +    error_record =3D (ie | be) && !(s->transaction_state[rrid].running &=
&
> +                                  s->transaction_state[rrid].error_repor=
ted);
> +    if (error_record) {
> +        if (s->transaction_state[rrid].running) {
> +            s->transaction_state[rrid].error_reported =3D true;
> +        }
> +        /* Update error information if the error is not suppressed */
> +        if (!FIELD_EX32(s->regs.err_info, ERR_INFO, V)) {
> +            error_id =3D FIELD_DP32(error_id, ERR_REQID, EID, eid);
> +            error_id =3D FIELD_DP32(error_id, ERR_REQID, RRID, rrid);
> +            error_info =3D FIELD_DP32(error_info, ERR_INFO, ETYPE, etype=
);
> +            error_info =3D FIELD_DP32(error_info, ERR_INFO, TTYPE, ttype=
);
> +            s->regs.err_info =3D error_info;
> +            s->regs.err_info =3D FIELD_DP32(s->regs.err_info, ERR_INFO, =
V, 1);
> +            s->regs.err_reqid =3D error_id;
> +            /* addr[LEN+2:2] */
> +            s->regs.err_reqaddr =3D addr >> 2;
> +            if (ie) {
> +                if (FIELD_EX32(s->regs.err_cfg, ERR_CFG, MSI_EN)) {
> +                    iopmp_msi_send(s);
> +                } else {
> +                    qemu_set_irq(s->irq, 1);
> +                }
> +            }
> +        } else if (s->mfr_en) {
> +            s->svw[rrid / 16] |=3D (1 << (rrid % 16));
> +            s->regs.err_info =3D FIELD_DP32(s->regs.err_info, ERR_INFO, =
SVC, 1);
> +        }
> +    }
> +    if (be) {
> +        return MEMTX_ERROR;
> +    } else {
> +        if (data) {
> +            *data =3D s->err_rdata;
> +        }
> +        return MEMTX_OK;
> +    }
> +}
> +
> +static IOMMUTLBEntry iopmp_translate(IOMMUMemoryRegion *iommu, hwaddr ad=
dr,
> +                                     IOMMUAccessFlags flags, int iommu_i=
dx)
> +{
> +    int rrid =3D iommu_idx;
> +    RISCVIOPMPState *s =3D RISCV_IOPMP(container_of(iommu,
> +                                                  RISCVIOPMPState, iommu=
));
> +    hwaddr start_addr, end_addr;
> +    int entry_idx =3D -1;
> +    hwaddr iopmp_tlb_size =3D TARGET_PAGE_SIZE;
> +    int match_cfg =3D 0;
> +    iopmp_entry_hit result;
> +    iopmp_permission iopmp_perm;
> +    bool lock =3D false;
> +    IOMMUTLBEntry entry =3D {
> +        .target_as =3D &s->downstream_as,
> +        .iova =3D addr,
> +        .translated_addr =3D addr,
> +        .addr_mask =3D 0,
> +        .perm =3D IOMMU_NONE,
> +    };
> +
> +    if (!s->enable) {
> +        /* Bypass IOPMP */
> +        entry.addr_mask =3D TARGET_PAGE_SIZE - 1,
> +        entry.perm =3D IOMMU_RW;
> +        return entry;
> +    }
> +
> +    /* unknown RRID */
> +    if (rrid >=3D s->rrid_num) {
> +        entry.target_as =3D &s->blocked_rwx_as;
> +        entry.perm =3D IOMMU_RW;
> +        return entry;
> +    }
> +
> +    if (s->is_stalled && s->rrid_stall[rrid]) {
> +        if (FIELD_EX32(s->regs.err_cfg, ERR_CFG, STALL_VIOLATION_EN)) {
> +            entry.target_as =3D &s->blocked_rwx_as;
> +            entry.perm =3D IOMMU_RW;
> +            return entry;
> +        } else {
> +            if (bql_locked()) {
> +                bql_unlock();
> +                lock =3D true;
> +            }
> +            while (s->is_stalled && s->rrid_stall[rrid]) {
> +                ;
> +            }
> +            if (lock) {
> +                bql_lock();
> +            }
> +        }
> +    }
> +
> +    if (s->transaction_state[rrid].running =3D=3D true) {
> +        start_addr =3D s->transaction_state[rrid].start_addr;
> +        end_addr =3D s->transaction_state[rrid].end_addr;
> +    } else {
> +        /* No transaction information, use the same address */
> +        start_addr =3D addr;
> +        end_addr =3D addr;
> +    }
> +    result =3D match_entry_srcmd(s, rrid, start_addr, end_addr, &entry_i=
dx,
> +                               &match_cfg, &iopmp_tlb_size);
> +    entry.addr_mask =3D iopmp_tlb_size - 1;
> +    /* Remove permission for no_x, no_w*/
> +    if (s->chk_x && s->no_x) {
> +        match_cfg =3D FIELD_DP32(match_cfg, ENTRY_CFG, X, 0);
> +    }
> +    if (s->no_w) {
> +        match_cfg =3D FIELD_DP32(match_cfg, ENTRY_CFG, W, 0);
> +    }
> +    if (result =3D=3D IOPMP_ENTRY_HIT) {
> +        iopmp_perm =3D match_cfg & IOPMP_RWX;
> +        if (flags) {
> +            if ((iopmp_perm & flags) =3D=3D 0) {
> +                /* Permission denied */
> +                entry.target_as =3D &s->blocked_rwx_as;
> +                entry.perm =3D IOMMU_RW;
> +            } else {
> +                entry.target_as =3D &s->downstream_as;
> +                if (s->rrid_transl_en) {
> +                    /* Indirectly access for rrid_transl */
> +                    entry.target_as =3D &s->full_as;
> +                }
> +                entry.perm =3D iopmp_perm;
> +            }
> +        } else {
> +            /* CPU access with IOMMU_NONE flag */
> +            if (iopmp_perm & IOPMP_XO) {
> +                if ((iopmp_perm & IOPMP_RW) =3D=3D IOPMP_RW) {
> +                    entry.target_as =3D &s->downstream_as;
> +                    if (s->rrid_transl_en) {
> +                        entry.target_as =3D &s->full_as;
> +                    }
> +                } else if ((iopmp_perm & IOPMP_RW) =3D=3D IOPMP_RO) {
> +                    entry.target_as =3D &s->blocked_w_as;
> +                } else if ((iopmp_perm & IOPMP_RW) =3D=3D IOPMP_WO) {
> +                    entry.target_as =3D &s->blocked_r_as;
> +                } else {
> +                    entry.target_as =3D &s->blocked_rw_as;
> +                }
> +            } else {
> +                if ((iopmp_perm & IOPMP_RW) =3D=3D IOMMU_RW) {
> +                    entry.target_as =3D &s->blocked_x_as;
> +                } else if ((iopmp_perm & IOPMP_RW) =3D=3D IOPMP_RO) {
> +                    entry.target_as =3D &s->blocked_wx_as;
> +                } else if ((iopmp_perm & IOPMP_RW) =3D=3D IOPMP_WO) {
> +                    entry.target_as =3D &s->blocked_rx_as;
> +                } else {
> +                    entry.target_as =3D &s->blocked_rwx_as;
> +                }
> +            }
> +            entry.perm =3D IOMMU_RW;
> +        }
> +    } else {
> +        /* CPU access with IOMMU_NONE flag no_hit or par_hit */
> +        entry.target_as =3D &s->blocked_rwx_as;
> +        entry.perm =3D IOMMU_RW;
> +    }
> +    return entry;
> +}
> +
> +static const MemoryRegionOps iopmp_ops =3D {
> +    .read =3D iopmp_read,
> +    .write =3D iopmp_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .valid =3D {.min_access_size =3D 4, .max_access_size =3D 4}
> +};
> +
> +static MemTxResult iopmp_permssion_write(void *opaque, hwaddr addr,
> +                                         uint64_t value, unsigned size,
> +                                         MemTxAttrs attrs)
> +{
> +    MemTxResult result;
> +    int rrid =3D attrs.requester_id;
> +    bool sent_info =3D false;
> +    riscv_iopmp_txn_info signal;
> +    RISCVIOPMPState *s =3D RISCV_IOPMP(opaque);
> +    if (s->rrid_transl_en) {
> +        if (s->transaction_state[rrid].running && s->send_ss) {
> +            sent_info =3D true;
> +            signal.rrid =3D s->rrid_transl;
> +            signal.start_addr =3D s->transaction_state[rrid].start_addr;
> +            signal.end_addr =3D s->transaction_state[rrid].end_addr;
> +            signal.stage =3D s->transaction_state[rrid].stage + 1;
> +            /* Send transaction information to next stage iopmp. */
> +            stream_push(s->send_ss, (uint8_t *)&signal, sizeof(signal), =
0);
> +        }
> +        attrs.requester_id =3D s->rrid_transl;
> +    }
> +    result =3D address_space_write(&s->downstream_as, addr, attrs, &valu=
e, size);
> +    if (sent_info) {
> +        stream_push(s->send_ss, (uint8_t *)&signal, sizeof(signal), 1);
> +    }
> +    return result;
> +}
> +
> +static MemTxResult iopmp_permssion_read(void *opaque, hwaddr addr,
> +                                        uint64_t *pdata, unsigned size,
> +                                        MemTxAttrs attrs)
> +{
> +    MemTxResult result;
> +    int rrid =3D attrs.requester_id;
> +    bool sent_info =3D false;
> +    riscv_iopmp_txn_info signal;
> +    RISCVIOPMPState *s =3D RISCV_IOPMP(opaque);
> +    if (s->rrid_transl_en) {
> +        if (s->transaction_state[rrid].running && s->send_ss) {
> +            sent_info =3D true;
> +            signal.rrid =3D s->rrid_transl;
> +            signal.start_addr =3D s->transaction_state[rrid].start_addr;
> +            signal.end_addr =3D s->transaction_state[rrid].end_addr;
> +            signal.stage =3D s->transaction_state[rrid].stage + 1;
> +            /* Send transaction information to next stage iopmp. */
> +            stream_push(s->send_ss, (uint8_t *)&signal, sizeof(signal), =
0);
> +        }
> +        attrs.requester_id =3D s->rrid_transl;
> +    }
> +    result =3D address_space_read(&s->downstream_as, addr, attrs, pdata,=
 size);
> +    if (sent_info) {
> +        stream_push(s->send_ss, (uint8_t *)&signal, sizeof(signal), 1);
> +    }
> +    return result;
> +}
> +
> +static MemTxResult iopmp_handle_block(void *opaque, hwaddr addr,
> +                                      uint64_t *data, unsigned size,
> +                                      MemTxAttrs attrs,
> +                                      iopmp_access_type access_type)
> +{
> +    RISCVIOPMPState *s =3D RISCV_IOPMP(opaque);
> +    int entry_idx;
> +    int rrid =3D attrs.requester_id;
> +    int result;
> +    hwaddr start_addr, end_addr;
> +    iopmp_err_info_etype etype;
> +    iopmp_err_info_ttype ttype;
> +    ttype =3D access_type;
> +    hwaddr iopmp_tlb_size =3D TARGET_PAGE_SIZE;
> +    int match_cfg =3D 0;
> +    /* unknown RRID */
> +    if (rrid >=3D s->rrid_num) {
> +        etype =3D ERR_INFO_ETYPE_RRID;
> +        return iopmp_error_reaction(s, rrid, 0, addr, etype, ttype, 0, d=
ata);
> +    }
> +
> +    if (s->is_stalled && s->rrid_stall[rrid]) {
> +        etype =3D ERR_INFO_ETYPE_STALL;
> +        return iopmp_error_reaction(s, rrid, 0, addr, etype, ttype, 0, d=
ata);
> +    }
> +
> +    if ((access_type =3D=3D IOPMP_ACCESS_FETCH && s->no_x) ||
> +        (access_type =3D=3D IOPMP_ACCESS_WRITE && s->no_w)) {
> +        etype =3D ERR_INFO_ETYPE_NOHIT;
> +        return iopmp_error_reaction(s, rrid, 0, addr, etype, ttype, 0, d=
ata);
> +    }
> +
> +    if (s->transaction_state[rrid].running =3D=3D true) {
> +        start_addr =3D s->transaction_state[rrid].start_addr;
> +        end_addr =3D s->transaction_state[rrid].end_addr;
> +    } else {
> +        /* No transaction information, use the same address */
> +        start_addr =3D addr;
> +        end_addr =3D addr;
> +    }
> +
> +    /* matching again to get eid */
> +    result =3D match_entry_srcmd(s, rrid, start_addr, end_addr,
> +                               &entry_idx, &match_cfg,
> +                               &iopmp_tlb_size);
> +    if (result =3D=3D IOPMP_ENTRY_HIT) {
> +        etype =3D access_type;
> +    } else if (result =3D=3D IOPMP_ENTRY_PAR_HIT) {
> +        etype =3D ERR_INFO_ETYPE_PARHIT;
> +        /* error supperssion per entry is only for all-byte matched entr=
y */
> +    } else {
> +        etype =3D ERR_INFO_ETYPE_NOHIT;
> +        entry_idx =3D 0;
> +    }
> +    return iopmp_error_reaction(s, rrid, entry_idx, start_addr, etype, t=
type,
> +                                match_cfg, data);
> +}
> +
> +static MemTxResult iopmp_block_write(void *opaque, hwaddr addr, uint64_t=
 value,
> +                                     unsigned size, MemTxAttrs attrs)
> +{
> +    return iopmp_handle_block(opaque, addr, NULL, size, attrs,
> +                              IOPMP_ACCESS_WRITE);
> +}
> +
> +static MemTxResult iopmp_block_read(void *opaque, hwaddr addr, uint64_t =
*pdata,
> +                                    unsigned size, MemTxAttrs attrs)
> +{
> +    return iopmp_handle_block(opaque, addr, pdata, size, attrs,
> +                              IOPMP_ACCESS_READ);
> +}
> +
> +static MemTxResult iopmp_block_fetch(void *opaque, hwaddr addr, uint64_t=
 *pdata,
> +                                     unsigned size, MemTxAttrs attrs)
> +{
> +    RISCVIOPMPState *s =3D RISCV_IOPMP(opaque);
> +    if (s->chk_x) {
> +        return iopmp_handle_block(opaque, addr, pdata, size, attrs,
> +                                  IOPMP_ACCESS_FETCH);
> +    }
> +    /* Using read reaction for no chk_x */
> +    return iopmp_handle_block(opaque, addr, pdata, size, attrs,
> +                                IOPMP_ACCESS_READ);
> +}
> +
> +static const MemoryRegionOps iopmp_block_rw_ops =3D {
> +    .fetch_with_attrs =3D iopmp_permssion_read,
> +    .read_with_attrs =3D iopmp_block_read,
> +    .write_with_attrs =3D iopmp_block_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .valid =3D {.min_access_size =3D 1, .max_access_size =3D 8},
> +};
> +
> +static const MemoryRegionOps iopmp_block_w_ops =3D {
> +    .fetch_with_attrs =3D iopmp_permssion_read,
> +    .read_with_attrs =3D iopmp_permssion_read,
> +    .write_with_attrs =3D iopmp_block_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .valid =3D {.min_access_size =3D 1, .max_access_size =3D 8},
> +};
> +
> +static const MemoryRegionOps iopmp_block_r_ops =3D {
> +    .fetch_with_attrs =3D iopmp_permssion_read,
> +    .read_with_attrs =3D iopmp_block_read,
> +    .write_with_attrs =3D iopmp_permssion_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .valid =3D {.min_access_size =3D 1, .max_access_size =3D 8},
> +};
> +
> +static const MemoryRegionOps iopmp_block_rwx_ops =3D {
> +    .fetch_with_attrs =3D iopmp_block_fetch,
> +    .read_with_attrs =3D iopmp_block_read,
> +    .write_with_attrs =3D iopmp_block_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .valid =3D {.min_access_size =3D 1, .max_access_size =3D 8},
> +};
> +
> +static const MemoryRegionOps iopmp_block_wx_ops =3D {
> +    .fetch_with_attrs =3D iopmp_block_fetch,
> +    .read_with_attrs =3D iopmp_permssion_read,
> +    .write_with_attrs =3D iopmp_block_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .valid =3D {.min_access_size =3D 1, .max_access_size =3D 8},
> +};
> +
> +static const MemoryRegionOps iopmp_block_rx_ops =3D {
> +    .fetch_with_attrs =3D iopmp_block_fetch,
> +    .read_with_attrs =3D iopmp_block_read,
> +    .write_with_attrs =3D iopmp_permssion_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .valid =3D {.min_access_size =3D 1, .max_access_size =3D 8},
> +};
> +
> +static const MemoryRegionOps iopmp_block_x_ops =3D {
> +    .fetch_with_attrs =3D iopmp_block_fetch,
> +    .read_with_attrs =3D iopmp_permssion_read,
> +    .write_with_attrs =3D iopmp_permssion_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .valid =3D {.min_access_size =3D 1, .max_access_size =3D 8},
> +};
> +
> +static const MemoryRegionOps iopmp_full_ops =3D {
> +    .fetch_with_attrs =3D iopmp_permssion_read,
> +    .read_with_attrs =3D iopmp_permssion_read,
> +    .write_with_attrs =3D iopmp_permssion_write,
> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .valid =3D {.min_access_size =3D 1, .max_access_size =3D 8},
> +};
> +
> +static void iopmp_realize(DeviceState *dev, Error **errp)
> +{
> +    Object *obj =3D OBJECT(dev);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> +    RISCVIOPMPState *s =3D RISCV_IOPMP(dev);
> +    uint64_t size, mmio_size;
> +
> +    size =3D -1ULL;
> +
> +    if (s->srcmd_fmt > 2) {
> +        error_setg(errp, "Invalid IOPMP srcmd_fmt");
> +        error_append_hint(errp, "Valid values are 0, 1, and 2.\n");
> +        return;
> +    }
> +
> +    if (s->mdcfg_fmt > 2) {
> +        error_setg(errp, "Invalid IOPMP mdcfg_fmt");
> +        error_append_hint(errp, "Valid values are 0, 1, and 2.\n");
> +        return;
> +    }
> +
> +    if (s->srcmd_fmt !=3D 0) {
> +        /* SPS is only supported in srcmd_fmt0 */
> +        s->sps_en =3D false;
> +    }
> +
> +    s->md_num =3D MIN(s->md_num, IOPMP_MAX_MD_NUM);
> +    if (s->srcmd_fmt =3D=3D 1) {
> +        /* Each RRID has one MD */
> +        s->md_num =3D MIN(s->md_num, s->rrid_num);
> +    }
> +    s->md_entry_num =3D s->default_md_entry_num;
> +    /* If md_entry_num is fixed, entry_num =3D md_num * (md_entry_num + =
1)*/
> +    if (s->mdcfg_fmt =3D=3D 1) {
> +        s->entry_num =3D s->md_num * (s->md_entry_num + 1);
> +    }
> +
> +    s->prient_prog =3D s->default_prient_prog;
> +    if (s->srcmd_fmt =3D=3D 0) {
> +        s->rrid_num =3D MIN(s->rrid_num, IOPMP_SRCMDFMT0_MAX_RRID_NUM);
> +    } else if (s->srcmd_fmt =3D=3D 1) {
> +        s->rrid_num =3D MIN(s->rrid_num, s->md_num);
> +    } else {
> +        s->rrid_num =3D MIN(s->rrid_num, IOPMP_SRCMDFMT2_MAX_RRID_NUM);
> +    }
> +    s->prio_entry =3D MIN(s->default_prio_entry, s->entry_num);
> +    s->rrid_transl_prog =3D s->default_rrid_transl_prog;
> +    s->rrid_transl =3D s->default_rrid_transl;
> +
> +    s->regs.err_cfg =3D FIELD_DP32(s->regs.err_cfg, ERR_CFG, MSI_EN,
> +                                 s->default_msi_en);
> +    s->regs.err_cfg =3D FIELD_DP32(s->regs.err_cfg, ERR_CFG, MSIDATA,
> +                                 s->default_msidata);
> +    s->regs.err_msiaddr =3D s->default_err_msiaddr;
> +    s->regs.err_msiaddrh =3D s->default_err_msiaddrh;
> +
> +    s->regs.mdcfg =3D g_malloc0(s->md_num * sizeof(uint32_t));
> +    if (s->srcmd_fmt !=3D 2) {
> +        s->regs.srcmd_en =3D g_malloc0(s->rrid_num * sizeof(uint32_t));
> +        s->regs.srcmd_enh =3D g_malloc0(s->rrid_num * sizeof(uint32_t));
> +    } else {
> +        /* srcmd_perm */
> +        s->regs.srcmd_perm =3D g_malloc0(s->md_num * sizeof(uint32_t));
> +        s->regs.srcmd_permh =3D g_malloc0(s->md_num * sizeof(uint32_t));
> +    }
> +
> +    if (s->sps_en) {
> +        s->regs.srcmd_r =3D g_malloc0(s->rrid_num * sizeof(uint32_t));
> +        s->regs.srcmd_rh =3D g_malloc0(s->rrid_num * sizeof(uint32_t));
> +        s->regs.srcmd_w =3D g_malloc0(s->rrid_num * sizeof(uint32_t));
> +        s->regs.srcmd_wh =3D g_malloc0(s->rrid_num * sizeof(uint32_t));
> +    }
> +
> +    if (s->stall_en) {
> +        s->rrid_stall =3D g_malloc0(s->rrid_num * sizeof(bool));
> +    }
> +
> +    if (s->mfr_en) {
> +        s->svw =3D g_malloc0((s->rrid_num / 16 + 1) * sizeof(uint16_t));
> +    }
> +
> +    s->regs.entry =3D g_malloc0(s->entry_num * sizeof(riscv_iopmp_entry_=
t));
> +    s->entry_addr =3D g_malloc0(s->entry_num * sizeof(riscv_iopmp_addr_t=
));
> +    s->transaction_state =3D g_malloc0(s->rrid_num *
> +                                     sizeof(riscv_iopmp_transaction_stat=
e));
> +    mmio_size =3D MAX(A_SRCMD_EN0 + 32 * s->rrid_num,
> +                    s->entry_offset + 16 * s->entry_num);
> +    qemu_mutex_init(&s->iopmp_transaction_mutex);
> +
> +    memory_region_init_iommu(&s->iommu, sizeof(s->iommu),
> +                             TYPE_RISCV_IOPMP_IOMMU_MEMORY_REGION,
> +                             obj, "riscv-iopmp-sysbus-iommu", UINT64_MAX=
);
> +    memory_region_init_io(&s->mmio, obj, &iopmp_ops,
> +                          s, "riscv-iopmp-regs", mmio_size);
> +    sysbus_init_mmio(sbd, &s->mmio);
> +
> +    memory_region_init_io(&s->blocked_rw, NULL, &iopmp_block_rw_ops, s,
> +                          "riscv-iopmp-blocked-rw", size);
> +    memory_region_init_io(&s->blocked_w, NULL, &iopmp_block_w_ops, s,
> +                          "riscv-iopmp-blocked-w", size);
> +    memory_region_init_io(&s->blocked_r, NULL, &iopmp_block_r_ops, s,
> +                          "riscv-iopmp-blocked-r", size);
> +    memory_region_init_io(&s->blocked_rwx, NULL, &iopmp_block_rwx_ops, s=
,
> +                          "riscv-iopmp-blocked-rwx", size);
> +    memory_region_init_io(&s->blocked_wx, NULL, &iopmp_block_wx_ops, s,
> +                          "riscv-iopmp-blocked-wx", size);
> +    memory_region_init_io(&s->blocked_rx, NULL, &iopmp_block_rx_ops, s,
> +                          "riscv-iopmp-blocked-rx", size);
> +    memory_region_init_io(&s->blocked_x, NULL, &iopmp_block_x_ops, s,
> +                          "riscv-iopmp-blocked-x", size);
> +    memory_region_init_io(&s->full_mr, NULL, &iopmp_full_ops, s,
> +                          "riscv-iopmp-full", size);
> +
> +    address_space_init(&s->blocked_rw_as, &s->blocked_rw,
> +                       "riscv-iopmp-blocked-rw-as");
> +    address_space_init(&s->blocked_w_as, &s->blocked_w,
> +                       "riscv-iopmp-blocked-w-as");
> +    address_space_init(&s->blocked_r_as, &s->blocked_r,
> +                       "riscv-iopmp-blocked-r-as");
> +    address_space_init(&s->blocked_rwx_as, &s->blocked_rwx,
> +                       "riscv-iopmp-blocked-rwx-as");
> +    address_space_init(&s->blocked_wx_as, &s->blocked_wx,
> +                       "riscv-iopmp-blocked-wx-as");
> +    address_space_init(&s->blocked_rx_as, &s->blocked_rx,
> +                       "riscv-iopmp-blocked-rx-as");
> +    address_space_init(&s->blocked_x_as, &s->blocked_x,
> +                       "riscv-iopmp-blocked-x-as");
> +    address_space_init(&s->full_as, &s->full_mr, "riscv-iopmp-full-as");
> +
> +    object_initialize_child(OBJECT(s), "riscv_iopmp_streamsink",
> +                            &s->txn_info_sink,
> +                            TYPE_RISCV_IOPMP_STREAMSINK);
> +}
> +
> +static void iopmp_reset_enter(Object *obj, ResetType type)
> +{
> +    RISCVIOPMPState *s =3D RISCV_IOPMP(obj);
> +
> +    qemu_set_irq(s->irq, 0);
> +    if (s->srcmd_fmt !=3D 2) {
> +        memset(s->regs.srcmd_en, 0, s->rrid_num * sizeof(uint32_t));
> +        memset(s->regs.srcmd_enh, 0, s->rrid_num * sizeof(uint32_t));
> +    } else {
> +        memset(s->regs.srcmd_en, 0, s->md_num * sizeof(uint32_t));
> +        memset(s->regs.srcmd_enh, 0, s->md_num * sizeof(uint32_t));
> +    }
> +
> +    if (s->sps_en) {
> +        memset(s->regs.srcmd_r, 0, s->rrid_num * sizeof(uint32_t));
> +        memset(s->regs.srcmd_rh, 0, s->rrid_num * sizeof(uint32_t));
> +        memset(s->regs.srcmd_w, 0, s->rrid_num * sizeof(uint32_t));
> +        memset(s->regs.srcmd_wh, 0, s->rrid_num * sizeof(uint32_t));
> +    }
> +
> +    if (s->stall_en) {
> +        memset((void *)s->rrid_stall, 0, s->rrid_num * sizeof(bool));
> +        s->is_stalled =3D 0;
> +    }
> +
> +    if (s->mfr_en) {
> +        memset(s->svw, 0, (s->rrid_num / 16 + 1) * sizeof(uint16_t));
> +    }
> +
> +    memset(s->regs.entry, 0, s->entry_num * sizeof(riscv_iopmp_entry_t))=
;
> +    memset(s->entry_addr, 0, s->entry_num * sizeof(riscv_iopmp_addr_t));
> +    memset(s->transaction_state, 0,
> +           s->rrid_num * sizeof(riscv_iopmp_transaction_state));
> +
> +    s->regs.mdlck =3D 0;
> +    s->regs.mdlckh =3D 0;
> +    s->regs.entrylck =3D 0;
> +    s->regs.mdcfglck =3D 0;
> +    s->regs.mdstall =3D 0;
> +    s->regs.mdstallh =3D 0;
> +    s->regs.rridscp =3D 0;
> +    s->regs.err_cfg =3D 0;
> +    s->regs.err_reqaddr =3D 0;
> +    s->regs.err_reqid =3D 0;
> +    s->regs.err_info =3D 0;
> +
> +    s->prient_prog =3D s->default_prient_prog;
> +    s->rrid_transl_prog =3D s->default_rrid_transl_prog;
> +    s->md_entry_num =3D s->default_md_entry_num;
> +    s->rrid_transl =3D s->default_rrid_transl;
> +    s->prio_entry =3D MIN(s->default_prio_entry, s->entry_num);
> +    s->regs.err_cfg =3D FIELD_DP32(s->regs.err_cfg, ERR_CFG, MSI_EN,
> +                                 s->default_msi_en);
> +    s->regs.err_cfg =3D FIELD_DP32(s->regs.err_cfg, ERR_CFG, STALL_VIOLA=
TION_EN,
> +                                 s->default_stall_violation_en);
> +    s->regs.err_cfg =3D FIELD_DP32(s->regs.err_cfg, ERR_CFG, MSIDATA,
> +                                 s->default_msidata);
> +    s->regs.err_msiaddr =3D s->default_err_msiaddr;
> +    s->regs.err_msiaddrh =3D s->default_err_msiaddrh;
> +    s->enable =3D 0;
> +}
> +
> +static void iopmp_reset_hold(Object *obj, ResetType type)
> +{
> +    RISCVIOPMPState *s =3D RISCV_IOPMP(obj);
> +
> +    qemu_set_irq(s->irq, 0);
> +}
> +
> +static int iopmp_attrs_to_index(IOMMUMemoryRegion *iommu, MemTxAttrs att=
rs)
> +{
> +    return attrs.requester_id;
> +}
> +
> +static void iopmp_iommu_memory_region_class_init(ObjectClass *klass, voi=
d *data)
> +{
> +    IOMMUMemoryRegionClass *imrc =3D IOMMU_MEMORY_REGION_CLASS(klass);
> +
> +    imrc->translate =3D iopmp_translate;
> +    imrc->attrs_to_index =3D iopmp_attrs_to_index;
> +}
> +
> +static const Property iopmp_property[] =3D {
> +    DEFINE_PROP_UINT32("mdcfg_fmt", RISCVIOPMPState, mdcfg_fmt, 1),
> +    DEFINE_PROP_UINT32("srcmd_fmt", RISCVIOPMPState, srcmd_fmt, 0),
> +    DEFINE_PROP_BOOL("tor_en", RISCVIOPMPState, tor_en, true),
> +    DEFINE_PROP_BOOL("sps_en", RISCVIOPMPState, sps_en, false),
> +    DEFINE_PROP_BOOL("prient_prog", RISCVIOPMPState, default_prient_prog=
, true),
> +    DEFINE_PROP_BOOL("rrid_transl_en", RISCVIOPMPState, rrid_transl_en, =
false),
> +    DEFINE_PROP_BOOL("rrid_transl_prog", RISCVIOPMPState,
> +                     default_rrid_transl_prog, false),
> +    DEFINE_PROP_BOOL("chk_x", RISCVIOPMPState, chk_x, true),
> +    DEFINE_PROP_BOOL("no_x", RISCVIOPMPState, no_x, false),
> +    DEFINE_PROP_BOOL("no_w", RISCVIOPMPState, no_w, false),
> +    DEFINE_PROP_BOOL("stall_en", RISCVIOPMPState, stall_en, false),
> +    DEFINE_PROP_BOOL("peis", RISCVIOPMPState, peis, true),
> +    DEFINE_PROP_BOOL("pees", RISCVIOPMPState, pees, true),
> +    DEFINE_PROP_BOOL("mfr_en", RISCVIOPMPState, mfr_en, true),
> +    DEFINE_PROP_UINT32("md_entry_num", RISCVIOPMPState, default_md_entry=
_num,
> +                       5),
> +    DEFINE_PROP_UINT32("md_num", RISCVIOPMPState, md_num, 8),
> +    DEFINE_PROP_UINT32("rrid_num", RISCVIOPMPState, rrid_num, 16),
> +    DEFINE_PROP_UINT32("entry_num", RISCVIOPMPState, entry_num, 48),
> +    DEFINE_PROP_UINT32("prio_entry", RISCVIOPMPState, default_prio_entry=
,
> +                       65535),
> +    DEFINE_PROP_UINT32("rrid_transl", RISCVIOPMPState, default_rrid_tran=
sl,
> +                       0x0),
> +    DEFINE_PROP_INT32("entry_offset", RISCVIOPMPState, entry_offset, 0x4=
000),
> +    DEFINE_PROP_UINT32("err_rdata", RISCVIOPMPState, err_rdata, 0x0),
> +    DEFINE_PROP_BOOL("msi_en", RISCVIOPMPState, default_msi_en, false),
> +    DEFINE_PROP_UINT32("msidata", RISCVIOPMPState, default_msidata, 12),
> +    DEFINE_PROP_BOOL("stall_violation_en", RISCVIOPMPState,
> +                     default_stall_violation_en, true),
> +    DEFINE_PROP_UINT32("err_msiaddr", RISCVIOPMPState, default_err_msiad=
dr,
> +                       0x24000000),
> +    DEFINE_PROP_UINT32("err_msiaddrh", RISCVIOPMPState, default_err_msia=
ddrh,
> +                       0x0),
> +    DEFINE_PROP_UINT32("msi_rrid", RISCVIOPMPState, msi_rrid, 0),
> +};
> +
> +static void iopmp_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> +    device_class_set_props(dc, iopmp_property);
> +    dc->realize =3D iopmp_realize;
> +    rc->phases.enter =3D iopmp_reset_enter;
> +    rc->phases.hold =3D iopmp_reset_hold;
> +}
> +
> +static void iopmp_init(Object *obj)
> +{
> +    RISCVIOPMPState *s =3D RISCV_IOPMP(obj);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> +
> +    sysbus_init_irq(sbd, &s->irq);
> +}
> +
> +static const TypeInfo iopmp_info =3D {
> +    .name =3D TYPE_RISCV_IOPMP,
> +    .parent =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(RISCVIOPMPState),
> +    .instance_init =3D iopmp_init,
> +    .class_init =3D iopmp_class_init,
> +};
> +
> +static const TypeInfo iopmp_iommu_memory_region_info =3D {
> +    .name =3D TYPE_RISCV_IOPMP_IOMMU_MEMORY_REGION,
> +    .parent =3D TYPE_IOMMU_MEMORY_REGION,
> +    .class_init =3D iopmp_iommu_memory_region_class_init,
> +};
> +
> +DeviceState *iopmp_create(hwaddr addr, qemu_irq irq)
> +{
> +    DeviceState *dev =3D qdev_new(TYPE_RISCV_IOPMP);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
> +    return dev;
> +}
> +
> +/*
> + * Alias subregions from the source memory region to the destination mem=
ory
> + * region
> + */
> +static void alias_memory_subregions(MemoryRegion *src_mr, MemoryRegion *=
dst_mr)
> +{
> +    int32_t priority;
> +    hwaddr addr;
> +    MemoryRegion *alias, *subregion;
> +    QTAILQ_FOREACH(subregion, &src_mr->subregions, subregions_link) {
> +        priority =3D subregion->priority;
> +        addr =3D subregion->addr;
> +        alias =3D g_malloc0(sizeof(MemoryRegion));
> +        memory_region_init_alias(alias, NULL, subregion->name, subregion=
, 0,
> +                                 memory_region_size(subregion));
> +        memory_region_add_subregion_overlap(dst_mr, addr, alias, priorit=
y);
> +    }
> +}
> +
> +/*
> + * Create downstream of system memory for IOPMP, and overlap memory regi=
on
> + * specified in memmap with IOPMP translator. Make sure subregions are a=
dded to
> + * system memory before call this function. It also add entry to
> + * iopmp_protection_memmaps for recording the relationship between physi=
cal
> + * address regions and IOPMP.
> + */
> +void iopmp_setup_system_memory(DeviceState *dev, const MemMapEntry *memm=
ap,
> +                               uint32_t map_entry_num, uint32_t stage)
> +{
> +    RISCVIOPMPState *s =3D RISCV_IOPMP(dev);
> +    uint32_t i;
> +    MemoryRegion *iommu_alias;
> +    MemoryRegion *target_mr =3D get_system_memory();
> +    MemoryRegion *downstream =3D g_malloc0(sizeof(MemoryRegion));
> +    memory_region_init(downstream, NULL, "iopmp_downstream",
> +                       memory_region_size(target_mr));
> +    /* Create a downstream which does not have iommu of iopmp */
> +    alias_memory_subregions(target_mr, downstream);
> +
> +    for (i =3D 0; i < map_entry_num; i++) {
> +        /* Memory access to protected regions of target are through IOPM=
P */
> +        iommu_alias =3D g_new(MemoryRegion, 1);
> +        memory_region_init_alias(iommu_alias, NULL, "iommu_alias",
> +                                 MEMORY_REGION(&s->iommu), memmap[i].bas=
e,
> +                                 memmap[i].size);
> +        memory_region_add_subregion_overlap(target_mr, memmap[i].base,
> +                                            iommu_alias, 1);
> +    }
> +    s->downstream =3D downstream;
> +    address_space_init(&s->downstream_as, s->downstream,
> +                       "riscv-iopmp-downstream-as");
> +}
> +
> +static size_t txn_info_push(StreamSink *txn_info_sink, unsigned char *bu=
f,
> +                            size_t len, bool eop)
> +{
> +    riscv_iopmp_streamsink *ss =3D RISCV_IOPMP_STREAMSINK(txn_info_sink)=
;
> +    RISCVIOPMPState *s =3D RISCV_IOPMP(container_of(ss, RISCVIOPMPState,
> +                                      txn_info_sink));
> +    riscv_iopmp_txn_info signal;
> +    uint32_t rrid;
> +
> +    memcpy(&signal, buf, len);
> +    rrid =3D signal.rrid;
> +
> +    if (s->transaction_state[rrid].running) {
> +        if (eop) {
> +            /* Finish the transaction */
> +            qemu_mutex_lock(&s->iopmp_transaction_mutex);
> +            s->transaction_state[rrid].running =3D 0;
> +            qemu_mutex_unlock(&s->iopmp_transaction_mutex);
> +            return 1;
> +        } else {
> +            /* Transaction is already running */
> +            return 0;
> +        }
> +    } else if (len =3D=3D sizeof(riscv_iopmp_txn_info)) {
> +        /* Get the transaction info */
> +        s->transaction_state[rrid].supported =3D 1;
> +        qemu_mutex_lock(&s->iopmp_transaction_mutex);
> +        s->transaction_state[rrid].running =3D 1;
> +        qemu_mutex_unlock(&s->iopmp_transaction_mutex);
> +
> +        s->transaction_state[rrid].start_addr =3D signal.start_addr;
> +        s->transaction_state[rrid].end_addr =3D signal.end_addr;
> +        s->transaction_state[rrid].error_reported =3D 0;
> +        s->transaction_state[rrid].stage =3D signal.stage;
> +        return 1;
> +    }
> +    return 0;
> +}
> +
> +void iopmp_setup_sink(DeviceState *dev, StreamSink * ss)
> +{
> +     RISCVIOPMPState *s =3D RISCV_IOPMP(dev);
> +     s->send_ss =3D ss;
> +}
> +
> +static void riscv_iopmp_streamsink_class_init(ObjectClass *klass, void *=
data)
> +{
> +    StreamSinkClass *ssc =3D STREAM_SINK_CLASS(klass);
> +    ssc->push =3D txn_info_push;
> +}
> +
> +static const TypeInfo txn_info_sink =3D {
> +    .name =3D TYPE_RISCV_IOPMP_STREAMSINK,
> +    .parent =3D TYPE_OBJECT,
> +    .instance_size =3D sizeof(riscv_iopmp_streamsink),
> +    .class_init =3D riscv_iopmp_streamsink_class_init,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { TYPE_STREAM_SINK },
> +        { }
> +    },
> +};
> +
> +static void iopmp_register_types(void)
> +{
> +    type_register_static(&iopmp_info);
> +    type_register_static(&txn_info_sink);
> +    type_register_static(&iopmp_iommu_memory_region_info);
> +}
> +
> +type_init(iopmp_register_types);
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index cf1abe6928..fc7126fb32 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -390,3 +390,7 @@ ivshmem_flat_read_write_mmr_invalid(uint64_t addr_off=
set) "No ivshmem register m
>  ivshmem_flat_interrupt_invalid_peer(uint16_t peer_id) "Can't interrupt n=
on-existing peer %u"
>  ivshmem_flat_write_mmr(uint64_t addr_offset) "Write access at offset %"P=
RIu64
>  ivshmem_flat_interrupt_peer(uint16_t peer_id, uint16_t vector_id) "Inter=
rupting peer ID %u, vector %u..."
> +
> +# riscv_iopmp.c
> +iopmp_read(uint64_t addr, uint32_t val) "addr 0x%"PRIx64" val 0x%x"
> +iopmp_write(uint64_t addr, uint32_t val) "addr 0x%"PRIx64" val 0x%x"
> diff --git a/include/hw/misc/riscv_iopmp.h b/include/hw/misc/riscv_iopmp.=
h
> new file mode 100644
> index 0000000000..18e3afa252
> --- /dev/null
> +++ b/include/hw/misc/riscv_iopmp.h
> @@ -0,0 +1,191 @@
> +/*
> + * QEMU RISC-V IOPMP (Input Output Physical Memory Protection)
> + *
> + * Copyright (c) 2023-2025 Andes Tech. Corp.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOU=
T
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License alo=
ng with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef RISCV_IOPMP_H
> +#define RISCV_IOPMP_H
> +
> +#include "hw/sysbus.h"
> +#include "qemu/typedefs.h"
> +#include "memory.h"
> +#include "exec/hwaddr.h"
> +#include "hw/stream.h"
> +
> +#define TYPE_RISCV_IOPMP "riscv-iopmp"
> +OBJECT_DECLARE_SIMPLE_TYPE(RISCVIOPMPState, RISCV_IOPMP)
> +
> +typedef struct riscv_iopmp_streamsink {
> +    Object parent;
> +} riscv_iopmp_streamsink;
> +#define TYPE_RISCV_IOPMP_STREAMSINK \
> +        "riscv-iopmp-streamsink"
> +DECLARE_INSTANCE_CHECKER(riscv_iopmp_streamsink, RISCV_IOPMP_STREAMSINK,
> +                         TYPE_RISCV_IOPMP_STREAMSINK)
> +typedef struct {
> +    uint32_t addr_reg;
> +    uint32_t addrh_reg;
> +    uint32_t cfg_reg;
> +} riscv_iopmp_entry_t;
> +
> +typedef struct {
> +    uint64_t sa;
> +    uint64_t ea;
> +} riscv_iopmp_addr_t;
> +
> +typedef struct {
> +    union {
> +        uint32_t *srcmd_en;
> +        uint32_t *srcmd_perm;
> +    };
> +    union {
> +        uint32_t *srcmd_enh;
> +        uint32_t *srcmd_permh;
> +    };
> +    uint32_t *srcmd_r;
> +    uint32_t *srcmd_rh;
> +    uint32_t *srcmd_w;
> +    uint32_t *srcmd_wh;
> +    uint32_t *mdcfg;
> +    riscv_iopmp_entry_t *entry;
> +    uint32_t mdlck;
> +    uint32_t mdlckh;
> +    uint32_t entrylck;
> +    uint32_t mdcfglck;
> +    uint32_t mdstall;
> +    uint32_t mdstallh;
> +    uint32_t rridscp;
> +    uint32_t err_cfg;
> +    uint64_t err_reqaddr;
> +    uint32_t err_reqid;
> +    uint32_t err_info;
> +    uint32_t err_msiaddr;
> +    uint32_t err_msiaddrh;
> +} riscv_iopmp_regs;
> +
> +/* To detect partially hit */
> +typedef struct riscv_iopmp_transaction_state {
> +    bool running;
> +    bool error_reported;
> +    bool supported;
> +    uint32_t stage;
> +    hwaddr start_addr;
> +    hwaddr end_addr;
> +} riscv_iopmp_transaction_state;
> +
> +typedef struct RISCVIOPMPState {
> +    SysBusDevice parent_obj;
> +    riscv_iopmp_addr_t *entry_addr;
> +    MemoryRegion mmio;
> +    IOMMUMemoryRegion iommu;
> +    riscv_iopmp_regs regs;
> +    MemoryRegion *downstream;
> +    MemoryRegion blocked_r, blocked_w, blocked_x, blocked_rw, blocked_rx=
,
> +                 blocked_wx, blocked_rwx;
> +    MemoryRegion full_mr;
> +
> +    AddressSpace downstream_as;
> +    AddressSpace blocked_r_as, blocked_w_as, blocked_x_as, blocked_rw_as=
,
> +                 blocked_rx_as, blocked_wx_as, blocked_rwx_as;
> +    AddressSpace full_as;
> +    qemu_irq irq;
> +
> +    /* Transaction(txn) information to identify whole transaction length=
 */
> +    /* Receive txn info */
> +    riscv_iopmp_streamsink txn_info_sink;
> +    /* Send txn info for next stage iopmp */
> +    StreamSink *send_ss;
> +    riscv_iopmp_transaction_state *transaction_state;
> +    QemuMutex iopmp_transaction_mutex;
> +
> +    /*
> +     * Stall:
> +     * a while loop to check stall flags if stall_violation is not enabl=
ed
> +     */
> +    volatile bool is_stalled;
> +    volatile bool *rrid_stall;
> +
> +    /* MFR extenstion */
> +    uint16_t *svw;
> +    uint16_t svi;
> +
> +    /* Properties */
> +    /*
> +     * MDCFG Format 0: MDCFG table is implemented
> +     *              1: HWCFG.md_entry_num is fixed
> +     *              2: HWCFG.md_entry_num is programmable
> +     */
> +    uint32_t mdcfg_fmt;
> +    /*
> +     * SRCMD Format 0: SRCMD_EN is implemented
> +     *              1: 1 to 1 SRCMD mapping
> +     *              2: SRCMD_PERM is implemented
> +     */
> +    uint32_t srcmd_fmt;
> +    bool tor_en;
> +    /* SPS is only supported srcmd_fmt0 */
> +    bool sps_en;
> +    /* Indicate prio_entry is programmable or not */
> +    bool default_prient_prog;
> +    bool rrid_transl_en;
> +    bool default_rrid_transl_prog;
> +    bool chk_x;
> +    bool no_x;
> +    bool no_w;
> +    bool stall_en;
> +    bool default_stall_violation_en;
> +    bool peis;
> +    bool pees;
> +    bool mfr_en;
> +    /* Indicate md_entry_num for mdcfg_fmt1/2 */
> +    uint32_t default_md_entry_num;
> +    uint32_t md_num;
> +    uint32_t rrid_num;
> +    uint32_t entry_num;
> +    /* Indicate number of priority entry */
> +    uint32_t default_prio_entry;
> +    uint32_t default_rrid_transl;
> +    /* MSI */
> +    bool default_msi_en;
> +    uint32_t default_msidata;
> +    uint32_t default_err_msiaddr;
> +    uint32_t default_err_msiaddrh;
> +    uint32_t msi_rrid;
> +    /* Note: entry_offset < 0 is not support in QEMU */
> +    int32_t entry_offset;
> +    /*
> +     * Data value to be returned for all read accesses that violate the =
security
> +     * check
> +     */
> +    uint32_t err_rdata;
> +
> +    /* Current status for programmable parameters */
> +    bool prient_prog;
> +    bool rrid_transl_prog;
> +    uint32_t md_entry_num;
> +    uint32_t prio_entry;
> +    uint32_t rrid_transl;
> +    bool enable;
> +} RISCVIOPMPState;
> +
> +DeviceState *iopmp_create(hwaddr addr, qemu_irq irq);
> +void iopmp_setup_system_memory(DeviceState *dev, const MemMapEntry *memm=
ap,
> +                               uint32_t mapentry_num, uint32_t stage);
> +void iopmp_setup_sink(DeviceState *dev, StreamSink * ss);
> +
> +#endif
> --
> 2.34.1
>
>

