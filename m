Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAF0C2BD09
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 14:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQ6PK-0007bk-Cp; Sat, 06 Jul 2024 10:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sQ6PI-0007at-KL
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 10:28:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sQ6PG-0005tJ-M7
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 10:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720276133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HPBDjfTjuF+1RRN0i/503tnhkMdhIKx1HHFpJpRnKIM=;
 b=Xmg+Lc0+/h8N1GgmaBIGexH/xwHzfbuZrABVbXCS+tOYRs862/fKHPl88d2lyR4Nr4eznT
 h+3P2IqOGMxk9becMc1ULXBn3aSFryccm1AVTqkYwTYVltC8lD2HJu6o4JunArwtZ8egIs
 JQ3mg6ulIeQJqCI0KqyWmHyR+YCaSJI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-AcenKr5aOdayKQFgrn4Grg-1; Sat, 06 Jul 2024 10:28:51 -0400
X-MC-Unique: AcenKr5aOdayKQFgrn4Grg-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-52e993e31a9so2406172e87.1
 for <qemu-devel@nongnu.org>; Sat, 06 Jul 2024 07:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720276130; x=1720880930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HPBDjfTjuF+1RRN0i/503tnhkMdhIKx1HHFpJpRnKIM=;
 b=VCwqWNtvXRhg+4dSn/jwO/2xQroLcQeWXJN3rXfecYEUTTKudd/Jx09T4+8N401X6H
 tfx1na7JcfJ2SRhQ2DEt8dpw84u1kzWBLXto2IH7e+RLhDUlVKXoNxq7LcZKOSw4WRiH
 7pZwDDK2bPL8q/G9K1vy6x0Fj5UcLCB5ynAAoOzqG+SQwxxqoo1xAQvKBrquV2JdgfN5
 D+PrpyxTzycwW3JqU9xjQZRQOH3HCXIOZlqJUX+ll226BJXh49pW7WIpBXvewXbqMYcT
 O+ymyvNQKRLT0zXiNdAPnTlyrsgXz6iJGwtQD2GOvbT6J4d/xAluOzpmmg72+n7wakuj
 kwFg==
X-Gm-Message-State: AOJu0YyD8410b0fBhdGo2hwCcp6MIRl7q8+dsDzH3i0OfNweZn7OfGvQ
 nBPYUKkhYf5vp5MtZtiABHQaKkZgErrXW2ZYPNUTeCdXFYE2AEfxMNhsSLPWtg+jxdHUDzjLPHY
 dj6kjV5F6P7MAi1q5MblG/gkyZgMK3v2DDEE1hTWx2MqRHO0Ift+s
X-Received: by 2002:a19:a412:0:b0:52c:dbc2:ea1 with SMTP id
 2adb3069b0e04-52ea061f5b7mr4464272e87.6.1720276129925; 
 Sat, 06 Jul 2024 07:28:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY2U/Uv1Ec9Kfuom0Ukeh6Bu0p497a72m1TFtCQLdWs4MKrjnfanNAf1jB4CzVUxykCw/75A==
X-Received: by 2002:a19:a412:0:b0:52c:dbc2:ea1 with SMTP id
 2adb3069b0e04-52ea061f5b7mr4464228e87.6.1720276129405; 
 Sat, 06 Jul 2024 07:28:49 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a283498sm97965215e9.41.2024.07.06.07.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jul 2024 07:28:48 -0700 (PDT)
Date: Sat, 6 Jul 2024 16:28:45 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <maz@kernel.org>,
 <jean-philippe@linaro.org>, <jonathan.cameron@huawei.com>,
 <lpieralisi@kernel.org>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <andrew.jones@linux.dev>,
 <david@redhat.com>, <philmd@linaro.org>, <eric.auger@redhat.com>,
 <oliver.upton@linux.dev>, <pbonzini@redhat.com>, <mst@redhat.com>,
 <will@kernel.org>, <gshan@redhat.com>, <rafael@kernel.org>,
 <alex.bennee@linaro.org>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>,
 <zhukeqian1@huawei.com>, <wangxiongfeng2@huawei.com>,
 <wangyanan55@huawei.com>, <jiakernel2@gmail.com>, <maobibo@loongson.cn>,
 <lixianglai@loongson.cn>, <npiggin@gmail.com>, <harshpb@linux.ibm.com>,
 <linuxarm@huawei.com>, Shaoqin Huang <shahuang@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH V13 4/8] hw/acpi: Update GED _EVT method AML with CPU scan
Message-ID: <20240706162845.3baf5568@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240607115649.214622-5-salil.mehta@huawei.com>
References: <20240607115649.214622-1-salil.mehta@huawei.com>
 <20240607115649.214622-5-salil.mehta@huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Fri, 7 Jun 2024 12:56:45 +0100
Salil Mehta <salil.mehta@huawei.com> wrote:

> OSPM evaluates _EVT method to map the event. The CPU hotplug event eventually
> results in start of the CPU scan. Scan figures out the CPU and the kind of
> event(plug/unplug) and notifies it back to the guest. Update the GED AML _EVT
> method with the call to \\_SB.CPUS.CSCN
> 
> Also, macro CPU_SCAN_METHOD might be referred in other places like during GED
> intialization so it makes sense to have its definition placed in some common
> header file like cpu_hotplug.h. But doing this can cause compilation break
> because of the conflicting macro definitions present in cpu.c and cpu_hotplug.c

one of the reasons is that you reusing legacy hw/acpi/cpu_hotplug.h,
see below for suggestion.

> and because both these files get compiled due to historic reasons of x86 world
> i.e. decision to use legacy(GPE.2)/modern(GED) CPU hotplug interface happens
> during runtime [1]. To mitigate above, for now, declare a new common macro
> ACPI_CPU_SCAN_METHOD for CPU scan method instead.
> (This needs a separate discussion later on for clean-up)
> 
> Reference:
> [1] https://lore.kernel.org/qemu-devel/1463496205-251412-24-git-send-email-imammedo@redhat.com/
> 
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Xianglai Li <lixianglai@loongson.cn>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> Tested-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  hw/acpi/cpu.c                  | 2 +-
>  hw/acpi/generic_event_device.c | 4 ++++
>  include/hw/acpi/cpu_hotplug.h  | 2 ++
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index 473b37ba88..af2b6655d2 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -327,7 +327,7 @@ const VMStateDescription vmstate_cpu_hotplug = {
>  #define CPUHP_RES_DEVICE  "PRES"
>  #define CPU_LOCK          "CPLK"
>  #define CPU_STS_METHOD    "CSTA"
> -#define CPU_SCAN_METHOD   "CSCN"
> +#define CPU_SCAN_METHOD   ACPI_CPU_SCAN_METHOD
>  #define CPU_NOTIFY_METHOD "CTFY"
>  #define CPU_EJECT_METHOD  "CEJ0"
>  #define CPU_OST_METHOD    "COST"
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 54d3b4bf9d..63226b0040 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -109,6 +109,10 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
>                  aml_append(if_ctx, aml_call0(MEMORY_DEVICES_CONTAINER "."
>                                               MEMORY_SLOT_SCAN_METHOD));
>                  break;
> +            case ACPI_GED_CPU_HOTPLUG_EVT:
> +                aml_append(if_ctx, aml_call0(ACPI_CPU_CONTAINER "."
> +                                             ACPI_CPU_SCAN_METHOD));

I don't particularly like exposing cpu hotplug internals for outside code
and then making that code do plumbing hoping that nothing will explode
in the future.

build_cpus_aml() takes event_handler_method to create a method that
can be called by platform. What I suggest is to call that method here
instead of trying to expose CPU hotplug internals and manually building
call path here.
aka:
  build_cpus_aml(event_handler_method = PATH_TO_GED_DEVICE.CSCN)
and then call here 
  aml_append(if_ctx, aml_call0(CSCN));
which will call  CSCN in GED scope, that was be populated by
build_cpus_aml() to do cpu scan properly without need to expose
cpu hotplug internal names and then trying to fixup conflicts caused by that.

PS:
we should do the same for memory hotplug, we see in context above


> +                break;
>              case ACPI_GED_PWR_DOWN_EVT:
>                  aml_append(if_ctx,
>                             aml_notify(aml_name(ACPI_POWER_BUTTON_DEVICE),
> diff --git a/include/hw/acpi/cpu_hotplug.h b/include/hw/acpi/cpu_hotplug.h
> index 48b291e45e..ef631750b4 100644
> --- a/include/hw/acpi/cpu_hotplug.h
> +++ b/include/hw/acpi/cpu_hotplug.h
> @@ -20,6 +20,8 @@
>  #include "hw/acpi/cpu.h"
>  
>  #define ACPI_CPU_HOTPLUG_REG_LEN 12
> +#define ACPI_CPU_SCAN_METHOD "CSCN"
> +#define ACPI_CPU_CONTAINER "\\_SB.CPUS"
>  
>  typedef struct AcpiCpuHotplug {
>      Object *device;


