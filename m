Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4737EC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 18:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubNYf-0007pD-DH; Mon, 14 Jul 2025 14:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ubMSi-0004YK-K5
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 12:55:33 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ubMSg-0001In-1D
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 12:55:32 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45526dec171so32955295e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 09:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752512128; x=1753116928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3cGXdCXCfPmsA5Ze9Qy3GSzkEFT+6aOU7O/5fB9CynM=;
 b=R9Jf0t7KZ3/UGK6NfDodcWaLoMtRvR8rvd3m5FGbyM7m9x0V9LufVAjW8/rBCQzzdi
 6FwPWNSYqTZVM3K/WXQFKALWkmzZqj3XOBde14eDd7CeEtMhNboHGhBfsuQXMuz3jjjh
 NdJV/CaG+yCJqO8rZ2XaM35wLz2JyuIP/Dpcp+8s16f2b+ka+Q+ouAGZGruFSehuPFSF
 ihwDcvuLkF6dbMdtuSmtApfbuklhorzAKzGHlRvBgoH0+XRtw4B0fhfsln0C5MJrs/pL
 80ySfwi+2FoU5a68yhsF/hoDH7TrA9JM11VoFH1hJN1pkfjkL0fuVquTCmox1xkkIOR4
 cAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752512128; x=1753116928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3cGXdCXCfPmsA5Ze9Qy3GSzkEFT+6aOU7O/5fB9CynM=;
 b=Ka65t0Dr5v2snpj8BUymDoT92g1tIlD8lG1RLfhdo56y6K9uyhGJmMCinr2Tm9LaGx
 iIV8YL4ZzZA+rvPL/QrCJs69gTBCnY9+Yo8btHdzlrdFSvnIcM2lts0VLD070OzAiMoM
 4lQWilzbvYjmiKn0YUk8PZWA1TVp9dm2zJiBodA1skMQ/oM6ig419nouFPCCUUQArM40
 orjO740oW/OVDSYtrPi70/KDCF8BA7I2XQzpKIyRBhNp0jYYkSDB8JJRZ/oVNAAPtoqp
 HHe8Kj7VOT43AzZkaPi22tMMlVE2YgzHNGN4Ri7u+/qm/Lf++xegfDUo0eQ5N5yhOdvf
 3x8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3zjiM9vs7iG+zna7O1cobV/EOb0kNsKWNNneUllAKV4DI8wvgKL/UVI5q7gJesRxPqQnXon0dwKTB@nongnu.org
X-Gm-Message-State: AOJu0YygJI4A40WVPo0kl3W9y+tm9LlVv+wZXdZarpNIsRYh05oZZYLC
 4OcSu6kbDgU7A+2NpkouZO5fVBUarj4mRhkdViMuqsM5Ujxcm5U08gisD/ODyLd5HuA=
X-Gm-Gg: ASbGncvnnz5vU5Tv1wLK5efdWuSP9wMxDbc+hBq7Mg+cJAFzGJBAAsSSTTYTbwHFrEd
 1zFh1/aabGV+s8KqEn6Fmdjl1osW3w/ZZe09TXeRPr7Ifeko2lyV2Ze+NjEXuevRU5sc5P7mGZK
 v1A5yP4TOmI59jGS4iulxAmSbkK+Ah+3E0hnARNgHhqFWQWwv60h3UGZTbGiIVFGqItiz/wz2jg
 ULF39oUezKPA/okgJ7ZQaUoUG8lYQflVWjOhJWhepFc9wnE0zQWcPYCgCa3ZSero16M1cKk8NYn
 UCJtKhPLwyYlS10EMSfTmN/ZtRkWE7YJvL83G1rn+f14MTb7wTCnLHbf8eqI9AfXgujmBnxuVa2
 bpmqHhRep8MKCjA946ndxYA3oNyCP
X-Google-Smtp-Source: AGHT+IF45BDZTCY6TXI/tXzTPRatDV+7gekhtrlLBFWCpQeaAgFgTrleOn0L6ZttQqlknoYQixgCSw==
X-Received: by 2002:a05:600c:8b2a:b0:453:7b2b:ed2e with SMTP id
 5b1f17b1804b1-454ec2727dcmr118670355e9.24.1752512128390; 
 Mon, 14 Jul 2025 09:55:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd15bfsm13164665f8f.19.2025.07.14.09.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 09:55:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH 2/4] hw/net/npcm_gmac.c: Unify length and prev_buf_size
 variables
Date: Mon, 14 Jul 2025 17:55:21 +0100
Message-ID: <20250714165523.1956235-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714165523.1956235-1-peter.maydell@linaro.org>
References: <20250714165523.1956235-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

After the bug fix in the previous commit, the length and prev_buf_size
variables are identical, except that prev_buf_size is uint32_t and
length is uint16_t. We can therefore unify them. The only place where
the type makes a difference is that we will truncate the packet
at 64K when sending it; this commit preserves that behaviour
by using a local variable when doing the packet send.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Should the behaviour really be to truncate the packet at 64K
rather than flagging an error if the guest assembles descriptors
that combine to give a too-large packet?
---
 hw/net/npcm_gmac.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
index 921327dd8ca..a0050a7725f 100644
--- a/hw/net/npcm_gmac.c
+++ b/hw/net/npcm_gmac.c
@@ -516,7 +516,6 @@ static void gmac_try_send_next_packet(NPCMGMACState *gmac)
     uint32_t desc_addr;
     struct NPCMGMACTxDesc tx_desc;
     uint32_t tx_buf_addr, tx_buf_len;
-    uint16_t length = 0;
     uint8_t *buf = tx_send_buffer;
     uint32_t prev_buf_size = 0;
     int csum = 0;
@@ -583,7 +582,6 @@ static void gmac_try_send_next_packet(NPCMGMACState *gmac)
                         __func__, tx_buf_addr);
             return;
         }
-        length += tx_buf_len;
         prev_buf_size += tx_buf_len;
 
         /* If not chained we'll have a second buffer. */
@@ -606,15 +604,18 @@ static void gmac_try_send_next_packet(NPCMGMACState *gmac)
                               __func__, tx_buf_addr);
                 return;
             }
-            length += tx_buf_len;
             prev_buf_size += tx_buf_len;
         }
         if (tx_desc.tdes1 & TX_DESC_TDES1_LAST_SEG_MASK) {
+            /*
+             * This will truncate the packet at 64K.
+             * TODO: find out if this is the correct behaviour.
+             */
+            uint16_t length = prev_buf_size;
             net_checksum_calculate(tx_send_buffer, length, csum);
             qemu_send_packet(qemu_get_queue(gmac->nic), tx_send_buffer, length);
             trace_npcm_gmac_packet_sent(DEVICE(gmac)->canonical_path, length);
             buf = tx_send_buffer;
-            length = 0;
             prev_buf_size = 0;
         }
 
-- 
2.43.0


