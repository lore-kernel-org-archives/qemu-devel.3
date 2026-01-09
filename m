Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A64D1A61E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 13:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veCNY-00074e-2U; Fri, 09 Jan 2026 08:18:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1veCN3-0006yB-90
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 08:17:43 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1veCMw-0005tH-QJ
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 08:17:36 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2a0a33d0585so29152045ad.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 05:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767964649; x=1768569449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bdGoioyK2QiPOyfMp3O2eTqnnXisFArETNv4sYqKAKU=;
 b=mafPjb9lqyHwYP9IlRH6HKtoBif1mqzxYjcps8ylFUTfTU3e5fDZiLQq9JaPayVmv1
 9oM94ZTaZlX98myjc/DuMeD1Kt8wnkmSdpUi+oxvi6srp13gLVKGQ245s1uSp5HG4kuF
 4bd3pMsVEulOmrshJkR2SAiL+zsYhjMEz0kpL0PtdT+s0pYbV3vKj4Qk/TXbQPjh7pja
 XK4oXPm3+JxnOI4C1SpjFn9ECMWuQpvwC16lV7EwNI2QrKduXF94Xd0BfvBOTScrRujq
 G1bdyFxyDbS1gBOzWu7pdDuqt5W5asgcoVFC9SHgai9+c8RJdw/6Uknmy1MMfUXEuofk
 0RmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767964649; x=1768569449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bdGoioyK2QiPOyfMp3O2eTqnnXisFArETNv4sYqKAKU=;
 b=reDma1So2/JesRryJX4UZWWJBmQP1jmIbtoaQFD31JS+iyNIMQqm4qi0y4tULeIV2+
 RdkVlxRk2ewI6l9rmz3ebqs8wo5L5oMYHKmBzNxeHoLZZxTVkA/cjTfE92MGxhwGM/Vi
 /8dQo3mT+omUoZDYJcHsnRsk7F8o5aaXMloAQW5gdiWeYJoVcdMkUS/vnCHz6WOj84a4
 88c+dQBKy4WmA3sb3gwUcGqLIA8mwgbPzAshs2CoA8m66bqcKXqasPmpWVDVIQWZthn8
 kB2EVhZomi7GRY8Lf8A9bhk2rUo326B/O/PqEfdMgO+Tr1G1cdEYD30i94Qj8RY40AFB
 sytw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWov7QD4KyEWAQQRbj3mrc1ZGzS/6QHy9rk293N73RQp8o9QUk/oT9Y09eWJOEVFraztJAZPsJkVthq@nongnu.org
X-Gm-Message-State: AOJu0YwpURCgDY7r07Q3jcMz6JMMzAoOKrZgBlvrqBGXalTIkjq3YsZY
 6MXI59JrvuBoBGOMeSwiA/oWBp8S+a4oUdKi74PJ7KflLgqaKMh6EIPm
X-Gm-Gg: AY/fxX5uBwNczHeTMCPvBsH24uyxfJ4oWMDgwTAPXZq+y05pEH8R9exVt6fIwL4EKBP
 +o9I95doTN8ltmEpakehRZZsERK0Yldb8XRtFi95GbZ8V+nuD9COjZtZ32ewJYTg+Weg9VdtJ7u
 Eiy4aZNTrwSW50OVwVwG3PiKDEfMX0U+93j+sUaGf3tgMODn9o8OHRRz25L4/ALiQHz9EJ/2g8r
 D3PQfB+FKGt2Zcl2ayeLdHB7ox76X2kRlDK9XTj+E2RpQOPnvfUSfNwpeP/ft/2yNISDkZuAI/K
 NKItoiD+CE2nW4Ct0AAPjBpQZxZmYbojhLGyg/OQCkbqgopmiqQ7N1e+tFw1LvFGliLpsf7Foyt
 3aA5e1hfRjcO/vCwqeRjYShL8VinExSdUaOJAXusyjq1KaSNB8WB1joxbFspbqg9sFMI3xVY8jx
 /oFqFyow0V9QLTzUPk8gn1
X-Google-Smtp-Source: AGHT+IEL9n52ei84W9xn7OVtF8WoJOOzh4g541L875Gw/s42e1h6ru0IcBxYJqy7fZ/YPzVGKEj1Ng==
X-Received: by 2002:a17:902:cf05:b0:2a0:97d2:a264 with SMTP id
 d9443c01a7336-2a3ee49015dmr86832435ad.37.1767964649069; 
 Fri, 09 Jan 2026 05:17:29 -0800 (PST)
Received: from donnager-debian.. ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c47390sm106103735ad.25.2026.01.09.05.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 05:17:28 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Vijai Kumar K <vijai@behindbytes.com>, Ran Wang <wangran@bosc.ac.cn>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: [PATCH 1/4] hw/riscv/boot: Describe discontiguous memory in boot_info
Date: Fri,  9 Jan 2026 23:46:52 +1030
Message-ID: <20260109131657.396794-2-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109131657.396794-1-joel@jms.id.au>
References: <20260109131657.396794-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

Machines that have discontiguous memory may need to adjust where
firmware and images are loaded at boot. Provide an interfaces for
machines to describe a discontiguous low/high RAM scheme for this
purpose.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/riscv/boot.h |  7 +++++++
 hw/riscv/boot.c         | 11 +++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index f00b3ca12245..115e3222174f 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -28,6 +28,10 @@
 #define RISCV64_BIOS_BIN    "opensbi-riscv64-generic-fw_dynamic.bin"
 
 typedef struct RISCVBootInfo {
+    /* First contiguous RAM region. If size is zero then assume entire RAM */
+    hwaddr ram_low_start;
+    hwaddr ram_low_size;
+
     ssize_t kernel_size;
     hwaddr image_low_addr;
     hwaddr image_high_addr;
@@ -43,6 +47,9 @@ bool riscv_is_32bit(RISCVHartArrayState *harts);
 char *riscv_plic_hart_config_string(int hart_count);
 
 void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts);
+void riscv_boot_info_init_discontig_mem(RISCVBootInfo *info,
+                                        RISCVHartArrayState *harts,
+                                        hwaddr start, hwaddr size);
 vaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
                                    hwaddr firmware_end_addr);
 hwaddr riscv_find_and_load_firmware(MachineState *machine,
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index e5490beda007..9babb85b0458 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -69,11 +69,22 @@ char *riscv_plic_hart_config_string(int hart_count)
 
 void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts)
 {
+    info->ram_low_start = 0;
+    info->ram_low_size = 0;
     info->kernel_size = 0;
     info->initrd_size = 0;
     info->is_32bit = riscv_is_32bit(harts);
 }
 
+void riscv_boot_info_init_discontig_mem(RISCVBootInfo *info,
+                                        RISCVHartArrayState *harts,
+                                        hwaddr start, hwaddr size)
+{
+    riscv_boot_info_init(info, harts);
+    info->ram_low_start = start;
+    info->ram_low_size = size;
+}
+
 vaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
                                    hwaddr firmware_end_addr) {
     if (info->is_32bit) {
-- 
2.47.3


