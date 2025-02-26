Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709F1C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 15:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnJnt-0005DW-ES; Wed, 26 Feb 2025 10:58:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnJnr-0005Cr-E7
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 10:58:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnJnp-0004up-DN
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 10:58:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740585508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6q+MfJiIaN0i87TpsuTV4ud4MXgYfN/GlXWJvHggK/I=;
 b=eN5xm5Za/d2mYRzXVwrMGwHmhiMHgxBUlBFE3WoNKhj4+r4u2fHtsemZij1+J9VjCyto3Y
 VGXWZvg8T4xenUTVyfVkhYXDdjrCmeqHgK6wL/6GtSobFGs1CYKEf4c1XdV3/RtU/RZI8P
 zG46b8eQg81MWxDhUiyhitf6rWje2sc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-2FS2uZUDM3CfbW9v-cxoUw-1; Wed, 26 Feb 2025 10:58:25 -0500
X-MC-Unique: 2FS2uZUDM3CfbW9v-cxoUw-1
X-Mimecast-MFC-AGG-ID: 2FS2uZUDM3CfbW9v-cxoUw_1740585505
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38f39352f1dso2810004f8f.0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 07:58:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740585504; x=1741190304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6q+MfJiIaN0i87TpsuTV4ud4MXgYfN/GlXWJvHggK/I=;
 b=Ii42UlowEyrj66sVuI6oXlFjQH64bvPiiAmn/ojc3RiJrOdm9J7+W/rKyD9zS/Rgyr
 xPCVvsrjviV4ghEdYCkb7Y9pRXEJ6Vu5f00hgRIczc2y5Ltq8UCbJAcsc6K01ouZYcLc
 sdSI0LWNT6JC51WyGtWT7ldxirM89IGUhl3BD9L+SSjOBXVHGyJtpV2npzufkTCxLSXB
 8YHzlRXAQzM/8e5OkUTepBGhJnNd6Y3Ll25CeUU0CtvoFUIjR11f6lQzH4hlhrlaYCsD
 pH44ltAskFArPG+jnY1LoMsPou6Lag3yih1BfhbCFz/TE3lvgnVzHXH+BZK9UrLv18gQ
 OwEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6IaXoGa+/bekGi2dSfl5g+NJ+bVWPipkBDUPXZPf95YQSWArsXeAATIGBq9H7zQ7mBkIAw/94yLY4@nongnu.org
X-Gm-Message-State: AOJu0YwpBRhQXa6otRAebb6qlyqIaBUU8ctN0/t768mUQB9SawK6CysU
 XpaqSc1EEXZF1WyduuxNYzYPc96F/UdB1vFByKX8O3VdHJO6RBpiAzSp3qWkHG4+jEtWwk3FG+d
 R145SKA5MUwliox+ZNJiaxejdAg1kwlCXgi7FOrhhHiYSEr+n5nNy
X-Gm-Gg: ASbGncvy7X6GIomGfrGEJKAQQ68mLGPAfUR0/xcQ6ymQoOoc8Ck7BJ4B/cT+ATxg3ZX
 Hu3/l6pqjLZfWahlHdDFyBxSGDU+0tMQ/J6NhmVw65A/06t7x8mGOLXWxrbBwO7ptRhHkDHCnEx
 DfqP7fsKrAZ7JWxpIlWGf7GMTAO8qB28YTFwITtATPykESsL/ojT8fMCiEoO8uAje+9HnrDkVHy
 4XTLfH/s4Q5pPQ5Xicbl4OcosmFY8e+UIXSHoLpaaEXWZgsQInoMicqrTD4bVMLonvRUIDCkPDf
 Baf/BA2pqS28PfF9+frwBnp27FNLSTeQ4IdVeDQWCqg3wqV/e4mtWmcNe7WjpKQ=
X-Received: by 2002:a05:6000:18a9:b0:38f:28a1:503f with SMTP id
 ffacd0b85a97d-38f707728e5mr18043410f8f.11.1740585504672; 
 Wed, 26 Feb 2025 07:58:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXHC8a93KgRIlFJAiZUxxPTJisHxJGeiPx1mpGo848eB+LMy6//uk7tw0WyQYrknxhTmMs+Q==
X-Received: by 2002:a05:6000:18a9:b0:38f:28a1:503f with SMTP id
 ffacd0b85a97d-38f707728e5mr18043389f8f.11.1740585504271; 
 Wed, 26 Feb 2025 07:58:24 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd86ca9csm6036028f8f.22.2025.02.26.07.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 07:58:23 -0800 (PST)
Date: Wed, 26 Feb 2025 16:58:23 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Shannon
 Zhao <shannon.zhaosl@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/14] arm/virt: Wire up a GED error device for ACPI
 / GHES
Message-ID: <20250226165823.14f08232@imammedo.users.ipa.redhat.com>
In-Reply-To: <87cb9cc850fb728f11d88a83c05b288baca556df.1740148260.git.mchehab+huawei@kernel.org>
References: <cover.1740148260.git.mchehab+huawei@kernel.org>
 <87cb9cc850fb728f11d88a83c05b288baca556df.1740148260.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, 21 Feb 2025 15:35:20 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Adds support to ARM virtualization to allow handling
> generic error ACPI Event via GED & error source device.
> 
> It is aligned with Linux Kernel patch:
> https://lore.kernel.org/lkml/1272350481-27951-8-git-send-email-ying.huang@intel.com/
> 
> Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> 
> ---
> 
> Changes from v8:
> 
> - Added a call to the function that produces GHES generic
>   records, as this is now added earlier in this series.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/generic_event_device.c |  2 +-
>  hw/arm/virt-acpi-build.c       |  1 +
>  hw/arm/virt.c                  | 12 +++++++++++-
>  include/hw/arm/virt.h          |  1 +
>  4 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 180eebbce1cd..f5e899155d34 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -331,7 +331,7 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>  
>  static const Property acpi_ged_properties[] = {
>      DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
> -    DEFINE_PROP_BOOL("x-has-hest-addr", AcpiGedState, ghes_state.use_hest_addr, false),
> +    DEFINE_PROP_BOOL("x-has-hest-addr", AcpiGedState, ghes_state.use_hest_addr, true),
irrelevant to this patch, see comment in 8/14

>  };
>  
>  static const VMStateDescription vmstate_memhp_state = {
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 9de51105a513..4f174795ed60 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -861,6 +861,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      }
>  
>      acpi_dsdt_add_power_button(scope);
> +    aml_append(scope, aml_error_device());
>  #ifdef CONFIG_TPM
>      acpi_dsdt_add_tpm(scope, vms);
>  #endif
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 4a5a9666e916..3faf32f900b5 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -678,7 +678,7 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
>      DeviceState *dev;
>      MachineState *ms = MACHINE(vms);
>      int irq = vms->irqmap[VIRT_ACPI_GED];
> -    uint32_t event = ACPI_GED_PWR_DOWN_EVT;
> +    uint32_t event = ACPI_GED_PWR_DOWN_EVT | ACPI_GED_ERROR_EVT;
>  
>      if (ms->ram_slots) {
>          event |= ACPI_GED_MEM_HOTPLUG_EVT;
> @@ -1010,6 +1010,13 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
>      }
>  }
>  
> +static void virt_generic_error_req(Notifier *n, void *opaque)
> +{
> +    VirtMachineState *s = container_of(n, VirtMachineState, generic_error_notifier);
> +
> +    acpi_send_event(s->acpi_dev, ACPI_GENERIC_ERROR);
> +}
> +
>  static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
>                               uint32_t phandle)
>  {
> @@ -2404,6 +2411,9 @@ static void machvirt_init(MachineState *machine)
>  
>      if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
>          vms->acpi_dev = create_acpi_ged(vms);
> +        vms->generic_error_notifier.notify = virt_generic_error_req;
> +        notifier_list_add(&acpi_generic_error_notifiers,
> +                          &vms->generic_error_notifier);
>      } else {
>          create_gpio_devices(vms, VIRT_GPIO, sysmem);
>      }
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index c8e94e6aedc9..f3cf28436770 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -176,6 +176,7 @@ struct VirtMachineState {
>      DeviceState *gic;
>      DeviceState *acpi_dev;
>      Notifier powerdown_notifier;
> +    Notifier generic_error_notifier;
>      PCIBus *bus;
>      char *oem_id;
>      char *oem_table_id;


