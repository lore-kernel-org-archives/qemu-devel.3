Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2D9CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmZ0-0004Mj-PA; Wed, 20 May 2026 15:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmYy-0004As-Qt
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:26:40 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmYw-0002fT-Nj
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:26:40 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso50332255e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779305197; x=1779909997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LGohp7dlyjWh+7CBb01fjLibw7y1O5nFqdvOmwWauJ8=;
 b=KCCJHp1AA2nhbfyNlVVb+zI4Mc+0qYHCameuPRtamq1YsKK5KFn2pOAcxaFOT45MNO
 vDRCKarr1hVBCU0ipPVSBdeMQxIG9/aFml9zIuFnY6SaUYthX+FSUcTpRkXc1ZWskE8w
 6rI86r4OdIab6/FbXEuapZaPEMCWqsGFa8oSd6J4/GCZ0EUXMcz+uF3SmgeIobSVV6ZU
 55TZchgutJBJZrDYxO6qf7tiA8wXeUHJD22/3EK2hVB9wjznzBqSDB9BXAS4L8Uo9gft
 Ak/zNaza6XUhktmEV+MosWAHbQHhKnQ5bmtA9cuVwgWqusI96O89RsiWsyy836OIfBFw
 Lcsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305197; x=1779909997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LGohp7dlyjWh+7CBb01fjLibw7y1O5nFqdvOmwWauJ8=;
 b=fbVZbENfKOI9/y6VLA8h14tE4qIjDclz0aMszz/r2HKGLD1UX75CTpPtQ+cg8KCwiW
 IrC59/IHD3Q27L+nyFmXWvOmgaltzOP6l1tMrR0oFCLiM7Wl2kGb6qkeuL39G3Zfni/A
 OkjNUAVPHw4d16Y0UpYT/NE+Zx4dSj6V5t7khLd3QPEKEf/z4jfEltgTdnYd9OfZoIKZ
 PYZDzn5yB7T+8awhmpqPIOE9sfI3boWAPjx/A6F8Bn6+2Xf95Ly6BLv3c6HBmYM/lyYS
 onBrxxWJjKDwWeXCUhUtIokAy3ueZ+UOHFUfQ8p3mINeRaenyB8lQmWIAJkKld5iqgWI
 WwbQ==
X-Gm-Message-State: AOJu0YyZW35idxvgiq83RyZoAwSm/z0EcbliVX2dDL7vJ5Jo/pFCiFxg
 xRx88Kcrgq17Ep7TQ6CLAyTbugZbhfSW15J4iOgJCgdJUll0m5Xd7w5UyNm6SLNOMvLJx4o5Vhp
 /sEoWkWM=
X-Gm-Gg: Acq92OEUFbHTZC1756qO1BDm7nPB2T9Xie6zhBN4AyKulylWOg4CK6PShPIyLiDU5pF
 4ECrWVBrU4tLyjUjKWc5kfhex8c9jlvM9IYnFD1Y+k0kTOXc3fphyyClSHJVSNmyeyNZIU25DjL
 aGTZeWjVAp8nZlr0I0PoYyjlVTcRMrQn+427h1wCTw06Fr0F//U20L5GAGCKm5Voyrd1gylUcGo
 3nf8d0OCaaABYlpXCzn4PlEUJwRZvSlW4oLS4AaMXhrA2dNShjpfqS5IZnPlxIeW24w+WU8/q1s
 rHFSy5x4OnhkXdPgN2wmeW1xCYHV6LXN8LYYNldoE4BXzyrPMFSAq1CSwvsIBGcvUxdi+02cFLA
 JgJS3WSxuAEQwsWiPChBpVJtRHljj8tYtOtA023ZSoF7PQiC39e8RGfI35+AOwMbH9K+pbrJlOz
 pIkvLvduAwBH8CqJy+yoBl/sPr1qegp8V8kXp27ityA0j4WB1LjmHWnYhUuvpzpQDzbGLvB+I9T
 aK8fx9FmAc=
X-Received: by 2002:a05:600c:6d83:b0:486:fcc7:6811 with SMTP id
 5b1f17b1804b1-49033d568e2mr8411035e9.10.1779305196661; 
 Wed, 20 May 2026 12:26:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a178adsm59648554f8f.18.2026.05.20.12.26.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 12:26:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/33] tcg: Introduce tcg_gen_addN_i64
Date: Wed, 20 May 2026 21:23:30 +0200
Message-ID: <20260520192338.40036-26-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520192338.40036-1-philmd@linaro.org>
References: <20260520192338.40036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Add a helper for multi-limb 64-bit addition. The helper emits native
carry-chain TCG ops when they are available and falls back to explicit
carry propagation otherwise.

This lets target translators build wider integer accumulators inline
without open-coding the same add-with-carry sequence at each use site.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20260520172313.23777-17-philmd@linaro.org>
---
 include/tcg/tcg-op-common.h |  1 +
 tcg/tcg-op.c                | 42 +++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index aff99754160..1fe342db0d4 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -253,6 +253,7 @@ void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_addcio_i64(TCGv_i64 r, TCGv_i64 co,
                         TCGv_i64 a, TCGv_i64 b, TCGv_i64 ci);
+void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 971ac2fb359..bbcb510c764 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2275,6 +2275,48 @@ void tcg_gen_addcio_i64(TCGv_i64 r, TCGv_i64 co,
     }
 }
 
+void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b)
+{
+    tcg_debug_assert(n > 2);
+
+    /* ??? Don't allow overlap for now. */
+    for (int i = 0; i < n - 1; ++i) {
+        for (int j = i + 1; j < n; ++j) {
+            tcg_debug_assert(r[i] != a[j]);
+            tcg_debug_assert(r[i] != b[j]);
+        }
+    }
+
+    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_addco, r[0], a[0], b[0]);
+        for (int i = 1; i < n - 1; ++i) {
+            tcg_gen_op3_i64(INDEX_op_addcio, r[i], a[i], b[i]);
+        }
+        tcg_gen_op3_i64(INDEX_op_addci, r[n - 1], a[n - 1], b[n - 1]);
+    } else {
+        TCGv_i64 t = tcg_temp_ebb_new_i64();
+        TCGv_i64 c = tcg_temp_ebb_new_i64();
+
+        tcg_gen_add_i64(t, a[0], b[0]);
+        tcg_gen_setcond_i64(TCG_COND_LTU, c, t, a[0]);
+        tcg_gen_mov_i64(r[0], t);
+
+        for (int i = 1; i < n - 1; ++i) {
+            tcg_gen_add_i64(t, a[i], c);
+            tcg_gen_setcond_i64(TCG_COND_LTU, c, t, c);
+            tcg_gen_add_i64(r[i], b[i], t);
+            tcg_gen_setcond_i64(TCG_COND_LTU, t, r[i], t);
+            tcg_gen_or_i64(c, c, t);
+        }
+
+        tcg_gen_add_i64(r[n - 1], a[n - 1], b[n - 1]);
+        tcg_gen_add_i64(r[n - 1], r[n - 1], c);
+
+        tcg_temp_free_i64(t);
+        tcg_temp_free_i64(c);
+    }
+}
+
 void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
 {
-- 
2.53.0


