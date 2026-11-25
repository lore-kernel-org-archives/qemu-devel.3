Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282BF606A334
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=H0KTve63;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X3SWfejr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWCvi-0002So-LA; Wed, 25 Nov 2026 08:20:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xWCvd-0002ST-4e
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 08:20:53 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xWCvb-0000dk-1N
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 08:20:52 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AP9nkKE1505215
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 13:20:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=McJ+RwP+YXr
 Jy/o0po6/9rYhcpWJnTJa3d/NTCdoacE=; b=H0KTve63yluRlQNtFh3olvRmIin
 IC1+EKmQhLoRdh0HjArbk3MrY61dQXj1umocrWraMUt19DJ/sG5qjJnpcUjRR1J6
 JfPFxn5eqCkt+NNUjPhz1uGUe8S0nLglED6Cv10diBdvSpqrSrbTmo9HiD92m3Ni
 uzMqia56qqTh7q8HnDEt3FRRBL5/yPjd0GYQv5+aX5AJ4PuBm5pohlQUyhJfHxC8
 ZhEO8xmV8ivrZLQfQtIkZsihipGWC+STvgQWXg9g+Lc3bauq89geLK9bqYGmJwZ9
 eF889b996/YPiJcIPUeyHFUZne8L/NPaqA+whMaFE87UCJPH0he0L+ckDew==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5qa2ac7u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 13:20:49 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9210a12765eso68206976d6.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 05:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795612849; x=1796217649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=McJ+RwP+YXrJy/o0po6/9rYhcpWJnTJa3d/NTCdoacE=;
 b=X3SWfejrPUiuIYOxQo+FO4Am0FiZZXAOFHBtpFyqQQyuG2FsCi19i16jO8vzuSvLxW
 hAGb+pcryDX20uNqsNeU2lv8kPx28IU6RQN2kxXp2eC8z0zbkavgVx7B9APhFjDTwykv
 PXvV6cuojjSwSa6bo7ZHcjQ1Px/WMk9rnF3KJbQ3K/ogWoVZe68fPCLq0RaIsNA+fHAq
 daNXUrpm6Ixt+qZU4AbHQuSdWYRQhLN97TpGPC6AqCz8DYrSZEn4hOQuMlhnSh1w9i8F
 ODJ85Hk5nzDOM/iC92rWdIoMrF2H+2ZrUVSLooupqBMEoxZKD/3IpNkylK2mxVk60ZaV
 XJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795612849; x=1796217649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=McJ+RwP+YXrJy/o0po6/9rYhcpWJnTJa3d/NTCdoacE=;
 b=NXwFBytYHdIKiN4Pbp+xomn1TYbRCnNeBddctLGsMybq41XVtrXIo7xw+PcW4m1F2u
 d6A8tb1/Hl2digSgy6Rer32FeBt0GHvsh31mo9Guk+xu7+1PMl2xWUuq5a+OWgFuOP6F
 0G3EstqVPLoT/lYXpDr/vyyo/fNCY77EWyZjy1dU/zIF+A6LfjME8CiIrLWFE8ZIWtOe
 1iZ8vO6VGVsj45Pm51Ec80QMTv74XE76ZCf7KOJIevHuAcXOZKHlrNEoQDIOgNZHFQoJ
 JiTR0tgDUjA2Nr0kgiriBzflw2lUqjxM9+GwXt/NlVBz2TudQPXhfGX/ZQ1XUXtSpy3c
 YdZQ==
X-Gm-Message-State: APuU4Z/x++ug9c07LxKTBgZ7mHXG52AxuT6OCNPpi8U9vNGq5L3j5CKn
 7hBjtlBXHvxhlfeJEuorobVEnh25CXyUsrbSNwjCbXCak5hpUVqe3IohjDyuEI8ldCqFsV1Q2oe
 R599TSAPzL7borppBbGfY/kZLBMWae+VOCGX18SDyotYSDEKqRhVfdTiXdeQPACuTIQ==
X-Gm-Gg: AZFdTZcEoCD3euONhaR04GUuwmc2K+Lq9gBmK+aLRZ6lEZjEix8YZF0OP5L7ZmqMv+h
 qOaGza372yqmb59JFOhB6AdkrYSzouPCucFZaYRZS+6D1cZ+601IFJqsIwkGGmVDC+w8rLtP5y9
 J4Sk0BcctlLF8LkilWrVJziIy410l6i4hRqyNw+VS6av1ebDy3U7ZzFxRoi+J+VQISB4WwLsQxK
 uNcTMItSw2n/czBzZvBBzPDpSsGtrSD28TSet4zRd8dPirsMk6lnEt3OSmDZZoDOO3Xc6eRJIKo
 UvZYbRsLV9Fvzbb+kgC1QNc2ihZJidrQ6IqTj5QpWyZ+gQLjeycWq62f9TktHheptA4ojMc11ez
 A25FAw30y3c35f2EYHkRLdb0F123HmZVTDBKTLXG+Ih8UdUmNQfDcSUwyNr8Aj55MyUWXw3wPpK
 vR80nfITwubg==
X-Received: by 2002:a05:6214:29cc:b0:921:3de2:4f7d with SMTP id
 6a1803df08f44-9213de25197mr298134206d6.51.1795612848545; 
 Wed, 25 Nov 2026 05:20:48 -0800 (PST)
X-Received: by 2002:a05:6214:29cc:b0:921:3de2:4f7d with SMTP id
 6a1803df08f44-9213de25197mr298133626d6.51.1795612847918; 
 Wed, 25 Nov 2026 05:20:47 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm160836946d6.34.2026.11.25.05.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 05:20:47 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 02/15] target/riscv: avoid amocas.* x0 clobbering
Date: Wed, 25 Nov 2026 10:20:01 -0300
Message-ID: <20261125132015.229955-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125132015.229955-1-daniel.barboza@oss.qualcomm.com>
References: <20261125132015.229955-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9H0HlcSaU3ts8DN5BbJOOp7Ng8Js_xO6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA1MiBTYWx0ZWRfX6vw4kgq3WbDr
 T45GunDp0Ti7VPaszh/v/vWDexmT43aHxna16GNuKx6TMt7dNJ0ybyuwhTHMcoeT3M3KuVn8YDn
 6njRm0YKzhdTIDLsF7EMrImDlODoYW8=
X-Proofpoint-GUID: 9H0HlcSaU3ts8DN5BbJOOp7Ng8Js_xO6
X-Authority-Analysis: v=2.4 cv=CKu/zhrD c=1 sm=1 tr=0 ts=6b06e0b1 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=sK0Jn417EFhoLsV17G0A:9 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA1MiBTYWx0ZWRfX+W4h+3LWJi0P
 qsUyoTztNU/Zp1sktJGS/zGGSXg9SDf2gkaQUxIwsBgWB3ZbcJ4RyhS5UYCuZx74WjdziWuyeff
 kAzzD9GSusbFQyyu4qa2V9LRDIVMIWmH37Y4JG8dNR/FCgA7sMfUZ6sja+PkSPGVK9j2EvFFqoe
 JVoJXaefRIwLo++GZVh5q3pwrpgx8qeAYDVs7n0gxyIA1tc4zjzckciU8RlGNRtq3E+xeTj/2XO
 ckU6Ru9E9f5svs/bBlvbOxSaCVQyA/ULQkNjmTV9t9rq1qCkEmbh3Lc6lu2A1MC3G9KLAJjn28A
 DfV+6IlRe+J2xa77RlTD6n3i0D/MiD/MxQWTZhCeqWB5Mk6SigWCzPvk+iSnLYUg67pJVkGDP5t
 4ahZa6gu4d0IlE97VjqmR6M5XgvH/cnMYCiWilwKeE5Eh3wAErsRK/NG1oV5ib24/VJfXIBZem9
 kNPjeAeNeK3Bx6CDecw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250052
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
	autolearn=ham autolearn_force=no version=4.0.1
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
 tests/tcg/riscv64/system/meson.build          |  5 ++
 tests/tcg/riscv64/test-amocas-x0.S            | 49 +++++++++++++++++++
 4 files changed, 67 insertions(+), 7 deletions(-)
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
index c9435bf2b3..6c3de32965 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -121,6 +121,11 @@ tests += {
     'cflags': cflags,
     'qemu_args': ['-cpu', 'max', qemu_args],
   },
+
+  'test-amocas-x0.S': {
+    'cflags': cflags + ['-march=rv64gc'],
+    'qemu_args': ['-cpu', 'max', qemu_args],
+  },
 }
 
 if 'qemu-system-riscv64' in emulators
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


