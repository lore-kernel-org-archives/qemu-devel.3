Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9F2C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TtD-0005T2-SL; Fri, 04 Sep 2026 09:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TtB-0005SL-Gb
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:23:29 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2Tt8-0008GC-NK
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:23:29 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4957eefd361so7690915e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788528205; x=1789133005; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cKQJGHQ+w7edigcXwLoHDig3QPQWeSds/1gr0aT4kEY=;
 b=yc/x+NB0G7D9BfGWWThINCdDPyIA3ttGzrN0IG+Qxv+4kbBDF1mwLtxO4s/CxltZtC
 cLBdj+U/U2nUlYCIPWN2ONbvMM/ilu8INwJfHQ5ed0V9Pz6f5vNxu2B1Yr286EN3HBWG
 1hnzEosRJA1r0iJyzWI0odN6a3gVG9G7yriX3EpCHrg+qBVa5u9p3fN8f3uv4BVaeZNf
 Yt3nE7dRD70LnK7+5UxjW1WJhmsNNQMvBzElMvbtbPGCMl70xeh2OzhtCFStSbr7oiXb
 IzQ7QtKcpf35hvjDi9ESBF520AI8sWMOfFkxgv2qQIr2vWUs+9khDUh7m4a7GAfnNsgL
 cuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788528205; x=1789133005;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cKQJGHQ+w7edigcXwLoHDig3QPQWeSds/1gr0aT4kEY=;
 b=k3tQDcI8eW86yFJxwklSP/g9zFEqSFpAx4jLNAkTn0epneX3Tm1mjCbd7W9Ovl64Zk
 UYlKwoVAdCHSGvyHChszb8DGcSSHc0f/pfgw2JdaShprXrrDKdIVLMM25YXZoi2BIrRb
 lA3TUN6eNmV31lDymExodUCu1/BqmjgDRtHdY3VgfxZ6/VXoYxcjneWMELDZTuPTNMRw
 8gTzFPGEYQNtasXCWdbB87eu0f2asTDVsZJRBJqhi3ZYhA2Hq7HS6SJKYvoz2zrD8wVP
 XAjiO2lKVSus8JQiF0lCXnGQse74EouZeqsC1CGcAf3KJDtxI1I9chiXVxnMZu3yiuHQ
 A8Kg==
X-Gm-Message-State: AFuF++lsphNA3zZsgCJyvFtfcQ9nxYRaoeu3rigYjTLvwSLLNWHici61
 VcLd7XpUHziuwV+AxH3dN2INFaYRPs4H+IKWCmRD0NdH4j837E1o4UaSWIfmI7tDKLg=
X-Gm-Gg: AYBFou0p1Ekn85YG0cDBLMJs2cuEteW9lfFjP48CKplF5yr8vGoPh8UM9Zn4HzJvnmP
 tBLqPWw3tRVAIei4oDGcyBMKWPiGyB4hdqL02rmqguWiez76tuwSlKfMZN6mBM07hks/3x6TKky
 dI7feoK5igeFh5wVpySupsyV76TIJyVUMkg/Zki+RIC/gMwoQG5JD4yEm3l1XPsG10LTRyRkOqB
 uF3tyhzNKqfYS3U3ZtilJ9/t7GsiGT/7BlXh7Bx4+g6glmwUQZNVQ+LYrBedo5uY7DJiJtNFM8F
 8o1SaQW33jGzukJ1oWL6oY8vYilD8+xB7MyH4qUvKkLUDZYHKTfih3Y3jyYLJCJu7TEqJQgKLeN
 pBcSkMwP2WcJwniaBjmFS7RHPQo3BSw+ZfBorqnzAwrQNWgDhQGUVEabpU5wgo7hjZecCMzR3nX
 2JNcdYSk20b7t1lzcWwxLloO4wKdDxcDvU73xyPJPV8fK62pQUN4qGXGSiG7jv
X-Received: by 2002:a05:600d:6501:10b0:49c:f2f4:edca with SMTP id
 5b1f17b1804b1-49cf825c891mr50597475e9.15.1788528204654; 
 Fri, 04 Sep 2026 06:23:24 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf772bd2asm64104485e9.11.2026.09.04.06.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:23:23 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6024E61996;
 Fri, 04 Sep 2026 13:46:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 050/105] tests/tcg/hexagon: user tests
Date: Fri,  4 Sep 2026 13:45:04 +0100
Message-ID: <20260904124604.2207440-51-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-51-pierrick.bouvier@oss.qualcomm.com>
[AJB: fix merge conflict]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
deleted file mode 100644
index f72bb8a6b45..00000000000
--- a/tests/tcg/hexagon/Makefile.target
+++ /dev/null
@@ -1,166 +0,0 @@
-##
-##  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
-##
-##  This program is free software; you can redistribute it and/or modify
-##  it under the terms of the GNU General Public License as published by
-##  the Free Software Foundation; either version 2 of the License, or
-##  (at your option) any later version.
-##
-##  This program is distributed in the hope that it will be useful,
-##  but WITHOUT ANY WARRANTY; without even the implied warranty of
-##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-##  GNU General Public License for more details.
-##
-##  You should have received a copy of the GNU General Public License
-##  along with this program; if not, see <http://www.gnu.org/licenses/>.
-##
-
-# Hexagon doesn't support gdb, so skip the EXTRA_RUNS
-EXTRA_RUNS =
-
-CFLAGS += -Wno-incompatible-pointer-types -Wno-undefined-internal
-CFLAGS += -fno-unroll-loops -fno-stack-protector
-
-HEX_SRC=$(SRC_PATH)/tests/tcg/hexagon
-VPATH += $(HEX_SRC)
-
-%: $(HEX_SRC)/%.S $(HEX_SRC)/crt.S
-	$(CC) -static -mv67 -nostdlib $^ -o $@
-
-HEX_TESTS = first
-HEX_TESTS += hex_sigsegv
-HEX_TESTS += misc
-HEX_TESTS += usr
-HEX_TESTS += preg_alias
-HEX_TESTS += dual_stores
-HEX_TESTS += multi_result
-HEX_TESTS += mem_noshuf
-HEX_TESTS += mem_noshuf_exception
-HEX_TESTS += circ
-HEX_TESTS += brev
-HEX_TESTS += load_unpack
-HEX_TESTS += load_align
-HEX_TESTS += atomics
-HEX_TESTS += fpstuff
-HEX_TESTS += overflow
-HEX_TESTS += signal_context
-HEX_TESTS += reg_mut
-HEX_TESTS += read_write_overlap
-HEX_TESTS += vector_add_int
-HEX_TESTS += scatter_gather
-HEX_TESTS += hvx_misc
-HEX_TESTS += hvx_histogram
-HEX_TESTS += fp_hvx
-HEX_TESTS += fp_hvx_cvt
-HEX_TESTS += fp_hvx_cmp
-HEX_TESTS += fp_hvx_disabled
-HEX_TESTS += invalid-slots
-HEX_TESTS += valid-slots
-HEX_TESTS += invalid-encoding
-HEX_TESTS += multiple-writes
-HEX_TESTS += privileged-insn
-HEX_TESTS += unaligned_pc
-HEX_TESTS += unaligned_data
-HEX_TESTS += icinva
-
-HEX_TESTS += test_abs
-HEX_TESTS += test_bitcnt
-HEX_TESTS += test_bitsplit
-HEX_TESTS += test_call
-HEX_TESTS += test_clobber
-HEX_TESTS += test_cmp
-HEX_TESTS += test_dotnew
-HEX_TESTS += test_ext
-HEX_TESTS += test_fibonacci
-HEX_TESTS += test_hl
-HEX_TESTS += test_hwloops
-HEX_TESTS += test_jmp
-HEX_TESTS += test_lsr
-HEX_TESTS += test_mpyi
-HEX_TESTS += test_packet
-HEX_TESTS += test_reorder
-HEX_TESTS += test_round
-HEX_TESTS += test_vavgw
-HEX_TESTS += test_vcmpb
-HEX_TESTS += test_vcmpw
-HEX_TESTS += test_vlsrw
-HEX_TESTS += test_vmaxh
-HEX_TESTS += test_vminh
-HEX_TESTS += test_vpmpyh
-HEX_TESTS += test_vspliceb
-
-HEX_TESTS += check_rev_gating
-HEX_TESTS += test_pnew_jump_loads
-
-HEX_TESTS += v68_scalar
-HEX_TESTS += v68_hvx
-HEX_TESTS += v69_hvx
-HEX_TESTS += v73_scalar
-
-TESTS += $(HEX_TESTS)
-
-atomics: atomics.c hex_test.h
-brev: brev.c hex_test.h
-circ: circ.c hex_test.h
-dual_stores: dual_stores.c hex_test.h
-fpstuff: fpstuff.c hex_test.h
-hex_sigsegv: hex_sigsegv.c hex_test.h
-icinva: icinva.c hex_test.h
-load_align: load_align.c hex_test.h
-load_unpack: load_unpack.c hex_test.h
-mem_noshuf_exception: mem_noshuf_exception.c hex_test.h
-mem_noshuf: mem_noshuf.c hex_test.h
-misc: misc.c hex_test.h
-multi_result: multi_result.c hex_test.h
-overflow: overflow.c hex_test.h
-preg_alias: preg_alias.c hex_test.h
-read_write_overlap: read_write_overlap.c hex_test.h
-reg_mut: reg_mut.c hex_test.h
-test_pnew_jump_loads: test_pnew_jump_loads.c hex_test.h
-unaligned_data: unaligned_data.c hex_test.h
-unaligned_pc: unaligned_pc.c
-
-# Compile for v66 so that the ELF selects a v66 CPU; the test then
-# exercises revision gating by executing a v68 .word instruction.
-run-check_rev_gating: QEMU_OPTS += -cpu v66
-check_rev_gating: check_rev_gating.c
-	$(CC) $(CFLAGS) -mv66 -O2 $< -o $@ $(LDFLAGS)
-
-# This test has to be compiled for the -mv67t target
-usr: usr.c hex_test.h
-	$(CC) $(CFLAGS) -mv67t -O2 -Wno-inline-asm -Wno-expansion-to-defined $< -o $@ $(LDFLAGS)
-
-# Build this test with -mv71 to exercise the CABAC instruction
-misc: misc.c
-	$(CC) $(CFLAGS) -mv71 -O2 $< -o $@ $(LDFLAGS)
-scatter_gather: CFLAGS += -mhvx
-vector_add_int: CFLAGS += -mhvx -fvectorize
-hvx_misc: hvx_misc.c hvx_misc.h
-hvx_misc: CFLAGS += -mhvx
-hvx_histogram: CFLAGS += -mhvx -Wno-gnu-folding-constant
-v68_hvx: v68_hvx.c hvx_misc.h v6mpy_ref.c.inc
-v68_hvx: CFLAGS += -mhvx -Wno-unused-function
-v69_hvx: v69_hvx.c hvx_misc.h
-v69_hvx: CFLAGS += -mhvx -Wno-unused-function
-v73_scalar: CFLAGS += -Wno-unused-function
-fp_hvx: fp_hvx.c hvx_misc.h hex_test.h
-fp_hvx: CFLAGS += -mhvx -mhvx-ieee-fp
-fp_hvx_disabled: fp_hvx_disabled.c hvx_misc.h hex_test.h
-fp_hvx_disabled: CFLAGS += -mhvx -mhvx-ieee-fp
-fp_hvx_cvt: fp_hvx_cvt.c hvx_misc.h hex_test.h
-fp_hvx_cvt: CFLAGS += -mhvx -mhvx-ieee-fp
-fp_hvx_cmp: fp_hvx_cmp.c hvx_misc.h hex_test.h
-fp_hvx_cmp: CFLAGS += -mhvx -mhvx-ieee-fp
-
-run-fp_hvx_disabled: QEMU_OPTS += -cpu v73,ieee-fp=false
-
-hvx_histogram: hvx_histogram.c hvx_histogram_row.S
-	$(CC) $(CFLAGS) $(CROSS_CC_GUEST_CFLAGS) $^ -o $@ $(LDFLAGS)
-
-ifeq ($(CONFIG_PLUGIN),y)
-# LLVM is way too aggressive with inlining and dead code elimination even at
-# -O0, which interferes with the test. What looks like dead code in this test
-# to the compiler isn't actually dead code, so we need to disable all potential
-# LLVM optimization passes.
-test-plugin-set-pc: CFLAGS += -Xclang -disable-llvm-passes
-endif
diff --git a/tests/tcg/hexagon/meson.build b/tests/tcg/hexagon/meson.build
new file mode 100644
index 00000000000..4a2826c4276
--- /dev/null
+++ b/tests/tcg/hexagon/meson.build
@@ -0,0 +1,120 @@
+tests = []
+
+cflags = ['-Wno-incompatible-pointer-types', '-Wno-undefined-internal',
+          '-fno-unroll-loops', '-fno-stack-protector']
+asmflags = [cflags, '-nostdlib', '-mv67', files('crt.S')]
+
+multi_src = []
+foreach t: tcg_tests['multiarch-linux-user']['tests']
+  foreach src, setup: t
+    if 'gdb_test' in setup
+      # gdb does not support hexagon, ignore test
+      continue
+    endif
+    new_cflags = []
+    if 'cflags' in setup
+      new_cflags += setup['cflags']
+    endif
+    new_cflags += cflags
+    if src not in multi_src
+      setup += {'cflags': [new_cflags]}
+      multi_src += src
+    endif
+    tests += {src: setup}
+  endforeach
+endforeach
+
+tests += {
+  'atomics.c': {'cflags': cflags},
+  'brev.c': {'cflags': cflags},
+  # Compile for v66 so that the ELF selects a v66 CPU; the test then
+  # exercises revision gating by executing a v68 .word instruction.
+  'check_rev_gating.c': {
+    'cflags': [cflags, '-mv66', '-O2'],
+    'qemu_args': ['-cpu', 'v66'],
+  },
+  'circ.c': {'cflags': cflags},
+  'first.S': {'cflags': asmflags},
+  'fpstuff.c': {'cflags': cflags},
+  'hex_sigsegv.c': {'cflags': cflags},
+  'fp_hvx.c': {'cflags': [cflags, '-mv73', '-mhvx', '-mhvx-ieee-fp']},
+  'fp_hvx_disabled.c': {'cflags': [cflags, '-mv73', '-mhvx', '-mhvx-ieee-fp'],
+                        'qemu_args': ['-cpu', 'v73,ieee-fp=false']},
+  'fp_hvx_cvt.c': {'cflags': [cflags, '-mv73', '-mhvx', '-mhvx-ieee-fp']},
+  'fp_hvx_cmp.c': {'cflags': [cflags, '-mv73', '-mhvx', '-mhvx-ieee-fp']},
+  'hvx_misc.c': {'cflags': [cflags, '-mhvx', '-mv69']},
+  'hvx_histogram.c': {
+    'cflags': [cflags, '-mhvx', '-Wno-gnu-folding-constant',
+               files('hvx_histogram_row.S')]
+  },
+  'invalid-encoding.c': {'cflags': cflags},
+  'invalid-slots.c': {'cflags': cflags},
+  'icinva.c': {'cflags': cflags},
+  'load_align.c': {'cflags': cflags},
+  'load_unpack.c': {'cflags': cflags},
+  # Build this test with -mv71 to exercise the CABAC instruction
+  'misc.c': {'cflags': [cflags, '-mv71', '-O2']},
+  'multiple-writes.c': {'cflags': cflags},
+  'overflow.c': {'cflags': cflags, 'exe_name': 'hex-overflow'},
+  'preg_alias.c': {'cflags': cflags},
+  'dual_stores.c': {'cflags': cflags},
+  'multi_result.c': {'cflags': cflags},
+  'mem_noshuf.c': {'cflags': cflags},
+  'mem_noshuf_exception.c': {'cflags': cflags},
+  'privileged-insn.c': {'cflags': cflags},
+  'read_write_overlap.c': {'cflags': cflags},
+  'reg_mut.c': {'cflags': cflags},
+  'scatter_gather.c': {'cflags': [cflags, '-mhvx']},
+  'signal_context.c': {'cflags': cflags},
+  'test_abs.S': {'cflags': asmflags},
+  'test_bitcnt.S': {'cflags': asmflags},
+  'test_bitsplit.S': {'cflags': asmflags},
+  'test_call.S': {'cflags': asmflags},
+  'test_clobber.S': {'cflags': asmflags},
+  'test_cmp.S': {'cflags': asmflags},
+  'test_dotnew.S': {'cflags': asmflags},
+  'test_ext.S': {'cflags': asmflags},
+  'test_fibonacci.S': {'cflags': asmflags},
+  'test_hl.S': {'cflags': asmflags},
+  'test_hwloops.S': {'cflags': asmflags},
+  'test_jmp.S': {'cflags': asmflags},
+  'test_lsr.S': {'cflags': asmflags},
+  'test_mpyi.S': {'cflags': asmflags},
+  'test_packet.S': {'cflags': asmflags},
+  'test_reorder.S': {'cflags': asmflags},
+  'test_round.S': {'cflags': asmflags},
+  'test_vavgw.S': {'cflags': asmflags},
+  'test_vcmpb.S': {'cflags': asmflags},
+  'test_vcmpw.S': {'cflags': asmflags},
+  'test_vlsrw.S': {'cflags': asmflags},
+  'test_vmaxh.S': {'cflags': asmflags},
+  'test_vminh.S': {'cflags': asmflags},
+  'test_vpmpyh.S': {'cflags': asmflags},
+  'test_vspliceb.S': {'cflags': asmflags},
+  'unaligned_pc.c': {'cflags': cflags},
+  'unaligned_data.c': {'cflags': cflags},
+  'usr.c': {
+    'cflags': [cflags, '-mv67t', '-O2',
+               '-Wno-inline-asm', '-Wno-expansion-to-defined']
+  },
+  'v68_scalar.c': {'cflags': [cflags, '-mv68']},
+  'v68_hvx.c': {'cflags': [cflags, '-mhvx', '-Wno-unused-function', '-mv68']},
+  'v69_hvx.c': {'cflags': [cflags, '-mhvx', '-Wno-unused-function', '-mv69']},
+  'v73_scalar.c': {'cflags': [cflags, '-Wno-unused-function', '-mv73']},
+  'valid-slots.c': {'cflags': cflags},
+  'vector_add_int.c': {'cflags': [cflags, '-mhvx', '-fvectorize']},
+}
+
+if 'qemu-hexagon' in emulators
+  tcg_tests += {
+    'hexagon-linux-user': {
+      'cc': 'hexagon-unknown-linux-musl-clang',
+      'cc_dockerfile': 'debian-hexagon-cross',
+      'cc_docker_host_arch': ['x86_64'],
+      'folder': 'hexagon',
+      'gdb_arch': 'hexagon_is_not_supported_by_gdb',
+      'qemu': emulators['qemu-hexagon'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 17f48bebf98..27d7aedb8b8 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -140,6 +140,7 @@ subdir('aarch64')
 subdir('aarch64_be')
 subdir('alpha')
 subdir('arm')
+subdir('hexagon')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


