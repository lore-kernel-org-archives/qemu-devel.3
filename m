Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0F8E68951
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:01:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MG4-0007JJ-S8; Wed, 30 Oct 2024 23:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MG2-0007Iu-Ob
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:54:02 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t6MG1-0003uw-3z
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 23:54:02 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20cdda5cfb6so4876255ad.3
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 20:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730346839; x=1730951639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w9MEmvUUXc+bdUTzl8uglw0lvJkSyGIG1hVQTYG1BN8=;
 b=T3VHBzd7vlzhjFWz3G6wnncQrObueRCZoPvqXW0V1vBT2Q1klSoteuf3zF58MiOlmS
 Lj/+uH9lQ4pC972nzJy8k/5Ur1p+JiXd39tPlJdADci8F2KIWgCW+Ytb21EV3dUkMQ/Z
 gW7NnPEANJjDh60txhYQYp3Fz75GW1rAloIh6HMe9N1qZJiW6Jp5K/OVb19mjWgVcZF9
 NE/uGlu6h7dS6O/Tl5JRrNmfHT8xZpTlY+fGYXG8cBvROD3KAGduGxeb7Xr6uouJI3l8
 uvnvTrXdhDmCI7GrFwOlA1gQ7KYJJiGgwzrXiTCRp8cWfNeNT2Rn+qFK2okrKOVfA8Fw
 VXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730346839; x=1730951639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w9MEmvUUXc+bdUTzl8uglw0lvJkSyGIG1hVQTYG1BN8=;
 b=vA8Yf1yA1SQVVlqmvGxJpsSEqPKl9/2r4IhL1PUMJhToqQw7ABmocbbhwljFitET6z
 P7uMIlBlLipqBgY7+/wZbZiOY12ydDIGBViPDumktGRCYktJbSKdup1/o+b0ytpSI+Jb
 96zXY9Fqj8m0k1VaC0C80fWXEfxzEae5aHYSQD03HkqGgJCoI2qI7qsLFc4+xY8Q8lvL
 ZjqgfcdoxkopfS4JrSaXmvYXxuVSHpRH7cHFUyByI5iwl9+gwkyeDjG58WnB0+M7U8sZ
 K8HwT/yuyp5CvapbHHd6SBaqw1kW0Fy52sWtzJO6Klj95vcoH0VRmn3PffTB7zMb+Y0Y
 NQYQ==
X-Gm-Message-State: AOJu0YyGj4ICrTSDVNBPSnf9xTQLO2wv9JBxxhNisCUZQK9iSTNTAoSL
 5N/telW50vSXe3doEL7mPe0EsGe2iiiBXR+++97mCKmpD+r65uSU7r2K02sF
X-Google-Smtp-Source: AGHT+IEO5Y7PYrBW90CuwUgIAO8BajCIJ3zg0BM7H4DPIN298zuBGLHiKHSbK7QXtEDQddG1ooC9Bg==
X-Received: by 2002:a17:903:41c1:b0:20c:aed1:813a with SMTP id
 d9443c01a7336-21103acdc1cmr17187925ad.14.1730346839570; 
 Wed, 30 Oct 2024 20:53:59 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21105707064sm3022795ad.70.2024.10.30.20.53.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 20:53:59 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Sergey Makarov <s.makarov@syntacore.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 11/50] hw/intc: Don't clear pending bits on IRQ lowering
Date: Thu, 31 Oct 2024 13:52:39 +1000
Message-ID: <20241031035319.731906-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031035319.731906-1-alistair.francis@wdc.com>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
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

From: Sergey Makarov <s.makarov@syntacore.com>

According to PLIC specification (chapter 5), there
is only one case, when interrupt is claimed. Fix
PLIC controller to match this behavior.

Signed-off-by: Sergey Makarov <s.makarov@syntacore.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240918140229.124329-3-s.makarov@syntacore.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/intc/sifive_plic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
index 8de3a654bc..ed74490dba 100644
--- a/hw/intc/sifive_plic.c
+++ b/hw/intc/sifive_plic.c
@@ -354,8 +354,10 @@ static void sifive_plic_irq_request(void *opaque, int irq, int level)
 {
     SiFivePLICState *s = opaque;
 
-    sifive_plic_set_pending(s, irq, level > 0);
-    sifive_plic_update(s);
+    if (level > 0) {
+        sifive_plic_set_pending(s, irq, true);
+        sifive_plic_update(s);
+    }
 }
 
 static void sifive_plic_realize(DeviceState *dev, Error **errp)
-- 
2.47.0


