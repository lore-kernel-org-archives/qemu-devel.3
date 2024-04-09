Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291C1CD1299
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 19:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruHGh-0000dW-ML; Tue, 09 Apr 2024 15:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGg-0000d0-O9
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:30 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGe-0004fA-Jl
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:30 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e3dda73192so21587385ad.3
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 12:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712691385; x=1713296185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qu730y1a5bhHx8+lUgk6PRHwUAMG8x1kinVBmiKeHm0=;
 b=nxaagpPBYzpTx3yZRMSBsGGRkBaJHvUGLmVx7to+4cHY8oitsJ6bFJSNmqWji7fWEo
 nadJ80bqriMTJlTl+099JOHnp+4h6ERFWW4qCsnVArI/IRvnpt6isTuqoxzsr3FEDkI4
 F4Vlu7LjWE6M3UuRMIvqNqHN852hHHL6q3VHkO45+0SxILAkJxtGZi9WTFoL4+OfYd0d
 Vn2C7JB/wzeFMte3Gb0nB+k+cjE6nbnjgoDf9KoHpCV2JYxMm5oJukGOjrmT3I5wi8u5
 Eokh/HJ82oPzMuKjOEP5ASJ1Ju/sBm8/obz/TJKpq7P3kk0QVufmblC64FFudGsR8rKn
 mr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712691385; x=1713296185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qu730y1a5bhHx8+lUgk6PRHwUAMG8x1kinVBmiKeHm0=;
 b=KkExLiWQW5QcbHD9sxo7Om4cISxRRE81/6RXO/aTqflJqyrhjzr4dKfW8YHNeiXZBP
 RuzrIQjenjbBdrotBGUlAPd3+X3u0SrMsGor8IV9puE4nFNVAs6OtiJdaJ0IMF1dhGY4
 YpzyMEvYnCzC9pbdowZiEItwaIxIdD5g6Bh1v6TJyDi0JwVBOJNfbFIMkx8cevG5z190
 uxbPaoa2XttHsXKRxA83HKHYMKnZ4FLr1NFsY4n7CVtLe26s+V2x+O2/2Qe7QaLV2HHP
 c9/jPW9J1jyAiMyHRUfjgeuF79AI0UIaWbDm7YGNrp3QZ/EKLO8FS9vgkuhAC2Tkl/zj
 secQ==
X-Gm-Message-State: AOJu0Yx3aAUy9JiAfjuaueMQiFlnZJzsSBH4ltf2Wo+wgOjT0KA70NGP
 vN0mhm08vW8jHBQnny+q0GM0IedhmbPH46lLryW7mJbcSvRoY4fDZO1D/wLKfGn3VgWCDvUJid2
 k
X-Google-Smtp-Source: AGHT+IFCA9nugoJKX6ZcRyOTZrDdSJpkV5H9aDyOS7XWhdE8zDCPceL+HkGbXy65nHym6c+CsjxMdg==
X-Received: by 2002:a17:902:7ec1:b0:1e2:7d3b:353c with SMTP id
 p1-20020a1709027ec100b001e27d3b353cmr615668plb.18.1712691385219; 
 Tue, 09 Apr 2024 12:36:25 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a170902d49100b001e1071cf0bbsm6065843plg.302.2024.04.09.12.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 12:36:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 13/20] target/arm: Use insn_start from DisasContextBase
Date: Tue,  9 Apr 2024 09:35:56 -1000
Message-Id: <20240409193603.1703216-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409193603.1703216-1-richard.henderson@linaro.org>
References: <20240409193603.1703216-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


