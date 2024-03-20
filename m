Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4348EC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 20:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn2on-0005QV-Fr; Wed, 20 Mar 2024 16:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rn2ol-0005QD-24
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 16:45:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rn2oj-0003aN-2q
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 16:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710967543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kQq3S3i4QahAL13n58XRewaitz+Lwub2vwn5BHn4Fp0=;
 b=UmdZHTu1nkEBNnbs3lTogscc11Xl8EBPt9bW4kfxNkPP9l+7iCtojf4ZVRkD1JpiSJ1Wjo
 8QFDxNyRP0JHl0bLhKSbP/4e0Bc0g6xJUDDzEVCvOxm4RxyZZ/0CUkZ5d3FTZzkzP3EPzq
 ej1HHbXpeqjtyA0CKwVzAoXJOebCvFU=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-BJe0MuZZMjGVLxRg3wK-Hg-1; Wed, 20 Mar 2024 16:45:42 -0400
X-MC-Unique: BJe0MuZZMjGVLxRg3wK-Hg-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5a4693c3264so56602eaf.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 13:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710967541; x=1711572341;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kQq3S3i4QahAL13n58XRewaitz+Lwub2vwn5BHn4Fp0=;
 b=Qu0zOoCXrckMjtzH3kkYI6DfhX1d7k6tsYzKeazwTdC4WbBBgNJt6qlMksY9GrL449
 D/BrR/X5QqdSlPiLtjBANBEE1kT3ChkJm+LGADaWcGG4Iek0ubEYBJ1W2JBRnWxc0Guc
 8uZ8cR/+dJQiRmN0NWHoWIYrpTzp3J5Qg7O4o+7pdCI/7oCHgzAtWdlyBXCHbcyzluOs
 +ZF8ZqTbQRMxBAp0EHTB/jRsAVpUMV95K8yG+okHUzxzSevjnseOq3PvcCoMSQExbJFN
 co4svjQyvdy+hP25c1n2YRckDWjLm5xPkvx2ocaRMx0JVrmdnKDKcPrFqRtrfxXlY57T
 jbbg==
X-Gm-Message-State: AOJu0YzmfbUEIWqdtyz/QV3wAQmk3GoXuhGfnEwL1XcshGyjopqbUkLc
 UOQM0tdiKWobMnYyznB6f1QSY/wGpx+6CpF1HYFlWhZqYdJf6LSFdto+LZZ+XowyCLNsgdoYb8S
 tF6sqilRev1+ZbDCOK9FgfoXfms+XorI8epo+z6hkFQMfwIt0QNtw
X-Received: by 2002:a05:6808:3099:b0:3c3:816a:529d with SMTP id
 bl25-20020a056808309900b003c3816a529dmr7136691oib.2.1710967539952; 
 Wed, 20 Mar 2024 13:45:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5PzS2C/MI6rZ5DPYxWr+CN1TL3ALLDjsWf5RIQQHFFUT66lGBuPFGD8lbtYtQLLI8NhuYcw==
X-Received: by 2002:a05:6808:3099:b0:3c3:816a:529d with SMTP id
 bl25-20020a056808309900b003c3816a529dmr7136632oib.2.1710967538231; 
 Wed, 20 Mar 2024 13:45:38 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 eh14-20020a05622a578e00b0042f2130cd0csm4462955qtb.34.2024.03.20.13.45.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 13:45:37 -0700 (PDT)
Date: Wed, 20 Mar 2024 16:45:34 -0400
From: Peter Xu <peterx@redhat.com>
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Prasad Pandit <ppandit@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Bandan Das <bdas@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 npiggin@gmail.com
Subject: Re: [PATCH 2/3] migration: Drop unnecessary check in ram's
 pending_exact()
Message-ID: <ZftK7um412hgYdpo@x1n>
References: <20240117075848.139045-1-peterx@redhat.com>
 <20240117075848.139045-3-peterx@redhat.com>
 <bc88f4572649084cd38a0880d7e096a939f80b14.camel@linux.ibm.com>
 <ZfsxjS4Phkf34f4J@x1n>
 <7c1f0248465d55ff804c32ed7bb366d4a03abdec.camel@linux.ibm.com>
 <Zfs9JOBhz-I7D_eI@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zfs9JOBhz-I7D_eI@x1n>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Mar 20, 2024 at 03:46:44PM -0400, Peter Xu wrote:
> On Wed, Mar 20, 2024 at 08:21:30PM +0100, Nina Schoetterl-Glausch wrote:
> > On Wed, 2024-03-20 at 14:57 -0400, Peter Xu wrote:
> > > On Wed, Mar 20, 2024 at 06:51:26PM +0100, Nina Schoetterl-Glausch wrote:
> > > > On Wed, 2024-01-17 at 15:58 +0800, peterx@redhat.com wrote:
> > > > > From: Peter Xu <peterx@redhat.com>
> > > > > 
> > > > > When the migration frameworks fetches the exact pending sizes, it means
> > > > > this check:
> > > > > 
> > > > >   remaining_size < s->threshold_size
> > > > > 
> > > > > Must have been done already, actually at migration_iteration_run():
> > > > > 
> > > > >     if (must_precopy <= s->threshold_size) {
> > > > >         qemu_savevm_state_pending_exact(&must_precopy, &can_postcopy);
> > > > > 
> > > > > That should be after one round of ram_state_pending_estimate().  It makes
> > > > > the 2nd check meaningless and can be dropped.
> > > > > 
> > > > > To say it in another way, when reaching ->state_pending_exact(), we
> > > > > unconditionally sync dirty bits for precopy.
> > > > > 
> > > > > Then we can drop migrate_get_current() there too.
> > > > > 
> > > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > 
> > > > Hi Peter,
> > > 
> > > Hi, Nina,
> > > 
> > > > 
> > > > could you have a look at this issue:
> > > > https://gitlab.com/qemu-project/qemu/-/issues/1565
> > > > 
> > > > which I reopened. Previous thread here:
> > > > 
> > > > https://lore.kernel.org/qemu-devel/20230324184129.3119575-1-nsg@linux.ibm.com/
> > > > 
> > > > I'm seeing migration failures with s390x TCG again, which look the same to me
> > > > as those a while back.
> > > 
> > > I'm still quite confused how that could be caused of this.
> > > 
> > > What you described in the previous bug report seems to imply some page was
> > > leftover in migration so some page got corrupted after migrated.
> > > 
> > > However what this patch mostly does is it can sync more than before even if
> > > I overlooked the condition check there (I still think the check is
> > > redundant, there's one outlier when remaining_size == threshold_size, but I
> > > don't think it should matter here as of now).  It'll make more sense if
> > > this patch made the sync less, but that's not the case but vice versa.
> > 
> > [...]
> > 
> > > In the previous discussion, you mentioned that you bisected to the commit
> > > and also verified the fix.  Now you also mentioned in the bz that you can't
> > > reporduce this bug manually.
> > > 
> > > Is it still possible to be reproduced with some scripts?  Do you also mean
> > > that it's harder to reproduce comparing to before?  In all cases, some way
> > > to reproduce it would definitely be helpful.
> > 
> > I tried running the kvm-unit-test a bunch of times in a loop and couldn't
> > trigger a failure. I just tried again on a different system and managed just
> > fine, yay. No idea why it wouldn't on the first system tho.
> 
> There's probably still a bug somewhere.  If reproduction rate changed, it's
> also a sign that it might not be directly relevant to this change, as
> otherwise it should reproduce the same as before.
> 
> > > 
> > > Even if we want to revert this change, we'll need to know whether this will
> > > fix your case so we need something to verify it before a revert.  I'll
> > > consider that the last though as I had a feeling this is papering over
> > > something else.
> > 
> > I can check if I can reproduce the issue before & after b0504edd ("migration:
> > Drop unnecessary check in ram's pending_exact()").
> > I can also check if I can reproduce it on x86, that worked last time.
> > Anything else? Ideas on how to pinpoint where the corruption happens?
> 
> I don't have a solid clue yet, but more information of the single case
> where it reproduced could help.
> 
> I saw from the bug link that the cmdline is pretty simple.  However still
> not sure of something that can be relevant.  E.g., did you use postcopy
> (including when postcopy-ram enabled but precopy completed)?  Is there any
> special device, like s390's CMMA (would that simplest cmdline include such
> a device; apologies, I have zero knowledge there before today)?
> 
> I _think_ when reading the code I already found something quite unusual,
> but only when postcopy is selected: I notice postcopy will frequently sync
> dirty bitmap while it doesn't really necessarily need to, because
> ram_state_pending_estimate() will report all ram as "can_postcopy"; it
> means it's highly likely that this check will 99.999% always be true simply
> because must_precopy can in most cases be zero:
> 
>     if (must_precopy <= s->threshold_size) { <---------------------------- here
>         qemu_savevm_state_pending_exact(&must_precopy, &can_postcopy);
>         pending_size = must_precopy + can_postcopy;
>         trace_migrate_pending_exact(pending_size, must_precopy, can_postcopy);
>     }
> 
> I need to think more of this, but this doesn't sound right at all.  There's
> no such issue with precopy-only, and I'm surprised it is like that for years.

It seems this can be a separate new bug.. possible introduced in the same
commit since 8.0.  I will post a patch for this soon.

One more thing to mention is I am aware Nicholas & Phil also hit some s390
tcg issues, and just recently there got a fix landed, I'm suspecting that
could also be relevant. See:

https://lore.kernel.org/qemu-devel/20240312201458.79532-1-philmd@linaro.org/
03bfc2188f physmem: Fix migration dirty bitmap coherency with TCG memory access

I would suspect this issue reproduces easier before this.  I think Nicholas
also mentioned there can be other bug floating around:

https://lore.kernel.org/qemu-devel/CZSDDVZW4G3L.6CV89ZRMQK9G@wheely/

Let me add all into this loop.

Thanks,

-- 
Peter Xu


