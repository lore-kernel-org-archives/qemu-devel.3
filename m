Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5280ECD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 23:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsWAV-00028C-Ax; Thu, 04 Apr 2024 19:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsWAF-00023Y-LC
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 19:06:37 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsWAC-0007lG-6s
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 19:06:35 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6ea9a60f7f5so1371809b3a.3
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 16:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712271990; x=1712876790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yq7gfhqzCEYtWciBbW30RRAKn3Q931Bk5u6D2pAF6UU=;
 b=VfeHwPPJiwnzKiBjfbW+AytV1ytBTL4sxpnd7g18S7o357PUa/QCmcowyKxmN2eZdW
 1bBwZYC4hxLbeG4vObg9IDL/84TVhEmBnBvRIzWxa3n+cUkJzllW1kPVSt5fIyMmlLEL
 5+kKE+IzyvFKjc3i3y2M+w5Ha3sKLL1KOVj0x6wrqgNzI4gRgDy1fzbrUsN5fUvp82Xc
 PEPV5sIKd8ut5rcDFvverTLrwflUpGATszsp3qeoc+I0lHsZHQ2ePHdxUY8Cgo2P20DM
 3Ba9ZljT4qiOdLQpHX048FqPNzPyX/vCedN5IH69v/Nt3fgKtWd5Aiq/i9NYO8x4B/VT
 x8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712271990; x=1712876790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yq7gfhqzCEYtWciBbW30RRAKn3Q931Bk5u6D2pAF6UU=;
 b=l0+MBcWbUscW/5sm2ghgSJbfZXtmjOS0xe+mLYb+oRewMND7gZEYSNHNONTIjZ99+4
 vCiqLdAUd4LZYJvRNhxssbQOfLDu5NNQaqzrU+LFcm6ecP3XUEwZJ8LMd9e1xiDVat4z
 HibNuE/BrNp2ZVSL7aQDX9/1qvg3UYU4AhQZgwclir32V7FB9XwfbQPNM8AVI+08hk6d
 Ege7PHQcVJJuf4JgA52gc9f0HywVML+zu1OKIoZ1ksrnb9ARPFCw3CZOylbfr7S7+vwE
 oqA3hAIbZ/Ce/qm903u5hqQ0zQbMPCxAcY1kWt5KRMddyvOlIiS5/AWpgwKOfmnFl0vG
 PaFA==
X-Gm-Message-State: AOJu0YyhZPy1kd183nmI46cpmhjp5U4Kj7snCpmH8pQ0ViuYvbGPxEbY
 1dV0ilJHYerdTNUdAazWHvxry0IT0TglCbpMQikRlGhNFr+6+LQOGAtaIzW5/nKpmBOnat9+0kl
 2
X-Google-Smtp-Source: AGHT+IF7n4GkF25d8N+JeNcvF0LWMB35isa6RVGcTKWDU/msTOvBHFfrrrwmsuPZSCWPzkvdm2dq7w==
X-Received: by 2002:a17:90a:c58a:b0:2a2:c353:7c38 with SMTP id
 l10-20020a17090ac58a00b002a2c3537c38mr3388116pjt.24.1712271989924; 
 Thu, 04 Apr 2024 16:06:29 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 q36-20020a17090a17a700b002a2f3cfc92asm1052592pja.16.2024.04.04.16.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 16:06:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 12/21] plugins: Remove plugin helpers
Date: Thu,  4 Apr 2024 13:06:02 -1000
Message-Id: <20240404230611.21231-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404230611.21231-1-richard.henderson@linaro.org>
References: <20240404230611.21231-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

These placeholder helpers are no longer required.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/plugin-helpers.h         |  5 -----
 include/exec/helper-gen-common.h   |  4 ----
 include/exec/helper-proto-common.h |  4 ----
 accel/tcg/plugin-gen.c             | 20 --------------------
 4 files changed, 33 deletions(-)
 delete mode 100644 accel/tcg/plugin-helpers.h

diff --git a/accel/tcg/plugin-helpers.h b/accel/tcg/plugin-helpers.h
deleted file mode 100644
index 11796436f3..0000000000
--- a/accel/tcg/plugin-helpers.h
+++ /dev/null
@@ -1,5 +0,0 @@
-#ifdef CONFIG_PLUGIN
-DEF_HELPER_FLAGS_2(plugin_vcpu_udata_cb_no_wg, TCG_CALL_NO_WG | TCG_CALL_PLUGIN, void, i32, ptr)
-DEF_HELPER_FLAGS_2(plugin_vcpu_udata_cb_no_rwg, TCG_CALL_NO_RWG | TCG_CALL_PLUGIN, void, i32, ptr)
-DEF_HELPER_FLAGS_4(plugin_vcpu_mem_cb, TCG_CALL_NO_RWG | TCG_CALL_PLUGIN, void, i32, i32, i64, ptr)
-#endif
diff --git a/include/exec/helper-gen-common.h b/include/exec/helper-gen-common.h
index 5d6d78a625..834590dc4e 100644
--- a/include/exec/helper-gen-common.h
+++ b/include/exec/helper-gen-common.h
@@ -11,8 +11,4 @@
 #include "exec/helper-gen.h.inc"
 #undef  HELPER_H
 
-#define HELPER_H "accel/tcg/plugin-helpers.h"
-#include "exec/helper-gen.h.inc"
-#undef  HELPER_H
-
 #endif /* HELPER_GEN_COMMON_H */
diff --git a/include/exec/helper-proto-common.h b/include/exec/helper-proto-common.h
index 8b67170a22..16782ef46c 100644
--- a/include/exec/helper-proto-common.h
+++ b/include/exec/helper-proto-common.h
@@ -13,8 +13,4 @@
 #include "exec/helper-proto.h.inc"
 #undef  HELPER_H
 
-#define HELPER_H "accel/tcg/plugin-helpers.h"
-#include "exec/helper-proto.h.inc"
-#undef  HELPER_H
-
 #endif /* HELPER_PROTO_COMMON_H */
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 8f8ae156b6..fb77585ac0 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -51,11 +51,6 @@
 #include "exec/exec-all.h"
 #include "exec/plugin-gen.h"
 #include "exec/translator.h"
-#include "exec/helper-proto-common.h"
-
-#define HELPER_H  "accel/tcg/plugin-helpers.h"
-#include "exec/helper-info.c.inc"
-#undef  HELPER_H
 
 /*
  * plugin_cb_start TCG op args[]:
@@ -82,21 +77,6 @@ enum plugin_gen_cb {
     PLUGIN_GEN_N_CBS,
 };
 
-/*
- * These helpers are stubs that get dynamically switched out for calls
- * direct to the plugin if they are subscribed to.
- */
-void HELPER(plugin_vcpu_udata_cb_no_wg)(uint32_t cpu_index, void *udata)
-{ }
-
-void HELPER(plugin_vcpu_udata_cb_no_rwg)(uint32_t cpu_index, void *udata)
-{ }
-
-void HELPER(plugin_vcpu_mem_cb)(unsigned int vcpu_index,
-                                qemu_plugin_meminfo_t info, uint64_t vaddr,
-                                void *userdata)
-{ }
-
 static void plugin_gen_empty_callback(enum plugin_gen_from from)
 {
     switch (from) {
-- 
2.34.1


