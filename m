Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62388C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 08:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbFy9-0006Py-6E; Tue, 06 Aug 2024 04:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sbFy7-0006Oo-2F
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 04:54:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sbFy4-00065O-Pn
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 04:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722934495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r07E9H1rgLrYPOS17s56ejzb5np4x5ByeVYAOU7MQEk=;
 b=WXI6HcrO1Za55hOAt1NlFeoNOF505E3LVLGWLqd0yDywc7R2oAVxKXNBHxo2Gs6ck6GpEE
 Rd6HunJgTOnTshWLoYZM0GB2L0Mh/8Ak3WUhpfCP7e8Ih8Co0g1/H9On06z8dQF+R5YT42
 7o/CTPoUt5dJ24OTONRDFDnRRpr6huw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-4mRgmP0yM_CdO-nmhrB5_w-1; Tue, 06 Aug 2024 04:54:52 -0400
X-MC-Unique: 4mRgmP0yM_CdO-nmhrB5_w-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ef2018bb2dso5085441fa.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 01:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722934491; x=1723539291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r07E9H1rgLrYPOS17s56ejzb5np4x5ByeVYAOU7MQEk=;
 b=RSBdxQIdQevIqapiUSxuImdOUv35vLlYIwZwShVl2i9tZ8/SiRm9r8cxxwDVVdyn/o
 DtGYkPP+5t1dlJ2w8HGW0pG+Vxc7gKJUF3Bvo8vJLXsfXHriRStIE2gF5tOUMbrnM1Zf
 tagRCx2UDnxSR12i3JbjiEOU45/4FrmwehkN9N2PXHgITUnSZYEa0jCZhUmVNS8R3TiG
 IQmU6MXeKJ4QOPKUVT/+cmtPsQ2pDA1vQSumDJUxuo/RBlMbOVmMIdmRuYKthTHMLlfT
 Dc+B7bUqP7AQuCuh8gmRf0upZfu2OHXCS6nh+yRZ3kAt+Ezidtw/t1sIaO9rkUGfHd0X
 T9Ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5IDAqw7yXbc1oaeFF318NDCN8E6tKwWiLFFCzbSQCChuxg5fXNiAW8iuaT+VjiRPHbeOHmQIVVy0rGG0juL4XM4DZyBU=
X-Gm-Message-State: AOJu0YyS9pR9nv6JA2WktP/otCadxv+HwgonSWW4QXfKjjnFKy/xAHpB
 BZpkbcsveZsVTOJG+2iSmigUUeVCrsOfq1uEANoGXd/ZuZ59wxWz2P4XegXv8iebbVka/JKyMaR
 6DE0hfE8gjFk5ez/XUrKiaEOTqlGHUJ8/dl5DuGHoly6cKBns185h
X-Received: by 2002:a2e:b70a:0:b0:2ef:2c6a:4929 with SMTP id
 38308e7fff4ca-2f15aa87463mr107457001fa.13.1722934491165; 
 Tue, 06 Aug 2024 01:54:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGy2PVMQlGk7p+Zenu+n0oxwpTRBTQeY18WuEh0Km+j07OjsfEQvtwu6ez96agLYLXNZ3GN+w==
X-Received: by 2002:a2e:b70a:0:b0:2ef:2c6a:4929 with SMTP id
 38308e7fff4ca-2f15aa87463mr107456691fa.13.1722934490586; 
 Tue, 06 Aug 2024 01:54:50 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e6e9d234sm169680675e9.46.2024.08.06.01.54.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 01:54:50 -0700 (PDT)
Date: Tue, 6 Aug 2024 10:54:48 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 2/7] acpi/generic_event_device: add an APEI error device
Message-ID: <20240806105448.7177f6b1@imammedo.users.ipa.redhat.com>
In-Reply-To: <5dfb5fb31afa249e06e0f849b37a7cb525f81215.1722634602.git.mchehab+huawei@kernel.org>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
 <5dfb5fb31afa249e06e0f849b37a7cb525f81215.1722634602.git.mchehab+huawei@kernel.org>
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

On Fri,  2 Aug 2024 23:43:57 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

subj: s/APEI/error/

to match spec

> Adds a Generic Event Device to handle generic hardware error
                 ^^^^^
Did you want to say: Error ?
 
> events, supporting General Purpose Event (GPE) as specified at
even though GPE can be used (for example with non hw-reduced pc/q35 machines),
it's not what you are doing here.
s/General Purpose Event (GPE)/generic event device/

> ACPI 6.5 specification at 18.3.2.7.2:
> https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#event-notification-for-generic-error-sources
> using HID PNP0C33.
> 
> The PNP0C33 device is used to report hardware errors to
> the bios via ACPI APEI Generic Hardware Error Source (GHES).

event is sent not to 'bios' but to the guest, OSPM in spec language

> 
> Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/generic_event_device.c         | 17 +++++++++++++++++
>  include/hw/acpi/acpi_dev_interface.h   |  1 +
>  include/hw/acpi/generic_event_device.h |  3 +++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 15b4c3ebbf24..b9ad05e98c05 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -26,6 +26,7 @@ static const uint32_t ged_supported_events[] = {
>      ACPI_GED_PWR_DOWN_EVT,
>      ACPI_GED_NVDIMM_HOTPLUG_EVT,
>      ACPI_GED_CPU_HOTPLUG_EVT,
> +    ACPI_GED_ERROR_EVT
>  };
>  
>  /*
> @@ -116,6 +117,11 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
>                             aml_notify(aml_name(ACPI_POWER_BUTTON_DEVICE),
>                                        aml_int(0x80)));
>                  break;
> +            case ACPI_GED_ERROR_EVT:
> +                aml_append(if_ctx,
> +                           aml_notify(aml_name(ACPI_APEI_ERROR_DEVICE),
> +                                      aml_int(0x80)));
> +                break;
>              case ACPI_GED_NVDIMM_HOTPLUG_EVT:
>                  aml_append(if_ctx,
>                             aml_notify(aml_name("\\_SB.NVDR"),
> @@ -153,6 +159,15 @@ void acpi_dsdt_add_power_button(Aml *scope)
>      aml_append(scope, dev);
>  }


put mandatory comment here, in format: earliest spec rev + chapter
> +void acpi_dsdt_add_error_device(Aml *scope)

s/void acpi_dsdt_add_error_device/Aml* aml_error_device()/

> +{
> +    Aml *dev = aml_device(ACPI_APEI_ERROR_DEVICE);
> +    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C33")));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));

> +    aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
not necessary unless you want set it anything else beside 0xF

> +    aml_append(scope, dev);
> +}

and maybe move the function to aml-build.c

>  /* Memory read by the GED _EVT AML dynamic method */
>  static uint64_t ged_evt_read(void *opaque, hwaddr addr, unsigned size)
>  {
> @@ -295,6 +310,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>          sel = ACPI_GED_MEM_HOTPLUG_EVT;
>      } else if (ev & ACPI_POWER_DOWN_STATUS) {
>          sel = ACPI_GED_PWR_DOWN_EVT;
> +    } else if (ev & ACPI_GENERIC_ERROR) {
> +        sel = ACPI_GED_ERROR_EVT;
>      } else if (ev & ACPI_NVDIMM_HOTPLUG_STATUS) {
>          sel = ACPI_GED_NVDIMM_HOTPLUG_EVT;
>      } else if (ev & ACPI_CPU_HOTPLUG_STATUS) {
> diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
> index 68d9d15f50aa..8294f8f0ccca 100644
> --- a/include/hw/acpi/acpi_dev_interface.h
> +++ b/include/hw/acpi/acpi_dev_interface.h
> @@ -13,6 +13,7 @@ typedef enum {
>      ACPI_NVDIMM_HOTPLUG_STATUS = 16,
>      ACPI_VMGENID_CHANGE_STATUS = 32,
>      ACPI_POWER_DOWN_STATUS = 64,
> +    ACPI_GENERIC_ERROR = 128,
>  } AcpiEventStatusBits;
>  
>  #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> index 40af3550b56d..b8f2f1328e0c 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -66,6 +66,7 @@
>  #include "qom/object.h"
>  
>  #define ACPI_POWER_BUTTON_DEVICE "PWRB"

> +#define ACPI_APEI_ERROR_DEVICE   "GEDD"

perhaps aml_build.h would be a better place
(if you consider using it with pc/q35 machines)

>  #define TYPE_ACPI_GED "acpi-ged"
>  OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
> @@ -98,6 +99,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>  #define ACPI_GED_PWR_DOWN_EVT      0x2
>  #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
>  #define ACPI_GED_CPU_HOTPLUG_EVT    0x8
> +#define ACPI_GED_ERROR_EVT          0x10
>  
>  typedef struct GEDState {
>      MemoryRegion evt;
> @@ -120,5 +122,6 @@ struct AcpiGedState {
>  void build_ged_aml(Aml *table, const char* name, HotplugHandler *hotplug_dev,
>                     uint32_t ged_irq, AmlRegionSpace rs, hwaddr ged_base);
>  void acpi_dsdt_add_power_button(Aml *scope);
> +void acpi_dsdt_add_error_device(Aml *scope);
>  
>  #endif


