Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080DD606A326
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 10:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nImFTzlm;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=avMOwpRX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWA4Q-0005ej-2m; Wed, 25 Nov 2026 05:17:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xWA4O-0005d4-Cm
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 05:17:44 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xWA4M-0003BQ-AM
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 05:17:44 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AP9mlXE3611422
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 10:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ZPFzXf5CXX9
 P55bldodHWlAY6t/62vaKgQ1lRwuIfJw=; b=nImFTzlmyXkq2UYMD6UD3QU9/Sh
 B8Y4Gi2T1yVhjvezSdF6nk/3FMQS8zdAV1I4JPKJNXBg8j86wQpicotPxkBQioZR
 j/nEqOoBHKnIoqL+nxc5CNdDQbJJr2HHPOBSKl1O8lcSswkPgO98YJVBlfU+onxD
 rInj9Qt7g+TVD9s/4loobSEfngwdj3WD9+rpRaK8nHrgxqN3g/rOKfQUFtV9aSmp
 8WSx7dbh/3Uy5ys7V+1h3LEkW2Hq8ncFfcRy3bpE7kKltvXuC8RF6iFZj1RgxNTf
 W5y2OL7k9ECCHp/ZH67FPYlxPKst/nyACpYBZnURK/bJnVOPyU4NR4UrfGg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5gnsb3jj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 10:17:39 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-92104826f9bso105053156d6.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 02:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795601858; x=1796206658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZPFzXf5CXX9P55bldodHWlAY6t/62vaKgQ1lRwuIfJw=;
 b=avMOwpRXy9z4lrRiiWpOhU1rF0uLaPkkODmtua4VIz5hFBYzDMYCAN7HEl1Ah4oQjB
 dmBj8isn3u8gB9JUZM6tXNMTfCL9xNeJB4er3Sb/1e5tWEZvYSXMGaFOMl2Sbh1qfz8e
 FYEM0u4xClSDVhy9CAebd/TfuxTy4irAr4EViel3RS6qdzOcl1NeAETQEnQHEOhoMEUD
 tYTbeA/7iGLIQrX1TzIG9RU+lhItgm2/IEbKYhD/cNXMbVneUsHG/7rhkSsGEaaqFjWA
 faKbAreZ/5UFnch67TvG5QmYhbQDiud/c5M720RVZILldUMxiYjdQaaMLm7AfzkjbYUb
 uVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795601858; x=1796206658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZPFzXf5CXX9P55bldodHWlAY6t/62vaKgQ1lRwuIfJw=;
 b=eXfbVWCtjfYeU8Nd5Z+9vCb6E6j+mXnK26iACh7vZD8lbz5741gra3OyUNhJjYiYyR
 k6jxzQzLFBmLz7S66ihH5u9Sd/05V5idsjfLM5Iex68qX4CkCdgGB7DkQpnyngpAHayv
 4ExBw7MfGvmj5m4JsD9UqX21sEuwnHuAuN2nKSONJillhzOJQh05DT9GgtlfNc4DahjO
 UP+Z6OeMXjCt0rNcqBBUGmkrzbvwZFkhsr79ONrR7M1hHbTHKLebBJsun3URTvz1rywp
 paU0jmURCJuHbCKkVMTBHCRkDnqVZpvjArcDG+Paw3FLTaYFamGgQZ88HMEugS1QloqB
 Lmpw==
X-Gm-Message-State: APuU4Z8Xs4Jo9DH43f4oz9/BH2Ac0JyB8TduGJbn9OdzBRBRF03Xoocm
 Uh76YIH/VJk8x4KfYRH4I1qhRFSmGfSQPRnlHw9UUqAaAyrXuCl2qmxxV1ne6kdJR6MU8yjiAJz
 lKpYNMV2J8+Pli9Zt8Wdfm9TXyIwXDkNVO3uSeOnToHUWjB5tgJz90RT0qOrduBYOZA==
X-Gm-Gg: AZFdTZfQjbM+U7w1nxAJkE4r4bZBD2mVxnSAwltYOGpM7tgHR3+67SDm6gIbxo1rILz
 +zgUnjDoxgZpRe+Hp4pPTkBk2Rz+W1Rm7+woV6v81UEKPjkqaqDterTT/EWavrEBKzGHdbd8xkS
 HIfsM/aJUkzmuXNAn9wimN+JY2nuYFQRuysPVrSPv+n2GV3xyQtmhRtmjHXzzrQJCBkIsrnEM9Z
 PYCxdItS4JqESx5ksdUhsekVjk+1RzkK7iPRDEDbqes9U3Y9u2Zh+xjD99upkLbAQCc8BTCO+rd
 bPOYhKvewgJHgYCtNKs1XAwDDFJqMXZKt5tdTWV7pjbuldFOaqVcasBxAD3AuxGlGbvHEvuBFQ4
 u84974SE+FpUrDFQBNQNKkCOQ3MbCdojmMOV3DlY6Y0QnhMIM6a210Ym8o1t/EAv09cr3ZXp1ad
 CR/rJ7cdYz4g==
X-Received: by 2002:a05:620a:8388:b0:949:5fa1:4e5d with SMTP id
 af79cd13be357-949bab23228mr3105450785a.64.1795601858005; 
 Wed, 25 Nov 2026 02:17:38 -0800 (PST)
X-Received: by 2002:a05:620a:8388:b0:949:5fa1:4e5d with SMTP id
 af79cd13be357-949bab23228mr3105447385a.64.1795601857434; 
 Wed, 25 Nov 2026 02:17:37 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb34ad6dsm1280811085a.12.2026.11.25.02.17.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 02:17:36 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 1/1] target/riscv: avoid amocas.* x0 clobbering
Date: Wed, 25 Nov 2026 07:17:30 -0300
Message-ID: <20261125101730.228914-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125101730.228914-1-daniel.barboza@oss.qualcomm.com>
References: <20261125101730.228914-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lXt7etUyF1NoUo3g7UMeyPmKCLYjXoic
X-Authority-Analysis: v=2.4 cv=G+SJgNk5 c=1 sm=1 tr=0 ts=6b06b5c3 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=sK0Jn417EFhoLsV17G0A:9 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0MCBTYWx0ZWRfXyQo5q11YoZ0l
 GEmyceTn4M+2QFSRIrTBTqDD7e5QD1DS8v1qsfpu5xz6Lweryzx3yMp0WTgc+Y50EEv2+XoDZki
 vDkLZoLG+AWkbQIOyLy2uykz8acKJsY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0MCBTYWx0ZWRfX9oEor3b2IRk6
 PI9Nk5d3poQCzgWhebjX2mfiUdYtZ9Eq8Xyz1IDhd8EqqExzbuQjDNsUwuQI59ULYjBu8mdAVnm
 hyi54OirjNLfggKCX7YaQ4ijZhnUgXONXGzQ5XvIcvnsebp9deqKM3XC7U6+sr8tUac6qcwFmgd
 Kjbzgg9OlsTx4bxRNfA6LwGAo9ZSGZfxFCPo9rBB7456QZpmK5kiUfMhFvpsald4jtWogxbx+Np
 ntrIxUEVlxjn4p3Ql/asbPAbrnFWu2vv0Y5g3uwGCJugXqRdjjzC2rxyFO9SXaTOGmrFxURbtSD
 o+Wfl1yFuWJGT3V+S+WQavX1E5Q91YNOAS3bCLMPgtkNK2dNPrSw0jm93kSyL7vmrieA2ndJize
 1GCv+WvSbLKt4i8WInN2l+4VMsGyk0RGmJm0WWgOtjs5G6VsrbmymGcarrINoByoT+HvFV2IAEg
 cQJA37+fpItZdBMp6NA==
X-Proofpoint-ORIG-GUID: lXt7etUyF1NoUo3g7UMeyPmKCLYjXoic
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250040
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
 tests/tcg/riscv64/system/meson.build          |  7 +++
 tests/tcg/riscv64/test-amocas-x0.S            | 49 +++++++++++++++++++
 4 files changed, 69 insertions(+), 7 deletions(-)
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
index 72d36764d8..fdf9c39bef 100644
--- a/target/riscv/tcg/translate.c
+++ b/target/riscv/tcg/translate.c
@@ -1176,13 +1176,14 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
 
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
index cdd2e99d22..842712defa 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -116,6 +116,13 @@ tests += {
   }
 }
 
+tests += {
+  'test-amocas-x0.S': {
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
index 0000000000..a7bbd059f0
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
+	/* If x0 is clobbered this bnez will fail.  */
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


