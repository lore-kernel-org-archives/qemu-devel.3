Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81170C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm6Bq-0005Ol-4Y; Tue, 21 Jul 2026 04:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6Bo-0005Nn-Ik
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:51:00 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6Bn-0005gL-3K
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:51:00 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49555a0e68bso12902455e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 01:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784623858; x=1785228658; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tCar3TZ1LsBwAlO7WsEkLyf5Y2Y7u1oPE70SMZ0kqBY=;
 b=D4jLkO0OQOBbCoGBBH7pFBmaTLCmgojf8oPinISUmbaewgtLEbE6Ji8OCW/rdsDYhL
 BLku5VOTAJqAQqxyfgY3vYSztTYVbCN37SXYw06ow2jl1n/t8LYWbAPLPdmvQFOcJpyC
 wBeqqEPrMAcseTjDryn76csIBJWKyE3WxeqILspKNH2hplDrdMJ5rbubBDPBPAsr/REa
 Wlz6p9OIhtl71ozQS38rwc0Ka4LgV1Pg4rnkxmJIZmzx9B57CKVc0ee8I0q48vR7JXi8
 xz4wvAffLQfDFOLMah5FssoEpMQC3p/ZYyDhgSplB+FVRS/ZKkdGpez8CSGBXIqL5LQq
 X4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784623858; x=1785228658;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tCar3TZ1LsBwAlO7WsEkLyf5Y2Y7u1oPE70SMZ0kqBY=;
 b=b4t/UIqa6RJY88D/zrM7AkjhiKcfzLEcdIk6rmqrUV6anDHnIkiXi1j2vWswYQnXJf
 MxjosXj4zvUNTdQlHn9Gzuf9FkJppfGLne21AY2cKa9JGoJy7tUZd1FVgpkbvNHHtD+1
 Z9lHdlpUBs40eLTwkB5VfBSu3avm7IyGW/kTBUKEQR0+tiNYaBrnMR0VSusGvgOLDmjg
 wgDFvmj8Cqx7TwVuhp3cWmuPPkPWp+ruZ99q6mkYaNQZUaZiBU12OJbWg8E/u6+ZXEt6
 D8oRJw6kTVKwxqh5aP3bXwy5Scj+6dnI7ATKzWa03WLjV8RzGMp/I2SiTtIdFg+S2nS7
 D22g==
X-Gm-Message-State: AOJu0Yzs39Xs85Xn4FtmMUbz5ZBCtvvGufLrMG7uoYitNOFE1VzAOYmH
 Cr1qMyq5Kdt6zlcJv/UqN7ud9G5ezY0Mzr2VPaUgWFrzj5M0zDIfTVX2zErszgaHgYKX3zf7Z8g
 MEahq2NnbMA==
X-Gm-Gg: AfdE7cnDIVTNucgjaH+uZUKyR3e5Zrp2/e4oVO+OYvIZrMi9xzWUDJY4SOC6uv7gQmh
 VHeKF/dxfGIO+uVkocGRrPJJeU+IOqvNurgMnvWvqQI14lwO6+BqpgemGH/oZ/E0TNYnPFi7Bdy
 1fd/nkM2w32xUoKE3WrUbToQxTEj3XRbxsGh3ZNmZo/u7ggfCloDO3AoKGaPg6T6rB1VSKY28lJ
 i6qsAChWkqze9SzNcrJsOBbAZy41bkeRsBPxa9M656Tzvqsq5aLC97HznemqjqDlu99d+pw2s7L
 Ejzsow7zDtRaayPVuHLe7BSXda1xcnpzYcqoMPogH5ksxeWdKsHhfLWy9L1LBPDsyBKuMQAsHkw
 OD68+hW/OurXxKgNjN2H5trpfRCa7Lj66F8exdcMLhO9yX80t4cfcQDdwdiNiMRuOvSewTIp09r
 heDf10ajm4jHyNDlyXoFQbbPkFJ+IFOU4OJjRjvgElBF9IoOc74wF5hkd/7uUllgTD+9WoXR2hh
 c6oBBFrKUKLaVj8PsoGQQ==
X-Received: by 2002:a05:600c:524c:b0:495:4e17:cad5 with SMTP id
 5b1f17b1804b1-4954e17caeemr190912105e9.26.1784623857449; 
 Tue, 21 Jul 2026 01:50:57 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956537c7desm68707245e9.7.2026.07.21.01.50.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 01:50:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/16] target/arm: GICv5 cpuif: Writes to ICC_APR_EL1 can
 change IRQ/FIQ
Date: Tue, 21 Jul 2026 09:50:38 +0100
Message-ID: <20260721085050.421257-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721085050.421257-1-peter.maydell@linaro.org>
References: <20260721085050.421257-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

The ICC_APR_EL1 register values change the current running priority,
which we use in our calculations in gic_hppi().  Changing them can
affect whether we have a HPPI, and so the value of the IRQ/FIQ
outputs.  We need to trigger an update in the register writefn.

Fixes: 9bd90bddb79 ("target/arm: GICv5 cpuif: Signal IRQ or FIQ")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260714091806.3568281-3-peter.maydell@linaro.org
---
 target/arm/tcg/gicv5-cpuif.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 8e2a08fdb6f..a6e6c440849 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -495,6 +495,7 @@ static void gic_icc_apr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     GICv5Domain domain = gicv5_logical_domain(env);
     value &= 0xffffffff;
     env->gicv5_cpuif.icc_apr[domain] = value;
+    gicv5_update_irq_fiq(env);
 }
 
 static uint64_t gic_icc_apr_el1_read(CPUARMState *env, const ARMCPRegInfo *ri)
-- 
2.43.0


