Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA460C54E62
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 09:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjFN1-00047j-B2; Wed, 28 Aug 2024 05:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sjFMz-000416-LH
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 05:53:41 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sjFMy-0001r7-4s
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 05:53:41 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5daa93677e1so4726124eaf.3
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 02:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724838819; x=1725443619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yaqkhcr8XXVjz3AUT5s3kLltD+ErMtVDTb6FVMqoohs=;
 b=hi4EzJsZw/s03MO3qXHrRi/0YPt5wcRuPRpuYCZO1iS2sDmbKB+oAKkFlZgdVCml/g
 ls78gCFX89ltPNPHKf++Q/d3iAc4RuZ7sdqZfbblI54EaVP9PFFaQQ+c4ZfjdvjNd3kX
 9Jtp9ayo09rV6+7F+de2Wj+x2INRrwgh8xtyA4zAt0MY6MdC1gT5ZAk2Ot+LPRfgL/J1
 DTf5dEUnjsaeBx+LMvx4EqofmAVGwnC36EdG93uNtAViCTXWN1lNELaBVVRZdVqGoGMn
 OugfRquj3GHzW/kani9OYXf8FzsZ77EC2e04M6ucBaXE9rgik8ksy6IC8K5wefoA+NY5
 nqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724838819; x=1725443619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yaqkhcr8XXVjz3AUT5s3kLltD+ErMtVDTb6FVMqoohs=;
 b=OXSp56yCHDo9vSBMK88I89lJVDfxuA4P3LHPXBBo0uDkKV3fR2dSW8Lji/TDOGUeuc
 9hSy/2LVCPTyqikJvMYJ3qzgJtvk72RjKRQq2jNeAHAdt3bG1iDFYjI9yPIozzicGEAn
 6QsSE6SnlkFgjf/350v0dvecCjCVcxZsCxInhR7qcDEgPoFGlaxT5xaXWMa+1bMpTOae
 kZDKxymw171H1fttl82/YAAVdMwxtyeb7d2vVVyUqJFnwy9AxMTpxbM28X/bTUOrNzCG
 2/m5RRcd2KrP9ti0NnbsVznoS3oKNugef3HaIRZ2M3L/IjYblawaa8FjbD1g4DgzcAJb
 OBNw==
X-Gm-Message-State: AOJu0Yz+CBX9HHFeIkHKbKvo1IlTTkBtORyvAtnjZR9McWdZ/edxg++j
 nZivPiMeeoTk/AfqHaYSf/goGEvAbSgvWmZIxV8sOMJ6GkbJePRau66wdQ==
X-Google-Smtp-Source: AGHT+IE2kyDCluBzV5FEkWR+vOYxoovDU8ixp0X+bmEQJ0Y5BhDSyhG0ObxU7J6jDGMRG9ZLjPM2mw==
X-Received: by 2002:a05:6358:3413:b0:1b3:9f0b:89c3 with SMTP id
 e5c5f4694b2df-1b5fac8cc4dmr166192455d.1.1724838818636; 
 Wed, 28 Aug 2024 02:53:38 -0700 (PDT)
Received: from localhost.localdomain ([220.253.126.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143430f6e7sm9787508b3a.160.2024.08.28.02.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 02:53:38 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 17/17] bsd-user: Add RISC-V 64-bit Target Configuration and
 Debug XML Files
Date: Wed, 28 Aug 2024 19:52:43 +1000
Message-Id: <20240828095243.90491-18-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828095243.90491-1-itachis@FreeBSD.org>
References: <20240828095243.90491-1-itachis@FreeBSD.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=itachis6234@gmail.com; helo=mail-oo1-xc2e.google.com
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

From: Warner Losh <imp@bsdimp.com>

Added configuration for RISC-V 64-bit target to the build system.

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
2.34.1


