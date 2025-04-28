Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42171C369D3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 07:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9J1U-0006Hb-4K; Mon, 28 Apr 2025 03:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1N-0006AP-Oi
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1K-0001BO-Im
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745825717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SBicW1h0/r2veCX2mitXgZUVrMQigI9U0cjfaTeztOQ=;
 b=B3hnIiM5Iek70hNfVBdAR9nWyUSHUXpce32ZlAUtX8Otdp4DdbSs+qV5P3LqSaXMnKxaFx
 I5HSro4VPWe/I/UyLXUpYJo8m00qqYvSiu878fVgDNx+6OgDAUVCkjGRiW++2WIeqw4wjO
 43R61QYkVc+DUVBAnG+uNC0WMrkJ1mI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-Uaj6jNJ7PgmoZlDV8P2_Sw-1; Mon, 28 Apr 2025 03:35:16 -0400
X-MC-Unique: Uaj6jNJ7PgmoZlDV8P2_Sw-1
X-Mimecast-MFC-AGG-ID: Uaj6jNJ7PgmoZlDV8P2_Sw_1745825715
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43f405810b4so22434165e9.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 00:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745825714; x=1746430514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SBicW1h0/r2veCX2mitXgZUVrMQigI9U0cjfaTeztOQ=;
 b=kc50F+A8u55/M320Is5HFN3kca0APVc1M2iuLGQii0AVoA2WGWmZClpcM9boMld5Mx
 7biKKy/N++xmcWNIN0y2Ha9T3KZ+SV85Sq3RlgiDYebKRwPyl2IExQvdgwUD5dvqGXBt
 UpwtYtMx+JuAs67IUZgQX2bLYFQgL/BcU8SqbgR1ybTjlcxRJeQ6RkPF1YZ78pjypZHr
 ugsI2UpMayZxKogZKljBlgSZ02BScA4xcnF3ui+FPKEqs9ow8gNsPaesXQhlwZq3cynO
 24hNN4WV4s0Xm0h9dANWNDVPuZo3ZpA53kK/SX8rdD0ahhKaBf26e3iNQ3bUQM7oLLEJ
 a+pw==
X-Gm-Message-State: AOJu0YyCQrwdAR/+TQ2x9y6jH5oB0yPZsGrx1Xl8pxqTUW8rvQLcPKsn
 AwYXx8gDQvZ21k1wuV4zobInPdA1KJyJ+E+uOpQhInlVhDMZ9d4Yl4KY8wzY5hvDq4QqlvxfUBW
 ITRH3CN7hSK3+MQYBBaPqJ4CDa+7wwTl3dtL5L/iK8lX3cA+fuS5O3El66zpwR3o9O4TBHsBf+Y
 JVtcjHIlfyeME8Cpn8bZj3Yx2gA7CcYqx8MKp2
X-Gm-Gg: ASbGncvAgAF49QRvstRhBmHnQy0F55gJwCpaXhkDG4Iuot/3RLn8sP6UqthL9oDSXuw
 AFghl0JIc166ejfkrcTYDywROs6WXbkT6ubQJ1q6apdTZoCbrnRvpxnGW+GNW3q4iZUu2KyL+dJ
 Uj/aEwy56BXHMkugGTJUkn8AtKzblm5tWBpDWlnZnsmjZkEbA0tO8TpeqYDsaY4of5SIIN9myw5
 upfv0W1AMUSyuznLA8Lctpcl07xyTpsloUuXNL4RssylemM+qFAh+RxYj43h7OXh9b3jmHlausr
 5vIZ5hMKCKCb900=
X-Received: by 2002:a05:600c:524a:b0:43c:fae1:5151 with SMTP id
 5b1f17b1804b1-440ab8480b4mr60252075e9.25.1745825713992; 
 Mon, 28 Apr 2025 00:35:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTDHYQ2MZ5xlceN1dB7LsC3biw6dPnhpqstppnsYYv8rz6yoLgnmm3zyVeAylu+I9xyBiCqg==
X-Received: by 2002:a05:600c:524a:b0:43c:fae1:5151 with SMTP id
 5b1f17b1804b1-440ab8480b4mr60251785e9.25.1745825713616; 
 Mon, 28 Apr 2025 00:35:13 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a52f89b2sm119434845e9.8.2025.04.28.00.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 00:35:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com,
	dbarboza@ventanamicro.com
Subject: [PATCH 11/26] target/riscv: include default value in
 cpu_cfg_fields.h.inc
Date: Mon, 28 Apr 2025 09:34:26 +0200
Message-ID: <20250428073442.315770-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428073442.315770-1-pbonzini@redhat.com>
References: <20250428073442.315770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.492,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

In preparation for adding a function to merge two RISCVCPUConfigs
(pulling values from the parent if they are not overridden) annotate
cpu_cfg_fields.h.inc with the default value of the fields.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
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


