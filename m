Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7F1C41513
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 06:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKu2u-0008UY-Un; Sat, 22 Jun 2024 02:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu2s-0008Nl-Nz
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKu2r-0006Nu-0N
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 02:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719036974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BxjCAp37ACaCDuTWQ1sr5np/1pD6k22WJCg4E5pz3xA=;
 b=D1upOqMKcf0ld+Q0nDHxKnU8+KYjKgvGXsCT3wo84c7s1kZFMEYBNdnRjo1r2jWNvTBpad
 mFUhCrppJYF8hw0EZGs9xk79Z9RUP48GBDyoVZNWda9OWam0bQ9jQDRtFTGgPCRcdjYHPw
 w2ZnNbVmiwARz0A8IK2hLQ1kBnhoeFY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-EW5UL2RpNXCn4k_hHMG_TA-1; Sat, 22 Jun 2024 02:16:10 -0400
X-MC-Unique: EW5UL2RpNXCn4k_hHMG_TA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a71e1625bdbso1951166b.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 23:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719036967; x=1719641767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BxjCAp37ACaCDuTWQ1sr5np/1pD6k22WJCg4E5pz3xA=;
 b=xSaeAlr3o0zEH/ca3ro6YZpHsBbCDTgwHp5Zqz9lySzKFL+yO6wbHoo+XMkfBunUfR
 GJjqcxgNX+odaqLqQ2NNBTxS96k6NJTn0V/fH7jnO2QRxonUxSmHetCMpAl6qWAcYvs0
 LZKcarP7JOrd+KsqGBiN23a5CIlKf2A+GL9USeb5hpiUCHlnp+sLN75K5jexaROO7YMu
 T4coTKaHvOoSmEqkuALr7v76VCEmvqvyClY6ZJES6uJ9RJ+lJ4Jw2eRUmexDYoxFllnv
 lXTzA0vw7EMChHgywnHntD63hvpqXyHRTEqw/ehzj8y7H9VSb00IPGeanxbRZPmmMPhe
 lZzQ==
X-Gm-Message-State: AOJu0Yzglaop/TFlmzSRU0jM7obWm0EtFeaBYhnpaXoMrSGYev0+pbjq
 9oo0ywf8ezupLUbj8kPEo99clVUvqJHFNnteuV49sDgBoR85dath3n+onhQYrVUWjn74M0q+Eu9
 F7M0UovRxSsnUOc73GTH49YUyG19zJ4+9M70gBv6DTca+jim2IuIaw1Zx8+D8kM62DR5DDC8wsN
 dl/eQp5TF31hDcS8pWBb3wRdqQRmeYHcTxKRff
X-Received: by 2002:a17:907:cc94:b0:a6f:6126:18aa with SMTP id
 a640c23a62f3a-a7165477dc4mr12694066b.67.1719036967500; 
 Fri, 21 Jun 2024 23:16:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzzPeqBHhZfqSLvWcXZXGT7wSmkocFDZR2sQ0OUZ8vmruIOMHwbRslKTSThcWe4zlts6AmZw==
X-Received: by 2002:a17:907:cc94:b0:a6f:6126:18aa with SMTP id
 a640c23a62f3a-a7165477dc4mr12692966b.67.1719036966611; 
 Fri, 21 Jun 2024 23:16:06 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fcf4bb22dsm157272266b.94.2024.06.21.23.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 23:16:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/23] target/i386: use cpu_cc_dst for CC_OP_POPCNT
Date: Sat, 22 Jun 2024 08:15:37 +0200
Message-ID: <20240622061558.530543-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240622061558.530543-1-pbonzini@redhat.com>
References: <20240622061558.530543-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

It is the only CCOp, among those that compute ZF from one of the cc_op_*
registers, that uses cpu_cc_src.  Do not make it the odd one off,
instead use cpu_cc_dst like the others.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h           | 2 +-
 target/i386/tcg/cc_helper.c | 2 +-
 target/i386/tcg/translate.c | 4 ++--
 target/i386/tcg/emit.c.inc  | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7e2a9b56aea..f54cd93b3f9 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1332,7 +1332,7 @@ typedef enum {
     CC_OP_BMILGQ,
 
     CC_OP_CLR, /* Z set, all other flags clear.  */
-    CC_OP_POPCNT, /* Z via CC_SRC, all other flags clear.  */
+    CC_OP_POPCNT, /* Z via CC_DST, all other flags clear.  */
 
     CC_OP_NB,
 } CCOp;
diff --git a/target/i386/tcg/cc_helper.c b/target/i386/tcg/cc_helper.c
index f76e9cb8cfb..301ed954064 100644
--- a/target/i386/tcg/cc_helper.c
+++ b/target/i386/tcg/cc_helper.c
@@ -107,7 +107,7 @@ target_ulong helper_cc_compute_all(target_ulong dst, target_ulong src1,
     case CC_OP_CLR:
         return CC_Z | CC_P;
     case CC_OP_POPCNT:
-        return src1 ? 0 : CC_Z;
+        return dst ? 0 : CC_Z;
 
     case CC_OP_MULB:
         return compute_all_mulb(dst, src1);
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index ad1819815ab..eb353dc3c9f 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -324,7 +324,7 @@ static const uint8_t cc_op_live[CC_OP_NB] = {
     [CC_OP_ADOX] = USES_CC_SRC | USES_CC_SRC2,
     [CC_OP_ADCOX] = USES_CC_DST | USES_CC_SRC | USES_CC_SRC2,
     [CC_OP_CLR] = 0,
-    [CC_OP_POPCNT] = USES_CC_SRC,
+    [CC_OP_POPCNT] = USES_CC_DST,
 };
 
 static void set_cc_op_1(DisasContext *s, CCOp op, bool dirty)
@@ -1020,7 +1020,7 @@ static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
     case CC_OP_CLR:
         return (CCPrepare) { .cond = TCG_COND_ALWAYS };
     case CC_OP_POPCNT:
-        return (CCPrepare) { .cond = TCG_COND_EQ, .reg = cpu_cc_src };
+        return (CCPrepare) { .cond = TCG_COND_EQ, .reg = cpu_cc_dst };
     default:
         {
             MemOp size = (s->cc_op - CC_OP_ADDB) & 3;
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 11faa70b5e2..fc7477833bc 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -2804,10 +2804,10 @@ static void gen_POPA(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_POPCNT(DisasContext *s, X86DecodedInsn *decode)
 {
-    decode->cc_src = tcg_temp_new();
+    decode->cc_dst = tcg_temp_new();
     decode->cc_op = CC_OP_POPCNT;
 
-    tcg_gen_mov_tl(decode->cc_src, s->T0);
+    tcg_gen_mov_tl(decode->cc_dst, s->T0);
     tcg_gen_ctpop_tl(s->T0, s->T0);
 }
 
-- 
2.45.2


