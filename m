Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C484CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 08:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSVyh-0000OC-Sm; Thu, 28 May 2026 04:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSVyf-0000Nm-Pp
 for qemu-devel@nongnu.org; Thu, 28 May 2026 04:20:29 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSVyd-0005l9-K2
 for qemu-devel@nongnu.org; Thu, 28 May 2026 04:20:29 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49048e043e5so48133495e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 01:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779956425; x=1780561225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Rq0aD7gZ5vhno5yGhN7uLNtbMOTf/oOFHBIjQ4ubsDc=;
 b=Y2s6nzUbhxQbSeCEyMZMZYLMuHO7kh9UhNCNNRBno8/Y0cvS3MgNq//tKYE+PRgQ6Z
 w/VCwyVUuKkaTN8Oq8X2f87k5/shVw6dMMHKL3+GHMYfjKBBdavsJ1i2owxUZrnrvchx
 1u0z+xeFT53zK4JqPu7mkEYNWe+r/c4JPhI86MbMCcGbVRm6pna41853NUc9S2gLHoqf
 wHYC9FJHpYCopaczyeDnWBJah85d6463QjlcYgmSYVSQQoyGqU2rTzhpzslqME6B1jqi
 qbg59Jo98lrvmAj0JB3VqMnZGKrB0swMRpaJIUPiApLcfdfa3OPGhrE14IIVdX8VDtzU
 1dVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779956425; x=1780561225;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rq0aD7gZ5vhno5yGhN7uLNtbMOTf/oOFHBIjQ4ubsDc=;
 b=Cg7U7qJTlfpLICwpX9964/wh3DDsneG4aKBiLu22K8SKM2km8ArniQHy+/uJUPq+/E
 4xcm1BvwdhnEvyLneclNvaCaVJISump64Fm7rIr/8xJWxew8ouj5I/c0oUT1KKw1B07z
 p7RlktKgcKJVBnwX0pwsq2GJYk4iOksHdyySmXI0SNXyAFekW8pGjZqYgGFge5iJcZxo
 COWjC7zE/VpXuOd+2GM5M6kK3QDrNtJqUnJHmP7ICYbd6QcqHGjj2v8Q56nK6+VTFENi
 nbwbDTGGHiKYf9DAl4GXsCe9yo+edMC6CTV4SCTfV4dqw9d3SNPIO/VMi83p207pfpML
 w7ow==
X-Gm-Message-State: AOJu0YzJP/Thsf4Hs6XmLoYyc7jfGhNVmLNDnOSZsUTgcRjUjDWui1XB
 vio5GviyczGcOPqAH0zDZPnbLgCKQAT+TXD8rAE8FKWthhPxiCcqZ4mIWkm7mjbV/lUHL4yy3rt
 FpIFh/rYGaw==
X-Gm-Gg: Acq92OHjwg4/In3L6bqu6MsQqdyMJ047c+ob2smb9wOfQ9FudjoXfYGvizmA1PugS/O
 YciuMvMzb3vg3QNiXD0sFGEz6Gkf914SmZLWY4d4gG80Ra2omI+Rg8Hatt44MIv6X+cyrgpDHK3
 vUT3hsMG3ylWDCkCNubJBR6mnsC5CBrD+uD9HEt/S9XEqbb5pylcCV57QDvk2CQm7vYrpjxwqjK
 0YMYYJ+ex9ToUokE9pLn3O51vbRJgAQwEyZmMFcoy38oGdAky5n8nh3xbfle3GA+u0Vf4Hn49dF
 9XLAuKEG666AgZ1+VllPlsSFRAjUdkxg+yl5FmYAFnM7X3l+euudebbBQgsCo3tFR6T0NOzRts4
 xQHj+svsUPtlaiF9L8qUWsI1/tTpcCygJEu7tf7CYiHJ0pj65t8s765rCqphyin4CFPQD9ZVftd
 YrvcImeHNTMPg7GencAhIiVgUxa/f48vUQHYCG5z7mCTh0m88dswwwQWoRIp/T4QDkRA==
X-Received: by 2002:a05:600c:8484:b0:490:3c94:a3c6 with SMTP id
 5b1f17b1804b1-490428e205cmr451280495e9.26.1779956424531; 
 Thu, 28 May 2026 01:20:24 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909294cafasm25384045e9.11.2026.05.28.01.20.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 01:20:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] docs/devel/tcg: Expand on multi-threaded TCG
Date: Thu, 28 May 2026 10:20:22 +0200
Message-ID: <20260528082022.32359-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Significantly expands the TCG documentation to provide more
comprehensive overview of its internal architecture.

Use more rST anchors to improve cross-referencing across the
documentation.

Clarify front-end / optimization / back-end phases.

Detail a bit memory consistency barriers under MTTCG mode.

Add the following new sections:

 - Register Allocation and Liveness analysis
 - Overviews of the Vector/SIMD internal strategy
 - Deterministic Execution (icount)
 - TCG Plugins
 - Instruction Decoding with decodetree

AI-used-for: docs
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20260528073412.551117-1-pbonzini@redhat.com>
---
 docs/devel/multi-thread-tcg.rst |  2 +-
 docs/devel/tcg-icount.rst       |  1 +
 docs/devel/tcg.rst              | 89 +++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/docs/devel/multi-thread-tcg.rst b/docs/devel/multi-thread-tcg.rst
index da9a1530c9f..aa0b11ab360 100644
--- a/docs/devel/multi-thread-tcg.rst
+++ b/docs/devel/multi-thread-tcg.rst
@@ -4,7 +4,7 @@
   This work is licensed under the terms of the GNU GPL, version 2 or
   later. See the COPYING file in the top-level directory.
 
-.. _mttcg:
+.. _MTTCG:
 
 ==================
 Multi-threaded TCG
diff --git a/docs/devel/tcg-icount.rst b/docs/devel/tcg-icount.rst
index a1dcd79e0fd..848c19a746f 100644
--- a/docs/devel/tcg-icount.rst
+++ b/docs/devel/tcg-icount.rst
@@ -2,6 +2,7 @@
    Copyright (c) 2020, Linaro Limited
    Written by Alex Bennée
 
+.. _icount:
 
 ========================
 TCG Instruction Counting
diff --git a/docs/devel/tcg.rst b/docs/devel/tcg.rst
index 2786f2f6791..9af06018f6a 100644
--- a/docs/devel/tcg.rst
+++ b/docs/devel/tcg.rst
@@ -13,6 +13,16 @@ performances.
 QEMU's dynamic translation backend is called TCG, for "Tiny Code
 Generator". For more information, please take a look at :ref:`tcg-ops-ref`.
 
+The translation process occurs in several distinct passes:
+
+1. **Front-end**: Guest instructions are parsed (often using the
+   `decodetree <Instruction Decoding (decodetree)_>`_ tool) and converted
+   into target-independent TCG Intermediate Representation (IR) opcodes.
+2. **Optimization**: TCG performs passes such as constant folding, liveness
+   analysis, and dead code elimination on the IR.
+3. **Back-end**: The optimized IR is converted by a host-specific code
+   generator into native instructions for the host CPU.
+
 The following sections outline some notable features and implementation
 details of QEMU's dynamic translator.
 
@@ -44,6 +54,12 @@ translating it from the guest architecture if it isn’t already available
 in memory. Then QEMU proceeds to execute this next TB, starting at the
 prologue and then moving on to the translated instructions.
 
+In :ref:`MTTCG` mode, each guest CPU is emulated by a separate host thread.
+TCG ensures memory consistency by inserting memory barrier (``mb``) opcodes
+for guest instructions with ordering side effects. Direct block chaining
+across page boundaries is restricted to ensure that changes to memory
+mappings in one thread are correctly handled by others.
+
 Exiting from the TB this way will cause the ``cpu_exec_interrupt()``
 callback to be re-evaluated before executing additional instructions.
 It is mandatory to exit this way after any CPU state changes that may
@@ -175,6 +191,12 @@ virtual to physical address translation is done at every memory
 access.
 
 QEMU uses an address translation cache (TLB) to speed up the translation.
+The software MMU partitions accesses into a **TLB fast-path** and a
+**TLB slow-path**. The fast-path handles RAM and ROM areas, where the TLB
+provides the direct offset between guest virtual addresses and host memory.
+If an access does not match a fast-path entry, it falls through to the
+slow-path, which calls C helper functions to handle MMIO device emulation.
+
 In order to avoid flushing the translated code each time the MMU
 mappings change, all caches in QEMU are physically indexed.  This
 means that each basic block is indexed with its physical address.
@@ -190,6 +212,73 @@ memory areas instead calls out to C code for device emulation.
 Finally, the MMU helps tracking dirty pages and pages pointed to by
 translation blocks.
 
+Register Allocation and Liveness
+--------------------------------
+
+During the translation phase, guest instructions are converted into TCG IR
+using an **unlimited number of temporaries (TEMPs)**.
+This allows guest translators to express logic without being constrained
+by the finite register set of the host CPU.
+
+To resolve these TEMPs into physical registers, TCG performs two passes:
+
+1. **Liveness Analysis**: This pass determines the "live range" of each
+   temporary within a basic block. By identifying when a variable
+   becomes "dead" (i.e., its value is no longer needed), TCG can suppress
+   redundant moves and remove instructions that compute unused results.
+2. **Register Allocation**: The Global Register Allocator maps live TEMPs
+   to host physical registers. Fixed globals, such as the pointer
+   to the CPU architecture state (``cpu_env``), are often permanently
+   held in host registers to minimize memory traffic during execution.
+
+Vector/SIMD Internal Strategy
+-----------------------------
+
+TCG supports SIMD operations through a set of generic vector instructions
+(e.g., ``add_vec``, ``shli_vec``) parameterized by vector length and element
+size. The length is specified as a ``TCGType`` (V64, V128, or V256), and the
+element size is given in log2 8-bit units.
+
+The internal strategy relies on the backend mapping these generic opcodes
+to native host SIMD instructions, such as x86 AVX or ARM NEON. If the host
+backend does not support a specific vector operation  or length, TCG's
+expansion layer automatically decomposes the opcode into smaller supported
+vector sizes or standard integer operations.
+
+Deterministic Execution (icount)
+--------------------------------
+
+The :ref:`icount` mechanism provides deterministic execution by ensuring
+that each Translation Block executes a fixed number of instructions. This
+is essential for features like record/replay and deterministic virtual time,
+where instruction counts serve as the system clock.
+
+Instrumentation and Plugins
+---------------------------
+
+:ref:`TCG Plugins` provide a mechanism for runtime instrumentation. Opcodes
+like ``plugin_cb`` and ``plugin_mem_cb`` are inserted during translation to
+trigger callbacks in external modules, allowing analysis of instruction
+execution or memory access.
+
+Instruction Decoding (decodetree)
+---------------------------------
+
+The first step of the translation process is converting a raw bitstream of
+guest instructions into a structured format that the translator can process.
+QEMU simplifies this using the ``decodetree.py`` script, which generates C
+code decoders from a domain-specific language defined in ``.decode`` files.
+
+The decodetree tool allows developers to define instruction **patterns**
+based on a bitmask and fixed bits. When a match is found, the generated
+decoder automatically  extracts defined **fields** (such as registers or
+immediates) and passes  them to a manually written translation function.
+
+This declarative approach drastically reduces the amount of error-prone
+manual bit-shifting and nested "if-else" logic required in guest translators.
+
+For detailled implementation see :ref:`decodetree`.
+
 Profiling JITted code
 ---------------------
 
-- 
2.53.0


