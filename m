Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8DBC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtjQ-0000yu-26; Wed, 19 Aug 2026 23:46:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtjN-0000wh-Rq
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:17 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtjL-00042k-U0
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:17 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso2755108a91.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197574; x=1787802374; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pvkNgzPBnkClRwc9O5eyz1kkZLDtZhEMJDHTwwC8vGY=;
 b=o500PZZQsMbtAX+JO8MdDd26EvRQ0d3DkmmvAY/H2tBZ43fqxDBE6gER4zQqcWbRCE
 JI36s+Q31J1SvAodqlTljoQXNMjgAjQIzU0gZFnxu/VExJDEdzbQwNEWox54Y3vaeUV4
 hBYufy89tvo/al6U+3MwqbgSZC18yvtR3OaDTQUMK83+Kou4qgbs/P/gT0SSs1AgHZN0
 BGjXhA/XiitrkS2DP+XlyU/bKQPgb6hKPN0cHzHwkM9SrQfhPNgaXiHebrppcP0M9xEG
 h5jdx5SQiI1an3VIlmSl0jP0ODmvPhhLKXuUr9zszvjNGXdd7oG7xWlmTynq5MmJnUa1
 FqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197574; x=1787802374;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pvkNgzPBnkClRwc9O5eyz1kkZLDtZhEMJDHTwwC8vGY=;
 b=TzGG631ue5kxe5DG+1wCFTGS301L2FwF8ZfKQZ97JOzauvw/gqMknYWyz1x6/i6kC5
 RykE+HCuIeUyNa6MkgNDTF3OOD1qhLibbXm56+2MzdiSba9Fp+KfRXrZ8eFv7i54o1Ak
 Ad/ZdX3sw+lkkWCIplge2zORNTsfvQoMTNqTvyNu0Ilfm6NcSpJLY+YZ95mN4iDmIVJ2
 Ay4/1kaeFESaS4Yqb7WHPI3X1mblUHrvvI2MgZIFTmPP1JYuOIBxAUH9ecTxh+ojplLR
 BVcCSW0Q8YqGJdysT86EtbxFT9wBz3/9YtVpw8dPjNBq3mRr3MFtOyg0a0I2noDIn5xX
 atDA==
X-Gm-Message-State: AFuF++nL1k9pVi4G1DbTR4YH5TqaJ7q1lseyrRz304J6fLh4PRsygpvp
 /scfdq8I9ByjWJFSjQ7+ohb832It6YpXArB4JugMONXGedDg6Jad1QvgbOFzhg==
X-Gm-Gg: AR+sD10VWS11YlVMea52HcmV2oo/O/eAmykhK4ShHROcA6EF5qHsE0cnLV4HGKru23l
 KHkPXNXc3ntaQu3CFS+CaJaakUGnMk7ZthYI43KE639cGjdtM83S4yX6+ww5dEc6D78eHfrmYpn
 ai7+8wfAaHKmwtv8Wp8UZHg+BAYkoSWvV0TqM9UAkCv3ela6LXVdC8NjpvjbC1S10gdCTa5qIlv
 aNZHWp+PXpLEgcREx6ct5fA89ZY9KWIv9lTmYh/PnpqE3XsVlPFFRrbhzOCxKPrVs8dyj8B+Hyw
 OkypZ1eWFKc9Dudxk1R0+SYzjhuCAX8eUBXvbUmO4dXBtXuAk/rY7zILNBY+tHc4S02btTl6iWK
 Wq6L5Z4PN5it2GEqaw3WnSlVGbcCsuhM/on3x/CZBLi7F3NPW8pyOHudWIehoC6tKLnx/FwjWQT
 RfGcmiah8QFS7RDmuHu8w31bD4WpJHG1SyQLZ7+7R39d1MQEOUFhe+01+wJxbpFVi4EpxniscZG
 sXXXA==
X-Received: by 2002:a17:90a:fc45:b0:38a:c3f:3b87 with SMTP id
 98e67ed59e1d1-39580f6d136mr18847912a91.12.1787197574502; 
 Wed, 19 Aug 2026 20:46:14 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.46.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:46:13 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: TANG Tiancheng <lyndra@linux.alibaba.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 30/93] disas/riscv: Fix 6-bit immediate extraction
Date: Thu, 20 Aug 2026 13:43:27 +1000
Message-ID: <20260820034430.1186695-31-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1034.google.com
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

From: TANG Tiancheng <lyndra@linux.alibaba.com>

rv_codec_r2_imm6 is used for XThead instructions whose 6-bit
immediate field is encoded in bits 25:20. The old expression
left-shifted by 38 and then right-shifted by 60, so it kept only
bits 25:22.

Use extract32() to decode bits 25:20 directly. This fixes the
immediate printed for th.srri and th.tst.

Fixes: 318df7238b9f ("disas/riscv: Add support for XThead* instructions")
Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260703-b4-disas-xthead-fix-riscv-next-v4-2-84c566330bc7@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 7f1b262773..fdf75a12ef 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -4546,7 +4546,7 @@ static uint32_t operand_zcmp_rlist(rv_inst inst)
 
 static uint32_t operand_imm6(rv_inst inst)
 {
-    return (inst << 38) >> 60;
+    return extract32(inst, 20, 6);
 }
 
 static uint32_t operand_imm2(rv_inst inst)
-- 
2.54.0


