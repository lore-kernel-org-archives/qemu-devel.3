Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F06CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 14:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSy0D-0000DZ-Vi; Fri, 29 May 2026 10:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSy02-0000Bu-A9
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:15:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSy00-0005E7-9o
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780064142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PCDGMmoAOu1cSPgOMNHwPu/bQbjKUUr2C9v5br3qW7E=;
 b=RaI/SSPhlOD0QhXR/QCapxuMI2xJO1A5AXlCtUpP8MAvplwfGUD1kQEEU/xw25jDjyFGFG
 oFiHo9lbvywsxRp20/gPBAuzvvq7lpgWzVauzgzqz58tvJZ3F8dhO0wuk6YxjHtRwXsQmj
 fM+LrYEByjWRh21hTVArqfi1WbniGDE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-_eH16Ht-O0S_sHR3FUaOfg-1; Fri, 29 May 2026 10:15:41 -0400
X-MC-Unique: _eH16Ht-O0S_sHR3FUaOfg-1
X-Mimecast-MFC-AGG-ID: _eH16Ht-O0S_sHR3FUaOfg_1780064140
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-91382222f94so2630049385a.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 07:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780064140; x=1780668940; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PCDGMmoAOu1cSPgOMNHwPu/bQbjKUUr2C9v5br3qW7E=;
 b=hkyHcXUIPah68tdU9W3bzMgQueDjBbu1wnAH/gfB/w1RfSQC4nSe4x21uFX0mgtlA4
 jBKe7NNO+buoMuV3KXF/PGC86+y2JTPtzxOGk/dkmNOSEKMZROiUVUYrn3k+0lrAEox4
 X5lr23tIHg2gQHXxwD5dcuBEULRdl62zQ2QLcowKdjBJ5V9cErehX827CD3WAwA9g1Ml
 ZPDrpx1VXhJNOvPkcPAxuqpX13vg/g05LV1dDO2qx3DJngfLGC6OawKAxJ8IA5LGB4s3
 J7NMrqe8X4soA+ei1/LENGG82IyWurjpliOqS7cUnKwRC9ug18b1gJJm4fYVrharvPBC
 mBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780064140; x=1780668940;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PCDGMmoAOu1cSPgOMNHwPu/bQbjKUUr2C9v5br3qW7E=;
 b=SbmVC8L9oqiRYyo4AnwEvdIeI6W8gQBuOFj4aKDl21Xu/vzs99rpMHJoX7gg6pCe5x
 kh/DwESFii08BG+5iztw19DJgzmkR2v2As4Mju1ZSQJ+PM+JANjfuZ4A7/Aejq8084K5
 7CWBnMPE5IXDvmKZ4fsDlvZFioWZuRqdUXzOc8S+4IKTzwv5VafdlGyKcHftbYa+zT9n
 4g5cyzWdIOlYUqNDEItPhJfoQ/Q8lyLlNbNnVdxynXFf3zF/19tAlJoIHJRhOqa1e4f0
 627U5sMiKBoJppYAdE73qd+QuMvEUh68oGjkO6qrJ+9iopqzdiFsQO5zSyIPqsmr++lf
 pxZQ==
X-Gm-Message-State: AOJu0Yz7hIDV8+kRE84r2n/czA1xxL1EJUMIlBHh0ligeInNFLjdlTYG
 1zRtBCTYWxDfpk+OCGSYybXAO5g8eU99MOMnHiC6uSR1483G9te3VKgeJq6EdH3oQsDeQV1M1eP
 VLXpZk4r52zOP+tztRIv134icv5W7/mf/t3mEae8r9idI6PPmfzj9BuQY
X-Gm-Gg: Acq92OFhaFd18wfFMU1yyGybcnLneEHRNH5Gtwv3Gh9Nr3hYI/NEo8oF3egUmsyVZh7
 Q94z9x2P0DlzzIlY537KgpDEHpDOiK2ACadSH02+FrY4/DCmMRq0eEuDoPgiJGqaPAlrvlU7SEe
 h39gQjVVWVev7I53W1B+hutNo3AoFKIOmsXFqe75O1mY3YnVQjDckg0w7LuVwco6YukM2vHJzhb
 cKR1T862q+eiJByovqbdOZzB2bOG/ywt3FPDunFQlHEHxS8F4fDLDXonMYpNvJsX7K+qnf/G2qF
 rUIbzBD+ejkOW6rkVlc07FDruKvsg2I3c0dVW3EqMpspDeNBP3s3nzby/pq4dwwnN0lQuELfpGL
 GPGoIxHJkHA3nM2tc2/+yu7bCq6MmATk9ERvZm0tEpY0f2U1wCC/40f+mkQ==
X-Received: by 2002:a05:620a:3910:b0:911:bade:b51b with SMTP id
 af79cd13be357-9152fcd2fe8mr440526985a.7.1780064138730; 
 Fri, 29 May 2026 07:15:38 -0700 (PDT)
X-Received: by 2002:a05:620a:3910:b0:911:bade:b51b with SMTP id
 af79cd13be357-9152fcd2fe8mr440500785a.7.1780064137078; 
 Fri, 29 May 2026 07:15:37 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-915325feedasm197534685a.29.2026.05.29.07.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 07:15:36 -0700 (PDT)
Date: Fri, 29 May 2026 10:15:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Ben Chaney <bchaney@akamai.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH RFC 0/2] migration/vl: new -incoming config:* for early
 migration parameters
Message-ID: <ahmfh2s7CLFLoZKN@x1.local>
References: <20260528212947.368132-1-peterx@redhat.com>
 <87se7btcq9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87se7btcq9.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, May 28, 2026 at 07:01:50PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > CI: https://gitlab.com/peterx/qemu/-/pipelines/2560168907
> >
> > This series introduces a generic way to specify migration parameters that
> > can be used even during the early boot phase of QEMU.
> >
> > One example use case that already existed is CPR-transfer / CPR-exec.
> > currently QEMU has a temporary global variable (incoming_mode) to achieve
> > this, but it's hard to understand and this hack bleeded into quite a few
> > places that we could have avoided.  The lines in patch 2 touched may
> > provide some idea.
> >
> > With a generic approach of setting migration parameters with cmdlines, we
> > can remove this hack meanwhile QEMU should be able to keep the CPR behavior
> > as before.  To CPR maintainers and reviewers: please have a closer look,
> > even better if it can be smoke tested, to see if this works for Oracle's
> > environment, TIA.
> >
> > The 1st patch implemented that new semantics.  It is straightforward: now
> > we can setup any migration parameter using an extra line of:
> >
> >   -incoming config:key1=value1,key2=value2,...
> 
> Just merge my code mate.
> https://lore.kernel.org/r/20251215220041.12657-25-farosas@suse.de

Heh, I apologize. I totally forgot it even if I seem to have read it..

The goal is differnent, though, which is to make it available before
migration object initialization.  Say, I wished -global would work too but
it doesn't, and it just can't.  So it's not "something good to have"
anymore, but functionally required for either CPR and TAP in the future if
we adopt this, they'll all read them early.

> 
> A couple of differences from my patch:
> 
> - old-style keyval vs. json;
> 
> Isn't json preferred nowadays?

I didn't mention it in doc, but yeah this series also supports JSON due to
the same qapi helper used.  I don't suggest json though for this entry (and
that's also why I didn't mention it..) because 99% of migration parameters
are scalars and I don't see why we should use JSON here.. the only one not
scalar is block-bitmap-mapping but it's not intended to be used in
-incoming at all (even if it'll work..).

> 
> - using "config:"
> 
> This makes it non-uniform with uri and channels which don't have a
> keyword in front of them. I guess I could live with it, but it seems
> odd. I see that it makes parsing way easier.

Yeah, having some identifier would be nice.  I wished channels also have
identifiers if we don't need to keep compatibility.

> 
> >
> > So far only one such instance is allowed for simplicity, but it should be
> > enough.  We still allow multiple -incoming for specifying channels, used
> > together with one "-incoming config:*".
> >
> > Then parameters set this way will be visible almost anytime for QEMU, for
> > example, during initialization of device backends (which is before
> > migration object created).
> >
> > I posted this series majorly because I want to see if this will make a
> > possible new user for the new "local" migration parameter proposed in
> > Vladimir's series:
> >
> >   https://lore.kernel.org/r/20260522120534.77653-1-vsementsov@yandex-team.ru
> >
> > Especially, there're some context on this idea too in this email:
> >
> >   https://lore.kernel.org/all/ahdI7Vl5KraK566D@x1.local/
> >
> 
> I like the idea overall.
> 
> > With this series, we should be able to drop "incoming-fds" TAP property
> > from the other series, instead relying on the existing "local" parameters
> > both in migration core and in TAP's property should suffice.
> >
> > One thing to mention is I didn't further make only-migratable into a
> > migration parameter.  Logically it will also work now with only-migratable,
> > but it then also means I'll need to convert it to a parameter, which will
> > be mutable even after VM started.  It will change how only-migratable used
> > to work, hence I skipped.
> >
> > After this, we also almost have no reason to use -global for migration
> > parameters.  Capabilities are still not supported in -incoming cmdline,
> > though.
> >
> 
> Will we still merge capabilities and parameters? Then it would be a free
> upgrade.

Yes!  /me waiting for your patches.

-- 
Peter Xu


