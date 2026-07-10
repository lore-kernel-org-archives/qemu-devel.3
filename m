Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E351AC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 03:00:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1Qx-0003C9-JE; Thu, 09 Jul 2026 22:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Qu-0002y0-RG
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:57:44 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Qs-00008t-Ms
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:57:44 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-84536ecfc5bso411426b3a.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652261; x=1784257061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Kv+GArOshXmFdR1sZyXd23A57ETGs8RdZ+Z2GyBMGTk=;
 b=AJCxr8wYiuj5qkfL8TT1X7t6p/G5FXz8vs/Mz+xLD7WTwps+KGLS9cWf5YOyrUeVrf
 4R4yPwCQrdQ4AY7lPv16smxLtbth5EGwbeeoGsilX6JBUU9kcHyeYzrIyDD87a3vu4kM
 l2/WBGlPp7PwjIi+Sl+RfaZ1KYRWKJgXdvxaid2VPWFf9N/eTwtHonDWeUHmUHETvwvy
 B/W+3QtNgTrtGwJ4u2ZelNZl2BeZbMmUD7C95dkU6G7e+3bvGKXoFHPKQ8Ut9E4UKkib
 EXxEnpw2hcoeht6rc4k/RQjAm44ETmY1es7Ku3HqyEYNE3ImeTrpLeoa4yWUZUFH+Bcv
 dotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652261; x=1784257061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Kv+GArOshXmFdR1sZyXd23A57ETGs8RdZ+Z2GyBMGTk=;
 b=Qr6u2RMCh6VcUSZ2w+2G/xvc0eo2A6K7oPhmcDXrZsY+EwRLepdWOwYBlPTy2bVLI9
 pfnDtDZh2QTdEWXrz9s3u5QZx04ew4rDWlQTKPZ1NZtdEZZ3kL5QYsMlwFrw7ZQRICd2
 ijnjUoliEfEVa0uDG5n2cKbeLlI2ai5aQ3QcEJSlxggkIS3tqc5VjrH72+qBKWteMhEH
 sURpT+9+LM5WlVbReI6cdeW9AFre/2PtYeSVZQP3m0N118Ycgu6cdDsip1mqhFwNvLiP
 S55IpzmYdt56cVGMIvTVMMzqxlCM4mvicT7PBmjcYXdL2l8+JXxApellF6Jtil2kAltR
 cU7A==
X-Gm-Message-State: AOJu0YwI5yTC6xD0nty/UXvqvLSwLlA8+sR8GJUEl36lNlhn65DjRj3+
 I/MOEPXQMsjpf+d2+FDvzXdOgV25kHdsPmL1HpQirciJ8tmcblAwd2JcBCMxIw==
X-Gm-Gg: AfdE7cktsMciiCO4QDwl8nvU1touE06wBq24QOBjndfwcT6BQC6ZEDjqckBrBj9GtOX
 5xbdlzqTi/vgYaBH5ZylfQjgZx4xmO+F6x6bZgzFjqHVTbAvwKyP9YWqUWUc3owdUgeTpJfEc3c
 N+o1hZ35lAeB35HJ5/lFyJFSqeyF3/PzJgsNX8t1DSZhsl8utaRDJGOyELZijHY9zRVKO7YI2lI
 5t/pYqMxmCPD4xDMnmQuNqSjNmHT+Etr+r7IjFjbePLDnKulKjeLsg/2aMhA72RE6iDBTNHGCIb
 YJyHgZ2PXjX14c2CWoWmzW0A02uE3Ev1caFcXtm3XHKEHy/GusJnvWqrSEUyjLJ+5pAxdeVd+09
 xTyYPpnmm30rTRiv6jMBg/uRSifIdpP+7OyQRRzuocYrTHjUUopUkDgq7pi8ciJ2bi+S5XfCEqE
 Q9gc41kQRBIEnmmir+qCNiuB7lX7lzglNa4DAGx4Sugw==
X-Received: by 2002:a05:6a21:a96:b0:3bf:d0c8:2aa7 with SMTP id
 adf61e73a8af0-3c0bcbc5172mr11540647637.47.1783652261211; 
 Thu, 09 Jul 2026 19:57:41 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:57:40 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 39/40] hw/acpi: correct field sequence in SPCR table
Date: Fri, 10 Jul 2026 12:55:24 +1000
Message-ID: <20260710025525.1704417-40-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
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

On LoongArch and RISC-V invalid SPCR tables are created:

    Terminal Type : 00
    Language : 03

The correct values are:

    Terminal Type : 03
    Language : 00

This is due to commit 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate
SPCR creation to common location") that swapped the fields.

See the specification of the table in
https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/serial-port-console-redirection-table

This page shows version 1.10. But the sequence of the fields was not changed
since version 1.0.

Our LoongArch and ARM code uses version 1.07 of the specification.
Our RISC-V code uses version 1.10 of the specification.

Fixes: 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate SPCR creation to common location")
Origin: https://lore.kernel.org/qemu-devel/20260326121947.51200-1-heinrich.schuchardt@canonical.com/T/#u
Bug-Ubuntu: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2146419
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260705063147.199732-3-heinrich.schuchardt@canonical.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/acpi/aml-build.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 9b3cdd3781..990abc64cd 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -2144,10 +2144,10 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
     build_append_int_noprefix(table_data, f->stop_bits, 1);
     /* Flow Control */
     build_append_int_noprefix(table_data, f->flow_control, 1);
-    /* Language */
-    build_append_int_noprefix(table_data, f->language, 1);
     /* Terminal Type */
     build_append_int_noprefix(table_data, f->terminal_type, 1);
+    /* Language */
+    build_append_int_noprefix(table_data, f->language, 1);
     /* PCI Device ID  */
     build_append_int_noprefix(table_data, f->pci_device_id, 2);
     /* PCI Vendor ID */
-- 
2.54.0


