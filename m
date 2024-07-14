Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640C6C3DA4A
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2024 11:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSx8C-0004dR-5u; Sun, 14 Jul 2024 07:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sSx89-0004Vr-Hd
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 07:11:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sSx86-00022k-OL
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 07:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720955452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z7mvDdgjDew4bcumhdVippQPV/asFmWc10+8vble7j0=;
 b=OszduRC5QRm8851s9dIm1KRHsmLLtzT/K9D5gh5MCsWqWl34Gnyg19FD6WbnF3+LLS+muq
 R68U92HcSIXFePp8Ffrw/DjORw0wi4u8RjbB/nk5jsgHPXV7j/zMPl37Yb6Lw1USQ6fnB0
 tp9y+76TBf5o7iZyN6Cpit8GtMPsfzg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-3ENQxU8HPKiI0D4b6nRLPQ-1; Sun, 14 Jul 2024 07:10:50 -0400
X-MC-Unique: 3ENQxU8HPKiI0D4b6nRLPQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-426703ac88dso22622485e9.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 04:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720955449; x=1721560249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z7mvDdgjDew4bcumhdVippQPV/asFmWc10+8vble7j0=;
 b=MnKDvKzMmbnUNqVTGMHcUVUATwnEBLiFL0cC/45Y44d5QCDRIG4Tacse2mzDkv0K+D
 Q7Jcd9V/WkpLOYJei31besRnfqJ9ms3/il9YOnOjgObigL+OaEuguJhViqNtrsWAFdOE
 21vcqvomsuevukIwiJMB+j1gbxN79HeBH4nYzyLZiUiGr3loQxR6eulHUWnKmBgnus2z
 EFAcEdhChYZ9UYPjrdBfCFJ+KQeEd8zl5xCt1+MiGLVQsR7U8T9mb8pvASkS36yQ0Bne
 /+EbdAo5GOAD4nzPdL8uJXhXBIOZHJSqzr5KGcK4HoKB6JrnD1DX7+aXDoQ5uyfsE7eY
 Y+ow==
X-Gm-Message-State: AOJu0Yzfmbwrkwrbb9ywao4LD3Ok1CheZOakucXvT9cMlr8zpqqrp5Th
 hEBsUKaTE7BGteSCy+jXqJzDGxaOfUrB83mOfBZOa11MFCIAf5e02Tfht3KW4B8/ap0a0g1DWE/
 WUvrj5j3wWT3UrygP6UOXP+bmc5oYwUGIRMNWq8Z1E4d4vSLodDgL2p44R6A6kidCDsyqYjLJX7
 uH8Hh3DnkNomFxi31YHJiMZJPUYfSG7HeNEaiG
X-Received: by 2002:a7b:ca4b:0:b0:426:6c7a:3a61 with SMTP id
 5b1f17b1804b1-426707cf194mr96992905e9.3.1720955448888; 
 Sun, 14 Jul 2024 04:10:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe5iVwXKpRvKcJ7T9DuyuCXUydmRnooNKkTnnRnJW/F3s6RBVCUkos0oVG9z1eAdTz8bVwBA==
X-Received: by 2002:a7b:ca4b:0:b0:426:6c7a:3a61 with SMTP id
 5b1f17b1804b1-426707cf194mr96992805e9.3.1720955448502; 
 Sun, 14 Jul 2024 04:10:48 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5e9a809sm48665495e9.28.2024.07.14.04.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jul 2024 04:10:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 01/13] target/i386/tcg: fix POP to memory in long mode
Date: Sun, 14 Jul 2024 13:10:31 +0200
Message-ID: <20240714111043.14132-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240714111043.14132-1-pbonzini@redhat.com>
References: <20240714111043.14132-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

In long mode, POP to memory will write a full 64-bit value.  However,
the call to gen_writeback() in gen_POP will use MO_32 because the
decoding table is incorrect.

The bug was latent until commit aea49fbb01a ("target/i386: use gen_writeback()
within gen_POP()", 2024-06-08), and then became visible because gen_op_st_v
now receives op->ot instead of the "ot" returned by gen_pop_T0.

Analyzed-by: Clément Chigot <chigot@adacore.com>
Fixes: 5e9e21bcc4d ("target/i386: move 60-BF opcodes to new decoder", 2024-05-07)
Tested-by: Clément Chigot <chigot@adacore.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 2 +-
 target/i386/tcg/emit.c.inc       | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 0d846c32c22..d2da1d396d5 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1717,7 +1717,7 @@ static const X86OpEntry opcodes_root[256] = {
     [0x8C] = X86_OP_ENTRYwr(MOV, E,v, S,w, op0_Mw),
     [0x8D] = X86_OP_ENTRYwr(LEA, G,v, M,v, nolea),
     [0x8E] = X86_OP_ENTRYwr(MOV, S,w, E,w),
-    [0x8F] = X86_OP_GROUPw(group1A, E,v),
+    [0x8F] = X86_OP_GROUPw(group1A, E,d64),
 
     [0x98] = X86_OP_ENTRY1(CBW,    0,v), /* rAX */
     [0x99] = X86_OP_ENTRYwr(CWD,   2,v, 0,v), /* rDX, rAX */
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index fc7477833bc..016dce81464 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -2788,6 +2788,7 @@ static void gen_POP(DisasContext *s, X86DecodedInsn *decode)
     X86DecodedOp *op = &decode->op[0];
     MemOp ot = gen_pop_T0(s);
 
+    assert(ot >= op->ot);
     if (op->has_ea || op->unit == X86_OP_SEG) {
         /* NOTE: order is important for MMU exceptions */
         gen_writeback(s, decode, 0, s->T0);
-- 
2.45.2


