Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0860C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 07:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Qm1-0007Pv-Qw; Thu, 02 May 2024 03:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s2Qlz-0007PC-Mc
 for qemu-devel@nongnu.org; Thu, 02 May 2024 03:22:31 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1s2Qlx-00056X-Gs
 for qemu-devel@nongnu.org; Thu, 02 May 2024 03:22:31 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5709cb80b03so8049363a12.2
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 00:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714634548; x=1715239348; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TBJFJ5wMx1BtKIT2P03my37zyaWn91PkqyxuO5aXPNk=;
 b=MUSCul4j0Qyc9/sl9uKlbA8FaOnBzHRdoFqnwZnvh1g/p1ESIwpSbTeDC3NW/0Qs8m
 SYSf6tQCMsoYofWrxMEyxbEMaKYE4bk84xBFwJSH8/gfDYCsY+A3nT8yl1aX8WkD3ewp
 b5TT9u7OErp+258XvlTRhWftKPH+0JyfasWNe+oSQ/1NkMqCDC6tKiyUO5unSSpGVmiu
 ARf/Mmo6MeEQ5bCNkJsVQDnsSQFaRTmk+bgkYc5ZccSyrdsoT6G8DYYeIcrFe16Pcx49
 BO/CBEqZBqKAzaeVu8SQUNwJ8/6MdNBpPeLsa6wNZXv7xsXSG0qOY3eD1m0dGNR4xt3V
 aKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714634548; x=1715239348;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TBJFJ5wMx1BtKIT2P03my37zyaWn91PkqyxuO5aXPNk=;
 b=HUK5dRThac+yR8bqWV3BAFf0FLXDKa1P0pJcJnl8DPMHPxhi0MqK/CoBhekXbtwImf
 arnHvvXZ8W5KEmQVFG9GDKyFeK+8vZgLfkM4zPGq9cLcNC1X4N4QxpY+Rahu/AYCcGPn
 psjfWgMinki36EfliSu4OhSSjVJ5mEvg98o1DUFM8Kq76YVFpfozZ1Wz6X1Z0NumjVXR
 JV4hxluj4+vrvkyf4K/SPV93aRdfxkc4BCsmeYfgkY2CEbXSdbmqnkGQATjOz6RVMLgO
 cRxdofGEGnU7IY0YBheVjm+qOAvB4welAX4jJkoS7wpNVFwc2YTvXfv/o3KC18oSo68Q
 tdFg==
X-Gm-Message-State: AOJu0YynQdpwQ/J/kbqdGWGFKin2aExDlhWkeTD7koLskzJ4GnL33OEi
 FZj/BLrHniGlVv8+5Ugius8E5/IqPnN200D33fqda5vL/LyVQyZ7PfahRnvblgZrz9ZMQFkMpUH
 n5JRCINzMVoh6XI6kmFxndttSc44=
X-Google-Smtp-Source: AGHT+IHSlb8IZgbXfdiILZJA/hvGebr0LK4P+w6/TsM+AJ6nYP9B3xdfVB6EUd55X8OzdH8lqoW18BT4TFiV4dMG2EU=
X-Received: by 2002:a50:bb26:0:b0:572:4faf:ed68 with SMTP id
 y35-20020a50bb26000000b005724fafed68mr3115003ede.27.1714634547567; Thu, 02
 May 2024 00:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
 <20240430164939.925307-16-edgar.iglesias@gmail.com>
 <alpine.DEB.2.22.394.2405011414320.497719@ubuntu-linux-20-04-desktop>
In-Reply-To: <alpine.DEB.2.22.394.2405011414320.497719@ubuntu-linux-20-04-desktop>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu, 2 May 2024 09:22:15 +0200
Message-ID: <CAJy5ezoQ4Q6kc9T8_P3nEU6N20e6Pvr3K_zuM0j95RcG-hDgfw@mail.gmail.com>
Subject: Re: [PATCH v4 15/17] xen: mapcache: Remove assumption of RAMBlock
 with 0 offset
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org, jgross@suse.com, 
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Anthony Perard <anthony.perard@citrix.com>, 
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ed1-x52f.google.com
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

On Wed, May 1, 2024 at 11:24=E2=80=AFPM Stefano Stabellini
<sstabellini@kernel.org> wrote:
>
> On Tue, 30 Apr 2024, Edgar E. Iglesias wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> >
> > The current mapcache assumes that all memory is mapped
> > in a single RAM MR (the first one with offset 0). Remove
> > this assumption and propagate the offset to the mapcache
> > so it can do reverse mappings (from hostptr -> ram_addr).
> >
> > This is in preparation for adding grant mappings.
> >
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
>
>
> Looking at xen_remap_bucket, it is only using address_index (without
> adding ram_offset) to map foreign memory. From xen_remap_bucket, I would
> understand that address_index already includes the ram_offset.
>
> Meaning that if we want to map foreign mapping at address 0x5000, then
> address_index would be 0x5000, even if ram_offset is 0x1000.
>
> But then looking xen_ram_addr_from_mapcache_single ram_offset is added
> to paddr_index to calculate the physical address. So in that case we
> would want address_index to be 0x4000 and ram_offset to be 0x1000. But
> xen_remap_bucket would have to sum address_index and ram_offset to map
> foreign memory.
>
> So I am a bit confused, did I get it wrong? One more comment below.
>

Thanks Stefano,

I think the confusion is that this ram_addr_offset is not related to
guest address-space.
It's a QEMU internal thing and it shouldn't be included in the address
used to map foreign memory.
The mapcache can treat this ram_addr offset like a cookie that we keep
around to be able to do
reverse mappings from host pointers into ram_addr space
(xen_ram_addr_from_mapcache).

The current mapcache implementation works because we've really only
been using foreign mappings
on RAMBlocks with offset 0. We're also creating RAM's such that the
offset into the RAM is also
the guest physical address, for x86 this is natural since RAM starts
at zero (for lowmem) but for
ARM we're creating larger than needed RAM's (GUEST_RAM0_BASE + ram-size) to
make this assumption true. Anyway, In this series I'm not addressing
this second assumption.

There's a second call in physmem.c to xen_map_cache using the
block->offset as an address.
I was considering removing that second call since I can't see how it can wo=
rk
(except perhaps in some specific use-case by luck?). Anyway, for now
I've left it unmodified.


>
> > ---
> >  hw/xen/xen-mapcache.c         | 25 ++++++++++++++++++-------
> >  include/sysemu/xen-mapcache.h |  2 ++
> >  system/physmem.c              |  8 ++++----
> >  3 files changed, 24 insertions(+), 11 deletions(-)
> >
> > diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> > index 09b5f36d9c..1b32d0c003 100644
> > --- a/hw/xen/xen-mapcache.c
> > +++ b/hw/xen/xen-mapcache.c
> > @@ -43,6 +43,9 @@ typedef struct MapCacheEntry {
> >  #define XEN_MAPCACHE_ENTRY_DUMMY (1 << 0)
> >      uint8_t flags;
> >      hwaddr size;
> > +
> > +    /* Keep ram_addr offset for reverse mappings (hostptr -> ram_addr)=
.  */
> > +    ram_addr_t ram_offset;
> >      struct MapCacheEntry *next;
> >  } MapCacheEntry;
> >
> > @@ -165,7 +168,8 @@ static void xen_remap_bucket(MapCache *mc,
> >                               void *vaddr,
> >                               hwaddr size,
> >                               hwaddr address_index,
> > -                             bool dummy)
> > +                             bool dummy,
> > +                             ram_addr_t ram_offset)
> >  {
> >      uint8_t *vaddr_base;
> >      xen_pfn_t *pfns;
> > @@ -244,6 +248,7 @@ static void xen_remap_bucket(MapCache *mc,
> >      entry->size =3D size;
> >      entry->valid_mapping =3D g_new0(unsigned long,
> >                                    BITS_TO_LONGS(size >> XC_PAGE_SHIFT)=
);
> > +    entry->ram_offset =3D ram_offset;
> >
> >      if (dummy) {
> >          entry->flags |=3D XEN_MAPCACHE_ENTRY_DUMMY;
> > @@ -264,6 +269,7 @@ static void xen_remap_bucket(MapCache *mc,
> >
> >  static uint8_t *xen_map_cache_unlocked(MapCache *mc,
> >                                         hwaddr phys_addr, hwaddr size,
> > +                                       ram_addr_t ram_offset,
> >                                         uint8_t lock, bool dma, bool is=
_write)
> >  {
> >      MapCacheEntry *entry, *pentry =3D NULL,
> > @@ -335,14 +341,16 @@ tryagain:
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
> > @@ -389,13 +397,15 @@ tryagain:
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
> > @@ -432,7 +442,8 @@ static ram_addr_t xen_ram_addr_from_mapcache_single=
(MapCache *mc, void *ptr)
> >          raddr =3D RAM_ADDR_INVALID;
> >      } else {
> >          raddr =3D (reventry->paddr_index << mc->bucket_shift) +
> > -             ((unsigned long) ptr - (unsigned long) entry->vaddr_base)=
;
> > +             ((unsigned long) ptr - (unsigned long) entry->vaddr_base)=
 +
> > +             entry->ram_offset;
> >      }
> >      mapcache_unlock(mc);
> >      return raddr;
> > @@ -627,8 +638,8 @@ static uint8_t *xen_replace_cache_entry_unlocked(Ma=
pCache *mc,
> >
> >      trace_xen_replace_cache_entry_dummy(old_phys_addr, new_phys_addr);
> >
> > -    xen_remap_bucket(mapcache, entry, entry->vaddr_base,
> > -                     cache_size, address_index, false);
> > +    xen_remap_bucket(mc, entry, entry->vaddr_base,
> > +                     cache_size, address_index, false, entry->ram_offs=
et);
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
> > index 1a5ffcba2a..5b16eeccca 100644
> > --- a/system/physmem.c
> > +++ b/system/physmem.c
> > @@ -2228,13 +2228,13 @@ static void *qemu_ram_ptr_length(RAMBlock *bloc=
k, ram_addr_t addr,
> >           * In that case just map the requested area.
> >           */
> >          if (xen_mr_is_memory(block->mr)) {
> > -            return xen_map_cache(block->mr, addr, len, lock, lock,
> > -                                 is_write);
> > +            return xen_map_cache(block->mr, addr, len, block->offset,
> > +                                 lock, lock, is_write);
>
> Have you considered not tracking offset and address separately and
> simply do this?
>
>             return xen_map_cache(block->mr, addr + block->offset, len,
>                                  lock, lock, is_write);
>

Unfortunately this won't work since block->offset is not related to where t=
his
ram is mapped in guest address-space. In the case of grant's, we'd get the
wrong grant ref. See my previous comment.

Cheers,
Edgar


>
> >          }
> >
> >          block->host =3D xen_map_cache(block->mr, block->offset,
> > -                                    block->max_length, 1,
> > -                                    lock, is_write);
> > +                                    block->max_length, 0,
> > +                                    1, lock, is_write);
> >      }
> >
> >      return ramblock_ptr(block, addr);
> > --
> > 2.40.1
> >

