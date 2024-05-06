Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD33C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tRS-0004aO-An; Mon, 06 May 2024 04:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tQo-0003UM-EW
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:10:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tQm-0002NZ-EN
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714983037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B8BvS4sj+GUGVtorZpR85dTDQubyMYT7AlKL1wB3gfU=;
 b=LnDwbLSwBZJi3kk73/z0XP53+t1vbzmynnV3b8lx3QPUsIiNsyKe2QvcY+oX/27xxYlQpR
 CL1weIqXN1gs7d/JZE+tp2Eo/vMBucWaGX1SleOD3z5c3a4jSlFDNWLyQhXgQzYJkD+wco
 HkR+sAjTLnzPUfMlHFXwLb8BmPD/mFM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-wKhTbwWGNi-O5MTvS04dXQ-1; Mon, 06 May 2024 04:10:35 -0400
X-MC-Unique: wKhTbwWGNi-O5MTvS04dXQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a59ad2436f8so125333466b.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 01:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714983034; x=1715587834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B8BvS4sj+GUGVtorZpR85dTDQubyMYT7AlKL1wB3gfU=;
 b=mpbZ2fk7Sh/FUpw8rbQGqvhnQy6y2l1x+/9eZ9seMoPQJ7tRWxJ+tjUsz7geJxBCUP
 K9SiQ8qC5sW1fy03iGYINnj809uKaoPNvJzgcqyEBpjFeSAkQMZOd7wdQy+YxoMZYsNO
 PukOIlB7Jz3vdezvR95dnd/WA9f6LzGIOAR+QzhLjr/f2lGV0Kz7flBgsCe5yHy8bJ6/
 nXRpJrbX2BQkb1q0w8Mrm4XYgCEARvmWZWoyqRX16oQpQlRz54wesCxsrNyO7T39bYFo
 FeR4JDJ+/aQrcblujPx50EG0REl15P7cx+0qgPHPob8i+RxtLL2BHQ0mtBJlm3jtXZ6O
 a/yg==
X-Gm-Message-State: AOJu0YwsoRmIDz3+ugloZn9FiPdChbN2l0ZgpOuncapE/oLX1A7iA7m+
 2gD8kWvRAVLtkOa5AkaIyMy9rRV0MG4TgZuB6y9TDBM8VGkVtQ0khVTmMP3al0XLnPSb8COCLbi
 WbEhQIAFz1SAUdySQcDP3BZHj4jvJ7GUjzlk+l/7TegAXWyIRyw6PHdZ6xE9i9NUFUvIxIDM+JM
 XuojwiYz+QCCQvgiEiGUnkPGJGqziMXpYWdmGZ
X-Received: by 2002:a17:906:f146:b0:a55:6f6c:3bae with SMTP id
 gw6-20020a170906f14600b00a556f6c3baemr5305081ejb.0.1714983033781; 
 Mon, 06 May 2024 01:10:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS0JgoywUhOma20aEpZQjp9oCmXacATZ5cgI7O9mYwXgtpCvXHdu0gW+ZWEYRCF9RM0fzQaQ==
X-Received: by 2002:a17:906:f146:b0:a55:6f6c:3bae with SMTP id
 gw6-20020a170906f14600b00a556f6c3baemr5305066ejb.0.1714983033363; 
 Mon, 06 May 2024 01:10:33 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 ju23-20020a170906e91700b00a59ddf023ddsm237746ejb.127.2024.05.06.01.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 01:10:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	zhao1.liu@intel.com
Subject: [PATCH v2 11/25] target/i386: reintroduce debugging mechanism
Date: Mon,  6 May 2024 10:09:43 +0200
Message-ID: <20240506080957.10005-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506080957.10005-1-pbonzini@redhat.com>
References: <20240506080957.10005-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c      | 27 +++++++++++++++++++++++++++
 target/i386/tcg/decode-new.c.inc |  3 +++
 2 files changed, 30 insertions(+)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index e36ed4dcc10..705e8f3ef49 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2968,6 +2968,9 @@ static void gen_sty_env_A0(DisasContext *s, int offset, bool align)
     tcg_gen_qemu_st_i128(t, s->tmp0, mem_index, mop);
 }
 
+static bool first = true;
+static unsigned long limit;
+
 #include "decode-new.h"
 #include "emit.c.inc"
 #include "decode-new.c.inc"
@@ -3123,15 +3126,39 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
 
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


