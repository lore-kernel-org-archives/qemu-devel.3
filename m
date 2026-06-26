Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA39CC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 14:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd7gw-0006yP-5R; Fri, 26 Jun 2026 10:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wd7gp-0006xx-6G
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 10:37:55 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wd7gn-0000a5-D1
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 10:37:54 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6a0ddedcd00so423150eaf.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 07:37:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782484672; cv=none;
 d=google.com; s=arc-20260327;
 b=oAGsAdFWzQegrhbqafvMo+ORI1x6+oQEj5rh23qjhGCyL5pNP5Sz28NcN+Pohuayh7
 /c2PEo9En6jnv5552VU5DpOZyzMAZHbGH3CQpwUdmys8Kw1OSwex94oU15eBBEdpRVVI
 m4NBI+xCZXQD7+ITdMZNj22UCR9fLFMcLy07oHcnLS4/0YW7PEY8/vtHj/E2gLXrAL9L
 uTNjj31US627ZtaTGd0JQVR+Yqxcctl33oK/CENe4kJNMnfD3IllH/xkEfQQzUWIxRHi
 g+EbjZcvcTqEdTXdBB2sMXjERVXifJtK31fnhSIHMSPAJS3gxeMjyvdfMgXCvVjiZHj8
 cbmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BOTY6fZjRlF8un3qj+KD0CYp8+F9w3+UGj0pmLa7LPw=;
 fh=M53F9OyMyXaprNYz5ycy0QOslAkZgr8cpZk3PVQ0YK0=;
 b=sIznhECk4SByphL21lr1LTxldOHKClklXjZOJJbfQJJomhGkYjB6Bv4PvHpV6QQefL
 OlF5cR8+wCyJOM7FBz0RYMdsDhOW6T7ZP9Sst6P67mTuCzRT5w4QtjAzYRkaQXW/LDdF
 O943hDmI5QUH9gfrx1RatStuLF7b5/tyP1rZOluAVw12BA1KFekXIXOFFQssERvS9eQb
 JuA/stGJ9euhqoxVyOKDxwMF1i7Pxc6qlZKHcI9h1D5BzB7MwHxCk3HDKFqsrEjFkanF
 U5LX40vNNnAsaNfXWqcwhf7CNlenrX3ZOZGSamVbT1egHUGa70s0k+DplTPdyIYLsyL8
 jmKQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782484672; x=1783089472; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BOTY6fZjRlF8un3qj+KD0CYp8+F9w3+UGj0pmLa7LPw=;
 b=V1IOn+k8su4M03cxhiuCvk5f2ebND1XkGB1Binger6+THjTpCM4sPwgAKoBz1nGInW
 AdKakWFZh5vQOutiRdkyU3YVarqDQwp8iSoydACHDbTOv3j4cKIXs8b8InQWSwQ5yUnM
 WMgqfW14ZzsC7wy+UqYBgVKqGADMJdIXWuLZge/WPlZN7cunZLFYogknMOjA1CLcqSh2
 dHKSRZHtYAW2wDD/ImiWwU1+JYcKdLZsHT+uZKfwQ/Airzc3n5FjqQbQyrg2Z8ShYKRB
 1/mTfOuA2/mKLmwFUNrvE2DWUNF5hAVfQgYMYld66l3o5OehxHuwrvgx1a6as11IKaDQ
 b27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782484672; x=1783089472;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BOTY6fZjRlF8un3qj+KD0CYp8+F9w3+UGj0pmLa7LPw=;
 b=eRXWmcEPR2EyyI8710+wnA5YA999uExEl1fO0fVFe6lFub2e/SKUE4f91Z8inoNAcd
 VKW5T0k1oFvoTnCTc+1oSxo25c+nhpG5W+dvn2gj9Z3dkBWVHWb6J0J4guEJabThvI4g
 LK8Ot2KsVSYkThwKe1e7rE9ciyHQBJgcjuuC5m1TqaJvZj4chX0J+gC+Kz7up3p43Qa7
 nnlg8AJ32JFK+BUhdYZCwabVyjkkcf7QK1bZb9eoXEfqj5dO1cO+sCHyHIsH5IR/cvzR
 9thb9dOgVIvoluWPMkgRdQzbMxg7enLUBO8REQL8X9CBMN9Hzb+8FxLr2dNoLABhq3tw
 AsZg==
X-Gm-Message-State: AOJu0YymGvfhHHPp45wjAxXVM9ZkF097ne9l2J/k/iPJ20HiF6NryNe6
 j9M5nD7w/fpryBeH5/MALWEaNfoF5HnE81+dXuzVhr6/WIczVdFALxtlRywBRgHPSKL7LoZeHUx
 4vERA2ksOVu5b9YRi8MNlFMn83Gjzowg=
X-Gm-Gg: AfdE7clj7bmxicZYtsjQCHjoj8LmP8e8FCHOpB6sQAPXq9gQXQCTfVhkDqJWJr5dqvI
 MSPPd3LGgHn7FB/IbGNoRGYJKQhjOg/9hVpiEFYaiAW3XK5u/vDhhKh8rRVHDnKBbjMfgvNcC/t
 O3QRlw4XUYBvDNoXiu+f6sg+jotDPliK0nbTFEZPKDvKQpFt8Hanc8mygCeSejqm5Bd5f2Zc3T9
 L5tTnqJ25fwKxfMy8qbbsD7ElG2aSUwe0LjxoQ9Ph7xKroOg7k8uiHHvnRjAews1h8gqRO7NnLp
 trj1rYtmkrhLp0WbqcfOS0ZmBuk=
X-Received: by 2002:a05:6820:1625:b0:696:8325:f7f5 with SMTP id
 006d021491bc7-6a13514d844mr5506700eaf.4.1782484672064; Fri, 26 Jun 2026
 07:37:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260618032010.88755-1-aadeshveer07@gmail.com>
 <20260618032010.88755-3-aadeshveer07@gmail.com> <874iisoviy.fsf@suse.de>
In-Reply-To: <874iisoviy.fsf@suse.de>
From: Aadeshveer Singh <aadeshveer07@gmail.com>
Date: Fri, 26 Jun 2026 20:07:37 +0530
X-Gm-Features: AVVi8Cd_SdlamvznCkbz5ufjJDzDQ0W1bBJXY4ut-CWJK4kz0i0C13IvsnSJLso
Message-ID: <CA++cPvLFggctBwO=KLY-dFWVy6Y4FoqjqWnf4P5Pto-2Oza+gw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] migration: add support for fault thread to load
 pages from disk
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, pbonzini@redhat.com, 
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=aadeshveer07@gmail.com; helo=mail-oo1-xc2f.google.com
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

On Wed, Jun 24, 2026 at 8:06=E2=80=AFPM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> Aadeshveer Singh <aadeshveer07@gmail.com> writes:
>
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
> > check is bypassed in fast snapshot load case as there is no source
> >
> > Allocate another channel in postcopy_temp_pages_setup(like the preempt
> > case), for both the fault thread and eager thread to load pages
> > independently.
> >
> > In case of failure to read required page crash the system using assert
> > as disk failure is critical and VM cannot be recovered.
> >
> > Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> > ---
> >  migration/postcopy-ram.c | 92 ++++++++++++++++++++++++++++++++--------
> >  1 file changed, 75 insertions(+), 17 deletions(-)
> >
> > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > index f5ef93f193..1ec20a07dd 100644
> > --- a/migration/postcopy-ram.c
> > +++ b/migration/postcopy-ram.c
> > @@ -949,6 +949,53 @@ int postcopy_wake_shared(struct PostCopyFD *pcfd,
> >                         pagesize);
> >  }
> >
> > +/*
> > + * Load a page from RAMBlock at offset at given host address.
> > + * Used by postcopy ram fault thread and eager thread in fast snapshot=
 load
> > + * case. rb_offset: Offset of page in RAMBlock haddr: Base of page whe=
re to load
> > + * in page Channel: Used to identify between threads and use correspon=
ding temp
> > + * pages Returns 0 on success
> > + */
> > +static int postcopy_mapped_ram_load_page(MigrationIncomingState *mis,
> > +                                         RAMBlock *rb, ram_addr_t rb_o=
ffset,
> > +                                         uint64_t haddr, int channel)
> > +{
> > +    int ret =3D 0;
> > +    unsigned long page;
> > +    void *host =3D (void *)haddr;
> > +    void *place_source =3D mis->postcopy_tmp_pages[channel].tmp_huge_p=
age;
> > +    size_t read;
> > +
> > +    page =3D rb_offset >> TARGET_PAGE_BITS;
> > +
> > +    if (bitmap_test_and_clear_atomic(rb->pending_bmap, page, 1)) {
> > +        if (test_bit(page, rb->nonzeropages)) {
> > +            /*
> > +             * qemu_get_buffer_at uses preadv which is thread safe we =
do not
> > +             * need different channels
> > +             */
> > +            read =3D qemu_get_buffer_at(mis->from_src_file, place_sour=
ce,
> > +                                      TARGET_PAGE_SIZE,
> > +                                      rb->pages_offset + rb_offset);
> > +
> > +            g_assert(read =3D=3D TARGET_PAGE_SIZE);
> > +
> > +            ret =3D postcopy_place_page(mis, host, place_source, rb);
> > +            if (ret) {
> > +                return ret;
> > +            }
> > +
> > +        } else {
> > +            /* zero page */
> > +            ret =3D postcopy_place_page_zero(mis, host, rb);
> > +            if (ret) {
> > +                return ret;
> > +            }
> > +        }
> > +    }
> > +    return ret;
> > +}
> > +
> >  /*
> >   * NOTE: @tid is only used when postcopy-blocktime feature is enabled,=
 and
> >   * also optional: when zero is provided, the fault accounting will be =
ignored.
> > @@ -1320,11 +1367,11 @@ static void *postcopy_ram_fault_thread(void *op=
aque)
> >              break;
> >          }
> >
> > -        if (!mis->to_src_file) {
> > +        if (!migrate_fast_snapshot_load() && !mis->to_src_file) {
> >              /*
> > -             * Possibly someone tells us that the return path is
> > -             * broken already using the event. We should hold until
> > -             * the channel is rebuilt.
> > +             * Fast snapshot load has no to src file or in other case =
someone
> > +             * possibly tells us that the return path is broken alread=
y using
> > +             * the event. We should hold until the channel is rebuilt.
> >               */
> >              postcopy_pause_fault_thread(mis);
> >          }
> > @@ -1387,18 +1434,26 @@ static void *postcopy_ram_fault_thread(void *op=
aque)
> >                                                  qemu_ram_get_idstr(rb)=
,
> >                                                  rb_offset,
> >                                                  msg.arg.pagefault.feat=
.ptid);
> > +
> > +            if (migrate_fast_snapshot_load()) {
>
> You probably want to check mapped_ram here instead as this is already
> under the postcopy path.
>
> I haven't reviewed the entire series yet, but I'm questioning whether we
> need the new term (fast snapshot) at all.

You are right. I initially introduced the migrate_fast_snapshot_load()
wrapper to improve readability, as checking multiple capabilities
might make it non-trivial for someone new to the codebase to
understand.

However, I agree that introducing a new wrapper unnecessarily
complicates capabilities. Adding comments around these checks will
achieve that same readability without increasing the API footprint.

I will drop the custom wrapper and consolidate the checks for v2.

>
> > +                if (postcopy_mapped_ram_load_page(
> > +                        mis, rb, rb_offset, msg.arg.pagefault.address,=
 1)) {
> > +                    break;
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
> > @@ -1471,8 +1526,11 @@ static int postcopy_temp_pages_setup(MigrationIn=
comingState *mis)
> >      unsigned i, channels;
> >      void *temp_page;
> >
> > -    if (migrate_postcopy_preempt()) {
> > -        /* If preemption enabled, need extra channel for urgent reques=
ts */
> > +    if (migrate_postcopy_preempt() || migrate_fast_snapshot_load()) {
> > +        /*
> > +         * If preemption enabled or it is fast snapshot load, need ext=
ra channel
> > +         * for urgent requests/faults
> > +         */
> >          mis->postcopy_channels =3D RAM_CHANNEL_MAX;
> >      } else {
> >          /* Both precopy/postcopy on the same channel */

