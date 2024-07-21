Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9509FC3DA59
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2024 02:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVMRl-0003FD-CJ; Sat, 20 Jul 2024 22:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pykfirst@gmail.com>)
 id 1sVMRi-0003Ee-QU
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 22:37:10 -0400
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pykfirst@gmail.com>)
 id 1sVMRf-0007j1-GE
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 22:37:10 -0400
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6ad86f3cc34so18504846d6.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 19:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721529425; x=1722134225; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=44otZtK80sVCzn9krLuxIPwb4HtMcylbrQef21NWXos=;
 b=HuXls6x57gjDExHNiAB20+ahpY5EbhjGwAS59j1VBYhYnToqiWu/f21PVJqqz4m6RA
 Z3Zp2HP4xtOcxQQr1GuSeYmnu6FVTswSGsDg19ImNg2HnNedqLg5AfkotjGNeMmFXVIJ
 i2Azox6cvbxP+bI/+XiLS5X1ZpnH7RNLAtEaPFHToZynj9MtfabCD/uGawTbQrbmgQQJ
 kag9jGPYyDWV0Bt2+RxqofXw4Bwox7BpwXIsSVBxol/EmpDd/P9NR7QvlGM0PaDH8jIQ
 FPOJ3zbWTLUMfFeYmVhhNtMfYXFnDYT/wGd7qlVlBU9KCKmTbIasLJ4UQTCl3FXmRYnI
 KiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721529425; x=1722134225;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=44otZtK80sVCzn9krLuxIPwb4HtMcylbrQef21NWXos=;
 b=AsrZlhje+aKfzNqr0DbRG6/Rij7he/sQxi9ta+YRtmGbFIzaBR7hjXre8X0JDk5fYZ
 pXaRX/Ll8cgZhjsGO16mNUYlPaWJEo+rWi63CX5MRJJVNxJUlPSCsGH47e2MZ5ofwUd6
 mZihuIaJKoY5+5VfyJyhSCD6YsU6FXcb49cyNh/0KDnBegdgs2YCkA+gVlPv0UhIvyBt
 enNunPUbJh2N85L3k6HR5f4SW6H9ktPfnQGk8hFBqlvkz+drlBDafkep3PFqG8kV4+mS
 kwkJvCsfPl5FiStW0rPw5poWaB/YWO9LKgFp6ybf+aICcfUFgIsNRQl+ntuwChp9bncp
 1LGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl9AZTfr5XCmLznQgnJAUdOfmblyh44FFGiRSZPQK99eKHAzJL8fmJHLAjK/qEaJkpvYYlGy0/Ov6G7WmQlLG4voIEpJ0=
X-Gm-Message-State: AOJu0Yzob2ME3qW2oR3zIItH6d9Y9aTibOr2wVkFdygf0N/YNzPJw3KL
 L4s+NnTutiCGAMDues6wM12AyZyE0M0I2170LuX0cdq5FmOXJyrNhUJYdWUiapBnHWVT8/lvYZp
 AJwnSyhvF4MDIUtvNQYoyPkI6utE=
X-Google-Smtp-Source: AGHT+IGvM8xXQLi5fwYEc50nyZ0JMZEov0Cpt45GF/Oy8iU+DEHZJ2tDe/4YMg9Ih6aPAeGYe02YHEa8DInVEien71Y=
X-Received: by 2002:a05:6214:acf:b0:6b0:8fe5:4a98 with SMTP id
 6a1803df08f44-6b95a74e963mr51469556d6.36.1721529425092; Sat, 20 Jul 2024
 19:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240708100816.1916346-1-pykfirst@gmail.com>
 <468ed4a0-14b1-4d0b-9537-9a550b14f0da@eviden.com>
 <20240720150438-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240720150438-mutt-send-email-mst@kernel.org>
From: Yuke Peng <pykfirst@gmail.com>
Date: Sun, 21 Jul 2024 10:36:53 +0800
Message-ID: <CAHJVP31QoonZ5AjottoBWRaLcgKwKcEXZ=TSkoY9KY95wSxt-Q@mail.gmail.com>
Subject: Re: [PATCH v2] hw/i386/intel_iommu: Block CFI when necessary
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 qemu-devel <qemu-devel@nongnu.org>, 
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=pykfirst@gmail.com; helo=mail-qv1-xf30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Sun, Jul 21, 2024 at 3:05=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Jul 09, 2024 at 04:43:25AM +0000, CLEMENT MATHIEU--DRIF wrote:
> > Hi
> >
> > On 08/07/2024 12:08, Yuke Peng wrote:
> > > Caution: External email. Do not open attachments or click links, unle=
ss this email comes from a known sender and you know the content is safe.
> > >
> > >
> > > According to Intel VT-d specification 5.1.4, CFI must be blocked when
> > > Extended Interrupt Mode is enabled or Compatibility format interrupts
> > > are disabled.
> > >
> > > Signed-off-by: Yuke Peng <pykfirst@gmail.com>
> > > ---
> > > Changes in v2:
> > > - Use subsections for the cfi_enabled field.
> > > - Link to v1: https://lore.kernel.org/qemu-devel/20240625112819.86228=
2-1-pykfirst@gmail.com/
> > >
> > > ---
> > >   hw/i386/intel_iommu.c         | 53 ++++++++++++++++++++++++++++++++=
+--
> > >   hw/i386/trace-events          |  1 +
> > >   include/hw/i386/intel_iommu.h |  1 +
> > >   3 files changed, 53 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > > index 5085a6fee3..af9c864bde 100644
> > > --- a/hw/i386/intel_iommu.c
> > > +++ b/hw/i386/intel_iommu.c
> > > @@ -2410,6 +2410,22 @@ static void vtd_handle_gcmd_ire(IntelIOMMUStat=
e *s, bool en)
> > >       }
> > >   }
> > >
> > > +/* Handle Compatibility Format Interrupts Enable/Disable */
> > > +static void vtd_handle_gcmd_cfi(IntelIOMMUState *s, bool en)
> > > +{
> > > +    trace_vtd_cfi_enable(en);
> > > +
> > > +    if (en) {
> > > +        s->cfi_enabled =3D true;
> > > +        /* Ok - report back to driver */
> > > +        vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_CFIS);
> > > +    } else {
> > > +        s->cfi_enabled =3D false;
> > > +        /* Ok - report back to driver */
> > > +        vtd_set_clear_mask_long(s, DMAR_GSTS_REG, VTD_GSTS_CFIS, 0);
> > > +    }
> > > +}
> > > +
> > >   /* Handle write to Global Command Register */
> > >   static void vtd_handle_gcmd_write(IntelIOMMUState *s)
> > >   {
> > > @@ -2440,6 +2456,10 @@ static void vtd_handle_gcmd_write(IntelIOMMUSt=
ate *s)
> > >           /* Interrupt remap enable/disable */
> > >           vtd_handle_gcmd_ire(s, val & VTD_GCMD_IRE);
> > >       }
> > > +    if (changed & VTD_GCMD_CFI) {
> > > +        /* Compatibility format interrupts enable/disable */
> > > +        vtd_handle_gcmd_cfi(s, val & VTD_GCMD_CFI);
> > > +    }
> > >   }
> > >
> > >   /* Handle write to Context Command Register */
> > > @@ -3283,7 +3303,25 @@ static int vtd_post_load(void *opaque, int ver=
sion_id)
> > >       return 0;
> > >   }
> > >
> > > -static const VMStateDescription vtd_vmstate =3D {
> > > +static bool vtd_cfi_needed(void *opaque)
> > > +{
> > > +    IntelIOMMUState *iommu =3D opaque;
> > > +
> > > +    return iommu->intr_enabled && !iommu->intr_eime;
> > > +}
> > > +
> > > +static const VMStateDescription vmstate_vtd_cfi =3D {
> > > +    .name =3D "iommu-intel/cfi",
> > > +    .version_id =3D 1,
> > > +    .minimum_version_id =3D 1,
> > > +    .needed =3D vtd_cfi_needed,
> > > +    .fields =3D (VMStateField[]) {
> > > +        VMSTATE_BOOL(cfi_enabled, IntelIOMMUState),
> > > +        VMSTATE_END_OF_LIST()
> > > +    }
> > > +};
> > > +
> > > +static const VMStateDescription vmstate_vtd =3D {
> > Why is vtd_vmstate renamed to vmstate_vtd? is it necessary?
>
>
>
> Yuke Peng, do you plan to answer this?

Sorry for the late reply and for not using the "reply to all" option.
I will update the reply email:

On Fri, Jul 12, 2024 at 2:56=E2=80=AFAM CLEMENT MATHIEU--DRIF
<clement.mathieu--drif@eviden.com> wrote:
>
> On 11/07/2024 10:19, Yuke Peng wrote:
> >
> > On Tue, Jul 9, 2024 at 12:43=E2=80=AFPM CLEMENT MATHIEU--DRIF <clement.=
mathieu--drif@eviden.com> wrote:
> > >
> > > Hi
> > >
> > > On 08/07/2024 12:08, Yuke Peng wrote:
> > > > +static const VMStateDescription vmstate_vtd_cfi =3D {
> > > > +    .name =3D "iommu-intel/cfi",
> > > > +    .version_id =3D 1,
> > > > +    .minimum_version_id =3D 1,
> > > > +    .needed =3D vtd_cfi_needed,
> > > > +    .fields =3D (VMStateField[]) {
> > > > +        VMSTATE_BOOL(cfi_enabled, IntelIOMMUState),
> > > > +        VMSTATE_END_OF_LIST()
> > > > +    }
> > > > +};
> > > > +
> > > > +static const VMStateDescription vmstate_vtd =3D {
> > > Why is vtd_vmstate renamed to vmstate_vtd? is it necessary?
> > >
> >
> > When I attempted to use vtd_vmstate as a reference to name the
> > cfi subsection. I found the proposed name was a bit odd for me, like
> > "vtd_cfi_vmstate" or "vtd_vmstate_cfi".
> >
> > I checked the other examples using subsections and I found they use
> > vmstate_xxx like "vmstate_serial" and "vmstate_serial_timeout_ipending"=
.
> > So here I rename vtd_vmstate to vmstate_vtd.
>
> Hi,
>
> I can't say if this will be approved or not.
> But if you really think renaming is important, you should make a patch fo=
r that specific change instead of using the same patch for all changes.
>
> Maybe you should consider using "reply all" so that people on the list ca=
n keep track of the conversation.

I had intended to split this patch into two parts, but I've been too
busy to work on it. I'm sorry about that.

>
>
> > >       .name =3D "iommu-intel",
> > >       .version_id =3D 1,
> > >       .minimum_version_id =3D 1,
> > > @@ -3306,6 +3344,10 @@ static const VMStateDescription vtd_vmstate =
=3D {
> > >           VMSTATE_BOOL(intr_enabled, IntelIOMMUState),
> > >           VMSTATE_BOOL(intr_eime, IntelIOMMUState),
> > >           VMSTATE_END_OF_LIST()
> > > +    },
> > > +    .subsections =3D (const VMStateDescription * []) {
> > > +        &vmstate_vtd_cfi,
> > > +        NULL
> > >       }
> > >   };
> > >
> > > @@ -3525,6 +3567,12 @@ static int vtd_interrupt_remap_msi(IntelIOMMUS=
tate *iommu,
> > >
> > >       /* This is compatible mode. */
> > >       if (addr.addr.int_mode !=3D VTD_IR_INT_FORMAT_REMAP) {
> > > +        if (iommu->intr_eime || !iommu->cfi_enabled) {
> > > +            if (do_fault) {
> > > +                vtd_report_ir_fault(iommu, sid, VTD_FR_IR_REQ_COMPAT=
, 0);
> > > +            }
> > > +            return -EINVAL;
> > > +        }
> > >           memcpy(translated, origin, sizeof(*origin));
> > >           goto out;
> > >       }
> > > @@ -3950,6 +3998,7 @@ static void vtd_init(IntelIOMMUState *s)
> > >       s->root_scalable =3D false;
> > >       s->dmar_enabled =3D false;
> > >       s->intr_enabled =3D false;
> > > +    s->cfi_enabled =3D false;
> > >       s->iq_head =3D 0;
> > >       s->iq_tail =3D 0;
> > >       s->iq =3D 0;
> > > @@ -4243,7 +4292,7 @@ static void vtd_class_init(ObjectClass *klass, =
void *data)
> > >       X86IOMMUClass *x86_class =3D X86_IOMMU_DEVICE_CLASS(klass);
> > >
> > >       dc->reset =3D vtd_reset;
> > > -    dc->vmsd =3D &vtd_vmstate;
> > > +    dc->vmsd =3D &vmstate_vtd;
> > >       device_class_set_props(dc, vtd_properties);
> > >       dc->hotpluggable =3D false;
> > >       x86_class->realize =3D vtd_realize;
> > > diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> > > index 53c02d7ac8..ffd87db65f 100644
> > > --- a/hw/i386/trace-events
> > > +++ b/hw/i386/trace-events
> > > @@ -57,6 +57,7 @@ vtd_dmar_translate(uint8_t bus, uint8_t slot, uint8=
_t func, uint64_t iova, uint6
> > >   vtd_dmar_enable(bool en) "enable %d"
> > >   vtd_dmar_fault(uint16_t sid, int fault, uint64_t addr, bool is_writ=
e) "sid 0x%"PRIx16" fault %d addr 0x%"PRIx64" write %d"
> > >   vtd_ir_enable(bool en) "enable %d"
> > > +vtd_cfi_enable(bool en) "enable %d"
> > >   vtd_ir_irte_get(int index, uint64_t lo, uint64_t hi) "index %d low =
0x%"PRIx64" high 0x%"PRIx64
> > >   vtd_ir_remap(int index, int tri, int vec, int deliver, uint32_t des=
t, int dest_mode) "index %d trigger %d vector %d deliver %d dest 0x%"PRIx32=
" mode %d"
> > >   vtd_ir_remap_type(const char *type) "%s"
> > > diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_io=
mmu.h
> > > index 7fa0a695c8..38e20d0f2c 100644
> > > --- a/include/hw/i386/intel_iommu.h
> > > +++ b/include/hw/i386/intel_iommu.h
> > > @@ -294,6 +294,7 @@ struct IntelIOMMUState {
> > >
> > >       /* interrupt remapping */
> > >       bool intr_enabled;              /* Whether guest enabled IR */
> > > +    bool cfi_enabled;               /* Whether CFI is enabled */
> > >       dma_addr_t intr_root;           /* Interrupt remapping table po=
inter */
> > >       uint32_t intr_size;             /* Number of IR table entries *=
/
> > >       bool intr_eime;                 /* Extended interrupt mode enab=
led */
> > > --
> > > 2.34.1
> > >
> > >
>

Yuke Peng

