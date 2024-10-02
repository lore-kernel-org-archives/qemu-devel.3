Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330C8CF3195
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 05:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svsGY-0005WG-UL; Wed, 02 Oct 2024 01:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsGV-0005Vm-6k
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:11 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsGR-0004pi-2u
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:09 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20bb92346caso3597515ad.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 22:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727848265; x=1728453065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mr8ztux/WjHsRrRRjwNMAfL9hLtaU+DJEJRiO/tD+UY=;
 b=OzBaWzbN/IDPDoPbcm3GF9nFpPVcXXXcaW3SM0TO4rx8nKIjAjc69dLiwKX/XiYu5I
 q+pSdNeJSRzEgLjLF6k5kxDD03OkqVZE1ofPoqQ30wNb/IRGiFlyU9glNFlbsExXIKBh
 j7IOzknM+I/LO2dhf7gWIxZqX9LO3Zag8VZCe7uqXXlc7ZauEucUyeY2eQo6YT0n8Dl7
 NQYVYB/WEqVlmMYninMgqcSdLwXzlGzhBFgX8cr2sxgWmRSBL4zmqpgQeR6IlBEs+ac1
 v6KJTvIzmkRoc5ccY4sWKDUzl5LuawAAlT1TSnMvfdRRTSeKwII9i2+tQI47nVqHPpFk
 +miA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727848265; x=1728453065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mr8ztux/WjHsRrRRjwNMAfL9hLtaU+DJEJRiO/tD+UY=;
 b=W3J/4ZhR74lKjbr5MRntoasxmWrjl+5EBkYBbx79M74h8RRKaOxGcnntVaa0dc1ugP
 XxAajRaAeVwi+mQHBb1wxSlAwqPg51BVRx1m8ultn1CdYfSNpLHXZR5oYaiX3jvKB7hc
 2cqtL4R4/Susbd3niKF6CdFv++dOtvi4R070mKWylRSb8fFK1u3Bhk2Iz84GxTsP1VQa
 e+WsIc1yxIH8GB7UbGsL+EgWt1pmv2elT7Y5pa0ssOqMySo1QmBLnycmeiEOVajKzbnz
 i7zPw3Sm0EBuyTlqR0aguvR6rMleyOwLhXmzItwLZaWM5lFvDXOI5au/yFc3OI1GOuYO
 2i3A==
X-Gm-Message-State: AOJu0YzgQJlmTStqzLhTtFe00BhNNB8mVyn01u9nel7909RPnR7LPhDt
 EawYwg7xqkCu64qTgz8H+QcqEwS+kt8MvHpwPvURxxSIRaybfnTT3ItDOvlL
X-Google-Smtp-Source: AGHT+IHx965BcMkWoDudsx2/bwopNVMnCLg9Wn1wrWsWDbRY2Rn73eC8/c+cNNVz53oqhRe+XqmNmA==
X-Received: by 2002:a17:902:c947:b0:20a:fd4e:fef6 with SMTP id
 d9443c01a7336-20ba9ebb492mr88355655ad.8.1727848265351; 
 Tue, 01 Oct 2024 22:51:05 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e60c76sm78324235ad.269.2024.10.01.22.51.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 22:51:04 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Haibo Xu <haibo1.xu@intel.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v3 02/35] tests/acpi: Add empty ACPI SRAT data file for RISC-V
Date: Wed,  2 Oct 2024 15:50:15 +1000
Message-ID: <20241002055048.556083-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002055048.556083-1-alistair.francis@wdc.com>
References: <20241002055048.556083-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
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
2.46.2


