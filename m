Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B939C52D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 09:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbGI3-00042f-Pv; Tue, 06 Aug 2024 05:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sbGHu-00041D-RS
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 05:15:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sbGHr-0000gJ-54
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 05:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722935722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5XhwKW5c4U1g4cZzHAN5oWzywBtrKv0PzNTnHbR+SW4=;
 b=CI/KsNfRSgD7ww+AVCHZ30GJdN1BVDnN2YcyQLbQmJ8IQdDZVe+1r+4CU6IsP8/LRpoq7+
 u2UpaGEE3xghF6/yk7/KQ66K7JgB1k1kiCMV85U1x/AYWs1P1eglVlwKDrifiD+S70nJL2
 RugYCU/Y7brz+UlDOIaFjybBGC/uaw8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-PeoL7b3AOGG0zpovU950Mg-1; Tue, 06 Aug 2024 05:15:17 -0400
X-MC-Unique: PeoL7b3AOGG0zpovU950Mg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-428fc34f41bso2990515e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 02:15:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722935716; x=1723540516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5XhwKW5c4U1g4cZzHAN5oWzywBtrKv0PzNTnHbR+SW4=;
 b=v5aCVc8xo9YCA86Fpr9L49zmKE2sdsVxKRJybT8TJssSZf+IUHHw7VgjZwfOtqlQXK
 8SliQRfQVzHutU903m/zZkxLw7EV4ktWcn/HB4/zArC5jEP/U3CD34pxoLBVzbcuWLjt
 CNEPkhk7fjr7cWVULy2/F1oxy+s0bA80f/1mVhmg4quYhm3bWM+BpqY4RBgWlOMhulqb
 SFhoVmCgEQXODGokcmiTkXoMD+SwN3ottiw75CdTTmdhzSiXo1rslSwvctHD7EijP74u
 /pKIWDYJSqGC5tndQ11S1XtP+6cN6+Ml40LYnkfut+yG2iTirvuy7S9jVeRlbZyhPLet
 D+tQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUANwzPH71urrBbCA+hgYA/21MgEUnhF2KPPAl4Y4ANsW9elitnKBF/aXQzhvtz5JlFju6f3WQKJETpIF+zJpNBPwtUOl8=
X-Gm-Message-State: AOJu0YxTMQ7Vr1BllXHjuhOqS75ZpKThj3Efgyosxk0fx4mgRBk9V8Oe
 SLY1Q2FR13pSKIX/Kb7oV7Z2Qs6UBM62xJjgcJrj45x8EsdHnFuRxr5qcDQglI2nlsJ4Bbk0Q13
 M4F1fQgQitKjWcptC//KVdr35MpVzugyjuXzCIqMMazRFJlkH7n7V
X-Received: by 2002:a05:600c:4fcb:b0:427:9a8f:9717 with SMTP id
 5b1f17b1804b1-428e6a5afc3mr120542055e9.0.1722935716167; 
 Tue, 06 Aug 2024 02:15:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfynUbZWqukL1ikowgqaVa3Y8Xs90DfG1xqFxO0dbhDyiUrxVhp7Hd8uSUD1yyMeMOc+VVqw==
X-Received: by 2002:a05:600c:4fcb:b0:427:9a8f:9717 with SMTP id
 5b1f17b1804b1-428e6a5afc3mr120541765e9.0.1722935715567; 
 Tue, 06 Aug 2024 02:15:15 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e6e03c4csm173915565e9.13.2024.08.06.02.15.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 02:15:15 -0700 (PDT)
Date: Tue, 6 Aug 2024 11:15:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 3/7] arm/virt: Wire up GPIO error source for ACPI / GHES
Message-ID: <20240806111514.680ba61e@imammedo.users.ipa.redhat.com>
In-Reply-To: <d0607d8f6116ff841b6c6a17d20f6d7077063045.1722634602.git.mchehab+huawei@kernel.org>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
 <d0607d8f6116ff841b6c6a17d20f6d7077063045.1722634602.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri,  2 Aug 2024 23:43:58 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

subj: s/GPIO/GED signaled/

> Adds support to ARM virtualization to allow handling
> a General Purpose Event (GPE) via GED error device.
s/General Purpose Event (GPE).../
  generic error ACPI Event via GED & error source device


> It is aligned with Linux Kernel patch:
> https://lore.kernel.org/lkml/1272350481-27951-8-git-send-email-ying.huang@intel.com/
> 
> Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c           |  3 +++
>  hw/arm/virt-acpi-build.c |  1 +
>  hw/arm/virt.c            | 16 +++++++++++++++-
>  include/hw/acpi/ghes.h   |  3 +++
>  include/hw/arm/virt.h    |  1 +
>  5 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index e9511d9b8f71..8d0262e6c1aa 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -444,6 +444,9 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
>      return ret;
>  }
>  
> +NotifierList generic_error_notifiers =
> +    NOTIFIER_LIST_INITIALIZER(error_device_notifiers);

s/generic_error_notifiers/acpi_generic_error_notifiers/

>  bool acpi_ghes_present(void)
>  {
>      AcpiGedState *acpi_ged_state;
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index f76fb117adff..f8bbe3e7a0b8 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -858,6 +858,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      }
>  
>      acpi_dsdt_add_power_button(scope);
> +    acpi_dsdt_add_error_device(scope);

with suggested change in 2/7, this will look like
aml_append(scope, aml_foo_device());


>  #ifdef CONFIG_TPM
>      acpi_dsdt_add_tpm(scope, vms);
>  #endif
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 687fe0bb8bc9..8b315328154f 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -73,6 +73,7 @@
>  #include "standard-headers/linux/input.h"
>  #include "hw/arm/smmuv3.h"
>  #include "hw/acpi/acpi.h"
> +#include "hw/acpi/ghes.h"
>  #include "target/arm/cpu-qom.h"
>  #include "target/arm/internals.h"
>  #include "target/arm/multiprocessing.h"
> @@ -677,7 +678,7 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
>      DeviceState *dev;
>      MachineState *ms = MACHINE(vms);
>      int irq = vms->irqmap[VIRT_ACPI_GED];
> -    uint32_t event = ACPI_GED_PWR_DOWN_EVT;
> +    uint32_t event = ACPI_GED_PWR_DOWN_EVT | ACPI_GED_ERROR_EVT;
>  
>      if (ms->ram_slots) {
>          event |= ACPI_GED_MEM_HOTPLUG_EVT;
> @@ -1009,6 +1010,15 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
>      }
>  }
>  
> +static void virt_generic_error_req(Notifier *n, void *opaque)
> +{
> +    VirtMachineState *s = container_of(n, VirtMachineState, generic_error_notifier);
> +
> +    if (s->acpi_dev) {

I'd assert her, and move check to caller so it won't even add
a notifier if acpi_dev is not present

> +        acpi_send_event(s->acpi_dev, ACPI_GENERIC_ERROR);
> +    }
> +}
> +
>  static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
>                               uint32_t phandle)
>  {
> @@ -2397,6 +2407,10 @@ static void machvirt_init(MachineState *machine)
>       vms->powerdown_notifier.notify = virt_powerdown_req;
>       qemu_register_powerdown_notifier(&vms->powerdown_notifier);
>  
> +     vms->generic_error_notifier.notify = virt_generic_error_req;
> +     notifier_list_add(&generic_error_notifiers,
> +                       &vms->generic_error_notifier);
> +
>      /* Create mmio transports, so the user can create virtio backends
>       * (which will be automatically plugged in to the transports). If
>       * no backend is created the transport will just sit harmlessly idle.
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 674f6958e905..6891eafff5ab 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -23,6 +23,9 @@
>  #define ACPI_GHES_H
>  
>  #include "hw/acpi/bios-linker-loader.h"
> +#include "qemu/notify.h"
> +
> +extern NotifierList generic_error_notifiers;
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


