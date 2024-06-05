Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E845C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 16:22:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEtOd-0003bH-Bx; Wed, 05 Jun 2024 12:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sEtOb-0003aS-Fo
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 12:21:53 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sEtOR-00055g-Gu
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 12:21:52 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VvXfQ2pgjz6K6CB;
 Thu,  6 Jun 2024 00:17:02 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 531C51400C8;
 Thu,  6 Jun 2024 00:21:39 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 5 Jun
 2024 17:21:38 +0100
Date: Wed, 5 Jun 2024 17:21:37 +0100
To: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, <linuxarm@huawei.com>
CC: Dave Jiang <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, <eduardo@habkost.net>,
 <imammedo@redhat.com>, <linux-cxl@vger.kernel.org>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v2 3/6] hw/acpi: Generic Port Affinity Structure support
Message-ID: <20240605172025.00003ebc@huawei.com>
In-Reply-To: <20240524100507.32106-4-Jonathan.Cameron@huawei.com>
References: <20240524100507.32106-1-Jonathan.Cameron@huawei.com>
 <20240524100507.32106-4-Jonathan.Cameron@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 24 May 2024 11:05:04 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> These are very similar to the recently added Generic Initiators
> but instead of representing an initiator of memory traffic they
> represent an edge point beyond which may lie either targets or
> initiators.  Here we add these ports such that they may
> be targets of hmat_lb records to describe the latency and
> bandwidth from host side initiators to the port.  A descoverable
> mechanism such as UEFI CDAT read from CXL devices and switches
> is used to discover the remainder fo the path and the OS can build
> up full latency and bandwidth numbers as need for work and data
> placement decisions.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

To join up the streams.  The tests added in this series failed
CI on s390 bios-tables-test.

https://lore.kernel.org/qemu-devel/ad6d572b-f39e-43ff-b11b-74fbe8ae3148@lin=
aro.org/T/#m0f6531d67ba28663bd35b359e32ddfea42db2dea

has my current theory on why and Richard is grabbing the SRAT table
which will hopefully have this as the smoking gun.

Comes back to my normal question to management.  Can I have an s390
for tests?  Where are those up to date big endian test boxes for
every developer to have on their desks?

J

> ---
> v2: Updates to QMP documentation to provide a lot more information
>     on the parameters.
> ---
>  qapi/qom.json                            |  35 ++++++
>  include/hw/acpi/acpi_generic_initiator.h |  18 ++-
>  include/hw/pci/pci_bridge.h              |   1 +
>  hw/acpi/acpi_generic_initiator.c         | 141 +++++++++++++++++------
>  hw/pci-bridge/pci_expander_bridge.c      |   1 -
>  5 files changed, 158 insertions(+), 38 deletions(-)
>=20
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 38dde6d785..9d1d86bdad 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -826,6 +826,39 @@
>    'data': { 'pci-dev': 'str',
>              'node': 'uint32' } }
> =20
> +
> +##
> +# @AcpiGenericPortProperties:
> +#
> +# Properties for acpi-generic-port objects.
> +#
> +# @pci-bus: QOM path of the PCI bus of the hostbridge associated with
> +#     this SRAT Generic Port Affinity Structure.  This is the same as
> +#     the bus parameter for the root ports attached to this host bridge.
> +#     The resulting SRAT Generic Port Affinity Structure will refer to
> +#     the ACPI object in DSDT that represents the host bridge (e.g.
> +#     ACPI0016 for CXL host bridges.) See ACPI 6.5 Section 5.2.16.7 for
> +#     more information.
> +#
> +# @node: Similar to a NUMA node ID, but instead of providing a reference
> +#     point used for defining NUMA distances and access characteristics
> +#     to memory or from an initiator (e.g. CPU), this node defines the
> +#     boundary point between non-discoverable system buses which must be
> +#     described by firmware, and a discoverable bus.  NUMA distances
> +#     and access characteristics are defined to and from that point.
> +#     For system software to establish full initiator to target
> +#     characteristics this information must be combined with information
> +#     retrieved from the discoverable part of the path.  An example would
> +#     use CDAT (see UEFI.org) information read from devices and switches
> +#     in conjunction with link characteristics read from PCIe
> +#     Configuration space.
> +#
> +# Since: 9.1
> +##
> +{ 'struct': 'AcpiGenericPortProperties',
> +  'data': { 'pci-bus': 'str',
> +            'node': 'uint32' } }
> +
>  ##
>  # @RngProperties:
>  #
> @@ -953,6 +986,7 @@
>  { 'enum': 'ObjectType',
>    'data': [
>      'acpi-generic-initiator',
> +    'acpi-generic-port',
>      'authz-list',
>      'authz-listfile',
>      'authz-pam',
> @@ -1025,6 +1059,7 @@
>    'discriminator': 'qom-type',
>    'data': {
>        'acpi-generic-initiator':     'AcpiGenericInitiatorProperties',
> +      'acpi-generic-port':          'AcpiGenericPortProperties',
>        'authz-list':                 'AuthZListProperties',
>        'authz-listfile':             'AuthZListFileProperties',
>        'authz-pam':                  'AuthZPAMProperties',
> diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/a=
cpi_generic_initiator.h
> index dd4be19c8f..1a899af30f 100644
> --- a/include/hw/acpi/acpi_generic_initiator.h
> +++ b/include/hw/acpi/acpi_generic_initiator.h
> @@ -30,6 +30,12 @@ typedef struct AcpiGenericInitiator {
>      AcpiGenericNode parent;
>  } AcpiGenericInitiator;
> =20
> +#define TYPE_ACPI_GENERIC_PORT "acpi-generic-port"
> +
> +typedef struct AcpiGenericPort {
> +    AcpiGenericInitiator parent;
> +} AcpiGenericPort;
> +
>  /*
>   * ACPI 6.3:
>   * Table 5-81 Flags =E2=80=93 Generic Initiator Affinity Structure
> @@ -49,8 +55,16 @@ typedef enum {
>   * Table 5-80 Device Handle - PCI
>   */
>  typedef struct PCIDeviceHandle {
> -    uint16_t segment;
> -    uint16_t bdf;
> +    union {
> +        struct {
> +            uint16_t segment;
> +            uint16_t bdf;
> +        };
> +        struct {
> +            uint64_t hid;
> +            uint32_t uid;
> +        };
> +    };
>  } PCIDeviceHandle;
> =20
>  void build_srat_generic_pci_initiator(GArray *table_data);
> diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
> index 5cd452115a..5456e24883 100644
> --- a/include/hw/pci/pci_bridge.h
> +++ b/include/hw/pci/pci_bridge.h
> @@ -102,6 +102,7 @@ typedef struct PXBPCIEDev {
>      PXBDev parent_obj;
>  } PXBPCIEDev;
> =20
> +#define TYPE_PXB_CXL_BUS "pxb-cxl-bus"
>  #define TYPE_PXB_DEV "pxb"
>  OBJECT_DECLARE_SIMPLE_TYPE(PXBDev, PXB_DEV)
> =20
> diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_init=
iator.c
> index c054e0e27d..85191e90ab 100644
> --- a/hw/acpi/acpi_generic_initiator.c
> +++ b/hw/acpi/acpi_generic_initiator.c
> @@ -7,6 +7,7 @@
>  #include "hw/acpi/acpi_generic_initiator.h"
>  #include "hw/acpi/aml-build.h"
>  #include "hw/boards.h"
> +#include "hw/pci/pci_bridge.h"
>  #include "hw/pci/pci_device.h"
>  #include "qemu/error-report.h"
> =20
> @@ -18,6 +19,10 @@ typedef struct AcpiGenericInitiatorClass {
>       AcpiGenericNodeClass parent_class;
>  } AcpiGenericInitiatorClass;
> =20
> +typedef struct AcpiGenericPortClass {
> +    AcpiGenericInitiatorClass parent;
> +} AcpiGenericPortClass;
> +
>  OBJECT_DEFINE_ABSTRACT_TYPE(AcpiGenericNode, acpi_generic_node,
>                              ACPI_GENERIC_NODE, OBJECT)
> =20
> @@ -30,6 +35,13 @@ OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericInitiato=
r, acpi_generic_initiator,
> =20
>  OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericInitiator, ACPI_GENERIC_INITIATOR)
> =20
> +OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericPort, acpi_generic_port,
> +                   ACPI_GENERIC_PORT, ACPI_GENERIC_NODE,
> +                   { TYPE_USER_CREATABLE },
> +                   { NULL })
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericPort, ACPI_GENERIC_PORT)
> +
>  static void acpi_generic_node_init(Object *obj)
>  {
>      AcpiGenericNode *gn =3D ACPI_GENERIC_NODE(obj);
> @@ -53,6 +65,14 @@ static void acpi_generic_initiator_finalize(Object *ob=
j)
>  {
>  }
> =20
> +static void acpi_generic_port_init(Object *obj)
> +{
> +}
> +
> +static void acpi_generic_port_finalize(Object *obj)
> +{
> +}
> +
>  static void acpi_generic_node_set_pci_device(Object *obj, const char *va=
l,
>                                               Error **errp)
>  {
> @@ -79,42 +99,61 @@ static void acpi_generic_node_set_node(Object *obj, V=
isitor *v,
>      }
> =20
>      gn->node =3D value;
> -    ms->numa_state->nodes[gn->node].has_gi =3D true;
> +    if (object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
> +        ms->numa_state->nodes[gn->node].has_gi =3D true;
> +    }
>  }
> =20
>  static void acpi_generic_node_class_init(ObjectClass *oc, void *data)
>  {
> -    object_class_property_add_str(oc, "pci-dev", NULL,
> -        acpi_generic_node_set_pci_device);
>      object_class_property_add(oc, "node", "int", NULL,
>          acpi_generic_node_set_node, NULL, NULL);
>  }
> =20
>  static void acpi_generic_initiator_class_init(ObjectClass *oc, void *dat=
a)
>  {
> +    object_class_property_add_str(oc, "pci-dev", NULL,
> +        acpi_generic_node_set_pci_device);
> +}
> +
> +static void acpi_generic_port_class_init(ObjectClass *oc, void *data)
> +{
> +    /*
> +     * Despite the ID representing a root bridge bus, same storage
> +     * can be used.
> +     */
> +    object_class_property_add_str(oc, "pci-bus", NULL,
> +        acpi_generic_node_set_pci_device);
>  }
> =20
>  /*
>   * ACPI 6.3:
>   * Table 5-78 Generic Initiator Affinity Structure
> + * ACPI 6.5:
> + * Table 5-67 Generic Port Affinity Structure
>   */
>  static void
> -build_srat_generic_pci_initiator_affinity(GArray *table_data, int node,
> -                                          PCIDeviceHandle *handle)
> +build_srat_generic_node_affinity(GArray *table_data, int node,
> +                                 PCIDeviceHandle *handle, bool gp, bool =
pci)
>  {
> -    uint8_t index;
> -
> -    build_append_int_noprefix(table_data, 5, 1);  /* Type */
> +    build_append_int_noprefix(table_data, gp ? 6 : 5, 1);  /* Type */
>      build_append_int_noprefix(table_data, 32, 1); /* Length */
>      build_append_int_noprefix(table_data, 0, 1);  /* Reserved */
> -    build_append_int_noprefix(table_data, 1, 1);  /* Device Handle Type:=
 PCI */
> +    /* Device Handle Type: PCI / ACPI */
> +    build_append_int_noprefix(table_data, pci ? 1 : 0, 1);
>      build_append_int_noprefix(table_data, node, 4);  /* Proximity Domain=
 */
> =20
>      /* Device Handle - PCI */
> -    build_append_int_noprefix(table_data, handle->segment, 2);
> -    build_append_int_noprefix(table_data, handle->bdf, 2);
> -    for (index =3D 0; index < 12; index++) {
> -        build_append_int_noprefix(table_data, 0, 1);
> +    if (pci) {
> +        /* Device Handle - PCI */
> +        build_append_int_noprefix(table_data, handle->segment, 2);
> +        build_append_int_noprefix(table_data, handle->bdf, 2);
> +        build_append_int_noprefix(table_data, 0, 12);
> +    } else {
> +        /* Device Handle - ACPI */
> +        build_append_int_noprefix(table_data, handle->hid, 8);
> +        build_append_int_noprefix(table_data, handle->uid, 4);
> +        build_append_int_noprefix(table_data, 0, 4);
>      }
> =20
>      build_append_int_noprefix(table_data, GEN_AFFINITY_ENABLED, 4); /* F=
lags */
> @@ -127,37 +166,69 @@ static int build_all_acpi_generic_initiators(Object=
 *obj, void *opaque)
>      GArray *table_data =3D opaque;
>      PCIDeviceHandle dev_handle;
>      AcpiGenericNode *gn;
> -    PCIDevice *pci_dev;
>      Object *o;
> =20
> -    if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
> +    if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_NODE)) {
>          return 0;
>      }
> =20
>      gn =3D ACPI_GENERIC_NODE(obj);
> -    if (gn->node >=3D ms->numa_state->num_nodes) {
> -        error_printf("%s: Specified node %d is invalid.\n",
> -                     TYPE_ACPI_GENERIC_INITIATOR, gn->node);
> -        exit(1);
> -    }
> =20
> -    o =3D object_resolve_path_type(gn->pci_dev, TYPE_PCI_DEVICE, NULL);
> -    if (!o) {
> -        error_printf("%s: Specified device must be a PCI device.\n",
> -                     TYPE_ACPI_GENERIC_INITIATOR);
> -        exit(1);
> -    }
> -
> -    pci_dev =3D PCI_DEVICE(o);
> -
> -    dev_handle.segment =3D 0;
> -    dev_handle.bdf =3D PCI_BUILD_BDF(pci_bus_num(pci_get_bus(pci_dev)),
> -                                   pci_dev->devfn);
> +    if (object_dynamic_cast(OBJECT(gn), TYPE_ACPI_GENERIC_INITIATOR)) {
> +        PCIDevice *pci_dev;
> +
> +        if (gn->node >=3D ms->numa_state->num_nodes) {
> +            error_printf("%s: Specified node %d is invalid.\n",
> +                         TYPE_ACPI_GENERIC_INITIATOR, gn->node);
> +            exit(1);
> +        }
> +
> +        o =3D object_resolve_path_type(gn->pci_dev, TYPE_PCI_DEVICE, NUL=
L);
> +        if (!o) {
> +            error_printf("%s: Specified device must be a PCI device.\n",
> +                         TYPE_ACPI_GENERIC_INITIATOR);
> +            exit(1);
> +        }
> +        pci_dev =3D PCI_DEVICE(o);
> +
> +        dev_handle.segment =3D 0;
> +        dev_handle.bdf =3D PCI_BUILD_BDF(pci_bus_num(pci_get_bus(pci_dev=
)),
> +                                       pci_dev->devfn);
> +        build_srat_generic_node_affinity(table_data,
> +                                         gn->node, &dev_handle, false, t=
rue);
> =20
> -    build_srat_generic_pci_initiator_affinity(table_data,
> -                                              gn->node, &dev_handle);
> +        return 0;
> +    } else { /* TYPE_ACPI_GENERIC_PORT */
> +        PCIBus *bus;
> +        const char *hid =3D "ACPI0016";
> +
> +        if (gn->node >=3D ms->numa_state->num_nodes) {
> +            error_printf("%s: Specified node %d is invalid.\n",
> +                         TYPE_ACPI_GENERIC_PORT, gn->node);
> +            exit(1);
> +        }
> +
> +        o =3D object_resolve_path_type(gn->pci_dev, TYPE_PCI_BUS, NULL);
> +        if (!o) {
> +            error_printf("%s: Specified device must be a PCI Host Bridge=
.\n",
> +                         TYPE_ACPI_GENERIC_PORT);
> +            exit(1);
> +        }
> +        bus =3D PCI_BUS(o);
> +        /* Need to know if this is a PXB Bus so below an expander bridge=
 */
> +        if (!object_dynamic_cast(OBJECT(bus), TYPE_PXB_CXL_BUS)) {
> +            error_printf("%s: Specified device is not a bus below a host=
 bridge.\n",
> +                         TYPE_ACPI_GENERIC_PORT);
> +            exit(1);
> +        }
> +        /* Copy without trailing NULL */
> +        memcpy(&dev_handle.hid, hid, sizeof(dev_handle.hid));
> +        dev_handle.uid =3D pci_bus_num(bus);
> +        build_srat_generic_node_affinity(table_data,
> +                                         gn->node, &dev_handle, true, fa=
lse);
> =20
> -    return 0;
> +        return 0;
> +    }
>  }
> =20
>  void build_srat_generic_pci_initiator(GArray *table_data)
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expa=
nder_bridge.c
> index 0411ad31ea..f5431443b9 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -38,7 +38,6 @@ DECLARE_INSTANCE_CHECKER(PXBBus, PXB_BUS,
>  DECLARE_INSTANCE_CHECKER(PXBBus, PXB_PCIE_BUS,
>                           TYPE_PXB_PCIE_BUS)
> =20
> -#define TYPE_PXB_CXL_BUS "pxb-cxl-bus"
>  DECLARE_INSTANCE_CHECKER(PXBBus, PXB_CXL_BUS,
>                           TYPE_PXB_CXL_BUS)
> =20


