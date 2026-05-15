Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF351CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 16:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNvRc-0005pC-8j; Fri, 15 May 2026 12:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wNvRJ-0005dn-Ni
 for qemu-devel@nongnu.org; Fri, 15 May 2026 12:31:11 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wNvRF-000271-S2
 for qemu-devel@nongnu.org; Fri, 15 May 2026 12:31:04 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48a7fe4f40bso217685e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 09:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778862660; x=1779467460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HobXv/ZPpEyLO9e5ogFd3ATowL5cDOBGGwo/E53v5G8=;
 b=kPvsyg1zXQxpkhDtDIfszfIprNtOvZYvXNC/F3iWmjMritWvlJe3dXH3Xxl5v9mgh+
 WZnmgEBRVDX1XWoxOr2L3fYroiT645BALa189MPkQBAn3Gme7uZj/MRT2kiR36UKkHGj
 xrc+0b9gp3FKfjUFrLu/91gDb/VXqUSBYCmpAAF+SnCvMMH3FEE5VwHS8q3UeGaaz0Wz
 F33rai/lF0UR/d4E2Tzedn8R2ph6skSgeuEF4jcUftc0lVg/v9QNdQNUZwTUqgpXNcbT
 VU+A28BfHKNJuTRqiYqd4TsFXqHC3/2zSKKMA/ZwThlmiXbuvU8/tF5xdSwyTfqW8vHc
 dZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778862660; x=1779467460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HobXv/ZPpEyLO9e5ogFd3ATowL5cDOBGGwo/E53v5G8=;
 b=fkfehVe0y4HNzYls+ZtplDtztcvgSajWglp/iG1lXRLfVl10tRXStXTO1PUdvuOMqF
 Y1viGAPVKAPq+9l4PhyZBZIvkjZSDb5GZ/y59I/8qhAWizXPLbu4qx/ljNcbYmPoxSK2
 o9nIz+C+6LeeYKw3ylBNLd62uQAOcOhGEwhBEjvPyQzh9PW/hGb5RdFzHZc9A8cKlPLw
 Qcaxz3vGjxb2yeNbFWc1TS8PoUTtG5vCaa72RV3yGqq8TqybHEGUUrYkLOM0SV2Kr4ST
 82Fwczl4L3Qt5xq63YH/7HoUWDwlslO0Svh018S2BBrnCzFp7/pi8hywhhx2+mCM9t5k
 OPIA==
X-Gm-Message-State: AOJu0Yz2He/7uJJ4/49xsKbJRFlCctjXxE/aMKVk31aX4TdTz2Uwniv6
 LRbWuVNhW1qORRGoV04BMUZsHcK0l0I/hfgBh699UtrcucZReIpOxFEN8vYi6Hz2DM8=
X-Gm-Gg: Acq92OG2yHsHZmoX7wd3X4ocjfcLp8vKoKs2kIqRX9buMixpihvzW8alN0JQHA1+Yt4
 43lCdcJaQVCimdm+eXv6y2BO1JF/WJODlb2tdaSM+YNcbAm3/J9Gwy1FmOQbAs8Rddf3tOFcTqd
 0IO+iVCydbcJ+iKJLqT05rf5sb5EE4XUlLdAV0z89K8Z6J02QWHBTaouLBTETf4zaySa6p8bGan
 rcHti42ygP0GC4nR9PuBqjbnmEUOrDy0rKUhp21W+ljughkPXoMDJaGSVwVZzW0CzPRE68OaFpD
 vLQjZviVfxt9qvdcQlN1b8JkqLWbCSAEqNzNZ1PCa3hgdAmxmnXQsK0EJVgLKnqCPI5mnv/TPGl
 D5G9eIL+uXaRznxoT92bFjmEBu0j3G+RjXvBx6CVGcpwxgyPkhWtVS3G3CATztFlvEnsfy/fsg5
 OJ56ggxtXGSIlldT1odgexTwg=
X-Received: by 2002:a05:600c:4692:b0:483:7903:c3b1 with SMTP id
 5b1f17b1804b1-48fe6325978mr69429705e9.20.1778862660019; 
 Fri, 15 May 2026 09:31:00 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48ff2cb4ae0sm4026635e9.0.2026.05.15.09.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 09:30:59 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0AEAA5F944;
 Fri, 15 May 2026 17:30:56 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v3 06/11] .agents/skills: add qemu-testing skill
Date: Fri, 15 May 2026 17:30:49 +0100
Message-ID: <20260515163055.1792262-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515163055.1792262-1-alex.bennee@linaro.org>
References: <20260515163055.1792262-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

This provides basic instructions for running tests but doesn't try to
exhaustively describe the whole setup.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - add link to testing docs.
---
 .agents/skills/qemu-testing/SKILL.md | 56 ++++++++++++++++++++++++++++
 AGENTS.md                            |  1 +
 2 files changed, 57 insertions(+)
 create mode 100644 .agents/skills/qemu-testing/SKILL.md

diff --git a/.agents/skills/qemu-testing/SKILL.md b/.agents/skills/qemu-testing/SKILL.md
new file mode 100644
index 00000000000..e5979dfc1c5
--- /dev/null
+++ b/.agents/skills/qemu-testing/SKILL.md
@@ -0,0 +1,56 @@
+---
+name: qemu-testing
+description: Provides instructions on how to find, list, and run individual tests for QEMU (Unit, QTest, Functional, TCG). You MUST use this skill whenever the user asks about tests, wants to list available tests, or wants to run any test in a build directory, even for simple exploratory queries like "what tests can I run". It includes details about spawning sub-agents.
+license: GPL-2.0-or-later
+---
+
+# Instructions
+To run QEMU tests, you can use several different suites depending on what you are testing. **Note**: Ensure you have a recent build of QEMU before running tests. Use the `qemu-build` skill if you need to configure or run a build.
+
+For exhaustive details on the testing infrastructure, architectures, and specific test requirements, you MUST refer to the official documentation in:
+- `docs/devel/testing/` (specifically `main.rst`)
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
diff --git a/AGENTS.md b/AGENTS.md
index 29a13ca01b4..f5439282967 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -32,6 +32,7 @@ If unsure read the linked document for guidance.
 You should use the following specialized skills for common tasks:
 - `qemu-code-explorer`: For finding where things are defined, how they're used, or understanding a specific subsystem.
 - `qemu-build`: For configuring and building QEMU (including debug and sanitizer builds).
+- `qemu-testing`: For finding, listing, and running individual tests (Unit, QTest, Functional, TCG).
 
 ## Source Code Layout (see `docs/devel/codebase.rst`)
 - **`accel/`**: Hardware accelerators (KVM, TCG, HVF, Xen, etc.) and architecture-agnostic acceleration code.
-- 
2.47.3


