Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58B9C5B549
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 09:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKwNg-0005oG-B4; Fri, 30 May 2025 05:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uKwNe-0005nf-CC; Fri, 30 May 2025 05:50:26 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uKwNb-0007HR-4q; Fri, 30 May 2025 05:50:26 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b7yZw2pKmz6GFDR;
 Fri, 30 May 2025 17:28:08 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id B2A0A140516;
 Fri, 30 May 2025 17:28:13 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 May
 2025 11:28:13 +0200
Date: Fri, 30 May 2025 10:28:11 +0100
To: Eric Auger <eric.auger@redhat.com>
CC: <eric.auger.pro@gmail.com>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>, <peter.maydell@linaro.org>, <imammedo@redhat.com>,
 <gustavo.romero@linaro.org>, <anisinha@redhat.com>, <mst@redhat.com>,
 <shannon.zhaosl@gmail.com>, <pbonzini@redhat.com>, <philmd@linaro.org>,
 <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 04/25] hw/pci-host/gpex-acpi: Add native_pci_hotplug
 arg to acpi_dsdt_add_pci_osc
Message-ID: <20250530102811.0000648d@huawei.com>
In-Reply-To: <20250530102711.000034eb@huawei.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-5-eric.auger@redhat.com>
 <20250530102711.000034eb@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 30 May 2025 10:27:11 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Tue, 27 May 2025 09:40:06 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
> 
> > Add a new argument to acpi_dsdt_add_pci_osc to be able to disable
> > native pci hotplug.
> > 
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>  
> 
> Hi Eric,
> 
> Makes me wonder what we should do for CXL - I was expecting
> a very similar change.  Currently seems like those always
> allow native hotplug (__build_cxl_osc_method()) on x86 and
> arm64 (patches on list).
> 
> Maybe that has only been working because the kernel is reading
> the PCI _OSC first. Or it's always been doing native hotplug
> an no one noticed.  A quick look at logs shows the kernel
> first gets told no, then yes as it queries the two different
> _OSC types. 
> 
> Looks like I should fix that _OSC then it should be carried
> over to this as well (or if you don't mind adding a trivial
> patch to replicate this  patch for the CXL _OSC, even better!)
> 
> Other than that, this patch looks fine to me though I do wonder
> if we could unify this with build_q35_osc_method()?
> I'm not the best at reading AML generation code but whilst
> they are written quite differently they seem to be functionally
> very similar, more so after this patch.
> 
I should have read on... Sorry for the noise!

J
> > 
> > ---
> > 
> > rfc -> v1:
> > - updated the "Allow OS control for all 5 features" comment
> > ---
> >  hw/pci-host/gpex-acpi.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
> > index 0aba47c71c..f34b7cf25e 100644
> > --- a/hw/pci-host/gpex-acpi.c
> > +++ b/hw/pci-host/gpex-acpi.c
> > @@ -50,7 +50,7 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq,
> >      }
> >  }
> >  
> > -static void acpi_dsdt_add_pci_osc(Aml *dev)
> > +static void acpi_dsdt_add_pci_osc(Aml *dev, bool enable_native_pcie_hotplug)
> >  {
> >      Aml *method, *UUID, *ifctx, *ifctx1, *elsectx, *buf;
> >  
> > @@ -77,11 +77,12 @@ static void acpi_dsdt_add_pci_osc(Aml *dev)
> >      aml_append(ifctx, aml_store(aml_name("CDW3"), aml_name("CTRL")));
> >  
> >      /*
> > -     * Allow OS control for all 5 features:
> > -     * PCIeHotplug SHPCHotplug PME AER PCIeCapability.
> > +     * Allow OS control for SHPCHotplug, PME, AER, PCIeCapability,
> > +     * and PCIeHotplug depending on enable_native_pcie_hotplug
> >       */
> > -    aml_append(ifctx, aml_and(aml_name("CTRL"), aml_int(0x1F),
> > -                              aml_name("CTRL")));
> > +    aml_append(ifctx, aml_and(aml_name("CTRL"),
> > +               aml_int(0x1E | (enable_native_pcie_hotplug ? 0x1 : 0x0)),
> > +               aml_name("CTRL")));
> >  
> >      ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(0x1))));
> >      aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x08),
> > @@ -192,7 +193,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
> >              if (is_cxl) {
> >                  build_cxl_osc_method(dev);  
> 
> This was the path I was expecting to change as well.
> 
> >              } else {
> > -                acpi_dsdt_add_pci_osc(dev);
> > +                acpi_dsdt_add_pci_osc(dev, true);
> >              }
> >  
> >              aml_append(scope, dev);
> > @@ -267,7 +268,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
> >      }
> >      aml_append(dev, aml_name_decl("_CRS", rbuf));
> >  
> > -    acpi_dsdt_add_pci_osc(dev);
> > +    acpi_dsdt_add_pci_osc(dev, true);
> >  
> >      Aml *dev_res0 = aml_device("%s", "RES0");
> >      aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));  
> 


