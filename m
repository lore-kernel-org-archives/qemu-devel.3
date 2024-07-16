Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF93C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTlP6-0005WE-WD; Tue, 16 Jul 2024 12:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sTlP1-0005Az-MO
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:51:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sTlOz-0003Oi-NW
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721148696;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FOb+oLxJSZ+RV9qq9guYSzX1qjVRSqRHQmL9rGu2Hxg=;
 b=IYxVJ4mYOgJHvSCs2pwDtv6O8z/pVQEtRhDd7gh8vVF2JZMV3ABNiZ7N3AMnRZ/J32BHdA
 sdDgWtGLqFx3KncKo9Jab2M/x8ovNPNaFt7xTnqw9RkVC9vFBvBh0gghApXB7D5UMPfcYb
 BnKwS+TMUenWeCfhI3JpvxhA40GOl40=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-Hdz-w4w6MSyGDnLUFmw55Q-1; Tue,
 16 Jul 2024 12:51:31 -0400
X-MC-Unique: Hdz-w4w6MSyGDnLUFmw55Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C1A471955D52; Tue, 16 Jul 2024 16:51:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 852CF1955D44; Tue, 16 Jul 2024 16:51:26 +0000 (UTC)
Date: Tue, 16 Jul 2024 17:51:22 +0100
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
Message-ID: <ZpalCr_tcx7nsevQ@redhat.com>
References: <20240716112614.1755692-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240716112614.1755692-1-thuth@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

On Tue, Jul 16, 2024 at 01:26:03PM +0200, Thomas Huth wrote:
> The Avocado v88 that we use in QEMU is already on a life support
> system: It is not supported by upstream anymore, and with the latest
> versions of Python, it won't work anymore since it depends on the
> "imp" module that has been removed in Python 3.12.
> 
> There have been several attempts to update the test suite in QEMU
> to a newer version of Avocado, but so far no attempt has successfully
> been merged yet.
> 
> Additionally, the whole "make check" test suite in QEMU is using the
> meson test runner nowadays, so running the python-based tests via the
> Avocodo test runner looks and feels quite like an oddball, requiring
> the users to deal with the knowledge of multiple test runners in
> parallel (e.g. the timeout settings work completely differently).
> 
> So instead of trying to update the python-based test suite in QEMU
> to a newer version of Avocado, we should maybe try to better integrate
> it with the meson test runner instead. Indeed most tests work quite
> nicely without the Avocado framework already, as you can see with
> this patch series - it does not convert all tests, just a subset so
> far, but this already proves that many tests only need small modifi-
> cations to work without Avocado.
> 
> Only tests that use the LinuxTest / LinuxDistro and LinuxSSHMixIn
> classes (e.g. based on cloud-init images or using SSH) really depend
> on the Avocado framework, so we'd need a solution for those if we
> want to continue using them. One solution might be to simply use the
> required functions from avocado.utils for these tests, and still run
> them via the meson test runner instead, but that needs some further
> investigation that will be done later.
> 
> 
> Now if you want to try out these patches: Apply the patches, then
> recompile and then run:
> 
>  make check-functional
> 
> You can also run single targets e.g. with:
> 
>  make check-functional-ppc
> 
> You can also run the tests without any test runner now by
> setting the PYTHONPATH environment variable to the "python" folder
> of your source tree, and by specifying the build directory via
> QEMU_BUILD_ROOT (if autodetection fails) and by specifying the
> QEMU binary via QEMU_TEST_QEMU_BINARY. For example:
> 
>  export PYTHONPATH=$HOME/qemu/python
>  export QEMU_TEST_QEMU_BINARY=qemu-system-x86_64
>  export PYTHONPATH=$HOME/qemu/build
>  ~/qemu/tests/functional/test_virtio_version.py

For the whole series as is

 Tested-by: Daniel P. Berrangé <berrange@redhat.com>

as it does what you claim it does here when I tried it.

> The logs of the tests can be found in the build directory under
> tests/functional/<testname> - console log and general logs will
> be put in separate files there.

As an example, one dir name appears to be:

  __main__.MemAddrCheck.test_phybits_ok_pentium_pae

I'd rather prefer it if the dir name matched the test script
file name - in this case test_mem_addr_space.py, as I don't
want to have to lookup which class names were defined inside
each test script. We could drop the "test_" prefix from the
method name too

IOW, could we make this dir name be:

  test_mem_addr_space.phybits_ok_pentium_pae


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


