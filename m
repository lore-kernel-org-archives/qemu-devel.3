Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A362ED3B981
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 17:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT16n-0002rr-PZ; Tue, 09 Dec 2025 12:02:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vT15C-0002AD-M4
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 12:01:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vT159-0002Pl-Cx
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 12:01:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765299657;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=T9MJclz9Vj2TI+we83PPn2yfD3VX101pKwU4rc8p/h0=;
 b=M8rEdswd2arLJkXJttJZapIVY11z3EzgsublYpKxBsz7oKqOZo4G5AV47FPpDV2MwOgRxU
 CKDaaaonzAKzk2ml2M26V+Bkt1Hjet68LWO9m/9pk3YOm6A1eUPOC4LMAT1kg4cTJNl5ZO
 68aKDCwp+JJiGieIuo4acZVIDqZ00NY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-8u-EGiTSNFGAaMXuU_G09w-1; Tue,
 09 Dec 2025 12:00:53 -0500
X-MC-Unique: 8u-EGiTSNFGAaMXuU_G09w-1
X-Mimecast-MFC-AGG-ID: 8u-EGiTSNFGAaMXuU_G09w_1765299652
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEE971800743; Tue,  9 Dec 2025 17:00:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.79])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9FDF19560AD; Tue,  9 Dec 2025 17:00:47 +0000 (UTC)
Date: Tue, 9 Dec 2025 17:00:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 00/15] python: drop qemu.qmp from qemu.git tree
Message-ID: <aThVvP5vwfjVa-ka@redhat.com>
References: <20251205060058.1503170-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251205060058.1503170-1-jsnow@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Dec 05, 2025 at 01:00:42AM -0500, John Snow wrote:
> Hello!
> 
> This series drops the in-tree version of our python-qemu-qmp package
> ("qemu.qmp") in favor of the version hosted on PyPI, whose repository is
> located at https://gitlab.com/qemu-project/python-qemu-qmp.
> 
> GitLab CI: https://gitlab.com/jsnow/qemu/-/pipelines/2197613036
>        (FreeBSD isn't my fault...!)
> 
> The major effects of this patch series are:
> 
> 1. qemu.qmp will be installed from PyPI or vendored packages instead of
>    being utilized directly from the qemu.git tree.

This is not getting installed in enough scenarios IMHO.

My current workflow is commonly

  $ ./configure --target-list=x86_64-softmmu
  $ make
  $ ./scripts/qmp/qmp-shell-wrap 
   /var/home/berrange/src/virt/qemu/build
  Traceback (most recent call last):
    File "/var/home/berrange/src/virt/qemu/scripts/qmp/qmp-shell-wrap", line 7, in <module>
      from qemu.qmp import qmp_shell
  ModuleNotFoundError: No module named 'qemu.qmp'

Even if I add in a call to 'source build/pyvenv/bin/activate'
after 'make', I'm still missing the qemu.qmp python module.

AFAICT, qemu.qmp only gets installed in the venv if you run
'make check', and IMHO that should not be expected for the
above usage scenario.

Likewise I can no longer run any of the test programs directly
without first having run 'make check'. eg what I would currently
do is:

   $ ./configure --target-list=x86_64-softmmu
   $ make
   $ cd build/tests/qemu-iotests
   $ ./check 300

I don't generally run 'make check' as frequently as I
'configure && make' as it adds alot of time which is
not needed usually.

In general I find it tedious having to remember to run
'source build/pyvenv/bin/activate' in every terminal
window where I might want to run a QEMU script that relies
on python. It is also fairly undesirable too, as I use the
same terminal window for various purposes, that activating
the QEMU venv can interfere with non-QEMU python usage.

I would find it helpful if we provided a "run" script in the
root dir of the build directory that contained the following

  $ cat build/run
  #!/bin/sh

  set -e

  HERE=$(realpath $(dirname $0))
  source $HERE/pyvenv/bin/activate
  exec "$@"

Which would be used as a wrapper to execute scripts with the
right environment. That would let us keep the simpler workflow,
and avoid polluting the global terminal environment with the
qemu venv.

eg to be used as

   $ ./configure --target-list=x86_64-softmmu
   $ make
   $ cd build/tests/qemu-iotests
   $ ../../run ./check 300

or

  $ ./configure --target-list=x86_64-softmmu
  $ make
  $ ./build/run ./scripts/qmp/qmp-shell-wrap 



> 2. There are no new python dependencies checked or installed during
>    configure.  All test dependencies are installed post-hoc on an
>    as-needed basis.
> 3. "make check-venv" is no longer required to be run manually before any
>    test that is integrated with meson; this includes "make check" and
>    "make check-functional".
> 4. "make check-venv" no longer installs functional test dependencies: it
>    installs only the core suite of python test dependencies.
> 5. "make check-venv" is now required as a pre-requisite for running
>    device-crash-test and manually executed iotests.
> 6. Unfortunately, python3-wheel and python3-setuptools are now required
>    on the host system if tests are to be executed and >= Python 3.13 is
>    used.
> 7. An awful lot of deleted lines of code, and a lot fewer headaches
>    managing two nearly-identical copies of this source code. O:-)
> 
> Patches 1-5 are build system focused; they set up new pythondeps.toml,
> mkvenv, and meson systems in preparation for relying on an external
> qemu.qmp library, but does not yet make the switch.
> 
> Patches 6-9 are testing and CI focused; they add necessary preparation
> steps to keep tests running happily once the in-tree qemu.qmp library is
> removed.
> 
> Patches 10-15 are build system focused again; they implement the actual
> switchover to the external qemu.qmp library.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


