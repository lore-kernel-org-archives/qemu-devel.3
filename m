Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5191C4828D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 00:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVhQY-0006zj-VL; Thu, 01 Feb 2024 19:29:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVhQX-0006xG-2C
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 19:29:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVhQU-0006KY-Cv
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 19:29:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706833740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hIJGAbk9xUqkKvR/I1Rl5QqQypOibfhaXGEhMNai/r4=;
 b=FF5oFIcMeMDp9swN8O77RtMQb3Dh8VNKRbuP5hzR2AJL59Jpt6msqL43NNavFQNHBY1mft
 qOsn8VQO1QSOq/ONP/WEVChDLPVC9SpawI5v1TIg0QaHBKOL1b7T35iff1bjtyD+AnZHek
 /wy2p6PwvjgjZf2CP9k2IO+Uo570Ad0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-kpxBYpEfOWKQiXGRSofu8Q-1; Thu, 01 Feb 2024 19:28:58 -0500
X-MC-Unique: kpxBYpEfOWKQiXGRSofu8Q-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-563de65ac5dso371891a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 16:28:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706833738; x=1707438538;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hIJGAbk9xUqkKvR/I1Rl5QqQypOibfhaXGEhMNai/r4=;
 b=psphHiW0iMl47dU8aF/mI+sRXw2SrVeIQKoFBHZQyek0JgJItXgCuK30LDWq8QoOIo
 kVCsYQknPw5r/qFkC1KLDJAThIl6vxahUzYJB3JooJs9Ua3KXLhTZzQ3PeyEnqS/L2eL
 Hh7O7HhR4TZTI5njc/DN/S5lnB36VRvrhozvc5uD4SVWvV/SDkZfEk9ioYTkbleKJuNb
 rojvw9Qrv2kBTA0ZPCZMb9vpoU293YiSUsJxhPsqYPkLrOmLvOc8JU1YR++GcJtcPe1A
 COQ/j6dDidnDS7kXuQhlQxOvYMJ2f434f5Y9kgDQT+d8bXdTPoRFIXvqiz3sqpf0p/yI
 NgRw==
X-Gm-Message-State: AOJu0YwzHk2EgTzvXISfexztJ2HDtZ3YUc5hGywhNysO7NLITBYn/Mum
 pW1rVVybumO7MpFWRD3PWntEfCJfFEuL0gfTK9ZmVI9FkulcNx6mR2pmi+CY9CVd+1OXJrOtRdH
 4Fe3EKLR1PNU8PEHrTYN/T9+PzgstNRFUAtLrLC2cXdPysviUtHUb
X-Received: by 2002:a05:6a20:54a3:b0:19e:2d2d:cb49 with SMTP id
 i35-20020a056a2054a300b0019e2d2dcb49mr6872660pzk.5.1706833737714; 
 Thu, 01 Feb 2024 16:28:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQdnYqtDcnYHwisdHzw645kKUDGsIppTrLhEE6MwSu4bdKBQt9EnQS4ldlvj1Fq/mTtv/D/w==
X-Received: by 2002:a05:6a20:54a3:b0:19e:2d2d:cb49 with SMTP id
 i35-20020a056a2054a300b0019e2d2dcb49mr6872645pzk.5.1706833737361; 
 Thu, 01 Feb 2024 16:28:57 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUfxGBFNH4GVEiVx5dOIlT8G0kt5Hfq8SIxBZULw3zXMiTAtyJV9Ef7O7rtjaweSUaqBQJ1U0kxmQEU6kzp0CG3zaXv8uG1O6IVFlPN745FuKFHEyQ9Xser9Zs7MolxqcljM4VV7kSaTFVCVUlijjBX5ShCoZIsFhxhDjf4NjzTwpO3BTuFv7uwiOEh+TiaZDGTHamMRhvB4N+Wnmzc2ug=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 c26-20020aa7881a000000b006d9be753ac7sm340814pfo.108.2024.02.01.16.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 16:28:57 -0800 (PST)
Date: Fri, 2 Feb 2024 08:28:47 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Bryan Zhang <bryan.zhang@bytedance.com>,
 Prasad Pandit <ppandit@redhat.com>, Yuan Liu <yuan1.liu@intel.com>,
 Avihai Horon <avihaih@nvidia.com>, Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH 04/14] migration/multifd: Postpone reset of MultiFDPages_t
Message-ID: <Zbw3P26zfARNBsBy@x1n>
References: <20240131103111.306523-1-peterx@redhat.com>
 <20240131103111.306523-5-peterx@redhat.com>
 <87wmrpjzew.fsf@suse.de> <ZbtsCsBFuMj1fx-q@x1n>
 <87plxgi51k.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87plxgi51k.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 01, 2024 at 12:21:27PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, Jan 31, 2024 at 12:27:51PM -0300, Fabiano Rosas wrote:
> >> > +/* Reset a MultiFDPages_t* object for the next use */
> >> > +static void multifd_pages_reset(MultiFDPages_t *pages)
> >> > +{
> >> > +    /*
> >> > +     * We don't need to touch offset[] array, because it will be
> >> > +     * overwritten later when reused.
> >> > +     */
> >> > +    pages->num = 0;
> >> > +    pages->block = NULL;
> >> 
> >> Having to do this at all is a huge overloading of this field. This not
> >> only resets it, but it also communicates to multifd_queue_page() that
> >> the previous payload has been sent. Otherwise, multifd_queue_page()
> >> wouldn't know whether the previous call to multifd_queue_page() has
> >> called multifd_send_pages() or if it has exited early. So this basically
> >> means "the block that was previously here has been sent".
> >> 
> >> That's why we need the changed=true logic. A
> >> multifd_send_state->pages->block still has a few pages left to send, but
> >> because it's less than pages->allocated, it skips
> >> multifd_send_pages(). The next call to multifd_queue_page() already has
> >> the next ramblock. So we set changed=true, call multifd_send_pages() to
> >> send the remaining pages of that block and recurse into
> >> multifd_queue_page() once more to send the new block.
> >
> > I agree, the queue page routines are not easy to follow as well.
> >
> > How do you like a rewrite of the queue logic, like this?
> >
> > =====
> > bool multifd_queue_page(RAMBlock *block, ram_addr_t offset)
> > {
> >     MultiFDPages_t *pages;
> >
> > retry:
> >     pages = multifd_send_state->pages;
> >
> >     /* If the queue is empty, we can already enqueue now */
> >     if (multifd_queue_empty(pages)) {
> >         pages->block = block;
> >         multifd_enqueue(pages, offset);
> >         return true;
> >     }
> >
> >     /*
> >      * Not empty, meanwhile we need a flush.  It can because of either:
> >      *
> >      * (1) The page is not on the same ramblock of previous ones, or,
> >      * (2) The queue is full.
> >      *
> >      * After flush, always retry.
> >      */
> >     if (pages->block != block || multifd_queue_full(pages)) {
> >         if (!multifd_send_pages()) {
> >             return false;
> >         }
> >         goto retry;
> >     }
> >
> >     /* Not empty, and we still have space, do it! */
> >     multifd_enqueue(pages, offset);
> >     return true;
> > }
> > =====
> >
> > Would this be clearer?  With above, we can drop the ->ramblock reset,
> > afaict.
> >
> > I attached three patches if you agree it's better, then I'll include them
> > in v2.
> 
> Yes, let's do it.
> 
> >
> > -- 
> > Peter Xu
> > From c5dc2052794efd6da6a1e6f4b49f25d5b32879f7 Mon Sep 17 00:00:00 2001
> > From: Peter Xu <peterx@redhat.com>
> > Date: Thu, 1 Feb 2024 17:50:21 +0800
> > Subject: [PATCH 1/3] migration/multifd: Change retval of multifd_queue_page()
> >
> > Using int is an overkill when there're only two options.  Change it to a
> > boolean.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/multifd.h | 2 +-
> >  migration/multifd.c | 9 +++++----
> >  migration/ram.c     | 2 +-
> >  3 files changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/migration/multifd.h b/migration/multifd.h
> > index 34a2ecb9f4..a320c53a6f 100644
> > --- a/migration/multifd.h
> > +++ b/migration/multifd.h
> > @@ -22,7 +22,7 @@ bool multifd_recv_all_channels_created(void);
> >  void multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
> >  void multifd_recv_sync_main(void);
> >  int multifd_send_sync_main(void);
> > -int multifd_queue_page(RAMBlock *block, ram_addr_t offset);
> > +bool multifd_queue_page(RAMBlock *block, ram_addr_t offset);
> >  
> >  /* Multifd Compression flags */
> >  #define MULTIFD_FLAG_SYNC (1 << 0)
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index 91be6d2fc4..d0a3b4e062 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -505,7 +505,8 @@ static int multifd_send_pages(void)
> >      return 1;
> >  }
> >  
> > -int multifd_queue_page(RAMBlock *block, ram_addr_t offset)
> > +/* Returns true if enqueue successful, false otherwise */
> > +bool multifd_queue_page(RAMBlock *block, ram_addr_t offset)
> >  {
> >      MultiFDPages_t *pages = multifd_send_state->pages;
> >      bool changed = false;
> > @@ -519,21 +520,21 @@ int multifd_queue_page(RAMBlock *block, ram_addr_t offset)
> >          pages->num++;
> >  
> >          if (pages->num < pages->allocated) {
> > -            return 1;
> > +            return true;
> >          }
> >      } else {
> >          changed = true;
> >      }
> >  
> >      if (multifd_send_pages() < 0) {
> > -        return -1;
> > +        return false;
> >      }
> >  
> >      if (changed) {
> >          return multifd_queue_page(block, offset);
> >      }
> >  
> > -    return 1;
> > +    return true;
> >  }
> >  
> >  /* Multifd send side hit an error; remember it and prepare to quit */
> > diff --git a/migration/ram.c b/migration/ram.c
> > index d5b7cd5ac2..4649a81204 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -1252,7 +1252,7 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss)
> >  
> >  static int ram_save_multifd_page(RAMBlock *block, ram_addr_t offset)
> >  {
> > -    if (multifd_queue_page(block, offset) < 0) {
> > +    if (!multifd_queue_page(block, offset)) {
> >          return -1;
> >      }
> >      stat64_add(&mig_stats.normal_pages, 1);
> > -- 
> > 2.43.0
> >
> > From f393f1cfe95d79bed72e6043903ee4c4cb298c21 Mon Sep 17 00:00:00 2001
> > From: Peter Xu <peterx@redhat.com>
> > Date: Thu, 1 Feb 2024 17:51:38 +0800
> > Subject: [PATCH 2/3] migration/multifd: Change retval of multifd_send_pages()
> >
> > Using int is an overkill when there're only two options.  Change it to a
> > boolean.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/multifd.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index d0a3b4e062..d2b0f0eda9 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -449,9 +449,10 @@ static void multifd_send_kick_main(MultiFDSendParams *p)
> >   * thread is using the channel mutex when changing it, and the channel
> >   * have to had finish with its own, otherwise pending_job can't be
> >   * false.
> > + *
> > + * Returns true if succeed, false otherwise.
> >   */
> > -
> > -static int multifd_send_pages(void)
> > +static bool multifd_send_pages(void)
> >  {
> >      int i;
> >      static int next_channel;
> > @@ -459,7 +460,7 @@ static int multifd_send_pages(void)
> >      MultiFDPages_t *pages = multifd_send_state->pages;
> >  
> >      if (multifd_send_should_exit()) {
> > -        return -1;
> > +        return false;
> >      }
> >  
> >      /* We wait here, until at least one channel is ready */
> > @@ -473,7 +474,7 @@ static int multifd_send_pages(void)
> >      next_channel %= migrate_multifd_channels();
> >      for (i = next_channel;; i = (i + 1) % migrate_multifd_channels()) {
> >          if (multifd_send_should_exit()) {
> > -            return -1;
> > +            return false;
> >          }
> >          p = &multifd_send_state->params[i];
> >          /*
> > @@ -502,7 +503,7 @@ static int multifd_send_pages(void)
> >      qemu_mutex_unlock(&p->mutex);
> >      qemu_sem_post(&p->sem);
> >  
> > -    return 1;
> > +    return true;
> >  }
> >  
> >  /* Returns true if enqueue successful, false otherwise */
> > @@ -526,7 +527,7 @@ bool multifd_queue_page(RAMBlock *block, ram_addr_t offset)
> >          changed = true;
> >      }
> >  
> > -    if (multifd_send_pages() < 0) {
> > +    if (!multifd_send_pages()) {
> >          return false;
> >      }
> >  
> > @@ -666,7 +667,7 @@ int multifd_send_sync_main(void)
> >          return 0;
> >      }
> >      if (multifd_send_state->pages->num) {
> > -        if (multifd_send_pages() < 0) {
> > +        if (!multifd_send_pages()) {
> >              error_report("%s: multifd_send_pages fail", __func__);
> >              return -1;
> >          }
> > -- 
> > 2.43.0
> >
> > From fcddc942cb31bc9d395d67a555d9a2281da452b1 Mon Sep 17 00:00:00 2001
> > From: Peter Xu <peterx@redhat.com>
> > Date: Thu, 1 Feb 2024 17:55:42 +0800
> > Subject: [PATCH 3/3] migration/multifd: Rewrite multifd_queue_page()
> >
> > The current multifd_queue_page() is not easy to read and follow.  It is not
> > good with a few reasons:
> >
> >   - No helper at all to show what exactly does a condition mean; in short,
> >   readability is low.
> >
> >   - Rely on pages->ramblock being cleared to detect an empty queue.  It's
> >   slightly an overload of the ramblock pointer, per Fabiano [1], which I
> >   also agree.
> >
> >   - Contains a self recursion, even if not necessary..
> >
> > Rewrite this function.  We add some comments to make it even clearer on
> > what it does.
> >
> > [1] https://lore.kernel.org/r/87wmrpjzew.fsf@suse.de
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/multifd.c | 56 ++++++++++++++++++++++++++++++---------------
> >  1 file changed, 37 insertions(+), 19 deletions(-)
> >
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index d2b0f0eda9..5a64a9c2e2 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -506,35 +506,53 @@ static bool multifd_send_pages(void)
> >      return true;
> >  }
> >  
> > +static inline bool multifd_queue_empty(MultiFDPages_t *pages)
> > +{
> > +    return pages->num == 0;
> > +}
> 
> Good, because we can later switch from pages to something else entirely.
> 
> > +
> > +static inline bool multifd_queue_full(MultiFDPages_t *pages)
> > +{
> > +    return pages->num == pages->allocated;
> > +}
> 
> Pages allocated is nonsense. See if you agree with its removal:
> https://gitlab.com/farosas/qemu/-/commit/7cfff1a3e31b271e901a6c08d8b5d8c01b680e4d
> 
> ---
> From 7cfff1a3e31b271e901a6c08d8b5d8c01b680e4d Mon Sep 17 00:00:00 2001
> From: Fabiano Rosas <farosas@suse.de>
> Date: Tue, 24 Oct 2023 19:03:41 -0300
> Subject: [PATCH] multifd: Remove MultiFDPage_t:allocated
> 
> When dealing with RAM, having a field called 'allocated' is
> confusing. This field simply holds number of pages that fit in a
> multifd packet.
> 
> Since it is a constant dependent on the size of the multifd packet,
> remove it and instead use the page size and MULTIFD_PACKET_SIZE
> directly.
> 
> This is another step in the direction of having no mentions of 'page'
> in the multifd send thread.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/multifd.c | 6 ++----
>  migration/multifd.h | 2 --
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index bdefce27706..83fb2caab04 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -241,7 +241,6 @@ static MultiFDPages_t *multifd_pages_init(uint32_t n)
>  {
>      MultiFDPages_t *pages = g_new0(MultiFDPages_t, 1);
>  
> -    pages->allocated = n;
>      pages->offset = g_new0(ram_addr_t, n);
>      pages->page_size = qemu_target_page_size();
>  
> @@ -251,7 +250,6 @@ static MultiFDPages_t *multifd_pages_init(uint32_t n)
>  static void multifd_pages_clear(MultiFDPages_t *pages)
>  {
>      pages->num = 0;
> -    pages->allocated = 0;
>      pages->block = NULL;
>      g_free(pages->offset);
>      pages->offset = NULL;
> @@ -264,7 +262,7 @@ static void multifd_send_fill_packet(MultiFDSendParams *p)
>      int i;
>  
>      packet->flags = cpu_to_be32(p->flags);
> -    packet->pages_alloc = cpu_to_be32(p->pages->allocated);
> +    packet->pages_alloc = cpu_to_be32(MULTIFD_PACKET_SIZE / p->pages->page_size);
>      packet->normal_pages = cpu_to_be32(p->pages->num);
>      packet->next_packet_size = cpu_to_be32(p->next_packet_size);
>      packet->packet_num = cpu_to_be64(p->packet_num);
> @@ -451,7 +449,7 @@ int multifd_queue_page(RAMBlock *block, ram_addr_t offset)
>          pages->offset[pages->num] = offset;
>          pages->num++;
>  
> -        if (pages->num < pages->allocated) {
> +        if (pages->num * pages->page_size < MULTIFD_PACKET_SIZE) {
>              return 1;
>          }
>      } else {
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 655f8d5eeb4..d1342296d63 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -56,8 +56,6 @@ typedef struct {
>  typedef struct {
>      /* number of used pages */
>      uint32_t num;
> -    /* number of allocated pages */
> -    uint32_t allocated;
>      /* guest page size */
>      uint32_t page_size;
>      /* offset of each page */
> -- 

I agree.

Even if we would like to add a parameter to setup the allcated size (I
remember one of the accelerator series has it), it'll still be a global
variable rather than per-pages thing.

I can cherry pick this and post together; will need a rebase but I can do
that.

-- 
Peter Xu


