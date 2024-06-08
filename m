Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9869EC25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFreK-0002y1-OS; Sat, 08 Jun 2024 04:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFreI-0002sj-Lc
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:42:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFreG-0001R1-Pk
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717836124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=29vDyAjFlT0oHHuzdskRtBwuTNaHeAQJUG9MkDRPFew=;
 b=IpAhcWCtiaXUW0ZMXJcQy+UdpcZcAipObvjGEYsCtTgjamrzgS0Ttr8anlymPOcNhZTKfQ
 bNopdKNaQDDBN+kGh6IV06cnCsv1qZ88PMPrnYsZav6QJ2MLsqSA6ZWFx/epi1PMCQpLMJ
 ibSOKuU5qregOlPk7wXqLiiIn/DYrhc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-s6FfGkXwMYC6v_vXAHJhAg-1; Sat, 08 Jun 2024 04:41:58 -0400
X-MC-Unique: s6FfGkXwMYC6v_vXAHJhAg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a68ce1ac733so157603866b.3
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:41:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717836116; x=1718440916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=29vDyAjFlT0oHHuzdskRtBwuTNaHeAQJUG9MkDRPFew=;
 b=cOVxjVw+O4IfZT0CvYFM0nyPB0IV6QS2oZDG0E3C02vXBYvW8yXyLqLz3g+YR4diUj
 60U2VsEuPNizx48k+wEfEO/hOoXrtULTZxjx3Y20aPOyVeKgvyyBH+4LpFpnNQh35Xpu
 W9ZUBVIFMJXJEJ938lHW59oXApbS+5r7YtL3Tw/Rzdwp7XwuSyXwxnrtorXJs2gVh5TW
 oly2RZ27oLugNG3DxyZH3YLDTc/NHxPKVOJKBxRfax5IZpFXzUk9nzCKjsI7++Ck/FHS
 +rBYq3IDBRP19Mi6nUAE+zhPamJdcj+3NNNsxORMDn4Hs6S961cYkRxVw8OtLF/HsY6h
 GXSg==
X-Gm-Message-State: AOJu0YwKWe/566I3Ye2ndsIx5wLmyzRqHWDKgGGD0LECuxkPjfMJl10F
 uKdJLKicfvc2SpcCIJAfRlcyxIfBXgQlptSjsf5mZsMDCIVhuvSl2SUnKaX6wBvzsxxbgXDDNH1
 9ck8cWIt832P5+N91YE3rZOH99iqoKly0t9k0K8rb4OEyPX9KhZCukv/3GAEE1sQbIkNELWLF+U
 G7V2Zq7adiTyZ+ST7l1LRnQisvBs2vEBcgv0nJ
X-Received: by 2002:a17:906:2894:b0:a6f:cae:b141 with SMTP id
 a640c23a62f3a-a6f0caeb662mr34090266b.2.1717836116018; 
 Sat, 08 Jun 2024 01:41:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTTre6JdsYJKv0cStu2DXFEeBDLgmNMJj3iyIkJEw5Q145TN5oHW5EtfTDf/n3zWzZYM7OcA==
X-Received: by 2002:a17:906:2894:b0:a6f:cae:b141 with SMTP id
 a640c23a62f3a-a6f0caeb662mr34088666b.2.1717836115221; 
 Sat, 08 Jun 2024 01:41:55 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c80581716sm359752466b.19.2024.06.08.01.41.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:41:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/25] target/i386: replace read_crN helper with read_cr8
Date: Sat,  8 Jun 2024 10:40:59 +0200
Message-ID: <20240608084113.2770363-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608084113.2770363-1-pbonzini@redhat.com>
References: <20240608084113.2770363-1-pbonzini@redhat.com>
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

All other control registers are stored plainly in CPUX86State.

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


