Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC332CD5BAB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDNK-0001aR-Br; Thu, 21 May 2026 20:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDNH-0001Zk-OO
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:24 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDNG-0003Kz-57
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:23 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2ba17c8cfacso65843335ad.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408261; x=1780013061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kytvezs7OB3qcRs3AvyEK68NIDmJYWzXOaWB19Zt0PI=;
 b=H+UiZNKT+QBKcFuyRMjF9nyooK1XYhvq4kF6s9aRoC50UZdcrq+0i9MOxO9kaseSd6
 8qyczdxmGOzdSYsRTEmDzajeS9Nec7AErh7ftjp3C5Dip8tyHc1I/B6RkrEPuNGAdG6R
 TRD5AD3Ou0KPPOZj1/9dapvNt0VCJgViCHutDzkL+Rt4GQHWQKKdWyWsrgx8UWErBQOw
 GK5M7FWOOJ7j3sqpv+11WjLuSQJgzjlQIhu2kc7Dts3FznPpGdNFY3ZBt8fPC6O957zq
 xDL3Jp/lHxvb83ajDeHtfkLF5e51M/L89CYMyF7DWl2VPdC08uPhczAoe+MdaaDgdYUK
 9gEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408261; x=1780013061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kytvezs7OB3qcRs3AvyEK68NIDmJYWzXOaWB19Zt0PI=;
 b=SRZSun4P8wdWFzbQQagSb9vaBuBpn0idnkM8TqCxvJ1oETaI3iWS0tHRpq02VP8tPC
 TwZ57W0I92mPeFb7adB6S2GvxivmTa+8TBgFxJx9lGMnzSIobpc2/vEPdVde48pdNlKH
 kIStGiyPM6k2WEGdAKEZ+2TplucElOnEKTfZNTCEwuh7H2/+Mm0ZDBUxe9xJ5YuFUuwi
 K2znzVXaDk0gk3k29ogZd7qx4gvdw+JHLMEPbes94ZLWuXY5C46L12yKMLJDz1gCmneb
 jpLN/2woSpAYtAgpZckt4ZjUnmWOQmlEhNuzh5atxa8IoMOB2iJbi3K97FEHIeH+kXp7
 s6cg==
X-Gm-Message-State: AOJu0YxamAqd7wSqDZcNX/iJNAHejGt0pAzdgC+jUqCkeSkjxJoEsR3S
 2sj79wRiSwIlOFRS/WGl/Mhr/qHsSJ485siy7MfmcdJp8Q9tZ0W73njSUrf+gV7z
X-Gm-Gg: Acq92OH3K40SmD2rZs/1RoD8N84GWl6k7NHvSFB6JGOuC15mZRzs3Lm2iOpIHnivhOa
 9ivdwDZEc35KHihE01prseXg2YGFPo4rcrkQL1KWnv99/GJNz+LOAAogCnEdR9y6KkhUs30Rv7A
 DXtH59LLlNO2p2Mt03tFdb7kab0enlz8w7h5qo4zDFRLLQ4WzePXP+k2if3NXFgjncDLqFNFnj+
 bN3RA8efdjva3Gd18EYA3szguoq9LBoIJ8eI0n2XmzDu66ZJ7QOTdaSR93y+nr/pYqHWdXxFpbm
 0inRq0JVudnAArpKOGKMfCGKQs2fKaq4A43AVNY7U6pdJkrnyHeSSqK4EOuOctS8Uxh/H4PTK72
 VYYua0I2dlIdu+X+7WY30qhD/Ex9qPAdTu4/4/ZQd0s09kWDieF+AHzW+y0xYjkFUzpSbSKb30P
 QEUbonQZww28mi+UEtzhXn2ytYrON3pdQTcPK22hUM5g==
X-Received: by 2002:a17:902:d4c3:b0:2bd:646b:2ddc with SMTP id
 d9443c01a7336-2beb0375f34mr11400945ad.12.1779408260816; 
 Thu, 21 May 2026 17:04:20 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:04:20 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Zishun Yi <vulab@iscas.ac.cn>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 14/48] target/riscv: add Zvknha as an implied extension for
 Zvknhb
Date: Fri, 22 May 2026 10:02:50 +1000
Message-ID: <20260522000324.23255-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Zishun Yi <vulab@iscas.ac.cn>

The RISC-V unpriv specification (zvk.adoc) states that "Zvknhb
implies Zvknha". This means that enabling Zvknhb should automatically
enable Zvknha.

Add Zvknha to ZVKNHB_IMPLIED to ensure the dependency is correctly
enforced.

This issue was discovered and reported by SpecHunter, an AI-driven
architecture specification analysis tool.

Link:https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-isa-manual/pr-2635/qemu.txt
Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260511051736.2916225-1-vulab@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 506a018d52..8be06640e5 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2542,7 +2542,7 @@ static RISCVCPUImpliedExtsRule ZVKNG_IMPLIED = {
 static RISCVCPUImpliedExtsRule ZVKNHB_IMPLIED = {
     .ext = CPU_CFG_OFFSET(ext_zvknhb),
     .implied_multi_exts = {
-        CPU_CFG_OFFSET(ext_zve64x),
+        CPU_CFG_OFFSET(ext_zve64x), CPU_CFG_OFFSET(ext_zvknha),
 
         RISCV_IMPLIED_EXTS_RULE_END
     },
-- 
2.53.0


