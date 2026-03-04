Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A43CEDEC02
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 03:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxcb5-00018a-Rl; Tue, 03 Mar 2026 22:08:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vxcb4-00018D-4b
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 22:08:26 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vxcb2-00020J-GP
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 22:08:25 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ad4d639db3so29166085ad.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 19:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772593702; x=1773198502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=blpQK4azDx8J3XzWoxy9ZUGYHZLU/JBdHaMe/KYzCbQ=;
 b=AkVMxtB9DWDN3rM3puCLfLpbutrpPdCTxs8Z64VVi6DdToHZffcjtqQic1xZsuGc5m
 cp6F02kBdY2sBKW1wb+ittc44haY4IVDHdcSldVTY+55uVXGp4AzlMt3GyY20jn9o8Cd
 xBG7eS4gIvdHi2+2y5qIey5+gTJbstdsHl51dzE701hzsM9nRXk7mbmofmxpC2gFHEtj
 hfB9pzpjr0xDP+sPEjiQ2IOcwnK1fPTRw/l7RWml/1I2z8NYBNlQJqQr/2JqNubHXIWP
 +i1ZxH6qtu5R59sD1dJWBZ9qae0cFlIlZ8F5nxQVnkTbNkvi8IhwK86Ln5ynF8/FUAfB
 E9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772593702; x=1773198502;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=blpQK4azDx8J3XzWoxy9ZUGYHZLU/JBdHaMe/KYzCbQ=;
 b=kMMc+47/V0/GUIfCq4lZwL26hqijlnuvg/2q4cEJKmggm4UnOnfAcEZVBtUVUNkwcs
 siTb3IW+BfiohmeP5psRwrdQ7W2+1Pv6g82VXbt1mSMf4JL9iTF9keiB+nrD9e8vu7NJ
 QoiMmeHrM2MPAmaxRv2y+Jd1cQ9MMrlLdsWO/IbKvVJxkKHItbuzfAxzL54A8sJPswy5
 +umWmiagsooJpMzRhCrR2QOvilkSxLxFFCOlOKWWdu8CuiRtCCvkYF05h5J7BkUcesHs
 alRjHPLHIE4C7ORf9kAIVkWmREXRfxDyVccnBqe7X0NP9TfBptpzF58ajQ4+4HthSPIy
 ttRw==
X-Gm-Message-State: AOJu0YzChv/n6v0ddx+pLIimINxvENACVqMFba5eBEWMNg2VYzfX9kvM
 n/IMjsSiXZSWba9YMbbzovrdhl81NeiV0f6dD5kTx2SfyEsGrEZpIhKcEyrnA21PSa6T8AamlSD
 m3PwwqHCjovuSe++LPvceHz7VshkMvtFPlHEtYPJfzO87aF/HRJ9m2Q4SaexUTrtLwiMXHXz8kd
 07ydCgqUlgqyV7RenxIbChxQPwvKOsy9iMRRTil95uzN4=
X-Gm-Gg: ATEYQzwS+d1Zef7Ug5DB0Ar2kOkulHMRvPtkGFFMmH5NCEWb3A5T1H0YcDQrdEm5o04
 SyPVOLGeGBVV+uHVoTkMa/X9cdnCYezC11DEKEGtnrOeRYKnll9LLfNPeNlFncdKbKifq3n4drC
 L/k50rFB+fK3Skx9ZLS5xnI/Ex25Haflxu2n7U9sHHgrbcug1GM1JMZSpVfM8yVEB4jXAVD6RPL
 Kc5mlqtcq3IzHIl8ZsHp2d77z0pgiiGXTVV9YpKAp/WUQm0hZFDIzls5IRd/rA1z3eAFhoT8W/a
 4dVtWobx9BOzqRB1hk6m+xKoBON3vTznDbOCJHsjlDGW93QXYpTbfcaABqMaQMmtnc2Pz8lOn9E
 OatzXAbXvhQQ4STz/TyMo+xOcXnGztExhfqHzUp5NYya92FPqkekNQ+Ri6zb3WLuMw37Xn8dcXd
 sZ1Cpe+bwSdc3twG5WR9YZ+WCb7MGYubScQ9xdS/WfOJT0iu+T+JofZ9K2hLKOyQ==
X-Received: by 2002:a17:903:2f8c:b0:2ae:48a2:1c3e with SMTP id
 d9443c01a7336-2ae6aaa73fdmr6234345ad.27.1772593702271; 
 Tue, 03 Mar 2026 19:08:22 -0800 (PST)
Received: from jchang-1875.internal.sifive.com ([136.226.240.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae3e4e34e6sm114774205ad.30.2026.03.03.19.08.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Mar 2026 19:08:22 -0800 (PST)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Jay Chang <jay.chang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH] hw/dma: sifive_pdma: Set done bit upon completion
Date: Wed,  4 Mar 2026 11:08:16 +0800
Message-ID: <20260304030816.33209-1-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=jay.chang@sifive.com; helo=mail-pl1-x631.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Ensure that the 'done' bit is set upon transfer completion, even if
an error occurs, since all transfers are considered completed regardless
of success or failure.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
---
 hw/dma/sifive_pdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/dma/sifive_pdma.c b/hw/dma/sifive_pdma.c
index 6d06ec0375..7b22e51492 100644
--- a/hw/dma/sifive_pdma.c
+++ b/hw/dma/sifive_pdma.c
@@ -153,6 +153,7 @@ done:
 error:
     s->chan[ch].state = DMA_CHAN_STATE_ERROR;
     s->chan[ch].control |= CONTROL_ERR;
+    s->chan[ch].control |= CONTROL_DONE;
 }
 
 static inline void sifive_pdma_update_irq(SiFivePDMAState *s, int ch)
-- 
2.48.1


