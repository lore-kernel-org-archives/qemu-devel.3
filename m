Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6306BC0218C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 09:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taXNY-0004SS-Je; Wed, 22 Jan 2025 04:50:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1taXNW-0004Rq-D7
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 04:50:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1taXNU-0008NT-Tf
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 04:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737539426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Zex2ldgIzvw4izBjigvsHNUrg0z9NxD1+oJuN6ssmbU=;
 b=c5L+O4F8/qAYXkmOvtA1u/8X7+dwpobwMQxVOE6a7zSe3fzfNP5qpZgxpty/BogLlihZ1Z
 tAkTTUPcs3K7t1O6CzEj1JZZWqY1yNrO7+SRU9wCZBdlf9C5sflSNBjepkcVXFuUQCc4Iu
 6h7HSjxZymviVmvqOjio4guqAGeim3U=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-XvqD8hoKMom1ww15kF_OSg-1; Wed, 22 Jan 2025 04:50:22 -0500
X-MC-Unique: XvqD8hoKMom1ww15kF_OSg-1
X-Mimecast-MFC-AGG-ID: XvqD8hoKMom1ww15kF_OSg
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5d3f55f8f3aso8214546a12.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 01:50:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737539421; x=1738144221;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zex2ldgIzvw4izBjigvsHNUrg0z9NxD1+oJuN6ssmbU=;
 b=rt8BbkF4YfnokUhSsmS6dMkWYSl2VsCtj5rGk0h+NGEZKRcbQWS3rK0/M1y3YYwx9/
 GjUB+zc+pIDtirumYd5JA2XFl+kZYFFJ+nmTARFm+rZtteqDAH4a+XNaiaWYo0BZmqog
 +bePGMBB3Mf36cFzpSQ2INWmRZQxzC5hZIwRZxEXYyGUUibd7u2iIS/RMAX8WUjnrs+F
 6jv9KySgXuXl2D4KKFU1/lqngINezs1M34fgfc8CtteIfn1TwlksgY2/EBMC/7yibmxx
 vua5ncR/MokSKmaDmGqjvuM1n1f8Kuplu+bHcWdsCxz6iSwZWELiqU+h6XVCzmiPlFcP
 vJ1Q==
X-Gm-Message-State: AOJu0Ywofn3eaWVLlC7TeJ1wvvutvFDcSFgTO8XXJEdTqqXczd5YFfNe
 i/LDi0rg/4hE7s2CYf6hOfj8mzs6Dhtc2rW2WTJ9a4LF1E9dFGgp82qweFrLRsvU1MAq6t4jDbl
 LBGwDKAgBWkUGWX+gtTINvwd8/Z5XV6LxJzp7J+R28f9njw9EKAQberNG22ka3fU8lKyo7NKZQt
 kyC1Tj9vvQAjuYyQqB2ONs5WgqeSuvKXBM412izqw=
X-Gm-Gg: ASbGncuEXV4jO9wnqBrRroBvNfTaiqM6a0sQYacv8tFVmlE9emJe6rCvBaeFehdRXNF
 /VKJZ4AYZsZu77axZteqsKS6K6zHU6Qk4I/rUY/fCDEH9jykyUEkDP36NJvkNVqptZ9uORritzK
 zuHzqIbf1zBgoObXbeoljP+az6c4jryt9ZqIpZ6tAEzQJlLu3XzhTfdtCCif94OhMo+3CD0Wyv3
 /uAFCR9VW1MnbEDUcnUYD7wIdL3mWoe84PDv07aFlVlA936W0jUmXv9bXhTrZjjR6e+F1w+078=
X-Received: by 2002:a05:6402:42cf:b0:5d9:a55:810c with SMTP id
 4fb4d7f45d1cf-5db7d2dc320mr20461949a12.5.1737539420815; 
 Wed, 22 Jan 2025 01:50:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtQb4ljOy7WXai1d4L3IYEdgJrey9+dYnyubWfQ6S7ucZ08MgtMhDvE1+jBFfb6dZT5Cl/dg==
X-Received: by 2002:a05:6402:42cf:b0:5d9:a55:810c with SMTP id
 4fb4d7f45d1cf-5db7d2dc320mr20461930a12.5.1737539420384; 
 Wed, 22 Jan 2025 01:50:20 -0800 (PST)
Received: from [192.168.10.47] ([176.206.124.70])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dbf31c3e7csm906208a12.3.2025.01.22.01.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 01:50:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] target/i386: extract common bits of gen_repz/gen_repz_nz
Date: Wed, 22 Jan 2025 10:50:17 +0100
Message-ID: <20250122095018.2471009-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Now that everything has been cleaned up, look at DF and prefixes
in a single function, and call that one from gen_repz and gen_repz_nz.

Based-on: <20241215090613.89588-1-pbonzini@redhat.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
	This was requested in the review of "target/i386: optimize string operations"

 target/i386/tcg/translate.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 9f4d3ebbd95..9b2fde5eb28 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -688,14 +688,6 @@ static inline void gen_string_movl_A0_EDI(DisasContext *s)
     gen_lea_v_seg(s, cpu_regs[R_EDI], R_ES, -1);
 }
 
-static inline TCGv gen_compute_Dshift(DisasContext *s, MemOp ot)
-{
-    TCGv dshift = tcg_temp_new();
-    tcg_gen_ld32s_tl(dshift, tcg_env, offsetof(CPUX86State, df));
-    tcg_gen_shli_tl(dshift, dshift, ot);
-    return dshift;
-};
-
 static TCGv gen_ext_tl(TCGv dst, TCGv src, MemOp size, bool sign)
 {
     if (size == MO_TL) {
@@ -1446,29 +1438,31 @@ static void do_gen_rep(DisasContext *s, MemOp ot, TCGv dshift,
     gen_jmp_rel_csize(s, 0, 1);
 }
 
-static void gen_repz(DisasContext *s, MemOp ot,
-                     void (*fn)(DisasContext *s, MemOp ot, TCGv dshift))
-
+static void do_gen_string(DisasContext *s, MemOp ot,
+                          void (*fn)(DisasContext *s, MemOp ot, TCGv dshift),
+                          bool is_repz_nz)
 {
-    TCGv dshift = gen_compute_Dshift(s, ot);
+    TCGv dshift = tcg_temp_new();
+    tcg_gen_ld32s_tl(dshift, tcg_env, offsetof(CPUX86State, df));
+    tcg_gen_shli_tl(dshift, dshift, ot);
 
     if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-        do_gen_rep(s, ot, dshift, fn, false);
+        do_gen_rep(s, ot, dshift, fn, is_repz_nz);
     } else {
         fn(s, ot, dshift);
     }
 }
 
+static void gen_repz(DisasContext *s, MemOp ot,
+                     void (*fn)(DisasContext *s, MemOp ot, TCGv dshift))
+{
+    do_gen_string(s, ot, fn, false);
+}
+
 static void gen_repz_nz(DisasContext *s, MemOp ot,
                         void (*fn)(DisasContext *s, MemOp ot, TCGv dshift))
 {
-    TCGv dshift = gen_compute_Dshift(s, ot);
-
-    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
-        do_gen_rep(s, ot, dshift, fn, true);
-    } else {
-        fn(s, ot, dshift);
-    }
+    do_gen_string(s, ot, fn, true);
 }
 
 static void gen_helper_fp_arith_ST0_FT0(int op)
-- 
2.47.1


