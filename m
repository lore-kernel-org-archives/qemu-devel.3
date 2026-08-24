Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2102C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyT2C-00013P-Up; Mon, 24 Aug 2026 07:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wyT2B-00013E-HD
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:40:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wyT29-0005Cu-Jq
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787571607;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=sEgIZGttgOq7mFv/7aiZMcfV+Gtlf53VGT1MdomH8wc=;
 b=iFdWaOMQVosUCIZaOifXPn4DY5rAe2+6btgkfa6+qnuUeSswqC4pmEWxYWkfwC5IRzuNey
 UCLtm7SP+fZysFH680e7EVClW1Mk2d6QZ7/1NP9rohh0QW4ZXL3SBH2aeU5d6I0WNh7aMd
 zRuoyEuv7V6gFRPULU2i+nEeK4lMzfQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-WP72HqCDOLGxjpUDSKvZhg-1; Mon,
 24 Aug 2026 07:40:04 -0400
X-MC-Unique: WP72HqCDOLGxjpUDSKvZhg-1
X-Mimecast-MFC-AGG-ID: WP72HqCDOLGxjpUDSKvZhg_1787571603
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C4E91801F09; Mon, 24 Aug 2026 11:40:03 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E4793000239; Mon, 24 Aug 2026 11:40:01 +0000 (UTC)
Date: Mon, 24 Aug 2026 12:39:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PULL 35/35] docs: mark '-mon' as deprecated in favour of -object
Message-ID: <aowtji-323FFQ5AH@redhat.com>
References: <20260707110300.1918153-1-armbru@redhat.com>
 <20260707110300.1918153-36-armbru@redhat.com>
 <CAFEAcA-tUz_YGhvqU8-o-jw-jhR4MTMFDJ3S9rA2ZG-0GpLtVw@mail.gmail.com>
 <87o6erssjf.fsf@pond.sub.org>
 <CAFEAcA-bN5aRaZPsiZoT_zpoZkiTgUupGnCn4OaWNG_rMRw7=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-bN5aRaZPsiZoT_zpoZkiTgUupGnCn4OaWNG_rMRw7=g@mail.gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Aug 24, 2026 at 11:58:52AM +0100, Peter Maydell wrote:
> On Mon, 24 Aug 2026 at 11:48, Markus Armbruster <armbru@redhat.com> wrote:
> > Peter Maydell <peter.maydell@linaro.org> writes:
> > > Can we be more precise in deprecation messages of this kind, please?
> > > This warning is not enough for the user to be able to figure out how
> > > to change their existing command line.
> > >
> > > I had to look into deprecated.rst, check the git history to see which
> > > commit added the deprecation, then find out how this commit was adjusting
> > > the examples in the tree.
> > >
> > > Notably, "-object monitor-hmp" appears to require an "id=" despite
> > > nothing actually caring what that ID is,
> >
> > Yes, -object requires @id regardless of object type.  It calls
> > object_new_with_props_from_qdict() via user_creatable_add_qapi().
> > Together, they create the object at /objects/ID.
> 
> Yes, but usually you need the ID because it's going to plug into
> some other option somewhere else; other options like -drive
> can take an id=, but don't insist on it if you don't need it, and
> some options like chardev are only useful if you connect them to
> something else by using the ID elsewhere in the command line, so
> whether they require id= or not never comes up. So the idea of an
> option requiring an ID even though it is never referenced anywhere
> else may well be new to the user.

FYI, the ID for the monitor can be used with  object-del  QMP/HMP
commands. 

> Mostly I mention it because otherwise I think the typical user is
> going to do what I did, i.e. replace "-mon" with "-object monitor-hmp"
> and then immediately get a different error from QEMU. The warning
> being more precise could save them a step.

I was thinking that the user would do 'man qemu' where we have
docs for "-object", for each object type including "monitor-hmp/qmp",
which are shown taking an ID parameter.

> 
> > >                                          and the warning message
> > > doesn't say how to determine whether your existing -mon option
> > > should be changed to monitor-hmp or monitor-qmp. The deprecated.rst
> > > docs do say that part, but don't mention the ID bit.
> >
> > Fair points.
> >
> > Is this just "do better in the future", or are you also asking for a
> > patch to improve this warning?
> 
> Both, preferably :-)
> 
> There's an argument that the deprecation warning could look at the
> option the user actually provided and emit the exact right new
> option to use instead. But I don't think that's something we've
> ever done before for deprecations.

Essentially we have three distinct places with info - the deprecation
message at runtime, the deprecated.rst docs, and the qemu.1 manual
page. It is a trade off between how much effort we want to put into
each area.

For humans I anticipated they'd be mostly using -monitor / -qmp
convenience options, with -mon mostly used by machines which are
already familiar with -object usage already.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


