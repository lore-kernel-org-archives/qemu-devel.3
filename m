Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33877C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 11:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riYAR-0008Q8-Fd; Fri, 08 Mar 2024 06:13:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riYAN-00083t-T7
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:32 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1riYAL-0001ij-Dr
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 06:13:31 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1dd4bc7a87aso3331465ad.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 03:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709896408; x=1710501208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7LHlSEt3nIHxiJIJ/8DN83IHqazhaKxxga1sDtvaf/s=;
 b=KJS9fmSvNCUzN7+v03c9SEGTC2LmYtIcXKDaVoPOOeiztOqiqcZXPX3V77FClA8JHx
 CrciaYFxPsQvkgIS1iHeOn988YCeLuP4Y2zAhpiZJngakylboJaiIl0CJHTVpzY6lZ5h
 eJRDRkZ87qUVQ3YW9l2jXI5Z1+TX++j2rX5J8CWq6DnpmOxv/adig0pr4gjvL42fJ9/q
 3sS2cn8Y1ALDZqjDZfHXM4w+SF7bNsSMhDZ8TCDGnL8JkQvUD+7YrKxJWLIv5d+GjDf4
 /RGXr+FWgvOzf6wcYpakmlFpn7QQi32MJ9XNENBjns06e3iyrHp4pp+845ldDlhRUMlB
 tUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709896408; x=1710501208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7LHlSEt3nIHxiJIJ/8DN83IHqazhaKxxga1sDtvaf/s=;
 b=CYz9jtj6v8gxDc3y3LYOS2enaEWiRbSMbiHkpTFnvPnpPS9kDfMFOIoP4yYaQt7EWY
 QNuN7sC1T5Rpc4yJ7croXKQWVVFmGngCMz+S5AI9zKgmcDhS8d3pLE8qyQctBAJgA5T8
 dLIx/skEAx9eJnoUPD4sfTkfo6KAHFzDRL8Qwb0hVvg+VA8wl06MQO5jGDgJVks0JJdD
 Nw530QZcUE2OJmI5c1zwe+NYFf9n5hGZErrifxeEZf4z/vjMAcV8ceMF3IcGZjxBIru4
 1R5lxRK4ZD29TCKagWaMovYffRnUUBBHIq04kK7mLLBdpP9D9N4cFLba0Xlnfp6mQBMG
 cKmg==
X-Gm-Message-State: AOJu0YwfOQW5/8Kg0m5A7crLZMP3ugdzyc58ZNiShx46Sm4bGaS2m+UA
 HlmXwZnDyQBxCcseWt892bYvgZ+FwhfDqLXcw8lvAHlo3A5tiAdCRpVn9z4+F6EXgw==
X-Google-Smtp-Source: AGHT+IHEA6MwveUMos7kfZO3w8mFvCT+bOBB4taN5KcMRXI9tKbBn00uH+TSK33a9r5qANKlq3+iSw==
X-Received: by 2002:a17:902:e804:b0:1dc:93b:8981 with SMTP id
 u4-20020a170902e80400b001dc093b8981mr14107920plg.14.1709896407871; 
 Fri, 08 Mar 2024 03:13:27 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a170902ecc600b001dcfbbb1ca5sm12006468plh.35.2024.03.08.03.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 03:13:27 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 26/34] target/riscv: move ratified/frozen exts to
 non-experimental
Date: Fri,  8 Mar 2024 21:11:44 +1000
Message-ID: <20240308111152.2856137-27-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240308111152.2856137-1-alistair.francis@wdc.com>
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

smaia and ssaia were ratified in August 25th 2023 [1].

zvfh and zvfhmin were ratified in August 2nd 2023 [2].

zfbfmin and zvfbf(min|wma) are frozen and moved to public review since
Dec 16th 2023 [3].

zaamo and zalrsc are both marked as "Frozen" since January 24th 2024
[4].

[1] https://jira.riscv.org/browse/RVS-438
[2] https://jira.riscv.org/browse/RVS-871
[3] https://jira.riscv.org/browse/RVS-704
[4] https://jira.riscv.org/browse/RVS-1995

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240301144053.265964-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 37425e0e50..5a48d30828 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1464,17 +1464,26 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
     MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
     MULTI_EXT_CFG_BOOL("zacas", ext_zacas, false),
+    MULTI_EXT_CFG_BOOL("zaamo", ext_zaamo, false),
+    MULTI_EXT_CFG_BOOL("zalrsc", ext_zalrsc, false),
     MULTI_EXT_CFG_BOOL("zawrs", ext_zawrs, true),
     MULTI_EXT_CFG_BOOL("zfa", ext_zfa, true),
+    MULTI_EXT_CFG_BOOL("zfbfmin", ext_zfbfmin, false),
     MULTI_EXT_CFG_BOOL("zfh", ext_zfh, false),
     MULTI_EXT_CFG_BOOL("zfhmin", ext_zfhmin, false),
     MULTI_EXT_CFG_BOOL("zve32f", ext_zve32f, false),
     MULTI_EXT_CFG_BOOL("zve64f", ext_zve64f, false),
     MULTI_EXT_CFG_BOOL("zve64d", ext_zve64d, false),
+    MULTI_EXT_CFG_BOOL("zvfbfmin", ext_zvfbfmin, false),
+    MULTI_EXT_CFG_BOOL("zvfbfwma", ext_zvfbfwma, false),
+    MULTI_EXT_CFG_BOOL("zvfh", ext_zvfh, false),
+    MULTI_EXT_CFG_BOOL("zvfhmin", ext_zvfhmin, false),
     MULTI_EXT_CFG_BOOL("sstc", ext_sstc, true),
 
+    MULTI_EXT_CFG_BOOL("smaia", ext_smaia, false),
     MULTI_EXT_CFG_BOOL("smepmp", ext_smepmp, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
+    MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
     MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
     MULTI_EXT_CFG_BOOL("svadu", ext_svadu, true),
     MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
@@ -1563,19 +1572,6 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
 
 /* These are experimental so mark with 'x-' */
 const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
-    MULTI_EXT_CFG_BOOL("x-smaia", ext_smaia, false),
-    MULTI_EXT_CFG_BOOL("x-ssaia", ext_ssaia, false),
-
-    MULTI_EXT_CFG_BOOL("x-zaamo", ext_zaamo, false),
-    MULTI_EXT_CFG_BOOL("x-zalrsc", ext_zalrsc, false),
-
-    MULTI_EXT_CFG_BOOL("x-zvfh", ext_zvfh, false),
-    MULTI_EXT_CFG_BOOL("x-zvfhmin", ext_zvfhmin, false),
-
-    MULTI_EXT_CFG_BOOL("x-zfbfmin", ext_zfbfmin, false),
-    MULTI_EXT_CFG_BOOL("x-zvfbfmin", ext_zvfbfmin, false),
-    MULTI_EXT_CFG_BOOL("x-zvfbfwma", ext_zvfbfwma, false),
-
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.44.0


