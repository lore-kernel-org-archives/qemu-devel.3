Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80BAC5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 11:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu6k8-0001bn-5H; Wed, 12 Aug 2026 07:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wu6jy-0001ZQ-M1
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 07:03:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wu6jr-0008AD-8b
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 07:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786532593;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YWSthwesr6AJ8PNxdBuAC8+eAjc+vNFZtjVD7z4VeVU=;
 b=L9rB31JXlANPXrGW8fyYWYcfQBmXLZa6SLEjoUHFBh4mHzquReEyCkXTHtwEQh1S3sSKd3
 D0HJvARfZyNXUV/tyQDXx1mzsMjfPvvyfUaonkYXEB0JAAz6MB4sgsJ0jgA1jAgBKxnyeY
 j/OC37yQArmPL01xaLamXtih6uT1v9g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-8LUqVvgzNousqBEA4OXfiA-1; Wed,
 12 Aug 2026 07:03:09 -0400
X-MC-Unique: 8LUqVvgzNousqBEA4OXfiA-1
X-Mimecast-MFC-AGG-ID: 8LUqVvgzNousqBEA4OXfiA_1786532587
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87B7A195608B; Wed, 12 Aug 2026 11:03:07 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E4DC195DF91; Wed, 12 Aug 2026 11:03:03 +0000 (UTC)
Date: Wed, 12 Aug 2026 12:03:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v6 103/103] docs/devel/testing/: update documentation
Message-ID: <anxS5H-ldefxUBpQ@redhat.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-104-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260728044248.137626-104-pierrick.bouvier@oss.qualcomm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Jul 27, 2026 at 09:42:47PM -0700, Pierrick Bouvier wrote:
> We document how to build and run tcg tests with new framework.
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  docs/devel/build-system.rst |  4 ++--
>  docs/devel/testing/main.rst | 33 ++++++++++++++++++++++-----------
>  2 files changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
> index 71331e64ac8..c64d40b42af 100644
> --- a/docs/devel/build-system.rst
> +++ b/docs/devel/build-system.rst
> @@ -447,8 +447,8 @@ these sub-Makefiles, the resulting build is largely non-recursive.
>  Tests, whether defined in ``meson.build`` or not, are also ran by the
>  Makefile with the traditional ``make check`` phony target, while benchmarks
>  are run with ``make bench``.  Meson test suites such as ``unit`` can be ran
> -with ``make check-unit``, and ``make check-tcg`` builds and runs "non-Meson"
> -tests for all targets.
> +with ``make check-unit``, and ``make check-tcg`` builds and runs tcg tests
> +for all targets.
>  
>  If desired, it is also possible to use ``ninja`` and ``pyvenv/bin/meson test``,
>  respectively to build emulators and run tests defined in meson.build.
> diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
> index c6821a36d99..9cbac144fdd 100644
> --- a/docs/devel/testing/main.rst
> +++ b/docs/devel/testing/main.rst
> @@ -1035,29 +1035,40 @@ See :ref:`container-ref` for more details.
>  Running subset of tests
>  ~~~~~~~~~~~~~~~~~~~~~~~
>  
> -You can build the tests for one architecture::
> +You can build the tcg tests using::
>  
> -  make build-tcg-tests-$TARGET
> +  make tcg-tests
>  
> -And run with::
> +And run them for one target with::
>  
> -  make run-tcg-tests-$TARGET
> +  make check-tcg-$TARGET
>  
>  Adding ``V=1`` to the invocation will show the details of how to
>  invoke QEMU for the test which is useful for debugging tests.
>  
> +Tests can also be run using directly meson test::
> +
> +  ./pyvenv/bin/meson test --suite tcg
> +  ./pyvenv/bin/meson test --suite tcg-$TARGET

For any binary that lives within the build dir, it is sufficient
to use the 'run' script which sets $PATH to search all build dir
locations, including the python venv.

IOW, this command should be just

   ./run meson test .....

Or probably slightly better as

  $BUILD-DIR/run meson test ...

to avoid the docs assumption that the user's CWD is at the root
of the build dir.

> +
> +Tests can be listed using::
> +
> +  ./pyvenv/bin/meson test --suite tcg --list
> +
>  Running individual tests
>  ~~~~~~~~~~~~~~~~~~~~~~~~
>  
> -Tests can also be run directly from the test build directory. If you
> -run ``make help`` from the test build directory you will get a list of
> -all the tests that can be run. Please note that same binaries are used
> -in multiple tests, for example::
> +Tests can also be run using directly meson test::
>  
> -  make run-plugin-test-mmap-with-libinline.so
> +  ./pyvenv/bin/meson test $TARGET-$TEST
>  
> -will run the mmap test with the ``libinline.so`` TCG plugin. The
> -gdbstub tests also re-use the test binaries but while exercising gdb.
> +For instance::
> +
> +  ./pyvenv/bin/meson test aarch64-softmmu-hello
> +
> +Test command and output can be accessed by using verbose flag::
> +
> +  ./pyvenv/bin/meson test aarch64-softmmu-hello --verbose
>  
>  TCG test dependencies
>  ~~~~~~~~~~~~~~~~~~~~~
> -- 
> 2.47.3
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


