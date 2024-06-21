Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0D1C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 12:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKcwr-00064P-MG; Fri, 21 Jun 2024 08:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sKcwN-0005ic-K9
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 08:00:29 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sKcwL-0003ae-Cp
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 08:00:26 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f480624d0fso14709775ad.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 05:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1718971223; x=1719576023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=olkiI7wyhmRaTOBe/j8f3rBI3dB8B8MYASE/tQDUo2k=;
 b=JDbATmk2F72KF1RGzB1mZIbr7xe7b3ubpnwL7yyhCD96fTgfh2sI8sBxkbh2MGogc3
 s3wuUM7h9skb2Hi2cFEGA8cbvx0PjuAQAaMvIj1Aodug1x0SFJ9QI2jUSIBs8MgZEGoT
 sXosoT2B3X8+Gr9bNs4UqdnOIq2TsUR/058jQ2TayAYMzz7BL4YLKlS25EFhKKnd0Q67
 jgvqSga3gY2rwG7EnU1l9vkXvm75k1/5e15XWfAZuUj7nIP9DbJeuELPUaNsj0nKIvVm
 IPKf7VCvl825kdKUzDOxH989OhmjIbJTB2qbZA7TutXEBz8qenZB/ovT8dR1h/n+fVul
 BLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718971223; x=1719576023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=olkiI7wyhmRaTOBe/j8f3rBI3dB8B8MYASE/tQDUo2k=;
 b=fRpc5hjRdDToP25I2ZHUH+fPOdXSj/aU7eZ4+VGygrS7ogQdOnE0Lg0U0ACLX9wX/D
 Lxou+mOhTg4WtqQ07XLR1lzibt0cg6udkOTdwI3PADcxX3A3AbPUlU6zID3uYRZ4rxM+
 HcVPSZ+jW2LwAD4nkdtlPd7zOS3aeVV5/yfcO+9/lcK0xGU1YNVB2Ct2UH4F59Rp+R6I
 jKthpm4fcQOe+Q3AepGCvu5G4cuhZ3XF/V1DOcmIIUm3i1a8JRhq9CKaYZ8IqMdJ8SQ0
 WyuWXNFTTeUgqlezCF3FAndiqIqibbpNYU3o73JoRoxZ4+Xdx+eNhWZz6KUKolAs8vDA
 pyRA==
X-Gm-Message-State: AOJu0Yx4c9GdU2XMg0JqkHvYGXYNJqFTtJhVG7WlErkA38DbU7AL91M4
 10g7NDZpuMovFBYidTRnbNs9xj8KlNmaTOl0V47LyNCZqdSmdrSS+MCB7VfFNNqn42RdK9SLEfq
 Z
X-Google-Smtp-Source: AGHT+IGwQFkNO29rnTMAdFkRkOjyoh5RdmSA7BHDz/NR5TA8A2H8PzI7wgpQmJWn6zEP1QhSBlkJcw==
X-Received: by 2002:a17:902:6808:b0:1f9:c701:1cb7 with SMTP id
 d9443c01a7336-1f9c7012283mr39847835ad.68.1718971222957; 
 Fri, 21 Jun 2024 05:00:22 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9ebbb606dsm12422995ad.270.2024.06.21.05.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 05:00:22 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 12/15] tests/data/acpi/rebuild-expected-aml.sh: Add RISC-V
Date: Fri, 21 Jun 2024 17:29:03 +0530
Message-Id: <20240621115906.1049832-13-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240621115906.1049832-1-sunilvl@ventanamicro.com>
References: <20240621115906.1049832-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pl1-x636.google.com
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

Update the list of supported architectures to include RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/data/acpi/rebuild-expected-aml.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/rebuild-expected-aml.sh
index dcf2e2f221..c1092fb8ba 100755
--- a/tests/data/acpi/rebuild-expected-aml.sh
+++ b/tests/data/acpi/rebuild-expected-aml.sh
@@ -12,7 +12,7 @@
 # This work is licensed under the terms of the GNU GPLv2.
 # See the COPYING.LIB file in the top-level directory.
 
-qemu_arches="x86_64 aarch64"
+qemu_arches="x86_64 aarch64 riscv64"
 
 if [ ! -e "tests/qtest/bios-tables-test" ]; then
     echo "Test: bios-tables-test is required! Run make check before this script."
@@ -36,7 +36,8 @@ fi
 if [ -z "$qemu_bins" ]; then
     echo "Only the following architectures are currently supported: $qemu_arches"
     echo "None of these configured!"
-    echo "To fix, run configure --target-list=x86_64-softmmu,aarch64-softmmu"
+    echo "To fix, run configure \
+         --target-list=x86_64-softmmu,aarch64-softmmu,riscv64-softmmu"
     exit 1;
 fi
 
-- 
2.40.1


