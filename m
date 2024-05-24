Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A19CC25B79
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 08:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAQ0z-0005kK-5i; Fri, 24 May 2024 04:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAQ0w-0005aC-63
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:10:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAQ0u-0000dz-As
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716538255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PFmVAnU2PZErTRTu3pvGi8VA91HPuCkI7gZtNWLo2q4=;
 b=KNpbIllG5O3Sgb8eO8IYxi06GXDO0C71sJ/N20UpPiFGbg5RevQyhlnw1NAivLIJIxjM3U
 6W3BTcH8C2b4XxbkpfRBUDBFbgGFJC24awMOWBV1bzxUTjwMJO81x85qXJm9R7zqs7xwpX
 TeMseAKbT8Q7erjRkAW/2+awi51I35M=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-4e7iuc5QMBCfBSqkylKO3w-1; Fri, 24 May 2024 04:10:54 -0400
X-MC-Unique: 4e7iuc5QMBCfBSqkylKO3w-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a6269ad7288so23409666b.2
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 01:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716538252; x=1717143052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PFmVAnU2PZErTRTu3pvGi8VA91HPuCkI7gZtNWLo2q4=;
 b=PmpNcwT3c76c1XHF89vye7JdsjZInBkjDtWsn6jks8wqlHX91mv62Z/Zuy1ofi/YUO
 yUM5QCSZYsZylJErQut1fk9M5dEOU80if8loY6as3f3v1qUCrsfH0BtB9/0qT9XUIIXZ
 ohclG5ugttbsquKwmID/N3HJrA3ONukD+FvzyhioyPMaKDRuNU4Nz/Akq/A7ECzA9lVp
 2f/Zzt8woujbGdlbUGjJwUgKnw+veDnDdXnw6/YnxiokWQWbOxZ41IWw5ZkZVjfBxeRv
 NWJdjjFsvinN4smI5EjZeIsJkjBqqWFKp41xz0GsBgrNcz9b49FLhfL+19lbWolZeMXh
 pTug==
X-Gm-Message-State: AOJu0Yza3HO0Yix5puj/zryIcTvVPILbM1H/fQvFxVzyhyirPrz7P5xg
 FNHbKT2VZqK2WWx4S7E/tSHsD2B1guogjsqpwS5rVHh437xsmEta2/+eBj7iaC0/7oMbwoz5Hjg
 9+jEtfeaTvSYs+zjxqOJp2UwEvBS8DW2fvHFaMgrD0D2n8Vq3BO/EM61/r3Z8FuG8mkbNaUGW/9
 G5+CpXI/0s7gS+PgZxgKjEqM55sK7GlTzOxXhY
X-Received: by 2002:a17:906:d147:b0:a59:9f4e:4e3b with SMTP id
 a640c23a62f3a-a62641a3aafmr93174466b.2.1716538252234; 
 Fri, 24 May 2024 01:10:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYe+hCAukNlsjh9haF38siBXMXm3UkSykoGAKgeOq0WfQELLVWimVKXOA16xUnarOquV6dtg==
X-Received: by 2002:a17:906:d147:b0:a59:9f4e:4e3b with SMTP id
 a640c23a62f3a-a62641a3aafmr93173266b.2.1716538251765; 
 Fri, 24 May 2024 01:10:51 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626c93b6d4sm90738866b.88.2024.05.24.01.10.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 01:10:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/16] target/i386: remove aflag argument of gen_lea_v_seg
Date: Fri, 24 May 2024 10:10:17 +0200
Message-ID: <20240524081019.1141359-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524081019.1141359-1-pbonzini@redhat.com>
References: <20240524081019.1141359-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

It is always s->aflag.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 20 ++++++++++----------
 target/i386/tcg/emit.c.inc  |  6 +++---
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 18d8c0de674..1a776e77297 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -673,20 +673,20 @@ static void gen_lea_v_seg_dest(DisasContext *s, MemOp aflag, TCGv dest, TCGv a0,
     }
 }
 
-static void gen_lea_v_seg(DisasContext *s, MemOp aflag, TCGv a0,
+static void gen_lea_v_seg(DisasContext *s, TCGv a0,
                           int def_seg, int ovr_seg)
 {
-    gen_lea_v_seg_dest(s, aflag, s->A0, a0, def_seg, ovr_seg);
+    gen_lea_v_seg_dest(s, s->aflag, s->A0, a0, def_seg, ovr_seg);
 }
 
 static inline void gen_string_movl_A0_ESI(DisasContext *s)
 {
-    gen_lea_v_seg(s, s->aflag, cpu_regs[R_ESI], R_DS, s->override);
+    gen_lea_v_seg(s, cpu_regs[R_ESI], R_DS, s->override);
 }
 
 static inline void gen_string_movl_A0_EDI(DisasContext *s)
 {
-    gen_lea_v_seg(s, s->aflag, cpu_regs[R_EDI], R_ES, -1);
+    gen_lea_v_seg(s, cpu_regs[R_EDI], R_ES, -1);
 }
 
 static inline TCGv gen_compute_Dshift(DisasContext *s, MemOp ot)
@@ -1777,7 +1777,7 @@ static void gen_lea_modrm(CPUX86State *env, DisasContext *s, int modrm)
 {
     AddressParts a = gen_lea_modrm_0(env, s, modrm);
     TCGv ea = gen_lea_modrm_1(s, a, false);
-    gen_lea_v_seg(s, s->aflag, ea, a.def_seg, s->override);
+    gen_lea_v_seg(s, ea, a.def_seg, s->override);
 }
 
 static void gen_nop_modrm(CPUX86State *env, DisasContext *s, int modrm)
@@ -2516,7 +2516,7 @@ static bool disas_insn_x87(DisasContext *s, CPUState *cpu, int b)
         bool update_fdp = true;
 
         tcg_gen_mov_tl(last_addr, ea);
-        gen_lea_v_seg(s, s->aflag, ea, a.def_seg, s->override);
+        gen_lea_v_seg(s, ea, a.def_seg, s->override);
 
         switch (op) {
         case 0x00 ... 0x07: /* fxxxs */
@@ -3313,7 +3313,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
             tcg_gen_sari_tl(s->tmp0, s->T1, 3 + ot);
             tcg_gen_shli_tl(s->tmp0, s->tmp0, ot);
             tcg_gen_add_tl(s->A0, gen_lea_modrm_1(s, a, false), s->tmp0);
-            gen_lea_v_seg(s, s->aflag, s->A0, a.def_seg, s->override);
+            gen_lea_v_seg(s, s->A0, a.def_seg, s->override);
             if (!(s->prefix & PREFIX_LOCK)) {
                 gen_op_ld_v(s, ot, s->T0, s->A0);
             }
@@ -3634,7 +3634,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
             }
             gen_update_cc_op(s);
             gen_update_eip_cur(s);
-            gen_lea_v_seg(s, s->aflag, cpu_regs[R_EAX], R_DS, s->override);
+            gen_lea_v_seg(s, cpu_regs[R_EAX], R_DS, s->override);
             gen_helper_monitor(tcg_env, s->A0);
             break;
 
@@ -4040,7 +4040,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                 } else {
                     tcg_gen_movi_tl(s->A0, 0);
                 }
-                gen_lea_v_seg(s, s->aflag, s->A0, a.def_seg, s->override);
+                gen_lea_v_seg(s, s->A0, a.def_seg, s->override);
                 if (a.index >= 0) {
                     tcg_gen_mov_tl(s->T0, cpu_regs[a.index]);
                 } else {
@@ -4145,7 +4145,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
                 } else {
                     tcg_gen_movi_tl(s->A0, 0);
                 }
-                gen_lea_v_seg(s, s->aflag, s->A0, a.def_seg, s->override);
+                gen_lea_v_seg(s, s->A0, a.def_seg, s->override);
                 if (a.index >= 0) {
                     tcg_gen_mov_tl(s->T0, cpu_regs[a.index]);
                 } else {
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index bc96735f61d..9eecf7ab56c 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -76,7 +76,7 @@ static void gen_NM_exception(DisasContext *s)
 static void gen_load_ea(DisasContext *s, AddressParts *mem, bool is_vsib)
 {
     TCGv ea = gen_lea_modrm_1(s, *mem, is_vsib);
-    gen_lea_v_seg(s, s->aflag, ea, mem->def_seg, s->override);
+    gen_lea_v_seg(s, ea, mem->def_seg, s->override);
 }
 
 static inline int mmx_offset(MemOp ot)
@@ -2044,7 +2044,7 @@ static void gen_MOV(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 
 static void gen_MASKMOV(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
-    gen_lea_v_seg(s, s->aflag, cpu_regs[R_EDI], R_DS, s->override);
+    gen_lea_v_seg(s, cpu_regs[R_EDI], R_DS, s->override);
 
     if (s->prefix & PREFIX_DATA) {
         gen_helper_maskmov_xmm(tcg_env, OP_PTR1, OP_PTR2, s->A0);
@@ -4039,7 +4039,7 @@ static void gen_XLAT(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     /* AL is already zero-extended into s->T0.  */
     tcg_gen_add_tl(s->A0, cpu_regs[R_EBX], s->T0);
-    gen_lea_v_seg(s, s->aflag, s->A0, R_DS, s->override);
+    gen_lea_v_seg(s, s->A0, R_DS, s->override);
     gen_op_ld_v(s, MO_8, s->T0, s->A0);
 }
 
-- 
2.45.1


