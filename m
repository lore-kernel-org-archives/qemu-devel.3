Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85572C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tRA-0004AT-KP; Mon, 06 May 2024 04:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tQv-0003Yk-N9
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:10:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tQs-0002OZ-Gf
 for qemu-devel@nongnu.org; Mon, 06 May 2024 04:10:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714983045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CEpDyUKulqMJAILlx9bT2KyS4H1JorB2/FN7/WZ3adA=;
 b=J9EoXg9AL5jq+4F2AKoxTD8GXTVPqNUvmTZTdD5henau/WHIlkJIXSDpOjhn7+KGGVD7Ws
 SL6ED6rZwBFpxFaWDcF+1l3DYt+b+natNzU7oRCrf6b8G4MDQQx6/IWdEDMqgfKp/fkgAp
 Dhf37pGjzY7vDCNtsxgz5gAzMgygyfg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-28QFCKigPnShpYrX9FU6dQ-1; Mon, 06 May 2024 04:10:44 -0400
X-MC-Unique: 28QFCKigPnShpYrX9FU6dQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a59cb20ea3bso58668566b.3
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 01:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714983042; x=1715587842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CEpDyUKulqMJAILlx9bT2KyS4H1JorB2/FN7/WZ3adA=;
 b=tVMSUeg3kuQ8xf/M/COUAq+CQLoWRPeGB/3aTHdqd5Kk0PO98rJJ0MsDBqyTatdenq
 VWMz7icgdwGK1i7S7cQsxNJZwQIlyJo7K2eiHBWQLlrA6H3UMeECRHFxx3rRQLlFKd8q
 3FcFEAleG9gSUoyfM4mf+fHyahznoN4oGWrc+wWYKmTyJ2dQHEK4/C43eWrNUzxXyz6S
 LhayWK0H9woPFmY9CSemdEcyEdCHDdxeOE45JKMvi3j1Q+CrxAKpihKd3XajBss5UfWG
 HeDA90yROuKO+mY93wRppj7fH6r3seqpQxJ8THB1MH2W0Wmt8q+wF1Z7NGtIOxTjqBa/
 yQNw==
X-Gm-Message-State: AOJu0YzggE/jYHDkAcpWHT4RBw3t0YvKaXOn6PIGsgeKfakejwnyhxYn
 HjgSxMUlVCjmTh+afmlMpVFSSXrDhzpXah21iDrHeBtnrg5vKvZ2ZSczp7Em36/W3fpC86Tlc5Z
 QjLDure3s3HGMYpMOa0wiuUHfgFq1tnFlOMm6iJF76b/qslM1YZnWS9XALFE3YBGyhQwF6W0dYw
 /FGx1+LhR62R3Lk1845hKT2LktsCrhNpuZfPrm
X-Received: by 2002:a17:906:370a:b0:a59:a431:a8ce with SMTP id
 d10-20020a170906370a00b00a59a431a8cemr4280965ejc.2.1714983042208; 
 Mon, 06 May 2024 01:10:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuakf42Ew0t2TCfkDPdOhcuxlcR9R7p/Ow9gbCstWNmXvZ847gqlS4ZhCxzNC3xN2kr4Z82Q==
X-Received: by 2002:a17:906:370a:b0:a59:a431:a8ce with SMTP id
 d10-20020a170906370a00b00a59a431a8cemr4280946ejc.2.1714983041862; 
 Mon, 06 May 2024 01:10:41 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 lb21-20020a170906add500b00a59c0a65a5bsm1778121ejb.219.2024.05.06.01.10.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 01:10:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	zhao1.liu@intel.com
Subject: [PATCH v2 14/25] target/i386: allow instructions with more than one
 immediate
Date: Mon,  6 May 2024 10:09:46 +0200
Message-ID: <20240506080957.10005-15-pbonzini@redhat.com>
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


