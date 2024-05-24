Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D4AC25B7C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 15:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAWvH-0000H4-DT; Fri, 24 May 2024 11:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAWvF-0000Dz-TG
 for qemu-devel@nongnu.org; Fri, 24 May 2024 11:33:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAWvE-0007A6-5Q
 for qemu-devel@nongnu.org; Fri, 24 May 2024 11:33:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716564811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RzX5wbk9gUXB2ZJUJy9nWcoexSItSBHOEDA2O9r8g6E=;
 b=RyWsX2TcFDcnHnQg0Oc5S09mgWrgx1TlNk+CekKeVKDpAuVpmXlRZiQa4hAjZHPIVo8myK
 TYTIEnRC4wR+Oro/qoAsK1Ie5peMOQE3yOHsdtFJ+Fj+TCMpP/i23vnSvS5zB/Eu4cwyz2
 Hz+TQ0V9KAANL12buctjuiV0fZUMh00=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-REnDr3vzNgSIrlhUHBnV4Q-1; Fri, 24 May 2024 11:33:30 -0400
X-MC-Unique: REnDr3vzNgSIrlhUHBnV4Q-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a626ac4d29aso52439266b.3
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 08:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716564808; x=1717169608;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RzX5wbk9gUXB2ZJUJy9nWcoexSItSBHOEDA2O9r8g6E=;
 b=fUBtU4aAW6GIfAWt9dX8noB/MUZm1Em0Dpv0gvR1k67VhWv5H+IQqD/rgwHyNJNAU4
 cGkAqZOlqUviyzG0tkJqwHE7KSUtK9Nm0itgFyE5nbdb4U4N1CIIjMxOim4YZJPmely5
 ycUYH/nxFzN1yQ6huNJ060UMNckn+Yv4jIppSLR00TeE/buQKMJus2HbB4tu+L6GE+TO
 +T9qTHtbtlfVScd/U3rJxUxXuaXALtCDTHeJib/A+CRj/93up+dng0/jzH8w9IcL+39h
 oc37E2irTPWg5SYBrGefDRQ7quC9Dk4mQjgjYl4NG5ztGH5XXGneuqTsm1wP4thD8NZC
 LyvQ==
X-Gm-Message-State: AOJu0Yz3530FjxhHkE32AN30UsQtBwaZTn+AhTuAssEKGELkKsDIV6j1
 lSpZXBW4rDk6S89mzAurkv6RFREp6w2c6qrBXjbyJbWJIP+thmMunLhbHKFVOcUXDikVDHuxs1Q
 y6uta5iFrtzjM+mSLbqltwf3H8jYibkAOfDeHGlo2Sgv0xFGDxxMRDKf3/A2QurmoVO/DJScL+r
 OnnyCQ9GgyAWN0efnF96P1/J9DmI7+hzMMLrLJ
X-Received: by 2002:a17:906:564c:b0:a59:bdb7:73f5 with SMTP id
 a640c23a62f3a-a6265148ba0mr187412966b.52.1716564807963; 
 Fri, 24 May 2024 08:33:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7wcoPW/Tlc1FQvxrnZAkznSgT7Ckg5i2MXkFkaQGEOYdVdsScFXFPchp6NS0MmZWhJ0vrmA==
X-Received: by 2002:a17:906:564c:b0:a59:bdb7:73f5 with SMTP id
 a640c23a62f3a-a6265148ba0mr187411266b.52.1716564807620; 
 Fri, 24 May 2024 08:33:27 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626c817c52sm146543766b.1.2024.05.24.08.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 08:33:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	qemu-stable@nongnu.org
Subject: [PATCH] target/i386: always go through gen_eob*()
Date: Fri, 24 May 2024 17:33:23 +0200
Message-ID: <20240524153323.1267511-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Using DISAS_NORETURN does not process any of HF_INHIBIT_IRQ_MASK,
HF_RF_MASK or HF_TF_MASK.  Never use it, instead there is
DISAS_EOB_ONLY.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 18 ++++++++++++------
 target/i386/tcg/emit.c.inc  |  4 ++--
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index ebcff8766cf..df10e7d8a6a 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1406,7 +1406,7 @@ static void gen_exception(DisasContext *s, int trapno)
     gen_update_cc_op(s);
     gen_update_eip_cur(s);
     gen_helper_raise_exception(tcg_env, tcg_constant_i32(trapno));
-    s->base.is_jmp = DISAS_NORETURN;
+    s->base.is_jmp = DISAS_EOB_ONLY;
 }
 
 /* Generate #UD for the current instruction.  The assumption here is that
@@ -2191,7 +2191,7 @@ static void gen_interrupt(DisasContext *s, uint8_t intno)
     gen_update_eip_cur(s);
     gen_helper_raise_interrupt(tcg_env, tcg_constant_i32(intno),
                                cur_insn_len_i32(s));
-    s->base.is_jmp = DISAS_NORETURN;
+    s->base.is_jmp = DISAS_EOB_ONLY;
 }
 
 static void gen_set_hflag(DisasContext *s, uint32_t mask)
@@ -2354,7 +2354,7 @@ static void gen_jmp_rel(DisasContext *s, MemOp ot, int diff, int tb_num)
             tcg_gen_movi_tl(cpu_eip, new_eip);
         }
         tcg_gen_exit_tb(s->base.tb, tb_num);
-        s->base.is_jmp = DISAS_NORETURN;
+        s->base.is_jmp = DISAS_EOB_ONLY;
     } else {
         if (!(tb_cflags(s->base.tb) & CF_PCREL)) {
             tcg_gen_movi_tl(cpu_eip, new_eip);
@@ -3520,7 +3520,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         gen_update_cc_op(s);
         gen_update_eip_cur(s);
         gen_helper_rdpmc(tcg_env);
-        s->base.is_jmp = DISAS_NORETURN;
+        s->base.is_jmp = DISAS_EOB_ONLY;
         break;
     case 0x134: /* sysenter */
         /* For AMD SYSENTER is not valid in long mode */
@@ -3690,7 +3690,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
             gen_update_cc_op(s);
             gen_update_eip_cur(s);
             gen_helper_mwait(tcg_env, cur_insn_len_i32(s));
-            s->base.is_jmp = DISAS_NORETURN;
+            s->base.is_jmp = DISAS_EOB_ONLY;
             break;
 
         case 0xca: /* clac */
@@ -3769,7 +3769,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
             gen_helper_vmrun(tcg_env, tcg_constant_i32(s->aflag - 1),
                              cur_insn_len_i32(s));
             tcg_gen_exit_tb(NULL, 0);
-            s->base.is_jmp = DISAS_NORETURN;
+            s->base.is_jmp = DISAS_EOB_ONLY;
             break;
 
         case 0xd9: /* VMMCALL */
@@ -4770,6 +4770,11 @@ static void i386_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
 
     switch (dc->base.is_jmp) {
     case DISAS_NORETURN:
+	/*
+	 * Nothing to do, gen_eob*() was already called.  DISAS_NORETURN is
+	 * never set explicitly except in gen_eob_worker(), because that is
+	 * where HF_INHIBIT_IRQ_MASK, HF_RF_MASK and HF_TF_MASK are handled.
+	 */
         break;
     case DISAS_TOO_MANY:
         gen_update_cc_op(dc);
@@ -4793,6 +4798,7 @@ static void i386_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
     default:
         g_assert_not_reached();
     }
+    assert(dc->base.is_jmp == DISAS_NORETURN);
 }
 
 static const TranslatorOps i386_tr_ops = {
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index c78e35b1e28..14464074d5a 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1642,7 +1642,7 @@ static void gen_HLT(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     gen_update_cc_op(s);
     gen_update_eip_cur(s);
     gen_helper_hlt(tcg_env, cur_insn_len_i32(s));
-    s->base.is_jmp = DISAS_NORETURN;
+    s->base.is_jmp = DISAS_EOB_ONLY;
 #endif
 }
 
@@ -4022,7 +4022,7 @@ static void gen_XCHG(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
             gen_update_cc_op(s);
             gen_update_eip_cur(s);
             gen_helper_pause(tcg_env, cur_insn_len_i32(s));
-            s->base.is_jmp = DISAS_NORETURN;
+            s->base.is_jmp = DISAS_EOB_ONLY;
         }
         /* No writeback.  */
         decode->op[0].unit = X86_OP_SKIP;
-- 
2.45.1


