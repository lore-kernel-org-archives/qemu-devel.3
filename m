Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C832D33996
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 15:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5RWW-00088U-3l; Mon, 28 Oct 2024 11:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5RWU-000881-6U
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:19:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5RWS-0000lU-Nb
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730128752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+8Ycd/z4FSPPHkMPrNjkGaE9+9ckB94sy40JwoCKvsU=;
 b=a1OjoLLN+jN0/8jDTNH6hJ+V/zGDi5IQ+x7J3Ano8EbLta7q0BDUDqjGTwCnOW3SlhPn84
 RhvBoUk/gBMi8rgk7d3UtPPM4NloXYMUJjMJzYzUoYDTs/+D8HMpFWRiRxAHg6VY1NIoU/
 8htWLoiLvPzLi7lXIrqWBFSSGCrt+cI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-0hOPG-MMMzmhPwXmff9BiA-1; Mon, 28 Oct 2024 11:19:10 -0400
X-MC-Unique: 0hOPG-MMMzmhPwXmff9BiA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d4922d8c7so2507929f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 08:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730128748; x=1730733548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+8Ycd/z4FSPPHkMPrNjkGaE9+9ckB94sy40JwoCKvsU=;
 b=Td7fATlVkptJgKusW+TAZE0UtihVa2upBUyNssNFtw1SBZO1mXbuPssiK0WBO5Qthp
 7tsdiIJzh6+KNF3USsH83NYQVYhZY6zvUp4/KK/dBXU0Zv/GGeKnCC8lzr8FM5kfEEvq
 VRuFDOJD3WqNAZ25O0B7X+Co2mLHjutrCzqfdTMviN/hvL/qLLDL+vnayqXSeNeyMl3/
 kggStq0CrznZyN77WUXab1e+NNX1XX2k6OzIn/qyJHegqojhhRHFhCJLCCr1IlS3Jdv1
 Z4Vj2Iq2FrrWBjVjUD1eDExklGMlbuKYa7iU9QH6FdlLEYeIh3rmAcLk0xoH9d40NKcE
 Mm7Q==
X-Gm-Message-State: AOJu0YxT9veivJiX9sx8+j2tPPEJ9HKiRKtNEgti76h5VjST+Wzy6NS1
 L+AExSI5pUghho3lBVWZHUB624gHckPX9cd/z4kPzk/uzsBZlXrgWBTmb4f0/zhr4CAmJnmjrPd
 F21w6dENG86LN76VszjAxrBBG7RK8EpMxbmi6Qbepo2YdJ7m5eJSlesFoOFXFZKKRPXECrbPCzO
 Qgimt8nAvxNUEynf0zBa35WdlSSZhe6z1vcgvpzGU=
X-Received: by 2002:a5d:49c2:0:b0:37d:373c:ed24 with SMTP id
 ffacd0b85a97d-380610f41damr6656490f8f.4.1730128748390; 
 Mon, 28 Oct 2024 08:19:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEEjSrjEHizHea+uFW5482drizHedRKHRKEeieHXAGcfBZcHdQ2AlopOgzGtEs3xZTF+OpOg==
X-Received: by 2002:a5d:49c2:0:b0:37d:373c:ed24 with SMTP id
 ffacd0b85a97d-380610f41damr6656469f8f.4.1730128747994; 
 Mon, 28 Oct 2024 08:19:07 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4319360c10asm112627335e9.43.2024.10.28.08.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 08:19:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 04/14] target/i386: Rearrange CCOp
Date: Mon, 28 Oct 2024 16:18:41 +0100
Message-ID: <20241028151851.376355-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028151851.376355-1-pbonzini@redhat.com>
References: <20241028151851.376355-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Give the first few enumerators explicit integer constants,
align the BWLQ enumerators.

This will be used to simplify ((op - CC_OP_*B) & 3).

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20240701025115.1265117-4-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c89db50eddc..b605f592521 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1292,11 +1292,10 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
  * are only needed for conditional branches.
  */
 typedef enum {
-    CC_OP_DYNAMIC, /* must use dynamic code to get cc_op */
-    CC_OP_EFLAGS,  /* all cc are explicitly computed, CC_SRC = flags */
-    CC_OP_ADCX, /* CC_DST = C, CC_SRC = rest.  */
-    CC_OP_ADOX, /* CC_SRC2 = O, CC_SRC = rest.  */
-    CC_OP_ADCOX, /* CC_DST = C, CC_SRC2 = O, CC_SRC = rest.  */
+    CC_OP_EFLAGS = 0,  /* all cc are explicitly computed, CC_SRC = flags */
+    CC_OP_ADCX = 1,    /* CC_DST = C, CC_SRC = rest.  */
+    CC_OP_ADOX = 2,    /* CC_SRC2 = O, CC_SRC = rest.  */
+    CC_OP_ADCOX = 3,   /* CC_DST = C, CC_SRC2 = O, CC_SRC = rest.  */
 
     CC_OP_MULB, /* modify all flags, C, O = (CC_SRC != 0) */
     CC_OP_MULW,
@@ -1369,9 +1368,12 @@ typedef enum {
     CC_OP_POPCNTQ__,
     CC_OP_POPCNT = sizeof(target_ulong) == 8 ? CC_OP_POPCNTQ__ : CC_OP_POPCNTL__,
 
+    CC_OP_DYNAMIC, /* must use dynamic code to get cc_op */
     CC_OP_NB,
 } CCOp;
-QEMU_BUILD_BUG_ON(CC_OP_NB >= 128);
+
+/* See X86DecodedInsn.cc_op, using int8_t. */
+QEMU_BUILD_BUG_ON(CC_OP_DYNAMIC > INT8_MAX);
 
 typedef struct SegmentCache {
     uint32_t selector;
-- 
2.47.0


