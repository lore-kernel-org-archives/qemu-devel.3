Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED96C27C65
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrX9-0000Wn-BV; Sat, 08 Jun 2024 04:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrX5-0000UN-G6
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:34:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrX2-0008GF-Ln
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3+poIGky4GSqhFlE6pkBG1pa6bXFWkqUUf8ylZXVgw0=;
 b=O3cwHMj07GG7QJ5YORY+mInP6CtKPdFftszBSxsHmp1bQCytFuUk3An8YNyrHuocO9wsXY
 /M7tX3i8YzittC1B6VXF/J02ngwuaHg4y3PEWJmnfOYcMewTCFz4BF/x7lNzPLNu1dz91m
 RhvBxxzLmWFRDn0YNSwryTEv+F5a+Kg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-_fjf7KbWPBusNNRXVXIuRw-1; Sat, 08 Jun 2024 04:34:28 -0400
X-MC-Unique: _fjf7KbWPBusNNRXVXIuRw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a68f654dc69so204283466b.1
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835667; x=1718440467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3+poIGky4GSqhFlE6pkBG1pa6bXFWkqUUf8ylZXVgw0=;
 b=Q/erogziS/9MinK/rEBmPLQUPmizBDAra//ES+4oh2cIVS/PX4gUuQ2s69MM3VAVhU
 +XgtUzNTxawW2dOi/ACeUPDkZBdG1x3EQAcaCySOAb8LxqFM6kBabDaF2gjwb93JoP4m
 WgzkfQg9HjzrUPp3On1GOHBeWAUfJjPPzsoyMP5hMNzTLhkN4PIip02DJddNbKqKL0jX
 vauw/1J5PFF5N+uSpgFvqQAfnRQZPCBjGDgLHLXLS5Yq06U/avm52xm+oT+IFIGI+UqZ
 2yR62Ga2MSNxrMz0Ld36hNLrNMEOt6FFst5MvlJlMGK7x5lY6CGpY/eezika19ADJsLD
 nfUw==
X-Gm-Message-State: AOJu0YyyTw/XOaQ61yRDaDAQGTsq0zukGCPbRbHpfBSo/IXlmjRlCXAv
 bJj+HP0Sxpt2ZSNbcqTjvgv/msVKKHQ+HogAF+Lez5B1C+yPcx5fv++2yVnF4w22eqqHmnVl/no
 SQQ0xbiIHksNfivj//3AgjBXLzHKcqQoCFfs3px1ur36pmH+raxAJRHJXVJdLGicsmyTE2i0y0S
 YaCRSfq1XLy2PS0EvQUH1frS/37LR8YTp4JnVh
X-Received: by 2002:a17:906:308a:b0:a6c:7027:b3e6 with SMTP id
 a640c23a62f3a-a6cd560fa1dmr359912866b.15.1717835667107; 
 Sat, 08 Jun 2024 01:34:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/23c81kUg3XdZpIXXKjy8F+QcqxO7ocLvQyHKLFbq1IfpIFE+s4klh2bfRAhQEjsXA/aIxQ==
X-Received: by 2002:a17:906:308a:b0:a6c:7027:b3e6 with SMTP id
 a640c23a62f3a-a6cd560fa1dmr359911266b.15.1717835666484; 
 Sat, 08 Jun 2024 01:34:26 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f0557b1c3sm43453766b.209.2024.06.08.01.34.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:34:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/42] target/i386: cleanup HLT helpers
Date: Sat,  8 Jun 2024 10:33:36 +0200
Message-ID: <20240608083415.2769160-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use decode.c's support for intercepts, doing the check in TCG-generated
code rather than the helper.  This is cleaner because it allows removing
the eip_addend argument to helper_hlt().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/helper.h                 |  2 +-
 target/i386/tcg/sysemu/misc_helper.c | 13 ++-----------
 target/i386/tcg/decode-new.c.inc     |  4 ++--
 target/i386/tcg/emit.c.inc           |  4 ++--
 4 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/target/i386/helper.h b/target/i386/helper.h
index 8f291a5f66f..c244dbb4812 100644
--- a/target/i386/helper.h
+++ b/target/i386/helper.h
@@ -90,7 +90,7 @@ DEF_HELPER_2(vmsave, void, env, int)
 DEF_HELPER_1(stgi, void, env)
 DEF_HELPER_1(clgi, void, env)
 DEF_HELPER_FLAGS_2(flush_page, TCG_CALL_NO_RWG, void, env, tl)
-DEF_HELPER_FLAGS_2(hlt, TCG_CALL_NO_WG, noreturn, env, int)
+DEF_HELPER_FLAGS_1(hlt, TCG_CALL_NO_WG, noreturn, env)
 DEF_HELPER_FLAGS_2(monitor, TCG_CALL_NO_WG, void, env, tl)
 DEF_HELPER_FLAGS_2(mwait, TCG_CALL_NO_WG, noreturn, env, int)
 DEF_HELPER_1(rdmsr, void, env)
diff --git a/target/i386/tcg/sysemu/misc_helper.c b/target/i386/tcg/sysemu/misc_helper.c
index edb7c3d8940..e41c88346cb 100644
--- a/target/i386/tcg/sysemu/misc_helper.c
+++ b/target/i386/tcg/sysemu/misc_helper.c
@@ -516,8 +516,7 @@ void helper_flush_page(CPUX86State *env, target_ulong addr)
     tlb_flush_page(env_cpu(env), addr);
 }
 
-static G_NORETURN
-void do_hlt(CPUX86State *env)
+G_NORETURN void helper_hlt(CPUX86State *env)
 {
     CPUState *cs = env_cpu(env);
 
@@ -527,14 +526,6 @@ void do_hlt(CPUX86State *env)
     cpu_loop_exit(cs);
 }
 
-G_NORETURN void helper_hlt(CPUX86State *env, int next_eip_addend)
-{
-    cpu_svm_check_intercept_param(env, SVM_EXIT_HLT, 0, GETPC());
-    env->eip += next_eip_addend;
-
-    do_hlt(env);
-}
-
 void helper_monitor(CPUX86State *env, target_ulong ptr)
 {
     if ((uint32_t)env->regs[R_ECX] != 0) {
@@ -558,6 +549,6 @@ G_NORETURN void helper_mwait(CPUX86State *env, int next_eip_addend)
     if (cs->cpu_index != 0 || CPU_NEXT(cs) != NULL) {
         do_pause(env);
     } else {
-        do_hlt(env);
+        helper_hlt(env);
     }
 }
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 0ff0866e8f3..376d2bdabe1 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1496,7 +1496,7 @@ static const X86OpEntry opcodes_root[256] = {
     [0xE7] = X86_OP_ENTRYrr(OUT,   0,v, I_unsigned,b), /* AX/EAX */
 
     [0xF1] = X86_OP_ENTRY0(INT1,   svm(ICEBP)),
-    [0xF4] = X86_OP_ENTRY0(HLT,    chk(cpl0)),
+    [0xF4] = X86_OP_ENTRY0(HLT,    chk(cpl0) svm(HLT)),
     [0xF5] = X86_OP_ENTRY0(CMC),
     [0xF6] = X86_OP_GROUP1(group3, E,b),
     [0xF7] = X86_OP_GROUP1(group3, E,v),
@@ -2539,7 +2539,7 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
 
     /*
      * Checks that result in #GP or VMEXIT come second.  Intercepts are
-     * generally checked after non-memory exceptions (i.e. before all
+     * generally checked after non-memory exceptions (i.e. after all
      * exceptions if there is no memory operand).  Exceptions are
      * vm86 checks (INTn, IRET, PUSHF/POPF), RSM and XSETBV (!).
      *
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 36127d99943..2e94e8ec56f 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1638,8 +1638,8 @@ static void gen_HLT(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
 #ifdef CONFIG_SYSTEM_ONLY
     gen_update_cc_op(s);
-    gen_update_eip_cur(s);
-    gen_helper_hlt(tcg_env, cur_insn_len_i32(s));
+    gen_update_eip_next(s);
+    gen_helper_hlt(tcg_env);
     s->base.is_jmp = DISAS_NORETURN;
 #endif
 }
-- 
2.45.1


