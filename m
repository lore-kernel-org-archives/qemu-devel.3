Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81720C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tSP-0005SX-Tt; Mon, 06 May 2024 04:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tRq-0004yY-1w
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:11:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tRA-0002ad-LJ
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714983063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KwORym2s7uDJ22C74Hjelt5Y4NcCjduHL3ixIkKHCqQ=;
 b=SjC47wCQOKvf+QjJ31VYQQ/iNoZtRUbDV7ga+agSPgiYCDXpf1Zhsm+60rCZbsz1zKAmVW
 loU+tD5xjginUkyAwNDvwt7dwNg1OKC1yFaQN7yMlyGDW9r2qguRVWtTVb0aJXo5B6iV+i
 TeIX/xCrwC1YwxDG6sPWTaiPjduDi9Y=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-Y8ocFPVyPzCC9CeoD6Lc0w-1; Mon, 06 May 2024 04:11:01 -0400
X-MC-Unique: Y8ocFPVyPzCC9CeoD6Lc0w-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a599dbd2b6aso90641266b.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 01:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714983059; x=1715587859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KwORym2s7uDJ22C74Hjelt5Y4NcCjduHL3ixIkKHCqQ=;
 b=HQjKL+zfDDM/9e+pj+jNdys78DKpYs1A8W5KWahqiMkHVfPepJNHP76MJcsDw23aFI
 rkQH3w5wKx7WynaZZegigsOu0upD/T1Y1j+z+6ykaqpasYsJIQ9PRem2FnwTGiz37Bm4
 nYJ0kw1Fnt02OKumzYpoRITESf0wCAEGcCsdceUrFsNVuPhOfVZkuVHN4FmYxZJOjtl0
 PEsMqrBkHJCHuhE8G9mCBlJvmY7kfdpwWe9d6djiPT9Ol3ZyAJc5iSsvo62X/WPH1aeR
 cgsEA09yb8PtKmoLsKCwa2YHQrkEsjHNlr6rk8UiaXFvTvFoeFNXnupnJO1T5sUQgGkw
 hKbg==
X-Gm-Message-State: AOJu0Yzf6IBy9E07JkRlzpJIgvwftyIaoxXo6LObbomEhIRDqkTWiC6L
 kykIN6JKhnpghp1nOE0nJILBBbmWr+IihdqWnfuhYvcVJreO8x27tridyZFbZk/Ko1axYGNiZG4
 oqyVBYrrsaCUm4k1PuZe/TLWdZn5wWWhuvUj1fuOKsB3TOElVhF9yVSqvIvgpwBxY8JgAh022Y1
 AU1K6dAmR/g5pbFzyN+yLNjfM4U9Mw0MHiazuI
X-Received: by 2002:a17:906:1190:b0:a59:c963:835 with SMTP id
 n16-20020a170906119000b00a59c9630835mr1545289eja.33.1714983059052; 
 Mon, 06 May 2024 01:10:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBrSG+nyW00Kd6wl1StsD8SbWs4hdUjDF1HtpDSY1J2LDhoLe+1Jyot+0vb6cQ9YYFsTRMjQ==
X-Received: by 2002:a17:906:1190:b0:a59:c963:835 with SMTP id
 n16-20020a170906119000b00a59c9630835mr1545279eja.33.1714983058735; 
 Mon, 06 May 2024 01:10:58 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 n26-20020a170906119a00b00a59cd12c9c6sm1055636eja.116.2024.05.06.01.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 01:10:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	zhao1.liu@intel.com
Subject: [PATCH v2 20/25] target/i386: move BSWAP to new decoder
Date: Mon,  6 May 2024 10:09:52 +0200
Message-ID: <20240506080957.10005-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506080957.10005-1-pbonzini@redhat.com>
References: <20240506080957.10005-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c      |  4 +++-
 target/i386/tcg/decode-new.c.inc |  9 +++++++++
 target/i386/tcg/emit.c.inc       | 11 +++++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index a80021930bf..87ecf082316 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3206,7 +3206,9 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
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
index 7528e9e4f07..e65fa208a43 100644
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
index a48ff1536a4..c826adbbbb8 100644
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


