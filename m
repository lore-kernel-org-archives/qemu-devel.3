Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1862C9830C
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 19:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhYb6-0000jU-LQ; Sun, 18 Jan 2026 14:38:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhYaA-0007KK-Iu
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 14:37:11 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhYa9-0006u9-5E
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 14:37:06 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42fbc305882so1969783f8f.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 11:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768765023; x=1769369823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GL8P56C3QKW+wYSnHUjfX38VQq1YNg4U4yN3Hx8cg1U=;
 b=YmW/PFD27jTpSY29jgk7p5cKJWBBx9KH0hbCEjm2Yg6qhSVUucBf8mZre7j6ACmdxC
 YAadl2r0iyGViiLsha7a13nHQZUbOSQqgfohCbTwn3WN0GCK9+UqeS0D1FMMnjz2QXrc
 KjfRKg0K3BLLxBYn07FG9GYWAxctGGE5IfpTxwMp4gt1zn5w+INbMpzGSUbYzsmKV6kF
 gzjRhZTSVV2ha/LFxRoSnhcERPamxv7kC5J0kvnHdfI860DYaf1uFETVqnfhML6Mjxhs
 MuE+FfqV7jGT8ZbAGA948JpoXRP/6KUFNTNQq5AmsUHdETLqwGCNEecVqjXGgKaMWg0I
 ZqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768765023; x=1769369823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GL8P56C3QKW+wYSnHUjfX38VQq1YNg4U4yN3Hx8cg1U=;
 b=vBj6Bs3lF0TTXnwtKB8FqaBBNbeHCunWo3xljvjDiE3rc8Aa1oW80i91mNmOoYoyX1
 kJ2pwRekjgqvH13HLmdnZwbrtVnKvKGRZqDd9UntEypIMLSPIfe59LY/cFVcxqK6Q7Rv
 vGmzWuox44L7bQ+JRP6rEHWe3poqB/PuWtbYl3H5HD6wn3q9i/Pn7R7dxG4MfCDRh6Ib
 oylJsSSsguXd+2VfTxM9TRIeFKNlDRBfE94N8EotNl/YrUepYgc1mLAocXlh/VwC3D2l
 g9v6Y7cqEtxi6kiUsCm8fQ2/9u7O2bty5AKJkAMNDQc5GHpX6JGgofY+UUNHcCHSG7Ev
 n4dw==
X-Gm-Message-State: AOJu0YyH4H+GCKGydvZxdXzhMFqpc6DG1V1GyVYq2dHy1yDBufzTfkXg
 eVrLZb0M2eJgCZRYQt5TMLhHqeS58x2dKS02ai0lCKYgO6toEoBdv2qvuJigKlc9HDh7aYRVX5b
 URHv7F9w=
X-Gm-Gg: AY/fxX799nVEDA1aVxQwhC5a9iX0oGTaIQHue9wJ1mx5NRcywkMB1NI0lNoFtpnGkLO
 rsZ0ginU1ijx/6I4Z2WrmSWgzVnpalM2XOhK0t0gCuiIoaI2DSi3VTbborwLMzliDz1rQGmB+pr
 YXScKZcFSW7kHQEDD5HzriL+6VtCoMjfv1n+mbvURDBWwmPw0Gg6Ky9IzLahN6X9YrpEb7lFsad
 pHXmTuM0oNd1rIbwEQTB77XIoL4M+MxWnyZv+nqHqMiGum5HCV92X6y52cRTmhGRKqGM6Kfgr3w
 1F8rJkLHelx73CBv14tRagAQGov2LtoyHAOEZDGGAFY0wcgQiGcv+/T92iKnVieZo6bz+yUe/dE
 dyzmtfOZZIrfbdais22wB39sRDg3Zxe8XEtiRN+hAWSJblDms6dJq7sDAwAU+hiD5kYUimGSX52
 +3E2XH6xSAPlMikr5+0PM79kZF76sRb1qqp9I/eb1nK8zEOBIk8UlV1jIZOgN/
X-Received: by 2002:a05:6000:22c9:b0:432:dfea:1fb8 with SMTP id
 ffacd0b85a97d-4356999c714mr13114348f8f.27.1768765023066; 
 Sun, 18 Jan 2026 11:37:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435699271easm18632425f8f.14.2026.01.18.11.37.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Jan 2026 11:37:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 16/18] system: Allow restricting the legacy tswap()
 'native-endian' API
Date: Sun, 18 Jan 2026 20:35:06 +0100
Message-ID: <20260118193509.42923-17-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260118193509.42923-1-philmd@linaro.org>
References: <20260118193509.42923-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
 include/exec/tswap.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/exec/tswap.h b/include/exec/tswap.h
index 72219e2c431..9e94fa0021c 100644
--- a/include/exec/tswap.h
+++ b/include/exec/tswap.h
@@ -21,6 +21,8 @@
 #define target_needs_bswap()  (HOST_BIG_ENDIAN != target_big_endian())
 #endif /* COMPILING_PER_TARGET */
 
+#if defined(CONFIG_USER_ONLY) \
+    || !defined(TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API)
 static inline uint16_t tswap16(uint16_t s)
 {
     if (target_needs_bswap()) {
@@ -68,5 +70,6 @@ static inline void tswap64s(uint64_t *s)
         *s = bswap64(*s);
     }
 }
+#endif
 
 #endif  /* TSWAP_H */
-- 
2.52.0


