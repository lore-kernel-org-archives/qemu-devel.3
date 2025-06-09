Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7628C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 15:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOemc-0006Eb-Tt; Mon, 09 Jun 2025 11:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOema-0006EI-N5
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 11:51:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOemY-0000Aq-Rl
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 11:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749484288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jVlzCoRyglB7qiKtuaW5m+a0qFknLnTdhohAoQbQZXA=;
 b=hUvBZ2k778jCRZxWZpfo9RvmWeyJrHaB9Enu/dw/9dbUTXmADEFyO0Ji+WVSSH00T1cLR+
 ZOlKTswdCUXKVUIcRjLAniVVXzKOo15igzmCOiVnSa6s1Q8Clp2Cb9s1kVYrMhkxX6D/wl
 QU2QXd2+WBJE9GsXIfrSZLnEbeN9VXs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-qDszTEPWNh6TH6VoOgBGhQ-1; Mon, 09 Jun 2025 11:51:21 -0400
X-MC-Unique: qDszTEPWNh6TH6VoOgBGhQ-1
X-Mimecast-MFC-AGG-ID: qDszTEPWNh6TH6VoOgBGhQ_1749484280
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4a581009dc5so70167901cf.0
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 08:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749484280; x=1750089080;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jVlzCoRyglB7qiKtuaW5m+a0qFknLnTdhohAoQbQZXA=;
 b=taVeMGzjxfhedQ5G8Lkr/aovYB7QT7up+Ve/6UjSd0SPFf/ijgkM3FvDp6fq9ALP/Q
 zd3214Ur7sCJQkIBEMhvdUzOJhjG3X5czSl2LsWAK8xv2LwFPZMKTnNe4fxL/dQtt011
 TNhVcVML56TyiCBuP5hM0Kn5KhJf5HQ1XC77l6//0i4a/xaz0y1sXh9dwffpV6GUXc/5
 yI3jHip9R1uMzHmgiAxS1hEefn2ehV4RSmr9p1HSs1Sqe5VpcfKzAZXumCI0y4gCmPxD
 s6aQDpehSfa321gnfWzm/uW4pSkg+QYZKYqSZysQ4qHhYmoGfcmNtxcfaCsdr8+tMy9G
 DFOA==
X-Gm-Message-State: AOJu0Yy2szUIQTJ9G9EtDzg2Ew2XGzlkJ4bU2Ll9mcokb5SguJvbEC5G
 ZJyxfr2NssHw33gUlTn6Xd7NV4VcymUhfC+LF1YpbI8VZATe07z3S+giJ4stPoGz+hHeLAtveHo
 ItyzNwkRpcwfRBerhqzXevRqtb/87auo2qjMmgodhkxBqAs8P950ScO9ZwMw94dbF
X-Gm-Gg: ASbGncuU9rUX22uFhVTkh79KNnGKmqYuJUjWIncQltuPH0xAAbC7/xWndj+IPaKFLwi
 +LuBk55DcLznNVFjMKByqS9gYw0Tf1AR4gpZNdyrC/K+QXVADTtRIkoYIEK+qx8t9WyPQqhpenH
 g2vR0xlE9CaeEwrFNlyAW0Ef7EyOCLhdioz6qQlyxXEX7yk8rWf04aTsNkG/oELIsrTRW572maK
 GoyD2GcjtiVAxL5ZcY6tSSMkwclAC4GfQGVKQWeRHASKT6jNRat3uUpXRy0IIOHUyBLQfvAOQpi
 CGQ=
X-Received: by 2002:a05:622a:424f:b0:494:70e7:1528 with SMTP id
 d75a77b69052e-4a708dc51d3mr115261cf.24.1749484280267; 
 Mon, 09 Jun 2025 08:51:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwyvOZ4nZIf7u8Ia/RuBdJ1SJUPsOYG1xWsqwQ6wqZ5m8ymqr/jCgt/2/MM94e0uhJvmySiA==
X-Received: by 2002:a05:622a:424f:b0:494:70e7:1528 with SMTP id
 d75a77b69052e-4a708dc51d3mr114791cf.24.1749484279867; 
 Mon, 09 Jun 2025 08:51:19 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a61116b831sm59272641cf.22.2025.06.09.08.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 08:51:19 -0700 (PDT)
Date: Mon, 9 Jun 2025 11:51:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH 19/21] migration: Allow migrate commands to provide the
 migration config
Message-ID: <aEcC9X5i6eV4N7An@x1.local>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-20-farosas@suse.de>
 <aENBda_y3v3y4ptS@x1.local> <874iwswrex.fsf@suse.de>
 <aENUrociiqlFuPpz@x1.local> <87y0u1ugkx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y0u1ugkx.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Mon, Jun 09, 2025 at 11:37:02AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Fri, Jun 06, 2025 at 05:23:18PM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > On Mon, Jun 02, 2025 at 10:38:08PM -0300, Fabiano Rosas wrote:
> >> >> Allow the migrate and migrate_incoming commands to pass the migration
> >> >> configuration options all at once, dispensing the use of
> >> >> migrate-set-parameters and migrate-set-capabilities.
> >> >> 
> >> >> The motivation of this is to simplify the interface with the
> >> >> management layer and avoid the usage of several command invocations to
> >> >> configure a migration. It also avoids stale parameters from a previous
> >> >> migration to influence the current migration.
> >> >> 
> >> >> The options that are changed during the migration can still be set
> >> >> with the existing commands.
> >> >> 
> >> >> The order of precedence is:
> >> >> 
> >> >> 'config' argument > -global cmdline > defaults (migration_properties)
> >> >
> >> > Could we still keep the QMP migrate-set-parameters values?
> >> >
> >> >   'config' argument > QMP setups using migrate-set-parameters >
> >> >     -global cmdline > defaults (migration_properties)
> >> >
> >> 
> >> That's the case. I failed to mention it in the commit message. IOW it
> >> behaves just like today, but the new 'config' way takes precedence over
> >> all.
> >
> > Referring to below chunk of code:
> >
> > [...]
> >
> >> >> +bool migrate_params_override(MigrationState *s, MigrationParameters *new,
> >> >> +                             Error **errp)
> >> >> +{
> >> >> +    ERRP_GUARD();
> >> >> +
> >> >> +    assert(bql_locked());
> >> >> +
> >> >> +    /* reset to default parameters */
> >> >> +    migrate_params_apply(&s->defaults);
> >
> > IIUC here it'll reset all global parameters using the initial defaults
> > first, then apply the "config" specified in "migrate" QMP command?
> >
> 
> Yes, this is so any previously set parameter via migrate-set-parameter
> gets erased. I think what we want (but feel free to disagree) is to have
> the migrate-set-parameter _eventually_ only handle parameters that need
> to be modifed during migration runtime. Anything else can be done via
> passing config to qmp_migrate.
> 
> For -global, I don't have a preference. Having -global take precedence
> over all would require a way to know which options were present in the
> command-line and which are just the defaults seet in
> migration_properties. I currently don't know how to do that. If it is at
> all possible (within reason) we could make the change, no worries.
> 
> > I think there're actually two separate questions to be asked, to make it
> > clearer, they are:
> 
> Here it got ambiguous when you say "global", I've been using -global to
> refer to the cmdline -global migration.foo, but others have used global
> to mean s->parameters (which has an extended lifetime). Could you
> clarify?

I meant the -global, and the global setups via migrate-set-parameters.

As replied to Dan in the other email, I changed my mind on question (1); I
think it makes sense to have it YES.  I left my pure question on (2) there
too.

Do we really want to disable migrate-set-parameters setting most of the
parameters, and only allow it to be set during migration on a few things
like bandwidth or so?

I just don't really see the major benefit of that yet.  I would think it
make more sense if we don't need to change any parameters in migration,
then provide that in one shot in QMP migrate "config".  Maybe making more
sense if migration is not heavily thread-based but having its aiocontext so
we could even move to Jobs.

Now after all we'll need to allow setting something like bandwidth even
during migration alive, and we have all the things ready allowing to set
before migration starts, I'm not 100% sure whether we need to bother even
if it does look cleaner, because we'll still break mgmt used to be working
for years.. I could be over-cautious on breaking things, but I still want
to understand better on the benefits.

One step back, on this "allow migrate to specify 'config'" request: I think
we can definitely do that as it still provides some kind of atomicity.  But
frankly speaking I never see it a "real problem" - do we really have report
or use case showing that Libvirt can trigger "migrate" with some global
settings touched by other apps at all?

To me, it was yet an illutionary problem, I never know the answer of that.
If Libvirt is still the owner of QEMU instance via the QMP channel, I
actually don't really see why the atomicity would even help, even though we
can still provide that as it's pretty easy as something optional; like what
this patch does without too much hassle.

Then if to move one step further to remove all global settings, we face
breaking debugging scripts, and breaking of any old libvirt and non-libvirt
mgmt apps.  Frankly I really don't yet know whether it's a good idea.  I
could miss some important reasoning of why we want to do it - it needs to
be something not relevant to "making the code cleaner", IMHO..

-- 
Peter Xu


