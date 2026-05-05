Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3614FF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 17:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKJ9J-00080t-40; Tue, 05 May 2026 13:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKJ98-0007xi-G3
 for qemu-devel@nongnu.org; Tue, 05 May 2026 13:01:24 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wKJ94-0003UG-BE
 for qemu-devel@nongnu.org; Tue, 05 May 2026 13:01:21 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so53515885e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 10:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778000475; x=1778605275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bKklbuX1VAfH8Rd1ctg6YvjCIythWLv8NYmd4ccPk6k=;
 b=mzmKUIHe22IOTSZncgEb6XQhj24Awiv4MZHDtsstjL96fFiNaU7HlZN1R3/fgJZbpX
 OERRvG2fwX5ZCRPkoEAif7+vviKqwfKOPoFHNCbPpmEd3UsdiMGJm3qnu+xFFF3DHr3q
 ZxepzKlwbUr8hR1WP0e+boQ3agDcSD6YsR8233CdWXrllCaO5POUxMr6C4iFo7mv9y7e
 Dng+WJ0of81Gccbv+VDvZGYzp8p6s4cAiObTWmjw8nYgX4QYXD7wPM0l3fa+V/RiETj4
 C2ScjZ7E+ZzqS+5eMPL3i2bxGQSF8dpuJ6mnCGlhuAqtSDmyuwhkFOG4KD6yXDESqPfg
 9V8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778000475; x=1778605275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bKklbuX1VAfH8Rd1ctg6YvjCIythWLv8NYmd4ccPk6k=;
 b=O0PuqLsEOVZ1DF8T8eEkovnzHRB+CCfHUXP8MxoJJ4jwqE70/nwReX1J/7eTjoKAkz
 VyUSjMdWTcJ2oAHKipWIjBHYmuO22qthbl8A9IMIICu4bPIiAg9OcGwICWIe2tG02H6n
 Pt9ev7NlOzudzGGVceNznjjh3JTmwwT9idqOfqlMx0YvUq6JqsFmN6G1drKM4fNRSa7m
 65YeZoDnCcWZrb9DnGXhpEPayD2PcGpUhFk6Kf63Bxa2vwbBiQMja7dGKeX8UAlHgOFv
 AEe7jBteCWwq7YD2kj1LhUqxqbFCcgYhpHNt4agHP/RveHIlXh7oUkzkfn4VgR1DVsbr
 VLoA==
X-Gm-Message-State: AOJu0YwEhwJiSl5f+Xm9ba5XY6Rzua5fSpL49WIKA7pUJ9+WPp2GzHdE
 ZFUE4MY/ZZHuWc64DotO0HuyPyLmt5EZIomf0Fe1k/5wsulR7da2zm9cB6Vwr359hVl/KXEBuLM
 Grz8RlMo=
X-Gm-Gg: AeBDievASC99SPldS+3xTw+tp7t94FHAYYrMh6Da1B1rCw+7Y3GT9YHBUgujTjnQbP4
 1/x9Zo8ScVsmxxega+z1m7jvU1yCDpf0IC2JLcJuj9ZicGScBsQJ6k/2kidLy9YzInkJzdIGLo+
 5PBgvV7S4HAFUA5WJQvgdom5Di/7TYQgUESRUKM97iccR2RPxVO5qbvW4G1VKbaQVtsFtdt5Llb
 8t6j79p92L+CCGgiIdFJnzxJh15lNO5PXjYs3VpzZcRfoRmnneTs/jLGqss84wNmVzucQY8x2qU
 pkvVQiodBp9Vrz+J0acQHkW3CtVZJFKV7SmtKhAmHb3uqVIcwLZeNlrJ3k3thvao3Q+oyZwQB+/
 pr/fLFH8MRP5KVMVxe18x7ZHevbDQ+9Ik8vnc0wx+l3bI1MzJkChLXIwmXujIS0BcbXhk846cbW
 3NoxRBegpmyWIxcTmFiXzqsy6Ak6sGMIA52w==
X-Received: by 2002:a05:600c:3b96:b0:48a:66a8:9981 with SMTP id
 5b1f17b1804b1-48e51f55272mr355415e9.27.1778000474983; 
 Tue, 05 May 2026 10:01:14 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a82308d77sm478692875e9.14.2026.05.05.10.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 10:01:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8B5C1604BD;
 Tue, 05 May 2026 18:01:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 06/10] .agents/skills: add qemu-testing skill
Date: Tue,  5 May 2026 18:01:01 +0100
Message-ID: <20260505170105.228162-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260505170105.228162-1-alex.bennee@linaro.org>
References: <20260505170105.228162-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This provides basic instructions for running tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .agents/skills/qemu-testing/SKILL.md | 53 ++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 .agents/skills/qemu-testing/SKILL.md

diff --git a/.agents/skills/qemu-testing/SKILL.md b/.agents/skills/qemu-testing/SKILL.md
new file mode 100644
index 00000000000..3b7b42109e1
--- /dev/null
+++ b/.agents/skills/qemu-testing/SKILL.md
@@ -0,0 +1,53 @@
+---
+name: qemu-testing
+description: Provides instructions on how to find, list, and run individual tests for QEMU (Unit, QTest, Functional, TCG). You MUST use this skill whenever the user asks about tests, wants to list available tests, or wants to run any test in a build directory, even for simple exploratory queries like "what tests can I run". It includes details about spawning sub-agents.
+license: GPL-2.0-or-later
+---
+
+# Instructions
+To run QEMU tests, you can use several different suites depending on what you are testing. **Note**: Ensure you have a recent build of QEMU before running tests. Use the `qemu-build` skill if you need to configure or run a build.
+
+## General Test Suites
+- **Unit Tests**: `make check-unit`
+- **QTest (Device emulation)**: `make check-qtest`
+- **Functional Tests (Python based)**: `make check-functional`
+- **TCG Tests (CPU instruction tests)**: `make check-tcg`
+
+## Launching Tests
+**Crucial**: You MUST NEVER run a test suites directly in the main agent context. You MUST ALWAYS launch them by spawning a sub-agent. Pass the specific build or test commands, along with the required build directory, in the `task` argument. Give the subagent explicit instructions on what to verify and what to report back to you.
+For example: `task: "Navigate to builds/debug and check what meson tests touch replay and report back."` or `task: "Run make check-tcg in builds/arm and summarize any failing tests."`
+
+### From the Build Directory
+Most individual tests from within a build directory. Most (unit, qtest, block, functional) can be individually selected and run via meson.
+
+As QEMU often needs a newer meson than the build host you should use the build `pyenv` to launch it:
+- **Example**: `./pyvenv/bin/meson test --suite thorough --list` to see what tests are in the thorough test suite
+
+## Running Individual Tests
+
+### Meson Test Runner (Unit, QTest, Functional, softfloat etc)
+To run a single test, you can use the meson test runner from within your pyvenv:
+`./pyvenv/bin/meson test [testname]`
+Example: `./pyvenv/bin/meson test qtest-x86_64/boot-serial-test`
+
+### TCG Tests
+To run individual TCG tests for a specific architecture:
+1. Navigate to the relevant build directory, e.g.: `cd tests/tcg/aarch64-softmmu`
+2. Run a specific test with make: `make run-[testname]`
+   Example: `make run-memory-sve`
+3. Use `make help` within the architecture directory to see the full list of available tests.
+
+### Functional Tests
+Individual functional tests can be run directly using the run script although from the source directory:
+- **Example**: `./builds/all/run tests/functional/aarch64/test_virt_vbsa.py`
+
+### Environment Variables
+- `V=1` for verbose output from tests.
+- `SPEED=slow` to run slower tests that are normally skipped.
+
+## Reporting Results
+**Crucial**: After completing the build and test tasks, provide a concise summary of the results to the calling agent.
+1. **Summary**: State whether the build and tests passed or failed.
+2. **Failure Excerpts**: If any task fails, include relevant excerpts from the logs (e.g., compiler errors, test failures).
+3. **Full Paths**: Always provide the **absolute file paths** to the full logs and result sets for further inspection.
+
-- 
2.47.3


