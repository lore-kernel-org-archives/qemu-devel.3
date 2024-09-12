Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0032FEE644B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socRm-0002P8-K6; Thu, 12 Sep 2024 01:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socRJ-0000cP-F5
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:32:31 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socRG-0003BH-Vp
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:32:21 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7db12af2f31so572311a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726119136; x=1726723936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1OZtUQ3CFcWEdjE0VCal/gtVrOv/C/IET7Ot8GrKz+4=;
 b=CeSVFWOcB1opvsk9a70AkSaaTkGY+PGoJkw+J2kRj7R/CO7gxPtX4YEnAyLjJr2rSU
 TvHcv16jAEKLhE+ufLeXixvX5QRItXwXjf6BtTzsxHKHCq+wNYoSm8pik5fB8HeNDlFt
 12/9/RfnBSJBm+AedElOYvvihIJdk3sOpnrhjAj16GaI+AoXIMJmzdkLIxQJXHpyCvFN
 EEBeJRwFhGLT4azoWCTKr0EumkAVM826C63twE/Kl7NeXbINrukIKiIftZ8Gnk1v5f/O
 fliigwwoxOrzi5SkY7AJNwDaHfW4DrJNW6/TmBOGq6GCRgG3laayBv8RGlhq1LRprbtK
 um/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119136; x=1726723936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1OZtUQ3CFcWEdjE0VCal/gtVrOv/C/IET7Ot8GrKz+4=;
 b=SkGBp5VPb/ijBKmuCJXR8Dno/UEFroM2g4bw9XIzYsEelTMKFFV0Or3cpP9p4nEXEd
 Wyy0mxp5Br3Fc74LASOh8djYPk/r1pJDBKzmgC2gdIswn84qNmgoOreTDOHpdp86huCw
 UCnPuQnI2cdipadMBNbM5zuC+p1PL+OmFzyFx3n7mBP3OAlXaVIWv/rPF+UBMaK7vWsP
 9n751ip/1Ym6uV5Z0pky71XtLSzw80Xy3aRgZthPYNwMTNd/AXNV3MxI/PJIvv0EdAB6
 57MtdAyqNKkT/uEcsMtQfWKqOxdOx25OtXoSrANpNtqnLNmWgQX30ZuWYWZWst6XKGzP
 FLXg==
X-Gm-Message-State: AOJu0Yx5sPwRNVhBdDN/Qp1ZwHUq4+YR93epiMUYPY8693XMwbuoKkJL
 RUd3d8ZUfLI2hTsYVw75QfjEngPV9k+XSQ947S5QrV6xlm84j/dE8qVcBA==
X-Google-Smtp-Source: AGHT+IFsQlaTs7tmehCRGLmNP+gJRUcmESzbmKM8Xlz3o67pu+czUHJT2gMXsEN79W5HT0VCh75tNg==
X-Received: by 2002:a05:6a21:458b:b0:1cc:e3a1:b9e3 with SMTP id
 adf61e73a8af0-1cf75f2a66cmr2496240637.25.1726119135921; 
 Wed, 11 Sep 2024 22:32:15 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fdesm3833034b3a.1.2024.09.11.22.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:32:15 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 42/47] bsd-user: Add RISC-V 64-bit Target Configuration and
 Debug XML Files
Date: Thu, 12 Sep 2024 15:29:47 +1000
Message-ID: <20240912052953.2552501-43-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x531.google.com
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

From: Warner Losh <imp@bsdimp.com>

Added configuration for RISC-V 64-bit target to the build system.

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240907031927.1908-18-itachis@FreeBSD.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 configs/targets/riscv64-bsd-user.mak | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 configs/targets/riscv64-bsd-user.mak

diff --git a/configs/targets/riscv64-bsd-user.mak b/configs/targets/riscv64-bsd-user.mak
new file mode 100644
index 0000000000..191c2c483f
--- /dev/null
+++ b/configs/targets/riscv64-bsd-user.mak
@@ -0,0 +1,4 @@
+TARGET_ARCH=riscv64
+TARGET_BASE_ARCH=riscv
+TARGET_ABI_DIR=riscv
+TARGET_XML_FILES= gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-64bit-virtual.xml
-- 
2.46.0


