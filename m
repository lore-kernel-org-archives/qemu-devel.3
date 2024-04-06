Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A4CC67861
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Apr 2024 22:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtEaq-0003M6-55; Sat, 06 Apr 2024 18:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtEao-0003Lo-EE
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 18:32:58 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtEam-0006fN-Uv
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 18:32:58 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2a2f6da024eso1848124a91.3
 for <qemu-devel@nongnu.org>; Sat, 06 Apr 2024 15:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712442775; x=1713047575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2L2/prB0ux2ctNxoqiiUKt6ospzwwfXyvGcwqxEj/VU=;
 b=TnslF/4kyHI0TtRj0726QWUwk3l01jJsj8h34GOmnf5CnnKzS2CMGc2MHA2FxhVDu6
 ZqVR3TQgpCv3S0yNXlcpm5QeBQRQGYLC484TVjkZ+ONuGdjPZUJP2AiWUYX1ZcPrvaFG
 D63qawqB+lxsUn/cXhqjqzwMjNRid1YOgCtu8RWvFInWAMA+UR0zlurzUvpvVv6N6B7W
 LmDgXQxlrkzynOin5kllDW+8bKqZ/kI7nTp9/NHyIRltHzbKw5ZaJJGcw8hJips3lPne
 GLYtUm+jv806kak7KML9a38iyVS2kQb5Z4IKOEOyGHiKgNfpiEPQnzxnunznouuC0ojH
 Q6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712442775; x=1713047575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2L2/prB0ux2ctNxoqiiUKt6ospzwwfXyvGcwqxEj/VU=;
 b=DCyuKlhxaKcC/yAL5VrLbKP0Rq0150R2uMR/dIC/eNFIIISw2cSrJgRCuFmFpUtkeb
 Lh8Kc7RDayNf5zzv4U5bU8OOskl79fF3gAgaYXjMknPw77eZf50KLon6UoKZZcnzhfcb
 0Cz9WrAVAv2y2SC86qKu0rON8LpDtD4TrVVupE109Za0V45utsty/tpLR97ANBTuP/6K
 IFBB32XOflK6cEhq/jwTooQHwjt5u/3dye65f2MeqwwWQUR1Bsg/Pt3htecYAXLYtBAv
 e8SVk6MgHwUlXs93u4+msChvKSM7hzjHFpITUs2sBajUPuixSK5cakeZR1Apr6JAlUsf
 2ldA==
X-Gm-Message-State: AOJu0Yy0XC8aItKtlwdcdNKp6KAd4PERYGooj4cpr8ugzh2gYE7xbo50
 HGYHVFBiHtbhnhUMOHWveRc8r47MciTRHAkTEURIwI0cZZHmxw4dssTs3AriMJlYZyHMm7Gea0Y
 f
X-Google-Smtp-Source: AGHT+IGDChcSyXOe/krl7Jt6OrrMbxdy1DnpqVL6nLsJh1dU/15hj84F26u8LD5cGAiYd07pEisvFA==
X-Received: by 2002:a17:90a:df10:b0:2a2:9b12:da04 with SMTP id
 gp16-20020a17090adf1000b002a29b12da04mr3882477pjb.3.1712442775469; 
 Sat, 06 Apr 2024 15:32:55 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 f23-20020a17090ace1700b002a20c0dcebbsm3643279pju.31.2024.04.06.15.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Apr 2024 15:32:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jorgen.Hansen@wdc.com,
 Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
Subject: [PATCH 2/9] accel/tcg: Add insn_start to DisasContextBase
Date: Sat,  6 Apr 2024 12:32:41 -1000
Message-Id: <20240406223248.502699-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240406223248.502699-1-richard.henderson@linaro.org>
References: <20240406223248.502699-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

This is currently target-specific for many; begin making it
target independent.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h | 3 +++
 accel/tcg/translator.c    | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 51624feb10..ceaeca8c91 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -74,6 +74,8 @@ typedef enum DisasJumpType {
  * @singlestep_enabled: "Hardware" single stepping enabled.
  * @saved_can_do_io: Known value of cpu->neg.can_do_io, or -1 for unknown.
  * @plugin_enabled: TCG plugin enabled in this TB.
+ * @insn_start: The last op emitted by the insn_start hook,
+ *              which is expected to be INDEX_op_insn_start.
  *
  * Architecture-agnostic disassembly context.
  */
@@ -87,6 +89,7 @@ typedef struct DisasContextBase {
     bool singlestep_enabled;
     int8_t saved_can_do_io;
     bool plugin_enabled;
+    struct TCGOp *insn_start;
     void *host_addr[2];
 } DisasContextBase;
 
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 38c34009a5..ae61c154c2 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -140,6 +140,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     db->max_insns = *max_insns;
     db->singlestep_enabled = cflags & CF_SINGLE_STEP;
     db->saved_can_do_io = -1;
+    db->insn_start = NULL;
     db->host_addr[0] = host_pc;
     db->host_addr[1] = NULL;
 
@@ -157,6 +158,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     while (true) {
         *max_insns = ++db->num_insns;
         ops->insn_start(db, cpu);
+        db->insn_start = tcg_last_op();
         tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
 
         if (plugin_enabled) {
-- 
2.34.1


