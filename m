Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B8ED18157
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 22:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Te1-00030O-6h; Mon, 14 Oct 2024 18:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t0Tdv-000303-E1
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 18:34:25 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t0Tde-0001rv-B7
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 18:34:08 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20ca388d242so23040515ad.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 15:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728945243; x=1729550043; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Xk75/hfGdWlL+1Mc1jz1GSd3w6HecYRikmmbqffemEs=;
 b=J7e/Hp376KUyq7crvHVvfOWxST9wu5VLJV2l6gNDXsg6a28Nyo2ooLXNv5xtL6mIpI
 TgIyIJeeh1iqfvAyo7IZe7Z2NyieDbliU2GujgBBzBlepKkPWhobnKmLj+WgwQ6FcOgb
 RtN1Cyram/a3//6TsNX4y7js9rz6U/f6WH7feP7C47YbmWGpgcTv1j4C/83+ykB7OpU/
 iktKlE19p9egphtm6tVkxWQ71IZIQXH0rEWMalCqNDTIOoJJ49dDugzjhIbEFInwoUun
 0NMAil4zVnX1eLOImrKlZxgptyfDScg4PIC5mOBpB2vsduvDDB5aZEIJQWiFPVNRdGwv
 XyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728945243; x=1729550043;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xk75/hfGdWlL+1Mc1jz1GSd3w6HecYRikmmbqffemEs=;
 b=hjd+p4BYvCZaMXYAtrnBp/U8uv1+aaRreuxJLBAOJIfVNChDH2e0N/Dhq98nWM5Hwh
 Lpcc2Kq957FImkwLPeNUY/Jzs6dOYQK0zQP98hJxXkaJ1k+LWyqPdjTiBgPyp2xRIRn7
 Y2geu1R7w3l5F8bsT+ih3LNtnCKdvrp0nMIFzcn+ns+TGik0vUl8IBm1PgT2+6LWL2MK
 rkFYIuLtwWLU5HFSNp+wrC8XWleBH+k9UO0Fo2oSD+skOBmfEfVmbczHFBxkTNWVkc7J
 w8G81pMFgxn5y2/Qc/Zq1rlUR7r9VQuhAWLYTNYZh4Cd0cme9eoMRb4vI3EC/4nClSWP
 hiRw==
X-Gm-Message-State: AOJu0YwXfABH4TkEz5DBTnSAkbI6GILHL4l9bEfV4hop8w+1Yzj3QyB3
 ypb7hFovWW0vpr3gVwH89RgCl5AzBJ+9U7wRACGB77TqTrGaFgM9DhUpMfRYC6bV81AFYtLT1Cu
 EVkuC+VBi
X-Google-Smtp-Source: AGHT+IFR5/0EpX7kYhLce5Mq/e6nRr+zw6W15Cr92pDvTYxcwANExSvu3LUNs5EUP+9Sw8unZqDB8w==
X-Received: by 2002:a17:902:fc50:b0:20c:8c0f:f986 with SMTP id
 d9443c01a7336-20cbb1a91camr131945475ad.24.1728945242349; 
 Mon, 14 Oct 2024 15:34:02 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d1806c1c0sm267985ad.301.2024.10.14.15.34.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 15:34:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] plugins: fix qemu_plugin_reset
Date: Mon, 14 Oct 2024 15:33:53 -0700
Message-Id: <20241014223353.900481-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

34e5e1 refactored the plugin context initialization. After this change,
tcg_ctx->plugin_insn is not reset inconditionnally anymore, but only if
one plugin at least is active.

When uninstalling the last plugin active, we stopped reinitializing
tcg_ctx->plugin_insn, which leads to memory callbacks being emitted.
This results in an error as they don't appear in a plugin op sequence as
expected.

The correct fix is to make sure we reset plugin translation variables
after current block translation ends. This way, we can catch any
potential misuse of those after a given block, in more than fixing the
current bug.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2570
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/tcg/plugin-gen.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 2ee4c22befd..2a8c8b2ad14 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -467,4 +467,9 @@ void plugin_gen_tb_end(CPUState *cpu, size_t num_insns)
 
     /* inject the instrumentation at the appropriate places */
     plugin_gen_inject(ptb);
+
+    /* reset plugin translation state */
+    tcg_ctx->plugin_db = NULL;
+    tcg_ctx->plugin_insn = NULL;
+    tcg_ctx->plugin_tb = NULL;
 }
-- 
2.39.5


