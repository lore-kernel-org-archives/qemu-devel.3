Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5979CD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 03:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQGge-0007bk-Q2; Thu, 21 May 2026 23:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wQGgd-0007b7-45
 for qemu-devel@nongnu.org; Thu, 21 May 2026 23:36:35 -0400
Received: from mail-dy1-x1341.google.com ([2607:f8b0:4864:20::1341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wQGga-00022n-Lw
 for qemu-devel@nongnu.org; Thu, 21 May 2026 23:36:34 -0400
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-2f7020a928eso9994229eec.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 20:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779420991; x=1780025791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/23ZpZzeuaYh+511klXxvATruIMQgl4rkcmNDX6c8ns=;
 b=ViCYxsgfMNtvaW6zG2NNsUDDmH7vqBUx3MyHf62+MFjcSQFiqfarusXHx+FGqYQlPO
 EGo2oxZ6eSZeLs/eEJV3NceSVGM1zGYzCKuQkqkPhtgkgVPBkVyRZNRXKwRvn+P4d0l3
 g8SVZ1SyS48rVHImi8ghF8qBrZhIpyXFucj9aKeXzchcZ/laBC3+cQY5I0Y6ar/x1+DY
 vqttUWtjIztnjFjs397frLocD/Hk0wqId5YhYP+KSwJ494AhWniZJixARUXf5eVSOcUf
 3mWQdxNBl+eXVG1csXD3e5gm4Z2PdUwpVfrEv8tS52tXarbzPoUllWxbVa3z6GnE/tbD
 Yd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779420991; x=1780025791;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/23ZpZzeuaYh+511klXxvATruIMQgl4rkcmNDX6c8ns=;
 b=P+9vD2KhMQ6f0aO6ujCNjEZt2I75XLfP6n4DyV2GkS+0digDWutyCR+JWrpKq+zEu7
 ztscPz88D7GxnTUw9F7HEYsGKQeMVS6M3WNgpLXAmdq4Iua0yOde+KbdyLWUWEr9EfoK
 XlbHk58Vziv6dA8sgJHcKgJUgaxl+vsNnGRWrjMu3T/IkZvOPxhi6Wy7e3+0qbBBH4Yk
 ZLtF0ILPW9bmjomeFF/kIUBmRUxaer9bmOlAGeKfch6zz/oLFgWEDjz06/ihXUbAGfZi
 GYIlUauD1L+yzlF7RCU/sjn02khG1yM0NwPRG4eGpPj+UvX7spZCrllQYUnGtxXBMuJI
 CDNQ==
X-Gm-Message-State: AOJu0YxBUEe9FuXySOW95GTwq+gBg2jKEI95q7TLSfC6GqVtJ+SolTBB
 QTcBEk5yRbPR3I3+NCQL6zwB10MLCa0KG1kL8dS4JIGaSDyAkjOCl6g5a4X8tDdYDwdWxzzzRZY
 =
X-Gm-Gg: Acq92OH6OJEGafIDTQnbyZWvwuBMgrkjK+V+SKNR2gzlUhmJDXv1F2FsbI40PzW6p7f
 hMrlj8iVgAdzgcRcmbkU3EEI8tr49v/Y5AWwDYkx7qDOog06EymsQ2JQmp75KKRMqSltXe94ARj
 gDXQlxGnEMHTEtd0MgPVPNbImMmRmbUIBxLNS75TBgeXphzxOyZs2qrsgQBfkogwcpaBEL3ZeEa
 YZ5ODRq806IgTJ+3CvZPL1ncD036G7Llyfs7yBHlwBFxS9/n1L9OriK9EAWKSMKTwx1H2JnXP82
 uRd35fmXe5VjbFlnbJYIShr3cD7b0yORYfFp1K5IpnHgOQpp9vwp0uuBMeHnJOtBvttR5begeK4
 fi2RzO9SvK32O5L/g6a96ylA/lCfxXhg2ztGvw3B0UzYUVuBUCPSdfsGeplkPWDvVrmX59qLUTV
 njXDbpD4T8PIqm3Dggfbxp+i4nwxV3cx9lPqL2IvqaVPD2kiA5BkR+VDFbqRsmtpcP5FNO54Pcd
 KIikYFyjUHXQ9hVxKoFRNSgG4qQpi/VGg==
X-Received: by 2002:a05:7301:1017:b0:2f0:4268:bc42 with SMTP id
 5a478bee46e88-304491cef8cmr984585eec.25.1779420990803; 
 Thu, 21 May 2026 20:36:30 -0700 (PDT)
Received: from openkylin-pc.lan
 (ec2-18-145-111-125.us-west-1.compute.amazonaws.com. [18.145.111.125])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451ef4afdsm30548eec.5.2026.05.21.20.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 20:36:30 -0700 (PDT)
From: Zephyr Li <fritchleybohrer@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, daniel.barboza@oss.qualcomm.com
Subject: [PATCH v2] target/riscv: Reject Svinval instructions in U-mode
Date: Fri, 22 May 2026 11:31:44 +0800
Message-ID: <20260522033145.17850-1-fritchleybohrer@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1341;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-dy1-x1341.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The RISC-V privileged specification requires SFENCE.W.INVAL and
SFENCE.INVAL.IR to raise an illegal instruction exception when executed
in U-mode. Check the current privilege mode during translation and reject these
instructions in U-mode, so they are reported as illegal instructions.

Add a helper to reject these instructions in U-mode during translation.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3493

Suggested-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
---
 target/riscv/insn_trans/trans_svinval.c.inc | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/riscv/insn_trans/trans_svinval.c.inc b/target/riscv/insn_trans/trans_svinval.c.inc
index a06c3b214f..4614c1489c 100644
--- a/target/riscv/insn_trans/trans_svinval.c.inc
+++ b/target/riscv/insn_trans/trans_svinval.c.inc
@@ -22,11 +22,19 @@
     }                                      \
 } while (0)
 
+/* Test if priv level is M or S. */
+#define REQUIRE_PRIV_MS(ctx) do {          \
+    if (ctx->priv == PRV_U) {              \
+        return false;                      \
+    }                                      \
+} while (0)
+
 static bool trans_sinval_vma(DisasContext *ctx, arg_sinval_vma *a)
 {
     REQUIRE_SVINVAL(ctx);
     /* Do the same as sfence.vma currently */
     REQUIRE_EXT(ctx, RVS);
+    REQUIRE_PRIV_MS(ctx);
 #ifndef CONFIG_USER_ONLY
     decode_save_opc(ctx, 0);
     gen_helper_tlb_flush(tcg_env);
@@ -39,6 +47,7 @@ static bool trans_sfence_w_inval(DisasContext *ctx, arg_sfence_w_inval *a)
 {
     REQUIRE_SVINVAL(ctx);
     REQUIRE_EXT(ctx, RVS);
+    REQUIRE_PRIV_MS(ctx);
     /* Do nothing currently */
     return true;
 }
@@ -47,6 +56,7 @@ static bool trans_sfence_inval_ir(DisasContext *ctx, arg_sfence_inval_ir *a)
 {
     REQUIRE_SVINVAL(ctx);
     REQUIRE_EXT(ctx, RVS);
+    REQUIRE_PRIV_MS(ctx);
     /* Do nothing currently */
     return true;
 }
@@ -56,6 +66,7 @@ static bool trans_hinval_vvma(DisasContext *ctx, arg_hinval_vvma *a)
     REQUIRE_SVINVAL(ctx);
     /* Do the same as hfence.vvma currently */
     REQUIRE_EXT(ctx, RVH);
+    REQUIRE_PRIV_MS(ctx);
 #ifndef CONFIG_USER_ONLY
     decode_save_opc(ctx, 0);
     gen_helper_hyp_tlb_flush(tcg_env);
@@ -69,6 +80,7 @@ static bool trans_hinval_gvma(DisasContext *ctx, arg_hinval_gvma *a)
     REQUIRE_SVINVAL(ctx);
     /* Do the same as hfence.gvma currently */
     REQUIRE_EXT(ctx, RVH);
+    REQUIRE_PRIV_MS(ctx);
 #ifndef CONFIG_USER_ONLY
     decode_save_opc(ctx, 0);
     gen_helper_hyp_gvma_tlb_flush(tcg_env);
-- 
2.43.0


