Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05723D68BCB
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 15:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tByRe-0003gW-2J; Fri, 15 Nov 2024 10:41:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tByRc-0003XM-QI
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:41:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tByRa-0000Lm-KT
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:41:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731685268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NNfV4bxdZOuu9wCNtNAJJ4tjt13Rjf7Iz6zYvYEPChw=;
 b=DkThGk30fW3RF6sjHa14AuPZ2vXYz9K0PN2MBYlIu1CyuWkLs1+yo4OASFnF98T7jzAL+6
 B+KCG8ikZGxbB60Z2unvMgbvaibeO5f+oai8TVBk8Tv1l4GX+eKoJFI1VcrQ4bN5Se2hhb
 a0tbKs2IvJB872meqegkVwC66E/AxDs=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-ngNYO8sJM-6CwIqQry5-bg-1; Fri, 15 Nov 2024 10:41:06 -0500
X-MC-Unique: ngNYO8sJM-6CwIqQry5-bg-1
X-Mimecast-MFC-AGG-ID: ngNYO8sJM-6CwIqQry5-bg
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-83ac1f28d2bso198552139f.0
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 07:41:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731685265; x=1732290065;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NNfV4bxdZOuu9wCNtNAJJ4tjt13Rjf7Iz6zYvYEPChw=;
 b=fMHK5hg7s9RHCWVPUlJHkWjnoXtryYv9ztvgT/VgNuSoAW8EMc7L7XZeVxI3d4WStj
 NqKs93IxN9vwFzbTWPPuvN9KY6jNqtj83dienUACJeDe97zvEvOXiJSBIxsO6sKo27YW
 AffAXCyDNdrRut+m75bOZoKmKBMmVlgv1OMVcDAB540sSe454RW2BsO9VF3ypd9UhkIr
 qICutHv+TMKT3KBjS/CPxYb1LeabOL9UoTZU5fF+8IqvCZRu6gWsUS7ab8bIvCwctUY6
 ZJRpccx3ntirPACaMyhFwSBmTrBN9+7q4NabZMgHkK1I3M0DmmPrcKxGW9CtAQIvtDr3
 iVlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/5i2A0+wyalL8gxMr2eiPtSqGFTv0iPQei4VhzAD7ppR2tSdokeFWLeLnPAzXeGMXsvs/pMmvOOOy@nongnu.org
X-Gm-Message-State: AOJu0YyYFAabQ59byUpwaXW+3e0NjZ/xuZhPoS63rihGfr1/CrEtRWpX
 MB3IwcPQHiAY/4BrOAXvApRT8LlIYgFRCrwsyFsAYnvVqABtuwSXvX1MONB4xnis7WWWSxv0uAK
 nkILSXAhx8ku/3XpADuVtFwZKM+QJxPGwCQ+98yoS8nIA1UFz5qmD
X-Received: by 2002:a05:6602:2ccc:b0:835:4278:f130 with SMTP id
 ca18e2360f4ac-83e6c2e99b3mr359245639f.13.1731685265108; 
 Fri, 15 Nov 2024 07:41:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/WYp3n/OygqLq6r3McKTanCSzXO0BSNMv06ZqzJ/GqIssg3F2auKLe/W72aOsItKifo0SRw==
X-Received: by 2002:a05:6602:2ccc:b0:835:4278:f130 with SMTP id
 ca18e2360f4ac-83e6c2e99b3mr359243039f.13.1731685264729; 
 Fri, 15 Nov 2024 07:41:04 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e06d706ae1sm392952173.37.2024.11.15.07.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 07:41:03 -0800 (PST)
Date: Fri, 15 Nov 2024 10:41:01 -0500
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Yong Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Wei Wang <wei.w.wang@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v1 2/2] migration: Do not perform RAMBlock dirty sync
 during the first iteration
Message-ID: <ZzdrjTXgNFlrqqEu@x1n>
References: <CAK9dgmY8BAy4JAj5y-fY_YOpM6b3=86cmckPJZFuk9k=X1TYfQ@mail.gmail.com>
 <3049bc19-2556-4fbf-9d34-578db523b63b@redhat.com>
 <ZzTkopUrLGL5iqSv@x1n>
 <382461ab-d620-4d2e-becd-720daadf3c55@redhat.com>
 <ZzUIOFPtvHKDJPei@x1n>
 <8ee7d398-0139-4628-9276-f6a89fa35245@redhat.com>
 <ZzZPd7Ye09bjUjyR@x1n>
 <5f04a1dc-ca0a-488b-812e-7cebf393f59f@redhat.com>
 <ZzZ8Tzw9WV9dHo_R@x1n>
 <5577f4cc-63f9-4f4a-b857-48a9405075c1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5577f4cc-63f9-4f4a-b857-48a9405075c1@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Nov 15, 2024 at 10:11:51AM +0100, David Hildenbrand wrote:
> > > > > 
> > > > > But then I realized that even memory_region_clear_dirty_bitmap() will not
> > > > > clear the ramblock_dirty_bitmap_ bits! It's only concerned about
> > > > > listener->log_clear() calls.
> > > > > 
> > > > > Looking for DIRTY_MEMORY_BLOCK_SIZE users, only
> > > > > cpu_physical_memory_sync_dirty_bitmap() and
> > > > > cpu_physical_memory_clear_dirty_range() clear them, whereby the latter is
> > > > > only used when resizing RAMblocks.
> > > > > 
> > > > > At first I wondered whether ramblock_dirty_bitmap_clear_discarded_pages()
> > > > > should also call cpu_physical_memory_clear_dirty_range(), but then I am not
> > > > > so sure if that is really the right approach.
> > > > 
> > > > That sounds actually reasonable to me so far.. What's the concern in your
> > > > mind?
> > > 
> > > I think what I had in mind was that for the initial bitmap sync, when we set
> > > the bmap to all-1s already, we could just clear the whole
> > > ramblock_dirty_bitmap_ + KVM ... bitmaps.
> > > 
> > > So, instead of an "initial sync" we might just want to do an "initial
> > > clearing" of all bitmaps.
> > 
> > Logically most dirty tracking bitmaps should start with all zeros.  KVM old
> > kernels are like that; KVM_DIRTY_LOG_INITIALLY_SET is not, but it's a
> > separate feature.  I still hope it's pretty common for the rest, e.g. vhost
> > should have all zeros in its init bitmap even without initial sync.
> 
> We better double check and document that, because it must be guaranteed, not
> "let's cross fingers".

Yes, we should double check on at least known good use cases, maybe not
all.

E.g., I see nvmm_log_sync() and whpx_log_sync() unconditionally set dirty
to all mem always.  I actually don't know how some of these trackers work
for live migration, or if it works at all.

If by accident this change breaks something, I also wonder whether we
should fix the patch that breaks it, or fix the assumption that the 1st
sync must happen at setup.  That's simply wrong to me.. and not all dirty
track users have such either.  E.g. vga tracking won't even have a SETUP
phase at all.

The simplest solution for any potential breakage is to provide a
log_global_start() and sync once there, that's exactly what SETUP should
do.  But I hope it won't happen at all..

This is legacy tech debt to me.  The earlier we understand it the better,
so I'm personally ok if someone would try to do this as long as major archs
will be safe.

> 
> Also, I'm not 100% sure how KVM internals implement that (I recall some
> s390x oddities, but might be wrong ...).
> 
> > 
> > > 
> > > > 
> > > > > 
> > > > > 
> > > > > virtio-balloon() calls qemu_guest_free_page_hint() which calls
> > > > > 
> > > > > migration_clear_memory_region_dirty_bitmap_range()
> > > > > bitmap_clear()
> > > > > 
> > > > > So it would maybe have the same issue.
> > > > 
> > > > Should virtio-balloon do the same?
> > > 
> > > virtio-balloon is more interesting, because I assume here we could run after
> > > the "initial clearing" and would want to mark it clean everywhere.
> > 
> > Yes, if it does what I mentioned below, IIUC it'll clear all dirty bits
> > across the whole stack.  Only the ram_list bitmap is missing.  IIUC it
> > could mean it could stop working for at least tcg, as tcg sololy uses
> > it.. even with kvm some MRs may use it.  Maybe we want to fix it
> > separately.
> 
> Yes, that definitely needs care.
> 
> [...]
> 
> > > (but I'm confused because we have way too many bitmaps, and maybe the KVM
> > > one could be problematic without an initial sync ... we'd want an initial
> > > clearing for that as well ...)
> > 
> > So IMHO most of the bitmaps should be initialized with zeros, not
> > ones.. like I mentioned above.
> > 
> > Migration bitmap is special, because it's not about dirty tracking
> > capability / reporting but that we know we need to migrate the first round.
> > So setting all ones makes sense for migration only, not a reporting
> > facility.  While KVM_DIRTY_LOG_INITIALLY_SET existed for its own reasoning
> > on speeding up migration starts..
> > 
> > So, now I am thinking whether we should not set all ones in ram_list bitmap
> > at all, corresponds to this change:
> > 
> > ===8<===
> > diff --git a/system/physmem.c b/system/physmem.c
> > index dc1db3a384..10966fa68c 100644
> > --- a/system/physmem.c
> > +++ b/system/physmem.c
> > @@ -1913,10 +1913,6 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
> >       ram_list.version++;
> >       qemu_mutex_unlock_ramlist();
> > -    cpu_physical_memory_set_dirty_range(new_block->offset,
> > -                                        new_block->used_length,
> > -                                        DIRTY_CLIENTS_ALL);
> > -
> >       if (new_block->host) {
> >           qemu_ram_setup_dump(new_block->host, new_block->max_length);
> >           qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_HUGEPAGE);
> > ===8<===
> > 
> 
> It will leave things in an inconsistent state with regards of
> qemu_ram_resize() though. So we'd want to do the same thing there as well.
> 
> I don't know about DIRTY_CLIENTS_ALL, though ... no expert on that, which
> side effects it has.
> 
> Because saying "initially, all memory is dirty" can make sense, depending on
> from which angle you look at it.

Migration definitely doesn't need it, so to be safe we could also make
CLIENT_ALL to CODE|VGA.

And if we agree virtio-mem will need to punch holes on all the bitmaps,
then this patch is even not needed.  For that, more below.

> 
> > I'm guessing whether above could fix the virtio-mem regression after
> > Hyman's current patch applied.
> > 
> > Said that, IMHO virtio-mem should still use the same helper just like
> > virtio-balloon as I discussed previously, so as to reset bitmap for the
> > whole stack (which seems to always be the right thing to do to not miss one
> > layer of them)?
> 
> Well, the difference is that virtio-mem really only gets called exactly once
> initially. If we can just reset all bitmaps initially, then virtio-mem
> really only has to zap the rb->bmap.

I think virtio-mem should better always punch through, regardless of
whether we can have above change. Consider cases like KVM "initial-all-set"
feature I mentioned above, when that feature bit is set by QEMU, KVM sets
all ones to the bitmap initially.  So that may be required for virtio-mem
to clear 1s in KVM at least.

> 
> The most robust solution would be to process discards after every bitmap
> sync of course.
> 
> > 
> > Hence: 1 patch to virtio-balloon covering ram_list bitmap (which could be a
> > real fix to virtio-balloon on e.g. tcg?); 1 patch to virtio-mem reusing
> > that helper of virtio-balloon just as a cleanup to also cover all bitmaps;
> > 1 patch like above to avoid setting ones at all in ram_list bitmap as
> > cleanup; then finally remove the sync() in SETUP, which is this patch.
> > IIUC after all these changes applied it'll work for all cases.
> 
> Would work for me.
> 
> BTW, I was wondering if we could get rid of one of the bitmaps with KVM ...
> but likely not that easy.

Yeh.  The memslots' bitmap can be completely overwritten by KVM kernel, so
at least we can't simply make use of the migration ram_list bitmap there..

-- 
Peter Xu


