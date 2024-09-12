Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95458EE644B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socPF-0008KR-6w; Thu, 12 Sep 2024 01:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socPC-0008DW-56
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:10 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socPA-0002yG-F3
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:09 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7cf5e179b68so426685a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726119007; x=1726723807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qKFK7bfzo9lztBPhZCSDP1XR7U4NGQvb7cgLHvUq4Qk=;
 b=BljB+s7k+nxPgTKRuIuf1WhPdQROXb5sJD/7n6vZ5KRPM02Jq2DLM4MM1jNpQusaLo
 /uIgukx996c1RgFPdeD2EuP7Rg40VnevBgeQntMfUQaojr7+W4df2OPSpMeG7erx8/V6
 hF+s6KVpkI1R8UffSYgMU8RQ1jpNa5Pj2tAyoK1lQuWljkPRA3E+UO7N+tA9csnfAN2t
 hDGizk+dIjHH2EKl1gU3BH/AMyxd+u4eqNdGirOMzMftKVz92TBDYAfU3NHxsDRMTpew
 +p044O1DIaGEHN4N9iwKSUiNLGVr41vW0vO5vqPPoQApw3ZM7SdtqiekJ1Dr/NHU6nbR
 zkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119007; x=1726723807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qKFK7bfzo9lztBPhZCSDP1XR7U4NGQvb7cgLHvUq4Qk=;
 b=TT30/bWmzU6DD3KhPcxpEboH2Wamef+F1nuT4ilSrsUdih7fzCl7eAUvtCUL6ST27C
 PCDshkqQ1M/Cs5WkSHFdtLytFhOn7d3roZTxoJ0wCcvdo5rxkphymcTSk1KjPGVttqLY
 kLrkoJlQXahmBCh6lyZs5jX2RqXY/PaC//nwE25WlV8Lfil8V7+0KGl+uRNwi1bNXthw
 qDg+X1cB51nvHV4K9WIWf2yihc0psR6IxJQhyHwPxUBBs4Rh5Baz830rPfu46iPBu9dB
 nw7pYrt0Soyv+M7m0/4eZOUDwxfpIqdkMpvzZnpoMQHdicaJEZZY9G85kLdJFwIlyj1Q
 azGA==
X-Gm-Message-State: AOJu0Yy9ehXRaviX0eSf85RSl1aGGYWYbwvLsacSBlSyRaAGEtIqiSPD
 efEt0j3y3XOcBn9KA4f3zWQ99sG9uHulCdlAhVs5BBU1hYvzFjcDSzPgtQ==
X-Google-Smtp-Source: AGHT+IFIojT6DO00nECHxhJaDgiZMy5EGf9SBLIQjAxWI0X9jVG7o8oA3/I/pqGPGMYdyEcQXCvntQ==
X-Received: by 2002:a05:6a21:6e41:b0:1cf:3338:a475 with SMTP id
 adf61e73a8af0-1cf755c7824mr2727457637.9.1726119006381; 
 Wed, 11 Sep 2024 22:30:06 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fdesm3833034b3a.1.2024.09.11.22.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:30:05 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Haibo Xu <haibo1.xu@intel.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 02/47] tests/acpi: Add empty ACPI SRAT data file for RISC-V
Date: Thu, 12 Sep 2024 15:29:07 +1000
Message-ID: <20240912052953.2552501-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x529.google.com
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

From: Haibo Xu <haibo1.xu@intel.com>

As per process documented (steps 1-3) in bios-tables-test.c, add
empty AML data file for RISC-V ACPI SRAT table and add the entry
in bios-tables-test-allowed-diff.h.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <0e30216273f2f59916bc651350578d8e8bc3a75f.1723172696.git.haibo1.xu@intel.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 tests/data/acpi/riscv64/virt/SRAT.numamem   | 0
 2 files changed, 1 insertion(+)
 create mode 100644 tests/data/acpi/riscv64/virt/SRAT.numamem

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..a3e01d2eb7 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/riscv64/virt/SRAT.numamem",
diff --git a/tests/data/acpi/riscv64/virt/SRAT.numamem b/tests/data/acpi/riscv64/virt/SRAT.numamem
new file mode 100644
index 0000000000..e69de29bb2
-- 
2.46.0


