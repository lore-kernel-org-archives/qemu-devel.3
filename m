Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918CBC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 08:00:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79Ru-0004QN-Re; Wed, 15 May 2024 03:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rq-0004Gd-Dp
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:14 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rl-0001dI-Ul
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:13 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-420104e5390so38425885e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715759586; x=1716364386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LFwVHeO0xdQZE4q/p0sWN9ZrSqg0kbbJP7VPGYxlODk=;
 b=XRQJUHcVK4WDZvmB7IUyCpsvozkpcvk8sLigeUhJFdBjepKS3GbVH4CLImPvxLsqSp
 fcpmETKVP0z3D1ZTRjMz+OPvV+WfABIWwif51FxxjuR1sXGUFO4/qCC5/ex+ICf/Nj0C
 R7Wh2fftRKhf5n85f4q6XiEMlXJ7iItHMFar/33JdnV9UB/ArsH0IOiAlPqu7El5mfR1
 u2mvyf0Ic+XxLBOa2vchx0EIoz9yiG8k6GclGGl5i8OyRu4A9UlJsnJsb4aDakLmqYjZ
 POchqwsJoGxYwxgGm9y2aD+aq1aE0w3QFJgVlG47ZwT99XcdEHIKA7wQQFuvju7OQqR2
 pufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759586; x=1716364386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LFwVHeO0xdQZE4q/p0sWN9ZrSqg0kbbJP7VPGYxlODk=;
 b=nGjAhUoMF26QDBuKFYtP6PYZlZ1+8MBzIGa3EG8lDGaX4ZDkO9WqLeuxY8IvGvIMXV
 BB+Cr7on9qfgUa18Ua0Ly8WzuTY4e/+VuwJy7Rakw2JegdoDSQtLeJnVcY2HAe3WpLli
 lX226T3DUnFvHQFDInqfiINEj2TKRDSuWeNd887rbr+pA3VejV2qvVMag0NWaHuVN983
 HqFxNLnXaG/HdnFSbBNzzYN7q7fKAmfLMMrRRIeVdrLcdnx7wsAoA8AknZ2hdLOXcXQO
 VksNUwQqZ+Mc+oVvEWWCj4dMoiqVvn1S550Tnpo/ov4LQc05C8fBPw9JLXKIoqRFmstE
 uOKw==
X-Gm-Message-State: AOJu0Yw0AJbIkIyisw1W8qYBTcf2gyrrk4To1QU0v3xXaAWs0eOnL4c3
 OiRK29YrFV3W5fc1Tg5X44/dL4Ni+/BrrW10HYc4/i8pHAt4BHMbkV9/yip3s4eJH7LB/BDdxYk
 BSxM=
X-Google-Smtp-Source: AGHT+IGOETvF3LQAfb1YTNsF0Y25Xv8dhD7jMHwTl+3Hkv7dpl8zzP4fXV2Z+k/j1NWJQqbcmW0Zkg==
X-Received: by 2002:a05:600c:19c8:b0:417:e60b:91f6 with SMTP id
 5b1f17b1804b1-41fea9324d9mr164134675e9.4.1715759586628; 
 Wed, 15 May 2024 00:53:06 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9292sm222611855e9.37.2024.05.15.00.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:53:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 27/34] target/cris: Use translator_ld* in cris_fetch
Date: Wed, 15 May 2024 09:52:40 +0200
Message-Id: <20240515075247.68024-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515075247.68024-1-richard.henderson@linaro.org>
References: <20240515075247.68024-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/cris/translate.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index b5410189d4..bb2d6612ba 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -222,37 +222,28 @@ static int sign_extend(unsigned int val, unsigned int width)
 }
 
 static int cris_fetch(CPUCRISState *env, DisasContext *dc, uint32_t addr,
-              unsigned int size, unsigned int sign)
+                      unsigned int size, bool sign)
 {
     int r;
 
     switch (size) {
     case 4:
-    {
-        r = cpu_ldl_code(env, addr);
+        r = translator_ldl(env, &dc->base, addr);
         break;
-    }
     case 2:
-    {
+        r = translator_lduw(env, &dc->base, addr);
         if (sign) {
-            r = cpu_ldsw_code(env, addr);
-        } else {
-            r = cpu_lduw_code(env, addr);
+            r = (int16_t)r;
         }
         break;
-    }
     case 1:
-    {
+        r = translator_ldub(env, &dc->base, addr);
         if (sign) {
-            r = cpu_ldsb_code(env, addr);
-        } else {
-            r = cpu_ldub_code(env, addr);
+            r = (int8_t)r;
         }
         break;
-    }
     default:
-        cpu_abort(CPU(dc->cpu), "Invalid fetch size %d\n", size);
-        break;
+        g_assert_not_reached();
     }
     return r;
 }
@@ -2868,7 +2859,7 @@ static unsigned int crisv32_decoder(CPUCRISState *env, DisasContext *dc)
     int i;
 
     /* Load a halfword onto the instruction register.  */
-        dc->ir = cris_fetch(env, dc, dc->pc, 2, 0);
+    dc->ir = cris_fetch(env, dc, dc->pc, 2, 0);
 
     /* Now decode it.  */
     dc->opcode   = EXTRACT_FIELD(dc->ir, 4, 11);
-- 
2.34.1


