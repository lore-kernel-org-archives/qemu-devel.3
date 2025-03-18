Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B18C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 04:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuOwJ-0001Wr-Py; Tue, 18 Mar 2025 00:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuOvc-0001F9-RH
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 00:51:50 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuOvZ-0008VE-8M
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 00:51:48 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-225b5448519so96013125ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 21:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742273503; x=1742878303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ff4if22Q9C7/aUOyimjBXuhprbDC9BPiONo3GzzeMnI=;
 b=CVCKwOWxOI+GKAhnaaDemskZWXf2KqZKrul6fqx8rnlJqSfmXnpLNxbc2IS2PohOLO
 b0AhXPU46foVqwedCYkitzvLD/grGmnqFOtKxQn3Krw4w6FPGAfmyVYtLUCuHdioPU3U
 8aNPowLdCO6hi81Wcj2MfbuHOQNEJWxG7vG8QnzE2sIPCajlPXK5gPKDmE/MOILUzGAy
 Af8NLN6bFwdMiQqIhDhZpZfFb30M9fjwVUydc55CWXvH9bSvzlERVpdvkWoMQis+FSJq
 Q53oiOWE3O6wE1YqddNM1zp2hd5JOtjNAp5/+6W+Am4N8Mhf2vEhpIZtxZCKfcNhGz5c
 HztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742273503; x=1742878303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ff4if22Q9C7/aUOyimjBXuhprbDC9BPiONo3GzzeMnI=;
 b=a4S3w4WrZWOG1KXbGpcM27SRxr/oh1ItUmu2zLYHvxqoY02MkZO9u8a6EtJjm9M111
 MjcsWi5bvpGYLZvI8323vD6Q0+mAPSvqQOn2zORoKvlN2+Rw6+bc6uh8u/cDIPF0KlqK
 Nlq2gnA3tnR0cyxLpfUJ79X/NXooida8l/2PNthK9AuTlopWhhazoEd3Xs+q3OYIkQ8x
 sq3/fN+NIT7UeIlld6YAQoNIBfepdJ4Cl6+l+IXxjB6UyiFVdzbdGYRvqDPZlYkdcZQF
 0VSnCiXIk1sm4J424gnoTgvULXGmAivHIF51FBfGnrK6YVvp40MW9SNhTMwjdjsmKS8E
 6NwA==
X-Gm-Message-State: AOJu0YzdVp780dzxSLgtB7nKfPRhkJjfmLJINsCxrmav2bMkH9t5nNRt
 JS6yAQoQhMX91M4rzzSPfkY7aNZQNbqMprWh6q+dnU0mVqDM5aiRNsCDOLzg2L7TXDrS6gNnkCz
 h
X-Gm-Gg: ASbGncvid34Lpxn9J7tHbttQi4aJaO3MGAusJAX7kwprXcZbWROb6jJa8c73oUKSAWi
 nTPN6cHzn7LZc2CWx0+fv2M/QLyTTqaRnE+0hGh1DaEAloXdamJySE3+6nZBA2aDaFS4M1BtpMM
 P9JUEcvBO9djPGiKlJCQ2hwp7XW07fpqQNp2bGZ8VtfW+WsLIUV94rG56DTAszA86o2I5FMldWo
 dZ/c+F6c+w4FntWsLF2IFfzDfRerAXurH1IfCXQQEc10lr9nmSklK/tTjli/DU4Hj3mX2Z+bxUZ
 OWsIaRktYu+ZbnoRtAvazqLqSYpMv4wHNiAAih7hdGuh
X-Google-Smtp-Source: AGHT+IGwUIS/3wXKGJBQGhbVlXqqVjdKfsJ7yt0C5ebmRfs4P5+hmmLEk6TOEURFfJtw+igxyOPO3Q==
X-Received: by 2002:a05:6a20:244a:b0:1f3:2e85:c052 with SMTP id
 adf61e73a8af0-1f5c1327783mr23658501637.35.1742273503447; 
 Mon, 17 Mar 2025 21:51:43 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711694b2csm8519195b3a.129.2025.03.17.21.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 21:51:43 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 11/13] target/arm/cpu: remove inline stubs for aarch32
 emulation
Date: Mon, 17 Mar 2025 21:51:23 -0700
Message-Id: <20250318045125.759259-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

Directly condition associated calls in target/arm/helper.c for now.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.h    | 8 --------
 target/arm/helper.c | 6 ++++++
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 51b6428cfec..9205cbdec43 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1222,7 +1222,6 @@ int arm_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
  */
 void arm_emulate_firmware_reset(CPUState *cpustate, int target_el);
 
-#ifdef TARGET_AARCH64
 int aarch64_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int aarch64_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
@@ -1254,13 +1253,6 @@ static inline uint64_t *sve_bswap64(uint64_t *dst, uint64_t *src, int nr)
 #endif
 }
 
-#else
-static inline void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq) { }
-static inline void aarch64_sve_change_el(CPUARMState *env, int o,
-                                         int n, bool a)
-{ }
-#endif
-
 void aarch64_sync_32_to_64(CPUARMState *env);
 void aarch64_sync_64_to_32(CPUARMState *env);
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b46b2bffcf3..774e1ee0245 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6562,7 +6562,9 @@ static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
      */
     new_len = sve_vqm1_for_el(env, cur_el);
     if (new_len < old_len) {
+#ifdef TARGET_AARCH64
         aarch64_sve_narrow_vq(env, new_len + 1);
+#endif
     }
 }
 
@@ -10646,7 +10648,9 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
          * Note that new_el can never be 0.  If cur_el is 0, then
          * el0_a64 is is_a64(), else el0_a64 is ignored.
          */
+#ifdef TARGET_AARCH64
         aarch64_sve_change_el(env, cur_el, new_el, is_a64(env));
+#endif
     }
 
     if (cur_el < new_el) {
@@ -11663,7 +11667,9 @@ void aarch64_sve_change_el(CPUARMState *env, int old_el,
 
     /* When changing vector length, clear inaccessible state.  */
     if (new_len < old_len) {
+#ifdef TARGET_AARCH64
         aarch64_sve_narrow_vq(env, new_len + 1);
+#endif
     }
 }
 #endif
-- 
2.39.5


