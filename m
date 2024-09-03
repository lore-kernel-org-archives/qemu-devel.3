Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A17CA101E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 06:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slMoa-0005pZ-QD; Tue, 03 Sep 2024 02:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1slMoR-0005mv-QX
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 02:14:47 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fea.wang@sifive.com>)
 id 1slMoQ-0002GJ-Ax
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 02:14:47 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7142a30e3bdso4271244b3a.0
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 23:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1725344085; x=1725948885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wR1GACgrZzM7YYzeZtxjDqa8lje9TmssIu2+ZZwLLUw=;
 b=WB6HxnHTIqMvpSEwd18xTkuvzGbBYCHALt9NV5uUrxMoX0XUj+GjY07ESuRXBNe0D5
 oC/nKN/CHBf2a89Xf4U0PoTMaUOVJMmFPwdCJ5cz38M5wZ9/FgN6N1XsG9R1VQ3YAWKn
 hQGUHZ7qMPQYaLTSACjCXr8jKfI9ZNXuk2vl8SWW27SzvcqL3l2EGcI2VHzOZc9HzsKr
 jiUBWyVjAYieEoLYfCAtoB3fEA2XlZJvtZU+Ld+aQoj+jztWrEQ5rZvaLEb5Uo+5nikq
 p4gCtehLuJLTQZApGtViP87GGXyP2PNFDfN74pS+bPPceCugNSDSDet8t/vqHzBio3qT
 NwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725344085; x=1725948885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wR1GACgrZzM7YYzeZtxjDqa8lje9TmssIu2+ZZwLLUw=;
 b=SSH0btEA1DFTnvNBjIDkrE2QRJOzdtkKx3zTUmk2UsWSrbXz3qCmqydbtGrfRGkw9Q
 BpQGY8e1w6UiBbLy5/nrgbNUo58SmO2Z5ER29KmfjAAEd9XP370nJ0BG/tWJSsG6qGL/
 9S6VmAUoz7PS4QrssC1iMBW59II9RGveNSuDZL2XH7Qy4Ux1bwn0l4KtvLZzkGH5BUox
 rZcUOtl42f7LMBMwCsh08hEWX4VR+USFfWtCXz6hh1uD90O3l7h0yoTRwN1U6lukNSgC
 TD/GFIrCz0Zi2JSvkL+L1Zxkz2hs3g8Xdcg1gssvw5xBi9Hx7jYVYBHrQGLT/lMBcRfJ
 rpBg==
X-Gm-Message-State: AOJu0YxS1N/3W3TPkW6qwqiP17COH4dLg86Ws5Rm8Mda1KysCSVMe8s+
 d60IBlMTczkior8KVG1Y6dvk1Snp+ejvAjJxOgRA2GkgNnCM8heC5B7GXVyoidWDIxMSorXcJcn
 X4A+HT0D5s8ab4Zj86Ac1xTdcnzCvXYg4Q3/bVL0zjM7Wl6azoCFd3Gsf1IEBJpswnGOVVeTbEX
 NCWlMFV0KmubRPG0ydC0D32n1wS/4VneCELeY=
X-Google-Smtp-Source: AGHT+IHnrqov/tdCdxu/H9D4C2PmIbQlFgcZjWjC/5cJOCXrVSACI+28gYp7QCRK+CCzgoZlqmfGtg==
X-Received: by 2002:a17:902:e551:b0:205:753e:e2e6 with SMTP id
 d9443c01a7336-205753ee47emr102309515ad.16.1725344084629; 
 Mon, 02 Sep 2024 23:14:44 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20524c16145sm60467145ad.98.2024.09.02.23.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 23:14:44 -0700 (PDT)
From: "Fea.Wang" <fea.wang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Fea.Wang" <fea.wang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 5/5] target/riscv: Expose svukte ISA extension
Date: Tue,  3 Sep 2024 14:17:57 +0800
Message-Id: <20240903061757.1114957-6-fea.wang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903061757.1114957-1-fea.wang@sifive.com>
References: <20240903061757.1114957-1-fea.wang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=fea.wang@sifive.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Add "svukte" in the ISA string when svukte extension is enabled.

Signed-off-by: Fea.Wang <fea.wang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fc3f75e826..a568194317 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -197,6 +197,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
     ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
+    ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1597,6 +1598,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
 
 /* These are experimental so mark with 'x-' */
 const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
+    MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.34.1


