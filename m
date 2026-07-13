Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC76FC44507
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 03:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj7iD-0006yv-Hl; Sun, 12 Jul 2026 23:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wj7i7-0006xj-RR
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 23:52:03 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wj7i6-0001O7-Ec
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 23:52:03 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-8485bd28dd0so2773157b3a.2
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2026 20:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1783914721; x=1784519521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O5v+4E6AH085JvEW/ulDh5E/YMq66y/1MyNCyiZh4NQ=;
 b=RILeWiiqtIPputgJSqsABtVIM2THiA00DoYnzNvM9uqlW0XBLc8szwplGHqvXR3R9o
 AlgJGjB2p5q2l5o/gAr+RBydt7NsPmKYpviFdTRvlCQ53HhqIaWiYgE3+uMg02kPYBwt
 7U2CRvqdM2LIfVy21IfCqqfRc54DF9Y1SSFrV5fqAQ+TipPOFiIeNB+rW+OetaY37Ynw
 8r10Sr7hIy97X2oBUre5CpQGa9iKPYSLt/AXXBcgkSTTyQ6XNhSADnjnYqNqN8HrrEL0
 fgxh0/nMWnNm+aS2eC2UA4DigLeFYtWuhOvoocgwc48/4rCLh5p8nnsnnu8xj32siqKN
 Q2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783914721; x=1784519521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=O5v+4E6AH085JvEW/ulDh5E/YMq66y/1MyNCyiZh4NQ=;
 b=IIvNUm+aNaSRPGiePB0kvA0ZrYTV8KWChEfEhc9AzOtHIp0L3HadYZqz3525dBiaxj
 e8plcaHexwv+GAghdLRv4TMjSqKlmLki1cn+fEAS5xMMbm6N0FVk+3ZRngdvR8i/xM5u
 VZ7aFPuGDy5UV0/0FQdmHsrWuIKRbU1+lQvLhTyc71/kcV/0ds7SiNIaltE42kXJsxMd
 yXjEFLo5qq/SpjdC3+5YHgLgimgiBP9JWO+qbbHu8GENA8ygAda1qpSNdqzWBUDKfKkc
 DRjUAcTyGlg/EPHbtXR7Xqt8C6zlTw8Xh/PVmQYd0nOLoFW5ch+kD/8W281YV4TXOtbj
 WmyQ==
X-Gm-Message-State: AOJu0YxOtnlzcep7e1Cqq+R5tK9+EOJDw7qw/lFLa75xE4vY09karTCP
 fkIpVwmsWiPl/Suf9fkqcdLHO6FV0KQZ+f3rpOTpiHLMLsEjfyP37D/AWCRuCpE8WBicNEUk0zr
 TK+SJcQe/xSWbj0VfaVilxSNuYExTqx1Zb4v5bKmSb2bpBPYuN5jiJ0LwDGRmmKX7oLFY14/eN7
 QsUqIgBDlIf33Og3qemR1dwFhH9fb3NwfAXdcpSh9Bo3v/vpmN
X-Gm-Gg: AfdE7cndMafaGFL7MjdJ5CBsnsOd+aw7oXbHaQV783HGzV8X1gN3byZLNag7nYVYw57
 2NXHeFY6iifHKuQnN5GkpW+lbu7IwIZiHQvf+Jic9cGhdZpd15rcyzptgDzePVfWPKPR3GjuRhe
 rr5W3snDQcVHiTyDuaVLL8ofN1sFOInLNtao7/DqzMIRPOgFlOgCHgAfOA1rVqkfAYnN97l5LSK
 43eSfCiF1cj3tgsxF6xwFuqOsJ/yBoaRH8/YPuQv0/2zuPLzcG2Qk54YztH8CJaqlmqaIgjGmym
 6A/n1IRG8LUt92V1K3D09vx4Mn1tSOyPaWqKkT9dKeP/JIRoF/VdwJ2MHwbrYIp5mUi/U1HaxED
 p5ih9ZVIp6TPz5g62Imb4FfxBVsVPK+9rlc8cmMg4neYdnwkImcNzIhnw8Vt+apPLRIzixDrnky
 Njt8ZnE2P4LjfbJOH5jqTNfqnYPpJ3uXn+VoDqVy8=
X-Received: by 2002:a05:6a00:6c9a:b0:848:2f73:9000 with SMTP id
 d2e1a72fcca58-848897b5315mr6807930b3a.73.1783914720120; 
 Sun, 12 Jul 2026 20:52:00 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5b3162d3csm7739884a12.18.2026.07.12.20.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 20:51:59 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v6 6/6] target/riscv: Expose Zicclsm as a CPU property and
 update RVA22U64 profile
Date: Mon, 13 Jul 2026 11:51:35 +0800
Message-ID: <20260713035135.3996990-7-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713035135.3996990-1-frank.chang@sifive.com>
References: <20260713035135.3996990-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x436.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Update Zicclsm ISA string and expose it as a CPU property to allow user
to turn on/off Zicclsm extension.

In addition, Zicclsm extension is mandatory for the RVA22U64 profile.
Previously, Zicclsm was enabled automatically when has_priv_1_11 was true.
Now that Zicclsm has been converted to an explicit CPU option, it must be
explicitly added to the RVA22U64 profile's extension list to ensure the
profile remains compliant with the specification.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7ee89f6fc4b..19b93f9c979 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -164,7 +164,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_zicboz),
     ISA_INTERNAL_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_INTERNAL_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, has_priv_1_11),
-    ISA_INTERNAL_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
+    ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, ext_zicclsm),
     ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, ext_ziccrse),
     ISA_EXT_DATA_ENTRY(zicfilp, PRIV_VERSION_1_12_0, ext_zicfilp),
     ISA_EXT_DATA_ENTRY(zicfiss, PRIV_VERSION_1_13_0, ext_zicfiss),
@@ -2237,6 +2237,7 @@ static RISCVCPUProfile RVA22U64 = {
         CPU_CFG_OFFSET(ext_zkt), CPU_CFG_OFFSET(ext_zicntr),
         CPU_CFG_OFFSET(ext_zihpm), CPU_CFG_OFFSET(ext_zicbom),
         CPU_CFG_OFFSET(ext_zicbop), CPU_CFG_OFFSET(ext_zicboz),
+        CPU_CFG_OFFSET(ext_zicclsm),
 
         /* mandatory named features for this profile */
         CPU_CFG_OFFSET(ext_zic64b),
-- 
2.43.0


