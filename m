Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5BFC55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 19:14:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrh32-0008AF-JQ; Wed, 05 Aug 2026 15:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wrh31-00089M-9y
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 15:13:03 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <simonxhy0404@gmail.com>)
 id 1wrh2z-0005aR-BV
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 15:13:03 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-44856d185bcso1191508fac.3
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 12:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785957180; x=1786561980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5P6J3ncrDcD6IsEUWAmn78lAN1nXZ3gx1oEseI65Xnw=;
 b=TTda+PJa/Wqq4WSs/EX9sPOpRSz+smf9YVURh718z0N4jI2yE0iGEoc/uJQkObnefW
 fhlzZYTZt3retHdfx+n1UKffOpskd3muzqLY5pHOO6iPxeercqvE9RG+11byuv44dMsD
 LOe/n40sQhoJPw1F3M1lnvizXqiTMuu9TpnQ7V3IJAwt87jJ6mXQEaBA290j+DMK01eT
 sTKkj4ZdIv26sRqQCgK+84J4anIlGsTI+DC+t28vKulICDRfOUtRsFFquw1Y2ViIocKU
 a4z+SStSJMprn0l3tJy3yrjqLyYVV19yNYpngg8NBoXky38dovqna/u1cNSEqFN1Yw3K
 TGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785957180; x=1786561980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5P6J3ncrDcD6IsEUWAmn78lAN1nXZ3gx1oEseI65Xnw=;
 b=gWK/1l2SGeZ0yr0xGNs8xJmsdLD5kB9nyULodTuEiDd7e+FM8hQCA+ecQ26V1aeP2U
 L92K/8rcYjFPkOml7AT8t1E+bzwtHejl6bMCLSHSwR8FiurYAd0IqmJWZ00z11duFS5n
 yOSW/vCCYfz2tCNrLYvTEC9ifbaVUHH5tJKQ1k+qyBJ1Fj01r2rqcIdDsapk7FCQZZ18
 3s4uC+QyWXVQNCV8326jDyMhZaxmpcmFEbzKKUUhM99HjzpE3q7FIwS8AQ7vMR6SRe4a
 heu2t6uJpiBY++XadzH1kQ8RuKMtAt6d17VVLC6y+NVFTM74H914w0ALZHwpDyw6tUZv
 61qQ==
X-Gm-Message-State: AOJu0YyGlzvP6HtOpXcI/T/RTAh4wCorDs3W4/v06fu4JNGIMfkeA2wL
 Un48NtAy1Xdp1xNfGp9PUOfLkxiXqxyoCH0SRUCOFYWipVATg4FveaJt934vpE6Y
X-Gm-Gg: AR+sD12aPRxc3Jejhsc3zhc+rPF7nbCX8MNmGyZJTM7rurwLnu+6ZdDcw/koNU9vfoB
 /SjlS47Cc25LiIQCgUrvvjKBzao0lkfWuKxAAvZf4bILeT93loZD0bHRNNXDnoyn2u7CuQp1MT4
 C8IqPv+F8yYw6paCMDnHpqyZhcziXVu7rqJKlZpIj2eIGYbjCfb4IxTQvp4c1NYbUxWktkgurNv
 vizQlBZBQkWXW6i5IJgrZ9O6j2ZJJ7iTim+5Z/lT+FErZatDtK1u1F2xDhDs7vDen+7v3Zqc3dE
 2STWXA/e4nE35i+J5/FA6h6RKOVHegcmj7GBvC5TQ4t9kC/lL0SJWZhJlzQB5iZpJHWNWN7R0vf
 bbG23Sp5vYPZV0rMgJpNTnr9HVHwu/cJBO5Zfq72juPrP5cuHGYW2eMho3EvUo6izZhbnRTvC3B
 jhOqtYM4lHXyB0STbI8nLr/kmRLhSBxrILkwgpjQ3JtyhcD34sjyuNrkqLNQMiO89TJrXuFHbn4
 O3xaydsw1BToDU=
X-Received: by 2002:a05:6870:84c9:b0:448:9d5b:6393 with SMTP id
 586e51a60fabf-4599ef14344mr4801150fac.14.1785957180149; 
 Wed, 05 Aug 2026 12:13:00 -0700 (PDT)
Received: from HPE-2MQ6131DV6.ams.hpecorp.net ([170.85.98.248])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4599dd615ecsm3494867fac.0.2026.08.05.12.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 12:12:59 -0700 (PDT)
From: Simon Xu <simonxhy0404@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Simon Xu <simonxhy0404@gmail.com>
Subject: [PATCH 2/4] hw/arm/armsse.c: fix SSE-300 PPU addresses
Date: Wed,  5 Aug 2026 14:12:55 -0500
Message-ID: <20260805191257.11303-3-simonxhy0404@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805191257.11303-1-simonxhy0404@gmail.com>
References: <20260805191257.11303-1-simonxhy0404@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=simonxhy0404@gmail.com; helo=mail-oa1-x2d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The SSE-300 CPU0_PPU, MGMT_PPU, DEBUG_PPU had the wrong addresses
that were the same as the SSE-200 addresses.
Page 146 of the SSE-300 TRM defines the addresses of the PPUs.

SSE-300 TRM: https://support.arm.com/documentation/101773/latest/

Fixes: 8901bb414a24 ("hw/arm/armsse: Add SSE-300 support")
Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
---
 hw/arm/armsse.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index e99b491bd9..55fbc2c290 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -452,7 +452,7 @@ static const ARMSSEDeviceInfo sse300_devices[] = {
         .name = "CPU0CORE_PPU",
         .type = TYPE_UNIMPLEMENTED_DEVICE,
         .index = 2,
-        .addr = 0x50023000,
+        .addr = 0x58023000,
         .size = 0x1000,
         .ppc = NO_PPC,
         .irq = NO_IRQ,
@@ -461,7 +461,7 @@ static const ARMSSEDeviceInfo sse300_devices[] = {
         .name = "MGMT_PPU",
         .type = TYPE_UNIMPLEMENTED_DEVICE,
         .index = 3,
-        .addr = 0x50028000,
+        .addr = 0x58028000,
         .size = 0x1000,
         .ppc = NO_PPC,
         .irq = NO_IRQ,
@@ -470,7 +470,7 @@ static const ARMSSEDeviceInfo sse300_devices[] = {
         .name = "DEBUG_PPU",
         .type = TYPE_UNIMPLEMENTED_DEVICE,
         .index = 4,
-        .addr = 0x50029000,
+        .addr = 0x58029000,
         .size = 0x1000,
         .ppc = NO_PPC,
         .irq = NO_IRQ,
-- 
2.53.0


