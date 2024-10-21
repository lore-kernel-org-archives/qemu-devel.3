Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6EBD3C92F
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 03:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2iiV-00053V-Qq; Sun, 20 Oct 2024 23:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1t2iiT-00053H-QY
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 23:04:21 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1t2iiS-00077I-Ay
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 23:04:21 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2e30db524c2so2872189a91.1
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 20:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1729479858; x=1730084658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OC85d0frDAS81b2elFPZ4IbWeno0/3AB1DnlunqXg3o=;
 b=nfvjNjPb7mryHxQ3cxNb44aOtNDKpVDeo3w4DjW/9HLkcKXi/EoqgM1s+C4vW0EnZq
 db4u9KUKWH3x5mDysDaiv1FQVdYZUTu3xAseVtcb2Xln0GSNBcXR0vy4nrkA2R3hO6bF
 8fO08sERrkPvL2kDC3ytntfeti4hdZhSrYT17bfFxvn77fUuglW6RZ5XGMaane4BSq2R
 lvszqui4YD1QKkXpI+CsAAm8jf9fjzb4LGeBGuKHfkhXP1wbYTuJ1edyozhgJ9ApaCji
 9CiVrSPr0aVCuST9QVqnWMTKvcRnaNyyBCVUUh3D99+ZHhE4OrcxxX9XbPsaureq96Z+
 VMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729479858; x=1730084658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OC85d0frDAS81b2elFPZ4IbWeno0/3AB1DnlunqXg3o=;
 b=uzIuGB0j02q6I2Jt51MRon4f/zuOGyPi3jjthlVE2Z/iJR3L2NiQ6P02wkGmJ0kpW+
 bPVXqzPMhJLr5WMrkCIwfGUfBNlJo3kP9oi9oc6tSWGwjJrIfcPZ3fjraDkTmadRYLIW
 mpFHEWLf12qdsx33y0qUNsi4ZKFImB4Y6BJSd0NQRzvq518zWnBnV23KLfNWim7S+N1H
 R2UKLgusTIcYQ6OCWEoiJBTiwVc+Ka2qEiMBZe2lM31tcEXad0buO776Pg0rMFh5U/mN
 LbRDy+6IRwtVUbVs2OZXLawXYqkGDU85pPHXio0cXvs/coqfftNExfzLnIDOYGcauqDf
 Ko9w==
X-Gm-Message-State: AOJu0YyBRui6/QCEPn2GXijJK+9q6oHzJZfJYzHkGzTABa6yM4ca9RRh
 rg71gl/LT22xDPqWAloCchNB86pgvBOfIrbmrBqFhCik9OuXSv+2Gljloyp3w7MFbdF12gZUqbh
 zgBvAlbHhtMyDu3rPaX+jb4VV4tqYVIHBql979LYAcK/YPrlT7C+22at3bo7IyX7TJIYsIfXWdM
 w7/mV/vrmISUQY8SWBhcaumQmzLGBBsgYTf6gSHLE=
X-Google-Smtp-Source: AGHT+IGOwsDK6xMVXZgunPUv2vR/a9saaSFdR6tjScdRYodmV7KXVvfgCVtWIfsV8KyCGdP8VvlDOg==
X-Received: by 2002:a17:90a:c398:b0:2e2:9077:a3b4 with SMTP id
 98e67ed59e1d1-2e5616c3c91mr12354307a91.7.1729479858052; 
 Sun, 20 Oct 2024 20:04:18 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e5ad368b25sm2348846a91.24.2024.10.20.20.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Oct 2024 20:04:17 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Tommy Wu <tommy.wu@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v8 5/5] target/riscv: Add Smrnmi cpu extension
Date: Mon, 21 Oct 2024 11:03:58 +0800
Message-ID: <20241021030358.12454-6-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241021030358.12454-1-frank.chang@sifive.com>
References: <20241021030358.12454-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Tommy Wu <tommy.wu@sifive.com>

This adds the properties for ISA extension Smrnmi.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b3195da512..fed64741d1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -184,6 +184,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
+    ISA_EXT_DATA_ENTRY(smrnmi, PRIV_VERSION_1_12_0, ext_smrnmi),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
     ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
@@ -1502,6 +1503,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
 
     MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
+    MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
     MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
     MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
-- 
2.43.2


