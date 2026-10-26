Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36638606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 21:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NN1Re/nP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLSG5-0001MZ-BD; Mon, 26 Oct 2026 17:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gessingate@gmail.com>)
 id 1xLSFu-0001KT-M5
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 17:29:25 -0400
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gessingate@gmail.com>)
 id 1xLSFt-00077D-9g
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 17:29:22 -0400
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-91b834592afso44553896d6.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 14:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793050160; x=1793654960; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I1OobZ+xS7ALgcpE3A652Wgd0tsqJvBFRpt8TtqypKE=;
 b=NN1Re/nP7VQSlJ42fpR/w2xTl21ygX3DhVj2UdFR+kUfYGdCYEP3n1TlfkBfpBkbsV
 UvA3CjW6nNPvd8vZRpAMiyJEZo919rhjtNf857mSZWvWM/ZG+L0Srh0ML88IserdtCNg
 DWSolBxuLkJFx7f+vYjkYZMGeAw4ye5QMUO2VQ6ll702/WmR9gtoQjQ8Eq8jI4snusq3
 GYYSfCRWCo3hWc8+g/llUgzPzTplVBb9sRCDtViSAP+oy/JOOdMjWSzo5ls5wTaa4eLE
 k5mHDByZbGmKMawebaBhX81Hc36oRF/aM3KiZ+l8ihqyS7iONM1xyRNGYH7xM6c3YN0g
 Q7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793050160; x=1793654960;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I1OobZ+xS7ALgcpE3A652Wgd0tsqJvBFRpt8TtqypKE=;
 b=pXyEHJSdd36DF76IUcr5SQnjfo00k9dx7hyirtOsAWQ2KEs7MqFQLtS5EGAR/hq/W0
 uYtQrbCW00kgVnTkGz7K+UQke51Uh2FirhjWCukKZeQQb7yRcPdh1HjGtdq/G5csdDNS
 MDvhiBlOx+Yi0XXg2tFlUtgweJci4JW43b/OM8/md4cL1hzzLV16hjCXcZxuQK8gleJb
 2CwV7EQ7jIA1apsSCyBqIUsyX4Wn9sC/tLQ2Jx4ibraVVciZ6TeqlJj0UXJKESfo9XWK
 T9skZjVhpU5hn6Cd9K75Ok+yvw519TEXMgzPfzgR1JPFML8TZs7B/HKFOoxDa3x6tBPO
 saxA==
X-Gm-Message-State: AFq9FYKs8M12ZByybvwicF3l4LrtfOOpPjRCwCbF2xSyC+ElUkfyALQS
 dptUmbU8zb1ymFwlbd5fLkxtdMnVw/8ctFKPAdeJPJdGRSMmGGWQJvN/
X-Gm-Gg: AYBFou1t9xP114CMifwGNaIa5QfHbCY0v4mKo5rh95lbG11TQYXMYDGvfJeWVzbW61g
 Yam5PVMsJJcFxBrBD0oKAG9qct+KWyxafzanV88/ENLHPbkDb2hDpty+0gMVaTjWXlUbw9j4QZS
 ZvIg+euMkfyaQpangfa4ztMzx1t8mc1MCZZ0omMxjJyik4TNGBf7QbQud7L/QFukX3rDS64Raev
 TmedsC2PfuZXP08yFVPh3j+W4WDp1tjxYklAgAV0L63qaL4IV8w1Hly0kdpItmKsVc8T56AepM7
 vTHQBX31l1EXD8Zq7tyfIm+ymFpFwBaM+vbrTtKfABh4ifE9dSKyb2qb6Uh8WhpYBmCSwU1bKRi
 OGC1TOdMJpsnb0Q7Al8I+6/8KyVivSTAYPS95lSjB71jc0pNm9++OJudRf/dTXNilKhk/iKlQTt
 mxbzjPBSG5QwfFRpfEjIrGFdxXjP1soitO16J/Ntx+o84+GIuL2j5SA2+2cocm00bJG3nJ8Rgfh
 AiwyDkNzzwpFSNCzPNPt41kAr0Q/FEj/uS41ERI33jPKXTmHFzBn1+cKeOjEoWSOwHS9HHWCpoF
 sMZcI0qC4/t3LG8=
X-Received: by 2002:a05:6214:2627:b0:91b:5d3a:4fcc with SMTP id
 6a1803df08f44-91c48ee12f0mr141160706d6.57.1793050159914; 
 Mon, 26 Oct 2026 14:29:19 -0700 (PDT)
Received: from [127.0.1.1] (95-24-99-141.broadband.corbina.ru. [95.24.99.141])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c47c6f3bcsm85206376d6.29.2026.10.26.14.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 14:29:19 -0700 (PDT)
From: Timur Maksimov <gessingate@gmail.com>
Date: Tue, 27 Oct 2026 00:28:38 +0300
Subject: [PATCH 2/6] hw/i2c/aspeed: fix CMD register reading
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-aspeed-i2c-nonpkt-fix-v1-2-076cdde514f8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793050151; l=1201;
 i=gessingate@gmail.com; s=20261022; h=from:subject:message-id;
 bh=YQ3mnGzbacwGUPWollDDyPAx9v91x21KBbyZP9a/PrU=;
 b=ygmd8aljktQA6aZj5PWMsAJpdGd4oDvrYLEt1YnxzAzabQHlbhCtimFJejKlNamdPocQUa+B+
 /3bLRYCTHS0CyONMlWLbo9nc27MuBHIRO3fENeYbq4yFhmgvEVAJD5k
X-Developer-Key: i=gessingate@gmail.com; a=ed25519;
 pk=xF4NKIzSbKMdte17nQ66S/q9m/A2gu6GiEWc8ZnyJmo=
Received-SPF: pass client-ip=2607:f8b0:4864:20::f36;
 envelope-from=gessingate@gmail.com; helo=mail-qv1-xf36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The I2CD_CMD and I2CM_CMD registers now return a valid value.

Fixes: c2c5beec42bf ("hw/i2c/aspeed_i2c: Fix out-of-bounds read in I2C MMIO handlers")

Signed-off-by: Timur Maksimov gessingate@gmail.com
---
 hw/i2c/aspeed_i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 0bc4bb6fbe..136d4eb859 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -108,6 +108,7 @@ static uint64_t aspeed_i2c_bus_old_read(AspeedI2CBus *bus, hwaddr offset,
         value = bus->regs[offset / sizeof(*bus->regs)];
         break;
     case A_I2CD_CMD:
+        value = bus->regs[offset / sizeof(*bus->regs)];
         value = SHARED_FIELD_DP32(value, BUS_BUSY_STS, i2c_bus_busy(bus->bus));
         break;
     case A_I2CD_DMA_ADDR:
@@ -167,6 +168,7 @@ static uint64_t aspeed_i2c_bus_new_read(AspeedI2CBus *bus, hwaddr offset,
         value = extract64(bus->dma_dram_offset, 0, 32);
         break;
     case A_I2CM_CMD:
+        value = bus->regs[offset / sizeof(*bus->regs)];
         value = SHARED_FIELD_DP32(value, BUS_BUSY_STS, i2c_bus_busy(bus->bus));
         break;
     case A_I2CM_DMA_TX_ADDR_HI:

-- 
2.53.0


