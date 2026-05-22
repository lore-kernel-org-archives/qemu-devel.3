Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C75CD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDMw-0001Wi-D2; Thu, 21 May 2026 20:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDMu-0001Vk-91
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:00 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDMs-0003G1-PG
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:00 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2bd9c3b550aso46085925ad.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408237; x=1780013037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WC2iiKLLlqcGQYDTGH87Wu5VEUoCfQXRtJb1LZHx4HU=;
 b=Pjzn3fpeYHVRs5IS/F5gpwmsKO8ZNAqggtkLauJNm9RAtpN5eMoa6lWjVkvVqBRcDG
 +T9EGS4DMz7A7BGZR2qfoyzsW7yJe7A0pHGrJTIFcaCXrm9TrJCQE9OytLDkBlcPv18S
 eEl/+NEyoH0AiNcz65L4g2Cz4VKtoy6Taw3oKOepQbo9KJ3UnKqXVFe/ofV8KzwoF9vM
 KRYeD2blOFi3X2QInpP5o+IDF/36AV5CCGRB6aki/MIFqgr7+EA58ADKP/W77A4MsrZb
 XhHlILnSBFgJFKYghkfGFT7i7NZrJp6vOREa2iFjd+CtcNTX5UTERXZ4dyribNNqqtXV
 reSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408237; x=1780013037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WC2iiKLLlqcGQYDTGH87Wu5VEUoCfQXRtJb1LZHx4HU=;
 b=CX9yKKwaYp+fyyU3SSzXwehcE/r9InhpP7AS3OIxZCU/jvgHGFNGPPMUXmYiPfXw3n
 C3Fv7bnOj+2cE6RM3rVchvpfxTA9hqwpsYMxCqozGIzvK65x7Zz5SNaQrF9ZRIK0tZgZ
 n3m22xyqQ6wPMNTDZPg6kymTPGokfjUGAZj7IugLGr/rqZVHwKSTNcUuxMAevCr+YlaO
 1YOagnuv+ecj43F2usosBXWL/KW/zLCeVWeBMAsWs3cAeY8im38nU6i36nrxONc3UWAQ
 u6DpKCTU6hDXWnXSLrEJ9McLDXMyb8fN4jCHH2MhirDcymnoRjuuOb22nkTWzrZSqPR/
 xZnQ==
X-Gm-Message-State: AOJu0YwJxBCu5BL47e9bAHqfq8UgZgBIWP3vNl5q9dRGJuMwSdOz9CZ6
 kMsRlSFQu0JX9gGa9vM+R+1D3iD3xWUaWplZnBLBgsbzUlHrtK+SHu2HcF2q31Gx
X-Gm-Gg: Acq92OHDJJzPxWDkUErgO2wVQ/2TW1DHUxmZdGmFNCO17B1EjpYph3Mxz8M9ztEgCYm
 jdFN6tbrI/+WhCtU/jCnyAIgQdJKLvXxtJhHL6PaCLT/iAGCC7DCo/uCkqu/SSj25pNtgcSUEAy
 /nAuUDktV5UMfLnYSdTcN/VS1xKs3JN2CdPrs1VTFvexpTw3roXLB6oBbbyZEjpxRkheJ/GmY5U
 42YXjytLlUgyiwjHI403fNlF5iHlIdJcGaEjA1FBabdt+Dp0eVEC1oPQTtzEuH8zNyGcq/dOc0q
 K8HAh7/2hCG4kalgM85DV2Ss/Occe3NDf3rMVm1xFlVy3yZ6J+Ec+Ov9UK19cZsD6CGeEwoGRzD
 lx0uBgTEK4FykJizNB+r6xYrPHIvjU/WRmNoxTHy+ZG2VFIVH+lbcTtb4PFHlbroxAPy1KyQGJX
 vYtrdE9dHOzKrcIOydmOFI7ooc23Z4V6+V3SiMO+y0qw==
X-Received: by 2002:a17:903:f90:b0:2bc:dca9:f0ef with SMTP id
 d9443c01a7336-2beb0770a09mr10606495ad.36.1779408237348; 
 Thu, 21 May 2026 17:03:57 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:03:56 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Mohamed Ayman <mohamedaymanworkspace@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 07/48] riscv: virt: avoid RISCVCPU copy in PMU FDT setup
Date: Fri, 22 May 2026 10:02:43 +1000
Message-ID: <20260522000324.23255-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
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

From: Mohamed Ayman <mohamedaymanworkspace@gmail.com>

Use a pointer to the hart instead of copying RISCVCPU when
passing pmu_avail_ctrs to riscv_pmu_generate_fdt_node().

Signed-off-by: Mohamed Ayman <mohamedaymanworkspace@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260503180252.1122776-1-mohamedaymanworkspace@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 315049bc86..3d06c9c610 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -722,11 +722,11 @@ static void create_fdt_pmu(RISCVVirtState *s)
 {
     g_autofree char *pmu_name = g_strdup_printf("/pmu");
     MachineState *ms = MACHINE(s);
-    RISCVCPU hart = s->soc[0].harts[0];
+    RISCVCPU *hart = &s->soc[0].harts[0];
 
     qemu_fdt_add_subnode(ms->fdt, pmu_name);
     qemu_fdt_setprop_string(ms->fdt, pmu_name, "compatible", "riscv,pmu");
-    riscv_pmu_generate_fdt_node(ms->fdt, hart.pmu_avail_ctrs, pmu_name);
+    riscv_pmu_generate_fdt_node(ms->fdt, hart->pmu_avail_ctrs, pmu_name);
 }
 
 static void create_fdt_sockets(RISCVVirtState *s,
-- 
2.53.0


