Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C193FCD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 16:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNvRa-0005lr-MK; Fri, 15 May 2026 12:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wNvRJ-0005dm-Nz
 for qemu-devel@nongnu.org; Fri, 15 May 2026 12:31:11 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wNvRE-00026f-2Y
 for qemu-devel@nongnu.org; Fri, 15 May 2026 12:31:03 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so155491405e9.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 09:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778862658; x=1779467458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sL1CgH/kLzkgCWYcamDHQZYL7OHt0jlzIDxXp3o/EBw=;
 b=ONvekDEdfruGgT2r8z25/WP/iOr/ZbSy7skyRKc1D3UY9XpU1RLFcnbSgIee7wZrYz
 wmUUG4ZrzZ7em8oeITyeEYcG8TuhP3VYpx8p6vTwjTbA6o1TwcyCfkZXHYCe7BY8cJwU
 fA+g29PkfQYMglkucCNYm3TxL7iRQVLNuZOEoAGKkPfVL7QCdKDQkXHJQCll86PdZUrl
 ZQgaCBUAAucTYQS0FhCiPN97CmlZctvOAZ7nvP+Zums88B+nVgjV9+NULss6vbboKL5a
 nLhEW+AzB/Sk8ABt2TLGY8Y0+Qi/PKLZZ4Y3fBD52H9oO8uI2WokdHZqxn1WwoyzQlKG
 eoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778862658; x=1779467458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sL1CgH/kLzkgCWYcamDHQZYL7OHt0jlzIDxXp3o/EBw=;
 b=H75vwdeW1ANFLvV3iueqq9VuWnNOtpn3heFibSxihIWpUM/RbZ6l/XSqXOSzPFXHdU
 ZIgAPz4Dxi5ZA0VG+Am9YQoX51I53IrxYrjMgWyUFuuR1GJa27nuwCE9tLqV3vebEyqj
 UFXchRZj4oE3q/ROesyqJuZ46MlhEu1Hkkg8g/+wzzUglriDIBZ0gTeBa50xuD4geu8+
 aNAxEgugnpfww1bONeiBpC8/DJUMeplT83z5nvAXFK3PMz4vCwvh0XOpS6nO8+x3ojme
 okDx63meTM6rS4KhsP4M2VlxJlcukWdd0FhttzRh2SwqWDOdFxmBMQrFSFJYAioBcvmy
 maTw==
X-Gm-Message-State: AOJu0Yx7ERmLX067j6CSGEnfFj63NuXLAmxgETxQtB6z05J2cILiNSl2
 H0fjk9vZyAzpos/ZaXiWX4YwX7QaeAEo2o2Vs8QHiXVLMRf6ljLdGohicBTI9imJPpk=
X-Gm-Gg: Acq92OGjrJpxgGtBmh2NDZeFHSeEFwicBVcWY3lCmT+etUnuIbK+4i0bG1l1eppzEak
 kU/RsjqOYAhFQUb+xcNDtIy3eZIneGWUpQW6OKceTFNsDH7eYXlL8/FrV07UhN+T2Yi7g1p0JZn
 uAmSYA1zyGm7lb3AqiSEvcwtD0Kn6JS/34XjeAI5MN0KdnzeFP3xKS1vTgJrQkP6bI/6EMGG7pR
 KeELwNfl/KHClALq9d6JXc/hecy7DmfsJuZ4MwI9jimiFpXzgbf0lk76BM4veLdfPeTNOBURrg0
 zllByS25th6mxOnZzqt+n6TVlMIQ6R8dCtgOL282RyDzsw0p5Hia0ReX2CmFi/kKQ/xUMYGIzKH
 zfCPRUKp+MJDpYjTXnbr8RGTMZGLPboEAETQjw7puVGXktMOAeWMhuuu4LKCsukc1HRendR4TcK
 oV1jAFDjTBbUfuEn8823YEClSM401hGzxZUQ==
X-Received: by 2002:a05:600c:3b12:b0:488:b14f:b8ed with SMTP id
 5b1f17b1804b1-48fe59ab80emr71984625e9.0.1778862657838; 
 Fri, 15 May 2026 09:30:57 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5ab52a6sm68966335e9.10.2026.05.15.09.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 09:30:56 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9E6ED5F83D;
 Fri, 15 May 2026 17:30:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v3 02/11] AGENTS.md: expand with information on skills,
 layout and style
Date: Fri, 15 May 2026 17:30:45 +0100
Message-ID: <20260515163055.1792262-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515163055.1792262-1-alex.bennee@linaro.org>
References: <20260515163055.1792262-1-alex.bennee@linaro.org>
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

To be efficient in navigating the code base inform the agents of the
basics of the repo layout, where skills can be found and a very quick
overview of the source code, coding and commit styles.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - split AGENTS.md into two commits
---
 .gitignore |  1 +
 AGENTS.md  | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/.gitignore b/.gitignore
index 61fa39967b5..4ccba871d16 100644
--- a/.gitignore
+++ b/.gitignore
@@ -8,6 +8,7 @@
 .git-submodule-status
 .clang-format
 .gdb_history
+.plan
 cscope.*
 tags
 TAGS
diff --git a/AGENTS.md b/AGENTS.md
index 133225957e0..3fd56fe3309 100644
--- a/AGENTS.md
+++ b/AGENTS.md
@@ -21,3 +21,64 @@ are treated as security vulnerabilities. In brief these are:
 - **Common devices for Virtualization**: e.g. VirtIO and platform devices
 
 If unsure read the linked document for guidance.
+
+## Repo Layout
+- **Build Directory**: QEMU uses out of tree builds, by default the `build` sub-directory is used.
+- **Multiple Builds**: Developers might create a `builds` directory with different configurations in subdirs (e.g. `builds/debug`, `builds/asan`).
+- **Documentation**: Developer docs live in `docs/devel`.
+- **Plan Files**: Plan files should be placed in `.plan`, they are not included in commits. Use them to track complex multi-step tasks.
+
+## Agent Skills (see `.agents/skills`)
+You should use the following specialized skills for common tasks:
+
+## Source Code Layout (see `docs/devel/codebase.rst`)
+- **`accel/`**: Hardware accelerators (KVM, TCG, HVF, Xen, etc.) and architecture-agnostic acceleration code.
+- **`audio/`**: Host audio backends.
+- **`authz/`**: QEMU Authorization framework.
+- **`backends/`**: Host resource backends (RNG, memory, crypto).
+- **`block/`**: Block layer, image formats (qcow2, raw), and protocol drivers.
+- **`chardev/`**: Character device backends (TCP, serial, mux, etc.).
+- **`crypto/`**: Cryptographic algorithms and framework.
+- **`disas/`**: Disassembler support for various architectures.
+- **`dump/`**: Guest memory dump implementation.
+- **`ebpf/`**: eBPF program support (e.g. for virtio-net RSS).
+- **`fpu/`**: Software floating-point emulation.
+- **`gdbstub/`**: Remote GDB protocol support.
+- **`hw/`**: Hardware device emulation, organized by type (e.g., `hw/net`, `hw/pci`) or architecture.
+- **`include/`**: Global header files, mirroring the source tree layout.
+- **`io/`**: I/O channels framework.
+- **`linux-user/` & `bsd-user/`**: User-space process emulation.
+- **`migration/`**: VM migration framework.
+- **`monitor/`**: HMP and QMP monitor implementations.
+- **`nbd/`**: Network Block Device server and client code.
+- **`net/`**: Networking stack and host backends.
+- **`plugins/`**: TCG introspection plugins core.
+- **`qapi/`**: QAPI schema and code generation infrastructure.
+- **`qga/`**: QEMU Guest Agent.
+- **`qom/`**: QEMU Object Model implementation.
+- **`replay/`**: Deterministic record/replay support.
+- **`rust/`**: Rust integration and Rust-based device models.
+- **`scripts/`**: Build system helpers, `checkpatch.pl`, `tracetool`, etc.
+- **`system/`**: Core system-level emulation logic (replaces `softmmu`).
+- **`target/`**: CPU-specific emulation (ISA translation, CPU state).
+- **`tcg/`**: The Tiny Code Generator (JIT) backends.
+- **`tests/`**: Test suites (qtest, unit, functional, tcg).
+- **`ui/`**: User interface backends (GTK, SDL, VNC, Spice).
+- **`util/`**: Low-level utility functions and data structures.
+
+## Code Style (see `docs/devel/style.rst`)
+- **Formatting**: 4-space indents, NO tabs, 80-char line limit (max 100).
+- **C Braces**: Mandatory for all blocks (if/while/for). Open brace on same line (except functions).
+- **C Includes**: `#include "qemu/osdep.h"` MUST be the first include in every `.c` file.
+- **C Comments**: Use `/* ... */` only. No `//` comments.
+- **Naming**: `snake_case` for variables/functions; `CamelCase` for types/enums.
+- **Memory**: Use GLib (`g_malloc`, `g_free`, `g_autofree`) or QEMU (`qemu_memalign`). No `malloc`.
+- **Errors**: Use `error_report()` or `error_setg()`. Avoid `printf` for errors.
+- **Lints**: Run `./scripts/checkpatch.pl` on C patches. Use `make clippy` for Rust.
+
+## Commit Style
+- **Small Commits**: Favour small discreet commits changing one thing.
+- **Maintain Bisectability**: Each commit must compile and pass basic tests.
+- **Separate Refactoring**: Split code movement or style fixes from functional changes.
+- **Commit Messages**: Use a concise subject line, followed by a body explaining "why" (not just "what").
+- **Signed-off-by**: Every commit must have a `Signed-off-by` line.
-- 
2.47.3


