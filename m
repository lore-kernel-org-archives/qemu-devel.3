Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFD0C27C53
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 07:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEORZ-00038x-8v; Tue, 04 Jun 2024 03:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sEORX-000368-Fr
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:18:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sEORV-0005bO-RL
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717485529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U/nNXKv5w7XsoKaYFhzY0rSXugZeBuJcWZqnC83Ujh0=;
 b=ISxBcOyuKeOZ5q6Ij4Mh6hRMsHkJQ7PeCJXOkPNlPfPwkoNGPS/RntHk24lPIg8cFvJVHB
 yIDUC/nURzL7zmIATWAfTIPxsIRUCNZGr0SY2YVTxvQ1Jr4YIpUHew+OfnhRwrP8pGagFs
 Hl9CKiRXBR5jPpzILZVWlKh8yZyQweE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-qqppHs-CNLiIai-j2BHHBg-1; Tue, 04 Jun 2024 03:18:46 -0400
X-MC-Unique: qqppHs-CNLiIai-j2BHHBg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-57a52be5f2aso831590a12.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 00:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717485524; x=1718090324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U/nNXKv5w7XsoKaYFhzY0rSXugZeBuJcWZqnC83Ujh0=;
 b=WJfUijtoyiqTG9/lj/CX8k069OjqhRnT/0O4iSziZ1miXzTxQcihiQQ05Zy9n+Ca8o
 A30GGmJBYsGJfCEV3N4hARZZYU1whbGS2Xyc0nvtq4+mFQN3oYLFESjVDfnn3mpJDuvw
 /gVzC3aVZDjtV64Lzd5A2PMqX0hI1zkdxLgeDRW3eHEWJeHV7l4rWfXDYeLVLyoDxSf0
 CG8iK8kPddtbAMmeVA6nDXU8iBjhtVth4nfI9VelzYKMVcQjq1LTvkQl9mUQA6CA6xuO
 WIBySmmz8nUBuGbnhbGmB3mc99cRNpZuQijZeGb+LLIWbl0o9sRx8/QdWkxHsYoioJF8
 QoMQ==
X-Gm-Message-State: AOJu0Yy7P01M/TLRTjpCC7a901BhaxB6GJWcZ3WM4MFqHgqSL5hMKwms
 fqrVoaCuB9fudhqqY9Z1F31jJcwEVUxvdwximuYo9iX2C/6xdw8xV0WNoGAL2EjL+k2J8gJ1DYc
 003AnJAAx8oTblh4B+gP5XMVoIT3RUZDyQbrQSX185hzlKJ4D18xpxUj+zS1iEdsfwZjbZk9ZTI
 r84WO81iaC+RK6ximUFtLY/kadnkhhgPz7j/Hl
X-Received: by 2002:a17:906:6d06:b0:a68:b0f2:1d95 with SMTP id
 a640c23a62f3a-a68b0f21f73mr514339566b.71.1717485524171; 
 Tue, 04 Jun 2024 00:18:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwfIzW2qIHF45NYhJjYVhuvBsePfnB39ghXQq3gsX5UUvBAEf+++bMCa3NFAFq5n+AMi1O+A==
X-Received: by 2002:a17:906:6d06:b0:a68:b0f2:1d95 with SMTP id
 a640c23a62f3a-a68b0f21f73mr514338366b.71.1717485523566; 
 Tue, 04 Jun 2024 00:18:43 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68ce1e4462sm398245566b.197.2024.06.04.00.18.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 00:18:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 02/11] target/i386: fix implementation of ICEBP
Date: Tue,  4 Jun 2024 09:18:24 +0200
Message-ID: <20240604071833.962574-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604071833.962574-1-pbonzini@redhat.com>
References: <20240604071833.962574-1-pbonzini@redhat.com>
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

ICEBP generates a trap-like exception, while gen_exception() produces
a fault.  Resurrect gen_update_eip_next() to implement the desired
semantics.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/helper.h          |  1 +
 target/i386/tcg/helper-tcg.h  |  3 +++
 target/i386/tcg/bpt_helper.c  |  6 ++++++
 target/i386/tcg/excp_helper.c | 20 ++++++++++++++++++++
 target/i386/tcg/translate.c   | 13 +++++++++++++
 target/i386/tcg/emit.c.inc    |  5 ++++-
 6 files changed, 47 insertions(+), 1 deletion(-)

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
index effc2c1c984..6a5505e7b4c 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -112,6 +112,9 @@ int exception_has_error_code(int intno);
 void do_smm_enter(X86CPU *cpu);
 
 /* bpt_helper.c */
+void do_end_instruction(CPUX86State *env);
+
+/* sysemu/bpt_helper.c */
 bool check_hw_breakpoints(CPUX86State *env, bool force_dr6_update);
 
 #endif /* I386_HELPER_TCG_H */
diff --git a/target/i386/tcg/bpt_helper.c b/target/i386/tcg/bpt_helper.c
index bc34ac27fea..9695b9dd041 100644
--- a/target/i386/tcg/bpt_helper.c
+++ b/target/i386/tcg/bpt_helper.c
@@ -37,3 +37,9 @@ void helper_rechecking_single_step(CPUX86State *env)
         helper_single_step(env);
     }
 }
+
+void do_end_instruction(CPUX86State *env)
+{
+    env->hflags &= ~HF_INHIBIT_IRQ_MASK; /* needed if sti is just before */
+    env->eflags &= ~HF_RF_MASK;
+}
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


