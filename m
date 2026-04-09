Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88444F31E29
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 14:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAqGf-00033e-Al; Thu, 09 Apr 2026 10:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAqGa-0002vE-3N
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 10:21:56 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAqGY-00037Q-IX
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 10:21:55 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43cfce3a195so601559f8f.2
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 07:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775744512; x=1776349312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v/Jd4YaaBvTfPvDC0v9XltfRQcsbFxXjKJ96oBPPl9w=;
 b=N2OWpNNmiRROwGRB4JCiIDUdaOxbW8sOny3l7/HVaHplyUgKufQO2CuS7M45M3fsX7
 rmqi9NbX1SnRnVRGP+ucWwSgHCuyw/5DNqlMMqNkELfQh7h9dKTvyu0uhYy2IWMgbvJg
 WhfOadY/W2Hxrj5xvFP7duitp5X2IsuK74foWSTvwnACjxmxMHT6zuAcfLsOyfdUb/3Q
 ki1pdPG+7DaOYgcoL5gS+Oib8apiwAU+QhbHlKqsfMC18glpdbJCcYpSgU2BaPdSEuIG
 VHUx/Uu3ykFClqctWn8dtQSSFfLv6yy0d2g6JpOO8oucreG4rG7trDNMEMILIxdPFX+s
 g+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775744512; x=1776349312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v/Jd4YaaBvTfPvDC0v9XltfRQcsbFxXjKJ96oBPPl9w=;
 b=WpbqSek0VZPiqbfL88kpUPNGp4fJ1b6Kirs/qoRTY+TrSalESGO1UQ0ZAYIUmVhIQd
 zDtpB6rx02xiVfyDTCnQuAWXC6Elgr0npiQ/82l6WbdG7RW6C0Ggqh+Vi1gvdUygTwYz
 JjDxxYBuH6a4TAvVR+BQ3TRffUv6hKSqhN/Lv0bnWzi1VZP8EECWRo4zk7yxV917r08c
 0qWCa/Y28kJyMKIMK4aacJ+619rMB9+jZri+dRiGKHpvMY633M80I4veak/apWAv3kMc
 7yfEUu6cRrmBHzrK2X41lGpB7H9ljtOlZ2rR0o8J5pEEY7xlBdzknqTrjI2tdidfQGNU
 jCVw==
X-Gm-Message-State: AOJu0YzdrS2wm/Tc8Rk2CTd+1wNnD6kso04KXOMHPJ3tb1I57D1mskIA
 FC96Phbx3EHkpGsEwEwiLoKJCg+TB1XRGRDN08AmmUGSL4Rq3htoZFdpyIGuW8t5qezHIfdb7pp
 H30Zlx+M=
X-Gm-Gg: AeBDieuQvF2Fi3ydHhnmwvRzxuKUQgT2wuP5ki4fHWY7O07iyPBTVcpZtfywlnL63jN
 W7KFBMrW1DV15Vi0DRG3TXU7ZMkl4NbvzFug/b3Fjkog9NpP1TxlYKHONVQRWt6Ezyzq1+eqdzh
 xP8uqliExVvmTpkMDvZBX0/ERxNTO9OJJDo/cRy7wD8iUoFxrCnnLbuRwoX9R+N7z0eIH6GL63R
 WvvvEgq78CJAMxks11psIJRfy0Xvphc0Ah9P3ivAth7BEN4DxvqYViziGaTEit5elNqDLmTcVDw
 wYdYGm4BHdfa9iYMsGowKEBT8K71a9cpZsT1iJnL+fF++vuZPKViU9bILvfsAPY1l+jaE9sx5uI
 C5x9G9ssp83fuBOeHP9J7gdSgRpzDl5qlu5wHZSnpPZ5DzZdWK5RcTxr9WnHK54GelnR1didS/B
 XlmJ8WHFvZU46cCx8VJ0iaDoGDrFAsptR7jR1QkImWDL//fsUNWA6TrdQIhr9qOMtWx0f0Q9eSA
 YS39BoPkog=
X-Received: by 2002:a05:6000:4305:b0:43b:50d6:4f04 with SMTP id
 ffacd0b85a97d-43d5a1a274bmr5276932f8f.38.1775744512535; 
 Thu, 09 Apr 2026 07:21:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e2c50a7sm67405047f8f.15.2026.04.09.07.21.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Apr 2026 07:21:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/4] hw/timer: ibex_timer: Update IRQs after writing CTRL
Date: Thu,  9 Apr 2026 16:21:34 +0200
Message-ID: <20260409142137.58349-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409142137.58349-1-philmd@linaro.org>
References: <20260409142137.58349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

From: Alistair Francis <alistair.francis@wdc.com>

When writing to rv_timer.CTRL after setting the compare values the timer
doesn't fire as we don't update the interrupts. Ensure we update the
interrupts after a write to the rv_timer.CTRL register.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2796
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Message-ID: <20260407043614.372871-5-alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/timer/ibex_timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/timer/ibex_timer.c b/hw/timer/ibex_timer.c
index 0f12531934d..571633803d0 100644
--- a/hw/timer/ibex_timer.c
+++ b/hw/timer/ibex_timer.c
@@ -193,6 +193,7 @@ static void ibex_timer_write(void *opaque, hwaddr addr,
         break;
     case R_CTRL:
         s->timer_ctrl = val;
+        ibex_timer_update_irqs(s);
         break;
     case R_CFG0:
         qemu_log_mask(LOG_UNIMP, "Changing prescale or step not supported");
-- 
2.53.0


