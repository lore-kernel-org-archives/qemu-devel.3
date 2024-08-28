Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86705C636E5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 16:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjLw7-0002IU-Gk; Wed, 28 Aug 2024 12:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sjLw5-0002DS-3g
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 12:54:21 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sjLw2-0007Ah-1Z
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 12:54:20 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wv9Pn1xZhz6K6Q2;
 Thu, 29 Aug 2024 00:50:05 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 2E4791400D4;
 Thu, 29 Aug 2024 00:54:07 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 17:54:06 +0100
Date: Wed, 28 Aug 2024 17:54:05 +0100
To: Igor Mammedov <imammedo@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>, <mst@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <linuxarm@huawei.com>,
 <linux-cxl@vger.kernel.org>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Dave
 Jiang <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>, Paolo
 Bonzini <pbonzini@redhat.com>, <eduardo@habkost.net>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v5 10/13] hw/acpi: Generic Port Affinity Structure support
Message-ID: <20240828175405.00004b4b@Huawei.com>
In-Reply-To: <20240715164841.1979fdea@imammedo.users.ipa.redhat.com>
References: <20240712110837.1439736-1-Jonathan.Cameron@huawei.com>
 <20240712110837.1439736-11-Jonathan.Cameron@huawei.com>
 <20240715164841.1979fdea@imammedo.users.ipa.redhat.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 15 Jul 2024 16:48:41 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Fri, 12 Jul 2024 12:08:14 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > These are very similar to the recently added Generic Initiators
> > but instead of representing an initiator of memory traffic they
> > represent an edge point beyond which may lie either targets or
> > initiators.  Here we add these ports such that they may
> > be targets of hmat_lb records to describe the latency and
> > bandwidth from host side initiators to the port.  A discoverable
> > mechanism such as UEFI CDAT read from CXL devices and switches
> > is used to discover the remainder of the path, and the OS can build
> > up full latency and bandwidth numbers as need for work and data
> > placement decisions.
> > 
> > Acked-by: Markus Armbruster <armbru@redhat.com>
> > Tested-by: "Huang, Ying" <ying.huang@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> ACPI tables generation LGTM
> As for the rest my review is perfunctory mostly.
Hi Igor,

Given I guess we will soon be in the 9.2 cycle, revisiting this
to prepare a v6.

Added missing parameter descriptions for properties in here
and an additional patch for the ones missing for
generic initiators.  Another patch fixes the uint32_t fragilty
you pointed out for generic initiators (fixed here as well)

2 things remain, the docs and the question you are asked Markus.

See inline.

> 
> > ---
> > v5: Push the definition of TYPE_ACPI_GENERIC_PORT down into the
> >     c file (similar to TYPE_ACPI_GENERIC_INITIATOR in earlier patch)
> > ---
> >  qapi/qom.json                       |  34 +++++++++
> >  include/hw/acpi/aml-build.h         |   4 +
> >  include/hw/acpi/pci.h               |   2 +-
> >  include/hw/pci/pci_bridge.h         |   1 +
> >  hw/acpi/aml-build.c                 |  40 ++++++++++
> >  hw/acpi/pci.c                       | 112 +++++++++++++++++++++++++++-
> >  hw/arm/virt-acpi-build.c            |   2 +-
> >  hw/i386/acpi-build.c                |   2 +-
> >  hw/pci-bridge/pci_expander_bridge.c |   1 -
> >  9 files changed, 193 insertions(+), 5 deletions(-)
> > 
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index 8e75a419c3..b97c031b73 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -838,6 +838,38 @@
> >    'data': { 'pci-dev': 'str',
> >              'node': 'uint32' } }
> >  
> > +##
> > +# @AcpiGenericPortProperties:
> > +#
> > +# Properties for acpi-generic-port objects.
> > +#
> > +# @pci-bus: QOM path of the PCI bus of the hostbridge associated with
> > +#     this SRAT Generic Port Affinity Structure.  This is the same as
> > +#     the bus parameter for the root ports attached to this host
> > +#     bridge.  The resulting SRAT Generic Port Affinity Structure will
> > +#     refer to the ACPI object in DSDT that represents the host bridge
> > +#     (e.g.  ACPI0016 for CXL host bridges).  See ACPI 6.5 Section
> > +#     5.2.16.7 for more information.
> > +#  
> 
> > +# @node: Similar to a NUMA node ID, but instead of providing a
> > +#     reference point used for defining NUMA distances and access
> > +#     characteristics to memory or from an initiator (e.g. CPU), this
> > +#     node defines the boundary point between non-discoverable system
> > +#     buses which must be described by firmware, and a discoverable
> > +#     bus.  NUMA distances and access characteristics are defined to
> > +#     and from that point.  For system software to establish full
> > +#     initiator to target characteristics this information must be
> > +#     combined with information retrieved from the discoverable part
> > +#     of the path.  An example would use CDAT (see UEFI.org)
> > +#     information read from devices and switches in conjunction with
> > +#     link characteristics read from PCIe Configuration space.  
> 
> you lost me here (even reading this several time doesn't help).
> Perhaps I lack specific domain knowledge, but is there a way to make it
> more comprehensible for layman?

I've had a few passes and clearly still failing :(

Maybe an example is the way to go?  Does the following help?
(replacing the 'An example sentence' above).

#       For example, a CXL Memory device M is directly
#       plugged into a CXL root port P which is part of a
#       CXL root bridge B. To calculate latency from a CPU in
#       the host to the memory on M, the latency from that CPU
#       to the bridge B (and hence port P)* must be added
#       to the latency due to the CXL Link between P and M
#       (calculated from link status registers) and that from
#       the CXL port on device M to the actual memory (read from
#       CDAT via a mailbox on the device).
#       The CPU to root bridge latency (*) is provided by ACPI HMAT.
#       HMAT latency data is indexed with the combination of the
#       proximity domain for the CPU and that for the root bridge.
#       This node value is the root bridge part of that index pair.     	



...


> > +static int build_acpi_generic_port(Object *obj, void *opaque)
> > +{
> > +    MachineState *ms = MACHINE(qdev_get_machine());
> > +    const char *hid = "ACPI0016";
> > +    GArray *table_data = opaque;
> > +    AcpiGenericPort *gp;
> > +    uint32_t uid;
> > +    Object *o;
> > +
> > +    if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_PORT)) {
> > +        return 0;
> > +    }
> > +
> > +    gp = ACPI_GENERIC_PORT(obj);
> > +
> > +    if (gp->node >= ms->numa_state->num_nodes) {  
> 
> > +        error_printf("%s: node %d is invalid.\n",
> > +                     TYPE_ACPI_GENERIC_PORT, gp->node);
> > +        exit(1);  
> 
> not sure, 
> maybe use error_fatal instead of using exit(1)?
> 
> CCing Markus to check if it's ok.

Markus?

> 
> 
> > +    }
> > +
> > +    o = object_resolve_path_type(gp->pci_bus, TYPE_PXB_CXL_BUS, NULL);
> > +    if (!o) {
> > +        error_printf("%s: device must be a CXL host bridge.\n",
> > +                     TYPE_ACPI_GENERIC_PORT);
> > +       exit(1);
> > +    }  
> ditto
> 



