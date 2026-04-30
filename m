Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF27FFF887E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:09:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEwO-0001nw-9C; Wed, 29 Apr 2026 20:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEvU-0008AS-EP
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:51 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEvS-0001wf-Iz
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:43 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-82418b0178cso193265b3a.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507601; x=1778112401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XPbtG+sHNeaROUy0XR6V+HlIi8gkAhS1z8vmkBsYSvk=;
 b=E5dx5X5dQGpCB9H1o2RBO2a2AhJDeGVXNn0eHpSGraDtGRg8Yb3Pj6M4uKCKNXhr1y
 sO5TZMSoBGmzTHJbK1X/ET3mLipokUrrSyBEyzb2uzTSFstKyA4OQDQPu7Wy/EAU+x5M
 +xDq5lG0rRe4SZnugPDicTpoRC0CBvIxmbxzkVAtrg+LBT+VxlKXeAnHXsVR4Y3H7Nip
 20eKd99baJlC3FWgi60FCdezsoq3+Hlag1GOLi5FS24Q0kwR1GZmQv+cS9WrPbc0L6+t
 A34vhuG48Wf8xmCs4LoN/rvxmc9RdBmMWYx7DQrGxxCPgrbysUdLoLI/OC35Yt9AFeHy
 pTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507601; x=1778112401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XPbtG+sHNeaROUy0XR6V+HlIi8gkAhS1z8vmkBsYSvk=;
 b=gs9nHT+GmzvIVPeANQ4amd8a/eK2NPef5WArj9hCsxy0X6NSQR9dGfk32z6YlcEqZE
 3+8Sd1ZPCrVE9nOGHt97W4csosLowf7O/76dhRFs70/mLswhRwQ/ZDtbLPWQAwajtnFL
 QnQ0GUusRRIy2IZwN7cZEzmJN4y8zESK/JFpyxoE2urWVKPpMzTg/WZSvIeeHJ9JNu9/
 RDz2QeVPKOXewYiE8MuTdPJMTCz988Uxq1K0TSbuGAomh08sDpT2vhnUSjhIbNmRqXoG
 ay4jsBEpfqajg6h7gQDXLbOHRl9My9SMcKIktwxn2gDNKHz8ZE2g7mSR/CQYd+94uyhc
 v87Q==
X-Gm-Message-State: AOJu0YweGckjqLmbcXgYex2/g33iUf8HZoMX/9oLO0bQum9tWIP8j1UM
 TyzoloGM0CopxCJhr3oKEFzZjimFMrdwgOf12umr3UEK4WAYlc9rMQAcBaUmj5XK61Xy/xaBVSD
 6snAF3FE=
X-Gm-Gg: AeBDiesyVIIA+7kC/rvR6GjGn12Zcw+KbsMJCGEoe1ZDPYevgETQy6h9FZmdtw/vtuV
 tcqwJxlaYKgOge82zBuO5gCHQ/KeM96wimToJhur/Yf0ktk0MPt1y7AwoGfFOBqRQRBZius3Oej
 9ODS/C6FvL/N7SSqxwuqSKQ6RUS2szDiKX8MPWXA18ff5hyq+P0wdIOF/rgOfvkOjlcMGxO5FLZ
 RE5oGKAiSNFuuTkv/wJW7xaziy3Y/Z083HJJ2thetbXvOJ5GXPy9MH55Dj2MCQBR8r+DUuwetj/
 KGGh/XKsDFP/w30veO9ADAIFCofJ2PqJ748yn7p8ajvM0OseyEV4B35vF2IjLcnzHUrxO0bNYYJ
 zcSCV+rm/w/gXXjPkmVLK89mWO+SX/D7+rEPeG+Fu4yqzo4cPSxc7yhGqhfX5QWVlpfZ+0kIlAX
 CMqoeL6kvQJsKtKTI0krYK8JD1hrfCWRq6h2w/H8bf
X-Received: by 2002:a05:6a00:4c9a:b0:82f:28da:ec7 with SMTP id
 d2e1a72fcca58-834fdc0ddd5mr744408b3a.27.1777507601276; 
 Wed, 29 Apr 2026 17:06:41 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:06:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 32/40] fpu: Simplify 0 +/- N case in parts_addsub
Date: Thu, 30 Apr 2026 10:05:15 +1000
Message-ID: <20260430000524.56046-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Consolidate the tests for zero and anynorm.
Add comments for a few cases.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 6aba0e6b18..c380f30fae 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -556,6 +556,7 @@ FloatPartsN partsN(addsub)(const FloatPartsN *a_orig,
         }
 
         if (ab_mask == float_cmask_zero) {
+            /* 0 - 0 */
             a.sign = s->float_rounding_mode == float_round_down;
             return a;
         }
@@ -581,23 +582,20 @@ FloatPartsN partsN(addsub)(const FloatPartsN *a_orig,
         }
 
         if (ab_mask == float_cmask_zero) {
+            /* 0 + 0 */
             return a;
         }
 
         if (ab_mask & float_cmask_inf) {
+            /* N + Inf or Inf + N */
             a.cls = float_class_inf;
             return a;
         }
     }
 
-    if (b.cls == float_class_zero) {
-        g_assert(is_anynorm(a.cls));
-        return a;
-    }
-
-    g_assert(a.cls == float_class_zero);
-    g_assert(is_anynorm(b.cls));
-    return b;
+    /* 0 +/- N or N +/- 0 */
+    assert((ab_mask & float_cmask_zero) && (ab_mask & float_cmask_anynorm));
+    return b.cls == float_class_zero ? a : b;
 }
 
 /*
-- 
2.43.0


