Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3183FC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4IV3-0005NZ-Oz; Tue, 07 May 2024 06:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IUm-0004uL-FL
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4IUi-0002oK-Cq
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715079383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CEpDyUKulqMJAILlx9bT2KyS4H1JorB2/FN7/WZ3adA=;
 b=LGIUZMRkhltjXwIfUQ2yxkO84ziQ23dZrepxGohEDEllRq50yO1MKoeIzcnEhCrjAmGqvo
 xHnLp/oh1+Y6rMpoQ7m2sWDS8k/Kh4iFuBftcoHQigH16MKyMP/axwiHWn87o75G56vS7Q
 gSwYPa5W29hOQeTNbzXvMnCEke1/g9k=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-x5gpE6tjM_KFbcsI1WuAUw-1; Tue, 07 May 2024 06:56:22 -0400
X-MC-Unique: x5gpE6tjM_KFbcsI1WuAUw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-51b0eed7614so2402840e87.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 03:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715079380; x=1715684180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CEpDyUKulqMJAILlx9bT2KyS4H1JorB2/FN7/WZ3adA=;
 b=TTSUJ19vIpE2er8NaI+9301zH50Nf0/wHww8tbpoQLknj3K5y1Hf5y9y/rzM/6tMPV
 MPFOqpVnyyB7VSA/JT0QpELwzgMzzB6Ho0D36X+Dw8pe7jFvP8e3DONkzx1Wn+2Qr6F4
 6qT2LCLiGEUeKLtRfOStP7CcPANa3vqNJi/mpV69tonxyyULBySeim0aT+mvw73kknip
 t8JTmwlY+QA9NLoz7x/vZy61dVQ78vwxd1G3yFTM7KvFDd+LDvGoKxBELqBC9hwfD1FC
 DcKMtFloYPVBetWi3uqpYlRsLUrAq6JZQ22uVGQMB8qBVfw3T3FSJ2DovDqYZLgq3Esr
 ScbA==
X-Gm-Message-State: AOJu0YyD1cVaNlUdFdEx38vgpms1SKdG/IT8LIDCcSssI0QLZ/6Z4Ue0
 WSQ9NiBmKGpr6699AtFWpnLXax1mN1mWzphzVjqZCau2Oe20WMcGMjxpupDQtfsPAW1v9RI/RPj
 sZ+zhIClUFdyhYKABTVE1kGYa6jKPtRE3ZQBLHIxZfFM0Qz80ZT9y3dwQRrhi+WnbbeW76r6XOq
 PxgWtFyTFaksQweGffouqnOlwfDeqYahogWxY1
X-Received: by 2002:a05:6512:2117:b0:51b:bb22:f21 with SMTP id
 q23-20020a056512211700b0051bbb220f21mr10033122lfr.38.1715079380357; 
 Tue, 07 May 2024 03:56:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiK2GpYmHcvFADHi9k2ipPDXaOoA1FY0C18Rr59sct7ycqS+VKLxHzzAQMxSakVDuIHMOFag==
X-Received: by 2002:a05:6512:2117:b0:51b:bb22:f21 with SMTP id
 q23-20020a056512211700b0051bbb220f21mr10033105lfr.38.1715079379969; 
 Tue, 07 May 2024 03:56:19 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 gf12-20020a170906e20c00b00a5884e0ad1asm6292989ejb.33.2024.05.07.03.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 03:56:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 15/26] target/i386: allow instructions with more than one
 immediate
Date: Tue,  7 May 2024 12:55:27 +0200
Message-ID: <20240507105538.180704-16-pbonzini@redhat.com>
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

While keeping decode->immediate for convenience and for 4-operand instructions,
store the immediate in X86DecodedOp as well.  This enables instructions
with more than one immediate such as ENTER.  It can also be used for far
calls and jumps.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
index a64186b8957..fc065caae79 100644
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
+    assert(op->unit == X86_OP_MMX || op->unit == X86_OP_SSE);
     if (op->v_ptr) {
         return op->v_ptr;
     }
-- 
2.45.0


