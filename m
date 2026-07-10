Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F9DC44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1R1-0003PM-3v; Thu, 09 Jul 2026 22:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Qy-0003Hx-Ta
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:57:48 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Qv-00009G-HK
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:57:48 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c9c26a5fb98so297642a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652264; x=1784257064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zr/+DWx7DIpUXKiFc+x0C2H/CKshylFSLRxsLwBzrrc=;
 b=WYGDeF+peCDF8ZJJb2LQ/q3oY3LYHdR5F/9uiaUIdc8LWVbN4LoayGJ/bY8/JruUla
 /yUyrBMMXW6zrtRCDn89PQgxxmpBDZbT6nYaNZqq9yUXsAI3xYZQdPiYkJPH1x20Lh1O
 GC0mGlYRZyDtMKSWn4zNYVqVF+PngXZYtoGrRQs7ETeMzk/wHiyySU3PdZ9jUgQiwLjt
 VEwghseH5N0FEvtS5RXtAWPd9mVrOBvz2DrxdRYrpKbC3l73wjjfxfN2JUu79lyOEK/Z
 pDUKW+R7R60FVVU1/vQQYlNTtfRZxRF2mE6CDvHdLAbCliAIVV6G/CbTUCpQanm3JoO/
 zDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652264; x=1784257064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zr/+DWx7DIpUXKiFc+x0C2H/CKshylFSLRxsLwBzrrc=;
 b=syy6Ncy0KXptg+JJv+fb6zOd9w7YyJWoUI/0no3FtAYD2IpomFxQCSQd/6b4w9GfzL
 O34XJRpkL+oHisEvp/XnY4ahqbACycyxos7MazdZIoN4hwFxIkJOBPkwkxxVurK3GYXn
 VaHW+43e5ef6OR6eRGqPbL3m7XgKyYLlAMXyMBaUq/CCZzq2dAMnYyPpEwFxHAEo2uGe
 FrTCAkhEAtoQ//dF6N2M/dBLtSoeoijNEWQm75dpfZF63DrC8UlmoUJaL6/iVQFmrJuS
 3RkBQMc7NnB/R1Zq2hTa2371E32kUcBggy0tJ/s7uQ8PLMi+lQOTbtZKZvDTJRMAIstz
 buhw==
X-Gm-Message-State: AOJu0YxQBWmytjzsqxLQQOKaEUZaztCn3qM/AiX/2wOP/+nciUHDvW88
 7YT6+1jqdPX++jOkUEFbaLV0UykHZ0uda/IJGqya5OlnnqdjKE4iuLHcHSsFOg==
X-Gm-Gg: AfdE7clU7ggvmozg82rcxHWlkxC9SRwm+wSgIMj1j7YRdAiol8rNrt8FL3u0QfhVoHU
 o4K4erRgmKrsUMs7FCt5icADgarYxFVJsLarF3E6//hhBKFO282YMpEVB1DMx4mFu4ZkA705Gyw
 w4jyZcY+BOOpOQnByOm3pRzecqA4r2cEuTm5Hj8I4ciHTrIZrcChu0Yp0K4bT68zddViOSPzg2J
 1eTKdNiDUWG+ui7MtuAHu5atctD514zVcBfrcsT8WdQHYjM3YdTwr4E38xcFG7KKbx1dYynwYrA
 cSjOEyMWbpF40Hwum/cxeIV/eoXvuOKJAtA235ptFuHe38kzwvbATieFUt6+OFnnYnJh5H7HxXL
 WMSzTRJglOoj7MGax7K8RUPqWmocIYC/+CS19rckOY5i0dtKni/2SRqLubjdXmDBwUu/0NEnOHk
 xvbE5yWbd59EHApK7+sD5aCEbE+PogAic=
X-Received: by 2002:a05:6300:6702:b0:3bf:b9de:8557 with SMTP id
 adf61e73a8af0-3c0f11d7a4amr1668024637.9.1783652263875; 
 Thu, 09 Jul 2026 19:57:43 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:57:43 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 40/40] tests: update SPCR loongarch64 and riscv64 test data
Date: Fri, 10 Jul 2026 12:55:25 +1000
Message-ID: <20260710025525.1704417-41-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x536.google.com
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

On LoongArch and RISC-V the SPCR test data contained:

    Terminal Type : 00
    Language : 03

The corrected values are:

    Terminal Type : 03
    Language : 00

See the specification of the table in
https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/serial-port-console-redirection-table

The ACPI table data was rebuilt with
tests/data/acpi/rebuild-expected-aml.sh.

Remove SPCR expections from tests/qtest/bios-tables-test-allowed-diff.h.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260705063147.199732-4-heinrich.schuchardt@canonical.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   2 --
 tests/data/acpi/loongarch64/virt/SPCR       | Bin 80 -> 80 bytes
 tests/data/acpi/riscv64/virt/SPCR           | Bin 90 -> 90 bytes
 3 files changed, 2 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 2c7086d9de..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,3 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/loongarch64/virt/SPCR",
-"tests/data/acpi/riscv64/virt/SPCR",
diff --git a/tests/data/acpi/loongarch64/virt/SPCR b/tests/data/acpi/loongarch64/virt/SPCR
index 3cc9bbcfb8..7bb819cd0d 100644
Binary files a/tests/data/acpi/loongarch64/virt/SPCR and b/tests/data/acpi/loongarch64/virt/SPCR differ
diff --git a/tests/data/acpi/riscv64/virt/SPCR b/tests/data/acpi/riscv64/virt/SPCR
index 09617f8793..59d2c8f7f2 100644
Binary files a/tests/data/acpi/riscv64/virt/SPCR and b/tests/data/acpi/riscv64/virt/SPCR differ
-- 
2.54.0


