Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB60C606A326
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 14:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KnHkTLmi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xObYN-0005IQ-Lh; Wed, 04 Nov 2026 09:01:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xObY2-0005HL-HQ
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 09:01:06 -0500
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xObY0-00076g-Dh
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 09:01:05 -0500
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-67be5d0e9cbso544617d50.3
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 06:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793800862; x=1794405662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oWjP9TaVJLspcyTTKOYzm0TyKqIJXml7Jq2J79eYhRA=;
 b=KnHkTLmitulQKKWjo2aSk+ekKsATIPFN6qoO2s4PKDMZoUw6GSlSjQeWcUHt29qjJy
 vxJNGbZY8ycaVseX0xpF06v1mA/a1YwyKV4WFFEOvBmWoEs+7PxMF9lF1rUe9JwS0imN
 lIBqkjlKHgSDrWHNefYtpcdROIo+M7sDcKTcq8HCAK2ikAcM/mWBJRBPGssSnNQUjDz4
 e3ae+FA+rnnMtsjY2yBczoongqh1E+8RStvVhFdb8CrDJ6PJx3vkDdnHfqLdfiWYmlkV
 5FGxFAHJoaJjs1yCN8sCvSd9Tnz/fQDbf/A5VZypN2clX6DqZSOxoEMD5wdkYaHheehI
 2pFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793800862; x=1794405662;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oWjP9TaVJLspcyTTKOYzm0TyKqIJXml7Jq2J79eYhRA=;
 b=IPCLcM4Pt7Vyn+e3iOLaLd9DwEft4WXwKLb0QwJNnJ9l9cJ443cs7+RcaStMyTSTty
 Xrl5vbG8OUbWEnCtbtITX9n9xa8QmIGI/wsa2mZSaQ+SYBQs1ke/MT3bhr8HaRd8Xyai
 klYoeLmE6La9SNB3FRm69FCbG/kQggnwJCo8hxQ+vugfC/+SzJfgHPrGvO03F/A1Pj48
 YHzTjl5NJo/leTr8pF/vAN4nO196supWSLeh/iQWlfrfUGEtrh/vCDAT/lnnvixn9BM5
 +QuOHTNIe3jZJk/L2+HjIkPGRnE2LbxawG7gTq4/GfSPi/6nTTKgkaGlKqkbTdS/aJFd
 qcaA==
X-Gm-Message-State: APuU4Z8ET4LJoFHVQlfcrieDxLq4cah/Zmw3gFdFyknmvMK2B5FXxLHP
 SyTOPeUz71aGO5Bm2EUXdIf0fDvwJTYjtNe+3kO8c5VyimcsAqTHjvSR+l5xnBxq
X-Gm-Gg: AYBFou2ILnhzkzfgmp6LYrwkyXFCJJOyvAFA4qUmrPlj8mbmn5WcQb/1yapwd0c/f5Q
 qjZYJC9F/xssHC9YoCTCeJPNTtYuQfkUtBpL+iIlJ17HZyI9S34/BYZjG4Fj3RSSiQFIz2F1948
 fj8A032EEgW1Gjlnh5UNCnFmOwUTjL8W+MSSvkpNFiS6ux9IEKRG3C+IUDPmRyXVCO5i1OmFVLv
 QkbEqh6AyOmTcNQhAsMU2EoB0pT3UI3GBwFFo8aei7JZQkNQy8JB/W+P+3sI3aDCvjL8oLcw/Zo
 ZMuiCUFhBkCqW+0u49fwj+es9sfwFSehVKNp22JCgRZMcHGP5sMKZzqDV7Nqrn7MhSsHobv6Ou1
 Kvuaw4lajZPCcJ/BdYNwrgbLcqPY1C32MKUB718ZyOb0GoMcqKzGTUln/3b01jX2Vi4fgXSlfL4
 HtEyEFZd2hYtwoje14SRbYStjNE8V0ZA4xQvuCbR1kDocUogw+72dHMqKLT+ZuR3dnr5msDkIGA
 PPEYCypa6FGQ+pEIJgWEQ0PCfqIqfj6COBwYFVgumbTf2gQnYoJ8W+fE7Eakr9mSQpptu57JRYD
 L/R78jp/3XuOQln+Hx3Aq+y/9ykMB7tjQ4LoOSVG1picJNxaKslm+g/xDvWKZg7mbS+nUEQh1er
 7/ySwJrzi5Mkkam+2aGfSw1z17w==
X-Received: by 2002:a05:690e:428d:20b0:679:9394:88fc with SMTP id
 956f58d0204a3-67ba5017f4amr7225537d50.83.1793800860580; 
 Wed, 04 Nov 2026 06:01:00 -0800 (PST)
Received: from localhost.localdomain ([2606:6d00:159:2900:6d2d:2c92:88b1:11b7])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91e896f09e3sm9369666d6.25.2026.11.04.06.00.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Nov 2026 06:00:59 -0800 (PST)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Marcelo Manzo <marcelomanzo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org (open list:Raspberry Pi)
Subject: [PATCH] hw/net/bcm2838_genet: fit the RX frame within the guest's
 buffer
Date: Wed,  4 Nov 2026 09:00:58 -0500
Message-ID: <20261104140058.24068-1-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=marcelomanzo@gmail.com; helo=mail-yx1-xb135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The RX path clamped the payload copied into each descriptor only
against the whole RING_BUF_SIZE register (whose upper half is the ring
size, not a buffer length) and against the size of the rx_packet
staging buffer. It did not account for the status block and 2 byte pad
that precede the payload, nor for the 4 byte CRC that is added to the
reported BUFLENGTH when CRC forwarding is enabled. The BUFLENGTH
written to the descriptor could therefore exceed the buffer the guest
supplied.

Clamp the payload to the guest's buffer size minus the status block,
pad and CRC. BUFLENGTH is then at most the buffer size, which is at
most MAX_FRAME_SIZE, so it fits its 12 bit field by construction.
(It cannot overflow today, because receive() drops frames larger than
MAX_PACKET_SIZE, but nothing in the descriptor code made that obvious.)

This also fixes a hang: with a buffer size of 0 the old code copied
zero bytes per iteration and never made progress through the frame.
Treat a buffer too small to hold any payload as a guest error and drop
the frame.

Resolves: Coverity CID 1690161
Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 hw/net/bcm2838_genet.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index 53bba99b38..ce55dc27ac 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -870,15 +870,24 @@ static ssize_t bcm2838_genet_rdma(BCM2838GenetState *s, uint32_t ring_idx,
         uint8_t *frame_buf = dma_buf + frame_off;
 
         bool crc_fwd = FIELD_EX32(s->regs.umac.cmd, GENET_UMAC_CMD, CRC_FWD);
+        const size_t crc_len = crc_fwd ? 4 : 0;
         size_t buflength;
         uint32_t prod_index;
 
-        if (l > ring->ring_buf_size) {
-            l = ring->ring_buf_size;
+        /*
+         * The buffer holds the status block, the 2 byte pad, the payload
+         * and (with CRC forwarding) the CRC. buf_size is at most
+         * MAX_FRAME_SIZE, so the BUFLENGTH computed below always fits
+         * its 12 bit field.
+         */
+        if (buf_size <= frame_off + crc_len) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: RX buffer size %zu too small\n",
+                          __func__, buf_size);
+            return -1;
         }
-        /* Never copy more than fits in rx_packet after the status block */
-        if (l > sizeof(s->rx_packet) - frame_off) {
-            l = sizeof(s->rx_packet) - frame_off;
+        if (l > buf_size - frame_off - crc_len) {
+            l = buf_size - frame_off - crc_len;
         }
 
         memcpy(frame_buf, buf + len, l);
@@ -889,10 +898,7 @@ static ssize_t bcm2838_genet_rdma(BCM2838GenetState *s, uint32_t ring_idx,
                                          GENET_RDMA_LENGTH_STATUS,
                                          EOP, !!(len >= size));
 
-        buflength = l + sizeof(BCM2838GenetXmitStatus) + 2;
-        if (crc_fwd) {
-            buflength += 4;
-        }
+        buflength = frame_off + l + crc_len;
 
         desc->length_status = FIELD_DP32(desc->length_status,
                                          GENET_RDMA_LENGTH_STATUS,
-- 
2.55.0


