Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25D5C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4IVA-0005kk-7e; Tue, 07 May 2024 06:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IV2-0005KD-4M
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IV0-0002ue-Cr
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715079400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KeLOw0sLpM5H/XhOdgpwzY0ev9pu1t41lGgX/HfRlG4=;
 b=CmzzbzjmYCNetkP68GrhJRo3/SZrbpubzIHUUN7rdkIpq96kxFsCwehImBZxDyrSU0xm0m
 BOqBc7eg5oH88iwXRpti18Q2fV9QfcRZuv8sG17ZE8AYzVyzr5WNsvfJMIqXXtSUEim0e9
 Zz52EF3080orKHTjHSbD3CwSdQVz2nc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-XO0eTLflMVajkKGv6o192w-1; Tue, 07 May 2024 06:56:39 -0400
X-MC-Unique: XO0eTLflMVajkKGv6o192w-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-57287ec26a8so1438842a12.3
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 03:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715079398; x=1715684198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KeLOw0sLpM5H/XhOdgpwzY0ev9pu1t41lGgX/HfRlG4=;
 b=Ix3VxMuF0jj/uIdJPYgxRMSyL2gLdpMluZB6Z6T1gIIC/V7fqnBYXmQ7fc7PSbtoWi
 bRIv05LBoBBALdhymqi328UydzBC6GbLSQfqGNKUoIUQRwGsKutv9i/zFdw7GBN4ZqRC
 IfjveMha7A+3gV8edLPut/KIYEMB5/fHgEm9TAYk4zSx0uRqU/qdbbEEDWnJvxSPvDue
 /K/B/zNWA61t3ZwnTnk40AOGh0QO5ZZsuX9Xx+7CSiwGfIaSk687GGc3C3CHpfihrofw
 trY1ip67wEAKxf221XOoH+kr55g0f0YwM1ULY7wYeds0lUgaJJOMOTahEDUdet4E/PuM
 GQOQ==
X-Gm-Message-State: AOJu0YzhPXpK5FNrTohvlzEpS/cR3r3IobUlrdHDv5nnq5Edh14QkF2v
 2yjC5QodMcctqSIHaAGl6pNw+0XwJzJHyzSRMvpfUSb41KKOBiQ/Mj4tGhkmyWdR/PYsEYkYtyB
 h0q8xSQgzbM5kdJYZVaSHTUOiKvzOxiPAQePgw4gjIDiAY6glkgro4RdXVsX004AIuOKU80OE1K
 XqLEOtweYBNqqp0mIES9CeUFrqqULW0yYduOeK
X-Received: by 2002:a50:a452:0:b0:571:be3a:e904 with SMTP id
 v18-20020a50a452000000b00571be3ae904mr7795700edb.8.1715079397868; 
 Tue, 07 May 2024 03:56:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmqgR+RrGWwcy9u/1aQ54gfqDSRqm0WbJaPJZbdplQ+WT2/V7k5IFC9qrJ/fwpL73ObZ/OOw==
X-Received: by 2002:a50:a452:0:b0:571:be3a:e904 with SMTP id
 v18-20020a50a452000000b00571be3ae904mr7795688edb.8.1715079397505; 
 Tue, 07 May 2024 03:56:37 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 p7-20020aa7d307000000b005722d871e4csm6208776edq.90.2024.05.07.03.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 03:56:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 21/26] target/i386: move BSWAP to new decoder
Date: Tue,  7 May 2024 12:55:33 +0200
Message-ID: <20240507105538.180704-22-pbonzini@redhat.com>
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
 target/i386/tcg/translate.c      |  4 +++-
 target/i386/tcg/decode-new.c.inc |  9 +++++++++
 target/i386/tcg/emit.c.inc       | 11 +++++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index b1c1aecf71e..751ec5d0f1a 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3207,7 +3207,9 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
 #ifndef CONFIG_USER_ONLY
         use_new &= b <= limit;
 #endif
-        if (use_new && (b >= 0x138 && b <= 0x19f)) {
+        if (use_new &&
+            ((b >= 0x138 && b <= 0x19f) ||
+             (b >= 0x1c8 && b <= 0x1cf))) {
             disas_insn_new(s, cpu, b);
             return true;
         }
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index c70a7836914..16e23ec3d88 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1124,6 +1124,15 @@ static const X86OpEntry opcodes_0F[256] = {
     [0xc5] = X86_OP_ENTRY3(PEXTRW,     G,d, U,dq,I,b,       vex5 mmx p_00_66),
     [0xc6] = X86_OP_ENTRY4(VSHUF,      V,x, H,x, W,x,       vex4 p_00_66),
 
+    [0xc8] = X86_OP_ENTRY1(BSWAP,     LoBits,y),
+    [0xc9] = X86_OP_ENTRY1(BSWAP,     LoBits,y),
+    [0xca] = X86_OP_ENTRY1(BSWAP,     LoBits,y),
+    [0xcb] = X86_OP_ENTRY1(BSWAP,     LoBits,y),
+    [0xcc] = X86_OP_ENTRY1(BSWAP,     LoBits,y),
+    [0xcd] = X86_OP_ENTRY1(BSWAP,     LoBits,y),
+    [0xce] = X86_OP_ENTRY1(BSWAP,     LoBits,y),
+    [0xcf] = X86_OP_ENTRY1(BSWAP,     LoBits,y),
+
     [0xd0] = X86_OP_ENTRY3(VADDSUB,   V,x, H,x, W,x,        vex2 cpuid(SSE3) p_66_f2),
     [0xd1] = X86_OP_ENTRY3(PSRLW_r,   V,x, H,x, W,x,        vex4 mmx avx2_256 p_00_66),
     [0xd2] = X86_OP_ENTRY3(PSRLD_r,   V,x, H,x, W,x,        vex4 mmx avx2_256 p_00_66),
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index a9e32516afd..befde6677be 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1310,6 +1310,17 @@ static void gen_BOUND(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     }
 }
 
+static void gen_BSWAP(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+#ifdef TARGET_X86_64
+    if (s->dflag == MO_64) {
+        tcg_gen_bswap64_i64(s->T0, s->T0);
+        return;
+    }
+#endif
+    tcg_gen_bswap32_tl(s->T0, s->T0, TCG_BSWAP_OZ);
+}
+
 static void gen_BZHI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
-- 
2.45.0


