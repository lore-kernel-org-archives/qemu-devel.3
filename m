Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC395C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 11:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNACX-0008Qn-L9; Fri, 28 Jun 2024 07:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sNACT-0008LM-EI
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 07:55:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sNACR-0001I8-MO
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 07:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719575730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MIdgxHEBhDpm1AmrQ07hyskJ/f/Dw+Jr6uTrIO5O4XI=;
 b=BsCmVsgS5j2obTyIqtgc05P7cg/cVyqJ5/UI3XwExRJ8LqepcLT9UtxgVE1Bbdds7l5h/H
 9xtEmoR+gi5x5O76xKnOIkVJ1IxN8Y1Zw2F0LfWCu6f9dF6gGso0VrcIwNv2a9sSiAWRSo
 T1CrOXOMs9BJXt+NtLqew1276LOQWBI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-mbP0IZMRNEiVVqlKJ1Kl7Q-1; Fri, 28 Jun 2024 07:55:28 -0400
X-MC-Unique: mbP0IZMRNEiVVqlKJ1Kl7Q-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52d58307b43so665816e87.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 04:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719575727; x=1720180527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MIdgxHEBhDpm1AmrQ07hyskJ/f/Dw+Jr6uTrIO5O4XI=;
 b=sEZKnLyddvmTzY73On1AXl4SdAgpDGIBjiNFFafRpA0+B88lHI03PX3Vj3qctqeyn0
 gvyS39wmnewYpYTpuf+EqA3gjXtChty4/qkntYKE5bU5Wu3xUvCZxPQy4z8O9hK/0fPR
 fTc/2o6TpYyMmNl/cMluaMm9k5qSw7BaS1Tek8Nw/kx/gA8j/FQi60zG++d7b4vOgzSn
 Jhvqvl2ySQq2LlaIx6hbQRQfxYyfOoFpKnA2N1h6EJ9XXL2Y4ECmyWXp5msr9H9Z0/ew
 29sWBWVRlrOCePAxcVjPef0oQubwLTM+l1pj0dI2gpB9sUjnzUd2jbkjHjTM1k7IxhUb
 tJ0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXabyZTwo+vlLHTzGzFXDDBmWe7xnDPciRoXJos2kXmFUb0JkOc8+Ozoc+NJ4YT2y+n9R4gqZV2CBiS8ICseAXK3DxlPPU=
X-Gm-Message-State: AOJu0Yw804GRp1mXOu0objut2lA+lj7a/k+o9hs73gKowHZ6OrEzglM1
 01y7HEETWANsYZIG6anr5IE8kDv6Pp6kNsFSgxKD3LngHdg5EexpmiZCpKB5Aqi4gHkKrHg0liY
 14p+84yVUiWZLwSmUsUbNr5uALI4H3IIve461kfA3YnTSNHTikCim
X-Received: by 2002:ac2:58c3:0:b0:52c:ec68:6165 with SMTP id
 2adb3069b0e04-52cec6861e8mr8380588e87.33.1719575727335; 
 Fri, 28 Jun 2024 04:55:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR4g586qIFOLmfhPhJ17znzEeUJZNpf05zPTnVrdOudzmojqCKmDvtnj2d7cZUyaUjvC6Rig==
X-Received: by 2002:ac2:58c3:0:b0:52c:ec68:6165 with SMTP id
 2adb3069b0e04-52cec6861e8mr8380561e87.33.1719575726892; 
 Fri, 28 Jun 2024 04:55:26 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0da004sm2094482f8f.45.2024.06.28.04.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 04:55:26 -0700 (PDT)
Date: Fri, 28 Jun 2024 13:55:25 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
 <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
 <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 07/11] hw/pci-bridge: Add acpi_uid property to CXL PXB
Message-ID: <20240628135525.0c131846@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240627144614.00004358@Huawei.com>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
 <20240620160324.109058-8-Jonathan.Cameron@huawei.com>
 <20240627152758.5eafb402@imammedo.users.ipa.redhat.com>
 <20240627144614.00004358@Huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
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

On Thu, 27 Jun 2024 14:46:14 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Thu, 27 Jun 2024 15:27:58 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Thu, 20 Jun 2024 17:03:15 +0100
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> >   
> > > This allows the ACPI SRAT Generic Port Affinity Structure
> > > creation to be independent of PCI internals. Note that
> > > the UID is currently the PCI bus number.
> > > 
> > > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > ---
> > > v3: New patch
> > > ---
> > >  hw/pci-bridge/pci_expander_bridge.c | 17 ++++++++++++++++-
> > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> > > index 0411ad31ea..92d39b917a 100644
> > > --- a/hw/pci-bridge/pci_expander_bridge.c
> > > +++ b/hw/pci-bridge/pci_expander_bridge.c
> > > @@ -93,6 +93,21 @@ static void pxb_bus_class_init(ObjectClass *class, void *data)
> > >      pbc->numa_node = pxb_bus_numa_node;
> > >  }
> > >  
> > > +static void prop_pxb_cxl_uid_get(Object *obj, Visitor *v, const char *name,
> > > +                             void *opaque, Error **errp)
> > > +{
> > > +    uint32_t uid = pci_bus_num(PCI_BUS(obj));
> > > +
> > > +    visit_type_uint32(v, name, &uid, errp);
> > > +}
> > > +
> > > +static void pxb_cxl_bus_class_init(ObjectClass *class, void *data)
> > > +{
> > > +    pxb_bus_class_init(class, data);
> > > +    object_class_property_add(class, "acpi_uid", "uint32",
> > > +                              prop_pxb_cxl_uid_get, NULL, NULL, NULL);
> > > +}
> > > +
> > >  static const TypeInfo pxb_bus_info = {
> > >      .name          = TYPE_PXB_BUS,
> > >      .parent        = TYPE_PCI_BUS,
> > > @@ -111,7 +126,7 @@ static const TypeInfo pxb_cxl_bus_info = {
> > >      .name          = TYPE_PXB_CXL_BUS,
> > >      .parent        = TYPE_CXL_BUS,
> > >      .instance_size = sizeof(PXBBus),
> > > -    .class_init    = pxb_bus_class_init,
> > > +    .class_init    = pxb_cxl_bus_class_init,    
> > 
> > why it's CXL only, doesn't the same UID rules apply to other PCI buses?  
> 
> In principle, yes.  My nervousness is that we can only test anything
> using this infrastructure today with CXL root bridges.
> 
> So I was thinking we should keep it limited and broaden the scope
> if anyone ever cares.  I don't mind broadening it from the start though.

Then I'd use it everywhere and cleanup ACPI code to use it as well
just to be consistent.
 
> Jonathan
> 
> 
> > >  };
> > >  
> > >  static const char *pxb_host_root_bus_path(PCIHostState *host_bridge,    
> > 
> >   
> 


