Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E12B608FF04
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 19:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=anCVVrW5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOgtT-0003dK-3E; Wed, 04 Nov 2026 14:43:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgtJ-00037p-CE
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:43:25 -0500
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xOgtH-0002X5-Jg
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 14:43:25 -0500
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-3282db206d3so2090260eec.0
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 11:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793821402; x=1794426202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6v5WM6O5/YrAgj4cOjJKp58vihmtziMsdsTSNKqL97Y=;
 b=anCVVrW52aXYvG3WpK8JOLmerVaDzAPpHuEZ69tK+qgcaVIfi8qyosxdqlJRKZnHGi
 DEqdJO2hGvh+aF9532cVv/SMwN/IsfUIEdkwBXN8qsWnJVsaNOdTmYfS7GiGIS0ueBiB
 1iZIZRmIZWIdllcFi9Ht2CfwHMJmjSzbV68jzqpPyApXI8o3RkBriCV5kFyPTtwoTuxe
 GrT3kS5e7dwedq+yQ/z+T26FPPQpC71WWWdJ7zwgjKOFbbqQDHH9gf2iKuFY1uMU2H2j
 l/naSsZLwkW01D93QuwuZObjKNU4NE8U6KGqprs0G85CGDclg6pHIePetLa+aOUVBzfx
 fLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793821402; x=1794426202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6v5WM6O5/YrAgj4cOjJKp58vihmtziMsdsTSNKqL97Y=;
 b=Bhr5RIR4B4w/zNCzyFt/liV2LHPStPu0puW2gQoG2yHXlLPoHuE3XSWEOxK5hXMrAk
 2yf3pHYyp0MMaxo/9vjTEzp0cJvayREm5elvr2QNEl+iy3NXn9nM/gU2yHK7HO/gPx4X
 t/djxuWuC4uVbJ6BgCNJuw2tV0XC3FfSDHMCJO+8mp5KGjr0xqDUC7N7Ic5SxONlM0e0
 /XMLFOmd1haRbIYoAQp1zr8DjZa2tbmoZpb48jOoTxOFi8EN4bqhdb1z1IMSbtoLFcQ5
 stSifRNQ6HqVls9lvctl/AvAtG1ApaskV4c7/bYYEoVz+/o43ombfjOtJzGKfLTp8WQx
 crkg==
X-Gm-Message-State: APuU4Z//U+i0j6hg/k058F6BdLkfnu9MrCRFL4K6DBny9F0bTtiwQWB+
 GbTzaAy/w7eaFoAFIkAEYUtBboRgtKwWngDELjoKHCi+EKCYjyYHarYRDJpgyxZGzykmzUUebHx
 Y2NVrIz/SZAYU2nfqkh4Cu94pDhnSCH6O1PpPrTx3zAP/+PQ13deCy21t/6aPoig83TjoKrdnHZ
 hvgepBBWmLamxLcgldY9okOpN+Rq33+ovakb0JX2U1Ww==
X-Gm-Gg: AYBFou3zeBPKGZI0GvNouqOcLnGd2OZ3a+FMIpv0ICVsoApDU4s7FmV0Pey1NZAbD8/
 3cQM7LJGx/M0+fccCE0k0WoKRrt1jicwqAqeI77SCD5QTXUL9NrJ3Fx28Jt5gKOCJcg0cEaTkAt
 5JR/JScZ/JEw7FffoBoF7S536ppx3gVLdkl2ORAx7yijZQtAmaShoozMNM2oquwJYLTt9n/wSLt
 BxSoUjtbMvIf/zvQWRVRDfFa176EgOrnjdkZO7Kqkr2A7g8QdZcuJaL9R67YadPc8y3QKHU+p1s
 RKnnRTLK5bm2OBGovAI+8snniYIXGiE3kOXBtrNPB96KyGZ2+BnHLza9EO6/x8RKeL0Dvps1DQi
 8+QEqQYgunCuweZUfB0CfDFVErzXyKwV+ewgjtvAoI/tN6T9azCGWRTX/wJUmN7cizRZZvo80IY
 LV8VJ986elhIlkAszIXkKjZPVidRxlB0ScOjGGbl2YxEEcM8Z4E6Cy1v2PY8A/Cr4YPz8fRyV5U
 JJ0ruhxPiqh9UUkZSXfJlaEbBQqSsaxFypywsnx/TRBTlHMAMhzmW3uu0o6OqrYGvCNHO1GNQwN
 402UqeIWHyz4cgTDv71w+O1uIfJ8B9KYykaAwDK+qlXq3FiJTw1puBv7wicK/HUbDbbaOm0v4Na
 bW+yrtL+8aMNubwndEpZZixIoqJOnxxBVZAozW9hLxh5pX0567w==
X-Received: by 2002:a05:693c:8806:10b0:36c:b8b1:a44f with SMTP id
 5a478bee46e88-36cb8b1a618mr4659071eec.31.1793821401856; 
 Wed, 04 Nov 2026 11:43:21 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca38d36a1sm11299527eec.12.2026.11.04.11.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:43:21 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH 22/38] disas/riscv: Support Zvqwbdota8i extension
Date: Thu,  5 Nov 2026 03:41:37 +0800
Message-ID: <20261104194155.679241-23-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104194155.679241-1-max.chou@sifive.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1333;
 envelope-from=max.chou@sifive.com; helo=mail-dy1-x1333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adds support to disassemble Zvqwbdota8i instructions.
- vqwbdotau.vv
- vqwbdotas.vv

Zvbdota instructions encode the batch-column immediate (ci) in rs2[2:0]
and the vs2 base-register group in rs2[7:3].
Add rv_codec_v_r_ci that splits rs2 into dec->rs2 (base register) and
dec->imm (ci), and add rv_fmt_vd_vs2_vs1_ci_vm to print them separately.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 disas/riscv-op.c.inc | 2 ++
 disas/riscv.c        | 9 +++++++++
 disas/riscv.h        | 2 ++
 3 files changed, 13 insertions(+)

diff --git a/disas/riscv-op.c.inc b/disas/riscv-op.c.inc
index 5ba29f52976..bb01ebb8a6c 100644
--- a/disas/riscv-op.c.inc
+++ b/disas/riscv-op.c.inc
@@ -773,6 +773,8 @@ OP(vnsrl_wx, "vnsrl.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
 OP(vor_vi, "vor.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm)
 OP(vor_vv, "vor.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
 OP(vor_vx, "vor.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
+OP(vqwbdotas_vv, "vqwbdotas.vv", rv_codec_v_r_ci, rv_fmt_vd_vs2_vs1_ci_vm)
+OP(vqwbdotau_vv, "vqwbdotau.vv", rv_codec_v_r_ci, rv_fmt_vd_vs2_vs1_ci_vm)
 OP(vqwdotas_vv, "vqwdotas.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
 OP(vqwdotau_vv, "vqwdotau.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
 OP(vredand_vs, "vredand.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
diff --git a/disas/riscv.c b/disas/riscv.c
index 0f609cc06b4..0534b8f4d64 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -2638,6 +2638,8 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 switch ((inst >> 26) & 0b111111) {
                 case 38: return &op_vqwdotau_vv;
                 case 39: return &op_vqwdotas_vv;
+                case 46: return &op_vqwbdotau_vv;
+                case 47: return &op_vqwbdotas_vv;
                 }
             }
             if (((inst >> 12) & 0b111) == 1) {
@@ -2999,6 +3001,13 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa,
         dec->rs2 = operand_rs2(inst);
         dec->vm = operand_vm(inst);
         break;
+    case rv_codec_v_r_ci:
+        dec->rd = operand_rd(inst);
+        dec->rs1 = operand_rs1(inst);
+        dec->rs2 = operand_rs2(inst) & ~0x7;
+        dec->imm = (operand_rs2(inst) & 0x7) << 3;
+        dec->vm = operand_vm(inst);
+        break;
     case rv_codec_v_ldst:
         dec->rd = operand_rd(inst);
         dec->rs1 = operand_rs1(inst);
diff --git a/disas/riscv.h b/disas/riscv.h
index 4f1ffc4ae02..34050583c96 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -138,6 +138,7 @@ typedef enum {
     rv_codec_k_bs,
     rv_codec_k_rnum,
     rv_codec_v_r,
+    rv_codec_v_r_ci,
     rv_codec_v_ldst,
     rv_codec_v_i,
     rv_codec_v_i_u,
@@ -254,6 +255,7 @@ typedef struct {
 #define rv_fmt_vd_vs2_vs1             "O\tD,F,E"
 #define rv_fmt_vd_vs2_vs1_vl          "O\tD,F,El"
 #define rv_fmt_vd_vs2_vs1_vm          "O\tD,F,Em"
+#define rv_fmt_vd_vs2_vs1_ci_vm       "O\tD,F,E,im"
 #define rv_fmt_vd_vs2_rs1_vl          "O\tD,F,1l"
 #define rv_fmt_vd_vs2_fs1_vl          "O\tD,F,4l"
 #define rv_fmt_vd_vs2_rs1_vm          "O\tD,F,1m"
-- 
2.56.0


