Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1466CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 13:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMnZ7-0007xS-7B; Tue, 12 May 2026 09:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMnYQ-0006kX-1v
 for qemu-devel@nongnu.org; Tue, 12 May 2026 09:53:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMnY6-0003IC-Sq
 for qemu-devel@nongnu.org; Tue, 12 May 2026 09:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778594005;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E4IqHjXVkVDbhO+NYEvCSW0n+EPiCaAl3N+v2pE4U8Y=;
 b=Z0f1XT4BKiGnJKzmPboOpdCH7+TEUhNpIUrlA72QRf+n4sETeBYBs63xUZsvtau1pEZWeI
 pp9Qki2bOYo13OlhgKf1hhbq/BJ0w/RP5lq5ioL8SHRimB0kl/2F9w7na4ambjOPw+wGeN
 RBKMHkazQm7UazSVIv9FLlYx+8NX8To=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-WliClPLNOUC6XIdUmpUbbQ-1; Tue,
 12 May 2026 09:53:19 -0400
X-MC-Unique: WliClPLNOUC6XIdUmpUbbQ-1
X-Mimecast-MFC-AGG-ID: WliClPLNOUC6XIdUmpUbbQ_1778593998
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FF431955EAB; Tue, 12 May 2026 13:53:14 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.244])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 907B11800352; Tue, 12 May 2026 13:53:10 +0000 (UTC)
Date: Tue, 12 May 2026 14:53:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 00/16] tests: do more testing of block drivers
Message-ID: <agMwwti_xIHPNjEu@redhat.com>
References: <20260424154205.364268-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260424154205.364268-1-berrange@redhat.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

ping: is there any more feedback on series ?

I'd really like to get the block driver CI coverage improved
to prevent further regressions in currently untested drivers.

On Fri, Apr 24, 2026 at 04:41:48PM +0100, Daniel P. Berrangé wrote:
>  v1: https://lists.nongnu.org/archive/html/qemu-devel/2025-10/msg01650.html
>  v2: https://lists.nongnu.org/archive/html/qemu-devel/2026-01/msg02083.html
>  v3: https://lists.nongnu.org/archive/html/qemu-devel/2026-01/msg02939.html
>  v4: https://lists.nongnu.org/archive/html/qemu-devel/2026-02/msg03245.html
>  v5: https://lists.nongnu.org/archive/html/qemu-devel/2026-03/msg01252.html
> 
> The recent (at the time of v1) set of regressions identified in the LUKS
> block driver re-inforced that despite having a hugely useful set of I/O
> tests, our CI coverage is still letting through too many bugs.
> 
> The core goals of this series were/are:
> 
>  * Add LUKS and NBD to the tested formats/protocols
>    integrated into "make check-block SPEED=thorough"
> 
>  * Ensure that all qcow2 tests can be run with "SPEED=slow",
>    not staying limited to only the 'auto' group used by the
>    'make check-block' target in its default 'quick' mode
> 
>  * Add  'make check-block-$FORMAT' to expose a standalone
>    target for running all tests for a given format (or
>    equivalently a protocol)
> 
>  * Add GitLab CI jobs for exercising tests for all formats
> 
> A sample pipeline for this is
> 
>   https://gitlab.com/berrange/qemu/-/pipelines/2258731804/
> 
> Showing the 'block-FORMAT' jobs which test the 10 block formats/protocols
> currently enabled.
> 
> This series fixes a couple of bugs
> 
>  * Test 128 check for device mapper usage doesn't work
>    sufficiently well to detect gitlab's containe env
>    can't do dynamic devfs
> 
>  * Test 185 is reliably failing on gitlab
> 
>  * Two tests fail when run on CentOS 9 because they trigger
>    python deprecation warnings. This will be fixed when the
>    python-qemu-qmp module is next released.
> 
> Testing of pipelines throughout development of v1-v5 postings does not
> exhibit any non-deterministic failures with the shared runners. Hopefully
> that will apply to QEMU's private runners used forthe staging tree too.
> 
> At this point it is a chicken & egg problem though.
> 
> If we don't bite the bullet and enable block I/O tests in GitLab CI for
> everyone, we'll never find out if they're truely stable enough to rely
> on.
> 
> As a mitigation against instability a patch in this series adds a new
> QEMU_TEST_IO_SKIP env variable that we are able to set as a GitLab CI
> env variable. This lets us skip broken tests dynamically without waiting
> for a git commit to disable them in the buildtest.yml config that we
> use for disabling the 3 known broken tests currently.
> 
> Changed in v6:
> 
>   - Drop redundant change from gitlab yml config
>   - Pull in rebase for qemu.qmp to 0.6.0 to fix two tests
>     by avoiding deprecation warnings
> 
> Changed in v5:
> 
>   - Adapt for python-qemu-qmp being spun off, by temp disabling
>     tests that are broken by it, that we formerly fixed in-tree.
> 
> Changed in v4:
> 
>   - Remove tests from build-tcg-disabled job
> 
> Changed in v3:
> 
>   - Test whether dmsetup create device appeared or not, instead
>     of unconditionally skipping test 128 in GitLab
>   - Use 'driver' term instead of 'format' or 'protocol'
>   - Fix misc typos & rephrasing
> 
> Daniel P. Berrangé (15):
>   gitlab: ensure all meson jobs capture build/meson-logs by default
>   tests: print reason when I/O test is skipped in TAP mode
>   tests: remove redundant meson suite for iotests
>   tests: ensure all qcow2 I/O tests are able to be run via make
>   scripts/mtest2make: ensure output has stable sorting
>   scripts/mtest2make: support optional tests grouping
>   tests: add a meson suite / make target per block I/O tests format
>   docs/devel/testing: expand documentation for 'make check-block'
>   tests: add nbd and luks to the I/O test suites
>   tests: use 'driver' as collective term for either format or protocol
>   tests: validate dmsetup result in test 128
>   tests: fix check for sudo access in LUKS I/O test
>   tests: add QEMU_TEST_IO_SKIP for skipping I/O tests
>   gitlab: add jobs for thorough block tests
>   gitlab: remove I/O tests from build-tcg-disabled job
> 
> John Snow (1):
>   python: bump qemu.qmp to v0.0.6
> 
>  .gitlab-ci.d/buildtest-template.yml           |  30 +++--
>  .gitlab-ci.d/buildtest.yml                    | 107 ++++++++++++++++--
>  docs/devel/testing/main.rst                   |  33 +++++-
>  python/scripts/vendor.py                      |   4 +-
>  ...ny.whl => qemu_qmp-0.0.6-py3-none-any.whl} | Bin 72263 -> 72379 bytes
>  pythondeps.toml                               |   2 +-
>  scripts/mtest2make.py                         |  30 +++--
>  tests/Makefile.include                        |   3 +-
>  tests/qemu-iotests/128                        |   6 +
>  tests/qemu-iotests/149                        |  13 ++-
>  tests/qemu-iotests/meson.build                |  59 ++++++++--
>  tests/qemu-iotests/testrunner.py              |  18 ++-
>  12 files changed, 254 insertions(+), 51 deletions(-)
>  rename python/wheels/{qemu_qmp-0.0.5-py3-none-any.whl => qemu_qmp-0.0.6-py3-none-any.whl} (64%)
> 
> -- 
> 2.53.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


