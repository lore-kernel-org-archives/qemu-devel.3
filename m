Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5014CC83F26
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 06:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufBpQ-0000B5-GV; Fri, 25 Jul 2025 02:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ufBkY-0003y8-0Q
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 02:17:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ufBkV-0005ks-RT
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 02:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753424261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=I/GZQOo3ZaJSzz/4xyMlDsU9NRkcWDb1U9mkur5TLoE=;
 b=Es0NzdQJX2dHE+b1FvoXv/QPtVCw0R65OKO1UYfupe6+sWkOOJWUjHzj6h30tc+B6VS6iy
 exsa8HyvZYSnn8fq3EvtgwAx0Q+IfBqOtC9uWG8mW2sxr8jCK+Clx4kXHL+ytOHGzafJLD
 9hPTg/6B+ryd53nPQQ+FZiFoPbA1ttE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-H7gwHZztOceQ-FJL8tW0Mw-1; Fri, 25 Jul 2025 02:17:40 -0400
X-MC-Unique: H7gwHZztOceQ-FJL8tW0Mw-1
X-Mimecast-MFC-AGG-ID: H7gwHZztOceQ-FJL8tW0Mw_1753424259
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-454dee17a91so13086085e9.3
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 23:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753424258; x=1754029058;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I/GZQOo3ZaJSzz/4xyMlDsU9NRkcWDb1U9mkur5TLoE=;
 b=ZaPaCm7GWcxR+5A0ZgA9QJmELhrwK3c2aLQ+U+dJtWvg9PrCJprV9sqfdbLoB3jrbw
 g/XhAwREjXqXzFZeqcW1GP/Zp47nHWAy5+8wPjz53plZYiIPiuNprToMo0vdRu/nQY9G
 B2Je2RB+FXMT1BB459HY2HvbIbiGYXyJ0X91VHmPRsYMfdo/Ic5JHiuy08g/6dOJHQ0H
 FwzGcCZ1zaxTXsy0MPxZ8I+exN455N24+9u2pZghCZANyOKMz8QsiWOwBzkJnAKKkefF
 ORp4AYPV3n5AW/8/IyFp782IKMzbVyYFOnko2cVoNVVTxX1wZZGMFYKCDg6oddwrgGtW
 /mIA==
X-Gm-Message-State: AOJu0YwNZEI6I1Hbr7dwJwEFhuv8k3rpIEeyEXGxkIsv1M/f2t59JLFe
 kvvs5pvVLJKVEP/YyWWELZFaZbIpWt08RnliC1app7V1h8qub5yf4gzRAZI87yg9PV9aSmfw3PX
 IX56xUA5cwia22xXtlnTc2PfaPsiV6qjT2zMt2deYTMXytbjTtVjJSpcGjaRweKj4tTjOLnkjL1
 IJ5Gvoh5GoQr9DrvYl+Kootv2EDmUHCABSfJMUIsX+
X-Gm-Gg: ASbGncsQkYqIHXGssc7X9Ipoclo8KPLq7mPd3hyULWAlZ1PduBe10qER7p6LgESnLqC
 4vtFaCdyvdw94+xCJZzW+LiCAHBV1Oklg6zpnGD/hZvcliSmP2aLgkU/xQNwPO5SNLX1839fOwV
 xwuq8rZUliHpa5sBw1tsc1SSaT77H5QzoIP20MuB+YXFQwTt+V94w6/U2y8ef1EBbNqZTGr42+V
 pZ8r4si4fbjYz1p7bcKjnqmsr/7MDu8yBeHNKfq4apR0hsoK5OQqisRbvCv8x21DlrixavAMpRU
 XbrR4AxXzUx2fos5fYUb5d+ap10EeQ8EAAnmEo6Z0nPm
X-Received: by 2002:a05:600c:3b83:b0:454:ab1a:8c39 with SMTP id
 5b1f17b1804b1-458769ce757mr3632595e9.26.1753424258222; 
 Thu, 24 Jul 2025 23:17:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER/kqCYEcfl2c4w1oXUkJrgxl13KSswoIoDXWXpM5500wlz5PhwJ13O+vCnpvgmIRIwW+OEg==
X-Received: by 2002:a05:600c:3b83:b0:454:ab1a:8c39 with SMTP id
 5b1f17b1804b1-458769ce757mr3632355e9.26.1753424257777; 
 Thu, 24 Jul 2025 23:17:37 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.154.122])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45872d57506sm16405195e9.28.2025.07.24.23.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 23:17:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] target/i386: fix width of third operand of VINSERTx128
Date: Fri, 25 Jul 2025 08:17:36 +0200
Message-ID: <20250725061736.1096206-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Table A-5 of the Intel manual incorrectly lists the third operand of
VINSERTx128 as Wqq, but it is actually a 128-bit value.  This is
visible when W is a memory operand close to the end of the page.

Fixes the recently-added poly1305_kunit test in linux-next.

(No testcase yet, but I plan to modify test-avx2 to use memory
close to the end of the page.  This would work because the test
vectors correctly have the memory operand as xmm2/m128).

Reported-by: Eric Biggers <ebiggers@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 853b1c8bf95..51038657f0f 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -878,10 +878,10 @@ static const X86OpEntry opcodes_0F3A[256] = {
     [0x0e] = X86_OP_ENTRY4(VPBLENDW,   V,x,  H,x,  W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
     [0x0f] = X86_OP_ENTRY4(PALIGNR,    V,x,  H,x,  W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
 
-    [0x18] = X86_OP_ENTRY4(VINSERTx128,  V,qq, H,qq, W,qq, vex6 chk(W0) cpuid(AVX) p_66),
+    [0x18] = X86_OP_ENTRY4(VINSERTx128,  V,qq, H,qq, W,dq, vex6 chk(W0) cpuid(AVX) p_66),
     [0x19] = X86_OP_ENTRY3(VEXTRACTx128, W,dq, V,qq, I,b,  vex6 chk(W0) cpuid(AVX) p_66),
 
-    [0x38] = X86_OP_ENTRY4(VINSERTx128,  V,qq, H,qq, W,qq, vex6 chk(W0) cpuid(AVX2) p_66),
+    [0x38] = X86_OP_ENTRY4(VINSERTx128,  V,qq, H,qq, W,dq, vex6 chk(W0) cpuid(AVX2) p_66),
     [0x39] = X86_OP_ENTRY3(VEXTRACTx128, W,dq, V,qq, I,b,  vex6 chk(W0) cpuid(AVX2) p_66),
 
     /* Listed incorrectly as type 4 */
-- 
2.50.1


