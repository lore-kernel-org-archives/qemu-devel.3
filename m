Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69157606A32D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=er4pEXWJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWAlV-00035l-Hm; Wed, 25 Nov 2026 06:02:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xWAlT-00034j-Nv
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:02:15 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xWAlR-00050N-T8
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:02:15 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6b8a2518f7cso6576510a12.2
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 03:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795604532; x=1796209332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2+TYvrPEdLnS9zjKGn3AfElY4o2hXNUYsYu4n+AaoC0=;
 b=er4pEXWJ3HaiCK+hpTgNSfmkKYwJQpjqPBdi+48hStqZkBAbNjLZV31jmargkLA+vB
 r5PNYONOhyCZw7wKBPJvLT7VixHk6t4tUnqF1Wn+LOa/oVKY51JSMvs0mDDKxOpPH42w
 wm4tCLDXD8iq+9FHsRjnqyWb5cJD3Eu/f5L/kUJ9Lw2LphVdNX75+8mVPI2T+h5VPTmN
 BnZ9/chEbGW371LsxVG4I0dfnH0q2W5dDIDVJZWH0373F1A1Jb5sHo/8b8m2K1N6RP79
 p607TaenvUMSCuaa0HYG2RTrUAqxxTeththClRy6u5+5vGPsnenzyl9ahKhCef+nWoV2
 3SUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795604532; x=1796209332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2+TYvrPEdLnS9zjKGn3AfElY4o2hXNUYsYu4n+AaoC0=;
 b=osh0TbKc9TmGtoM8Agj6w2Jb3nJ9dODXApzMQ1b6wbdhjw5dFDLjV/JkhQfeArQCqO
 xC7HloBXLSkAmH3SEHgiiAtWM+PmIHqA7cNk0oC3sxV5KQyJr6Yz3lRO3ELGKV6O1e2k
 YGJK+zlPAEl1/wAXxAgIuTq9KLTmxRaEgR689MNFOhqMRw/ZoCcOvcPgTBNjcQVBLkS3
 AkBYOdRDybB98PYDsjoIDlLSfRW/zjUT3kKgWxcXAR8dZtWzwhYNdD7OgcUmIyUXIGwj
 b7Oa2WAIFGhNrbsY9y3eViP89A8nhsZOqS14ACyif9fsCa361NDrMNMA6pzvd+IOKvYr
 UlFw==
X-Forwarded-Encrypted: i=1;
 AL+hErGkzLiV896kK//5fTBih1nt8cypg0SFQE4gBUEUWV8WYiqgQA/Awoy6E8nQtWb1dMFlXq9LEAZ9wdgR@nongnu.org
X-Gm-Message-State: APuU4Z/ONvgkj5RoqseBhsd6SAbqiZ9OivzEvFCzJLsunuNyYv4S3tiT
 LiOvBKaY/QQIeFSG8H8Hj+FLyPaMlTrM4jnoUX5VJ8XnJziPwccAsYra
X-Gm-Gg: AZFdTZcwOb6jC42C4dXzAb5Pk4UDwpQ0u+RZbnf5I8I11rn5ROTJFkv5uIzzIeJclgc
 OUwGLdQmBe8fVtWskhL4LiHV4arPQ1x4Q5Lyb8MnSUWf6g0S1ixKRNHLaWWR7wG9qYUBTo+u2J/
 BW1d+MuI/8Cljqxf/lshCtvwQg4lTv90HhqjWYuPgjVFXrxybjqnkcH6IBURzk6wQ/Sm/2Fs70y
 UJ95+6WFZsomaqaXZQz9jLtbbnNStDCBs9v6LIUHQZLP+r6seqLSHjppXkWMl8HYBTX4gjfowMg
 0aDad1wa8FqpfJX+ks6uM3rHpA30k+6CRU/ar2+KxMtpNyQvqVLqw9J7Qyk6I8Vj/JCYN/FY+LP
 abgeJQ0maD530oa0CQoC2x+skhdAX8E+1mqlbiQoYBc80NmV8ziSwDiiqbgXw+va+p726/R7iYF
 dT7ATZKNbnX+5evjhScU+QGDO5Edi1tgn8t0pO4Po9N9jzTJF3G78BBd+dUWhkoNrh/pbiEPhoT
 Rn6mg/IvaPuvAttHk1MLWx3z96rYhmMqta6PMm0POH1W2ElFe9I+2Hikoyuo7M4oGM9aPhLHaKo
 xAHkEYDgVtewYYWakhRwIUw/c1SJZEVJq3AUnEwpFdY5FN73cOPJh82V19gkwzrWbVzUNdzEJhP
 M9iSumimG+cDiq8nZ7lg7jI2c
X-Received: by 2002:a05:6402:5005:b0:6b8:791e:5d4d with SMTP id
 4fb4d7f45d1cf-6ba638a6273mr10892504a12.27.1795604531552; 
 Wed, 25 Nov 2026 03:02:11 -0800 (PST)
Received: from PKL-HASEEBA-LT.. ([39.36.25.192])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6c340df4sm38665459f8f.55.2026.11.25.03.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 03:02:11 -0800 (PST)
From: Haseeb Ashraf <haseebashraf091@gmail.com>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vgarhw@gmail.com>, qemu-devel@nongnu.org
Cc: Haseeb Ashraf <haseeb.ashraf@siemens.com>,
 Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 1/2] hw/net/can/sja1000: fix receive FIFO corruption
Date: Wed, 25 Nov 2026 16:02:01 +0500
Message-ID: <20261125110202.471181-2-haseebashraf091@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125110202.471181-1-haseebashraf091@gmail.com>
References: <20261125083350.331457-1-haseebashraf091@gmail.com>
 <20261125110202.471181-1-haseebashraf091@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=haseebashraf091@gmail.com; helo=mail-ed1-x532.google.com
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Haseeb Ashraf <haseeb.ashraf@siemens.com>

Remote frames carry a DLC but no payload.  Do not enqueue payload bytes
for RTR frames in PeliCAN or BasicCAN mode, since the release operation
otherwise consumes bytes which were never stored and leaves the FIFO
misaligned.  Preserve the CAN identifier when decoding a BasicCAN RTR
frame.

Reset the receive write pointer on both hardware and software reset so
the byte and frame counts remain consistent.

Fixes: 733210e75465 ("hw/net/can: SJA1000 chip register level emulation for QEMU")
Signed-off-by: Haseeb Ashraf <haseeb.ashraf@siemens.com>
---
 hw/net/can/can_sja1000.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
index 922431effb..23bec3b210 100644
--- a/hw/net/can/can_sja1000.c
+++ b/hw/net/can/can_sja1000.c
@@ -57,6 +57,7 @@ static void can_sja_software_reset(CanSJA1000State *s)
     s->status_pel  |= 0x34;
 
     s->rxbuf_start = 0x00;
+    s->rx_ptr      = 0x00;
     s->rxmsg_cnt   = 0x00;
     s->rx_cnt      = 0x00;
 }
@@ -69,6 +70,7 @@ void can_sja_hardware_reset(CanSJA1000State *s)
     s->interrupt_pel = 0x00;
     s->clock       = 0x00;
     s->rxbuf_start = 0x00;
+    s->rx_ptr      = 0x00;
     s->rxmsg_cnt   = 0x00;
     s->rx_cnt      = 0x00;
 
@@ -312,7 +314,7 @@ static void buff2frame_bas(const uint8_t *buff, qemu_can_frame *frame)
     frame->flags = 0;
     frame->can_id = ((buff[0] << 3) & (0xff << 3)) + ((buff[1] >> 5) & 0x07);
     if (buff[1] & 0x10) { /* RTR */
-        frame->can_id = QEMU_CAN_RTR_FLAG;
+        frame->can_id |= QEMU_CAN_RTR_FLAG;
     }
     frame->can_dlc = buff[1] & 0x0f;
 
@@ -345,6 +347,8 @@ static int frame2buff_pel(const qemu_can_frame *frame, uint8_t *buff)
     buff[0] = 0x0f & frame->can_dlc; /* DLC */
     if (frame->can_id & QEMU_CAN_RTR_FLAG) { /* RTR */
         buff[0] |= (1 << 6);
+        /* RTR DLC is the requested length, not payload stored in the FIFO. */
+        dlen = 0;
     }
     if (frame->can_id & QEMU_CAN_EFF_FLAG) { /* EFF */
         buff[0] |= (1 << 7);
@@ -392,6 +396,7 @@ static int frame2buff_bas(const qemu_can_frame *frame, uint8_t *buff)
     buff[1] = extract32(frame->can_id, 0, 3) << 5; /* ID.02~ID.00,xxxxx */
     if (frame->can_id & QEMU_CAN_RTR_FLAG) { /* RTR */
         buff[1] |= (1 << 4);
+        dlen = 0;
     }
     buff[1] |= frame->can_dlc & 0x0f;
     for (i = 0; i < dlen; i++) {
@@ -610,7 +615,10 @@ void can_sja_mem_write(CanSJA1000State *s, hwaddr addr, uint64_t val,
                 }
 
                 tmp8 = s->rx_buff[(s->rxbuf_start + 1) % SJA_RCV_BUF_LEN];
-                count = 2 + (tmp8 & 0x0f);
+                count = 2;
+                if (!(tmp8 & (1 << 4))) { /* DATA */
+                    count += tmp8 & 0x0f;
+                }
 
                 if (DEBUG_FILTER) {
                     qemu_log("[cansja]: message released from "
-- 
2.34.1


