Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DD4606A332
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 20:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=G/cguTMP;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cA9f087N
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRFHa-0001PG-2z; Wed, 11 Nov 2026 15:51:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRFHV-0001Mr-Co
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 15:50:57 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRFHT-0003HO-11
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 15:50:57 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABIpAXX1141844
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 20:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=hbbu8NzLOTmuqCUqSq8vt918AgdNtA1RlTd
 btHruRNw=; b=G/cguTMP/Uhpb7eMR8Xaoa16uK4TAVg73iMa6mSQPwJ9+p/M0vF
 SVtIR3zT8rLHn85jF7c4uiTqn4lXZhC1w/InvzBp2VCZtoIKruaja1zLKKyHfSsO
 0fefuSHYnzm1Aj3VOX+Hd7kKvpo7KvZ+dk2uBF9K3pgvCl80i5B+4SDGf+zlnBGx
 /DgBmPgv/4JUqJ2iT5cw6yBOjhGluIRNSDrgLbqsnWiVfik8q0hRYJ9EQWO5WTrC
 Ds2p82odWdOGANReuUbIWmzo2aeuwni/P70+S5bo3vYrMs3lejP/rBehRucDZ4nI
 79JwAT+UcjxkjQSUeHw+GBCHEltHw12UVTQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvpjjtk6p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 20:50:50 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91c7bf2d734so77161486d6.3
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 12:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794430250; x=1795035050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hbbu8NzLOTmuqCUqSq8vt918AgdNtA1RlTdbtHruRNw=;
 b=cA9f087Nn2vvwBw+h/Vi90peQ7knLqNthe9vMsKcQvckl2i9Wfsc3JmBhubNjV/b0L
 t3NfxinGdVVGg+RsRj7RNCMOJJqwk2CcnAK8ZNSCmv8GU6zjkol8Zi3nrA9CqPjLN0L6
 K2sh+O+U8b6Um/kYB/vMZx1Xm/ICcL1eUPRlDB3NtSbn9udO7y1Wk5DLDE5Tb7Wt8IMQ
 EaZYJBOBOR4k69EJuFeMUMlpQjgb57z/R7OhuTz9QXz6rEfTCqze6j/BvOn6p+8UbNJ/
 UESWHVd34uLIanYMJNopK/IljAEZ1IK77Af9D9ToQDVYExuz/u/q9p7SR3HWz83E2SMv
 uzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794430250; x=1795035050;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hbbu8NzLOTmuqCUqSq8vt918AgdNtA1RlTdbtHruRNw=;
 b=IS6ghjkBLyQVbfAYjjR29O1p9eVuLhDepFkmz9nJJl9+MQkiC9IukqK/me5S+wi0p1
 IP2YS8Ykibz35nYEKWGjQp0nW4ow+/97cxwh06HQKQugujI9TfHQUXVCuAQ4NDxI7+9E
 Fh0N+L0B0em8XSJAGRm044fGTYDjo9lKtgUhF2Xel4AfJ5m9vuwClK4JCR1re2vsgxBT
 IEceIhJdH9ipVCwDowZpQvtMogLJzkcR+6oyfEt/HO/GX1gaiIrTBtI4/NrFgMVaatqj
 UrF9GShR/qYhWog+eLjhxwZ0qwwmvJxxzm0243XUn+xChMoaiW6xR29yLGCQM0aJB72T
 e36Q==
X-Gm-Message-State: APuU4Z8/adpjERZJDbcodFLna14HQ9HHs02uQIuN7CUeI6ez2R2hvNcJ
 oJzut+TeFBu6CuX/3nE4vFqDeWxMFzW8MktoakTxeB5O+FDH5y3twcRKyuETuF9gHk5VnFi4g07
 90CSW9h6etfkB+7KlgOfqNwfijgEcs+jg8FCtUaSWVy15PoA5NnR5mw8euSa5FmbRpw==
X-Gm-Gg: AYBFou3WV2Z2C69zY5HViwz6fBmXqHJLsoa9Z/K1IwxFPlQifj4zl71mLumQLT3RbOO
 8uoeeuPd4iNRA46Xv9/YmdtVMKCgfDipc/9M4zCXIACWUtH7x2/tJrS3mEVjAnGQBKvRf2ObyVx
 59TwXZ3tC3kTFw30ITbBUeHCCZX2WvnLSiXKRjvV1l8Ftw8eHBnb4RYYghdnZzyaeLynqrEjVLA
 mw1sy5KqEgHPPqPt6/pJrOAabT5uawSxlKAmTl7PnBU7hQRVl5v2gHiQP99D5oklnxlEInrNqPC
 x0WtsnqP5Ze8teiDoj77HkpO/C39vaeaawmidTTm0zt16Jxjrf28sEpLUHh07XraHpY95MUCwhK
 Jz+OlH0IO1r30U1MB+WbJP6yw8SCG2N0DcqdRVQgLB4d4rolx+uWuTG7YqHb6RU8cDJkmFGLZYO
 zIWeClL4y1Pdesar/+69x/gq35rO+6X9aD9OoWVv+Dq9Pu
X-Received: by 2002:a05:620a:688b:b0:93f:633b:ee13 with SMTP id
 af79cd13be357-947afd67c8bmr614271585a.28.1794430249611; 
 Wed, 11 Nov 2026 12:50:49 -0800 (PST)
X-Received: by 2002:a05:620a:688b:b0:93f:633b:ee13 with SMTP id
 af79cd13be357-947afd67c8bmr614267285a.28.1794430249083; 
 Wed, 11 Nov 2026 12:50:49 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com (189-68-253-226.dsl.telesp.net.br.
 [189.68.253.226]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e7915e2sm565336085a.23.2026.11.11.12.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 12:50:47 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] target/riscv: avoid amocas.* x0 clobbering [GL3526]
Date: Wed, 11 Nov 2026 17:50:43 -0300
Message-ID: <20261111205043.327652-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA4MyBTYWx0ZWRfXzqssB5TuO0/p
 rjV1X6PjL6vbmtJNVRxW1jNPR+sbrrxRMUU4NaRbUbIqNopfbykji9ZU9LIGSVSJXk3snNxQZlE
 aUHr401BnXek70z7xBeu47wUnR+Kz5TAwJ5JHo+ubTq+3qGm9m/WuueAvm/hbQR0qIjJx8n3D6h
 5xmpzu1k6Az1XAkAwhmJ5J3Go+NFrhI+DXLc58YUIZ01eCCOf9hjMjq0gluT0gs7mqclQqovKFi
 GWW+Nzb/pHdlrZqcygQZ4moID7BdfZLWlyRIkCph77CyE3ZPdZJp53NCjyY335iJIrELeV28lff
 jaBi+yiAXfNXKAtyqikBOUhHcSsawdGQSr9oNOkjW+jsI+39nVVTQVTejyfNwP9sLIibbBTmzSX
 h2yz4HomCGgFPbYCNAXyAv3mELfCLgWne/PbBpgWJyvNN5MPm8uleiUH7ZsJyTRJZ8CNkHg+JlA
 YwpcDYR7T+/kXBQJPkg==
X-Proofpoint-ORIG-GUID: AuLT829gOoxA04kMaACl31M-5-an58bG
X-Authority-Analysis: v=2.4 cv=FeuiV5+6 c=1 sm=1 tr=0 ts=6af4d52a cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xcxBfRYLw5hNHjR815/AfA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=sK0Jn417EFhoLsV17G0A:9 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: AuLT829gOoxA04kMaACl31M-5-an58bG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA4MyBTYWx0ZWRfX+X8EumM9S+36
 +fmv8/ib00TyDGr+RhprSD4yXdOwSH3yEFTpqNAqwrf2Z7Ntq04sHejcRC2CY6EL8YURmEJDlyT
 3xsNaOI4e4+SzsMXRnJGcILsmM8Pxzs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110083
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

gen_cmpxchg* and trans_amocas_q() load amocas registers using get_gpr().
When the register is x0/zero get_gpr() returns ctx->zero, the shared TCG
constant that every x0 read uses.  As it is today, the amocas helpers
uses tcg_gen_atomic_cmpxchg_* helpers using the dest register retrieved
by get_gpr().

So, if we have something like:

amocas.d                zero,s0,(a0)

gen_cmpxchg() uses ctx->zero as 'dest' for tcg_gen_atomic_cmpxchg_tl(),
which will end up clobbering it with whatever is in 'rs1'.  ctx->zero
will be reset back to normal in init_disas_context(), but if there's
something else that ends up reading it in the same TB, e.g.:

beqz                    a2,24

This will read a clobbered ctx->zero and then all bets are off.

The fix is to use a temp variable as 'dest' for gen_atomic_cmpxchg_*
calls instead of the result of get_gpr().  We are already executing
gen_set_grp() in all cases using 'dest', making this change a bit
simpler.

Fixes: b52d49e97fc4 ("target/riscv: Add support for Zacas extension")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3526
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 .../riscv/tcg/insn_trans/trans_rvzacas.c.inc  | 15 ++++--
 target/riscv/tcg/translate.c                  |  5 +-
 tests/tcg/riscv64/system/meson.build          |  8 +++
 tests/tcg/riscv64/test-amocas-x0.S            | 49 +++++++++++++++++++
 4 files changed, 70 insertions(+), 7 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-amocas-x0.S

diff --git a/target/riscv/tcg/insn_trans/trans_rvzacas.c.inc b/target/riscv/tcg/insn_trans/trans_rvzacas.c.inc
index 79bca1e957..e908ed2377 100644
--- a/target/riscv/tcg/insn_trans/trans_rvzacas.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvzacas.c.inc
@@ -72,13 +72,14 @@ static bool gen_cmpxchg64(DisasContext *ctx, arg_atomic *a, MemOp mop)
         return false;
     }
 
-    TCGv_i64 dest = get_gpr_pair(ctx, a->rd);
+    TCGv_i64 cmp = get_gpr_pair(ctx, a->rd);
     TCGv src1 = get_address(ctx, a->rs1, 0);
     TCGv_i64 src2 = get_gpr_pair(ctx, a->rs2);
+    TCGv_i64 dest = tcg_temp_new_i64();
 
     mop |= ctx->mo_endianness;
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
-    tcg_gen_atomic_cmpxchg_i64(dest, src1, dest, src2, ctx->mem_idx, mop);
+    tcg_gen_atomic_cmpxchg_i64(dest, src1, cmp, src2, ctx->mem_idx, mop);
 
     gen_set_gpr_pair(ctx, a->rd, dest);
     return true;
@@ -117,15 +118,19 @@ static bool trans_amocas_q(DisasContext *ctx, arg_amocas_q *a)
     TCGv_i128 src2 = tcg_temp_new_i128();
     TCGv_i64 src2l = get_gpr(ctx, a->rs2, EXT_NONE);
     TCGv_i64 src2h = get_gpr(ctx, a->rs2 == 0 ? 0 : a->rs2 + 1, EXT_NONE);
-    TCGv_i64 destl = get_gpr(ctx, a->rd, EXT_NONE);
-    TCGv_i64 desth = get_gpr(ctx, a->rd == 0 ? 0 : a->rd + 1, EXT_NONE);
+    TCGv_i64 cmpl = get_gpr(ctx, a->rd, EXT_NONE);
+    TCGv_i64 cmph = get_gpr(ctx, a->rd == 0 ? 0 : a->rd + 1, EXT_NONE);
+    TCGv_i64 destl = tcg_temp_new_i64();
+    TCGv_i64 desth = tcg_temp_new_i64();
+    TCGv_i128 cmp = tcg_temp_new_i128();
     MemOp memop = MO_ALIGN | MO_UO;
 
     memop |= ctx->mo_endianness;
+    tcg_gen_concat_i64_i128(cmp, cmpl, cmph);
     tcg_gen_concat_i64_i128(src2, src2l, src2h);
     tcg_gen_concat_i64_i128(dest, destl, desth);
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
-    tcg_gen_atomic_cmpxchg_i128(dest, src1, dest, src2, ctx->mem_idx, memop);
+    tcg_gen_atomic_cmpxchg_i128(dest, src1, cmp, src2, ctx->mem_idx, memop);
 
     tcg_gen_extr_i128_i64(destl, desth, dest);
 
diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
index 79b0f444ef..b9f47a4fc2 100644
--- a/target/riscv/tcg/translate.c
+++ b/target/riscv/tcg/translate.c
@@ -1175,13 +1175,14 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
 
 static bool gen_cmpxchg(DisasContext *ctx, arg_atomic *a, MemOp mop)
 {
-    TCGv dest = get_gpr(ctx, a->rd, EXT_NONE);
+    TCGv cmp = get_gpr(ctx, a->rd, EXT_NONE);
     TCGv src1 = get_address(ctx, a->rs1, 0);
     TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);
+    TCGv dest = tcg_temp_new();
 
     mop |= ctx->mo_endianness;
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
-    tcg_gen_atomic_cmpxchg_tl(dest, src1, dest, src2, ctx->mem_idx, mop);
+    tcg_gen_atomic_cmpxchg_tl(dest, src1, cmp, src2, ctx->mem_idx, mop);
 
     gen_set_gpr(ctx, a->rd, dest);
     return true;
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index 3c8b018d9e..985c492a00 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -89,6 +89,14 @@ tests += {
   }
 }
 
+tests += {
+  'test-amocas-x0.S': {
+    'exe_name': 'test-amocas-x0',
+    'cflags': cflags + ['-march=rv64gc'],
+    'qemu_args': ['-cpu', 'max', qemu_args],
+  }
+}
+
 if 'qemu-system-riscv64' in emulators
   tcg_tests += {
     'riscv64-softmmu': {
diff --git a/tests/tcg/riscv64/test-amocas-x0.S b/tests/tcg/riscv64/test-amocas-x0.S
new file mode 100644
index 0000000000..d71814035c
--- /dev/null
+++ b/tests/tcg/riscv64/test-amocas-x0.S
@@ -0,0 +1,49 @@
+/*
+ * Test if amocas.d will clobber x0.  Based on Gitlab 3526.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+	.option norvc
+	.text
+
+	.global _start
+
+_start:
+	li     t0, 5
+	lla    t1, amo_target
+	li     t2, 0
+
+	/* amocas.d zero, t0, (t1) */
+	.word  0x2853302f
+
+        /* If x0 is clobbered this bnez will fail.  */
+	bnez   t2, _fail
+
+	li     a0, 0
+	j      _exit
+
+_fail:
+	li    a0, 1
+
+/* Exit through the semihosting SYS_EXIT_EXTENDED call with a0 as the code. */
+_exit:
+	lla	a1, semiargs
+	li	t0, 0x20026	/* ADP_Stopped_ApplicationExit */
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
+	li	a0, 0x20	/* TARGET_SYS_EXIT_EXTENDED */
+	.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+	.data
+	.balign	8
+semiargs:
+	.space	16
+/* An amo target must be a valid, 8-byte aligned address.  */
+amo_target:
+	.dword	0x1234
-- 
2.43.0


