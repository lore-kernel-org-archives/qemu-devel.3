Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C120D767F7
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZMw-0002gj-7h; Thu, 31 Oct 2024 13:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMR-000276-IG
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMQ-0007Pf-42
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ybL7+9wAgz/1BKinmhWAD7p+qC2nAGKD3FTOM60MIM=;
 b=dKuIHWdq9i7oPUNRalZtpFFGvaKDVilvi6+IhwZSRgf6XAoCQbQGiUwLrVCt7dk4KUZFIo
 Oh4wNCjsurXRCOchsGQZfjiNoxXrrvrJIECS8Clh/xJqh4yyNWhwr9RbS3r8k2rlaguQxn
 /w3/IqUkjIzZZqvDqXq5vVoGDXX5gec=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-VAvPovYeOkqTu7PGTQXpqw-1; Thu, 31 Oct 2024 13:53:27 -0400
X-MC-Unique: VAvPovYeOkqTu7PGTQXpqw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d531a19a9so613765f8f.1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397205; x=1731002005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ybL7+9wAgz/1BKinmhWAD7p+qC2nAGKD3FTOM60MIM=;
 b=HWE+Q1MqCtI8mlDCQ32VltAVEJc9tFYeh5M8zcvpjgMP4PQzQFo7USogw54+qmhahk
 xPPMpJ6OhznITBxLkNHE8XbhaOPd4QxkAFv3d19kRX3M+YG6cV+aKLoVzzkqedjOJl1T
 a0aKsxOrxmV/Ue1xRrLTyVUEgCDrIm2CbsSc5akm6S8t3UzLhf19KVCrX36I2s8ebaD3
 Ph8/jZfy0R3EJp7vFoUSbpPscEb3LMt/5I17CSCLjM0D3xGCamqE/Cf+Znt98xfb6YOG
 RNK/FJgRJhz8wbZoMF4E+j9Tc6pfEUcvb8OSLDvtrg45/zDBwevuWfbkPtEbZnbQY10j
 NXyA==
X-Gm-Message-State: AOJu0Ywn8SMp+hlkF6IONus48hlzHqYZAajqrJdaDjQ4madGhMrukFPK
 cwlrFtxNZT6ewojpFk5gZX8yWsY0+KRsNNYmGiOslMS+sC+/bGtf8Tiun1UCviNLSQs8D+nwcFu
 tIqLrzEbzhAAEWn6m7iIUCqobSO94cUxw7Fn2PhUiYNP+MNmjX4LdqMbv0lDj/Zyoh6MX81ousa
 1aIDcgyiGeXv9hsmJil8bgzj6VgSun9o27SMbDUqU=
X-Received: by 2002:a5d:59a2:0:b0:37d:5129:f454 with SMTP id
 ffacd0b85a97d-381be776c81mr3191064f8f.15.1730397205635; 
 Thu, 31 Oct 2024 10:53:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwCSVH16m3sUt8+UgeAonUikdqP89j02XOps6SUEoj/WgH8jbBWMxlyypOO6qLRwwVRhyfyg==
X-Received: by 2002:a5d:59a2:0:b0:37d:5129:f454 with SMTP id
 ffacd0b85a97d-381be776c81mr3191047f8f.15.1730397205151; 
 Thu, 31 Oct 2024 10:53:25 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10ea7a1sm2761271f8f.62.2024.10.31.10.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:53:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 31/49] target/i386: Rearrange CCOp
Date: Thu, 31 Oct 2024 18:51:55 +0100
Message-ID: <20241031175214.214455-32-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
index 50172d7a6f9..6ec63380473 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1299,11 +1299,10 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
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
@@ -1376,9 +1375,12 @@ typedef enum {
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


