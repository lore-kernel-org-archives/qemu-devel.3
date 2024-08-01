Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CB4C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 10:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZSjP-0003Sl-0T; Thu, 01 Aug 2024 06:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZSjK-00033r-5n
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:08:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZSjH-00077A-NO
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722506894;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fDHdj0aQ0c4Ld5C71SWCQAk7Uzpzm5R+FzlzkspxkBk=;
 b=JEu50ppwt4CZeExGzA7Wp1A/ApDiiPEXnW58XIP/0fT4ptlEC+rWrSuk9FeDzMDZu/u8Do
 JO1isf1xtx366F5tBZkPq8R5eR+RIycVZsKxXF6u5AOVyskI6VXmoUsMkqKRe4QE/3KlMd
 wkLOn6ewVkBFyNFeOIz90L4EVXQFhoc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-jbTamVZYNrCeNXlUmQZ92g-1; Thu,
 01 Aug 2024 06:08:11 -0400
X-MC-Unique: jbTamVZYNrCeNXlUmQZ92g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7F3F182A9CB; Thu,  1 Aug 2024 10:07:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.109])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 471721955D4D; Thu,  1 Aug 2024 10:07:23 +0000 (UTC)
Date: Thu, 1 Aug 2024 11:07:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 02/24] tests/functional: Add base classes for the
 upcoming pytest-based tests
Message-ID: <ZqteWGZFbpY3gjgT@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-3-berrange@redhat.com>
 <87ed79fxlo.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ed79fxlo.fsf@draig.linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 31, 2024 at 03:24:35PM +0100, Alex Bennée wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > From: Thomas Huth <thuth@redhat.com>
> >
> > The file is mostly a copy of the tests/avocado/avocado_qemu/__init__.py
> > file with some adjustments to get rid of the Avocado dependencies (i.e.
> > we also have to drop the LinuxSSHMixIn and LinuxTest for now).
> >
> > The emulator binary and build directory are now passed via
> > environment variables that will be set via meson.build later.
> <snip>
> > diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> > new file mode 100644
> > index 0000000000..82cc1d454f
> > --- /dev/null
> > +++ b/tests/functional/qemu_test/testcase.py
> > @@ -0,0 +1,154 @@
> > +# Test class and utilities for functional tests
> > +#
> > +# Copyright 2018, 2024 Red Hat, Inc.
> > +#
> > +# Original Author (Avocado-based tests):
> > +#  Cleber Rosa <crosa@redhat.com>
> > +#
> > +# Adaption for standalone version:
> > +#  Thomas Huth <thuth@redhat.com>
> > +#
> > +# This work is licensed under the terms of the GNU GPL, version 2 or
> > +# later.  See the COPYING file in the top-level directory.
> > +
> > +import logging
> > +import os
> > +import pycotap
> > +import sys
> > +import unittest
> > +import uuid
> > +
> > +from qemu.machine import QEMUMachine
> > +from qemu.utils import kvm_available, tcg_available
> > +
> > +from .cmd import run_cmd
> > +from .config import BUILD_DIR
> > +
> > +
> > +class QemuBaseTest(unittest.TestCase):
> > +
> > +    qemu_bin = os.getenv('QEMU_TEST_QEMU_BINARY')
> > +    arch = None
> > +
> > +    workdir = None
> > +    log = logging.getLogger('qemu-test')
> > +
> > +    def setUp(self, bin_prefix):
> > +        self.assertIsNotNone(self.qemu_bin, 'QEMU_TEST_QEMU_BINARY must be set')
> > +        self.arch = self.qemu_bin.split('-')[-1]
> > +
> > +        self.workdir = os.path.join(BUILD_DIR, 'tests/functional', self.arch,
> > +                                    self.id())
> > +        if not os.path.exists(self.workdir):
> > +            os.makedirs(self.workdir)
> 
> This is racy under --repeat:
> 
>   ==================================== 1/4 =====================================
>   test:         qemu:func-quick+func-riscv64 / func-riscv64-riscv_opensbi
>   start time:   14:16:52
>   duration:     0.06s
>   result:       exit status 1
>   command:      PYTHONPATH=/home/alex/lsrc/qemu.git/python:/home/alex/lsrc/qemu.git/tests/functional QEMU_BUILD_ROOT=/home/alex/lsrc/qemu.git/builds/all QEMU_TEST_QEMU_BINARY=
>   /home/alex/lsrc/qemu.git/builds/all/qemu-system-riscv64 MALLOC_PERTURB_=71 QEMU_TEST_QEMU_IMG=/home/alex/lsrc/qemu.git/builds/all/qemu-img /home/alex/lsrc/qemu.git/builds/al
>   l/pyvenv/bin/python3 /home/alex/lsrc/qemu.git/tests/functional/test_riscv_opensbi.py
>   ----------------------------------- stdout -----------------------------------
>   TAP version 13
>   not ok 1 test_riscv_opensbi.RiscvOpenSBI.test_riscv_sifive_u
>   not ok 2 test_riscv_opensbi.RiscvOpenSBI.test_riscv_spike
>   not ok 3 test_riscv_opensbi.RiscvOpenSBI.test_riscv_virt
>   1..3
>   ----------------------------------- stderr -----------------------------------
>   Traceback (most recent call last):
>     File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/testcase.py", line 85, in setUp
>       super().setUp('qemu-system-')
>     File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/testcase.py", line 45, in setUp
>       os.makedirs(self.workdir)
>     File "<frozen os>", line 225, in makedirs 
>   FileExistsError: [Errno 17] File exists: '/home/alex/lsrc/qemu.git/builds/all/tests/functional/riscv64/test_riscv_opensbi.RiscvOpenSBI.test_riscv_sifive_u'
> 
>   Traceback (most recent call last):
>     File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/testcase.py", line 85, in setUp
>       super().setUp('qemu-system-')
>     File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/testcase.py", line 45, in setUp
>       os.makedirs(self.workdir)
>     File "<frozen os>", line 225, in makedirs 
>   FileExistsError: [Errno 17] File exists: '/home/alex/lsrc/qemu.git/builds/all/tests/functional/riscv64/test_riscv_opensbi.RiscvOpenSBI.test_riscv_spike'
> 
>   Traceback (most recent call last):
>     File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/testcase.py", line 85, in setUp
>       super().setUp('qemu-system-')
>     File "/home/alex/lsrc/qemu.git/tests/functional/qemu_test/testcase.py", line 45, in setUp
>       os.makedirs(self.workdir)
>     File "<frozen os>", line 225, in makedirs 
>   FileExistsError: [Errno 17] File exists: '/home/alex/lsrc/qemu.git/builds/all/tests/functional/riscv64/test_riscv_opensbi.RiscvOpenSBI.test_riscv_virt'
> 
> 
>   (test program exited with status code 1)
> 
> We could just:
> 
>   os.makedirs(self.workdir, exist_ok = True)

Yeah, that's a better approach.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


