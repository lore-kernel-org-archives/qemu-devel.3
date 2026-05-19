Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A20CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNDl-0006kE-HZ; Tue, 19 May 2026 12:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDY-0006e0-RM
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:55 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDV-0000fl-H3
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:52 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6969c864c89so2075764eaf.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207768; x=1779812568; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vlxXuOxT+NYJ7cIBM5cb2IVyDziWrmPqOCWZ9Z4002I=;
 b=D0l+r27KZxAuQLhD1Xr6mpDz15QqO9Pw83vy7pH1IbtBxxCLeiWDDzKKZc/aVCH999
 nR5B9CAYE1SJjfmVU3eBYZO3t08v9Wt9SNOH2p61u6Wl8UfYj34+YXabK4jxpaxJBAL+
 4Oacqf5VlEd/unbyv1WUgbRMc0HMhFKxqn3lWvqC2sZ2jCO3DOBGY6RdanptRSiwOvri
 QUGf8HMq0BJonZ7ihFfsSjDqAh+akgMaf4NSCoQzI5/6fBV12xqwl3OumW5kiAGkplTn
 07CGv8Nou2bEDaHhbpfCaLUaC7d9X9eUznSk5OcRqikNk0aTcC6psLWbdXcUIY+WVVxT
 Ji0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207768; x=1779812568;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vlxXuOxT+NYJ7cIBM5cb2IVyDziWrmPqOCWZ9Z4002I=;
 b=p/7Q3Qw7YAS00o2SqBvElEpZnwpfoMaG3ppB4Fvjh3Rjbofp8wuJVD6i8Ve2HB0I5n
 J8QQJ2IDHyLQrA+yXOKlSJLpfoSCETlofr/MFfdJMs9wo4qjYcaITqG9Xf2FoVTSnN7P
 xPsyVBGIAnpLcalAUmOPor3Sw2cyakW5Kn/Inj6s9NwL5UEnTUqLBbJp0DPfapivOB6O
 KJve/4iwyzWq4LTgFCHRr2HgYWeeJq+36CHaCnd4vIwpXcHkIddB2siQddXWz18Ksko1
 eSFTo8Ue5eOlLoFvq8xtPY9zqAvmu0nO0Xc5chfvoMmMsx9N8uRmieiBruuSLqgzy9j9
 Ff2Q==
X-Gm-Message-State: AOJu0YypdPEfGXqqyxNlz2WOmzxqWllHp46eQPXiZsY1kkRlJ6IXwssa
 e72Yo8OcTjlzh+AqvVmVScrPLktzkGwyLedbwvs2Qlfh0mm5Gcg7hbam
X-Gm-Gg: Acq92OG+HV6Z/HjgaYE14e23euWybgjf0X3JtV8bcRj9w8RrxoYK62SL6jSRWtkjsDu
 r/lKiv0JeX4V3waxZvJ8raaE6H1/1Zn7Zp0z0iZetZBXQSYIU9wgdl/eUlNZ9d5GA9KKx9Hknoj
 S9iAPNd8A9nJ7KZiy6N1RUf7ok141c1mZS3zfsgVOTQx7aJnHS8P76orHdMA4jX4xXMO5lcJCoZ
 Qi4DQw1dQ4vXNBcgXND/ysRMNfbVgDZ+Y40zZtDfE9f4ddGwTbyEHOB1099v0fbasEnAP+a/iCw
 ksmpN1EKV9RQoTCNM6YxB60mu9bdvcc6C7TU0XEig/EA2dUfzr6nBRxWubTU98Kp8b3qGOrXMmG
 kUY2rnylSm4X5tjxopoKc/DJfNJUSavi1xKPWINd1npUK7232DwgjjOLKimZvftI16ip5csU+ih
 dtb4Iaf3UXhSRA8s21fGO74gKIqrMajX0miIQsqPnkN72PZjlnGxsqT0LFbV7M0gsg6vi3LeU0m
 UfNJud7m7vFpPqf7xpXmk1zsRW3zOtA4tI+fP44FI4nrJf/q0Fidec1lIZhjU1M50Be
X-Received: by 2002:a05:6820:6189:b0:69d:521d:a4f1 with SMTP id
 006d021491bc7-69d521da817mr876394eaf.55.1779207768019; 
 Tue, 19 May 2026 09:22:48 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:22:47 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 10:22:15 -0600
Subject: [PATCH v9 13/40] tcg: Introduce tcg_gen_addN_i64
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-13-d7dd735ecddd@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oo1-xc2a.google.com
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

Add a helper for multi-limb 64-bit addition. The helper emits native
carry-chain TCG ops when they are available and falls back to explicit
carry propagation otherwise.

This lets target translators build wider integer accumulators inline
without open-coding the same add-with-carry sequence at each use site.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

---
Changes v7 -> v8:
  - New patch from Richard Henderson's v7.5 multiplier rework.
---
 include/tcg/tcg-op-common.h |  1 +
 tcg/tcg-op.c                | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e02f209c09..ee0ad5f6a3 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -251,6 +251,7 @@ void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_addcio_i64(TCGv_i64 r, TCGv_i64 co,
                         TCGv_i64 a, TCGv_i64 b, TCGv_i64 ci);
+void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index d8ae57d604..28ef5bacfd 100644
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
2.54.0


