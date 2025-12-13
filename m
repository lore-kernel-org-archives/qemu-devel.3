Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD74D59F52
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Dec 2025 00:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vUDFl-00043T-BD; Fri, 12 Dec 2025 19:12:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3eq88aQoKCh0F3K5FHK5HL9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--marcmorcos.bounces.google.com>)
 id 1vUDFj-000431-I6
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 19:12:51 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3eq88aQoKCh0F3K5FHK5HL9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--marcmorcos.bounces.google.com>)
 id 1vUDFi-0006kH-05
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 19:12:51 -0500
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-34566e62f16so2018401a91.1
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 16:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765584767; x=1766189567; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=a9byHUhq171lB8iBLQB0kPeEXv2KRtdFiOEay6iUm0M=;
 b=D5M2IGTi3P0mpBW9iH/dfdgNkxHzlNf6jDqLkk4EZESUiWA/TO0+Djb8tFzbqpfG6R
 FdfijBFG0u3kcMujC1ZyNCu4YLxq16EHhfdUvr8GiR285VqrCsey3vNO/283COGjDZ+E
 U+3i4NCldPUKvE+QlPSGU+T/WjBMSF3hz3uGPEHdcwNA75fjtQ1HmmTn31+1Y9HKck1K
 JWdV8TriuK6tXqgA1Ln7dxmBhroFSmaA9zuBCDuTvYZNU2u5ZRTO1Hr7zoefrjNrdgHH
 hQdT2mumo4AoZLKyyvQzIArXXhhP87sLcoI+LdGPVBSGMqO3PT2shy7FG3IIR63PvDDt
 C8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765584767; x=1766189567;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a9byHUhq171lB8iBLQB0kPeEXv2KRtdFiOEay6iUm0M=;
 b=b0l2iLk08NrQy3EtiPCyrsWhPJWFZszMyVLeKZTOvjfC691/EADnl8i/4PWSPUZg14
 iTxl7ULrj0HmdBL4Hpq8j+aGWswvTR6E86PaI8qVgTJ3aCuQZG9J0tD7/IZy1r4wGOd3
 OvsGfYVmwGx3FkPcMvdwfKsfUr3bcyHT4iMoL97W5XnZ3dHlGzlghaW1J22fnRgvxGQp
 vc8hhRccDaUqN5X5+ru/BjflPVLUD5eXb1IxocKiiTAsSqDOZDpfLwzXOlPSEJ1VxTao
 idUc+B/DIBsxbrDjNpvaB18J/AjqoMwHuIE8iXMBJ+PBSK+KQBnfGSrKQxV04iwdPOro
 4wOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUniq4kJVrPOKOhKKqgeVJmQDJrNmAWHrqhiyIn2btwJ+KXjUVth1taihfX8jQlfr+J/KkETlV57Nol@nongnu.org
X-Gm-Message-State: AOJu0YyMS9uFh+D0b2SesBn7le64j7vIOK8iGi19I6MaTvjAlh/V2t4h
 LGkE1eD2bNX4inb3FPwXJDzaFxJYSrmKtuPRl0AaWaJKOIZkXynJCby3/FD2F6zOx378rO5XZro
 Ts7/rmix/s5T6jkEV38A2KQ==
X-Google-Smtp-Source: AGHT+IEjImOGnlHMiztl4z2ZlqTF3b9vjLnHL3vmRAV9t64A7B/mGpPOtYTnPz2l0lrHh3nOPkeYKOTQotEdpHPM
X-Received: from dlbbk2.prod.google.com ([2002:a05:7022:4282:b0:11d:cfca:1df5])
 (user=marcmorcos job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:f509:b0:11b:9386:8257 with SMTP id
 a92af1059eb24-11f34c2628bmr1661310c88.44.1765584762064; 
 Fri, 12 Dec 2025 16:12:42 -0800 (PST)
Date: Sat, 13 Dec 2025 00:12:31 +0000
In-Reply-To: <20251213001234.2039232-1-marcmorcos@google.com>
Mime-Version: 1.0
References: <20251213001234.2039232-1-marcmorcos@google.com>
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
Message-ID: <20251213001234.2039232-2-marcmorcos@google.com>
Subject: [PATCH 1/4] apic: Resize APICBASE
From: Marc Morcos <marcmorcos@google.com>
To: maintainer_email_from_script@google.com
Cc: cc_list_from_script@google.com, qemu-devel@nongnu.org, 
 Marc Morcos <marcmorcos@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3eq88aQoKCh0F3K5FHK5HL9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--marcmorcos.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

 APICBASE is 36-bits wide, so this commit resizes it to hold the full data.

Signed-off-by: Marc Morcos <marcmorcos@google.com>
---
 hw/intc/apic_common.c           | 4 ++--
 include/hw/i386/apic_internal.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index ec9e978b0b..1e9aba2e48 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -233,7 +233,7 @@ static void apic_reset_common(DeviceState *dev)
 {
     APICCommonState *s = APIC_COMMON(dev);
     APICCommonClass *info = APIC_COMMON_GET_CLASS(s);
-    uint32_t bsp;
+    uint64_t bsp;
 
     bsp = s->apicbase & MSR_IA32_APICBASE_BSP;
     s->apicbase = APIC_DEFAULT_ADDRESS | bsp | MSR_IA32_APICBASE_ENABLE;
@@ -363,7 +363,7 @@ static const VMStateDescription vmstate_apic_common = {
     .post_load = apic_dispatch_post_load,
     .priority = MIG_PRI_APIC,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT32(apicbase, APICCommonState),
+        VMSTATE_UINT64(apicbase, APICCommonState),
         VMSTATE_UINT8(id, APICCommonState),
         VMSTATE_UINT8(arb_id, APICCommonState),
         VMSTATE_UINT8(tpr, APICCommonState),
diff --git a/include/hw/i386/apic_internal.h b/include/hw/i386/apic_internal.h
index 4a62fdceb4..c7ee65ce1d 100644
--- a/include/hw/i386/apic_internal.h
+++ b/include/hw/i386/apic_internal.h
@@ -158,7 +158,7 @@ struct APICCommonState {
 
     MemoryRegion io_memory;
     X86CPU *cpu;
-    uint32_t apicbase;
+    uint64_t apicbase;
     uint8_t id; /* legacy APIC ID */
     uint32_t initial_apic_id;
     uint8_t version;
-- 
2.52.0.239.gd5f0c6e74e-goog


