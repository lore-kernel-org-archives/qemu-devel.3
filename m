Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27520C88E75
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 23:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Fnb-00038H-TH; Mon, 14 Sep 2026 19:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6FnR-00035y-Pl
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 19:09:09 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6FnP-0007EO-KG
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 19:09:09 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2d6e954afbdso30283655ad.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 16:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789427346; x=1790032146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hp98EFeGEXaMZfJzt6dBht66T/TZlFkqt0wAoHKZQrE=;
 b=LM1hxwyPeap/3Fxk6W0ZTIhXuIogN70N8ZX4hxD/sL0NpXeilZ4rT+1a39fOFJL6iz
 FRNOOVm3+2y63XSzOu+MJWMAeGAfyiW7dSrbxwqnp6nGHGP/n4YS6tRcqfv31JZC38ld
 BKEeXFcVEREowb7V/IW7VqsG8fl9v+92pFGy0xsFeEi+czPgGL/29/EOh1irsdtTf9Y9
 mhiiVCucDFf8/Mul5uUaFpnPB7ebjTciWXKN/NmLV17K7jbVI1nRlJcSM5UtnKUXzVw2
 j+N/BnYybuWwTzUMEpZCqazm9jt7VL2WaGDkd+vvOGy/9aZ+nCNEaKRWKuD7iwTizo+J
 +K2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789427346; x=1790032146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Hp98EFeGEXaMZfJzt6dBht66T/TZlFkqt0wAoHKZQrE=;
 b=d5Hq4fNisTyxEJCus6UcHo2rQM4WY9ZTABJOm2nmmSu7Rm2HegH1DFK4HBDaGCVpZm
 2rPsB16Ucq/W23wx0tffcifsNbi/UhryNzUqEqAq8YhWI9/5GNTke9Q0MytM9K/TF0xV
 kwS6H/zJ4vRsnY1JkOJd+KqdUEfmiOChjYNZppy9bvIb2o29nOyKyy7STt+D2rYfELYT
 s0uGz7cibnXF2Y1Ch4QikZM5yihQrNyxj3a6vBsBKbnDROAAOdlkbtlUcSqQFAAmMPdG
 1oDhc0KsjDHzvHTiAlWxFmax/7vl3w6xZbKOip2jA4Q2sDWHTXvsEdY16PQebilAF72x
 eSnw==
X-Gm-Message-State: AFuF++nxlfPb2jXD60EmyqenVIuCgjH70rPBXYeKTeht3DVvU6OAoiuV
 MP8ETqMRxJ2oEE+SuBRCbsQ1jQdvRuiLZUZsY9ge8WA7g/10fB9+nemVe8OgX4Z/1tQTxOZ/ED0
 e9tWxGXY=
X-Gm-Gg: AYBFou1wm7IB6Pksy4qmzC4QxH6M+ZdolZqHCfZQj9JY/ELxfVVNrSCKPtGjYggYqFT
 yvSWXEg50jS/EOsWdGG/4OhmrehCLfyJLi7TC2GVhqPji/7t2I2DLUVTeuyZc2lsA3Oj3FH2SUI
 tclVTcECODPf7Y3SZBeQed1qmJQK152i7wr6CGWGgTtDLd6wj9x0Yr6QoumqPm36mknVT/6gBmX
 c+LsWAQRc0A6Lw+3yGBHX+i5Ms4/UaFuUmNPMgEbaO5u85xeH9g+WXFpBcINvbRp1PLDtdMGy8W
 DAOaF8jKdRu5m6hLduifuiA25OqQ9SkTXbUDn2kQpuS7EwEo9GPrFwD4ABXHaZ6yBqCmWQibkN8
 TnK/Gj5lFMhsWPw6LV/qMOBhnThCCW8yfw73z139XEk2iapBfW5pn4hH7AD6V8fM2ue7v2AoNGa
 /UwzafxK1jdMHRivO/HavrK8g16tRpHpwTMhhDl6dFXhYcS4xzDwAy9qYpybMc/+hqEO9S1XBhS
 b0kBCQ=
X-Received: by 2002:a17:902:fc44:b0:2da:e67a:87d4 with SMTP id
 d9443c01a7336-2dd6c75e064mr100224695ad.19.1789427345626; 
 Mon, 14 Sep 2026 16:09:05 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:7164:7976:4c53:31bc])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4e9a3casm28054447eec.12.2026.09.14.16.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 16:09:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com
Subject: [PATCH 2/6] target/mips/tcg: Drop zero optimization in gen_mxu_s32mul
Date: Mon, 14 Sep 2026 13:08:54 -1000
Message-ID: <20260914230901.1781309-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914230901.1781309-1-richard.henderson@linaro.org>
References: <20260914230901.1781309-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

In the unlikely event of the architecturally valid case
of using the zero register as a multiply input, this will
be folded away during optimize.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 9559b8aada3..f30883f976f 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -964,18 +964,13 @@ static void gen_mxu_s32mul(DisasContext *ctx, bool mulu)
     rs  = extract32(ctx->opcode, 16, 5);
     rt  = extract32(ctx->opcode, 21, 5);
 
-    if (unlikely(rs == 0 || rt == 0)) {
-        tcg_gen_movi_i32(t0, 0);
-        tcg_gen_movi_i32(t1, 0);
-    } else {
-        gen_load_gpr(t0, rs);
-        gen_load_gpr(t1, rt);
+    gen_load_gpr(t0, rs);
+    gen_load_gpr(t1, rt);
 
-        if (mulu) {
-            tcg_gen_mulu2_i32(t0, t1, t0, t1);
-        } else {
-            tcg_gen_muls2_i32(t0, t1, t0, t1);
-        }
+    if (mulu) {
+        tcg_gen_mulu2_i32(t0, t1, t0, t1);
+    } else {
+        tcg_gen_muls2_i32(t0, t1, t0, t1);
     }
     tcg_gen_mov_i32(cpu_HI[0], t1);
     tcg_gen_mov_i32(cpu_LO[0], t0);
-- 
2.53.0


