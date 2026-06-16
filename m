Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04495CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQjL-0006JM-83; Tue, 16 Jun 2026 06:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQj3-00060R-NG
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:08:58 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQj2-0003k4-06
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:08:57 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-36ba706ab46so2774175a91.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604535; x=1782209335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LC8Tp9LOlX1iIxsS7p263aBjVp7XomH0anhd7+QMmbM=;
 b=WZbtRBO44CxxTWSOoL/EXKbXJVEExtxI61LHHDKQ2iXWdSHfrkCZ53yfW5nRy3wswG
 wLmKcmELsfGouUCNRh0/Gsq6EIxD+cDOOdKdRTHa8XMo/7uWV/oQ7YpAtezs6pgEHMxF
 nc4SWwayEyH51FHVftZt0QfGcaMT0CyiEhLbKgVUStGVfCoOwk/LJugPn2v85nauJz9W
 0iDaZkP2lplvOY5Fa3+0FqySr+LkSU05vh20ArI4Ay+5YNaxg4SNnUUToXxAhl1V3SYe
 6806+of5kIy58DI92Ke9MdTrxf18uZe4RAyLE6yud9hzPA1Ojb6yELa5qfs7+jcQEf5z
 NjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604535; x=1782209335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LC8Tp9LOlX1iIxsS7p263aBjVp7XomH0anhd7+QMmbM=;
 b=tTOhQPlgiiPVI/A8PtXrIMoQKEdltF8KBDEr8qWk1+8ooQwDW5A1Y/6bZXvb/PPQ5K
 6xUeDVqhXF0c4D/Ci2W5Q+Xb7uwAtAyDZROtEloM3s0X0xEt6k9A0XMFgIwtmPTswuc6
 FJDeG10RlTz8pblgaKItD73GBR4QjzQ+07lJd1LxQ6NWrbcCALYR/ZxEfvX3iEdHUiRZ
 WBtkdqPJJDEn+nMdQEG3pLvMhIpcuOO7T5eBhgClmRsRQDWbWh1xzNL1xcZktrLFTqGC
 O9eDz3ZtbNKrPzUSZgK6KIXOgGHqTIoDp6ooMrsi+gUwvmAgUWlbiH1Qp7OwtVIUVJka
 HdZw==
X-Gm-Message-State: AOJu0YwAmTlofLNfsgQM8LTbI3NLC0f1XGvDmKpybwxgdebMO62bgkV3
 jmvQaIF0Emq/G9W0f0V65ANMhzmJ5pbuuJoK8Zb/JcunPuZfoaVHNvxua649VVyr
X-Gm-Gg: Acq92OG1NyH9v61d+w2Vz/cFTOF8d0p5DbGf4q52ohEy0gNUV5yJoq5BM+LhftA6Dpr
 8UFt+D/QdIwzi4GgOyck+KUDmPqk3i0uou5YKS+AbQoer980lAEeIsbD6xfd4hSkh0HFKQQ90fP
 tL1/MS9o5Aka7KHvvdd8QcL05VhVAZotvM1BtN29/RZ8CbsYU+clGibCmd3GWfY2l5m19f9WcJ6
 2WACxwZBhPjMI+vunUImvxmYKeFEcK1KuPxLyBUlYPquIww+XFGcGZQx9yoxL+vCvJCDhufRqUT
 e7woVpNpBRA0t3UMwxg5uH21lUDgjkHdi3kE6J9CpQQPRukyiHRSXIHUiWDCbrPjbjJa9kRNvt+
 y2NHDSXpnr7wuXTWIuMW1C/i8uzuPVCM1EvdK+4PzK8oYhUkFG33PR780fHCcsTdg8DUDjUSO0y
 2Gl5fyYmUVcm3qdYH8Crrh/eA1kamMd9ks9c0hOX3J
X-Received: by 2002:a17:90b:4f88:b0:368:5367:d679 with SMTP id
 98e67ed59e1d1-37c5284102dmr3014066a91.9.1781604534720; 
 Tue, 16 Jun 2026 03:08:54 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:08:53 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Abhigyan Kumar <314abh@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PULL 57/83] target/riscv: mask vxrm csrw write to the low 2 bits
Date: Tue, 16 Jun 2026 20:05:00 +1000
Message-ID: <20260616100527.1939565-58-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102a.google.com
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

From: Abhigyan Kumar <314abh@gmail.com>

Citing the RISC-V specification:

    "The vector fixed-point rounding-mode register holds a two-bit
    read-write rounding-mode field in the least-significant bits
    (vxrm[1:0]). The upper bits, vxrm[XLEN-1:2], should be written as
    zeros."

QEMU wrote full value into env->vxrm causing read of upper bits too.
Used existing macros for bit-masking. Previous had a hard-coded value.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3470
Signed-off-by: Abhigyan Kumar <314abh@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260530102100.78150-1-314abh@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 19d5a55b54..ec931a8c3d 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -989,7 +989,7 @@ static RISCVException write_vxrm(CPURISCVState *env, int csrno,
 #if !defined(CONFIG_USER_ONLY)
     env->mstatus |= MSTATUS_VS;
 #endif
-    env->vxrm = val;
+    env->vxrm = val & (VCSR_VXRM >> VCSR_VXRM_SHIFT);
     return RISCV_EXCP_NONE;
 }
 
-- 
2.54.0


