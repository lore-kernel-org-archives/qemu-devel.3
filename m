Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF94C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 05:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTwpv-0001xM-Cn; Wed, 17 Jul 2024 01:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTwpl-0001bU-DN
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:04:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTwph-0001zy-E0
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 01:04:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721192644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z7mvDdgjDew4bcumhdVippQPV/asFmWc10+8vble7j0=;
 b=UUh65Mrtol54rXsfbSPDBG0sFUE2vwozWhKptDt2mzl0diOK7J+/pJwWXbYOTwHIYjzKZU
 TAlX5kpgmS2sROgWCPKC8xqchICDp4W8UpV0KagZlkTTEQcf8XmybylB/9cxKInAK5YRur
 RV5/XOkWUbNH4WnM2eXhz1oN/2Qy0m0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-5FtpdzEWMcKbAAaMyBCLHA-1; Wed, 17 Jul 2024 01:04:01 -0400
X-MC-Unique: 5FtpdzEWMcKbAAaMyBCLHA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-426724679f0so1650105e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 22:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721192640; x=1721797440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z7mvDdgjDew4bcumhdVippQPV/asFmWc10+8vble7j0=;
 b=qqAgStfuicBj3ZuYFl/PnrU8hzHAYl1fMOyykMVMo9W/bHGZzfwxz9lrW+XEDPObHF
 4/yy2OX+FYRsaSGa2NIQLMs2znUFHM2cjIKFnxKbnpl0rlpnBauVdI96/ivro1WSqfic
 MOspoN/LdmiD1KbDi3Ju4xBVNG37g1ania31iEvTWh2Q7HIL4hQQ+Jb4pfan6Ca4f/5J
 0d3W7jAf/Q9t1nwu+ClxRl9zj44c5itw7DOkYujxhGUIy/1sAJi9TzrcitIIi+UieJV/
 vvIUtT/brm400R+/zCU02F4GSp/Li69Hd5OUAdia0kniJIqBXBcDK9VJKEHVX6vlY1dD
 BHpA==
X-Gm-Message-State: AOJu0YyH6W1w6EB7Ldx6WcC5+/8B1WaAbZFICghrBiu/LdABNwJmUmKj
 iiSvHbcXtewIiBFOpf50YGEiv2aBjYe1t/ypVTp8Bq9c1T19BGU2sw2aNijcUFzkqQFUhrj+yh6
 53b7GpDWc3ntV+bOwkFurHSs9k0GhRbsD5DXfkxirOWGYUKpNMsxnz1ArY7hzyU7d9EdKB0XrMM
 pmC3XHkN69Py0cWgnO0eIhOLNkes0O8NeTKg7y
X-Received: by 2002:a05:6000:d86:b0:367:895f:619e with SMTP id
 ffacd0b85a97d-368273d1a7bmr2772871f8f.11.1721192639804; 
 Tue, 16 Jul 2024 22:03:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJ2x2hU0tVVsbdY46jhdNJmMN4aGSAQdGHTf4Aoi3HyRO7SmX84i0JAOlI65T1+Y4wjDKkRg==
X-Received: by 2002:a05:6000:d86:b0:367:895f:619e with SMTP id
 ffacd0b85a97d-368273d1a7bmr2772859f8f.11.1721192639422; 
 Tue, 16 Jul 2024 22:03:59 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5e7751asm157155705e9.3.2024.07.16.22.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 22:03:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 11/20] target/i386/tcg: fix POP to memory in long mode
Date: Wed, 17 Jul 2024 07:03:21 +0200
Message-ID: <20240717050331.295371-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717050331.295371-1-pbonzini@redhat.com>
References: <20240717050331.295371-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


