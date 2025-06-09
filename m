Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E5CC61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 20:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOjDP-0008VB-FA; Mon, 09 Jun 2025 16:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOjDJ-0008Uq-Us
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 16:35:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOjDH-0002Ap-7t
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 16:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749501321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HyMfFid+3h1tNDbg8oO9+ELgXZpPxLVQB6uhDWUdLkw=;
 b=Oe8eNYXxrPBx1A63/2nj7cvVTSufk9NygL8LK5Noo1kVRs8dcHlIUCtyep+VVx00Rj0vxZ
 uDz7jqNtom3+PYe9xXV/8XdBIS6tTJxP5MpOp8tmxKEu/xBM4cHZfDcj02nuzrUOPGOS50
 ZUUAWjFPITDoZQ3SnZgGcrIqhxGXMkU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-Z5ZRik7GPp-gJFipNWjHNA-1; Mon, 09 Jun 2025 16:35:20 -0400
X-MC-Unique: Z5ZRik7GPp-gJFipNWjHNA-1
X-Mimecast-MFC-AGG-ID: Z5ZRik7GPp-gJFipNWjHNA_1749501320
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4a6ef72a544so48650851cf.1
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 13:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749501319; x=1750106119;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HyMfFid+3h1tNDbg8oO9+ELgXZpPxLVQB6uhDWUdLkw=;
 b=O7yXg93ZcQ1H/pQBBT4/vwU6cG5mEafXJMKRgli7MI113F2lsEmpdMXltxl5rgvu9t
 lE24J/jj7Q1opb212BtmpaGrzyWWMufrNO7xhbv6nMR9ea9vvJjoJxIYYIWWd3i3cTHh
 sgo4yVhEfeEpJvtoWDVJYv4bwiqgMc+A/005GjATllqgoNr/vaw9AVRCYT8WA+0uQ528
 fEsNqgZpvD+fj0Wht6MrO5aAyLgO1fDS/irt23eQJ7R9dMF95IJDcaWc/BilxzzpRmvn
 NgsAVF5OmBYQvc9+1wF5qhvoLSKNYvNCv7sBKk/LAV1otGFYtGkVGRxU+suNYapmraTc
 oMCg==
X-Gm-Message-State: AOJu0Yw/phmnuHJlKFy5HS6ye421+M6QwbuUv4QDr/ukSLfIKPrdQZ0m
 mmwwkreXDtbAQl/QGNvOTYOYRlJ6FO9XHA+NoQcyWj7EEluHDD5PkqfPwflY2CV6ZdBy3zxrFh6
 G/xIEtkdUWY2TBEytPZZkwL/tsajJOywLhtltQBAcy0RYUHfnPyoTg4knES7tUhnA
X-Gm-Gg: ASbGncurtVnGpD27sxJZPMpz9Jd+BJrM7tZ27/po6TmdQHzFQKHFnAkz3eQDaGdl3TH
 OQKQRHheeRwQq8u5E2UCu74O0yGYoPULv9igxEq5LAGeb0UoEtYLu5tYrFwymr1UgkSCAzxIcEl
 uhejzoCdqR6s6F8xby9FHVTleJT+w/7yQHLODM4avE/vppRdl5VEbIEb147kVrRNgt9JHUAiwzz
 wc8VH1/GELufKMDDMn+ZcJHOtpikoAFyIbGSh655UXkyNd8D6+7Ku0xoqXzX8RMMD9c/gPEi46l
 4PbBxgrDJECU1A==
X-Received: by 2002:a05:622a:5a8a:b0:4a4:3d6e:57c8 with SMTP id
 d75a77b69052e-4a5b9ececd0mr247957331cf.34.1749501318431; 
 Mon, 09 Jun 2025 13:35:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEwpsPY025kVKPBYQH0jUrsnwweU7M1ttcupwce2TMA1kujH0pRsrrUw/xNdlvSwuXiG13Vg==
X-Received: by 2002:a05:622a:5a8a:b0:4a4:3d6e:57c8 with SMTP id
 d75a77b69052e-4a5b9ececd0mr247957041cf.34.1749501317860; 
 Mon, 09 Jun 2025 13:35:17 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a61115048fsm60422801cf.9.2025.06.09.13.35.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 13:35:17 -0700 (PDT)
Date: Mon, 9 Jun 2025 16:35:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH 19/21] migration: Allow migrate commands to provide the
 migration config
Message-ID: <aEdFgjAAuagXUyT9@x1.local>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-20-farosas@suse.de>
 <aENBda_y3v3y4ptS@x1.local> <874iwswrex.fsf@suse.de>
 <aENUrociiqlFuPpz@x1.local> <87y0u1ugkx.fsf@suse.de>
 <aEcC9X5i6eV4N7An@x1.local> <87v7p4vlnl.fsf@suse.de>
 <aEcwaZFSyarnFTPv@x1.local> <87plfcvh2l.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87plfcvh2l.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 09, 2025 at 04:41:06PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Jun 09, 2025 at 03:02:06PM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > On Mon, Jun 09, 2025 at 11:37:02AM -0300, Fabiano Rosas wrote:
> >> >> Peter Xu <peterx@redhat.com> writes:
> >> >> 
> >> >> > On Fri, Jun 06, 2025 at 05:23:18PM -0300, Fabiano Rosas wrote:
> >> >> >> Peter Xu <peterx@redhat.com> writes:
> >> >> >> 
> >> >> >> > On Mon, Jun 02, 2025 at 10:38:08PM -0300, Fabiano Rosas wrote:
> >> >> >> >> Allow the migrate and migrate_incoming commands to pass the migration
> >> >> >> >> configuration options all at once, dispensing the use of
> >> >> >> >> migrate-set-parameters and migrate-set-capabilities.
> >> >> >> >> 
> >> >> >> >> The motivation of this is to simplify the interface with the
> >> >> >> >> management layer and avoid the usage of several command invocations to
> >> >> >> >> configure a migration. It also avoids stale parameters from a previous
> >> >> >> >> migration to influence the current migration.
> >> >> >> >> 
> >> >> >> >> The options that are changed during the migration can still be set
> >> >> >> >> with the existing commands.
> >> >> >> >> 
> >> >> >> >> The order of precedence is:
> >> >> >> >> 
> >> >> >> >> 'config' argument > -global cmdline > defaults (migration_properties)
> >> >> >> >
> >> >> >> > Could we still keep the QMP migrate-set-parameters values?
> >> >> >> >
> >> >> >> >   'config' argument > QMP setups using migrate-set-parameters >
> >> >> >> >     -global cmdline > defaults (migration_properties)
> >> >> >> >
> >> >> >> 
> >> >> >> That's the case. I failed to mention it in the commit message. IOW it
> >> >> >> behaves just like today, but the new 'config' way takes precedence over
> >> >> >> all.
> >> >> >
> >> >> > Referring to below chunk of code:
> >> >> >
> >> >> > [...]
> >> >> >
> >> >> >> >> +bool migrate_params_override(MigrationState *s, MigrationParameters *new,
> >> >> >> >> +                             Error **errp)
> >> >> >> >> +{
> >> >> >> >> +    ERRP_GUARD();
> >> >> >> >> +
> >> >> >> >> +    assert(bql_locked());
> >> >> >> >> +
> >> >> >> >> +    /* reset to default parameters */
> >> >> >> >> +    migrate_params_apply(&s->defaults);
> >> >> >
> >> >> > IIUC here it'll reset all global parameters using the initial defaults
> >> >> > first, then apply the "config" specified in "migrate" QMP command?
> >> >> >
> >> >> 
> >> >> Yes, this is so any previously set parameter via migrate-set-parameter
> >> >> gets erased. I think what we want (but feel free to disagree) is to have
> >> >> the migrate-set-parameter _eventually_ only handle parameters that need
> >> >> to be modifed during migration runtime. Anything else can be done via
> >> >> passing config to qmp_migrate.
> >> >> 
> >> >> For -global, I don't have a preference. Having -global take precedence
> >> >> over all would require a way to know which options were present in the
> >> >> command-line and which are just the defaults seet in
> >> >> migration_properties. I currently don't know how to do that. If it is at
> >> >> all possible (within reason) we could make the change, no worries.
> >> >> 
> >> >> > I think there're actually two separate questions to be asked, to make it
> >> >> > clearer, they are:
> >> >> 
> >> >> Here it got ambiguous when you say "global", I've been using -global to
> >> >> refer to the cmdline -global migration.foo, but others have used global
> >> >> to mean s->parameters (which has an extended lifetime). Could you
> >> >> clarify?
> >> >
> >> > I meant the -global, and the global setups via migrate-set-parameters.
> >> >
> >> > As replied to Dan in the other email, I changed my mind on question (1); I
> >> > think it makes sense to have it YES.  I left my pure question on (2) there
> >> > too.
> >> >
> >> > Do we really want to disable migrate-set-parameters setting most of the
> >> > parameters, and only allow it to be set during migration on a few things
> >> > like bandwidth or so?
> >> >
> >> 
> >> Well, if we decide we have reasons to introduce the "config" concept,
> >> then I think we should not present two ways of doing the same
> >> thing. User calls qmp_migrate with its arguments and that's the
> >> migration. No other ways of setting parameters.
> >> 
> >> Since we do have parameters that are set in "runtime" I though of
> >> keeping migrate-set-parameters around to minimize the interface
> >> change. Maybe those should have been separate knobs on their own after
> >> all... But in any case, we can't reject migrate-set-parameters because
> >> it might happen way earlier than the actual migration command. So I
> >> don't think anything changes regarding the API.
> >> 
> >> > I just don't really see the major benefit of that yet.  I would think it
> >> > make more sense if we don't need to change any parameters in migration,
> >> > then provide that in one shot in QMP migrate "config".  Maybe making more
> >> > sense if migration is not heavily thread-based but having its aiocontext so
> >> > we could even move to Jobs.
> >> >
> >> > Now after all we'll need to allow setting something like bandwidth even
> >> > during migration alive, and we have all the things ready allowing to set
> >> > before migration starts, I'm not 100% sure whether we need to bother even
> >> > if it does look cleaner, because we'll still break mgmt used to be working
> >> > for years.. I could be over-cautious on breaking things, but I still want
> >> > to understand better on the benefits.
> >> >
> >> 
> >> Makes sense. We'd say either use the old way or the new way. If both are
> >> mixed, then the new way takes precedence. That keeps older apps working
> >> and allows new code to transition into the new way.
> >
> > Fair enough.  Yes whenever the new way is chosen it can work in anyway we
> > define it.
> >
> > It's just that if the global list of parameters will still be around then
> > it seems to have no good reason to not build the migration parameters on
> > top of the global list of parameters.  After all, anything can be
> > overwritten in the QMP migrate if needed.
> >
> 
> If we had a way to detect that the user has modified some parameters via
> the cmdline, then we could merge that with the s->defaults and restore
> it before applying config, that would achieve what you want. I'm in
> favor, -global should only be used for debugging, I think it's fine if
> we let it go through. But anything set by migrate-set-parameters
> definitely needs to be reset. I just need a way to differentiate between
> "default parameter" vs. "default parameter that got overwritten by
> -global". I'll try to figure something out.

I think I see what you meant.  Ignoring -global is ok.  I agree with you
that should be pure debugging, and feel free to keep it like that if you
can't find anything to persist it - it may not justify your time spent if
it grows too much.

> 
> >> 
> >> > One step back, on this "allow migrate to specify 'config'" request: I
> >> > think we can definitely do that as it still provides some kind of
> >> > atomicity.  But frankly speaking I never see it a "real problem" - do
> >> > we really have report or use case showing that Libvirt can trigger
> >> > "migrate" with some global settings touched by other apps at all?
> >> >
> >> 
> >> I don't think other apps is the problem, but libvirt itself maybe
> >> attempting two migrations in sequence after one of them fails.
> >> 
> >> There always the possibility that the user is poking around, which of
> >> course is not advisable, but if a weird migration bug shows up it's
> >> difficult to confirm that other app/user hasn't changed the parameters.
> >
> > That's almost what I think the current patch is useful on providing some
> > kind of atomicity.
> >
> > If we want to make debugging easy, we could also consider returning the
> > finalized migration setup in the response of QMP "migrate" with all
> > parameters, by defining "returns" for QMP "migrate".
> >
> 
> Isn't query-migrate-parameters that already?

The important part is still "atomicity".  Consider right after Libvirt
sends a "migrate" command someone quickly cancelled it and invoked another
one using another "config".  Yes there will still be events generated to
Libvirt but I think that'll be asynchronous anyway so its arrival might
have been after the other one migrating VM again.

Attach to that to "returns" provides atomicity making sure if Libvirt
invoking a "migrate" command and get the returns, if that succeeded Libvirt
knows the returned setup is 100% the one that is running now.  It might be
cancelled too but the finalized setup will match what Libvirt triggers.

Said that, not that I think any of such would ever happen.. but that idea
does match with atomicity provided by QMP "migrate" with "config".

> 
> >> 
> >> > To me, it was yet an illutionary problem, I never know the answer of that.
> >> > If Libvirt is still the owner of QEMU instance via the QMP channel, I
> >> > actually don't really see why the atomicity would even help, even though we
> >> > can still provide that as it's pretty easy as something optional; like what
> >> > this patch does without too much hassle.
> >> >
> >> 
> >> We can provide it, but I'd rather not unless we agree that is the way
> >> forward. We don't need another way of doing the same as existing
> >> commands.
> >
> > OK, it might be me that misunderstood the request initially.
> >
> >> 
> >> > Then if to move one step further to remove all global settings, we face
> >> > breaking debugging scripts, and breaking of any old libvirt and non-libvirt
> >> > mgmt apps.  Frankly I really don't yet know whether it's a good idea.  I
> >> > could miss some important reasoning of why we want to do it - it needs to
> >> > be something not relevant to "making the code cleaner", IMHO..
> >> 
> >> I don't see it as breaking the old stuff. Because any old users would
> >> still be using migrate-set-parameters as usual. So I think your concern
> >> is about calling migrate the new way and also keeping -global
> >> working. As I said, personally I don't mind if put some ifs around to
> >> keep -global working.
> >> 
> >> Could we add another parameter that says allow-globals (or w/e) and make
> >> everyone happy?
> >
> > That's not needed if it's about making me happy. :) My happiness alone
> > isn't that important, I can change any of my script, and I'm OK whatever
> > ABI changes, but as long as the downstream won't be a mess..
> >
> 
> At this point you've probably done more migrations than any single
> person. So of course your use-case is important. I don't think an extra
> knob is too much to ask. Could even be -global only.
> 
> However, if we're going to keep both requirements working: 1) overwrite
> migrate-set-params; 2) do not overwrite -global; as I said we need a way
> to detect a parameter changed via -global... and then we don't need a
> new knob because that would already tell us.

Let's not bother; I'm totally OK ignoring -global.  When one's testing
manually, one won't be using "config" in "migrate" normally so it's fine.

> 
> > If we want to either do nothing or making it a bundle, then we can decide
> > what's the bundle now.
> >
> > For example, do we plan to have this, then drop migrate-set-parameters &
> > capabilities finally (or at least failing non-runtime-modifi-able ones)?
> >
> 
> Good question, I don't think we've decided. Those last few patches could
> have kept the RFC tag. I say we:
> 
> - Merge params+caps and deprecate migrate-set-capabilities now.
> 
>   One is an internal change and the other is a normal command
>   deprecation, AFAIK.

Agree.  Maybe we could still keep the interface for more than two releases.
Maybe we don't need to rush removing the support, and keep it deprecate for
long enough, until we figure out when it's safe.

> 
> - Make sure we agree on how config is going to work and introduce it
>   then (possibly this release).
> 
>   We also need to make sure this is the right thing for savevm, cpr,
>   etc. It would be good to have all of them uniformly prepared to take
>   (or not) the config parameter.

CPR is still live migration, I hope we can reach consensus.  It uses
exactly the caps/params it needs, but it's migrating the same as live
migration would do, except it migrates some more fds.

It could be more special if it was based on fork(), there're tons of
uncertainties over fork() with a multi-threaded app, but now we're going
scm rights, much better I'd say. Same reason, it is still live migration
when it's using generic unix sockets.

savevm - we don't plan to yet support any migration cap/param on it, right?

I remember the other use case for enabling mapped-ram, but per my memory
there is much better way to go for that use case rather than building it on
top of savevm, so I'd still think savevm doesn't need any extension, and it
should take zero parameters even in the near future.

What it can do is reset all parameters right before start, then "recover"
the parameters right after, taking BQL for the whole process.  Logically if
we know it's a new libvirt we don't even need to bother on the "recover"
part, but we may still want to consider the old libvirts too as long as
there's compat concerns.

> 
> - Leave migrate-set-parameters as is.
>   (this wasn't my original intention, but this discussion changed my
>   mind)
> 
>   As I said, we can't predict whether the user will call
>   migrate-set-parameters before calling migrate. So I don't think we can
>   say:
> 
>     "Only use this if you're not using the new 'config' option OR if
>      you're using the new 'config' option plus setting runtime parameters"
> 
>   It also gives us the ability to say that nothing changes with
>   migrate-set-parameter except that it now takes caps as well.

Yep.  For this one keeping it as-is is simpler.  We can wait for Dan/Markus
and others to chime in when there's other opinions.

> 
> > How fast do we want to do this, and how do we manage downstream to not be
> > affected by having new QEMU's migrate-set-* commands completely gone, would
> > be the follow up questions..
> >
> 
> - The migrate-set-parameters change is just an addition of options. We
>   do this anytime a new feature is added and I don't think there are
>   issues downstream. Are there?

Adding caps into it is all fine; I don't see anything would break.

> 
> - Dropping migrate-set-capabilities would be covered by the deprecation
>   period. We shouldn't have to think about it. But let's say we _are_
>   going to think about it: a libvirt from before the removal of the
>   command would have trouble with a QEMU from after the
>   removal. Converting between the two may not be trivial because caps
>   today take a MigrationCapabilityList which is a more complex data
>   structure than just key=value as MigrationParameters.

Yes, this is discussed above as well.  The worst case is we can keep the
deprecation for as long as how we deprecate machine types.  Logically
that was defined partly as "max major release cycle on guaranteed ABI",
then we may assume whatever to be rebased on the current release in any
downstream would have new libvirt ready.  Again, we can discuss this later,
marking deprecation can be done first.

> 
> - The 'config' change is supported by keeping migrate-set-parameters
>   around, so it wouldn't affect anything. Just don't use the new API.
> 
> I think that's it? Am I being too simplistic?

Nop; so far so good to me.

> 
> > Maybe I worked much enough on Linux so I pay a lot of attention trying to
> > think such trade-off, then if I see not much benefit normally I'll try to
> > not break any ABI.  But if that's everyone's wish (except myself.. even if
> > it only makes the interface better..) then we can discuss before
> > moving on.
> 
> I think we can do this without breaking anything. We could bring more
> people into the discussion to double-check. Let's just agree between
> ourselves on some of these other details.
> 
> I don't discard the possibility of simply dropping it. But I see Daniel
> (and Markus on the previous version) making compelling points.

Yeah I was absent for quite a while, and I may have missed some points.  We
can wait for some more inputs.

-- 
Peter Xu


