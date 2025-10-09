Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2C3CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 14:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6rgN-0002Q8-JH; Thu, 09 Oct 2025 10:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6rgC-0002M1-Oe
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:31:41 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6rg8-00032K-F9
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:31:39 -0400
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-46e6ba26c50so5809295e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 07:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760020292; x=1760625092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OHGiYHHnFd1U2KRhE1wPaGotMJPdoqLk98PjO3xtvD4=;
 b=fb0i9jdRJmZoxZdzuuF6MsGSn4WoW/mBe8Umd/3QAzd5XZUbVQf+Szt3bQMJBGMjtw
 bEXlYSQ3N/NvfpOGJjSnDcBONs5tPtkDs2sQwU6xeArkhTp6L68jhfTopWpsi6T9FsKw
 /FNwHoJGALSRMc0XS+pZEJcm8W7+Sms7K6afTjme4iX5ZKzzBt+2TmLMvr49H2jzQb0M
 QVRrJLM4gQlm1oreVcAMdQdKbgrfSWFHtTMc1SNBDH9Oa3rOokT5SbdT8RG3Depv1C8J
 Zxi39jmpodzydnxTsBKnXLd54Sug6uhXxcwp/w/wElJtB8AcxBm9IYavUohSNfHUNYtV
 Tg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760020292; x=1760625092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OHGiYHHnFd1U2KRhE1wPaGotMJPdoqLk98PjO3xtvD4=;
 b=l24jf8JSljgMXaj19IGVbejiH2nBYZXqnYmFIr+bQyoaeMfR9a+WtpmBVGgRdfbqAU
 PQN530zvN+1n02yLDTe0SyRMzJoxFfCadFsnmh9FwN2sEB9uapenA61Jc9laTpLWPMDU
 n+SmmEAP2cIy2HzIF0d2B5+7FACjdlIfQ5MaCmBrZAzaarHwxITGLvUBsgicGw4hfYC6
 uHOMhGiMJb5eTfIap1aD5FbJeXr7eGPvqBduUnRIhikiWkX7wRqxZupQn90pQWySvpVO
 sVXdKcxS8lhJ8TbLzdCZmuEDOUAj8i1B8gkXuX+7EBAqULbsXL3qT1tahMijSyrChpr2
 xNig==
X-Gm-Message-State: AOJu0YzY5cwtHZvoRDhB/H3LzSgog0AZZ5WEQTOpwTSDAjETci0pge7Z
 Jt9vBlZrdjUVCbdR38H5GqLgPkxGoCHvs3W3xGHE9i4+NVc1TWVvIya/+U0v7HPC54XF1S25jVi
 N/OR9jhMOQecN
X-Gm-Gg: ASbGnctJb90cTfRJx5bA9NOLA4h3+84Ow0FxltHyQvDQ/uSqcxLLui/BYOGFNoqPBkW
 14ppDqgaIlAXRzOr6sSR8pJVI57VhVE+V4oFeSqn/82bnvgWVGsXHXFhF5hcu+8FC6Hqo7T6GQI
 YkH6cjxj0fJ28ooGQWXKFsDXku+sZSD75OaCS7wlZfcgpjU595ZwwjNNSpt9CtnVmSJ5QYe1t0y
 6s9WKijukS491UB9ZXr/wGRRWHmkOlr7M8K0NyppNycgzbU02Z+Jm7ljOQ5a8Zu18l3ryzy+2DR
 EmMdfF6PU90FClsMNZS87xj/WcmooqCVxBxfNMRzbqPsjt+awFNeHIczizwI9TEhovIQr+FOAGq
 Hh3rHcxEqdlFoWl9IzrEvQRH0Fj/wmn1zePiWSiVX+YBQXkPlO20J+2kMyKoBNfe4+otTOCXWKu
 zo7cJpNmFcGfBhNBF1cpJKuZe7tquSOZCkpWg=
X-Google-Smtp-Source: AGHT+IEccTWO1378fJBOylbAmaJBWCmzZuadQBA26EBPDsJUMzrsFYzpqrTCVsSjhDfLm1gm6BrZjQ==
X-Received: by 2002:a05:600c:810b:b0:468:4350:c84d with SMTP id
 5b1f17b1804b1-46fa9a8657fmr53893765e9.7.1760020292153; 
 Thu, 09 Oct 2025 07:31:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb484f5e3sm231055e9.18.2025.10.09.07.31.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 07:31:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/6] hw/hppa: Introduce HppaMachineState::boot_info::kernel
 structure
Date: Thu,  9 Oct 2025 16:31:05 +0200
Message-ID: <20251009143106.22724-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009143106.22724-1-philmd@linaro.org>
References: <20251009143106.22724-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x342.google.com
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

CPUHPPAState::@cmdline_or_bootorder is now only used in kernel
mode. Move it to HppaMachineState::kernel, and use the 'hwaddr'
type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/cpu.h |  1 -
 hw/hppa/machine.c | 11 +++++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index e14f238827b..0aa06f6ebec 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -273,7 +273,6 @@ typedef struct CPUArchState {
     bool is_pa20;
 
     target_ulong kernel_entry; /* Linux kernel was loaded here */
-    target_ulong cmdline_or_bootorder;
     target_ulong initrd_base, initrd_end;
 } CPUHPPAState;
 
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 138cd97efd9..c315d13ea01 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -49,6 +49,9 @@ struct HppaMachineState {
                 char bootorder;
                 bool interactive_mode;
             } firmware;
+            struct {
+                hwaddr cmdline_paddr;
+            } kernel;
         };
     } boot_info;
 };
@@ -495,8 +498,8 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
         hms->boot_info.is_kernel = true;
 
         if (kernel_cmdline) {
-            cpu[0]->env.cmdline_or_bootorder = 0x4000;
-            pstrcpy_targphys("cmdline", cpu[0]->env.cmdline_or_bootorder,
+            hms->boot_info.kernel.cmdline_paddr = 0x4000;
+            pstrcpy_targphys("cmdline", hms->boot_info.kernel.cmdline_paddr,
                              TARGET_PAGE_SIZE, kernel_cmdline);
         }
 
@@ -687,7 +690,7 @@ static void hppa_machine_reset(MachineState *ms, ResetType type)
                          ? cpu[0]->env.kernel_entry
                          : hms->boot_info.firmware.interactive_mode;
     cpu[0]->env.gr[24] = hms->boot_info.is_kernel
-                         ? cpu[0]->env.cmdline_or_bootorder
+                         ? hms->boot_info.kernel.cmdline_paddr
                          : hms->boot_info.firmware.bootorder;
     cpu[0]->env.gr[23] = cpu[0]->env.initrd_base;
     cpu[0]->env.gr[22] = cpu[0]->env.initrd_end;
@@ -698,7 +701,7 @@ static void hppa_machine_reset(MachineState *ms, ResetType type)
     cpu[0]->env.kernel_entry = 0;
     cpu[0]->env.initrd_base = 0;
     cpu[0]->env.initrd_end = 0;
-    cpu[0]->env.cmdline_or_bootorder = 0;
+    hms->boot_info.kernel.cmdline_paddr = 0;
     hms->boot_info.firmware.bootorder = mc->default_boot_order[0];
 }
 
-- 
2.51.0


