Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E232FF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwse-00067I-IH; Wed, 29 Apr 2026 00:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwsc-00063K-KA
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:50:34 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwsb-0000dK-2o
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:50:34 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ab077e3f32so53037135ad.3
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438231; x=1778043031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EnJkJpchAM7vwOFSUOFAUxKHXhQnmjW3rca5keBbe/Q=;
 b=Lnj3KHJL7ndnF9+vPk1qDUdudOQ8N01Kz4P5oC3NM0jKbcw009Y/yJeim6PiGcsW4u
 hRVRx3QgP0+Zc9TF+nbNjiy03byea1+3GhLurkjUxqA/C8/7kNZt9c10iZbDn0By90pR
 I9Cpnehd3+yamzp5/y5Ee6Nl6hS5UqisnRWOJR5OQD4NB3fG1YMlBjGHNwG/LK3E4XYv
 /0407jMuvsXUxeiL9dr6xkT0yte6e2Vj56vMKry0kc0CVv1tADxjxbnYgLWmy1g0eymS
 X2xSCukeJJdCwrhnoV1DcTdgvQBdWsz5wQasQJqh+pSO+X4/DZjXSPJa+H+wu8nY37av
 RdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438231; x=1778043031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EnJkJpchAM7vwOFSUOFAUxKHXhQnmjW3rca5keBbe/Q=;
 b=rFiiv8yLEuS0/QQSfnnCvrf1b+J4nEGgrwpN0+pCFNPF+eKfOpg5cC8uWspv5XC5ZB
 BUAcvcl2ckyCm7CH1Jw3rqbLMzPZqtggiWAvpi61krG2Si0Ys1xsllVxXIGuW06CMg7o
 otvWXTx6QRPqm9DSO2gKYIW/qm0g+P0J/86lhGeO1qnc11OmFIGWaOhLkmWHmobbUdbe
 Dc9EyjcM7JWhj28yvwKc1ZvdeeX2UWTW2yHixb1daL8dUPNwmgaNSdHaYPQ6+3sIq60T
 5gIMqQvottXVW7ucpvifLwjzSm9vCwtYnZJAUqZGPt09RYKq/Pf1HxvxkOUoCGz+T1mg
 AO9A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+QeKou5ehgfQuBD3Old3++6W/ZSQQhOnlJXDq2TqmZQNNZbvGiHLEeO4e7D79RTetVwYxn4N+Zg4gf@nongnu.org
X-Gm-Message-State: AOJu0YwcExYq/uxDWAMbCpmS7zeltIFdMbY2pE2GpefmK6H9iZSB4fM6
 mE6UxIthsRxy7Ex7zK9zHxluJ2jCEh8FD2AxN7IPORE8BNP28rXzE4Mi
X-Gm-Gg: AeBDiesZRL8t2gZH1vMGhGJGDc3zkRi8srDPbPfJ8FEAA4qziuQK4gtS88Kb+GMiFSs
 1RXNsQt5YYOK5p0ndMP8kXAOXqpTwDa0XNxe6iVDqVlQE8WVNierF1hf8lD6vZhEnfKUAfgTnbx
 Gil9jSfcDeBlC840Qx5SjDZa5VKi1N+SjqjnHvGuc4IGrcQIo6kMUC9hFxywns7kgNlTHQjnntJ
 XWHrNSGqPj2eNizJmx9cS51El27T05cs6AYZrRN/wjg7SUYSK0b0J0QnTJ5QNFm71pyIp/cUH99
 wAa6cLRAszUJsu41fVMD8iVvL0OwFWQhA0MhTI58rem+aAhQCDDrdqav7pJhcjd9HF/leuINoLz
 YREDIzK6w3C6KKpmq46+W5QoXkAYstYXy+7nCSkP8pbMyHb/kYtaWoWhPDoQ9lZVgmqD+GQB4+q
 fkv+LTlEaI7jhbP8tcnzwPq4lcyjqjxjRfOcegaZHbFodCjlhw3WuY
X-Received: by 2002:a17:903:2ed0:b0:2ae:cb0e:fd59 with SMTP id
 d9443c01a7336-2b97c4120bdmr60169505ad.8.1777438231583; 
 Tue, 28 Apr 2026 21:50:31 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:50:31 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nutty Liu <nutty.liu@hotmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 28/51] target/riscv: Add the Zvfbfa extension implied rule
Date: Wed, 29 Apr 2026 14:47:29 +1000
Message-ID: <20260429044752.4176397-29-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
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

From: Max Chou <max.chou@sifive.com>

According to the Zvfbfa isa spec:
The Zvfbfa extension requires the Zve32f and Zfbfmin extensions.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
Message-ID: <20260402125234.1371897-3-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7c652dea78..bbab96385b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2622,6 +2622,15 @@ static RISCVCPUImpliedExtsRule SSCTR_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvfbfa),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve32f), CPU_CFG_OFFSET(ext_zfbfmin),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
     &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
     &RVM_IMPLIED, &RVV_IMPLIED, NULL
@@ -2635,8 +2644,8 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZHINX_IMPLIED, &ZHINXMIN_IMPLIED, &ZICNTR_IMPLIED,
     &ZIHPM_IMPLIED, &ZK_IMPLIED, &ZKN_IMPLIED,
     &ZKS_IMPLIED, &ZVBB_IMPLIED, &ZVE32F_IMPLIED,
-    &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED,
-    &ZVE64X_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
+    &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED, &ZVE64X_IMPLIED,
+    &ZVFBFA_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
     &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
     &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
     &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
-- 
2.53.0


