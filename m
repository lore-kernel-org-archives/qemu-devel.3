Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6084C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 22:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOlvH-0000DL-IP; Tue, 02 Jul 2024 18:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sOlv9-00009Z-TP; Tue, 02 Jul 2024 18:24:19 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sOlv8-0004Mu-BI; Tue, 02 Jul 2024 18:24:19 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4256788e13bso34097275e9.2; 
 Tue, 02 Jul 2024 15:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719959056; x=1720563856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YMPI4NI5qgqB10olnsEts08cEoSNuCybDJKAnuq35Gc=;
 b=EW/DbZEEIYw6qiXRGxL9ILYWUEKSnRmc3Tq3Jj6L1TUQilZTbIGcLsg8vW+JaQyKEW
 cSS/NUq3KBBwvZs1aAf7aNhMwtBZ1q+x3GFhAU71yVdOZTMqX5udfQ3mTr9r125WBzGM
 X5BsN8mi0COL9FA+25SHBytQBPV2SsuKfObN4kUQ8MjSgzmwZfR4qsK0IGPggPcviJ4R
 +AJtK487lLWFXv6Vg+CtlCHh/a12bs97QnIZc6EgHThg2Pldq+6LaHPQNfLTh83wxka6
 JNKFAJMyVttxr0hQ1t/D120PEEzLIFCmFIeIdHYPk+FMSVOr/F6RH8QQGPWYPhWFDfOh
 ULDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719959056; x=1720563856;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YMPI4NI5qgqB10olnsEts08cEoSNuCybDJKAnuq35Gc=;
 b=K3hUNzA5YtIIQzMPTKcsYzRf2d6xRo0Bz59gGoIS8dM1oFy+b+wrZm8+VdHnyXM/kz
 GDEE2Ddu52V4ob8akEMtOr/JUhecbe2lJBVZEFUW3d7Ga76+nefjn7wsPAuhnSnuCC76
 tTmonTmsJcsw1lnnWn/FWWFLi1+UpsMbUB2cfh32M9ckVmVyPWdbctRJwc9wLJsupQYq
 OAa9Koz1YNnzP5jk/MgPI1/vW8QsSBV3gDSyHMm/CC0cdMRPG1MYYnyISEXtYhphE7XC
 7KXwe4GrdI+Y8KIZjzSFUPFvmP7ZW8aBD4R1Iup9Rg8yACAU/B2HGVF9cuOI3x7GwiP7
 PNqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW70UKbWfgGnckkZIXwevCxs7s1yzp53U2LMiUaMmdMDuzhBSuhBUhmnloUzoA3rX9t0bmcV+tm7rUL0VhxLH9Ictz2PG2x6x/Vq9vjUHas6QxmK08IIsXiTSo=
X-Gm-Message-State: AOJu0YyEMrJ6uQfsuVmIaBnXPsv6ZUvnjFVbMe1QrEUU+Ns8GOKwIGKr
 HiERmY0KQChwz6Rf5wjwgsF5Gz3C08DqYB0d+zq5LEMSVpqcaTE=
X-Google-Smtp-Source: AGHT+IHZxKpR8fd7wOzJLrlZ9xAxzCAl5Y77W7mDyVQpVROxHS/SX48XiETOih4diXm3spQS/oCKNQ==
X-Received: by 2002:a05:600c:5125:b0:425:672a:7683 with SMTP id
 5b1f17b1804b1-4257a08ded2mr55896055e9.41.1719959056057; 
 Tue, 02 Jul 2024 15:24:16 -0700 (PDT)
Received: from wing.epfl.ch (dhcp-122-dist-b-021.epfl.ch. [128.178.122.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af59732sm214792695e9.11.2024.07.02.15.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 15:24:15 -0700 (PDT)
From: Zheyu Ma <zheyuma97@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Zheyu Ma <zheyuma97@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH] hw/display/sm501: Validate local memory size index in
 sm501_system_config_write
Date: Wed,  3 Jul 2024 00:24:02 +0200
Message-Id: <20240702222402.3070730-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=zheyuma97@gmail.com; helo=mail-wm1-x32a.google.com
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

In sm501_system_config_write(), we update the local memory size index
based on the incoming value. However, there was no check to ensure
that the index is within the valid range, which could result in
a buffer overflow.

This commit adds a check to ensure that the local memory size index
is within the valid range before updating it. If the index is not
valid, an error is logged and the index is not updated.

ASAN log:
==3067247==ERROR: AddressSanitizer: global-buffer-overflow on address 0x55c6586e4d3c at pc 0x55c655d4e0ac bp 0x7ffc9d5c6a10 sp 0x7ffc9d5c6a08
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
 hw/display/sm501.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 26dc8170d8..2cdfeaacab 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1020,11 +1020,19 @@ static void sm501_system_config_write(void *opaque, hwaddr addr,
         s->gpio_63_32_control = value & 0xFF80FFFF;
         break;
     case SM501_DRAM_CONTROL:
-        s->local_mem_size_index = (value >> 13) & 0x7;
-        /* TODO : check validity of size change */
+    {
+        int local_mem_size_index = (value >> 13) & 0x7;
+        if (local_mem_size_index < ARRAY_SIZE(sm501_mem_local_size)) {
+            s->local_mem_size_index = local_mem_size_index;
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "sm501: Invalid local_mem_size_index value: %d\n",
+                          local_mem_size_index);
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


