Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF91606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 09:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=llFFkq8p
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWW2G-00086b-91; Thu, 26 Nov 2026 04:45:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xWW1p-0007yd-Gi
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 04:44:33 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xWW1m-0001za-0R
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 04:44:32 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4bb702a7548so60984185e9.1
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 01:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795686265; x=1796291065; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/ufcfO7U7xhZR1F4mrd0e2U0grlkLDxyaRdVD544TG8=;
 b=llFFkq8pQuif+cOuDMaAMs/YLVePOql90kQmwe3lSlDr7JEwSaRskc8U9tr+HqaZ6L
 GZ6XJ3xhGJoVMRnfIxTOJ9HFnBFFR3I+R275NYNpttCV/8JK6yKM2vlXGuvdT3HUgFAW
 cOox2bRaDcShuM8K3WlqwfllkjdBDmET57h/9tPX6rlO44W5CbJ0/hy4Zd0C+rTIAi6J
 /968gK8++Wrh3sU1BLfy/kerE7fj2FtR7F57a7o3CUk4e7PBHPZX6PZLltVTLcmlUZMI
 Y7/pN27aB/MuGoJP6OtAHuoJjt4oJFjDHGSSz8I7/PJdI+z16hsBn9Cfv/sDaiyBarOH
 hyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795686265; x=1796291065;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/ufcfO7U7xhZR1F4mrd0e2U0grlkLDxyaRdVD544TG8=;
 b=auUD8hPhVojTR7FSrOy6N9yM/cyVGLyeSRKc/CKSDjgsJOZQy3NQRMpuVdaDovdbU/
 6BDCzonZBBM2tjskgWZRrLDK8rcPN/iv3qpmpQuaN7wJtMbERRu6QRItECG/ky5yD4YS
 EMt0QY/lq+dV0/ZVAjQ9LZtvW3R4xDDbIJqqIdvlqTj8Vye8lfA6GuOhZC4ZEkrjjd4V
 WF2DFQAcNrMgwUDdPLmVIhHVDYjDInnCGC8Vz7niugVhfhLkVMpRat44O1F4K+3FMzbP
 it0d2WBoWbEHjLqkgUkjDjJvnhAsGIgMDqNwm3SIQHKlDnHOIBhZZI302it7tSV6KAXG
 saYw==
X-Gm-Message-State: APuU4Z+9AceJqFmAhdQlJr6a+mJbKuzXq6lHrb8gUAzV4bWNqFCq3HYe
 zznKIqNkDG1yZcJYifkvbT5SQxL+rOttMBv5z1MQBS/oEQW5YFOs53+kB/sDBwEMowg=
X-Gm-Gg: AZFdTZfDATeu4Y3uxbNM49uX4LP+YwzuhIhBRi65Dy8WAHefOirbH/1VPbeOo1I+5Uw
 xV+2fvNRiRYdG98neEbTtF4CW1ANY+TTvl1eiJDK0zTmbU4uPww6dQDaczRsJLHfs5Xv5vBI0kH
 aDd3oF1i66JcTvn2rmvv835DbjW5/2tyRGZdhsjegM2Rc7QVtZ8BoExUe0NEeyepoyEaxUUBB1l
 yHxYeqnTBmIFLM0jPIX9BMpqxv+pk9OeOdvHHjn4mSAqV6+63PqLUb0qt7C0oBrLtyT+OfSk8xO
 8fdnlysJuehfQ47WXr6QQpapB3/kUQOdzo9gbxcjyaZEbpVVRNQ0gXsjpRUnEo1K+1TjotLhOfn
 4SLYkCV37nGwuuA81HCQb2rNEPo8CJ1Res0P+WYFErXSLBGeIp6JNPymrjwt3nG8rvF+U+FT1Cl
 p6H/oaC62zth4q8qfT/0oYQarbEwOt2yBrscw8916WAAIPxFSG+QjV85BRe2G/yY2RWYQqskzjY
 H6roj+XKZ+qoJqb6otCXPJytaFviMNpLGnjYrpJB9+CcFtWwl4hMCnKm4TfvJLOeGbp6S9erC40
 Jjw7FkPQ8vXKSPLBheodjWg0Urb7NHP6IA==
X-Received: by 2002:a05:600c:4e0d:b0:4a5:e6fd:65e5 with SMTP id
 5b1f17b1804b1-4bb88922a67mr402498985e9.31.1795686264937; 
 Thu, 26 Nov 2026 01:44:24 -0800 (PST)
Received: from [127.0.1.1] ([2a10:d582:31e:0:496e:5802:6210:8370])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b2050f1sm39023989f8f.38.2026.11.26.01.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 01:44:24 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Thu, 26 Nov 2026 09:44:20 +0000
Subject: [PATCH v3 2/2] hw/arm/sbsa-ref.c: Increase SMMU space for Root
 registers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-jmac-smmu-root-registers-v3-2-b46a8ac59b6d@linaro.org>
References: <20261126-jmac-smmu-root-registers-v3-0-b46a8ac59b6d@linaro.org>
In-Reply-To: <20261126-jmac-smmu-root-registers-v3-0-b46a8ac59b6d@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 Gustavo Romero <gromero@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.17-dev-6be7c
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In our implementation, SMMU Root registers are directly after the
non-optional SMMU registers. Realms registers will be added above the
root registers later.

Also force x-root on for sbsa-ref, which will allocate the extra
space necessary and allow access to the Root registers.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 hw/arm/sbsa-ref.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 158b461eb4..0b30f34512 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -35,6 +35,7 @@
 #include "hw/arm/bsa.h"
 #include "hw/arm/fdt.h"
 #include "hw/arm/smmuv3.h"
+#include "hw/arm/smmuv3-common.h"
 #include "hw/block/flash.h"
 #include "hw/core/boards.h"
 #include "hw/ide/ide-bus.h"
@@ -129,7 +130,7 @@ static const MemMapEntry sbsa_ref_memmap[] = {
     [SBSA_GPIO] =               { 0x60020000, 0x00001000 },
     [SBSA_SECURE_UART] =        { 0x60030000, 0x00001000 },
     [SBSA_SECURE_UART_MM] =     { 0x60040000, 0x00001000 },
-    [SBSA_SMMU] =               { 0x60050000, 0x00020000 },
+    [SBSA_SMMU] =               { 0x60050000, 3 * SMMUV3_PAGE_SIZE },
     /* Space here reserved for more SMMUs */
     [SBSA_AHCI] =               { 0x60100000, 0x00010000 },
     [SBSA_XHCI] =               { 0x60110000, 0x00010000 },
@@ -630,6 +631,7 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus,
                              &error_abort);
     object_property_set_link(OBJECT(dev), "secure-memory", OBJECT(secure_sysmem),
                              &error_abort);
+    object_property_set_bool(OBJECT(dev), "x-root", true, &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     for (i = 0; i < NUM_SMMU_IRQS; i++) {

-- 
2.43.0


