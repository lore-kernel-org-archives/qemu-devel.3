Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B21C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 16:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruEa0-0000Xs-7U; Tue, 09 Apr 2024 12:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruEZW-0000J4-Gu
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:43:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruEZJ-00080g-VB
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712681011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GKj06Q1UJNgdnNLxDCGMfDe5mX6d9Zq1tXhx357YV8A=;
 b=b3r/9InZOEpb11j9ToUHkB1bASrARKsiSETAjMv9h0GihQ3p5tZXznEvjoZdpFmXkY1q/w
 8M84n6pkEIW7KD5i3dME60H37o1J2kbrtLJcWAj2GfwXIE5kK0Yg5niJtVViAlbPuzOI2S
 mMqSiMwAP9+HQka34aWqjXJ9lDL+DJo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-SE7KX8kIONWvqWp1tpxwHA-1; Tue, 09 Apr 2024 12:43:30 -0400
X-MC-Unique: SE7KX8kIONWvqWp1tpxwHA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4162b93067dso22902785e9.3
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 09:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712681008; x=1713285808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GKj06Q1UJNgdnNLxDCGMfDe5mX6d9Zq1tXhx357YV8A=;
 b=um1n836DGdmJkASz5GzLm0qlkx3QzEfbyPAofVOFPHRBoF40MbPXx0pGlxBXqx1W5a
 HqYNeG7FFzmoUw6FIWPNNJMlhYgUnRFb7lf3Qc6/ijWmGtqF7fEYNjGsYK9qtvnVDY63
 1XDjyn7QtzP5N1snEQ9H5OEV47FCpmbQ/iPpxavlpq3coRhc3dn/onhNp+nFbjZXTmOk
 WNlQovrO5rwJLWMqNGC8XCVCz/x5dolkuxKxcyM/nt2P/JSWd22/DjitMYixjrjzaNAr
 cafAdXniBRBy7Hby7N8nGnPOO63lR2PBK1+DyVAGeasXhP/V29RcClWUfnVgFbLR6yKy
 ObeA==
X-Gm-Message-State: AOJu0YxV0iQIDpHhgOlJQu/DVqlCwktQV2sWVvugCfwiJqvmeW5ZYtO9
 g/qhLByeJ/BpsR1Gc/U4yMOlGpKcWwZJ9dmnlS+IXxfUF/aZQZO0R9R8GXaULS6WCDRO1WGU84O
 fc1JvpfEIdZ/dApZEFfnlC31FY4H1ShOrXSj9+RSAdTKH9amEzz6uxORpRGfnFSzQvd+srszl+s
 v3WQX22/zhM/2ZIE5wHBPnRQ4F0enYTIGF3VBb
X-Received: by 2002:a05:600c:1c8d:b0:416:99bb:f7d8 with SMTP id
 k13-20020a05600c1c8d00b0041699bbf7d8mr191135wms.2.1712681008179; 
 Tue, 09 Apr 2024 09:43:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnufMPcdiTQXDHgqbeClFYuABzJhUOh06CYIIn9ENjxatTXZbyUNcLSSBKMh4WryrsQeE8mQ==
X-Received: by 2002:a05:600c:1c8d:b0:416:99bb:f7d8 with SMTP id
 k13-20020a05600c1c8d00b0041699bbf7d8mr191118wms.2.1712681007677; 
 Tue, 09 Apr 2024 09:43:27 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 r10-20020a05600c35ca00b0041622c88852sm21410520wmq.16.2024.04.09.09.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 09:43:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH for-9.1 01/19] target/i386: use TSTEQ/TSTNE to test low bits
Date: Tue,  9 Apr 2024 18:43:05 +0200
Message-ID: <20240409164323.776660-2-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

When testing the sign bit or equality to zero of a partial register, it
is useful to use a single TSTEQ or TSTNE operation.  It can also be used
to test the parity flag, using bit 0 of the population count.

Do not do this for target_ulong-sized values however; the optimizer would
produce a comparison against zero anyway, and it avoids shifts by 64
which are undefined behavior.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 28 ++++++++++++++++++++--------
 target/i386/tcg/emit.c.inc  |  5 ++---
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 76a42c679c7..b7117393961 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -928,11 +928,21 @@ typedef struct CCPrepare {
     bool no_setcond;
 } CCPrepare;
 
+static CCPrepare gen_prepare_sign_nz(TCGv src, MemOp size)
+{
+    if (size == MO_TL) {
+        return (CCPrepare) { .cond = TCG_COND_LT, .reg = src, .mask = -1 };
+    } else {
+        return (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = src, .mask = -1,
+                             .imm = 1ull << ((8 << size) - 1) };
+    }
+}
+
 /* compute eflags.C to reg */
 static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
 {
     TCGv t0, t1;
-    int size, shift;
+    MemOp size;
 
     switch (s->cc_op) {
     case CC_OP_SUBB ... CC_OP_SUBQ:
@@ -967,9 +977,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
     case CC_OP_SHLB ... CC_OP_SHLQ:
         /* (CC_SRC >> (DATA_BITS - 1)) & 1 */
         size = s->cc_op - CC_OP_SHLB;
-        shift = (8 << size) - 1;
-        return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_src,
-                             .mask = (target_ulong)1 << shift };
+        return gen_prepare_sign_nz(cpu_cc_src, size);
 
     case CC_OP_MULB ... CC_OP_MULQ:
         return (CCPrepare) { .cond = TCG_COND_NE,
@@ -1029,8 +1037,7 @@ static CCPrepare gen_prepare_eflags_s(DisasContext *s, TCGv reg)
     default:
         {
             MemOp size = (s->cc_op - CC_OP_ADDB) & 3;
-            TCGv t0 = gen_ext_tl(reg, cpu_cc_dst, size, true);
-            return (CCPrepare) { .cond = TCG_COND_LT, .reg = t0, .mask = -1 };
+            return gen_prepare_sign_nz(cpu_cc_dst, size);
         }
     }
 }
@@ -1077,8 +1084,13 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
     default:
         {
             MemOp size = (s->cc_op - CC_OP_ADDB) & 3;
-            TCGv t0 = gen_ext_tl(reg, cpu_cc_dst, size, false);
-            return (CCPrepare) { .cond = TCG_COND_EQ, .reg = t0, .mask = -1 };
+            if (size == MO_TL) {
+                return (CCPrepare) { .cond = TCG_COND_EQ, .reg = cpu_cc_dst,
+                                     .mask = -1 };
+            } else {
+                return (CCPrepare) { .cond = TCG_COND_TSTEQ, .reg = cpu_cc_dst,
+                                     .mask = -1, .imm = (1ull << (8 << size)) - 1 };
+            }
         }
     }
 }
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 6bcf88ecd71..0e00f6635dd 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1209,7 +1209,7 @@ static void gen_CMPccXADD(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
         [JCC_Z] = TCG_COND_EQ,
         [JCC_BE] = TCG_COND_LEU,
         [JCC_S] = TCG_COND_LT,  /* test sign bit by comparing against 0 */
-        [JCC_P] = TCG_COND_EQ,  /* even parity - tests low bit of popcount */
+        [JCC_P] = TCG_COND_TSTEQ,  /* even parity - tests low bit of popcount */
         [JCC_L] = TCG_COND_LT,
         [JCC_LE] = TCG_COND_LE,
     };
@@ -1260,8 +1260,7 @@ static void gen_CMPccXADD(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
     case JCC_P:
         tcg_gen_ext8u_tl(s->tmp0, s->T0);
         tcg_gen_ctpop_tl(s->tmp0, s->tmp0);
-        tcg_gen_andi_tl(s->tmp0, s->tmp0, 1);
-        cmp_lhs = s->tmp0, cmp_rhs = tcg_constant_tl(0);
+        cmp_lhs = s->tmp0, cmp_rhs = tcg_constant_tl(1);
         break;
 
     case JCC_S:
-- 
2.44.0


