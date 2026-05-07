Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84AEDCD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL126-0005sM-Cj; Thu, 07 May 2026 11:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL124-0005oh-PH
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:53:00 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL123-00043p-8y
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:53:00 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso11867565e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169178; x=1778773978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4eok6cHwZNCAp1lJxTQayrYIK7Kwl6hC9hZNWKlxPbM=;
 b=R+97yiZv86OEnylrhnp8V0cGf7Xp3N5cOFl31fRhxPbfK8oIeW9RcYEliU876FWtD4
 6Q6/QgmCf1xHaP2nD+VTy2/AdOY5If9yxvuAAeBvwVsR/zTUDfLgVHDkHMaELZpRYarR
 OE6wk1I3UeF89EWkAQGXev4TVBRGnlUYUDRYVNtmN8qMqw2t0PBHmP6bYmRUYyKDJ78k
 hzzeXceMzEzq5eVx/VE15Ufv8rU/1zMWhLnQ9VtbsUx1bGVE2pHC01ZD+BSKxn23g2E3
 N7W3WPXKOhIJI2l/puAniSN0Z5jvg7PWiIxEg9+1jypYOY7Zamn6OvbthBuMibxZlk5Q
 RCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169178; x=1778773978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4eok6cHwZNCAp1lJxTQayrYIK7Kwl6hC9hZNWKlxPbM=;
 b=p6poE9bhOJtvk8Oc/VjK3PQPCLLTlU5K2/k+xPvq2wcIETMDI21HVheMkDBcbWQpmR
 YqaaoWXlzGB4LksoFfZXPBLlg5X3kwNp4UDKndt7lYuGMPmD2CG973SxXfZOo0BmuFxh
 VXU43HqT+mKmLE0PWtQdJHjC5GbG7LNBqdAJYiAviIRuLi512bsJsa3hCbhmfLS00YD4
 ODoVz1d0e3yLimBxjUdzkBnP8IxQMCDqvX0umFFk9CixJ0C8rqO+JRljvJCOo3PHhHSz
 kdVMy8aKebK0mApBPPxmm/AyvZ1p6vQftytg0so8JCgyhkFvoOXBmlWOcIUmYBXxRvgu
 aifw==
X-Gm-Message-State: AOJu0YzdgnW9mAdMhP5uIIsnCLhD/hWxKtTVge2eTW8SsysGWt97djhU
 TrIFhluP5A2okHR/gj6xL9YH7aKP29+9zpC7R8s9Kv5HJeWC4MlgRP2zs+6GtOv5F19akF3b4rQ
 KAQIH
X-Gm-Gg: AeBDieuFzLYw+44zpwyc9Q7G89RYeJlAVu3j1zE2Axow7ArLBSW3yDRiPwIMpbMZixb
 lHIve4H6yva0bFzy9bQ6klF+knzLXs+yPLSgikf+HS3OXhKUl5mLZyvwn4LaO+ODHE8uqDHNk2J
 T1ip9DBxM1jpMYw5AGTMOK88YUzMxfpMqN0q+GUPd/kChtxzld3LPIloqEC5PRP+bjInmDpptTr
 VrNiakhCB4eIUEOsjT4g4OdE4hkmERGfg9bQTrjbSDPAi3QNStzGt1fjrqcOYHI2z4nqdjra8I+
 bLDhOOBJKEMYNF9gugdC9tX4dyYv7lSewSCCGxfGWUb0MQl2v8Oognk+vRg1GVg3kzqhfrWfsXh
 L4oSj8LZVgEr+vSLEP7VzIIL0k7UYPJThxMpwyXOF73SJjdjT7I68l5Xw5Bk+NyM+m0FIDsGpUu
 +gzabUKukLzqoLrF9Nd6p/v4oBuxnpH+oAe1jljgOPps88GcReC/gBAGKco+SgVOjoKwnB2VNwN
 cFft3XDmTmjjYAT180GaS7x9iJysaw=
X-Received: by 2002:a05:600c:a110:b0:488:ae6c:42c6 with SMTP id
 5b1f17b1804b1-48e51f2e8a3mr105669375e9.14.1778169177652; 
 Thu, 07 May 2026 08:52:57 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 64/67] hw/arm/virt: Enable GICv5 CPU interface when using GICv5
Date: Thu,  7 May 2026 16:51:51 +0100
Message-ID: <20260507155154.1886557-65-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

If we are using the GICv5 in the virt board, we need to set the
has_gcie property on the CPU objects to tell them to implement the
cpu interface part of GICv5.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-65-peter.maydell@linaro.org
---
 hw/arm/virt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7da92e7746..75b20cfc9a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3017,6 +3017,14 @@ static void machvirt_init(MachineState *machine)
             object_property_set_bool(cpuobj, "lpa2", false, NULL);
         }
 
+        if (vms->gic_version == VIRT_GIC_VERSION_5) {
+            if (!object_property_find(cpuobj, "has_gcie")) {
+                error_report("Using GICv5 but guest CPU does not support it");
+                exit(1);
+            }
+            object_property_set_bool(cpuobj, "has_gcie", true, NULL);
+        }
+
         if (object_property_find(cpuobj, "reset-cbar")) {
             object_property_set_int(cpuobj, "reset-cbar",
                                     vms->memmap[VIRT_CPUPERIPHS].base,
-- 
2.43.0


