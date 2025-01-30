Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77055C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 17:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdXuq-0003M5-Gv; Thu, 30 Jan 2025 12:01:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tdXup-0003I1-2i
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 12:01:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tdXun-0000lW-9C
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 12:01:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738256474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RgTkTXyoi13BvXnoAdM1hu4sQtRe5MUoJ/HaZZj3QnE=;
 b=hNylrrlz68Wfp21wLXKLXSlbjGC0egV34Xqp7CofBrr0lLVJ6NEFAALMTozuxaxwW+fUw8
 Go5ELMxKezU2dh/9BorFg+Nqv1voKHIm9aolLxeC2CfEIJH2nGqWP5ScovgG0GNt3ei4zl
 q1kIynU5lV5+NwtH/1xtTICBUGfyrN4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-XUBOUvEZOoOe74vlXLUWvw-1; Thu, 30 Jan 2025 12:01:10 -0500
X-MC-Unique: XUBOUvEZOoOe74vlXLUWvw-1
X-Mimecast-MFC-AGG-ID: XUBOUvEZOoOe74vlXLUWvw
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6d92f0737beso16066496d6.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 09:01:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738256469; x=1738861269;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RgTkTXyoi13BvXnoAdM1hu4sQtRe5MUoJ/HaZZj3QnE=;
 b=tYnuiI1sRxtDlwjmF3BW8ZMuUzG5UqrpPVculugJRYcFFXgOvXecMa7FGuZmioEKm2
 nuTm+n7zEubZ27XClV+uurVTm18dwGIXkbWELyfhcNykYZagpvjofFBIjBu9JDlsFVlB
 WCnKUY69Xch7BPva4Jnv4/DAF/MPPMWIq5GBVhYFB/EB/JUc06l09WoP+vCv54n9VmkH
 g4562g4iwn7QkegiPdbGAo/vyi8rIiiDGf+sh9KMx4wh14zD/SfYEOJCQPYjB6J86boH
 XUnAG4j1i8D2/v+Phe6p3UfrxmpTKtJK/3cTN6Ycbck1Sy+dWVF0BsSntQuHwS24YVTL
 xJGw==
X-Gm-Message-State: AOJu0Yy4gLY/kTXw8YUN9IkWii2p7tZ25iTVqrGRIKxogwxYDjfbbIB7
 ++4Q9YSblSPFdlhz/qk9gY647ggHOJUQTBub4zWCZTLz06hyjkQhKDBx7wI7WwsMjf4hZoMrnji
 ZfhEPnJDdFcmEoEm6l+VpiwvOsFYb/nEh3PgZZUwYVVgCfTdvHsO4
X-Gm-Gg: ASbGncsrifiFECKNHbYR0+tnUO5drYtApMT8oeYmi211/oIFxQg1h0EkZu7/o+73V2R
 AajrUR33dDdo4XJD3tBNpkqA0Bsb8V9WDrP1wWZX85a4OltEl674XcP3GYLHxffA9LhB+i8ZcOc
 xYsp26z99j07LgIQcLFS4J1dVggegXB8J54Y0q6J7tKaQlMlnhgCyAgAJRD78i8TZoqXB3OGv/h
 Nghmet+EcU9IkmzTLkJ4UKKgnIU7vMOYJBXonADB5SMBzF4nekmLcthaN+OsNRN6N6iIYRX/hpD
 r5QfTY53P6h7InZqtWTT+1lIFfQcSyCDebfzTjbjecwUiDXc
X-Received: by 2002:ad4:4ee5:0:b0:6d1:9f29:2e3b with SMTP id
 6a1803df08f44-6e243c1c95bmr134944386d6.13.1738256467361; 
 Thu, 30 Jan 2025 09:01:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrLtblk1LblnI8m1mHmQLc23guZ8tK54bJ4yOeJOcp/08M/oGXOiJ2xV53Dcl3CANOCLrVLA==
X-Received: by 2002:ad4:4ee5:0:b0:6d1:9f29:2e3b with SMTP id
 6a1803df08f44-6e243c1c95bmr134943386d6.13.1738256466617; 
 Thu, 30 Jan 2025 09:01:06 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2547f40a7sm7988246d6.3.2025.01.30.09.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 09:01:06 -0800 (PST)
Date: Thu, 30 Jan 2025 12:01:04 -0500
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] migration: ram block cpr blockers
Message-ID: <Z5uwUNtYhQfJJlg3@x1.local>
References: <1737135971-132839-1-git-send-email-steven.sistare@oracle.com>
 <Z4qelNxnBcgO87go@x1n>
 <814d9205-8ba5-48a8-9940-6f16bbb097eb@oracle.com>
 <Z4ruhpH28-GnnTq7@x1n>
 <20674b54-3c88-4d2c-a590-3b0ddaff86f9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20674b54-3c88-4d2c-a590-3b0ddaff86f9@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Jan 29, 2025 at 01:20:13PM -0500, Steven Sistare wrote:
> On 1/17/2025 6:57 PM, Peter Xu wrote:
> > On Fri, Jan 17, 2025 at 02:10:14PM -0500, Steven Sistare wrote:
> > > On 1/17/2025 1:16 PM, Peter Xu wrote:
> > > > On Fri, Jan 17, 2025 at 09:46:11AM -0800, Steve Sistare wrote:
> > > > > +/*
> > > > > + * Return true if ram contents would be lost during CPR.
> > > > > + * Return false for ram_device because it is remapped in new QEMU.  Do not
> > > > > + * exclude rom, even though it is readonly, because the rom file could change
> > > > > + * in new QEMU.  Return false for non-migratable blocks.  They are either
> > > > > + * re-created in new QEMU, or are handled specially, or are covered by a
> > > > > + * device-level CPR blocker.  Return false for an fd, because it is visible and
> > > > > + * can be remapped in new QEMU.
> > > > > + */
> > > > > +static bool ram_is_volatile(RAMBlock *rb)
> > > > > +{
> > > > > +    MemoryRegion *mr = rb->mr;
> > > > > +
> > > > > +    return mr &&
> > > > > +        memory_region_is_ram(mr) &&
> > > > > +        !memory_region_is_ram_device(mr) &&
> > > > > +        (!qemu_ram_is_shared(rb) || !qemu_ram_is_named_file(rb)) &&
> > > > > +        qemu_ram_is_migratable(rb) &&
> > > > > +        rb->fd < 0;
> > > > > +}
> > > > 
> > > > Blocking guest_memfd looks ok, but comparing to add one more block
> > > > notifier, can we check all ramblocks once in migrate_prepare(), and fail
> > > > that command directly if it fails the check?
> > > 
> > > In an upcoming patch, I will be adding an option analogous to only-migratable which
> > > prevents QEMU from starting if anything would block cpr-transfer.  That option
> > > will be checked when blockers are added, like for only-migratable. migrate_prepare
> > > is too late.
> > > 
> > > > OTOH, is there any simpler way to simplify the check conditions?  It'll be
> > > > at least nice to break these checks into smaller if conditions for
> > > > readability..
> > > 
> > > I thought the function header comments made it clear, but I could move each
> > > comment next to each condition:
> > > 
> > >      ...
> > >      /*
> > >       * Return false for an fd, because it is visible and can be remapped in
> > >       * new QEMU.
> > >       */
> > >      if (rb->fd >= 0) {
> > >          return false;
> > >      }
> > >      ...
> > > 
> > > > I wonder if we could stick with looping over all ramblocks, then make sure
> > > > each of them is on the cpr saved fd list.  It may need to make
> > > > cpr_save_fd() always register with the name of ramblock to do such lookup,
> > > > or maybe we could also cache the ramblock pointer in CprFd, then the lookup
> > > > will be a pointer match check.
> > > 
> > > Some ramblocks are not on the list, such as named files.  Plus looping in
> > > migrate_prepare is too late as noted above.
> > > 
> > > IMO what I have already implemented using blockers is clean and elegant.
> > 
> > OK if we need to fail it early at boot, then yes blockers are probably
> > better.
> > 
> > We'll need one more cmdline parameter. I've no objection, but I don't know
> > how to judge when it's ok to add, when it's better not.. I'll leave others
> > to comment on this.
> > 
> > But still, could we check it when ramblocks are created?  So in that way
> > whatever is forbidden is clear in its own path, I feel like that could be
> > clearer (like what you did with gmemfd).
> 
> When the ramblock is created, we don't yet know if it is migratable. A
> ramblock that is not migratable does not block cpr. Migratable is not known
> until vmstate_register_ram calls qemu_ram_set_migratable.  Hence that is
> where I evaluate conditions and install a blocker.
> 
> Because that is the only place where ram_block_add_cpr_blocker is called,
> the test qemu_ram_is_migratable() inside ram_block_add_cpr_blocker is
> redundant, and I should delete it.

Hmm.. sounds reasonable.

> 
> > For example, if I start to convert some of your requirements above, then
> > memory_region_is_ram_device() implies RAM_PREALLOC.  Actually, ram_device
> > is not the only RAM_PREALLOC user..  Say, would it also not work with all
> > memory_region_init_ram_ptr() users (even if they're not ram_device)?  An
> > example is, looks like virtio-gpu can create random ramblocks on the fly
> > with prealloced buffers.  I am not sure whether they can be pinned by VFIO
> > too.  You may know better.
> 
> That memory is not visible to the guest.  It is not part of system_memory,
> and is not marked migratable.

I _think_ that can still be visible at least for the virtio-gpu use case,
which hangs under VirtIOGPUBase.hostmem.  Relevant code for reference:

virtio_gpu_virgl_map_resource_blob:
    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
    memory_region_add_subregion(&b->hostmem, offset, mr);
    memory_region_set_enabled(mr, true);

virtio_gpu_pci_base_realize:
        memory_region_init(&g->hostmem, OBJECT(g), "virtio-gpu-hostmem",
                           g->conf.hostmem);
        pci_register_bar(&vpci_dev->pci_dev, 4,
                         PCI_BASE_ADDRESS_SPACE_MEMORY |
                         PCI_BASE_ADDRESS_MEM_PREFETCH |
                         PCI_BASE_ADDRESS_MEM_TYPE_64,
                         &g->hostmem);

pci_update_mappings:
            memory_region_add_subregion_overlap(r->address_space,
                                                r->addr, r->memory, 1);

but indeed I'm not sure how it work with migration so far, because it
doesn't have RAM_MIGRATABLE set. So at least cpr didn't make it more
special.  I assume this isn't something we must figure out as of now
then.. but if you do, please kindly share.

Thanks,

-- 
Peter Xu


