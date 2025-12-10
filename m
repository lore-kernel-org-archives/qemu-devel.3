Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E33D3C928
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 16:32:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTN6y-00039d-I5; Wed, 10 Dec 2025 11:32:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vTN6w-00038j-B2
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 11:32:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vTN6t-0003lb-41
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 11:32:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765384334;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SEQAExgnJTli1ajGPbB9H0p7sS7k1C0DSjyGYAsttAE=;
 b=cAXS6yKrF3so6konNm7ojMeX3PJSUM+8GpD3gowSlfkfiEHdcpC0uWbQboihOhBzkn0qTR
 MuAbl8bUWHZaEt/0kIzWP5m4Kc2xQSPfFMD/E7rXqdf38F81aKzsJ1TH6PWQZ2966jfzh1
 OFKXTqzwjHVEiLZT/nq/C0HXnfdhyAo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-Hcugmk54N8aT8x1k4DODXA-1; Wed,
 10 Dec 2025 11:32:09 -0500
X-MC-Unique: Hcugmk54N8aT8x1k4DODXA-1
X-Mimecast-MFC-AGG-ID: Hcugmk54N8aT8x1k4DODXA_1765384328
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02D771956060; Wed, 10 Dec 2025 16:32:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.162])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D27811956095; Wed, 10 Dec 2025 16:32:04 +0000 (UTC)
Date: Wed, 10 Dec 2025 16:32:01 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] run: introduce a script for running devel commands
Message-ID: <aTmggYmFQkVFRIn9@redhat.com>
References: <20251210160544.2265437-1-berrange@redhat.com>
 <CAFEAcA__06DsQZrW3k1rUOOYAN6-6+2T_jTy4scGQ4s=2qUpfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA__06DsQZrW3k1rUOOYAN6-6+2T_jTy4scGQ4s=2qUpfQ@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Dec 10, 2025 at 04:22:18PM +0000, Peter Maydell wrote:
> On Wed, 10 Dec 2025 at 16:06, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > Various aspects of the development workflow are complicated by the need
> > to set env variables ahead of time, or use specific paths. Introduce a
> > $BUILD_DIR/run script that will do a number of things
> >
> >  * Set $PATH to point to $BUILD_DIR/qemu-bundle/$PREFIX/$BIN_DIR
> >  * Set $PYTHONPATH to point to $SRC_DIR/tests/functional
> >
> >  * Source $BUILD_DIR/pyvenv/bin/activate
> >
> > To see the benefits of this consider this command:
> >
> >   $ source ./build/pyvenv/bin/activate
> >   $ ./scripts/qmp/qmp-shell-wrap ./build/qemu-system-x86_64
> >
> > which is now simplified to
> >
> >   $ ./build/run ./scripts/qmp/qmp-shell-wrap qemu-system-x86_64 [args..]
> >
> > This avoids the need repeat './build' several times and avoids polluting
> > the current terminal's environment and/or avoids errors from forgetting
> > to source the venv settings.
> >
> > As another example running functional tests
> >
> >   $ export PYTHONPATH=./python:./tests/functional
> >   $ export QEMU_TEST_QEMU_BINARY=./build/qemu-system-x86_64
> >   $ build/pyvenv/bin/python3 ./tests/functional/x86_64/test_virtio_version.py
> >
> > which is now simplified to
> >
> >   $ export QEMU_TEST_QEMU_BINARY=qemu-system-x86_64
> >   $ ./build/run ./tests/functional/x86_64/test_virtio_version.py
> >
> > This usefulness of this will be further enhanced with the pending
> > removal of the QEMU python APIs from git, as that will require the use
> > of the python venv in even more scenarios that today.
> 
> Mmm, I think this will be helpful. My review comments
> below are all nitpicks.
> 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >
> > Historical context: this 'run' script concept is something introduced
> > by libguestfs a decade & a half ago, and copied by libvirt shortly
> > after that. It has been very helpful in simplifying life for developers
> > and should do likewise for QEMU.
> >
> >  docs/devel/build-system.rst       | 12 ++++++++++++
> >  docs/devel/testing/functional.rst | 17 ++++++++---------
> >  meson.build                       | 11 +++++++++++
> >  run.in                            | 15 +++++++++++++++
> >  4 files changed, 46 insertions(+), 9 deletions(-)
> >  create mode 100644 run.in
> >

> > diff --git a/meson.build b/meson.build
> > index d9293294d8..8f2320d362 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -3507,6 +3507,17 @@ endif
> >  config_host_h = configure_file(output: 'config-host.h', configuration: config_host_data)
> >  genh += config_host_h
> >
> > +run_config = configuration_data(
> > +    {'build_dir': meson.current_build_dir(),
> > +     'src_dir': meson.current_source_dir(),
> > +     'bin_dir': get_option('prefix') / get_option('bindir')},
> > +)
> > +
> > +run = configure_file(input: 'run.in',
> > +                     output: 'run',
> > +                     configuration: run_config)
> > +run_command('chmod', 'a+x', meson.current_build_dir() / 'run', check: true)
> 
> Does this work on Windows hosts ? (Obviously the run script
> isn't going to be any use if you don't have a Posix-ish shell,
> but we should at least not fall over.)

Opps, since this is just an optional convenience script, the quick
fix is to just hide this within

   if host_os != 'windows'
      ...
   endif

> > diff --git a/run.in b/run.in
> > new file mode 100644
> > index 0000000000..124f0daed2
> > --- /dev/null
> > +++ b/run.in
> > @@ -0,0 +1,15 @@
> > +#!/bin/sh
> 
> In my build tree the 'activate' script says it must
> be used "from bash"; is it wrong, or should this be
> #!/bin/bash instead ?

I don't know, but we should probably believe what the
comment says and use /bin/bash to be sure.

> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +# Ensure that we find our local builds first
> > +PATH=@build_dir@/qemu-bundle/@bin_dir@:$PATH
> > +export PATH
> > +
> > +# Ensure that functional tests find their lib
> > +PYTHONPATH=@src_dir@/tests/functional${PYTHONPATH:+:${PYTHONPATH}}
> 
> docs/devel/testing/functional.rst says PYTHONPATH also
> needs to have $SRC_DIR/python on it.

Opps, yes, I tested this on top of John Snow's series
which moves the stuff into the venv. Until then, we do
need to add $SRC_DIR/python too

> 
> > +export PYTHONPATH
> > +
> > +# Ensure that everything uses the venv python & site packages
> > +source @build_dir@/pyvenv/bin/activate
> 
> Aren't there quoting issues here if e.g. @build_dir@ has
> a space in it, or some existing PYTHONPATH or PATH
> entry has a space in it?

Yes, I should quote it

> 
> > +exec $@
> 
> I thought this needed to be quoted, i.e. "$@" rather
> than $@.

Yes.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


