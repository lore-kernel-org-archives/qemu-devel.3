Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2028C606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K0FLfcxv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLO0m-0007HG-LF; Mon, 26 Oct 2026 12:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xLO0k-0007Gl-CC
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:57:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xLO0h-0004AK-Ly
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 12:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793033842;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=5INXLLNN0MyDgnwWxMMPclKJ1zb8RbKJCFFTaWgHeP8=;
 b=K0FLfcxvCRmuYJu5UcGaO+8P6/Q9x2DbwvDDuOmi/Ty859LC86vfD4iva9eMwotpLgzhEI
 MTVsbSM6X5wgSqD/7O61tI8ViI3PSubQA5mN3QhfxTF2HWAs5CXx384haipNaxM7aXGoPa
 jH5OZ2Ca+Zf7i6s2/RKmShWyUwpOcWU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-Yl9okfvrMu2Q7cSd89KTSw-1; Mon,
 26 Oct 2026 12:57:21 -0400
X-MC-Unique: Yl9okfvrMu2Q7cSd89KTSw-1
X-Mimecast-MFC-AGG-ID: Yl9okfvrMu2Q7cSd89KTSw_1793033840
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3AE11955D54; Mon, 26 Oct 2026 16:57:19 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F01A518004D2; Mon, 26 Oct 2026 16:57:17 +0000 (UTC)
Date: Mon, 26 Oct 2026 16:57:15 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Anatol Belski <anbelski@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, th.huth+qemu@posteo.eu, mvaralar@redhat.com,
 philmd@oss.qualcomm.com, pbonzini@redhat.com, zhao1.liu@intel.com
Subject: Re: [PATCH v2] tests: Add virtio-villain fault injection suite
Message-ID: <at-Ga9X6fAmhptCK@redhat.com>
References: <20261001210916.1907716-1-anbelski@linux.microsoft.com>
 <20261025234922.1766842-1-anbelski@linux.microsoft.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261025234922.1766842-1-anbelski@linux.microsoft.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 12:49:22AM +0100, Anatol Belski wrote:
> Add a test suite that drives the virtio-villain harness against QEMU.
> virtio-villain is a guest side fault injection tool that boots a
> separate guest for each case. Each case supplies invalid virtio driver
> input to test how the device model handles it.
> 
> The harness is added as a git submodule under tests/virtio-villain.
> Case IDs are discovered from source filenames during configuration
> and each case is registered as a Meson test. Meson controls parallel
> execution and timeouts, with one case per runner invocation.
> 
> The suite builds the static guest initramfs and fetches kernels on
> demand for native Linux x86_64 and aarch64 hosts. Generated artifacts
> stay in the build directory and kernel downloads use the QEMU asset
> cache.
> 
> The virtio-villain and check-virtio-villain make targets build and run
> the suite without adding it to the default check target. Each case
> retains readable logs and JSON reports, with skipped cases reported
> separately from successful tests. Embedded helper tests and
> documentation are included.
> 
> Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>

snip

> diff --git a/docs/devel/testing/virtio-villain.rst b/docs/devel/testing/virtio-villain.rst
> new file mode 100644
> index 0000000000..a4a100f49d
> --- /dev/null
> +++ b/docs/devel/testing/virtio-villain.rst
> @@ -0,0 +1,102 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +virtio-villain
> +==============
> +
> +The virtio-villain suite tests how QEMU handles invalid virtio driver
> +input. The harness boots a separate guest for each case to isolate
> +crashes. Meson registers each case individually and controls parallel
> +execution, timeouts and results.
> +
> +Requirements
> +------------
> +
> +The suite supports native Linux x86_64 and aarch64 hosts with the
> +matching system emulator enabled and access to ``/dev/kvm``.

What part of it requires use of /dev/kvm ?  The virtio devices can
be used under TCG, albeit with a much slower test suite.

If we didn't have the KVM dep, then we could run it under gitlab
CI.

> +Cross compilation is not supported.
> +Building the static guest init requires make, strip, cpio, gzip and
> +a compiler with static C library support. The build prefers musl-gcc
> +when available and otherwise uses the native compiler recorded by
> +Meson, including its compiler arguments.

What's the goal with preferring musl-gcc ?

I get the standalone virtio-villain harness may be preferring
musl-gcc and that's fine, but for integration in QEMU, I would
expect it to always honour the C compiler configured by meson
and nothing else.

> +Running the suite
> +-----------------
> +
> +From the QEMU checkout, run::
> +
> +  make -C build-release virtio-villain

When running 'configure' from the src tree, QEMU auto-creates
a 'build' directory. So our makefiles "do the right thing"
whether run from the root of the buld directory or from the
source directory.

The only people needing to use '-C  ...somedir...' are those
who want a different build directory name while using make
from the  source dir.

This is along winded way of saying just drop the '-C build-release'
part from the docs examples, and assume our defaults.[

> +
> +Replace ``build-release`` with your build directory. Use ``make -jN``
> +to control how many cases Meson runs concurrently::
> +
> +  make -C build-release -j16 virtio-villain

This bit can be dropped - it is not specific to this test suite
and -jNN is normal stuff anyone knows when using make, so can
drop that arg from all the examples.

> +The ``virtio-villain`` target invokes ``check-virtio-villain``.

I don't see a benefit to creating a 'virtio-villain' target, we
can just document 'check-virtio-villain' as that fits in with
our other 'check-functional', 'check-qtest', 'check-block', etc
naming conventions.


> +The target builds the guest initramfs and fetches kernels on demand.
> +Neither operation runs during a normal QEMU build. Generated files
> +stay under the build directory. Kernel downloads
> +reuse the QEMU asset cache and verify the SHA256 checksum. Set
> +``QEMU_TEST_CACHE_DIR`` to override the cache location or
> +``QEMU_TEST_NO_DOWNLOAD=1`` to require cached kernels.
> +
> +This standalone suite is not part of the functional tests or the
> +default ``make check`` selection. Its Meson suite name is
> +``virtio-villain-optional``, following the QEMU optional suite convention.
> +To run one case directly through Meson::
> +
> +  build-release/pyvenv/bin/meson test -C build-release RNG0001-basic

We prefer to point people to the 'run' script in the build dir:

  $BUILD-DIR/run meson test  RNG0001-basic

> +Filtering cases
> +---------------
> +
> +Meson test names combine the case ID with a description from the source
> +filename, for example ``RNG0001-basic``. The suite identifies them as
> +virtio-villain tests without repeating that prefix in every name.
> +
> +Pass Meson name filters through ``MTESTARGS`` to run one case by ID::
> +
> +  make -C build-release virtio-villain MTESTARGS='RNG0001-*'
> +
> +Use a wildcard to run a group of cases::
> +
> +  make -C build-release -j16 virtio-villain MTESTARGS='RNG*'
> +
> +Multiple filters select the union of their matches::
> +
> +  make -C build-release -j16 virtio-villain \
> +    MTESTARGS='RNG* B0196-*'
> +
> +List matching cases without running them::
> +
> +  build-release/pyvenv/bin/meson test -C build-release \
> +    --suite virtio-villain-optional --list 'RNG*'
> +
> +Quote wildcard filters to prevent shell expansion. These are Meson
> +test name filters, not the directory filters of the villain runner.
> +
> +Results and logs
> +----------------
> +
> +Each invocation runs one case with the QEMU binary from the build.
> +
> +PASS and REJECT pass. SKIP and XFAIL are reported as skipped.
> +FAIL, WEDGED and XPASS fail. Runner errors and missing reports fail
> +rather than appearing as successful tests. Unsupported devices and
> +unavailable host services are skipped by the harness.
> +
> +Meson reports each case separately and writes its standard text and
> +JUnit reports under ``<build>/meson-logs/``. Full readable case logs
> +and JSON reports are retained under
> +``<build>/tests/virtio-villain-build/logs/<case>.log`` and ``<case>.json``.
> +The test output always points to its case log.
> +
> +The reporting helper has embedded unit tests that run without a VM::
> +
> +  python3 tests/virtio-villain-test.py --self-test

If I run the villain tests on current QEMU with this patch applied
I get a number of failures. I assume that is expected currently ?


Summary of Failures:

 254/1964 virtio-villain-optional - qemu:B0173-xq-write-read-verify                   FAIL            2.07s   exit status 1
 398/1964 virtio-villain-optional - qemu:B0201-hotplug-remove-readd                   FAIL           17.61s   exit status 1
 671/1964 virtio-villain-optional - qemu:M0019-mmio-queue-num-max-read                FAIL            5.32s   exit status 1
1182/1964 virtio-villain-optional - qemu:P0060-packed-desc-addr-pci-bar               FAIL           30.36s   exit status 1
1207/1964 virtio-villain-optional - qemu:PCI0200-remove-during-kick                   FAIL           14.41s   exit status 1
1504/1964 virtio-villain-optional - qemu:SND0005-info-size-short                      FAIL            1.19s   exit status 1
1514/1964 virtio-villain-optional - qemu:SND0012-pcm-info-size-zero                   FAIL            1.80s   exit status 1
1523/1964 virtio-villain-optional - qemu:SND0015-pcm-info-status-short                FAIL            2.41s   exit status 1
1563/1964 virtio-villain-optional - qemu:SND0065-tx-missing-status                    FAIL            1.73s   exit status 1
1566/1964 virtio-villain-optional - qemu:SND0066-tx-status-short                      FAIL            1.81s   exit status 1
1571/1964 virtio-villain-optional - qemu:SND0076-rx-status-short                      FAIL            1.56s   exit status 1
1573/1964 virtio-villain-optional - qemu:SND0078-rx-header-only                       FAIL            1.52s   exit status 1
1593/1964 virtio-villain-optional - qemu:SND0088-tx-status-readable                   FAIL            2.05s   exit status 1
1963/1964 virtio-villain-optional - qemu:T0063-desc-addr-pci-bar                      FAIL           30.53s   exit status 1




> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 9f82552ab5..d5cca6a0d1 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -16,6 +16,7 @@ check-help:
>  	@echo " $(MAKE) check-tracetool               Run tracetool generator tests"
>  	@echo " $(MAKE) check-block                   Run block tests (all formats/protocols)"
>  	@echo " $(MAKE) check-block-DRIVER            Run block tests (only for format/protocol 'DRIVER')"
> +	@echo " $(MAKE) virtio-villain                 Run the standalone virtio fault injection suite"

s/virtio-villain/check-virtio-villain/        and    ^^^ minor alignment bug

>  ifneq ($(filter $(all-check-targets), check-softfloat),)
>  	@echo " $(MAKE) check-softfloat               Run FPU emulation tests"
>  	@echo " $(MAKE) check-tcg                     Run TCG tests"
> @@ -55,6 +56,10 @@ check-functional:
>  .PHONY: check-func check-func-quick
>  check-func check-func-quick:
>  
> +.PHONY: virtio-villain
> +virtio-villain:
> +	@$(MAKE) check-virtio-villain

IMHO this is redundant and can be dropped.


> diff --git a/tests/meson.build b/tests/meson.build
> index 5877d2f60b..619e24c78c 100644
> --- a/tests/meson.build
> +++ b/tests/meson.build
> @@ -1,6 +1,52 @@
>  subdir('bench')
>  subdir('qemu-iotests')
>  

A few blank lines in places below would do wonders for
readability.

> +if host_os == 'linux' and not meson.is_cross_build() and \
> +   cpu in ['x86_64', 'aarch64'] and \
> +   emulators.has_key('qemu-system-' + cpu)
> +  villain_make = find_program('make', required: false)
> +  villain_strip = find_program('strip', required: false)
> +  villain_cpio = find_program('cpio', required: false)
> +  villain_gzip = find_program('gzip', required: false)

<blank>

> +  if villain_make.found() and villain_strip.found() and \
> +     villain_cpio.found() and villain_gzip.found()
> +    villain_list = files('virtio-villain-list.py')
> +    villain_list_args = get_option('wrap_mode') == 'nodownload' ? ['--no-download'] : []

<blank>

> +    villain_names = run_command(
> +      python, villain_list, villain_list_args, check: true
> +    ).stdout().strip().split()
> +    villain_sources = run_command(
> +      python, villain_list, villain_list_args, '--sources', check: true
> +    ).stdout().strip().split('\n')

<blank>

> +    villain_musl = find_program('musl-gcc', required: false)
> +    villain_cc = villain_musl.found() ? [villain_musl.full_path()] : \
> +                                      meson.get_compiler('c', native: true).cmd_array()
> +    villain_build_dir = meson.current_build_dir() / 'virtio-villain-build'

<blank>

> +    villain_initramfs = custom_target(
> +      'virtio-villain-initramfs',
> +      output: 'virtio-villain-initramfs.stamp',
> +      command: [python, files('virtio-villain-build.py'),
> +                '--source', meson.current_source_dir() / 'virtio-villain',
> +                '--build', villain_build_dir, '--arch', cpu,
> +                '--stamp', '@OUTPUT@', '--make', villain_make.full_path(),
> +                '--'] + villain_cc,
> +      depend_files: files(villain_sources + ['functional/qemu_test/asset.py']),
> +      build_by_default: false)

<blank>

> +    foreach name : villain_names
> +      test(name, python,
> +           args: [files('virtio-villain-test.py'),
> +                  '--build', villain_build_dir,
> +                  '--source', meson.current_source_dir() / 'virtio-villain',
> +                  '--qemu', emulators['qemu-system-' + cpu].full_path(),
> +                  name.split('-')[0]],
> +           depends: [villain_initramfs, emulators['qemu-system-' + cpu]],
> +           suite: ['virtio-villain-optional'], timeout: 90)
> +    endforeach
> +  else
> +    message('virtio-villain requires make, strip, cpio and gzip')
> +  endif
> +endif
> +
>  test_qapi_outputs = [
>    'qapi-builtin-types.c',
>    'qapi-builtin-types.h',


If we can run without a KVM dep, then it would be nice to add this into
GitLab CI, by adding to the .gitlab-ci.yml.d/buildtest.yml file:

virtio-villain:
  extends: .native_test_job_template
  needs:
    - job: build-system-fedora
      artifacts: true
  variables:
    IMAGE: fedora
  script:
    - cd build
    - make -j"$JOBS" check-virtio-villain
  allow-failure: true

obviously it would be better not to have the 'allow-failure: true'
bit. Those failures mentioned earlier would need fixing first but
I assume we want to address those bugs quickly regardless.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


