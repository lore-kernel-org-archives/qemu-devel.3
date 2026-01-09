Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48791D232DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 05:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve56n-0004Zk-NZ; Fri, 09 Jan 2026 00:32:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56k-0004Os-J9
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:22 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56i-0003jE-Q5
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:22 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-bde0f62464cso1959670a12.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 21:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767936739; x=1768541539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zSL3i7ENCU8ltHQXwRd7u1MvgH8wQpDj3Y7z7SG9ZmI=;
 b=ky8HiAza82ha2Mh0aSMZPjDPuAUC16c9AfPHXlBsF0anjkRng3lR5LVjKcHscISn7z
 Fmrd25nCgSfa4KJXrs6esCqRRK/2SoYH2LlYogbuLo8obF3d9BfbDJLYdtbGbL04LEi0
 +Lj098/Ob9/TD/m7M7Ab/pdPnE/Y54wQXAM0zkjp9oIkFRuhgFPR+YYFMr1gloSE7mqI
 0oyTIZM78243Czbe80EoAXbSDKr8miX+ldddG8iyXc9cqFFReH78AUDpFqUGfSzuGJcZ
 2x/HvGp5JKX5YKHb5QbqE6XOj5yfFb6CbrFSIo5NuJIK+Yva8/QrFN6/Za/tTn+dugxw
 DXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767936739; x=1768541539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zSL3i7ENCU8ltHQXwRd7u1MvgH8wQpDj3Y7z7SG9ZmI=;
 b=r8y/tdMh0NyenlCAP/sAVEeSYlwJGnKN8QFvCL8iBh5/D21e8/xyiiJ+fThswIZHMM
 /BepolXXYGAfCru5ATsB3glgTp0sZREWRtOvGv548VFK1S+Z4v/Ej8vUM9BRV8ISGpzn
 9L9MnheYZJ2oGBoJ3JyiU2asYCKy/NkEVsomjAl5Irt7pmBvAOr7SMoU/z6YqmDOkwte
 daAWqQ1oBiyaGhyDANpuBJrZWwWpzmKUYUNy0Fag5xQyAUu1ZD8vDIVU9R/nrajalFsy
 yl1pkQrKSBpGOTLJRveURgEN/pCqCe2q2Dd9ZyHELrfuhjvHbACgmVCSlmO66CDf7xAx
 2KXw==
X-Gm-Message-State: AOJu0YyHqZMo5k71SaLH5pRNAmgYnwF+m/DcD3fr4xLlNVBBDPfbFFNr
 O982RpilFaStZDHGhbLgkOFryw5XOdgnZnl13Ml+YgKXUCjOfLK6paxZYT5lxu1MM6f8BtJdDGw
 /jDWP
X-Gm-Gg: AY/fxX6TpCD9WXa3LSUwE3vh1tcqEprKXkd0NiDrYsRNG7fXmWYIlbONl4va54ROKo9
 cnVQku+SU5R4QpCGHgv1HDl58MmuRymIpzsrXXHujBblpSy2TFluCdxsFBtLdohqCCWmXUPoyIj
 +DvpFHM7hM2zId83SyRl//JXGAFefPrcn1+C/De0zfjzUUl8x1MDBgU+A7gjSglqG1Lu0m6Q9aU
 UI2GrJqLSiZGxFsOQRvNqLVYpp1Buk7sCD0vEzJiJ1W5+v9ax2WFHjtqtgPT6LvUjjye5yvgpo+
 jJZjStoKUf5jLklr3CspT8XPMPFBFwtKHXwvS38/yQ4fVoMEGcajPl28tDobcCelS6rkAbSiaHJ
 /UGtI0Nf38X2A3BwSoSa1O/B9KdpIztqK9b2De81vkAajJoZxQRqBHP1s239E4MchC6QQkOlAUe
 weyGqCjKGBi1Gqj/9ovC2IEBx0ixvRpjdoqKLUQuYcFDwrVZQZbe4yD8u/MPg/Fvmd
X-Google-Smtp-Source: AGHT+IFRvkqy2QqFT+IttBCA9qtf8ZPVq6AqHBFZeyvBI/tjP7Xv7u/PsMKbIl2xLEflnO9B/cS28A==
X-Received: by 2002:a17:90b:1ccd:b0:32b:baaa:21b0 with SMTP id
 98e67ed59e1d1-34f68b4ce91mr8678451a91.6.1767936739308; 
 Thu, 08 Jan 2026 21:32:19 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa93f30sm9260137a91.5.2026.01.08.21.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 21:32:18 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 16/29] target/arm/tcg/translate.h: remove TARGET_AARCH64
Date: Thu,  8 Jan 2026 21:31:45 -0800
Message-ID: <20260109053158.2800705-17-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x530.google.com
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

We need to stub a64_translate_init and gen_a64_update_pc.
At this point, we don't need to do anything for aarch64_translator_ops
since it's just an external symbol.

We can now include target/arm/tcg/translate.h from common code, since
all target specific bits have been removed, or can be specialized with
specific defines.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.h | 10 ----------
 target/arm/tcg/stubs32.c   | 17 +++++++++++++++++
 target/arm/tcg/meson.build |  1 +
 3 files changed, 18 insertions(+), 10 deletions(-)
 create mode 100644 target/arm/tcg/stubs32.c

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 12319c02080..f12430c2637 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -357,19 +357,9 @@ static inline int curr_insn_len(DisasContext *s)
 /* CPU state was modified dynamically; no need to exit, but do not chain. */
 #define DISAS_UPDATE_NOCHAIN  DISAS_TARGET_10
 
-#ifdef TARGET_AARCH64
 void a64_translate_init(void);
 void gen_a64_update_pc(DisasContext *s, int64_t diff);
 extern const TranslatorOps aarch64_translator_ops;
-#else
-static inline void a64_translate_init(void)
-{
-}
-
-static inline void gen_a64_update_pc(DisasContext *s, int64_t diff)
-{
-}
-#endif
 
 void arm_test_cc(DisasCompare *cmp, int cc);
 void arm_jump_cc(DisasCompare *cmp, TCGLabel *label);
diff --git a/target/arm/tcg/stubs32.c b/target/arm/tcg/stubs32.c
new file mode 100644
index 00000000000..c5a0bc61f47
--- /dev/null
+++ b/target/arm/tcg/stubs32.c
@@ -0,0 +1,17 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "target/arm/tcg/translate.h"
+
+
+void gen_a64_update_pc(DisasContext *s, int64_t diff)
+{
+    g_assert_not_reached();
+}
+
+void a64_translate_init(void)
+{
+    /* Don't initialize for 32 bits. Call site will be fixed later. */
+}
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 3b501df7425..b09957195f5 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -21,6 +21,7 @@ gen_a32 = [
 
 arm_ss.add(gen_a32)
 arm_ss.add(when: 'TARGET_AARCH64', if_true: gen_a64)
+arm_ss.add(when: 'TARGET_AARCH64', if_false: files('stubs32.c'))
 
 arm_ss.add(files(
   'cpu32.c',
-- 
2.47.3


