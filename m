Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFECFC98315
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 19:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhYb6-0000kQ-Rv; Sun, 18 Jan 2026 14:38:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhYa4-0007FD-3y
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 14:37:08 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhYa2-0006to-MJ
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 14:36:59 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43246af170aso2010993f8f.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 11:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768765016; x=1769369816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=clmUza8l1GwtG34+YXHZaXD4EgmAbnoa/13LIvHiXg8=;
 b=LVAKx7lxT1pSpdo46JuVyDWs1+Wn+VP+Ups5efHZarDKUj39XYUdcnP7xrL/O1D84c
 +lbj0BmuN/vvW8y+wHiRiUEKZggI+jzVL+a+KRoBq6Of0k4kdEHrnpTR4wx6QYSpuKwH
 OpuS9i+XAFJAeVkfEqhKk6luvEKX5hCszftzwYnBt/vOVw6XpswfUh7yBRfMXepMP1VQ
 LdISd+k25QlqOu/lUws6HyapsP+1owObVtCb1K5GswTPBHdPTSL53+XkUNVHRmukaMOc
 NexxwePjV3jZYfMSavZewGKrA51D8qL8TqVbCa4Zzi2En4aaZ+hU1Su1xwwXKTi/Tk4C
 Nn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768765016; x=1769369816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=clmUza8l1GwtG34+YXHZaXD4EgmAbnoa/13LIvHiXg8=;
 b=dNSnQUG7bX9u6I8KmwJnkwDjDgwBJ4Jg7hxCgyr1nzQwI+0uSilFFgS5XRzn8Suh0Q
 /GD1W+3KLqkNqs+OYUgJB48md7syxzGYaZ0aK2gJloHBLpkzaSueC9mg7IPwufa7tNZr
 IhUpIpcKYZNXHr834PyhsZHkDK7EpO5NyctAI0oDgzAvpHe9lAdthNStECS5vp58eSGD
 KnqpSfyvLIBjyVy8bPUmCfFIBCqwYu6hHCvAj0RW6/02XAfz9Q5Tv3n6SWP6lkPYEPol
 amAJ5piJCQMky8227yOw0Qieccj/r+CxloDwbRYZXuo3arnTLz2Ikiq2HukNl002QJkC
 9M3A==
X-Gm-Message-State: AOJu0YxVOBAPLwwBl67YUzJJRvEj2yptYy6IhHNClL0rnxhmfOcJuGJY
 2zbJ8pqiCgqAgx09ZufJqMqqZtsqwFkpLIB82XiC03g+JFGWQ3VMKOlNzGqFVaQGMpbkEKiI0nm
 pMNtdi1Y=
X-Gm-Gg: AY/fxX4xyQxF2hVYDX3xHeFcwEAug7MyMbwLTLf+vK6dq0gMCm2OqXR+dYZ2heEGiTT
 WB8RkWxtAEwiKmH3YDW/LnC+QYlGH5JUNaBcncsb+T7kt6WN+RNWEQLNwDnCrYp20Cu6Tg3br8r
 EZ5mmA6AExhrFoEy6SWGG0/SSa5gB4av6yje6yJe6bjcGQzoqWCKcOJZPtFB7gxPRHfURkI5HQu
 UgSyjsaE1hFUz4xVsukPxDzFJAvubywa7Uq59BmW7sL6FSZKeI2MKKYujuqjI4UehqrtdXQi8iD
 RexpGJ4EQbjBphHUVr3796IFXLA0P6GcmPYlUKKN22LlUeIUdQCbFP4vX/R0CrNoW77N5fhX48Y
 4iNxZk96qJUWSXay/p6ZzJ1u1I/GwbpwzCE0XY7xatAgc9/oUoL4R19smdB1+pYY1Yz/pHousOD
 vka7C1dmJrb4vIg8K9RiIRh5rFvV7r7IYrlxtSKHTBb5jagj+/Fs/yGFaqVCBUPYiIuBbIuRE=
X-Received: by 2002:a05:6000:4023:b0:431:8bf:f08c with SMTP id
 ffacd0b85a97d-43569565221mr11581204f8f.21.1768765015859; 
 Sun, 18 Jan 2026 11:36:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435699980e5sm18606979f8f.41.2026.01.18.11.36.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Jan 2026 11:36:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 15/18] system: Allow restricting the legacy translator_ld()
 'native-endian' API
Date: Sun, 18 Jan 2026 20:35:05 +0100
Message-ID: <20260118193509.42923-16-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260118193509.42923-1-philmd@linaro.org>
References: <20260118193509.42923-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Guard the native endian APIs we want to remove by surrounding
them with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.

Once a target gets cleaned we'll set the definition in the
target config, then the target won't be able to use the legacy
API anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 3c326555696..8d343627bd9 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -188,7 +188,8 @@ uint32_t translator_ldl_end(CPUArchState *env, DisasContextBase *db,
 uint64_t translator_ldq_end(CPUArchState *env, DisasContextBase *db,
                             vaddr pc, MemOp endian);
 
-#ifdef COMPILING_PER_TARGET
+#if !defined(TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API) \
+    && defined(COMPILING_PER_TARGET)
 static inline uint16_t
 translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
 {
@@ -227,7 +228,7 @@ translator_ldq_swap(CPUArchState *env, DisasContextBase *db,
 {
     return translator_ldq_end(env, db, pc, MO_TE ^ (do_swap * MO_BSWAP));
 }
-#endif /* COMPILING_PER_TARGET */
+#endif /* !TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API && COMPILING_PER_TARGET */
 
 /**
  * translator_fake_ld - fake instruction load
-- 
2.52.0


