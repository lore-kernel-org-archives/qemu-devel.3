Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CA8CF07BF
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 08:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syofL-0006D6-UP; Thu, 10 Oct 2024 04:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1syofE-0006Bu-4m
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 04:36:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1syofC-00075n-IG
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 04:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728549408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Y6ZhgI9A/PPL66uKE+bRh7ed0Z2uBOmJSzMOo3Ul9p0=;
 b=D5vCj/Hhi3NZAZ/D0UOO4jVVBWJj5e30DuOKKCfNs/L3oPIU+pdHW7sq1xylKclBHFYqJl
 6sRXVLxaYsJPxKeG9R6SXPO/KkiFXtC2yc7+uUkdGlSLNr+qmJ3nD7Hu9rhl5TAslhJP4W
 0FeoygMVpE9aekVNAcR2F7CXy2HwjQ4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-bxOlJhrxPAG1obiZKwE9Uw-1; Thu, 10 Oct 2024 04:36:46 -0400
X-MC-Unique: bxOlJhrxPAG1obiZKwE9Uw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5c938ae4152so346683a12.1
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 01:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728549405; x=1729154205;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y6ZhgI9A/PPL66uKE+bRh7ed0Z2uBOmJSzMOo3Ul9p0=;
 b=exWGoCRnco+gyis8Fbota6joD9As5iQqqVlzpLoEC0i34vG98nOHs4PVg4aICCxRUG
 eSbyd9NSyZX7pCXcT/Vpi4hd7ru7BdMMCcpYUv7Q5/HxcnTfnKEwRT0F2vkWEMCIi1dX
 2jGL2Byx0Kh4kpngVRSaMsRpztQDIVTjXzNR+v0FDEVqjME38OcjcSVZ5NAAKZZemiVk
 68lA+vsU2TthQJU/lniyI2gFmDDRa5orDyGABF5YeiHKDMsOZ4D92QqFaslL1OPUxvTs
 v39yg9NuGJybLjXSEO/hyKw9hZKAbGwGSH2pGZVbr4ebe8g3vyG0KY1+eLElEUcWCKKd
 47XQ==
X-Gm-Message-State: AOJu0Yyph3oc6JHlyf179PI9MAomF87ghF69f8GHEaYTCW7pjdCHncg+
 qfyhIZP90NcG+4gl4juQWHsUS/ED2Zs1B7rhQOPHh3pG9FZG8bV0vOoeoDrPYYUxCPSaKt1Myvd
 SLjYg94sfWr8X6c2ryy4M/7V2pIruMkOU7TFrzyKpL99uhLt9hptiLzBdqVnuI5Erurq8AsmEmb
 q1zsyS+i/aTCo6vGxnQw0TdAqFIA8VEHe1xTgtk6Y=
X-Received: by 2002:a05:6402:35d3:b0:5c9:35bc:81a2 with SMTP id
 4fb4d7f45d1cf-5c935bc88d4mr1528541a12.6.1728549404999; 
 Thu, 10 Oct 2024 01:36:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8cLf8tnANgDA4Kpwis70Rruqwq+RYFwQeDwDvplN20RpRTZYvdIQjx9UbERy3k+WD77BtKg==
X-Received: by 2002:a05:6402:35d3:b0:5c9:35bc:81a2 with SMTP id
 4fb4d7f45d1cf-5c935bc88d4mr1528484a12.6.1728549404202; 
 Thu, 10 Oct 2024 01:36:44 -0700 (PDT)
Received: from avogadro.local ([151.81.124.37])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c937260a9asm464026a12.67.2024.10.10.01.36.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 01:36:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tcg: remove singlestep_enabled from DisasContextBase
Date: Thu, 10 Oct 2024 10:36:41 +0200
Message-ID: <20241010083641.1785069-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It is used in a couple of places only, both within the same target.  Those can
use the cflags just as well, so remove the separate field.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/translator.h   | 2 --
 accel/tcg/translator.c      | 1 -
 target/mips/tcg/translate.c | 5 +++--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 25004dfb76e..d8dcb77b5f4 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -71,7 +71,6 @@ typedef enum DisasJumpType {
  * @is_jmp: What instruction to disassemble next.
  * @num_insns: Number of translated instructions (including current).
  * @max_insns: Maximum number of instructions to be translated in this TB.
- * @singlestep_enabled: "Hardware" single stepping enabled.
  * @plugin_enabled: TCG plugin enabled in this TB.
  * @fake_insn: True if translator_fake_ldb used.
  * @insn_start: The last op emitted by the insn_start hook,
@@ -86,7 +85,6 @@ struct DisasContextBase {
     DisasJumpType is_jmp;
     int num_insns;
     int max_insns;
-    bool singlestep_enabled;
     bool plugin_enabled;
     bool fake_insn;
     struct TCGOp *insn_start;
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 113edcffe35..cbad00a5172 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -129,7 +129,6 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     db->is_jmp = DISAS_NEXT;
     db->num_insns = 0;
     db->max_insns = *max_insns;
-    db->singlestep_enabled = cflags & CF_SINGLE_STEP;
     db->insn_start = NULL;
     db->fake_insn = false;
     db->host_addr[0] = host_pc;
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 333469b268e..50d8537a3b3 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -15362,7 +15362,8 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
      * hardware does (e.g. if a delay slot instruction faults, the
      * reported PC is the PC of the branch).
      */
-    if (ctx->base.singlestep_enabled && (ctx->hflags & MIPS_HFLAG_BMASK)) {
+    if ((tb_cflags(ctx->base.tb) & CF_SINGLE_STEP) &&
+        (ctx->hflags & MIPS_HFLAG_BMASK)) {
         ctx->base.max_insns = 2;
     }
 
@@ -15445,7 +15446,7 @@ static void mips_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
      * together with its delay slot.
      */
     if (ctx->base.pc_next - ctx->page_start >= TARGET_PAGE_SIZE
-        && !ctx->base.singlestep_enabled) {
+        && !(tb_cflags(ctx->base.tb) & CF_SINGLE_STEP)) {
         ctx->base.is_jmp = DISAS_TOO_MANY;
     }
 }
-- 
2.46.2


