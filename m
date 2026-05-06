Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 152DFFF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcsF-0003kF-MJ; Wed, 06 May 2026 10:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcrh-0002E4-I5
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:04:42 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcre-0001IZ-Qz
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:04:41 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-452169ae568so386357f8f.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076276; x=1778681076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZP4w7Rk3n+TwTim0y/LaZ0U4XGUljk46CIvMASTDLg4=;
 b=tnL3Iv+eB2Fs57wCa71oRR+jKL7Kw03E9jjCH6mqmmPGT/fLbPvq3jq8YPi1urzFma
 eQcnYeAzLr1lb+IghwmgJwOfLDYWZankU0RhgXunoGTmB+/G2IxdxaWa9SiViGwrWVtL
 jg9wOnMMcsCZC4kvSpe9Z+Hx5zoLI2kn3O6kIsBDGQ73D/1UAsdvwWbztoLrYjGqwxKp
 aUm7HhyvYzE9vqRxOsDXogywDesqJN/yo3Gle3mIpuR+nJyNhJEOf8umeroW7RmfIv+J
 gFPsEBL5MYQtKSV8qlWDdHhWgLHqrytrlDY6ozLMPIIXFkU1L5euRWe5qxnzmlFM6MIE
 PEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076276; x=1778681076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZP4w7Rk3n+TwTim0y/LaZ0U4XGUljk46CIvMASTDLg4=;
 b=lma3xuuCw/QlsTxQR6kMX9M1kzMb3Aj8amCTyMcRjMLJNCI/RvIBY7YvRAPsr7uy3M
 yO9HO+EgOhaKjp61T8BJmdrPUBNVhVcIrnRrM3FcHIi0aFDAt8OBJmYJEKA5V/WcLrPx
 vSGo95J8D05IJgtGg2WmtXSOU7ZvTwrAKNiqF1Pvrn0vnwATaQHBodcrZnGcaR8I5v5l
 Esg7C6qm0T1XraHO62L5RGb+2EiL6NvWW1QBESzfA5qV9o6SxZD3u9WlStlb2TCUjyOA
 iJqNfz9tUo9eDZYfzZOj/COEpT7uMe2XuXuzggG7ZEbQzGMq/tV+1x+++d62Ob9uNSD6
 2hHA==
X-Gm-Message-State: AOJu0YygmcV5W186X7ArqCSO4t7Ifq/QbcLO4z6BkjDI3J9RNw5gaCp4
 yIeclrvkwQDSmoAv+RbVa3kKihGZLtNUcRDKYyyjyhbF2bT6Z0krPaWrcNCtyhzRXB1/X6YtsS5
 bx/r6DAc=
X-Gm-Gg: AeBDieuV1tEh5EJJ1Vz9TadqDrE+j3JGTOnxC+CcRKdmNMk826U6ESVtOVPf4VJwl13
 lO5jMWS3UtUp8HnwJl6dVeftS+JjywApP0LO89hw+ZmEiTHTNq/7G3QBjksoOyeZ/X2rGL9DBMV
 j1HnuJd1UZhicA+ffU39BPCf6TfLlIo1UN83oPQJgP7dwREYB+qQkRyKLJeYYbCay5ILousi8sc
 m2nHo39rWzPFk//lFHzwzp+8l0u1bkiAKa5r1KDQQq+pWc5ee1P5LEtsjl2iqxenp+i66RMkO+x
 Fu9k7YlHLglSx30voHE51YjBnZotqI8OXKd4YErcyFKYsmVC8Bi8y/jYaSlifIuY5knYUndwRLc
 dGny2OVy1tzPxYJyoNw6GoCosDC/Q1FUuIDEAlDcn49i7YWzULkEA5TNxkzQUvMq9mZ52oBm66M
 7TmDXhdqdfrZSK1ZcmGl81cqmcdzXrur0g3U5P88lUrhQ/QL55eyAVuqcmomCMoVGeJGLtPZmBB
 zTsC4JAjV+GM8A197EDiA==
X-Received: by 2002:a05:6000:290f:b0:43d:7af0:3a7c with SMTP id
 ffacd0b85a97d-4515d3dc24cmr6096479f8f.29.1778076275787; 
 Wed, 06 May 2026 07:04:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-450524833e1sm13014054f8f.2.2026.05.06.07.04.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:04:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 070/110] accel/tcg: Remove non-explicit endian cpu_ld*_code()
 wrappers
Date: Wed,  6 May 2026 15:54:42 +0200
Message-ID: <20260506135524.20617-71-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

All uses were converted to the cpu_ld*_code_mmu() helpers:
remove them. Update the documentation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260320074555.33974-3-philmd@linaro.org>
---
 docs/devel/loads-stores.rst  | 21 +++++++++------------
 include/accel/tcg/cpu-ldst.h | 33 ++-------------------------------
 2 files changed, 11 insertions(+), 43 deletions(-)

diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index 57892e814cd..c719241a7f5 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -235,16 +235,13 @@ Regexes for git grep:
  - ``\<cpu_ld[us]\?[bwlq]\(_[bl]e\)\?_data\>``
  - ``\<cpu_st[bwlq]\(_[bl]e\)\?_data\+\>``
 
-``cpu_ld*_code``
-~~~~~~~~~~~~~~~~
+``cpu_ld*_code_mmu``
+~~~~~~~~~~~~~~~~~~~~
 
-These functions perform a read for instruction execution.  The ``mmuidx``
-parameter is taken from the current mode of the guest CPU, as determined
-by ``cpu_mmu_index(env, true)``.  The ``retaddr`` parameter is 0, and
-thus does not unwind guest CPU state, because CPU state is always
-synchronized while translating instructions.  Any guest CPU exception
-that is raised will indicate an instruction execution fault rather than
-a data read fault.
+These functions work like the ``cpu_{ld,st}*_mmu`` functions
+except that they perform a read for instruction execution.
+Any guest CPU exception that is raised will indicate an instruction
+execution fault rather than a data read fault.
 
 In general these functions should not be used directly during translation.
 There are wrapper functions that are to be used which also take care of
@@ -252,7 +249,7 @@ plugins for tracing.
 
 Function names follow the pattern:
 
-load: ``cpu_ld{sign}{size}_code(env, ptr)``
+load: ``cpu_ld{sign}{size}_code_mmu(env, addr, oi, retaddr)``
 
 ``sign``
  - (empty) : for 32 or 64 bit sizes
@@ -266,12 +263,12 @@ load: ``cpu_ld{sign}{size}_code(env, ptr)``
  - ``q`` : 64 bits
 
 Regexes for git grep:
- - ``\<cpu_ld[us]\?[bwlq]_code\>``
+ - ``\<cpu_ld[us]\?[bwlq]_code_mmu\>``
 
 ``translator_ld*``
 ~~~~~~~~~~~~~~~~~~
 
-These functions are a wrapper for ``cpu_ld*_code`` which also perform
+These functions are a wrapper for ``cpu_ld*_code_mmu`` which also perform
 any actions required by any tracing plugins.  They are only to be
 called during the translator callback ``translate_insn``.
 
diff --git a/include/accel/tcg/cpu-ldst.h b/include/accel/tcg/cpu-ldst.h
index ea2cbf40fe4..1facabccb23 100644
--- a/include/accel/tcg/cpu-ldst.h
+++ b/include/accel/tcg/cpu-ldst.h
@@ -51,10 +51,9 @@
  *     _be: for forced big endian
  *     _le: for forced little endian
  *
- * mmusuffix is one of the generic suffixes "data" or "code", or "mmuidx".
+ * mmusuffix is one of the generic suffixes "data" or "mmuidx".
  * The "mmuidx" suffix carries an extra mmu_idx argument that specifies
- * the index to use; the "data" and "code" suffixes take the index from
- * cpu_mmu_index().
+ * the index to use; the "data" suffix take the index from cpu_mmu_index().
  *
  * The "mmu" suffix carries the full MemOpIdx, with both mmu_idx and the
  * MemOp including alignment requirements.  The alignment will be enforced.
@@ -470,34 +469,6 @@ cpu_stq_le_data(CPUArchState *env, abi_ptr addr, uint64_t val)
 # define cpu_stl_mmuidx_ra    cpu_stl_le_mmuidx_ra
 # define cpu_stq_mmuidx_ra    cpu_stq_le_mmuidx_ra
 #endif
-
-static inline uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr)
-{
-    CPUState *cs = env_cpu(env);
-    MemOpIdx oi = make_memop_idx(MO_UB, cpu_mmu_index(cs, true));
-    return cpu_ldb_code_mmu(env, addr, oi, 0);
-}
-
-static inline uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr)
-{
-    CPUState *cs = env_cpu(env);
-    MemOpIdx oi = make_memop_idx(MO_TEUW, cpu_mmu_index(cs, true));
-    return cpu_ldw_code_mmu(env, addr, oi, 0);
-}
-
-static inline uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr)
-{
-    CPUState *cs = env_cpu(env);
-    MemOpIdx oi = make_memop_idx(MO_TEUL, cpu_mmu_index(cs, true));
-    return cpu_ldl_code_mmu(env, addr, oi, 0);
-}
-
-static inline uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr)
-{
-    CPUState *cs = env_cpu(env);
-    MemOpIdx oi = make_memop_idx(MO_TEUQ, cpu_mmu_index(cs, true));
-    return cpu_ldq_code_mmu(env, addr, oi, 0);
-}
 #endif /* TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API */
 
 #endif /* ACCEL_TCG_CPU_LDST_H */
-- 
2.53.0


