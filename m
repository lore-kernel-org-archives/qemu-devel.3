Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DA4D6B6C4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 19:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6EbS-0002ar-GE; Wed, 30 Oct 2024 15:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6EbP-0002ag-Br
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 15:43:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6EbI-0004OE-U5
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 15:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730317407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=snPQo/q0D2hJ7gxDH09kDwj+hKYA7cXpGbhPP/Yz29o=;
 b=VQ1RXyU6qji01N+VfY/jL458MEfXxsSnk194GY4FfXHqjAma74Q5VCNXY25qNdO6l9M386
 Ka0fvj9ZHEGm6XApefg5jw8u5CjMIMWl6V2JLcYZmaT6cnq6k2oGZm+PLBCxFpAUv0XL57
 yNo81TjDjA1DI5MZ71nU9nsFgBcgSmQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-VxX3c16sOvWOZwixBZ7sxw-1; Wed, 30 Oct 2024 15:43:24 -0400
X-MC-Unique: VxX3c16sOvWOZwixBZ7sxw-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-460a85907b7so3760751cf.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 12:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730317403; x=1730922203;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=snPQo/q0D2hJ7gxDH09kDwj+hKYA7cXpGbhPP/Yz29o=;
 b=mwJMBmhB/948qVk3FqX+6N+RXnnfADarCldrsULzhAi4tAOdJc/onoTur4N/duthF/
 kvfuvEGgFnyMgXOZh3K8FYOxY/+Tw39Qa78/pWwRukHQrERDsFc/xnw+W/whWuD9UJdO
 kbYTkmbO5PCsAJ/f7z2ina3HGA9HKq20tthMzL9zBA4W3/0mlklD5/oVj750r8Na8eGb
 3cX7NHL963HByunck6z8RCD26ZwrZ/tcyOHdvbesV8ThYBxZx0VuVtebXa8fxNiI1EkO
 qC904lNuIvFYgCu7QDYNUMevJvivnQMeEesqAEY9aLbPThpdIpRcJGNo9LgwStm4+TRA
 rhiw==
X-Gm-Message-State: AOJu0Yxh6p3mRjykq2ejCmvSFzenaA+MQ7oSmko5Cr7Os61sYrNCRs2h
 aZlXISq+pkwEk9OdZVQWPBk9mW6BERsEn9sTdltIeBW32OapgV6/1012/S4NlNGexMlqdwDUffw
 KDN914EBbZNpZyWBEHa25RmzlGu5mYB9n5kbg++xU/aUaDgDyayBT
X-Received: by 2002:ac8:5742:0:b0:460:a825:636c with SMTP id
 d75a77b69052e-4613bff0d99mr282931271cf.14.1730317403353; 
 Wed, 30 Oct 2024 12:43:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH97O8Xruv3M/HOobDzT9v3XZOzfUbOim9WXh9YQAAOZP3FrAgGjV7VRhuLGeN8/yPZU3CPCQ==
X-Received: by 2002:ac8:5742:0:b0:460:a825:636c with SMTP id
 d75a77b69052e-4613bff0d99mr282930891cf.14.1730317402906; 
 Wed, 30 Oct 2024 12:43:22 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46132142c60sm57630431cf.33.2024.10.30.12.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 12:43:21 -0700 (PDT)
Date: Wed, 30 Oct 2024 15:43:19 -0400
From: Peter Xu <peterx@redhat.com>
To: Yong Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC 2/2] migration: Avoid doing RAMBlock dirty sync in
 the initial iteration
Message-ID: <ZyKMVxuJyb3SZXkj@x1n>
References: <cover.1729648695.git.yong.huang@smartx.com>
 <76f0ea57ac7f4c2a68203d17fec1c34bb3d16a4a.1729648695.git.yong.huang@smartx.com>
 <ZyELi_ax8zM_kFbZ@x1n>
 <CAK9dgmZ_++jEmhRfO9QR3WQFs18AwUnvn=_dTyfUnv5PHXYBYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK9dgmZ_++jEmhRfO9QR3WQFs18AwUnvn=_dTyfUnv5PHXYBYA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Oct 30, 2024 at 10:09:38AM +0800, Yong Huang wrote:
> On Wed, Oct 30, 2024 at 12:21 AM Peter Xu <peterx@redhat.com> wrote:
> 
> > On Wed, Oct 23, 2024 at 10:09:51AM +0800, yong.huang@smartx.com wrote:
> > > From: Hyman Huang <yong.huang@smartx.com>
> > >
> > > KVM always returns 1 when userspace retrieves a dirty bitmap for
> > > the first time when KVM_DIRTY_LOG_INITIALLY_SET is enabled; in such
> > > scenario, the RAMBlock dirty sync of the initial iteration can be
> > > skipped.
> > >
> > > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > > ---
> > >  migration/cpu-throttle.c |  3 ++-
> > >  migration/ram.c          | 30 +++++++++++++++++++++++++++---
> > >  2 files changed, 29 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/migration/cpu-throttle.c b/migration/cpu-throttle.c
> > > index 342681cdd4..06e3b1be78 100644
> > > --- a/migration/cpu-throttle.c
> > > +++ b/migration/cpu-throttle.c
> > > @@ -27,6 +27,7 @@
> > >  #include "hw/core/cpu.h"
> > >  #include "qemu/main-loop.h"
> > >  #include "sysemu/cpus.h"
> > > +#include "sysemu/kvm.h"
> > >  #include "cpu-throttle.h"
> > >  #include "migration.h"
> > >  #include "migration-stats.h"
> > > @@ -141,7 +142,7 @@ void cpu_throttle_dirty_sync_timer_tick(void *opaque)
> > >       * effect on guest performance, therefore omit it to avoid
> > >       * paying extra for the sync penalty.
> > >       */
> > > -    if (sync_cnt <= 1) {
> > > +    if (sync_cnt <= (kvm_dirty_log_manual_enabled() ? 0 : 1)) {
> > >          goto end;
> > >      }
> > >
> > > diff --git a/migration/ram.c b/migration/ram.c
> > > index d284f63854..b312ebd69d 100644
> > > --- a/migration/ram.c
> > > +++ b/migration/ram.c
> > > @@ -2718,7 +2718,7 @@ static void ram_list_init_bitmaps(void)
> > >  {
> > >      MigrationState *ms = migrate_get_current();
> > >      RAMBlock *block;
> > > -    unsigned long pages;
> > > +    unsigned long pages, clear_bmap_pages;
> > >      uint8_t shift;
> > >
> > >      /* Skip setting bitmap if there is no RAM */
> > > @@ -2736,6 +2736,7 @@ static void ram_list_init_bitmaps(void)
> > >
> > >          RAMBLOCK_FOREACH_NOT_IGNORED(block) {
> > >              pages = block->max_length >> TARGET_PAGE_BITS;
> > > +            clear_bmap_pages = clear_bmap_size(pages, shift);
> > >              /*
> > >               * The initial dirty bitmap for migration must be set with
> > all
> > >               * ones to make sure we'll migrate every guest RAM page to
> > > @@ -2751,7 +2752,17 @@ static void ram_list_init_bitmaps(void)
> > >                  block->file_bmap = bitmap_new(pages);
> > >              }
> > >              block->clear_bmap_shift = shift;
> > > -            block->clear_bmap = bitmap_new(clear_bmap_size(pages,
> > shift));
> > > +            block->clear_bmap = bitmap_new(clear_bmap_pages);
> > > +            /*
> > > +             * Set the clear bitmap by default to enable dirty logging.
> > > +             *
> > > +             * Note that with KVM_DIRTY_LOG_INITIALLY_SET, dirty logging
> > > +             * will be enabled gradually in small chunks using
> > > +             * KVM_CLEAR_DIRTY_LOG
> > > +             */
> > > +            if (kvm_dirty_log_manual_enabled()) {
> > > +                bitmap_set(block->clear_bmap, 0, clear_bmap_pages);
> > > +            }
> >
> > Why it needs to be relevant to whether DIRTY_LOG is enabled?
> >
> > I wonder if we should always set clear_bmap to 1 unconditionally, as we
> > always set bmap to all 1s by default.
> >
> 
> OK, this works. We can drop it.
> 
> 
> >
> > Then we skip sync always during setup, dropping patch 1.
> >
> 
> IIUC, KVM initializes the slot->dirty_bitmap with 1 only when
> KVM_DIRTY_LOG_INITIALLY_SET is enabled, 0 otherwize.
> This means that if KVM does not support the
> KVM_DIRTY_LOG_INITIALLY_SET feature, userspace should
> do the first sync so that KVM could set the WP bit and clear
> the D-bit of the PTE.
> 
> Skipping first sync could handle this scenario?

Yes, the old kernels could be tricky (!CLEAR_LOG support), but I hope it's
also working.

The thing is log_start() should also protect all pages if that's the case.
For x86, that should corresponds to:

kvm_mmu_slot_apply_flags():

		/*
		 * Initially-all-set does not require write protecting any page,
		 * because they're all assumed to be dirty.
		 */
		if (kvm_dirty_log_manual_protect_and_init_set(kvm))
			return;

		if (READ_ONCE(eager_page_split))
			kvm_mmu_slot_try_split_huge_pages(kvm, new, PG_LEVEL_4K);

		if (kvm_x86_ops.cpu_dirty_log_size) {
			kvm_mmu_slot_leaf_clear_dirty(kvm, new);
			kvm_mmu_slot_remove_write_access(kvm, new, PG_LEVEL_2M);
		} else {
			kvm_mmu_slot_remove_write_access(kvm, new, PG_LEVEL_4K);
		}

In general, I think even if GET_DIRTY_LOG in setup() is omitted, all pages
should still be wr-protected already right after log_start().  Then follow
up log_clear()s will be noop, until the next sync which will reprotect
every page again.

Please double check.

Thanks,

-- 
Peter Xu


