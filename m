Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BE7D3C92D
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 15:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2YG7-0003X6-4V; Sun, 20 Oct 2024 11:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2YFh-0003NA-56
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 11:53:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2YFf-0005Pp-JL
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 11:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729439623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uPHb5ByYipPEkRTaBja/s+S6rotpUpBmTRUGPYsW6is=;
 b=f10Z7w5g811ee7A5Y2FMW9O1hDHfqKNwOnmYPYOq3c8ic74I8iVFUiNqE9Qq4U1DA4RIAg
 UoGOPPty+m86llFUVF72Og6MMXnexYg3vVP8AZnepjznBF4hSEDIsZ2GMjnVioKvzBtG2a
 66BPRsf4QokgnK5S/VieMGSA3V3X9Qo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-7oxP4ECDOWGrI8i5US1hrA-1; Sun, 20 Oct 2024 11:53:42 -0400
X-MC-Unique: 7oxP4ECDOWGrI8i5US1hrA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-431673032e6so11855135e9.0
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 08:53:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729439620; x=1730044420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uPHb5ByYipPEkRTaBja/s+S6rotpUpBmTRUGPYsW6is=;
 b=j+FTXiXlRdzEFPkkvX7aJmVZ7imjoDil81mw8qzQF2mfYp3gpdJQw+KFh/eunsKA8u
 gA+UVo6R0hDCt6Kk0gZDbrNZCNCHMMBVRjAnl634zH12JJxg56q2p2zvhVp3Fuy2yCFW
 UsITmtSZtgIKo9I7CkHQDGhe/uwG4sjsMNigcu0yyMFQ+5+P3Y3mipItMQZhk6hUS3j4
 i2RogH1+IlndU8ps1Y1Lxmzrznu0SJaPuOGu14ui/C5HSsEzSTMCsDkPz/frAL0DiNbT
 rYVO/CUbtYyxK9wA9KIbADtmYkccXrO/H3tX7/jTccBha42OXH+B89EPvIkedlOjO/an
 rp+g==
X-Gm-Message-State: AOJu0YzLo+XUBroRPOOsvEU8o2+CGlniWWLLkem+EaXenf76ZbrrN+3n
 8E7fd8COhz846AJt5KYUuSqk0LULUTYsiXRMygD/FUOImXXw/paWiy6icDv0/Cw8I5+Kgjs+KPs
 BdKQWOkprkuYvbOPiipOd2THJ2K89nmQ9uPo/ZmmWEOKQL39LqRs4P+HjRawo4TJJBRDRgKBsVk
 wa4DjzYApFZd3S5FMEJrCCg561Ck/8QueX/rJC2p4=
X-Received: by 2002:a05:600c:3151:b0:431:6060:8b22 with SMTP id
 5b1f17b1804b1-43161641a62mr67364205e9.10.1729439620017; 
 Sun, 20 Oct 2024 08:53:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELz/Bg3uT/zOKKTe5KLi113M0KBal67e64hNp/KNlHYoW6Wuny6p2X/IHUjTd1m42veVQYrQ==
X-Received: by 2002:a05:600c:3151:b0:431:6060:8b22 with SMTP id
 5b1f17b1804b1-43161641a62mr67364125e9.10.1729439619617; 
 Sun, 20 Oct 2024 08:53:39 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f5cb88csm27004045e9.39.2024.10.20.08.53.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Oct 2024 08:53:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 04/14] target/i386: Rearrange CCOp
Date: Sun, 20 Oct 2024 17:53:14 +0200
Message-ID: <20241020155324.35273-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241020155324.35273-1-pbonzini@redhat.com>
References: <20241020155324.35273-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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
index 567fefa1d7b..f292463c34a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1278,11 +1278,10 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
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
@@ -1355,9 +1354,12 @@ typedef enum {
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
2.46.2


