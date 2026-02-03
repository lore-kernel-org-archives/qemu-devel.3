Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A953FE8783F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:05:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHxR-0000OP-Tc; Tue, 03 Feb 2026 10:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHxQ-0000Nq-DR
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:04:48 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHxO-0001Lg-TO
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:04:48 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43590777e22so3592428f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770131085; x=1770735885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tuRjC9GWhykhArGXENtPPp74AE8CygRAtcP+2Ych30U=;
 b=HwF6LNekjO/PddeXSIO5gMern5VCQ7e2iETSoos5NPuHHpit9sVeNfxcIej10qOEbV
 abwnerD11nnc4umsmLs5eAUGJeiPaJy6New13Tvh56wBsrKzQr6/PRe6g6IZ95q9IJ6c
 4I8O3isusPYJybrRDIZTTnnzekEsOriUi2wS9GCVSpWjfZM+p85L4d1YrVprbNWposKD
 UqyMLt+bZ5gmDH+wqGIniIVNUcx1ivwiVylog/tery+FCPDHfdVFbdi1Us3Cpt8Wcia0
 g5Da7CE/Kk7Dgf6Rsd2Xaa2wfoZYjf4dWzOp5ussn687eS4PuyxCq+oh8YOkTS2WKACs
 Xx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770131085; x=1770735885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tuRjC9GWhykhArGXENtPPp74AE8CygRAtcP+2Ych30U=;
 b=lF/4HlcQ8WB0oiP0v4FeyfbLbE0CIbVljaxk/7m8oryrPXsoMjBLfhRusv0/Z9sbmO
 xb1Q8COyAhPHze4JQo/ai6u/dOszungEpHpasZuO1xwPQfc+uEYExfqEEurfmLAfAZjg
 Nq45wrL+5RdqE4UyoMxjwWtGlYM+ymUPmFJMO+ctTJwu7p+81DPUfTvsjWXy7zvQpX3g
 weMNgF+t/xtd9VQg7vypGkNMSKmD2QAGofreXmYcYYxrOrZm8qevPE+TIQzPROkllZx/
 gmJhSC5FUCt3K76lMQIgb1QndkgxBnVvCTW3wfigmmJR1vkOyx9H7CoAB/Ungi1tkbei
 vy8w==
X-Gm-Message-State: AOJu0Ywl/26CPwjYNBDJEHO9pcf9VUOq/vaIPy1c7DGJ8DUsKMn4CdpV
 LqUd1j55wN0tMNzjS0bDLLU1hK3ODppEXgnJVyYUSkOxF2U5YTx9MNUKtwGIDg0Yss8j0Zv8xGV
 fC8mUIZw=
X-Gm-Gg: AZuq6aLc62WH9EA5PkAqnN0Y6Gyy6LNBWpY8t3cMHCsPezGLJOu6fAvJoNkPsyY9gqi
 0W5p3TM+NIcUhM99/+Rz8h/jLfphSTiqIiUauFMwkYeZRtyK+eM1Yf2yo3cNgWjQvAxRQqAy2Qf
 EBYxRQCcqW0uz5LY3v0dU2YKVU2ZpYRNVObCajLO+Njc6t1mJojREuDnYjW3O7cj8VsnvX6mCuV
 xhp/RbV6P+0FFEJBmtjtOfuShqBcNn6SYGGapKnxqR36/C8tQzrqrTqwv62MYem5wcjNi44k8XA
 b/fLMW5Uuzulmi9c3g6H9wY1rbcXOwAWdfRnGMym9c5rFTusvUn+JUiLOhn2cj6ZGbjqf3++CaZ
 0PVhvqy4BXxhWwQlG7gdru0pwdA1MWrv7apbk1dKi6SYPhfCWKV0sWETxe4UsUSoloyUsiSwP8t
 SyvGqlN6pv99g/TAXP5mbsAB9/LU1Yt3HrtR77WZCEuotxvagEweS2Z3TN5EkV
X-Received: by 2002:a05:6000:1a87:b0:435:9882:2342 with SMTP id
 ffacd0b85a97d-435f3aa91b8mr22989031f8f.33.1770131084759; 
 Tue, 03 Feb 2026 07:04:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edfe7sm51537171f8f.14.2026.02.03.07.04.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 07:04:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/30] target-info: add target_base_ppc,
 target_ppc and target_ppc64
Date: Tue,  3 Feb 2026 16:04:06 +0100
Message-ID: <20260203150436.71907-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203150436.71907-1-philmd@linaro.org>
References: <20260203150436.71907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20260131020100.1115203-2-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/target-info.h | 21 +++++++++++++++++++++
 target-info.c              | 21 +++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 62359622232..e3287334304 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -71,4 +71,25 @@ bool target_arm(void);
  */
 bool target_aarch64(void);
 
+/**
+ * target_base_ppc:
+ *
+ * Returns whether the target architecture is PowerPC 32-bit or 64-bit.
+ */
+bool target_base_ppc(void);
+
+/**
+ * target_ppc:
+ *
+ * Returns whether the target architecture is PowerPC 32-bit.
+ */
+bool target_ppc(void);
+
+/**
+ * target_ppc64:
+ *
+ * Returns whether the target architecture is PowerPC 64-bit.
+ */
+bool target_ppc64(void);
+
 #endif
diff --git a/target-info.c b/target-info.c
index 24696ff4111..5a6d7282524 100644
--- a/target-info.c
+++ b/target-info.c
@@ -73,3 +73,24 @@ bool target_aarch64(void)
 {
     return target_arch() == SYS_EMU_TARGET_AARCH64;
 }
+
+bool target_base_ppc(void)
+{
+    switch (target_arch()) {
+    case SYS_EMU_TARGET_PPC:
+    case SYS_EMU_TARGET_PPC64:
+        return true;
+    default:
+        return false;
+    }
+}
+
+bool target_ppc(void)
+{
+    return target_arch() == SYS_EMU_TARGET_PPC;
+}
+
+bool target_ppc64(void)
+{
+    return target_arch() == SYS_EMU_TARGET_PPC64;
+}
-- 
2.52.0


