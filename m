Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D150C54E67
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Mar 2024 01:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlJJ4-0002rY-38; Fri, 15 Mar 2024 21:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJJ2-0002r0-1A
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:57:52 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJJ0-0000lG-FA
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:57:51 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1dd9b6098aeso20337085ad.0
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 18:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710554269; x=1711159069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r3h8QUtdpv2Bkm8l3PLViSF5XzQ3nzd/ZWsA5m75Pu0=;
 b=gmN2AxlKeiDcACMGGZv+zBUn184OKaH0coHm2iMLsCyVdUGFV8LArSGq294M3/o55U
 JHG4PGTLG2blXtvb74J+2JeagaCP7o0C0qtVCSU21qnQ30khwQpI9tDv6xsDioY979vF
 WUuup9OH5ewXoriu44/q7y4f25U0czW8YnLbQMPdTrTQD7jZ7Fd2zpX/rzT11pPXSKDh
 BAaizdSUpdYBzbbPvQJQqeyKHc/iYAf0/iHitkl4TxVmMrHFAH5lUe0IQojL/2c0dlKw
 34eVwcJeLvxJXpo3ITr5m4Hn0x4gCfnb5hpTEnKegRp9ZBwxqY9/NkckWJRWPRDJV7q5
 dbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710554269; x=1711159069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r3h8QUtdpv2Bkm8l3PLViSF5XzQ3nzd/ZWsA5m75Pu0=;
 b=vVF/j5GtNOfDSx8UhSQs/yhOyC8hC2j59/oOqt168nC9vHmnupZFwxH4NqB8zF0iKl
 Xh4KZA2mbzRPq9V7u8TXMXaaFq8Y6Y/tJlcga3bFTK++dOhoMiL+22rZh/9eBBTnBWTO
 glCakQp/D5RCiCFJLFizX3jIR9krvq5+iCJgDZo9Cqf+CQGGoVhtgx9HH+KnOqaxTE0V
 qPgaQ/KVcR7CV5OdDjNkhDTSU4+nrwpgAf5Mlg8JdvIvwfCDEVn1jf3abxxLkP9TPoL+
 xMPOgu2XB0dWhITtHOKZdDmK3GEnKo9YmYaPTHfgFf/OV/cKpguSF5ONFE2zsUbZ6RPj
 03Bw==
X-Gm-Message-State: AOJu0Yx7QSUYXpoupxPfpegOldSj+gDOy0ixyAyBAZjZHkKuRksB97I1
 66dm3d4j3lEbnxbpbDoC9YEE+UBbn2intxc9ZOW/rq8+IlMSpi3Xxnjl/m4Xp2UH4JHStcoVYEb
 T
X-Google-Smtp-Source: AGHT+IE2rTUxv5BPmAqFPrYqJMHMJNyf3Fzd7ZxRv+oqlunUcrQiThcnv4gMv4vm6zdSiU6hh+DNJQ==
X-Received: by 2002:a17:903:187:b0:1de:de58:2a55 with SMTP id
 z7-20020a170903018700b001dede582a55mr6684883plg.26.1710554269156; 
 Fri, 15 Mar 2024 18:57:49 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a170903228300b001dd42bbb08asm4592985plh.253.2024.03.15.18.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 18:57:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH 12/22] plugins: Remove plugin helpers
Date: Fri, 15 Mar 2024 15:57:10 -1000
Message-Id: <20240316015720.3661236-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316015720.3661236-1-richard.henderson@linaro.org>
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index be7fd548cc..b5261edc38 100644
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
 
 #ifdef CONFIG_SOFTMMU
 # define CONFIG_SOFTMMU_GATE 1
@@ -88,21 +83,6 @@ enum plugin_gen_cb {
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


