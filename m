Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F4BD1A61E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 13:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veCNF-00072P-S9; Fri, 09 Jan 2026 08:17:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1veCNC-00070I-90
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 08:17:50 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1veCN8-0005xK-8A
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 08:17:48 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2a0a95200e8so25768985ad.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 05:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767964664; x=1768569464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dEAkhF7Gs/JkiVXMykS0GnYYtidy6ieqVLgHbEaHLzA=;
 b=g/AxMIOnENtmIlU2yieKUXctcYoxtdBHHkzwgnBxadNJrNzCQUPTL/H0Pph2tTA6Ok
 EnJoSEDi3n/m06Y7K25T5W34i0UIP9pz+yRqoeJUcQNWSA40Y5/x95riaobiNhoKOaBO
 fVMBe3kmg+ijRdkJr6C8xja6lKVXJkD+ZOpKtcz2bfl1WLGkCiG/ibAjfLrP2wFCja4p
 O37ABzf93Zp9FkvA/acRC0EV64hL0h4iewBTHX2dktNWKwbSJ4cleTUYjjRMHiJBcN5j
 hlawKBCTZJWuSn9Kzc5XvqHL3zJEBYxbbgo6b2yk3nNLYTLU7lTCpslENtNymdYDABvO
 tQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767964664; x=1768569464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dEAkhF7Gs/JkiVXMykS0GnYYtidy6ieqVLgHbEaHLzA=;
 b=TLreDS0J2F+KwWvPYlfkDyte9SQybErbudOIBd+w6jjkr8/IbY73tsUdU9L9CJyXbX
 ilviINE+vVbuCL/O0PrNsMGE8wXNo+tVlxdQSNDTUjyBLHP1TZRWdPJeTz+zoYwR+Qnq
 a5L3WiZo+eIENZtn8hDlZT0TYe1a2yO6R8vT7WmCLlmka/LC0uKvCahix8oj70wx4r5U
 pQQfAs1W/UQ4hTisxbn95fMoCoJMpPqgGupM9beXHnZSmaEUqBPbzJlRrRwgKNUTdeCo
 /x24dddA4MhA+T2pL5i4Wp5UprwXS86CMzB1z2qCbuBe0q+ggaMNfk0zJnBZD8f7Pajx
 FRLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURrd5wU0uDiIjE4fGxyu24R2KRWveL3HcoJy1GxChSrHwLx+TDnd2mLpcNwidnXyWc6gZmS8N6NyNv@nongnu.org
X-Gm-Message-State: AOJu0YwQ7Tve5EED4w1xSN2W3BC7ODO1DxYpeKSaiasYNDB2nHe+zKQc
 aNhDf5EzCi7JOz7iZEYP2LsnF6kPw9Q0k1QZw7emJ7WRiU34p49sTvLn
X-Gm-Gg: AY/fxX7XJRSrfexy1irI9cyfxcyI2+HhuGbdxPkhIo97IuFzUdDYEO8K7IZnMnCd35s
 lITKctD4unWnL/ozLmDIcrdSJb8tL5ixRj+TbR0JIjtToXI+9ytsWO75A9I+i9bXc6g3ZVRz7pl
 hdtBVltluaj8IuWRcaMq27O5XJdxnCf00Z/PCxJ9mtnh4MCNDB+sGjXYmbV9VQe59wD5cfRRbL4
 LNuePOBxdQ8yJYcZRa75izzUyyWSN+pcDPS/NzZjlYnoTgk1Lfiq82Ngs523XwbMLiUXmatth0n
 sta/I2acvetUaomktLxuXfqOvYrSgWBFIMoDBzukF+OgDnsTaUEbOw3hqKtsnG/Aa3/GlZI6AmC
 aV0V4YyAewqj5DJztOVBPNNqn0FGbfm0huPth+svpecZEn3TCQnoEy1aoO4EFIDLNIDTd/oBNoy
 +CxUYUKTXTUcGxH8zJpC42
X-Google-Smtp-Source: AGHT+IF7ykl69do1dPb+W6el91zat01jqrsDTfEeH7NwkIhso8cO492tTsw1bwTN669PA8gs6P2bRg==
X-Received: by 2002:a17:902:ea09:b0:295:738f:73fe with SMTP id
 d9443c01a7336-2a3ee4ab6a2mr100802305ad.30.1767964664442; 
 Fri, 09 Jan 2026 05:17:44 -0800 (PST)
Received: from donnager-debian.. ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c47390sm106103735ad.25.2026.01.09.05.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 05:17:43 -0800 (PST)
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
Subject: [PATCH 4/4] hw/riscv/boot: Provide a simple halting payload
Date: Fri,  9 Jan 2026 23:46:55 +1030
Message-ID: <20260109131657.396794-5-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109131657.396794-1-joel@jms.id.au>
References: <20260109131657.396794-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

OpenSBI hangs before any console output if the domain init code sees the
next stage is not in an executable region.

If no kernel payload is provided to QEMU, the next stage address is
NULL, and the riscv virt machine memory map ends up covering the 0
address with the catch all S-mode RWX region and so OpenSBI prints
console messages and does not hang until the next stage boot.

The TT Atlantis address map has RAM starting at 0 and it loads OpenSBI
there, so it is M-mode and not accessible by S-mode, tripping the early
check and hang.

Add a helper to set up a simple payload that gets OpenSBI messages
to console.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/riscv/boot.h |  2 ++
 hw/riscv/boot.c         | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index fb90bf12399e..d1d7258a2179 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -78,6 +78,8 @@ void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts
                                hwaddr rom_base, hwaddr rom_size,
                                uint64_t kernel_entry,
                                uint64_t fdt_load_addr);
+void riscv_setup_halting_payload(MachineState *machine,
+                                 RISCVBootInfo *info, hwaddr addr);
 void riscv_rom_copy_firmware_info(MachineState *machine,
                                   RISCVHartArrayState *harts,
                                   hwaddr rom_base,
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 3ea95c175c14..fc8a39a8d913 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -518,6 +518,27 @@ void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts
                                  kernel_entry);
 }
 
+/* Simple payload so OpenSBI does not hang early with no output */
+void riscv_setup_halting_payload(MachineState *machine,
+                                 RISCVBootInfo *info, hwaddr addr)
+{
+    int i;
+    uint32_t payload_vec[] = {
+        0x10500073,                     /* 1: wfi           */
+        0xffdff06f,                     /* j       1b       */
+    };
+    /* copy in the payload vector in little_endian byte order */
+    for (i = 0; i < ARRAY_SIZE(payload_vec); i++) {
+        payload_vec[i] = cpu_to_le32(payload_vec[i]);
+    }
+    rom_add_blob_fixed_as("mrom.payload", payload_vec, sizeof(payload_vec),
+                          addr, &address_space_memory);
+
+    info->kernel_size = sizeof(payload_vec);
+    info->image_low_addr = addr;
+    info->image_high_addr = info->image_low_addr + info->kernel_size;
+}
+
 void riscv_setup_direct_kernel(hwaddr kernel_addr, hwaddr fdt_addr)
 {
     CPUState *cs;
-- 
2.47.3


