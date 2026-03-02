Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A3EEB3632
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 20:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx9lu-0005xG-Vp; Mon, 02 Mar 2026 15:21:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vx9ls-0005x3-9y
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 15:21:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vx9lq-0000lI-9s
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 15:21:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772482896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wj9BEcUxrRlAnufo8uO3U0vjxTDQxgGRX5+Ab4Wwu6Q=;
 b=PStmr/dDoKJ7Lgdj9I1O80LJvjvAwivvEbCyFKGBMVB1roEyI3eySUQ7GZkDo8DC/weaoy
 eabnrIjPLedS2wNtIum3tqj04x5ZEVVG7eMtuAQ6TQFZWNOe6KYPASp4cxU+lYQSEh678A
 g5DsCCcOjr3r7+HucZqQzdLfGlQyrFQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-8TRY3fNYNyW9nkdUxYiiqw-1; Mon, 02 Mar 2026 15:21:35 -0500
X-MC-Unique: 8TRY3fNYNyW9nkdUxYiiqw-1
X-Mimecast-MFC-AGG-ID: 8TRY3fNYNyW9nkdUxYiiqw_1772482895
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-506bfa0441aso779768081cf.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 12:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772482894; x=1773087694; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Wj9BEcUxrRlAnufo8uO3U0vjxTDQxgGRX5+Ab4Wwu6Q=;
 b=JAPFJlzePQPNrWH1CLB3hsEE8AKvUdzl6ljjFDLIB2F+P00N0epmT3L3zlnV8tJn7L
 KWFqq6aLzph/xBJNW0I5tixoU73a7wN5NjKQ+RsOzjTP7Ir6nRo05DHzKUajfRAbf8DK
 HefxlOuQxVSTFGTUZApKGqn26pJ3yg6RKVV3yo8IU/AYnURVpI7f+/BMQPlUyTGFpkqE
 F7sPluqQzPUFJUH+dStQJ0Aeyvp+B6AdUhqE1txLi+tSuEEjAtKdJ40rdlkC3JI1T/OD
 EMTrLoVcBrDVmnldqmgjT127hBaO+affU+ojbI/dPhNlS/neC/BdY/B4ODaNS1N4mGch
 H9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772482894; x=1773087694;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wj9BEcUxrRlAnufo8uO3U0vjxTDQxgGRX5+Ab4Wwu6Q=;
 b=HcYNp09qnYopQKLvaJ4WL1cBS9/crbVnl76kTxYiWJ2BpnrNMfsJd3T1/HaVsgMU2V
 RFj8fRfp3ZSoo0RDGpFPfTVp/l3adrsqP+w7Zs7w67tDJUHHuxqnA1ZpMHtQ6B/PjpbF
 iHztM+d7TwjuO/B/06673RH+Mqx3cv+fkcTbCXDfNl8YmdKvOq+mk2TmH2EEx2r0NW5I
 dsajtbBcDzhgva8O6JQbD1CnoBrYqLCskiF/O4LSkR2GNiNagL5dSjQSy4hGHPfE6JRr
 Z88ztgCDS2wgI5hgmi/zGdpNt9Ls+R5kZHhyvZkItgEjMc7RaaJShjcerdxQJFd3izUF
 uAHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZOiclNRN3QxydyqzdaiZqBrl5mPToDhWqAl8V9JlrI/NOC0HgALjG0talDMoef5PUjDeuG1sr1NVU@nongnu.org
X-Gm-Message-State: AOJu0YyegZ4gSU7TR+a6PG9YhKMYjJ7fxbe7Wl0J+VZSrdIw0GTyVc3e
 sxpXJpG29BM9KCjeMI85aX+qJsjBd1mWh683NOz3N5cTtSYL6w5L3Ou4uszChXldCEdnpTnwGGd
 U5BrhuiYssSMEOG+e69+rIAk5FjeyYwcW8RCb9mtUiz3pYjuVlY8OGbTqtK0O+Rxu
X-Gm-Gg: ATEYQzxMH4Ncg5Ow+6hUnMZAcAC9IBJXzLuEOxY9U6wV1xYpjMylMayWXfzK66zeJsB
 BrWnNAE3WfMplIvnCa0cJtVh2ZXimWjkEwVUnhXQRVw6mU7banLvaieMJlG46BJNDIHIuRdwZKO
 8tERQJtkbR7yAKie89o5xOHcLrdTzB7cw4Y9OLL3Luon31OheHTUhirDwzR5qBA/IBEwYDL8f6M
 sX6Td/jKFS5E/cgIKfATekGyf8nZCRF9Kjp8+HcPv8jVCA1X8r3KukvLG237gdz48z87Tdbp7ON
 L5jbdzBya6e1FTXt9AAT35Mkbr/Wq0C71+ZFuNLdy9LSSWPX3NUKUbt8wtoOP03Lvw+jUA/KbQx
 xmYqTCUDhJGTB/UtMzYrecv6GpkAzmAbaIi7ZyXdaNFCH8T0mkZvIkEPFvyvomuL1vXwFLQ+FCc
 Mk5yKClw==
X-Received: by 2002:ac8:5d56:0:b0:502:a06a:fe5a with SMTP id
 d75a77b69052e-5075288e50cmr196520071cf.51.1772482894130; 
 Mon, 02 Mar 2026 12:21:34 -0800 (PST)
X-Received: by 2002:ac8:5d56:0:b0:502:a06a:fe5a with SMTP id
 d75a77b69052e-5075288e50cmr196519681cf.51.1772482893533; 
 Mon, 02 Mar 2026 12:21:33 -0800 (PST)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd4c992277sm68254685a.25.2026.03.02.12.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 12:21:32 -0800 (PST)
Date: Mon, 2 Mar 2026 15:21:31 -0500
From: Peter Xu <peterx@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 0/8] memory: Remove most _nomigrate variants
Message-ID: <aaXxS0zdMKMoyjvA@x1.local>
References: <cover.1770253186.git.balaton@eik.bme.hu>
 <aZ3CQw2ad5cVc-Mm@x1.local>
 <c8a789fa-8d16-709d-eb3f-8acd6c1d08e8@eik.bme.hu>
 <aZ8jmaB-zuBSoQXH@x1.local>
 <997bf152-3982-490b-8450-06095ffad22b@rsg.ci.i.u-tokyo.ac.jp>
 <01f28121-0306-39e9-6526-fef766388eab@eik.bme.hu>
 <0c750924-95a1-4fc8-ab7c-93ca19b791dc@rsg.ci.i.u-tokyo.ac.jp>
 <b09d2e8a-3b64-e537-b9e0-8037e2855fdc@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b09d2e8a-3b64-e537-b9e0-8037e2855fdc@eik.bme.hu>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Mar 02, 2026 at 04:20:10PM +0100, BALATON Zoltan wrote:
> On Mon, 2 Mar 2026, Akihiko Odaki wrote:
> > On 2026/03/02 21:26, BALATON Zoltan wrote:
> > > On Mon, 2 Mar 2026, Akihiko Odaki wrote:
> > > > On 2026/02/26 1:30, Peter Xu wrote:
> > > > > On Tue, Feb 24, 2026 at 06:44:58PM +0100, BALATON Zoltan wrote:
> > > > > > On Tue, 24 Feb 2026, Peter Xu wrote:
> > > > > > > On Thu, Feb 05, 2026 at 02:13:18AM +0100, BALATON Zoltan wrote:
> > > > > > > > v4:
> > > > > > > > - separate patch converting Sun machines from
> > > > > > > > memory_region_init_ram_nomigrate
> > > > > > > > - split helper to init ram into two functions:
> > > > > > > > setup and error_propagate
> > > > > > > > - also use memory_region_init_io in memory_region_init_ram_device_ptr
> > > > > > > > 
> > > > > > > > v3:
> > > > > > > > - rebased on master after some patches were merged
> > > > > > > > - drop some more line from memory-region-housekeeping.cocci
> > > > > > > > - added comment to explain what factored out helper does
> > > > > > > > - some more clean ups included
> > > > > > > > 
> > > > > > > > BALATON Zoltan (8):
> > > > > > > >    hw/display/{cg3,tcx}: Do not use memory_region_init_rom_nomigrate()
> > > > > > > >    memory: Remove memory_region_init_rom_nomigrate()
> > > > > > > >    sun4m,sun4u,tcx: Do not use memory_region_init_ram_nomigrate()
> > > > > > > >    memory: Remove memory_region_init_ram_nomigrate()
> > > > > > > 
> > > > > > > Could you help explain why we need to remove the
> > > > > > > above two small helpers?
> > > > > > 
> > > > > > Ideally we should remove all of the nomigrate variants as there are only
> > > > > > about 3 uses left, everything else is already moved to
> > > > > > the init_{ram,rom}
> > > > > > variants that register the memory region for migration.
> > > > > > The is probably one
> > > > > > legitimate use that is served by memory_region_init_flags_nomigrate and
> > > > > > other 3 uses are the xtfpga which I think is just old code and does not
> > > > > > support migration so it will be converted in the second series to
> > > > > > memory_region_new as the maintainers did not say anyting to that so far.
> > > > > > Then there's one in hw/display/vga but that's gated
> > > > > > behind a compatibility
> > > > > > switch that's only set in 2.12 (global-vmstate=true) and
> > > > > > earlier. This is
> > > > > > not active any more but cannot yet be removed as there
> > > > > > are eariler compat
> > > > > > props still need cleaning up but the last visible
> > > > > > machine version is 5.1 now
> > > > > > so this is long deprecated and not used. And there are
> > > > > > these Sun machines
> > > > > > that I've converted in the first version but Mark said
> > > > > > he'd like to keep the
> > > > > > current behaviour until it's the last user left. See:
> > > > > > https://
> > > > > > patchew.org/QEMU/cover.1769703287.git.balaton@eik.bme.hu/ b530cf54609b853c6b34306fd4aa3ce2f8087d05.1769703287.git.balaton@eik.bme.hu/
> > > > > > 
> > > > > > > Not saying that we can't remove them, but I don't yet see the point of
> > > > > > > open-code those readonly=true setup either, or any
> > > > > > > problem with having the
> > > > > > > smaller helpers when ram_flags=0.  Small helpers
> > > > > > > sometimes help readability.
> > > > > > > 
> > > > > > > Some of them are going backwards againist what the cocci scripts were
> > > > > > > suggesting previously, like:
> > > > > > > 
> > > > > > > - memory_region_init_ram_nomigrate(E1, E2, E3, E4, E5);
> > > > > > > + memory_region_init_rom_nomigrate(E1, E2, E3, E4, E5);
> > > > > > >   ... WHEN != E1
> > > > > > > - memory_region_set_readonly(E1, true);
> > > > > > > 
> > > > > > > So you suggest open-code instead.  Why?
> > > > > > 
> > > > > > This is temporary until the usage in vga is gone with
> > > > > > hw_compat_2_12 then
> > > > > > the Sun machines will be the last users so they can also be converted to
> > > > > > init_{ram,rom} (unless Mark changes his mind and agrees
> > > > > > changing these now
> > > > > > as was in the first version).
> > > > > > 
> > > > > > > Is it required for your follow up cleanups?
> > > > > > 
> > > > > > It makes those simpler as then we don't need to add memory_region_new
> > > > > > variants for the nomigrate versions that we would remove later anyway.
> > > > > 
> > > > > Personally I don't see the memory_region_new() whole thing solid yet, but
> > > > > still during review.  I shared my thoughts.  So far, I'm not fully
> > > > > convinced, but I also don't have the full picture to say no, either.  We
> > > > > can wait for others to chime in with more thoughts.
> > > > > 
> > > > > For this series, I would prefer if we can discuss it separately from the
> > > > > other work.
> > > > > 
> > > > > Removing _nomigrate() variances makes sense to me in general, it means we
> > > > > want to by default suggest new devices only use RAM regions that is
> > > > > migratable, with proper owner device specified along with
> > > > > the ramblock name
> > > > > (as part of migration API).
> > > > > 
> > > > > However, we have two sets of these _nomigrate APIs:
> > > > > 
> > > > >    (1) memory_region_init_r[ao]m_nomigrate
> > > > >    (2) memory_region_init_r[ao]m_flags_nomigrate
> > > > > 
> > > > > What I am still confused about is why this series used (2) to replace (1)
> > > > > rather than removing both.  I don't understand how this helps if we still
> > > > > have (2) around: it means new devices at least can still use
> > > > > (2) to bypass
> > > > > migration.
> > > > > 
> > > > > There's actually one way to enforce migratable RAMs, taking
> > > > > ROM as example,
> > > > > it could be:
> > > > > 
> > > > >    memory_region_init_rom_internal(..., global_vmstate=XXX)
> > > > > 
> > > > > Then memory_region_init_rom() should use that, setting
> > > > > global_vmstate=off.
> > > > > 
> > > > > Then we can unexport/remove memory_region_init_rom_[flag_]nomigrate() but
> > > > > use that _internal() in relevant paths; we should also mark
> > > > > the _internal()
> > > > > functions to say "new code is suggested to use the normal
> > > > > version".  But I
> > > > > do not know if that is a slight overkill just for this..
> > > > > 
> > > > > If the other series (to avoid introducing new APIs) is the
> > > > > only reason for
> > > > > this part, then IMHO this part of the series needs to be in the other
> > > > > series, not this one.  The last cleanup patches look more self contained
> > > > > OTOH to me, if the whole purpose of the latter half was code
> > > > > dedup, then it
> > > > > makes more sense at least to me.
> > > > 
> > > > +1 for what Peter Xu suggested. Most part of this series looks
> > > > independently useful, but I don't think the removal of
> > > > memory_region_init_ram_nomigrate() is.
> > > 
> > > But if there are no useful uses why keep it? This version shows that
> > > converting the Sun machines as Peter Maydell suggested only leaves
> > > very few uses that can be removed eventually too after some further
> > > clean up that I don't want to take up now. Do you have any usage in
> > > mind that needs these nomigrate variants?
> > 
> > Well, my threshold for "useful" is > 1 uses, but maintainers may have
> > other preferences.

Personally I share the same preference..

When >1 it means we can dedup some code with a function and I normally
think it worthwhile.  That's also why I don't understand why we need to
open code _set_readonly() in some of this series.

Even if for the sake of a new set of APIs, it doesn't need to provide every
single API that we have had in the old set if we don't need it, IMHO.

> 
> After this series when converting the Sun machines as in v5 the only
> nomigrate variant left is memory_region_init_ram_flags_nomigrate that is
> equivalent to memory_region_init_ram_nomigrate with flags=0 which appears
> outside of memory.c only in hw/xtensa/xtfpga.c (that will be converted in
> the next series to memory_region_new) and in hw/display/vga.c that can be
> removed when the hw_compat_2_12 is removed. There are two more uses of
> memory_region_init_ram_flags_nomigrate in backends/hostmem-ram.c and
> hw/m68k/next-cube.c but those have non-0 flags parameter. Therefore I think
> there's no need to keep other nomigrate variants than
> memory_region_init_ram_flags_nomigrate as the only two uses outside of
> memory.c that would need memory_region_init_ram_nomigrate are to be removed
> soon and can use flags=0 until then.
> 
> I don't know if the other two uses with non-0 flags can be replaced and
> memory_region_init_ram_flags_nomigrate made internal to memory.c but that's
> beyond the scope of this series and could be considered separately. Creating
> nomigrate memory region is not something that should be done or need several
> functions and the very few cases where this might be needed can use
> memory_region_init_ram_flags_nomigrate.

The hostmem-ram.c one is slightly special, when created as an object it
still doesn't know its parent device.

I still think it might be helpful if you can split your "cleanup" patches
out of this series.  Note that softfreeze will be next week.

Thanks,

-- 
Peter Xu


