Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBBAC3064D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 02:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sO78X-00030h-Ac; Sun, 30 Jun 2024 22:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sO78U-0002xL-Qg
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 22:51:22 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sO78S-00007m-TZ
 for qemu-devel@nongnu.org; Sun, 30 Jun 2024 22:51:22 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2c84df0e2f4so1601400a91.1
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2024 19:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719802279; x=1720407079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+mPvMUbmRUW5qOg66PJMTfVpv43K7IU1VZRf6V6fQ1Q=;
 b=V5/JjILYl8P0sxw3n2cUbZh/sMn5dztL6nI3t28zgPpENiEMoeQlsj9yaQ2OjshKoi
 WJdZhW1WDprayRfjLCXoduGM5wweEafs+aZFS5D42nEGxUA5Ti4Of6FNLNdL2/V7qQWl
 mag/oO0c7IGP+BQS9TKc9pBlpxBe7y1LKaiEL4B1M8ykI0P6Ee4nPNzQ6FRzhzCETqow
 D+d500UDnQja70WlBwYrGxmJtZ2pcdrcGLL9gqC0B1R2cS2Spzee0qw1ICcYQRUyG+Tn
 89xF6c0QoMiq3tKGilB8W3mo0POR0Ob2c2+LP5sJNpocJmoifO7OaBab2jW53hPcfrjC
 sVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719802279; x=1720407079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+mPvMUbmRUW5qOg66PJMTfVpv43K7IU1VZRf6V6fQ1Q=;
 b=TrUzLUe6EFrngqAUweg7jwOOdOjxE6DbjzUfJbcIGAwQj54CZpbWMeco3trXRRBWax
 njrJEwrga/wGYcFrXmT+eoT4bIIn62/8q+RNeh/wByLH4l37tjaNqt4ARPWjX0pld6Dz
 9fFURDrMrEQKYaF1SMC4zdbImTcKhOXpi28jy4txJTmGq0E48Pz2aSg8bEjRP0NYpGtl
 Qz1HSVb7bQRdbbt64OWzRzRx2y49LQ+RTVHcnB51qy9gU8/IdFhqJ0CMmH0mq0Q9bGBo
 BTyemmX1IgP0OkmMYcGP+9fMj28wFzBi3UMHLURWZMx54Xf/eQAWWA33l4Z3k/gKFgZo
 wmMw==
X-Gm-Message-State: AOJu0Yz63QAjsm+nyk8GwosIR+9efDEabDBXXCPIfgGu+5jQUxj5yROg
 XzpXxXbNDutDvlV4gz/bMfS0axrnrM9a1nSwPrb0UVcpnoaTC9pKgloGs7ZdxP7gSFr/OElRLXH
 3
X-Google-Smtp-Source: AGHT+IF6pDvzWK0bOiycY1uCErclF6JZrL67rAeQrWa2qa13XrLBXJUAFjg0jzFdzW4tc1aedpn0og==
X-Received: by 2002:a17:90a:5b0e:b0:2c8:946b:eea2 with SMTP id
 98e67ed59e1d1-2c93d1b9307mr7041641a91.7.1719802279273; 
 Sun, 30 Jun 2024 19:51:19 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91d3b9349sm5531698a91.37.2024.06.30.19.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jun 2024 19:51:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH 3/5] target/i386: Rearrange CCOp
Date: Sun, 30 Jun 2024 19:51:13 -0700
Message-Id: <20240701025115.1265117-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701025115.1265117-1-richard.henderson@linaro.org>
References: <20240701025115.1265117-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Define CC_OP_{FIRST,LAST}_BWLQ.  Remove CC_OP_NB.
Give the first few enumerators explicit integer constants.
Move CC_OP_POPCNT up in the enumeration; remove unused
CC_OP_POPCNT*__ placeholders.  Align the BWLQ enumerators.

This will be used to simplify ((op - CC_OP_*B) & 3).

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h | 44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 29daf37048..df4272fdae 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1270,14 +1270,27 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
  * are only needed for conditional branches.
  */
 typedef enum {
-    CC_OP_DYNAMIC, /* must use dynamic code to get cc_op */
-    CC_OP_EFLAGS,  /* all cc are explicitly computed, CC_SRC = flags */
-    CC_OP_ADCX, /* CC_DST = C, CC_SRC = rest.  */
-    CC_OP_ADOX, /* CC_SRC2 = O, CC_SRC = rest.  */
-    CC_OP_ADCOX, /* CC_DST = C, CC_SRC2 = O, CC_SRC = rest.  */
-    CC_OP_CLR, /* Z and P set, all other flags clear.  */
+    CC_OP_DYNAMIC = 0, /* must use dynamic code to get cc_op */
+    CC_OP_EFLAGS = 1,  /* all cc are explicitly computed, CC_SRC = flags */
+    CC_OP_ADCX = 2,    /* CC_DST = C, CC_SRC = rest.  */
+    CC_OP_ADOX = 3,    /* CC_SRC2 = O, CC_SRC = rest.  */
+    CC_OP_ADCOX = 4,   /* CC_DST = C, CC_SRC2 = O, CC_SRC = rest.  */
+    CC_OP_CLR = 5,     /* Z and P set, all other flags clear.  */
 
-    CC_OP_MULB, /* modify all flags, C, O = (CC_SRC != 0) */
+    /*
+     * Z via CC_DST, all other flags clear.
+     * Treat CC_OP_POPCNT like the other BWLQ ops in making the low bits
+     * equal MO_TL; this gives a value of either 6 or 7.
+     */
+#ifdef TARGET_X86_64
+    CC_OP_POPCNT = 7,
+#else
+    CC_OP_POPCNT = 6,
+#endif
+
+#define CC_OP_FIRST_BWLQ  CC_OP_POPCNT
+
+    CC_OP_MULB = 8, /* modify all flags, C, O = (CC_SRC != 0) */
     CC_OP_MULW,
     CC_OP_MULL,
     CC_OP_MULQ,
@@ -1332,20 +1345,11 @@ typedef enum {
     CC_OP_BMILGL,
     CC_OP_BMILGQ,
 
-    /*
-     * Note that only CC_OP_POPCNT (i.e. the one with MO_TL size)
-     * is used or implemented, because the translation needs
-     * to zero-extend CC_DST anyway.
-     */
-    CC_OP_POPCNTB__, /* Z via CC_DST, all other flags clear.  */
-    CC_OP_POPCNTW__,
-    CC_OP_POPCNTL__,
-    CC_OP_POPCNTQ__,
-    CC_OP_POPCNT = sizeof(target_ulong) == 8 ? CC_OP_POPCNTQ__ : CC_OP_POPCNTL__,
-
-    CC_OP_NB,
+#define CC_OP_LAST_BWLQ CC_OP_BMILGQ
 } CCOp;
-QEMU_BUILD_BUG_ON(CC_OP_NB >= 128);
+
+/* See X86DecodedInsn.cc_op, using int8_t. */
+QEMU_BUILD_BUG_ON(CC_OP_LAST_BWLQ > INT8_MAX);
 
 typedef struct SegmentCache {
     uint32_t selector;
-- 
2.34.1


