Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7C5C67861
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Apr 2024 22:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtEas-0003N8-Gy; Sat, 06 Apr 2024 18:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtEap-0003M4-Uz
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 18:33:00 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtEao-0006ft-Ct
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 18:32:59 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2a2d0ca3c92so2115561a91.0
 for <qemu-devel@nongnu.org>; Sat, 06 Apr 2024 15:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712442777; x=1713047577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QQc6e5RogWeg+/QqEB/0KfIIQRJeLZXWsX6Xz7y/RG8=;
 b=okzOtzWWY9TyyLE+vDIzRbNyMb8tVFFm66dF6voACRkpHacdT0aELlWF9Urxn7mAZt
 D4Eq5qjp44bwle4NK/ddgVWssrsDv9U+Uuco+mHBVr93tOgM8PJxAFCKQfzGUeLXkA3X
 uY7RK6q3bJlhszJiLHTVk34YWOHaRBzLjlDjvz5LQugqLtaVjBX00uVVgS+eLdzrYQ5s
 909+w2CzFMs+WZpOsLWoeTX2jkk+OPmpb7v5I+MSs0F8wPi6ttv37RTDXR82InHP1AxC
 00PemL7qrLBBTmu/1RettFoEiGFF2MOGmNG6bdAq1gNUKsLfEQa8kfxQIdNOYOibBm1B
 WGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712442777; x=1713047577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QQc6e5RogWeg+/QqEB/0KfIIQRJeLZXWsX6Xz7y/RG8=;
 b=CYWF+ZVVgyoLzeZ3v9xDImLCndAgVqE5703sOpQT3NnXNH4RXtleQatf+EXE0wYJhu
 5aLqk2GGsE6TSpFiGhth5tdly36P3W3eExsEWlJzv4VrMggzARMyK06njgwXoO7B75bd
 kKMtOwjC768DYxS/E1ryvqM1klKehd638zxoJxXBm3j+UfKCH8Qw8TJuqOZ5vacW14ue
 0w3AL04jFNrkPPLlU7S/9mSx9wg/EJsPfhGYLTGF/5AYLIYk7UQAZ/fc8JlccXPmpPBg
 SZWE4nwyfv+oRowiG/j/hMyXK26aXyMT7EB82YOTSRDC04FmrNkUkVXFOI5pBi3m1Q7q
 fhXQ==
X-Gm-Message-State: AOJu0YxIhyrgED4kmgiy09/VNlu2zQm6bgIXNeAM80wC3qmtnY/rJ5tN
 u8BBIRqrQuEY+L39zf6v8ZU8Gl/99XNRQlQ/uB8TsrRbw05c0+yQOPiru2T9ijpKt7sreLC4jFd
 /
X-Google-Smtp-Source: AGHT+IHvglE+20EV14TIEcEtETBS3PRrO9IVFh74Usc8OZGns7hc9vLAHRrHFRw7/hKBktR7zvRXwA==
X-Received: by 2002:a17:90a:7c43:b0:2a2:f249:6180 with SMTP id
 e3-20020a17090a7c4300b002a2f2496180mr8207410pjl.18.1712442777063; 
 Sat, 06 Apr 2024 15:32:57 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 f23-20020a17090ace1700b002a20c0dcebbsm3643279pju.31.2024.04.06.15.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Apr 2024 15:32:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jorgen.Hansen@wdc.com,
 Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
Subject: [PATCH 3/9] target/arm: Use insn_start from DisasContextBase
Date: Sat,  6 Apr 2024 12:32:42 -1000
Message-Id: <20240406223248.502699-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240406223248.502699-1-richard.henderson@linaro.org>
References: <20240406223248.502699-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

To keep the multiple update check, replace insn_start
with insn_start_updated.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h     | 12 ++++++------
 target/arm/tcg/translate-a64.c |  2 +-
 target/arm/tcg/translate.c     |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 93be745cf3..dc66ff2190 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -165,10 +165,10 @@ typedef struct DisasContext {
     uint8_t gm_blocksize;
     /* True if this page is guarded.  */
     bool guarded_page;
+    /* True if the current insn_start has been updated. */
+    bool insn_start_updated;
     /* Bottom two bits of XScale c15_cpar coprocessor access control reg */
     int c15_cpar;
-    /* TCG op of the current insn_start.  */
-    TCGOp *insn_start;
     /* Offset from VNCR_EL2 when FEAT_NV2 redirects this reg to memory */
     uint32_t nv2_redirect_offset;
 } DisasContext;
@@ -276,10 +276,10 @@ static inline void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
     syn &= ARM_INSN_START_WORD2_MASK;
     syn >>= ARM_INSN_START_WORD2_SHIFT;
 
-    /* We check and clear insn_start_idx to catch multiple updates.  */
-    assert(s->insn_start != NULL);
-    tcg_set_insn_start_param(s->insn_start, 2, syn);
-    s->insn_start = NULL;
+    /* Check for multiple updates.  */
+    assert(!s->insn_start_updated);
+    s->insn_start_updated = true;
+    tcg_set_insn_start_param(s->base.insn_start, 2, syn);
 }
 
 static inline int curr_insn_len(DisasContext *s)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 340265beb0..2666d52711 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -14179,7 +14179,7 @@ static void aarch64_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
         pc_arg &= ~TARGET_PAGE_MASK;
     }
     tcg_gen_insn_start(pc_arg, 0, 0);
-    dc->insn_start = tcg_last_op();
+    dc->insn_start_updated = false;
 }
 
 static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 69585e6003..dc49a8d806 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -9273,7 +9273,7 @@ static void arm_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
         condexec_bits = (dc->condexec_cond << 4) | (dc->condexec_mask >> 1);
     }
     tcg_gen_insn_start(pc_arg, condexec_bits, 0);
-    dc->insn_start = tcg_last_op();
+    dc->insn_start_updated = false;
 }
 
 static bool arm_check_kernelpage(DisasContext *dc)
-- 
2.34.1


