Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B33CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZAa-0007Wr-3l; Tue, 16 Jun 2026 15:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8E-0004ZM-Bs
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:37 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ87-0000yz-P8
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:26 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-490a76757e5so35888215e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636827; x=1782241627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dBnz57USTF4klnOD0F5S3F9sAeLT+jv8yGXcqqpiY2U=;
 b=UNWcdNGXWi559vcK1kduzSlD4DcmH4EwHnh3es6W0e6RzDNUcGLpbpiaebBO354D5R
 xBhz4/U0KgB/gaCXxBp7A2BYNiQFs2O4PZFrjDkd5QwktvCJbADy2LwAicM1fLO3ASjT
 T1gqgT8wvAvdiLOXHILZirgS9F86+RHBLv2C5puJPEnSoHIV13iDZgRPx3pfvgPYY+E/
 X3StTYyfDmyfqwqzZ6yeosBzufw4rcnO+g9XWiwSqNVesamjIkavrdmAekiBHgpHw7e3
 Jc3ZLHe1Jf4Dh7BnTFVbYnxoRaoElOMj07y6HKxuSpT7X9U+n2fErkT23/HD8o3bslV5
 Lc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636827; x=1782241627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dBnz57USTF4klnOD0F5S3F9sAeLT+jv8yGXcqqpiY2U=;
 b=BFOM+Qiil6ZWPPpMoehKVZ4EF1qQznV6BKVqkJDKDUHozxhm7pYrQREm+8GLirTL3E
 zVgWLbB9C1vK82DVlAjKP+IaXy+gum7Se0G4eBMzr+YyLSYCRX5KU0vnGEw4qc0jBcJi
 QlWscZIk0SC1DGPTezOVOUrQu4PBM6mP3oWmfQNrPSZEP5SYXjddfzh86lSaxw+ipKdb
 D/nGem3Qq1Winrkhyq1FICnk+RiCXdXtkPsgyjpH8HR0fmmS0+fh6W72GSe+Sr/Ywhzm
 QCuUAPhHYSxJYx7Tp1eugIKitZjRY28AVncz2jfqCcmQKQncptB277ITrIUffbx+/og1
 Ttsg==
X-Gm-Message-State: AOJu0YwrMYyrbnMyr1NrUTOytOAAyHKqXltV4FtFpTfiKekBbUpAqZkg
 rdjtpNgtXxqD0h1HOtc0Ftt5/FDRhfG/ChUA49tDm9+GfmWrC6Wx4ROcu9UW56eG6up6dgH/Y22
 v3aZN
X-Gm-Gg: Acq92OEJ8rVP9u5R4nJJvpCGmPUkLGJ/kxHtyeGmEoOM2GgaJvl+BbBBxib903SwOyt
 UJEAVB3CTSdBVkQF24TbNA2Se2HUKuKHFIO5LvVPdOH7YmI+APOTIO5iHnhGIz6CAmaGFk1tRpY
 rOn/Ijfg7GpRMD4rR5a0B3CfX7etznO6fD4hQDFmur661yWrUOW2fCH8vXzaLaJMXOwbRX6NKsD
 A1Kqb6Xzkjy0RWVt2HkvtrqKit9ZE9n7jSuEd/L7qETYC/u0jjWEW6k49bEfU5KLNOBLuieh+JU
 xSIzeb8CLo8kkCefVMWlmSSpBkmxNmS5iY9J6MpmqY40KF23IAA7MKeR4PZw3BspJNMgmkyFyw0
 nUEOObn0UDcHWcUzCGtTQ7HUGtjocPpF5VxbYS0jHPjs87onNxneydXp6SKORcHCVeUKfLnXwWm
 FBKIAN8hgkHCerE5RlI72uqQlr0p/IbauTrDNPsna+uaxFJeckiLIewRfTf1GlcuZiyEi2wNihx
 tnuDjrjHw9pnzzocTrfbKhrg3OhLJZ/OFlEw/VaxU8=
X-Received: by 2002:a05:600c:19ca:b0:492:1edf:9fbc with SMTP id
 5b1f17b1804b1-492333ba2e3mr14447175e9.1.1781636827379; 
 Tue, 16 Jun 2026 12:07:07 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/61] hw/arm/virt: Link SMMUv3 CMDQV resources to platform bus
Date: Tue, 16 Jun 2026 20:05:59 +0100
Message-ID: <20260616190639.3462006-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

SMMUv3 devices with acceleration may enable CMDQV extensions
after device realize. In that case, additional MMIO regions and
IRQ lines may be registered but not yet mapped to the platform bus.

Ensure SMMUv3 device resources are linked to the platform bus
during machine_done().

This is safe to do unconditionally since the platform bus helpers
skip resources that are already mapped.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260609112552.378999-13-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ac0606fe87..2add7401a1 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2361,6 +2361,25 @@ static void virt_build_smbios(VirtMachineState *vms)
     }
 }
 
+/*
+ * SMMUv3 devices with acceleration may enable CMDQV extensions
+ * after device realize. In that case, additional MMIO regions and
+ * IRQ lines may be registered but not yet mapped to the platform bus.
+ *
+ * Ensure all resources are linked to the platform bus before final
+ * machine setup.
+ */
+
+static void virt_smmuv3_dev_link_cmdqv(VirtMachineState *vms)
+{
+    for (int i = 0; i < vms->smmuv3_devices->len; i++) {
+        DeviceState *dev = g_ptr_array_index(vms->smmuv3_devices, i);
+
+        platform_bus_link_device(PLATFORM_BUS_DEVICE(vms->platform_bus_dev),
+                                 SYS_BUS_DEVICE(dev));
+    }
+}
+
 static
 void virt_machine_done(Notifier *notifier, void *data)
 {
@@ -2377,6 +2396,9 @@ void virt_machine_done(Notifier *notifier, void *data)
     if (vms->cxl_devices_state.is_enabled) {
         cxl_fmws_link_targets(&error_fatal);
     }
+
+    virt_smmuv3_dev_link_cmdqv(vms);
+
     /*
      * If the user provided a dtb, we assume the dynamic sysbus nodes
      * already are integrated there. This corresponds to a use case where
-- 
2.43.0


