Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF0DC5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHUL-0007CE-Sd; Wed, 12 Aug 2026 18:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUK-0007BI-RP
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:31:56 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUJ-0000wl-2j
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:31:56 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2caea3f742bso21658965ad.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786573914; x=1787178714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3PV8Wn7z7mUJ54Ax/xp0gpg9WRpfYZRwPm1ejIDJl5Y=;
 b=eKIaBQqF751x6Ev1ZIfEb75/oB4e19GX+vKuGmz24+wA5/62Ru9w5KwiN6qfIGllEz
 0huEf9AORr0lX3K87HMOwq9Bx/e3qn2wamXkUm10xd+oRlOkvjfCszfZRs6yUZqNwE5T
 EU3bnl1ztQFYW/3aHQas3cSPi0EyT8weKRPuvIoiarePqlrJb1iZ1h32++35rQuFbht9
 aglN9QXWRB5FIWVGn5oqglhYpr9pBYAy/vTZoQTwvEabShIROTZxetp3EsoadhZIey1Z
 B9lCMYhUT899VRIxTdn2J3tV6T1xGTht0coD0NYnPMsKFeAO6ir1oH2bvl8v6+TVU77k
 PaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786573914; x=1787178714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3PV8Wn7z7mUJ54Ax/xp0gpg9WRpfYZRwPm1ejIDJl5Y=;
 b=DRUO7Bqk2PgugKtQ7aGhYnNhJTgtfxyYsL8XtIbMULKE55GXzH4rc8v7o4UfNXB8gz
 ZB/dmk8XOzxQTqMB/B90pSTCBn1mFqOa/FWfNzVfOp9OqOmSJCqbzedbNN4/BC31Dn5f
 0eDI5BXkELBWi6uWbnBT9ZLHAbmHYxiOHyxEuqu9Gt44tikiK1ZuB7hDSSRVTmR/aR0S
 VHy0XPE7jrebaMWDxCaMUQ2XqrNrUWg3dLJdwUTTvkwHm5JCdiQqbiybUIR8HTr9ljcx
 5pwnr8wVL/KufHTBO237BXw3RIiemWOV0VtqWYuO9Q72ccujvCMIqVg3WTmKGCuW5N3P
 CtxA==
X-Gm-Message-State: AOJu0Yz3Ja/gW7DVPpppM8okMEh1/0YURAKRdd/g8RHq5adTXGS0Wns3
 k3INA1+6YtzA6+MkCcD4LmelQMsPPakvVpZKtb+D6TbB4YwMnnHa0cRTtrMknFVyXr5VG7TXFq0
 y3YuX
X-Gm-Gg: AR+sD12bvVdkHbne8KrXL333FLm+FF1hUiclmjysgxAoQLoVN1sE5OpAfX8aqGJOG2w
 DElR6+UD0Jtx7be4/L4+xwLp8j6qERCuQpITjy6TNHo7ymGrOFU95b40Xwa/nBXAnG7UpCzvvDX
 dNm/crhpn+4sYrTzcpasBVRCenPTe+vxi1yyxesqkhN80NvIwtbcbi6z45tmT3Lrc+WYeJgNdKS
 HqZ54KEnZxaNnnUdGrW4bf4akdqEyLdjcQ1kXEOnOdVK+Z14NTJA/zSX54+6X+etuVTLLJ69AyY
 ZoEAAT2q5DL2sJ9oMJ5ojpUVZj7KCbhI9X3UMgUwYRu6a9JXQmEuGGGwzBcxsAjCtNTLGdDItZp
 p74gKsvZ2j/xFd3qNj4AC5WuhAJE5o6cSHzLcJ1KbN4KkbndzJmMyGDG/AM5mx0hldc3gpLKjV5
 8Fuj4+e4nyOgK1n2u0p+4RmPLu/CEOCDwILxdZgisjhZTYH7XY4xXV88XAaX7rUuaBYJC3LBBGt
 HuCk4sHBbMYvL2fqFp5
X-Received: by 2002:a05:6a20:6f03:b0:3cc:2c74:a0 with SMTP id
 adf61e73a8af0-3cc552de9bcmr1931348637.21.1786573913532; 
 Wed, 12 Aug 2026 15:31:53 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef721cb0bsm212031a12.26.2026.08.12.15.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:31:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 08/52] disas/riscv: Tidy disasm_inst main loop
Date: Wed, 12 Aug 2026 15:30:58 -0700
Message-ID: <20260812223142.349142-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Unroll first iteration, so that always_true_p is not used,
Drop some local variables and use 'decoders' directly.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 63 +++++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

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
+    dec.opcode_data = rvi_opcode_data;
+    decode_inst_opcode(&dec, isa);
 
-        /* always_true_p don't dereference cfg */
-        if (((i == 0) || cfg) && guard_func(cfg)) {
-            dec.opcode_data = opcode_data;
-            decode_func(&dec, isa);
-            if (dec.op != rv_op_illegal)
-                break;
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
2.43.0


