Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7047AC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 16:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruEab-0000wL-OS; Tue, 09 Apr 2024 12:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruEZz-0000YQ-Fm
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:44:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruEZX-000821-G1
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712681023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wf2tVfaTh1bvwuOTSvtg3oyPPERZ0LSpwFLl2wx9qrs=;
 b=XDq3rcsL/+kqOmbFGl0nJECfJjsqQSwEcC6dKLY1RHWpHC9oErxJmxxrIHpyLVMw1irjiI
 BlS6EyJmb8UPQ0ETtqHsvwEzZjoc/z67sMx51BPY9HzhQOnnZc6Xug9fb79qQmgin1Zbku
 HXDhA9mv42e/zZvZKvANKge7InOpkMs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-GWgI80D6P5ujEAiJVMU6ug-1; Tue, 09 Apr 2024 12:43:41 -0400
X-MC-Unique: GWgI80D6P5ujEAiJVMU6ug-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-415591b1500so34080715e9.3
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 09:43:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712681020; x=1713285820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wf2tVfaTh1bvwuOTSvtg3oyPPERZ0LSpwFLl2wx9qrs=;
 b=n+FY0VmMDPrHSd5A/vRMolN5atM8d9g95AjzlTG6j2TqUASNndWUtkXqPcHoR6tUfd
 xziaSPXWb8NgEE/RSkHywL64IOYB0EIwpw0yVkovWYjtojJboTvfkjwFcu3tfw/95n57
 6a3LDZg74OXuXcRSbv4PG77eVRPWI6RLAQ8u2XAYpwtyKgIWqymkk62vOk4Tb4Tc2FnG
 zqshH5xXZ2YfNmU3Ofq1K81VT0S1vc25HUaYdrFk/++z5IgVmmhfDQVHAv1fGEoo+sQz
 JqiVK6IyKOuLJmXwnp4EUn7SOiCWhY3Os1oofyie9Xo1sccP/cZx6f76hWTPReRx8REP
 vQlA==
X-Gm-Message-State: AOJu0Yz5vFk4aj/847TvFVstg214aBGNLH4nx3WKyfP43K8wI2i8Q6Kb
 yoAjbL/KHRt6Ekgkax+TvHzCf7NDa99+s5yfXdMu2QQa/c5EwaHys3Rz/DQxAx5hM/G6B2gxCmU
 1e2KiCyEToIZRgzhoYWpBck7hSHpcHKu0bappjzfvjAQUkl4oOYmiHQ/Np3//ENqx9FF3bGYXOh
 EorKWO0vxfV6Br9XT08KTjPiWrRSgB2RZMk9X+
X-Received: by 2002:a05:600c:5104:b0:413:3941:d9ae with SMTP id
 o4-20020a05600c510400b004133941d9aemr175598wms.31.1712681019966; 
 Tue, 09 Apr 2024 09:43:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGc7iztGQehHuU8rcP8F/QdP7gkULtuqlzV6C8w6ZdEdUCeD3Y31wMUhfa8qrKaLOHJafp4+w==
X-Received: by 2002:a05:600c:5104:b0:413:3941:d9ae with SMTP id
 o4-20020a05600c510400b004133941d9aemr175585wms.31.1712681019572; 
 Tue, 09 Apr 2024 09:43:39 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 z5-20020a05600c0a0500b00416290b3e1dsm18187798wmp.24.2024.04.09.09.43.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 09:43:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-9.1 05/19] target/i386: reintroduce debugging mechanism
Date: Tue,  9 Apr 2024 18:43:09 +0200
Message-ID: <20240409164323.776660-6-pbonzini@redhat.com>
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
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c      | 27 +++++++++++++++++++++++++++
 target/i386/tcg/decode-new.c.inc |  3 +++
 2 files changed, 30 insertions(+)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index debc1b27283..2a372842db4 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2971,6 +2971,9 @@ static void gen_sty_env_A0(DisasContext *s, int offset, bool align)
     tcg_gen_qemu_st_i128(t, s->tmp0, mem_index, mop);
 }
 
+static bool first = true;
+static unsigned long limit;
+
 #include "decode-new.h"
 #include "emit.c.inc"
 #include "decode-new.c.inc"
@@ -3126,15 +3129,39 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
 
     prefixes = 0;
 
+    if (first) {
+        const char *limit_str = getenv("QEMU_I386_LIMIT");
+        limit = limit_str ? atol(limit_str) : -1;
+        first = false;
+    }
+    bool use_new = true;
+#ifdef CONFIG_USER_ONLY
+    use_new &= limit > 0;
+#endif
+
  next_byte:
     s->prefix = prefixes;
     b = x86_ldub_code(env, s);
     /* Collect prefixes.  */
     switch (b) {
     default:
+#ifndef CONFIG_USER_ONLY
+        use_new &= b <= limit;
+#endif
+        if (use_new && 0) {
+            disas_insn_new(s, cpu, b);
+            return true;
+        }
         break;
     case 0x0f:
         b = x86_ldub_code(env, s) + 0x100;
+#ifndef CONFIG_USER_ONLY
+        use_new &= b <= limit;
+#endif
+        if (use_new && 0) {
+            disas_insn_new(s, cpu, b);
+            return true;
+        }
         break;
     case 0xf3:
         prefixes |= PREFIX_REPZ;
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 426c4594120..3fc6485d74c 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1689,6 +1689,9 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
     X86DecodeFunc decode_func = decode_root;
     uint8_t cc_live;
 
+#ifdef CONFIG_USER_ONLY
+    if (limit) { --limit; }
+#endif
     s->has_modrm = false;
 
  next_byte:
-- 
2.44.0


