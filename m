Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A54CD5BB1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 00:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQDO3-0002U2-P2; Thu, 21 May 2026 20:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDNl-00024d-9z
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:53 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wQDNj-0003iS-IL
 for qemu-devel@nongnu.org; Thu, 21 May 2026 20:04:53 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ba6485d219so50682705ad.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 17:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779408290; x=1780013090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lVQWbjWJNWGQBFqdKllYREvwvixFFOatWu8HImUdVmU=;
 b=J+8/P6qHEzCoF03i+i+M+rZ4oafwsRfHstOa1ExjPHeH3eFjdNgDkzMB35l234677x
 dtLYC8fWDc4q7gHZXKtYJQZSEqe7WVUsszPkzsidmlw6oDccS8Yx2srtSX3cd8y/LhCR
 c8wj8pfvhV4yH+iy9AIwt4nlGbieCd2ZPiOJQtHyTxmrgRsiVNIrFjvMD6NWgvz8PXip
 tuM6JkDL9JmdtWMiVD9LN0LyFmBo0vTSSNvRreHXGh3vW81X2Q4bXTcmD7DnhmuxruOr
 sMHiB/WnRapUlOpvA6K7iKfQ6M0TBMuzlebteaLMCiGGzKC1vczSgd+hyKOsMxCFQzbp
 w99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779408290; x=1780013090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lVQWbjWJNWGQBFqdKllYREvwvixFFOatWu8HImUdVmU=;
 b=qLgSR/IpV00lbeRbM94OOOPt0Q92geywpSREmCXgpz2ODbdizWSXoe80CHNJvqmcc5
 PTq+6HLa1fHKgvingE2b+lN10Wc2QmZNc2VpfhXI92bWtEPijkAsSi2y8CiRHWVxQMOK
 AuX6lBahyesk7P/vWYZev9uZpNcdvOWuMOeKr3xfATzB9CsxJVeT7aKa9mRMq2w/poUm
 5gIVD7jlsc/nICiTYwlIhUCCBH1DA1wkoldKXjY6C0OYQ0afSL4SkBMEK09PfNOlyGWS
 LmXPPw2amZD7gccntdGRqbw9KSKtqfmGbSIVixDRanF03LiDDh2oaHsbNzI9cjC/5ehU
 duHQ==
X-Gm-Message-State: AOJu0YwT+3PI1lX0m8xo2Mj0QcuOMqyioO02N7MKTB0zCzOJm/Fc7F8m
 Y8ve6+jVXmYM1hC0qJe2k7n4MDox1UzZPc4IPDMoKNmWu/zTRjn4HuYzOH/YxCif
X-Gm-Gg: Acq92OH31qTPBcItFunDkWAAKPF2uqpiprNFn4w9C9OUPu0lHX+CMGrvwRwgNgA3J5t
 Nh/nLmO/olLUak6W0K/1z4fIhUR/VVVxpYojo+2JasBEVYRchNxE6bJlQrf6tRP3eyEtF3iRS6y
 SFjwvTEEjts4lIoQzqsLb4NSEdYj2GFGghSNsDptfU368+KDaY6nTLlHMRYE+Ntikp0bAqykjaC
 rD00hnp6UVF0O9T3yShs8gs6T/hhk0msLhovncUBXIzqYvOzqZS0iFaXtdXbGJEBadFJTlliLNF
 jhjuPYKjYxoWHg8a9kxepsYXU/eJmuJsPqKc+3aQlMweVjfz7nzRgBtvzWrE88Nhq/NnkAfJQZQ
 HNybvNCn73pXRuKWLV6P1x1o//ZSU0HpjBEeEveL/Pr8jtylR30Cw12CyXl1pljp0BXNVxx1Hx7
 ONpZ9DFdeoxSeovS3GgQ+316LTEastPHTcU8gZe7TrWVlHeE6KWIyt
X-Received: by 2002:a17:902:fc85:b0:2bc:f202:54d7 with SMTP id
 d9443c01a7336-2beb069e6c7mr10573845ad.38.1779408289969; 
 Thu, 21 May 2026 17:04:49 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b54csm3915475ad.42.2026.05.21.17.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 17:04:49 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Zishun Yi <vulab@iscas.ac.cn>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 23/48] hw/riscv/riscv-iommu: fix FSC SV32 capability check
Date: Fri, 22 May 2026 10:02:59 +1000
Message-ID: <20260522000324.23255-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522000324.23255-1-alistair.francis@wdc.com>
References: <20260522000324.23255-1-alistair.francis@wdc.com>
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

From: Zishun Yi <vulab@iscas.ac.cn>

Fix a mode-to-capability comparison error in
riscv_iommu_validate_device_ctx.  The code was comparing fsc_mode (a
value) against a capability bitmask, making the SV32 support check
ineffective.

This issue was discovered and reported by SpecHunter, an AI-driven
architecture specification analysis tool.

Link: https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-iommu/pr-694/qemu.txt
Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260511080904.3049446-1-vulab@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index eb09cc9748..c9c64be24f 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -807,7 +807,7 @@ static bool riscv_iommu_validate_device_ctx(RISCVIOMMUState *s,
         }
 
         if (ctx->tc & RISCV_IOMMU_DC_TC_SXL) {
-            if (fsc_mode == RISCV_IOMMU_CAP_SV32 &&
+            if (fsc_mode == RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV32 &&
                 !(s->cap & RISCV_IOMMU_CAP_SV32)) {
                 return false;
             }
-- 
2.53.0


