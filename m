Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84303CF58FA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 20:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLpGB-0002f7-T9; Wed, 19 Nov 2025 15:58:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vLpGA-0002ey-Po
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 15:58:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vLpG8-0002wz-KN
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 15:58:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763585914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5LbzGF/gMz8eDBIbqfbcHyOmXImhBxKnPsjhIZ0rbIQ=;
 b=SqBcBUE9G7NTyYyicQygkU9wnsA0dhiKvOPReHreXf888eJltEfDQkglnaaNU4YVuZZamz
 MnTrKB/nrFeoB/0l5X5K5Fl/Hhd8JOp1F9HPFfHHTRqplA+vO7+cXVT7J1Zs6jaD5lirxg
 NltpjXv+uW1dEzwQc5MaPIEdhPCI2uA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-gkYW4mgWP_e0OH2KXX0SEw-1; Wed, 19 Nov 2025 15:58:33 -0500
X-MC-Unique: gkYW4mgWP_e0OH2KXX0SEw-1
X-Mimecast-MFC-AGG-ID: gkYW4mgWP_e0OH2KXX0SEw_1763585913
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4ee42d99125so4520141cf.3
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 12:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763585912; x=1764190712; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5LbzGF/gMz8eDBIbqfbcHyOmXImhBxKnPsjhIZ0rbIQ=;
 b=jtPbIHn/vRbM8rT37974cJeoXX6WZxSln+p8ZFq+0DjC6X9BK+dvEOmVfGnkE5jO++
 oGzqmeUpQcsuB7X/GJU5erUETctJ7W0nkSxJo81DZqRcHSXkO4oH1Wb0LImgn1DG6Nny
 +lqBnYw3pS3sxvVOkAhYUwy8a3jYNEz+/DzjXAh0pQ3IDzwm8wApaHr200GrBt/Pj6h2
 x6mzZC7Y4lMaJbCYjtF1QVbBiOrCXGLOCbtfYBE6gM3SFlnJTbiWpdHLIAa/ljHo8weP
 j4OcRKIstys5YgQyrUEffk9VBwx6Exo2zzOBJ05tWhG21x1z+7RdXMg71+3S+iApdGm9
 YvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763585912; x=1764190712;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5LbzGF/gMz8eDBIbqfbcHyOmXImhBxKnPsjhIZ0rbIQ=;
 b=Qw6w8ncUeGqhDgJuTkXJoPPSmBdOTXtoQWzYcjzZpLdIdr4q3CXh5JfWIICuY05zea
 PdFM4kgQnGgCmaY0lyp0IzW2Op38nnq8GFOK9vTkvaqEemMe2/LynALMi0utl2C/Cm1N
 GiOBLcL5FL004wRPPrhx2lVGgy6bxcnibXcLw/FFjHqyyPeHEzKofKm/ds+7rTRqrKIb
 zEUhxlM9KPi4htDc5nqOp1805dL+d1CKc0ylqy9Xjlf+O+VJ+HEVcfTO5w2+jjm/dOqO
 cXA59ia5RX6tfwavRHUhhFZDQGKXMIc7QBr6efTAYTdQQJw96P1oCH1ZglN4B6F+Mtre
 dq4g==
X-Gm-Message-State: AOJu0YzouNEtNES6hrfa35vBcni5THlkft1QGXziGmCM6oEesVFlR1OK
 yGirnTLp9OsGkGqYuksavU/GKaEoDC2ixncmM7GYUkG0i5Kp1gxuZNtM6uJOlgPp76l0/vP4xO0
 znhDjNVIR5FqmN1lNZ13nn83riIRMhKeGaJ/UqbIxvM7z6lt5rIhv2J2o+r4u+qjy
X-Gm-Gg: ASbGncvLwsR1i9yV4vCuX7lF2ZgwY/OcuhSKdF1gqRWA1xa6xdtjEW5gc+R8P3M6yrP
 AQnAuGqYsqbWvwSGA2VqOfCF1H7hQh3tHnVSybQAJVveG8+NaPJKnOxw+wLXUGd/NzEBz2dBjJ9
 q0GWe6K9aUmR4+mFd6Ee1G4OJfoYET/d7yD0JBvviAbLyuUyNCjCGhyMWfed+bkVIceRMCvdLt8
 8VsMPRcPROEW5ZCGBkS/TEXwSjdmHBzLO2AjCwkjWtmJEyul9XDM57Ccy3R6FpG7cf1LfU20umU
 elA5JXWexQ26EzLRBEDmASIb/8WQgbosyxZTitAM9u6xq7lb9Vgnia59yEPkbyv0S+9uIALrdmF
 xCUM=
X-Received: by 2002:ac8:578c:0:b0:4ee:219e:e66 with SMTP id
 d75a77b69052e-4ee4974cfadmr8475571cf.83.1763585912337; 
 Wed, 19 Nov 2025 12:58:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsjPeBkojMy/3g6BVfDa6V3RabBfVx/cOygPUvnZHctdv9X+Et6J0LIOuMWsLEIcS7drp7Qg==
X-Received: by 2002:ac8:578c:0:b0:4ee:219e:e66 with SMTP id
 d75a77b69052e-4ee4974cfadmr8475191cf.83.1763585911551; 
 Wed, 19 Nov 2025 12:58:31 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ee48e6c2c3sm3726911cf.28.2025.11.19.12.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 12:58:30 -0800 (PST)
Date: Wed, 19 Nov 2025 15:58:29 -0500
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: [PATCH 0/3] migration: Error fixes and improvements
Message-ID: <aR4vdRcORY4em3yB@x1.local>
References: <20251115083500.2753895-1-armbru@redhat.com>
 <aRtHWbWcTh3OF2wY@x1.local> <87a50jlr8f.fsf@pond.sub.org>
 <aRyuZbS7iALvx-BT@x1.local> <87cy5ecvoc.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87cy5ecvoc.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Nov 19, 2025 at 08:45:39AM +0100, Markus Armbruster wrote:

[...]

> The hairy part is the background task.
> 
> I believe it used to simply do its job, reporting errors to stderr along
> the way, until it either succeeded or failed.  The errors reported made
> success / failure "obvious" for users.
> 
> This can report multiple errors, which can be confusing.
> 
> Worse, it was no good for management applications.  These need to
> observe migration as a state machine, with final success and error
> states, where the error state comes with an indication of what went
> wrong.  So we made migration store the first of certain errors in the
> migration state in addition to reporting to stderr.
> 
> "First", because we store only when the state doesn't already have an
> error.  "Certain", because I doubt we do it for all errors we report.
> 
> Compare this to how jobs solve this problem.  These are a much, much
> later invention, and designed for management applications from the
> start[*].  A job is a state machine.  Management applications can
> observe and control the state.  Errors are not supposed to be reported,
> they should be fed to the state machine, which goes into an error state
> then.  The job is not supposed to do actual work in an error state.
> Therefore, no further errors should be possible.  When something goes
> wrong, we get a single error, stored in the job state, where the
> management application can find it.
> 
> Migration is also a state machine, and we long ago retrofitted the means
> for management applications to observe and control the state.  What we
> haven't done is the disciplined feeding of errors to the state machine.
> We can still get multiple errors.  We store the first of certain errors
> where the managament application can find it, but whether that error
> suffices to explain what went wrong is a crap shot.  As long as that's
> the case, we need to spew the other errors to stderr, where a human can
> find it.

Since above mentioned once more on the possibility of reusing Jobs idea, I
did try to list things explicitly this time, that why I think it should be
challenging and maybe not as worthwhile (?) to do so, however I might be
wrong.  I attached it at the end of this email almost for myself in the
future to reference, please feel free comment, or, to ignore all of those!
IMHO it's not directly relevant to the error reporting issues.

IMHO rewriting migration with Jobs will not help much in error reporting,
because the challenge for refactoring from migration side is not the "Jobs"
interfacing, but internally of migration.  Say, even if migration provided
a "job", it's the "job" impl that did error reporting bad, not the Jobs
interfacing.. the "job" impl will need to manage quite some threads on its
own, making sure errors are properly reported at least to the "job"
interface.

Said that, I totally agree we should try to improve error reporting in
migration.. with / without Jobs.

[...]

> > Maybe I should ping Vladimir on his recent work here?
> >
> > https://lore.kernel.org/r/20251028231347.194844-1-vsementsov@yandex-team.ru
> >
> > That'll be part of such cleanup effort (and yes unfortunately many
> > migration related cleanups will need a lot of code churns...).
> 
> I know...
> 
> Can we afford modest efforts to reduce the mess one step at a time?

Yes, I'll try to follow up on that.

[...]

> [*] If the job abstraction had been available in time, migration would
> totally be a job.  There's no *design* reason for it being not a job.
> Plenty of implementation and backward compatibility reasons, though.

There might be something common between Jobs that block uses and a
migration process.  If so, we can provide CommonJob and make MigrationJob
and BlockJobs dependent on it.

However, I sincerely don't know how much common function will there be.
IOW, I doubt even in an imaginery world, if we could go back to when Jobs
was designed and if we would make migration a Job too (note!  snapshots is
definitely a too simple migration scenario..).  Is it possible after
evaluation we still don't?  I don't know, but I think it's possible.

Thanks!
Peter




Possible challenges of adopting Jobs in migration flow
======================================================

- Many Jobs defined property doesn't directly suite migration

  - JobStatus is not directly suitable for migration purposes.  There're
    some of the JobStatus that I can't think of any use
    (e.g. JOB_STATUS_WAITING, JOB_STATUS_PENDING, which is fine, because we
    can simply not use it), but there're other status that migration needs
    but isn't availble. Introducing them seems to be an overkill instead to
    block layer's use case.

  - Similarly to JobVerb.  E.g. JOB_VERB_CHANGE doesn't seem to apply to
    any concept to migration, but it misses quite some others
    (e.g. JOB_VERB_SET_DOWNTIME, JOB_VERB_POSTCOPY_START, and more).

  - Similarly, JobInfo reports in current-progress (which is not optional
    but required), which may make perfect sense for block jobs. However
    migration is OTOH convergence-triggered process, or user-triggered (in
    case of postcopy).  It doesn't have a quantified process but only
    "COMPLETED" / "IN_PROGRESS".

  - Another very major example that I have discussed a few times
    previously, Jobs are close attached to AioContext, while migration
    doesn't have, meanwhile migration is moving even further away from
    event driven model..  See:

    https://lore.kernel.org/all/20251022192612.2737648-1-peterx@redhat.com/#t

  There're just too many example showing that Jobs are defined almost only
  for block layer.. e.g. job-finalize (which may not make much sense in a
  migration context anyway..) mentions finalizing of graph changes, which
  also doesn't exist in migration process.

  So if we rewrite migration somehow with Jobs or keeping migration in mind
  designing Jobs, Jobs may need to be very bloated containing both
  migration and block layer requirements.

- Migration involves "two" QEMU instances instead of one

  I'm guessing existing Jobs operations are not as such, and providing such
  mechanisms in "Jobs" only for migration may introduce unnecessary code
  that block layer will never use.

  E.g. postcopy migration attached the two QEMU instances to represent one
  VM instance.  I do not have a clear picture in mind yet on how we can
  manage that if we see it as two separate Jobs on each side, and what
  happens if each side operates on its own Job with different purposes, and
  how we should connect two Jobs to say they're relevant (or maybe we don't
  need to?).

- More challenges on dest QEMU (VM loader) than src QEMU

  Unlike on the src side, the dest QEMU, when in an incoming state, is not
  a VM at all yet, but waiting to receive the migration data to become a
  working VM. It's not a generic long term process, but a pure listening
  port of QEMU where QEMU can do nothing without this "job" being
  completed..

  If we think about CPR it's even more complicated, because we essential
  require part of incoming process to happen before almost everything.. it
  may even include monitors being initialized.

- Deep integration with other subsystems

  Migration is deeply integrated into many other subsystems (auto-converge
  being able to throttle vCPUs, RAM being able to ignore empty pages
  reported from balloons, dirty trackings per-module, etc.), so we're not
  sure if there'll be some limitation from Jobs (when designed with block
  layer in mind) that will make such transition harder.

  For example, we at least want to make sure Jobs won't have simple locks
  that will be held while running migration, that can further deadlock if
  the migration code may invoke something else that tries to re-take the
  Jobs lock, which may cause dead-locks.

  Or, since migration runs nowadays with quite some threads concurrently,
  whether the main migration Job can always properly synchronize between
  all of them with no problem (maybe yes, but I just don't know Jobs enough
  to say).  This is also a relevant question about how much AioContext
  plays a role in core of Jobs idea and whether it can work well with
  complicated threaded environment.

-- 
Peter Xu


