Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7740DC54E41
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfHm0-0002F3-Ft; Wed, 28 Feb 2024 06:06:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfHlx-0002EN-ON
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:06:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rfHlw-00006e-BE
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:06:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709118407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Adv1FeZ7IQtv7tUa449DMgYXIFGMSB/pjlycFke2cbM=;
 b=iTVjOUh7eKOCJ+F9qYqRQfyLuiaITmtdEhFz0nx1I3I/RGxjwXv1UYpet0QPvd789YC8HB
 z3S4JlNs3krPP92sNVPfW5SzCKA5YfthV0tmBWpBSOqi4RHpBdBWXFO2aHPNILeCfaUfxs
 iKxpkePZudWpfP1Sunpn/GwNEXK6f6Y=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613--CFiGRCIOEqv5FP8tiNkSg-1; Wed, 28 Feb 2024 06:06:45 -0500
X-MC-Unique: -CFiGRCIOEqv5FP8tiNkSg-1
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-36516d55c5fso48323285ab.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:06:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709118404; x=1709723204;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Adv1FeZ7IQtv7tUa449DMgYXIFGMSB/pjlycFke2cbM=;
 b=U0iRdzM6LsCuT5Z80Mvl230xe34VBIHk2udwDkZDWIFuQPVRYvLveEy5HH6Toeh1h7
 L0SoTBg4/b9VCbTKi9kJTqCRRbrjVSdhMXtuB8mjhGhkyb2E4RSs+ojVoKpv009Hwpxu
 NEHok5425ERu/m22hI/sPX8k93R0Jiqq3sphttGdbYx3oXrUsp2/4tydOycLrqB5mWaj
 uVnO6HF8/tUF2/qOBulFDrXyifZGNGx+M1wjO3fw9qUjWZmzyW2gKPImf8H8uPllu5YO
 ht8szklktCf9uYd8umZumJV850MXhs5mi0NAs2LMt9jA3zEOjoKd8hkVReM/8Xa5qM5d
 AO7A==
X-Gm-Message-State: AOJu0YwmjOhZy7F73MLjiQPuug563bv+DUEpoE7UWOxyYhQqqL0rqyUR
 u/sLn+RVEo4wqluC1yPPsclAJwtfivBJMHes/HaAnx4iiVRDJ9cwHtid/vryr1kUIkiZCPyVJLH
 hTPJXiiHFlwYx4YYFz+OFNo6sEkRIW19TW/E5/O2uPHLd+nX4895A1R3mchMdCySP5M32BIo9TF
 DbRJOh+i27E19tUs2J2MkpTTB9/OZSwU/ZYr8u
X-Received: by 2002:a92:cf4d:0:b0:365:13c0:1bc3 with SMTP id
 c13-20020a92cf4d000000b0036513c01bc3mr12809656ilr.20.1709118404389; 
 Wed, 28 Feb 2024 03:06:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuHXd2Kjd9FJHmXrSn7ukxh+8gNE0HPi0ZvMN2ky7Lsa6gZBQrKen4/h88cj01+ezMsNlm8A==
X-Received: by 2002:a92:cf4d:0:b0:365:13c0:1bc3 with SMTP id
 c13-20020a92cf4d000000b0036513c01bc3mr12809633ilr.20.1709118404046; 
 Wed, 28 Feb 2024 03:06:44 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 eq21-20020a0566384e3500b00474874acfe1sm1482377jab.172.2024.02.28.03.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 03:06:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <pbonzini@redhat.com>
Subject: [PATCH] tcg/optimize: fix uninitialized variable
Date: Wed, 28 Feb 2024 12:06:41 +0100
Message-ID: <20240228110641.287205-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The variables uext_opc and sext_opc are used without initialization if
TCG_TARGET_extract_i{32,64}_valid returns false.  The result, depending
on the compiler, might be the generation of extract and sextract opcodes
with invalid offset and count, or just random data in the TCG opcode
stream.

Fixes: ceb9ee06b71 ("tcg/optimize: Handle TCG_COND_TST{EQ,NE}", 2024-02-03)
Cc: Richard Henderson <pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tcg/optimize.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 79e701652bf..752cc5c56b6 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2102,7 +2102,8 @@ static bool fold_remainder(OptContext *ctx, TCGOp *op)
 
 static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 {
-    TCGOpcode and_opc, sub_opc, xor_opc, neg_opc, shr_opc, uext_opc, sext_opc;
+    TCGOpcode and_opc, sub_opc, xor_opc, neg_opc, shr_opc;
+    TCGOpcode uext_opc = 0, sext_opc = 0;
     TCGCond cond = op->args[3];
     TCGArg ret, src1, src2;
     TCGOp *op2;
-- 
2.43.2


