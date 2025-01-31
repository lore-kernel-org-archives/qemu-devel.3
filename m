Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6C9C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyCv-00061t-02; Fri, 31 Jan 2025 16:05:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyCq-00061I-EP
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:05:40 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyCp-0007n8-0H
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:05:40 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so29280385e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357537; x=1738962337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=15w1nupw+QeCLHgv52eCdDFsKAOjsC/FzZz5ZeEtw0g=;
 b=EQZemB7ZPz4tY7RRzGIVjXhNZTgc3CBEGid3KzPznhSY0oT66lkPSgO7PezrGSk5SQ
 vn//uTqpl44kjo5ayrnRhitsmwfzgWj3wLBdrYuC+HPHA5+Q5r5MtD5qfEhJim7pNF6E
 vm0dEjUXyb0sNEMNMh4hT0TSU1dQuudR0zqf5DfwJYOTXILXYjgVYlk3l0Gg2R0R0lhn
 modgmA8O5EF4O3EvVZvs6Ea0Rzine5ngaMnEf2yFkCe0lIBJmkJTzoFyM3tTeC7SMB7+
 9XKgpqFV4x3OlB7vcmmTOywV0UENdM+O3eCQsuSerGUFl9rkvXt7tU3Wva8LGMaGsIRq
 TzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357537; x=1738962337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=15w1nupw+QeCLHgv52eCdDFsKAOjsC/FzZz5ZeEtw0g=;
 b=rP+5gSE+LNyG4LixaA3zK7GDMhO1paQrs8xSdMb3H7IXWZGGcsFy4sav4syC5AaBn6
 AAqawse9WltHH5Wfq7NgJXShTr/0ppKpMO3gs65ZH2cs39ECiYKT8sRCJgJiO0bHT5KI
 i7Tguygg89bZckZwnCHJvhhh5gtmFu8lnv9WuZqw7LVl4AeOJAQ1GhZx3B/LAoh3GqMf
 Zu+3oB8NntByi+YiIBs0p3vUX30GJ8B/VoHN7AefB5NJ6aJTpDU37HhHJGfiqtopZslF
 kNHoV1/Jr9DcD3TF76jEKrN5tRkkazbar6tPoZWxBRtAPfgmtfTUp1Bt+5/qfkvo+eOs
 D4KQ==
X-Gm-Message-State: AOJu0Yw50uCa7bh3RpGuwIElqYDSq7iFFn4h5uD0PLNbdxJp+r/7ZRY1
 w1YqyB59a+uGFPvs2Wmjawb5iO3Z1HPC0h5nQY4NLSPj0Yr71lTW459gV3vIWNSHqXY6+sIaXG9
 uke8=
X-Gm-Gg: ASbGncv1Uq+k0oEJm94/mmCBfQhse5vIRfVRwaqwY7m7rLPV7SnYsKjnW3lxY2cvF9o
 SEOMmJ2G6rYcnYmjvzIbrMDLfq2diuRgQ1VRwULhjEjTZF/v4jXMzgeAfyjYyOIJ/lA8ztFmMhx
 7lHRIOiMd8Ekba6P95AzEPxZpRlCahxzz9j8UOEU+Y0v7Zw/AXPzDtZc9NrPHOZi/y7Id78PRP5
 xst/e1a9HQC+Kn/pDpCTUXqOaiJ7JxP46Fvxctn+AaIxhqBe6LUgydppmwIYrFs5CNLIWopt8Xd
 Njy2dW20VqFKoyc4n7hYKbsAS3gCK3AZWHoeZVuodDV/o7kgM05tzmv0kwYi6Q6viQ==
X-Google-Smtp-Source: AGHT+IEf6/pz4oXtvA0V2KPup+IgWnaoFS+371HXbQsWXi9dB3RH57jGmSjij/hk+ecEFXkUu9V7qQ==
X-Received: by 2002:a7b:c5d7:0:b0:431:542d:2599 with SMTP id
 5b1f17b1804b1-438e07cd500mr105141355e9.22.1738357537202; 
 Fri, 31 Jan 2025 13:05:37 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1cf53asm5467812f8f.87.2025.01.31.13.05.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:05:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/36] hw/mips/loongson3_virt: Invert vCPU creation order to
 remove &first_cpu
Date: Fri, 31 Jan 2025 22:04:46 +0100
Message-ID: <20250131210520.85874-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Create vCPUs from the last one to the first one.
No need to use the &first_cpu global since we already
have it referenced.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250115232952.31166-3-philmd@linaro.org>
---
 hw/mips/loongson3_virt.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 47d112981a2..28d4eaf1e59 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -492,9 +492,8 @@ static void mips_loongson3_virt_init(MachineState *machine)
 {
     int i;
     long bios_size;
-    MIPSCPU *cpu;
+    MIPSCPU *cpu = NULL;
     Clock *cpuclk;
-    CPUMIPSState *env;
     DeviceState *liointc;
     DeviceState *ipi = NULL;
     char *filename;
@@ -569,7 +568,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
     cpuclk = clock_new(OBJECT(machine), "cpu-refclk");
     clock_set_hz(cpuclk, DEF_LOONGSON3_FREQ);
 
-    for (i = 0; i < machine->smp.cpus; i++) {
+    for (i = machine->smp.cpus - 1; i >= 0; --i) {
         int node = i / LOONGSON3_CORE_PER_NODE;
         int core = i % LOONGSON3_CORE_PER_NODE;
         int ip;
@@ -609,7 +608,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
                                pin, cpu->env.irq[ip + 2]);
         }
     }
-    env = &MIPS_CPU(first_cpu)->env;
+    assert(cpu); /* This variable points to the first created cpu. */
 
     /* Allocate RAM/BIOS, 0x00000000~0x10000000 is alias of 0x80000000~0x90000000 */
     memory_region_init_rom(bios, NULL, "loongson3.bios",
@@ -640,7 +639,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
         loaderparams.kernel_filename = kernel_filename;
         loaderparams.kernel_cmdline = kernel_cmdline;
         loaderparams.initrd_filename = initrd_filename;
-        loaderparams.kernel_entry = load_kernel(env);
+        loaderparams.kernel_entry = load_kernel(&cpu->env);
 
         init_boot_rom();
         init_boot_param();
-- 
2.47.1


