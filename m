Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45AEC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLjXA-0001QL-1g; Mon, 24 Jun 2024 09:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjX8-0001Mo-BR
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:14:58 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjX6-0004yd-Dj
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:14:58 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4217990f8baso37997685e9.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 06:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719234894; x=1719839694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aSK8hO4sLlN1hU/1KYxtFOH8CJir4+Yl/Ws4QmLQZLA=;
 b=upOoYYP9Vsy5BRy55w+Egr7n6iTSPcyii49ZI9cECZIr7UYB4jX4K9fRJKquQ7dH4l
 Lv7GZ082QeVTDCHKLxvO7R6MhR6zU++xlefFmfsIgml/TMXzhCU4lFKNYa+LDA6K8lWX
 Hg4ugob2kVrL4EDc8F65TsZ6+1xxTw0d8Omp7zd9psdTI9Z6OnebaDnQW1lVrPxsfPj2
 MmcMiD4xQrDErVztytfU1fdTLbBjmrL8Dxt6dwr8Ip99PEqMnPsBPNY9tT089xO9ie56
 q+YORExKpOR9g/thnBQjiwfoURbtmJNZC6LEZMg8W4D2/rHfzMlnXjfL+XSrzn26ZxYu
 7OsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719234894; x=1719839694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aSK8hO4sLlN1hU/1KYxtFOH8CJir4+Yl/Ws4QmLQZLA=;
 b=IWWiuT1z4bFEmZm4EnkTfwGN9ebqIPcD1p/8Q4kcbIE1ljPZ6VF01FYIfkyQQl7r2N
 u1IyIkU90SprB5zewLgp1+aA3TP87lJK3W3f0MHo8u0OcbkCxhLx9UOlU74MAuwlDQnS
 5Ip/T+sqCSCY+1DxLjAAJWm7bmBzBopp1gfGr+rX3IGZU5I8mxNSs6d1DDvz/lGe58gb
 3mUow2fxZmBXC1XorkEV4S8u+Yy5/8a4lGG1/XT2PUiMedAn7ybh6uomLLVfGTK0wVuz
 bQE3o4quYvQV8YGkCZlba+Y6OyH8A9EeiiJE+BjyJoTJi4GsAf7YhUAcsJpxA5WFIk4/
 J78Q==
X-Gm-Message-State: AOJu0YwmgGcoTsMNzZ8Q+ziZua8FMu433JQYajuP2ckDqP79qJx2pHE/
 wYsumSlE2Sa5h/7sUujoKxRl68fyftoIz6nfo/9KXTift58gGKyMNeO0c5l7fc+LlCRuU0e/Z+y
 8
X-Google-Smtp-Source: AGHT+IG27lmH8c5acaDS4R9l0BvYew+nhI6n0YlO0kNThaUfJ3gCSxR5aBmqL6Y9iCbFddBOwirUlA==
X-Received: by 2002:a05:600c:818:b0:422:1163:4488 with SMTP id
 5b1f17b1804b1-4248b9c9c5dmr35020065e9.25.1719234894569; 
 Mon, 24 Jun 2024 06:14:54 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247cf5272esm176765475e9.0.2024.06.24.06.14.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 06:14:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Bulekov <alxndr@bu.edu>
Subject: [PULL 02/19] hw/sd/sdcard: Avoid OOB in sd_read_byte() during
 unexpected CMD switch
Date: Mon, 24 Jun 2024 15:14:23 +0200
Message-ID: <20240624131440.81111-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240624131440.81111-1-philmd@linaro.org>
References: <20240624131440.81111-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

For multi-bytes commands, our implementation uses the @data_start
and @data_offset fields to track byte access. We initialize the
command start/offset in buffer once. Malicious guest might abuse
by switching command while staying in the 'transfer' state, switching
command buffer size, and our implementation can access out of buffer
boundary. For example, CMD17 (READ_SINGLE_BLOCK) allows to read up to
512 bytes, and CMD13 (SEND_STATUS) up to 64 bytes. By switching from
CMD17 to CMD13 (see reproducer below), bytes [64-511] are out of the
'status' buffer.

Our implementation return R0 status code for unexpected commands.
Such in-transaction command switch is unexpected and returns R0.
This is a good place to reset the start/offset fields to avoid
malicious accesses.

Can be reproduced running:

  $ export UBSAN_OPTIONS=print_stacktrace=1:halt_on_error=1
  $ cat << EOF | qemu-system-i386 \
                     -display none -nographic \
                     -machine accel=qtest -m 512M \
                     -nodefaults \
                     -device sdhci-pci,sd-spec-version=3 \
                     -device sd-card,drive=mydrive \
                     -drive if=none,index=0,file=null-co://,format=raw,id=mydrive \
                     -qtest stdio -trace sd\* -trace -sdbus_read
  outl 0xcf8 0x80001010
  outl 0xcfc 0xe0000000
  outl 0xcf8 0x80001004
  outw 0xcfc 0x02
  write 0xe000002c 0x1 0x05
  write 0xe000000f 0x1 0x37
  write 0xe000000a 0x1 0x01
  write 0xe000000f 0x1 0x29
  write 0xe000000f 0x1 0x02
  write 0xe000000f 0x1 0x03
  write 0xe000000c 0x1 0x32
  write 0xe000000f 0x1 0x06
  write 0xe0000005 0x1 0x01
  write 0xe0000007 0x1 0x01
  write 0xe0000003 0x1 0x00
  write 0xe000000f 0x1 0x11
  write 0xe000002a 0x1 0x01
  write 0xe000002a 0x1 0x02
  write 0xe000000f 0x1 0x0d
  write 0xe000002a 0x1 0x01
  write 0xe000002a 0x1 0x02
  EOF
  hw/sd/sd.c:1984:15: runtime error: index 256 out of bounds for type 'uint8_t [64]'
  #0 sd_read_byte hw/sd/sd.c:1984:15
  #1 sdbus_read_data hw/sd/core.c:157:23
  #2 sdhci_read_block_from_card hw/sd/sdhci.c:423:9
  #3 sdhci_blkgap_write hw/sd/sdhci.c:1074:13
  #4 sdhci_write hw/sd/sdhci.c:1195:13
  #5 memory_region_write_accessor softmmu/memory.c:492:5
  #6 access_with_adjusted_size softmmu/memory.c:554:18
  #7 memory_region_dispatch_write softmmu/memory.c
  #8 flatview_write_continue softmmu/physmem.c:2778:23
  #9 flatview_write softmmu/physmem.c:2818:14
  #10 address_space_write softmmu/physmem.c:2910:18
  SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior hw/sd/sd.c:1984:15

Reported-by: Alexander Bulekov <alxndr@bu.edu>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/487
Buglink: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=36240
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240408141717.66154-2-philmd@linaro.org>
---
 hw/sd/sd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 807b5d3de3..6a7a10501b 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1826,6 +1826,13 @@ send_response:
         break;
 
     case sd_r0:
+        /*
+         * Invalid state transition, reset implementation
+         * fields to avoid OOB abuse.
+         */
+        sd->data_start = 0;
+        sd->data_offset = 0;
+        /* fall-through */
     case sd_illegal:
         rsplen = 0;
         break;
-- 
2.41.0


