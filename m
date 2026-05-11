Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3919CCD484D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 17:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMU48-0000x7-FF; Mon, 11 May 2026 13:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMU45-0000sr-Of
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:05:10 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wMU43-0007nl-6n
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:05:09 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso48259825e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 10:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778519105; x=1779123905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rKUkvslWZr7sukogZRrX9QWlcGo8FSZeMYPKDhG7aV8=;
 b=nJ6lkhRq6fosPVk9nnClSzbg1RwXfvH/pa8+xNkG4iUEdGW98qRJmDk/VjzbKzyOQJ
 c+wkJ2kl57epSiZwKzi8RAo2CBImAYx8gV6cxCpnrRGKCIqh6ARnkTxkSsAIa7MFPZCX
 xfybjNu0WoVeAKPKQxJUC0UHKrJcagaanSZx9ttn9go5R+JAedX029FxFN5txexwXTFu
 bZEW0daHQLeJxCPZHBUdAc2q4XnMAA2Krav+rKIg1CRz2zcAnTrNWX4Km17erXJHsZgt
 bCgqI1bLXlTnP7hKyxtmBLGEtYOEuhL8PgbCL0QxV75FB7KrkQUtmnl1I1KXSbteJtx8
 u8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778519105; x=1779123905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rKUkvslWZr7sukogZRrX9QWlcGo8FSZeMYPKDhG7aV8=;
 b=VBR5vk/xQISFrl1bGhpT2fuciCW2zF2f+Vgb6GIErraA9qjqTOE2M2wOVCYMZDDnXX
 GSFCfoxRhsm56ass/cMByVtwNo8xIhWwZuzslDIH2JkzvuTufKSAZfOL8ESalHVzVTbn
 TG/SuyLQLTvVnmxq4VWY95lj8UrrgtxqIgKtpOdcd9UwI8wJKBVI9xRvBJu3z2x2UA4u
 fiQdXyoIfMFs3bNMjqS5o65ZcB2HIet5XYRtY5/oxx2qp+iqcAJvrebVgki5wlBMsa3K
 SmpsvFUOS6DO5A4SpevS1iwsBHwYZzkaG/88Q31nib1kbY5osmWB9DcW7mdgqsfmrSGl
 Diug==
X-Gm-Message-State: AOJu0Yzb17V8rABd81hFxHZejHa+SPHob8A+BVjCMtg/zzjO9FzuqDwX
 +XCud3wzpbiA9oPy2mux/kJKCDf9GhpSaqHyPJA68fy9GRLiCDTKg0KXA9l7OgIENwY=
X-Gm-Gg: Acq92OEmgCNcmoak9hsButlwiUidR7V00xYQunCt806JOYSwgFzq0VKsOuhGFmFdcmH
 IxoKyAPk6MnfftkfAhkD8piY99mUbM6C2LOxU3dfmsKV34XfYXgZVFtfhYvkBl7Ka7SfMVqZLKx
 bM6XUGs9e10fDdpa7baxZnufCcCrnfoQBLrJUZcdX8po2RPEoSZst5BMqXWZxds6rwp/UKhTajv
 uz/N4BcLeer5I1vwSsJv64QYMrUuiBQBd4XJQ7/2DWVSV/luDkeKt275Tf3QorCv8rSJwzuQBWr
 ve9vcAjFaQhyrTHNFjrJX5oiO/FSAyHG7mjyJGT18sYq9RSMzXoT57fFapteWPydXKUgiYK+g+H
 bZeBXAxihd+cs1udBGtbNCTPemAyPPd5I7sT5EcSa+l2jn8nxjTaXgWIT7uNBbhhWYXfUBv63oQ
 T2c0tqkpm82c4+QwA1t4ApAik=
X-Received: by 2002:a05:600c:4c25:b0:48a:65a5:750f with SMTP id
 5b1f17b1804b1-48e51f46ddamr241162965e9.21.1778519104685; 
 Mon, 11 May 2026 10:05:04 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8e7491edsm592135e9.13.2026.05.11.10.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 10:05:01 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C3AB560469;
 Mon, 11 May 2026 18:05:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [RFC PATCH v2 03/10] .agents/skills: add qemu-code-explorer skill
Date: Mon, 11 May 2026 18:04:52 +0100
Message-ID: <20260511170500.124211-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511170500.124211-1-alex.bennee@linaro.org>
References: <20260511170500.124211-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

This provides a skill detailing how to explore the QEMU code base. It
guides the agents to use the tags and git-grep by default and outlines
some of the confusions that can occur with multiple build directories.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - remove personal gtag skill references, add global stanzas directly
  - moved macro information from AGENTS.md into code explorer
  - more imperative language to trigger its use
  - add section on using scripts/expand_macro.py
  - remove eca reference from evals.json (maybe we should just drop this)
---
 .agents/skills/qemu-code-explorer/SKILL.md    | 119 ++++++++++++++++++
 .../qemu-code-explorer/evals/evals.json       |  26 ++++
 AGENTS.md                                     |   1 +
 3 files changed, 146 insertions(+)
 create mode 100644 .agents/skills/qemu-code-explorer/SKILL.md
 create mode 100644 .agents/skills/qemu-code-explorer/evals/evals.json

diff --git a/.agents/skills/qemu-code-explorer/SKILL.md b/.agents/skills/qemu-code-explorer/SKILL.md
new file mode 100644
index 00000000000..d5b7d6a35cd
--- /dev/null
+++ b/.agents/skills/qemu-code-explorer/SKILL.md
@@ -0,0 +1,119 @@
+---
+name: qemu-code-explorer
+description: Systematic framework for deep-diving into the QEMU codebase. Use this to find precise symbol definitions (functions, structs, globals), locate all call sites or references, explore subsystem architectures, or search generated code in build directories. You MUST use this skill when exploring code flow and dependencies.
+license: GPL-2.0-or-later
+---
+
+# QEMU Code Base Explorer
+
+This skill provides a systematic approach to navigating and understanding the large and complex QEMU codebase.
+
+## 1. Symbol Search with Tags (Primary)
+
+Tagging systems are the fastest and most accurate way to find global symbol definitions and references. QEMU supports `gtags`, `ctags`, `cscope`, and `TAGS` (Emacs).
+
+### GNU Global (gtags) - Recommended
+- **Best for**: Finding where a function, struct, or global variable is defined or used.
+- **Commands**: 
+  - Find definition with context: `global -dx SYMBOL`
+  - Find references with context: `global -rx SYMBOL`
+  - Find related symbols (completion): `global -c PREFIX`
+- **Note**: Using `-x` provides line numbers and the matching line's content, allowing for immediate analysis. This is significantly faster and more accurate than `grep` for symbols.
+
+### Updating Tags
+If you suspect the tags are out of date:
+```bash
+make gtags  # or make ctags, make cscope, make TAGS
+```
+
+## 2. Text Search with `git grep` (Secondary)
+
+`git grep` is the preferred tool for general text searches within the source tree.
+
+- **Best for**:
+  - Searching for local variables within a function.
+  - Searching for string literals or comments.
+  - Finding occurrences of symbols defined in system headers (e.g., `optarg`).
+  - Complex regex patterns that `gtags` doesn't support.
+- **Why**: It is fast, respects `.gitignore`, and avoids searching through build artifacts or other non-source files.
+- **Usage**: `git grep "pattern"` or use a grep-like tool with the `path` set to the repository root.
+
+## 3. Searching Generated Code
+
+Generated source files (e.g., from QAPI, trace-events, decodetree) do not reside in the source tree but in the build directory.
+
+- **Best for**:
+  - Finding definitions of functions generated by QAPI (e.g., `qmp_marshal_...`).
+  - Finding trace points and their implementations (e.g., `trace_..._header`).
+  - Checking configuration fragments (`config-*.h`).
+- **Tools**: Use a normal `grep` (or similar search tool) limited to the build directory.
+- **Crucial Note**: QEMU developers often have multiple build directories (e.g., `build/`, `builds/debug/`, `builds/asan/`). Always verify which build directory is active or intended.
+- **Common Paths**:
+  - `build/qapi/`: Generated QAPI headers and C files.
+  - `build/config-host.h`: Host-specific configuration.
+
+### QOM (QEMU Object Model) (see `docs/devel/qom.rst` & `include/qom/object.h`)
+- Most devices are QOM objects.
+- Key concepts: `TypeInfo`, `ClassInit`, `InstanceInit`, `InstanceFinalize`.
+- `OBJECT_DECLARE_SIMPLE_TYPE` or `OBJECT_DECLARE_TYPE` expand to boilerplate.
+- Also creates casting macros like `MY_DEVICE(obj)`.
+
+### QAPI
+- Interface definitions live in `qapi/*.json`.
+- Generated code lives in `build/qapi/`.
+
+### Tracing
+- QEMU uses a tracing framework. Events are defined in `trace-events` files.
+  - `build/trace/`: Generated trace points.
+  - `trace_my_event_name(arg1, arg2);` calls the `my_event_name` trace point.
+
+### Decodetree (see `docs/devel/decodetree.rst`)
+- QEMU uses `decodetree.py` to generate instruction decoders.
+- A pattern like `- FOO ...` in a `.decode` file will:
+  1. Generate code in the build tree (e.g. `decode-insns.c.inc`).
+  2. Call a handwritten `trans_FOO(DisasContext *ctx, arg_FOO *a)` in the source tree.
+  3. The `arg_FOO` structure is automatically filled with fields from the instruction.
+- Some instructions may use a common structure if defined with `&`.
+
+### Common QEMU Macros
+- **QOM**: `OBJECT_DECLARE_SIMPLE_TYPE(InstanceType, ClassType, MODULE_OBJ_NAME, MODULE_OBJ_TYPENAME)` expands to type declarations, casting macros (`MODULE_OBJ_NAME(obj)`), and more.
+- **TCG**: `HELPER(foo)` expands to helper function declarations or calls.
+- **Error**: `ERRP_GUARD()` ensures `errp` is not NULL for easy error propagation.
+- **Bitwise**: `BIT(n)`, `MAKE_64BIT_MASK(shift, len)` for clear bit manipulation.
+- **Structs**: `container_of(ptr, type, member)` to get parent struct pointer.
+- **Memory**: `g_autofree` and `g_autoptr(Type)` for automatic cleanup (GLib).
+- **Migration**: `VMSTATE_...` macros for defining device state save/load.
+
+## 4. Expanding Complex Macros
+
+QEMU makes heavy use of macros, which can sometimes be hard to follow by "hand". To understand exactly how a macro expands in a specific file and context, you should use the `scripts/expand-macro.py` tool.
+
+- **Best for**:
+  - Expanding complex macros to see their generated C code.
+  - Understanding how nested macros evaluate.
+- **Usage**:
+  ```bash
+  python3 ./scripts/expand-macro.py FILE --context CONTEXT_FILE --range START_LINE-END_LINE
+  ```
+- **Example**:
+  To see how `partsN_canonicalize` expands in `fpu/softfloat-parts.c.inc` when included from `fpu/softfloat.c` between lines 191 and 264:
+  ```bash
+  python3 ./scripts/expand-macro.py fpu/softfloat-parts.c.inc --context fpu/softfloat.c --range 191-264
+  ```
+
+## Decision Matrix: Which tool to use?
+
+| Goal | Tool | Reason |
+|------|------|--------|
+| Find a function definition | `gtags` | Precise and fast. |
+| Find all call sites of a function | `gtags` | Comprehensive. |
+| Find a local variable usage | `git grep` | `gtags` only tracks globals. |
+| Search for a string literal | `git grep` | `gtags` doesn't index literals. |
+| Find QAPI-generated code | `grep` in `build/` | Not in source tree. |
+| Search in a specific subsystem | `git grep <path>` | Efficiently scoped. |
+| Understand complex macro expansion | `scripts/expand-macro.py` | Shows exact generated C code. |
+
+## Workflow Tips
+1. **Scope your search**: If you know you are looking for a networking issue, search `hw/net/` or `net/` first.
+2. **Beware of Macros**: QEMU uses many macros (especially in QOM). If `gtags` fails, `git grep` might find where the macro is used to define the symbol.
+3. **Verify the Build**: Before searching generated code, ensure a build has been performed in the target directory.
diff --git a/.agents/skills/qemu-code-explorer/evals/evals.json b/.agents/skills/qemu-code-explorer/evals/evals.json
new file mode 100644
index 00000000000..8eaa45b28b3
--- /dev/null
+++ b/.agents/skills/qemu-code-explorer/evals/evals.json
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+{
+  "skill_name": "qemu-code-explorer",
+  "evals": [
+    {
+      "id": 0,
+      "prompt": "Where is the function 'qemu_mutex_lock' defined and where is it used in the block layer (block/)?",
+      "expected_output": "The definition should be found (likely in util/qemu-thread-posix.c or similar) and usages in block/ should be listed using gtags."
+    },
+    {
+      "id": 1,
+      "prompt": "I'm seeing a reference to 'qmp_marshal_query_status' in some docs but I can't find it in the source tree. Can you find where it is defined?",
+      "expected_output": "The agent should identify this as QAPI generated code and look in the build directory (e.g., build/qapi/qapi-commands-control.c)."
+    },
+    {
+      "id": 2,
+      "prompt": "Find all implementations of trace points for 'virtio_net' in the generated code.",
+      "expected_output": "The agent should search for 'trace_virtio_net_*' in the build directory, specifically in generated trace headers/sources."
+    },
+    {
+      "id": 3,
+      "prompt": "Find all occurrences of the string 'Could not open' in the 'hw/' directory.",
+      "expected_output": "The agent should use git grep scoped to hw/ to find the string literals."
+    }
+  ]
+}
diff --git a/AGENTS.md b/AGENTS.md
index a97b4df5f7f..74516c378ed 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -24,6 +24,7 @@ security stance. In brief:
 
 ## Agent Skills (see `.agents/skills`)
 You should use the following specialized skills for common tasks:
+- `qemu-code-explorer`: For finding where things are defined, how they're used, or understanding a specific subsystem.
 
 ## Source Code Layout (see `docs/devel/codebase.rst`)
 - **`accel/`**: Hardware accelerators (KVM, TCG, HVF, Xen, etc.) and architecture-agnostic acceleration code.
-- 
2.47.3


