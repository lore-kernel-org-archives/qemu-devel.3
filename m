Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6025FC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 08:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWtk4-0007aY-3c; Thu, 25 Jul 2024 04:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sWtk0-0007Zt-Kr
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 04:22:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sWtjy-0005rx-3F
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 04:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721895740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R5L2VlGsOvjUuuxv4O2i/zUCGIp1tif4qxNc7cuC61g=;
 b=WSTV8Na6dBrDfbSlxcArNuo54YTIhtcNhoMK68Q3bFev3Eh4VVLmhhsPRr9bOfnLnSnGsT
 3Tv4iRVNHKYLCFDoUa3C069YnV5c1+oGZpNMHNsSpalyQJ/KdXHcd2BJekuAhW4QVpJkfa
 akYSkzsK+19kb6/2G9gW8B/O6WPPKaI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-yrBDFfNmPG6mEzrTisMh1w-1; Thu, 25 Jul 2024 04:22:18 -0400
X-MC-Unique: yrBDFfNmPG6mEzrTisMh1w-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4272718b9b0so5062405e9.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 01:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721895737; x=1722500537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R5L2VlGsOvjUuuxv4O2i/zUCGIp1tif4qxNc7cuC61g=;
 b=nI6rqRUbtOBUkSWiHvBSAnMcRmsfeZwM71M+7C+DduWORmaw8zQAHWBl9T+Rh3MIrj
 S2ETHt0UZec/hx+wYCpg/KUMNphiBFDyKtC4uSb2q5tiCUxKwf04TNJe02pgp4EwEsfP
 hAikwVBmAK13HUxcY1E3sZX0HXkcYXiyVofAD0psFvq0w76babo1Ju+9ovaWbaGem7Jb
 zGmK7YziJhNgmM9OytzsfmCDFIuk90Fb4pwTIlOmSfTxmnuZOcm6itjlvlcIKQEV1/jd
 AairhuT+pbKszu8cCZ19XWNvLBw0ZjDhxkXoq5DiY85yrGtcu5uM1O1RuwCeWakgxS0h
 IOyQ==
X-Gm-Message-State: AOJu0YyGFy6Gz58LX1vyE3M98aUNaXN8HlU6thuRux1+4207HJ9LfFnw
 rRyzCwHhJbz2jUNtYs95kfaTnFSiajylDrlQciKNNnXuye3W2seuS0lYSsvVFOy2Malnkj+vwxP
 hMJV9zZ0H5V8xCPf6O0s0mxgZAmVdNdPQkoueiazoYLCedpdn6J4J
X-Received: by 2002:a05:600c:4447:b0:426:63b8:2cce with SMTP id
 5b1f17b1804b1-4280550c294mr11224855e9.7.1721895737331; 
 Thu, 25 Jul 2024 01:22:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnivFspuNVuZWeVC3H/MtuBHwdJgQhXpIsxRRDy69PtBWuys8PqmyVFFF+HJhBrGnPbTNNnQ==
X-Received: by 2002:a05:600c:4447:b0:426:63b8:2cce with SMTP id
 5b1f17b1804b1-4280550c294mr11224665e9.7.1721895736893; 
 Thu, 25 Jul 2024 01:22:16 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f9413547sm64816585e9.44.2024.07.25.01.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 01:22:16 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:22:15 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Song Gao <gaosong@loongson.cn>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH 1/3] acpi/ged: Implement S3 and S4 sleep
Message-ID: <20240725102215.4046ecc2@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240613-loongarch64-sleep-v1-1-d2ef0aaa543a@flygoat.com>
References: <20240613-loongarch64-sleep-v1-0-d2ef0aaa543a@flygoat.com>
 <20240613-loongarch64-sleep-v1-1-d2ef0aaa543a@flygoat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 13 Jun 2024 18:30:15 +0100
Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:

> Implement S3 and S4 sleep with ACPI_GED_REG_SLEEP_CTL.SLP_TYP
> writes.
> 
> Implement wakeup callback and WAK_STS register to inform guest
> about current states.
> 
> All new functions are gated by "slp-typs" property, it is defaulted
> to S5 only and machines can opt-in for S3 and S4.

subject says S3 + S4 and don't mention S5
the same happens throughout the series, please fix it up

PS:
please reference relevant ACPI portions in the patch below,
so reader could easily find and understand what code does.

> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  hw/acpi/generic_event_device.c         | 70 ++++++++++++++++++++++++++++++----
>  include/hw/acpi/generic_event_device.h | 12 +++++-
>  2 files changed, 73 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 2d6e91b124e5..f1fc99c04011 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -11,6 +11,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> +#include "qapi/qapi-events-run-state.h"
>  #include "hw/acpi/acpi.h"
>  #include "hw/acpi/generic_event_device.h"
>  #include "hw/irq.h"
> @@ -186,24 +187,53 @@ static const MemoryRegionOps ged_evt_ops = {
>  
>  static uint64_t ged_regs_read(void *opaque, hwaddr addr, unsigned size)
>  {
> +    GEDState *ged_st = opaque;
> +
> +    switch (addr) {
> +    case ACPI_GED_REG_SLEEP_STS:
> +        return ged_st->sleep_sts;
> +    default:
> +        break;
> +    }
> +
>      return 0;
>  }
>  
>  static void ged_regs_write(void *opaque, hwaddr addr, uint64_t data,
>                             unsigned int size)
>  {
> -    bool slp_en;
> -    int slp_typ;
> +    GEDState *ged_st = opaque;
> +    AcpiGedState *s = container_of(ged_st, AcpiGedState, ged_state);
>  
>      switch (addr) {
>      case ACPI_GED_REG_SLEEP_CTL:
> -        slp_typ = (data >> 2) & 0x07;
> -        slp_en  = (data >> 5) & 0x01;
maybe use defines instead of magic numbers, it's also good to add
coments here referring to concrete chapter in APCI spec that describe
what these numbers are.

> -        if (slp_en && slp_typ == 5) {
                                    ^^^
ditto

> -            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> +        if (data & ACPI_GED_SLP_EN) {
> +            switch (extract8(data, 2, 3)) {
> +            case ACPI_GED_SLP_TYP_S3:
> +                if (s->slp_typs_bitmap & (1 << ACPI_GED_SLP_TYP_S3)) {

why not use existing helpers like test_bit()
the same applies to following bit checks

> +                    qemu_system_suspend_request();
> +                }
> +                break;
> +            case ACPI_GED_SLP_TYP_S4:
> +                if (s->slp_typs_bitmap & (1 << ACPI_GED_SLP_TYP_S4)) {
> +                    qapi_event_send_suspend_disk();
> +                    qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> +                }
> +                break;
> +            case ACPI_GED_SLP_TYP_S5:
> +                if (s->slp_typs_bitmap & (1 << ACPI_GED_SLP_TYP_S5)) {
> +                    qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> +                }
> +                break;
> +            default:
> +                break;
> +            }
>          }
>          return;
>      case ACPI_GED_REG_SLEEP_STS:
> +        if (data & ACPI_GED_WAK_STS) {
> +            ged_st->sleep_sts &= ~ACPI_GED_WAK_STS;
> +        }
>          return;
>      case ACPI_GED_REG_RESET:
>          if (data == ACPI_GED_RESET_VALUE) {
> @@ -223,6 +253,14 @@ static const MemoryRegionOps ged_regs_ops = {
>      },
>  };
>  
> +static void acpi_ged_notify_wakeup(Notifier *notifier, void *data)
> +{
> +    GEDState *ged_st = container_of(notifier, GEDState, wakeup);
> +
> +    ged_st->sleep_sts |= ACPI_GED_WAK_STS;

describe somewhere workflow how it is supposed to work 
(commit message or add ged specific doc in docs/specs/
as the 1st patch)

> +}
> +
> +
>  static void acpi_ged_device_plug_cb(HotplugHandler *hotplug_dev,
>                                      DeviceState *dev, Error **errp)
>  {
> @@ -305,6 +343,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>  
>  static Property acpi_ged_properties[] = {
>      DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
> +    DEFINE_PROP_UINT32("slp-typs", AcpiGedState, slp_typs_bitmap,
> +                        (1 << ACPI_GED_SLP_TYP_S5)),

I'd default to everything enabled, and use compat mechanism
to disable it on older machine types.

You have to do this as ged is also used by versioned arm/virt machine

>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> @@ -320,10 +360,11 @@ static const VMStateDescription vmstate_memhp_state = {
>  
>  static const VMStateDescription vmstate_ged_state = {
>      .name = "acpi-ged-state",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINT32(sel, GEDState),
> +        VMSTATE_UINT8(sleep_sts, GEDState),
>          VMSTATE_END_OF_LIST()
>      }
>  };

see for example
commit 829600a519386c7b188d5d813e78ba69bf0bd323
    hpet: recover timer offset correctly



> @@ -371,6 +412,18 @@ static const VMStateDescription vmstate_acpi_ged = {
>      }
>  };
>  
> +static void acpi_ged_realize(DeviceState *dev, Error **errp)
> +{
> +    AcpiGedState *s = ACPI_GED(dev);
> +    GEDState *ged_st = &s->ged_state;
> +
> +    if (s->slp_typs_bitmap & (1 << ACPI_GED_SLP_TYP_S3)) {
> +        ged_st->wakeup.notify = acpi_ged_notify_wakeup;
> +        qemu_register_wakeup_notifier(&ged_st->wakeup);
> +        qemu_register_wakeup_support();
> +    }
> +}
> +
>  static void acpi_ged_initfn(Object *obj)
>  {
>      DeviceState *dev = DEVICE(obj);
> @@ -409,6 +462,7 @@ static void acpi_ged_class_init(ObjectClass *class, void *data)
>      AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_CLASS(class);
>  
>      dc->desc = "ACPI Generic Event Device";
> +    dc->realize = acpi_ged_realize;

realize was added recently (currently in master),
please rebase on top of current master tree

>      device_class_set_props(dc, acpi_ged_properties);
>      dc->vmsd = &vmstate_acpi_ged;
>  
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> index ba84ce021477..1ea3cb848679 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -80,9 +80,16 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>  /* ACPI_GED_REG_RESET value for reset*/
>  #define ACPI_GED_RESET_VALUE       0x42
>  
> -/* ACPI_GED_REG_SLEEP_CTL.SLP_TYP value for S5 (aka poweroff) */
> +/* ACPI_GED_REG_SLEEP_CTL.SLP_EN bit */
> +#define ACPI_GED_SLP_EN            (1 << 5)
> +
> +/* ACPI_GED_REG_SLEEP_CTL.SLP_TYP values */
> +#define ACPI_GED_SLP_TYP_S3        0x03
> +#define ACPI_GED_SLP_TYP_S4        0x04
>  #define ACPI_GED_SLP_TYP_S5        0x05
>  
> +#define ACPI_GED_WAK_STS           (1 << 7)
> +
>  #define GED_DEVICE      "GED"
>  #define AML_GED_EVT_REG "EREG"
>  #define AML_GED_EVT_SEL "ESEL"
> @@ -99,7 +106,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>  typedef struct GEDState {
>      MemoryRegion evt;
>      MemoryRegion regs;
> +    Notifier     wakeup;
>      uint32_t     sel;
> +    uint8_t      sleep_sts;
>  } GEDState;
>  
>  struct AcpiGedState {
> @@ -108,6 +117,7 @@ struct AcpiGedState {
>      MemoryRegion container_memhp;
>      GEDState ged_state;
>      uint32_t ged_event_bitmap;
> +    uint32_t slp_typs_bitmap;
>      qemu_irq irq;
>      AcpiGhesState ghes_state;
>  };
> 


