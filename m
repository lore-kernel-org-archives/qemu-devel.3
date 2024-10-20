Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC54D3C92D
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 15:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2YG0-0003PU-RF; Sun, 20 Oct 2024 11:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2YFi-0003NG-Is
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 11:54:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2YFf-0005Px-JV
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 11:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729439630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q6Atrid02n+aIsNXR6t6jfxIFvTGj0hOmgcUWqfqLMk=;
 b=R48dcR+zNcMTFoSKZwbacSrF4z99SsHYa624AQLhvOT4NSPg2ml81ztyiiGW11U/8cfp90
 kcjqHK3gH+sRBcoRpQzzKNyM8D8Hauemi2DYrwKZx1C4uFExrv+mRTnBE3EKaJEpa30zbQ
 FZXZIMggomy6+MMHhMUcOOhKdExU+b4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-IKDbB3trP5SmisM5HEI-DQ-1; Sun, 20 Oct 2024 11:53:48 -0400
X-MC-Unique: IKDbB3trP5SmisM5HEI-DQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d4af408dcso2107523f8f.0
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 08:53:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729439627; x=1730044427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q6Atrid02n+aIsNXR6t6jfxIFvTGj0hOmgcUWqfqLMk=;
 b=RV3p6wj9XokdHcNAXdLFgtVxRYpHq1x5Fhi8NIVDpzezV+hjM/qniX39AiapLxLi6i
 SJuVltSu89UFNZOYtFw673Wiuw+sAgfkkDw4uKw3gncO6hwkyA/ZFuaWgLeITqAb3qTD
 50EDC0MJB0AIfr/dntJcPqbX/ZMKJHnbOgVhIJ/fCt18O9oFsk07xdfOTQF/y3MaGpIC
 wxOrAWdXU9IpN8PHkqROv0XoQWqDh8JqspVjmWVWmopPrQyMUTb3COOm3bGB+IybrlVx
 aPODk+kj4QlO2g7Ul3Hbe57fuFp5z+2Btv+q/Pt/8b5Cf78/gzY7hZ3+Wnl6yJaD3Enb
 l9Rw==
X-Gm-Message-State: AOJu0YxblMh7wUGq+Yu0bScdoAC3P7oXQv8APHVhnf7cNR6pPbYuhFqF
 TgDljaVf206Zvrj/i30sWW077fzhmgp7wAPPB11YhZvPW0dSmuGm1jyyhokIlLdHD7dkrPbcn8a
 E48B5tuCf2MdZh30vfT3OrvcmwqjlCtKSnqye+c5hZ1xWyt2YqZZ4Ps2rNrC8hhSIJwcakmwUiY
 stZlemQGGkj53nWKZ7WuhZNjiyJ3Kn1Vmu/GECBhc=
X-Received: by 2002:adf:ef50:0:b0:37d:54a0:d0a1 with SMTP id
 ffacd0b85a97d-37eb4897a21mr5463496f8f.56.1729439627042; 
 Sun, 20 Oct 2024 08:53:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdXgQVtZjWgZ1/6Oo7v50h3P7ADnBe8k6t47/08C9J21SiCJ7id0EwSU+7F2ILL15ST/86bg==
X-Received: by 2002:adf:ef50:0:b0:37d:54a0:d0a1 with SMTP id
 ffacd0b85a97d-37eb4897a21mr5463486f8f.56.1729439626540; 
 Sun, 20 Oct 2024 08:53:46 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee095bec2sm2040612f8f.0.2024.10.20.08.53.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Oct 2024 08:53:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 06/14] target/i386: Wrap cc_op_live with a validity check
Date: Sun, 20 Oct 2024 17:53:16 +0200
Message-ID: <20241020155324.35273-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241020155324.35273-1-pbonzini@redhat.com>
References: <20241020155324.35273-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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

From: Richard Henderson <richard.henderson@linaro.org>

Assert that op is known and that cc_op_live_ is populated.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h                |  1 -
 target/i386/tcg/translate.c      | 21 ++++++++++++++++++---
 target/i386/tcg/decode-new.c.inc |  2 +-
 target/i386/tcg/emit.c.inc       |  4 ++--
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 51a0a463c3e..782e329c15c 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1359,7 +1359,6 @@ typedef enum {
 #define CC_OP_LAST_BWLQ CC_OP_POPCNTQ__
 
     CC_OP_DYNAMIC, /* must use dynamic code to get cc_op */
-    CC_OP_NB,
 } CCOp;
 
 /* See X86DecodedInsn.cc_op, using int8_t. */
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 46062002c02..1a9a2fe709e 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -291,7 +291,7 @@ enum {
 };
 
 /* Bit set if the global variable is live after setting CC_OP to X.  */
-static const uint8_t cc_op_live[CC_OP_NB] = {
+static const uint8_t cc_op_live_[] = {
     [CC_OP_DYNAMIC] = USES_CC_DST | USES_CC_SRC | USES_CC_SRC2,
     [CC_OP_EFLAGS] = USES_CC_SRC,
     [CC_OP_MULB ... CC_OP_MULQ] = USES_CC_DST | USES_CC_SRC,
@@ -312,6 +312,21 @@ static const uint8_t cc_op_live[CC_OP_NB] = {
     [CC_OP_POPCNT] = USES_CC_DST,
 };
 
+static uint8_t cc_op_live(CCOp op)
+{
+    uint8_t result;
+    assert(op >= 0 && op < ARRAY_SIZE(cc_op_live_));
+
+    /*
+     * Check that the array is fully populated.  A zero entry would correspond
+     * to a fixed value of EFLAGS, which can be obtained with CC_OP_EFLAGS
+     * as well.
+     */
+    result = cc_op_live_[op];
+    assert(result);
+    return result;
+}
+
 static void set_cc_op_1(DisasContext *s, CCOp op, bool dirty)
 {
     int dead;
@@ -321,7 +336,7 @@ static void set_cc_op_1(DisasContext *s, CCOp op, bool dirty)
     }
 
     /* Discard CC computation that will no longer be used.  */
-    dead = cc_op_live[s->cc_op] & ~cc_op_live[op];
+    dead = cc_op_live(s->cc_op) & ~cc_op_live(op);
     if (dead & USES_CC_DST) {
         tcg_gen_discard_tl(cpu_cc_dst);
     }
@@ -808,7 +823,7 @@ static void gen_mov_eflags(DisasContext *s, TCGv reg)
     src2 = cpu_cc_src2;
 
     /* Take care to not read values that are not live.  */
-    live = cc_op_live[s->cc_op] & ~USES_CC_SRCT;
+    live = cc_op_live(s->cc_op) & ~USES_CC_SRCT;
     dead = live ^ (USES_CC_DST | USES_CC_SRC | USES_CC_SRC2);
     if (dead) {
         TCGv zero = tcg_constant_tl(0);
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 1f193716468..ee2a508ae9a 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2865,7 +2865,7 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
             tcg_gen_mov_i32(cpu_cc_op, decode.cc_op_dynamic);
         }
         set_cc_op(s, decode.cc_op);
-        cc_live = cc_op_live[decode.cc_op];
+        cc_live = cc_op_live(decode.cc_op);
     } else {
         cc_live = 0;
     }
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 45ac5edb1ae..785ff63f2ac 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -3777,13 +3777,13 @@ static void gen_shift_dynamic_flags(DisasContext *s, X86DecodedInsn *decode, TCG
     decode->cc_op_dynamic = tcg_temp_new_i32();
 
     assert(decode->cc_dst == s->T0);
-    if (cc_op_live[s->cc_op] & USES_CC_DST) {
+    if (cc_op_live(s->cc_op) & USES_CC_DST) {
         decode->cc_dst = tcg_temp_new();
         tcg_gen_movcond_tl(TCG_COND_EQ, decode->cc_dst, count, tcg_constant_tl(0),
                            cpu_cc_dst, s->T0);
     }
 
-    if (cc_op_live[s->cc_op] & USES_CC_SRC) {
+    if (cc_op_live(s->cc_op) & USES_CC_SRC) {
         tcg_gen_movcond_tl(TCG_COND_EQ, decode->cc_src, count, tcg_constant_tl(0),
                            cpu_cc_src, decode->cc_src);
     }
-- 
2.46.2


