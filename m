Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CEFC27C6E
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 13:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHkVw-0004cg-E0; Thu, 13 Jun 2024 09:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yshxxsjt715@163.com>)
 id 1sHgqQ-000747-QY
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 05:34:10 -0400
Received: from m16.mail.163.com ([117.135.210.5])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yshxxsjt715@163.com>) id 1sHgqK-0007FQ-Hl
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 05:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=BGztXnyZs8pPzHIeDA
 XzDYimt5pyyT2LxrRWGHuD+k4=; b=XPctxuiTm0P87cq68wQQiacGWm2NpU4IUL
 XQuT6rKMAelFdXLkVO6k7RLVErkW+Z60ltYVUynuUigE2tec6CS5tlwm3VzIhX7i
 A/4dR0X+VD2UA/+3ehEYRnuYszz1JLGgDd738/Hg381KiwSTv4jQxJamEm51l/GB
 55tMnDQa4=
Received: from localhost.localdomain (unknown [113.120.52.251])
 by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wAH7SP6vGpmR3kLIA--.23208S2;
 Thu, 13 Jun 2024 17:33:50 +0800 (CST)
From: shenjiatong <yshxxsjt715@163.com>
To: qemu-devel@nongnu.org
Cc: shenjiatong <yshxxsjt715@gmail.com>
Subject: [PATCH] hw/acpi: increase default size for rsdp file
Date: Thu, 13 Jun 2024 17:33:45 +0800
Message-Id: <20240613093345.4020-1-yshxxsjt715@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wAH7SP6vGpmR3kLIA--.23208S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFW3WrWkCF15Gr1kXF15twb_yoWfGFX_WF
 n5AF45Wwn8Xr97CFsFqryYyw1Sg3y3Ww1S9w13XwnrJa4Ygw45GFs5uFs3Za15K34xWFy3
 A347Xr1UA3ySgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbUGYtUUUUU==
X-Originating-IP: [113.120.52.251]
X-CM-SenderInfo: h1vk555vmwliqv6rljoofrz/1tbiLh-8L2V4JicHVgAAsv
Received-SPF: pass client-ip=117.135.210.5; envelope-from=yshxxsjt715@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_BL=0.001, RCVD_IN_MSPIKE_L3=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 13 Jun 2024 09:29:14 -0400
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

From: shenjiatong <yshxxsjt715@gmail.com>

Size of RSDP file will be different on an OS
configured with PAGE_SIZE of 64 KiB. This will
eventually blocks live migration from a different
hosts which has the same haredware spec. So increase
this default max size to 0x10000 (64 KiB).

Signed-off-by: shenjiatong <yshxxsjt715@gmail.com>
---
 hw/acpi/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/utils.c b/hw/acpi/utils.c
index 0c486ea29f..85f6ff36f1 100644
--- a/hw/acpi/utils.c
+++ b/hw/acpi/utils.c
@@ -37,7 +37,7 @@ MemoryRegion *acpi_add_rom_blob(FWCfgCallback update, void *opaque,
     } else if (!strcmp(name, ACPI_BUILD_LOADER_FILE)) {
         max_size = 0x10000;
     } else if (!strcmp(name, ACPI_BUILD_RSDP_FILE)) {
-        max_size = 0x1000;
+        max_size = 0x10000;
     } else {
         g_assert_not_reached();
     }
-- 
2.17.1


