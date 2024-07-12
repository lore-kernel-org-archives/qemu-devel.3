Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9369C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 09:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSC9i-0001NS-EY; Fri, 12 Jul 2024 05:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSC9f-0001Mv-DE
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 05:01:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSC9Z-0007tA-Ka
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 05:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720774879;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=uHw4JvZ1pDEHxsamIQZBvT5BeJIYK7aR59BeUK6eKc8=;
 b=ZX2GO6BBAf7y7px8YfMqVC05/x0vuQRL0zGlC4YxdwaoLR06FnZkb2VPaGzUh9uFBy1TSe
 uRfF1i7aht6u2LkcccGryJ8wiqYIbE37RfMva+J5R9UtIklNdaYb1cVo2Gax80Imr5JHq9
 TofRccb5xE13AR4WN0AdXQ82Dxqs3mc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-SbIH1oetNzyKHn5AiPg2fQ-1; Fri,
 12 Jul 2024 05:01:13 -0400
X-MC-Unique: SbIH1oetNzyKHn5AiPg2fQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4DEDE195609F; Fri, 12 Jul 2024 09:01:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 41C501955F68; Fri, 12 Jul 2024 09:01:08 +0000 (UTC)
Date: Fri, 12 Jul 2024 10:01:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [RFC PATCH 4/8] tests/pytest: add pytest to the meson build system
Message-ID: <ZpDw0CiRvN_DvJqe@redhat.com>
References: <20240711115546.40859-1-thuth@redhat.com>
 <20240711115546.40859-5-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240711115546.40859-5-thuth@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Jul 11, 2024 at 01:55:42PM +0200, Thomas Huth wrote:
> From: Ani Sinha <ani@anisinha.ca>
> 
> Integrate the pytest framework with the meson build system. This
> will make meson run all the pytests under the pytest directory.

Lets add a note about the compelling benefit of this new approach

  With this change, each functional test becomes subject
  to an individual execution timeout, defaulting to 60
  seconds, but overridable per-test.

> 
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> [thuth: Removed the acpi-bits and adjusted for converted avocado tests instead]
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/Makefile.include   |  4 ++-
>  tests/meson.build        |  1 +
>  tests/pytest/meson.build | 53 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 57 insertions(+), 1 deletion(-)
>  create mode 100644 tests/pytest/meson.build

For CI purposes we'll need to add 'python3-pytest' to
tests/lcitool/projects/qemu.yml, and re-generate the
the dockerfiles. Some of the other non-gitlab CI
integrations probably need manual additions of pytest
packages.

> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index d39d5dd6a4..68151717d7 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -3,12 +3,14 @@
>  .PHONY: check-help
>  check-help:
>  	@echo "Regression testing targets:"
> -	@echo " $(MAKE) check                  Run block, qapi-schema, unit, softfloat, qtest and decodetree tests"
> +	@echo " $(MAKE) check                  Run block, qapi-schema, unit, softfloat, qtest, pytest and decodetree tests"
>  	@echo " $(MAKE) bench                  Run speed tests"
>  	@echo
>  	@echo "Individual test suites:"
>  	@echo " $(MAKE) check-qtest-TARGET     Run qtest tests for given target"
>  	@echo " $(MAKE) check-qtest            Run qtest tests"
> +	@echo " $(MAKE) check-pytest           Run pytest tests"
> +	@echo " $(MAKE) check-pytest-TARGET    Run pytest for a given target"

Or name it after the type of test rather than harness ?

 eg  check-functional / check-functional-TARGET

For that matter perhaps also for the dir name ?

   tests/functional/*.py

>  	@echo " $(MAKE) check-unit             Run qobject tests"
>  	@echo " $(MAKE) check-qapi-schema      Run QAPI schema tests"
>  	@echo " $(MAKE) check-block            Run block tests"
> diff --git a/tests/meson.build b/tests/meson.build
> index acb6807094..17510a468e 100644
> --- a/tests/meson.build
> +++ b/tests/meson.build
> @@ -85,3 +85,4 @@ subdir('unit')
>  subdir('qapi-schema')
>  subdir('qtest')
>  subdir('migration')
> +subdir('pytest')
> diff --git a/tests/pytest/meson.build b/tests/pytest/meson.build
> new file mode 100644
> index 0000000000..1486628d45
> --- /dev/null
> +++ b/tests/pytest/meson.build
> @@ -0,0 +1,53 @@
> +slow_pytests = {
> +  'mem_addr_space' : 90,
> +}
> +
> +pytests_generic = [
> +  'empty_cpu_model',
> +  'info_usernet',
> +  'version',
> +]
> +
> +pytests_x86_64 = [
> +  'cpu_queries',
> +  'mem_addr_space',
> +  'virtio_version',
> +]
> +
> +pytest = find_program('pytest', required: false)
> +if not pytest.found()
> +  message('pytest not available ==> Disabled the qemu-pytests.')
> +  subdir_done()
> +endif
> +
> +foreach dir : target_dirs
> +  if not dir.endswith('-softmmu')
> +    continue
> +  endif
> +
> +  target_base = dir.split('-')[0]
> +  pytest_emulator = emulators['qemu-system-' + target_base]
> +  target_pytests = get_variable('pytests_' + target_base, []) + pytests_generic
> +
> +  test_deps = roms
> +  pytest_env = environment()
> +  if have_tools
> +    pytest_env.set('PYTEST_QEMU_IMG', './qemu-img')
> +    test_deps += [qemu_img]
> +  endif
> +  pytest_env.set('PYTEST_QEMU_BINARY', meson.global_build_root() / 'qemu-system-' + target_base)
> +  pytest_env.set('PYTEST_SOURCE_ROOT', meson.project_source_root())
> +  pytest_env.set('PYTEST_BUILD_ROOT', meson.project_build_root())
> +  pytest_env.set('PYTHONPATH', meson.project_source_root() / 'python')
> +
> +  foreach test : target_pytests
> +    test('pytest-@0@/@1@'.format(target_base, test),
> +         pytest,
> +         depends: [test_deps, pytest_emulator, emulator_modules],
> +         env: pytest_env,
> +         args: [meson.current_source_dir() / 'test_' + test + '.py'],
> +         timeout: slow_pytests.get(test, 60),
> +         priority: slow_pytests.get(test, 60),
> +         suite: ['pytest', 'pytest-' + target_base])
> +  endforeach
> +endforeach
> -- 
> 2.45.2
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


