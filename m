Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2FACD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 17:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMU48-0000yR-Ur; Mon, 11 May 2026 13:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMU44-0000rv-PG
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:05:08 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMU41-0007nU-R2
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:05:08 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48e6db3ff7eso14751045e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 10:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778519104; x=1779123904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oCvDLGdWpxj14o5+vhYsw/V00nmfdhF65oNI4ftCg/w=;
 b=uRIji4tl30mtL+Qb+Lf83YAW/C25rBO71GhmK030jxE0Q3jvhQT0eHiCjvq4ykGoU6
 r73gmIMsFTbbI1OTALSSwZE+/ShBu+oZ0pPORAcuUZOKiYZM6HBdtO4ut2mHXJHTPrZQ
 rpjZI5jXWONRczcJ6J3jfuG5F8o49F1MSCDmnFnKNjXupF5amBU890XenWGHDcbmQh5G
 yFKfnKFZ52+eoMDs1DR0PaTeEeCRAlmSGFwT5xxc2zWLgd8x17L9aOiRp32nwRrk/XTw
 Nm0FrM/UKEW2KNg2XPgpNjXdrEJaUNEgLcAxIA5rw3PEeRSbxkZjwjdBO3BmllPfcwQe
 XrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778519104; x=1779123904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oCvDLGdWpxj14o5+vhYsw/V00nmfdhF65oNI4ftCg/w=;
 b=bFCSAJmzghrGiLaWm93Q8kF5QI5EYIgl4Ar5Ec75WeC/cUn5OAR+id83K1CRRHh1i/
 MRXsoX+ImpRjp0kmu5oj6Bk48EzEGFihQRdwzho/KXL058D4EcHICb0NsXqDmWU8buz7
 ABxtUc7OlLF6aSjY1ejezXbD7YSDrFn/fmS0gOJpK0v/B85Sn/p9cvs3r7D3fXXPIHn0
 Lpw6oXnI0Z7E5iD6pwd9jK6bIgepP0rxL9ACEP4O8r642EngIDHdJyUtwasMzRY6C+Yy
 7WgIgmQ2hudEfRICttoIIWcWWz6w1pfiOah7wwfkse1UkLMNiFxaVewYXzfNLDIq5z9U
 8Lqw==
X-Gm-Message-State: AOJu0YyWA4ymM+tZa03FV7/KVlsYSc/rYKhAdEQmn4PlYIJY52wEOVW1
 LysNTq5HipIlezD33Qv6xGa1ZfX0aPfBNvdoXB/xAdwV5dg9S6+SrHtlcqdZkTdJYq0=
X-Gm-Gg: Acq92OGCdBnkGBSS50vYNDf+zjRc/oQ2WYADtwftIuzxfC8+fiVkrCQtnnyeBKSeCBD
 h07LGh6bWSJVrJ7rqbjAIrco0h0JsBxhKGC/2Yf14tiLwgjGQf4V3mcq2bv8RRgsrXEz/Cj+5cp
 AKZ/5QcV5wG4obhYwJSfdzSccuQFJcxUw+l73mU0nKheDE51zgbY1KRiBNfLYFVTxb+SlbDoWci
 QGPFfUp1AMBxa+xwNzl4yzziQYg/fuSqcEzAawlqooY3Df87bCykCrDuus2nmO/anoRl4MgM54d
 4uTOemNKtNkwdT3GOX7T3ul0RHHshTQvmyh1R2EqsLg/tVnssKLJPF5fHnU2HdaElMbDHiub8FP
 xnUvwjHuhxLGjIDsEsOLjfTvI3dFYEQMllOuyxSOmZR5MOzulmsH5xnFsF4qT9koaKNyXmSbclR
 J6Wccjsnk2KxUFOn/uCGAPs4w=
X-Received: by 2002:a05:600c:2e0c:b0:48e:526e:1011 with SMTP id
 5b1f17b1804b1-48e526e106bmr217016445e9.25.1778519103962; 
 Mon, 11 May 2026 10:05:03 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e702e6d41sm254552155e9.7.2026.05.11.10.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 10:05:01 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DCAFA6076B;
 Mon, 11 May 2026 18:05:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [RFC PATCH v2 04/10] .agents/skills: add qemu-build skill
Date: Mon, 11 May 2026 18:04:53 +0100
Message-ID: <20260511170500.124211-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511170500.124211-1-alex.bennee@linaro.org>
References: <20260511170500.124211-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

This provides basic instructions for building QEMU.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - drop ECA/qemu-helper-agent sub-agent language
  - mention configure --help
  - drop mention of full paths - not needed for compilation
  - moved earlier is series so code-reviewer can refer to it
---
 .agents/skills/qemu-build/SKILL.md | 50 ++++++++++++++++++++++++++++++
 AGENTS.md                          |  1 +
 2 files changed, 51 insertions(+)
 create mode 100644 .agents/skills/qemu-build/SKILL.md

diff --git a/.agents/skills/qemu-build/SKILL.md b/.agents/skills/qemu-build/SKILL.md
new file mode 100644
index 00000000000..91819a0992a
--- /dev/null
+++ b/.agents/skills/qemu-build/SKILL.md
@@ -0,0 +1,50 @@
+---
+name: qemu-build
+description: Provides step-by-step instructions on configuring and building QEMU. You MUST trigger this skill whenever the user asks to build QEMU or debug build failures. It includes critical details on build directory reuse and spawning sub-agents.
+license: GPL-2.0-or-later
+---
+
+# Instructions
+
+## Examining and Re-using Build Directories
+Before creating a new build directory, check if an existing one can be re-used. QEMU uses out-of-tree builds, typically in `build` or `builds/` sub-directories.
+
+1. **Check existing configs**: You can examine how an existing build directory was configured by checking its `config.log`. Run `head -n 2 builds/<dir>/config.log`. The second line typically contains the full `../configure` command line used.
+2. **Re-use and Reconfigure**: You have latitude to re-use existing directories when appropriate (e.g., `builds/debug` which is a general-purpose debug directory for whatever is currently going on). If an existing directory has the right flags (like debug/sanitizers) but the wrong target list, you can reconfigure it to keep the same config but change the `--target-list`:
+   ```bash
+   cd builds/debug
+   # Check the old config.log, then re-run configure with the new target-list
+   ../../configure <old-flags> --target-list=<new-targets>
+   ```
+
+## Launching Builds
+**Crucial**: You MUST NEVER run builds directly in the main agent context. You MUST ALWAYS launch them by spawning a sub-agent.
+Pass the specific build commands, along with the required working directory, in the `task` argument. Give the subagent explicit instructions on what to verify and what to report back to you.
+For example: `task: "Navigate to builds/debug and run ninja. If it fails, report the exact compiler errors."`
+
+## Configuring a New Build
+If no suitable build directory exists, create a new one.
+
+1. **Create build directory**: `mkdir -p builds/test-target; cd builds/test-target`
+2. **Basic Configure**: `../../configure --target-list=[list of targets]`
+   - Common targets: `x86_64-softmmu`, `aarch64-softmmu`, `riscv64-softmmu`, `x86_64-linux-user`.
+3. **Common Options**:
+   - `--enable-debug-info`: Include symbols.
+   - `--enable-debug`: Enable assertions.
+4. **Sanitizers**:
+   - `--enable-asan`: Address Sanitizer.
+   - `--enable-tsan`: Thread Sanitizer.
+   - `--enable-ubsan`: Undefined Behavior Sanitizer.
+5. **Help**:
+   - `--help`: will give a comprehensive list of options
+
+## Building
+**Important**: Always re-run the build after making changes to the source code.
+
+## Reporting Results
+**Crucial**: After completing the build task, provide a concise summary of the results to the user.
+1. **Summary**: State whether the build passed or failed.
+2. **Failure Excerpts**: If the build fails, include relevant excerpts from the logs (e.g., compiler errors).
+
+## Debugging and Environment
+- **Verbose**: `V=1` for detailed output.
diff --git a/AGENTS.md b/AGENTS.md
index 74516c378ed..08bfe13ebd2 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -25,6 +25,7 @@ security stance. In brief:
 ## Agent Skills (see `.agents/skills`)
 You should use the following specialized skills for common tasks:
 - `qemu-code-explorer`: For finding where things are defined, how they're used, or understanding a specific subsystem.
+- `qemu-build`: For configuring and building QEMU (including debug and sanitizer builds).
 
 ## Source Code Layout (see `docs/devel/codebase.rst`)
 - **`accel/`**: Hardware accelerators (KVM, TCG, HVF, Xen, etc.) and architecture-agnostic acceleration code.
-- 
2.47.3


