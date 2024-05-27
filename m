Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A0CC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 21:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBhka-0007BK-RJ; Mon, 27 May 2024 17:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBhkZ-0007AC-SL
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:19:23 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBhkW-0003d7-TF
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:19:22 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f693fb0ab6so111176b3a.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 14:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716844759; x=1717449559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E7bkv4ty1zxqt87Mn+b6+Rngx51mCR8MnV64dw39CC0=;
 b=NaZ+L0bYALgR+lv3I/KvUbY+h7mxtaK7RARd+/73LcZV42ucenLw+AVEToa3i9WJAx
 TEpIyj8tzluIHuCQh12HOsIgX/K+kwdzRtA3AP9cOCGDSqujxHCeknUgNAXg91NSb70o
 2UTBSLwwC8nItfeniMqKUi8VavSCc33JHVwMY0O8ScYwhYEEzSSsVBo6zUHHEbzWcslk
 JhIJkPH+eyocCV84sBCZfC+djZI0l7GYRq2xIWM+tDe5ba60R/ppk1H/WBreEE71Vp6k
 isSwhIO1MvLSkXjeBTgIGyy0w2/g2VCAFCwKq5J/qmNAnNf+nSS9+T4jvWYibiHkJ4Iu
 6ggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716844759; x=1717449559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E7bkv4ty1zxqt87Mn+b6+Rngx51mCR8MnV64dw39CC0=;
 b=kSrsf+/ge8kb5XvzULPC87OleQJSVQwYJ5cvnxeM+7gv6HIeKg+/ZJ4Esv5U5vv3Dt
 x8wR7+JuAr+/rFaSZyGs82qm7mOF/4Fzi7QCp+iIQ1B0akr6MVbndggZshStlEvK7oyR
 gUTqKAiIuEhq2WERti5OmdBLm2rVf7gX556tn/Kqr1mmwg1JzFlK0ySLD5MIw8CO6dAd
 tn8FWdj0Vdg6norISJY1FeFGCFePJi7XciAnTDmyDp4JQRl/o2G3rxS6ZuFysgvO1e4r
 muWzLHc7tseu1BvFYJckixweasRoVlaCIqkvlqQ0wD6uu2lu0ZWIdlrA+eCKI4fBUrHv
 Elog==
X-Gm-Message-State: AOJu0YwDE+u124gDfs9vN/73An8ISx9jVncLn+TOMWScU8bg6fqniKcK
 0/EGCLOvePPOulx5+zsx6a6B7/ACcnj7lAHpIEOuIJWbCX5cse/LiSf03/XO9HaSpzNqHmqKNae
 x
X-Google-Smtp-Source: AGHT+IEtlvTuXWzIBUpzzgM+Peon8lMIqdkuYbtYB3du5bqOyRrmtU11Rp6PGW8jquKWITItLL4KLw==
X-Received: by 2002:a05:6a20:3241:b0:1af:cfc2:8069 with SMTP id
 adf61e73a8af0-1b212cc77a7mr9400337637.4.1716844759485; 
 Mon, 27 May 2024 14:19:19 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd1d4d5fsm5265876b3a.165.2024.05.27.14.19.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 14:19:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: git@xen0n.name,
	gaosong@loongson.cn
Subject: [PATCH 06/18] tcg/loongarch64: Simplify tcg_out_dup_vec
Date: Mon, 27 May 2024 14:19:00 -0700
Message-Id: <20240527211912.14060-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527211912.14060-1-richard.henderson@linaro.org>
References: <20240527211912.14060-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 980ea10211..b1d652355d 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1674,22 +1674,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg rd, TCGReg rs)
 {
-    switch (vece) {
-    case MO_8:
-        tcg_out_opc_vreplgr2vr_b(s, rd, rs);
-        break;
-    case MO_16:
-        tcg_out_opc_vreplgr2vr_h(s, rd, rs);
-        break;
-    case MO_32:
-        tcg_out_opc_vreplgr2vr_w(s, rd, rs);
-        break;
-    case MO_64:
-        tcg_out_opc_vreplgr2vr_d(s, rd, rs);
-        break;
-    default:
-        g_assert_not_reached();
-    }
+    static const LoongArchInsn repl_insn[4] = {
+        OPC_VREPLGR2VR_B, OPC_VREPLGR2VR_H, OPC_VREPLGR2VR_W, OPC_VREPLGR2VR_D
+    };
+
+    tcg_debug_assert(vece <= MO_64);
+    tcg_out32(s, encode_vdj_insn(repl_insn[vece], rd, rs));
     return true;
 }
 
-- 
2.34.1


