Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BAE9C25B7D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 08:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAQ11-0005og-KI; Fri, 24 May 2024 04:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAQ0y-0005hP-6u
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:11:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAQ0w-0000eB-EW
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716538256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7MYcC6Q1D9ri/NOlxqffS6MJV/c4iIBiGqbzxlhkUs8=;
 b=Ay+OThu2rndQKOlKS25Hm22kq1s147kGHE0bN8lWA04XIVcdGrvPdIKPCENBcyjvwoYPA2
 3PqYK42ahzRuBr+w95NlpX5WP/xec0woxnM9cpWl/lUha/ulPExVsPjeHjec+2/jp2rGkm
 ene2HtqLC9gzXf282V9txkfphO7mpMI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-ySVwXInENpKltwv6MMbu_w-1; Fri, 24 May 2024 04:10:55 -0400
X-MC-Unique: ySVwXInENpKltwv6MMbu_w-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6266c77502so28181966b.1
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 01:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716538253; x=1717143053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7MYcC6Q1D9ri/NOlxqffS6MJV/c4iIBiGqbzxlhkUs8=;
 b=X3sALli63rL2Won2bhj1gOIzsleVKmLJ0W4l+W2zPzuC58fA0GL5IfsLvTh+eZE4R9
 d+a8eLYpZXSbPwzUQsWCFe9nqoyuu7Gh1tapf6y6d1R3QE3LbH3inbwWrfXiaksxrDuX
 lqd4Y2Gg12kkxGIrpfb2ONgVrBBogg8pnvZ7pvllTLe+MiJySCY0eZsryyH+VH9PA1dh
 WGn3bFUrvEGWZdoqpwAVfzgMZXBQfXaJcK8aRhCjETjoHYkFvvBKm32ZB8wOavpGaXPD
 K1tSZNGknBPF7OY6zcOx+qUX+bCwRoX94h0tTvfrHn4nif7yqDL+utfzQ6KkSoq/MP2c
 wGPg==
X-Gm-Message-State: AOJu0Yx/xjdJmXQZYKYDVgp0wcDU3WtaqC0AQh4GRQgoeZDWlMdkegTJ
 VgCLXbGoVWJqgkns4+YS+XymQ2yRbFffjvo41NgVS/ssv6Seu+ThDuDXwemyc8T8/ARVZlURC+h
 gErUjYanLiw4BHGvPzMMS/gi9QukDtM3G29/NBBWIq3SMb74RoFO4RMY5KCtL4UUP2VORDWt9Qb
 coXcae7qmspbDzDuNr1fXa7m4SGhO9SseCQz4X
X-Received: by 2002:a17:906:470f:b0:a5c:e240:ceb7 with SMTP id
 a640c23a62f3a-a6264f0e8c9mr98379966b.62.1716538253143; 
 Fri, 24 May 2024 01:10:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpU5N3NKmoyUY1FhQuVzGs9Gsj+oF21Pz8XGrZixmk4Bt1MkQLZrO5gB+6hivtcUULe0E+Kw==
X-Received: by 2002:a17:906:470f:b0:a5c:e240:ceb7 with SMTP id
 a640c23a62f3a-a6264f0e8c9mr98378866b.62.1716538252765; 
 Fri, 24 May 2024 01:10:52 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626fc72ee3sm82827166b.195.2024.05.24.01.10.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 01:10:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/16] target/i386: cpu_load_eflags already sets cc_op
Date: Fri, 24 May 2024 10:10:18 +0200
Message-ID: <20240524081019.1141359-16-pbonzini@redhat.com>
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

No need to set it again at the end of the translation block, cc_op_dirty
can be set to false.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 37 ++++++++++++++++++++++++-------------
 target/i386/tcg/emit.c.inc  |  2 +-
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 1a776e77297..7442a8a51b1 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -332,7 +332,7 @@ static const uint8_t cc_op_live[CC_OP_NB] = {
     [CC_OP_POPCNT] = USES_CC_SRC,
 };
 
-static void set_cc_op(DisasContext *s, CCOp op)
+static void set_cc_op_1(DisasContext *s, CCOp op, bool dirty)
 {
     int dead;
 
@@ -355,20 +355,27 @@ static void set_cc_op(DisasContext *s, CCOp op)
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
@@ -3510,6 +3517,10 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
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
@@ -3526,7 +3537,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
             gen_helper_sysret(tcg_env, tcg_constant_i32(dflag - 1));
             /* condition codes are modified only in long mode */
             if (LMA(s)) {
-                set_cc_op(s, CC_OP_EFLAGS);
+                assume_cc_op(s, CC_OP_EFLAGS);
             }
             /* TF handling for the sysret insn is different. The TF bit is
                checked after the sysret insn completes. This allows #DB to be
@@ -4444,7 +4455,7 @@ static void disas_insn_old(DisasContext *s, CPUState *cpu, int b)
         g_assert_not_reached();
 #else
         gen_helper_rsm(tcg_env);
-        set_cc_op(s, CC_OP_EFLAGS);
+        assume_cc_op(s, CC_OP_EFLAGS);
 #endif /* CONFIG_USER_ONLY */
         s->base.is_jmp = DISAS_EOB_ONLY;
         break;
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 9eecf7ab56c..9fea395dfbf 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1881,7 +1881,7 @@ static void gen_IRET(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
         gen_helper_iret_protected(tcg_env, tcg_constant_i32(s->dflag - 1),
                                   eip_next_i32(s));
     }
-    set_cc_op(s, CC_OP_EFLAGS);
+    assume_cc_op(s, CC_OP_EFLAGS);
     s->base.is_jmp = DISAS_EOB_ONLY;
 }
 
-- 
2.45.1


