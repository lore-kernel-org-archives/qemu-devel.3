Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E62C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 09:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEPrG-0007g5-O4; Mon, 12 May 2025 05:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPqy-0007bw-6t
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:53:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPqw-0000he-NJ
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747043621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8pKmGPccZ420f06nXvp35Qbhc0ksIEV7ACiJPt5ZXsA=;
 b=QQgzPj86vCEQoBGdRMT9Ts1qrYTbHMDdlIQva89e6RMstw6hRuWw57h0l39JFIjR5SAvTo
 qnhWQhmSQfwDt2SX99Fr34hA8BotYIHUbcV2VEFmxifOG+WXzPi14NN3C7hOkSgib5EQWi
 JpZ4AdutEt/VGngCRE5Mh3bvNM/FpGU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-rknp753XNae4QPvfLTpodQ-1; Mon, 12 May 2025 05:53:40 -0400
X-MC-Unique: rknp753XNae4QPvfLTpodQ-1
X-Mimecast-MFC-AGG-ID: rknp753XNae4QPvfLTpodQ_1747043619
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-acbbb00099eso392605666b.2
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 02:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747043618; x=1747648418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8pKmGPccZ420f06nXvp35Qbhc0ksIEV7ACiJPt5ZXsA=;
 b=YED0oD4a+xqWqtDTsV7incK3QzeCKzge+J+PNo5vcnSTvlQRDRR3dvznbAA4puI+dH
 cnWnZYNeadqvpsD4CV5cWDuQ3TpsTAizvU1Xu76ctmzwFF+/5xi1zx6kLpzkvO6kD1uE
 5BIGyL1JpgDnLvEtFsqIyW6NSIJx4AJIVm1X3khgMrf0rFLUqJ+6Q3lzxxfUp3E4c8Vt
 FvBFuS1c5mlwTWlL3TXlVSSk09Z1CCgMUivr1QpVWGUeh6yNM1U3stHYL5yGhtARDWpv
 EC+/rNdQpKzC+lkiC4o2WwIyBbzlmNcVbLHEfZ8M1oB2ag+FQ6O6MZ58oLk9RsWREbzy
 FMYA==
X-Gm-Message-State: AOJu0YwzaNq5MpYdYmo8amn86PCtd524GSrg8+GLC8mYGrimjmSqCQzf
 ffVz9JgrDb5G7WeJiJvhPU8D+TqhrfOWOsZIvO0ErH+1mT/G92iMPHgNZHSvcSg4T6P+lphvRRY
 cYuu1k87S8vLZbVwEBClTZKoeQ3rQ3g7JVOgja14fpkVwlQ5coKJ7gaFYWiMx1+VECoEs+kCfL4
 CRbWF5JHyHx52hOAIOnvdXdFuBUXpJedVjuHd/
X-Gm-Gg: ASbGncvIOpBxt/upleZ8DAzD9O5HA8t4Erfy0ZnpIO+6//ZacKcqU9kA8RNMpBTjMl6
 Pq6IkCUxSYkXnIm83/LrMQO8WH00Sl4zNHYvj/QMdi3TCd3VlmMH4lOCYDlyqZitjtXNQiZ7VBn
 v5gIWEeNvvFGgxct7mytxV8DYKuXaxahfZChXQnR8eu9XM6cHIJdKdcnAjo+KxSDQNCemZ5qrv6
 wl89nHN39h1VRh638lAcE/ceobQg4DomGOV6iTpjVLpICNgexppXq/+fAJlkX2oslzvKy8HoOys
 DjbSKQFw6b3eMhy4e7Mv8n7Q8ssQXezXCDMi4ovPuqSbTa8=
X-Received: by 2002:a17:907:c711:b0:ad2:33a5:f468 with SMTP id
 a640c23a62f3a-ad233a6061amr818045866b.54.1747043618691; 
 Mon, 12 May 2025 02:53:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHij68ukYBqY+uTZVv2IfrvQa1vimP65j/IVK9Z/nunu/VuuTdH9cGb8BFPRce7g1pyiW6Hlw==
X-Received: by 2002:a17:907:c711:b0:ad2:33a5:f468 with SMTP id
 a640c23a62f3a-ad233a6061amr818043766b.54.1747043618314; 
 Mon, 12 May 2025 02:53:38 -0700 (PDT)
Received: from [192.168.122.1] (93-40-56-213.ip37.fastwebnet.it.
 [93.40.56.213]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2198b68absm585483666b.182.2025.05.12.02.53.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 02:53:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: dbarboza@ventanamicro.com, alistair23@gmail.com,
 richard.henderson@linaro.org
Subject: [PATCH 10/26] target/riscv: include default value in
 cpu_cfg_fields.h.inc
Date: Mon, 12 May 2025 11:52:10 +0200
Message-ID: <20250512095226.93621-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512095226.93621-1-pbonzini@redhat.com>
References: <20250512095226.93621-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

In preparation for adding a function to merge two RISCVCPUConfigs
(pulling values from the parent if they are not overridden) annotate
cpu_cfg_fields.h.inc with the default value of the fields.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu_cfg.h            |  2 +-
 target/riscv/cpu_cfg_fields.h.inc | 22 +++++++++++-----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index e9bf75730a6..aa28dc8d7e6 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -23,7 +23,7 @@
 
 struct RISCVCPUConfig {
 #define BOOL_FIELD(x) bool x;
-#define TYPED_FIELD(type, x) type x;
+#define TYPED_FIELD(type, x, default) type x;
 #include "cpu_cfg_fields.h.inc"
 };
 
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index cb86bfc5dc3..59f134a4192 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -2,7 +2,7 @@
  * Required definitions before including this file:
  *
  * #define BOOL_FIELD(x)
- * #define TYPED_FIELD(type, x)
+ * #define TYPED_FIELD(type, x, default)
  */
 
 BOOL_FIELD(ext_zba)
@@ -153,18 +153,18 @@ BOOL_FIELD(misa_w)
 
 BOOL_FIELD(short_isa_string)
 
-TYPED_FIELD(uint32_t, mvendorid)
-TYPED_FIELD(uint64_t, marchid)
-TYPED_FIELD(uint64_t, mimpid)
+TYPED_FIELD(uint32_t, mvendorid, 0)
+TYPED_FIELD(uint64_t, marchid, 0)
+TYPED_FIELD(uint64_t, mimpid, 0)
 
-TYPED_FIELD(uint32_t, pmu_mask)
-TYPED_FIELD(uint16_t, vlenb)
-TYPED_FIELD(uint16_t, elen)
-TYPED_FIELD(uint16_t, cbom_blocksize)
-TYPED_FIELD(uint16_t, cbop_blocksize)
-TYPED_FIELD(uint16_t, cboz_blocksize)
+TYPED_FIELD(uint32_t, pmu_mask, 0)
+TYPED_FIELD(uint16_t, vlenb, 0)
+TYPED_FIELD(uint16_t, elen, 0)
+TYPED_FIELD(uint16_t, cbom_blocksize, 0)
+TYPED_FIELD(uint16_t, cbop_blocksize, 0)
+TYPED_FIELD(uint16_t, cboz_blocksize, 0)
 
-TYPED_FIELD(int8_t, max_satp_mode)
+TYPED_FIELD(int8_t, max_satp_mode, -1)
 
 #undef BOOL_FIELD
 #undef TYPED_FIELD
-- 
2.49.0


