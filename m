Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BD5CD1297
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 16:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruEaq-0001Xx-M5; Tue, 09 Apr 2024 12:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruEaL-0000hU-WE
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:44:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruEa3-00086o-85
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712681049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I+IkkhB9pl1S2fDACEPQ2ZBXV/CaDauOuRUxY+FYR0I=;
 b=LQ4ObRVVsOQgHyUQUAWXMZB5cDmYQjeTkHZAvm5oOq7TgU5mwg64a2vVIjvjbG+l8PM606
 vmS9t8jZVO4PhzTC1hNMP4XR30NVCNTga1NGLERymrhzlhGC8LKpp+f//MMQT1jgN8xDe6
 16Kau8Ol1U5UF84QopcpF6Jg05woj4w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-0Q5D_zMZPWuCWT7FV6cYRA-1; Tue, 09 Apr 2024 12:44:07 -0400
X-MC-Unique: 0Q5D_zMZPWuCWT7FV6cYRA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-343e46df264so2387999f8f.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 09:44:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712681045; x=1713285845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I+IkkhB9pl1S2fDACEPQ2ZBXV/CaDauOuRUxY+FYR0I=;
 b=YqGFM6fs8kdnWkeqBZWNCtw5tRpRJHEHqiK2CI9ofH7drIHQeEM5DXJCyxrWtLRFCN
 TtYQu8Ie77H39Ct10N8EBj+s+WZD0nR9TDoubt/rtEkviDum3CbhPwPfkocbtgkwpB2D
 N8UuWVBTCrgNlFfsXIwwvhRuiHbC05sARDoKeZ+Zq/zidin12hsyBsGkVkpBzAW1psma
 ClpzSouMdIVkg6D2V+w6WdNM5i/Ht4g9WP95kaPwj4JX6AFEmkwZWP0lBBB3dOQIUYxn
 /GzNWQARmfTrYyeJDCkm+xEJGQNZfzcYB5y+vbXJV7Z+FhmmiYvM6jyBZUPdpDJ7pML5
 HLnA==
X-Gm-Message-State: AOJu0YwCp0gSQAQvFo1XG2vKyRqEeE+KdaTbvKPgs82aSBwzNF4P8xz6
 GKSuRpugBa+pR6uo/mXQA2aaUa3Aar9/c6yu6yxdV7jLdnCCzIt3wtC/gY5HVRuF9ima0qbp77I
 gL7kwXz+Yxdoji6d29Xb1YlPbR9kek9CugJUFutSy4khAtlDTLtiX9JaxCToP6kIMpMP7OfzOlS
 y5rrzuUp+VoNG1eZtOZ75V+4N/6dQe1Gic3Sqm
X-Received: by 2002:a7b:ce0a:0:b0:416:bc07:a8a6 with SMTP id
 m10-20020a7bce0a000000b00416bc07a8a6mr199446wmc.23.1712681045592; 
 Tue, 09 Apr 2024 09:44:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ1HSkvs2II1d4f9kGFZY4BDpoNsVxC0VVmHDtHpZZp+Q/VuqwIvO8Ku/JuQGKa/gPCuoXNw==
X-Received: by 2002:a7b:ce0a:0:b0:416:bc07:a8a6 with SMTP id
 m10-20020a7bce0a000000b00416bc07a8a6mr199433wmc.23.1712681045233; 
 Tue, 09 Apr 2024 09:44:05 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 v19-20020a05600c471300b004157ff88ad7sm17999812wmo.7.2024.04.09.09.44.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 09:44:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-9.1 14/19] target/i386: move BSWAP to new decoder
Date: Tue,  9 Apr 2024 18:43:18 +0200
Message-ID: <20240409164323.776660-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409164323.776660-1-pbonzini@redhat.com>
References: <20240409164323.776660-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 target/i386/tcg/translate.c      |  4 +++-
 target/i386/tcg/decode-new.c.inc |  9 +++++++++
 target/i386/tcg/emit.c.inc       | 11 +++++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index f3c437aee88..a1e6e8ec7d9 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3209,7 +3209,9 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
 #ifndef CONFIG_USER_ONLY
         use_new &= b <= limit;
 #endif
-        if (use_new && (b >= 0x138 && b <= 0x19f)) {
+        if (use_new &&
+	    ((b >= 0x138 && b <= 0x19f) ||
+             (b >= 0x1c8 && b <= 0x1cf))) {
             disas_insn_new(s, cpu, b);
             return true;
         }
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 36eb53515af..2ee949b50e2 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1118,6 +1118,15 @@ static const X86OpEntry opcodes_0F[256] = {
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
index dc5142be51f..1dc246f8c1e 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1299,6 +1299,17 @@ static void gen_BOUND(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
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
2.44.0


