Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E565AC3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 15:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRw2v-0005Jz-1j; Thu, 11 Jul 2024 11:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1sRw2u-0005Hz-8c
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 11:49:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1sRw2s-0003Ba-2Y
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 11:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720712961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yqGhKTCLzV102CtXJNgKbffh4EHa55AzQPOPjiU5ZHw=;
 b=cZsayCMWwaBP1nDhJM4MUywXqP0/3TeHtJ8x2lm3ZUOHX574SDVRK8n4xjEtiUr6KOfV/N
 d6r74zWpKxjP6CoJWpTkCV6qMwKXK7lEzmRGXR2Wcy6GrSBJsxGKOf3qveGH1Xyymr5YWj
 QUczugkcm7w3aEwz1lwQmqOO70NpXvc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-Icyq4SCMNT2j9uTjhJ7FaA-1; Thu, 11 Jul 2024 11:48:12 -0400
X-MC-Unique: Icyq4SCMNT2j9uTjhJ7FaA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-79f1a81bd7fso135772485a.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 08:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720712891; x=1721317691;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yqGhKTCLzV102CtXJNgKbffh4EHa55AzQPOPjiU5ZHw=;
 b=tY6HZsC55/TDMOJakoiRr7QulYUnlEmfuyGESp9zdqg5zjz9iXaeqBb2gc216OFO6s
 9hYIuDWUffij46QJQAy+JzEoTUlToQceK/+AHHZyohOKTGP+nHbYVdiWOZTiKP0JkceT
 c9jT3USr1kE3fzx8F7gl5WEawJLq/uHDHg/FiVhbqxIt7EDseu1bEdtdwCHu04VLWRVi
 UezIhPj3BDn/o6PD+8pmzXar6X47iPHihm7wHlZZDU0vq2MxMbeP7pnbm3agfV6RUBFI
 YYuEJhUx8QC+S9Wyfm+e6ks/EDaFq4zA2LujUr6Zt4X9EoHwsMRB7BrgUlLpgvRl4ath
 c0IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7MidfQe4l9NGppn3CFzaeKvTpJXz1FSPXNfL/+Qt05tPdGYmseP9NtB1PAO0RshIo7OsZzoN8KxIr8/9AmoPZAZnQf1E=
X-Gm-Message-State: AOJu0Yxq9tzdttkh68pJdQenBOWd/ZBuK6wdL5XlqzPR3jBc9rwjfjVy
 PEHmuLtq5FoQOMgE0TxAprExskH/S0PRMwfCg2tBq7gGPjrHHz23bvp9FMyfI3M/lZ/nr0alGg/
 cXHascrUJQ85exG+0nWF70u6pklkVhOhik2O5aFCRMJ9zcxP+C5B9m5/a112Z2qGbwyvLr/jOCR
 ANXQKFwdjtzhuDtx4No+L8RioghTc=
X-Received: by 2002:a05:622a:198a:b0:447:dbe8:5268 with SMTP id
 d75a77b69052e-447fa92d037mr102820761cf.37.1720712891588; 
 Thu, 11 Jul 2024 08:48:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsEdyjO/16TlIbUy92YdyBghaSgHEF5muY5uctLc8Y9IidV/x1oJyE+zLG9t/avNINc003eTB/1gZBicxEvog=
X-Received: by 2002:a05:622a:198a:b0:447:dbe8:5268 with SMTP id
 d75a77b69052e-447fa92d037mr102820481cf.37.1720712891239; Thu, 11 Jul 2024
 08:48:11 -0700 (PDT)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 11 Jul 2024 08:48:10 -0700
From: Andrea Bolognani <abologna@redhat.com>
References: <cover.1719361174.git.nicolinc@nvidia.com>
 <bc7a57311ac4976699789ceca329edfdfe823c2d.1719361174.git.nicolinc@nvidia.com>
 <9c3e95c2-1035-4a55-89a3-97165ef32f18@redhat.com>
 <Zo16gnKKxXFg4LLE@Asurada-Nvidia>
MIME-Version: 1.0
In-Reply-To: <Zo16gnKKxXFg4LLE@Asurada-Nvidia>
Date: Thu, 11 Jul 2024 08:48:10 -0700
Message-ID: <CABJz62PVt9h9776DjXkPYq_Mf+AUJ-0YhnDi-OsaqCqrsrGSQQ@mail.gmail.com>
Subject: Re: [PATCH RFCv1 05/10] hw/arm/virt: Add VIRT_NESTED_SMMU
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Eric Auger <eric.auger@redhat.com>, peter.maydell@linaro.org, 
 shannon.zhaosl@gmail.com, mst@redhat.com, imammedo@redhat.com, 
 anisinha@redhat.com, peterx@redhat.com, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, jgg@nvidia.com, shameerali.kolothum.thodi@huawei.com, 
 jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jul 09, 2024 at 10:59:30AM GMT, Nicolin Chen wrote:
> On Tue, Jul 09, 2024 at 03:26:58PM +0200, Eric Auger wrote:
> > > +    /* Build PCI Expander Bridge + Root Port from the top of PCI_BUS_MAX */
> > > +    if (vms->num_nested_smmus) {
> > > +        /* VIRT_NESTED_SMMU must hold all vSMMUs */
> > > +        g_assert(vms->num_nested_smmus <=
> > > +                 vms->memmap[VIRT_NESTED_SMMU].size / SMMU_IO_LEN);
> > > +
> > > +        vms->nested_smmu_phandle = g_new0(uint32_t, vms->num_nested_smmus);
> > > +
> > > +        for (i = 0; i < vms->num_nested_smmus; i++) {
> > > +            DeviceState *smmu_dev;
> > > +            PCIBus *pxb_bus;
> > > +
> > > +            pxb_bus = create_pcie_expander_bridge(vms, i);
> > > +            g_assert(pxb_bus);
> > > +
> > > +            vms->nested_smmu_phandle[i] = qemu_fdt_alloc_phandle(ms->fdt);
> > > +            smmu_dev = create_nested_smmu(vms, pxb_bus, i);
> > > +            g_assert(smmu_dev);
> > > +
> > > +            qemu_fdt_setprop_cells(ms->fdt, nodename, "iommu-map", 0x0,
> > > +                                   vms->nested_smmu_phandle[i], 0x0, 0x10000);
>
> > I think libvirt is supposed to create the pcie bus topology instead and
> > it shall not be created by qemu behind the scene.
> > The pcie elements you create here are not visible to libvirt and I guess
> > they may collide with elements explicitly created by libvirt at a given
> > pci bdf.
>
> Yea, the bdf conflict is a concern. So I allocated the bdf list
> from the top of the bus number... one of the reasons of doing
> this is to ease users so they don't need to deal with the over-
> complicated topology. I will try libvirt and see how it goes.

libvirt developer here. Eric is absolutely right that creating PCI
controllers implicitly will not fly, as libvirt's PCI address
allocation algorithm would not know about them and would produce
incorrect output as a result.

> > I think it would make more sense to be able to attach an smmu instance
> > to a given pci root or pxb either by adding an iommu id to a given
> > pxb-pcie option
> >
> > -device
> > pxb-pcie,bus_nr=100,id=pci.12,numa_node=0,bus=pcie.0,addr=0x3,iommu=<id>
> > or
> > adding a list of pxb ids to the iommu option. It is unfortunate the
> > iommu option is a machine option.
>
> Yes. I had thought about that too, but the virt-machine code
> creates all the instance at this moment...
>
> > platform bus framework could be considered to dynamically allocate them
> > using the -device option. This has been used along with dt generation
> > but with ACPI this would need to be studied. However at the time the
> > smmu was integrated the machine option was prefered.
> >
> > Maybe using the 1st option would allow to infer that if there are
> > different iommu ids this implies that several IOMMU instances need to be
> > created.
>
> Yea, I like the idea of creating iommu instance with a "-device"
> string.

This sounds like the best option to me as well. Incidentally, it's
also how the intel-iommu device works. From libvirt's test suite:

  -device '{"driver":"intel-iommu","id":"iommu0"}'

Looks like a sensible model to follow. You could then associate each
specific IOMMU instance to a PCI controller using an attribute, as
Eric suggested above.

> One more question. Let's say we have 2 smmus/pxb-buses:
>   [ pxb0] <---> vSMMU0/pSMMU0 [ devA, devB, devC ]
>   [ pxb1] <---> vSMMU1/pSMMU1 [ devD, devE, devF ]
> How would a user know that devA/devB should be attached to pxb0
> without doing like devA->pxb0 and devB->pxb1? Should QEMU just
> error out until the user associate them correctly? Or they may
> rely on libvirt to figure that out, i.e. moving the iommu node
> matching from QEMU to libvirt?

IIUC having devices associated to the "correct" SMMU is only a
requirement for optimal performance, not pure functionality, right?
In other words, getting the association wrong will make things slower
but they will keep working.

Is a 1:1 match between pSMMU and vSMMU mandatory? On a system with 4
SMMUs, could I create a VMs with

  vSMMU0 <-> pSMMU0
  vSMMU1 <-> pSMMU1

and another one with

  vSMMU0 <-> pSMMU2
  vSMMU1 <-> pSMMU3

assuming of course that devices are assigned to the correct VM?

How is the association between vSMMU and pSMMU created anyway? Is
that something that the user can control, or is it done automatically
somehow?

-- 
Andrea Bolognani / Red Hat / Virtualization


