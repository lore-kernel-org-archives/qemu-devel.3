Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46F8D33990
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 15:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5RX2-0000JF-Uz; Mon, 28 Oct 2024 11:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5RWu-0008NI-Ez
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:19:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5RWs-0000rf-Ra
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730128776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UiNRCJcj6y5gkOMCLNt04TYjymilyV5BG77bHcu2074=;
 b=OcNU5SlYWN5wzqAG7wn9UYmpffu9YySVlE+25qJS/+k6p0W72mYFa7Nl60Ouk6NxVkQRoL
 2SrsKgFYKNnGEs6K1t1GQuUEaKcXemYbrQdLAIuJIBoqqjetzkewJltdY+dPQSoqPwwOOc
 0LTGsL6xfSzrmuSkOwNU7QXFcaxWhdE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-G5ZPMZmDMbaWJ8rB71LuZA-1; Mon, 28 Oct 2024 11:19:35 -0400
X-MC-Unique: G5ZPMZmDMbaWJ8rB71LuZA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d56061a4cso2434622f8f.2
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 08:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730128773; x=1730733573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UiNRCJcj6y5gkOMCLNt04TYjymilyV5BG77bHcu2074=;
 b=LbeWW44eEs0nZ6z6r+l5j09Q2D0n/Vb47ZS05Unn56p8RPd2kZmuYxln+AaYmIY2eA
 g5tre3bbsLYEER/7fGsYmxzLf/NldzuZFJV8GWf09RCRL3dZBXjD8hTlMaHKC/FQ+Fl9
 ao8NEVS3LaED7zbE1a5sG7F9vXRzR9I8tsbNDdhBu8lJ3WlLvTPWPtGgNSyF6EtgGTyC
 IsmwJH06F17lVTSwqOe3DNfX3Ke72Fud6ChH/71hqQXseZBaU8iZE0RoqcKymCYfkrqO
 oBPyfsNQeh/izxhAGOy3vkDmFWoOZ5aQvXHAlrJLV7XxC+b8yD6nCyV9q1uSNh2h0aHK
 JN6w==
X-Gm-Message-State: AOJu0YwV1yrL32IRVwXvMZtE0lvSDDSJ2/J4vpw1zAnGf13cPUA/Hmpq
 AhhyW+0BOiDgNH98hhM7ummzoLIBfe0XgTotoMGmrLkTVJyj2X6Vd1Ys+oQzRhvp8gsixibGrfg
 ZmvdPKZbmHFzepwD5ljDspsatn8bOMTnHjDCdRHzlNFaI4X4RWyQDeiNQCPYx228a8dbCezcnLM
 FXDZEyej0MspKQfse69fL3Ez5lKODppRztNYYI6J0=
X-Received: by 2002:a5d:4c46:0:b0:378:89be:1825 with SMTP id
 ffacd0b85a97d-380611f55a1mr5450283f8f.49.1730128773302; 
 Mon, 28 Oct 2024 08:19:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2O952Wyn20plbBwesyIVVMgDcqmoYAw5bUTLzjkYmZQAiA/AzU9Vu+DGR4Nq1xuIYHaURQw==
X-Received: by 2002:a5d:4c46:0:b0:378:89be:1825 with SMTP id
 ffacd0b85a97d-380611f55a1mr5450262f8f.49.1730128772857; 
 Mon, 28 Oct 2024 08:19:32 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058bb433bsm9729282f8f.112.2024.10.28.08.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 08:19:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 13/14] target/i386: use higher-precision arithmetic to compute
 CF
Date: Mon, 28 Oct 2024 16:18:50 +0100
Message-ID: <20241028151851.376355-14-pbonzini@redhat.com>
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
2.47.0


