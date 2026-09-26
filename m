Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F1EC98338
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 12:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xARuC-0000Tq-8O; Sat, 26 Sep 2026 08:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoxiaoqiang007@gmail.com>)
 id 1xARmF-0008HT-KL
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 08:45:17 -0400
Received: from mail-pz2-x2b.google.com ([2607:f8b0:4864:3b::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhaoxiaoqiang007@gmail.com>)
 id 1xARmE-0004sR-6k
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 08:45:15 -0400
Received: by mail-pz2-x2b.google.com with SMTP id
 41be03b00d2f7-cc78dd54610so502037a12.1
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 05:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790426712; x=1791031512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pImCYgQdZy64e/+WHphPJKNF/YWpOYzJk9HAVflTVlU=;
 b=Ge4kSbP4BbgPmPStJG78COzGumh1yhiZng02jrP2f0OzD+0O78/n3EuPSCgH3XaMg7
 Z904JQ3Hw2zNlWk0FrQ17aekThmSC2aLLzcP4U+rjAL+snIORHO20XraPxZG1jd6hStK
 MiS7OW8BkLO0+Rii3SetZFZRt3+uA4RjkrDHJwlZO3HW5jp/2k1UqT2WeteleG3GUQn2
 yrxgyhyEjPu89Dqhkufs3xPzigWWFDgkt5uxns0c31UoRYrE+HkquG+izsQIgL7T79xX
 Zr2WtVBPv61RW1nv+9e6fMOnPV0Nmfj9tZD/KwJ4wc4kweQuACiMc7Sct2jOPLPDyLUJ
 y+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790426712; x=1791031512;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pImCYgQdZy64e/+WHphPJKNF/YWpOYzJk9HAVflTVlU=;
 b=j9bKgXgveBkTi5QMSTGonbXRYaqXachnXzXLR5PgANIQfpdnjzct6xYeMSkXz+9QB4
 cery2ff0FZtKiRAuqr2f40okSO1e71KfbVcXkqGv/LmwhHWqLzkbcYvpNk7zG3kSrmYx
 CcjLD6CTlmgiYH36GJqqTPQgiYIrfHHf/N+G7pg5HTzvFkwzU2yiHnVfCHQrea76klY+
 6m/S4sBrZ9VsDQ26ywnLZ54oVgkiF+Sx+3OZPdxfQFLERBkkrKxpaj74vAZGTNbBSqAW
 gZ/SlQiLvvU4kTGehSnLIir0kxS9HSMRWEEO3o2U2/1GX0Lyxh9+MzwPgHdAgpWwNdCx
 ZJvw==
X-Gm-Message-State: AFq9FYInVnsYy6f9nQtwB12w3bwjF/rmGaRpNb/Zk3x1F27PdPRqFmim
 fmOyDPgH+mKxbJrIgTvhTgy3Sw/Lqip3gKoi6iPBrJer3iO4bUZrOqa/U4x9pLRSQWE=
X-Gm-Gg: AYBFou03dy0GlwmT9orLhv5V9Pxzr79m0C/FnfXPzVYizrBVvvRekVS6yLt+P0lRlYZ
 KWPQpdqALxlMBjBEV3ZjSTDDGY7hjWcIoTL7o+nu3lyht48Ese47St2qCThmDTLssfZQ6wvQUh0
 k7JylsaxdZKh9hT2j0xmw7hQW+DgdXLsUkn3nyMWEUXKpxTZPt5keRiLIP89mEE3btsVSZ2Z7O6
 QdU1+d0ko94yVoHxiJC/W8NrzyKk+zV3icFZYKW/VxphAmQPGOGnDvsgYBCRqR7y7/N9Y/40O0W
 Zq2g9wIrFR9nrVzv1ULKmSwf0WNX99oywxTF1B4GWMBbZBHZPb5tw277+KgU0SWCweERQ5Ang+Q
 1YI6VW4EyRCKo4mHa+brHJzrquXqJIlAcFXv+nKCtuOLdMrNgPF/9n5+Q4jHYbgVrFcHy1BRztV
 b8Fh1zzd6MH3l3JAfFEC2R/64SEKlV4jYJA7ZxjxHUd0JDGmLF9CeN/ZnIRkdXI82X
X-Received: by 2002:a17:90b:3c87:b0:39e:6c68:1556 with SMTP id
 98e67ed59e1d1-3a098aab6b9mr5850174a91.30.1790426712045; 
 Sat, 26 Sep 2026 05:45:12 -0700 (PDT)
Received: from euler-NAS ([1.203.174.67]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b7d11124sm10919649a91.10.2026.09.26.05.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 05:45:11 -0700 (PDT)
From: xiaoqiang zhao <zhaoxiaoqiang007@gmail.com>
X-Google-Original-From: xiaoqiang zhao <zxq_yx_007@163.com>
To: qemu-devel@nongnu.org
Cc: 17746591750@163.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 jiaxun.yang@flygoat.com, xiaoqiang zhao <zxq_yx_007@163.com>
Subject: [PATCH] hw/loongarch/virt: fix SPCR bitwidth value
Date: Sat, 26 Sep 2026 20:45:05 +0800
Message-ID: <20260926124505.2900623-1-zxq_yx_007@163.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::2b;
 envelope-from=zhaoxiaoqiang007@gmail.com; helo=mail-pz2-x2b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 26 Sep 2026 08:53:24 -0400
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

Serial base_addr.width should be 8 instead of 32.
The wrong reported data will cause ADE in FreeBSD console initialize
process and trigger a reset loop.

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
---
 hw/loongarch/virt-acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index 600ef60fc5..54965f011d 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -268,7 +268,7 @@ spcr_setup(GArray *table_data, BIOSLinker *linker, MachineState *machine)
     AcpiSpcrData serial = {
         .interface_type = 0,       /* 16550 compatible */
         .base_addr.id = AML_AS_SYSTEM_MEMORY,
-        .base_addr.width = 32,
+        .base_addr.width = 8,
         .base_addr.offset = 0,
         .base_addr.size = 1,
         .base_addr.addr = VIRT_UART_BASE,
-- 
2.54.0


