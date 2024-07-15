Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C8CC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 14:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTN0W-0001AE-4s; Mon, 15 Jul 2024 10:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTN0U-00019K-0z
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 10:48:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTN0R-0002zE-Ad
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 10:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721054926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8hjOBwScs6Y159MlmdMvnyA8iJHd/1eRdc8iKf3WuJg=;
 b=hrg/QEvJ16Gw99nTS5GrNO1sJ3HoqZJlYxfw6iQHjSCBRIAnZz+oaXmfou562N+EyXqvfF
 pcGxsHpvaN7K/oIhI9U+uQIYM8ob0r0uP33rtbulIe1nIyITlHRLNz4u8JndUdMk8BgUqA
 ZOyPi0ClRb7hD+Ql0nZavUZqWj1VHqY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-ayAYFYrgOvaikeNyG3nbjQ-1; Mon, 15 Jul 2024 10:48:44 -0400
X-MC-Unique: ayAYFYrgOvaikeNyG3nbjQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3678f832c75so3939733f8f.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 07:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721054923; x=1721659723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8hjOBwScs6Y159MlmdMvnyA8iJHd/1eRdc8iKf3WuJg=;
 b=PLPo/QummYyeurR2am1fAsNWYqi54O6RxfAZ5PM6Mkt9zGyq7YMjIDcDryIJRqCX2K
 OGBS/sAPVw5rer3mgwYP7eBcvvU3s53pfUQYn8mEMw/vxKwXezH6Vz6KL3ju6lOkkDFD
 lrjpGJQceziNr3pwGufZQsGgM0RAfdOipdIxlwQdsCdGi+Nzw2Z8A0/8kaYd8DBxLXp1
 lc59B6O9kZ3LUk7Bep5OkV1bcdShtDBrN543b6+kYCz4urP9QwRJhMhWuJybnqDYLful
 14eZMBMMBXHDLtzmmUtUQynOatb/rI7EX8X4fvU48gmQr7CJEn1TTILfkZhDl7SO29ug
 8kVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQ1rkiW9PrcufRnmac0ySMHMqgybXW8MpgAKFa+y6Rk9nobek+R63066OIHhO8tnw5NGfMOaaxLaVN/Oeu1GFF5jt2jd4=
X-Gm-Message-State: AOJu0YywC4R5HZUqiRy4oMWJ26ZTvl1RHq46HzUhIKlkdNNMQHLWu9xB
 DQEL2kYcXnC5T/mu+7QocfnJOcAmo2r3E+cZ2j1rbYLO5iTZLVK1FqvxYCICpVehETRZhrVEAFf
 ORSMErhNfDA1/XfZ2iAEGqK2j76hTA2udU/H8fLUp88ZC+sLY6ZJq
X-Received: by 2002:a5d:4cd2:0:b0:367:9801:9c67 with SMTP id
 ffacd0b85a97d-367cead15c3mr15919210f8f.48.1721054923010; 
 Mon, 15 Jul 2024 07:48:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvo1BL8O24IggWGu4Fjt3lZuBhXRP2ZXF0fOsIrWPscfm99RTZvhO2hWCDAZCq3gWRZTWsng==
X-Received: by 2002:a5d:4cd2:0:b0:367:9801:9c67 with SMTP id
 ffacd0b85a97d-367cead15c3mr15919178f8f.48.1721054922582; 
 Mon, 15 Jul 2024 07:48:42 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5e77488sm91062235e9.9.2024.07.15.07.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 07:48:42 -0700 (PDT)
Date: Mon, 15 Jul 2024 16:48:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Markus Armbruster
 <armbru@redhat.com>
Cc: <mst@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>,
 <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
 <marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Dave Jiang <dave.jiang@intel.com>, Huang
 Ying <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>, Ani Sinha
 <anisinha@redhat.com>
Subject: Re: [PATCH v5 10/13] hw/acpi: Generic Port Affinity Structure support
Message-ID: <20240715164841.1979fdea@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240712110837.1439736-11-Jonathan.Cameron@huawei.com>
References: <20240712110837.1439736-1-Jonathan.Cameron@huawei.com>
 <20240712110837.1439736-11-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
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

On Fri, 12 Jul 2024 12:08:14 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> These are very similar to the recently added Generic Initiators
> but instead of representing an initiator of memory traffic they
> represent an edge point beyond which may lie either targets or
> initiators.  Here we add these ports such that they may
> be targets of hmat_lb records to describe the latency and
> bandwidth from host side initiators to the port.  A discoverable
> mechanism such as UEFI CDAT read from CXL devices and switches
> is used to discover the remainder of the path, and the OS can build
> up full latency and bandwidth numbers as need for work and data
> placement decisions.
> 
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Tested-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

ACPI tables generation LGTM
As for the rest my review is perfunctory mostly.

> ---
> v5: Push the definition of TYPE_ACPI_GENERIC_PORT down into the
>     c file (similar to TYPE_ACPI_GENERIC_INITIATOR in earlier patch)
> ---
>  qapi/qom.json                       |  34 +++++++++
>  include/hw/acpi/aml-build.h         |   4 +
>  include/hw/acpi/pci.h               |   2 +-
>  include/hw/pci/pci_bridge.h         |   1 +
>  hw/acpi/aml-build.c                 |  40 ++++++++++
>  hw/acpi/pci.c                       | 112 +++++++++++++++++++++++++++-
>  hw/arm/virt-acpi-build.c            |   2 +-
>  hw/i386/acpi-build.c                |   2 +-
>  hw/pci-bridge/pci_expander_bridge.c |   1 -
>  9 files changed, 193 insertions(+), 5 deletions(-)
> 
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 8e75a419c3..b97c031b73 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -838,6 +838,38 @@
>    'data': { 'pci-dev': 'str',
>              'node': 'uint32' } }
>  
> +##
> +# @AcpiGenericPortProperties:
> +#
> +# Properties for acpi-generic-port objects.
> +#
> +# @pci-bus: QOM path of the PCI bus of the hostbridge associated with
> +#     this SRAT Generic Port Affinity Structure.  This is the same as
> +#     the bus parameter for the root ports attached to this host
> +#     bridge.  The resulting SRAT Generic Port Affinity Structure will
> +#     refer to the ACPI object in DSDT that represents the host bridge
> +#     (e.g.  ACPI0016 for CXL host bridges).  See ACPI 6.5 Section
> +#     5.2.16.7 for more information.
> +#

> +# @node: Similar to a NUMA node ID, but instead of providing a
> +#     reference point used for defining NUMA distances and access
> +#     characteristics to memory or from an initiator (e.g. CPU), this
> +#     node defines the boundary point between non-discoverable system
> +#     buses which must be described by firmware, and a discoverable
> +#     bus.  NUMA distances and access characteristics are defined to
> +#     and from that point.  For system software to establish full
> +#     initiator to target characteristics this information must be
> +#     combined with information retrieved from the discoverable part
> +#     of the path.  An example would use CDAT (see UEFI.org)
> +#     information read from devices and switches in conjunction with
> +#     link characteristics read from PCIe Configuration space.

you lost me here (even reading this several time doesn't help).
Perhaps I lack specific domain knowledge, but is there a way to make it
more comprehensible for layman?

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
> @@ -1031,6 +1063,7 @@
>  { 'enum': 'ObjectType',
>    'data': [
>      'acpi-generic-initiator',
> +    'acpi-generic-port',
>      'authz-list',
>      'authz-listfile',
>      'authz-pam',
> @@ -1106,6 +1139,7 @@
>    'discriminator': 'qom-type',
>    'data': {
>        'acpi-generic-initiator':     'AcpiGenericInitiatorProperties',
> +      'acpi-generic-port':          'AcpiGenericPortProperties',
>        'authz-list':                 'AuthZListProperties',
>        'authz-listfile':             'AuthZListFileProperties',
>        'authz-pam':                  'AuthZPAMProperties',
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index 33eef85791..9e30c735bb 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -490,6 +490,10 @@ void build_srat_pci_generic_initiator(GArray *table_data, int node,
>                                        uint16_t segment, uint8_t bus,
>                                        uint8_t devfn);
>  
> +void build_srat_acpi_generic_port(GArray *table_data, int node,
> +                                  const char *hid,
> +                                  uint32_t uid);
> +
>  void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms,
>                  const char *oem_id, const char *oem_table_id);
>  
> diff --git a/include/hw/acpi/pci.h b/include/hw/acpi/pci.h
> index 3015a8171c..6359d574fd 100644
> --- a/include/hw/acpi/pci.h
> +++ b/include/hw/acpi/pci.h
> @@ -41,6 +41,6 @@ Aml *aml_pci_device_dsm(void);
>  void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus);
>  void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope);
>  
> -void build_srat_generic_pci_initiator(GArray *table_data);
> +void build_srat_generic_affinity_structures(GArray *table_data);
>  
>  #endif
> diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
> index 5cd452115a..5456e24883 100644
> --- a/include/hw/pci/pci_bridge.h
> +++ b/include/hw/pci/pci_bridge.h
> @@ -102,6 +102,7 @@ typedef struct PXBPCIEDev {
>      PXBDev parent_obj;
>  } PXBPCIEDev;
>  
> +#define TYPE_PXB_CXL_BUS "pxb-cxl-bus"
>  #define TYPE_PXB_DEV "pxb"
>  OBJECT_DECLARE_SIMPLE_TYPE(PXBDev, PXB_DEV)
>  
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 968b654e58..4067100dd6 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1955,6 +1955,19 @@ static void build_append_srat_pci_device_handle(GArray *table_data,
>      build_append_int_noprefix(table_data, 0, 12);
>  }
>  
> +static void build_append_srat_acpi_device_handle(GArray *table_data,
> +                                                 const char *hid,
> +                                                 uint32_t uid)
> +{
> +    assert(strlen(hid) == 8);
> +    /* Device Handle - ACPI */
> +    for (int i = 0; i < sizeof(hid); i++) {
> +        build_append_int_noprefix(table_data, hid[i], 1);
> +    }
> +    build_append_int_noprefix(table_data, uid, 4);
> +    build_append_int_noprefix(table_data, 0, 4);
> +}
> +
>  /*
>   * ACPI spec, Revision 6.3
>   * 5.2.16.6 Generic Initiator Affinity Structure
> @@ -1982,6 +1995,33 @@ void build_srat_pci_generic_initiator(GArray *table_data, int node,
>      build_append_int_noprefix(table_data, 0, 4);
>  }
>  
> +/*
> + * ACPI spec, Revision 6.5
> + * 5.2.16.7 Generic Port Affinity Structure
> + *   With ACPI Device Handle.
> + */
> +void build_srat_acpi_generic_port(GArray *table_data, int node,

shouldn't node be uint32_t?

> +                                  const char *hid,
> +                                  uint32_t uid)
> +{
> +    /* Type */
> +    build_append_int_noprefix(table_data, 6, 1);
> +    /* Length */
> +    build_append_int_noprefix(table_data, 32, 1);
> +    /* Reserved */
> +    build_append_int_noprefix(table_data, 0, 1);
> +    /* Device Handle Type: ACPI */
> +    build_append_int_noprefix(table_data, 0, 1);
> +    /* Proximity Domain */
> +    build_append_int_noprefix(table_data, node, 4);
> +    /* Device Handle */
> +    build_append_srat_acpi_device_handle(table_data, hid, uid);
> +    /* Flags - GP Enabled */
> +    build_append_int_noprefix(table_data, 1, 4);
> +    /* Reserved */
> +    build_append_int_noprefix(table_data, 0, 4);
> +}
> +
>  /*
>   * ACPI spec 5.2.17 System Locality Distance Information Table
>   * (Revision 2.0 or later)
> diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
> index 3e1db161cc..020ad53c03 100644
> --- a/hw/acpi/pci.c
> +++ b/hw/acpi/pci.c
> @@ -30,6 +30,7 @@
>  #include "hw/boards.h"
>  #include "hw/acpi/aml-build.h"
>  #include "hw/acpi/pci.h"
> +#include "hw/pci/pci_bridge.h"
>  #include "hw/pci/pci_device.h"
>  #include "hw/pci/pcie_host.h"
>  
> @@ -177,9 +178,118 @@ static int build_acpi_generic_initiator(Object *obj, void *opaque)
>      return 0;
>  }
>  
> -void build_srat_generic_pci_initiator(GArray *table_data)
> +typedef struct AcpiGenericPort {
> +    /* private */
> +    Object parent;
> +
> +    /* public */
> +    char *pci_bus;
> +    uint16_t node;

ditto

> +} AcpiGenericPort;
> +
> +typedef struct AcpiGenericPortClass {
> +    ObjectClass parent_class;
> +} AcpiGenericPortClass;
> +
> +#define TYPE_ACPI_GENERIC_PORT "acpi-generic-port"
> +
> +OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericPort, acpi_generic_port,
> +                   ACPI_GENERIC_PORT, OBJECT,
> +                   { TYPE_USER_CREATABLE },
> +                   { NULL })
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericPort, ACPI_GENERIC_PORT)
> +
> +static void acpi_generic_port_init(Object *obj)
> +{
> +    AcpiGenericPort *gp = ACPI_GENERIC_PORT(obj);
> +
> +    gp->node = MAX_NODES;
> +    gp->pci_bus = NULL;
> +}
> +
> +static void acpi_generic_port_finalize(Object *obj)
> +{
> +    AcpiGenericPort *gp = ACPI_GENERIC_PORT(obj);
> +
> +    g_free(gp->pci_bus);
> +}
> +
> +static void acpi_generic_port_set_pci_bus(Object *obj, const char *val,
> +                                          Error **errp)
> +{
> +    AcpiGenericPort *gp = ACPI_GENERIC_PORT(obj);
> +
> +    gp->pci_bus = g_strdup(val);
> +}
> +
> +static void acpi_generic_port_set_node(Object *obj, Visitor *v,
> +                                       const char *name, void *opaque,
> +                                       Error **errp)
> +{
> +    AcpiGenericPort *gp = ACPI_GENERIC_PORT(obj);
> +    uint32_t value;
> +
> +    if (!visit_type_uint32(v, name, &value, errp)) {
> +        return;
> +    }
> +
> +    if (value >= MAX_NODES) {
> +        error_printf("%s: Invalid NUMA node specified\n",
> +                     TYPE_ACPI_GENERIC_INITIATOR);
> +        exit(1);
> +    }
> +
> +    gp->node = value;

as long as gp->node is uint32_t it should be fine.
otherwise it's too fragile. 

> +}
> +
> +static void acpi_generic_port_class_init(ObjectClass *oc, void *data)
> +{
> +    object_class_property_add_str(oc, "pci-bus", NULL,
> +        acpi_generic_port_set_pci_bus);
> +    object_class_property_add(oc, "node", "int", NULL,
> +        acpi_generic_port_set_node, NULL, NULL);

missing property description calls.

> +}
> +
> +static int build_acpi_generic_port(Object *obj, void *opaque)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    const char *hid = "ACPI0016";
> +    GArray *table_data = opaque;
> +    AcpiGenericPort *gp;
> +    uint32_t uid;
> +    Object *o;
> +
> +    if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_PORT)) {
> +        return 0;
> +    }
> +
> +    gp = ACPI_GENERIC_PORT(obj);
> +
> +    if (gp->node >= ms->numa_state->num_nodes) {

> +        error_printf("%s: node %d is invalid.\n",
> +                     TYPE_ACPI_GENERIC_PORT, gp->node);
> +        exit(1);

not sure, 
maybe use error_fatal instead of using exit(1)?

CCing Markus to check if it's ok.


> +    }
> +
> +    o = object_resolve_path_type(gp->pci_bus, TYPE_PXB_CXL_BUS, NULL);
> +    if (!o) {
> +        error_printf("%s: device must be a CXL host bridge.\n",
> +                     TYPE_ACPI_GENERIC_PORT);
> +       exit(1);
> +    }
ditto

> +
> +    uid = object_property_get_uint(o, "acpi_uid", &error_fatal);
> +    build_srat_acpi_generic_port(table_data, gp->node, hid, uid);
> +
> +    return 0;
> +}
> +
> +void build_srat_generic_affinity_structures(GArray *table_data)
>  {
>      object_child_foreach_recursive(object_get_root(),
>                                     build_acpi_generic_initiator,
>                                     table_data);
> +    object_child_foreach_recursive(object_get_root(), build_acpi_generic_port,
> +                                   table_data);
>  }
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index a50b00b7c1..d98651df55 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -510,7 +510,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          }
>      }
>  
> -    build_srat_generic_pci_initiator(table_data);
> +    build_srat_generic_affinity_structures(table_data);
>  
>      if (ms->nvdimms_state->is_enabled) {
>          nvdimm_build_srat(table_data);
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 2eaa4c9203..7f5ca188c1 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2048,7 +2048,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>          build_srat_memory(table_data, 0, 0, 0, MEM_AFFINITY_NOFLAGS);
>      }
>  
> -    build_srat_generic_pci_initiator(table_data);
> +    build_srat_generic_affinity_structures(table_data);
>  
>      /*
>       * Entry is required for Windows to enable memory hotplug in OS
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index b94cb85cfb..cd7f2d5423 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -38,7 +38,6 @@ DECLARE_INSTANCE_CHECKER(PXBBus, PXB_BUS,
>  DECLARE_INSTANCE_CHECKER(PXBBus, PXB_PCIE_BUS,
>                           TYPE_PXB_PCIE_BUS)
>  
> -#define TYPE_PXB_CXL_BUS "pxb-cxl-bus"
>  DECLARE_INSTANCE_CHECKER(PXBBus, PXB_CXL_BUS,
>                           TYPE_PXB_CXL_BUS)
>  


