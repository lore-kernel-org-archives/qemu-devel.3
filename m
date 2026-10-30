Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626C5606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 02:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DlOwxa9b
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMcMB-0001lL-Ak; Thu, 29 Oct 2026 22:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1xMcM8-0001kg-Lh
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 22:28:36 -0400
Received: from mail-oo2-x02.google.com ([2607:f8b0:4864:31::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1xMcM2-0004jd-FW
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 22:28:36 -0400
Received: by mail-oo2-x02.google.com with SMTP id
 46e09a7af769-849c2965b9eso182106a34.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:28:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793327309; cv=none;
 d=google.com; s=arc-20260327;
 b=sWuB3xG/y2e4tr0TwexijL4uhffP12ysz8QdZqLBlW+JdWTLrALjDzh76gFpCNjqAg
 d0ZNXtlqf4+w0OosgVKankzwQQTcmGyVK+MftzvXa0CwLyyMSeDfgXbtcakGhzgvhvdS
 YTOUolWoHqqHc4PEwbGQB6BwKs8wp+xEAS/lEHmc3oPEwx88RNpmK8QOfdqLEYiYE6QZ
 XKI8BY5eMtjFWCYdNvCQ/AK/MeQGcn3DovZ1qZYDZhDnJW7Ge1F6ezNHAy1bAf4VoYA8
 OzmdP2HOQe8PUATLOMJKTW5qcrINLMnP4jGLY12UQM9mGk9PRAICgRIWMDII3Pwe0aJk
 RVJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PbatM/PCmkcR6X6U7VufAHIoT5ocHhPr5EfF2Hznx7I=;
 fh=3pjrZItSKaVnWsfbcMsCcvIL+dzWz32KI6dMXzdy2Og=;
 b=OOXFoz/7/o8A/VkPM6hnCMUO8EiI1Im9DuAkEn1cm/8UQRQlKeL5x6eC8jWtxXYrz/
 hWacu09HDUHVAkLAQvk9K9xcwwwCtJjRpICqjxkyDcS/vKD5tQ87b+aABXhG85XYWhnu
 IXb0VM3/f9N4iYdN/plhVBaQxBJoJVgxVuHL7Wgz8STGec+bBwjfXjWks68GipLCQh1+
 papu0/ojBkzeI06qHSKCZFbDVOhtBcBXL9IHRoZvJjzhW8ZzPDrGGwgpLZhSpyTHkD3h
 laDeFbsj72xpSp1K3zGqZ/dY1bhTlDtrTcPZ7PtNMCiCthMItZ2j/yUROHWF3ISDeV9K
 cF0A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793327309; x=1793932109; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PbatM/PCmkcR6X6U7VufAHIoT5ocHhPr5EfF2Hznx7I=;
 b=DlOwxa9bfCNGntESqedCfz2wxkTspXTfV5FMkvV9HRtLA3EFgy4A4+VhbXws5jqZ3w
 wrTKNOeMh60hEPFjkXXq55xUG0cGEhVQBMot4psSZUWdbbvbX6YX84sMhuI7XbDv4uMw
 Iv27YiD9fiQtkYnsU9feMCFDongcXooBgYIyMeujPw4D+B9qWfY7VwXMGVr7s2/WksdP
 1TYaGZa3nr7sZWE8q2psayyt68wFARN+LzHM2/CyUeS52WTmlPSv475Iu7rgrxYjWCmc
 9n6k5kAoG5fhEpjzdfEYsviR4mRvJD3GzlmljW7NYmP0qKzQDrN9nFRddHB9YfZT7TJ5
 zTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793327309; x=1793932109;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PbatM/PCmkcR6X6U7VufAHIoT5ocHhPr5EfF2Hznx7I=;
 b=BXLcS9uSUCmQAg7d/dWu54aGa6MjIvGEnVlpCpdijlrjpQO9WBQCqSwX3aUbnuuJSs
 eV+wtZMEQUMsKSluQqRP/cvW/6iXUmlL0jTP74T2Pofvhmyasb/4FRCyZJ1cfCyNQCUy
 9yQ/YgSOi31BwU9lBU6yZbh7QMiWvk4Kff37HXk422ugdzQZiNFqTflqrIwfVABEKZ+V
 kDJEiqrhpr09Yf6g0/PBXL6yhh37Vq81Lh7/CnsnKHh9tmNMzgkPz7UG7kJOrsuVHCUY
 TY4ML3ImcyMmiAG4sjenLhyjbL7gMxguv/6oG47nTimLVIEyOL5wqMRew4KluV45ym2n
 b7Pg==
X-Gm-Message-State: AFq9FYI/sH9THX9uvLCk5BYd9Zr36rdz2Y/Y+I7hi+Be9oQrx1ijMjmX
 TbgGBOS+N/nA8elhOHKMEzLP8I4adx7GGp52NesKywzAWpd8Wzv7hbT/hyjm7TjKsFT0DArpJBM
 Jk8Ayp08BUlPSzPn9ntCcDr5skNNwD2w=
X-Gm-Gg: AYBFou3Ra3ky8VtQVlgwyQdN+qTyf9o4t1GTNZoc7saDvk3NC65LBO6299fhqcm/Dvj
 ++N8G8yaV55q4bpuJ9zyjgVKZSN/mjVdspCVxN+B65qAJPRTBJjeNtgbu2hoByRezYh+FZDKNIQ
 JDc7zQ83jVuQpmGVg6MtZ/LDOmJ1hO32gz45y4UV7wvCBanstsREBSmGf8F+wS+oOwq5+zu3DyY
 jItUFttfVm4qGw+jbsPF5jtVlYGxAaJ5TUfiRfYbo6y6fhyqXH6WkXvee6UjqmPey9DgU9cckX7
 4ISLFudUiagy1JJiYGAtAqZEqG99+Zsw7UvXLn4qRf0coBuLS9lJ2gXzlNIR/u6EuJVg7VOltWx
 AMZRskUT+q6HedfJqbsm2kr1lNaQ1xozI5rM=
X-Received: by 2002:a05:6830:2406:b0:845:8d86:9f7f with SMTP id
 46e09a7af769-85d364a9eb9mr904057a34.8.1793327308231; Thu, 29 Oct 2026
 19:28:28 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028031042.1496-1-fritchleybohrer@gmail.com>
 <49ae69e6-aab4-4f7d-8a12-db28cf513a62@oss.qualcomm.com>
In-Reply-To: <49ae69e6-aab4-4f7d-8a12-db28cf513a62@oss.qualcomm.com>
From: Zephyr Li <fritchleybohrer@gmail.com>
Date: Fri, 30 Oct 2026 10:28:14 +0800
X-Gm-Features: AclHuK8vbZ6SyQ5Yv6mAZlUBDQQdsuxccuu0tgSOThPMvRzw9rYyqtIHiIcJTb4
Message-ID: <CAN4PorXMM1uR3PjQZK7vp-pnaOaZ7Sgm4hHrqhO+G92FfsnCtw@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/iommu-sys: honor MSI vector masks
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com, 
 pbonzini@redhat.com
Content-Type: multipart/alternative; boundary="0000000000002c587f065f058d02"
Received-SPF: pass client-ip=2607:f8b0:4864:31::2;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-oo2-x02.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000002c587f065f058d02
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

Thanks for the review!

I agree that reusing msix_pba as the pending bitmap would avoid maintaining
redundant state.

My concern is that the existing msix_pba_mmio region is mapped at offset
0x400, while the RISC-V IOMMU specification defines 0x400-0xfff as reserved
for future standard use, which must read as zero.

The specification discusses the MSI-X PBA in the context of PCIe IOMMU
integration, whereas riscv-iommu-sys is a SysBus device.

References:

   -

   https://docs.riscv.org/reference/iommu/v20260222/iommu_registers.html
   -

   https://docs.riscv.org/reference/iommu/v20260222/iommu_hw_guidelines.htm=
l

If we reuse msix_pba directly, the current MMIO read handler would expose
non-zero pending bits through the reserved region.

Would it make sense to reuse msix_pba as the internal pending bitmap while
keeping reads from the reserved MMIO region returning zero?

I can update the implementation and tests accordingly in v2.

Thanks,
Zephyr

On Fri, Oct 30, 2026 at 5:28=E2=80=AFAM Daniel Henrique Barboza <
daniel.barboza@oss.qualcomm.com> wrote:

>
>
> On 10/28/2026 12:10 AM, Zephyr Li wrote:
> > The system IOMMU currently sends MSIs without checking the correspondin=
g
> > vector mask bit in the MSI configuration table.
> >
> > Honor the mask bit and maintain one pending flag per vector.
> Notifications
> > generated while masked are deferred and coalesced. Unmasking a vector
> > delivers one pending MSI, if any, and reset clears all pending flags.
> >
> > Do not release deferred MSIs while FCTL.WSI selects wired interrupt mod=
e.
> > When switching back to MSI mode, release unmasked pending vectors and
> > retain masked ones until unmask.
> >
> > Add qtests covering masked and unmasked delivery, vector isolation, MSI
> > configuration updates, wired interrupt delivery, mode transitions, and
> > reset.
> >
> > Fixes: 01c1caa9d1b4 ("hw/riscv/virt.c, riscv-iommu-sys.c: add MSIx
> support")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4444
> > Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
> > ---
>
> This is less of a bug fix and more of a new feature.  I was ducking it fo=
r
> awhile because the Linux kernel support for masked MSIs with the RISC-V
> IOMMU
> isn't there yet, but I'm glad you went ahead and implemented it anyway.
>
> One comment:
>
> >   hw/riscv/riscv-iommu-sys.c     |  67 ++++-
> >   hw/riscv/riscv-iommu.c         |  12 +
> >   hw/riscv/riscv-iommu.h         |   3 +
> >   tests/qtest/iommu-riscv-test.c | 461 ++++++++++++++++++++++++++++++++=
+
> >   4 files changed, 541 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
> > index 258c171efd..96d2bdff7a 100644
> > --- a/hw/riscv/riscv-iommu-sys.c
> > +++ b/hw/riscv/riscv-iommu-sys.c
> > @@ -52,8 +52,50 @@ struct RISCVIOMMUStateSys {
> >       MemoryRegion msix_pba_mmio;
> >       uint8_t *msix_table;
> >       uint8_t *msix_pba;
> > +    /* Platform MSI state; the reserved PBA region does not expose it.
> */
>
> Can you add the riscv-iommu/riscv-aia citation that says that the PBA
> region doesn't
> need update for this kind of masking?  As far as I'm aware we would need
> to update
> msix_pba too, along with the msi_pending array you created.  Basically
> every time
> you set s->msi_pending[vector] =3D true you would write '1' in
> msix_pba[vector],
> and likewise when you're seeting s->msi_pending[vector] =3D false.
>
> In fact, do we need s->msi_pending?  Can't we just use msix_pba directly?
>
>
> Thanks,
> Daniel
>
>
>
> > +    bool msi_pending[RISCV_IOMMU_PCI_MSIX_VECTORS];
> >   };
> >
> > +static void riscv_iommu_sysdev_send_MSI_unmasked(RISCVIOMMUStateSys *s=
,
> > +                                                 uint32_t vector);
> > +
> > +static bool riscv_iommu_sysdev_msi_masked(RISCVIOMMUStateSys *s,
> > +                                          uint32_t vector)
> > +{
> > +    uint8_t *table_entry;
> > +
> > +    g_assert(vector < RISCV_IOMMU_PCI_MSIX_VECTORS);
> > +    table_entry =3D s->msix_table + vector * PCI_MSIX_ENTRY_SIZE;
> > +
> > +    return pci_get_long(table_entry + PCI_MSIX_ENTRY_VECTOR_CTRL) &
> > +           PCI_MSIX_ENTRY_CTRL_MASKBIT;
> > +}
> > +
> > +static void riscv_iommu_sysdev_release_pending(RISCVIOMMUStateSys *s,
> > +                                              uint32_t vector)
> > +{
> > +    /* Retain deferred MSI messages until MSI mode is restored. */
> > +    if (riscv_iommu_reg_get32(&s->iommu, RISCV_IOMMU_REG_FCTL) &
> > +        RISCV_IOMMU_FCTL_WSI) {
> > +        return;
> > +    }
> > +
> > +    if (s->msi_pending[vector] &&
> > +        !riscv_iommu_sysdev_msi_masked(s, vector)) {
> > +        s->msi_pending[vector] =3D false;
> > +        riscv_iommu_sysdev_send_MSI_unmasked(s, vector);
> > +    }
> > +}
> > +
> > +static void riscv_iommu_sysdev_msi_enabled(RISCVIOMMUState *iommu)
> > +{
> > +    RISCVIOMMUStateSys *s =3D container_of(iommu, RISCVIOMMUStateSys,
> iommu);
> > +
> > +    for (unsigned vector =3D 0; vector < ARRAY_SIZE(s->msi_pending);
> vector++) {
> > +        riscv_iommu_sysdev_release_pending(s, vector);
> > +    }
> > +}
> > +
> >   static uint64_t msix_table_mmio_read(void *opaque, hwaddr addr,
> >                                        unsigned size)
> >   {
> > @@ -67,9 +109,17 @@ static void msix_table_mmio_write(void *opaque,
> hwaddr addr,
> >                                     uint64_t val, unsigned size)
> >   {
> >       RISCVIOMMUStateSys *s =3D opaque;
> > +    uint32_t vector =3D addr / PCI_MSIX_ENTRY_SIZE;
> > +    bool was_masked;
> >
> >       g_assert(addr + size <=3D RISCV_IOMMU_PCI_MSIX_VECTORS *
> PCI_MSIX_ENTRY_SIZE);
> > +
> > +    was_masked =3D riscv_iommu_sysdev_msi_masked(s, vector);
> >       pci_set_long(s->msix_table + addr, val);
> > +
> > +    if (was_masked && !riscv_iommu_sysdev_msi_masked(s, vector)) {
> > +        riscv_iommu_sysdev_release_pending(s, vector);
> > +    }
> >   }
> >
> >   static const MemoryRegionOps msix_table_mmio_ops =3D {
> > @@ -134,8 +184,8 @@ static void
> riscv_iommu_sysdev_init_msi(RISCVIOMMUStateSys *s,
> >                                   &s->msix_pba_mmio);
> >   }
> >
> > -static void riscv_iommu_sysdev_send_MSI(RISCVIOMMUStateSys *s,
> > -                                        uint32_t vector)
> > +static void riscv_iommu_sysdev_send_MSI_unmasked(RISCVIOMMUStateSys *s=
,
> > +                                                 uint32_t vector)
> >   {
> >       uint8_t *table_entry =3D s->msix_table + vector *
> PCI_MSIX_ENTRY_SIZE;
> >       uint64_t msi_addr =3D pci_get_quad(table_entry +
> PCI_MSIX_ENTRY_LOWER_ADDR);
> > @@ -160,6 +210,17 @@ static void
> riscv_iommu_sysdev_send_MSI(RISCVIOMMUStateSys *s,
> >       }
> >   }
> >
> > +static void riscv_iommu_sysdev_send_MSI(RISCVIOMMUStateSys *s,
> > +                                        uint32_t vector)
> > +{
> > +    if (riscv_iommu_sysdev_msi_masked(s, vector)) {
> > +        s->msi_pending[vector] =3D true;
> > +        return;
> > +    }
> > +
> > +    riscv_iommu_sysdev_send_MSI_unmasked(s, vector);
> > +}
> > +
> >   static void riscv_iommu_sysdev_notify(RISCVIOMMUState *iommu,
> >                                         unsigned vector)
> >   {
> > @@ -194,6 +255,7 @@ static void riscv_iommu_sys_realize(DeviceState
> *dev, Error **errp)
> >       }
> >
> >       s->iommu.notify =3D riscv_iommu_sysdev_notify;
> > +    s->iommu.msi_enabled =3D riscv_iommu_sysdev_msi_enabled;
> >
> >       /* 4 IRQs are defined starting from s->base_irq */
> >       for (int i =3D 0; i < RISCV_IOMMU_INTR_COUNT; i++) {
> > @@ -255,6 +317,7 @@ static void riscv_iommu_sys_reset_hold(Object *obj,
> ResetType type)
> >       RISCVIOMMUState *iommu =3D &sys->iommu;
> >
> >       riscv_iommu_reset(iommu);
> > +    memset(sys->msi_pending, 0, sizeof(sys->msi_pending));
> >
> >       trace_riscv_iommu_sys_reset_hold(type);
> >   }
> > diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> > index 323a041b4a..23b6f8da86 100644
> > --- a/hw/riscv/riscv-iommu.c
> > +++ b/hw/riscv/riscv-iommu.c
> > @@ -2419,6 +2419,7 @@ static MemTxResult riscv_iommu_mmio_write(void
> *opaque, hwaddr addr,
> >       RISCVIOMMUState *s =3D opaque;
> >       uint32_t regb =3D addr & ~3;
> >       uint32_t busy =3D 0;
> > +    uint32_t old_fctl =3D 0;
> >       uint64_t val =3D 0;
> >       bool cy_inh =3D false;
> >
> > @@ -2434,6 +2435,10 @@ static MemTxResult riscv_iommu_mmio_write(void
> *opaque, hwaddr addr,
> >
> >       /* Track actionable MMIO write. */
> >       switch (regb) {
> > +    case RISCV_IOMMU_REG_FCTL:
> > +        old_fctl =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FCTL);
> > +        break;
> > +
> >       case RISCV_IOMMU_REG_DDTP:
> >       case RISCV_IOMMU_REG_DDTP + 4:
> >           process_fn =3D riscv_iommu_process_ddtp;
> > @@ -2510,6 +2515,13 @@ static MemTxResult riscv_iommu_mmio_write(void
> *opaque, hwaddr addr,
> >        */
> >       riscv_iommu_write_reg_val(s, &s->regs[addr], addr, size, data);
> >
> > +    if (regb =3D=3D RISCV_IOMMU_REG_FCTL && s->msi_enabled &&
> > +        (old_fctl & RISCV_IOMMU_FCTL_WSI) &&
> > +        !(riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_FCTL) &
> > +          RISCV_IOMMU_FCTL_WSI)) {
> > +        s->msi_enabled(s);
> > +    }
> > +
> >       /* Busy flag update, MSB 4-byte register. */
> >       if (busy) {
> >           uint32_t rw =3D ldl_le_p(&s->regs[regb]);
> > diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
> > index 7c470ba084..ea1b53e732 100644
> > --- a/hw/riscv/riscv-iommu.h
> > +++ b/hw/riscv/riscv-iommu.h
> > @@ -61,6 +61,9 @@ struct RISCVIOMMUState {
> >       /* interrupt notifier */
> >       void (*notify)(RISCVIOMMUState *iommu, unsigned vector);
> >
> > +    /* Optional platform callback when FCTL switches from WSI to MSI. =
*/
> > +    void (*msi_enabled)(RISCVIOMMUState *iommu);
> > +
> >       /* IOMMU target address space */
> >       AddressSpace *target_as;
> >       MemoryRegion *target_mr;
> > diff --git a/tests/qtest/iommu-riscv-test.c
> b/tests/qtest/iommu-riscv-test.c
> > index 2638024891 <(263)%20802-4891>..979a976e4f 100644
> > --- a/tests/qtest/iommu-riscv-test.c
> > +++ b/tests/qtest/iommu-riscv-test.c
> > @@ -19,6 +19,28 @@
> >
> >   #define DMA_LEN           4
> >
> > +#define RISCV_IOMMU_SYS_MSI_TARGET0  (QRIOMMU_SPACE_OFFS +
> 0x03000000ull)
> > +#define RISCV_IOMMU_SYS_MSI_TARGET1  (RISCV_IOMMU_SYS_MSI_TARGET0 + 4)
> > +#define RISCV_IOMMU_SYS_CQ_BASE      \
> > +    (QRIOMMU_SPACE_OFFS + QRIOMMU_CQ_BASE_ADDR)
> > +#define RISCV_IOMMU_SYS_MSI_DATA0    0x12345678
> > +#define RISCV_IOMMU_SYS_MSI_DATA1    0xa5a55a5a
> > +
> > +/* RISC-V virt machine PLIC, hart 0 M-mode context. */
> > +#define RISCV_PLIC_BASE             0x0c000000
> > +#define RISCV_PLIC_PENDING          (RISCV_PLIC_BASE + 0x1000)
> > +#define RISCV_PLIC_ENABLE           (RISCV_PLIC_BASE + 0x2000)
> > +#define RISCV_PLIC_THRESHOLD        (RISCV_PLIC_BASE + 0x200000)
> > +#define RISCV_PLIC_CLAIM            (RISCV_PLIC_THRESHOLD + 4)
> > +#define RISCV_IOMMU_SYS_IRQ_BASE    36
> > +
> > +#define PCI_TESTDEV_TEST             0
> > +#define PCI_TESTDEV_WIDTH            1
> > +#define PCI_TESTDEV_OFFSET           4
> > +#define PCI_TESTDEV_DATA             8
> > +#define PCI_TESTDEV_COUNT            12
> > +#define PCI_TESTDEV_NO_EVENTFD       0
> > +
> >   /* RISC-V virt machine PCI configuration */
> >   #define RISCV_GPEX_PIO_BASE        0x3000000
> >   #define RISCV_BUS_PIO_LIMIT        0x10000
> > @@ -264,6 +286,425 @@ static void test_riscv_iommu_nested(void)
> >       run_riscv_iommu_translation(&cfg);
> >   }
> >
> > +static void riscv_iommu_sys_set_wsi(QTestState *qts, bool wsi)
> > +{
> > +    uint64_t base =3D VIRT_RISCV_IOMMU_BASE;
> > +    uint32_t fctl;
> > +
> > +    /* Feature changes require Off mode and all in-memory queues
> disabled. */
> > +    g_assert_cmphex(qtest_readq(qts, base + RISCV_IOMMU_REG_DDTP) &
> > +                    (RISCV_IOMMU_DDTP_MODE | RISCV_IOMMU_DDTP_BUSY),
> > +                    =3D=3D, RISCV_IOMMU_DDTP_MODE_OFF);
> > +    g_assert_cmphex(qtest_readl(qts, base + RISCV_IOMMU_REG_CQCSR) &
> > +                    (RISCV_IOMMU_CQCSR_CQEN | RISCV_IOMMU_CQCSR_CQON |
> > +                     RISCV_IOMMU_CQCSR_BUSY), =3D=3D, 0);
> > +    g_assert_cmphex(qtest_readl(qts, base + RISCV_IOMMU_REG_FQCSR) &
> > +                    (RISCV_IOMMU_FQCSR_FQEN | RISCV_IOMMU_FQCSR_FQON |
> > +                     RISCV_IOMMU_FQCSR_BUSY), =3D=3D, 0);
> > +    g_assert_cmphex(qtest_readl(qts, base + RISCV_IOMMU_REG_PQCSR) &
> > +                    (RISCV_IOMMU_PQCSR_PQEN | RISCV_IOMMU_PQCSR_PQON |
> > +                     RISCV_IOMMU_PQCSR_BUSY), =3D=3D, 0);
> > +
> > +    fctl =3D qtest_readl(qts, base + RISCV_IOMMU_REG_FCTL);
> > +    fctl =3D (fctl & ~RISCV_IOMMU_FCTL_WSI) |
> > +           (wsi ? RISCV_IOMMU_FCTL_WSI : 0);
> > +    qtest_writel(qts, base + RISCV_IOMMU_REG_FCTL, fctl);
> > +    g_assert_cmphex(qtest_readl(qts, base + RISCV_IOMMU_REG_FCTL) &
> > +                    RISCV_IOMMU_FCTL_WSI, =3D=3D, fctl &
> RISCV_IOMMU_FCTL_WSI);
> > +}
> > +
> > +static QTestState *riscv_iommu_sys_test_init(const char *extra_args)
> > +{
> > +    QTestState *qts;
> > +    uint64_t cap;
> > +    uint32_t igs;
> > +
> > +    if (!qtest_has_machine("virt")) {
> > +        g_test_skip("virt machine not available");
> > +        return NULL;
> > +    }
> > +
> > +    qts =3D qtest_initf("-machine virt,aia=3Dnone,acpi=3Doff,iommu-sys=
=3Don "
> > +                      "-cpu max -smp 1 -m 512 -net none -nodefaults %s=
",
> > +                      extra_args ? extra_args : "");
> > +
> > +    cap =3D qtest_readq(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_C=
AP);
> > +    igs =3D (cap & RISCV_IOMMU_CAP_IGS) >> 28;
> > +    g_assert_cmpuint(igs, <=3D, RISCV_IOMMU_CAP_IGS_BOTH);
> > +    g_assert_cmpuint(igs, !=3D, RISCV_IOMMU_CAP_IGS_WSI);
> > +
> > +    riscv_iommu_sys_set_wsi(qts, false);
> > +
> > +    return qts;
> > +}
> > +
> > +static QPCIDevice *riscv_iommu_sys_init_msi_sink(QTestState *qts,
> > +                                                  QGenericPCIBus *gbus=
,
> > +                                                  QPCIBar *bar,
> > +                                                  uint64_t *target,
> > +                                                  uint32_t *data)
> > +{
> > +    QPCIDevice *dev =3D NULL;
> > +    uint32_t offset;
> > +
> > +    qpci_init_generic(gbus, qts, NULL, false);
> > +    riscv_config_qpci_bus(gbus);
> > +    qpci_device_foreach(&gbus->bus, PCI_VENDOR_ID_REDHAT,
> > +                        PCI_DEVICE_ID_REDHAT_TEST, save_fn, &dev);
> > +    g_assert(dev);
> > +
> > +    qpci_device_enable(dev);
> > +    *bar =3D qpci_iomap(dev, 0, NULL);
> > +    g_assert_false(bar->is_io);
> > +
> > +    qpci_io_writeb(dev, *bar, PCI_TESTDEV_TEST, PCI_TESTDEV_NO_EVENTFD=
);
> > +    g_assert_cmpuint(qpci_io_readb(dev, *bar, PCI_TESTDEV_WIDTH), =3D=
=3D,
> 1);
> > +    offset =3D qpci_io_readl(dev, *bar, PCI_TESTDEV_OFFSET);
> > +    *data =3D qpci_io_readl(dev, *bar, PCI_TESTDEV_DATA);
> > +    *target =3D bar->addr + offset;
> > +    g_assert_cmpuint(qpci_io_readl(dev, *bar, PCI_TESTDEV_COUNT), =3D=
=3D,
> 0);
> > +
> > +    return dev;
> > +}
> > +
> > +static void riscv_iommu_sys_program_msi(QTestState *qts, unsigned
> vector,
> > +                                        uint64_t target, uint32_t data=
,
> > +                                        bool masked)
> > +{
> > +    uint64_t entry =3D VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_MSI_CON=
FIG
> +
> > +                     vector * PCI_MSIX_ENTRY_SIZE;
> > +
> > +    qtest_writeq(qts, entry + PCI_MSIX_ENTRY_LOWER_ADDR, target);
> > +    qtest_writel(qts, entry + PCI_MSIX_ENTRY_DATA, data);
> > +    qtest_writel(qts, entry + PCI_MSIX_ENTRY_VECTOR_CTRL,
> > +                 masked ? PCI_MSIX_ENTRY_CTRL_MASKBIT : 0);
> > +}
> > +
> > +static void riscv_iommu_sys_set_mask(QTestState *qts, unsigned vector,
> > +                                     bool masked)
> > +{
> > +    uint64_t entry =3D VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_MSI_CON=
FIG
> +
> > +                     vector * PCI_MSIX_ENTRY_SIZE;
> > +
> > +    qtest_writel(qts, entry + PCI_MSIX_ENTRY_VECTOR_CTRL,
> > +                 masked ? PCI_MSIX_ENTRY_CTRL_MASKBIT : 0);
> > +}
> > +
> > +static void riscv_iommu_sys_setup_cq(QTestState *qts)
> > +{
> > +    uint64_t cqb =3D (RISCV_IOMMU_SYS_CQ_BASE >> 12) << 10;
> > +    uint32_t cqcsr;
> > +
> > +    qtest_writeq(qts, RISCV_IOMMU_SYS_CQ_BASE, UINT64_MAX);
> > +    qtest_writeq(qts, RISCV_IOMMU_SYS_CQ_BASE + 8, 0);
> > +    qtest_writeq(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQB, cqb=
);
> > +    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQT, 0);
> > +    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR,
> > +                 RISCV_IOMMU_CQCSR_CQEN | RISCV_IOMMU_CQCSR_CIE);
> > +
> > +    cqcsr =3D qtest_readl(qts,
> > +                        VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR)=
;
> > +    g_assert_cmphex(cqcsr & RISCV_IOMMU_CQCSR_CQON,
> > +                    =3D=3D, RISCV_IOMMU_CQCSR_CQON);
> > +}
> > +
> > +static void riscv_iommu_sys_trigger_cq_irq(QTestState *qts)
> > +{
> > +    uint32_t cqcsr;
> > +
> > +    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQT, 1);
> > +    cqcsr =3D qtest_readl(qts,
> > +                        VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR)=
;
> > +    g_assert_cmphex(cqcsr & RISCV_IOMMU_CQCSR_CMD_ILL,
> > +                    =3D=3D, RISCV_IOMMU_CQCSR_CMD_ILL);
> > +}
> > +
> > +static void riscv_iommu_sys_rearm_cq_irq(QTestState *qts)
> > +{
> > +    uint32_t cqcsr;
> > +
> > +    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQT, 0);
> > +    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR,
> > +                 RISCV_IOMMU_CQCSR_CQEN | RISCV_IOMMU_CQCSR_CIE |
> > +                 RISCV_IOMMU_CQCSR_CMD_ILL);
> > +    cqcsr =3D qtest_readl(qts,
> > +                        VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR)=
;
> > +    g_assert_cmphex(cqcsr & RISCV_IOMMU_CQCSR_CMD_ILL, =3D=3D, 0);
> > +
> > +    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_IPSR,
> > +                 RISCV_IOMMU_IPSR_CIP);
> > +    g_assert_cmphex(qtest_readl(qts, VIRT_RISCV_IOMMU_BASE +
> > +                               RISCV_IOMMU_REG_IPSR) &
> RISCV_IOMMU_IPSR_CIP,
> > +                    =3D=3D, 0);
> > +}
> > +
> > +static void test_riscv_iommu_sys_msi_unmasked(void)
> > +{
> > +    QTestState *qts =3D riscv_iommu_sys_test_init(NULL);
> > +
> > +    if (!qts) {
> > +        return;
> > +    }
> > +
> > +    qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET0, 0);
> > +    riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI_TARGET0,
> > +                                RISCV_IOMMU_SYS_MSI_DATA0, false);
> > +    riscv_iommu_sys_setup_cq(qts);
> > +    riscv_iommu_sys_trigger_cq_irq(qts);
> > +
> > +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0),
> > +                    =3D=3D, RISCV_IOMMU_SYS_MSI_DATA0);
> > +    qtest_quit(qts);
> > +}
> > +
> > +static void test_riscv_iommu_sys_msi_masked(void)
> > +{
> > +    QGenericPCIBus gbus;
> > +    QPCIBar sink_bar;
> > +    QPCIDevice *sink;
> > +    QTestState *qts =3D riscv_iommu_sys_test_init("-device pci-testdev=
");
> > +    uint64_t sink_target;
> > +    uint32_t sink_data;
> > +
> > +    if (!qts) {
> > +        return;
> > +    }
> > +
> > +    sink =3D riscv_iommu_sys_init_msi_sink(qts, &gbus, &sink_bar,
> > +                                         &sink_target, &sink_data);
> > +    riscv_iommu_sys_program_msi(qts, 0, sink_target, sink_data, true);
> > +    riscv_iommu_sys_setup_cq(qts);
> > +
> > +    riscv_iommu_sys_trigger_cq_irq(qts);
> > +    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT),
> =3D=3D, 0);
> > +
> > +    riscv_iommu_sys_rearm_cq_irq(qts);
> > +    riscv_iommu_sys_trigger_cq_irq(qts);
> > +    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT),
> =3D=3D, 0);
> > +
> > +    riscv_iommu_sys_set_mask(qts, 0, false);
> > +    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT),
> =3D=3D, 1);
> > +
> > +    riscv_iommu_sys_set_mask(qts, 0, false);
> > +    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT),
> =3D=3D, 1);
> > +    g_free(sink);
> > +    qtest_quit(qts);
> > +}
> > +
> > +static void test_riscv_iommu_sys_msi_config_update(void)
> > +{
> > +    QTestState *qts =3D riscv_iommu_sys_test_init(NULL);
> > +
> > +    if (!qts) {
> > +        return;
> > +    }
> > +
> > +    qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET0, 0);
> > +    qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET1, 0);
> > +    riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI_TARGET0,
> > +                                RISCV_IOMMU_SYS_MSI_DATA0, true);
> > +    riscv_iommu_sys_setup_cq(qts);
> > +    riscv_iommu_sys_trigger_cq_irq(qts);
> > +
> > +    /* Updating a masked entry must not release the deferred message. =
*/
> > +    riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI_TARGET1,
> > +                                RISCV_IOMMU_SYS_MSI_DATA1, true);
> > +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), =3D=
=3D,
> 0);
> > +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET1), =3D=
=3D,
> 0);
> > +
> > +    /* Release uses the current address and data, rather than a
> snapshot. */
> > +    riscv_iommu_sys_set_mask(qts, 0, false);
> > +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), =3D=
=3D,
> 0);
> > +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET1),
> > +                    =3D=3D, RISCV_IOMMU_SYS_MSI_DATA1);
> > +    qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET1, 0);
> > +    riscv_iommu_sys_set_mask(qts, 0, false);
> > +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET1), =3D=
=3D,
> 0);
> > +    qtest_quit(qts);
> > +}
> > +
> > +static void test_riscv_iommu_sys_msi_vector_isolation(void)
> > +{
> > +    QTestState *qts =3D riscv_iommu_sys_test_init(NULL);
> > +
> > +    if (!qts) {
> > +        return;
> > +    }
> > +
> > +    qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET0, 0);
> > +    qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET1, 0);
> > +    riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI_TARGET0,
> > +                                RISCV_IOMMU_SYS_MSI_DATA0, true);
> > +    riscv_iommu_sys_program_msi(qts, 1, RISCV_IOMMU_SYS_MSI_TARGET1,
> > +                                RISCV_IOMMU_SYS_MSI_DATA1, false);
> > +    riscv_iommu_sys_setup_cq(qts);
> > +
> > +    riscv_iommu_sys_trigger_cq_irq(qts);
> > +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), =3D=
=3D,
> 0);
> > +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET1), =3D=
=3D,
> 0);
> > +
> > +    riscv_iommu_sys_rearm_cq_irq(qts);
> > +    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_ICVEC, 1=
);
> > +    riscv_iommu_sys_trigger_cq_irq(qts);
> > +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), =3D=
=3D,
> 0);
> > +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET1),
> > +                    =3D=3D, RISCV_IOMMU_SYS_MSI_DATA1);
> > +
> > +    riscv_iommu_sys_set_mask(qts, 0, false);
> > +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0),
> > +                    =3D=3D, RISCV_IOMMU_SYS_MSI_DATA0);
> > +    qtest_quit(qts);
> > +}
> > +
> > +static void test_riscv_iommu_sys_msi_wsi_switch(const void *opaque)
> > +{
> > +    bool unmask_in_wsi =3D GPOINTER_TO_INT(opaque);
> > +    QGenericPCIBus gbus;
> > +    QPCIBar sink_bar;
> > +    QPCIDevice *sink;
> > +    QTestState *qts =3D riscv_iommu_sys_test_init("-device pci-testdev=
");
> > +    uint64_t sink_target;
> > +    uint32_t sink_data;
> > +
> > +    if (!qts) {
> > +        return;
> > +    }
> > +
> > +    g_assert_cmpuint((qtest_readq(qts, VIRT_RISCV_IOMMU_BASE +
> > +                                 RISCV_IOMMU_REG_CAP) &
> > +                      RISCV_IOMMU_CAP_IGS) >> 28,
> > +                     =3D=3D, RISCV_IOMMU_CAP_IGS_BOTH);
> > +    sink =3D riscv_iommu_sys_init_msi_sink(qts, &gbus, &sink_bar,
> > +                                         &sink_target, &sink_data);
> > +    riscv_iommu_sys_program_msi(qts, 0, sink_target, sink_data, true);
> > +    riscv_iommu_sys_setup_cq(qts);
> > +    riscv_iommu_sys_trigger_cq_irq(qts);
> > +    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT),
> =3D=3D, 0);
> > +
> > +    /* Stop the CQ before changing FCTL, preserving the deferred
> message. */
> > +    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR, 0=
);
> > +    riscv_iommu_sys_set_wsi(qts, true);
> > +    if (unmask_in_wsi) {
> > +        riscv_iommu_sys_set_mask(qts, 0, false);
> > +    }
> > +    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT),
> =3D=3D, 0);
> > +
> > +    riscv_iommu_sys_set_wsi(qts, false);
> > +    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT),
> > +                     =3D=3D, unmask_in_wsi ? 1 : 0);
> > +    riscv_iommu_sys_set_mask(qts, 0, false);
> > +    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT),
> =3D=3D, 1);
> > +
> > +    /* Repeated mode changes and unmask writes must not replay the MSI=
.
> */
> > +    riscv_iommu_sys_set_wsi(qts, true);
> > +    riscv_iommu_sys_set_wsi(qts, false);
> > +    riscv_iommu_sys_set_mask(qts, 0, false);
> > +    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT),
> =3D=3D, 1);
> > +    g_free(sink);
> > +    qtest_quit(qts);
> > +}
> > +
> > +static void test_riscv_iommu_sys_wsi_delivery(void)
> > +{
> > +    const unsigned vector =3D 1;
> > +    const unsigned irq =3D RISCV_IOMMU_SYS_IRQ_BASE + vector;
> > +    const uint32_t irq_bit =3D 1U << (irq % 32);
> > +    const unsigned irq_word =3D (irq / 32) * 4;
> > +    QGenericPCIBus gbus;
> > +    QPCIBar sink_bar;
> > +    QPCIDevice *sink;
> > +    QTestState *qts =3D riscv_iommu_sys_test_init("-device pci-testdev=
");
> > +    uint64_t sink_target;
> > +    uint32_t sink_data;
> > +
> > +    if (!qts) {
> > +        return;
> > +    }
> > +
> > +    sink =3D riscv_iommu_sys_init_msi_sink(qts, &gbus, &sink_bar,
> > +                                         &sink_target, &sink_data);
> > +    riscv_iommu_sys_set_wsi(qts, true);
> > +    /* The MSI vector mask must not suppress delivery through the wire=
.
> */
> > +    riscv_iommu_sys_program_msi(qts, vector, sink_target, sink_data,
> true);
> > +    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_ICVEC,
> vector);
> > +
> > +    qtest_writel(qts, RISCV_PLIC_BASE + irq * 4, 1);
> > +    qtest_writel(qts, RISCV_PLIC_ENABLE + irq_word, irq_bit);
> > +    qtest_writel(qts, RISCV_PLIC_THRESHOLD, 0);
> > +    g_assert_cmphex(qtest_readl(qts, RISCV_PLIC_PENDING + irq_word),
> =3D=3D, 0);
> > +    g_assert_cmpuint(qtest_readl(qts, RISCV_PLIC_CLAIM), =3D=3D, 0);
> > +
> > +    riscv_iommu_sys_setup_cq(qts);
> > +    riscv_iommu_sys_trigger_cq_irq(qts);
> > +    /* The PLIC latches the pulse after the device's wire returns low.
> */
> > +    g_assert_cmphex(qtest_readl(qts, RISCV_PLIC_PENDING + irq_word),
> > +                    =3D=3D, irq_bit);
> > +    g_assert_cmpuint(qtest_readl(qts, RISCV_PLIC_CLAIM), =3D=3D, irq);
> > +    g_assert_cmphex(qtest_readl(qts, RISCV_PLIC_PENDING + irq_word),
> =3D=3D, 0);
> > +    qtest_writel(qts, RISCV_PLIC_CLAIM, irq);
> > +    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT),
> =3D=3D, 0);
> > +
> > +    /* A WSI event must not become a deferred MSI after switching
> modes. */
> > +    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR, 0=
);
> > +    riscv_iommu_sys_set_wsi(qts, false);
> > +    riscv_iommu_sys_set_mask(qts, vector, false);
> > +    g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TESTDEV_COUNT),
> =3D=3D, 0);
> > +    g_free(sink);
> > +    qtest_quit(qts);
> > +}
> > +
> > +static void test_riscv_iommu_sys_msi_wsi_reset(void)
> > +{
> > +    QTestState *qts =3D riscv_iommu_sys_test_init(NULL);
> > +
> > +    if (!qts) {
> > +        return;
> > +    }
> > +
> > +    qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET0, 0);
> > +    riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI_TARGET0,
> > +                                RISCV_IOMMU_SYS_MSI_DATA0, true);
> > +    riscv_iommu_sys_setup_cq(qts);
> > +    riscv_iommu_sys_trigger_cq_irq(qts);
> > +    qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR, 0=
);
> > +    riscv_iommu_sys_set_wsi(qts, true);
> > +    riscv_iommu_sys_set_mask(qts, 0, false);
> > +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), =3D=
=3D,
> 0);
> > +
> > +    qtest_system_reset(qts);
> > +    /* Reprogram valid MSI state without depending on table reset
> values. */
> > +    riscv_iommu_sys_set_wsi(qts, true);
> > +    riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI_TARGET0,
> > +                                RISCV_IOMMU_SYS_MSI_DATA1, false);
> > +    riscv_iommu_sys_set_wsi(qts, false);
> > +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), =3D=
=3D,
> 0);
> > +    riscv_iommu_sys_set_mask(qts, 0, true);
> > +    riscv_iommu_sys_set_mask(qts, 0, false);
> > +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), =3D=
=3D,
> 0);
> > +    qtest_quit(qts);
> > +}
> > +
> > +static void test_riscv_iommu_sys_msi_reset(void)
> > +{
> > +    QTestState *qts =3D riscv_iommu_sys_test_init(NULL);
> > +
> > +    if (!qts) {
> > +        return;
> > +    }
> > +
> > +    qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET0, 0);
> > +    riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI_TARGET0,
> > +                                RISCV_IOMMU_SYS_MSI_DATA0, true);
> > +    riscv_iommu_sys_setup_cq(qts);
> > +    riscv_iommu_sys_trigger_cq_irq(qts);
> > +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), =3D=
=3D,
> 0);
> > +
> > +    qtest_system_reset(qts);
> > +    riscv_iommu_sys_set_mask(qts, 0, false);
> > +    g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TARGET0), =3D=
=3D,
> 0);
> > +    qtest_quit(qts);
> > +}
> > +
> >   int main(int argc, char **argv)
> >   {
> >       g_test_init(&argc, &argv, NULL);
> > @@ -275,5 +716,25 @@ int main(int argc, char **argv)
> >                      test_riscv_iommu_g_stage_only);
> >       qtest_add_func("/iommu-testdev/translation/ns-nested",
> >                      test_riscv_iommu_nested);
> > +    qtest_add_func("/riscv-iommu-sys/msi/unmasked",
> > +                   test_riscv_iommu_sys_msi_unmasked);
> > +    qtest_add_func("/riscv-iommu-sys/msi/masked",
> > +                   test_riscv_iommu_sys_msi_masked);
> > +    qtest_add_func("/riscv-iommu-sys/msi/config-update",
> > +                   test_riscv_iommu_sys_msi_config_update);
> > +    qtest_add_func("/riscv-iommu-sys/msi/vector-isolation",
> > +                   test_riscv_iommu_sys_msi_vector_isolation);
> > +    qtest_add_data_func("/riscv-iommu-sys/msi/wsi-switch-unmasked",
> > +                        GINT_TO_POINTER(true),
> > +                        test_riscv_iommu_sys_msi_wsi_switch);
> > +    qtest_add_data_func("/riscv-iommu-sys/msi/wsi-switch-masked",
> > +                        GINT_TO_POINTER(false),
> > +                        test_riscv_iommu_sys_msi_wsi_switch);
> > +    qtest_add_func("/riscv-iommu-sys/wsi/delivery",
> > +                   test_riscv_iommu_sys_wsi_delivery);
> > +    qtest_add_func("/riscv-iommu-sys/msi/wsi-reset",
> > +                   test_riscv_iommu_sys_msi_wsi_reset);
> > +    qtest_add_func("/riscv-iommu-sys/msi/reset",
> > +                   test_riscv_iommu_sys_msi_reset);
> >       return g_test_run();
> >   }
>
>

--0000000000002c587f065f058d02
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p>Hi Daniel,</p><p>Thanks for the review!</p><p>I agree t=
hat reusing msix_pba as the pending bitmap would avoid maintaining redundan=
t state.</p><p>My concern is that the existing msix_pba_mmio region is mapp=
ed at offset 0x400, while the RISC-V IOMMU specification defines 0x400-0xff=
f as reserved for future standard use, which must read as zero.</p><p>The s=
pecification discusses the MSI-X PBA in the context of PCIe IOMMU integrati=
on, whereas riscv-iommu-sys is a SysBus device.</p><p>References:</p><ul><l=
i><p><a href=3D"https://docs.riscv.org/reference/iommu/v20260222/iommu_regi=
sters.html">https://docs.riscv.org/reference/iommu/v20260222/iommu_register=
s.html</a></p></li><li><p><a href=3D"https://docs.riscv.org/reference/iommu=
/v20260222/iommu_hw_guidelines.html">https://docs.riscv.org/reference/iommu=
/v20260222/iommu_hw_guidelines.html</a></p></li></ul><p>If we reuse msix_pb=
a directly, the current MMIO read handler would expose non-zero pending bit=
s through the reserved region.</p><p>Would it make sense to reuse msix_pba =
as the internal pending bitmap while keeping reads from the reserved MMIO r=
egion returning zero?</p><p>I can update the implementation and tests accor=
dingly in v2.</p><p>Thanks,<br>Zephyr</p></div><br><div class=3D"gmail_quot=
e gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct =
30, 2026 at 5:28=E2=80=AFAM Daniel Henrique Barboza &lt;<a href=3D"mailto:d=
aniel.barboza@oss.qualcomm.com">daniel.barboza@oss.qualcomm.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On 10/28/2026 12:10 AM, Zephyr Li wrote:<br>
&gt; The system IOMMU currently sends MSIs without checking the correspondi=
ng<br>
&gt; vector mask bit in the MSI configuration table.<br>
&gt; <br>
&gt; Honor the mask bit and maintain one pending flag per vector. Notificat=
ions<br>
&gt; generated while masked are deferred and coalesced. Unmasking a vector<=
br>
&gt; delivers one pending MSI, if any, and reset clears all pending flags.<=
br>
&gt; <br>
&gt; Do not release deferred MSIs while FCTL.WSI selects wired interrupt mo=
de.<br>
&gt; When switching back to MSI mode, release unmasked pending vectors and<=
br>
&gt; retain masked ones until unmask.<br>
&gt; <br>
&gt; Add qtests covering masked and unmasked delivery, vector isolation, MS=
I<br>
&gt; configuration updates, wired interrupt delivery, mode transitions, and=
<br>
&gt; reset.<br>
&gt; <br>
&gt; Fixes: 01c1caa9d1b4 (&quot;hw/riscv/virt.c, riscv-iommu-sys.c: add MSI=
x support&quot;)<br>
&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/444=
4" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qem=
u/-/issues/4444</a><br>
&gt; Signed-off-by: Zephyr Li &lt;<a href=3D"mailto:fritchleybohrer@gmail.c=
om" target=3D"_blank">fritchleybohrer@gmail.com</a>&gt;<br>
&gt; ---<br>
<br>
This is less of a bug fix and more of a new feature.=C2=A0 I was ducking it=
 for<br>
awhile because the Linux kernel support for masked MSIs with the RISC-V IOM=
MU<br>
isn&#39;t there yet, but I&#39;m glad you went ahead and implemented it any=
way.<br>
<br>
One comment:<br>
<br>
&gt;=C2=A0 =C2=A0hw/riscv/riscv-iommu-sys.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 67 +=
+++-<br>
&gt;=C2=A0 =C2=A0hw/riscv/riscv-iommu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 12 +<br>
&gt;=C2=A0 =C2=A0hw/riscv/riscv-iommu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 =C2=A0tests/qtest/iommu-riscv-test.c | 461 +++++++++++++++++++++=
++++++++++++<br>
&gt;=C2=A0 =C2=A04 files changed, 541 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c<b=
r>
&gt; index 258c171efd..96d2bdff7a 100644<br>
&gt; --- a/hw/riscv/riscv-iommu-sys.c<br>
&gt; +++ b/hw/riscv/riscv-iommu-sys.c<br>
&gt; @@ -52,8 +52,50 @@ struct RISCVIOMMUStateSys {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion msix_pba_mmio;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t *msix_table;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t *msix_pba;<br>
&gt; +=C2=A0 =C2=A0 /* Platform MSI state; the reserved PBA region does not=
 expose it. */<br>
<br>
Can you add the riscv-iommu/riscv-aia citation that says that the PBA regio=
n doesn&#39;t<br>
need update for this kind of masking?=C2=A0 As far as I&#39;m aware we woul=
d need to update<br>
msix_pba too, along with the msi_pending array you created.=C2=A0 Basically=
 every time<br>
you set s-&gt;msi_pending[vector] =3D true you would write &#39;1&#39; in m=
six_pba[vector],<br>
and likewise when you&#39;re seeting s-&gt;msi_pending[vector] =3D false.<b=
r>
<br>
In fact, do we need s-&gt;msi_pending?=C2=A0 Can&#39;t we just use msix_pba=
 directly?<br>
<br>
<br>
Thanks,<br>
Daniel<br>
<br>
<br>
<br>
&gt; +=C2=A0 =C2=A0 bool msi_pending[RISCV_IOMMU_PCI_MSIX_VECTORS];<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static void riscv_iommu_sysdev_send_MSI_unmasked(RISCVIOMMUStateSys *=
s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t vector);<br>
&gt; +<br>
&gt; +static bool riscv_iommu_sysdev_msi_masked(RISCVIOMMUStateSys *s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 uint32_t vector)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint8_t *table_entry;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 g_assert(vector &lt; RISCV_IOMMU_PCI_MSIX_VECTORS);<br>
&gt; +=C2=A0 =C2=A0 table_entry =3D s-&gt;msix_table + vector * PCI_MSIX_EN=
TRY_SIZE;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return pci_get_long(table_entry + PCI_MSIX_ENTRY_VECTOR=
_CTRL) &amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PCI_MSIX_ENTRY_CTRL_MASKBIT;=
<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void riscv_iommu_sysdev_release_pending(RISCVIOMMUStateSys *s,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 uint32_t vector)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /* Retain deferred MSI messages until MSI mode is resto=
red. */<br>
&gt; +=C2=A0 =C2=A0 if (riscv_iommu_reg_get32(&amp;s-&gt;iommu, RISCV_IOMMU=
_REG_FCTL) &amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 RISCV_IOMMU_FCTL_WSI) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;msi_pending[vector] &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 !riscv_iommu_sysdev_msi_masked(s, vector)=
) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;msi_pending[vector] =3D false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_iommu_sysdev_send_MSI_unmasked(s, v=
ector);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void riscv_iommu_sysdev_msi_enabled(RISCVIOMMUState *iommu)<br=
>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 RISCVIOMMUStateSys *s =3D container_of(iommu, RISCVIOMM=
UStateSys, iommu);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (unsigned vector =3D 0; vector &lt; ARRAY_SIZE(s-&g=
t;msi_pending); vector++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_iommu_sysdev_release_pending(s, vec=
tor);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0static uint64_t msix_table_mmio_read(void *opaque, hwaddr =
addr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsig=
ned size)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; @@ -67,9 +109,17 @@ static void msix_table_mmio_write(void *opaque, hw=
addr addr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t val,=
 unsigned size)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0RISCVIOMMUStateSys *s =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 uint32_t vector =3D addr / PCI_MSIX_ENTRY_SIZE;<br>
&gt; +=C2=A0 =C2=A0 bool was_masked;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0g_assert(addr + size &lt;=3D RISCV_IOMMU_PCI=
_MSIX_VECTORS * PCI_MSIX_ENTRY_SIZE);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 was_masked =3D riscv_iommu_sysdev_msi_masked(s, vector)=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pci_set_long(s-&gt;msix_table + addr, val);<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (was_masked &amp;&amp; !riscv_iommu_sysdev_msi_maske=
d(s, vector)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_iommu_sysdev_release_pending(s, vec=
tor);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static const MemoryRegionOps msix_table_mmio_ops =3D {<br>
&gt; @@ -134,8 +184,8 @@ static void riscv_iommu_sysdev_init_msi(RISCVIOMMU=
StateSys *s,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;s-&gt;msix_pba_=
mmio);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -static void riscv_iommu_sysdev_send_MSI(RISCVIOMMUStateSys *s,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint=
32_t vector)<br>
&gt; +static void riscv_iommu_sysdev_send_MSI_unmasked(RISCVIOMMUStateSys *=
s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t vector)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t *table_entry =3D s-&gt;msix_table + =
vector * PCI_MSIX_ENTRY_SIZE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t msi_addr =3D pci_get_quad(table_ent=
ry + PCI_MSIX_ENTRY_LOWER_ADDR);<br>
&gt; @@ -160,6 +210,17 @@ static void riscv_iommu_sysdev_send_MSI(RISCVIOMM=
UStateSys *s,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static void riscv_iommu_sysdev_send_MSI(RISCVIOMMUStateSys *s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint=
32_t vector)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (riscv_iommu_sysdev_msi_masked(s, vector)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;msi_pending[vector] =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sysdev_send_MSI_unmasked(s, vector);<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0static void riscv_iommu_sysdev_notify(RISCVIOMMUState *iom=
mu,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0unsigned vector)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; @@ -194,6 +255,7 @@ static void riscv_iommu_sys_realize(DeviceState *d=
ev, Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;iommu.notify =3D riscv_iommu_sysdev_no=
tify;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;iommu.msi_enabled =3D riscv_iommu_sysdev_msi_enab=
led;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* 4 IRQs are defined starting from s-&gt;ba=
se_irq */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0for (int i =3D 0; i &lt; RISCV_IOMMU_INTR_CO=
UNT; i++) {<br>
&gt; @@ -255,6 +317,7 @@ static void riscv_iommu_sys_reset_hold(Object *obj=
, ResetType type)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0RISCVIOMMUState *iommu =3D &amp;sys-&gt;iomm=
u;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0riscv_iommu_reset(iommu);<br>
&gt; +=C2=A0 =C2=A0 memset(sys-&gt;msi_pending, 0, sizeof(sys-&gt;msi_pendi=
ng));<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_riscv_iommu_sys_reset_hold(type);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c<br>
&gt; index 323a041b4a..23b6f8da86 100644<br>
&gt; --- a/hw/riscv/riscv-iommu.c<br>
&gt; +++ b/hw/riscv/riscv-iommu.c<br>
&gt; @@ -2419,6 +2419,7 @@ static MemTxResult riscv_iommu_mmio_write(void *=
opaque, hwaddr addr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0RISCVIOMMUState *s =3D opaque;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t regb =3D addr &amp; ~3;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t busy =3D 0;<br>
&gt; +=C2=A0 =C2=A0 uint32_t old_fctl =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t val =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool cy_inh =3D false;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -2434,6 +2435,10 @@ static MemTxResult riscv_iommu_mmio_write(void =
*opaque, hwaddr addr,<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Track actionable MMIO write. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (regb) {<br>
&gt; +=C2=A0 =C2=A0 case RISCV_IOMMU_REG_FCTL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 old_fctl =3D riscv_iommu_reg_get32(s, RIS=
CV_IOMMU_REG_FCTL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case RISCV_IOMMU_REG_DDTP:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case RISCV_IOMMU_REG_DDTP + 4:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0process_fn =3D riscv_iommu_pro=
cess_ddtp;<br>
&gt; @@ -2510,6 +2515,13 @@ static MemTxResult riscv_iommu_mmio_write(void =
*opaque, hwaddr addr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0riscv_iommu_write_reg_val(s, &amp;s-&gt;regs=
[addr], addr, size, data);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 if (regb =3D=3D RISCV_IOMMU_REG_FCTL &amp;&amp; s-&gt;m=
si_enabled &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (old_fctl &amp; RISCV_IOMMU_FCTL_WSI) &am=
p;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 !(riscv_iommu_reg_get32(s, RISCV_IOMMU_RE=
G_FCTL) &amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISCV_IOMMU_FCTL_WSI)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;msi_enabled(s);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Busy flag update, MSB 4-byte register. */=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (busy) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t rw =3D ldl_le_p(&amp;=
s-&gt;regs[regb]);<br>
&gt; diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h<br>
&gt; index 7c470ba084..ea1b53e732 100644<br>
&gt; --- a/hw/riscv/riscv-iommu.h<br>
&gt; +++ b/hw/riscv/riscv-iommu.h<br>
&gt; @@ -61,6 +61,9 @@ struct RISCVIOMMUState {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* interrupt notifier */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0void (*notify)(RISCVIOMMUState *iommu, unsig=
ned vector);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 /* Optional platform callback when FCTL switches from W=
SI to MSI. */<br>
&gt; +=C2=A0 =C2=A0 void (*msi_enabled)(RISCVIOMMUState *iommu);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* IOMMU target address space */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AddressSpace *target_as;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion *target_mr;<br>
&gt; diff --git a/tests/qtest/iommu-riscv-test.c b/tests/qtest/iommu-riscv-=
test.c<br>
&gt; index <a href=3D"tel:(263)%20802-4891" value=3D"+12638024891" target=
=3D"_blank">2638024891</a>..979a976e4f 100644<br>
&gt; --- a/tests/qtest/iommu-riscv-test.c<br>
&gt; +++ b/tests/qtest/iommu-riscv-test.c<br>
&gt; @@ -19,6 +19,28 @@<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#define DMA_LEN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04<=
br>
&gt;=C2=A0 =C2=A0<br>
&gt; +#define RISCV_IOMMU_SYS_MSI_TARGET0=C2=A0 (QRIOMMU_SPACE_OFFS + 0x030=
00000ull)<br>
&gt; +#define RISCV_IOMMU_SYS_MSI_TARGET1=C2=A0 (RISCV_IOMMU_SYS_MSI_TARGET=
0 + 4)<br>
&gt; +#define RISCV_IOMMU_SYS_CQ_BASE=C2=A0 =C2=A0 =C2=A0 \<br>
&gt; +=C2=A0 =C2=A0 (QRIOMMU_SPACE_OFFS + QRIOMMU_CQ_BASE_ADDR)<br>
&gt; +#define RISCV_IOMMU_SYS_MSI_DATA0=C2=A0 =C2=A0 0x12345678<br>
&gt; +#define RISCV_IOMMU_SYS_MSI_DATA1=C2=A0 =C2=A0 0xa5a55a5a<br>
&gt; +<br>
&gt; +/* RISC-V virt machine PLIC, hart 0 M-mode context. */<br>
&gt; +#define RISCV_PLIC_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00x0c000000<br>
&gt; +#define RISCV_PLIC_PENDING=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (RISCV_P=
LIC_BASE + 0x1000)<br>
&gt; +#define RISCV_PLIC_ENABLE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(RI=
SCV_PLIC_BASE + 0x2000)<br>
&gt; +#define RISCV_PLIC_THRESHOLD=C2=A0 =C2=A0 =C2=A0 =C2=A0 (RISCV_PLIC_B=
ASE + 0x200000)<br>
&gt; +#define RISCV_PLIC_CLAIM=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (RI=
SCV_PLIC_THRESHOLD + 4)<br>
&gt; +#define RISCV_IOMMU_SYS_IRQ_BASE=C2=A0 =C2=A0 36<br>
&gt; +<br>
&gt; +#define PCI_TESTDEV_TEST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00<br>
&gt; +#define PCI_TESTDEV_WIDTH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1<=
br>
&gt; +#define PCI_TESTDEV_OFFSET=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04<=
br>
&gt; +#define PCI_TESTDEV_DATA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A08<br>
&gt; +#define PCI_TESTDEV_COUNT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 12=
<br>
&gt; +#define PCI_TESTDEV_NO_EVENTFD=C2=A0 =C2=A0 =C2=A0 =C2=A00<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0/* RISC-V virt machine PCI configuration */<br>
&gt;=C2=A0 =C2=A0#define RISCV_GPEX_PIO_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x3=
000000<br>
&gt;=C2=A0 =C2=A0#define RISCV_BUS_PIO_LIMIT=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1=
0000<br>
&gt; @@ -264,6 +286,425 @@ static void test_riscv_iommu_nested(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0run_riscv_iommu_translation(&amp;cfg);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static void riscv_iommu_sys_set_wsi(QTestState *qts, bool wsi)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint64_t base =3D VIRT_RISCV_IOMMU_BASE;<br>
&gt; +=C2=A0 =C2=A0 uint32_t fctl;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Feature changes require Off mode and all in-memory q=
ueues disabled. */<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmphex(qtest_readq(qts, base + RISCV_IOMMU_REG=
_DDTP) &amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (RISCV_IOMMU_DDTP_MODE | RISCV_IOMMU_DDTP_BUSY),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D=3D, RISCV_IOMMU_DDTP_MODE_OFF);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmphex(qtest_readl(qts, base + RISCV_IOMMU_REG=
_CQCSR) &amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (RISCV_IOMMU_CQCSR_CQEN | RISCV_IOMMU_CQCSR_CQON |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0RISCV_IOMMU_CQCSR_BUSY), =3D=3D, 0);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmphex(qtest_readl(qts, base + RISCV_IOMMU_REG=
_FQCSR) &amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (RISCV_IOMMU_FQCSR_FQEN | RISCV_IOMMU_FQCSR_FQON |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0RISCV_IOMMU_FQCSR_BUSY), =3D=3D, 0);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmphex(qtest_readl(qts, base + RISCV_IOMMU_REG=
_PQCSR) &amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 (RISCV_IOMMU_PQCSR_PQEN | RISCV_IOMMU_PQCSR_PQON |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0RISCV_IOMMU_PQCSR_BUSY), =3D=3D, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 fctl =3D qtest_readl(qts, base + RISCV_IOMMU_REG_FCTL);=
<br>
&gt; +=C2=A0 =C2=A0 fctl =3D (fctl &amp; ~RISCV_IOMMU_FCTL_WSI) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(wsi ? RISCV_IOMMU_FCTL_WSI =
: 0);<br>
&gt; +=C2=A0 =C2=A0 qtest_writel(qts, base + RISCV_IOMMU_REG_FCTL, fctl);<b=
r>
&gt; +=C2=A0 =C2=A0 g_assert_cmphex(qtest_readl(qts, base + RISCV_IOMMU_REG=
_FCTL) &amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 RISCV_IOMMU_FCTL_WSI, =3D=3D, fctl &amp; RISCV_IOMMU_FCTL_WSI);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static QTestState *riscv_iommu_sys_test_init(const char *extra_args)<=
br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 QTestState *qts;<br>
&gt; +=C2=A0 =C2=A0 uint64_t cap;<br>
&gt; +=C2=A0 =C2=A0 uint32_t igs;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!qtest_has_machine(&quot;virt&quot;)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_test_skip(&quot;virt machine not availa=
ble&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qts =3D qtest_initf(&quot;-machine virt,aia=3Dnone,acpi=
=3Doff,iommu-sys=3Don &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 &quot;-cpu max -smp 1 -m 512 -net none -nodefaults %s&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 extra_args ? extra_args : &quot;&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 cap =3D qtest_readq(qts, VIRT_RISCV_IOMMU_BASE + RISCV_=
IOMMU_REG_CAP);<br>
&gt; +=C2=A0 =C2=A0 igs =3D (cap &amp; RISCV_IOMMU_CAP_IGS) &gt;&gt; 28;<br=
>
&gt; +=C2=A0 =C2=A0 g_assert_cmpuint(igs, &lt;=3D, RISCV_IOMMU_CAP_IGS_BOTH=
);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmpuint(igs, !=3D, RISCV_IOMMU_CAP_IGS_WSI);<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_set_wsi(qts, false);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return qts;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static QPCIDevice *riscv_iommu_sys_init_msi_sink(QTestState *qts,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QGenericPCIBus *gbus,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QPCIBar *bar,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t *target,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t *data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 QPCIDevice *dev =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 uint32_t offset;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qpci_init_generic(gbus, qts, NULL, false);<br>
&gt; +=C2=A0 =C2=A0 riscv_config_qpci_bus(gbus);<br>
&gt; +=C2=A0 =C2=A0 qpci_device_foreach(&amp;gbus-&gt;bus, PCI_VENDOR_ID_RE=
DHAT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 PCI_DEVICE_ID_REDHAT_TEST, save_fn, &amp;dev);<br>
&gt; +=C2=A0 =C2=A0 g_assert(dev);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qpci_device_enable(dev);<br>
&gt; +=C2=A0 =C2=A0 *bar =3D qpci_iomap(dev, 0, NULL);<br>
&gt; +=C2=A0 =C2=A0 g_assert_false(bar-&gt;is_io);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qpci_io_writeb(dev, *bar, PCI_TESTDEV_TEST, PCI_TESTDEV=
_NO_EVENTFD);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmpuint(qpci_io_readb(dev, *bar, PCI_TESTDEV_W=
IDTH), =3D=3D, 1);<br>
&gt; +=C2=A0 =C2=A0 offset =3D qpci_io_readl(dev, *bar, PCI_TESTDEV_OFFSET)=
;<br>
&gt; +=C2=A0 =C2=A0 *data =3D qpci_io_readl(dev, *bar, PCI_TESTDEV_DATA);<b=
r>
&gt; +=C2=A0 =C2=A0 *target =3D bar-&gt;addr + offset;<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmpuint(qpci_io_readl(dev, *bar, PCI_TESTDEV_C=
OUNT), =3D=3D, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return dev;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void riscv_iommu_sys_program_msi(QTestState *qts, unsigned vec=
tor,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint=
64_t target, uint32_t data,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool=
 masked)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint64_t entry =3D VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_=
REG_MSI_CONFIG +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0vector * PCI_MSIX_ENTRY_SIZE;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qtest_writeq(qts, entry + PCI_MSIX_ENTRY_LOWER_ADDR, ta=
rget);<br>
&gt; +=C2=A0 =C2=A0 qtest_writel(qts, entry + PCI_MSIX_ENTRY_DATA, data);<b=
r>
&gt; +=C2=A0 =C2=A0 qtest_writel(qts, entry + PCI_MSIX_ENTRY_VECTOR_CTRL,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0masked =
? PCI_MSIX_ENTRY_CTRL_MASKBIT : 0);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void riscv_iommu_sys_set_mask(QTestState *qts, unsigned vector=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool masked)=
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint64_t entry =3D VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_=
REG_MSI_CONFIG +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0vector * PCI_MSIX_ENTRY_SIZE;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qtest_writel(qts, entry + PCI_MSIX_ENTRY_VECTOR_CTRL,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0masked =
? PCI_MSIX_ENTRY_CTRL_MASKBIT : 0);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void riscv_iommu_sys_setup_cq(QTestState *qts)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint64_t cqb =3D (RISCV_IOMMU_SYS_CQ_BASE &gt;&gt; 12) =
&lt;&lt; 10;<br>
&gt; +=C2=A0 =C2=A0 uint32_t cqcsr;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qtest_writeq(qts, RISCV_IOMMU_SYS_CQ_BASE, UINT64_MAX);=
<br>
&gt; +=C2=A0 =C2=A0 qtest_writeq(qts, RISCV_IOMMU_SYS_CQ_BASE + 8, 0);<br>
&gt; +=C2=A0 =C2=A0 qtest_writeq(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_R=
EG_CQB, cqb);<br>
&gt; +=C2=A0 =C2=A0 qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_R=
EG_CQT, 0);<br>
&gt; +=C2=A0 =C2=A0 qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_R=
EG_CQCSR,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RISCV_I=
OMMU_CQCSR_CQEN | RISCV_IOMMU_CQCSR_CIE);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 cqcsr =3D qtest_readl(qts,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmphex(cqcsr &amp; RISCV_IOMMU_CQCSR_CQON,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D=3D, RISCV_IOMMU_CQCSR_CQON);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void riscv_iommu_sys_trigger_cq_irq(QTestState *qts)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint32_t cqcsr;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_R=
EG_CQT, 1);<br>
&gt; +=C2=A0 =C2=A0 cqcsr =3D qtest_readl(qts,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmphex(cqcsr &amp; RISCV_IOMMU_CQCSR_CMD_ILL,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D=3D, RISCV_IOMMU_CQCSR_CMD_ILL);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void riscv_iommu_sys_rearm_cq_irq(QTestState *qts)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint32_t cqcsr;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_R=
EG_CQT, 0);<br>
&gt; +=C2=A0 =C2=A0 qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_R=
EG_CQCSR,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RISCV_I=
OMMU_CQCSR_CQEN | RISCV_IOMMU_CQCSR_CIE |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RISCV_I=
OMMU_CQCSR_CMD_ILL);<br>
&gt; +=C2=A0 =C2=A0 cqcsr =3D qtest_readl(qts,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_REG_CQCSR);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmphex(cqcsr &amp; RISCV_IOMMU_CQCSR_CMD_ILL, =
=3D=3D, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_R=
EG_IPSR,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RISCV_I=
OMMU_IPSR_CIP);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmphex(qtest_readl(qts, VIRT_RISCV_IOMMU_BASE =
+<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RISCV_IOMMU_REG_IPSR) &amp; RISCV=
_IOMMU_IPSR_CIP,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D=3D, 0);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void test_riscv_iommu_sys_msi_unmasked(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 QTestState *qts =3D riscv_iommu_sys_test_init(NULL);<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!qts) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET0, 0);<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI=
_TARGET0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISCV_IOMMU_SYS_MSI_DATA0, false=
);<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_setup_cq(qts);<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_trigger_cq_irq(qts);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TA=
RGET0),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D=3D, RISCV_IOMMU_SYS_MSI_DATA0);<br>
&gt; +=C2=A0 =C2=A0 qtest_quit(qts);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void test_riscv_iommu_sys_msi_masked(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 QGenericPCIBus gbus;<br>
&gt; +=C2=A0 =C2=A0 QPCIBar sink_bar;<br>
&gt; +=C2=A0 =C2=A0 QPCIDevice *sink;<br>
&gt; +=C2=A0 =C2=A0 QTestState *qts =3D riscv_iommu_sys_test_init(&quot;-de=
vice pci-testdev&quot;);<br>
&gt; +=C2=A0 =C2=A0 uint64_t sink_target;<br>
&gt; +=C2=A0 =C2=A0 uint32_t sink_data;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!qts) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 sink =3D riscv_iommu_sys_init_msi_sink(qts, &amp;gbus, =
&amp;sink_bar,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&amp;sink_target, &amp;sink_data);<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_program_msi(qts, 0, sink_target, sink_d=
ata, true);<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_setup_cq(qts);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_trigger_cq_irq(qts);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TEST=
DEV_COUNT), =3D=3D, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_rearm_cq_irq(qts);<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_trigger_cq_irq(qts);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TEST=
DEV_COUNT), =3D=3D, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_set_mask(qts, 0, false);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TEST=
DEV_COUNT), =3D=3D, 1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_set_mask(qts, 0, false);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TEST=
DEV_COUNT), =3D=3D, 1);<br>
&gt; +=C2=A0 =C2=A0 g_free(sink);<br>
&gt; +=C2=A0 =C2=A0 qtest_quit(qts);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void test_riscv_iommu_sys_msi_config_update(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 QTestState *qts =3D riscv_iommu_sys_test_init(NULL);<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!qts) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET0, 0);<br>
&gt; +=C2=A0 =C2=A0 qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET1, 0);<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI=
_TARGET0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISCV_IOMMU_SYS_MSI_DATA0, true)=
;<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_setup_cq(qts);<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_trigger_cq_irq(qts);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Updating a masked entry must not release the deferre=
d message. */<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI=
_TARGET1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISCV_IOMMU_SYS_MSI_DATA1, true)=
;<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TA=
RGET0), =3D=3D, 0);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TA=
RGET1), =3D=3D, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Release uses the current address and data, rather th=
an a snapshot. */<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_set_mask(qts, 0, false);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TA=
RGET0), =3D=3D, 0);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TA=
RGET1),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D=3D, RISCV_IOMMU_SYS_MSI_DATA1);<br>
&gt; +=C2=A0 =C2=A0 qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET1, 0);<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_set_mask(qts, 0, false);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TA=
RGET1), =3D=3D, 0);<br>
&gt; +=C2=A0 =C2=A0 qtest_quit(qts);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void test_riscv_iommu_sys_msi_vector_isolation(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 QTestState *qts =3D riscv_iommu_sys_test_init(NULL);<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!qts) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET0, 0);<br>
&gt; +=C2=A0 =C2=A0 qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET1, 0);<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI=
_TARGET0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISCV_IOMMU_SYS_MSI_DATA0, true)=
;<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_program_msi(qts, 1, RISCV_IOMMU_SYS_MSI=
_TARGET1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISCV_IOMMU_SYS_MSI_DATA1, false=
);<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_setup_cq(qts);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_trigger_cq_irq(qts);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TA=
RGET0), =3D=3D, 0);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TA=
RGET1), =3D=3D, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_rearm_cq_irq(qts);<br>
&gt; +=C2=A0 =C2=A0 qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_R=
EG_ICVEC, 1);<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_trigger_cq_irq(qts);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TA=
RGET0), =3D=3D, 0);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TA=
RGET1),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D=3D, RISCV_IOMMU_SYS_MSI_DATA1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_set_mask(qts, 0, false);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TA=
RGET0),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D=3D, RISCV_IOMMU_SYS_MSI_DATA0);<br>
&gt; +=C2=A0 =C2=A0 qtest_quit(qts);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void test_riscv_iommu_sys_msi_wsi_switch(const void *opaque)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 bool unmask_in_wsi =3D GPOINTER_TO_INT(opaque);<br>
&gt; +=C2=A0 =C2=A0 QGenericPCIBus gbus;<br>
&gt; +=C2=A0 =C2=A0 QPCIBar sink_bar;<br>
&gt; +=C2=A0 =C2=A0 QPCIDevice *sink;<br>
&gt; +=C2=A0 =C2=A0 QTestState *qts =3D riscv_iommu_sys_test_init(&quot;-de=
vice pci-testdev&quot;);<br>
&gt; +=C2=A0 =C2=A0 uint64_t sink_target;<br>
&gt; +=C2=A0 =C2=A0 uint32_t sink_data;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!qts) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmpuint((qtest_readq(qts, VIRT_RISCV_IOMMU_BAS=
E +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RISCV_IOMMU_REG_CAP) &amp;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 RISCV_IOMMU_CAP_IGS) &gt;&gt; 28,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=3D=3D, RISCV_IOMMU_CAP_IGS_BOTH);<br>
&gt; +=C2=A0 =C2=A0 sink =3D riscv_iommu_sys_init_msi_sink(qts, &amp;gbus, =
&amp;sink_bar,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&amp;sink_target, &amp;sink_data);<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_program_msi(qts, 0, sink_target, sink_d=
ata, true);<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_setup_cq(qts);<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_trigger_cq_irq(qts);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TEST=
DEV_COUNT), =3D=3D, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Stop the CQ before changing FCTL, preserving the def=
erred message. */<br>
&gt; +=C2=A0 =C2=A0 qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_R=
EG_CQCSR, 0);<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_set_wsi(qts, true);<br>
&gt; +=C2=A0 =C2=A0 if (unmask_in_wsi) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 riscv_iommu_sys_set_mask(qts, 0, false);<=
br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TEST=
DEV_COUNT), =3D=3D, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_set_wsi(qts, false);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TEST=
DEV_COUNT),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=3D=3D, unmask_in_wsi ? 1 : 0);<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_set_mask(qts, 0, false);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TEST=
DEV_COUNT), =3D=3D, 1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Repeated mode changes and unmask writes must not rep=
lay the MSI. */<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_set_wsi(qts, true);<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_set_wsi(qts, false);<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_set_mask(qts, 0, false);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TEST=
DEV_COUNT), =3D=3D, 1);<br>
&gt; +=C2=A0 =C2=A0 g_free(sink);<br>
&gt; +=C2=A0 =C2=A0 qtest_quit(qts);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void test_riscv_iommu_sys_wsi_delivery(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 const unsigned vector =3D 1;<br>
&gt; +=C2=A0 =C2=A0 const unsigned irq =3D RISCV_IOMMU_SYS_IRQ_BASE + vecto=
r;<br>
&gt; +=C2=A0 =C2=A0 const uint32_t irq_bit =3D 1U &lt;&lt; (irq % 32);<br>
&gt; +=C2=A0 =C2=A0 const unsigned irq_word =3D (irq / 32) * 4;<br>
&gt; +=C2=A0 =C2=A0 QGenericPCIBus gbus;<br>
&gt; +=C2=A0 =C2=A0 QPCIBar sink_bar;<br>
&gt; +=C2=A0 =C2=A0 QPCIDevice *sink;<br>
&gt; +=C2=A0 =C2=A0 QTestState *qts =3D riscv_iommu_sys_test_init(&quot;-de=
vice pci-testdev&quot;);<br>
&gt; +=C2=A0 =C2=A0 uint64_t sink_target;<br>
&gt; +=C2=A0 =C2=A0 uint32_t sink_data;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!qts) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 sink =3D riscv_iommu_sys_init_msi_sink(qts, &amp;gbus, =
&amp;sink_bar,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&amp;sink_target, &amp;sink_data);<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_set_wsi(qts, true);<br>
&gt; +=C2=A0 =C2=A0 /* The MSI vector mask must not suppress delivery throu=
gh the wire. */<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_program_msi(qts, vector, sink_target, s=
ink_data, true);<br>
&gt; +=C2=A0 =C2=A0 qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_R=
EG_ICVEC, vector);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qtest_writel(qts, RISCV_PLIC_BASE + irq * 4, 1);<br>
&gt; +=C2=A0 =C2=A0 qtest_writel(qts, RISCV_PLIC_ENABLE + irq_word, irq_bit=
);<br>
&gt; +=C2=A0 =C2=A0 qtest_writel(qts, RISCV_PLIC_THRESHOLD, 0);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmphex(qtest_readl(qts, RISCV_PLIC_PENDING + i=
rq_word), =3D=3D, 0);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmpuint(qtest_readl(qts, RISCV_PLIC_CLAIM), =
=3D=3D, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_setup_cq(qts);<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_trigger_cq_irq(qts);<br>
&gt; +=C2=A0 =C2=A0 /* The PLIC latches the pulse after the device&#39;s wi=
re returns low. */<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmphex(qtest_readl(qts, RISCV_PLIC_PENDING + i=
rq_word),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D=3D, irq_bit);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmpuint(qtest_readl(qts, RISCV_PLIC_CLAIM), =
=3D=3D, irq);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmphex(qtest_readl(qts, RISCV_PLIC_PENDING + i=
rq_word), =3D=3D, 0);<br>
&gt; +=C2=A0 =C2=A0 qtest_writel(qts, RISCV_PLIC_CLAIM, irq);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TEST=
DEV_COUNT), =3D=3D, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* A WSI event must not become a deferred MSI after swi=
tching modes. */<br>
&gt; +=C2=A0 =C2=A0 qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_R=
EG_CQCSR, 0);<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_set_wsi(qts, false);<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_set_mask(qts, vector, false);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmpuint(qpci_io_readl(sink, sink_bar, PCI_TEST=
DEV_COUNT), =3D=3D, 0);<br>
&gt; +=C2=A0 =C2=A0 g_free(sink);<br>
&gt; +=C2=A0 =C2=A0 qtest_quit(qts);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void test_riscv_iommu_sys_msi_wsi_reset(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 QTestState *qts =3D riscv_iommu_sys_test_init(NULL);<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!qts) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET0, 0);<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI=
_TARGET0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISCV_IOMMU_SYS_MSI_DATA0, true)=
;<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_setup_cq(qts);<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_trigger_cq_irq(qts);<br>
&gt; +=C2=A0 =C2=A0 qtest_writel(qts, VIRT_RISCV_IOMMU_BASE + RISCV_IOMMU_R=
EG_CQCSR, 0);<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_set_wsi(qts, true);<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_set_mask(qts, 0, false);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TA=
RGET0), =3D=3D, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qtest_system_reset(qts);<br>
&gt; +=C2=A0 =C2=A0 /* Reprogram valid MSI state without depending on table=
 reset values. */<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_set_wsi(qts, true);<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI=
_TARGET0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISCV_IOMMU_SYS_MSI_DATA1, false=
);<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_set_wsi(qts, false);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TA=
RGET0), =3D=3D, 0);<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_set_mask(qts, 0, true);<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_set_mask(qts, 0, false);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TA=
RGET0), =3D=3D, 0);<br>
&gt; +=C2=A0 =C2=A0 qtest_quit(qts);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void test_riscv_iommu_sys_msi_reset(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 QTestState *qts =3D riscv_iommu_sys_test_init(NULL);<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!qts) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qtest_writel(qts, RISCV_IOMMU_SYS_MSI_TARGET0, 0);<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_program_msi(qts, 0, RISCV_IOMMU_SYS_MSI=
_TARGET0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RISCV_IOMMU_SYS_MSI_DATA0, true)=
;<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_setup_cq(qts);<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_trigger_cq_irq(qts);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TA=
RGET0), =3D=3D, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qtest_system_reset(qts);<br>
&gt; +=C2=A0 =C2=A0 riscv_iommu_sys_set_mask(qts, 0, false);<br>
&gt; +=C2=A0 =C2=A0 g_assert_cmphex(qtest_readl(qts, RISCV_IOMMU_SYS_MSI_TA=
RGET0), =3D=3D, 0);<br>
&gt; +=C2=A0 =C2=A0 qtest_quit(qts);<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0g_test_init(&amp;argc, &amp;argv, NULL);<br>
&gt; @@ -275,5 +716,25 @@ int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 test_riscv_iommu_g_stage_only);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qtest_add_func(&quot;/iommu-testdev/translat=
ion/ns-nested&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 test_riscv_iommu_nested);<br>
&gt; +=C2=A0 =C2=A0 qtest_add_func(&quot;/riscv-iommu-sys/msi/unmasked&quot=
;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
test_riscv_iommu_sys_msi_unmasked);<br>
&gt; +=C2=A0 =C2=A0 qtest_add_func(&quot;/riscv-iommu-sys/msi/masked&quot;,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
test_riscv_iommu_sys_msi_masked);<br>
&gt; +=C2=A0 =C2=A0 qtest_add_func(&quot;/riscv-iommu-sys/msi/config-update=
&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
test_riscv_iommu_sys_msi_config_update);<br>
&gt; +=C2=A0 =C2=A0 qtest_add_func(&quot;/riscv-iommu-sys/msi/vector-isolat=
ion&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
test_riscv_iommu_sys_msi_vector_isolation);<br>
&gt; +=C2=A0 =C2=A0 qtest_add_data_func(&quot;/riscv-iommu-sys/msi/wsi-swit=
ch-unmasked&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 GINT_TO_POINTER(true),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 test_riscv_iommu_sys_msi_wsi_switch);<br>
&gt; +=C2=A0 =C2=A0 qtest_add_data_func(&quot;/riscv-iommu-sys/msi/wsi-swit=
ch-masked&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 GINT_TO_POINTER(false),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 test_riscv_iommu_sys_msi_wsi_switch);<br>
&gt; +=C2=A0 =C2=A0 qtest_add_func(&quot;/riscv-iommu-sys/wsi/delivery&quot=
;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
test_riscv_iommu_sys_wsi_delivery);<br>
&gt; +=C2=A0 =C2=A0 qtest_add_func(&quot;/riscv-iommu-sys/msi/wsi-reset&quo=
t;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
test_riscv_iommu_sys_msi_wsi_reset);<br>
&gt; +=C2=A0 =C2=A0 qtest_add_func(&quot;/riscv-iommu-sys/msi/reset&quot;,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
test_riscv_iommu_sys_msi_reset);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return g_test_run();<br>
&gt;=C2=A0 =C2=A0}<br>
<br>
</blockquote></div>

--0000000000002c587f065f058d02--

