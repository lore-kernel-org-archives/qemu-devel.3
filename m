Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D98C02185
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJsq-0002h0-Hm; Sat, 18 Jan 2025 20:13:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJso-0002az-3E
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:13:46 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJsm-0003FH-CN
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:13:45 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2f43d17b0e3so6125633a91.0
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249222; x=1737854022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wSAD1j708buAVXbbTj9KkPqf9zo6iZ9nlQUceWoK8SU=;
 b=djoGPFGSf+zG9G4tdrrFCaHQKrq0+S8YJoxCQCvCANRrBoiON+R0PmzChuPS+RgdPM
 UacSVcNIH4LprOoPpHywBbQtw47tPrOsRn8OnuoyewdZXs2oWacae1TLPhfdcjIGGkx1
 TDgC5SZ7q4HoEKCyTULDvV5OxVTWOsrUaJdcUSZWCayfQTkLNFToQVeDc/7nZPf9WL6n
 VHG26ICArNfMeGeILD5GYVBTu4cQ3t47g2aTj6cProJbj63pPBJBzsrkmXk7vSvtvaZ5
 PXDlyu00mpkXcUaafWuM2kJntlmGFfbynZn2Uccu6butnSsClnKfHwOVGgptYHEIjUxX
 mV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249222; x=1737854022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wSAD1j708buAVXbbTj9KkPqf9zo6iZ9nlQUceWoK8SU=;
 b=hYJY8voacXgyUGbKa3ZueGdLUO7VkKZB5OFVDK+ImSm1IXsA08UH37mYZkm797iTzJ
 LNg/BxU4NS+o9CLLUQdT7YYOIykooCuNCDvY0XnhwnR8vuYjSFL/YI4Vc8W2mM7gD06n
 5EtVyDw2Mk5L3l2yllTiFgEZxtK1hnLxg0hJ2gVnzEIGytQbm6JKd69thKOeoM2OEU51
 3g3gEuzyxsbdfk4uaADaziTbLss6bbhfmvRh1j8cKbvH7uZRL+bfofcUC2ZPkSbRrALV
 +QJyM8ycfUrG/YLVX6rN/IZ4YMgTH8dvMavrEGu2hjSQbznrahNL7feAD9KVK9TkcVeg
 1bIg==
X-Gm-Message-State: AOJu0Yz0FAjwgRkMT1NhFTRJ2h4z+bY4qX9vyWYTUAlSocx9hY5WkN/Y
 8OscK0Z/WCbLnPLz2KSRnn0pDSE+4MWJFw94gP6VVpwwiI9jRuR9EnMaIBJn
X-Gm-Gg: ASbGncsNViQYic5cw2NuSePaE6sxqwlcaAI0fiyC7Jdclv1U0QyhQByzwQYUWNTZPvN
 MmvEWywm7CnqV7mSFZ2PXcAQFKeVC6eUlV0N+6mroB+EpQGqoJRtYMCPuIC0fx2/mx5Z/8NcQmE
 lZHv85on5zG6NTepIfHztawzEYTBTfGXW4qVsgG0pNPDviyEHomJflN7NTKuRd1zE0UqJ2wnuzt
 iT9/9QM9m0nriNnoB1XNtQdD2tKtOf+VpOiuBwsESJGghG7rWAwY/BfFZuWrcpXMELyyqep0kaU
 FQrC4w1rEC+ZodPY6+V26hS2K5YIF4kqXjIrdvlsnJjaKtqwRGQXB8GWrx+jjJizIeE8WAZfbQ=
 =
X-Google-Smtp-Source: AGHT+IE9ZPjRfbwUezQEuOFNBAGXCHo5umD5rdnxopQvdztvduTf4ZqP0QxtNJ85XaR4JZE3uR7eLg==
X-Received: by 2002:a17:90a:d004:b0:2ee:8ea0:6b9c with SMTP id
 98e67ed59e1d1-2f782c9404fmr13944403a91.12.1737249222498; 
 Sat, 18 Jan 2025 17:13:42 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.13.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:13:42 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alexey Baturo <baturo.alexey@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 19/50] target/riscv: Enable updates for pointer masking
 variables and thus enable pointer masking extension
Date: Sun, 19 Jan 2025 11:11:54 +1000
Message-ID: <20250119011225.11452-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
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

From: Alexey Baturo <baturo.alexey@gmail.com>

Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250106102346.1100149-8-baturo.alexey@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 99588e219e..d9eb2c04c3 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -193,11 +193,14 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
+    ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_13_0, ext_smmpm),
+    ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_13_0, ext_smnpm),
     ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
     ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
     ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
     ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
     ISA_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0, ext_ssstateen),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
     ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
@@ -1595,9 +1598,12 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zvfh", ext_zvfh, false),
     MULTI_EXT_CFG_BOOL("zvfhmin", ext_zvfhmin, false),
     MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
+    MULTI_EXT_CFG_BOOL("ssnpm", ext_ssnpm, false),
 
     MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
+    MULTI_EXT_CFG_BOOL("smmpm", ext_smmpm, false),
+    MULTI_EXT_CFG_BOOL("smnpm", ext_smnpm, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
     MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
     MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
-- 
2.48.1


