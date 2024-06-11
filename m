Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86140C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 14:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH2S2-0007hH-C4; Tue, 11 Jun 2024 10:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2S0-0007gW-Oh
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:26:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2Rp-00069D-DD
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718115963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zcn+DdHrcRw78M6P0mtW8fRKfJRYnrPP3Kt3DJstS+4=;
 b=M2hMc0MJMtI8jxbmFHmoYuYP21AiYD7WQw7fq5G0QEQ3yo4XG0/8UrDbRIiT/l8rDvXtYS
 CSOWcvkl/Wv8dokF47gqQlneMvvdVPRqqcvlXskNo9p3XqlyIogy43BgqgIcGseX6tuN+z
 NFrzrGPt5eOLH/HuAq8CTaKaXI2J8gU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-y2X5sL8tMuuPDDu_3-t1kA-1; Tue, 11 Jun 2024 10:26:01 -0400
X-MC-Unique: y2X5sL8tMuuPDDu_3-t1kA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a6ef729b465so201600366b.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 07:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718115960; x=1718720760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zcn+DdHrcRw78M6P0mtW8fRKfJRYnrPP3Kt3DJstS+4=;
 b=pBQccrZLHpNaxD+i/QvwjWywAZXixzVl7X3KYsF5R+HsmbuKXvY01MHlJvrC/qcAPD
 djyYzFm/Zg5SIht+r9jMcfMTKjFy0b5Ta20zYscd3niNqLux6ed8yMxGhaxV2PRRjDvN
 iuCKkzfczTmN9bkbBL3jK4MqQOFnWrvH45oDzvZQ0VZDOoNvFsCRb/xCAWBwBfocANc5
 aiztlOqrtL02z6915LYMttcXUmY5icyJQQVB9BWB2L1fbyP84ZtxeBWHpdXO5U6qFJp+
 AA4WjcKwQAgUsBSLqLHjAcDSoI2mGnQlByh/lpmgAC/LwpmcB0xrbzTuixbwchGhyhrf
 imlw==
X-Gm-Message-State: AOJu0YzKGrq7bwcclNGcCO2ztcCSasGNVdHtr7qTq87Ea4h77AW7AKzw
 JUWA6qy6JQz3ODF0a6RrbyYrVQmJLA65OHQlLmMbaCyLa6p6VXxg9rtIyo/16uKRtkf8jB1Z7NY
 jJM2hZrk6Usfud4BUPhE4ouNXeyHQN1LRlx6xHRbt+sNYXBpgWuMq0WcwQqzxot5g3evgnFUL8p
 HDocWQkl1x2E0wmv9a2CbY9/qWVcU7CMMQJLj8
X-Received: by 2002:a17:906:4356:b0:a6f:23e5:c112 with SMTP id
 a640c23a62f3a-a6f23e5c1b9mr310325966b.43.1718115959743; 
 Tue, 11 Jun 2024 07:25:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFivEskUKBZT7vXIguKxmkiyw8kuDGE1FgJl1P05InnahmupoE+4+g3m+amykAQeOknod60iw==
X-Received: by 2002:a17:906:4356:b0:a6f:23e5:c112 with SMTP id
 a640c23a62f3a-a6f23e5c1b9mr310324666b.43.1718115959356; 
 Tue, 11 Jun 2024 07:25:59 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6ef6a512f0sm530445366b.198.2024.06.11.07.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 07:25:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 16/25] target/i386: replace read_crN helper with read_cr8
Date: Tue, 11 Jun 2024 16:25:14 +0200
Message-ID: <20240611142524.83762-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611142524.83762-1-pbonzini@redhat.com>
References: <20240611142524.83762-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

All other control registers are stored plainly in CPUX86State.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/helper.h                 |  2 +-
 target/i386/tcg/sysemu/misc_helper.c | 20 +++++---------------
 target/i386/tcg/emit.c.inc           |  2 +-
 3 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/target/i386/helper.h b/target/i386/helper.h
index 2f46cffabd8..eeb8df56eaa 100644
--- a/target/i386/helper.h
+++ b/target/i386/helper.h
@@ -95,7 +95,7 @@ DEF_HELPER_FLAGS_2(monitor, TCG_CALL_NO_WG, void, env, tl)
 DEF_HELPER_FLAGS_2(mwait, TCG_CALL_NO_WG, noreturn, env, int)
 DEF_HELPER_1(rdmsr, void, env)
 DEF_HELPER_1(wrmsr, void, env)
-DEF_HELPER_FLAGS_2(read_crN, TCG_CALL_NO_RWG, tl, env, int)
+DEF_HELPER_FLAGS_1(read_cr8, TCG_CALL_NO_RWG, tl, env)
 DEF_HELPER_FLAGS_3(write_crN, TCG_CALL_NO_RWG, void, env, int, tl)
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/i386/tcg/sysemu/misc_helper.c b/target/i386/tcg/sysemu/misc_helper.c
index 7fa0c5a06de..094aa56a20d 100644
--- a/target/i386/tcg/sysemu/misc_helper.c
+++ b/target/i386/tcg/sysemu/misc_helper.c
@@ -63,23 +63,13 @@ target_ulong helper_inl(CPUX86State *env, uint32_t port)
                              cpu_get_mem_attrs(env), NULL);
 }
 
-target_ulong helper_read_crN(CPUX86State *env, int reg)
+target_ulong helper_read_cr8(CPUX86State *env)
 {
-    target_ulong val;
-
-    switch (reg) {
-    default:
-        val = env->cr[reg];
-        break;
-    case 8:
-        if (!(env->hflags2 & HF2_VINTR_MASK)) {
-            val = cpu_get_apic_tpr(env_archcpu(env)->apic_state);
-        } else {
-            val = env->int_ctl & V_TPR_MASK;
-        }
-        break;
+    if (!(env->hflags2 & HF2_VINTR_MASK)) {
+        return cpu_get_apic_tpr(env_archcpu(env)->apic_state);
+    } else {
+        return env->int_ctl & V_TPR_MASK;
     }
-    return val;
 }
 
 void helper_write_crN(CPUX86State *env, int reg, target_ulong t0)
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 5ca3764e006..709ef7b0cb2 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -245,7 +245,7 @@ static void gen_load(DisasContext *s, X86DecodedInsn *decode, int opn, TCGv v)
 #ifndef CONFIG_USER_ONLY
     case X86_OP_CR:
         if (op->n == 8) {
-            gen_helper_read_crN(v, tcg_env, tcg_constant_i32(op->n));
+            gen_helper_read_cr8(v, tcg_env);
         } else {
             tcg_gen_ld_tl(v, tcg_env, offsetof(CPUX86State, cr[op->n]));
         }
-- 
2.45.1


