Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826A9C3DA49
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 19:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVFOH-0003bJ-Gg; Sat, 20 Jul 2024 15:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVFOF-0003aX-OI
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:05:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVFOD-0007hX-5t
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721502302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tl2HcfUodlBvyHHALhNHrxrK4xhHfka1zNQFqDOiK4s=;
 b=NP/yD1xB1AZKj9G1sosK7u//By0m5BcAp0YZKSURVcbZrS2JFI15qt4UQTkPS1fD0I44cl
 2iDUaHhGO+O5UrF2wpQsVg8RKwr992Lcdnlnngp5HkAmYHshzSZc7Z6s9on8zV6SvOx6jM
 G340G4LsiGzy44ylonCk20DCteTlZy4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-Ccv3HU1cNpqwAzNd-wT-FA-1; Sat, 20 Jul 2024 15:05:01 -0400
X-MC-Unique: Ccv3HU1cNpqwAzNd-wT-FA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-426703ac88dso19871645e9.0
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 12:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721502300; x=1722107100;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tl2HcfUodlBvyHHALhNHrxrK4xhHfka1zNQFqDOiK4s=;
 b=u+h9Oqx4vvU35dFjnpCrXpjEZA+hU3g0vF72GZ0KgiZSMRCZwIaTV0KUGRAUpJ+vU3
 UwMWkMiRV7Q9p6yQTYopDpAXs5KGk1dfaQAkc3DoRvCPuaL+TtADAQrBxyQ8OKMS936R
 UPaXyNI6G3juz8Umqia0qTO58nd8jYPbu9H4+kTwfiEwl5SbbcmeJ5i8H/smWpR33/Iv
 rmxe5AXQRo2SzwVAuOnvdeYfMz6Fj3HH5HILNCXmhEMc4m3GTAEq6/ZdisZ+VaWcMN/Y
 K/PkTkb+HDxGsGtkJi9dAUMwcKsE30scEBmEv8pLlMyxLmz9O6Ob5OXTkmPUrFJB0Vps
 s+vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtQTG1dnRRN6TmOua8eOMpvCh9P0Quf/Aca8WzcKYy6DMXEXjbnnQiEcV8XqyhNdvJ9Hl1Foe09SNWkUPi0mZQ77mAFR0=
X-Gm-Message-State: AOJu0YzufcYzJ7hkmk452BAzKesoA8N60g0o48p2l/YDFxxi/ud8u+aK
 gLvPh7Vbb0OqWOiQ92+f5Pwtb0YcGIKceaFVSKVmbNoN5EQyDpVTItJ+IRTOLsYkP9Sl9EbuuaA
 BaX0AXqlsO9NGuEA6QrSKmfhooZqjZGbK8C8DvhOPyKodqCOacUZ4
X-Received: by 2002:a05:600c:4586:b0:426:6822:855 with SMTP id
 5b1f17b1804b1-427dc575129mr11289715e9.36.1721502299748; 
 Sat, 20 Jul 2024 12:04:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG09mhMqRjlvjARRjhV/BjTiLDnbIWpwCyC16WiKiaZUmveFJzx//yks7HM6TCRyu7cv4XLlA==
X-Received: by 2002:a05:600c:4586:b0:426:6822:855 with SMTP id
 5b1f17b1804b1-427dc575129mr11289555e9.36.1721502299092; 
 Sat, 20 Jul 2024 12:04:59 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d68fa171sm66691695e9.1.2024.07.20.12.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 12:04:58 -0700 (PDT)
Date: Sat, 20 Jul 2024 15:04:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: Yuke Peng <pykfirst@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v2] hw/i386/intel_iommu: Block CFI when necessary
Message-ID: <20240720150438-mutt-send-email-mst@kernel.org>
References: <20240708100816.1916346-1-pykfirst@gmail.com>
 <468ed4a0-14b1-4d0b-9537-9a550b14f0da@eviden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <468ed4a0-14b1-4d0b-9537-9a550b14f0da@eviden.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 09, 2024 at 04:43:25AM +0000, CLEMENT MATHIEU--DRIF wrote:
> Hi
> 
> On 08/07/2024 12:08, Yuke Peng wrote:
> > Caution: External email. Do not open attachments or click links, unless this email comes from a known sender and you know the content is safe.
> >
> >
> > According to Intel VT-d specification 5.1.4, CFI must be blocked when
> > Extended Interrupt Mode is enabled or Compatibility format interrupts
> > are disabled.
> >
> > Signed-off-by: Yuke Peng <pykfirst@gmail.com>
> > ---
> > Changes in v2:
> > - Use subsections for the cfi_enabled field.
> > - Link to v1: https://lore.kernel.org/qemu-devel/20240625112819.862282-1-pykfirst@gmail.com/
> >
> > ---
> >   hw/i386/intel_iommu.c         | 53 +++++++++++++++++++++++++++++++++--
> >   hw/i386/trace-events          |  1 +
> >   include/hw/i386/intel_iommu.h |  1 +
> >   3 files changed, 53 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > index 5085a6fee3..af9c864bde 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -2410,6 +2410,22 @@ static void vtd_handle_gcmd_ire(IntelIOMMUState *s, bool en)
> >       }
> >   }
> >
> > +/* Handle Compatibility Format Interrupts Enable/Disable */
> > +static void vtd_handle_gcmd_cfi(IntelIOMMUState *s, bool en)
> > +{
> > +    trace_vtd_cfi_enable(en);
> > +
> > +    if (en) {
> > +        s->cfi_enabled = true;
> > +        /* Ok - report back to driver */
> > +        vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_CFIS);
> > +    } else {
> > +        s->cfi_enabled = false;
> > +        /* Ok - report back to driver */
> > +        vtd_set_clear_mask_long(s, DMAR_GSTS_REG, VTD_GSTS_CFIS, 0);
> > +    }
> > +}
> > +
> >   /* Handle write to Global Command Register */
> >   static void vtd_handle_gcmd_write(IntelIOMMUState *s)
> >   {
> > @@ -2440,6 +2456,10 @@ static void vtd_handle_gcmd_write(IntelIOMMUState *s)
> >           /* Interrupt remap enable/disable */
> >           vtd_handle_gcmd_ire(s, val & VTD_GCMD_IRE);
> >       }
> > +    if (changed & VTD_GCMD_CFI) {
> > +        /* Compatibility format interrupts enable/disable */
> > +        vtd_handle_gcmd_cfi(s, val & VTD_GCMD_CFI);
> > +    }
> >   }
> >
> >   /* Handle write to Context Command Register */
> > @@ -3283,7 +3303,25 @@ static int vtd_post_load(void *opaque, int version_id)
> >       return 0;
> >   }
> >
> > -static const VMStateDescription vtd_vmstate = {
> > +static bool vtd_cfi_needed(void *opaque)
> > +{
> > +    IntelIOMMUState *iommu = opaque;
> > +
> > +    return iommu->intr_enabled && !iommu->intr_eime;
> > +}
> > +
> > +static const VMStateDescription vmstate_vtd_cfi = {
> > +    .name = "iommu-intel/cfi",
> > +    .version_id = 1,
> > +    .minimum_version_id = 1,
> > +    .needed = vtd_cfi_needed,
> > +    .fields = (VMStateField[]) {
> > +        VMSTATE_BOOL(cfi_enabled, IntelIOMMUState),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> > +static const VMStateDescription vmstate_vtd = {
> Why is vtd_vmstate renamed to vmstate_vtd? is it necessary?



Yuke Peng, do you plan to answer this?

> >       .name = "iommu-intel",
> >       .version_id = 1,
> >       .minimum_version_id = 1,
> > @@ -3306,6 +3344,10 @@ static const VMStateDescription vtd_vmstate = {
> >           VMSTATE_BOOL(intr_enabled, IntelIOMMUState),
> >           VMSTATE_BOOL(intr_eime, IntelIOMMUState),
> >           VMSTATE_END_OF_LIST()
> > +    },
> > +    .subsections = (const VMStateDescription * []) {
> > +        &vmstate_vtd_cfi,
> > +        NULL
> >       }
> >   };
> >
> > @@ -3525,6 +3567,12 @@ static int vtd_interrupt_remap_msi(IntelIOMMUState *iommu,
> >
> >       /* This is compatible mode. */
> >       if (addr.addr.int_mode != VTD_IR_INT_FORMAT_REMAP) {
> > +        if (iommu->intr_eime || !iommu->cfi_enabled) {
> > +            if (do_fault) {
> > +                vtd_report_ir_fault(iommu, sid, VTD_FR_IR_REQ_COMPAT, 0);
> > +            }
> > +            return -EINVAL;
> > +        }
> >           memcpy(translated, origin, sizeof(*origin));
> >           goto out;
> >       }
> > @@ -3950,6 +3998,7 @@ static void vtd_init(IntelIOMMUState *s)
> >       s->root_scalable = false;
> >       s->dmar_enabled = false;
> >       s->intr_enabled = false;
> > +    s->cfi_enabled = false;
> >       s->iq_head = 0;
> >       s->iq_tail = 0;
> >       s->iq = 0;
> > @@ -4243,7 +4292,7 @@ static void vtd_class_init(ObjectClass *klass, void *data)
> >       X86IOMMUClass *x86_class = X86_IOMMU_DEVICE_CLASS(klass);
> >
> >       dc->reset = vtd_reset;
> > -    dc->vmsd = &vtd_vmstate;
> > +    dc->vmsd = &vmstate_vtd;
> >       device_class_set_props(dc, vtd_properties);
> >       dc->hotpluggable = false;
> >       x86_class->realize = vtd_realize;
> > diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> > index 53c02d7ac8..ffd87db65f 100644
> > --- a/hw/i386/trace-events
> > +++ b/hw/i386/trace-events
> > @@ -57,6 +57,7 @@ vtd_dmar_translate(uint8_t bus, uint8_t slot, uint8_t func, uint64_t iova, uint6
> >   vtd_dmar_enable(bool en) "enable %d"
> >   vtd_dmar_fault(uint16_t sid, int fault, uint64_t addr, bool is_write) "sid 0x%"PRIx16" fault %d addr 0x%"PRIx64" write %d"
> >   vtd_ir_enable(bool en) "enable %d"
> > +vtd_cfi_enable(bool en) "enable %d"
> >   vtd_ir_irte_get(int index, uint64_t lo, uint64_t hi) "index %d low 0x%"PRIx64" high 0x%"PRIx64
> >   vtd_ir_remap(int index, int tri, int vec, int deliver, uint32_t dest, int dest_mode) "index %d trigger %d vector %d deliver %d dest 0x%"PRIx32" mode %d"
> >   vtd_ir_remap_type(const char *type) "%s"
> > diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> > index 7fa0a695c8..38e20d0f2c 100644
> > --- a/include/hw/i386/intel_iommu.h
> > +++ b/include/hw/i386/intel_iommu.h
> > @@ -294,6 +294,7 @@ struct IntelIOMMUState {
> >
> >       /* interrupt remapping */
> >       bool intr_enabled;              /* Whether guest enabled IR */
> > +    bool cfi_enabled;               /* Whether CFI is enabled */
> >       dma_addr_t intr_root;           /* Interrupt remapping table pointer */
> >       uint32_t intr_size;             /* Number of IR table entries */
> >       bool intr_eime;                 /* Extended interrupt mode enabled */
> > --
> > 2.34.1
> >
> >


