Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4DA1C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 11:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdTCs-0005Dx-NF; Mon, 12 Aug 2024 07:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sdTCq-0005Ct-SR
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 07:27:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sdTCo-0004tP-DZ
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 07:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723462036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FTNEksQrLdisblUVudWNfbeRRd9kGZhHe6HbGnA049s=;
 b=U0du5seoF3e8XrSrV84NJliiRHfsT7AO0mmd055l31JUQSaCNMLrzFjZDkOIdFiaI/8Qb2
 Z4+kvVKmiAwrM52YHypON6ieUFABAy0yNippt0h8KwkZXTejZsaxYlgMxVwZzh8wge2LTP
 qjyL/dnbqgYYsM/FWtzmEFrjSzCoALQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-RTz41NFPMJSvLOqdnzoT5g-1; Mon, 12 Aug 2024 07:27:15 -0400
X-MC-Unique: RTz41NFPMJSvLOqdnzoT5g-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3685a5a765fso2557258f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 04:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723462034; x=1724066834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FTNEksQrLdisblUVudWNfbeRRd9kGZhHe6HbGnA049s=;
 b=nIHrIR+Qao1pxe+nGNWVxIermsZ28SPlAHzu/hyX16M7FDP/ENodwUG1AqH2VsaTVF
 XoV1mSstcYravEOwt9d+KtQNwQjpaF/llfcajGp/GC69YvGfMKl95sTvsAEuAET2Ysph
 KErb5a/tobDbGH8smxiOVd6MzjYcgJP0usU1Usz1/JV+efaqz/IvCE1iOH5gmrVig16h
 2XsBPoPvLBVrKfZhhVIgsfBuPxvB7MX0gl+XT+qG8Dx/i61bMFJgcVzavnYU0CZu6sBX
 FSq2tZlj6wIEFk17YbTo7UGUgE1t8H/ZBxqSusQTMP035zx5cuK00GCW8c7ghATbkwnt
 BiIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjuqmnN3d8R43xO181o7fhlAnYyinpxK2p/55F/T+3ISH74QDIlIeCY05imB//yT1gZ5tlewc9QMDI@nongnu.org
X-Gm-Message-State: AOJu0YwAAa0t/I2mpi/myLwgcdUEYadASZv9SecN0kcrnkiDF48Hgiew
 5rQ65q42lBo5/2FJtb+jUWwEGt+h6A3k0ZtH+MnOMMDmbTpxzoIBSHf8Yr5bQzM3elbabzaL5tC
 e4gXSJrXC+4zUE2ccWy/RJhgvTgUSNl4dT6SXg9fUKIr4kZokU13o
X-Received: by 2002:a05:6000:bce:b0:366:f041:935d with SMTP id
 ffacd0b85a97d-36d61cd285cmr6086476f8f.60.1723462033967; 
 Mon, 12 Aug 2024 04:27:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBdE+brdDDdF8VgDTrcnurcDVAF4EbnFNjdeppQr0etaziX5FLJH8ym1YEm72TP6i2UHm1vQ==
X-Received: by 2002:a05:6000:bce:b0:366:f041:935d with SMTP id
 ffacd0b85a97d-36d61cd285cmr6086459f8f.60.1723462033386; 
 Mon, 12 Aug 2024 04:27:13 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4ebd35c8sm7152000f8f.107.2024.08.12.04.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 04:27:12 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:27:11 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 02/10] arm/virt: Wire up a GED error device for ACPI
 / GHES
Message-ID: <20240812132711.7c23df55@imammedo.users.ipa.redhat.com>
In-Reply-To: <5965df0d8c11890d43c66a2be424ac5a82614599.1723119423.git.mchehab+huawei@kernel.org>
References: <cover.1723119423.git.mchehab+huawei@kernel.org>
 <5965df0d8c11890d43c66a2be424ac5a82614599.1723119423.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu,  8 Aug 2024 14:26:28 +0200
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

other than question below mostly to arm/virt maintainers, LGTM
Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes.c           |  3 +++
>  hw/arm/virt-acpi-build.c |  1 +
>  hw/arm/virt.c            | 12 +++++++++++-
>  include/hw/acpi/ghes.h   |  3 +++
>  include/hw/arm/virt.h    |  1 +
>  5 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index e9511d9b8f71..13b105c5d02d 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -444,6 +444,9 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
>      return ret;
>  }
>  
> +NotifierList acpi_generic_error_notifiers =
> +    NOTIFIER_LIST_INITIALIZER(error_device_notifiers);
> +
>  bool acpi_ghes_present(void)
>  {
>      AcpiGedState *acpi_ged_state;
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index f76fb117adff..1769467d23b2 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -858,6 +858,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      }
>  
>      acpi_dsdt_add_power_button(scope);
> +    aml_append(scope, aml_error_device());
>  #ifdef CONFIG_TPM
>      acpi_dsdt_add_tpm(scope, vms);
>  #endif
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 687fe0bb8bc9..22448e5c5b73 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -677,7 +677,7 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
>      DeviceState *dev;
>      MachineState *ms = MACHINE(vms);
>      int irq = vms->irqmap[VIRT_ACPI_GED];
> -    uint32_t event = ACPI_GED_PWR_DOWN_EVT;
> +    uint32_t event = ACPI_GED_PWR_DOWN_EVT | ACPI_GED_ERROR_EVT;

given how often error injection would be used, does it make a sense
to make it always enabled? (it after all consumes guest RAM for
error block buffer)

Maybe we need to add a machine property to enable it when desired?
What arm/virt folk think?


>  
>      if (ms->ram_slots) {
>          event |= ACPI_GED_MEM_HOTPLUG_EVT;
> @@ -1009,6 +1009,13 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
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
> @@ -2385,6 +2392,9 @@ static void machvirt_init(MachineState *machine)
>  
>      if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
>          vms->acpi_dev = create_acpi_ged(vms);
> +        vms->generic_error_notifier.notify = virt_generic_error_req;
> +        notifier_list_add(&acpi_generic_error_notifiers,
> +                          &vms->generic_error_notifier);
>      } else {
>          create_gpio_devices(vms, VIRT_GPIO, sysmem);
>      }
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 674f6958e905..fb80897e7eac 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -23,6 +23,9 @@
>  #define ACPI_GHES_H
>  
>  #include "hw/acpi/bios-linker-loader.h"
> +#include "qemu/notify.h"
> +
> +extern NotifierList acpi_generic_error_notifiers;
>  
>  /*
>   * Values for Hardware Error Notification Type field
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index a4d937ed45ac..ad9f6e94dcc5 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -175,6 +175,7 @@ struct VirtMachineState {
>      DeviceState *gic;
>      DeviceState *acpi_dev;
>      Notifier powerdown_notifier;
> +    Notifier generic_error_notifier;
>      PCIBus *bus;
>      char *oem_id;
>      char *oem_table_id;


