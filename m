Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D855606A32A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XPi0+8TW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C3VtwvoN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUIx-0004b6-Gp; Thu, 12 Nov 2026 07:53:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRUIv-0004Wy-BA
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 07:53:25 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xRUIt-0000y8-3W
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 07:53:25 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACCgHM93670877
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 12:53:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=CAi6j/hpVYY
 XVTTCgc9B29TxG3NjCW0S1PHwMqiE7nc=; b=XPi0+8TWbGbmuqoQjBoiaLazmzn
 CyzDcaqku8Ugr0oe/UHzk4Ii3/Uj7lj1fKdg6s2ryPFo6D+yA9xwQ+h+w/lkZtDs
 No4tW3PVgCZeS5fT12KBawSxUBC8qxuDQ9mrgSbVFvpe1b8SUsNumRdvpuGWTnZu
 EM8r+e5taS/J9gu27bSmNOOhkuZLzvW256vvKkaXzmh63I7RqMViL4BeFiZkqe6a
 78u9hFTV8Agwf+kPsoqqYxBX2PwCPJwaiBlzJJLRI3PHgD4w0YmmHDwIRXy+zaLy
 X6UspuzCv1DLQFsUI0Ohm1EMLC2EsklqGPoT5jy9UwGmoNponekQlFSSHuA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw6yuhkg5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 12:53:20 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7d2d60a8bf5so889787137.1
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 04:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794488000; x=1795092800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CAi6j/hpVYYXVTTCgc9B29TxG3NjCW0S1PHwMqiE7nc=;
 b=C3VtwvoNvwVJS9DDaPK0xkgTxt8kdarmljN5V6ppPkCqIE6XFlCnMw6z8dJt+reFnO
 gYykLjnsEp1qodkwAWKGxBirNdirPeXrBXl1u0/uoQYHmhB8r5qRIoKHDxgGY63O9nbg
 a9bvAwGmMYcAajK2AVtN1RetFOpmCNCXomZcyQn663x3o7KyRJQNg+M9z5MSSDfq/bFl
 VKpRFmY5l6fnVRt9zKrh6GltOvbk03IUmbnSNRiOLhKD1UoF8d6BSJdvhUskgtCnHV3E
 lJK2tw37Cv4CRRgJ9jqFUwaTEVodkxOsu2OFlUl0jFiMzGWuI9jR/IF1X5umbuGFIzlt
 6jug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794488000; x=1795092800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CAi6j/hpVYYXVTTCgc9B29TxG3NjCW0S1PHwMqiE7nc=;
 b=NdsUsVteAuDmPfDxjZ264XHfIANp98fDbxNlbA+eLadlTRjB8yLee1hh3O8MbUU61I
 vMS26GHwxWGAeS1MxHM5SeVMg+mtkDcg2BkoXW3vY143wPRvGjpslKMT0b+YWa90B3uK
 kHn6qanJ8if5r9gnTGVBcvykmwbQP475VVIR+8H9lY59aGTR7f05DUvD7CscwFLoUgXy
 sCmuLTM0NpklzbG1qior3AdGLOLQgGx2FGq/aGErH6V/aju6/csGigrzGceoe4JeVJMR
 bvQzaUND9sPg1mFQ378flXYR8Ff8kfyoGxSqWjKw5UuUiXlgKfgxRxDIthFFiitMGntl
 ZMww==
X-Gm-Message-State: APuU4Z846xSC6VWMDXbRGN9p+c0d2pVbExgL4IJMC5OkDj8aX7ofzMXa
 I3lortN87PS3NtxPjj8qRsUuX2wBfW1Thm33GIrMZAo5XHaduPJYpuFHY5/BMelG03rdeON6eQm
 sjZk4Yew8UDUxwWhCFtSmuzyDMAyml7yB1z9pRK6VZLbVGF9+BELrmW5i+C3WIJ+wCQ==
X-Gm-Gg: AYBFou2k2OvccRZKy94nlTrWj7MVMrEf51/0UC9SyAJ8EkH9+7hsNRGo68kxuBvLUrM
 OsdldFyYOSOLyxfG0UIyanBPnCG0xi2tc7yFcC+lvGV9B3CS4u0kqZcttoGpxBHS8eetDhYZ8z+
 XWTAM0OYKj3mxZ6wabwhqiIA+RZZgD/yQBdU6WcT/IJLyWRsdhNt7pK7kJn0RMf4casqhU9IP5W
 k0hafWz/AJ47i8ic5k2jYyX03s5IxXzhH4NPSzbNGuz1dYYG9p8kJbu0B+wy+pv8sZn9L9ysNJU
 T5Y2ybDT4GMtgufWLvFflxtHYZTQaz3pfZhpsZSUfHyw4GjRdaxFpGlROVG4vIaUGPZs4Z9bLnp
 9SHKIflseKupz91IYzXIGA/bddR0sksuaOuJLI0GDXD4d4GxNC/KbIwKWGJLWBYZNVBaI+PLRQA
 5vZ7BHwTX+RuoKuq7SaeWxwIlqodt8gk+Uc+qfSkU1V4JB
X-Received: by 2002:a05:6102:5086:b0:7cc:2946:7f69 with SMTP id
 ada2fe7eead31-7d4fb2577dfmr1735292137.8.1794487999748; 
 Thu, 12 Nov 2026 04:53:19 -0800 (PST)
X-Received: by 2002:a05:6102:5086:b0:7cc:2946:7f69 with SMTP id
 ada2fe7eead31-7d4fb2577dfmr1735283137.8.1794487999182; 
 Thu, 12 Nov 2026 04:53:19 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com (189-68-253-226.dsl.telesp.net.br.
 [189.68.253.226]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba08de826asm92994755e9.0.2026.11.12.04.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 04:53:18 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 1/1] target/riscv: avoid amocas.* x0 clobbering [GL3526]
Date: Thu, 12 Nov 2026 09:53:07 -0300
Message-ID: <20261112125307.485690-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112125307.485690-1-daniel.barboza@oss.qualcomm.com>
References: <20261112125307.485690-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xcG_TIBkSY_69sHW-yMeJPfYmY9WTSJD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1MSBTYWx0ZWRfX2W3vtKAGGeCi
 VRDV7tTE4KiZswKv0zRpF/tYLf2Vt4jxVnSLKIycUvyq4e5g6L/Yxl5p1BQINYbYJDL78+s/97X
 0EZvOOTzN1a6lQJQxxfbrAySo0HSTkI=
X-Proofpoint-ORIG-GUID: xcG_TIBkSY_69sHW-yMeJPfYmY9WTSJD
X-Authority-Analysis: v=2.4 cv=d49gWhjE c=1 sm=1 tr=0 ts=6af5b6c1 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xcxBfRYLw5hNHjR815/AfA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=sK0Jn417EFhoLsV17G0A:9 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1MSBTYWx0ZWRfX3+OGcqGVe5YI
 3wLFTRqxNseaxopWlLjx8N9MCgNAdrDRanaoC8VcysBnhUVJX7svqVKy0gBHGtOxMcLGEs8tumg
 Fq5+KtZFQo6WRM//Adk4kWTr8A5+lYKbOTrGMbdew2MQYDVHY8+ogrP/xtFZlNDcGSj8EwQ69dk
 sb5E4aibaMGJVY7i66yyR1p5rn57pd0u5D5IuCTMvUMzTz5vgAKGSxRfD63Xo+8BxI0JPKw+ajN
 q1zv9dmk+Qij0Qw2XoINBHGSi0OIpj/bac+jqi90NzFvnRLsmKteFvIkVy+SV6Qg9uCRD4G5hUV
 LW9LuB6YJXCG07Lp6P/aQHRB0HKLnXen9x66QZvuf8E2iqk3GwoEqOo2rVP1lMWtlNwxaMP+nqM
 uvZ5TO/TAwPyHOBkiDZ5c8w9wtPjIcCj7I8a8RsIUJ5ADq6kFhVbNJCBCn5Y6Jusr4Ixo1IrQct
 92TQtQGoR4zl9t6ILsw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120051
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
index 3c8b018d9e..882f268a71 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -89,6 +89,13 @@ tests += {
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


