Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174FBC3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 05:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbD5j-0007Bs-RS; Tue, 06 Aug 2024 01:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sbD5f-0007Av-TY
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 01:50:36 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sbD5a-0007Ok-Re
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 01:50:34 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 185C4CE009F;
 Tue,  6 Aug 2024 05:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C38C32786;
 Tue,  6 Aug 2024 05:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722923422;
 bh=UiWQS7gc3ysLCHL9aHj72FbRoBMkgpHs3tYBo3erZz4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=hV43y14XMABUY81yE+YC+2Td9A7tvcct9m87Hg0EGry0HVNNIEMjlUszPrOzorXEN
 2M492EF4PI/ZjDfckEbeDV1GYm7IFG2Qdi1QfsB6jsmTnOjkqmjCjGtg0fHixtDQ5G
 M8XeLAZUZhUranSfNg4NUgK/DCMH8IrFrqerFPZJYdmXZJqS90uq/uT2qT61RIMYeT
 lusFzM3NGa9BxAbrdyzTrg0XMH+R7jo8SpDRdoY2O58i8gpY8UUXaajQWFtfXaaVCQ
 1IEiwNQ7sk0llWpAG9MLEvCuQ6IhWGUEXZ+aapS9jEHl8Pk9lI+z7OLkRz8ZE0lyQq
 IOxRpHV45FstQ==
Date: Tue, 6 Aug 2024 07:50:18 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Shiju Jose <shiju.jose@huawei.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, <linux-kernel@vger.kernel.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 2/7] acpi/generic_event_device: add an APEI error device
Message-ID: <20240806075018.46ff22ea@foz.lan>
In-Reply-To: <20240805173946.00001244@Huawei.com>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
 <5dfb5fb31afa249e06e0f849b37a7cb525f81215.1722634602.git.mchehab+huawei@kernel.org>
 <20240805173946.00001244@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=mchehab+huawei@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Em Mon, 5 Aug 2024 17:39:46 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:

> On Fri,  2 Aug 2024 23:43:57 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Adds a Generic Event Device to handle generic hardware error
> > events, supporting General Purpose Event (GPE) as specified at
> > ACPI 6.5 specification at 18.3.2.7.2:
> > https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#event-notification-for-generic-error-sources
> > using HID PNP0C33.
> > 
> > The PNP0C33 device is used to report hardware errors to
> > the bios via ACPI APEI Generic Hardware Error Source (GHES).
> > 
> > Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> Much nicer with a GED event.
> Happy to give SoB on this as you requested due to changes.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> One minor comment though.
> The pnp0c33 device isn't technically coupled to the generic_event_device.
> Perhaps that should be in aml_build.h/.c instead of where you
> have it here?
> 
> Maybe we can move it later though if anyone implements non GED signalling?

I opted to place it there at hw/acpi/generic_event_device.c, just after 
PNP0C0C, e. g.:

	void acpi_dsdt_add_power_button(Aml *scope)
	{
	    Aml *dev = aml_device(ACPI_POWER_BUTTON_DEVICE);
	    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C0C")));
	    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
	    aml_append(scope, dev);
	}
	
	void acpi_dsdt_add_error_device(Aml *scope)
	{
	    Aml *dev = aml_device(ACPI_APEI_ERROR_DEVICE);
	    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C33")));
	    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
	    aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
	    aml_append(scope, dev);
	}

IMO this way it will be kept closer to other PNP devices. If this starts
to grow, then some later cleanup could move those to some separate file,
but, as now there are just two, I would just keep both there at GED
file.

> 
> Jonathan
> 
> 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  hw/acpi/generic_event_device.c         | 17 +++++++++++++++++
> >  include/hw/acpi/acpi_dev_interface.h   |  1 +
> >  include/hw/acpi/generic_event_device.h |  3 +++
> >  3 files changed, 21 insertions(+)
> > 
> > diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> > index 15b4c3ebbf24..b9ad05e98c05 100644
> > --- a/hw/acpi/generic_event_device.c
> > +++ b/hw/acpi/generic_event_device.c
> > @@ -26,6 +26,7 @@ static const uint32_t ged_supported_events[] = {
> >      ACPI_GED_PWR_DOWN_EVT,
> >      ACPI_GED_NVDIMM_HOTPLUG_EVT,
> >      ACPI_GED_CPU_HOTPLUG_EVT,
> > +    ACPI_GED_ERROR_EVT
> >  };
> >  
> >  /*
> > @@ -116,6 +117,11 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
> >                             aml_notify(aml_name(ACPI_POWER_BUTTON_DEVICE),
> >                                        aml_int(0x80)));
> >                  break;
> > +            case ACPI_GED_ERROR_EVT:
> > +                aml_append(if_ctx,
> > +                           aml_notify(aml_name(ACPI_APEI_ERROR_DEVICE),
> > +                                      aml_int(0x80)));
> > +                break;
> >              case ACPI_GED_NVDIMM_HOTPLUG_EVT:
> >                  aml_append(if_ctx,
> >                             aml_notify(aml_name("\\_SB.NVDR"),
> > @@ -153,6 +159,15 @@ void acpi_dsdt_add_power_button(Aml *scope)
> >      aml_append(scope, dev);
> >  }
> >  
> > +void acpi_dsdt_add_error_device(Aml *scope)
> > +{
> > +    Aml *dev = aml_device(ACPI_APEI_ERROR_DEVICE);
> > +    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C33")));
> > +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> > +    aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
> > +    aml_append(scope, dev);
> > +}
> > +
> >  /* Memory read by the GED _EVT AML dynamic method */
> >  static uint64_t ged_evt_read(void *opaque, hwaddr addr, unsigned size)
> >  {
> > @@ -295,6 +310,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
> >          sel = ACPI_GED_MEM_HOTPLUG_EVT;
> >      } else if (ev & ACPI_POWER_DOWN_STATUS) {
> >          sel = ACPI_GED_PWR_DOWN_EVT;
> > +    } else if (ev & ACPI_GENERIC_ERROR) {
> > +        sel = ACPI_GED_ERROR_EVT;
> >      } else if (ev & ACPI_NVDIMM_HOTPLUG_STATUS) {
> >          sel = ACPI_GED_NVDIMM_HOTPLUG_EVT;
> >      } else if (ev & ACPI_CPU_HOTPLUG_STATUS) {
> > diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
> > index 68d9d15f50aa..8294f8f0ccca 100644
> > --- a/include/hw/acpi/acpi_dev_interface.h
> > +++ b/include/hw/acpi/acpi_dev_interface.h
> > @@ -13,6 +13,7 @@ typedef enum {
> >      ACPI_NVDIMM_HOTPLUG_STATUS = 16,
> >      ACPI_VMGENID_CHANGE_STATUS = 32,
> >      ACPI_POWER_DOWN_STATUS = 64,
> > +    ACPI_GENERIC_ERROR = 128,
> >  } AcpiEventStatusBits;
> >  
> >  #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"
> > diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> > index 40af3550b56d..b8f2f1328e0c 100644
> > --- a/include/hw/acpi/generic_event_device.h
> > +++ b/include/hw/acpi/generic_event_device.h
> > @@ -66,6 +66,7 @@
> >  #include "qom/object.h"
> >  
> >  #define ACPI_POWER_BUTTON_DEVICE "PWRB"
> > +#define ACPI_APEI_ERROR_DEVICE   "GEDD"
> >  
> >  #define TYPE_ACPI_GED "acpi-ged"
> >  OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
> > @@ -98,6 +99,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
> >  #define ACPI_GED_PWR_DOWN_EVT      0x2
> >  #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
> >  #define ACPI_GED_CPU_HOTPLUG_EVT    0x8
> > +#define ACPI_GED_ERROR_EVT          0x10
> >  
> >  typedef struct GEDState {
> >      MemoryRegion evt;
> > @@ -120,5 +122,6 @@ struct AcpiGedState {
> >  void build_ged_aml(Aml *table, const char* name, HotplugHandler *hotplug_dev,
> >                     uint32_t ged_irq, AmlRegionSpace rs, hwaddr ged_base);
> >  void acpi_dsdt_add_power_button(Aml *scope);
> > +void acpi_dsdt_add_error_device(Aml *scope);
> >  
> >  #endif  
> 



Thanks,
Mauro

