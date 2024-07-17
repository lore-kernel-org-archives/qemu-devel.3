Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E640C3DA5D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 21:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUCWT-0007R0-LN; Wed, 17 Jul 2024 17:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUCWO-00072M-Nv
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:49:14 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUCWM-0002RD-9y
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:49:12 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4279c10a40eso957245e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 14:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721252949; x=1721857749; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XbJOgH6dYyPN3e3bCfJ4gl/53nu9HSazmUaIUNR0ln4=;
 b=g/1HISjRkhBFXh6jwS0SvadnUGsEmLdQYbe1zXBB1NmmgtwzCFypg09Q38Cr2WhuQK
 0WM3eyjXUey1DkNFTtHexhe+6S0aZ32wMMUKbn8eHVoHX5DGJgQyXIux5AcXmgJTPTQU
 ZJ0LMPbCFDiCN0FWfewnJa0DGNQ4JGqLgImze+j6EuEFYz2cCatauqbkt/ushLC49L2X
 V7FGiScYe39tlDmSepmz48xGbtCVScDT+GblA5e8PRkkTCOJqjm89C/c4Osh64O4eSYZ
 r+4EfjUeiCISPKYvhnngiV1hBGYJfZZdIK5V4Pa6d3w8T8GTCy5aNZhnR6rhumbVPVI9
 RC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721252949; x=1721857749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XbJOgH6dYyPN3e3bCfJ4gl/53nu9HSazmUaIUNR0ln4=;
 b=RnxtmU9EYjPKvCRjZ3vUbfbasxJ7x/ZYvPTj732fJ2bi3DHnYvEGrR35r3UKbYUzpN
 BU+YyqhU0qfqalBnt+HfPX1nkFe4WJxnVTeyghMg/N9k4gjUlNDmLeSAbGR7Q9BKw/m7
 z+VYJXirM/WtMOsZLFRjGTodHeghWxcmS23aQSqRsi+gP1+li15FGPqTnUDL1xLhwuzl
 hYpLCmXQy3/KIj2n5HU8xI7ExZ7ZJUOK3p5YrfyPNkg4xE5x+2FsQ4IW7EpXh49453P3
 V6rT0P6XuqLQaVqDYJZMquKNTpCw26Pg/8UBTysjVA0YPO6s2PGgaZKeFVechHVCtMVw
 sy6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8dhB/JPtEV9FR/bKJQU31PaCBsFN3gC1P7LjJgCQXYIm18X6jy0A0Tr8W2NFsBklWwuZ6gGM94W6MrkGMdZ2YU182OGk=
X-Gm-Message-State: AOJu0YzKMO5l2P+AHFIrvi4mKyu8ccd2wjxLKm6AaEnxM6xdxoGpxgCG
 n32Sa8OAa/3S1D2K0HwJWM6zVp0d+req6MtKfRUIdeYwVhgNIhCHjEHxyq70SMA=
X-Google-Smtp-Source: AGHT+IE8B5oGnr8gHzyYusdO/sceXJAjUNVfQ2wPS/1gD1grtl09uG1l+wCnthQzfK0pDimpm56Jcw==
X-Received: by 2002:a05:600c:1e1b:b0:425:80d5:b8b2 with SMTP id
 5b1f17b1804b1-427c2ca9d9fmr21226885e9.16.1721252949077; 
 Wed, 17 Jul 2024 14:49:09 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427c78154f8sm11487405e9.43.2024.07.17.14.49.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jul 2024 14:49:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH v3 16/17] hw/intc/loongson_ipi: Restrict to MIPS
Date: Wed, 17 Jul 2024 23:47:07 +0200
Message-ID: <20240717214708.78403-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240717214708.78403-1-philmd@linaro.org>
References: <20240717214708.78403-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Bibo Mao <maobibo@loongson.cn>

Now than LoongArch target can use the TYPE_LOONGARCH_IPI
model, restrict TYPE_LOONGSON_IPI to MIPS.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[PMD: Extracted from bigger commit, added commit description]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/loongson_ipi.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 464bb6b580..61375d89ff 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -16,22 +16,9 @@
 #include "exec/address-spaces.h"
 #include "exec/memory.h"
 #include "migration/vmstate.h"
-#ifdef TARGET_LOONGARCH64
-#include "target/loongarch/cpu.h"
-#endif
-#ifdef TARGET_MIPS
 #include "target/mips/cpu.h"
-#endif
 #include "trace.h"
 
-#ifdef TARGET_LOONGARCH64
-static AddressSpace *get_iocsr_as(CPUState *cpu)
-{
-    return LOONGARCH_CPU(cpu)->env.address_space_iocsr;
-}
-#endif
-
-#ifdef TARGET_MIPS
 static AddressSpace *get_iocsr_as(CPUState *cpu)
 {
     if (ase_lcsr_available(&MIPS_CPU(cpu)->env)) {
@@ -40,7 +27,6 @@ static AddressSpace *get_iocsr_as(CPUState *cpu)
 
     return NULL;
 }
-#endif
 
 static const MemoryRegionOps loongson_ipi_core_ops = {
     .read_with_attrs = loongson_ipi_core_readl,
-- 
2.41.0


