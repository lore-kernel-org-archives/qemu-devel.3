Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4659FC25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrWy-0000TZ-FK; Sat, 08 Jun 2024 04:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrWv-0000T2-JU
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:34:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrWt-0008FS-Vq
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LS/wITdYZ/lsQjy8bD9YvoyCGUgNIB1fvmjbJmhZtYY=;
 b=FYFZxyacvhPSnGqvMMyPBuWZbV/bWC1I7HYvPJfZzOf5JPrPUIxTmCErSHSaEP6Gel6TjB
 6fZgQarg4fPpxDU3hFLzOZvWM7ON+dmQdf0MnCOGD6lxlDLIIe9RiNvxUnAfxJj6ZFW8Y4
 Xk+g9HSo3yr/f6AP1g5fZvsAa7VqqIs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-UrAZZ7Z9PvWxK5UTe38WWg-1; Sat, 08 Jun 2024 04:34:25 -0400
X-MC-Unique: UrAZZ7Z9PvWxK5UTe38WWg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a6f0d8b466dso8082166b.2
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835663; x=1718440463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LS/wITdYZ/lsQjy8bD9YvoyCGUgNIB1fvmjbJmhZtYY=;
 b=n6SI9nK2sRwd9E43PZ6L+mssTZxpWUf2erh55fCWvv5oosAEyWlYMHXqUQawBqQ/le
 2c2heqFRAkz9Jp+neaqDFcK/7zgOeXZUqwWVlYyTY3WTFk0Eh9i8XKLb3dt645gzeF/M
 YjHhFP4Yda8+vHCM54MwFpDvYLK2Dy1/wui9lgRmztkPEPO2Ky6lIiKD99P9GsVELfPY
 PmZUFT3ff24422D7fshW2gvdImaDNATTJlu+sZW/6Rq88g98Fg1RgNkv2vwNOMgZTXOv
 HUkp3o2LzsTAsen0krmCY6K4Mt2HF5BL58Ar2lfDjFbWrAx0b+2PArT9ybvEYey31Elj
 2/fg==
X-Gm-Message-State: AOJu0YwktXayxjjO3neZl9GxrBWtqQ/rolN+XfMggOBP+stTjph1myne
 Q7A9U4aPn9kE9DnbJ2tMBKdrsXJJTVd2Wb0SVk8XcjA5vA2cNzQs2KkotA8YAk4edysfPUJb1By
 +x5YcOU4IbeJI/t3qbPkEL1406QhcveBLRRzo7B4+t21bFhp7opiRun+SlKeRGZzBVYUMrupbwV
 h8i3ArsCYoEDIY/Ws4dYplHE8Q0bwz34vR/qLe
X-Received: by 2002:a50:8d07:0:b0:57c:6338:328a with SMTP id
 4fb4d7f45d1cf-57c6338371dmr1924784a12.30.1717835663532; 
 Sat, 08 Jun 2024 01:34:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFA0saavFD8HanITQ106HeeMkOVMh3ZfY+DCsl9vfzPkMzrxwSi8ImQ6dT1Ctkj12C7Z7NEqA==
X-Received: by 2002:a50:8d07:0:b0:57c:6338:328a with SMTP id
 4fb4d7f45d1cf-57c6338371dmr1924770a12.30.1717835663183; 
 Sat, 08 Jun 2024 01:34:23 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae12ce21sm3964992a12.49.2024.06.08.01.34.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:34:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 02/42] target/i386: fix implementation of ICEBP
Date: Sat,  8 Jun 2024 10:33:35 +0200
Message-ID: <20240608083415.2769160-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
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

ICEBP generates a trap-like exception, while gen_exception() produces
a fault.  Resurrect gen_update_eip_next() to implement the desired
semantics.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/helper.h          |  1 +
 target/i386/tcg/helper-tcg.h  | 12 +++++++++++-
 target/i386/tcg/excp_helper.c | 20 ++++++++++++++++++++
 target/i386/tcg/translate.c   | 13 +++++++++++++
 target/i386/tcg/emit.c.inc    |  5 ++++-
 5 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/target/i386/helper.h b/target/i386/helper.h
index a52a1bf0f21..8f291a5f66f 100644
--- a/target/i386/helper.h
+++ b/target/i386/helper.h
@@ -56,6 +56,7 @@ DEF_HELPER_2(sysret, void, env, int)
 DEF_HELPER_FLAGS_2(pause, TCG_CALL_NO_WG, noreturn, env, int)
 DEF_HELPER_FLAGS_3(raise_interrupt, TCG_CALL_NO_WG, noreturn, env, int, int)
 DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, int)
+DEF_HELPER_FLAGS_1(icebp, TCG_CALL_NO_WG, noreturn, env)
 DEF_HELPER_3(boundw, void, env, tl, int)
 DEF_HELPER_3(boundl, void, env, tl, int)
 
diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index 85957943bf3..eb6a4926a43 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -111,7 +111,17 @@ int exception_has_error_code(int intno);
 /* smm_helper.c */
 void do_smm_enter(X86CPU *cpu);
 
-/* bpt_helper.c */
+/* sysemu/bpt_helper.c */
 bool check_hw_breakpoints(CPUX86State *env, bool force_dr6_update);
 
+/*
+ * Do the tasks usually performed by gen_eob().  Callers of this function
+ * should also handle TF as appropriate.
+ */
+static inline void do_end_instruction(CPUX86State *env)
+{
+    /* needed if sti is just before */
+    env->hflags &= ~HF_INHIBIT_IRQ_MASK;
+    env->eflags &= ~HF_RF_MASK;
+}
 #endif /* I386_HELPER_TCG_H */
diff --git a/target/i386/tcg/excp_helper.c b/target/i386/tcg/excp_helper.c
index 65e37ae2a0c..72387aac24f 100644
--- a/target/i386/tcg/excp_helper.c
+++ b/target/i386/tcg/excp_helper.c
@@ -140,6 +140,26 @@ G_NORETURN void raise_exception_ra(CPUX86State *env, int exception_index,
     raise_interrupt2(env, exception_index, 0, 0, 0, retaddr);
 }
 
+G_NORETURN void helper_icebp(CPUX86State *env)
+{
+    CPUState *cs = env_cpu(env);
+
+    do_end_instruction(env);
+
+    /*
+     * INT1 aka ICEBP generates a trap-like #DB, but it is pretty special.
+     *
+     * "Although the ICEBP instruction dispatches through IDT vector 1,
+     * that event is not interceptable by means of the #DB exception
+     * intercept".  Instead there is a separate fault-like ICEBP intercept.
+     */
+    cs->exception_index = EXCP01_DB;
+    env->error_code = 0;
+    env->exception_is_int = 0;
+    env->exception_next_eip = env->eip;
+    cpu_loop_exit(cs);
+}
+
 G_NORETURN void handle_unaligned_access(CPUX86State *env, vaddr vaddr,
                                         MMUAccessType access_type,
                                         uintptr_t retaddr)
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index d438f8f76f7..77ed9c1db47 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -549,6 +549,19 @@ static inline void gen_op_st_rm_T0_A0(DisasContext *s, int idx, int d)
     }
 }
 
+static void gen_update_eip_next(DisasContext *s)
+{
+    assert(s->pc_save != -1);
+    if (tb_cflags(s->base.tb) & CF_PCREL) {
+        tcg_gen_addi_tl(cpu_eip, cpu_eip, s->pc - s->pc_save);
+    } else if (CODE64(s)) {
+        tcg_gen_movi_tl(cpu_eip, s->pc);
+    } else {
+        tcg_gen_movi_tl(cpu_eip, (uint32_t)(s->pc - s->cs_base));
+    }
+    s->pc_save = s->pc;
+}
+
 static void gen_update_eip_cur(DisasContext *s)
 {
     assert(s->pc_save != -1);
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index e990141454b..36127d99943 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1858,7 +1858,10 @@ static void gen_INT(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 
 static void gen_INT1(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
-    gen_exception(s, EXCP01_DB);
+    gen_update_cc_op(s);
+    gen_update_eip_next(s);
+    gen_helper_icebp(tcg_env);
+    s->base.is_jmp = DISAS_NORETURN;
 }
 
 static void gen_INT3(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
-- 
2.45.1


