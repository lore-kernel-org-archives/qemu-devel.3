Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1D2CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 06:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v76T9-0001m1-Th; Fri, 10 Oct 2025 02:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v76T8-0001lR-Db
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 02:19:10 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v76T1-0001HX-Ua
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 02:19:10 -0400
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-46b303f755aso13170435e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 23:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760077142; x=1760681942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bVqaOgMWNzPQ72Xk8r5FC1qOKhB0mUP3ugx2Q83BZeI=;
 b=oXiBUFywPGlAoBfhstq5vobRFG8n3jS7WPhR4F86YLHivxMdSsaPvutezFdzkR0jXA
 8+t2cdmiPzpUT83DBJk4Td1Hn/BPKb1vExR5BygIZzznrqRSyMvqbYHyQKVUgxIz55+v
 Dk8f3p8KA8oq+T7je4bCs60wZZvcN1dnycKlnphgHyi2lfyDTFz8+jy/aTCrVocAKmmj
 2Rjr+wauy+JHJLzT+JiR/QqeLi5PYmiRstVxQ/gm2UGXY770+nJD/xNc+MU+7GdvUAkm
 /1hwrnH19peHtCQ8rbC7qRR8H0LObwchPCF/XU+cI1zzNWBzQ8egGngRQ/wC08SBaXM8
 XwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760077142; x=1760681942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bVqaOgMWNzPQ72Xk8r5FC1qOKhB0mUP3ugx2Q83BZeI=;
 b=JV18y9xTwFBjFLtHLpYPSqdwWAqwwFxhHRAOmCSy8WkRGykaf+avsC35Dyes97zhXM
 6VJthC6hMqHYqSc2MR2ujhGKv0AEDRvoKT7fya47qc+iMCr/aaH6pN3PpL2z8Imqi/bL
 K03PPaWu4tcf4y2euoy6pWiuMQfPB2KplBHopdO/pfu5bgGU53B5Kuu+s1AhoKoXkDc5
 MwpwaQZRa31KtX0AkyZ82nSMoTqhz2P2IQczoVeeNgjbfTBrbVPocCRYTRjh3QLcHCF8
 /MRmaEH8KsZb15pvRfA2G9n4YP9V77A3jDdjLIB5MjKqQr+b5pUhdqfNwUhwKCM6E0S/
 /3kw==
X-Gm-Message-State: AOJu0YzH4y7zyxSVCbCeuzVyF9dvXuQ2ZuQCJOf36u9q4VkjNX1PQ5y8
 xm8HmFrjvAR9mW3Beh160Y9UCEGy9Z+XYjtzhkqe3Yx8vv0bQyoOubeWYmkwEH7X8NKwQgqjnuA
 GLrmaP25FlyGt
X-Gm-Gg: ASbGnctIVQW957hYCXq5WQLgzkJvVhqMRAAJNaMjLjFqHpqfthBff4RKprGJRJ6WGGB
 ffeTZ6XQ8e91X7J/ZdqDFG9M8od+yvG2C690uiAnTRHDiaAvdfVvG1VLhCAlstjxBQD7KzngGBj
 J9Vvw6iJQDG1a2SpqJ6nO9B0nxC8LcLsiqxVIe+fzmColQ4C1DxmG9AeKxW18t5/mM2D/1Jt4qq
 Ld1iduXw+77HL5DZcNBLlvgxEHOwlu5c/10sdcjda+JspE62SGAqQvvFQFvSXdJlaKa7gb62VLy
 1yZUMvyMvS1VNMUe3mKe2feF0q3ATVN9Z7ypC8P8FALxtIePFz3v0MfXPRlZBi/aRDebcwOzGDB
 JvtayyLi43Hm+Lkt0Z/vdXkojYl5FW1LFOJUW9a1J69rsTi5OlztFowGNx+wz0O3XASJmqgCuxv
 5TVdrHt8AVlAarQZcOoqkzWQU0
X-Google-Smtp-Source: AGHT+IHPiCYllZmN+Ue5R2/Xetr9YVQVRsuvluIfpH34oyRCZokvL1DKroCcEJg18/hTRSEhesZtgA==
X-Received: by 2002:a05:600c:c083:b0:46f:b32e:5292 with SMTP id
 5b1f17b1804b1-46fb32e5338mr21753845e9.8.1760077141881; 
 Thu, 09 Oct 2025 23:19:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb489194dsm30421395e9.12.2025.10.09.23.19.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 23:19:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 5/6] hw/hppa: Move CPU::cmdline_or_bootorder ->
 Machine::boot_info.gr24
Date: Fri, 10 Oct 2025 08:18:35 +0200
Message-ID: <20251010061836.45739-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010061836.45739-1-philmd@linaro.org>
References: <20251010061836.45739-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

Current code uses CPUHPPAState::@cmdline_or_bootorder to hold either:
 - kernel &cmdline physical address
 - firmware boot order

Besides, these variables don't belong to CPUHPPAState, they
depend on how the machine is started, and only apply to the
first CPU.

Initialize the register value the reset handler needs ($GP24)
once in machine_HP_common_init_tail().

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/cpu.h |  1 -
 hw/hppa/machine.c | 14 +++++++-------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index f54634db7f1..6c9bcbd9078 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -272,7 +272,6 @@ typedef struct CPUArchState {
 
     bool is_pa20;
 
-    target_ulong cmdline_or_bootorder;
     target_ulong initrd_base, initrd_end;
 } CPUHPPAState;
 
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 7066f6d575c..b6f15bc61a3 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -43,6 +43,7 @@ struct HppaMachineState {
     MachineState parent_obj;
 
     struct {
+        uint64_t gr24;
         uint64_t gr25;
     } boot_info;
 };
@@ -492,8 +493,8 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
         hms->boot_info.gr25 = kernel_entry;
 
         if (kernel_cmdline) {
-            cpu[0]->env.cmdline_or_bootorder = 0x4000;
-            pstrcpy_targphys("cmdline", cpu[0]->env.cmdline_or_bootorder,
+            hms->boot_info.gr24 = 0x4000;
+            pstrcpy_targphys("cmdline", hms->boot_info.gr24,
                              TARGET_PAGE_SIZE, kernel_cmdline);
         }
 
@@ -528,13 +529,13 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
         }
     } else {
         /* When booting via firmware, tell firmware if we want interactive
-         * mode (interactive_mode=1), and to boot from CD (cmdline_or_bootorder='d')
-         * or hard disc (cmdline_or_bootorder='c').
+         * mode (interactive_mode=1), and to boot from CD (bootorder='d')
+         * or hard disc (bootorder='c').
          */
         hms->boot_info.gr25 = machine->boot_config.has_menu
                             ? machine->boot_config.menu
                             : 0;
-        cpu[0]->env.cmdline_or_bootorder = machine->boot_config.order[0];
+        hms->boot_info.gr24 = machine->boot_config.order[0];
     }
 }
 
@@ -675,7 +676,7 @@ static void hppa_machine_reset(MachineState *ms, ResetType type)
 
     cpu[0]->env.gr[26] = ms->ram_size;
     cpu[0]->env.gr[25] = hms->boot_info.gr25;
-    cpu[0]->env.gr[24] = cpu[0]->env.cmdline_or_bootorder;
+    cpu[0]->env.gr[24] = hms->boot_info.gr24;
     cpu[0]->env.gr[23] = cpu[0]->env.initrd_base;
     cpu[0]->env.gr[22] = cpu[0]->env.initrd_end;
     cpu[0]->env.gr[21] = smp_cpus;
@@ -685,7 +686,6 @@ static void hppa_machine_reset(MachineState *ms, ResetType type)
     memset(&hms->boot_info, 0, sizeof(hms->boot_info));
     cpu[0]->env.initrd_base = 0;
     cpu[0]->env.initrd_end = 0;
-    cpu[0]->env.cmdline_or_bootorder = 'c';
 }
 
 static void hppa_nmi(NMIState *n, int cpu_index, Error **errp)
-- 
2.51.0


