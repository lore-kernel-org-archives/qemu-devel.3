Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA54D2F33F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 16:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfhai-0007fy-1y; Tue, 13 Jan 2026 11:50:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vfhaf-0007fm-SR
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 11:49:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vfhad-0003Ex-Aq
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 11:49:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768322993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mBC26/7APAcUiJ0JcgBn5Yzr6UA7p9MW/zC4J2qhPRU=;
 b=RlmlFZ9uILEQtsRc5xDwGoIUBJwObwDOTRxk+UbBOqEHLUAiQcfDFEUkLMoqZjOQsvW6rn
 bE1g3reLN9GWNVxLhnzaGMwiV63YK0DKl0od05PeebWUVuiLF2LJ93VXbd/zFgd2vjdnqb
 crydclOezznxRFaHT3qDUMNm/TgVb+k=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-YKRTlUBLP3OteJeSBnrj6w-1; Tue, 13 Jan 2026 11:49:50 -0500
X-MC-Unique: YKRTlUBLP3OteJeSBnrj6w-1
X-Mimecast-MFC-AGG-ID: YKRTlUBLP3OteJeSBnrj6w_1768322990
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-88fcbe2e351so169230096d6.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 08:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768322990; x=1768927790; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mBC26/7APAcUiJ0JcgBn5Yzr6UA7p9MW/zC4J2qhPRU=;
 b=bbqwmqk/vHNRgU852M6cAS7usigcvSn/FxDXkn2nxns2q3XKJMg0Bb0tczYjPZM6OU
 tD/uQFOY7HguoGo7fMKCpv4wrOYW8fvCgJqZlsW5TdbOQCDFQCgqYB3bYsRejwGhXbtd
 JCaAwr0OLtXdoAWVZ4Yqe6B0uqHe3xIVzA8wfvO7QAP2r4iu/BfoB42/Xe8+/QTR3b4i
 Tsc/hPTZX0sTeQ6klqix+5lQmNKB3JJom8gu938vl+SbVGpFWSmt54Vp0zGhKTI3zkcv
 HI+aJaNF5QB9TZW437DUA7HKcFGEUrhZHRln4yC9i1GfGG81igyBHdmIBL0NOVI2+bVL
 QjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768322990; x=1768927790;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mBC26/7APAcUiJ0JcgBn5Yzr6UA7p9MW/zC4J2qhPRU=;
 b=uIDXShvQ0S2nkfCfDkSTDqgLPaeTU/wdUdNfITDV8SQjqB54LOsZfCvobQvNS0GP3t
 IGhuormKT/OYw/myOQAjaaKLaovb8tg1FI03CjDFqh4dcGNKucel6UGf+DddJMWqChn8
 t9MhAJG12c1c1DYvtlA9Bkb0MDxpxR6scyNZauYTt/0xrmjMy956FWAl5UYGO3dq9Nz2
 BVBDoRTnKZ8WwbaV51ZS4oRVZYOGmR4gvl0TFxka2zhNUrzWDGcy7rnBgM2WskxSJdep
 PrKYGvUPot2bi2jfEXFUEwtgy4tsS+0rAxsZoLEIPmU6z39473YCxhk3uGBFGgXwf55+
 wWRQ==
X-Gm-Message-State: AOJu0Yw+JyM2tjSBpCNxsYeH6VJJLFoi00tagfWjpUxpjIOFpT47t+G2
 O9HaOn485/JxJ0rx/tvgZIgRq5BBQnTUNUu3u/BaWvprTpyZU1oD6hEyvJ0a9jS/L9Ni8WlcKhL
 uJT61t3uMBR2sQg4tyfAVbB9agJ/qAo205N3zn68xgg5Yh4W2z2w5JSu5
X-Gm-Gg: AY/fxX4pEho2yGm4tUoVEgTJBHl0dweWQ2ATE7QuKCkZUp27SbmOyOLGTTf+bmiCrKn
 PmhneiBGImB6z3VUCwLtBRX6vLi3qNfNRLEQQXBLqUTqSg32N+m1CmNES+ITGXoadd0zeqAqwgX
 sHijQkTGpoYudrBcE+YlmWTins6ifhcpJ796MpCTEC9L1jC9/Z+qcNYAI8Iq98wgB4WWDhXHuhb
 pl6QTGtpHIuKUFJAL9USI9w4rmAn/6GJWNvM88RI5Ygsy0VxmDuY7RT7ZcCjoNBQf1oA4AK83Bx
 XW8ROa6SWxrXCxwobHAqjaYVtmtMN0q4v9bjpwTsvXYV/PQCJ8uvWrVV8nL7RUEq0kTvzJlRc1I
 oo8E=
X-Received: by 2002:a05:622a:1348:b0:4ee:bac:e3aa with SMTP id
 d75a77b69052e-501397f25cbmr56261401cf.35.1768322989738; 
 Tue, 13 Jan 2026 08:49:49 -0800 (PST)
X-Received: by 2002:a05:622a:1348:b0:4ee:bac:e3aa with SMTP id
 d75a77b69052e-501397f25cbmr56260811cf.35.1768322989130; 
 Tue, 13 Jan 2026 08:49:49 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ffa8d6b044sm144588791cf.14.2026.01.13.08.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 08:49:48 -0800 (PST)
Date: Tue, 13 Jan 2026 11:49:47 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Prasad Pandit <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 08/13] migration: Thread-ify precopy vmstate load process
Message-ID: <aWZ3q3NBBCl5KTYr@x1.local>
References: <20251022192612.2737648-1-peterx@redhat.com>
 <20251022192612.2737648-9-peterx@redhat.com>
 <87y0m7df46.fsf@suse.de> <aWUYVvFVbhXCdVod@x1.local>
 <871pju1wlv.fsf@suse.de> <aWVim4LDYb4gMQLk@x1.local>
 <87fr89psu5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87fr89psu5.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Jan 13, 2026 at 10:04:02AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Jan 12, 2026 at 04:04:12PM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > On Thu, Jan 08, 2026 at 05:27:37PM -0300, Fabiano Rosas wrote:
> >> >> Peter Xu <peterx@redhat.com> writes:
> >> >> 
> >> >> > Migration module was there for 10+ years.  Initially, it was in most cases
> >> >> > based on coroutines.  As more features were added into the framework, like
> >> >> > postcopy, multifd, etc.. it became a mixture of threads and coroutines.
> >> >> >
> >> >> > I'm guessing coroutines just can't fix all issues that migration want to
> >> >> > resolve.
> >> >> >
> >> >> > After all these years, migration is now heavily based on a threaded model.
> >> >> >
> >> >> > Now there's still a major part of migration framework that is still not
> >> >> > thread-based, which is precopy load.  We do load in a separate thread in
> >> >> > postcopy since the 1st day postcopy was introduced, however that requires a
> >> >> > separate state transition from precopy loading all devices first, which
> >> >> > still happens in the main thread of a coroutine.
> >> >> >
> >> >> > This patch tries to move the migration incoming side to be run inside a
> >> >> > separate thread (mig/dst/main) just like the src (mig/src/main).  The
> >> >> > entrance to be migration_incoming_thread().
> >> >> >
> >> >> > Quite a few things are needed to make it fly..  One note here is we need to
> >> >> > change all these things in one patch to not break anything.  The other way
> >> >> > to do this is add code to make all paths (that this patch touched) be ready
> >> >> > for either coroutine or thread.  That may cause confusions in another way.
> >> >> > So reviewers, please take my sincere apology on the hardness of reviewing
> >> >> > this patch: it covers a few modules at the same time, and with some risky
> >> >> > changes.
> >> >> >
> >> >> > BQL Analysis
> >> >> > ============
> >> >> >
> >> >> > Firstly, when moving it over to the thread, it means the thread cannot take
> >> >> > BQL during the whole process of loading anymore, because otherwise it can
> >> >> > block main thread from using the BQL for all kinds of other concurrent
> >> >> > tasks (for example, processing QMP / HMP commands).
> >> >> >
> >> >> > Here the first question to ask is: what needs BQL during precopy load, and
> >> >> > what doesn't?
> >> >> >
> >> >> 
> >> >> I just noticed that the BQL held at process_incoming_migration_co is
> >> >> also responsible for stopping qmp_migrate_set_capabilities from being
> >> >> dispatched.
> >> >
> >> > I don't know if it is by design, or even if it will be guaranteed to work..
> >> >
> >> 
> >> Regardless, we shouldn't rely on the BQL for this. The BQL should be
> >> left as last resort for things that interact across subsystems. If
> >> someone is issuing a migration command during a migration, the migration
> >> code is exquisitely positioned to handle that itself.
> >
> > Yes I agree.
> >
> >> 
> >> > Consider the migration incoming rocoutine runs into qemu_get_byte(), and
> >> > then proactively yield the migration coroutine (qemu_coroutine_yield())
> >> > when the incoming port is blocked on read..
> >> >
> >> > AFAIU, a proper fix for that (note, this will currently break tests) is:
> >> >
> >> > bool migration_is_running(void)
> >> >  {
> >> > -    MigrationState *s = current_migration;
> >> > +    MigrationStatus state;
> >> >  
> >> > -    if (!s) {
> >> > -        return false;
> >> > +    if (runstate_check(RUN_STATE_INMIGRATE)) {
> >> > +        MigrationIncomingState *mis = migration_incoming_get_current();
> >> > +
> >> > +        if (!mis) {
> >> > +            return false;
> >> > +        }
> >> > +
> >> > +        state = mis->state;
> >> > +    } else {
> >> > +        MigrationState *s = migrate_get_current();
> >> > +
> >> > +        if (!s) {
> >> > +            return false;
> >> > +        }
> >> > +
> >> > +        state = s->state;
> >> >      }
> >> >  
> >> > -    switch (s->state) {
> >> > +    switch (state) {
> >> >      case MIGRATION_STATUS_ACTIVE:
> >> >      case MIGRATION_STATUS_POSTCOPY_DEVICE:
> >> >      case MIGRATION_STATUS_POSTCOPY_ACTIVE:
> >> >
> >> 
> >> LGTM
> >> 
> >> >> 
> >> >> Any point during incoming migration when BQL is unlocked we have a
> >> >> window where a capability could be changed. Same for parameters, for
> >> >> that matter.
> >> >> 
> >> >> To make matters worse, the -incoming cmdline will trigger
> >> >> qmp_migrate_incoming->...->migration_transport_compatible early on, but
> >> >> until the channels finally connect and process_incoming_migration_co
> >> >> starts it's possible to just change a capability in an incompatible way
> >> >> and the transport will never be validated again.
> >> >
> >> > Right.  Above should fix it, but I believe it also means after "-incoming
> >> > tcp:xxx" (or anything not "defer") we should forbid changing migration caps
> >> > or params on destination.
> >> >
> >> 
> >> Parameters are never forbidden, right? And we cannot forbid them with
> >> is_running because some parameters are allowed to be changed while
> >> running.
> >
> > Right, my above statement was definitely inaccurate.
> >
> > After merging caps and params we only have params.  We should only allow
> > some params to be changed anytime.  Most of the params (including caps)
> > should not allow changing during migration live on either src/dst.
> >
> >> 
> >> I feel we should have a more fine grained way of saying "this option
> >> cannot be set at this moment", instead of just using the state as a
> >> proxy. States can change, while the fact that from a certain point on,
> >> certain options should not be touched anymore doesn't change.
> >
> > IIUC that's what migration_is_running() about?
> >
> 
> At a high level, yes, but I think that's actually a downside of
> migration_is_running. It's not explicit.
> 
> E.g.: qmp_migrate -> migration_transport_compatible is the first time
> capabilities are checked in the code. Guess what migration_is_running
> returns at that point? (it's false)
> 
> If there's ever a change in BQL behavior, there'll be a bug and we'll
> see another patch extending the scope of migration_is_running, either
> adding existing states to it, or as Prasad proposed, adding a new state
> that is set a little later/earlier.
> 
> What we technically want is to stop accepting new capabilities as soon
> as we're about to use them for the first time. Not as soon as (state ==
> ACTIVE || SETUP || ...) which is a more high level definition.

Isn't migration_incoming_state_setup() almost immediately invoked (after
migration_transport_compatible() check passed), which will start to make
the retval of migration_is_running() reflecting the fact?

IMHO as long as QMP handlers are run with any lock (currently, BQL), then
such layout should keep working?  That will make sure QMP "migrate" and
"migrate_set_parameters" be serialized, that's, AFAICT, what we only need.

> 
> > It's a matter of if such finer granularity is necessary for us. Let's
> > assume the simple scheme is:
> >
> >   (a) Some params are allowed to be modified anytime, examples,
> >       downtime-limit, max-bandwidth, max-postcopy-bandwidth, etc.
> >
> 
> What about during migration_cleanup() or migrate-cancel? Won't there
> ever be something in the path of setting these params that would require
> a "healthy" migration?

If we'll introduce FAILING, then plus CANCELLING I think we should cover
all race against migration_cleanup()?  As long as we'll have both FAILING
and CANCELLING to return true for migration_is_running().

> 
> >   (b) All the rest params and all capabilities are not allowed to be modified
> >       when migration_is_running() returns true (my fixed version above)
> >
> > The whitelisted (a) should really be the smallest set of params, and
> > justified one by one or it should fall into (b).
> >
> > My hope is the simple scheme should work for us already.  After merging
> > caps, it's only about some params that can be set anytime, rest params can
> > only be set when migration is not running.
> >
> 
> Sure, I'd just like to avoid adding another set of "if
> (s->parameters->has_foobar)" if possible.
> 
> >> 
> >> Maybe a little infra like bdrv_op_is_blocked, i.e, a list of blocked
> >> operations. It could be set in qmp_migrate and checked in
> >> qmp_set_parameters/caps.
> >
> > Any example you can think of, that above simple scheme won't work for us?
> >
> 
> It works. I think it's fragile due to:
> 
> - the reliance on BQL to avoid concurrent invocations;
> 
> - the possible addition of new states for unrelated reasons
>   risks regressions and it's just extra work to make sure everything is
>   still blocked at the time it needs to be blocked.

Yes, we'll need to make sure when new states introduced it needs to report
correctly in migration_is_running().  I think it's not an issue because we
need to do it right with/without relying on the function to ban updates on
caps/params.. It always must be done right as migration_is_running() is
also used in other use cases.

> 
> - any bugs need to be fixed by moving states around, which is dubious
>   since the migration flow itself (which the states should represent)
>   has not changed in a while.
> 
>   We're still seeing patches such as dc487044d5 ("migration: Make
>   migration_has_failed() work even for CANCELLING") and the recent patch
>   from Prasad. So there is something changing elsewhere and exposing
>   these bugs and it's not immediately clear what that something is (or
>   else we would have avoided the bug).
> 
> To be clear, I'm not asking we solve these issues at this moment, it's
> fine if we go forward with the simple scheme. I'm just trying to clarify
> what I think the problems are.
> 
> >> 
> >> > As discussed above, that'll at least break our qtests.  But frankly
> >> > speaking I think that's the right thing to do..  I hope libvirt always
> >> > works with "defer" and never update any caps/params after QMP
> >> > migrate_incoming.
> >> >
> >> > So I wonder if I should continue with above patch, and then fix our qtests.
> >> > Your work from the other "merge caps+params" might also work here,
> >> > actually, if we make sure everything will be set alone with the QMP
> >> > migrate_incoming single command.
> >> >
> >> 
> >> For incoming, yes. And this is maybe a point in favor of adding the
> >> 'config'.
> >> 
> >> For outgoing, there's still the point I mentioned above about how to
> >> restrict _some_ options to be allowed at runtime and others not.
> >> 
> >> > Let me know your initial thoughts, then I'll see what I can do..
> >> >
> >> 
> >> We should fix the bug, I think your patch is good for that.
> >> 
> >> Although this kind of overlaps with some things we've been discussing
> >> with Prasad. I'd be super happy if the code magically stopped using
> >> QAPI's MigrationStatus for internal tracking of migration state and
> >> blocking of commands and so on.
> >> 
> >> Whatever comes first =)
> >
> > I didn't follow as closely on the discussion there.  I don't know if
> > changing MigrationStatus is a good idea..  we should have some really good
> > reason to make libvirt and all mgmt need a change.. but maybe I misread the
> > discussion.  I can wait until I read something solid if Prasad is going to
> > propose something.
> >
> 
> We're moving towards decoupling MigrationStatus from these ordinary code
> checks. MigrationStatus should be used for informing management about a
> relevant change in the migration stage of progression.
> 
> As it stands, we're either "exposing implementation details" or
> "inadvertently changing the API". Both are undesirable.
> 
> Of course, we might introduce the "internal state is off-sync with
> externally visible states" issue, but hopefully we'll catch that during
> review. =)

I need to confess I'm still a bit lost on what it is about, and what is the
problem we're solving here.. But I can always wait and read the patches
when they come up.. :)

> 
> >> 
> >> ---
> >> Side note, did we ever discuss something like this?
> >> 
> >> struct MigrationState {
> >>    <state>
> >>    union {
> >>      <outgoing>
> >>      <incoming>
> >>    }
> >> }
> >> 
> >> there's so much stuff in these structs...
> >
> > Yeah..  When merging state, we'll also need to be careful on overlapped
> > fields, e.g. expecting a COMPLETED state (from a completed incoming
> > migration) when starting a new outgoing migration.
> >
> > We can likely leave this for later.
> 
> No worries, I'm just collecting your opinions on it.
> 

-- 
Peter Xu


