Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3350FF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwrw-0003X9-HM; Wed, 29 Apr 2026 00:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwrt-0003IG-My
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:49:50 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwrq-0008VU-On
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:49:49 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-362bb3260f1so6145833a91.2
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438185; x=1778042985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qEDmsR/JqcbgCNghfcXwBD3pCtURvXQEABYF1XFgcWM=;
 b=WhW3ZJezEP0JJ9HrEbWgpCcm4EdrHooWInJs6tGtXH+ZVAyu8i+JhDb+SIOqMrKdFF
 F14lDm+63prBhKxg0On/70rzyxccgHBHPtWnA/asUJ4s2vCmRrUwuIIggTk58+V24wIM
 EVgSJt9bwLEu6txQHYUpG3qWo3HB1iDuId5vcJWAwQ2hFdOsf2HHyBPAQeOq0JPwXrbD
 eWJ8kwrTdKmE9TbZXH7mAci7rOpKmHJ6RwXswymoaWfRFZgTOJvRHprv+DQuG0lXa5lR
 qNDttXxpVqSUFQr8ec227FJUIQbhaX8iM5Tt97/1fo4LbaBOzW+8+XKnYmxjCWiVudxK
 IeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438185; x=1778042985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qEDmsR/JqcbgCNghfcXwBD3pCtURvXQEABYF1XFgcWM=;
 b=ea4qksePabF7j5o33oOhu7tEntLx+RKlUJd8PRenmoIt/LcSN/kWtWFy+dGl3sbHsq
 HJcJ8GP6VflvPzyzjKrktcfJLss1srqb3CFKF+ubCpPMloFcYGqh9e2vQFA28aGLRba2
 T68yJdQHbHLXxm8eIqHUHzo2Nqp/ytvLd2kRd86jvhfC+Qfs6Rb3OLxKSVLjC5z6qtqs
 wR5bXpMCxb3B5UzJg7gtQfwrzakm0FIb2C7XQSOYTHddVcbdoMxFJ2kqLQgZbVzXRwjc
 VtJori20AKGJ6lMFy3OTjNV8t6D/d47qGsD+sOBfDYar1JlwZwOwsNEoYb49SVo8S7uj
 DhUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+xu+TNOmFrHe9gEI0UB0Cw5MHynH2P4VbbdH/n1zwjeZAUQ47qm6RLM46x6yvX69HQEBpOvdzsMrz+@nongnu.org
X-Gm-Message-State: AOJu0YyLooUFdLTPE0GE8nSKPYuWygLAC8eCEAqMDRln493wI5/hLZDT
 25ruU/WliklISuORmfWwuAByxumPjPiMttNTDDBB53Bpw8YnPfscVXk6
X-Gm-Gg: AeBDietiHoIMtka9fCXdjIZdTB3nOqYi3BjuJF9XYJASnBB447hO86v7C//5Gaxl5il
 cU5/n5sXULqG9rTEpDkMik0vbROG3Z/O4H8eyE1fLF8I88WxCcpiflBFRHbpyEV+6hMlLpuloa5
 Ekxa5VN2fbjvICrJcrcm7o6erET5rSmc+hAAm4tHGRpduhA7nkF9laZ5RI7HYo2bUPNWWE7z+1P
 0ge/+HohY2PNHJVSMHRG/QqvVNPNEqfwoVC3r3SCuBckTpd0g/arAEm6T3zEmBi8/pYwXPuXgPX
 ESTy3n/YY1UB0gq4yEi8OrBNixSxOoqyAPxGGmSVlXHyU8IDf47juIs7MrrAR/QlA6J1LORTne0
 zavFf06vBaVfH3CFgjrBxs5g/u2Gf+DW6kBhb83BQS+ykCYU2En/uKMnOVhNqk2jqDRffPfq9D3
 1Tpy9v1lpzFTuF+KSxCZxeBhpR5YmHraV/1A99aQVIcyPNmUuI4Aoa
X-Received: by 2002:a17:903:38cd:b0:2ad:d0ff:2ed4 with SMTP id
 d9443c01a7336-2b98730ca9emr21563935ad.6.1777438185183; 
 Tue, 28 Apr 2026 21:49:45 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:49:44 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 19/51] configs/targets: Forbid RISC-V to use legacy native
 endianness APIs
Date: Wed, 29 Apr 2026 14:47:20 +1000
Message-ID: <20260429044752.4176397-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

All RISC-V related binaries are buildable without a single
use of the legacy "native endian" API. Set the transitional
TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
further uses of the legacy API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260318103122.97244-17-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 configs/targets/riscv32-linux-user.mak | 1 +
 configs/targets/riscv32-softmmu.mak    | 1 +
 configs/targets/riscv64-bsd-user.mak   | 1 +
 configs/targets/riscv64-linux-user.mak | 1 +
 configs/targets/riscv64-softmmu.mak    | 1 +
 5 files changed, 5 insertions(+)

diff --git a/configs/targets/riscv32-linux-user.mak b/configs/targets/riscv32-linux-user.mak
index f069ab9a0f..d88fdf5e1b 100644
--- a/configs/targets/riscv32-linux-user.mak
+++ b/configs/targets/riscv32-linux-user.mak
@@ -8,3 +8,4 @@ TARGET_SYSTBL_ABI=32
 TARGET_SYSTBL_ABI=common,32,riscv,memfd_secret
 TARGET_SYSTBL=syscall.tbl
 TARGET_LONG_BITS=32
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/riscv32-softmmu.mak b/configs/targets/riscv32-softmmu.mak
index 26080599be..5d5016d008 100644
--- a/configs/targets/riscv32-softmmu.mak
+++ b/configs/targets/riscv32-softmmu.mak
@@ -5,3 +5,4 @@ TARGET_XML_FILES= riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml ri
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=32
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/riscv64-bsd-user.mak b/configs/targets/riscv64-bsd-user.mak
index bc85d9ed04..5b4e138099 100644
--- a/configs/targets/riscv64-bsd-user.mak
+++ b/configs/targets/riscv64-bsd-user.mak
@@ -3,3 +3,4 @@ TARGET_BASE_ARCH=riscv
 TARGET_ABI_DIR=riscv
 TARGET_XML_FILES= riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-64bit-virtual.xml
 TARGET_LONG_BITS=64
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/riscv64-linux-user.mak b/configs/targets/riscv64-linux-user.mak
index bca0864512..35621520c5 100644
--- a/configs/targets/riscv64-linux-user.mak
+++ b/configs/targets/riscv64-linux-user.mak
@@ -8,3 +8,4 @@ TARGET_SYSTBL_ABI=64
 TARGET_SYSTBL_ABI=common,64,riscv,rlimit,memfd_secret
 TARGET_SYSTBL=syscall.tbl
 TARGET_LONG_BITS=64
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/riscv64-softmmu.mak b/configs/targets/riscv64-softmmu.mak
index 5059c55048..a10dc03c04 100644
--- a/configs/targets/riscv64-softmmu.mak
+++ b/configs/targets/riscv64-softmmu.mak
@@ -6,3 +6,4 @@ TARGET_XML_FILES= riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml ri
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
-- 
2.53.0


