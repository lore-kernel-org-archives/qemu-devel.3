Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA538C3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 08:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWuFV-0005tH-Dx; Thu, 25 Jul 2024 04:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sWuFT-0005sU-C5
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 04:54:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sWuFQ-0006te-Hi
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 04:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721897691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QoQlxriUVfkZ2L4MTnMj5U4bx/ftW7bYQlieTKZ8dLE=;
 b=Hb24JNMnRKAMKPKHkzf44fVal0DLtiywoEOhqxujtgZDTCP2XqfwHWjzh+bREIkX5BEj8J
 CtS6UPH2ClfPdNZbeMvVMwhIjRGbm8L7wqNrwUU46jxZj9x3ufbgju6SMF2gaFQ7PAE3lc
 tQRcj/lCqG1xKSqFWlvp2v/OPzlaND4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-J0wdKYonMfmR7FvU_e4Z_A-1; Thu, 25 Jul 2024 04:54:47 -0400
X-MC-Unique: J0wdKYonMfmR7FvU_e4Z_A-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3683f34d8d9so392866f8f.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 01:54:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721897686; x=1722502486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QoQlxriUVfkZ2L4MTnMj5U4bx/ftW7bYQlieTKZ8dLE=;
 b=PTvWzSPocwt21wn2xNHd+ZJiyCRJuI6Yh70Wm32xBl3/4TBSGvx8HEIlYiq0GcoZVH
 vsCrMYxXEb7hjvYgd03HXc/sJMwgliqO8IbrwUuEOgLYy9ZJnvme0d4te1ThVpgW9U9J
 aFjJnvCCHqiQAY2TwstZOcIRx42NzFMWwmB9m40fLLGG23QQsJxB41XCO//jjWLlPY/m
 +youatDoyEtAEW59yRA+7Z4gsQEiOxSaRzcYF1Orh3Kswwuz2pANFZt0Oo88KIYPRDwi
 ctXVIcGJgE6un8D/wtkvPdEk/qpZgr8m7DQVt7mitz897xx6yDcNrFB5viH+NB2kuTz4
 vz7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgVGt6+dNdCSJi45/yXAoKlLjCFBJHNoj68dz4oUZ+Guos8RoGADPVMkvhKWWLmBGudKKmjXDIINQywGuQ5GWzOIpmyqY=
X-Gm-Message-State: AOJu0YxB0oZKiKN+GvbNBtx0aXlhAP1pxEf84lBn16/q09qGBrPB3t9Y
 RI8MDbSwABGe4aNKjBQoeOO83eO9o7IDKIBdl2wU4c5dRWurEY8YWy8CzAeeL2b7QiQQ2NMXa5E
 I/Dy2h4FX+8Z9tFsdAstkNOisIVDb/2sQORQDZcsSr8Hc4TPKTmEp
X-Received: by 2002:adf:db51:0:b0:367:9903:a79 with SMTP id
 ffacd0b85a97d-36b364117f9mr871869f8f.48.1721897686342; 
 Thu, 25 Jul 2024 01:54:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZZHD17d1rCB41bwio+OVOtANABM4RPoxVbNZlCW3mLX/9hTefpMxHE2uYGznTY+GfOTNY2w==
X-Received: by 2002:adf:db51:0:b0:367:9903:a79 with SMTP id
 ffacd0b85a97d-36b364117f9mr871856f8f.48.1721897685911; 
 Thu, 25 Jul 2024 01:54:45 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36862489sm1381799f8f.105.2024.07.25.01.54.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 01:54:45 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:54:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Song Gao <gaosong@loongson.cn>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH 1/3] acpi/ged: Implement S3 and S4 sleep
Message-ID: <20240725105444.5ac4f0ec@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240725042431-mutt-send-email-mst@kernel.org>
References: <20240613-loongarch64-sleep-v1-0-d2ef0aaa543a@flygoat.com>
 <20240613-loongarch64-sleep-v1-1-d2ef0aaa543a@flygoat.com>
 <20240725102215.4046ecc2@imammedo.users.ipa.redhat.com>
 <20240725042431-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
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

On Thu, 25 Jul 2024 04:30:42 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Jul 25, 2024 at 10:22:15AM +0200, Igor Mammedov wrote:
> > On Thu, 13 Jun 2024 18:30:15 +0100
> > Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
> >   
> > > Implement S3 and S4 sleep with ACPI_GED_REG_SLEEP_CTL.SLP_TYP
> > > writes.
> > > 
> > > Implement wakeup callback and WAK_STS register to inform guest
> > > about current states.
> > > 
> > > All new functions are gated by "slp-typs" property, it is defaulted
> > > to S5 only and machines can opt-in for S3 and S4.  
> > 
> > subject says S3 + S4 and don't mention S5
> > the same happens throughout the series, please fix it up
> > 
> > PS:
> > please reference relevant ACPI portions in the patch below,
> > so reader could easily find and understand what code does.
> >   
> > > 
> > > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > ---
> > >  hw/acpi/generic_event_device.c         | 70 ++++++++++++++++++++++++++++++----
> > >  include/hw/acpi/generic_event_device.h | 12 +++++-
> > >  2 files changed, 73 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> > > index 2d6e91b124e5..f1fc99c04011 100644
> > > --- a/hw/acpi/generic_event_device.c
> > > +++ b/hw/acpi/generic_event_device.c
> > > @@ -11,6 +11,7 @@
> > >  
> > >  #include "qemu/osdep.h"
> > >  #include "qapi/error.h"
> > > +#include "qapi/qapi-events-run-state.h"
> > >  #include "hw/acpi/acpi.h"
> > >  #include "hw/acpi/generic_event_device.h"
> > >  #include "hw/irq.h"
> > > @@ -186,24 +187,53 @@ static const MemoryRegionOps ged_evt_ops = {
> > >  
> > >  static uint64_t ged_regs_read(void *opaque, hwaddr addr, unsigned size)
> > >  {
> > > +    GEDState *ged_st = opaque;
> > > +
> > > +    switch (addr) {
> > > +    case ACPI_GED_REG_SLEEP_STS:
> > > +        return ged_st->sleep_sts;
> > > +    default:
> > > +        break;
> > > +    }
> > > +
> > >      return 0;
> > >  }
> > >  
> > >  static void ged_regs_write(void *opaque, hwaddr addr, uint64_t data,
> > >                             unsigned int size)
> > >  {
> > > -    bool slp_en;
> > > -    int slp_typ;
> > > +    GEDState *ged_st = opaque;
> > > +    AcpiGedState *s = container_of(ged_st, AcpiGedState, ged_state);
> > >  
> > >      switch (addr) {
> > >      case ACPI_GED_REG_SLEEP_CTL:
> > > -        slp_typ = (data >> 2) & 0x07;
> > > -        slp_en  = (data >> 5) & 0x01;  
> > maybe use defines instead of magic numbers, it's also good to add
> > coments here referring to concrete chapter in APCI spec that describe
> > what these numbers are.  
> 
> In fact if you add comments you do not need defines.
> One time use defines are a waste of time and hard to parse.
> 
>  slp_typ = (data >> 2 /* x Yz */ ) & 0x07 /* bits 0 to 3 */;
> 
> is clearer than
> 
> #define ACPI_S3_X_YZ 2
> #define ACPI_S3_MASK 7
> 
> because that "x Yz" can match spec text *exactly*, you do
> text search and you find where it is. With macros
> you have to guess.

seconded, I'd also prefer comments (for 1-off use) that
match spec _exactly_ so reader could easily find relevant
place in spec

> build_amd_iommu is a nice example I think.
> 
> >   
> > > -        if (slp_en && slp_typ == 5) {  
> >                                     ^^^
> > ditto  
> 
> this is deleted code, isn't it?
yep, sorry.
(a cup of coffee wasn't enough)
 
> > > -            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> > > +        if (data & ACPI_GED_SLP_EN) {
> > > +            switch (extract8(data, 2, 3)) {
> > > +            case ACPI_GED_SLP_TYP_S3:
> > > +                if (s->slp_typs_bitmap & (1 << ACPI_GED_SLP_TYP_S3)) {  
> > 
> > why not use existing helpers like test_bit()
> > the same applies to following bit checks
> >   
> > > +                    qemu_system_suspend_request();
> > > +                }
> > > +                break;
> > > +            case ACPI_GED_SLP_TYP_S4:
> > > +                if (s->slp_typs_bitmap & (1 << ACPI_GED_SLP_TYP_S4)) {
> > > +                    qapi_event_send_suspend_disk();
> > > +                    qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> > > +                }
> > > +                break;
> > > +            case ACPI_GED_SLP_TYP_S5:
> > > +                if (s->slp_typs_bitmap & (1 << ACPI_GED_SLP_TYP_S5)) {
> > > +                    qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> > > +                }
> > > +                break;
> > > +            default:
> > > +                break;
> > > +            }
> > >          }
> > >          return;
> > >      case ACPI_GED_REG_SLEEP_STS:
> > > +        if (data & ACPI_GED_WAK_STS) {
> > > +            ged_st->sleep_sts &= ~ACPI_GED_WAK_STS;
> > > +        }
> > >          return;
> > >      case ACPI_GED_REG_RESET:
> > >          if (data == ACPI_GED_RESET_VALUE) {
> > > @@ -223,6 +253,14 @@ static const MemoryRegionOps ged_regs_ops = {
> > >      },
> > >  };
> > >  
> > > +static void acpi_ged_notify_wakeup(Notifier *notifier, void *data)
> > > +{
> > > +    GEDState *ged_st = container_of(notifier, GEDState, wakeup);
> > > +
> > > +    ged_st->sleep_sts |= ACPI_GED_WAK_STS;  
> > 
> > describe somewhere workflow how it is supposed to work 
> > (commit message or add ged specific doc in docs/specs/
> > as the 1st patch)
> >   
> > > +}
> > > +
> > > +
> > >  static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
> > >                                      DeviceState *dev, Error **errp)
> > >  {
> > > @@ -305,6 +343,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
> > >  
> > >  static Property acpi_ged_properties[] = {
> > >      DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
> > > +    DEFINE_PROP_UINT32("slp-typs", AcpiGedState, slp_typs_bitmap,
> > > +                        (1 << ACPI_GED_SLP_TYP_S5)),  
> > 
> > I'd default to everything enabled, and use compat mechanism
> > to disable it on older machine types.
> > 
> > You have to do this as ged is also used by versioned arm/virt machine
> >   
> > >      DEFINE_PROP_END_OF_LIST(),
> > >  };
> > >  
> > > @@ -320,10 +360,11 @@ static const VMStateDescription vmstate_memhp_state = {
> > >  
> > >  static const VMStateDescription vmstate_ged_state = {
> > >      .name = "acpi-ged-state",
> > > -    .version_id = 1,
> > > -    .minimum_version_id = 1,
> > > +    .version_id = 2,
> > > +    .minimum_version_id = 2,
> > >      .fields = (const VMStateField[]) {
> > >          VMSTATE_UINT32(sel, GEDState),
> > > +        VMSTATE_UINT8(sleep_sts, GEDState),
> > >          VMSTATE_END_OF_LIST()
> > >      }
> > >  };  
> > 
> > see for example
> > commit 829600a519386c7b188d5d813e78ba69bf0bd323
> >     hpet: recover timer offset correctly
> > 
> > 
> >   
> > > @@ -371,6 +412,18 @@ static const VMStateDescription vmstate_acpi_ged = {
> > >      }
> > >  };
> > >  
> > > +static void acpi_ged_realize(DeviceState *dev, Error **errp)
> > > +{
> > > +    AcpiGedState *s = ACPI_GED(dev);
> > > +    GEDState *ged_st = &s->ged_state;
> > > +
> > > +    if (s->slp_typs_bitmap & (1 << ACPI_GED_SLP_TYP_S3)) {
> > > +        ged_st->wakeup.notify = acpi_ged_notify_wakeup;
> > > +        qemu_register_wakeup_notifier(&ged_st->wakeup);
> > > +        qemu_register_wakeup_support();
> > > +    }
> > > +}
> > > +
> > >  static void acpi_ged_initfn(Object *obj)
> > >  {
> > >      DeviceState *dev = DEVICE(obj);
> > > @@ -409,6 +462,7 @@ static void acpi_ged_class_init(ObjectClass *class, void *data)
> > >      AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_CLASS(class);
> > >  
> > >      dc->desc = "ACPI Generic Event Device";
> > > +    dc->realize = acpi_ged_realize;  
> > 
> > realize was added recently (currently in master),
> > please rebase on top of current master tree
> >   
> > >      device_class_set_props(dc, acpi_ged_properties);
> > >      dc->vmsd = &vmstate_acpi_ged;
> > >  
> > > diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> > > index ba84ce021477..1ea3cb848679 100644
> > > --- a/include/hw/acpi/generic_event_device.h
> > > +++ b/include/hw/acpi/generic_event_device.h
> > > @@ -80,9 +80,16 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
> > >  /* ACPI_GED_REG_RESET value for reset*/
> > >  #define ACPI_GED_RESET_VALUE       0x42
> > >  
> > > -/* ACPI_GED_REG_SLEEP_CTL.SLP_TYP value for S5 (aka poweroff) */
> > > +/* ACPI_GED_REG_SLEEP_CTL.SLP_EN bit */
> > > +#define ACPI_GED_SLP_EN            (1 << 5)
> > > +
> > > +/* ACPI_GED_REG_SLEEP_CTL.SLP_TYP values */
> > > +#define ACPI_GED_SLP_TYP_S3        0x03
> > > +#define ACPI_GED_SLP_TYP_S4        0x04
> > >  #define ACPI_GED_SLP_TYP_S5        0x05
> > >  
> > > +#define ACPI_GED_WAK_STS           (1 << 7)
> > > +
> > >  #define GED_DEVICE      "GED"
> > >  #define AML_GED_EVT_REG "EREG"
> > >  #define AML_GED_EVT_SEL "ESEL"
> > > @@ -99,7 +106,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
> > >  typedef struct GEDState {
> > >      MemoryRegion evt;
> > >      MemoryRegion regs;
> > > +    Notifier     wakeup;
> > >      uint32_t     sel;
> > > +    uint8_t      sleep_sts;
> > >  } GEDState;
> > >  
> > >  struct AcpiGedState {
> > > @@ -108,6 +117,7 @@ struct AcpiGedState {
> > >      MemoryRegion container_memhp;
> > >      GEDState ged_state;
> > >      uint32_t ged_event_bitmap;
> > > +    uint32_t slp_typs_bitmap;
> > >      qemu_irq irq;
> > >      AcpiGhesState ghes_state;
> > >  };
> > >   
> 


