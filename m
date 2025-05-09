Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED80C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 09:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDJd2-0001a6-JY; Fri, 09 May 2025 05:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uDJd0-0001Zy-Nw
 for qemu-devel@nongnu.org; Fri, 09 May 2025 05:02:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uDJcy-00088m-H8
 for qemu-devel@nongnu.org; Fri, 09 May 2025 05:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746781362;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4czOD5NDNTNmRDfXvU3ms0Otf4jwaH9VcCEHEoIrd0U=;
 b=eR656IeRCwdm1jzORQGl60ZLVsSaD+tWizUFRVOGBa5ZcMTA22x8WpF8L0KhZ5F2Xs58uu
 niXVruRYnhA6o5pua8d9sTdBdEfYnkTSn1CYsQkhggqwiWUgoK+d9VTQHzPJjLCm2vJA1b
 /OhduQzScld/rhyCRir9ZndQv9lgYKA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-arS5aFwQPh-MTAMsdhRRSQ-1; Fri,
 09 May 2025 05:02:38 -0400
X-MC-Unique: arS5aFwQPh-MTAMsdhRRSQ-1
X-Mimecast-MFC-AGG-ID: arS5aFwQPh-MTAMsdhRRSQ_1746781357
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 183C31800261; Fri,  9 May 2025 09:02:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.100])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3920519560AD; Fri,  9 May 2025 09:02:33 +0000 (UTC)
Date: Fri, 9 May 2025 10:02:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH RFC 00/10] qapi: remove all TARGET_* conditionals from
 the schema
Message-ID: <aB3EpKu0iafLtgVT@redhat.com>
References: <20250508135816.673087-1-berrange@redhat.com>
 <c7623b1c-01c1-46c0-bfa6-dc34aa4e722d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7623b1c-01c1-46c0-bfa6-dc34aa4e722d@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, May 08, 2025 at 02:09:37PM -0700, Pierrick Bouvier wrote:
> On 5/8/25 6:58 AM, Daniel P. Berrangé wrote:
> > Pierrick has proposed a series that introduces a concept of runtime
> > conditionals to the QAPI schema, in order to adapt the TARGET_*
> > conditionals currently used at build time:
> > 
> >    https://lists.nongnu.org/archive/html/qemu-devel/2025-05/msg01699.html
> > 
> > For the sake of comparison & evaluation, this series illustrates the
> > alternative approach that we've discussed of entirely removing any
> > concept of TARGET_* conditionals.
> > 
> > With this the QAPI schema varies solely based on CONFIG_* conditionals,
> > and is thus invariant across different target emulators.
> > 
> > In this PoC I've taken the minimal effort approach to the problem.
> > 
> > The QAPI schema has removed the TARGET_* conditionals and in order to
> > make all the emulators then compile, the stubs/ directory is populated
> > with a bunch of files to provide dummy impls of the target specific QMP
> > commands.
> > 
> > This is sufficient to make the current QEMU binaries build successfully.
> > 
> > To make the "single binary" concept work, however, would require
> > additional followup work to eliminate the stubs.
> > 
> > Instead of having stubs we would need to de-couple the QMP command
> > impl from the machine internals. This would likely require greater
> > use of interfaces and/or virtual method dispatchers on the machine
> > class. This would enable the 'qmp_XXXXX' command impls to exist
> > once. Then they call out to virtual methods on the machine to provide
> > the real impl, and/or generate an error if the virtual method is not
> > implemented for the machine.
> > 
> 
> Thanks for posting it Daniel.
> 
> I think your approach is pretty neat, and yes, it's much simpler than having
> any compile time or runtime conditional to deal with that.
> 
> When we talked about that on previous thread, I thought the idea was to
> expose *all* the commands to *all* the targets, which I didn't really
> understand, considering we have target specific commands by design.
> I understand better where you wanted to go, by extracting concerned commands
> in dedicated files.
> 
> The only downside I can see is that some commands have to be there, but
> return an "error, not implemented" at runtime. Fine for me, but some people
> may argue against it.
> 
> A concern I might have as well is about how we'll deal if we want to hide
> some commands in the future, based on various criterias
> (is_heterogenenous()?). The mantra "define all, and let the build system
> hide things" mantra means you can only have a single definition existing in
> the binary, by design. But maybe it's not even a real concern, and I
> definitely prefer to see problems before fixing them, so it's definitely not
> blocking this approach.

I think we have to distinguish between what made sense in the context
of our original design, from what makes sense for our future design(s)
and plans.

I can understand why we took the direction we did historically, but I
think we have unwittingly created problems for ourselves that are
looking increasingly worse than the problems we considered solved.


In the other thread I pointed out my dislike for QAPI schema not being
fully self-describing when we have conditionals present, even today,
but there are other aspects that trouble me more wrt conditionals.

Since the schema is currently target specific, a mgmt app has to probe
for QEMU capabilities once for every target binary. QEMU has ~30 system
binaries, and if querying capabilities takes 250 milliseconds, then
querying all binaries is ~ 7 seconds of work. Libvirt mitigates this
overhead by caching the results of capabilities probes. We periodically
suffer delays when we must invalidate our cache though, typically on
software upgrades, and this is unpleasant for users who think we've
got stuck or just have bad slow code.


Even if we had a QAPI schema that didn't vary per target, this is
repeated probing is tricky to avoid when we have completely independant
binaries. We would need QEMU to have some internal "build id", so that
we could detect that all binaries came from the same build, to let us
avoid re-probing each binary.


With your work to have a single binary that can impersonate any of our
target specific binaries, *if* we had a QAPI schema that didn't vary
per target, we would stand a real chance of being able to eliminate
the need to probe capabilities once for every target.

eg if we assume qemu-system-x86_64 is a symlink to "/usr/bin/qemu-system"
(or whatever you call the common binary), then we only need to probe one
binary - the target of the symlink - we can easily identify that all
the legacy binary symlinks resolve to the same real binary with no special
effort.


Conversely if we want the QAPI schema to be varying at runtime per target,
it means we have to select a target before we can probe the schema in the
binary. If we assume an install with only the new binary and none of the
legacy target specific symlinks, we have a chicken & egg problem though.

How do we know what targets are supported ? We should be able to use QAPI
to query the available targets, but before we can use QAPI we need to
select a target ?

We could make QAPI only expose the pieces of schema that are *not*
specific to a target initially, and then refine the schema once a
target is selected. That would solve the immediate problem, but I
think that kind of cleverness is just postponing the pain

Consider that we eventually want a QEMU binary that can run CPUs from
multiple targets concurrently.  That implies that a dynamic QAPI schema
needs to turn on the target specific pieces of multiple targets at once.
At that point a mgmt app fundamentally has to understand ahead of time
that some features are target specific - the existance/absence of
features in the QAPI schema can no longer express what is target
specific, since we must expose the union of features all targets
that are in use.

So as we look to the future of QEMU, IMHO, the concept of using the QAPI
schema definitions to dynamically express what is available per-target
is unhelpful and likely even to be harmful.

Assuming a schema that is fixed at build time ought to simplify QEMU
maintainers' life, and while mgmt apps loose a little info, they will
gain in other ways such as not having to query QEMU capabilities
30 times over.

> Overall, if I had to choose, I think I would pick your approach instead of
> the "runtime conditional" route, it's just simpler and saner overall.
> I would be happy to see you take ownership on that, as long as we can
> deliver something in the next weeks. I can help on anything as well.

I'm fine with you driving this forward, not least because I can't commit
to having any predictable amount of time to write code myself for this.

> @Markus, @Michael, which approach would you prefer to be followed for QAPI?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


