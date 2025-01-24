Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384AAC0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGFK-0006St-Jo; Fri, 24 Jan 2025 04:45:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFI-0006Op-35
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFG-0003ea-BH
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:44:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yeuGoGuKTcvwqHXgxX9xaCBIJpyVFW8auKhsCDJr9O0=;
 b=Bp0M+uxTom5fqfqzfZ4DOkBr5T6az234bUU7Sr8ltdP/Tv91J2Tyqfq9Cu2ySrhbYh/Ogd
 diiQ4tYjs3aHMgfM/pYBByD5Blj8IlXR2UeJHB0zqzJCu1+KLIqUMA+9yfLekhG6hat9dg
 QPWUXGHdYzrHobqX5OalBNEoG8OVfRs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-pwWiZI4HOYysMXAqEWjgjw-1; Fri, 24 Jan 2025 04:44:55 -0500
X-MC-Unique: pwWiZI4HOYysMXAqEWjgjw-1
X-Mimecast-MFC-AGG-ID: pwWiZI4HOYysMXAqEWjgjw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43673af80a6so13347885e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:44:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711894; x=1738316694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yeuGoGuKTcvwqHXgxX9xaCBIJpyVFW8auKhsCDJr9O0=;
 b=WVHOrjhGdc9VujpPDgytip/jAQvRsOlBjNa0Dbr2eIdQtACvY0G6iQ3KBd1M+24nIk
 DhVwYn224jaPnpAWBlqxmGVAHut1B0Nd3xVi8Ixd4JNE8FanR1WUS800PRnqwOT5NOJ2
 7tEKYaBV6V9a4XXMD1HDmHgD+Ay9yL00N8Lhnflkm3SchYlNver6e3OoBouJhP6KA7fg
 gf+tBW8kLuLF0boITZAtbVAWXk+BX6vN2ZeqXrKIfcDQVcNZiSxqLeKJooxHkEX0DVM0
 MMBPZVKxWPFF5tVQmwR8vGsX5H+jVYl47/jxWkerPZXOQMVdqodC4qgL8QBKRED8UxW0
 tS1Q==
X-Gm-Message-State: AOJu0Yxjet7Ky4RI43XM8zbDmchRkdT4fl2zFvqdtmeyk23n2UcNKtND
 OnwB5r2nKHIHtP416u3usb4dEqmgh3aICRrgrS3rmvUVf81Eyk4xl5kn5zehZDqYkVsWiC1IGim
 ji+kkabIagiRKZKYdeCV23ZA/m5Kgk4pz9B3+8cPaIuFyJ9l3IbgFMqq+LwxlLxz0NTZe+OBQi6
 ZMCbqWgpOjMzGYopp/Q/JL8aZGgLauj7zKaJf8jfc=
X-Gm-Gg: ASbGncucertvVi6UMJmtmkOkh41QeWIuLcOnNsqs1kwyJf2rMp0HAXz5MqAarZaiAVi
 IAgQfWO1USfEPKMJdhXSZo0g7TvV1dHDTmQG4cgfxwa+J9aXNwPKAzrNWiqZG3Im2QopDLgHWc7
 dL1ZIyimiZKV6GWrsDX1+aEBB6wX+ApNr8hhqXdgKAqdl+ll9fPLxALWaqJ2CB3VVBxWouAI33M
 GVeBo2aKFWruXQqkGBt+vhgFD+0hesc8kXHXC/qkUUJ2wTQJgFeDKlLEe1kqKDe4aua/1EWiQ==
X-Received: by 2002:a05:600c:1e18:b0:436:8a6f:b6db with SMTP id
 5b1f17b1804b1-4389141c12emr237090245e9.22.1737711893392; 
 Fri, 24 Jan 2025 01:44:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9134ho+c33aRXcw2WcMMOqRVvSNXc8G7fvS6ZJ7qrDk9hxSdq3axhWYGeDtEh2aObtmLWUw==
X-Received: by 2002:a05:600c:1e18:b0:436:8a6f:b6db with SMTP id
 5b1f17b1804b1-4389141c12emr237090005e9.22.1737711892948; 
 Fri, 24 Jan 2025 01:44:52 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd57545dsm20122795e9.40.2025.01.24.01.44.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:44:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/48] target/i386: unify choice between single and repeated
 string instructions
Date: Fri, 24 Jan 2025 10:43:59 +0100
Message-ID: <20250124094442.13207-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The same "if" is present in all generator functions for string instructions.
Push it inside gen_repz() and gen_repz_nz() instead.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20241215090613.89588-5-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 12 +++++++++--
 target/i386/tcg/emit.c.inc  | 42 +++++++------------------------------
 2 files changed, 17 insertions(+), 37 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 877b5846114..3e46be8d78d 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1341,13 +1341,21 @@ static void gen_repz(DisasContext *s, MemOp ot,
                      void (*fn)(DisasContext *s, MemOp ot))
 
 {
-    do_gen_rep(s, ot, fn, false);
+    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
+        do_gen_rep(s, ot, fn, false);
+    } else {
+        fn(s, ot);
+    }
 }
 
 static void gen_repz_nz(DisasContext *s, MemOp ot,
                         void (*fn)(DisasContext *s, MemOp ot))
 {
-    do_gen_rep(s, ot, fn, true);
+    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
+        do_gen_rep(s, ot, fn, true);
+    } else {
+        fn(s, ot);
+    }
 }
 
 static void gen_helper_fp_arith_ST0_FT0(int op)
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 861f0fb70f3..3a28b0cb31b 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1743,11 +1743,7 @@ static void gen_CMPccXADD(DisasContext *s, X86DecodedInsn *decode)
 static void gen_CMPS(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[2].ot;
-    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-        gen_repz_nz(s, ot, gen_cmps);
-    } else {
-        gen_cmps(s, ot);
-    }
+    gen_repz_nz(s, ot, gen_cmps);
 }
 
 static void gen_CMPXCHG(DisasContext *s, X86DecodedInsn *decode)
@@ -2238,11 +2234,7 @@ static void gen_INS(DisasContext *s, X86DecodedInsn *decode)
     }
 
     translator_io_start(&s->base);
-    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-        gen_repz(s, ot, gen_ins);
-    } else {
-        gen_ins(s, ot);
-    }
+    gen_repz(s, ot, gen_ins);
 }
 
 static void gen_INSERTQ_i(DisasContext *s, X86DecodedInsn *decode)
@@ -2426,11 +2418,7 @@ static void gen_LGS(DisasContext *s, X86DecodedInsn *decode)
 static void gen_LODS(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[1].ot;
-    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-        gen_repz(s, ot, gen_lods);
-    } else {
-        gen_lods(s, ot);
-    }
+    gen_repz(s, ot, gen_lods);
 }
 
 static void gen_LOOP(DisasContext *s, X86DecodedInsn *decode)
@@ -2628,11 +2616,7 @@ static void gen_MOVq_dq(DisasContext *s, X86DecodedInsn *decode)
 static void gen_MOVS(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[2].ot;
-    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-        gen_repz(s, ot, gen_movs);
-    } else {
-        gen_movs(s, ot);
-    }
+    gen_repz(s, ot, gen_movs);
 }
 
 static void gen_MUL(DisasContext *s, X86DecodedInsn *decode)
@@ -2794,11 +2778,7 @@ static void gen_OUTS(DisasContext *s, X86DecodedInsn *decode)
     }
 
     translator_io_start(&s->base);
-    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-        gen_repz(s, ot, gen_outs);
-    } else {
-        gen_outs(s, ot);
-    }
+    gen_repz(s, ot, gen_outs);
 }
 
 static void gen_PALIGNR(DisasContext *s, X86DecodedInsn *decode)
@@ -3879,11 +3859,7 @@ static void gen_SBB(DisasContext *s, X86DecodedInsn *decode)
 static void gen_SCAS(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[2].ot;
-    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-        gen_repz_nz(s, ot, gen_scas);
-    } else {
-        gen_scas(s, ot);
-    }
+    gen_repz_nz(s, ot, gen_scas);
 }
 
 static void gen_SETcc(DisasContext *s, X86DecodedInsn *decode)
@@ -4089,11 +4065,7 @@ static void gen_STMXCSR(DisasContext *s, X86DecodedInsn *decode)
 static void gen_STOS(DisasContext *s, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[1].ot;
-    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-        gen_repz(s, ot, gen_stos);
-    } else {
-        gen_stos(s, ot);
-    }
+    gen_repz(s, ot, gen_stos);
 }
 
 static void gen_SUB(DisasContext *s, X86DecodedInsn *decode)
-- 
2.48.1


