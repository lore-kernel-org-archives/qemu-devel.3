Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12170CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 09:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruU35-00071t-OD; Wed, 10 Apr 2024 05:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruU2m-0006nz-Fn
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 05:15:03 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruU2k-0005gQ-Mn
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 05:15:00 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56e69888a36so3779876a12.3
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 02:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712740497; x=1713345297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6sqSTbvcHE/PEJ061E2tWbqv/m5mGCSbZ1MuwfTm1R8=;
 b=h9vNpKww2lzMJFmL4wtY4SDU/v6Df/hCYO/19EZM+fEyWowS3J0YoRauBJDa67a2RZ
 3SQk4q0Tt9ADDlivwHx2oXwAHi16me6oP1xqn1IKr/dwS0clpIWQmg1GlR3kh8HYyCKx
 WpLwSLc916mdbI2Xa/NqZ9IYVB4mFHHPiA1ma43FBd73xzGKXyeVJgiD8WNRhVEc6wg1
 OfUzdDS6jMDcoUebYtrm2h/PgnEEFptmy/jUCOqwSWHt2YnjEaCZZoOWOhYYliUuRFXz
 AA9xTMQU+853P+0WBNwB19GxAp4qW4g5TixFcF9uxGD1iYq/qiVP5BhtO7PLzCbaQstm
 GgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712740497; x=1713345297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6sqSTbvcHE/PEJ061E2tWbqv/m5mGCSbZ1MuwfTm1R8=;
 b=MEf93GFOwsgw+7ukGGSG8CseHjFODSCfEo6wNBFRNZojQfpayjezKFXKijNMsG9z6/
 i4uEXo3BVraJmg7Glwr5WMrH58m4wjzvEqhVNZkEb9Ap+IwCAkZzmlsJSLENZcd0mLNK
 6abq7N/bogpKTISRmTor/8/ViPjhPVwl3GDjm4/8UDPwVKJQvcR9NA4mxjiMtyrsm+T1
 XBOKGzRwrC4QR8Ji6TJJwZlkgbNcyttJk/oWmyWq07HBKSRkdB8zCd3Af9JWhY8HogU/
 mcu686H2Fhfbk3c0xgk2ll0+67AkelI/fGzVsTu3ZLnlMKUAEySRYUuGOvbp0byl4sh0
 xU+g==
X-Gm-Message-State: AOJu0Yw4CPJwkPe2u6glwfzgojTPlsCKb/HRbDTUCMXxX+j6/QJ2O8/s
 3JGaom2AYtQs7MIBEGfnb+wyT2RImObollacvW+I9lrkxhbtoWpqZndFW4EY7agv3/HuH4ySFZX
 p
X-Google-Smtp-Source: AGHT+IF2Pi0nXPUSbCoq2qDvc7kQRo+1W6T5bDSunDJ8zbGsSKOO3MNQ9GqSE1iVEQmn8sndcJtMXA==
X-Received: by 2002:a17:906:ae94:b0:a4e:3777:db0 with SMTP id
 md20-20020a170906ae9400b00a4e37770db0mr1123626ejb.57.1712740496785; 
 Wed, 10 Apr 2024 02:14:56 -0700 (PDT)
Received: from m1x-phil.lan (arl95-h02-176-184-34-173.dsl.sta.abo.bbox.fr.
 [176.184.34.173]) by smtp.gmail.com with ESMTPSA id
 k14-20020a1709063fce00b00a4e8a47107asm6654677ejj.200.2024.04.10.02.14.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Apr 2024 02:14:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Chuhong Yuan <hslester96@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 13/16] hw/net/lan9118: Fix overflow in MIL TX FIFO
Date: Wed, 10 Apr 2024 11:13:12 +0200
Message-ID: <20240410091315.57241-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240410091315.57241-1-philmd@linaro.org>
References: <20240410091315.57241-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When the MAC Interface Layer (MIL) transmit FIFO is full,
truncate the packet, and raise the Transmitter Error (TXE)
flag.

Broken since model introduction in commit 2a42499017
("LAN9118 emulation").

When using the reproducer from
https://gitlab.com/qemu-project/qemu/-/issues/2267 we get:

  hw/net/lan9118.c:798:17: runtime error:
  index 2048 out of bounds for type 'uint8_t[2048]' (aka 'unsigned char[2048]')
    #0 0x563ec9a057b1 in tx_fifo_push hw/net/lan9118.c:798:43
    #1 0x563ec99fbb28 in lan9118_writel hw/net/lan9118.c:1042:9
    #2 0x563ec99f2de2 in lan9118_16bit_mode_write hw/net/lan9118.c:1205:9
    #3 0x563ecbf78013 in memory_region_write_accessor system/memory.c:497:5
    #4 0x563ecbf776f5 in access_with_adjusted_size system/memory.c:573:18
    #5 0x563ecbf75643 in memory_region_dispatch_write system/memory.c:1521:16
    #6 0x563ecc01bade in flatview_write_continue_step system/physmem.c:2713:18
    #7 0x563ecc01b374 in flatview_write_continue system/physmem.c:2743:19
    #8 0x563ecbff1c9b in flatview_write system/physmem.c:2774:12
    #9 0x563ecbff1768 in address_space_write system/physmem.c:2894:18
    ...

[*] LAN9118 DS00002266B.pdf, Table 5.3.3 "INTERRUPT STATUS REGISTER"

Cc: qemu-stable@nongnu.org
Reported-by: Will Lester
Reported-by: Chuhong Yuan <hslester96@gmail.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2267
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20240409133801.23503-3-philmd@linaro.org>
---
 hw/net/lan9118.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 8214569a2c..91d81b410b 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -799,8 +799,22 @@ static void tx_fifo_push(lan9118_state *s, uint32_t val)
             /* Documentation is somewhat unclear on the ordering of bytes
                in FIFO words.  Empirical results show it to be little-endian.
                */
-            /* TODO: FIFO overflow checking.  */
             while (n--) {
+                if (s->txp->len == MIL_TXFIFO_SIZE) {
+                    /*
+                     * No more space in the FIFO. The datasheet is not
+                     * precise about this case. We choose what is easiest
+                     * to model: the packet is truncated, and TXE is raised.
+                     *
+                     * Note, it could be a fragmented packet, but we currently
+                     * do not handle that (see earlier TX_B case).
+                     */
+                    qemu_log_mask(LOG_GUEST_ERROR,
+                                  "MIL TX FIFO overrun, discarding %u byte%s\n",
+                                  n, n > 1 ? "s" : "");
+                    s->int_sts |= TXE_INT;
+                    break;
+                }
                 s->txp->data[s->txp->len] = val & 0xff;
                 s->txp->len++;
                 val >>= 8;
-- 
2.41.0


