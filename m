Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520D6C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4IV0-00058R-SF; Tue, 07 May 2024 06:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IUl-0004qG-5N
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IUc-0002k8-9D
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715079376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UF2McxSx47efKZhPTXJyVZFej15pDLGXmUBpaUrKS0Y=;
 b=P1Z1tAqzBf2Rp+JLJ8Rmxyz4uKmJJQyDJUQcSSc4oc8+am5el1Q+NdOXWc4OXrMLxmbpel
 gbj5pd5qJllNfuaW1CU9leZAoiVz4O4aq9GtXXwfyf7pSDd7uc6CTL60jND1ONf1qWd101
 hBXs554z0D3mKyphHx1e7CN+hKTjSVQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-GBgKv-_fOy-7QyknfoZV9Q-1; Tue, 07 May 2024 06:56:14 -0400
X-MC-Unique: GBgKv-_fOy-7QyknfoZV9Q-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a59a0d2280cso216700266b.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 03:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715079373; x=1715684173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UF2McxSx47efKZhPTXJyVZFej15pDLGXmUBpaUrKS0Y=;
 b=MYRkcjyNC8QlI+BNd5EkiaH51VEiJ7fS8X7iw3erYv6tQgZer8w3fuDFchHgZ6wWnq
 tMh27L+edtd0AZWKF/lpGfIalmenGCNtbXZmsIl+NdVnlMjZLiPq1TbTh/nTdpvvj8vg
 pQ31En7j/zXED+Zo0QgJ2KJX9xyNRDAJhVTa2bJieSvAOvuWVvYomgn2uceZ9cgLndu7
 9QV2auLsjoGBuNZDzkh3CnKx7rtxYrFv6i4CqY1kwRY+7mDetedxMNp+OKJGgYX3vemk
 k4Tmf2Q6n6Suj6hWTAJ+WpHorpga+2Czqq58y82Jc4dsLHwcb1vMizBeYpV8+6eQVItP
 RbYQ==
X-Gm-Message-State: AOJu0Yzdaf1SnO059ONsx5px5Kjz7q6hNOk6v4BQ7btdOL/n+D7HrR17
 bRHeH6FKgARPPorBvWeaUnsq0vO4XoI0scY7aXsyRTVw7AKWrH7l7l29c3GB3aee8SVKk+BBms+
 Xx23tvr7Sg5I2bsViw40jZpNz/NLrTiGDgxdXajHK2M4CGKUsycygYPA620wcZ1TybgYNoLHdvT
 BGGWF+gBUrTXYZeIbmppXxgTDVXy6QjKiHjBjj
X-Received: by 2002:a17:907:20b4:b0:a59:8786:3850 with SMTP id
 pw20-20020a17090720b400b00a5987863850mr7522687ejb.72.1715079373107; 
 Tue, 07 May 2024 03:56:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzemfcHKYfqRj1tfVaADzZShKosA5MOMEot+J/YzhBKxxKNsvGNWClx3RywrU4eq/z4XE38g==
X-Received: by 2002:a17:907:20b4:b0:a59:8786:3850 with SMTP id
 pw20-20020a17090720b400b00a5987863850mr7522682ejb.72.1715079372778; 
 Tue, 07 May 2024 03:56:12 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 ks15-20020a170906f84f00b00a59da4386e0sm1764946ejb.148.2024.05.07.03.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 03:56:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 12/26] target/i386: reintroduce debugging mechanism
Date: Tue,  7 May 2024 12:55:24 +0200
Message-ID: <20240507105538.180704-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240507105538.180704-1-pbonzini@redhat.com>
References: <20240507105538.180704-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c      | 27 +++++++++++++++++++++++++++
 target/i386/tcg/decode-new.c.inc |  3 +++
 2 files changed, 30 insertions(+)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index f018d6303a9..6a0c74c225f 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2969,6 +2969,9 @@ static void gen_sty_env_A0(DisasContext *s, int offset, bool align)
     tcg_gen_qemu_st_i128(t, s->tmp0, mem_index, mop);
 }
 
+static bool first = true;
+static unsigned long limit;
+
 #include "decode-new.h"
 #include "emit.c.inc"
 #include "decode-new.c.inc"
@@ -3124,15 +3127,39 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
 
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
2.45.0


