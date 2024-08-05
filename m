Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07030C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 16:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb0kl-00083I-Rv; Mon, 05 Aug 2024 12:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sb0ki-00082O-4z
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 12:40:08 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sb0ke-0002of-LJ
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 12:40:07 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wd2CQ1lHrz6K8wS;
 Tue,  6 Aug 2024 00:37:06 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 3AA33140A87;
 Tue,  6 Aug 2024 00:39:48 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 5 Aug
 2024 17:39:47 +0100
Date: Mon, 5 Aug 2024 17:39:46 +0100
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Shiju Jose <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 <linux-kernel@vger.kernel.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 2/7] acpi/generic_event_device: add an APEI error device
Message-ID: <20240805173946.00001244@Huawei.com>
In-Reply-To: <5dfb5fb31afa249e06e0f849b37a7cb525f81215.1722634602.git.mchehab+huawei@kernel.org>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
 <5dfb5fb31afa249e06e0f849b37a7cb525f81215.1722634602.git.mchehab+huawei@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri,  2 Aug 2024 23:43:57 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Adds a Generic Event Device to handle generic hardware error
> events, supporting General Purpose Event (GPE) as specified at
> ACPI 6.5 specification at 18.3.2.7.2:
> https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#event-notification-for-generic-error-sources
> using HID PNP0C33.
> 
> The PNP0C33 device is used to report hardware errors to
> the bios via ACPI APEI Generic Hardware Error Source (GHES).
> 
> Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Much nicer with a GED event.
Happy to give SoB on this as you requested due to changes.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

One minor comment though.
The pnp0c33 device isn't technically coupled to the generic_event_device.
Perhaps that should be in aml_build.h/.c instead of where you
have it here?

Maybe we can move it later though if anyone implements non GED signalling?

Jonathan


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
>  
> +void acpi_dsdt_add_error_device(Aml *scope)
> +{
> +    Aml *dev = aml_device(ACPI_APEI_ERROR_DEVICE);
> +    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C33")));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> +    aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
> +    aml_append(scope, dev);
> +}
> +
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
>  
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


