Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66895D767F8
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZNa-0003wq-9f; Thu, 31 Oct 2024 13:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMm-0002dN-63
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZMk-0007SQ-GU
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P1iy+2WvpN1bYE2vUYS/SUko4M/32FZ7LjWFyedrCk0=;
 b=b/QNpIScm6eFJLkJ55JoonLAqyEMRgkMTdHT4969h0FPgmwVv26Yy/rcctxQoOo0p43Iag
 2yzQelPQi6H7DdpED8A6mdwn6Sjxw9WElmWj4d83VpgBWMUVOsXpSbk/WslWKFnV8ZEtcm
 TDTqkSALbS9QA2TztbjdxAmTByIDhsM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-r1-dKqPCM8q0pb3W9J_EUA-1; Thu, 31 Oct 2024 13:53:48 -0400
X-MC-Unique: r1-dKqPCM8q0pb3W9J_EUA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a99fc3e2285so64821466b.0
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397226; x=1731002026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P1iy+2WvpN1bYE2vUYS/SUko4M/32FZ7LjWFyedrCk0=;
 b=U5MHxAPZFu/nC98uAI0S0oFCyyp9x+KqLLeln53vHQ6eDNMPweCJrMGE86uLMEdyoA
 URpaakoVwDyRLMWjU00SCKVM2EDyoz82tlIlLHJlKhMj8WCNI8HwpjDbGNN1J3CAZtV9
 T/rONXHeET7RxQB5eBerdzwwGuLu3BS9TrUze0OjzkIfDaRaJYeatopJOlwO+6W7hX56
 ScAL3x9GaquPrGV2rk0+aTRJ0N4tfEqP370Z23FoCn2W6ylARQ2RbN/OzPSrMaRug8bm
 2hP1TqntMpb4ox4yNT/QnWFwfZip6uQbfSSW9olzSE+vL9+BFVy2cGTl6Up8dfJptMYC
 iEfg==
X-Gm-Message-State: AOJu0YwGSB4ARVrIoI2JdeyuPliJCgP3eOLqEO7ePy8f6gMwSPG9QjVG
 Z3K1oHrPnRNdkp0JA3mS/1BIdmWt8gaHvgEk0UFzS9+iUg8b6AWn20Fw5AW2dHmYcj0YacBquyU
 qHLdWQNeBr/esLP7P2QqFBhaqtR7wv8QYE/DwItnaVWDpGRnsnFuAMuUYCwIZOY1yWJO2s7v60u
 WTqGglqWsQKrwELvTRM7K0ITaqjOGvKnUdfBpu7Vo=
X-Received: by 2002:a17:907:7d87:b0:a9a:684e:9a64 with SMTP id
 a640c23a62f3a-a9e50ba4055mr374335466b.61.1730397225899; 
 Thu, 31 Oct 2024 10:53:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvkevg2XVei2N4iBt3CBIQNSI8hg+VxRfzGjgozdhBTO9V6v+QyfE6DkyRDX8R6058r+d4Vw==
X-Received: by 2002:a17:907:7d87:b0:a9a:684e:9a64 with SMTP id
 a640c23a62f3a-a9e50ba4055mr374333166b.61.1730397225445; 
 Thu, 31 Oct 2024 10:53:45 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e565df962sm89798966b.123.2024.10.31.10.53.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:53:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 40/49] target/i386: use higher-precision arithmetic to compute
 CF
Date: Thu, 31 Oct 2024 18:52:04 +0100
Message-ID: <20241031175214.214455-41-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

If the operands of the arithmetic instruction fit within a half-register,
it's easiest to use a comparison instruction to compute the carry.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/cc_helper_template.h.inc | 37 ++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/target/i386/tcg/cc_helper_template.h.inc b/target/i386/tcg/cc_helper_template.h.inc
index 8af8b8539f9..628d942a161 100644
--- a/target/i386/tcg/cc_helper_template.h.inc
+++ b/target/i386/tcg/cc_helper_template.h.inc
@@ -22,12 +22,17 @@
 #if DATA_BITS == 8
 #define SUFFIX b
 #define DATA_TYPE uint8_t
+#define WIDER_TYPE uint32_t
 #elif DATA_BITS == 16
 #define SUFFIX w
 #define DATA_TYPE uint16_t
+#define WIDER_TYPE uint32_t
 #elif DATA_BITS == 32
 #define SUFFIX l
 #define DATA_TYPE uint32_t
+#if HOST_LONG_BITS >= 64
+#define WIDER_TYPE uint64_t
+#endif
 #elif DATA_BITS == 64
 #define SUFFIX q
 #define DATA_TYPE uint64_t
@@ -62,9 +67,18 @@ static uint32_t glue(compute_all_adc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1,
                                          DATA_TYPE src3)
 {
     uint32_t cf, pf, af, zf, sf, of;
+
+#ifdef WIDER_TYPE
+    WIDER_TYPE src13 = (WIDER_TYPE) src1 + (WIDER_TYPE) src3;
+    DATA_TYPE src2 = dst - src13;
+
+    cf = dst < src13;
+#else
     DATA_TYPE src2 = dst - src1 - src3;
 
     cf = (src3 ? dst <= src1 : dst < src1);
+#endif
+
     pf = compute_pf(dst);
     af = (dst ^ src1 ^ src2) & 0x10;
     zf = (dst == 0) << 6;
@@ -76,7 +90,13 @@ static uint32_t glue(compute_all_adc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1,
 static int glue(compute_c_adc, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1,
                                        DATA_TYPE src3)
 {
+#ifdef WIDER_TYPE
+    WIDER_TYPE src13 = (WIDER_TYPE) src1 + (WIDER_TYPE) src3;
+
+    return dst < src13;
+#else
     return src3 ? dst <= src1 : dst < src1;
+#endif
 }
 
 static uint32_t glue(compute_all_sub, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2)
@@ -104,9 +124,18 @@ static uint32_t glue(compute_all_sbb, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2,
                                          DATA_TYPE src3)
 {
     uint32_t cf, pf, af, zf, sf, of;
+
+#ifdef WIDER_TYPE
+    WIDER_TYPE src23 = (WIDER_TYPE) src2 + (WIDER_TYPE) src3;
+    DATA_TYPE src1 = dst + src23;
+
+    cf = src1 < src23;
+#else
     DATA_TYPE src1 = dst + src2 + src3;
 
     cf = (src3 ? src1 <= src2 : src1 < src2);
+#endif
+
     pf = compute_pf(dst);
     af = (dst ^ src1 ^ src2) & 0x10;
     zf = (dst == 0) << 6;
@@ -118,9 +147,16 @@ static uint32_t glue(compute_all_sbb, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2,
 static int glue(compute_c_sbb, SUFFIX)(DATA_TYPE dst, DATA_TYPE src2,
                                        DATA_TYPE src3)
 {
+#ifdef WIDER_TYPE
+    WIDER_TYPE src23 = (WIDER_TYPE) src2 + (WIDER_TYPE) src3;
+    DATA_TYPE src1 = dst + src23;
+
+    return src1 < src23;
+#else
     DATA_TYPE src1 = dst + src2 + src3;
 
     return (src3 ? src1 <= src2 : src1 < src2);
+#endif
 }
 
 static uint32_t glue(compute_all_logic, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
@@ -258,3 +294,4 @@ static int glue(compute_c_blsi, SUFFIX)(DATA_TYPE dst, DATA_TYPE src1)
 #undef DATA_TYPE
 #undef DATA_MASK
 #undef SUFFIX
+#undef WIDER_TYPE
-- 
2.47.0


