Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F597C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtk2-0002U5-Nc; Wed, 19 Aug 2026 23:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtk1-0002Tc-AH
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:57 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtjz-00047W-N3
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:57 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-38e347638adso1950631a91.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197614; x=1787802414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HiY1OdOtBijExrR7AqCE72zrQVCis7QsYpBlu+X6Ymk=;
 b=r7isK4UPDK41afbycR1msFqx7eYebniaA6Ah9OyuI2g3JKYahzcRq4db2ZePMJ2N7i
 zCa71fT/tdhnrraz5KFtKyMAZC5aDgeWLC/CMu3duwmRJv3vMY9z3ytYbXuE1Xi2POtv
 o59wC1NfdH29aa+Qglxv+t1eUARVKqHdWTl31Kr28stdVE65vNZBr3OMzGlkz1XvZXVb
 xO7yE4/IJEKPFK4gIN8wxlMTAIQE+fynTH/qfGCVmvB8tB1KlXFAtFmviqSg/HQJjbel
 aZp2UsFik0ZgD6JjoNdrkPtjc9gtrjPyW57KaI5rqR2LphxNBiMmPh4ru5eLD96iTiHC
 BfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197614; x=1787802414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HiY1OdOtBijExrR7AqCE72zrQVCis7QsYpBlu+X6Ymk=;
 b=lojjCJZXLIwStoZeV6ET4Zxs2Cwd5dilNSlHSleMu9a2Guil5LmdSbmKLfLJg4s4jw
 frMh6UBSzfLLqqUfgWZVUOJxku8oH4dOpQ6Umupbg8ENhyVDOMsJsdM6IPbd0fXeYEHb
 bJsbfsDIn+5NkgqdRJLcf7FptsKDjH5IW5guog0uV3jJllU9wvNgHwZSgw0tLdzgD9c6
 82/RKCGrJcfz4eWIsRiBwq8jvLSmqGbsp8VA3SWB5aJ3cGeB1DiQ8XpH50VTPNTAAgwb
 UQ7r4aIpf98QjMWAHokdDE1hmSd2WrBGVLgHCrOzlNoB/yuCSqswX6oMZ/9pr/xBeXbh
 Iv4w==
X-Gm-Message-State: AFuF++kUKwz+Ze4PvdILh8fVwV0vUxNKCz5iRuW95nSfyWeo0bFt132w
 aD1fIgFx188xDRLg0yAdxDLCvb0l2fucO6hqGGqE/J/yPVi1y/6+zZxAvN6PWA==
X-Gm-Gg: AR+sD13ogVI5IssCZlDCSvjKIX3IqdQ7N11+FbZGXiJc+Vm0x+ngkGfRx9AJmVPY+5H
 wSQazAbF1KJSwdxvfRQRqh8DLmTfHXW/PCwnHITCKW1mUQ2KwB3qu7Jykf1i+sefyzbU8rRvuNa
 DUxIVh2XZ2A7iiqrv+b/OuqvJo9PbzND0kGeu2Ic08Gbl1QKn4t6oK31FbMhP47/iUKCRng5YNU
 WTPN+cc8p155Sa9hj9ObDgeX6nUoa3mo56QZde3FCuLo4h7UYLpjPwotVKmck0HYgpQUGJvkgRf
 bFPRQ+hAEpAkGSYB+9MUsw3+oFzj0HZ7CJCaFLdirkf0V+qeQVLFufRGMuqFeBHsAaQbKmE39CF
 JpfaEeZrPkIEj5JylmBmo5FaTbNtohF+xCELFVvOi847U80g3DxDplJqyO7n8/etGMrXD1m6H0P
 S2kWHve9YWGh83hGCo5oRlhfoS7BZbt7wOJYiCkUXRi9ZV8J5gAy3X8T4ZC8HZGPeyDYM/XtPVg
 2Xukw==
X-Received: by 2002:a17:90b:5250:b0:38d:b36e:9813 with SMTP id
 98e67ed59e1d1-395810b57d1mr17850979a91.11.1787197614195; 
 Wed, 19 Aug 2026 20:46:54 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:46:53 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 44/93] disas/riscv: Tidy disasm_inst main loop
Date: Thu, 20 Aug 2026 13:43:41 +1000
Message-ID: <20260820034430.1186695-45-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Unroll first iteration, so that always_true_p is not used,
Drop some local variables and use 'decoders' directly.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-9-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 65 +++++++++++++++++++++++++--------------------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 70ea41f125..9880b8de20 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -5419,41 +5419,40 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
         .inst = inst,
         .cfg = cfg,
     };
-
-    static const struct {
-        bool (*guard_func)(const RISCVCPUConfig *);
-        const rv_opcode_data *opcode_data;
-        void (*decode_func)(rv_decode *, rv_isa);
-    } decoders[] = {
-        { always_true_p, rvi_opcode_data, decode_inst_opcode },
-        { has_xtheadba_p, xthead_opcode_data, decode_xtheadba },
-        { has_xtheadbb_p, xthead_opcode_data, decode_xtheadbb },
-        { has_xtheadbs_p, xthead_opcode_data, decode_xtheadbs },
-        { has_xtheadcmo_p, xthead_opcode_data, decode_xtheadcmo },
-        { has_xtheadcondmov_p, xthead_opcode_data, decode_xtheadcondmov },
-        { has_xtheadfmemidx_p, xthead_opcode_data, decode_xtheadfmemidx },
-        { has_xtheadfmv_p, xthead_opcode_data, decode_xtheadfmv },
-        { has_xtheadmac_p, xthead_opcode_data, decode_xtheadmac },
-        { has_xtheadmemidx_p, xthead_opcode_data, decode_xtheadmemidx },
-        { has_xtheadmempair_p, xthead_opcode_data, decode_xtheadmempair },
-        { has_xtheadsync_p, xthead_opcode_data, decode_xtheadsync },
-        { has_XVentanaCondOps_p, ventana_opcode_data, decode_xventanacondops },
-        { has_xlrbr_p, rv_xlrbr_opcode_data, decode_xlrbr },
-    };
-
     const rv_opcode_data *op;
 
-    for (size_t i = 0; i < ARRAY_SIZE(decoders); i++) {
-        bool (*guard_func)(const RISCVCPUConfig *) = decoders[i].guard_func;
-        const rv_opcode_data *opcode_data = decoders[i].opcode_data;
-        void (*decode_func)(rv_decode *, rv_isa) = decoders[i].decode_func;
-
-        /* always_true_p don't dereference cfg */
-        if (((i == 0) || cfg) && guard_func(cfg)) {
-            dec.opcode_data = opcode_data;
-            decode_func(&dec, isa);
-            if (dec.op != rv_op_illegal)
-                break;
+    dec.opcode_data = rvi_opcode_data;
+    decode_inst_opcode(&dec, isa);
+
+    if (dec.op == rv_op_illegal && cfg) {
+        static const struct {
+            bool (*guard_func)(const RISCVCPUConfig *);
+            const rv_opcode_data *opcode_data;
+            void (*decode_func)(rv_decode *, rv_isa);
+        } decoders[] = {
+            { has_xtheadba_p, xthead_opcode_data, decode_xtheadba },
+            { has_xtheadbb_p, xthead_opcode_data, decode_xtheadbb },
+            { has_xtheadbs_p, xthead_opcode_data, decode_xtheadbs },
+            { has_xtheadcmo_p, xthead_opcode_data, decode_xtheadcmo },
+            { has_xtheadcondmov_p, xthead_opcode_data, decode_xtheadcondmov },
+            { has_xtheadfmemidx_p, xthead_opcode_data, decode_xtheadfmemidx },
+            { has_xtheadfmv_p, xthead_opcode_data, decode_xtheadfmv },
+            { has_xtheadmac_p, xthead_opcode_data, decode_xtheadmac },
+            { has_xtheadmemidx_p, xthead_opcode_data, decode_xtheadmemidx },
+            { has_xtheadmempair_p, xthead_opcode_data, decode_xtheadmempair },
+            { has_xtheadsync_p, xthead_opcode_data, decode_xtheadsync },
+            { has_XVentanaCondOps_p, ventana_opcode_data, decode_xventanacondops },
+            { has_xlrbr_p, rv_xlrbr_opcode_data, decode_xlrbr },
+        };
+
+        for (size_t i = 0; i < ARRAY_SIZE(decoders); i++) {
+            if (decoders[i].guard_func(cfg)) {
+                dec.opcode_data = decoders[i].opcode_data;
+                decoders[i].decode_func(&dec, isa);
+                if (dec.op != rv_op_illegal) {
+                    break;
+                }
+            }
         }
     }
 
-- 
2.54.0


