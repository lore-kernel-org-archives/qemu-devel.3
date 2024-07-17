Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32FF7C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 14:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU5WX-0006XM-UP; Wed, 17 Jul 2024 10:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sU5WR-0006UV-UN; Wed, 17 Jul 2024 10:20:48 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sU5WN-0004bM-LF; Wed, 17 Jul 2024 10:20:46 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so5358915e9.1; 
 Wed, 17 Jul 2024 07:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721226041; x=1721830841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zGAbM8QJpZ96DmlOT720qBNbXGY78gAejPKZ75MksbE=;
 b=XI+5sA6eUkzOrlH+1pdbOksDdChIqboVGRc7E1WUZ50x85JtB1mVLc9Ee+9Dzez9rA
 Kl/200RyjtHQc6sIpOj4cTZKqJlSAa6zbGs/kfsY+TWqu7Sw3JtlVZMl4gEoigM4ILIF
 GjQ4bo49WYAHWrMgAfYCidGkuj58NixVgvIZsC4/Zg6e51lifGQg3Ps3nqidLSsbno6b
 y/dT3yUvAD/HNKW3bvGBiNypoZsSFjE+wGkgjxf7BfKCgOPuj+xU4dmWEoT9lYcfHrS1
 NMmzUybxBMw3jVRWoAhEdsrHWx9j3iplwqmY1WQDAP+J7rhBS97MODsVCkNj4kEJ1pqw
 30xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721226041; x=1721830841;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zGAbM8QJpZ96DmlOT720qBNbXGY78gAejPKZ75MksbE=;
 b=PHaZSlt4mJPFIlhdrq5wZPZ+evQLBNWVcEOoe3mS22Ox9DzvjTbsTv+4Jz4mOhBsOe
 q6PkVkDWIjYw1VpIHBv3MGE9lY2tKg5uAZwUIB1mP6LqVqAjngYWtKX/QWmT7GcdQeDe
 19dYvq60GhAEdaNjJNDzlg+Yf3t0fPtAZSWRFVxPYB5Nis87SpLmEqv3J8CVwdtOnUlT
 mplujEatNBbxKh02ndlThQLQgCW8dVNMzqTu7vuoZOnBCU3dB7OHGSm6EvcYb9kJ6cg5
 HdfyIxmxKvGvumOArYQpmfax742g5QVL4Nsmsi8yqVj9SmuKDIKAepEUfqufpm5grnc4
 as4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcR5HWaEB4o+hu5RfqGgR8pczlspQeBG8j1vp2rzoWqcX3TPyanjOcyTIkfk+3edx0dEzTfiVP3a5x/LHRfB+m1otjxrgVRIz9aRC73abPEGPN3t24rzWXA28=
X-Gm-Message-State: AOJu0Yy085wHSkNKYK8MHHOZuiUT4ScGiu9yOKA2IanYFIm4CBUe45Ts
 Gg2Tim97fm24xfIw7v2u1+Lvi3GPJDkauVhz8yUmLxZnqgTw5mM=
X-Google-Smtp-Source: AGHT+IHyJ+PLJTm2y3TfnpjvOg0QbnttLVVVsnFzruNMCr4IFfKl8wJls4xxAbqmIhDEQty781rl3A==
X-Received: by 2002:a05:600c:3590:b0:426:5b19:d2b3 with SMTP id
 5b1f17b1804b1-427bb8e8379mr39497215e9.14.1721226040783; 
 Wed, 17 Jul 2024 07:20:40 -0700 (PDT)
Received: from wing.epfl.ch (dhcp-122-dist-b-021.epfl.ch. [128.178.122.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5e77493sm178425905e9.7.2024.07.17.07.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 07:20:40 -0700 (PDT)
From: Zheyu Ma <zheyuma97@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Zheyu Ma <zheyuma97@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3] hw/display/sm501: Fix potential overflow in memory size
 index
Date: Wed, 17 Jul 2024 16:20:29 +0200
Message-Id: <20240717142029.66372-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=zheyuma97@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This patch addresses potential issues in the sm501 memory size
configuration. Specifically, it adds validation checks to ensure that
the local_mem_size_index value written to the SM501_DRAM_CONTROL
register is within valid bounds. It ensures that the selected memory
size does not exceed the available VRAM size.

Additionally, the read operation for the SM501_DRAM_CONTROL register
is modified to return the raw dram_control value without combining it
with the local_mem_size_index.

ASAN log:
==3067247==ERROR: AddressSanitizer: global-buffer-overflow on address
0x55c6586e4d3c at pc 0x55c655d4e0ac bp 0x7ffc9d5c6a10 sp 0x7ffc9d5c6a08
READ of size 4 at 0x55c6586e4d3c thread T0
    #0 0x55c655d4e0ab in sm501_2d_operation qemu/hw/display/sm501.c:729:21
    #1 0x55c655d4b8a1 in sm501_2d_engine_write qemu/hw/display/sm501.c:1551:13

Reproducer:
cat << EOF | qemu-system-x86_64  \
-display none -machine accel=qtest, -m 512M -machine q35 -nodefaults \
-device sm501 -qtest stdio
outl 0xcf8 0x80000814
outl 0xcfc 0xe4000000
outl 0xcf8 0x80000804
outw 0xcfc 0x02
writel 0xe4000010 0xe000
writel 0xe4100010 0x10000
writel 0xe4100008 0x10001
writel 0xe410000c 0x80000000
EOF

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
Changes in v3:
- Also change the read operation
- Refine the error log
Changes in v2:
- Also check the memory_region_size bound
---
 hw/display/sm501.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 26dc8170d8..af9765a354 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -961,7 +961,7 @@ static uint64_t sm501_system_config_read(void *opaque, hwaddr addr,
         ret = 0x050100A0;
         break;
     case SM501_DRAM_CONTROL:
-        ret = (s->dram_control & 0x07F107C0) | s->local_mem_size_index << 13;
+        ret = s->dram_control;
         break;
     case SM501_ARBTRTN_CONTROL:
         ret = s->arbitration_control;
@@ -1020,11 +1020,24 @@ static void sm501_system_config_write(void *opaque, hwaddr addr,
         s->gpio_63_32_control = value & 0xFF80FFFF;
         break;
     case SM501_DRAM_CONTROL:
-        s->local_mem_size_index = (value >> 13) & 0x7;
-        /* TODO : check validity of size change */
+    {
+        int local_mem_size_index = (value >> 13) & 0x7;
+        if (local_mem_size_index >= ARRAY_SIZE(sm501_mem_local_size)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "sm501: Invalid local_mem_size_index value: %d\n",
+                          local_mem_size_index);
+        } else if (sm501_mem_local_size[local_mem_size_index] >
+                   memory_region_size(&s->local_mem_region)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "sm501: Memory size %d cannot be more than vram_size\n",
+                          sm501_mem_local_size[local_mem_size_index]);
+        } else {
+            s->local_mem_size_index = local_mem_size_index;
+        }
         s->dram_control &= 0x80000000;
         s->dram_control |= value & 0x7FFFFFC3;
         break;
+    }
     case SM501_ARBTRTN_CONTROL:
         s->arbitration_control = value & 0x37777777;
         break;
-- 
2.34.1


