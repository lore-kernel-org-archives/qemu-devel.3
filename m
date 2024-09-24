Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA49CF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 22:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stDrL-0003Gb-05; Tue, 24 Sep 2024 18:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDrH-00039h-PM
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:18:11 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDrF-0001bd-L3
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:18:11 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-718d704704aso5321047b3a.3
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 15:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727216287; x=1727821087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C0E1zfPSjh1qpzGGU7IMQN7XcWmz190vR1wl/9PYF1Y=;
 b=bQonOGorzS5uGXSAR6vukCjjdtUNfWeQSPE31bgZ31tR+2G+AMamWxoKjBPLPQxTOg
 r+D+hn6DGWgjE8J35Wp0Ju95lCZ1NC/XAWUsrdfZ7pFJ3aTnSeETjpl94qjqKMvrcsGC
 Xr7O///AQUyPPoXlDxoZ+QUf6TB7s6JSUcPBtn3JRpO7rEDv5YujpKXZ+asQ115n58kx
 YVNzxRVXZIqWQEljO4VyCHT3GU8Zu5pO+jLKeUAN9TH5xjioYC2aXoNN72B6kQrQQcgG
 i7jcBqSkqoPxL6CUZX/GK5I8QRkCWimu+0N7NWxXCM6lOYGsbe5rrkpEYhFE4+cHGakY
 rvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727216287; x=1727821087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C0E1zfPSjh1qpzGGU7IMQN7XcWmz190vR1wl/9PYF1Y=;
 b=du3EJBLu5d/pdvtUYJ446Wfwkwg+VppFqSZScoF6srFTNazo0aCk7AaFXHTQ7I8b4t
 Ds2XyXj2tlr5Qr+gqp9uT83WawrVDc87YPfHs1sQygRE0hWijzkqnGhkXXOycrbVG/Ne
 cp0FBstmZ9MvD/v2TM3VIK8xoczqVZNFcXMHhlNg5Zv2e80orfN1JNaMKVAK6tx/C2ZF
 F9a72AP9e6i6CE5rKl+jfhgmTqb8bYsLt88mKMDjrpGrZIbXNrCBTpB7FGblASgqbT2u
 xVf0EPCaWiokySZ+tVdqZ0kj+1OSv6ZzVblKOEtWgbredEgAfzft9uOFzYed78aitePY
 2SUg==
X-Gm-Message-State: AOJu0YzxyC5uwND3vRMrEKcn7MBm3VpSNvnKsEUn1B4H9LUTx6DO/KAe
 sg1oJkycJPZY87DWRXVH4dUOxPoKoND2okstZkW9H1JxsazJ/PsO8tx9Ig==
X-Google-Smtp-Source: AGHT+IHPTzV1AqZ9nx3FHRjAHTOl7vwFo8Xmlw4Ytczy53cQQs5m9oMqjxjuE0FeBlNyLhXnwVKZFg==
X-Received: by 2002:a05:6a20:c797:b0:1d2:f00e:47bb with SMTP id
 adf61e73a8af0-1d4d4ac39bcmr932262637.21.1727216287213; 
 Tue, 24 Sep 2024 15:18:07 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc8342easm1665310b3a.11.2024.09.24.15.18.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 15:18:06 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Haibo Xu <haibo1.xu@intel.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 02/47] tests/acpi: Add empty ACPI SRAT data file for RISC-V
Date: Wed, 25 Sep 2024 08:17:03 +1000
Message-ID: <20240924221751.2688389-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924221751.2688389-1-alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x436.google.com
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
2.46.1


