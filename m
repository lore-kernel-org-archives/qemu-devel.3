Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC1CC44501
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggig-0007EK-Gs; Mon, 06 Jul 2026 06:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggia-000798-Qi
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:29 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiZ-0003Tb-8o
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:28 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-490cf3000f0so28927255e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334306; x=1783939106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Psw5RQ7bn8RFZkWZ5A+Dxh+A3qWZNnUc6p+gvL5S8h4=;
 b=aD/854QI9lpp68gPm97VvszcTu8WCLVML6IfEsBceNcBfh+jbpqlzYukmUrqLq9vUg
 n2nhFLOTV2zHzxlpdeKFcKsbXYRTelrDoojseLth1rPCLHst9wEqPy8ix+hoPWQE7c7y
 pBBdaYQ+6uauKjD/xjmPWvLqQhV5UitEc739E6ekwJa7A/9++nxH3yRuBVwc7mSO3bRa
 142w2teCkd5mj/FV056uCTjm9NHlhtbyNb87o1LDoXK46xVNIGf46LYVeIQCbrdq64qv
 gfWZAX1ckzZaSU4iXxCgHrhScU93BVZU1mhBYDPrp/yj6tmjU7LqOcQQLx+4aaZ64rbp
 7AfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334306; x=1783939106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Psw5RQ7bn8RFZkWZ5A+Dxh+A3qWZNnUc6p+gvL5S8h4=;
 b=IwOacsjUIzA4YHEJ9RdT61ik1Ly6VEc8Y87SsaaAjexyh+q/twHKhSECehaiV4aNnM
 92bfGrhDuOCDN1nYzVMSqfz/lq5Lw7QCrp4z4NJx3NkJ6Ehw9nOKTDjSlB37QmbuLAEN
 3bbA/4hRsRVPBKqxkSDDpyHcCNyMcrq4CQYamomeNNafOKGLrR69jbSkmMLP2WGgQpBb
 VqbViOH00pOLdxyumoP+VzGRcmpvC+ryL5hTY6uQGc9MjJO6jOoOxVaG7o9YMRsBg8l9
 wb261jVUv2x2FBOd4Yr5wW7OaSYhO9N28ZYLn1DmM2At+CZqLF30LiAw7LGGUZiDXmFJ
 7ATQ==
X-Gm-Message-State: AOJu0YzVGuGm5vppI1FioZ16+VHMPC27ts+UMUFEmn4SmFp5yJzqP8Lz
 cDic+5luEIuAmtEAu6GisZRuaDOUfVxe25D9Q/LRbTNfXpfPOMA7w2CQjOcHnM0ldM25Mj34p8x
 SfxnT0jPxjg==
X-Gm-Gg: AfdE7clLCCmjojRlvB/hsly0MPBo0FnVmzjmvUdx2eNWnwRA8BLJ9UiRRX8gIWSgUA+
 UaUnf9w3klOrqNvRVjyJIxLQKAjLY9yjc1OzbJku8uClJC96iaIkaYz4SNuwlgwoGoCjSnax7JP
 QpZcaqbDY29t2PP04hWEyNDiuFMD3fqFofbVPZ9h8zsP/Z+SEIV666FvpRMs29Mx1iAs9fndN20
 eqDGlWng+32ubVUOBmkCk/gQclWnA8iP0yh9FlbXMlq1qkyDQDbywB2wi/ZZ5KhqNRtD4tLDvaW
 yq/Mqi5OFcNOAx4YFnr5HhlEU7RBC7FcgqzqM/TTp9y7hC7J3udGYcsJcXzuUb+9vNx8+T2/dFG
 +VYICclsD7wRwrY5BjfExJZx6j6LU0wvt19tX+uF3btrCHUzKptdjIcufxW8b6lffxqxWTSfIHK
 R4g1CdgGv8KEZ1gvqrW8fmpGSOPSHUifqUB37P1fM5zdE3dfTRGphd3CACYHRGr6QDANWG39y/o
 EMs+oI3a3GDkiT1yvZFOw==
X-Received: by 2002:a05:600c:3054:b0:493:bc4a:e7d3 with SMTP id
 5b1f17b1804b1-493d11fbcbdmr70545505e9.39.1783334305672; 
 Mon, 06 Jul 2026 03:38:25 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/49] hw/arm: add support for shim loading
Date: Mon,  6 Jul 2026 11:37:32 +0100
Message-ID: <20260706103752.320511-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
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

From: Gerd Hoffmann <kraxel@redhat.com>

Add support for direct kernel boot with
shim to the arm platform.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20260521112806.504961-4-kraxel@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c         | 6 ++++++
 include/hw/arm/boot.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 780b6be637..9b7553dde5 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -1161,6 +1161,11 @@ static void arm_setup_firmware_boot(ARMCPU *cpu, struct arm_boot_info *info)
             fw_cfg_add_string(fw_cfg, FW_CFG_CMDLINE_DATA,
                               info->kernel_cmdline);
         }
+
+        if (info->shim_filename) {
+            load_image_to_fw_cfg_file(fw_cfg, "etc/boot/shim",
+                                      info->shim_filename);
+        }
     }
 
     /*
@@ -1195,6 +1200,7 @@ void arm_load_kernel(ARMCPU *cpu, MachineState *ms, struct arm_boot_info *info)
      * doesn't support secure.
      */
     assert(!(info->secure_board_setup && kvm_enabled()));
+    info->shim_filename = ms->shim_filename;
     info->kernel_filename = ms->kernel_filename;
     info->kernel_cmdline = ms->kernel_cmdline;
     info->initrd_filename = ms->initrd_filename;
diff --git a/include/hw/arm/boot.h b/include/hw/arm/boot.h
index a2e22bda8a..94386fdbea 100644
--- a/include/hw/arm/boot.h
+++ b/include/hw/arm/boot.h
@@ -39,6 +39,7 @@ void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename,
 /* arm_boot.c */
 struct arm_boot_info {
     uint64_t ram_size;
+    const char *shim_filename;
     const char *kernel_filename;
     const char *kernel_cmdline;
     const char *initrd_filename;
-- 
2.43.0


