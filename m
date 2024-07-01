Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD170C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJRO-0000Uk-9s; Mon, 01 Jul 2024 11:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sOJRM-0000TP-C1
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:59:40 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sOJRK-0001yc-0P
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:59:40 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WCW141DR0z6K62D;
 Mon,  1 Jul 2024 23:58:32 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id D7CDE140B63;
 Mon,  1 Jul 2024 23:59:29 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 1 Jul
 2024 16:59:29 +0100
Date: Mon, 1 Jul 2024 16:59:28 +0100
To: Igor Mammedov <imammedo@redhat.com>
CC: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 05/11] hw/pci: Add a bus property to pci_props and
 use for acpi/gi
Message-ID: <20240701165928.00006213@Huawei.com>
In-Reply-To: <20240628135804.12434f5e@imammedo.users.ipa.redhat.com>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
 <20240620160324.109058-6-Jonathan.Cameron@huawei.com>
 <20240627150912.6ce774b1@imammedo.users.ipa.redhat.com>
 <20240628135804.12434f5e@imammedo.users.ipa.redhat.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.174.77]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
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

On Fri, 28 Jun 2024 13:58:04 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Thu, 27 Jun 2024 15:09:12 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Thu, 20 Jun 2024 17:03:13 +0100
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> >   
> > > Using a property allows us to hide the internal details of the PCI device
> > > from the code to build a SRAT Generic Initiator Affinity Structure with
> > > PCI Device Handle.
> > > 
> > > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > ---
> > > V3: New patch
> > > ---
> > >  hw/acpi/acpi_generic_initiator.c | 11 ++++++-----
> > >  hw/pci/pci.c                     | 14 ++++++++++++++
> > >  2 files changed, 20 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
> > > index 73bafaaaea..34284359f0 100644
> > > --- a/hw/acpi/acpi_generic_initiator.c
> > > +++ b/hw/acpi/acpi_generic_initiator.c
> > > @@ -9,6 +9,7 @@
> > >  #include "hw/boards.h"
> > >  #include "hw/pci/pci_device.h"
> > >  #include "qemu/error-report.h"
> > > +#include "qapi/error.h"
> > >  
> > >  typedef struct AcpiGenericInitiatorClass {
> > >      ObjectClass parent_class;
> > > @@ -79,7 +80,7 @@ static int build_acpi_generic_initiator(Object *obj, void *opaque)
> > >      MachineState *ms = MACHINE(qdev_get_machine());
> > >      AcpiGenericInitiator *gi;
> > >      GArray *table_data = opaque;
> > > -    PCIDevice *pci_dev;
> > > +    uint8_t bus, devfn;
> > >      Object *o;
> > >  
> > >      if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
> > > @@ -100,10 +101,10 @@ static int build_acpi_generic_initiator(Object *obj, void *opaque)
> > >          exit(1);
> > >      }
> > >  
> > > -    pci_dev = PCI_DEVICE(o);
> > > -    build_srat_pci_generic_initiator(table_data, gi->node, 0,
> > > -                                     pci_bus_num(pci_get_bus(pci_dev)),
> > > -                                     pci_dev->devfn);
> > > +    bus = object_property_get_uint(o, "bus", &error_fatal);
> > > +    devfn = object_property_get_uint(o, "addr", &error_fatal);
> > > +
> > > +    build_srat_pci_generic_initiator(table_data, gi->node, 0, bus, devfn);
> > >  
> > >      return 0;
> > >  }
> > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > index 324c1302d2..b4b499b172 100644
> > > --- a/hw/pci/pci.c
> > > +++ b/hw/pci/pci.c
> > > @@ -67,6 +67,19 @@ static char *pcibus_get_fw_dev_path(DeviceState *dev);
> > >  static void pcibus_reset_hold(Object *obj, ResetType type);
> > >  static bool pcie_has_upstream_port(PCIDevice *dev);
> > >  
> > > +static void prop_pci_bus_get(Object *obj, Visitor *v, const char *name,
> > > +                             void *opaque, Error **errp)
> > > +{
> > > +    uint8_t bus = pci_dev_bus_num(PCI_DEVICE(obj));
> > > +
> > > +    visit_type_uint8(v, name, &bus, errp);
> > > +}
> > > +
> > > +static const PropertyInfo prop_pci_bus = {
> > > +    .name = "bus",    
> > 
> > /me confused,
> > didn't we have 'bus' property for PCI devices already?
> > 
> > i.e. I can add PCI device like this
> >   -device e1000,bus=pci.0,addr=0x6,...  
> 
> to avoid confusion, I'd suggest to name it to 'busnr'
> (or be more specific (primary|secondary)_busnr if applicable)
For generic initiators we are always dealing with an EP so I think
busnr alone is appropriate. If we need similar for bridges we
can add that later.


> 
> >   
> >   
> > > +    .get = prop_pci_bus_get,
> > > +};
> > > +
> > >  static Property pci_props[] = {
> > >      DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
> > >      DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
> > > @@ -85,6 +98,7 @@ static Property pci_props[] = {
> > >                      QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
> > >      DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
> > >                      QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
> > > +    { .name = "bus", .info = &prop_pci_bus },
> > >      DEFINE_PROP_END_OF_LIST()
> > >  };
> > >      
> >   
> 
> 


