Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D137C36002
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 12:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvbwi-0007jl-5Y; Fri, 21 Mar 2025 08:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvbwe-0007j4-6q
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 08:57:52 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvbwc-00030W-Lc
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 08:57:51 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39133f709f5so1040543f8f.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 05:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742561869; x=1743166669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AO+ZUcaKZQJk5enooplb2+PJUlk54AQnNwm/1pAm8KA=;
 b=rtfgn9Nl5uIkp+4zLVlcf5YjdrAnvN1R+i2ITaAPHfbkdzmZU6SQSCeaFS+S4fXqFJ
 DmNntJSQfI7L5rSXYYUMvji+odVceT4hwIsT0O2w/ZOlzXKgF54xW4zYnJmSTKeHGeng
 Vmo+FH5zrf6OvpBEy45R7Ae/4h43u9YvMxCnwGQf1K4hyfkK9cYMQdUdkGLRQmdmXqRe
 seXHzeYw/LcIZxzyPYeR/dehjYJBTHMPr9tIXGtaFTjdsg+WdDi2jT0Tgs59dzm6a7S7
 oSQICZwy0NMIys6U5Sso4LLZbDkC+/MSrqVuSVx0DuPDQEvgY20nLIl7JZvilGcAatSP
 +AwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742561869; x=1743166669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AO+ZUcaKZQJk5enooplb2+PJUlk54AQnNwm/1pAm8KA=;
 b=omPFoafBXtYCzFnRjsqh9LSlnqAg7rf3ozE6Ysug1P81DelshYCipQAq0V7CPzZ5nS
 kMFPNtMdg3PnA7WPGouogNCj3ToEg0faNZyZo9bEoNbmASTeCGp9FlGb9PEFmmzf31mN
 AnIY0pUZDAIg3Afrfcnru28wcC32zTA6mPbPJCeBCvgu806LhYDyhlBIc+mTTHG0gBEH
 6nVYorT44iLoOl5TDjOChLOffQ4kKubMyPH88iTBMf4WkAgD/Ww02Sy/4TaWQAmQN8HZ
 9vUSIst4vK5ibM4A0+rltuQsvChjtIRVd46ZhDxS9Nvjkqy8OAw631L51MBLaTqoQW0j
 rniw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWAeNSQQj10QjxuodMSxVjqQZ61abfPGeQRZqjxlHnrhfchptSCdEDGt/CQmLx4YxShhVHe6rN9586@nongnu.org
X-Gm-Message-State: AOJu0Yw4QPmXBEfBv79xsRwAwgVRrZHvuGTL7zcGPVn6XIE/0aExmdaU
 +47wR90Qq2P/Ctx2ZpJF7DvP+AE+a8LjtUq2UUTNlqXeYwTwounOMZkTVa/Jaa8=
X-Gm-Gg: ASbGncvmVSILoKDDCHsWOa7WK9qmtfsqczSMgzGvsQKfPUwKP8F5kJkmJNopY9got3n
 TiYYw19QDNtANQ880JKJ2PVzCb6mb6yUfUi0RRtYTRFO4+XXQhsakcUnBlX0xIXNr7UmaU4BIxF
 0MuhlI9siecImxw8Ap5NCFmB9jyuxU2uBS0f6zvP8VUjpWYzLLdD2WaYHUApWywQA/WA9aJ5Skn
 eHpzPXqdKU0h3/all1MPSFWMga072P8XRZe6DyfpeDuhTSeovmdBeof84IP8RIzNfdB6SfrTn65
 e279QQtbvfWLgVREvCGTPn8n+66uSh64iGPrkf0OG/0RRfLecZhiF3a343YzNWDjFVEDVkM30s/
 9/t/855lKfcnQsMA5CYs=
X-Google-Smtp-Source: AGHT+IHsle+wo+oiCId+CllSMw5ngir0xgOKJYSXwZ7yt9X4lRFZ+hPHHVdX/IonoUeJ9DkJN1MeEw==
X-Received: by 2002:a05:6000:156f:b0:391:ffc:2413 with SMTP id
 ffacd0b85a97d-3997f92d5ccmr3843398f8f.40.1742561869187; 
 Fri, 21 Mar 2025 05:57:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f55721sm77437695e9.20.2025.03.21.05.57.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Mar 2025 05:57:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 2/4] tcg: Simplify tcg_req_mo() macro
Date: Fri, 21 Mar 2025 13:57:35 +0100
Message-ID: <20250321125737.72839-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250321125737.72839-1-philmd@linaro.org>
References: <20250321125737.72839-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Now that TCG_GUEST_DEFAULT_MO is always defined,
simplify the tcg_req_mo() macro.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/internal-target.h | 9 +--------
 accel/tcg/tcg-all.c         | 3 ---
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index 2cdf11c905e..1cb35dba99e 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -50,17 +50,10 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
  * memory ordering vs the host memory ordering.  A non-zero
  * result indicates that some barrier is required.
  *
- * If TCG_GUEST_DEFAULT_MO is not defined, assume that the
- * guest requires strict ordering.
- *
  * This is a macro so that it's constant even without optimization.
  */
-#ifdef TCG_GUEST_DEFAULT_MO
-# define tcg_req_mo(type) \
+#define tcg_req_mo(type) \
     ((type) & TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO)
-#else
-# define tcg_req_mo(type) ((type) & ~TCG_TARGET_DEFAULT_MO)
-#endif
 
 /**
  * cpu_req_mo:
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index c1a30b01219..cb632cc8cc7 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -77,9 +77,6 @@ static bool default_mttcg_enabled(void)
         return false;
     }
 #ifdef TARGET_SUPPORTS_MTTCG
-# ifndef TCG_GUEST_DEFAULT_MO
-#  error "TARGET_SUPPORTS_MTTCG without TCG_GUEST_DEFAULT_MO"
-# endif
     return true;
 #else
     return false;
-- 
2.47.1


