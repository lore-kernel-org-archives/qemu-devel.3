Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA969CD128A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 16:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruEaY-0000mR-UN; Tue, 09 Apr 2024 12:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruEa0-0000aK-Gg
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:44:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ruEZh-000838-1h
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712681032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tJUYhX/+ukGLYf+DwUCr8Vts+Fg0GPkTuEhT/LD1lYg=;
 b=QEGFmfHjoJt0qz0HR7erIrzN8MjajTGhdpoBwdivgQpNhlrTtjPed1KmJ21aj/qcdzRdsQ
 HwemZoWpD5ABdOnsbzT+4thDi6pW5L/mEWSqcModz4BE0nhL0WDPvR2dZYVhRkbtWmP+Fq
 V+yjQHmy5c5edCjFo1fU/r5eikh8Wyc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-aCiibbLOPMKCby_yQW2TKw-1; Tue, 09 Apr 2024 12:43:50 -0400
X-MC-Unique: aCiibbLOPMKCby_yQW2TKw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-416b91d1328so2313045e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 09:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712681029; x=1713285829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tJUYhX/+ukGLYf+DwUCr8Vts+Fg0GPkTuEhT/LD1lYg=;
 b=bduxPTmzIMx2w68Iw769wnzOWevqgDG1qj82QyLOn7NQ9Yr7q9avms0MAFJ0XGE1M8
 SxX197iCRrFWqq9B2AOMu4uDkDvECaRTv17KWtzaMkixKSLPIBJe8F23oMlIHuJoNe7Q
 gR8X+dk0yr2+3AwOWZ2Ye4NIagmVDrAbnjF2UiXpjEv0IcPcrk3omZBu2SEP+bTfDPJU
 KKrTNXcyloKHUdFUkb2h+6G4jqi5suyC7GxT2suPPElWrTda2QAQNXuiJobhUhy8iUtq
 0EQTNIJ3rOYirXKR6VqhH9RFwdqKlq1puS/bd5slII5dSOQdY4F96ugF+7TRpmQ1ZOp0
 +uaA==
X-Gm-Message-State: AOJu0Yz+6Aq0XQLEIkN1XtSxDOyNb7Hk08Enn+W8zz+21IWQ8m3q72Ck
 yBZbQ0L+wdC3heOv3cdfAjGeuoA1Dq+CwzLIPhgjKRYH9zKSi4U60gBGn4HFumrdh6B913hPP6W
 lyUWMgi1hFogUPWj7kUT/qD8xJ/eHTNDRpxmhnWnTdQGYfPELar7Jo37ybuldiy6y2Z9hzLNRbt
 3Ar1ztcCvDKOMcgtgik7bz5DCHNmb/FqiwdBVt
X-Received: by 2002:a5d:64e9:0:b0:343:4c4a:2a8b with SMTP id
 g9-20020a5d64e9000000b003434c4a2a8bmr228921wri.34.1712681028806; 
 Tue, 09 Apr 2024 09:43:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrQM9GH1p2cO6CLeDiOoCxWxyRoseISnG3AB49lOxYRHZJbVXX0t00ZdRaZiqW7HN7A6mFyA==
X-Received: by 2002:a5d:64e9:0:b0:343:4c4a:2a8b with SMTP id
 g9-20020a5d64e9000000b003434c4a2a8bmr228910wri.34.1712681028514; 
 Tue, 09 Apr 2024 09:43:48 -0700 (PDT)
Received: from avogadro.local ([151.95.152.232])
 by smtp.gmail.com with ESMTPSA id
 c11-20020adffb4b000000b00345bcb4fdb9sm5206475wrs.16.2024.04.09.09.43.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 09:43:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-9.1 08/19] target/i386: allow instructions with more than
 one immediate
Date: Tue,  9 Apr 2024 18:43:12 +0200
Message-ID: <20240409164323.776660-9-pbonzini@redhat.com>
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

While keeping decode->immediate for convenience and for 4-operand instructions,
store the immediate in X86DecodedOp as well.  This enables instructions
with more than one immediate such as ENTER.  It can also be used for far
calls and jumps.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.h     | 17 ++++++++++++-----
 target/i386/tcg/decode-new.c.inc |  2 +-
 target/i386/tcg/emit.c.inc       |  4 +++-
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 15e6bfef4b1..8ffde8d1cd6 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -271,16 +271,23 @@ typedef struct X86DecodedOp {
     bool has_ea;
     int offset;   /* For MMX and SSE */
 
-    /*
-     * This field is used internally by macros OP0_PTR/OP1_PTR/OP2_PTR,
-     * do not access directly!
-     */
-    TCGv_ptr v_ptr;
+    union {
+	target_ulong imm;
+        /*
+         * This field is used internally by macros OP0_PTR/OP1_PTR/OP2_PTR,
+         * do not access directly!
+         */
+        TCGv_ptr v_ptr;
+    };
 } X86DecodedOp;
 
 struct X86DecodedInsn {
     X86OpEntry e;
     X86DecodedOp op[3];
+    /*
+     * Rightmost immediate, for convenience since most instructions have
+     * one (and also for 4-operand instructions).
+     */
     target_ulong immediate;
     AddressParts mem;
 
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 1e792426ff5..c6fd7a053bd 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1473,7 +1473,7 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
     case X86_TYPE_I:  /* Immediate */
     case X86_TYPE_J:  /* Relative offset for a jump */
         op->unit = X86_OP_IMM;
-        decode->immediate = insn_get_signed(env, s, op->ot);
+        decode->immediate = op->imm = insn_get_signed(env, s, op->ot);
         break;
 
     case X86_TYPE_L:  /* The upper 4 bits of the immediate select a 128-bit register */
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index a64186b8957..a27d3040e03 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -259,7 +259,7 @@ static void gen_load(DisasContext *s, X86DecodedInsn *decode, int opn, TCGv v)
         }
         break;
     case X86_OP_IMM:
-        tcg_gen_movi_tl(v, decode->immediate);
+        tcg_gen_movi_tl(v, op->imm);
         break;
 
     case X86_OP_MMX:
@@ -283,6 +283,8 @@ static void gen_load(DisasContext *s, X86DecodedInsn *decode, int opn, TCGv v)
 static TCGv_ptr op_ptr(X86DecodedInsn *decode, int opn)
 {
     X86DecodedOp *op = &decode->op[opn];
+
+    assert (op->unit == X86_OP_MMX || op->unit == X86_OP_SSE);
     if (op->v_ptr) {
         return op->v_ptr;
     }
-- 
2.44.0


