Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D01CA9EDE
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 03:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHCJ4-0005bf-Lr; Wed, 14 Oct 2026 23:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xHCIx-0005NG-Bu
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 23:38:56 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xHCIu-0008M8-Bv
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 23:38:55 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2e8f2c3ad6bso20020995ad.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1792035524; x=1792640324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6iOmegYCi2+kiLTh1Hh1rMDQY/0CO9Y8ougnF0CSQjM=;
 b=AQ4EpjK7NQ/UAbOEgu3Gbw77bLq7xOwf7rUIDnsI6ImldPQZVKdurXocgsFY1yiw8E
 Ao0MYXCWlWAI4TvmOWOkgaADzstD/HCKB1dRSaYFDqWeE3gk9uQte8nHRBIzFfSgmKur
 3M1VvUU0EKFJcWJjvcXSPnQQshLaRp0ncWOhu3fFhU0s83z/uKgBGvyQNdSmlwGlWMJ9
 6aOELTJFJ72JJUGQMbk/MtZot7ARVKOf6twoIQNRhFAO4pqR4iqFPxLYaq8Xz6NmS/Iu
 1o6oIC4Vm8TbzKsLbwwRzlj6FGU+WS1c9LcC7DxJCb6HsWb4bPLj0cHeZkgTivGLBy1w
 tl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792035524; x=1792640324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6iOmegYCi2+kiLTh1Hh1rMDQY/0CO9Y8ougnF0CSQjM=;
 b=BIroG7QiENH6Ey4alt4oPPzKul7r41zUoWAcaw8WH/74+WeGKKZD0qqIbrZX8j0Esf
 UF/h8UEofwAyo/ngq3lPVyTrl7+xf4JhgxTAu0N0jb9tS4CtdvuJ3OvfN6uIGGvOjfw9
 tEcR4k1EdVvxwT8on8igDyeHOLMADn7kRahgWqkRm6JiGKjeVqY1h/tJNoEDab3hX6PT
 O6hSLrVmnx0lgNzOKc9QHl2c8xmDwRXEH32TnV9FKoJMvNVrN70FgwNaKQIZJnpFkZPA
 SdDiwlmqHGqrn6wpHljFOAe45u8um4XXGayjI5CCU2n6nwQrCuwaYtflKtckm6NpUnc8
 Vaxg==
X-Gm-Message-State: AFq9FYJrg9UGfGFqsBtWNWPhDa6mJwB5iw+9cZ50vWI/RfzfLDV8FB5g
 cREeW2VNy/2JS+iDhcj/oaEkldzlUknMShcCOXOUmN8Kw+y7U2STpIW2CDMuxlFe6qEAa+QN2q4
 crBjX3NuWs9tXV74tz9VXO3LdNKKAiTi7Pz+pszcJfe7iqG6HjG05tRLqX7GasQczJHICgFRvm8
 0+2yAPAAEfBfP34osm1vxDUJta7W+Y5PeBjqssgkiVtgjscw==
X-Gm-Gg: AYBFou18+wypLkZ24IuKrhxbS1ahCgvv8wpOAiSLcqS6N0gJcsL10uL1jTUzqSCudkN
 gKTD6oQeZktt/5QcCAk8j0E9PjVAPqxMdO2/lcHvgkL4+KmecpPFrEDhZqM9dj5SHAgjvCK3oKu
 mpGzAVQX9Wq/M79xWGYQobzNjUOnkB5aFGNGRLU6x0njDOiUe/mk9/vKv3yxB/P6voLS6G6QqQE
 3TBDOW4+x7tFA3WzlNutZCbVq6LJtezV11QuCqisRQCzSNtpQfbtIlPtyNyisPsxqB/nmSyqcxm
 hrMzdy6pADpsZXeayWy+iu8leXbvK8GUy2L7eB35M7A9AIXUKSWsxvlX89aeZSGxQSjEHy0la7b
 ZCMqh3rDyqDxTwHh8G8zW+OICE/hHTmN29fu0BlZ9qdtygP7vkpu7FV64RCYWdTrULiVBr/5IbK
 SrUcKG/Gvbde8oELckg/lzck+U+NsPc9MofozznlKADK+6OijYIbEKXX1wci69/dbJMQs/TR0yX
 +0q5sfNU7Qh7ixeHz29mHZlzGpaW+HVaafk
X-Received: by 2002:a17:90a:e704:b0:3aa:fc22:8aaa with SMTP id
 98e67ed59e1d1-3ab3b0951e9mr14778761a91.67.1792035523459; 
 Wed, 14 Oct 2026 20:38:43 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.181])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd635c612a9sm559188a12.17.2026.10.14.20.38.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 14 Oct 2026 20:38:43 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org (open list:Xilinx Zynq),
 Jay Chang <jay.chang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 4/6] hw/dma/xilinx_axidma: Reset both channels on DMACR_RESET
Date: Thu, 15 Oct 2026 11:37:31 +0800
Message-ID: <20261015033733.35116-5-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261015033733.35116-1-jay.chang@sifive.com>
References: <20261015033733.35116-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=jay.chang@sifive.com; helo=mail-pl1-x630.google.com
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

Spec says setting either MM2S_DMACR.Reset = 1 or
S2MM_DMACR.Reset = 1 resets the entire AXI DMA engine.

Also replace magic number '1' with DMACR_RUNSTOP for clarity.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
---
 hw/dma/xilinx_axidma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 6892d494c0..687b5080e0 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -554,10 +554,11 @@ static void axidma_writel(XilinxAXIDMA *d, struct Stream *s, hwaddr addr,
         s->regs[R_DMACR] = value;
 
         if (value & DMACR_RESET) {
-            stream_reset(s);
+            stream_reset(&d->streams[0]);
+            stream_reset(&d->streams[1]);
         }
 
-        if ((value & 1) && !stream_resetting(s)) {
+        if ((value & DMACR_RUNSTOP) && !stream_resetting(s)) {
             /* Start processing.  */
             s->regs[R_DMASR] &= ~DMASR_HALTED;
         }
-- 
2.48.1


