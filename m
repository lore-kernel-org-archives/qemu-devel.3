Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84396109192F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 23:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Mkd-0000lD-Bw; Thu, 19 Mar 2026 19:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w3Mka-0000km-7u
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:26:00 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w3MkY-0007dI-KO
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:25:59 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2ad9a9be502so431865ad.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 16:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773962757; x=1774567557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xwoi+O+VyBLBHt3oqgyEn9Gx8FelMnzje7H/aNHtlwE=;
 b=DmHf5WSbYzwt2lWIO8mu+HWnFyg4Zy+ryXWYW8pSp3p2eL59QogPjaDExdvLr19aG3
 4fgqx5a+VexuEvLKhHgCXMcg5QYdPaHXsno0XqeMbr/oC5ZkNWohh2BFuqaO7SkZcuIx
 zq6Get5QiZeGzYbM4ZdL63z4wc1RyDevkigswykZgDsa25EFQfoVW7ZqMKeh+7O2liYK
 X9QQd4ClwaGXtIvyXSh8Y6K1sLtdXpUuGUL0G4HdGn4Zmc2ZILdfkDB56eb6i/XgyYeD
 BzMTGtDLOfdhEG9oPT/EVEQCp1ivoabX9H4ejA/TsHDlRx2ANbIeA3NQQw6bO7asSFzN
 Pfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773962757; x=1774567557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xwoi+O+VyBLBHt3oqgyEn9Gx8FelMnzje7H/aNHtlwE=;
 b=muLZiUWdOjBs+lTPW6aFL51HS2++5GgpHqqtLgEb1jxbDUOLW+Vdh+kIjxCWV6WJMR
 kyUFhgpHA+8gi2iNfr9JgAeko7SLli7dM2U0JrAYvGiDLtT4EwrmEF4+zmyep0omxXgN
 1rULkUIw8GXImD3R0Ub4qyC/3+fd1K6Lc3fisfNbmQ+b1Hi7CgUMrpqDsaBNo67sGqza
 ICqhH3cSQnDkroOdY7IvGVc1+ANQLnEPEMgJU6jDTRzqS+X73D8X/9++Nr5MIoC7xZLZ
 eSiK3LTYQuahpPvFsr9c6P+T0Wk7CAkb5RFgTrz4AL3ie+hO5zd1CsZ9iw6D/KTIuRwZ
 2vmw==
X-Gm-Message-State: AOJu0YxcJOc7m9Ts6MNbl8MCofSFI1CTiBhxs1L6ldMAGyr4SPBIkLRg
 QsSbfR7K/Am+nGaDZyG9os/KfrNW3oZB2QSiYhFLwgAJRy/7A7ywz9mySuC62w==
X-Gm-Gg: ATEYQzxuiJ76Sr/8tppDwaX2/MIveBzX2vpXPmMW/hByURlQ0EzasdO3xQz0+VkgXFH
 8a0MUG4YHYvGX/T+tOZHE5HMLq+PJ7CkHVqv3eTTyrlTZYp2RKs9KalMUJAuLuNVZeUmfOyMImZ
 U9zQDaiU0KR4NiqAnIw05QxhWKtwRdg2BX1eEhELUcR0kpU7Cc1avU6SRZis9qC71ctVdbzY5OG
 UCZKVaq0it8G1OSo0k2zrparlZL1NTrWtQ8GUk19Wdk5m5GB8pZp6PK4TG32C/TzzpI6X37OKkV
 qTaXzdekZrpdhoPB6fnTFNpSiaOEtQxFGqCAoTt1hePmeRGJVV0pX4dAVTmcZbZooiuEQRJZKEB
 f1/tENe/okaByubDODla5o+YBQbBZIFKTEwQyfh9P3Tdkg5owRtxx6H/DW8FL/20VsMmlgZi/kX
 tLsyGGrR1y17yaSmq2XjCeestGhoBhw2tyDB7CkBGS5w==
X-Received: by 2002:a17:903:1a0c:b0:2b0:7255:8df2 with SMTP id
 d9443c01a7336-2b0827b8562mr8635255ad.38.1773962756772; 
 Thu, 19 Mar 2026 16:25:56 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083516ae1sm2979165ad.13.2026.03.19.16.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 16:25:56 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PULL 06/17] hw/riscv: Remove deprecated 'riscv,
 delegate' device-tree property
Date: Fri, 20 Mar 2026 09:25:11 +1000
Message-ID: <20260319232522.1867400-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319232522.1867400-1-alistair.francis@wdc.com>
References: <20260319232522.1867400-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The "riscv,delegate" DT property was added in QEMU 7.0 as part of
the AIA APLIC support.  The property changed name during the
review process in Linux and the correct name ended up being
"riscv,delegation". The incorrect name was added as alias, and
deprecated in v9.1 (commit 38facfa8432), so can be removed for
v11.0.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260227232838.23392-1-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/about/deprecated.rst       | 11 -----------
 docs/about/removed-features.rst | 11 +++++++++++
 hw/riscv/virt.c                 |  9 ---------
 3 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index c37643548d..a6d6a71326 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -481,17 +481,6 @@ versions, aliases will point to newer CPU model versions
 depending on the machine type, so management software must
 resolve CPU model aliases before starting a virtual machine.
 
-RISC-V "virt" board "riscv,delegate" DT property (since 9.1)
-''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-The "riscv,delegate" DT property was added in QEMU 7.0 as part of
-the AIA APLIC support.  The property changed name during the review
-process in Linux and the correct name ended up being
-"riscv,delegation".  Changing the DT property name will break all
-available firmwares that are using the current (wrong) name.  The
-property is kept as is in 9.1, together with "riscv,delegation", to
-give more time for firmware developers to change their code.
-
 x86 "isapc" board use of modern x86 CPUs (since 10.2)
 '''''''''''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 6f4447993c..557a24679a 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1239,6 +1239,17 @@ converting to using TCG plugins they should contact the qemu-devel
 mailing list.
 
 
+Firmware, ACPI, Device Tree
+---------------------------
+
+RISC-V "virt" board "riscv,delegate" DT property (removed in 11.0)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The "riscv,delegate" DT property was added in QEMU 7.0 as part of
+the AIA APLIC support.  The property changed name during the review
+process in Linux and the correct name ended up being "riscv,delegation".
+
+
 System emulator devices
 -----------------------
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index bbce2fb667..a1c323e66d 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -666,15 +666,6 @@ static void create_fdt_one_aplic(RISCVVirtState *s, int socket,
         qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegation",
                                aplic_child_phandle, 0x1,
                                VIRT_IRQCHIP_NUM_SOURCES);
-        /*
-         * DEPRECATED_9.1: Compat property kept temporarily
-         * to allow old firmwares to work with AIA. Do *not*
-         * use 'riscv,delegate' in new code: use
-         * 'riscv,delegation' instead.
-         */
-        qemu_fdt_setprop_cells(ms->fdt, aplic_name, "riscv,delegate",
-                               aplic_child_phandle, 0x1,
-                               VIRT_IRQCHIP_NUM_SOURCES);
     }
 
     riscv_socket_fdt_write_id(ms, aplic_name, socket);
-- 
2.53.0


