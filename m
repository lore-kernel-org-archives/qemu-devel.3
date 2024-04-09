Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59513CD128A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 16:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruEa6-0000c8-45; Tue, 09 Apr 2024 12:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruEZp-0000SL-FS
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:44:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruEZY-00081j-Ey
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712681020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5qQRcWwTmeCYOgNULC5SnXW502wZ5qxCsGLvfObFDcM=;
 b=DpWlc0C47oMI+D8AHg0LjdcXfp28PpeWxCDhMJbEnb1dUk4ZcFCyS8UV3erpEdv4psegwL
 cVTgUSXRG10IrhmteY9RhTRSCgzjV/5e8AXao/9Md0WXGGjvjeaaeIs7Z49UIGeSxiN+ou
 oV4rO8JWJ4J+HOSkvDmZE53Kc6XIeFY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-lPrQGdllMTyLs3agXo7yUw-1; Tue, 09 Apr 2024 12:43:39 -0400
X-MC-Unique: lPrQGdllMTyLs3agXo7yUw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-343d7cd8f46so2738569f8f.2
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 09:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712681018; x=1713285818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5qQRcWwTmeCYOgNULC5SnXW502wZ5qxCsGLvfObFDcM=;
 b=LD+5S6Whb6Xy2jQARM6CQmwv+EFlnzOv3FKW/GpviOtKeeVjK9Y3R77NOYJB7bZIcD
 z+4rnf0wbf4k3ulzAr3R3aeTdNFWw2oz5nr+svD4Nm0BWXVqI6EgCTmWxyTj7bZMJYZN
 bTiNxeLdRtXDdnJ7TZrdwtXnrM0yeDrnsyhsHq+GpTRsspxRbck55XppE2yo1phE2vtg
 SMBg6xv85ri4KM99cSv4GzHs/qEKQGOZXQSFCvxGNao/eSZ0XrddQdTSjf/hG7plT1fS
 sLVkOZy67ospar5HUwM5EEvsONi3+aQwmqvNnMd6ewrp12oMkGQ1HNiVjcA15dIYkVkJ
 yvBg==
X-Gm-Message-State: AOJu0Ywz2I5YKe5w1wfO1dTrCqSGaeGe+eUKKZwlg6AI1izr0jUtgGtw
 R8j0yI3ApNH7uU5xnz64AmWOTh1lOZFXtOHDbubqayN0nNXPYeTCTdRBIixnZOlF1XkNGUb6kPL
 7K0G9hrd6cCU0KMa5Ykr4Yg7Ux1qMEDVYD1plClJzg6DiFAh95OXzSLS5dsgb1YLR1rireh2gXq
 RrGoOvB2/Zgmj4aR6QQUo0td53cf0Kzmrr5FYq
X-Received: by 2002:a5d:4a51:0:b0:343:3542:b6aa with SMTP id
 v17-20020a5d4a51000000b003433542b6aamr159751wrs.58.1712681017705; 
 Tue, 09 Apr 2024 09:43:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt5NVyftS0GGrN8cjmAT452HlFD9dKL0ia5nKyU/lJXngb6QkjgyS8qB+lNHbVPBgnVkZF5Q==
X-Received: by 2002:a5d:4a51:0:b0:343:3542:b6aa with SMTP id
 v17-20020a5d4a51000000b003433542b6aamr159737wrs.58.1712681017256; 
 Tue, 09 Apr 2024 09:43:37 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 d6-20020a056000114600b003456c693fa4sm7615585wrx.93.2024.04.09.09.43.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 09:43:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-9.1 04/19] target/i386: do not use s->tmp0 and s->tmp4 to
 compute flags
Date: Tue,  9 Apr 2024 18:43:08 +0200
Message-ID: <20240409164323.776660-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409164323.776660-1-pbonzini@redhat.com>
References: <20240409164323.776660-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Create a new temporary whenever flags have to use one, instead of using
s->tmp0 or s->tmp4.  NULL can now be passed as the scratch register
to gen_prepare_*.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 54 +++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 197cccb6c96..debc1b27283 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -947,9 +947,9 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
     case CC_OP_SUBB ... CC_OP_SUBQ:
         /* (DATA_TYPE)CC_SRCT < (DATA_TYPE)CC_SRC */
         size = s->cc_op - CC_OP_SUBB;
-        t1 = gen_ext_tl(s->tmp0, cpu_cc_src, size, false);
-        /* If no temporary was used, be careful not to alias t1 and t0.  */
-        t0 = t1 == cpu_cc_src ? s->tmp0 : reg;
+        /* Be careful not to alias t1 and t0.  */
+        t1 = gen_ext_tl(NULL, cpu_cc_src, size, false);
+        t0 = (reg == t1 || !reg) ? tcg_temp_new() : reg;
         tcg_gen_mov_tl(t0, s->cc_srcT);
         gen_extu(size, t0);
         goto add_sub;
@@ -957,8 +957,9 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
     case CC_OP_ADDB ... CC_OP_ADDQ:
         /* (DATA_TYPE)CC_DST < (DATA_TYPE)CC_SRC */
         size = s->cc_op - CC_OP_ADDB;
-        t1 = gen_ext_tl(s->tmp0, cpu_cc_src, size, false);
-        t0 = gen_ext_tl(reg, cpu_cc_dst, size, false);
+        /* Be careful not to alias t1 and t0.  */
+        t1 = gen_ext_tl(NULL, cpu_cc_src, size, false);
+        t0 = gen_ext_tl(reg == t1 ? NULL : reg, cpu_cc_dst, size, false);
     add_sub:
         return (CCPrepare) { .cond = TCG_COND_LTU, .reg = t0,
                              .reg2 = t1, .use_reg2 = true };
@@ -1002,6 +1003,9 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
        /* The need to compute only C from CC_OP_DYNAMIC is important
           in efficiently implementing e.g. INC at the start of a TB.  */
        gen_update_cc_op(s);
+       if (!reg) {
+           reg = tcg_temp_new();
+       }
        gen_helper_cc_compute_c(reg, cpu_cc_dst, cpu_cc_src,
                                cpu_cc_src2, cpu_cc_op);
        return (CCPrepare) { .cond = TCG_COND_NE, .reg = reg,
@@ -1098,7 +1102,7 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
     int inv, jcc_op, cond;
     MemOp size;
     CCPrepare cc;
-    TCGv t0;
+    TCGv t0, t1;
 
     inv = b & 1;
     jcc_op = (b >> 1) & 7;
@@ -1109,11 +1113,13 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
         size = s->cc_op - CC_OP_SUBB;
         switch (jcc_op) {
         case JCC_BE:
-            tcg_gen_mov_tl(s->tmp4, s->cc_srcT);
-            gen_extu(size, s->tmp4);
-            t0 = gen_ext_tl(s->tmp0, cpu_cc_src, size, false);
-            cc = (CCPrepare) { .cond = TCG_COND_LEU, .reg = s->tmp4,
-                               .reg2 = t0, .use_reg2 = true };
+            /* Be careful not to alias t1 and t0.  */
+            t1 = gen_ext_tl(NULL, cpu_cc_src, size, false);
+            t0 = (reg == t1 || !reg) ? tcg_temp_new() : reg;
+            tcg_gen_mov_tl(t0, s->cc_srcT);
+            gen_extu(size, t0);
+            cc = (CCPrepare) { .cond = TCG_COND_LEU, .reg = t0,
+                               .reg2 = t1, .use_reg2 = true };
             break;
 
         case JCC_L:
@@ -1122,11 +1128,13 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
         case JCC_LE:
             cond = TCG_COND_LE;
         fast_jcc_l:
-            tcg_gen_mov_tl(s->tmp4, s->cc_srcT);
-            gen_exts(size, s->tmp4);
-            t0 = gen_ext_tl(s->tmp0, cpu_cc_src, size, true);
-            cc = (CCPrepare) { .cond = cond, .reg = s->tmp4,
-                               .reg2 = t0, .use_reg2 = true };
+            /* Be careful not to alias t1 and t0.  */
+            t1 = gen_ext_tl(NULL, cpu_cc_src, size, true);
+            t0 = (reg == t1 || !reg) ? tcg_temp_new() : reg;
+            tcg_gen_mov_tl(t0, s->cc_srcT);
+            gen_exts(size, t0);
+            cc = (CCPrepare) { .cond = cond, .reg = t0,
+                               .reg2 = t1, .use_reg2 = true };
             break;
 
         default:
@@ -1160,8 +1168,8 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
             break;
         case JCC_L:
             gen_compute_eflags(s);
-            if (reg == cpu_cc_src) {
-                reg = s->tmp0;
+            if (reg == cpu_cc_src || !reg) {
+                reg = tcg_temp_new();
             }
             tcg_gen_addi_tl(reg, cpu_cc_src, CC_O - CC_S);
             cc = (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = reg,
@@ -1170,8 +1178,8 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
         default:
         case JCC_LE:
             gen_compute_eflags(s);
-            if (reg == cpu_cc_src) {
-                reg = s->tmp0;
+            if (reg == cpu_cc_src || !reg) {
+                reg = tcg_temp_new();
             }
             tcg_gen_addi_tl(reg, cpu_cc_src, CC_O - CC_S);
             cc = (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = reg,
@@ -1216,7 +1224,7 @@ static inline void gen_compute_eflags_c(DisasContext *s, TCGv reg)
    value 'b'. In the fast case, T0 is guaranteed not to be used. */
 static inline void gen_jcc1_noeob(DisasContext *s, int b, TCGLabel *l1)
 {
-    CCPrepare cc = gen_prepare_cc(s, b, s->T0);
+    CCPrepare cc = gen_prepare_cc(s, b, NULL);
 
     if (cc.use_reg2) {
         tcg_gen_brcond_tl(cc.cond, cc.reg, cc.reg2, l1);
@@ -1230,7 +1238,7 @@ static inline void gen_jcc1_noeob(DisasContext *s, int b, TCGLabel *l1)
    A translation block must end soon.  */
 static inline void gen_jcc1(DisasContext *s, int b, TCGLabel *l1)
 {
-    CCPrepare cc = gen_prepare_cc(s, b, s->T0);
+    CCPrepare cc = gen_prepare_cc(s, b, NULL);
 
     gen_update_cc_op(s);
     set_cc_op(s, CC_OP_DYNAMIC);
@@ -2495,7 +2503,7 @@ static void gen_jcc(DisasContext *s, int b, int diff)
 
 static void gen_cmovcc1(DisasContext *s, int b, TCGv dest, TCGv src)
 {
-    CCPrepare cc = gen_prepare_cc(s, b, s->T1);
+    CCPrepare cc = gen_prepare_cc(s, b, NULL);
 
     if (!cc.use_reg2) {
         cc.reg2 = tcg_constant_tl(cc.imm);
-- 
2.44.0


