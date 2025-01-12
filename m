Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2E9E7719E
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 21:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX5zG-0005Le-2a; Sun, 12 Jan 2025 16:59:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX5zD-0005LM-U5
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:59:11 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX5zC-0003my-EB
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:59:11 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38633b5dbcfso3733106f8f.2
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 13:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736719148; x=1737323948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wK3KLpGOg+W1VXGWktCJ4kGgWfKhkmwKswKddpX8HX0=;
 b=ZF5vvIppX8dcxG/ZdFmSQNNa6OzjDuflU0Jg/QNqPfvCMG5MPunXY3G0nIx3Qbdgn2
 ILWQtADXHtm4apayxHxXs1oZPvkveqBaYZ9QjPZOvuJLddUV2u/HtFZ2PbQhaOr9J3lX
 ZVbGomBFe9olTdX0P/eljXVRt/p5uqFcjBER0nnD5vW9tUXXf1js6tvOhYZJq3DE3Wx+
 2YVzDiVd+s0G8f5LaF7Me6QxbH/TbXrfwhfMfxex329FlYgya5L48Kzklec2PXD1HHp6
 CP7VaCMSSerhxY/ZycBq//ln1H0quC7wHCaNioQMIHMbbpolfPj3/fffe4dxAEI7d+Mv
 EoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736719148; x=1737323948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wK3KLpGOg+W1VXGWktCJ4kGgWfKhkmwKswKddpX8HX0=;
 b=oza2bR2wEkd5owPUQUxWsQFNZvDSu282nt1/DmRhx/PpdZADDzXvAGBADL86djzmsY
 r/BTRjhW2HM/0/bwJXfvkaTqWOiN0jmFD5zuKiWiDHgBC7x6ZFfF0dJWHsCqnpmmewBL
 LOpKu/LYQ0ptyTO1hcVq6SOcySel7A0D3jN+8SHJuI9IUeRwbw9Bc7ckwR2XOeR4Z/b7
 UGLe6zL2LtCzrnyUSKRyQor+6pKJfaErXehJU7gp3uS0JBWdDlqnfvsSvXc7G14MWO9p
 I2kdYshClN0Yb3ptqGD2W3POA+7h5DydALYbUgUKt2qRyTgYHHl0rvlropTrUQBNkHwE
 U7tg==
X-Gm-Message-State: AOJu0YxaG/OxuLAKtupV1O2E8d8h2rU3blXV4U86QpMBCH+OkvnaM27/
 W6HvDHdV/MkL2m8TG9/hupk9sitkTSG6Y+TCKMvmIe+iVUWaIKpB0SKdYN1f0SWYmM99+QW9aBm
 x7mc=
X-Gm-Gg: ASbGncs9wXaoiPUgMaNMfNfUbhBWnp10CZXA/rrHT1altA0zXcNc9xLDMzK5TOCwLgt
 kDesDSKd51ZEtMaFyeqersicIBtdxJ10qyO+78SBuNCxXQI2nqUlvyIuqGVFJ8ZBcDNsEWZPr/i
 iO1FPwawdGJTPL8Io9lkDio+rUlpiv4BD3wIX5wTJAIW4ycyz+OWgFFJuYURR0YUXTkY9LiA8gl
 L0diSEPTpDU+chZxHtUgAAq9xZNsGBQge3+7Le10Zi/9Z/+xdnulu0lc0vKlTWhDhmfUrUW5tcF
 Jd3+68jDzLMrZQVYfjj+qKn7EgvkXmw=
X-Google-Smtp-Source: AGHT+IFaOeXE01rf7RNCZKNiPmhVF+WqOxqdLt+uEMHGk1OUSUNHlmKkqNBZqcHnS/rb7CuyLP2WbQ==
X-Received: by 2002:a5d:5f51:0:b0:38a:8e2e:9fe3 with SMTP id
 ffacd0b85a97d-38a8e2ea20cmr11591714f8f.24.1736719148481; 
 Sun, 12 Jan 2025 13:59:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b80d4sm10295173f8f.85.2025.01.12.13.59.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 13:59:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 06/11] hw/mips/loongson3: Propagate cpu_count to
 init_loongson_params()
Date: Sun, 12 Jan 2025 22:58:30 +0100
Message-ID: <20250112215835.29320-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112215835.29320-1-philmd@linaro.org>
References: <20250112215835.29320-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Propagate the %cpu_count from the machine file, allowing
to remove the "hw/boards.h" dependency (which is machine
specific) from loongson3_bootp.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/loongson3_bootp.h |  1 +
 hw/mips/loongson3_bootp.c | 11 ++++++-----
 hw/mips/loongson3_virt.c  |  1 +
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/hw/mips/loongson3_bootp.h b/hw/mips/loongson3_bootp.h
index 9091265df7f..ee6340e42c1 100644
--- a/hw/mips/loongson3_bootp.h
+++ b/hw/mips/loongson3_bootp.h
@@ -233,6 +233,7 @@ enum {
 
 extern const MemMapEntry virt_memmap[];
 void init_loongson_params(struct loongson_params *lp, void *p,
+                          uint32_t cpu_count,
                           uint64_t cpu_freq, uint64_t ram_size);
 void init_reset_system(struct efi_reset_system_t *reset);
 
diff --git a/hw/mips/loongson3_bootp.c b/hw/mips/loongson3_bootp.c
index 712439c2575..91b58a71a68 100644
--- a/hw/mips/loongson3_bootp.c
+++ b/hw/mips/loongson3_bootp.c
@@ -24,10 +24,10 @@
 #include "qemu/bswap.h"
 #include "exec/hwaddr.h"
 #include "cpu.h"
-#include "hw/boards.h"
 #include "hw/mips/loongson3_bootp.h"
 
-static void init_cpu_info(void *g_cpuinfo, uint64_t cpu_freq)
+static void init_cpu_info(void *g_cpuinfo, uint32_t cpu_count,
+                          uint64_t cpu_freq)
 {
     struct efi_cpuinfo_loongson *c = g_cpuinfo;
 
@@ -40,8 +40,8 @@ static void init_cpu_info(void *g_cpuinfo, uint64_t cpu_freq)
     }
 
     c->cpu_startup_core_id = cpu_to_le16(0);
-    c->nr_cpus = cpu_to_le32(current_machine->smp.cpus);
-    c->total_node = cpu_to_le32(DIV_ROUND_UP(current_machine->smp.cpus,
+    c->nr_cpus = cpu_to_le32(cpu_count);
+    c->total_node = cpu_to_le32(DIV_ROUND_UP(cpu_count,
                                              LOONGSON3_CORE_PER_NODE));
 }
 
@@ -112,9 +112,10 @@ static void init_special_info(void *g_special)
 }
 
 void init_loongson_params(struct loongson_params *lp, void *p,
+                          uint32_t cpu_count,
                           uint64_t cpu_freq, uint64_t ram_size)
 {
-    init_cpu_info(p, cpu_freq);
+    init_cpu_info(p, cpu_count, cpu_freq);
     lp->cpu_offset = cpu_to_le64((uintptr_t)p - (uintptr_t)lp);
     p += ROUND_UP(sizeof(struct efi_cpuinfo_loongson), 64);
 
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 078ad46174f..af1937455b0 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -185,6 +185,7 @@ static void init_boot_param(void)
     init_reset_system(&(bp->reset_system));
     p += ROUND_UP(sizeof(struct boot_params), 64);
     init_loongson_params(&(bp->efi.smbios.lp), p,
+                         current_machine->smp.cpus,
                          loaderparams.cpu_freq, loaderparams.ram_size);
 
     rom_add_blob_fixed("params_rom", bp,
-- 
2.47.1


