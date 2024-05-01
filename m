Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4B6C10F1A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 14:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2B6E-0002oC-QI; Wed, 01 May 2024 10:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5w-0002j2-Fu
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:38:04 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2B5u-0002Cp-VT
 for qemu-devel@nongnu.org; Wed, 01 May 2024 10:38:04 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1ec4dd8525cso14160435ad.3
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 07:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714574282; x=1715179082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nSa2977I3Rq8Xc+67Y2/yCKgEWXvHU4DRnUfHiUzUVE=;
 b=rsygncj/EIs54VAIMitaOr+b5vCZO0u/NZRd5gZ8lT/EO5bHydgJR75xk05soDnZUL
 2NPkbU5BcbWVS5MuZBL0uBzzFkzsxqvVqCY6YW3YUwN02u6uMEgTh9bw9QNZ4SYr1fvi
 SP/fPEY5dxgKAopcJZL9gIJwL5wH4aLZ/MrPn4gxXJBRciVoKSBGyR15FTGlLebOC3Kb
 sNtNMDtpcHdx2mGwDWjSwtjQDTn+K4GQR8MJWMfIp0VOtWaXsFS0IqOGxWXMWLCoiKcf
 W9Q4SUw7kI69swJAEPCA2WOmlncju1wnlLZlEBq1KzNWnrPhvn+bOMNGyHjWSo5H7NOH
 k2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714574282; x=1715179082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nSa2977I3Rq8Xc+67Y2/yCKgEWXvHU4DRnUfHiUzUVE=;
 b=mIsESqxKiGZR2cIlq4UGuM7t/4OROxu3Hvvf9jYaeAGOn/8G430B897BETXHkbug1C
 CFp94FDrttauD73UDeRirk5LKasYQb8qvmqMVFp0lii/MFWywtOyOqTrI72b9IeAnpu1
 iVSqeE7iIQd9L0w2tFIOgO9ga+uOVGwRTI0/xRyEGrI5wT757PeyHIWoRY9c3blEmSzM
 2aEbZ+cyfRo70fnyYs3espFcifQIWRogP4FKCEudkrS0LSNfj6HZ9VrQTOyyQULX4ap6
 0j2+90e2lShU1d8+8/c8yGtELJxFHNXnfm4bUo+H4AqlxKfwJjYtbVdnJbctNohV/yRd
 YO3Q==
X-Gm-Message-State: AOJu0Yxef6cxCbNs6cIg19OaiqoRn191XwZhBtemkbIagS4h2aSGaxkh
 8zCa1JAQFKoQo2Vjlj/CsUr4avMamOD5MAdzAw9WTqB2cmoMC+HuUoPqGx/WcAV/867CaS8p+aI
 t
X-Google-Smtp-Source: AGHT+IG3rrt57oezORmWHKV4ZjKep5JW8havgmDbFFXwwHckvoYCKrhLdWTc7wQxKW5DQyJanwpLZg==
X-Received: by 2002:a17:902:c185:b0:1e4:60d4:916b with SMTP id
 d5-20020a170902c18500b001e460d4916bmr2355319pld.64.1714574281733; 
 Wed, 01 May 2024 07:38:01 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a170902f54c00b001ebd73f61fcsm5751573plf.121.2024.05.01.07.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 07:38:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 19/20] plugins: Inline plugin_gen_empty_callback
Date: Wed,  1 May 2024 07:37:38 -0700
Message-Id: <20240501143739.10541-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501143739.10541-1-richard.henderson@linaro.org>
References: <20240501143739.10541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Each caller can use tcg_gen_plugin_cb directly.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/plugin-gen.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index c0cbc26984..d914d64de0 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -60,19 +60,6 @@ enum plugin_gen_from {
     PLUGIN_GEN_AFTER_TB,
 };
 
-static void plugin_gen_empty_callback(enum plugin_gen_from from)
-{
-    switch (from) {
-    case PLUGIN_GEN_AFTER_INSN:
-    case PLUGIN_GEN_FROM_TB:
-    case PLUGIN_GEN_FROM_INSN:
-        tcg_gen_plugin_cb(from);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 /* called before finishing a TB with exit_tb, goto_tb or goto_ptr */
 void plugin_gen_disable_mem_helpers(void)
 {
@@ -362,7 +349,7 @@ bool plugin_gen_tb_start(CPUState *cpu, const DisasContextBase *db,
         ptb->mem_only = mem_only;
         ptb->mem_helper = false;
 
-        plugin_gen_empty_callback(PLUGIN_GEN_FROM_TB);
+        tcg_gen_plugin_cb(PLUGIN_GEN_FROM_TB);
     }
 
     tcg_ctx->plugin_insn = NULL;
@@ -419,12 +406,12 @@ void plugin_gen_insn_start(CPUState *cpu, const DisasContextBase *db)
         insn->haddr = ptb->haddr2 + pc - ptb->vaddr2;
     }
 
-    plugin_gen_empty_callback(PLUGIN_GEN_FROM_INSN);
+    tcg_gen_plugin_cb(PLUGIN_GEN_FROM_INSN);
 }
 
 void plugin_gen_insn_end(void)
 {
-    plugin_gen_empty_callback(PLUGIN_GEN_AFTER_INSN);
+    tcg_gen_plugin_cb(PLUGIN_GEN_AFTER_INSN);
 }
 
 /*
-- 
2.34.1


