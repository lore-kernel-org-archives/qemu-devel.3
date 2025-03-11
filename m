Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82147C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 19:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts5dt-0006vS-49; Tue, 11 Mar 2025 15:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts5do-0006uV-8i
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:51:54 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts5dm-0007TY-9K
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:51:51 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cf58eea0fso17396885e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 12:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741722708; x=1742327508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=73seHR9MuWhUHelcL1xiHEfBtbLZ+U0WCvX/Qs9nIEI=;
 b=BGPgJjh/riYijJ6zewpKO14nzHbgjvZcm3OGQxHZ3rALH6EKJAaM9XLK+8WpyLOegA
 79mixqbXd1d4UPanfC96UFvLsHLxG8EfctfjicoTx/y3j3sRg+mpiqHEHdoiwpx9LY1/
 LfW28dWg3tiJfjDgUUwEQ1QmrzAynD7k+INLPWt5VHVGLcpS7VO/l11eGjnAHle8MZrI
 w4seVQ+wVLELqp26DVXJLUKorlbnb15A0rJPLZ+1seGJbqtb4VsK7VnRGifNOBwURdKo
 f0qM1IXFAO53QyKW9IIWWP8T0Hc/bEsPJ00jGb7Yc/em/iXUo1LojBbB1Q0MeB40kVBG
 tjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741722708; x=1742327508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=73seHR9MuWhUHelcL1xiHEfBtbLZ+U0WCvX/Qs9nIEI=;
 b=gemd2l5zUaty/TSZCKjc02oN9ew9YW9krqNz4zhhW6tP7umaMBniguoFlhGNT0Rqpi
 DnuKhXvA8Gd7DlbaKKTATojVngGRlLJzqur8PHilT/oV5tjN4AsR2j/C+1KK2AENMVpC
 K27bKoHGK3TBlxyjUqYDMlLef9uXdTsvU6xN3pRiZzTX9ZZKeJQUwtV+X7YGxX+w19Lg
 vIRw1hmLY+GbFEOu4J4rJ7G64ZL6kCtp4x5ep576cv5RFR8E5iOM/ryrdc5AzfFxa3eq
 Ou9If8ZgcUJ/N7whvapsGN9Yjd/Xz0gI3so2oveRiwZtVsF2wzRIazdrGHNC0LN90XSm
 77Rw==
X-Gm-Message-State: AOJu0YytL5W9NJGzb+ZDUVIJeYW+1RRfvYktkJMa0AmiNot0O7Qa1Z4v
 4mcbItIKYFfwQNfZCDRVrG5OCw0+/FjvhIiTDd6BGWQiGgaVYQk9d4gHN6CuOy3PvX/rnw8Q66d
 DMJg=
X-Gm-Gg: ASbGncsgsbQS4dIypkmvXD2o4rLXiSKKpWGIOKwmpajKuXoL5XWeTxSBYgcE38+aJJT
 x9EbOTUGm10VpG6pIMLVsQ7evKyE4nsw0wmLrtte2XzNL/UCpcyeEPv2tQ5Z7K1XZPAQRVPc/bh
 Ai0ZObWJKROv74canuo2fE6f+Dn1rwbaDMiTWjZm4mb8O2GxRKd7V0otm++2QqfqgRzzsEorKtm
 ZOHn/Bv0+ChBo23LZvZJAEfY2aCk87zJY+vY23DUqkO+SIS5iiVsEEN6dW1dizPkl5xVRdxlwpB
 uy4gwdGhJRcpk0Px5jty0oaPAZFeIHxgGRwHWNmPa+GwLeSEUfGPU3KNmZqUEee96H+SleqFPQG
 +Jen+PBRQdV9U7hmgPYQ=
X-Google-Smtp-Source: AGHT+IHLXvbhr8n8/ClmA9jeKcF8xz/pC9ASSp9OjSnVDYxVWwAI8Gbr0GjTgGBflGXfYiJnYoOxeA==
X-Received: by 2002:a05:600c:4587:b0:439:a155:549d with SMTP id
 5b1f17b1804b1-43d01bdbe2amr60319395e9.12.1741722708283; 
 Tue, 11 Mar 2025 12:51:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ce5d2808dsm132200055e9.13.2025.03.11.12.51.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Mar 2025 12:51:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/14] hw/net/smc91c111: Use MAX_PACKET_SIZE instead of magic
 numbers
Date: Tue, 11 Mar 2025 20:51:14 +0100
Message-ID: <20250311195123.94212-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311195123.94212-1-philmd@linaro.org>
References: <20250311195123.94212-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

Now we have a constant for the maximum packet size, we can use it
to replace various hardcoded 2048 values.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250228174802.1945417-4-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/smc91c111.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index 72ce5d8f4de..b05970d5e1c 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -58,7 +58,7 @@ struct smc91c111_state {
     int tx_fifo_done_len;
     int tx_fifo_done[NUM_PACKETS];
     /* Packet buffer memory.  */
-    uint8_t data[NUM_PACKETS][2048];
+    uint8_t data[NUM_PACKETS][MAX_PACKET_SIZE];
     uint8_t int_level;
     uint8_t int_mask;
     MemoryRegion mmio;
@@ -86,7 +86,8 @@ static const VMStateDescription vmstate_smc91c111 = {
         VMSTATE_INT32_ARRAY(rx_fifo, smc91c111_state, NUM_PACKETS),
         VMSTATE_INT32(tx_fifo_done_len, smc91c111_state),
         VMSTATE_INT32_ARRAY(tx_fifo_done, smc91c111_state, NUM_PACKETS),
-        VMSTATE_BUFFER_UNSAFE(data, smc91c111_state, 0, NUM_PACKETS * 2048),
+        VMSTATE_BUFFER_UNSAFE(data, smc91c111_state, 0,
+                              NUM_PACKETS * MAX_PACKET_SIZE),
         VMSTATE_UINT8(int_level, smc91c111_state),
         VMSTATE_UINT8(int_mask, smc91c111_state),
         VMSTATE_END_OF_LIST()
@@ -773,8 +774,9 @@ static ssize_t smc91c111_receive(NetClientState *nc, const uint8_t *buf, size_t
     if (crc)
         packetsize += 4;
     /* TODO: Flag overrun and receive errors.  */
-    if (packetsize > 2048)
+    if (packetsize > MAX_PACKET_SIZE) {
         return -1;
+    }
     packetnum = smc91c111_allocate_packet(s);
     if (packetnum == 0x80)
         return -1;
-- 
2.47.1


