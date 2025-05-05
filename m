Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A9AC369DC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl1J-0004n1-5O; Sun, 04 May 2025 21:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0s-0003xO-Ck
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:53:00 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0l-0002aA-Ho
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:56 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b061a775ac3so3730026a12.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409970; x=1747014770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tgtkzpe8JxmQvRJXZCyTrKxE1atR2TmNo3Re2v0+pHY=;
 b=KAjWhzSEX8Cae5OFgY9dnRxC1w7/oKTJQw6DsfvKthwPFjN4nFNhbyuVZpGtvKG6Yp
 xAsy9nyxCn4dbEcVlWdkpV8kG9nxlqBFNYvGYAFeB3zwMG/uGAd+kxHB9duQguChryJi
 oTC00kXRCHSPwkzXZNfRr6jvvXd5fTF6gApopga8qtvEgnvlHxj8u/Jw6qa+VznfbcV1
 BikxhRopTn5s2t8cePwF+b7jcHr3uD2ThjG0DLe39xAWlmnJJCy0Naa7BRekiPFqLjTI
 Smy/Fdn/rbAmX3jXfFdZ0gOH0QxoukRiOEedX5OH88r2dncS3er2EsJ0HzriEUr6peD0
 ImjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409970; x=1747014770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tgtkzpe8JxmQvRJXZCyTrKxE1atR2TmNo3Re2v0+pHY=;
 b=uzPX+eQgFcCF2LcCEF/1XkJ8HLi89Kj6pVbFrVro3hX7IEkeCOV3Et27UelGz1rfCI
 zlHqmE0SW/vFt+8kRrga+gt6XZJWeGLrOQWbHkCYSiGaqM9+0gBalcctUlom9fX1cdb2
 tHyihElqn7pQmIAHY2rTgAMoNAGtT+u4XXONLOcwKv8/vP+/n1mo9E3nTLHvoUq4ozJb
 bW3DO0YyXTeD9I5vahYE0W297hj4/HDKo9xIyFpLvoRfVM8wl5wMX45rgiygsg8YdLa1
 w+/XiMK/o/7SEMD//KBRsnjWfReFccLKigTnb9vKkG50afTVrv1O4IKEWhsXB4cU9skJ
 GGxA==
X-Gm-Message-State: AOJu0Yx4s1Z2wgCSm9RW7edNNJBJl4AyW2uRMCi/upKWEXU9BgPpADrY
 libnOeC6IJV+ZwwkNi2TaW+IGI12k/zsIplUxom7VG/z7KkBRyWhzq4Mz47gza0AJYtF3h1yFgF
 V3mk=
X-Gm-Gg: ASbGnctImB777qu3LRZ6RylcKWM5BAXjpbiWFp3vaJWvyfDMvGJKaztHBMG4B6/g8kg
 mKOCi3rwOj9zfOEj62WvNwW7htEuye8wDKJI+Bfc0dkf+nGgB/6e3FDDeHzgF5LODCaLSrB81NO
 s3tSDIf25eqCvzETEo9wx4IX1ABSUj/le6z66i9TBNpQWfNKAl/80ZdDfCPH+jKvTLnrj2vTrSA
 Z3iZ6dfxOb5uI/RnaImULuFrA12xqDTVu7klS6yoDHI8dz5/q88jdyH7xUwKPbkOziOLl3QUOo1
 gRcKRgZQ5s4Y2dMi7Sfwc8GJkdV+KtDGXxjxNUDS
X-Google-Smtp-Source: AGHT+IGhu4YzGN/5F6xNrrGQWE7WcyTSjX3jY7dpyCfW22wf11Z/aLnaJEKYbWVBhB6LZTzsmoKOng==
X-Received: by 2002:a05:6a21:9189:b0:1f5:8d30:a4db with SMTP id
 adf61e73a8af0-20e96205dafmr7605597637.9.1746409970184; 
 Sun, 04 May 2025 18:52:50 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:52:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 24/48] target/arm/helper: remove remaining TARGET_AARCH64
Date: Sun,  4 May 2025 18:51:59 -0700
Message-ID: <20250505015223.3895275-25-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x536.google.com
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
index 7e07ed04a5b..ef9594eec29 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6565,9 +6565,7 @@ static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
      */
     new_len = sve_vqm1_for_el(env, cur_el);
     if (new_len < old_len) {
-#ifdef TARGET_AARCH64
         aarch64_sve_narrow_vq(env, new_len + 1);
-#endif
     }
 }
 
@@ -10625,9 +10623,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
          * Note that new_el can never be 0.  If cur_el is 0, then
          * el0_a64 is is_a64(), else el0_a64 is ignored.
          */
-#ifdef TARGET_AARCH64
         aarch64_sve_change_el(env, cur_el, new_el, is_a64(env));
-#endif
     }
 
     if (cur_el < new_el) {
@@ -11527,7 +11523,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, vaddr *pc,
     *cs_base = flags.flags2;
 }
 
-#ifdef TARGET_AARCH64
 /*
  * The manual says that when SVE is enabled and VQ is widened the
  * implementation is allowed to zero the previously inaccessible
@@ -11639,12 +11634,9 @@ void aarch64_sve_change_el(CPUARMState *env, int old_el,
 
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


