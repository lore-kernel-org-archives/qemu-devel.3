Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92207CD343F
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 00:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wO36x-0000Cl-Nr; Fri, 15 May 2026 20:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wO36w-0000CW-Ut
 for qemu-devel@nongnu.org; Fri, 15 May 2026 20:42:34 -0400
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wO36t-0001lH-Po
 for qemu-devel@nongnu.org; Fri, 15 May 2026 20:42:34 -0400
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-1309f4ee97fso393020c88.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778892150; x=1779496950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UDoNhf6KynPL4YFKLBUj+5auhyRSEdnU3zK6Mig90ZY=;
 b=J4QEIp8cfWpacxgYJ/gr2+7msWv8Lz7/4MGiCT3l99QR9B8zLX8zXcKlSum7cDYHsr
 2QeVnBv69X0EH8xE1DN/p5LUlDS87WM5pW7gXIcRuHB3PoWx2BVPOkPPeWgKyQLfAIA3
 6q+qMXx61YG65FfHBp4vJpQMru+zWy3UdFkTQ/PQRunUWU91nZYXUpzn4+ZAFsZ+cbaD
 ky8Eooh0RmiEe6ehMG+BEIojD/lxsC4wcOpC4+ka6CbkgwscpIs96C2KYhdIih/PXq6Q
 6bNgzKPGo7xO81q5MYpdQUVXBF8YaNeidSDH6mXRkMsKOu3QbveU89dACzfLKMhDx8WN
 ZIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778892150; x=1779496950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UDoNhf6KynPL4YFKLBUj+5auhyRSEdnU3zK6Mig90ZY=;
 b=jPwOYT5Dx3URyDHqQB+CpVMD7RHpR/6D7ZnG5SLdIKAzMomn4+cr+Mm06KO15y6IZ5
 Y9L8oAfC4K/Yf5SZTaAy41MMG+R0NeapY3/e+anxkrIJovpTSGkyZ6mtntaY3Ngf6UKz
 WWOwdNHNVYmU3TDnA3p4RzhJUVK+xOLDPw6tSDa8kplo3df5M5RPSLtoLgVFgRidsErm
 bIP9vcohqwl1JaKVQscJWNCRgXCk2Ov06+Lgo+oKbL9Wvp2OxgHG5c1CdV1iaby4vkHa
 CatOHo93vkc0+jBgoA8Ijy7PCtmU3C0dq3t90v7DFoz7PBEI0tKOH6dTKnTGVi9WAbe7
 zW3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/8GQB2n4LH1bRBrbclC/4ogXrSEWvXDlVXpOIukWHAyrmnJADMomZRNJqG73mvz3ieULRAv5uRoNwk@nongnu.org
X-Gm-Message-State: AOJu0Yyp5ZcxgFA72WSprT+w6bRBcbcjeKi2u4cVqjn+J9O/xLuqFaYd
 46ylgoizimCSDsv7jg8q5x/c0Q0o/GZCpgL7ZOdbaofoeuM1X7nNb9hJ
X-Gm-Gg: Acq92OEhTdHISwREr+kMNF/RevGT/xxdO+GnfRet49GZh7eu6uqBOiarJ00Wdc9Uav/
 ZvKYYDTDM/yGsfdL+k80jeK4MtfunHXSSSWBH4GWLW3MXKEAdpyEZ7nDqoIHh6NQ8QogwjtneqP
 i/HAcLWjCxFJ2FIHyNlWARm5in9NIwGKZandZIopbOIYjTY9LMzHJnFC0Fr6PUWdK/Yp3m59OSj
 i/JLvk2gU+MYHW2E57XcELwvhCJ6JkswRNtgJ3zfo5IZTX4oUe8cCSeDDykWqRphwLv5zZG2lcc
 FOVm0Rx+DUfsWZBCwEkulscfG2Gko4X1Lg/cq3r0h/fYpI45OJ3F4/4RfuuMD/A5VVUyK/w1HXf
 itrAqDlrmV6bJv4f9fTAKAU8Px56Fh6hdiy8RE4DSUE1SZLFzcFc7P+rblDM5MZvvRJF4iujkIJ
 WspBoDlJYmmB3czhEw47kV4KVOeQ2h2bg=
X-Received: by 2002:a05:7022:128c:b0:128:ca83:5aa3 with SMTP id
 a92af1059eb24-1350440d257mr2587224c88.1.1778892150297; 
 Fri, 15 May 2026 17:42:30 -0700 (PDT)
Received: from localhost ([38.104.138.51]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cbcb9ed3sm11661762c88.1.2026.05.15.17.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 17:42:29 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 06/10] hw/riscv/atlantis: Provide a simple halting payload
Date: Fri, 15 May 2026 17:42:01 -0700
Message-ID: <20260516004206.169035-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516004206.169035-1-npiggin@gmail.com>
References: <20260516004206.169035-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1231;
 envelope-from=npiggin@gmail.com; helo=mail-dl1-x1231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

OpenSBI hangs before any console output if the domain init code sees the
next stage is not in an executable region.

If no kernel payload is provided to QEMU, the next stage address is
NULL, and the riscv virt machine memory map ends up covering the 0
address with the catch all S-mode RWX region and so OpenSBI prints
console messages and does not hang until the next stage boot.

The Tenstorrent Atlantis machine address map has RAM starting at 0 and
it loads OpenSBI there, so it is M-mode and not accessible by S-mode,
tripping the early check and hang.

Add a helper to set up a simple payload that gets OpenSBI messages to
console, until OpenSBI can be fixed.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/tt_atlantis.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 43f47fbd75..789a66870a 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -384,6 +384,30 @@ static void create_fdt(TTAtlantisState *s)
     create_fdt_pmu(s);
 }
 
+/*
+ * This works around a problem with OpenSBI hanging with no console output if
+ * no payload is provided. By chance, machines with memory at 0x80000000 do get
+ * output, but Atlantis memory begins at 0x0 which takes a different OpenSBI
+ * error path.
+ *
+ * This can be removed when OpenSBI is fixed in QEMU.
+ */
+static void tt_atlantis_setup_halting_payload_opensbi_fixup(
+                                        RISCVBootInfo *info, hwaddr addr)
+{
+    /* Store the payload vector in little_endian byte order */
+    static const uint32_t payload_vec[] = {
+        const_le32(0x10500073),         /* 1: wfi           */
+        const_le32(0xffdff06f),         /* j       1b       */
+    };
+    rom_add_blob_fixed_as("mrom.payload", payload_vec, sizeof(payload_vec),
+                          addr, &address_space_memory);
+
+    info->kernel_size = sizeof(payload_vec);
+    info->image_low_addr = addr;
+    info->image_high_addr = info->image_low_addr + info->kernel_size;
+}
+
 static void tt_atlantis_machine_done(Notifier *notifier, void *data)
 {
     TTAtlantisState *s = container_of(notifier, TTAtlantisState, machine_done);
@@ -421,6 +445,9 @@ static void tt_atlantis_machine_done(Notifier *notifier, void *data)
     if (machine->kernel_filename) {
         riscv_load_kernel(machine, &boot_info, kernel_start_addr,
                           true, NULL);
+    } else {
+        tt_atlantis_setup_halting_payload_opensbi_fixup(&boot_info,
+                                                        kernel_start_addr);
     }
     kernel_entry = boot_info.image_low_addr;
 
-- 
2.53.0


