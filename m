Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8DBC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 05:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUggz-0000Cn-KB; Tue, 30 Jan 2024 00:29:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUggx-0000CV-Q0
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 00:29:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUggv-0007xE-Rl
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 00:29:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706592588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VGcKzAWO8qPfi/s5ehR2sVEWFNi0CR8TBpZx4OI5Os0=;
 b=YJCsReXGnlyzxEDbGKh1o1XfnxOtp7Ao3ge9gq6p0KGb1JSzDX6Q7h163wneu7QNMB1lLM
 2N1MqRlSyfzvS00GUni1Dg53JJcAxo4ist49nRQEuiDy2jtV6ac6AnOBqmyBAohA6gtBa3
 Ej/L4QS2PPkhYtgTLmbjwTH6bJBC85c=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-P-hXUQ-uMxWhjkhQRZ4upA-1; Mon, 29 Jan 2024 23:26:00 -0500
X-MC-Unique: P-hXUQ-uMxWhjkhQRZ4upA-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6dbd919aba8so1105763b3a.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 20:26:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706588760; x=1707193560;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VGcKzAWO8qPfi/s5ehR2sVEWFNi0CR8TBpZx4OI5Os0=;
 b=iCdKp4G38+vo602l7w2uiSw3rrLRocZr81BWhA1eDhXZACLo9ov2kNK4JvVOFFg0wl
 BERBzlvqg7Fh4qhsQ1z7u/DUVWGwzkSwAbSy+zIbFIa9rvBilchrFywhFz66kQudr+wI
 VY+ylNjDT4YxTrE9UtQhP1pFfr+0ZkJ7CZGllHLy2yjNR6/4i04+nuKzcg29HAo0RAJD
 hI+z7w4NQ1ns0sUi/SxYNdXifbAcCH0uDjvel3YJpJ7oQv7/XI58SOjakzoSII2k5uZM
 pVfMYLiWJ1oJNXbun31FR9lDBOqiOcKOiQD2vvgA+ZkMAnDxIKDVrswMiJ1X5VZUbdpN
 VkVA==
X-Gm-Message-State: AOJu0Yye/1oh2VBSntVci4h37lpMOmXsWzzUTEQJMMlZNMi5dPTEqqvS
 FsEECkwvomoHjHNmqi/W5j6ETcStz3hwTHqAJwDJE7a8smi8X9S3SEE3fQewA7s7t129AlyC0jD
 4GSTPdjS7k4BiFyKeLxhzzLEDlh8RFZuH7/ZD7Zdr5Lg/iom22tcR
X-Received: by 2002:a62:840c:0:b0:6dd:7b36:df93 with SMTP id
 k12-20020a62840c000000b006dd7b36df93mr9134493pfd.1.1706588759837; 
 Mon, 29 Jan 2024 20:25:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFltsGeXmyIbNU8659ioEDYQOp4CYnIR1AhpIsA7RtEmxNZZfOnrTn24afGSF21LmAqy6z8hA==
X-Received: by 2002:a62:840c:0:b0:6dd:7b36:df93 with SMTP id
 k12-20020a62840c000000b006dd7b36df93mr9134479pfd.1.1706588759388; 
 Mon, 29 Jan 2024 20:25:59 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 g5-20020aa79f05000000b006ddda48bd21sm6604005pfr.130.2024.01.29.20.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 20:25:58 -0800 (PST)
Date: Tue, 30 Jan 2024 12:25:47 +0800
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH] migration/docs: Explain two solutions for VMSD
 compatibility
Message-ID: <Zbh6S1XID8mkE9Kp@x1n>
References: <20240122070600.16681-1-peterx@redhat.com> <87plxtgyxx.fsf@suse.de>
 <Za81vJgTjFSGT56r@x1n> <87frygdzjl.fsf@suse.de>
 <CAFEAcA_uzJKuvY=iTnbG-xAjLn0zHRevzvjoyhjqqiBThveO3Q@mail.gmail.com>
 <87a5oodv7k.fsf@suse.de>
 <CAFEAcA9Yzihj1dds3H=fmQZZ24ERDwGPkrxinb4tQHw2Ev5nYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9Yzihj1dds3H=fmQZZ24ERDwGPkrxinb4tQHw2Ev5nYw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jan 29, 2024 at 03:51:07PM +0000, Peter Maydell wrote:
> On Mon, 29 Jan 2024 at 15:18, Fabiano Rosas <farosas@suse.de> wrote:
> >
> > Peter Maydell <peter.maydell@linaro.org> writes:
> >
> > > On Mon, 29 Jan 2024 at 13:45, Fabiano Rosas <farosas@suse.de> wrote:
> > >>
> > >> Peter Xu <peterx@redhat.com> writes:
> > >> > Fundamentally, IMHO it's because QEMU as a project is used both in
> > >> > enterprise and personal emulations.  I think it might be too strict to
> > >> > always request backward migration capability if we know some device / arch
> > >> > is only used for personal, or educational, purposes.
> > >>
> > >> Do we need migration support tiers? =)
> > >
> > > We already have them. The tier list is:
> >
> > Ah that's good. Thanks, Peter.
> >
> > >
> > >  * if the machine type is a versioned one, then we maintain
> > >    forwards compatibility for the versioned machine
> > >    (i.e. can migrate machine-X.Y of QEMU A.B to the
> > >     machine-X.Y of a QEMU C.D which is newer than A.B).
> > >  * if the machine type is not versioned, then we do not make
> > >    any guarantee of migration compatibility across QEMU versions.
> > >    Instead the aim is that if the user tries it it either works
> > >    or gives an error message that the migration failed
> > >    (e.g. because the version field in a VMState struct was bumped).
> > >    Migration breaks are generally called out in commit messages.
> > >    Often for machines in this tier the user is really interested
> > >    in state-save snapshots for debugging purposes, rather than
> > >    in a true cross-host-machine migration.
> > >  * some machine types do not support migration/savevm/loadvm
> > >    at all, because of devices missing VMState structs. This
> > >    is not desirable, and for new machine models we try to
> > >    ensure that they have vmstate structs as part of the minimum
> > >    quality bar, but it is true of some legacy machine types.
> >
> > Hm, does this mean in some cases we're requiring new models to have
> > vmstate only to never look at them again? Or do you mean some versioned
> > machines are currently broken?
> 
> New device models have vmstate; we don't actively test that
> savevm/loadvm works, but as with most device models we fix bugs
> if anybody reports them. Some older device models simply omit
> the vmstate struct completely (which results in the guest not
> behaving right after savevm/loadvm); a few at least register a
> migration blocker. Usually if somebody's doing a refactoring
> and cleanup of an old device they'll add the vmstate while they're
> doing it.
> 
> Any device which is used by a versioned machine type is supposed
> to have the vmstate support.
> 
> > > AIUI we, in the sense of the upstream project, do not support
> > > backwards migration compatibility (i.e. migrating a machine-X.Y
> > > from QEMU C.D to QEMU A.B where A.B is an older version than C.D);
> > > though some downstreams (read: RedHat) may do so.
> >
> > Here we still need to make a distinction between migration code and
> > vmstate. If we simply ignore backwards migration then it might become
> > impossible for downstreams to provide it without major
> > modifications. But luckily this is the easy case.
> 
> Yeah, there's no reason for us to make our downstreams' lives
> harder; the "not supported upstream" part is a mix of
> (a) we don't test it so it probably doesn't work and
> (b) we're not going to insist on patch submitters tying themselves
> in knots over trying to implement a level of compatibility for
> a device when we don't advertise that it's supposed to work

(b) makes sense.  I suppose that further justified what this document
wanted to make clear of, on that we should probably allow vmsd versioning
to be used, which is already better than either migration incompatible, or
even not support migration at all on the system.

But shouldn't we still have that tier to request "backward migration"?  Yes
it's not covered yet by any test, but maybe some day we can have it.
Besides, we're more discussing the goal which can apply to suggestions to
patch submitters and reviewers.  I think that's still a fair goal so that
on extremely popular devices + architectures, we still ask for bi-direction
migration capability.

Do we have a place where such tiering is documented?  Should I add one more
patch to describe it?

I think the hard thing is still how to justify which change will require
which tier: we were discussing machine type numbers, but normally IIUC many
devices can be used in multiple machine types, in that case should we pick
the strictest rule out of those machine types that such device support?
Maybe it'll be easier we just justify that during reviews.

-- 
Peter Xu


