Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EF2E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 19:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTRBb-0003yc-DU; Thu, 02 Jan 2025 14:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tTRBZ-0003yE-Ro
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 14:48:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tTRBX-0003Tb-V8
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 14:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735847325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t2eSs2oKoGrCGnogND6unf3AFwwxV4FmURv6T/rTMu4=;
 b=cjkVJ7Tb2MXFUitXp7rwqqIrjhN8GYT6Qh83HtH/dwuFEvkxwXtCtT95wCp1bivb3BSK95
 GFEP52fqs7QzxqudOu3jYKJ0C8zE/eOyociAOLeZoR/+L104fxzcTOA5DxkLv0oosdQdwL
 uH/JVKsBBOWjqhs6/OLQwWzhHM1qSk8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-NQIlf2-qNzeYOm5tNgaLrA-1; Thu, 02 Jan 2025 14:48:41 -0500
X-MC-Unique: NQIlf2-qNzeYOm5tNgaLrA-1
X-Mimecast-MFC-AGG-ID: NQIlf2-qNzeYOm5tNgaLrA
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b6f943f59dso1770042785a.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 11:48:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735847320; x=1736452120;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t2eSs2oKoGrCGnogND6unf3AFwwxV4FmURv6T/rTMu4=;
 b=Ei0hlzu8BR/xkAUkPKzt6Xu0Bphux8KRU65HmdBV3haUELG/JtqFJ8nSB7P2sSw5B6
 /o38Q0lsKK32ox0qTrigkLsA0NUaKdmgyzasrwNJGt7GMBi3GeRSdUe8A/mVCTc5A3bf
 c60PZ6JVcRni2bgJnti2iSC1mDzoIXsM3N56LoPreblidznmuLT0tuXkxVx3rIM8SbiN
 OkdjC/RDDmTNjlyTycHkRRBXCsVRFygoMz/MHN9OGjtnITJ2Hiwsln2+sHRt0+d7C2U8
 39zfKDmGH+A+0fGUrHbhLjM879jYjICP9qUWtA2jBg6MJHgKx+6YvSDUWNd1B4FB5jOb
 TEIw==
X-Gm-Message-State: AOJu0YwBfV0FfNHkQpG3DbAbq5XAU1aBUnmmO5yLWrrd14ek4193Uvqk
 a+wBrqs1XQCxmAjFHMaQiPO8w+0Vil9wLfrooJzxssDKdXHfoQMw6k4KePLukfN+6L4+xP/99K/
 Y1PqYHpZbx69Yez5K1dZD1rmwbK3EiVXBDKDok5dVjn0mlmIAmu0C
X-Gm-Gg: ASbGnctl510q+a7k7JM8NzWsm5vFGxbFD0RaibRPg92rZHdbhld+dwwo+pDz52Mzktx
 rr2DEZq8FJonjtPTNY9PrH8/Sv2wYDHKN8JB0zv34tanG5BeM9GVi/0p6wNuxLr5LxKnpkRqORw
 xnFbrKwcem041RHX0wy2Z6T2M0YAmEtcta0KqTPYL3NltYxtnyw5UYMzCqXzXE+XZiKMI58Uo2o
 YsAQP+V1za1lKLva5UyjAjblnqQgaSJCV9/iFGc4JeQiXk9SmMK0QMXQRosrQee5OjGnIkCwuBa
 x4JR40GxzZktdLZOqw==
X-Received: by 2002:a05:620a:3185:b0:7b7:106a:19a0 with SMTP id
 af79cd13be357-7b9ba799addmr7463215885a.24.1735847320105; 
 Thu, 02 Jan 2025 11:48:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1d5MNKGXlLpb/R5CWw0x6VJM6r9VAf5hbgeHPC3QQeud+Zaep0af7wXLy1VuhK/C/+hp5Yw==
X-Received: by 2002:a05:620a:3185:b0:7b7:106a:19a0 with SMTP id
 af79cd13be357-7b9ba799addmr7463212585a.24.1735847319695; 
 Thu, 02 Jan 2025 11:48:39 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac47a6cdsm1201100185a.93.2025.01.02.11.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 11:48:39 -0800 (PST)
Date: Thu, 2 Jan 2025 14:48:36 -0500
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V5 02/23] physmem: qemu_ram_alloc_from_fd extensions
Message-ID: <Z3btlLk4YpljgS4R@x1n>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
 <1735057028-308595-3-git-send-email-steven.sistare@oracle.com>
 <Z2rs4nYtuXfFW4sT@x1n>
 <afde28fb-fad5-4ba7-8c28-bf9f2a05cd1b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <afde28fb-fad5-4ba7-8c28-bf9f2a05cd1b@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Thu, Jan 02, 2025 at 01:36:01PM -0500, Steven Sistare wrote:
> On 12/24/2024 12:18 PM, Peter Xu wrote:
> > On Tue, Dec 24, 2024 at 08:16:47AM -0800, Steve Sistare wrote:
> > > Extend qemu_ram_alloc_from_fd to support resizable ram, and define
> > > qemu_ram_resize_cb to clean up the API.
> > > 
> > > Add a grow parameter to extend the file if necessary.  However, if
> > > grow is false, a zero-sized file is always extended.
> > > 
> > > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > > ---
> > >   include/exec/ram_addr.h | 13 +++++++++----
> > >   system/memory.c         |  4 ++--
> > >   system/physmem.c        | 35 ++++++++++++++++++++---------------
> > >   3 files changed, 31 insertions(+), 21 deletions(-)
> > > 
> > > diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> > > index ff157c1..94bb3cc 100644
> > > --- a/include/exec/ram_addr.h
> > > +++ b/include/exec/ram_addr.h
> > > @@ -111,23 +111,30 @@ long qemu_maxrampagesize(void);
> > >    *
> > >    * Parameters:
> > >    *  @size: the size in bytes of the ram block
> > > + *  @max_size: the maximum size of the block after resizing
> > >    *  @mr: the memory region where the ram block is
> > > + *  @resized: callback after calls to qemu_ram_resize
> > >    *  @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
> > >    *              RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
> > >    *              RAM_READONLY_FD, RAM_GUEST_MEMFD
> > >    *  @mem_path or @fd: specify the backing file or device
> > >    *  @offset: Offset into target file
> > > + *  @grow: extend file if necessary (but an empty file is always extended).
> > >    *  @errp: pointer to Error*, to store an error if it happens
> > >    *
> > >    * Return:
> > >    *  On success, return a pointer to the ram block.
> > >    *  On failure, return NULL.
> > >    */
> > > +typedef void (*qemu_ram_resize_cb)(const char *, uint64_t length, void *host);
> > > +
> > >   RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
> > >                                      uint32_t ram_flags, const char *mem_path,
> > >                                      off_t offset, Error **errp);
> > > -RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
> > > +RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
> > > +                                 qemu_ram_resize_cb resized, MemoryRegion *mr,
> > >                                    uint32_t ram_flags, int fd, off_t offset,
> > > +                                 bool grow,
> > >                                    Error **errp);
> > >   RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
> > > @@ -135,9 +142,7 @@ RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
> > >   RAMBlock *qemu_ram_alloc(ram_addr_t size, uint32_t ram_flags, MemoryRegion *mr,
> > >                            Error **errp);
> > >   RAMBlock *qemu_ram_alloc_resizeable(ram_addr_t size, ram_addr_t max_size,
> > > -                                    void (*resized)(const char*,
> > > -                                                    uint64_t length,
> > > -                                                    void *host),
> > > +                                    qemu_ram_resize_cb resized,
> > >                                       MemoryRegion *mr, Error **errp);
> > >   void qemu_ram_free(RAMBlock *block);
> > > diff --git a/system/memory.c b/system/memory.c
> > > index 78e17e0..290c522 100644
> > > --- a/system/memory.c
> > > +++ b/system/memory.c
> > > @@ -1680,8 +1680,8 @@ bool memory_region_init_ram_from_fd(MemoryRegion *mr,
> > >       mr->readonly = !!(ram_flags & RAM_READONLY);
> > >       mr->terminates = true;
> > >       mr->destructor = memory_region_destructor_ram;
> > > -    mr->ram_block = qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, offset,
> > > -                                           &err);
> > > +    mr->ram_block = qemu_ram_alloc_from_fd(size, size, NULL, mr, ram_flags, fd,
> > > +                                           offset, false, &err);
> > >       if (err) {
> > >           mr->size = int128_zero();
> > >           object_unparent(OBJECT(mr));
> > > diff --git a/system/physmem.c b/system/physmem.c
> > > index c76503a..48c544f 100644
> > > --- a/system/physmem.c
> > > +++ b/system/physmem.c
> > > @@ -1942,8 +1942,10 @@ out_free:
> > >   }
> > >   #ifdef CONFIG_POSIX
> > > -RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
> > > +RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
> > > +                                 qemu_ram_resize_cb resized, MemoryRegion *mr,
> > >                                    uint32_t ram_flags, int fd, off_t offset,
> > > +                                 bool grow,
> > >                                    Error **errp)
> > >   {
> > >       RAMBlock *new_block;
> > > @@ -1953,7 +1955,9 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
> > >       /* Just support these ram flags by now. */
> > >       assert((ram_flags & ~(RAM_SHARED | RAM_PMEM | RAM_NORESERVE |
> > >                             RAM_PROTECTED | RAM_NAMED_FILE | RAM_READONLY |
> > > -                          RAM_READONLY_FD | RAM_GUEST_MEMFD)) == 0);
> > > +                          RAM_READONLY_FD | RAM_GUEST_MEMFD |
> > > +                          RAM_RESIZEABLE)) == 0);
> > > +    assert(max_size >= size);
> > >       if (xen_enabled()) {
> > >           error_setg(errp, "-mem-path not supported with Xen");
> > > @@ -1968,12 +1972,14 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
> > >       size = TARGET_PAGE_ALIGN(size);
> > >       size = REAL_HOST_PAGE_ALIGN(size);
> > > +    max_size = TARGET_PAGE_ALIGN(max_size);
> > > +    max_size = REAL_HOST_PAGE_ALIGN(max_size);
> > >       file_size = get_file_size(fd);
> > > -    if (file_size > offset && file_size < (offset + size)) {
> > > +    if (file_size && file_size < offset + max_size && !grow) {
> > 
> > Is this a bugfix for the case offset < fsize?  If so, better make it a
> > small patch and copy stable..
> > 
> > $ touch ramfile
> > $ truncate -s 64M ramfile
> > $ ./qemu-system-x86_64 -object memory-backend-file,mem-path=./ramfile,offset=128M,size=128M,id=mem1,prealloc=on
> > qemu-system-x86_64: qemu_prealloc_mem: preallocating memory failed: Bad address
> > 
> > So yes, it's a bug..
> 
> Yes, it's a bug I noticed by inspection.
> I will split and submit to stable.

Thanks.

> 
> > >           error_setg(errp, "backing store size 0x%" PRIx64
> > >                      " does not match 'size' option 0x" RAM_ADDR_FMT,
> > > -                   file_size, size);
> > > +                   file_size, max_size);
> > >           return NULL;
> > >       }
> > > @@ -1988,11 +1994,13 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
> > >       new_block = g_malloc0(sizeof(*new_block));
> > >       new_block->mr = mr;
> > >       new_block->used_length = size;
> > > -    new_block->max_length = size;
> > > +    new_block->max_length = max_size;
> > > +    new_block->resized = resized;
> > >       new_block->flags = ram_flags;
> > >       new_block->guest_memfd = -1;
> > > -    new_block->host = file_ram_alloc(new_block, size, fd, !file_size, offset,
> > > -                                     errp);
> > > +    new_block->host = file_ram_alloc(new_block, max_size, fd,
> > > +                                     file_size < offset + max_size,
> > 
> > Same here, looks like relevant to above.
> 
> This line would not be part of the fix for stable.  The pre-cpr code should only
> truncate (allocate) if !file_size.  If file_size > 0, the fixed conditional above
> verifies that file_size is large enough.
> 
> The fix will be a 1-liner:
>  -    if (file_size > offset && file_size < (offset + size)) {
>  +    if (file_size && file_size < offset + size) {

Indeed, this should work.

-- 
Peter Xu


