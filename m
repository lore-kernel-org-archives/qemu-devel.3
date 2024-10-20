Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45297D3C92D
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 15:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2YGC-0003hz-R9; Sun, 20 Oct 2024 11:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2YG3-0003Us-Gh
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 11:54:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2YG1-0005Rt-5s
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 11:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729439656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rdCTjRuJWU9eu1zEMJ2p20wsDU/+YEzfRzwCWhFB3yM=;
 b=CXdsvnOa5C/j30ATpnxii9qOQDFM5Vz+5cYg5+I9Qbzc/NydE7nle8RpRJsCwUv17W641A
 0LmhWN5d4CPG0A6t+fzyA+eGSHHYRpDjxBCY7HrZd/1sBskHLQznu5QkGt3HDRTV+AMp9Z
 gfxWdcDcw3vg+B4+qChHY0Xo8ALwoxA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-NxBTyTQzMoKA4weyoH27QQ-1; Sun, 20 Oct 2024 11:54:13 -0400
X-MC-Unique: NxBTyTQzMoKA4weyoH27QQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d5a3afa84so1859821f8f.3
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 08:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729439651; x=1730044451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rdCTjRuJWU9eu1zEMJ2p20wsDU/+YEzfRzwCWhFB3yM=;
 b=TvwjKeKvTpK7X1iEmDSyVj51RIlXseWgLwKUchoZ1lfLFv3TR3PuHupH1SCTlZqQut
 nuaaGi3JbkQSKW/3LlREV2lpF/96Z7NuUgPs36uLPEoNocttJZM9oNC5Q0+sqM2RBwdV
 kJcieDrbSx+Nh/vttzT7yuTo0B98Llu1OMHaw2wm3BlRJh/kxoSXW0xKXKBHsokhMbfM
 qeGYEI9i5bqq8DMefZr+HYVxjnwMpy8Y38MJHkCgwkyksQPUPvorT/3xkTtS2Zxl6meC
 7TJbcQn45ahkSvBZOmh0ZFKDnLrQD9LL3b8QTK+fBVOJZBkZxg93gXN913u1mZRpn6M1
 veqw==
X-Gm-Message-State: AOJu0YxdK7k5HL35koI7CtW5mqV2gKf2fFeUkuwSwKDCRuYwsVcDLfK2
 sf1O9YyRqCJWoABFKZqJFcX8eNbmbLVdnJ0A16jndVE854UjshgOB7g7yGmcuZ5euBIIKLQxpQE
 nu70oXfxn5NMOoZA6NpdvSquIE3wem2HWdVkt3EdDJlZvQMK/U6B0b5Xw9EDzMjTCpKGzkCZOhx
 aKkK2ocditBlw7k1e52/x6dHOTc8gniZYjmDssG2o=
X-Received: by 2002:adf:f6d2:0:b0:37c:d299:b5f0 with SMTP id
 ffacd0b85a97d-37eab6ec6camr5327420f8f.59.1729439650906; 
 Sun, 20 Oct 2024 08:54:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYWBXyX46VYVA7kzUy0SkLvAFBfoAYjzVeL4dAj59yP8wZStDJT74AzOHqBwAPxGhzbkSWuw==
X-Received: by 2002:adf:f6d2:0:b0:37c:d299:b5f0 with SMTP id
 ffacd0b85a97d-37eab6ec6camr5327412f8f.59.1729439650386; 
 Sun, 20 Oct 2024 08:54:10 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0ba7dffsm1991213f8f.116.2024.10.20.08.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Oct 2024 08:54:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 13/14] target/i386: use higher-precision arithmetic to compute
 CF
Date: Sun, 20 Oct 2024 17:53:23 +0200
Message-ID: <20241020155324.35273-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241020155324.35273-1-pbonzini@redhat.com>
References: <20241020155324.35273-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

If the operands of the arithmetic instruction fit within a half-register,
it's easiest to use a comparison instruction to compute the carry.
`
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/cc_helper_template.h.inc | 37 ++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/target/i386/tcg/cc_helper_template.h.inc b/target/i386/tcg/cc_helper_template.h.inc
index 8af8b8539f9..f29a6dfb77c 100644
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
+#if HOST_LONG_BITS <= 64
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
2.46.2


