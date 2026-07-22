Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620A7C44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmXPQ-0006LT-GS; Wed, 22 Jul 2026 09:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wmXPM-0006J8-F3
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 09:54:48 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wmXPI-0006S3-Ux
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 09:54:47 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-39ca0a30148so105720081fa.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 06:54:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784728483; cv=none;
 d=google.com; s=arc-20260327;
 b=jY09/etpRGQlJSQIL9cHSBja7vEHDpnDB3pRkdFATQ5s1QiTLEAP61+cm0qxSmdopo
 pFeLxiOHHzN/3l4UKO/c8nS/kpVamlNWTifaXIbuD95NffVilL7K8FuXlLn4YvFMrgpF
 i91+svCcPRVsS/7qM/8Z8fV43zHtkiSEr+NcMc9FkMt7k3Tjk17Iz8k5gARCQsngIBmT
 S8vGB04WlWR62opJ46L+vwJ0z7fmffKxsZQ4VVpAMRHdNsp3li4BNizOtPRwEhIEsNwc
 7FfteBGifqIZg0Ua+IqlIy7lQzSwH1Sh6z58M0kLXq/fNEmqfHvlEthjBLbQM1d1GkNX
 KVZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=T/MsquuuxRB0/iIgK3GMO3gQfmpNDKRa7YRQmDxu/WA=;
 fh=YYFlP8b5nG0xp43ekYQGYSQr9uembBeNxJ16OtaRW/0=;
 b=mjGTGvpnPs/7E3zV+tEwC41zM22P77M4jYjHvF9+bWIvwDlM8tYU44TxGCBtdz3BBI
 jZIg78raQnAKS9LMyZLkroWWFET02h4kECvaL2IN/S5CVIGmuoanVub3LMbAYXLZoWx4
 qyomd3uL6LeRjBynn/nkN+SBBr+gmixjVAArA+bL9uTuPGfqfvrwQN7m5upgzzWtGGIY
 +XMFAYoC5Gb7R6Da4jjnfDvyL2R9Nhl8OWQP1/Mgvau1t3V1vrUD5XEe097oUp6D3TJs
 L1Y7ZCAYBpFQjZqk6zM2YVR1lcQ1HDWf8VAyzP9b9SO+nCJ6fUhKp+3sbHtz8yiQ2sXQ
 ke2g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784728483; x=1785333283; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T/MsquuuxRB0/iIgK3GMO3gQfmpNDKRa7YRQmDxu/WA=;
 b=ook2guZWpYnzZK22z7utwNi8pS2eyGUcUwABGXspW8wJJNLEYybiloXaWLdbjYd5ov
 xMN2T0bsLb0FR+Gqv9GYuo5tIB4NIYiV2WVf1r7sqGEVd+MS4vqkiO7Lro0Dc77FUejq
 q8qGdZhiC6PU4ZBzhYt+RaBbWOnSW5ek86sF96BEPP5bIKL8Wd+fjjpxMKXdrUC1hCPp
 2xFGGEBCYky5phYjXqcqdCrdJx9OWNUPTrqfUIRbv6jL+8CyuEUWBl7napF/HWIOpA6r
 K3pe4PzLpFynHMQiWuNNr3vhjHHMGu/wvT0a5Vv9sYA5MxHZ1YpaBB2HzNSgjEO6nJ+s
 KnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784728483; x=1785333283;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T/MsquuuxRB0/iIgK3GMO3gQfmpNDKRa7YRQmDxu/WA=;
 b=ChyVE6taT02m2ehSAyu1mJyNOcEMyNNkwoCXGcCFqXNC5r6IV2pvcRjOH33hR6IeYx
 LLZT5tzwO2fh7WUoyR1r9Ti8s+u5oohBDNhUcBS/V43MfGuZOk9D+ch3DMIYjZOTT+W4
 HmO8/IVWjbOvDcEf2FfBiL3tgJIFzpbisOytw6aX+Tg+GbiVXoJu0DOqAE/PlDqObDNT
 MAkLq5laL9ARu25SKZViuAaS+JEyDJYY17J3sXnEFZjOCdiZ2nmpeaw0e070Hzyn59NZ
 T7lojhmrmu4afsPnZyQzUeHKFU+EWAF6VPeiJfi/SaaAEVkYMx33xX47zcs5Qo5o1neM
 mPVg==
X-Gm-Message-State: AOJu0YyzP9K6/J2ZjFU7wTzqkDCBuV+1cCqdvvaDAzzT2Mm7GN2XCWG1
 vCW+dvgXazvjiuuNSuLpGG4lxtNx5ldfVNaapjOq2mGBhtqN3oLNWeM6y0F024O3oNzbZL3mZPH
 UoEF5E1k9Fst36xUMpPLRYnLqMH2rHj4=
X-Gm-Gg: AR+sD11/r091J+CkJ7BkvC/66ZybBTjQvAZnHPnu9tWf0pdi4ygPeCmiHplw2eEAQA5
 qioqcqYmz4XXMfYi0i3JjnD7HAtzy6grN5ktGzGsuD4nG53WWEdfPryUL5ZOGg6d3SSZ24lqROo
 bQed+bKdEvKo9Hc39wXrq18kzLY4FDSSm+hQf3/vnxj0O3S6aqGer1OGPxm/7HdP45NF9D94Ipb
 gNW/Pvllxf1yMV54gL+Gk+00ZsXEtrblpZfr2DT4/dq9EcIkM48cqGvNtCh7Fq0ZoHwst1S7nci
 tFi1YSNyg7PE0H59lw==
X-Received: by 2002:a05:651c:1603:b0:38e:d18:4d0 with SMTP id
 38308e7fff4ca-39eb27f1b6bmr48121861fa.13.1784728482638; Wed, 22 Jul 2026
 06:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260714141547.1268000-1-aadeshveer07@gmail.com>
 <20260714141547.1268000-8-aadeshveer07@gmail.com> <al5xOKr1-8e-6iML@x1.local>
In-Reply-To: <al5xOKr1-8e-6iML@x1.local>
From: Aadeshveer Singh <aadeshveer07@gmail.com>
Date: Wed, 22 Jul 2026 19:24:29 +0530
X-Gm-Features: AUfX_mzwNgYVorkgIDeLI5Zh4Ykt6M_6K9Zu4ELhJ0RCGr-mrH2Gj9wUaVtwyGc
Message-ID: <CA++cPvLN_iuchGCD7K45zN3QcjzJ9Z+FktRBMv6ar=Ov271j6g@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] migration: add support for fault thread to load
 pages from disk
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com, 
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com, 
 pierrick.bouvier@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=aadeshveer07@gmail.com; helo=mail-lj1-x234.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URG_BIZ=0.573 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jul 21, 2026 at 12:34=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote=
:
>
> On Tue, Jul 14, 2026 at 07:45:43PM +0530, Aadeshveer Singh wrote:
> > In fast snapshot load, we would like to serve faults as soon as possibl=
e
> > hence loading pages directly instead of requesting a source
> >
> > Add postcopy_mapped_ram_load_page() function which serves single page
> > fault by reading the snapshot file. It uses bitmap_test_and_clear_atomi=
c
> > on pending_bmap to coordinate between threads so each page is loaded
> > exactly once. Non-zero pages are read using qemu_get_buffer_at into a
> > temporary page (for loading page atomically), which is then placed usin=
g
> > postcopy_place_page. Zero pages are placed directly using
> > postcopy_place_page_zero.
> >
> > Update postcopy_ram_fault_thread to call postcopy_mapped_ram_load_page
> > instead of requesting source in case of fast snapshot load. to_src_file
> > check is bypassed in fast snapshot load case as there is no source.
> >
> > Call try_mark_postcopy_blocktime_begin on every page fault to support
> > postcopy-blocktime.
> >
> > Allocate another channel in postcopy_temp_pages_setup(like the preempt
> > case), for both the fault thread and eager thread to load pages
> > independently.
> >
> > Add function ramblock_file_bitmap_page_is_nonzero() which searches a
> > range of bits corresponding to a page for a set bit. This is just a bit
> > check for normal pages but for hugepages it checks the range to see if
> > any part of page is non zero.
> >
> > Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> > ---
> >  migration/postcopy-ram.c | 121 +++++++++++++++++++++++++++++++++------
> >  migration/ram.c          |  11 +++-
> >  migration/ram.h          |   2 +
> >  3 files changed, 116 insertions(+), 18 deletions(-)
> >
> > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > index 2e2c9fae10..723070b5cd 100644
> > --- a/migration/postcopy-ram.c
> > +++ b/migration/postcopy-ram.c
> > @@ -949,6 +949,68 @@ int postcopy_wake_shared(struct PostCopyFD *pcfd,
> >                         pagesize);
> >  }
> >
> > +/**
> > + * postcopy_mapped_ram_load_page() - Load a page to given host address=
.
> > + * @mis: Migration Incoming State.
> > + * @rb: RAMBlock from where page is loaded.
> > + * @rb_offset: Offset of page in RAMBlock.
> > + * @haddr: Base of page where to load in page.
> > + * @channel: Used to identify between threads and use corresponding te=
mp.
> > + * @errp: Set error in case of failure
> > + *
> > + * Load a page from RAMBlock at offset at given host address. Used by =
postcopy
> > + * ram fault thread and eager thread in fast snapshot load case.
> > + *
> > + * Return: True on success.
> > + */
> > +static bool postcopy_mapped_ram_load_page(MigrationIncomingState *mis,
> > +                                          RAMBlock *rb, ram_addr_t rb_=
offset,
> > +                                          uint64_t haddr, int channel,
> > +                                          Error **errp)
> > +{
> > +    void *place_source =3D mis->postcopy_tmp_pages[channel].tmp_huge_p=
age;
> > +    size_t page;
> > +    size_t read;
> > +
> > +    page =3D rb_offset / qemu_ram_pagesize(rb);
> > +
> > +    if (bitmap_test_and_clear_atomic(rb->pending_bmap, page, 1)) {
> > +        if (ramblock_file_bitmap_page_is_nonzero(rb, page)) {
>
> I discussed this part previously I think, but maybe not with details.  Th=
is
> is fine but it is less optimal in two things:
>
> - It relies on the mapped-ram pre-fill all zero pages to be zeros in the
>   image, otherwise if you see a huge page having some but not all non-zer=
o
>   page, it'll fallback to always copy from image, then we start to read
>   data from "zero page" ranges, which we never do before (in vanilla
>   mapped-ram logic, we always skip ranges that represent zero pages).
>
> - It is slightly less efficient, because we need to copy the zeros from t=
he
>   image even if we know they're zeros
>
> IIUC it's better to loop over all guest pages on this specific host page
> when preparing the place_source buffer, then do a one-shot place page.
>
> NOTE: I believe in all paths you touched, you assumed host psize is alway=
s
> >=3D guest psize.  Just to mention it's actually possible to have host ps=
ize
> < guest psize. One case is ARM64 using 4K host psize to emulate 64K guest
> psize.  But that's less of a problem; normally production users rarely us=
e
> such setup, IIUC, so I think we can put it aside for now (however I belie=
ve
> migration core should work with such setup right now in general). But if
> you can take that into account it'll be even better.
>

I agree with the looping over and loading pages into the buffer. That
would be more efficient and would get rid of the assumption I had that
zero ranges in hugepages should always be zero. I will look into how
to generalize this for differences between host and guest page sizes.
That depends on how mapped-ram handles those cases. I might have to
look into that.

> > +            /*
> > +             * This can happen concurrently, but it's thread-safe beca=
use
> > +             * qemu_get_buffer_at() is thread-safe, and the caller wil=
l be using
> > +             * different temporary buffers.
> > +             */
> > +            read =3D qemu_get_buffer_at(mis->from_src_file, place_sour=
ce,
> > +                                      qemu_ram_pagesize(rb),
> > +                                      rb->pages_offset + rb_offset, er=
rp);
> > +
> > +            if (read !=3D qemu_ram_pagesize(rb)) {
> > +                error_prepend(errp, "Could not read page %zu from RAM =
Block %s",
> > +                              page, rb->idstr);
> > +                return false;
> > +            }
> > +
> > +            if (postcopy_place_page(mis, (void *)haddr, place_source, =
rb)) {
> > +                error_setg(errp,
> > +                           "Failed to place page %zu from RAM Block %s=
 at "
> > +                           "address %" PRIu64,
> > +                           page, rb->idstr, haddr);
> > +                return false;
> > +            }
> > +        } else {
> > +            if (postcopy_place_page_zero(mis, (void *)haddr, rb)) {
> > +                error_setg(errp,
> > +                           "Failed to place zero page %zu from RAM Blo=
ck %s at "
> > +                           "address %" PRIu64,
> > +                           page, rb->idstr, haddr);
> > +                return false;
> > +            }
> > +        }
> > +    }
> > +    return true;
> > +}
> > +
> >  /*
> >   * NOTE: @tid is only used when postcopy-blocktime feature is enabled,=
 and
> >   * also optional: when zero is provided, the fault accounting will be =
ignored.
> > @@ -1310,6 +1372,7 @@ static void *postcopy_ram_fault_thread(void *opaq=
ue)
> >      int ret;
> >      size_t index;
> >      RAMBlock *rb =3D NULL;
> > +    Error *local_err =3D NULL;
> >
> >      trace_postcopy_ram_fault_thread_entry();
> >      rcu_register_thread();
> > @@ -1351,11 +1414,13 @@ static void *postcopy_ram_fault_thread(void *op=
aque)
> >              break;
> >          }
> >
> > -        if (!mis->to_src_file) {
> > +        if (!migrate_mapped_ram() && !mis->to_src_file) {
> >              /*
> > -             * Possibly someone tells us that the return path is
> > -             * broken already using the event. We should hold until
> > -             * the channel is rebuilt.
> > +             * Possibly someone tells us that the return path is broke=
n already
> > +             * using the event. We should hold until the channel is re=
built.
> > +             * Fast snapshot load doesn't support pause and recover, b=
ecause
> > +             * it's not necessary: we can fail right away when QEMU ju=
st booted
> > +             * with nothing to lose.
> >               */
> >              postcopy_pause_fault_thread(mis);
> >          }
> > @@ -1418,18 +1483,37 @@ static void *postcopy_ram_fault_thread(void *op=
aque)
> >                                                  qemu_ram_get_idstr(rb)=
,
> >                                                  rb_offset,
> >                                                  msg.arg.pagefault.feat=
.ptid);
> > +
> > +            if (migrate_mapped_ram()) {
> > +                /* Load page directly in case of fast snapshot load */
> > +
> > +                uintptr_t aligned =3D (uintptr_t)ROUND_DOWN(
> > +                    msg.arg.pagefault.address, qemu_ram_pagesize(rb));
> > +
> > +                if (try_mark_postcopy_blocktime_begin(
> > +                        mis, rb, rb_offset, (uintptr_t)aligned,
> > +                        msg.arg.pagefault.feat.ptid)) {
> > +                    if (!postcopy_mapped_ram_load_page(
> > +                            mis, rb, rb_offset, aligned, RAM_CHANNEL_P=
OSTCOPY,
> > +                            &local_err)) {
> > +                        error_report_err(local_err);
> > +                        break;
> > +                    }
> > +                }
> > +            } else {
> >  retry:
> > -            /*
> > -             * Send the request to the source - we want to request one
> > -             * of our host page sizes (which is >=3D TPS)
> > -             */
> > -            ret =3D postcopy_request_page(mis, rb, rb_offset,
> > -                                        msg.arg.pagefault.address,
> > -                                        msg.arg.pagefault.feat.ptid);
> > -            if (ret) {
> > -                /* May be network failure, try to wait for recovery */
> > -                postcopy_pause_fault_thread(mis);
> > -                goto retry;
> > +                /*
> > +                 * Send the request to the source - we want to request=
 one
> > +                 * of our host page sizes (which is >=3D TPS)
> > +                 */
> > +                ret =3D postcopy_request_page(mis, rb, rb_offset,
> > +                                            msg.arg.pagefault.address,
> > +                                            msg.arg.pagefault.feat.pti=
d);
> > +                if (ret) {
> > +                    /* May be network failure, try to wait for recover=
y */
> > +                    postcopy_pause_fault_thread(mis);
> > +                    goto retry;
> > +                }
> >              }
> >          }
> >
> > @@ -1501,8 +1585,11 @@ static int postcopy_temp_pages_setup(MigrationIn=
comingState *mis, Error **errp)
> >      unsigned i, channels;
> >      void *temp_page;
> >
> > -    if (migrate_postcopy_preempt()) {
> > -        /* If preemption enabled, need extra channel for urgent reques=
ts */
> > +    if (migrate_postcopy_preempt() || migrate_mapped_ram()) {
> > +        /*
> > +         * If preemption enabled or it is fast snapshot load, need ext=
ra channel
> > +         * for urgent requests/faults
> > +         */
> >          mis->postcopy_channels =3D RAM_CHANNEL_MAX;
> >      } else {
> >          /* Both precopy/postcopy on the same channel */
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 330fceaa43..4ab8e0e750 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -269,12 +269,21 @@ static void ramblock_pending_bmap_init(void)
> >
> >      RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
> >          assert(!rb->pending_bmap);
> > -        size_t size =3D rb->max_length >> qemu_target_page_bits();
> > +        size_t size =3D rb->max_length / qemu_ram_pagesize(rb);
>
> Oh here is the change..  let's move this to that patch directly (or squas=
h
> three patches).

I think I messed up this change. Moved it to the previous patch for
following version.

>
> Other than that this patch looks good.
>
> Thanks,
>
> >          rb->pending_bmap =3D bitmap_new(size);
> >          bitmap_set(rb->pending_bmap, 0, size);
> >      }
> >  }
> >
> > +bool ramblock_file_bitmap_page_is_nonzero(RAMBlock *rb, uint64_t page_=
idx)
> > +{
> > +    int page_bits =3D qemu_ram_pagesize(rb) / qemu_target_page_size();
> > +    uint64_t bmap_page_start =3D page_idx * page_bits;
> > +    uint64_t bmap_page_end =3D bmap_page_start + page_bits;
> > +    return find_next_bit(rb->file_bmap, bmap_page_end, bmap_page_start=
) !=3D
> > +           bmap_page_end;
> > +}
> > +
> >  static void ramblock_recv_map_init(void)
> >  {
> >      RAMBlock *rb;
> > diff --git a/migration/ram.h b/migration/ram.h
> > index 41697a7599..7e2eac58d3 100644
> > --- a/migration/ram.h
> > +++ b/migration/ram.h
> > @@ -95,6 +95,8 @@ void ram_handle_zero(void *host, uint64_t size);
> >  void ram_transferred_add(uint64_t bytes);
> >  void ram_release_page(const char *rbname, uint64_t offset);
> >
> > +bool ramblock_file_bitmap_page_is_nonzero(RAMBlock *rb, uint64_t page_=
idx);
> > +
> >  int ramblock_recv_bitmap_test(RAMBlock *rb, void *host_addr);
> >  bool ramblock_recv_bitmap_test_byte_offset(RAMBlock *rb, uint64_t byte=
_offset);
> >  void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr);
> > --
> > 2.55.0
> >
>
> --
> Peter Xu
>

