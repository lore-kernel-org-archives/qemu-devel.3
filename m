Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC8AC3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJWh-0007U7-2S; Tue, 06 May 2025 10:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJTN-0008Jn-60
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:40:41 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJTK-0001sI-MG
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:40:40 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-39ee57c0b8cso5210678f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542436; x=1747147236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pj+GFYlfc9iJo6yTyQ5Nz9Q5zJ67gCxIABOM4SRTAcA=;
 b=ASE7gzgbmEQ2b/UX7UfwH4ISLSFVYLCe/zLPUFZsYFaWzRquTO8gMlx6hvfR6AbLxm
 +BeC6RUVC2ngnc+a+/tQxyz2BT61hOh+JEfPxt6m+cpfZpROBUxf3FUbexRM6gumYsgb
 i85auihVy0Dg4CTVFjm6Yg5JbT3Q2yW8d3T4rfZx5teuWdxG/JLhEI4njovija2UboG+
 lbouhAtYGTe1qNK0tSBqrUsSrMKDV+/dwQFik4BWq/dUR7QqBoOcv2TsQkyitOvyrWLK
 Ou+roJtHs6dK+hEDuFiVmNDrgx3TXLNNz6783I7DI60JIxDb28aL+2CVtvTVJ5mvkZrk
 gu4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542436; x=1747147236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pj+GFYlfc9iJo6yTyQ5Nz9Q5zJ67gCxIABOM4SRTAcA=;
 b=MO1ji6i+sLBv3Z5ytw/Q9hPDOrGm4X7s61D2fVauXwOruERSYts86W0xTlGOEij2qv
 q/dhAQxmICIkkHHR3WTH1KV5VIfDiwxgJsX0OyCqA1DfeK4s6lQcnAgX1qxeYqEMHWWa
 9jlhyqsQ7RSBs/1drSzQk21G8ElCZjE+F5XKjyF6yON94v3+J7bqrm9KqMyguzZRduC5
 Plpe93xDVV8C8btT04TP6xSWVRZ1hz2xtXmc1Fhv1MFzCoex68goFcv1P1mUGBvBsZcY
 DntGVXih7h1d+EJ61rPkNDQvtuZbJu0XWJOn1MnbJP3BBTpmhBYPP5fdLFwfFtnFiMKs
 vBjA==
X-Gm-Message-State: AOJu0Yzlxuf+vgcaBYu3bAK6iGc+FJhHBjtTLBPj2EuBH60qZ++C3n1m
 EIzlF145ZHQJrInnzYOVs4dRQOmadKAb6SI9e21T8RlRT9Bzip9nxnVZaosnCTxoCGiY93yV4/a
 B
X-Gm-Gg: ASbGncsRuulaVIyK93QBZ9KexgLW/QbM/UFIq46gOlKUhgzZoboKCbB/asV8VCHWD9X
 qjwEad5sdCweFNzfYt5+c1gcWvFNYiQhRuEN5YN88ZWl2+CcOuS5tLCMnWh+AuiMTG3d6ckXMhO
 teMJj2LjwlNECg7wTPApb6PGwTAfMCvtuHsH2YkBvwTL4Gxl8mSxFHnRHmUIaZ54xX9Em8d5+k7
 L70DYRpi/0Yy5ECTYaQzmyzr0u1WlXufbmloHQTfNraX7CM/53xjrmicVt5WMMC3pWkmdBO0P0K
 c0kMrGrV6zzkevnWmb/oBl2cglTxmVaY272RruMUzorCNQERkUW0FyEYhCERAN66oSP6V6hEPT4
 hXoaaFQe4DyMvBJ8BC8Ac
X-Google-Smtp-Source: AGHT+IE+vl9W4ipcnPoIi1Vy+XRrqp6VoJu7UOxjY7vVt6XZdAv0bTwgNR94GxNr7FJhWMSGD+bl5w==
X-Received: by 2002:a05:6000:2204:b0:39c:268e:ae04 with SMTP id
 ffacd0b85a97d-3a09fd0d09dmr8979686f8f.0.1746542436570; 
 Tue, 06 May 2025 07:40:36 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0ad661602sm2344414f8f.61.2025.05.06.07.40.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:40:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-block@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 18/19] hw/net/vmxnet3: Remove
 VMXNET3_COMPAT_FLAG_DISABLE_PCIE definition
Date: Tue,  6 May 2025 16:39:04 +0200
Message-ID: <20250506143905.4961-19-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143905.4961-1-philmd@linaro.org>
References: <20250506143905.4961-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

VMXNET3_COMPAT_FLAG_DISABLE_PCIE was only used by the
hw_compat_2_5[] array, via the 'x-disable-pcie=on' property.
We removed all machines using that array, lets remove all the
code around VMXNET3_COMPAT_FLAG_DISABLE_PCIE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/net/vmxnet3.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 3cf5d71f478..d080fe9b38a 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -41,11 +41,6 @@
 #define PCI_DEVICE_ID_VMWARE_VMXNET3_REVISION 0x1
 #define VMXNET3_MSIX_BAR_SIZE 0x2000
 
-/* Compatibility flags for migration */
-#define VMXNET3_COMPAT_FLAG_DISABLE_PCIE_BIT 1
-#define VMXNET3_COMPAT_FLAG_DISABLE_PCIE \
-    (1 << VMXNET3_COMPAT_FLAG_DISABLE_PCIE_BIT)
-
 #define VMXNET3_EXP_EP_OFFSET (0x48)
 #define VMXNET3_MSI_OFFSET    (0x84)
 #define VMXNET3_MSIX_OFFSET   (0x9c)
@@ -2466,8 +2461,6 @@ static const VMStateDescription vmstate_vmxnet3 = {
 
 static const Property vmxnet3_properties[] = {
     DEFINE_NIC_PROPERTIES(VMXNET3State, conf),
-    DEFINE_PROP_BIT("x-disable-pcie", VMXNET3State, compat_flags,
-                    VMXNET3_COMPAT_FLAG_DISABLE_PCIE_BIT, false),
 };
 
 static void vmxnet3_realize(DeviceState *qdev, Error **errp)
@@ -2476,9 +2469,7 @@ static void vmxnet3_realize(DeviceState *qdev, Error **errp)
     PCIDevice *pci_dev = PCI_DEVICE(qdev);
     VMXNET3State *s = VMXNET3(qdev);
 
-    if (!(s->compat_flags & VMXNET3_COMPAT_FLAG_DISABLE_PCIE)) {
-        pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
-    }
+    pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
 
     vc->parent_dc_realize(qdev, errp);
 }
-- 
2.47.1


