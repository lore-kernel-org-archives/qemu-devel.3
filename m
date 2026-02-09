Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107C5E7C706
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 08:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpMOL-0006bZ-WE; Mon, 09 Feb 2026 03:13:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vpMOK-0006bH-4g
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 03:13:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vpMOI-0002Te-8z
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 03:13:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770624785;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SJ4qqd0DHvy/gr0t7MaXLGkWYoBIwXUT6vTtdbrzoJo=;
 b=b7USmYClPS7I1kaV2GjKXudQBBX0XnhjTxPmufvP8mNgwPL1Rv12D0xvTWnlhi9BWadI0d
 ynQSnz2lh2k5omLybtHIMLHiXxcVldlIvTAr3G5oxfI1gdLrnk1nmHpej76qFWBS2ErJYk
 d+cCoXBm1hlU2tbWDrseMz+qDNAqyIc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-qv5PagC8NoOGrVODa062Dg-1; Mon,
 09 Feb 2026 03:13:01 -0500
X-MC-Unique: qv5PagC8NoOGrVODa062Dg-1
X-Mimecast-MFC-AGG-ID: qv5PagC8NoOGrVODa062Dg_1770624780
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 463C41956095; Mon,  9 Feb 2026 08:12:59 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FB051800465; Mon,  9 Feb 2026 08:12:51 +0000 (UTC)
Date: Mon, 9 Feb 2026 08:12:47 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Maksim Davydov <davydov-max@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v5 13/16] tests: remove "make check-venv" target
Message-ID: <aYmWy0yMzyF3E310@redhat.com>
References: <20260203203512.672552-1-jsnow@redhat.com>
 <20260203203512.672552-14-jsnow@redhat.com>
 <87y0l7m829.fsf@draig.linaro.org>
 <CAFn=p-a3BK5PiFQv2C0FX8z8PhQ91A3xWLoDv9fw-yJAGHMCUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFn=p-a3BK5PiFQv2C0FX8z8PhQ91A3xWLoDv9fw-yJAGHMCUg@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Feb 06, 2026 at 05:41:35PM -0500, John Snow wrote:
> On Thu, Feb 5, 2026 at 12:09 PM Alex Bennée <alex.bennee@linaro.org> wrote:
> >
> > John Snow <jsnow@redhat.com> writes:
> >
> > > With the qemu.qmp and qemu.machine dependencies now installed by default
> > > at configure time and additional dependencies required by functional
> > > testing installed on demand, there is no longer any reason to have an
> > > explicit target.
> > >
> > > FIXME: This forces image regeneration for vm tests whenever Make
> > > determines that the image needs to be rebuilt; which is a regression
> > > over the previous behavior.
> > >
> > > Signed-off-by: John Snow <jsnow@redhat.com>
> > > ---
> > >  tests/Makefile.include    | 22 ++--------------------
> > >  tests/vm/Makefile.include | 24 +++++++-----------------
> > >  2 files changed, 9 insertions(+), 37 deletions(-)
> > >
> > > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > > index f28c9e329aa..2a203e23718 100644
> > > --- a/tests/Makefile.include
> > > +++ b/tests/Makefile.include
> > > @@ -21,7 +21,6 @@ ifneq ($(filter $(all-check-targets), check-softfloat),)
> > >  endif
> > >       @echo
> > >       @echo " $(MAKE) check-report.junit.xml   Generates an aggregated XML test report"
> > > -     @echo " $(MAKE) check-venv               Creates a Python venv for tests"
> > >       @echo " $(MAKE) check-clean              Clean the tests and related data"
> > >       @echo
> > >       @echo "The following are useful for CI builds"
> > > @@ -92,33 +91,16 @@ clean-tcg: $(CLEAN_TCG_TARGET_RULES)
> > >  .PHONY: distclean-tcg
> > >  distclean-tcg: $(DISTCLEAN_TCG_TARGET_RULES)
> > >
> > > -# Python venv for running tests
> > > -
> > > -.PHONY: check-venv
> > > -
> > >  # Build up our target list from the filtered list of ninja targets
> > >  TARGETS=$(patsubst libqemu-%.a, %, $(filter libqemu-%.a, $(ninja-targets)))
> > >
> > > -TESTS_VENV_TOKEN=$(BUILD_DIR)/pyvenv/tests.group
> > > -
> > > -quiet-venv-pip = $(quiet-@)$(call quiet-command-run, \
> > > -    $(PYTHON) -m pip -q --disable-pip-version-check $1, \
> > > -    "VENVPIP","$1")
> > > -
> > > -$(TESTS_VENV_TOKEN): $(SRC_PATH)/pythondeps.toml
> > > -     $(call quiet-venv-pip,install -e "$(SRC_PATH)/python/")
> > > -     $(MKVENV_ENSUREGROUP) $< tooling functests
> > > -     $(call quiet-command, touch $@)
> > > -
> > > -check-venv: $(TESTS_VENV_TOKEN)
> > > -
> > >  FUNCTIONAL_TARGETS=$(patsubst %-softmmu,check-functional-%, $(filter %-softmmu,$(TARGETS)))
> > >  .PHONY: $(FUNCTIONAL_TARGETS)
> > > -$(FUNCTIONAL_TARGETS): check-venv
> > > +$(FUNCTIONAL_TARGETS):
> > >       @$(MAKE) SPEED=thorough $(subst -functional,-func,$@)
> > >
> > >  .PHONY: check-functional
> > > -check-functional: check-venv
> > > +check-functional:
> > >       @$(NINJA) precache-functional
> > >       @$(PYTHON) $(SRC_PATH)/scripts/clean_functional_cache.py
> > >       @QEMU_TEST_NO_DOWNLOAD=1 $(MAKE) SPEED=thorough check-func check-func-quick
> > > diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> > > index 14188bba1c6..095ec2eefa3 100644
> > > --- a/tests/vm/Makefile.include
> > > +++ b/tests/vm/Makefile.include
> > > @@ -1,14 +1,5 @@
> > >  # Makefile for VM tests
> > >
> > > -# Hack to allow running in an unconfigured build tree
> > > -ifeq ($(realpath $(SRC_PATH)),$(realpath .))
> > > -VM_PYTHON = PYTHONPATH=$(SRC_PATH)/python /usr/bin/env python3
> > > -VM_VENV =
> > > -else
> > > -VM_PYTHON = $(PYTHON)
> > > -VM_VENV = check-venv
> > > -endif
> > > -
> >
> > It's a shame to loose this because the build directory should have no
> > influence on what we build in the VM. Surely if we have qmp installed on
> > the system (and therefor its deps) we should still want the ability to
> > build in the src dir. Currently I get:
> >
> >   ➜  make vm-build-netbsd V=1
> >   tests/vm/netbsd  --debug     --source-path . --image "/home/alex/.cache/qemu-vm/images/netbsd.img" --force --build-image /home/alex/.cache/qemu-vm/images/netbsd.img
> >   Traceback (most recent call last):
> >     File "/home/alex/lsrc/qemu.git/tests/vm/netbsd", line 19, in <module>
> >       import basevm
> >     File "/home/alex/lsrc/qemu.git/tests/vm/basevm.py", line 32, in <module>
> >       from qemu.machine import QEMUMachine
> >   ModuleNotFoundError: No module named 'qemu'
> >   make: *** [tests/vm/Makefile.include:86: /home/alex/.cache/qemu-vm/images/netbsd.img] Error 1
> 
> Ah, I see.... it used to be possible to run the VM tests *without a
> build directory at all*.
> 
> So, this used to work because of this bit in tests/vm/Makefile.include:
> 
> # Hack to allow running in an unconfigured build tree
> ifeq ($(realpath $(SRC_PATH)),$(realpath .))
> VM_PYTHON = PYTHONPATH=$(SRC_PATH)/python /usr/bin/env python3
> VM_VENV =
> else
> VM_PYTHON = $(PYTHON)
> VM_VENV = check-venv
> endif
> 
> What this did was effectively treat qemu.git/python/ as an installed
> package directory and picked the most likely culprit for your actual
> python interpreter location. (Note that the configure script is a bit
> more thorough in picking a python interpreter to use that is bypassed
> here.) It's possible we can continue to do this, however, it will
> begin requiring that you just-so-happen to have qemu.qmp available in
> your python environment. The list of dependencies you might need for
> this to work successfully may increase as the years go by, so this is
> a little bit "porcelain". I'm not sure I like this, just because I
> don't wanna be on the hook for mysterious failures down the line.
> 
> Otherwise, to get all of the dependencies and python configuration
> managed for you, you have to do this:
> 
> mkdir build && pushd build && ../configure && make vm-test-netbsd
> 
> ... But you don't actually have to build, and in fact you don't even
> really need to actually run configure either, so, hm.... yeah, how
> about this, using a new "vm-venv" folder in the source tree as the
> virtual environment location, using a dependency hook like check-venv
> but now localized specifically for VM tests benefit and only when it
> is run from the source tree:

IMHO just keep life simple and expect configure to be run so we
have the regular venv setup.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


