Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664A5CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkg9-0006bY-E9; Wed, 20 May 2026 13:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkfX-0005aS-39
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:25:24 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkfU-000403-GE
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:25:18 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488b0046078so45633355e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297914; x=1779902714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XSiG7gGiExeeiYzEge+/yBN+HoKo7f+sN+7ijrnTEwY=;
 b=PwmcntrlHs6GndWj8E6lcDmDq467OQ/b5003ZeRA74seNDf0LN98tyGdOCEMxdyf4w
 EEphL2n/rxJmfzEgL4IEaDOnyK5AIdaLAH5+vy6mfgYI1t8cTazVLDILl5TIwqL8OJ+1
 827zX7YmQ0xN5IE/O4v5QKlJ4Ftz1nqxRjHIfRvwK0LsSwRRSrIg5XVRqUivSqD9jyCL
 yA5I4I/9pRyEUldAI2L0+gusyHPd6TmrWPh8SZaxysclCFGu6e2kQyZG4n4139fdm9tv
 RygBbxs+h+i5ceZceNxLQe29YH/z8Yd7ciyV5HuwJaJJe3GUg+IMoTem4sMBZa3QYKr5
 dgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297914; x=1779902714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XSiG7gGiExeeiYzEge+/yBN+HoKo7f+sN+7ijrnTEwY=;
 b=cOlgMVCewhBvloNMW7vW3i2Yt5OMYC7GknlK0QLUSHm6GY/PFiewyCvZsMAGbJVfJf
 WXP4q1n7ZMygCGXj99S7y0b5wpSFvbH2I2U0COpEytn9xoAIDIOv+qwi0fsoUxjLFaVv
 ThyWzHKKc4QXsrBlpxvDU+KKP33QmyzJI/1ivt3mRzI0J1N+sUH9I5DiMyMuJlTu8w3v
 VMrP/rEHI6FSjxlWm5CH364gwg5fXV3JKUHVpzEDIjK4lkNWqSD7PossyI8dCv0uD0su
 2+2hnHy7nxMSc6Udono7PPEOVpCXz1EM/EvsW1rH7ZHUtdebzywmvz9PnxZuj6JT0EH/
 YqDw==
X-Gm-Message-State: AOJu0YygdcVgTNWA2Yx7MV240YpO8R4rhdkAhfL9TxuSpPNwtGWukEny
 P1VotprzOFuF52xyIvj+ljiVY8i6h1CT9LWAiQP6IftcwHk5rZCZ4j9n47HLSu/U+ePwDkcQo/p
 /eIg+Dkw=
X-Gm-Gg: Acq92OEpJBY3feG+JPY1ebFhObva4CDj2V6dqwHiW0KETeFdkVh/alYU63KTWbxxUBG
 PILFAlw3KlEH5EamKXmNBVaTGPGDyR6Zb/l1pJecI+BPg2fWeK/z1fYBF557IxddKE1REO90ljj
 It9KrLikKlvgUG0czP640ocfYfKON+FRrYsLZwOdA/CUUe0/B/EyzJ0yyfVV575z+2+4IIVwaOL
 AyUQKUS401c9CCi824S1Yx81QxViGB/RAYQQDM8bYKB3LqYX2RkU11RoEzWuhNimzaPwRjztdfG
 f8y/krmeCXRJ0DQaiDmDRoYvFiKKK0GlfHbdUEvIO12yRcumpTKVlVfw3B3iKTEBsySjGcs2R+O
 p2SILJXSlpxPVnzo6tidASVrR8NVTOnFl7scCHWL3oGmdyv9vlwnnwIpR7w6fd08dSTvzC19uJT
 H+cZXdP0Pq1ZDkSg3AvIvHgmdmLjYXi9WDj3ilPdt6zyeUCHDzjrjlUJqIJL9/udSS4wLSHXKi
X-Received: by 2002:a05:600c:8906:b0:48f:e3e7:3d39 with SMTP id
 5b1f17b1804b1-48fe5fdd63fmr285946795e9.11.1779297914223; 
 Wed, 20 May 2026 10:25:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feb00bbe4sm134909355e9.12.2026.05.20.10.25.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 10:25:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v12 16/24] tcg: Introduce tcg_gen_addN_i64
Date: Wed, 20 May 2026 19:23:04 +0200
Message-ID: <20260520172313.23777-17-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520172313.23777-1-philmd@linaro.org>
References: <20260520172313.23777-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
index d8ae57d6047..28ef5bacfdf 100644
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


