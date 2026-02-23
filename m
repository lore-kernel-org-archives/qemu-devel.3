Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF5EEA4FB0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 11:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuU1Z-0005Sl-Ah; Mon, 23 Feb 2026 06:22:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vuU1X-0005Qu-5E
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 06:22:47 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vuU1R-0000HP-KX
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 06:22:45 -0500
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fKJN90WhFzHnH6X;
 Mon, 23 Feb 2026 19:22:01 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id E314940565;
 Mon, 23 Feb 2026 19:22:38 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Feb
 2026 11:22:38 +0000
Date: Mon, 23 Feb 2026 11:22:36 +0000
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <ankita@nvidia.com>, <vsethi@nvidia.com>, <jgg@nvidia.com>,
 <skolothumtho@nvidia.com>, <alex@shazbot.org>, <imammedo@redhat.com>,
 <anisinha@redhat.com>, <aniketa@nvidia.com>, <cjia@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <zhiw@nvidia.com>,
 <mochs@nvidia.com>, <kjaju@nvidia.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 1/1] hw/acpi/pci.c: preserve generic initiator
 insertion order
Message-ID: <20260223112236.000065aa@huawei.com>
In-Reply-To: <20260222091700-mutt-send-email-mst@kernel.org>
References: <20260222113526.6291-1-ankita@nvidia.com>
 <20260222091700-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, 22 Feb 2026 09:17:25 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Sun, Feb 22, 2026 at 11:35:26AM +0000, ankita@nvidia.com wrote:
> > From: Ankit Agrawal <ankita@nvidia.com>

Side note, I didn't receive the original email and nor did lore.kernel.org.

Thankfully Michael's reply reached the list just fine.


> > 
> > During creation of the VM's SRAT table, the generic initiator entries
> > are added. Currently the order in the entries are not controllable from
> > the qemu command. This is due to the fact that the code queries the
> > object tree which may not be in the order objects were inserted.  
> 
> why is this a problem?
> 
> > As a fix the patch maintains a GPtrArray of generic initiator objects
> > that preserves their insertion order. Objects are automatically added
> > to the array when initialized and removed when finalized. When building
> > the SRAT table, objects are processed in the order they were first
> > inserted.
> > 
> > E.g. for the following qemu command.
> > ...
> >             -object acpi-generic-initiator,id=gi0,pci-dev=dev0,node=2 \
> >             -object acpi-generic-initiator,id=gi1,pci-dev=dev0,node=3 \
> >             -object acpi-generic-initiator,id=gi2,pci-dev=dev0,node=4 \
> >             -object acpi-generic-initiator,id=gi3,pci-dev=dev0,node=5 \
> >             -object acpi-generic-initiator,id=gi4,pci-dev=dev0,node=6 \
> >             -object acpi-generic-initiator,id=gi5,pci-dev=dev0,node=7 \
> >             -object acpi-generic-initiator,id=gi6,pci-dev=dev0,node=8 \
> >             -object acpi-generic-initiator,id=gi7,pci-dev=dev0,node=9 \
> > ...

Ah. I'd forgotten you had this use case where you spin lots of nodes against
a single device (did you ever get the ACPI spec clarified to cover this case?)

The ordering of the SRAT entries shouldn't matter though we may run into
CI bios tables test problems if it ever gets accidentally changed. We've
had to switch ordering approaches before to avoid that sort of instability
wrt to unrelated changes.  If we did that we might not want it to have
anything to do with the command line (or at least make that the last level
of sorting after node, id and pci-dev)

Do we see differences in HMAT and SLIT as a result of this patch?

Jonathan


> > 
> > Original PXM in the VM SRAT table:
> > [1A4h 0420 004h]            Proximity Domain : 00000007
> > [1C4h 0452 004h]            Proximity Domain : 00000006
> > [1E4h 0484 004h]            Proximity Domain : 00000005
> > [204h 0516 004h]            Proximity Domain : 00000004
> > [224h 0548 004h]            Proximity Domain : 00000003
> > [244h 0580 004h]            Proximity Domain : 00000009
> > [264h 0612 004h]            Proximity Domain : 00000002
> > [284h 0644 004h]            Proximity Domain : 00000008
> > [2A2h 0674 004h]            Proximity Domain : 00000009
> > 
> > After the patch (preserves insertion order):
> > [1A4h 0420 004h]            Proximity Domain : 00000002
> > [1C4h 0452 004h]            Proximity Domain : 00000003
> > [1E4h 0484 004h]            Proximity Domain : 00000004
> > [204h 0516 004h]            Proximity Domain : 00000005
> > [224h 0548 004h]            Proximity Domain : 00000006
> > [244h 0580 004h]            Proximity Domain : 00000007
> > [264h 0612 004h]            Proximity Domain : 00000008
> > [284h 0644 004h]            Proximity Domain : 00000009
> > 
> > cc: Shameer Kolothum <skolothumtho@nvidia.com>
> > Fixes: 0a5b5acdf2 ("hw/acpi: Implement the SRAT GI affinity structure")
> > Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> > ---  
> 
> changelog since v1?
> 
> >  hw/acpi/pci.c | 49 +++++++++++++++++++++++++++++++++++++------------
> >  1 file changed, 37 insertions(+), 12 deletions(-)
> > 
> > diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
> > index 8c7ed10479..61d9a836c5 100644
> > --- a/hw/acpi/pci.c
> > +++ b/hw/acpi/pci.c
> > @@ -88,18 +88,35 @@ OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericInitiator, acpi_generic_initiator,
> >  
> >  OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericInitiator, ACPI_GENERIC_INITIATOR)
> >  
> > +static GPtrArray *acpi_generic_initiator_list;
> > +
> >  static void acpi_generic_initiator_init(Object *obj)
> >  {
> >      AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
> >  
> >      gi->node = MAX_NODES;
> >      gi->pci_dev = NULL;
> > +
> > +    /* Initialize array on first use */
> > +    if (!acpi_generic_initiator_list) {
> > +        acpi_generic_initiator_list = g_ptr_array_new();
> > +    }
> > +
> > +    g_ptr_array_add(acpi_generic_initiator_list, gi);
> >  }
> >  
> >  static void acpi_generic_initiator_finalize(Object *obj)
> >  {
> >      AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
> >  
> > +    if (acpi_generic_initiator_list) {
> > +        g_ptr_array_remove(acpi_generic_initiator_list, gi);
> > +
> > +        if (acpi_generic_initiator_list->len == 0) {
> > +            g_ptr_array_free(acpi_generic_initiator_list, true);
> > +            acpi_generic_initiator_list = NULL;
> > +        }
> > +    }
> >      g_free(gi->pci_dev);
> >  }
> >  
> > @@ -145,20 +162,15 @@ static void acpi_generic_initiator_class_init(ObjectClass *oc, const void *data)
> >          "NUMA node associated with the PCI device");
> >  }
> >  
> > -static int build_acpi_generic_initiator(Object *obj, void *opaque)
> > +
> > +static void build_acpi_generic_initiator(AcpiGenericInitiator *gi,
> > +                                         GArray *table_data)
> >  {
> >      MachineState *ms = MACHINE(qdev_get_machine());
> > -    AcpiGenericInitiator *gi;
> > -    GArray *table_data = opaque;
> >      int32_t devfn;
> >      uint8_t bus;
> >      Object *o;
> >  
> > -    if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
> > -        return 0;
> > -    }
> > -
> > -    gi = ACPI_GENERIC_INITIATOR(obj);
> >      if (gi->node >= ms->numa_state->num_nodes) {
> >          error_printf("%s: Specified node %d is invalid.\n",
> >                       TYPE_ACPI_GENERIC_INITIATOR, gi->node);
> > @@ -178,8 +190,22 @@ static int build_acpi_generic_initiator(Object *obj, void *opaque)
> >      assert(devfn >= 0 && devfn < PCI_DEVFN_MAX);
> >  
> >      build_srat_pci_generic_initiator(table_data, gi->node, 0, bus, devfn);
> > +}
> >  
> > -    return 0;
> > +static void build_all_acpi_generic_initiators(GArray *table_data)
> > +{
> > +    AcpiGenericInitiator *gi;
> > +    guint i;
> > +
> > +    if (!acpi_generic_initiator_list) {
> > +        return;
> > +    }
> > +
> > +    /* Iterate array in insertion order */
> > +    for (i = 0; i < acpi_generic_initiator_list->len; i++) {
> > +        gi = g_ptr_array_index(acpi_generic_initiator_list, i);
> > +        build_acpi_generic_initiator(gi, table_data);
> > +    }
> >  }
> >  
> >  typedef struct AcpiGenericPort {
> > @@ -295,9 +321,8 @@ static int build_acpi_generic_port(Object *obj, void *opaque)
> >  
> >  void build_srat_generic_affinity_structures(GArray *table_data)
> >  {
> > -    object_child_foreach_recursive(object_get_root(),
> > -                                   build_acpi_generic_initiator,
> > -                                   table_data);
> > +    build_all_acpi_generic_initiators(table_data);
> > +
> >      object_child_foreach_recursive(object_get_root(), build_acpi_generic_port,
> >                                     table_data);
> >  }
> > -- 
> > 2.34.1  
> 
> 


