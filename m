Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80400C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 13:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl7Kx-0000BT-VV; Fri, 15 Mar 2024 09:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1rl7KI-0006nF-Mq
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:10:24 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1rl7K9-0007xN-Jm
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:10:21 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6da202aa138so1215674b3a.2
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 06:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710508210; x=1711113010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rLrHBMIvFW4XmoCMhvXju7BN+IFOvSPPXpZv8Qzl0AE=;
 b=FjsiYhaOOz1Y7EjCrVxJQ8uoRJRuFGW3ZL8Re+AsfE2qaviapXbn/OCHLL/LMHr9Zs
 MJ4gr9jHzPUGKxlk8TUFjxoBomiNQODL5lSS0ZbA0r5RWEDPrwcJoW2nAPTrMTqBTmpN
 yWAwezYJTjAtFOMmz32fA92h20hHVxtp9pTpioE++K8r21zroZJhLra39CMZiHFvjrUQ
 H0ajtAEwui4kYNtG20sgttY92sSxFiyUcDjRm3sbqVA1JOGmMZVfiRE89s/W7MkdCUhP
 Ic0LEjvmxE38wPaNGLEEE5EjmxEGbuiKZSnwxg1jZKTbAq2iVDfUuwKuENb1tPszkYZI
 +Azg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710508210; x=1711113010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rLrHBMIvFW4XmoCMhvXju7BN+IFOvSPPXpZv8Qzl0AE=;
 b=RikTG6tbTZlAXzbw/h0e3Zh5JtqUQbsTg/XhO+j61/uOefK+wAk+BqZ0JsG4AsNDk1
 jemdYuPn+VgTvRc1TWwGvLSk2B4rsH+or7Kj073/EyBjXnznH75LiZPP0HIl4qaZTll+
 2AyiY834QcVTx/0uUaw1tpbuVCgqWR6uDk63L3qh7YOhWPcb7ZyXdLSMzUsWxzvx3Hv9
 0mWOKNOytbnj66dAuIB4YDn9WNRPZalRcKtCTWM8j/RV7u5XMMyX1VB2tCHm6uNu0b/r
 rIxmJEwyP/ntrxSN0xtwf6JJ/qPP3obBn01TK7+CJp5Uk6rDnSwjZwgpeU2vzntbOr6o
 ardw==
X-Gm-Message-State: AOJu0YzopkR/D/2olp4lbfeFnHec+7uRqyDMvnOf6zS3gfQJjZU2aqA4
 /TPxrvcO09MD2c8J/QzrAulj+1QYAHm//Rxx4CaF6Sp63REP2ccYEwFepT79Pj9/pJP/W5h+Bpt
 E
X-Google-Smtp-Source: AGHT+IHObHc0Ahl0qj6J7KZfwd1HADuvDQ77aHsslrh5XiW6wo7BFk+HQiUOclQqf2aCK83ZbRrP/w==
X-Received: by 2002:a05:6a20:1591:b0:1a0:e187:87c4 with SMTP id
 h17-20020a056a20159100b001a0e18787c4mr3772557pzj.38.1710508209727; 
 Fri, 15 Mar 2024 06:10:09 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.184.12])
 by smtp.gmail.com with ESMTPSA id
 r3-20020a17090ad40300b0029c68206e2bsm2886663pju.0.2024.03.15.06.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 06:10:09 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair23@gmail.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Anup Patel <apatel@ventanamicro.com>, Haibo1 Xu <haibo1.xu@intel.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 10/12] tests/data/acpi/rebuild-expected-aml.sh: Add RISC-V
Date: Fri, 15 Mar 2024 18:39:22 +0530
Message-Id: <20240315130924.2378849-8-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240315130924.2378849-1-sunilvl@ventanamicro.com>
References: <20240315130924.2378849-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x429.google.com
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

Update the list of supported architectures to include RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
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


