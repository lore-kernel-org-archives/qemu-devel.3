Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06083C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 12:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7a29-0004uN-O2; Thu, 16 May 2024 08:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s7a23-0004qr-3Q
 for qemu-devel@nongnu.org; Thu, 16 May 2024 08:16:25 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s7a1z-0007iK-Ox
 for qemu-devel@nongnu.org; Thu, 16 May 2024 08:16:22 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-573061776e8so3264744a12.1
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 05:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715861775; x=1716466575; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yn+oXlbgVr7a9k+BINSVHmajhWBEJ0sHm25nDF+ijag=;
 b=M36WEMwFV/xrV1BT29+N0TrIdPBXMZhz8V1/1yjmUd1JHPRMOwCPr7zLAuCgUZrdqG
 U/Ahw8hrVod5Chsa4K6b4h5ZZ2XeIRN6dtSZBFqQEvK1+kg8lFJQvbgIVfdXBQQlhu4D
 r6XB+vIDSaiBcVGoLCHN4kQEpt68GLup6MgLuvmfGtZNzgi6FoKtb+NyknQYhLKp2W07
 3FJH6nFdIyRsPBrtZRvt2hDf574jUTTCfiSVMroAywZGsujnR5sTHqaQuBpphGjOlAyJ
 CMnS5MxPwkuRizVQ6T75Vjhj9RJRrq3m20tVACEZAkyyDzNAMUEVLz0T0ZHKruTkGlAF
 hlug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715861775; x=1716466575;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yn+oXlbgVr7a9k+BINSVHmajhWBEJ0sHm25nDF+ijag=;
 b=RKIGvchskjCg3QI/so06o3jGu5ozGqlj1sAFgnTGiK5FfxPOm06p+wSZsfYx7sGWKo
 aGu/VZX/LK7JkhytA/KjFAuk6GjdIEp5+IdJmkwpDsNGg0okWev2yKuV0JbNV6lZnzCE
 MpqSkyqmeHKOLb9DPtxnNSVOEp0cqWcRb7rGgrX/uH7+KRA2XaVkrcr/wjWWcQMs/xJh
 TAqUaKPsUSB/cJeneOCLtZlZRHKv5+qPR/T5CBXPdvtRDxnGAjO77G8GfMsczwIjlH+D
 egDqLVqr7hETKVpUD9u7P+ymcq3ZsVOX5uJN2eB/Vg6Cn4/nBES9Q1H2tZt0BElwhSwT
 0hrA==
X-Gm-Message-State: AOJu0YzRqwOEoacXJKjgALOeYKXb8f6yx5IEStjkXnOnZrbsDBkrz1xc
 9unmFwaDsbrQLR0yMYTxWSD86a8mHdbmnXVLPf964TQ4JBVJ9NawMcjfhisBeQNunzdyhhQPcdf
 8LAj7sSb6X9jics0GsboCZw8gLHo=
X-Google-Smtp-Source: AGHT+IFnT5fCN2Q3WSyadS6/AHfALVLYnoDOnQyI+y3w4CmbQMi4Z9f5oXw7pPPeYA3fC3u8vr/OEv8Pt+tb1RiaPk8=
X-Received: by 2002:a50:d496:0:b0:572:3bcc:8370 with SMTP id
 4fb4d7f45d1cf-5734d4417b4mr11339654a12.0.1715861774886; Thu, 16 May 2024
 05:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240503014449.1046238-1-edgar.iglesias@gmail.com>
 <20240503014449.1046238-7-edgar.iglesias@gmail.com>
 <alpine.DEB.2.22.394.2405151605550.2544314@ubuntu-linux-20-04-desktop>
In-Reply-To: <alpine.DEB.2.22.394.2405151605550.2544314@ubuntu-linux-20-04-desktop>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu, 16 May 2024 14:16:03 +0200
Message-ID: <CAJy5ezoB+MZDhPN0iWcTTTy_ufdVwK1qOpU-5M4aJ+Ujfv9TQg@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] xen: mapcache: Pass the ram_addr offset to
 xen_map_cache()
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, jgross@suse.com, 
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Anthony PERARD <anthony@xenproject.org>, 
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, May 16, 2024 at 1:08=E2=80=AFAM Stefano Stabellini
<sstabellini@kernel.org> wrote:
>
> On Fri, 3 May 2024, Edgar E. Iglesias wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> >
> > Pass the ram_addr offset to xen_map_cache.
> > This is in preparation for adding grant mappings that need
> > to compute the address within the RAMBlock.
> >
> > No functional changes.
> >
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> > ---
> >  hw/xen/xen-mapcache.c         | 16 +++++++++++-----
> >  include/sysemu/xen-mapcache.h |  2 ++
> >  system/physmem.c              |  9 +++++----
> >  3 files changed, 18 insertions(+), 9 deletions(-)
> >
> > diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> > index ec95445696..26bc38a9e3 100644
> > --- a/hw/xen/xen-mapcache.c
> > +++ b/hw/xen/xen-mapcache.c
> > @@ -167,7 +167,8 @@ static void xen_remap_bucket(MapCache *mc,
> >                               void *vaddr,
> >                               hwaddr size,
> >                               hwaddr address_index,
> > -                             bool dummy)
> > +                             bool dummy,
> > +                             ram_addr_t ram_offset)
> >  {
> >      uint8_t *vaddr_base;
> >      xen_pfn_t *pfns;
> > @@ -266,6 +267,7 @@ static void xen_remap_bucket(MapCache *mc,
> >
> >  static uint8_t *xen_map_cache_unlocked(MapCache *mc,
> >                                         hwaddr phys_addr, hwaddr size,
> > +                                       ram_addr_t ram_offset,
> >                                         uint8_t lock, bool dma, bool is=
_write)
> >  {
> >      MapCacheEntry *entry, *pentry =3D NULL,
> > @@ -337,14 +339,16 @@ tryagain:
> >      if (!entry) {
> >          entry =3D g_new0(MapCacheEntry, 1);
> >          pentry->next =3D entry;
> > -        xen_remap_bucket(mc, entry, NULL, cache_size, address_index, d=
ummy);
> > +        xen_remap_bucket(mc, entry, NULL, cache_size, address_index, d=
ummy,
> > +                         ram_offset);
> >      } else if (!entry->lock) {
> >          if (!entry->vaddr_base || entry->paddr_index !=3D address_inde=
x ||
> >                  entry->size !=3D cache_size ||
> >                  !test_bits(address_offset >> XC_PAGE_SHIFT,
> >                      test_bit_size >> XC_PAGE_SHIFT,
> >                      entry->valid_mapping)) {
> > -            xen_remap_bucket(mc, entry, NULL, cache_size, address_inde=
x, dummy);
> > +            xen_remap_bucket(mc, entry, NULL, cache_size, address_inde=
x, dummy,
> > +                             ram_offset);
> >          }
> >      }
> >
> > @@ -391,13 +395,15 @@ tryagain:
> >
> >  uint8_t *xen_map_cache(MemoryRegion *mr,
> >                         hwaddr phys_addr, hwaddr size,
> > +                       ram_addr_t ram_addr_offset,
> >                         uint8_t lock, bool dma,
> >                         bool is_write)
> >  {
> >      uint8_t *p;
> >
> >      mapcache_lock(mapcache);
> > -    p =3D xen_map_cache_unlocked(mapcache, phys_addr, size, lock, dma,=
 is_write);
> > +    p =3D xen_map_cache_unlocked(mapcache, phys_addr, size, ram_addr_o=
ffset,
> > +                               lock, dma, is_write);
> >      mapcache_unlock(mapcache);
> >      return p;
> >  }
> > @@ -632,7 +638,7 @@ static uint8_t *xen_replace_cache_entry_unlocked(Ma=
pCache *mc,
> >      trace_xen_replace_cache_entry_dummy(old_phys_addr, new_phys_addr);
> >
> >      xen_remap_bucket(mc, entry, entry->vaddr_base,
> > -                     cache_size, address_index, false);
> > +                     cache_size, address_index, false, new_phys_addr);
>
> Everything else makes sense, but I don't understand how can it be that
> new_phys_addr is the block->offset here?
>

Agreed, this should be old_phys_addr propagated via phys_offset from
xen_add_to_physmap().
The reason this didn't have an effect here is that we currently only
use the ram_addr offset for grants,
and xen_replace_cache_entry is never called for grants. Anyway, I'll
fix this in the next version!




>
> >      if (!test_bits(address_offset >> XC_PAGE_SHIFT,
> >                  test_bit_size >> XC_PAGE_SHIFT,
> >                  entry->valid_mapping)) {
> > diff --git a/include/sysemu/xen-mapcache.h b/include/sysemu/xen-mapcach=
e.h
> > index 1ec9e66752..b5e3ea1bc0 100644
> > --- a/include/sysemu/xen-mapcache.h
> > +++ b/include/sysemu/xen-mapcache.h
> > @@ -19,6 +19,7 @@ typedef hwaddr (*phys_offset_to_gaddr_t)(hwaddr phys_=
offset,
> >  void xen_map_cache_init(phys_offset_to_gaddr_t f,
> >                          void *opaque);
> >  uint8_t *xen_map_cache(MemoryRegion *mr, hwaddr phys_addr, hwaddr size=
,
> > +                       ram_addr_t ram_addr_offset,
> >                         uint8_t lock, bool dma,
> >                         bool is_write);
> >  ram_addr_t xen_ram_addr_from_mapcache(void *ptr);
> > @@ -37,6 +38,7 @@ static inline void xen_map_cache_init(phys_offset_to_=
gaddr_t f,
> >  static inline uint8_t *xen_map_cache(MemoryRegion *mr,
> >                                       hwaddr phys_addr,
> >                                       hwaddr size,
> > +                                     ram_addr_t ram_addr_offset,
> >                                       uint8_t lock,
> >                                       bool dma,
> >                                       bool is_write)
> > diff --git a/system/physmem.c b/system/physmem.c
> > index b7847db1a2..33d09f7571 100644
> > --- a/system/physmem.c
> > +++ b/system/physmem.c
> > @@ -2231,13 +2231,14 @@ static void *qemu_ram_ptr_length(RAMBlock *bloc=
k, ram_addr_t addr,
> >           */
> >          if (xen_mr_is_memory(block->mr)) {
> >              return xen_map_cache(block->mr, block->offset + addr,
> > -                                 len, lock, lock,
> > -                                 is_write);
> > +                                 len, block->offset,
> > +                                 lock, lock, is_write);
> >          }
> >
> >          block->host =3D xen_map_cache(block->mr, block->offset,
> > -                                    block->max_length, 1,
> > -                                    lock, is_write);
> > +                                    block->max_length,
> > +                                    block->offset,
> > +                                    1, lock, is_write);
> >      }
>
> This is OK but it is really making it clear that there is a mistake in
> the code. OK for now but it is something to fix in the future.
>
>
> >      return ramblock_ptr(block, addr);
> > --
> > 2.40.1
> >

