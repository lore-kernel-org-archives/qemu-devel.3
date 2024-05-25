Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CABC25B78
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 11:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sApf2-0002MI-7p; Sat, 25 May 2024 07:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApf0-0002Lb-A1
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApey-00042y-8b
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716636839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6AzBA78pbflNThNfuRdbt+YMVvZA2AmBw1wMegaaFwc=;
 b=Cct9YdkX2GUSxbQp/Nr8/L3o8EhlejrGj6eCLlYf+ndNxJii9JMK1OglrUKq2mb1uM1Hvg
 HVyVGC7RZq6+6xyzUhRsHuIJoR287nNrJ1qcJY78Ob0SDruPeiVEn/Fq8a2c6s0ZKsyw53
 4/ZNd68EggB+EZSCCYwqAabjfhlZDKU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-6SAIdBPFPkKycWEMrolMZg-1; Sat, 25 May 2024 07:33:58 -0400
X-MC-Unique: 6SAIdBPFPkKycWEMrolMZg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a6267bcfb5fso32435066b.2
 for <qemu-devel@nongnu.org>; Sat, 25 May 2024 04:33:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716636836; x=1717241636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6AzBA78pbflNThNfuRdbt+YMVvZA2AmBw1wMegaaFwc=;
 b=B8Ayz9+0b5IcYPeLXjacF7MqROcKe7ZFCBEONIrRzS1Jp/J1hq1tp7PzEYl5A+xJgF
 Pq+BfdDT6Pu7G9CVL0xph2s8RgBzr0KZQPebQs9oBlil7HtazY2M0VtwoyjG1cSoj5Tw
 4025Qyy2mrg7YGRZ4HlGH3h+XC337aIR77licMIKR+OUlQ60GwsHGKt7ikmPn6THXsNF
 vDzkpTr9jnlh0jkWdr4oIkDKQO7JqeGSLJctISvMF+n4lfAWIhCPH/rT8ulI1woekrZK
 IJ234aANFP4zNiiqm+qbXSWmeypYgmQ/gcv2be4CaUukZP/+DpOBq7OJJrBtG/4YL2/7
 RDmw==
X-Gm-Message-State: AOJu0YwEXpNqLJEwNKs5J3bQTP+KNFL8ikx14HXAQ0hU68Lyrv46VCMX
 zTEeX89/r9RdLOU83CC2I9A2Q6gt9vTHFD9HGKZZ0JiVDcOaTLktM8S+6kfVQIzoZ2dsgqOko+6
 Ou3ZoSZIBaBb3r4wteL4on7rtlliggrFWGGIXftWb3yLTVwZEkEwWLZNuI5k5qbMGEoY39BSbOz
 HDxFXwl2vKQ5v2lLgw44fdWQLU7u9HXOKcB2Oc
X-Received: by 2002:a50:cd5d:0:b0:578:881e:7b77 with SMTP id
 4fb4d7f45d1cf-578884c43e8mr1093196a12.34.1716636836081; 
 Sat, 25 May 2024 04:33:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEckXUv7UbucwIzjAjV+uRTkRUTm3bavUmfopiYM+TacbJFz5QQ7IBC007pcLbANOM8tN7tjA==
X-Received: by 2002:a50:cd5d:0:b0:578:881e:7b77 with SMTP id
 4fb4d7f45d1cf-578884c43e8mr1093175a12.34.1716636835566; 
 Sat, 25 May 2024 04:33:55 -0700 (PDT)
Received: from [192.168.10.116] ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-579c004108esm348864a12.23.2024.05.25.04.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 May 2024 04:33:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/24] target/i386: cpu_load_eflags already sets cc_op
Date: Sat, 25 May 2024 13:33:14 +0200
Message-ID: <20240525113332.1404158-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240525113332.1404158-1-pbonzini@redhat.com>
References: <20240525113332.1404158-1-pbonzini@redhat.com>
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

No need to set it again at the end of the translation block, cc_op_dirty
can be set to false.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 37 ++++++++++++++++++++++++-------------
 target/i386/tcg/emit.c.inc  |  2 +-
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 920d854c2b5..25c973e20c6 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -309,7 +309,7 @@ static const uint8_t cc_op_live[CC_OP_NB] = {
     [CC_OP_POPCNT] = USES_CC_SRC,
 };
 
-static void set_cc_op(DisasContext *s, CCOp op)
+static void set_cc_op_1(DisasContext *s, CCOp op, bool dirty)
 {
     int dead;
 
@@ -332,20 +332,27 @@ static void set_cc_op(DisasContext *s, CCOp op)
         tcg_gen_discard_tl(s->cc_srcT);
     }
 
-    if (op == CC_OP_DYNAMIC) {
-        /* The DYNAMIC setting is translator only, and should never be
-           stored.  Thus we always consider it clean.  */
-        s->cc_op_dirty = false;
-    } else {
-        /* Discard any computed CC_OP value (see shifts).  */
-        if (s->cc_op == CC_OP_DYNAMIC) {
-            tcg_gen_discard_i32(cpu_cc_op);
-        }
-        s->cc_op_dirty = true;
+    if (dirty && s->cc_op == CC_OP_DYNAMIC) {
+        tcg_gen_discard_i32(cpu_cc_op);
     }
+    s->cc_op_dirty = dirty;
     s->cc_op = op;
 }
 
+static void set_cc_op(DisasContext *s, CCOp op)
+{
+    /*
+     * The DYNAMIC setting is translator only, everything else
+     * will be spilled later.
+     */
+    set_cc_op_1(s, op, op != CC_OP_DYNAMIC);
+}
+
+static void assume_cc_op(DisasContext *s, CCOp op)
+{
+    set_cc_op_1(s, op, false);
+}
+
 static void gen_update_cc_op(DisasContext *s)
 {
     if (s->cc_op_dirty) {
@@ -3554,6 +3561,10 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         gen_update_cc_op(s);
         gen_update_eip_cur(s);
         gen_helper_syscall(tcg_env, cur_insn_len_i32(s));
+        /* condition codes are modified only in long mode */
+        if (LMA(s)) {
+            assume_cc_op(s, CC_OP_EFLAGS);
+        }
         /* TF handling for the syscall insn is different. The TF bit is  checked
            after the syscall insn completes. This allows #DB to not be
            generated after one has entered CPL0 if TF is set in FMASK.  */
@@ -3570,7 +3581,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
             gen_helper_sysret(tcg_env, tcg_constant_i32(dflag - 1));
             /* condition codes are modified only in long mode */
             if (LMA(s)) {
-                set_cc_op(s, CC_OP_EFLAGS);
+                assume_cc_op(s, CC_OP_EFLAGS);
             }
             /* TF handling for the sysret insn is different. The TF bit is
                checked after the sysret insn completes. This allows #DB to be
@@ -4489,7 +4500,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         g_assert_not_reached();
 #else
         gen_helper_rsm(tcg_env);
-        set_cc_op(s, CC_OP_EFLAGS);
+        assume_cc_op(s, CC_OP_EFLAGS);
 #endif /* CONFIG_USER_ONLY */
         s->base.is_jmp = DISAS_EOB_ONLY;
         break;
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index c78e35b1e28..3f2ae0aa7e7 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1883,7 +1883,7 @@ static void gen_IRET(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
         gen_helper_iret_protected(tcg_env, tcg_constant_i32(s->dflag - 1),
                                   eip_next_i32(s));
     }
-    set_cc_op(s, CC_OP_EFLAGS);
+    assume_cc_op(s, CC_OP_EFLAGS);
     s->base.is_jmp = DISAS_EOB_ONLY;
 }
 
-- 
2.45.1


