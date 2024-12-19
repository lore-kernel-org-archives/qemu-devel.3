Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A16BBE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOBy2-0004ZP-Tr; Thu, 19 Dec 2024 03:33:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBy1-0004Z7-Jh
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBy0-00058e-1T
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TlMQQm7DVIpgs/ZW+QzOnHXM5DBlsDVAt9yoOQUCT5w=;
 b=F3oXNTD9ZQ/sgMJ8GbC3cAAtqUwYNJBpZmy/OFO65/oRKVJmmLhEOsNqjjZzjkVE+UeM0r
 DbckksghalKy3zUwFO7bvCyTOWXtfSnaIrqz0Hw4gFhNVtqbASwECvG502U+jx/JnOgEsG
 z3XSao53rsovxC/2fqRlV1bbST5rr14=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-eYdVgMtlMmu7JOATeaDLKw-1; Thu, 19 Dec 2024 03:33:04 -0500
X-MC-Unique: eYdVgMtlMmu7JOATeaDLKw-1
X-Mimecast-MFC-AGG-ID: eYdVgMtlMmu7JOATeaDLKw
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385dcae001fso230821f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:33:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597182; x=1735201982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TlMQQm7DVIpgs/ZW+QzOnHXM5DBlsDVAt9yoOQUCT5w=;
 b=vhweHV2r1TGG698Vqy4777GGRTddmxU2OaUVqTi98ytst/XKq3fqZEswYx1bnxXoGx
 7KWcX+7IKTi7wLUQwIdTtNbENec7vHi3OFufEXX+3j3Ok8Cb/vxOQC3ZuZZZXaomjMUR
 ImSi0xn9whnmojfeY3kst7p2raqQCYwW4pfgGgr9On2hYz3hAelNLhotor3cP5Xf9Oy2
 ZBS4MzRWaBTq32WXKlxTshj/gCC6kKREAYYdRmvlDQAWBJ+PvlfYHWZOcfbBymUSLtwU
 gBKX6iwIWQSllvUgs9FNTvn9rkZNtQI4ksCpcsbbH585CLLzxIEy7Jbm8McIoLC/Ohy4
 lv7g==
X-Gm-Message-State: AOJu0Yy9gSdtmxpgKaEuZn83XmicXZ1AAxTiZoziwYSOc7o2N3lsqKmU
 GPGYup7PFp2/QOAVdkP/jveyd4PW7svf6Qbx8sI058zpyiQO5jtW+EnL0oLu3X8niPSwigQZuf+
 0Q1OCvl0pQ3sN9SmNQ/a+O0dFxJvW1FqBB4twWUTM9FZ9RA2vu6QA6SR5oohr2uUdHUpspwsEbE
 XOsCJWEvtyc/tH/Ov6aCnWg7xPC3fzS4Di0e7b
X-Gm-Gg: ASbGncuyNgvZbmHnse69puVeCU5BLox9ALk/8t3YguEwOxjDgXLPrNhvTUV3nKBmyrD
 Wq4d0SyhnxQQtfyfQG70M+nFAeGu73cchLiiQbIY9fl/QqYVqusKlqU8mUTOaqpBHrsHFGaSILO
 EdN2SGuiBEjUytXad4Cv9NpXKa0TbVa+eYnU+i6IGfpqsTc1UsjodQr4GYS2DkrtiPW7ouKCHIq
 vcYJAPuWu/BWHLcMJmUb+6iV5IRbtznTxQUB8u+73pNwoD4sLq0YtQV3mHS
X-Received: by 2002:a05:6000:400f:b0:385:fa2e:a33e with SMTP id
 ffacd0b85a97d-388e4d8e54cmr6063772f8f.43.1734597182184; 
 Thu, 19 Dec 2024 00:33:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKjGpwbAYyzTyApgi/Hc//OmdMRx57jNbb8c2W3s8J/3ePLHgS5d9ooc/n2BgOKe9BwhyFVw==
X-Received: by 2002:a05:6000:400f:b0:385:fa2e:a33e with SMTP id
 ffacd0b85a97d-388e4d8e54cmr6063737f8f.43.1734597181722; 
 Thu, 19 Dec 2024 00:33:01 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8ac97fsm962448f8f.92.2024.12.19.00.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:33:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 16/41] hw/arm/armsse: Use device_class_set_props_n
Date: Thu, 19 Dec 2024 09:32:03 +0100
Message-ID: <20241219083228.363430-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

We must remove DEFINE_PROP_END_OF_LIST so the count is correct.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20241216035109.3486070-17-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/arm/armsse.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 1cd6b4a4b2b..ffd732f8068 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -72,6 +72,7 @@ struct ARMSSEInfo {
     bool has_cpu_pwrctrl;
     bool has_sse_counter;
     bool has_tcms;
+    uint8_t props_count;
     const Property *props;
     const ARMSSEDeviceInfo *devinfo;
     const bool *irq_is_common;
@@ -87,7 +88,6 @@ static const Property iotkit_properties[] = {
     DEFINE_PROP_BOOL("CPU0_DSP", ARMSSE, cpu_dsp[0], true),
     DEFINE_PROP_UINT32("CPU0_MPU_NS", ARMSSE, cpu_mpu_ns[0], 8),
     DEFINE_PROP_UINT32("CPU0_MPU_S", ARMSSE, cpu_mpu_s[0], 8),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static const Property sse200_properties[] = {
@@ -104,7 +104,6 @@ static const Property sse200_properties[] = {
     DEFINE_PROP_UINT32("CPU0_MPU_S", ARMSSE, cpu_mpu_s[0], 8),
     DEFINE_PROP_UINT32("CPU1_MPU_NS", ARMSSE, cpu_mpu_ns[1], 8),
     DEFINE_PROP_UINT32("CPU1_MPU_S", ARMSSE, cpu_mpu_s[1], 8),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static const Property sse300_properties[] = {
@@ -117,7 +116,6 @@ static const Property sse300_properties[] = {
     DEFINE_PROP_BOOL("CPU0_DSP", ARMSSE, cpu_dsp[0], true),
     DEFINE_PROP_UINT32("CPU0_MPU_NS", ARMSSE, cpu_mpu_ns[0], 8),
     DEFINE_PROP_UINT32("CPU0_MPU_S", ARMSSE, cpu_mpu_s[0], 8),
-    DEFINE_PROP_END_OF_LIST()
 };
 
 static const ARMSSEDeviceInfo iotkit_devices[] = {
@@ -528,6 +526,7 @@ static const ARMSSEInfo armsse_variants[] = {
         .has_sse_counter = false,
         .has_tcms = false,
         .props = iotkit_properties,
+        .props_count = ARRAY_SIZE(iotkit_properties),
         .devinfo = iotkit_devices,
         .irq_is_common = sse200_irq_is_common,
     },
@@ -549,6 +548,7 @@ static const ARMSSEInfo armsse_variants[] = {
         .has_sse_counter = false,
         .has_tcms = false,
         .props = sse200_properties,
+        .props_count = ARRAY_SIZE(sse200_properties),
         .devinfo = sse200_devices,
         .irq_is_common = sse200_irq_is_common,
     },
@@ -570,6 +570,7 @@ static const ARMSSEInfo armsse_variants[] = {
         .has_sse_counter = true,
         .has_tcms = true,
         .props = sse300_properties,
+        .props_count = ARRAY_SIZE(sse300_properties),
         .devinfo = sse300_devices,
         .irq_is_common = sse300_irq_is_common,
     },
@@ -1699,7 +1700,7 @@ static void armsse_class_init(ObjectClass *klass, void *data)
 
     dc->realize = armsse_realize;
     dc->vmsd = &armsse_vmstate;
-    device_class_set_props(dc, info->props);
+    device_class_set_props_n(dc, info->props, info->props_count);
     device_class_set_legacy_reset(dc, armsse_reset);
     iic->check = armsse_idau_check;
     asc->info = info;
-- 
2.47.1


