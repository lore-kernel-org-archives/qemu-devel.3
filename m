Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79454CA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 07:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl1Gf-0000My-4u; Mon, 02 Sep 2024 03:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1sl1Gd-0000FA-E1
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 03:14:27 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1sl1Gb-0003jn-Nb
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 03:14:27 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-70f794cd0e3so904884a34.2
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 00:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1725261264; x=1725866064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=riPnYasURW77Dz2ZwVlvtuzpt5ZqhwUi415BFr5uQMs=;
 b=anjql5FnY67JEJxldqez59aBrRrUtw/FPrUkIDAq73qOdqVfTCfmx/2A2bpmgLBZas
 cX2XO9k45RPpqjsDfeBwCyDH7gKJamqVPTuRRYF3TeAqRvVeUqXF/vQQ6e7X4gxdxW7A
 KOIWbyUICPZxP+XfHp2WYU7CSnfgg1GMKXUUCqB6cHu7eYfdadKCaAV8fOkxkslK3lGE
 HMKe9mJVnDGw5/Af7peSVZzeMipXMw6pN1DHlnrgGJPlm46xKDtDMXl1jT+f0btrr1X7
 quHBp8W8MW2B09CxSVP6omjcwbp1WoTCW5wiM7TsKv8kzRNqKZfyZk/M06hAE2rW3F3z
 mxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725261264; x=1725866064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=riPnYasURW77Dz2ZwVlvtuzpt5ZqhwUi415BFr5uQMs=;
 b=oQIVWQwGnk2c1u8oc4jBSYU3Cx1LzxjdVkG86CFWU2G9vUHlL9tw/J/1T1665Ls+W+
 BZCZw+sJDdXeGhGkLY6d+IFOCQlT2ehhgFSNhJ9jcYrfon0M9yGMEKsbAB5CZRwfhl+4
 TQ0I3fy9B1R6lOCQTBmw87hMf2CymSWY1ZN9e5xtMmicjffxMzNheFmgI/5joy9ALLtz
 1bCwyY9tkXiruD5KtH7p4zc7uQIILY+NqwZ+7V2Ka+MIU7ZY8ULDi0JaDDp7Tr/dAH5I
 I6IxVN8aDn0unhO9UCU2Oogro2Y96NFBvvpAiSe0vYCjIczY8pg7xtL2Nh+wCvAlz1lo
 UTMQ==
X-Gm-Message-State: AOJu0Yyv6iotfn5Sxk0+1NkTLqyAzMaiglj6imfzjdHHsQKi0MfOJtPw
 v7Ylfrikn8Xmg0NtS0R2uqcPY60F//qdfqp1e3yZtwLMsdzVr8WyjV9LTSiypM6gzDkD6nIDR4X
 OJ28FZoa6F4adM5I93pH1ieX7osacnOYvp7DPCF6CGd84EOIsKROU6ULo0mbdL65RQolBROAuWT
 k9qk9zLuCn30Gf8PVI9dMYsA5vAxFWO29UPUw7HA==
X-Google-Smtp-Source: AGHT+IH4tkb5Oexhex8sbALS925W99zRTLH9z06Uw6RGuEFR9ffyy37i4nulFobaPOnCbVvlKieyNQ==
X-Received: by 2002:a05:6358:88d:b0:1b5:a034:4713 with SMTP id
 e5c5f4694b2df-1b7ef352898mr935257555d.0.1725261263712; 
 Mon, 02 Sep 2024 00:14:23 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7d22e743252sm6793331a12.15.2024.09.02.00.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 00:14:23 -0700 (PDT)
From: Tommy Wu <tommy.wu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: frank.chang@sifive.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 alistair23@gmail.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, ajones@ventanamicro.com,
 Tommy Wu <tommy.wu@sifive.com>
Subject: [PATCH v6 5/5] target/riscv: Add Smrnmi cpu extension.
Date: Mon,  2 Sep 2024 00:13:58 -0700
Message-Id: <20240902071358.1061693-6-tommy.wu@sifive.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240902071358.1061693-1-tommy.wu@sifive.com>
References: <20240902071358.1061693-1-tommy.wu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=tommy.wu@sifive.com; helo=mail-ot1-x32e.google.com
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

This adds the properties for ISA extension Smrnmi.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 98e6940e93..7ee7b9c4ee 100644
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
@@ -1514,6 +1515,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
 
     MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
+    MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
     MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
     MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
-- 
2.39.3


