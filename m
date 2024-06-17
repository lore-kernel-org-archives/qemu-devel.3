Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1C4C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 12:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJB7D-0001lL-GD; Mon, 17 Jun 2024 08:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sJB7A-0001jS-Sc
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 08:05:36 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sJB76-0002M4-UB
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 08:05:36 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W2pSh43zjz6K9FT;
 Mon, 17 Jun 2024 20:03:48 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 5FD51140A1B;
 Mon, 17 Jun 2024 20:05:17 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 17 Jun
 2024 13:05:16 +0100
Date: Mon, 17 Jun 2024 13:05:15 +0100
To: Igor Mammedov <imammedo@redhat.com>
CC: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <philmd@linaro.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, Dave Jiang <dave.jiang@intel.com>, 
 Huang Ying <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH qemu ] hw/acpi: Fix big endian host creation of Generic
 Port Affinity Structures
Message-ID: <20240617130515.000020fb@Huawei.com>
In-Reply-To: <20240614150835.00000674@Huawei.com>
References: <20240605180455.18193-1-Jonathan.Cameron@huawei.com>
 <20240606160653.27226def@imammedo.users.ipa.redhat.com>
 <20240606184716.00000708@Huawei.com>
 <20240614125725.730f8914@imammedo-mac>
 <20240614150835.00000674@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.174.77]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
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

On Fri, 14 Jun 2024 15:08:35 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Fri, 14 Jun 2024 12:57:25 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Thu, 6 Jun 2024 18:47:16 +0100
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> >   
> > > On Thu, 6 Jun 2024 16:06:53 +0200
> > > Igor Mammedov <imammedo@redhat.com> wrote:
> > >     
> > > > On Wed, 5 Jun 2024 19:04:55 +0100
> > > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > > >     
> > > > > Treating the HID as an integer caused it to get bit reversed
> > > > > on big endian hosts running little endian guests.  Treat it
> > > > > as a character array instead.
> > > > > 
> > > > > Fixes hw/acpi: Generic Port Affinity Structure Support
> > > > > Tested-by: Richard Henderson <richard.henderson@linaro.org>
> > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > 
> > > > > ---
> > > > > Richard ran the version posted in the thread on an s390 instance.
> > > > > Thanks for the help!
> > > > > 
> > > > > Difference from version in thread:
> > > > > - Instantiate i in the for loop.
> > > > > 
> > > > > Sending out now so Michael can decide whether to fold this in, or
> > > > > drop the GP series for now from his pull request (in which case
> > > > > I'll do an updated version with this and Markus' docs feedback
> > > > > folded in.)
> > > > > 
> > > > > ---
> > > > >  include/hw/acpi/acpi_generic_initiator.h | 2 +-
> > > > >  hw/acpi/acpi_generic_initiator.c         | 4 +++-
> > > > >  2 files changed, 4 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/acpi_generic_initiator.h
> > > > > index 1a899af30f..5baefda33a 100644
> > > > > --- a/include/hw/acpi/acpi_generic_initiator.h
> > > > > +++ b/include/hw/acpi/acpi_generic_initiator.h
> > > > > @@ -61,7 +61,7 @@ typedef struct PCIDeviceHandle {
> > > > >              uint16_t bdf;
> > > > >          };
> > > > >          struct {
> > > > > -            uint64_t hid;
> > > > > +            char hid[8];
> > > > >              uint32_t uid;
> > > > >          };
> > > > >      };      
> > > > 
> > > > not sure on top of what this patch applies but I have some generic comments wrt it    
> > > 
> > > https://lore.kernel.org/qemu-devel/20240524100507.32106-1-Jonathan.Cameron@huawei.com/
> > > 
> > > Comments are all on elements of the existing upstream code, but I'm touching it
> > > anyway so will look at making the improvements you suggest as new precursors
> > > to v3 given we are going around again anyway.
> > >     
> > > > 
> > > > why PCIDeviceHandle is in header file? is there plan for it
> > > > being used outside of acpi_generic_initiator.c?    
> > > 
> > > I'll add a precursor patch to my series that moves
> > > it and anything else that should be more local.  May well move
> > > to being local in aml_build.c given your later comments with the
> > > various fields passed in as parameters.
> > >     
> > > > 
> > > >     
> > > > > diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
> > > > > index 78b80dcf08..f064753b67 100644
> > > > > --- a/hw/acpi/acpi_generic_initiator.c
> > > > > +++ b/hw/acpi/acpi_generic_initiator.c
> > > > > @@ -151,7 +151,9 @@ build_srat_generic_node_affinity(GArray *table_data, int node,
> > > > >          build_append_int_noprefix(table_data, 0, 12);
> > > > >      } else {
> > > > >          /* Device Handle - ACPI */
> > > > > -        build_append_int_noprefix(table_data, handle->hid, 8);
> > > > > +        for (int i = 0; i < sizeof(handle->hid); i++) {
> > > > > +            build_append_int_noprefix(table_data, handle->hid[i], 1);
> > > > > +        }
> > > > >          build_append_int_noprefix(table_data, handle->uid, 4);
> > > > >          build_append_int_noprefix(table_data, 0, 4);      
> > > > 
> > > > instead of open codding structure
> > > > 
> > > > it might be better to introduce helper in aml_build.c
> > > > something like 
> > > >   /* proper reference to spec as we do for other ACPI primitives */
> > > >   build_append_srat_acpi_device_handle(GArray *table_data, char* hid, unit32_t uid)
> > > >       assert(strlen(hid) ...
> > > >       for() {
> > > >             build_append_byte()
> > > >       }          
> > > >       ...
> > > > 
> > > > the same applies to "Device Handle - PCI" structure    
> > > 
> > > I'll look at moving that stuff and the affinity structure creation
> > > code themselves in there. I think they ended up in this file because
> > > of the other infrastructure needed to create these nodes and it
> > > will have felt natural to keep this together.
> > > 
> > > Putting it in aml_build.c will put it with similar code though
> > > which makes sense to me.    
> > 
> > the point of moving handle packing to aml-build.c,
> > is to isolate primitives that likely could be reused later on elsewhere
> > and hide little endiannes from API user.
> > So shuch errors as you are fixing wouldn't be easy to introduce
> > (as long as API does it right)
> > 
> > 
> > Also this API probably should take not packed BDF, i.e. something like this:
> >     build_append_srat_pci_device_handle(GArray *table_data, bus, dev, func)
> > 
> > Or a packed BDF as you suggest in the later email, but then API function wold have
> > to 'decode' that before putting numbers into table, which complicates things
> > and likely would pull in PCI deps to unpack BDF, which I'd rather avoid in
> > generic aml-build.c  
> 
> Ok. I can split it up. My motivation for the encoded version was that
> the spec field is defined as a 2 byte field, but it is also broken out
> in the description into byte 2 then various bits of byte 3 so we can construct
> it that way instead. (were it defined as bits in the 16 bit field this would
> make less sense).  Should still be obvious enough to anyone trying to
> correlate the two.
> 
> Splitting the devfn bit up though is tricky as that doesn't really
> have a separate meaning in PCI any more given ARI where it becomes an 8 bit
> function ID. So probably makes more sense to keep that as devfn as it's
> coming from pci->devfn in that form anyway and they both forms get encoded
> into a byte anyway.

I guess it was inevitable (and perhaps you had this thought).  QEMU ordering
of BDF has the bytes swapped wrt to the ACPI ordering.  With them split the
test was failing.  I'll also tweak the test to ensure we have a non 0 bus
number (by inserting a root port rather than having the generic initiator
on the root bridge bus 0).

Ankit.  Can you confirm if you were seeing these reversed?

https://elixir.bootlin.com/qemu/v9.0.1/source/hw/acpi/acpi_generic_initiator.c#L134
uses PCI_BUIILD_BDF() which has bus << 8
The ACPI write is little endian, so bus ends up in byte 3 but should be in byte 2.

Jonathan

> 
> Jonathan
> 
> 
> >   
> > >     
> > > > 
> > > > Also get rid of PCI deps in acpi_generic_initiator.c 
> > > > move build_all_acpi_generic_initiators/build_srat_generic_pci_initiator into
> > > > hw/acpi/pci.c    
> > > 
> > > Today it's used only for PCI devices, but that's partly an artifact
> > > of how we get to the root complex via the bus below it.
> > > 
> > > Spec wise, it's just as applicable to platform devices etc, but maybe
> > > we can move it to pci.c for now and move it out again if it gains other
> > > users. Or leave it in acpi_generic_initiator.c but have all the aml
> > > stuff in aml_build.c as you suggest. 
> > >     
> > > > file if it has to access PCI code/structures directly
> > > > (which I'm not convinced it should, can we get/expose what it needs as QOM properties?)    
> > > 
> > > Maybe. I'll see what I can come up with.  This feels involved
> > > however so I'm more doubtful about this as a precursor.
> > >     
> > > > 
> > > > btw:
> > > > build_all_acpi_generic_initiators() name doesn't match what it's doing.
> > > > it composes only one initiator entry.    
> > > 
> > > I'll look at tidying up all the relevant naming.
> > > 
> > > Jonathan
> > >     
> > > >     
> > > > >      }      
> > > > 
> > > >     
> > >     
> > 
> >   
> 
> 


