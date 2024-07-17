Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC67C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 08:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU0AR-0006Jo-Nu; Wed, 17 Jul 2024 04:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sU0AP-0006JH-Ip
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 04:37:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sU0AM-0005At-RB
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 04:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721205457;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X1JZe7AUPmUm4nNOPVAY6FMPKJh0quRVPE2Aien1voQ=;
 b=Kc5cohr3Cii1qMASM9YLmpJ+SKhIXhGco77LQEQ7fYTs5kuTgUCOF0QGn1JTyDROYdAdry
 WJYM4udsBjLvn+Tebmej59XwaToOWXvvELV3VgRA97KpJdRcN9F9LI+oOkWRiCyB5Epudy
 1l5micjhbcARX1eqOPAk9SI3n9bCDMs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-G37nesdtNnqga-Al9dm4Bw-1; Wed,
 17 Jul 2024 04:37:35 -0400
X-MC-Unique: G37nesdtNnqga-Al9dm4Bw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37DCE19560B3; Wed, 17 Jul 2024 08:37:34 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B500D1955F40; Wed, 17 Jul 2024 08:37:29 +0000 (UTC)
Date: Wed, 17 Jul 2024 09:37:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v1 00/11] Convert avocado tests to normal Python unittests
Message-ID: <ZpeCxWhEglM_w_5l@redhat.com>
References: <20240716112614.1755692-1-thuth@redhat.com>
 <ZpalCr_tcx7nsevQ@redhat.com>
 <b34746d2-b55d-486e-91a8-1394be4dfaeb@redhat.com>
 <2cae80ea-dbf6-4b1c-a086-756a5c6f15e0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2cae80ea-dbf6-4b1c-a086-756a5c6f15e0@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

On Wed, Jul 17, 2024 at 10:04:19AM +0200, Thomas Huth wrote:
> On 16/07/2024 19.03, Thomas Huth wrote:
> > On 16/07/2024 18.51, Daniel P. Berrangé wrote:
> > > On Tue, Jul 16, 2024 at 01:26:03PM +0200, Thomas Huth wrote:
> > ...
> > > > So instead of trying to update the python-based test suite in QEMU
> > > > to a newer version of Avocado, we should maybe try to better integrate
> > > > it with the meson test runner instead. Indeed most tests work quite
> > > > nicely without the Avocado framework already, as you can see with
> > > > this patch series - it does not convert all tests, just a subset so
> > > > far, but this already proves that many tests only need small modifi-
> > > > cations to work without Avocado.
> > ...
> > > > Now if you want to try out these patches: Apply the patches, then
> > > > recompile and then run:
> > > > 
> > > >   make check-functional
> > > > 
> > > > You can also run single targets e.g. with:
> > > > 
> > > >   make check-functional-ppc
> > > > 
> > > > You can also run the tests without any test runner now by
> > > > setting the PYTHONPATH environment variable to the "python" folder
> > > > of your source tree, and by specifying the build directory via
> > > > QEMU_BUILD_ROOT (if autodetection fails) and by specifying the
> > > > QEMU binary via QEMU_TEST_QEMU_BINARY. For example:
> > > > 
> > > >   export PYTHONPATH=$HOME/qemu/python
> > > >   export QEMU_TEST_QEMU_BINARY=qemu-system-x86_64
> > > >   export PYTHONPATH=$HOME/qemu/build
> > > >   ~/qemu/tests/functional/test_virtio_version.py
> > > 
> > > For the whole series as is
> > > 
> > >   Tested-by: Daniel P. Berrangé <berrange@redhat.com>
> > > 
> > > as it does what you claim it does here when I tried it.
> > 
> > Thanks!
> > 
> > > > The logs of the tests can be found in the build directory under
> > > > tests/functional/<testname> - console log and general logs will
> > > > be put in separate files there.
> > > 
> > > As an example, one dir name appears to be:
> > > 
> > >    __main__.MemAddrCheck.test_phybits_ok_pentium_pae
> > > 
> > > I'd rather prefer it if the dir name matched the test script
> > > file name - in this case test_mem_addr_space.py, as I don't
> > > want to have to lookup which class names were defined inside
> > > each test script. We could drop the "test_" prefix from the
> > > method name too
> > > 
> > > IOW, could we make this dir name be:
> > > 
> > >    test_mem_addr_space.phybits_ok_pentium_pae
> > 
> > I can try to change that, indeed ... but the boilerplate code will
> > increase a little bit, I guess, since I cannot simply rely on the
> > unittest.id() function in that case anymore...
> 
> After looking at this for a while, I think it's maybe best to ditch the idea
> of making the .py files directly runnable and run the tests via a simple
> pycotap runner instead. Then you get proper module names:

I'd really not want to loose that. To me, eliminating the test harness
entirely when debugging is the single biggest improvement of this new
approach, especially when I want to 'strace' the test without
extraneous processes.

> $ pyvenv/bin/python3 -m pycotap test_virtio_version
> TAP version 13
> ok 1 test_virtio_version.VirtioVersionCheck.test_conventional_devs
> ok 2 test_virtio_version.VirtioVersionCheck.test_modern_only_devs
> 1..

With the following change, you get the same output with direct
execution, by making argv look the same as you'd get when
running your pycotap example.

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index cc49fd4c94..3a3e65252d 100644
--- a/tests/functional/qemu_test/__init__.py
+++ b/tests/functional/qemu_test/__init__.py
@@ -266,7 +266,10 @@ def fetch_asset(self, url, asset_hash):
     def main():
         tr = pycotap.TAPTestRunner(message_log = pycotap.LogMode.LogToError,
                                    test_output_log = pycotap.LogMode.LogToError)
-        unittest.main(testRunner = tr)
+        import sys
+        import os.path
+        path = os.path.basename(sys.argv[0])[:-3]
+        unittest.main(module = None, testRunner = tr, argv=["__dummy__", path])
 
 
 class QemuSystemTest(QemuBaseTest):

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


