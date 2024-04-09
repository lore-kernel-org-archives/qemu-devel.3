Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603F4CD129C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 19:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruHGe-0000br-Sx; Tue, 09 Apr 2024 15:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGc-0000bf-Pe
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:27 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ruHGb-0004et-5d
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:36:26 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e4bf0b3e06so6927745ad.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 12:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712691384; x=1713296184; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7jtBLExS0tGWR2Q7Hyghjc2ZDJ4QMJ89vJLFL0IAkpg=;
 b=DE7+tfS1CW0d35m42dYOF78cC4Rxy9Gp4aOG1pi2/GYpIdTmMLh4r56c6O/XPoL0sK
 B8BG4vwx/tFFQ8FW9GhJhuH80q05gny+fhAguXplem1mgpsMxChUhK54Dbuzn6cN/PWq
 CKrE+JJ7BkYFGEd2VMdDTD1b2IdkwWa+U8lAYJmHW19R0MpIsauhBpMvIZrpE3z5QBha
 GaVn/HmO5uR27s2vUmWg9DHHmMb+tsMKpO+/PhKLHydhUoDJi5pqji16XRBBKyvxZOKa
 Qde+6xHGDRa0w9fYiYKRTz8jRGlFmfNX/t6kpMJBhZZ4CtNaJyHGzc3UywOcQ1Ypah8W
 ZjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712691384; x=1713296184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7jtBLExS0tGWR2Q7Hyghjc2ZDJ4QMJ89vJLFL0IAkpg=;
 b=IhZXXnIkjj80m8TjLFJSklvqwSiifJ+8rcEndj3Dc+5keiLdcWRYdQUX/qqJzKs4lf
 ty7NE2Q3ey+nXRrNtDXzMgjXhsNF2scTOSK91b5xPO29hGVyyEJpoU33Gm4gmPOkMzM7
 a5M0IR49Pm2qH0STF3FpEVoS8rAdA8j4gT21qxtbVQ9TxIYeZtpv28TqIjVNm+y2a4XM
 s65AWXHQBEGD8jcQ3/ecllWlZHyTGwMndCpNvo1S0lN6Olpo/iY3UEGzo9VxCK3z1xFU
 g0OVcBuWF20hqr2jv6VIfS3+HgzJkVxIJWMvzbxnNi8PTkBN1WHDSS8h2gYOqd2zUOLm
 YbVg==
X-Gm-Message-State: AOJu0YymX/vF1/XQUUlVGXGrgbJu+kxSaXVJ7vmzE2A+Yd0DFVGUK8jA
 lZDc8NSNC3p0vL4SLv4CIdHrZIf8zpwT9rSmeD3Wmu8gc07233+hOkSE0vEz5iY9vNHY1ZhSbNo
 F
X-Google-Smtp-Source: AGHT+IH5SOMUsH2RywfAizn+a7egYc7g24G9ldNDw0yOdAb3s+LCXy+b082BE49BI9f3kmORQArGUQ==
X-Received: by 2002:a17:902:cece:b0:1e2:61c9:85de with SMTP id
 d14-20020a170902cece00b001e261c985demr883385plg.4.1712691383985; 
 Tue, 09 Apr 2024 12:36:23 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a170902d49100b001e1071cf0bbsm6065843plg.302.2024.04.09.12.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 12:36:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?J=C3=B8rgen=20Hansen?= <Jorgen.Hansen@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 12/20] accel/tcg: Add insn_start to DisasContextBase
Date: Tue,  9 Apr 2024 09:35:55 -1000
Message-Id: <20240409193603.1703216-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409193603.1703216-1-richard.henderson@linaro.org>
References: <20240409193603.1703216-1-richard.henderson@linaro.org>
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

This is currently target-specific for many; begin making it
target independent.

Tested-by: Jørgen Hansen <Jorgen.Hansen@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


