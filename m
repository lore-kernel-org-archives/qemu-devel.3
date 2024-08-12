Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17740C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 00:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdJ9n-00079g-ED; Sun, 11 Aug 2024 20:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sdJ9f-00078T-Fa; Sun, 11 Aug 2024 20:43:23 -0400
Received: from mail-vs1-xe33.google.com ([2607:f8b0:4864:20::e33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sdJ9a-0001ZH-4K; Sun, 11 Aug 2024 20:43:22 -0400
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-4928fb6fdceso1264239137.3; 
 Sun, 11 Aug 2024 17:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723423397; x=1724028197; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jo6vJ4BaRGk1Pw4f5uo6YKWKeAD5JJ3XJ9Ng7dpXCRg=;
 b=mF7UPtEzvWP6a98k8J9WsDsCQQlLb4dvLf6LwqlFg9qdhG7xKV/WABFOX4FC2l8ToV
 hIe+nSzO5MLqGd09XcGp6W/V5tAYH9aWPH/OG4c56G/7JbM8ve53am7wzRVpTuZrKauT
 KxnS945Vr0fBKCXv3s9+JJDM/DojV6o7xF5BlpAeP/bV+J3+IHWBMR29vzkzYvuEngR2
 UccC5iMWH48JYL3+gyDHiQjHx/LGZrioWOpRjwyyWw76fKoCcyDHCvAUMnrJym8Qt7FP
 SDcX4qc2rmoIU4Hrhh5tTbBnnv7EjnlmOpV2zxjLmcHiGlA0T1k5X+f4JRKwh6ZD5ex1
 NB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723423397; x=1724028197;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jo6vJ4BaRGk1Pw4f5uo6YKWKeAD5JJ3XJ9Ng7dpXCRg=;
 b=HRmBsO9a+OVb6u49UCJm2Zkex/RtjRBWj3+sbPnEbTYBICohxujwK5h4lbPJZEU50J
 q7/mDjNx8pFfyd+3a0rHzUHYqWkkjSwQ7MwqaT+0nPnFwOqKXzO1grsULmVey5CXxaYX
 P3AUakqRMO2URVHvQWOcQ1k+bHxGyLK/dM5Y2eT9XSm4LJ1iO1Q0yCkSVof0uKjyJAd0
 NR8fvpoSuvAEomb4YDR+1obC9kuRsEwSSxl7ZahRjE3lYdcLGdOQlFn6+zbSR1LBetHd
 7RXYLPO1ryPRRDtOXPMdC/ZzaFkWm08oN701N+jwTR6qBigHQbfOt1RlyOxuO657dblF
 xD9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJzdwXAYIWN1KEWZVFHmy+ESxvwcQAmyi2y/ZCdTw9dPOnAj2JGmAF4l1VFtQEHu4cx7vNa8EgK0SPXEyT71LJOFqvgDg=
X-Gm-Message-State: AOJu0Yy0AedgWfq0CQUfLZCv/AwDwFYDojjS9gTPladsjHpx+8iF9EUH
 44vLT+9uLFu6BFELsLiDYZmPYwVovqAcesgKDo8961WYp+yX+lpnNoAjC4OCAYI33nL29dkCD0r
 4NfPSwWIv//GVwxZ1pcJDCut7j2g=
X-Google-Smtp-Source: AGHT+IEDma3KvHlxNn9wuk1l436gAJ0MxjPEJMwMEIFYP/OXle7YDtpboNVOtVsVW04Q5MikJXzrFV0DOtNat1K2eBE=
X-Received: by 2002:a05:6102:3746:b0:493:c1f0:d46f with SMTP id
 ada2fe7eead31-495d85b3168mr9649277137.22.1723423396474; Sun, 11 Aug 2024
 17:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240715095702.1222213-1-ethan84@andestech.com>
 <20240715095702.1222213-5-ethan84@andestech.com>
 <CAKmqyKM5TPHOAuf-b13CTp2_D5mOAt6bpMv2NWv06z0o2sQx5g@mail.gmail.com>
 <ZrXkdYxB0LzE0lrj@ethan84-VirtualBox>
In-Reply-To: <ZrXkdYxB0LzE0lrj@ethan84-VirtualBox>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 12 Aug 2024 10:42:50 +1000
Message-ID: <CAKmqyKMZXw2s0YSA7Z6OwB3LVdZVt5ViQ8iu4UdkEtn5dsb=pA@mail.gmail.com>
Subject: Re: [PATCH v8 4/8] hw/misc/riscv_iopmp: Add RISC-V IOPMP device
To: Ethan Chen <ethan84@andestech.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e33;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe33.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Aug 9, 2024 at 7:42=E2=80=AFPM Ethan Chen <ethan84@andestech.com> w=
rote:
>
> On Thu, Aug 08, 2024 at 01:56:35PM +1000, Alistair Francis wrote:
> > [EXTERNAL MAIL]
> >
> > On Mon, Jul 15, 2024 at 7:58=E2=80=AFPM Ethan Chen via <qemu-devel@nong=
nu.org> wrote:
> > >
> > > Support basic functions of IOPMP specification v0.9.1 rapid-k model.
> > > The specification url:
> > > https://github.com/riscv-non-isa/iopmp-spec/releases/tag/v0.9.1
> > >
> > > The IOPMP checks whether memory access from a device or CPU is valid.
> > > This implementation uses an IOMMU to modify the address space accesse=
d
> > > by the device.
> > >
> > > For device access with IOMMUAccessFlags specifying read or write
> > > (IOMMU_RO or IOMMU_WO), the IOPMP checks the permission in
> > > iopmp_translate. If the access is valid, the target address space is
> > > downstream_as. If the access is blocked, it will be redirected to
> > > blocked_rwx_as.
> > >
> > > For CPU access with IOMMUAccessFlags not specifying read or write
> > > (IOMMU_NONE), the IOPMP translates the access to the corresponding
> > > address space based on the permission. If the access has full permiss=
ion
> > > (rwx), the target address space is downstream_as. If the access has
> > > limited permission, the target address space is blocked_ followed by
> > > the lacked permissions.
> > >
> > > The operation of a blocked region can trigger an IOPMP interrupt, a b=
us
> > > error, or it can respond with success and fabricated data, depending =
on
> > > the value of the IOPMP ERR_CFG register.
> > >
> > > Signed-off-by: Ethan Chen <ethan84@andestech.com>
> > > ---
> > >  hw/misc/Kconfig               |    3 +
> > >  hw/misc/meson.build           |    1 +
> > >  hw/misc/riscv_iopmp.c         | 1154 +++++++++++++++++++++++++++++++=
++
> > >  hw/misc/trace-events          |    3 +
> > >  include/hw/misc/riscv_iopmp.h |  168 +++++
> > >  5 files changed, 1329 insertions(+)
> > >  create mode 100644 hw/misc/riscv_iopmp.c
> > >  create mode 100644 include/hw/misc/riscv_iopmp.h
> > >
> > > diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> > > index 1e08785b83..427f0c702e 100644
> > > --- a/hw/misc/Kconfig
> > > +++ b/hw/misc/Kconfig
> > > @@ -213,4 +213,7 @@ config IOSB
> > >  config XLNX_VERSAL_TRNG
> > >      bool
> > >
> > > +config RISCV_IOPMP
> > > +    bool
> > > +
> > >  source macio/Kconfig
> > > diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> > > index 2ca8717be2..d9006e1d81 100644
> > > --- a/hw/misc/meson.build
> > > +++ b/hw/misc/meson.build
> > > @@ -34,6 +34,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true=
: files('sifive_e_prci.c'))
> > >  system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true: files('sifive_e_=
aon.c'))
> > >  system_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_=
otp.c'))
> > >  system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u=
_prci.c'))
> > > +specific_ss.add(when: 'CONFIG_RISCV_IOPMP', if_true: files('riscv_io=
pmp.c'))
> > >
> > >  subdir('macio')
> > >
> > > diff --git a/hw/misc/riscv_iopmp.c b/hw/misc/riscv_iopmp.c
> > > new file mode 100644
> > > index 0000000000..db43e3c73f
> > > --- /dev/null
> > > +++ b/hw/misc/riscv_iopmp.c
> > > @@ -0,0 +1,1154 @@
> > > +/*
> > > + * QEMU RISC-V IOPMP (Input Output Physical Memory Protection)
> > > + *
> > > + * Copyright (c) 2023-2024 Andes Tech. Corp.
> > > + *
> > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > + *
> > > + * This program is free software; you can redistribute it and/or mod=
ify it
> > > + * under the terms and conditions of the GNU General Public License,
> > > + * version 2 or later, as published by the Free Software Foundation.
> > > + *
> > > + * This program is distributed in the hope it will be useful, but WI=
THOUT
> > > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILIT=
Y or
> > > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Lic=
ense for
> > > + * more details.
> > > + *
> > > + * this program.  If not, see <http://www.gnu.org/licenses/>.
> > > + */
> > > +
> > > +#include "qemu/osdep.h"
> > > +#include "qemu/log.h"
> > > +#include "qapi/error.h"
> > > +#include "trace.h"
> > > +#include "exec/exec-all.h"
> > > +#include "exec/address-spaces.h"
> > > +#include "hw/qdev-properties.h"
> > > +#include "hw/sysbus.h"
> > > +#include "hw/misc/riscv_iopmp.h"
> > > +#include "memory.h"
> > > +#include "hw/irq.h"
> > > +#include "hw/registerfields.h"
> > > +#include "trace.h"
> > > +
> > > +#define TYPE_IOPMP_IOMMU_MEMORY_REGION "iopmp-iommu-memory-region"
> > > +
> > > +REG32(VERSION, 0x00)
> > > +    FIELD(VERSION, VENDOR, 0, 24)
> > > +    FIELD(VERSION, SPECVER , 24, 8)
> > > +REG32(IMP, 0x04)
> > > +    FIELD(IMP, IMPID, 0, 32)
> > > +REG32(HWCFG0, 0x08)
> > > +    FIELD(HWCFG0, MODEL, 0, 4)
> > > +    FIELD(HWCFG0, TOR_EN, 4, 1)
> > > +    FIELD(HWCFG0, SPS_EN, 5, 1)
> > > +    FIELD(HWCFG0, USER_CFG_EN, 6, 1)
> > > +    FIELD(HWCFG0, PRIENT_PROG, 7, 1)
> > > +    FIELD(HWCFG0, RRID_TRANSL_EN, 8, 1)
> > > +    FIELD(HWCFG0, RRID_TRANSL_PROG, 9, 1)
> > > +    FIELD(HWCFG0, CHK_X, 10, 1)
> > > +    FIELD(HWCFG0, NO_X, 11, 1)
> > > +    FIELD(HWCFG0, NO_W, 12, 1)
> > > +    FIELD(HWCFG0, STALL_EN, 13, 1)
> > > +    FIELD(HWCFG0, PEIS, 14, 1)
> > > +    FIELD(HWCFG0, PEES, 15, 1)
> > > +    FIELD(HWCFG0, MFR_EN, 16, 1)
> > > +    FIELD(HWCFG0, MD_NUM, 24, 7)
> > > +    FIELD(HWCFG0, ENABLE, 31, 1)
> > > +REG32(HWCFG1, 0x0C)
> > > +    FIELD(HWCFG1, RRID_NUM, 0, 16)
> > > +    FIELD(HWCFG1, ENTRY_NUM, 16, 16)
> > > +REG32(HWCFG2, 0x10)
> > > +    FIELD(HWCFG2, PRIO_ENTRY, 0, 16)
> > > +    FIELD(HWCFG2, RRID_TRANSL, 16, 16)
> > > +REG32(ENTRYOFFSET, 0x14)
> > > +    FIELD(ENTRYOFFSET, OFFSET, 0, 32)
> > > +REG32(MDSTALL, 0x30)
> > > +    FIELD(MDSTALL, EXEMPT, 0, 1)
> > > +    FIELD(MDSTALL, MD, 1, 31)
> > > +REG32(MDSTALLH, 0x34)
> > > +    FIELD(MDSTALLH, MD, 0, 32)
> > > +REG32(RRIDSCP, 0x38)
> > > +    FIELD(RRIDSCP, RRID, 0, 16)
> > > +    FIELD(RRIDSCP, OP, 30, 2)
> > > +REG32(MDLCK, 0x40)
> > > +    FIELD(MDLCK, L, 0, 1)
> > > +    FIELD(MDLCK, MD, 1, 31)
> > > +REG32(MDLCKH, 0x44)
> > > +    FIELD(MDLCKH, MDH, 0, 32)
> > > +REG32(MDCFGLCK, 0x48)
> > > +    FIELD(MDCFGLCK, L, 0, 1)
> > > +    FIELD(MDCFGLCK, F, 1, 7)
> > > +REG32(ENTRYLCK, 0x4C)
> > > +    FIELD(ENTRYLCK, L, 0, 1)
> > > +    FIELD(ENTRYLCK, F, 1, 16)
> > > +REG32(ERR_CFG, 0x60)
> > > +    FIELD(ERR_CFG, L, 0, 1)
> > > +    FIELD(ERR_CFG, IE, 1, 1)
> > > +    FIELD(ERR_CFG, IRE, 2, 1)
> > > +    FIELD(ERR_CFG, IWE, 3, 1)
> > > +    FIELD(ERR_CFG, IXE, 4, 1)
> > > +    FIELD(ERR_CFG, RRE, 5, 1)
> > > +    FIELD(ERR_CFG, RWE, 6, 1)
> > > +    FIELD(ERR_CFG, RXE, 7, 1)
> > > +REG32(ERR_REQINFO, 0x64)
> > > +    FIELD(ERR_REQINFO, V, 0, 1)
> > > +    FIELD(ERR_REQINFO, TTYPE, 1, 2)
> > > +    FIELD(ERR_REQINFO, ETYPE, 4, 3)
> > > +    FIELD(ERR_REQINFO, SVC, 7, 1)
> > > +REG32(ERR_REQADDR, 0x68)
> > > +    FIELD(ERR_REQADDR, ADDR, 0, 32)
> > > +REG32(ERR_REQADDRH, 0x6C)
> > > +    FIELD(ERR_REQADDRH, ADDRH, 0, 32)
> > > +REG32(ERR_REQID, 0x70)
> > > +    FIELD(ERR_REQID, RRID, 0, 16)
> > > +    FIELD(ERR_REQID, EID, 16, 16)
> > > +REG32(ERR_MFR, 0x74)
> > > +    FIELD(ERR_MFR, SVW, 0, 16)
> > > +    FIELD(ERR_MFR, SVI, 16, 12)
> > > +    FIELD(ERR_MFR, SVS, 31, 1)
> > > +REG32(MDCFG0, 0x800)
> > > +    FIELD(MDCFG0, T, 0, 16)
> > > +REG32(SRCMD_EN0, 0x1000)
> > > +    FIELD(SRCMD_EN0, L, 0, 1)
> > > +    FIELD(SRCMD_EN0, MD, 1, 31)
> > > +REG32(SRCMD_ENH0, 0x1004)
> > > +    FIELD(SRCMD_ENH0, MDH, 0, 32)
> > > +REG32(SRCMD_R0, 0x1008)
> > > +    FIELD(SRCMD_R0, MD, 1, 31)
> > > +REG32(SRCMD_RH0, 0x100C)
> > > +    FIELD(SRCMD_RH0, MDH, 0, 32)
> > > +REG32(SRCMD_W0, 0x1010)
> > > +    FIELD(SRCMD_W0, MD, 1, 31)
> > > +REG32(SRCMD_WH0, 0x1014)
> > > +    FIELD(SRCMD_WH0, MDH, 0, 32)
> > > +
> > > +FIELD(ENTRY_ADDR, ADDR, 0, 32)
> > > +FIELD(ENTRY_ADDRH, ADDRH, 0, 32)
> > > +
> > > +FIELD(ENTRY_CFG, R, 0, 1)
> > > +FIELD(ENTRY_CFG, W, 1, 1)
> > > +FIELD(ENTRY_CFG, X, 2, 1)
> > > +FIELD(ENTRY_CFG, A, 3, 2)
> > > +FIELD(ENTRY_CFG, SIRE, 5, 1)
> > > +FIELD(ENTRY_CFG, SIWE, 6, 1)
> > > +FIELD(ENTRY_CFG, SIXE, 7, 1)
> > > +FIELD(ENTRY_CFG, SERE, 8, 1)
> > > +FIELD(ENTRY_CFG, SEWE, 9, 1)
> > > +FIELD(ENTRY_CFG, SEXE, 10, 1)
> > > +
> > > +FIELD(ENTRY_USER_CFG, IM, 0, 32)
> > > +
> > > +/* Offsets to SRCMD_EN(i) */
> > > +#define SRCMD_EN_OFFSET  0x0
> > > +#define SRCMD_ENH_OFFSET 0x4
> > > +#define SRCMD_R_OFFSET   0x8
> > > +#define SRCMD_RH_OFFSET  0xC
> > > +#define SRCMD_W_OFFSET   0x10
> > > +#define SRCMD_WH_OFFSET  0x14
> > > +
> > > +/* Offsets to ENTRY_ADDR(i) */
> > > +#define ENTRY_ADDR_OFFSET     0x0
> > > +#define ENTRY_ADDRH_OFFSET    0x4
> > > +#define ENTRY_CFG_OFFSET      0x8
> > > +#define ENTRY_USER_CFG_OFFSET 0xC
> > > +
> > > +/* Memmap for parallel IOPMPs */
> > > +typedef struct iopmp_protection_memmap {
> > > +    MemMapEntry entry;
> > > +    IopmpState *iopmp_s;
> > > +    QLIST_ENTRY(iopmp_protection_memmap) list;
> > > +} iopmp_protection_memmap;
> > > +QLIST_HEAD(, iopmp_protection_memmap)
> > > +    iopmp_protection_memmaps =3D QLIST_HEAD_INITIALIZER(iopmp_protec=
tion_memmaps);
> > > +
> > > +static void iopmp_iommu_notify(IopmpState *s)
> > > +{
> > > +    IOMMUTLBEvent event =3D {
> > > +        .entry =3D {
> > > +            .iova =3D 0,
> > > +            .translated_addr =3D 0,
> > > +            .addr_mask =3D -1ULL,
> > > +            .perm =3D IOMMU_NONE,
> > > +        },
> > > +        .type =3D IOMMU_NOTIFIER_UNMAP,
> > > +    };
> > > +
> > > +    for (int i =3D 0; i < s->rrid_num; i++) {
> > > +        memory_region_notify_iommu(&s->iommu, i, event);
> > > +    }
> > > +}
> > > +
> > > +static void iopmp_decode_napot(uint64_t a, uint64_t *sa,
> > > +                               uint64_t *ea)
> > > +{
> > > +    /*
> > > +     * aaaa...aaa0   8-byte NAPOT range
> > > +     * aaaa...aa01   16-byte NAPOT range
> > > +     * aaaa...a011   32-byte NAPOT range
> > > +     * ...
> > > +     * aa01...1111   2^XLEN-byte NAPOT range
> > > +     * a011...1111   2^(XLEN+1)-byte NAPOT range
> > > +     * 0111...1111   2^(XLEN+2)-byte NAPOT range
> > > +     *  1111...1111   Reserved
> > > +     */
> > > +
> > > +    a =3D (a << 2) | 0x3;
> > > +    *sa =3D a & (a + 1);
> > > +    *ea =3D a | (a + 1);
> > > +}
> > > +
> > > +static void iopmp_update_rule(IopmpState *s, uint32_t entry_index)
> > > +{
> > > +    uint8_t this_cfg =3D s->regs.entry[entry_index].cfg_reg;
> > > +    uint64_t this_addr =3D s->regs.entry[entry_index].addr_reg |
> > > +                         ((uint64_t)s->regs.entry[entry_index].addrh=
_reg << 32);
> > > +    uint64_t prev_addr =3D 0u;
> > > +    uint64_t sa =3D 0u;
> > > +    uint64_t ea =3D 0u;
> > > +
> > > +    if (entry_index >=3D 1u) {
> > > +        prev_addr =3D s->regs.entry[entry_index - 1].addr_reg |
> > > +                    ((uint64_t)s->regs.entry[entry_index - 1].addrh_=
reg << 32);
> > > +    }
> > > +
> > > +    switch (FIELD_EX32(this_cfg, ENTRY_CFG, A)) {
> > > +    case IOPMP_AMATCH_OFF:
> > > +        sa =3D 0u;
> > > +        ea =3D -1;
> > > +        break;
> > > +
> > > +    case IOPMP_AMATCH_TOR:
> > > +        sa =3D (prev_addr) << 2; /* shift up from [xx:0] to [xx+2:2]=
 */
> > > +        ea =3D ((this_addr) << 2) - 1u;
> > > +        if (sa > ea) {
> > > +            sa =3D ea =3D 0u;
> > > +        }
> > > +        break;
> > > +
> > > +    case IOPMP_AMATCH_NA4:
> > > +        sa =3D this_addr << 2; /* shift up from [xx:0] to [xx+2:2] *=
/
> > > +        ea =3D (sa + 4u) - 1u;
> > > +        break;
> > > +
> > > +    case IOPMP_AMATCH_NAPOT:
> > > +        iopmp_decode_napot(this_addr, &sa, &ea);
> > > +        break;
> > > +
> > > +    default:
> > > +        sa =3D 0u;
> > > +        ea =3D 0u;
> > > +        break;
> > > +    }
> > > +
> > > +    s->entry_addr[entry_index].sa =3D sa;
> > > +    s->entry_addr[entry_index].ea =3D ea;
> > > +    iopmp_iommu_notify(s);
> > > +}
> > > +
> > > +static uint64_t iopmp_read(void *opaque, hwaddr addr, unsigned size)
> > > +{
> > > +    IopmpState *s =3D IOPMP(opaque);
> > > +    uint32_t rz =3D 0;
> > > +    uint32_t offset, idx;
> > > +
> > > +    switch (addr) {
> > > +    case A_VERSION:
> > > +        rz =3D VENDER_VIRT << R_VERSION_VENDOR_SHIFT |
> > > +             SPECVER_0_9_1 << R_VERSION_SPECVER_SHIFT;
> >
> > It would be better to use the FIELD_DP32() macro instead of the manual =
shifts
>
> It will be refined in next revision.
>
> >
> > > +        break;
> > > +    case A_IMP:
> > > +        rz =3D IMPID_0_9_1;
> > > +        break;
> > > +    case A_HWCFG0:
> > > +        rz =3D s->model << R_HWCFG0_MODEL_SHIFT |
> > > +             1 << R_HWCFG0_TOR_EN_SHIFT |
> > > +             0 << R_HWCFG0_SPS_EN_SHIFT |
> > > +             0 << R_HWCFG0_USER_CFG_EN_SHIFT |
> > > +             s->prient_prog << R_HWCFG0_PRIENT_PROG_SHIFT |
> > > +             0 << R_HWCFG0_RRID_TRANSL_EN_SHIFT |
> > > +             0 << R_HWCFG0_RRID_TRANSL_PROG_SHIFT |
> > > +             1 << R_HWCFG0_CHK_X_SHIFT |
> > > +             0 << R_HWCFG0_NO_X_SHIFT |
> > > +             0 << R_HWCFG0_NO_W_SHIFT |
> > > +             0 << R_HWCFG0_STALL_EN_SHIFT |
> > > +             0 << R_HWCFG0_PEIS_SHIFT |
> > > +             0 << R_HWCFG0_PEES_SHIFT |
> > > +             0 << R_HWCFG0_MFR_EN_SHIFT |
> > > +             s->md_num << R_HWCFG0_MD_NUM_SHIFT |
> > > +             s->enable << R_HWCFG0_ENABLE_SHIFT ;
> > > +        break;
> > > +    case A_HWCFG1:
> > > +        rz =3D s->rrid_num << R_HWCFG1_RRID_NUM_SHIFT |
> > > +             s->entry_num << R_HWCFG1_ENTRY_NUM_SHIFT;
> > > +        break;
> > > +    case A_HWCFG2:
> > > +        rz =3D s->prio_entry << R_HWCFG2_PRIO_ENTRY_SHIFT;
> > > +        break;
> > > +    case A_ENTRYOFFSET:
> > > +        rz =3D s->entry_offset;
> > > +        break;
> > > +    case A_ERR_CFG:
> > > +        rz =3D s->regs.err_cfg;
> > > +        break;
> > > +    case A_MDLCK:
> > > +        rz =3D s->regs.mdlck;
> > > +        break;
> > > +    case A_MDLCKH:
> > > +        rz =3D s->regs.mdlckh;
> > > +        break;
> > > +    case A_MDCFGLCK:
> > > +        rz =3D s->regs.mdcfglck;
> > > +        break;
> > > +    case A_ENTRYLCK:
> > > +        rz =3D s->regs.entrylck;
> > > +        break;
> > > +    case A_ERR_REQADDR:
> > > +        rz =3D s->regs.err_reqaddr & UINT32_MAX;
> > > +        break;
> > > +    case A_ERR_REQADDRH:
> > > +        rz =3D s->regs.err_reqaddr >> 32;
> > > +        break;
> > > +    case A_ERR_REQID:
> > > +        rz =3D s->regs.err_reqid;
> > > +        break;
> > > +    case A_ERR_REQINFO:
> > > +        rz =3D s->regs.err_reqinfo;
> > > +        break;
> > > +
> > > +    default:
> > > +        if (addr >=3D A_MDCFG0 &&
> > > +            addr < A_MDCFG0 + 4 * (s->md_num - 1)) {
> > > +            offset =3D addr - A_MDCFG0;
> > > +            idx =3D offset >> 2;
> > > +            if (idx =3D=3D 0 && offset =3D=3D 0) {
> > > +                rz =3D s->regs.mdcfg[idx];
> > > +            } else {
> > > +                /* Only MDCFG0 is implemented in rapid-k model */
> > > +                qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\n",
> > > +                                __func__, (int)addr);
> > > +            }
> > > +        } else if (addr >=3D A_SRCMD_EN0 &&
> > > +                   addr < A_SRCMD_WH0 + 32 * (s->rrid_num - 1)) {
> > > +            offset =3D addr - A_SRCMD_EN0;
> > > +            idx =3D offset >> 5;
> > > +            offset &=3D 0x1f;
> > > +
> > > +            switch (offset) {
> > > +            case SRCMD_EN_OFFSET:
> > > +                rz =3D s->regs.srcmd_en[idx];
> > > +                break;
> > > +            case SRCMD_ENH_OFFSET:
> > > +                rz =3D s->regs.srcmd_enh[idx];
> > > +                break;
> > > +            default:
> > > +                qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\n",
> > > +                    __func__, (int)addr);
> > > +                break;
> > > +            }
> > > +        } else if (addr >=3D s->entry_offset &&
> > > +                   addr < s->entry_offset + ENTRY_USER_CFG_OFFSET +
> > > +                          16 * (s->entry_num - 1)) {
> > > +            offset =3D addr - s->entry_offset;
> > > +            idx =3D offset >> 4;
> > > +            offset &=3D 0xf;
> > > +
> > > +            switch (offset) {
> > > +            case ENTRY_ADDR_OFFSET:
> > > +                rz =3D s->regs.entry[idx].addr_reg;
> > > +                break;
> > > +            case ENTRY_ADDRH_OFFSET:
> > > +                rz =3D s->regs.entry[idx].addrh_reg;
> > > +                break;
> > > +            case ENTRY_CFG_OFFSET:
> > > +                rz =3D s->regs.entry[idx].cfg_reg;
> > > +                break;
> > > +            case ENTRY_USER_CFG_OFFSET:
> > > +                /* Does not support user customized permission */
> > > +                rz =3D 0;
> > > +                break;
> > > +            default:
> > > +                qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\n",
> > > +                    __func__, (int)addr);
> > > +                break;
> > > +            }
> > > +        } else {
> > > +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\n",
> > > +                            __func__, (int)addr);
> > > +        }
> > > +        break;
> > > +    }
> > > +    trace_iopmp_read(addr, rz);
> > > +    return rz;
> > > +}
> > > +
> > > +static void
> > > +iopmp_write(void *opaque, hwaddr addr, uint64_t value, unsigned size=
)
> > > +{
> > > +    IopmpState *s =3D IOPMP(opaque);
> > > +    uint32_t offset, idx;
> > > +    uint32_t value32 =3D value;
> > > +
> > > +    trace_iopmp_write(addr, value32);
> > > +
> > > +    switch (addr) {
> > > +    case A_VERSION: /* RO */
> > > +        break;
> > > +    case A_IMP: /* RO */
> > > +        break;
> > > +    case A_HWCFG0:
> > > +        if (FIELD_EX32(value32, HWCFG0, PRIENT_PROG)) {
> > > +            /* W1C */
> > > +            s->prient_prog =3D 0;
> > > +        }
> > > +        if (FIELD_EX32(value32, HWCFG0, ENABLE)) {
> > > +            /* W1S */
> > > +            s->enable =3D 1;
> > > +            iopmp_iommu_notify(s);
> > > +        }
> > > +        break;
> > > +    case A_HWCFG1: /* RO */
> > > +        break;
> > > +    case A_HWCFG2:
> > > +        if (s->prient_prog) {
> > > +            s->prio_entry =3D FIELD_EX32(value32, HWCFG2, PRIO_ENTRY=
);
> > > +        }
> > > +        break;
> > > +    case A_ERR_CFG:
> > > +        if (!FIELD_EX32(s->regs.err_cfg, ERR_CFG, L)) {
> > > +            s->regs.err_cfg =3D FIELD_DP32(s->regs.err_cfg, ERR_CFG,=
 L,
> > > +                FIELD_EX32(value32, ERR_CFG, L));
> > > +            s->regs.err_cfg =3D FIELD_DP32(s->regs.err_cfg, ERR_CFG,=
 IE,
> > > +                FIELD_EX32(value32, ERR_CFG, IE));
> > > +            s->regs.err_cfg =3D FIELD_DP32(s->regs.err_cfg, ERR_CFG,=
 IRE,
> > > +                FIELD_EX32(value32, ERR_CFG, IRE));
> > > +            s->regs.err_cfg =3D FIELD_DP32(s->regs.err_cfg, ERR_CFG,=
 RRE,
> > > +                FIELD_EX32(value32, ERR_CFG, RRE));
> > > +            s->regs.err_cfg =3D FIELD_DP32(s->regs.err_cfg, ERR_CFG,=
 IWE,
> > > +                FIELD_EX32(value32, ERR_CFG, IWE));
> > > +            s->regs.err_cfg =3D FIELD_DP32(s->regs.err_cfg, ERR_CFG,=
 RWE,
> > > +                FIELD_EX32(value32, ERR_CFG, RWE));
> > > +            s->regs.err_cfg =3D FIELD_DP32(s->regs.err_cfg, ERR_CFG,=
 IXE,
> > > +                FIELD_EX32(value32, ERR_CFG, IXE));
> > > +            s->regs.err_cfg =3D FIELD_DP32(s->regs.err_cfg, ERR_CFG,=
 RXE,
> > > +                FIELD_EX32(value32, ERR_CFG, RXE));
> > > +        }
> > > +        break;
> > > +    case A_MDLCK:
> > > +        if (!FIELD_EX32(s->regs.mdlck, MDLCK, L)) {
> > > +            s->regs.mdlck =3D value32;
> > > +        }
> > > +        break;
> > > +    case A_MDLCKH:
> > > +        if (!FIELD_EX32(s->regs.mdlck, MDLCK, L)) {
> > > +            s->regs.mdlckh =3D value32;
> > > +        }
> > > +        break;
> > > +    case A_MDCFGLCK:
> > > +        if (!FIELD_EX32(s->regs.mdcfglck, MDCFGLCK, L)) {
> > > +            s->regs.mdcfglck =3D FIELD_DP32(s->regs.mdcfglck, MDCFGL=
CK, F,
> > > +                                          FIELD_EX32(value32, MDCFGL=
CK, F));
> > > +            s->regs.mdcfglck =3D FIELD_DP32(s->regs.mdcfglck, MDCFGL=
CK, L,
> > > +                                          FIELD_EX32(value32, MDCFGL=
CK, L));
> > > +        }
> > > +        break;
> > > +    case A_ENTRYLCK:
> > > +        if (!(FIELD_EX32(s->regs.entrylck, ENTRYLCK, L))) {
> > > +            s->regs.entrylck =3D FIELD_DP32(s->regs.entrylck, ENTRYL=
CK, F,
> > > +                                          FIELD_EX32(value32, ENTRYL=
CK, F));
> > > +            s->regs.entrylck =3D FIELD_DP32(s->regs.entrylck, ENTRYL=
CK, L,
> > > +                                          FIELD_EX32(value32, ENTRYL=
CK, L));
> > > +        }
> > > +    case A_ERR_REQADDR: /* RO */
> > > +        break;
> > > +    case A_ERR_REQADDRH: /* RO */
> > > +        break;
> > > +    case A_ERR_REQID: /* RO */
> > > +        break;
> > > +    case A_ERR_REQINFO:
> > > +        if (FIELD_EX32(value32, ERR_REQINFO, V)) {
> > > +            s->regs.err_reqinfo =3D FIELD_DP32(s->regs.err_reqinfo,
> > > +                                             ERR_REQINFO, V, 0);
> > > +            qemu_set_irq(s->irq, 0);
> > > +        }
> > > +        break;
> > > +
> > > +    default:
> > > +        if (addr >=3D A_MDCFG0 &&
> > > +            addr < A_MDCFG0 + 4 * (s->md_num - 1)) {
> > > +            offset =3D addr - A_MDCFG0;
> > > +            idx =3D offset >> 2;
> > > +            /* RO in rapid-k model */
> > > +            if (idx > 0) {
> > > +                qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\n",
> > > +                              __func__, (int)addr);
> > > +            }
> > > +        } else if (addr >=3D A_SRCMD_EN0 &&
> > > +                   addr < A_SRCMD_WH0 + 32 * (s->rrid_num - 1)) {
> > > +            offset =3D addr - A_SRCMD_EN0;
> > > +            idx =3D offset >> 5;
> > > +            offset &=3D 0x1f;
> > > +
> > > +            if (offset % 4) {
> > > +                qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\n",
> > > +                              __func__, (int)addr);
> > > +            } else if (FIELD_EX32(s->regs.srcmd_en[idx], SRCMD_EN0, =
L)
> > > +                        =3D=3D 0) {
> > > +                switch (offset) {
> > > +                case SRCMD_EN_OFFSET:
> > > +                    s->regs.srcmd_en[idx] =3D
> > > +                        FIELD_DP32(s->regs.srcmd_en[idx], SRCMD_EN0,=
 L,
> > > +                                   FIELD_EX32(value32, SRCMD_EN0, L)=
);
> > > +
> > > +                    /* MD field is protected by mdlck */
> > > +                    value32 =3D (value32 & ~s->regs.mdlck) |
> > > +                              (s->regs.srcmd_en[idx] & s->regs.mdlck=
);
> > > +                    s->regs.srcmd_en[idx] =3D
> > > +                        FIELD_DP32(s->regs.srcmd_en[idx], SRCMD_EN0,=
 MD,
> > > +                                   FIELD_EX32(value32, SRCMD_EN0, MD=
));
> > > +                    break;
> > > +                case SRCMD_ENH_OFFSET:
> > > +                    value32 =3D (value32 & ~s->regs.mdlckh) |
> > > +                              (s->regs.srcmd_enh[idx] & s->regs.mdlc=
kh);
> > > +                    s->regs.srcmd_enh[idx] =3D
> > > +                        FIELD_DP32(s->regs.srcmd_enh[idx], SRCMD_ENH=
0, MDH,
> > > +                                   value32);
> > > +                    break;
> > > +                default:
> > > +                    break;
> > > +                }
> > > +            }
> > > +        } else if (addr >=3D s->entry_offset &&
> > > +                   addr < s->entry_offset + ENTRY_USER_CFG_OFFSET
> > > +                          + 16 * (s->entry_num - 1)) {
> > > +            offset =3D addr - s->entry_offset;
> > > +            idx =3D offset >> 4;
> > > +            offset &=3D 0xf;
> > > +
> > > +            /* index < ENTRYLCK_F is protected */
> > > +            if (idx >=3D FIELD_EX32(s->regs.entrylck, ENTRYLCK, F)) =
{
> > > +                switch (offset) {
> > > +                case ENTRY_ADDR_OFFSET:
> > > +                    s->regs.entry[idx].addr_reg =3D value32;
> > > +                    break;
> > > +                case ENTRY_ADDRH_OFFSET:
> > > +                    s->regs.entry[idx].addrh_reg =3D value32;
> > > +                    break;
> > > +                case ENTRY_CFG_OFFSET:
> > > +                    s->regs.entry[idx].cfg_reg =3D value32;
> > > +                    break;
> > > +                case ENTRY_USER_CFG_OFFSET:
> > > +                    /* Does not support user customized permission *=
/
> > > +                    break;
> > > +                default:
> > > +                    qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\=
n",
> > > +                                  __func__, (int)addr);
> > > +                    break;
> > > +                }
> > > +                iopmp_update_rule(s, idx);
> > > +                if (idx + 1 < s->entry_num &&
> > > +                    FIELD_EX32(s->regs.entry[idx + 1].cfg_reg, ENTRY=
_CFG, A) =3D=3D
> > > +                    IOPMP_AMATCH_TOR) {
> > > +                        iopmp_update_rule(s, idx + 1);
> > > +                }
> > > +            }
> > > +        } else {
> > > +            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad addr %x\n", __fu=
nc__,
> > > +                          (int)addr);
> > > +        }
> > > +    }
> > > +}
> > > +
> > > +/* Match entry in memory domain */
> > > +static int match_entry_md(IopmpState *s, int md_idx, hwaddr start_ad=
dr,
> > > +                          hwaddr end_addr, int *entry_idx,
> > > +                          int *prior_entry_in_tlb)
> > > +{
> > > +    int entry_idx_s, entry_idx_e;
> > > +    int result =3D ENTRY_NO_HIT;
> > > +    int i =3D 0;
> > > +    hwaddr tlb_sa =3D start_addr & ~(TARGET_PAGE_SIZE - 1);
> > > +    hwaddr tlb_ea =3D tlb_sa + TARGET_PAGE_SIZE - 1;
> > > +
> > > +    entry_idx_s =3D md_idx * s->regs.mdcfg[0];
> > > +    entry_idx_e =3D (md_idx + 1) * s->regs.mdcfg[0];
> > > +
> > > +    if (entry_idx_s >=3D s->entry_num) {
> > > +        return result;
> > > +    }
> > > +    if (entry_idx_e > s->entry_num) {
> > > +        entry_idx_e =3D s->entry_num;
> > > +    }
> > > +    i =3D entry_idx_s;
> > > +    for (i =3D entry_idx_s; i < entry_idx_e; i++) {
> > > +        if (FIELD_EX32(s->regs.entry[i].cfg_reg, ENTRY_CFG, A) =3D=
=3D
> > > +            IOPMP_AMATCH_OFF) {
> > > +            continue;
> > > +        }
> > > +        if (start_addr >=3D s->entry_addr[i].sa &&
> > > +            start_addr <=3D s->entry_addr[i].ea) {
> > > +            /* Check end address */
> > > +            if (end_addr >=3D s->entry_addr[i].sa &&
> > > +                end_addr <=3D s->entry_addr[i].ea) {
> > > +                *entry_idx =3D i;
> > > +                return ENTRY_HIT;
> > > +            } else if (i >=3D s->prio_entry) {
> > > +                /* Continue for non-prio_entry */
> > > +                continue;
> > > +            } else {
> > > +                *entry_idx =3D i;
> > > +                return ENTRY_PAR_HIT;
> > > +            }
> > > +        } else if (end_addr >=3D s->entry_addr[i].sa &&
> > > +                   end_addr <=3D s->entry_addr[i].ea) {
> > > +            /* Only end address matches the entry */
> > > +            if (i >=3D s->prio_entry) {
> > > +                continue;
> > > +            } else {
> > > +                *entry_idx =3D i;
> > > +                return ENTRY_PAR_HIT;
> > > +            }
> > > +        } else if (start_addr < s->entry_addr[i].sa &&
> > > +                   end_addr > s->entry_addr[i].ea) {
> > > +            if (i >=3D s->prio_entry) {
> > > +                continue;
> > > +            } else {
> > > +                *entry_idx =3D i;
> > > +                return ENTRY_PAR_HIT;
> > > +            }
> > > +        }
> > > +        if (prior_entry_in_tlb !=3D NULL) {
> > > +            if ((s->entry_addr[i].sa >=3D tlb_sa &&
> > > +                 s->entry_addr[i].sa <=3D tlb_ea) ||
> > > +                (s->entry_addr[i].ea >=3D tlb_sa &&
> > > +                 s->entry_addr[i].ea <=3D tlb_ea)) {
> > > +                /*
> > > +                 * TLB should not use the cached result when the tlb=
 contains
> > > +                 * higher priority entry
> > > +                 */
> > > +                *prior_entry_in_tlb =3D 1;
> > > +            }
> > > +        }
> > > +    }
> > > +    return result;
> > > +}
> > > +
> > > +static int match_entry(IopmpState *s, int rrid, hwaddr start_addr,
> > > +                       hwaddr end_addr, int *match_md_idx,
> > > +                       int *match_entry_idx, int *prior_entry_in_tlb=
)
> > > +{
> > > +    int cur_result =3D ENTRY_NO_HIT;
> > > +    int result =3D ENTRY_NO_HIT;
> > > +    /* Remove lock bit */
> > > +    uint64_t srcmd_en =3D ((uint64_t)s->regs.srcmd_en[rrid] |
> > > +                         ((uint64_t)s->regs.srcmd_enh[rrid] << 32)) =
>> 1;
> > > +
> > > +    for (int md_idx =3D 0; md_idx < s->md_num; md_idx++) {
> > > +        if (srcmd_en & (1ULL << md_idx)) {
> > > +            cur_result =3D match_entry_md(s, md_idx, start_addr, end=
_addr,
> > > +                                        match_entry_idx, prior_entry=
_in_tlb);
> > > +            if (cur_result =3D=3D ENTRY_HIT || cur_result =3D=3D ENT=
RY_PAR_HIT) {
> > > +                *match_md_idx =3D md_idx;
> > > +                return cur_result;
> > > +            }
> > > +        }
> > > +    }
> > > +    return result;
> > > +}
> > > +
> > > +static void iopmp_error_reaction(IopmpState *s, uint32_t id, hwaddr =
start,
> > > +                                 uint32_t info)
> > > +{
> > > +    if (!FIELD_EX32(s->regs.err_reqinfo, ERR_REQINFO, V)) {
> > > +        s->regs.err_reqinfo =3D info;
> > > +        s->regs.err_reqinfo =3D FIELD_DP32(s->regs.err_reqinfo, ERR_=
REQINFO, V,
> > > +                                         1);
> > > +        s->regs.err_reqid =3D id;
> > > +        /* addr[LEN+2:2] */
> > > +        s->regs.err_reqaddr =3D start >> 2;
> > > +
> > > +        if (FIELD_EX32(info, ERR_REQINFO, TTYPE) =3D=3D ERR_REQINFO_=
TTYPE_READ &&
> > > +            FIELD_EX32(s->regs.err_cfg, ERR_CFG, IE) &&
> > > +            FIELD_EX32(s->regs.err_cfg, ERR_CFG, IRE)) {
> > > +            qemu_set_irq(s->irq, 1);
> > > +        }
> > > +        if (FIELD_EX32(info, ERR_REQINFO, TTYPE) =3D=3D ERR_REQINFO_=
TTYPE_WRITE &&
> > > +            FIELD_EX32(s->regs.err_cfg, ERR_CFG, IE) &&
> > > +            FIELD_EX32(s->regs.err_cfg, ERR_CFG, IWE)) {
> > > +            qemu_set_irq(s->irq, 1);
> > > +        }
> > > +        if (FIELD_EX32(info, ERR_REQINFO, TTYPE) =3D=3D ERR_REQINFO_=
TTYPE_FETCH &&
> > > +            FIELD_EX32(s->regs.err_cfg, ERR_CFG, IE) &&
> > > +            FIELD_EX32(s->regs.err_cfg, ERR_CFG, IXE)) {
> > > +            qemu_set_irq(s->irq, 1);
> > > +        }
> > > +    }
> > > +}
> > > +
> > > +static IOMMUTLBEntry iopmp_translate(IOMMUMemoryRegion *iommu, hwadd=
r addr,
> > > +                                     IOMMUAccessFlags flags, int iom=
mu_idx)
> > > +{
> > > +    int rrid =3D iommu_idx;
> > > +    IopmpState *s =3D IOPMP(container_of(iommu, IopmpState, iommu));
> > > +    hwaddr start_addr, end_addr;
> > > +    int entry_idx =3D -1;
> > > +    int md_idx =3D -1;
> > > +    int result;
> > > +    uint32_t error_info =3D 0;
> > > +    uint32_t error_id =3D 0;
> > > +    int prior_entry_in_tlb =3D 0;
> > > +    iopmp_permission iopmp_perm;
> > > +    IOMMUTLBEntry entry =3D {
> > > +        .target_as =3D &s->downstream_as,
> > > +        .iova =3D addr,
> > > +        .translated_addr =3D addr,
> > > +        .addr_mask =3D 0,
> > > +        .perm =3D IOMMU_NONE,
> > > +    };
> > > +
> > > +    if (!s->enable) {
> > > +        /* Bypass IOPMP */
> > > +        entry.addr_mask =3D -1ULL,
> > > +        entry.perm =3D IOMMU_RW;
> > > +        return entry;
> > > +    }
> > > +
> > > +    /* unknown RRID */
> > > +    if (rrid >=3D s->rrid_num) {
> > > +        error_id =3D FIELD_DP32(error_id, ERR_REQID, RRID, rrid);
> > > +        error_info =3D FIELD_DP32(error_info, ERR_REQINFO, ETYPE,
> > > +                                ERR_REQINFO_ETYPE_RRID);
> > > +        error_info =3D FIELD_DP32(error_info, ERR_REQINFO, TTYPE, fl=
ags);
> > > +        iopmp_error_reaction(s, error_id, addr, error_info);
> > > +        entry.target_as =3D &s->blocked_rwx_as;
> > > +        entry.perm =3D IOMMU_RW;
> > > +        return entry;
> > > +    }
> > > +
> > > +    if (s->transaction_state[rrid].supported =3D=3D true) {
> > > +        start_addr =3D s->transaction_state[rrid].start_addr;
> > > +        end_addr =3D s->transaction_state[rrid].end_addr;
> > > +    } else {
> > > +        /* No transaction information, use the same address */
> > > +        start_addr =3D addr;
> > > +        end_addr =3D addr;
> > > +    }
> > > +
> > > +    result =3D match_entry(s, rrid, start_addr, end_addr, &md_idx, &=
entry_idx,
> > > +                         &prior_entry_in_tlb);
> > > +    if (result =3D=3D ENTRY_HIT) {
> > > +        entry.addr_mask =3D s->entry_addr[entry_idx].ea -
> > > +                          s->entry_addr[entry_idx].sa;
> > > +        if (prior_entry_in_tlb) {
> > > +            /* Make TLB repeat iommu translation on every access */
> >
> > I don't follow this, if we have a prior entry in the TLB cache we
> > don't cache the accesses?
>
> For the cached TLB result to be used, the highest-priority entry in the T=
LB must
> occupy the entire TLB page. If a lower-priority entry fills the entire TL=
B page,
> it is still necessary to check which entry the transaction hits on each a=
ccess
> to the TLB page.

Oh! When you say "prior" you mean priority, not prior. That is a
little confusing.

Maybe just write `priority_entry_in_tlb` to be clear. Also I think
it's worth including you entire response in the code comment

Alistair

>
> >
> > > +            entry.addr_mask =3D 0;
> > > +        }
> > > +        iopmp_perm =3D s->regs.entry[entry_idx].cfg_reg & IOPMP_RWX;
> > > +        if (flags) {
> > > +            if ((iopmp_perm & flags) =3D=3D 0) {
> > > +                /* Permission denied */
> > > +                error_id =3D FIELD_DP32(error_id, ERR_REQID, EID, en=
try_idx);
> > > +                error_id =3D FIELD_DP32(error_id, ERR_REQID, RRID, r=
rid);
> > > +                error_info =3D FIELD_DP32(error_info, ERR_REQINFO, E=
TYPE,
> > > +                                        ERR_REQINFO_ETYPE_READ + fla=
gs - 1);
> > > +                error_info =3D FIELD_DP32(error_info, ERR_REQINFO, T=
TYPE, flags);
> > > +                iopmp_error_reaction(s, error_id, start_addr, error_=
info);
> > > +                entry.target_as =3D &s->blocked_rwx_as;
> > > +                entry.perm =3D IOMMU_RW;
> > > +            } else {
> > > +                entry.target_as =3D &s->downstream_as;
> > > +                entry.perm =3D iopmp_perm;
> > > +            }
> > > +        } else {
> > > +            /* CPU access with IOMMU_NONE flag */
> > > +            if (iopmp_perm & IOPMP_XO) {
> > > +                if ((iopmp_perm & IOPMP_RW) =3D=3D IOPMP_RW) {
> > > +                    entry.target_as =3D &s->downstream_as;
> > > +                } else if ((iopmp_perm & IOPMP_RW) =3D=3D IOPMP_RO) =
{
> > > +                    entry.target_as =3D &s->blocked_w_as;
> > > +                } else if ((iopmp_perm & IOPMP_RW) =3D=3D IOPMP_WO) =
{
> > > +                    entry.target_as =3D &s->blocked_r_as;
> > > +                } else {
> > > +                    entry.target_as =3D &s->blocked_rw_as;
> > > +                }
> > > +            } else {
> > > +                if ((iopmp_perm & IOPMP_RW) =3D=3D IOMMU_RW) {
> > > +                    entry.target_as =3D &s->blocked_x_as;
> > > +                } else if ((iopmp_perm & IOPMP_RW) =3D=3D IOPMP_RO) =
{
> > > +                    entry.target_as =3D &s->blocked_wx_as;
> > > +                } else if ((iopmp_perm & IOPMP_RW) =3D=3D IOPMP_WO) =
{
> > > +                    entry.target_as =3D &s->blocked_rx_as;
> > > +                } else {
> > > +                    entry.target_as =3D &s->blocked_rwx_as;
> > > +                }
> > > +            }
> > > +            entry.perm =3D IOMMU_RW;
> > > +        }
> > > +    } else {
> > > +        if (flags) {
> > > +            if (result =3D=3D ENTRY_PAR_HIT) {
> > > +                error_id =3D FIELD_DP32(error_id, ERR_REQID, EID, en=
try_idx);
> > > +                error_id =3D FIELD_DP32(error_id, ERR_REQID, RRID, r=
rid);
> > > +                error_info =3D FIELD_DP32(error_info, ERR_REQINFO, E=
TYPE,
> > > +                                        ERR_REQINFO_ETYPE_PARHIT);
> > > +                error_info =3D FIELD_DP32(error_info, ERR_REQINFO, T=
TYPE, flags);
> > > +                iopmp_error_reaction(s, error_id, start_addr, error_=
info);
> > > +            } else {
> > > +                error_id =3D FIELD_DP32(error_id, ERR_REQID, RRID, r=
rid);
> > > +                error_info =3D FIELD_DP32(error_info, ERR_REQINFO, E=
TYPE,
> > > +                                        ERR_REQINFO_ETYPE_NOHIT);
> > > +                error_info =3D FIELD_DP32(error_info, ERR_REQINFO, T=
TYPE, flags);
> > > +                iopmp_error_reaction(s, error_id, start_addr, error_=
info);
> > > +            }
> > > +        }
> > > +        /* CPU access with IOMMU_NONE flag no_hit or par_hit */
> > > +        entry.target_as =3D &s->blocked_rwx_as;
> > > +        entry.perm =3D IOMMU_RW;
> > > +    }
> > > +    return entry;
> > > +}
> > > +
> > > +static const MemoryRegionOps iopmp_ops =3D {
> > > +    .read =3D iopmp_read,
> > > +    .write =3D iopmp_write,
> > > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> > > +    .valid =3D {.min_access_size =3D 4, .max_access_size =3D 4}
> > > +};
> > > +
> > > +static MemTxResult iopmp_permssion_write(void *opaque, hwaddr addr,
> > > +                                         uint64_t value, unsigned si=
ze,
> > > +                                         MemTxAttrs attrs)
> > > +{
> > > +    IopmpState *s =3D IOPMP(opaque);
> > > +    return address_space_write(&s->downstream_as, addr, attrs, &valu=
e, size);
> > > +}
> > > +
> > > +static MemTxResult iopmp_permssion_read(void *opaque, hwaddr addr,
> > > +                                        uint64_t *pdata, unsigned si=
ze,
> > > +                                        MemTxAttrs attrs)
> > > +{
> > > +    IopmpState *s =3D IOPMP(opaque);
> > > +    return address_space_read(&s->downstream_as, addr, attrs, pdata,=
 size);
> > > +}
> > > +
> > > +static MemTxResult iopmp_handle_block(void *opaque, hwaddr addr,
> > > +                                      uint64_t *data, unsigned size,
> > > +                                      MemTxAttrs attrs,
> > > +                                      iopmp_access_type access_type)=
 {
> > > +    IopmpState *s =3D IOPMP(opaque);
> > > +    int md_idx, entry_idx;
> > > +    uint32_t error_info =3D 0;
> > > +    uint32_t error_id =3D 0;
> > > +    int rrid =3D attrs.requester_id;
> > > +    int result;
> > > +    hwaddr start_addr, end_addr;
> > > +    start_addr =3D addr;
> > > +    end_addr =3D addr;
> > > +    result =3D match_entry(s, rrid, start_addr, end_addr, &md_idx, &=
entry_idx,
> > > +                         NULL);
> > > +
> > > +    if (result =3D=3D ENTRY_HIT) {
> > > +        error_id =3D FIELD_DP32(error_id, ERR_REQID, EID, entry_idx)=
;
> > > +        error_id =3D FIELD_DP32(error_id, ERR_REQID, RRID, rrid);
> > > +        error_info =3D FIELD_DP32(error_info, ERR_REQINFO, ETYPE,
> > > +                                access_type);
> > > +        error_info =3D FIELD_DP32(error_info, ERR_REQINFO, TTYPE, ac=
cess_type);
> > > +        iopmp_error_reaction(s, error_id, start_addr, error_info);
> > > +    } else if (result =3D=3D ENTRY_PAR_HIT) {
> > > +        error_id =3D FIELD_DP32(error_id, ERR_REQID, EID, entry_idx)=
;
> > > +        error_id =3D FIELD_DP32(error_id, ERR_REQID, RRID, rrid);
> > > +        error_info =3D FIELD_DP32(error_info, ERR_REQINFO, ETYPE,
> > > +                                ERR_REQINFO_ETYPE_PARHIT);
> > > +        error_info =3D FIELD_DP32(error_info, ERR_REQINFO, TTYPE,
> > > +                                access_type);
> > > +        iopmp_error_reaction(s, error_id, start_addr, error_info);
> > > +    } else {
> > > +        error_id =3D FIELD_DP32(error_id, ERR_REQID, RRID, rrid);
> > > +        error_info =3D FIELD_DP32(error_info, ERR_REQINFO, ETYPE,
> > > +                                ERR_REQINFO_ETYPE_NOHIT);
> > > +        error_info =3D FIELD_DP32(error_info, ERR_REQINFO, TTYPE, ac=
cess_type);
> > > +        iopmp_error_reaction(s, error_id, start_addr, error_info);
> > > +    }
> > > +
> > > +    if (access_type =3D=3D IOPMP_ACCESS_READ) {
> > > +
> > > +        switch (FIELD_EX32(s->regs.err_cfg, ERR_CFG, RRE)) {
> > > +        case RRE_ERROR:
> > > +            return MEMTX_ERROR;
> > > +            break;
> > > +        case RRE_SUCCESS_VALUE:
> > > +            *data =3D s->fabricated_v;
> > > +            return MEMTX_OK;
> > > +            break;
> > > +        default:
> > > +            break;
> > > +        }
> > > +        return MEMTX_OK;
> > > +    } else if (access_type =3D=3D IOPMP_ACCESS_WRITE) {
> > > +
> > > +        switch (FIELD_EX32(s->regs.err_cfg, ERR_CFG, RWE)) {
> > > +        case RWE_ERROR:
> > > +            return MEMTX_ERROR;
> > > +            break;
> > > +        case RWE_SUCCESS:
> > > +            return MEMTX_OK;
> > > +            break;
> > > +        default:
> > > +            break;
> > > +        }
> > > +        return MEMTX_OK;
> > > +    } else {
> > > +
> > > +        switch (FIELD_EX32(s->regs.err_cfg, ERR_CFG, RXE)) {
> > > +        case RXE_ERROR:
> > > +            return MEMTX_ERROR;
> > > +            break;
> > > +        case RXE_SUCCESS_VALUE:
> > > +            *data =3D s->fabricated_v;
> > > +            return MEMTX_OK;
> > > +            break;
> > > +        default:
> > > +            break;
> > > +        }
> > > +        return MEMTX_OK;
> > > +    }
> > > +    return MEMTX_OK;
> > > +}
> > > +
> > > +static MemTxResult iopmp_block_write(void *opaque, hwaddr addr, uint=
64_t value,
> > > +                                     unsigned size, MemTxAttrs attrs=
)
> > > +{
> > > +    return iopmp_handle_block(opaque, addr, &value, size, attrs,
> > > +                              IOPMP_ACCESS_WRITE);
> > > +}
> > > +
> > > +static MemTxResult iopmp_block_read(void *opaque, hwaddr addr, uint6=
4_t *pdata,
> > > +                                    unsigned size, MemTxAttrs attrs)
> > > +{
> > > +    return iopmp_handle_block(opaque, addr, pdata, size, attrs,
> > > +                              IOPMP_ACCESS_READ);
> > > +}
> > > +
> > > +static MemTxResult iopmp_block_fetch(void *opaque, hwaddr addr, uint=
64_t *pdata,
> > > +                                    unsigned size, MemTxAttrs attrs)
> > > +{
> > > +    return iopmp_handle_block(opaque, addr, pdata, size, attrs,
> > > +                              IOPMP_ACCESS_FETCH);
> > > +}
> > > +
> > > +static const MemoryRegionOps iopmp_block_rw_ops =3D {
> > > +    .fetch_with_attrs =3D iopmp_permssion_read,
> > > +    .read_with_attrs =3D iopmp_block_read,
> > > +    .write_with_attrs =3D iopmp_block_write,
> > > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> > > +    .valid =3D {.min_access_size =3D 1, .max_access_size =3D 8},
> > > +};
> > > +
> > > +static const MemoryRegionOps iopmp_block_w_ops =3D {
> > > +    .fetch_with_attrs =3D iopmp_permssion_read,
> > > +    .read_with_attrs =3D iopmp_permssion_read,
> > > +    .write_with_attrs =3D iopmp_block_write,
> > > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> > > +    .valid =3D {.min_access_size =3D 1, .max_access_size =3D 8},
> > > +};
> > > +
> > > +static const MemoryRegionOps iopmp_block_r_ops =3D {
> > > +    .fetch_with_attrs =3D iopmp_permssion_read,
> > > +    .read_with_attrs =3D iopmp_block_read,
> > > +    .write_with_attrs =3D iopmp_permssion_write,
> > > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> > > +    .valid =3D {.min_access_size =3D 1, .max_access_size =3D 8},
> > > +};
> > > +
> > > +static const MemoryRegionOps iopmp_block_rwx_ops =3D {
> > > +    .fetch_with_attrs =3D iopmp_block_fetch,
> > > +    .read_with_attrs =3D iopmp_block_read,
> > > +    .write_with_attrs =3D iopmp_block_write,
> > > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> > > +    .valid =3D {.min_access_size =3D 1, .max_access_size =3D 8},
> > > +};
> > > +
> > > +static const MemoryRegionOps iopmp_block_wx_ops =3D {
> > > +    .fetch_with_attrs =3D iopmp_block_fetch,
> > > +    .read_with_attrs =3D iopmp_permssion_read,
> > > +    .write_with_attrs =3D iopmp_block_write,
> > > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> > > +    .valid =3D {.min_access_size =3D 1, .max_access_size =3D 8},
> > > +};
> > > +
> > > +static const MemoryRegionOps iopmp_block_rx_ops =3D {
> > > +    .fetch_with_attrs =3D iopmp_block_fetch,
> > > +    .read_with_attrs =3D iopmp_block_read,
> > > +    .write_with_attrs =3D iopmp_permssion_write,
> > > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> > > +    .valid =3D {.min_access_size =3D 1, .max_access_size =3D 8},
> > > +};
> > > +
> > > +static const MemoryRegionOps iopmp_block_x_ops =3D {
> > > +    .fetch_with_attrs =3D iopmp_block_fetch,
> > > +    .read_with_attrs =3D iopmp_permssion_read,
> > > +    .write_with_attrs =3D iopmp_permssion_write,
> > > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> > > +    .valid =3D {.min_access_size =3D 1, .max_access_size =3D 8},
> > > +};
> > > +
> > > +static void iopmp_realize(DeviceState *dev, Error **errp)
> > > +{
> > > +    Object *obj =3D OBJECT(dev);
> > > +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> > > +    IopmpState *s =3D IOPMP(dev);
> > > +    uint64_t size;
> > > +
> > > +    size =3D -1ULL;
> > > +    s->model =3D IOPMP_MODEL_RAPIDK;
> >
> > Should this be a property to allow other models in the future?
>
> Yes, it will be refined in next revision.
>
> >
> > > +    s->regs.mdcfglck =3D FIELD_DP32(s->regs.mdcfglck, MDCFGLCK, F, s=
->md_num);
> > > +    s->regs.mdcfglck =3D FIELD_DP32(s->regs.mdcfglck, MDCFGLCK, L, 1=
);
> > > +
> > > +    s->prient_prog =3D s->default_prient_prog;
> > > +    s->rrid_num =3D MIN(s->rrid_num, IOPMP_MAX_RRID_NUM);
> > > +    s->md_num =3D MIN(s->md_num, IOPMP_MAX_MD_NUM);
> > > +    s->entry_num =3D s->md_num * s->k;
> > > +    s->prio_entry =3D MIN(s->prio_entry, s->entry_num);
> > > +
> > > +    s->regs.mdcfg =3D g_malloc0(s->md_num * sizeof(uint32_t));
> > > +    s->regs.mdcfg[0] =3D s->k;
> > > +
> > > +    s->regs.srcmd_en =3D g_malloc0(s->rrid_num * sizeof(uint32_t));
> > > +    s->regs.srcmd_enh =3D g_malloc0(s->rrid_num * sizeof(uint32_t));
> > > +    s->regs.entry =3D g_malloc0(s->entry_num * sizeof(iopmp_entry_t)=
);
> > > +    s->entry_addr =3D g_malloc0(s->entry_num * sizeof(iopmp_addr_t))=
;
> > > +    s->transaction_state =3D  g_malloc0(s->rrid_num *
> > > +                                      sizeof(iopmp_transaction_state=
));
> > > +    qemu_mutex_init(&s->iopmp_transaction_mutex);
> > > +
> > > +    memory_region_init_iommu(&s->iommu, sizeof(s->iommu),
> > > +                             TYPE_IOPMP_IOMMU_MEMORY_REGION,
> > > +                             obj, "riscv-iopmp-sysbus-iommu", UINT64=
_MAX);
> > > +    memory_region_init_io(&s->mmio, obj, &iopmp_ops,
> > > +                          s, "iopmp-regs", 0x100000);
> > > +    sysbus_init_mmio(sbd, &s->mmio);
> > > +
> > > +    memory_region_init_io(&s->blocked_rw, NULL, &iopmp_block_rw_ops,
> > > +                          s, "iopmp-blocked-rw", size);
> > > +    memory_region_init_io(&s->blocked_w, NULL, &iopmp_block_w_ops,
> > > +                          s, "iopmp-blocked-w", size);
> > > +    memory_region_init_io(&s->blocked_r, NULL, &iopmp_block_r_ops,
> > > +                          s, "iopmp-blocked-r", size);
> > > +
> > > +    memory_region_init_io(&s->blocked_rwx, NULL, &iopmp_block_rwx_op=
s,
> > > +                          s, "iopmp-blocked-rwx", size);
> > > +    memory_region_init_io(&s->blocked_wx, NULL, &iopmp_block_wx_ops,
> > > +                          s, "iopmp-blocked-wx", size);
> > > +    memory_region_init_io(&s->blocked_rx, NULL, &iopmp_block_rx_ops,
> > > +                          s, "iopmp-blocked-rx", size);
> > > +    memory_region_init_io(&s->blocked_x, NULL, &iopmp_block_x_ops,
> > > +                          s, "iopmp-blocked-x", size);
> > > +    address_space_init(&s->blocked_rw_as, &s->blocked_rw,
> > > +                       "iopmp-blocked-rw-as");
> > > +    address_space_init(&s->blocked_w_as, &s->blocked_w,
> > > +                       "iopmp-blocked-w-as");
> > > +    address_space_init(&s->blocked_r_as, &s->blocked_r,
> > > +                       "iopmp-blocked-r-as");
> > > +
> > > +    address_space_init(&s->blocked_rwx_as, &s->blocked_rwx,
> > > +                       "iopmp-blocked-rwx-as");
> > > +    address_space_init(&s->blocked_wx_as, &s->blocked_wx,
> > > +                       "iopmp-blocked-wx-as");
> > > +    address_space_init(&s->blocked_rx_as, &s->blocked_rx,
> > > +                       "iopmp-blocked-rx-as");
> > > +    address_space_init(&s->blocked_x_as, &s->blocked_x,
> > > +                       "iopmp-blocked-x-as");
> > > +}
> > > +
> > > +static void iopmp_reset(DeviceState *dev)
> > > +{
> > > +    IopmpState *s =3D IOPMP(dev);
> > > +
> > > +    qemu_set_irq(s->irq, 0);
> > > +    memset(s->regs.srcmd_en, 0, s->rrid_num * sizeof(uint32_t));
> > > +    memset(s->regs.srcmd_enh, 0, s->rrid_num * sizeof(uint32_t));
> > > +    memset(s->entry_addr, 0, s->entry_num * sizeof(iopmp_addr_t));
> > > +
> > > +    s->regs.mdlck =3D 0;
> > > +    s->regs.mdlckh =3D 0;
> > > +    s->regs.entrylck =3D 0;
> > > +    s->regs.mdstall =3D 0;
> > > +    s->regs.mdstallh =3D 0;
> > > +    s->regs.rridscp =3D 0;
> > > +    s->regs.err_cfg =3D 0;
> > > +    s->regs.err_reqaddr =3D 0;
> > > +    s->regs.err_reqid =3D 0;
> > > +    s->regs.err_reqinfo =3D 0;
> > > +
> > > +    s->prient_prog =3D s->default_prient_prog;
> > > +    s->enable =3D 0;
> > > +
> > > +    s->regs.mdcfglck =3D FIELD_DP32(s->regs.mdcfglck, MDCFGLCK, F, s=
->md_num);
> > > +    s->regs.mdcfglck =3D FIELD_DP32(s->regs.mdcfglck, MDCFGLCK, L, 1=
);
> > > +    s->regs.mdcfg[0] =3D s->k;
> > > +}
> > > +
> > > +static int iopmp_attrs_to_index(IOMMUMemoryRegion *iommu, MemTxAttrs=
 attrs)
> > > +{
> > > +    return attrs.requester_id;
> > > +}
> > > +
> > > +static void iopmp_iommu_memory_region_class_init(ObjectClass *klass,=
 void *data)
> > > +{
> > > +    IOMMUMemoryRegionClass *imrc =3D IOMMU_MEMORY_REGION_CLASS(klass=
);
> > > +
> > > +    imrc->translate =3D iopmp_translate;
> > > +    imrc->attrs_to_index =3D iopmp_attrs_to_index;
> > > +}
> > > +
> > > +static Property iopmp_property[] =3D {
> > > +    DEFINE_PROP_BOOL("prient_prog", IopmpState, default_prient_prog,=
 true),
> > > +    DEFINE_PROP_UINT32("k", IopmpState, k, 6),
> > > +    DEFINE_PROP_UINT32("prio_entry", IopmpState, prio_entry, 48),
> > > +    DEFINE_PROP_UINT32("rrid_num", IopmpState, rrid_num, 16),
> > > +    DEFINE_PROP_UINT32("md_num", IopmpState, md_num, 8),
> > > +    DEFINE_PROP_UINT32("entry_offset", IopmpState, entry_offset, 0x4=
000),
> > > +    DEFINE_PROP_UINT32("fabricated_v", IopmpState, fabricated_v, 0x0=
),
> > > +    DEFINE_PROP_END_OF_LIST(),
> > > +};
> > > +
> > > +static void iopmp_class_init(ObjectClass *klass, void *data)
> > > +{
> > > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > > +    device_class_set_props(dc, iopmp_property);
> > > +    dc->realize =3D iopmp_realize;
> > > +    dc->reset =3D iopmp_reset;
> > > +}
> > > +
> > > +static void iopmp_init(Object *obj)
> > > +{
> > > +    IopmpState *s =3D IOPMP(obj);
> > > +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> > > +
> > > +    sysbus_init_irq(sbd, &s->irq);
> > > +}
> > > +
> > > +static const TypeInfo iopmp_info =3D {
> > > +    .name =3D TYPE_IOPMP,
> > > +    .parent =3D TYPE_SYS_BUS_DEVICE,
> > > +    .instance_size =3D sizeof(IopmpState),
> > > +    .instance_init =3D iopmp_init,
> > > +    .class_init =3D iopmp_class_init,
> > > +};
> > > +
> > > +static const TypeInfo
> > > +iopmp_iommu_memory_region_info =3D {
> > > +    .name =3D TYPE_IOPMP_IOMMU_MEMORY_REGION,
> > > +    .parent =3D TYPE_IOMMU_MEMORY_REGION,
> > > +    .class_init =3D iopmp_iommu_memory_region_class_init,
> > > +};
> > > +
> > > +static void
> > > +iopmp_register_types(void)
> > > +{
> > > +    type_register_static(&iopmp_info);
> > > +    type_register_static(&iopmp_iommu_memory_region_info);
> > > +}
> > > +
> > > +type_init(iopmp_register_types);
> > > diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> > > index 1be0717c0c..c148166d2d 100644
> > > --- a/hw/misc/trace-events
> > > +++ b/hw/misc/trace-events
> > > @@ -362,3 +362,6 @@ aspeed_sli_read(uint64_t offset, unsigned int siz=
e, uint32_t data) "To 0x%" PRIx
> > >  aspeed_sliio_write(uint64_t offset, unsigned int size, uint32_t data=
) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
> > >  aspeed_sliio_read(uint64_t offset, unsigned int size, uint32_t data)=
 "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
> > >
> > > +# riscv_iopmp.c
> > > +iopmp_read(uint64_t addr, uint32_t val) "addr 0x%"PRIx64" val 0x%x"
> > > +iopmp_write(uint64_t addr, uint32_t val) "addr 0x%"PRIx64" val 0x%x"
> > > diff --git a/include/hw/misc/riscv_iopmp.h b/include/hw/misc/riscv_io=
pmp.h
> > > new file mode 100644
> > > index 0000000000..b8fe479108
> > > --- /dev/null
> > > +++ b/include/hw/misc/riscv_iopmp.h
> > > @@ -0,0 +1,168 @@
> > > +/*
> > > + * QEMU RISC-V IOPMP (Input Output Physical Memory Protection)
> > > + *
> > > + * Copyright (c) 2023-2024 Andes Tech. Corp.
> > > + *
> > > + * SPDX-License-Identifier: GPL-2.0-or-later
> > > + *
> > > + * This program is free software; you can redistribute it and/or mod=
ify it
> > > + * under the terms and conditions of the GNU General Public License,
> > > + * version 2 or later, as published by the Free Software Foundation.
> > > + *
> > > + * This program is distributed in the hope it will be useful, but WI=
THOUT
> > > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILIT=
Y or
> > > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public Lic=
ense for
> > > + * more details.
> > > + *
> > > + * You should have received a copy of the GNU General Public License=
 along with
> > > + * this program.  If not, see <http://www.gnu.org/licenses/>.
> > > + */
> > > +
> > > +#ifndef RISCV_IOPMP_H
> > > +#define RISCV_IOPMP_H
> > > +
> > > +#include "hw/sysbus.h"
> > > +#include "qemu/typedefs.h"
> > > +#include "memory.h"
> > > +#include "exec/hwaddr.h"
> > > +
> > > +#define TYPE_IOPMP "iopmp"
> > > +#define IOPMP(obj) OBJECT_CHECK(IopmpState, (obj), TYPE_IOPMP)
> > > +
> > > +#define IOPMP_MAX_MD_NUM            63
> > > +#define IOPMP_MAX_RRID_NUM          65535
> > > +#define IOPMP_MAX_ENTRY_NUM         65535
> > > +
> > > +#define VENDER_VIRT                 0
> > > +#define SPECVER_0_9_1               91
> > > +#define IMPID_0_9_1                 91
> > > +
> > > +#define RRE_ERROR                   0
> > > +#define RRE_SUCCESS_VALUE           1
> > > +
> > > +#define RWE_ERROR                   0
> > > +#define RWE_SUCCESS                 1
> > > +
> > > +#define RXE_ERROR                   0
> > > +#define RXE_SUCCESS_VALUE           1
> > > +
> > > +#define ERR_REQINFO_TTYPE_READ      1
> > > +#define ERR_REQINFO_TTYPE_WRITE     2
> > > +#define ERR_REQINFO_TTYPE_FETCH     3
> > > +#define ERR_REQINFO_ETYPE_NOERROR   0
> > > +#define ERR_REQINFO_ETYPE_READ      1
> > > +#define ERR_REQINFO_ETYPE_WRITE     2
> > > +#define ERR_REQINFO_ETYPE_FETCH     3
> > > +#define ERR_REQINFO_ETYPE_PARHIT    4
> > > +#define ERR_REQINFO_ETYPE_NOHIT     5
> > > +#define ERR_REQINFO_ETYPE_RRID      6
> > > +#define ERR_REQINFO_ETYPE_USER      7
> > > +
> > > +#define IOPMP_MODEL_FULL            0
> > > +#define IOPMP_MODEL_RAPIDK          0x1
> > > +#define IOPMP_MODEL_DYNAMICK        0x2
> > > +#define IOPMP_MODEL_ISOLATION       0x3
> > > +#define IOPMP_MODEL_COMPACTK        0x4
> > > +
> > > +#define ENTRY_NO_HIT                0
> > > +#define ENTRY_PAR_HIT               1
> > > +#define ENTRY_HIT                   2
> >
> > Why not an enum?
> >
>
> Thank you for your suggestion. There will be enums in next version.
>
> Thanks,
> Ethan Chen
>
> > Alistair
> >
> > > +
> > > +/* The generic iopmp address space which downstream is system memory=
 */
> > > +extern AddressSpace iopmp_container_as;
> > > +
> > > +typedef enum {
> > > +    IOPMP_AMATCH_OFF,  /* Null (off)                            */
> > > +    IOPMP_AMATCH_TOR,  /* Top of Range                          */
> > > +    IOPMP_AMATCH_NA4,  /* Naturally aligned four-byte region    */
> > > +    IOPMP_AMATCH_NAPOT /* Naturally aligned power-of-two region */
> > > +} iopmp_am_t;
> > > +
> > > +typedef enum {
> > > +    IOPMP_ACCESS_READ  =3D 1,
> > > +    IOPMP_ACCESS_WRITE =3D 2,
> > > +    IOPMP_ACCESS_FETCH =3D 3
> > > +} iopmp_access_type;
> > > +
> > > +typedef enum {
> > > +    IOPMP_NONE =3D 0,
> > > +    IOPMP_RO   =3D 1,
> > > +    IOPMP_WO   =3D 2,
> > > +    IOPMP_RW   =3D 3,
> > > +    IOPMP_XO   =3D 4,
> > > +    IOPMP_RX   =3D 5,
> > > +    IOPMP_WX   =3D 6,
> > > +    IOPMP_RWX  =3D 7,
> > > +} iopmp_permission;
> > > +
> > > +typedef struct {
> > > +    uint32_t addr_reg;
> > > +    uint32_t addrh_reg;
> > > +    uint32_t cfg_reg;
> > > +} iopmp_entry_t;
> > > +
> > > +typedef struct {
> > > +    uint64_t sa;
> > > +    uint64_t ea;
> > > +} iopmp_addr_t;
> > > +
> > > +typedef struct {
> > > +    uint32_t *srcmd_en;
> > > +    uint32_t *srcmd_enh;
> > > +    uint32_t *mdcfg;
> > > +    iopmp_entry_t *entry;
> > > +    uint32_t mdlck;
> > > +    uint32_t mdlckh;
> > > +    uint32_t entrylck;
> > > +    uint32_t mdcfglck;
> > > +    uint32_t mdstall;
> > > +    uint32_t mdstallh;
> > > +    uint32_t rridscp;
> > > +    uint32_t err_cfg;
> > > +    uint64_t err_reqaddr;
> > > +    uint32_t err_reqid;
> > > +    uint32_t err_reqinfo;
> > > +} iopmp_regs;
> > > +
> > > +
> > > +/* To detect partially hit */
> > > +typedef struct iopmp_transaction_state {
> > > +    bool running;
> > > +    bool supported;
> > > +    hwaddr start_addr;
> > > +    hwaddr end_addr;
> > > +} iopmp_transaction_state;
> > > +
> > > +typedef struct IopmpState {
> > > +    SysBusDevice parent_obj;
> > > +    iopmp_addr_t *entry_addr;
> > > +    MemoryRegion mmio;
> > > +    IOMMUMemoryRegion iommu;
> > > +    IOMMUMemoryRegion *next_iommu;
> > > +    iopmp_regs regs;
> > > +    MemoryRegion *downstream;
> > > +    MemoryRegion blocked_r, blocked_w, blocked_x, blocked_rw, blocke=
d_rx,
> > > +                 blocked_wx, blocked_rwx;
> > > +    MemoryRegion stall_io;
> > > +    uint32_t model;
> > > +    uint32_t k;
> > > +    bool prient_prog;
> > > +    bool default_prient_prog;
> > > +    iopmp_transaction_state *transaction_state;
> > > +    QemuMutex iopmp_transaction_mutex;
> > > +
> > > +    AddressSpace downstream_as;
> > > +    AddressSpace blocked_r_as, blocked_w_as, blocked_x_as, blocked_r=
w_as,
> > > +                 blocked_rx_as, blocked_wx_as, blocked_rwx_as;
> > > +    qemu_irq irq;
> > > +    bool enable;
> > > +
> > > +    uint32_t prio_entry;
> > > +    uint32_t rrid_num;
> > > +    uint32_t md_num;
> > > +    uint32_t entry_num;
> > > +    uint32_t entry_offset;
> > > +    uint32_t fabricated_v;
> > > +} IopmpState;
> > > +
> > > +#endif
> > > --
> > > 2.34.1
> > >
> > >

