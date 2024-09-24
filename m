Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287F3CF9C69
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 22:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stDtr-0000Ok-BO; Tue, 24 Sep 2024 18:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDtm-0008Bm-SN
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:20:46 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDtl-000219-9J
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:20:46 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7193010d386so4903298b3a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 15:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727216443; x=1727821243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rm2PciGct0eK86VEsTnJsW2Sf41E6+hfctylwipX0gc=;
 b=ikBcfVgQ1/fYcaRG+XKK/AG7MpBumrhAfRc35sANKtfmb8/pENxB2P7X1r6MWiH8VG
 sT+7kHW1IJjDP8sbSnnpM+/MnAvwmvxViXKRzm+xjY1JoXbzOqoaYX5gTtJqgZ/FV3oH
 +TITnsn25VLa1G3rNMfdUU8QyyK+fXFvW+fA9naWQDfQPT2+zBSZuAO1R9/zRJMM18bH
 WZr5tNH5nediSwzeEhnbzRq25YUac2MbMJem6VVjIi4ojXgscSxZZtQ6ZgslrebJbOhp
 3Uj34txtCHdvzZxD88iUddIq/3YCvH+hET3izvrhP/Z7PnbY1J91tq7xi2xG5cXE6kmF
 t0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727216443; x=1727821243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rm2PciGct0eK86VEsTnJsW2Sf41E6+hfctylwipX0gc=;
 b=JfX5X+0qzqp0wro43DsP1yYAwVcdRjuJOGRFPlKjysSrnbSx1maisCyLxQHx3G8bk6
 STIGEjkxBjJh94pGpxvMjfPhb5Z7NWiekPJ8hkftcAD18uP7DNKC5NK5H1Jr+b3acISX
 uznYJNm4yOZrHT1SjoVWyyUmFyUqPY3tzMKY+lvpT/95Sn/eAq+N8bnC7lBzI6qANwCb
 JRivNyKeBcU1BsVU02fmasKOYkw/VmETQsJFwOv3ZprC5DdYcvrHj65lNZBuzfZXS4dp
 R69hXGM3nzgBepA9Be55sbuzLLrCJkPFJQElRKFHA5FFe4vnkh16F5Qu2VyBcLEMVNdl
 VBMg==
X-Gm-Message-State: AOJu0Ywmbd5V6etTVDVCY/Euhb9HVOcCy+BbJrzoM9jDVjLmg7/rP1fB
 wSOw8la7TaCb/wDgXeN8slH/ckAuJwe07T44otTdG3STvkXOSbBDDvxhsQ==
X-Google-Smtp-Source: AGHT+IFbTawxPktrfLJYVk+YVzZkLTuBUBCpGjcYu4ZaLKuE5AmJLYGRGZg3+M4EWGPcVFOJtZhdZw==
X-Received: by 2002:a05:6a00:3cc2:b0:714:228d:e9f5 with SMTP id
 d2e1a72fcca58-71b0aaa5bc0mr1343716b3a.2.1727216442660; 
 Tue, 24 Sep 2024 15:20:42 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc8342easm1665310b3a.11.2024.09.24.15.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 15:20:42 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 47/47] bsd-user: Add RISC-V 64-bit Target Configuration and
 Debug XML Files
Date: Wed, 25 Sep 2024 08:17:48 +1000
Message-ID: <20240924221751.2688389-48-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924221751.2688389-1-alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x432.google.com
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
Message-ID: <20240916155119.14610-18-itachis@FreeBSD.org>
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
2.46.1


