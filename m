Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21889C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes2J-0002dM-RE; Wed, 01 Jul 2026 06:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes2H-0002XL-Nk
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:17 -0400
Received: from mail-dl1-x1234.google.com ([2607:f8b0:4864:20::1234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes2G-0004nI-34
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:17 -0400
Received: by mail-dl1-x1234.google.com with SMTP id
 a92af1059eb24-13b2d7dc8d1so389975c88.1
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901155; x=1783505955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EDSU73NnRsCuqjkJt0Y0dn6AC859Y51TrtUnRoh72iM=;
 b=XIa4hqh3AHBZbEpJTbjBGTtuo0xMCXrsGqpqdWbZPmYZHLaj/dH1JTCyi4KgfwNrDB
 vucazPKMMw90jsvqnkP8iG5HMw2udVD3Kxkr6NYX9iyc4Lzh4cQVtiV5Nv1tF9TepaxH
 w7paWB1j77tMl6Q71N/6VaarnJIAMaxgYEag+V5xZPddPhio13kn5FxvnVXTz1EmqiTl
 qgGbipe3rTnPbFxIUnlBSB6HRArgyDJuqeII1pV1k8IYWCizlJXnVBjqGINdzCzGwr3K
 kaRcDl2CoGAO8IX80qWPLBh2HHGQkHRjKaLlJxeno1wcaNo5QUbU6dXU9NEO8UDSzVRQ
 4qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901155; x=1783505955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EDSU73NnRsCuqjkJt0Y0dn6AC859Y51TrtUnRoh72iM=;
 b=PCq9yn3mhXdxnQWmd1Bt59c6adEa8qNja3QQD3RbynoSTM9VVkKYRbXKyjzwtfmd2o
 +azr17+q75mOWfWyCwfFARM48uhnzI0JP0beF0lqWlrT+X47dFfIqfReqrc/sHnEPDTQ
 UGFduh4KEC3Lc3GqoxIDBqLaqHR9rye150G0jFpA2NamUbb3k1SDRweFrYt2e55JudL2
 p6pEQ0lII+y0Vvkx77t0xT+/yeYo/cpVzOz3b4dfbr9JsOqh2FssLT3A4/n8vD2AqJqR
 k9VmOmJT0FDE//SRE4p6xRVBaHjHthh3J6kITZOruvxT2ZkP+43Y7NCj+6Goe+2kNvll
 eaIQ==
X-Gm-Message-State: AOJu0YzAI5EFRCeMLzHHhzUXvV1L0TnwK6rxGRShQ5tOL7w+hl7/3shF
 wMwiWvsjvOzZ8Ub9q4VAsYZvM0Rvj9JCHeEcM+SpSc1RIWsuhPDsDBUWG8NYrQ==
X-Gm-Gg: AfdE7cl2IRC87Ox8EF0J6PRQ6sj5x1QDIvuBPS+ndefuPhJT9i96gMzcmg5aY2yHy8g
 rC8dvw5R8bB60gNZsD35ENmni3U+h60iTP4TR5EvrtM8kx4gxGIbuJ2E74XZORuuCfXHGVzkZfN
 E4pmp2Q5eYKy0RhhnfFwC6jDGfY39e+S3+VoiWCY+bNeeEampu68bgdq5COeTyMAgEO0dKH2E8A
 dO+zJA+RY+JP6bQj82qfok/ffPw2ty8/WCX/d1trE0sl9cpsjH/GqZ0RclJFlAefxPpKYqoPptt
 lQPHuLulMOkDvWEQ7JrjopeNlxOv8tTiGOcStMPpSxLpZDI1fljnLrcx5aJmzNPn+pYkPQSa7Fw
 cTxWuqgPDU2VyYegzQYgCfktJuOI+hp+OQgWl5wOMaF7byZcKArvfwP+8ObSOrZHQCFSyGB7bH3
 LEJOYop5n4nru8opvXImJBv294y4qu7hU=
X-Received: by 2002:a05:7022:419d:b0:13b:20ad:b976 with SMTP id
 a92af1059eb24-13b36e01a14mr1163595c88.47.1782901154659; 
 Wed, 01 Jul 2026 03:19:14 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:19:14 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 22/39] hw/riscv/riscv-iommu: set cmd_ill IOFENCE.C rsvp bits
 are set
Date: Wed,  1 Jul 2026 20:17:35 +1000
Message-ID: <20260701101752.2522962-23-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1234;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x1234.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

We're not setting RISCV_IOMMU_CQCSR_CMD_ILL if a reserved bit happens to
be set in an IOFENCE.C command.

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3575
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260626170533.3562484-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu-bits.h | 1 +
 hw/riscv/riscv-iommu.c      | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
index f9b6f35170..cc0b1c3ccd 100644
--- a/hw/riscv/riscv-iommu-bits.h
+++ b/hw/riscv/riscv-iommu-bits.h
@@ -347,6 +347,7 @@ struct riscv_iommu_command {
 #define RISCV_IOMMU_CMD_IOFENCE_OPCODE          2
 #define RISCV_IOMMU_CMD_IOFENCE_FUNC_C          0
 #define RISCV_IOMMU_CMD_IOFENCE_AV      BIT_ULL(10)
+#define RISCV_IOMMU_CMD_IOFENCE_RESERVED GENMASK_ULL(31, 14)
 #define RISCV_IOMMU_CMD_IOFENCE_DATA    GENMASK_ULL(63, 32)
 
 #define RISCV_IOMMU_CMD_IODIR_OPCODE            3
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index c2c470b5df..9bf02084cc 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1880,6 +1880,10 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
         switch (cmd_opcode) {
         case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IOFENCE_FUNC_C,
                              RISCV_IOMMU_CMD_IOFENCE_OPCODE):
+            if (cmd.dword0 & RISCV_IOMMU_CMD_IOFENCE_RESERVED) {
+                goto cmd_ill;
+            }
+
             res = riscv_iommu_iofence(s,
                 cmd.dword0 & RISCV_IOMMU_CMD_IOFENCE_AV, cmd.dword1 << 2,
                 get_field(cmd.dword0, RISCV_IOMMU_CMD_IOFENCE_DATA));
-- 
2.54.0


