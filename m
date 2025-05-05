Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BEAC3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC57H-0006VS-Cj; Mon, 05 May 2025 19:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC579-0006Nx-0U
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:47 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC575-0003br-OB
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:46 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b1fcb97d209so1567221a12.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487242; x=1747092042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tgtkzpe8JxmQvRJXZCyTrKxE1atR2TmNo3Re2v0+pHY=;
 b=gzxtM6bl9s9Y+GfPgs/YI7JRKO5Suf38BJVkDj5VhN47Ln5pTNh8Xf5GSIjaub/lnt
 x91FDm6mEUvzivi7HzGFY438BOkPAtFHUoXbVmI0Icyrcp2O4ts6pAUClXNSO5yW4fOJ
 5/dERi1d7keTMMkpzVOfhnnK4iopEw/2Fv3GvxupOvAJ7CMoZ5Svyu79yG3DEJ6fv3Qe
 fODckC4/VohwOB2C0K3QuVXkjPLZNQOgW9XMypYjyJIOI7y76vtMJwAIRbeHg1Wvoh1Y
 eyON6R3hESMwIKAK+TAlD2ZAn/hFXoF4ZclnJQ24o4IFXFd8k3newJfR/BHlfu8yofXV
 nqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487242; x=1747092042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tgtkzpe8JxmQvRJXZCyTrKxE1atR2TmNo3Re2v0+pHY=;
 b=OosUwrQGDx/KoUSORLccLt11SdHKeutMf9oYKywCl6lS0ZphTi2UDLijSBtW3BUhLR
 6Afa9tNEaZPnpQhuyWcp54yxa+3vojBSkp8hbbkTK1XSL4X7aUc/C7vcl+6xNSd86CFY
 87UZajbKzQCf/cN7J+RYCDZWXif6TNerGnUm9eSh52ppw+SOEFcfpAZH1MLfGkaUs+OA
 Cqg5bGvhtKV/OtdU8zI7+MTxM8pQBvn4jDkQXX6W1PzRm0ge9Zz/jDA9wTueqTVNywSn
 sIGDW3rGh48zU5P0mdHsTaxxy5hcxr43WwlSjNvw97aC9Ap7risrhPi8vTvddMgVwVmc
 JbxQ==
X-Gm-Message-State: AOJu0YzkyWLGCJHnbMJhP4pd9o2PueaJM+wtCqaBBV3IfdWPu4JwJgF6
 PbwqeY9P1bGsHZ0pk9i+vOUpN3oFxEgGXMsLoy+OzkJpKL/Mm4RV2B/zUAUlOGQaUaH+hZQs737
 malk=
X-Gm-Gg: ASbGncuCQGYoFhLfrTXl+uuw+ON5Hgmd43aSxsyWW8cazct7X36JShZ3zm56PHdEuZ1
 JgWMmovFv9BRskQsV8jF2830rd+ITALxxcLU7je7G6Rrq6mswQtzR5Cew/s4tRRebZll1bffFd/
 go33LPdj5ZU3B/jZsL4zNo4E3ogG0HtjBM9J4JTK8T4WXB8gXE0WsZe53piy+Nmqm4mQKRcYEL0
 ls2MpqdRjF9a4S2sGakX2xuB719am+E28iPppa/RF/sxrq34jEB3djlmVirYliH63KQJyBpIz48
 5X46QgbMLacuDmNI2sL7bMloMuJl1a2eCCqTb6kl
X-Google-Smtp-Source: AGHT+IGWkM8Y93kjIHnya9pzfJRAlQyMK/kyKFEpmMjkEHy8e5TjRZCSQClHRiEUpiFWdNLxftt7RQ==
X-Received: by 2002:a17:90b:544e:b0:2fa:3174:e344 with SMTP id
 98e67ed59e1d1-30a7bb28833mr2024932a91.14.1746487241836; 
 Mon, 05 May 2025 16:20:41 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 24/50] target/arm/helper: remove remaining TARGET_AARCH64
Date: Mon,  5 May 2025 16:19:49 -0700
Message-ID: <20250505232015.130990-25-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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


