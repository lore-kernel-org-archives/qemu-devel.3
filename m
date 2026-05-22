Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FE5CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUaq-0004hN-AC; Fri, 22 May 2026 14:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUan-0004eF-UK
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:30 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUam-0005Ms-C5
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:27:29 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2bccb978bd9so51850505ad.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779474447; x=1780079247; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bCgdRyITzXe+PAn36FnB4uw07GyhqVI89lgA/9dEQq4=;
 b=exO4k8p/4Ig2bjrKqke8xS/M7sJ4bKRc5RtpYWrWkvo1YgZM/piCKiH6TeHy03tMiO
 xxnYdAQpdvNOxeAZ8DTyRKEW/8Kb4XEE6sJfNczamhVXS7nmBsebar9R3/XOxw7PTIpc
 WvV+5KvXAHZo49hxolkw9Nns4OU1hS5h9iRpK4BCauwdVnSCqV6x/RGdm/8UCS9O7TJe
 uJj5yW4Pvt66bN8bfr7GR1GoCxw0J/lh2DM8Cp4HMvhKhnyHXuqCUAvWoCo6Ctl0aG6D
 H3+unirRAO93sMEiJ/XN7drhrPKK36O/Vgv4tiCQR+w+4N27yNTRfHZTHeUJYEE+YUgF
 ibcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779474447; x=1780079247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bCgdRyITzXe+PAn36FnB4uw07GyhqVI89lgA/9dEQq4=;
 b=L0piy5kT+z8y+dKfMoGNBwtW5tSL9qY8iadw4pkOt8AZSWpa7VLxMNT6kRCzehK9sH
 naZRMChzDOOUfWtWgp2kSlFGAh6pZwVIG1Ukncedp8Dgk/I29TtOw2ez6tWhg23YNI6I
 j5hIftPhi36jUpFgCMf8J3hvQpjZd01CjTip8AiNtVifWleGIxu5IDLQUFekb5Jj+DQE
 9jYdlo/4Mh8fMjG0MZ5b8K0M1wFt8cii8GZc5nPQgqpyrBedsa/XFxuKX5TTlfO4cRU/
 B+jQ/AgfSjbbg/7IngLTwBfvyjUwvW02Sg0faweWRLezdGbL8v2j4VpHZ9xs6JEjvwKJ
 PqCw==
X-Gm-Message-State: AOJu0Yy6yLHiuwjKkYK4EGmVpr8XtEmX0y+eoU5tU8wsOsWJ3MBB6Dfp
 c96AMAKAoL6WXbZ35SGnC6wEBWH8O6mxQpEluQ0UqvJT2F6LYPdOzf/LqDrLVO5Bmh1TntHmrZ1
 4qSrC
X-Gm-Gg: Acq92OF1fDdYHAm+QGTrAAurKlxwvhsb9WAu6SQRbiVocNj3T5fQeKjRa9XXZt1Dae8
 HFqwqzhMurmHdUGWxZvHP4/02V99WyXWLo8bcj/uKw0iw5r52jnl6PTtFKrHSZ3/9KhvuUpEcEF
 8YyAtbafErx99w9fTJwREUmUsBPcvU55FpWw2zWRkSe3/VCS7QMDdjea3fm/9Sel2Fl/dNTBV7o
 WyDpc9S0JwX2OO67++WiKVZhfu/gUfsFEmrw7YTF7sKG0WbwCdvbZqnQOxAZxPOAZ+GCKW9V6gu
 7jaLR/IVaC+U6jxdGBFscrtejBhEzlvd6g/Jgl3CWmwRou6I1kg781w6jfYl5dolQKVxzpFgbGK
 r/9bkAgdhr8uo4l1lWOAYz98/a+mIlZNr3AHtACIGqhAcxL7em8GioC3ihSVNRMlBurKV0El9RW
 SGpZthjBhypxLEyCFuZ3Zbir+Yqt9jDJPIPyaiDgrrhN1J0zeuIg==
X-Received: by 2002:a17:903:350c:b0:2b0:6068:4c5f with SMTP id
 d9443c01a7336-2bea21d2cafmr83439355ad.8.1779474446718; 
 Fri, 22 May 2026 11:27:26 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb5900b8bsm21824735ad.76.2026.05.22.11.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 11:27:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/30] fpu: Simplify 0 +/- N case in parts_addsub
Date: Fri, 22 May 2026 11:26:33 -0700
Message-ID: <20260522182658.184604-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522182658.184604-1-richard.henderson@linaro.org>
References: <20260522182658.184604-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat-parts.c.inc | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 3246702289..45606f8402 100644
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


