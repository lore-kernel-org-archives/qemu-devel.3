Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1444D606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 21:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fmWeLYCb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLSG6-0001NU-HF; Mon, 26 Oct 2026 17:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gessingate@gmail.com>)
 id 1xLSG0-0001LZ-22
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 17:29:28 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gessingate@gmail.com>)
 id 1xLSFy-00077u-GT
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 17:29:27 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-5366ae57896so37993551cf.3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 14:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793050165; x=1793654965; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WITGkaW89txTAqQAj33cp2FLdFP7Bbf+xfqIESob79A=;
 b=fmWeLYCbe/Hj5PpXO9U1IFfEmVWTaJE6OE1oEeVk92IRATEVI2uFVUah6RKSvFriv7
 BpP47MpObsZEMyM5AKiOR4duOsNJ6C2X1x1FnJbibHTJOu1jjvmWFJidUwYZ/1XjONZ5
 dL/9bFs/bP/+15hvUYVH5frK6vwjYJwkztwBZtB/9BJVBY3QLVsZvCkpTY3cyDWNKbpE
 etha+SB2N2CDI/pHPG2sTP4+Dk68t0A1ECdNK8aFG+CyUL0iTd8FzneQzhAJF45FGV0r
 eNXNx2WkKayKb4/VkEXxdzFYfi5gH/rOBhKo5LFNpRcyvMB/r8c3WCqSrU8qXW7kzEBh
 4ing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793050165; x=1793654965;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WITGkaW89txTAqQAj33cp2FLdFP7Bbf+xfqIESob79A=;
 b=fRzN1qyvE5FAxrz/Hs3QQx4H9nqg2bmeMKvuHKVDCvnzRzP1vdsYSmw3JqLGIuq3Ot
 f7vO0c8GLeCBCOQ975mJCOcQlgKejU1tNAt+oBnEYRoiire0KnlU/3Gk6qnblnu33jjS
 Q+9Cv+dJr5i6Qe6UeccPQao8neYiJnq2RAuXmGl26oR0MT8yRlSZlDb9uDiRgoodKYNn
 PESWpWC1Bt4W88uac/iZMI1wdBcuuJx+++4nPxXfERQ//rmIGi4AocgAlUcAi1W+UKwC
 CzLN2sOzTmpXOsaOupSMySM72LL5bHBjJfCISbzJ5McjztvnFP9qcXLqdHPrmG7oPegB
 S+QA==
X-Gm-Message-State: AFq9FYJ4xT2AkkHpoHZmmqO9e7h+DKS2vtYCjIVIM17C1liwwVFBsLII
 TT9fjyWb6AiQbYQ+4vxhsKNKNPbedvTP7bSu86IoE3FCwxjZeABCSfau
X-Gm-Gg: AYBFou3j6k5DxaPDE3MD5Dvtwivp1DhsRvhmO8gbIcbU0AYR8n60f7mnUHEXHhLAs85
 wP5+4b7T+bsmu279dObfmCuf6ehiVmfDk7TmEX7yEvNlRUu7fZIBtnt0OnWnuMp6T59BU5dLTnX
 XV2/gmMRA34SnlEM29QW7bOj/qfo6sCzydJy0zE1TBLdy8K4CV9zK/hPZKMDgzFqekb7+VsYmkp
 G2UNiaoWeXzKavedOz9JxjX4ZZmpxaUyz5zwTklQCTUTUhPz49363GQps1cZKf3ymKTQAg+Nh22
 ycNiFlcaAPk8K8Doxovyd6oelbjToxEjya9Yu/BRZacOeAlemytnXP+Eys6QOGiYIejpRV6GhdL
 6FHmcU+fjLWXCaA0M1YJXtIEYhNY5I3kfI39R/TP6Zi8walT4wtes7FSUSl2ZlA078b/OMe9iUC
 md8gX0ySr8n1CaxdFWeDRKfkOxGn+RMUWJ64ksJC60NY0xQ0/vVIAynT0TDT+5gtErMc//qoiNG
 01wkjXCM8rJ6K/jObK8Zrc9WYzcGEluFL2qFeMNRqcpYur0lZf45pR1N0dWuPUfHUd1eRBAJ4Zh
 VqKu1IhV3qAZWeg=
X-Received: by 2002:a05:622a:1f15:b0:535:92a6:22e7 with SMTP id
 d75a77b69052e-5383b6a942bmr123758041cf.42.1793050165298; 
 Mon, 26 Oct 2026 14:29:25 -0700 (PDT)
Received: from [127.0.1.1] (95-24-99-141.broadband.corbina.ru. [95.24.99.141])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c47c6f3bcsm85206376d6.29.2026.10.26.14.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 14:29:25 -0700 (PDT)
From: Timur Maksimov <gessingate@gmail.com>
Date: Tue, 27 Oct 2026 00:28:40 +0300
Subject: [PATCH 4/6] hw/i2c/aspeed: fix DMA transfer in non-packet mode
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-aspeed-i2c-nonpkt-fix-v1-4-076cdde514f8@gmail.com>
References: <20261027-aspeed-i2c-nonpkt-fix-v1-0-076cdde514f8@gmail.com>
In-Reply-To: <20261027-aspeed-i2c-nonpkt-fix-v1-0-076cdde514f8@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Timur Maksimov <gessingate@gmail.com>, 
 "Timur Maksimov gessingate"@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793050151; l=1478;
 i=gessingate@gmail.com; s=20261022; h=from:subject:message-id;
 bh=3g9wcVyGDZUOSH45Un3b+SSii/t58p5DosQTf5nBaHk=;
 b=GCTl2NEvEbdT7mdp6UIcHad1zJFDnsUOxzdtq0vszYjyDqM2mYZjyVl1p+Ep97CskM1mS0uBM
 8mEVAjUdzXnArJilwr3wGZndRYqsINfGvnrWGiOu3j4p1YrTs+9dyJQ
X-Developer-Key: i=gessingate@gmail.com; a=ed25519;
 pk=xF4NKIzSbKMdte17nQ66S/q9m/A2gu6GiEWc8ZnyJmo=
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=gessingate@gmail.com; helo=mail-qt1-x832.google.com
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Avoid calling aspeed_i2c_set_tx_dma_dram_offset twice in non-packet mode
where this function is called first in aspeed_i2c_get_addr.
Also fix writing to I2CD_DMA_ADDR in old register mode.

Signed-off-by: Timur Maksimov gessingate@gmail.com
---
 hw/i2c/aspeed_i2c.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index ec46f6c94c..376e113e58 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -416,7 +416,9 @@ static int aspeed_i2c_bus_send(AspeedI2CBus *bus, bool send_addr)
         if (aspeed_i2c_is_new_mode(bus->controller)) {
             ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN_STS, TX_LEN, 0);
         }
-        aspeed_i2c_set_tx_dma_dram_offset(bus);
+        if (!send_addr) {
+            aspeed_i2c_set_tx_dma_dram_offset(bus);
+        }
         while (bus->regs[reg_dma_len]) {
             uint8_t data;
             ret = aspeed_i2c_dma_read(bus, &data);
@@ -1070,11 +1072,13 @@ static void aspeed_i2c_bus_old_write(AspeedI2CBus *bus, hwaddr offset,
         bus->pending_intr_sts |= old_intr & cmd_intr;
         aspeed_i2c_bus_raise_interrupt(bus);
         break;
+
     case A_I2CD_DMA_ADDR:
         if (!aic->has_dma) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA support\n",  __func__);
             break;
         }
+        bus->regs[R_I2CD_DMA_ADDR] = value;
         break;
 
     case A_I2CD_DMA_LEN:

-- 
2.53.0


