Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471CCC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1P3-0007HA-Kf; Thu, 09 Jul 2026 22:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1P2-0007H2-Hx
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:55:48 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1P1-0008Kv-0X
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:55:48 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-381891a9525so615073a91.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652145; x=1784256945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bMKznMZ6gL3LxNeQ+G9+dAGW7UUVl5tn9CpFJDiEbjA=;
 b=CTOTXY28RvTVmjypV7J4wr0My4xFJbj2r2964rN4n/HocdkcAuC8w34m/xoimoMDCV
 fRV8TIiUKsdfitas+AUhbIk4UGPTEEQbnggoADKmJDIrKB7hpC4qnf5CL+GiwxkkT0E+
 0PJ6Lv1rNLV2WBxCTBZAr4heCVzkGtSVoq1/nQC/sFx01cAu4tvFh24T8blvLECzWg7D
 TUECaC8mUfrHMDGYhwaPFDzKKInFb6mP/gxghBYtVBNVTPgP21DKVlIjVT7qrZqNu6oo
 /mO2BsQ5u6f5qW/WAWPlCiace+UZzOc6TJ0TloRlrY6EZjvuWYH3YV6WHfM86XR3/lXK
 mClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652145; x=1784256945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bMKznMZ6gL3LxNeQ+G9+dAGW7UUVl5tn9CpFJDiEbjA=;
 b=WNrBNB2bzsrroWjla1/7obI8HLALBsj/wZovfZz+NuSFc86MFw+luj9AHqOuQZdlpV
 JJ/A2lsh4o6LyBE0Ex/QXHcDWytsnjHjJZZOhTjLg03UrO6hhwLnrCmO3FeMGGmTi0pc
 I9bS3V0Fywodso+E22wGNbMxM+1h4KfoR1xZ4Lls905JfU/53FNBkBbyLjuLGkmEn9PT
 MumLUYO//08T3CG+9m3W36K8BYBiGzbCFTwbenwJeyT8o+esHJUZhmRozQXBayQveIjA
 8r0HQ9I4pVjAzxl/1XEAfeOhOcJId2R2vN45QADjzvEE3IRmoUUTcLVKi2YQPaXGUH7w
 R/KQ==
X-Gm-Message-State: AOJu0YzLIDQaY6DDyeBoS8sETQ37QYFEItG5umYSRgfl3s4c56lVC78E
 2WD36BXHI8eucrvCDgdiV9B7+w+TFYd3KeE4hmM4LEmADyXt1Am6+Rg1oXUWwA==
X-Gm-Gg: AfdE7ck0IyDoQhSbtujQ5IELnZtjsCKFCtoh0vE09GltKT/gSK0jLrmirhxHExoyjOW
 ywIsxZXveN1hg8Uy59c/mW7SjMPu5hG9PpGZxX/BgyX6Pe9GxoSFFGvtCC3zZ86i4nWS7kStJ8h
 ZOYcHntPdb10PbRFm47Kp/uWNYRINqHSgjXJrCPtcA1UcPoSt5Z6siQKhtdx+w/qLbOkiojeObv
 fcjWbczvOIghOvsx/78/+qzNdnUxtt3BBADQVp4Z/3cRJaClp1siSd6VrMler6043JBddZTivng
 +/zopOKegZzA+1Dav8JZE5mogNX+/bxPpumWaYu+QZscTNQ2jHy1b0uy7SKnGk3ci9MzP6fuQbg
 2Z+aJl1KGcmEJRB3xVOhY8UF+YJoWRhQxrx7Z8Gs5UpjGgqikjfRlDTpoMv/Pc1iwN0aH4j4Lpk
 NU+HA7A7sSyg7kaMy+xhP3525pqSNu7ac=
X-Received: by 2002:a05:6a21:4cc3:b0:3bf:a4c9:b054 with SMTP id
 adf61e73a8af0-3c0bd0fa859mr11229985637.46.1783652145345; 
 Thu, 09 Jul 2026 19:55:45 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.55.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:55:44 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Nutty Liu <nutty.liu@hotmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 02/40] hw/riscv/riscv-iommu.c: check for reserved PTE bits
Date: Fri, 10 Jul 2026 12:54:47 +1000
Message-ID: <20260710025525.1704417-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102b.google.com
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

We need to fault if reserved PTE bits (60:54) are set.

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3554
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Message-ID: <20260701121111.537654-2-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 7f94ce152e..6665ad9f7c 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -469,6 +469,8 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
 
         if (!(pte & PTE_V)) {
             break;                /* Invalid PTE */
+        } else if (pte & PTE_RESERVED(false)) {
+            break;                /* Reserved PTE bits set */
         } else if (!(pte & (PTE_R | PTE_W | PTE_X))) {
             base = PPN_PHYS(ppn); /* Inner PTE, continue walking */
         } else if ((pte & (PTE_R | PTE_W | PTE_X)) == PTE_W) {
-- 
2.54.0


