Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C57CCCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Cpr-0006a6-R8; Fri, 10 Oct 2025 09:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cpj-0006RR-8S
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:56 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cp4-0003vd-Pe
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:54 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42420c7de22so960230f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101568; x=1760706368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ewlPxRur2UwbnMrdBufYyXSEz9OIf5mQHJvcBpq1vY8=;
 b=ONzoXpJq1i0UDd7pabsxm7c+tsREbTdhJsRXJzS5t5wwr+nYKgxtzVk2wCZZgxU7aK
 IqAmmVMsPgWIzxIaBCh+jOVMIEicFcXYeIgOgbN9Y7G8TvI3K1H/P2yvwbXE5/wOlXL0
 o4Zp8q/YOM7tNgwqrIxdyrmOAnhc9oL152wEjtekkXfnhIgOOMcf0UuTkfy6qokmdb67
 B21yGSlbJNciS1MNGBju/9xE6PXvam+K7LPCh+wqebbKW7HhqqGfMkOk5fV9NKTCWYIX
 fcXK2BGTlf+nMeiQjSoLDB2ZYRoUx3uNlEHG7rEdfghBGVxQwbKZIyGFNB48qRHIEaP0
 j4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101568; x=1760706368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ewlPxRur2UwbnMrdBufYyXSEz9OIf5mQHJvcBpq1vY8=;
 b=unu5OvzoJnnsVSVbDM6qEdGLAWW8mJFNptFRs9uOO9H855EJfjJ2YBfWnSaqMAO8vk
 J6A9ID6mHuvlPcCOmMp2uIe9At63a05r58yhwGyYHqknUDg8xB7eKX2drZgakm8Td6AI
 t/L10gpIICfhKmQJCi5vu+A9ZEdll/c6hBw535oaCgdOrpeF3ys1T9QTK0SXUL9LCDwA
 TrwKIZRqvvkGWXT4DLigUNUIjry60NZCirMcHnOWDjBUcIp/8/u4gj7ea4G0B1x7EKnm
 nBxMABv/g+3l6inIYBCXXWI5zHJmR6YWWSfIki1twOqoa67gmSKOVp7dInjkoey5+VQs
 R3EQ==
X-Gm-Message-State: AOJu0YzrkUmMEE1V6RAGjIAzvusfGiPfrhDqAGiDDh8+2wSjpOxND9Jb
 Fx4+P/H07+7iT1bjd54J9M399fzJCZWuiUAx3kLboicqeM1c/0Xqmb7B05zCMewFIJbzZqBnPM+
 G+Fsx
X-Gm-Gg: ASbGncsdaO5w5VTx5ZNNLNGkDqpmVL8JPpltAN2cwMkhZgpaz/dUv+BAGln1ExojsmV
 vy4EWpqpx8qfo0aMpVMHdRlzk/CFZG3k6RKjvpOfhBj3OfZ5ImUzWlG6hUk61WoF0aDlGBQa9Wl
 /amtRjEW5TBZ7hZf+V3NV85+2J+LFk+326BmFX1INMsKzFWWgSDq0Rk7FW+HXcKc48s90+mzPJS
 zyp8R1DbKxReBB6hrv4eiXxWXuOxiRS5W1WnP5PZzyitOLvc9NYwQt+JVxFBi8PulZeiv5r0ZcI
 EUZ/OBzcp5+KUNfZIhwaLcHj3vjgnONrLxFox8Y7wuAwPrTi4M6ky4L/3YejYbE1HZ6iAuVtoBy
 mjkna+/geU5w01KRk/hYJCKFSef5MkhiSQ5Dsk8RVzdlMzyWp/8uUyv+k+vBahA==
X-Google-Smtp-Source: AGHT+IHpPQF66e/Z6WC2IIzfZ4YDrDPbuNeLnnR3xNayZm1WVVQKsFG7u28jrlCVx5RsPQUd/nLoLg==
X-Received: by 2002:a05:6000:4212:b0:406:87ba:99a3 with SMTP id
 ffacd0b85a97d-4266e8d8a8bmr6283991f8f.30.1760101568059; 
 Fri, 10 Oct 2025 06:06:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/76] target/arm: Make helper_exception_return system-only
Date: Fri, 10 Oct 2025 14:04:45 +0100
Message-ID: <20251010130527.3921602-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20251008215613.300150-35-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-a64.h    | 5 ++++-
 target/arm/tcg/helper-a64.c    | 2 ++
 target/arm/tcg/translate-a64.c | 8 ++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64.h
index 85023465b76..b6008b5a3ac 100644
--- a/target/arm/tcg/helper-a64.h
+++ b/target/arm/tcg/helper-a64.h
@@ -80,7 +80,6 @@ DEF_HELPER_3(vfp_ah_maxh, f16, f16, f16, fpst)
 DEF_HELPER_3(vfp_ah_maxs, f32, f32, f32, fpst)
 DEF_HELPER_3(vfp_ah_maxd, f64, f64, f64, fpst)
 
-DEF_HELPER_2(exception_return, void, env, i64)
 DEF_HELPER_FLAGS_2(dc_zva, TCG_CALL_NO_WG, void, env, i64)
 
 DEF_HELPER_FLAGS_3(pacia, TCG_CALL_NO_WG, i64, env, i64, i64)
@@ -145,3 +144,7 @@ DEF_HELPER_FLAGS_5(gvec_fmulx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32
 DEF_HELPER_FLAGS_5(gvec_fmulx_idx_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fmulx_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fmulx_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+
+#ifndef CONFIG_USER_ONLY
+DEF_HELPER_2(exception_return, void, env, i64)
+#endif
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 71c6c44ee8a..6d77fd0113d 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -576,6 +576,7 @@ uint32_t HELPER(advsimd_rinth)(uint32_t x, float_status *fp_status)
     return ret;
 }
 
+#ifndef CONFIG_USER_ONLY
 static int el_from_spsr(uint32_t spsr)
 {
     /* Return the exception level that this SPSR is requesting a return to,
@@ -787,6 +788,7 @@ illegal_return:
     qemu_log_mask(LOG_GUEST_ERROR, "Illegal exception return at EL%d: "
                   "resuming execution at 0x%" PRIx64 "\n", cur_el, env->pc);
 }
+#endif /* !CONFIG_USER_ONLY */
 
 void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
 {
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 78b2881a155..43c9bfef93f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1870,6 +1870,9 @@ static bool trans_BLRA(DisasContext *s, arg_bra *a)
 
 static bool trans_ERET(DisasContext *s, arg_ERET *a)
 {
+#ifdef CONFIG_USER_ONLY
+    return false;
+#else
     TCGv_i64 dst;
 
     if (s->current_el == 0) {
@@ -1889,10 +1892,14 @@ static bool trans_ERET(DisasContext *s, arg_ERET *a)
     /* Must exit loop to check un-masked IRQs */
     s->base.is_jmp = DISAS_EXIT;
     return true;
+#endif
 }
 
 static bool trans_ERETA(DisasContext *s, arg_reta *a)
 {
+#ifdef CONFIG_USER_ONLY
+    return false;
+#else
     TCGv_i64 dst;
 
     if (!dc_isar_feature(aa64_pauth, s)) {
@@ -1918,6 +1925,7 @@ static bool trans_ERETA(DisasContext *s, arg_reta *a)
     /* Must exit loop to check un-masked IRQs */
     s->base.is_jmp = DISAS_EXIT;
     return true;
+#endif
 }
 
 static bool trans_NOP(DisasContext *s, arg_NOP *a)
-- 
2.43.0


