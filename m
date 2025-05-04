Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B160FC369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRvJ-0002PG-57; Sun, 04 May 2025 01:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRv7-0002Bg-HZ
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:45 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRv4-0004O6-Qc
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:45 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso3535958b3a.0
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336581; x=1746941381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=39PScigtuz9820KEKAK4bxrnXJbLJRdrPn0GANchp1o=;
 b=SGc/f96uKAQUFbJK6zE7qOmsF4CQFSXAPyLfUIzEJ7b6/6gFBV+CUCGXgJ5ckkKXV/
 sauEuQJUAjP+IWveo9/73iC21SytHCHbwoMQoK8FCuStepUxEP+scd1ll3KyXXjMPAz+
 0BhZkRgHofK4BikOdZMOHRdkVcOfSwT+BjWfHobSmsmsouoj0crsoVasghrBKVc2Kqmc
 k9O0HMWri2pTLXDBpDbq/envEwz0BKUkjjnn66GdHWk8tO4aFqT4d1m0ONCxiy4ugjnr
 dYpNJHyxlKe3klMRoN6nGYWQkq36ahFZCqjvcDR3MYQcPJWdrEb1x9fFrhmFIRRZUjvm
 pTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336581; x=1746941381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=39PScigtuz9820KEKAK4bxrnXJbLJRdrPn0GANchp1o=;
 b=mGfEmPKCMUlQ3ca/wlYRvgKfvN/5UtUfba9n6wFN28ka/3EoTAHwyWYft405xNHUAG
 mF0yM7Q3m8bSv1elyqYErmwtEkkb7ZNNp/ps3faKRrJuWXtWTSlQma02xtZxIU6H/gMr
 oxMscwxchWjIeJSIjJgF4EzmvHJE5xdX72gZ8t13l1cYtEce+9jOrw4LODWbBIqcLswW
 fRlUOrZuLwy0bv8us1+FqoagsFS0CHWNBJSlO/Y8sXqO/y1gZPzN/IoNb3Rf+piNhKbV
 xY0LyF82RGq3ocnxO+VbVVabMFDSb0+wFCmMw5t7vh5iVf/XGk7rtXn2M3joFmDfsTvm
 0NKA==
X-Gm-Message-State: AOJu0Yx+YzgW+8n61pSTsgwoAd9Ssncg20u6h123hN27XGpSanHwNSKR
 4MJlEBxBFKvHWwlObjsivrKu5yXGapR708Iz0HSyMcqhHvtrQfRZ0cUll5tGh7pjHxpWCC/Iyz/
 PhLM=
X-Gm-Gg: ASbGncvimUFs8kgoyDs88X2e/KjTrKF7+R8cQo0+Z3As/wr49LIaAt4eiu/fkWhT916
 4/svI7OT3QVSV/qeD/roV5w42SfSW5qw3RtpBMjuzUrUwh4j/XcEqXXTxcyMWYdHXhSGFaz7mTw
 NgiTpcq8wk0w19vvJADpsMZ0kMSxqoa6Tz5d7vFRpidtf5dXDIDDCJ/H17CoBZFT0gFGBhHp32v
 NA7eVtS/e4ORYhefVnFtuGMoJJF4Oq5m/OfQ5ENIiq43HE7QRgln79QuCdnrkHK6MRPoE9XP1nt
 HkCCxldrqVNxKNVFm2NB1J9n8CgmyHMIEF804F4r
X-Google-Smtp-Source: AGHT+IGTptIceRjAxyTX2FKxG69Z0atmLZhDjlVRkXVmilsAn2sBjvy7HHkao4bpmRwP6OnfTy6E4Q==
X-Received: by 2002:a05:6a00:3b06:b0:736:b923:5323 with SMTP id
 d2e1a72fcca58-74049261a39mr15380704b3a.10.1746336581216; 
 Sat, 03 May 2025 22:29:41 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:40 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 24/40] target/arm/helper: remove remaining TARGET_AARCH64
Date: Sat,  3 May 2025 22:28:58 -0700
Message-ID: <20250504052914.3525365-25-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

They were hiding aarch64_sve_narrow_vq and aarch64_sve_change_el, which
we can expose safely.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1db40caec38..1dd9035f47e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6566,9 +6566,7 @@ static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
      */
     new_len = sve_vqm1_for_el(env, cur_el);
     if (new_len < old_len) {
-#ifdef TARGET_AARCH64
         aarch64_sve_narrow_vq(env, new_len + 1);
-#endif
     }
 }
 
@@ -10645,9 +10643,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
          * Note that new_el can never be 0.  If cur_el is 0, then
          * el0_a64 is is_a64(), else el0_a64 is ignored.
          */
-#ifdef TARGET_AARCH64
         aarch64_sve_change_el(env, cur_el, new_el, is_a64(env));
-#endif
     }
 
     if (cur_el < new_el) {
@@ -11552,7 +11548,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, vaddr *pc,
     *cs_base = flags.flags2;
 }
 
-#ifdef TARGET_AARCH64
 /*
  * The manual says that when SVE is enabled and VQ is widened the
  * implementation is allowed to zero the previously inaccessible
@@ -11664,12 +11659,9 @@ void aarch64_sve_change_el(CPUARMState *env, int old_el,
 
     /* When changing vector length, clear inaccessible state.  */
     if (new_len < old_len) {
-#ifdef TARGET_AARCH64
         aarch64_sve_narrow_vq(env, new_len + 1);
-#endif
     }
 }
-#endif
 
 #ifndef CONFIG_USER_ONLY
 ARMSecuritySpace arm_security_space(CPUARMState *env)
-- 
2.47.2


