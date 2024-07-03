Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB44C30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 15:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP2Lu-0002kT-KS; Wed, 03 Jul 2024 11:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sP2Lq-0002fC-GI; Wed, 03 Jul 2024 11:56:58 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sP2Lo-0000w3-Nq; Wed, 03 Jul 2024 11:56:58 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-425809eef0eso26376125e9.3; 
 Wed, 03 Jul 2024 08:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720022210; x=1720627010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LQOK9pjTJjZNue9VVtyWIczQ+3PWwfz24C1CtOqUlZA=;
 b=ay4o8VTPBsNT1ID6EjFIRgVnCmqRNQY66xmEiWPgpklGla7ViJkksN6FjbXzpCF0Hn
 78x3VXzkI7qvzjpvbFJQdLAKPRIolQlCNc/lhW9MLcgevyB6iS9OOrKVCJfZ3ayISwTn
 4Pr1RWh4R+50SoLLySSxtrpFzjSqCaYrqcTs8Tnbvzc6l26rDIIyoOGqP9J6/xZnYJ6S
 mm3K8fX78N0qKtbZ1ZGxhvybLhWI8+0NYl0c8hHo5fQIF/3IjdNLTn5fHzXD4QG66q8q
 nlKTe6GBehZod4h8nEkrSoOYnhByZtcGEwuhIlvybz2vjTTjy5x3tgPJfHIBa4UXbZnr
 1djQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720022210; x=1720627010;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LQOK9pjTJjZNue9VVtyWIczQ+3PWwfz24C1CtOqUlZA=;
 b=u9572S1NOdkZaU+rd6QVhHFXWV2yBXmndX4rKNDr6XPo6d1YwX0w/HNIa0tdycjR0+
 TxwgE+V4b32h0+gH8FHuMFOrZv8XMU8WDmcno8usHEu4WOtOpZr21J3ZwcgoxcKMIByY
 9rZf0Sr7Z/o2zSgOj5//QjAp3ErnfKpS4rpYu9tdhrKDbZ+2J42PvcvQ8mpgFXFmaP2E
 Na3tYtbkkTcGjCLnDKaV2EquuVKpx5G0E1p+bjtea2LtmmLJW01WFMnrdGeXlfTtjDGb
 b++bKmOlL2YpMSrRsmJZ/LziG0bFiedPbg2VXZKFtGZ7EtdG8o6BU2ZhQLuaXUfn/rlB
 RqGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXywBdBo38k+29hu5cUBv2b3t9LDloGWOEoE4KzinUtA/y+CoyUkw87zXrj48zdf1Jp4ZmWH5uzYJekIoJwYgwCt/BKe07oLlqpeY2i/WgHaS+UMJrbmbLo6B8=
X-Gm-Message-State: AOJu0Yx6479tWRLVspuzP8xBGMrQhWOiwtDRKXsu+SCnE0d5MyCeaPqr
 rgAZFIQKW81shpvmApTrWe5NY8dlnigIPZLrGx7ypyuJ3/BCOHs=
X-Google-Smtp-Source: AGHT+IH8oyet79kwsM7q/NtXVGBjyiEwx3JNh0Cs3AUNER/AD0jpReStLc6LLPvoDz3UGxPwAHcwog==
X-Received: by 2002:a05:600c:3b97:b0:424:addc:c79a with SMTP id
 5b1f17b1804b1-4257a02c7famr78725205e9.7.1720022210199; 
 Wed, 03 Jul 2024 08:56:50 -0700 (PDT)
Received: from wing.epfl.ch (dhcp-122-dist-b-021.epfl.ch. [128.178.122.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af54ecasm240094075e9.12.2024.07.03.08.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 08:56:49 -0700 (PDT)
From: Zheyu Ma <zheyuma97@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Zheyu Ma <zheyuma97@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2] hw/display/sm501: Validate local memory size index in
 sm501_system_config_write
Date: Wed,  3 Jul 2024 17:56:33 +0200
Message-Id: <20240703155633.17352-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=zheyuma97@gmail.com; helo=mail-wm1-x334.google.com
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

Ensure that the local_mem_size_index is within valid bounds and does not
exceed the allocated memory size before updating it in sm501_system_config_write
to prevent out-of-bounds read.

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
Changes in v2:
- Also check the memory_region_size bound
Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 hw/display/sm501.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 26dc8170d8..a878c35dd9 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1020,11 +1020,21 @@ static void sm501_system_config_write(void *opaque, hwaddr addr,
         s->gpio_63_32_control = value & 0xFF80FFFF;
         break;
     case SM501_DRAM_CONTROL:
-        s->local_mem_size_index = (value >> 13) & 0x7;
-        /* TODO : check validity of size change */
+    {
+        int local_mem_size_index = (value >> 13) & 0x7;
+        if (local_mem_size_index < ARRAY_SIZE(sm501_mem_local_size) &&
+            sm501_mem_local_size[local_mem_size_index] <=
+                    memory_region_size(&s->local_mem_region)) {
+            s->local_mem_size_index = local_mem_size_index;
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "sm501: Invalid local_mem_size_index value: %d or memory size too large\n",
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


