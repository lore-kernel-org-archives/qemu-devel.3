Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0BCCCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 12:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6pPK-0000FY-GL; Thu, 09 Oct 2025 08:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6pPG-0000Ew-I4
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 08:06:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v6pP0-0008GU-44
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 08:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760011540;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7AE49c/NRdkWV0HzD04idUEpIjimLR4Pvv3chvzWfJ8=;
 b=I3RDnSheYUatR/JKHqVrKTt501DGhD910kBxcYu+IOnOpEv0XE+VEuixj7BQstN4HXzK2D
 oZWS9wliGY+04lHvoN/r1WsAM0p7OuOqefBAzC0tXCc/8XmzaSBmheQaAXdAEn8UIvx3Lo
 b2k6M41y1Q6pp7NgIeAZbi2WvUSVLdA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-35wVr05WPEikP7IWEdFsEA-1; Thu,
 09 Oct 2025 08:05:36 -0400
X-MC-Unique: 35wVr05WPEikP7IWEdFsEA-1
X-Mimecast-MFC-AGG-ID: 35wVr05WPEikP7IWEdFsEA_1760011530
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9489819560B7; Thu,  9 Oct 2025 12:05:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.196])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C47E30001B7; Thu,  9 Oct 2025 12:05:26 +0000 (UTC)
Date: Thu, 9 Oct 2025 13:05:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 2/6] tracetool: apply isort and add check
Message-ID: <aOelAgpeQbdByULq@redhat.com>
References: <20251008063546.376603-1-pbonzini@redhat.com>
 <20251008063546.376603-3-pbonzini@redhat.com>
 <20251008175811.GB181748@fedora> <aOdpofyFVoYVQc3D@redhat.com>
 <CABgObfYx8V+mUm-1eaimMeBmXyFiiBLBKWNc23_+HFXXFFb5sw@mail.gmail.com>
 <aOd5IFgFZG91izxG@redhat.com>
 <CABgObfZkEOj8HoPa8WFDw-AjHgsGskPr_ct3EmSxJyWJB1K0xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfZkEOj8HoPa8WFDw-AjHgsGskPr_ct3EmSxJyWJB1K0xQ@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Oct 09, 2025 at 01:26:25PM +0200, Paolo Bonzini wrote:
> On Thu, Oct 9, 2025 at 10:58 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Thu, Oct 09, 2025 at 10:22:43AM +0200, Paolo Bonzini wrote:
> > > On Thu, Oct 9, 2025 at 9:52 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > > I've proposed removing them in favour of meson rules earlier
> > > > this year:
> > > >
> > > >   https://lists.gnu.org/archive/html/qemu-devel/2025-02/msg04920.html
> > >
> > > I mostly agree with the intent of integrating tests with the
> > > configure/pyvenv/meson infrastructure, but I'd do things in a
> > > different order:
> > >
> > > - split part of scripts/ into contrib/scripts/ to identify one-off
> > > scripts vs. what is really used in the build process
> >
> > IMHO we should rather aim to eliminate contrib. We should either care
> > about the contents, and find an appropriate home for it in tree & have
> > ability to install it, or they should live outside QEMU git in their
> > own home.
> >
> > We shouldn't encourage a "dumping ground" for stuff that we don't
> > know what to do with.
> 
> I don't disagree but we have a lot of scripts like that:
> 
> scripts/analyse-9p-simpletrace.py
> scripts/analyse-locks-simpletrace.py
> scripts/compare-machine-types.py
> scripts/dump-guest-memory.py
> scripts/get-wraps-from-cargo-registry.py
> scripts/python_qmp_updater.py
> scripts/qcow2-to-stdout.py
> scripts/qemu-gdb.py
> scripts/qom-cast-macro-clean-cocci-gen.py
> scripts/render_block_graph.py
> scripts/replay-dump.py
> scripts/simpletrace.py
> scripts/u2f-setup-gen.py
> scripts/userfaultfd-wrlat.py
> 
> and a bunch more that aren't .py so I didn't check them; plus entire
> directories:
> 
> scripts/coccinelle/
> scripts/codeconverter
> scripts/coverage/
> scripts/kvm/
> scripts/performance/
> scripts/simplebench/
> 
> Separating them would be useful.
> 
> > > - move python/scripts/ to scripts/venv/, adjusting python/tests
> > >
> > > - move tests/minreqs.txt to pythondeps.toml. switch from pip to mkvenv
> > > in tests/Makefile.
> > >
> > > - unifying the test scripts for all of scripts/, as much as possible
> > >
> > > - integrate tests in meson, but keeping the shell scripts for now.
> > > move python/tests to tests/python. add a custom_target() to do "mkvenv
> > > ensuregroup tests"
> > >
> > > - move tox usage to .gitlab-ci.d, placing tox outside the configure
> > > script instead of inside. this makes the QEMU venv a "child" of the
> > > tox venv rather than the opposite, and allows more testing than just
> > > running the linters
> >
> > If tox is outside, that seems to require that we re-run configure for
> > each different python version we want to run tests with, which feels
> > pretty undesirable.
> >
> > There's the (system) python version that we want to run the overall
> > build system with, and then there are N other python versions which
> > we want to be able to run linters against.
> 
> I think we do want to check that configure can set up a virtual
> environment for all those versions of Python. Then we can use the
> virtual environment to run the linters too.
> 
> In fact I'm not even sure we need tox. Thanks to mkvenv, we would be
> using "configure --python" as a much cheaper substitute of tox. The
> only thing that is lost is the ability to test all versions through a
> single build tree, but I'm not sure the complexity is worth it.

FWIW, from my POV as a contributor, what I dislike is submitting a
patch series that has run through "make check" and then getting
complaints from maintainers that it fails various tests that are
not run as part of "make check".

If the maintainer is going to send feedback about failures under
5 different versions of python, then IMHO 'make check' needs to
be validating those 5 different versions of python in one go.
That was what my patch series aimed to address.

I'm not bothered whether we use tox or directly call mkvenv to
setup our test envs, provided we don't end up running

  configure; make; make check

for each python version we want linter checks against.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


