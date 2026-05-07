Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67ED3CD3442
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 08:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKthr-0003hi-7B; Thu, 07 May 2026 04:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wKthi-0003gM-U4
 for qemu-devel@nongnu.org; Thu, 07 May 2026 04:03:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wKthh-0004dQ-1i
 for qemu-devel@nongnu.org; Thu, 07 May 2026 04:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778141008;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E2oVkXubTiXT1SMX7PKPRVECF5DFIWlUie3bYbzfDW8=;
 b=fhyv9vGmZ95Hdn8D2IHyoLvsl+bQHEt/qhauEWSyZH5+WR3J7w3aM6OKL2vNGNvBYh5+Pd
 SLvewHI5IdPghrOYWQqUIPU7kKD1kzFu4smPbCzguvF7Qhk1zwRDMy5IWuDEOZ6eS9Ob3r
 MxK8EoTwRXoBx90rZE2zkSeKZ9PCUYk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-dnMovD6rMxWkzXYaFf6nrA-1; Thu,
 07 May 2026 04:03:24 -0400
X-MC-Unique: dnMovD6rMxWkzXYaFf6nrA-1
X-Mimecast-MFC-AGG-ID: dnMovD6rMxWkzXYaFf6nrA_1778141004
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EAFD719560B5; Thu,  7 May 2026 08:03:23 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.217])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B41B11953947; Thu,  7 May 2026 08:03:22 +0000 (UTC)
Date: Thu, 7 May 2026 09:03:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 06/10] .agents/skills: add qemu-testing skill
Message-ID: <afxHRn6ft1ABjWDw@redhat.com>
References: <20260505170105.228162-1-alex.bennee@linaro.org>
 <20260505170105.228162-7-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260505170105.228162-7-alex.bennee@linaro.org>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 05, 2026 at 06:01:01PM +0100, Alex Bennée wrote:
> This provides basic instructions for running tests.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .agents/skills/qemu-testing/SKILL.md | 53 ++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 .agents/skills/qemu-testing/SKILL.md
> 
> diff --git a/.agents/skills/qemu-testing/SKILL.md b/.agents/skills/qemu-testing/SKILL.md
> new file mode 100644
> index 00000000000..3b7b42109e1
> --- /dev/null
> +++ b/.agents/skills/qemu-testing/SKILL.md
> @@ -0,0 +1,53 @@
> +---
> +name: qemu-testing
> +description: Provides instructions on how to find, list, and run individual tests for QEMU (Unit, QTest, Functional, TCG). You MUST use this skill whenever the user asks about tests, wants to list available tests, or wants to run any test in a build directory, even for simple exploratory queries like "what tests can I run". It includes details about spawning sub-agents.
> +license: GPL-2.0-or-later
> +---
> +
> +# Instructions
> +To run QEMU tests, you can use several different suites depending on what you are testing. **Note**: Ensure you have a recent build of QEMU before running tests. Use the `qemu-build` skill if you need to configure or run a build.
> +
> +## General Test Suites
> +- **Unit Tests**: `make check-unit`
> +- **QTest (Device emulation)**: `make check-qtest`
> +- **Functional Tests (Python based)**: `make check-functional`
> +- **TCG Tests (CPU instruction tests)**: `make check-tcg`
> +
> +## Launching Tests
> +**Crucial**: You MUST NEVER run a test suites directly in the main agent context. You MUST ALWAYS launch them by spawning a sub-agent. Pass the specific build or test commands, along with the required build directory, in the `task` argument. Give the subagent explicit instructions on what to verify and what to report back to you.
> +For example: `task: "Navigate to builds/debug and check what meson tests touch replay and report back."` or `task: "Run make check-tcg in builds/arm and summarize any failing tests."`
> +
> +### From the Build Directory
> +Most individual tests from within a build directory. Most (unit, qtest, block, functional) can be individually selected and run via meson.
> +
> +As QEMU often needs a newer meson than the build host you should use the build `pyenv` to launch it:
> +- **Example**: `./pyvenv/bin/meson test --suite thorough --list` to see what tests are in the thorough test suite
> +
> +## Running Individual Tests
> +
> +### Meson Test Runner (Unit, QTest, Functional, softfloat etc)
> +To run a single test, you can use the meson test runner from within your pyvenv:
> +`./pyvenv/bin/meson test [testname]`
> +Example: `./pyvenv/bin/meson test qtest-x86_64/boot-serial-test`
> +
> +### TCG Tests
> +To run individual TCG tests for a specific architecture:
> +1. Navigate to the relevant build directory, e.g.: `cd tests/tcg/aarch64-softmmu`
> +2. Run a specific test with make: `make run-[testname]`
> +   Example: `make run-memory-sve`
> +3. Use `make help` within the architecture directory to see the full list of available tests.
> +
> +### Functional Tests
> +Individual functional tests can be run directly using the run script although from the source directory:
> +- **Example**: `./builds/all/run tests/functional/aarch64/test_virt_vbsa.py`
> +
> +### Environment Variables
> +- `V=1` for verbose output from tests.
> +- `SPEED=slow` to run slower tests that are normally skipped.

When I read this, I note there is some significant overlap with what
we write in docs/devel/testing/. 

Would it still be effective enough to merely point the agents to
docs/devel/testing and get rid of most text in this section ?

> +
> +## Reporting Results
> +**Crucial**: After completing the build and test tasks, provide a concise summary of the results to the calling agent.
> +1. **Summary**: State whether the build and tests passed or failed.
> +2. **Failure Excerpts**: If any task fails, include relevant excerpts from the logs (e.g., compiler errors, test failures).
> +3. **Full Paths**: Always provide the **absolute file paths** to the full logs and result sets for further inspection.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


