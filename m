Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39381CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhaM-0007aN-47; Fri, 16 Oct 2026 09:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHev7-0001aV-Fa; Fri, 16 Oct 2026 06:12:13 -0400
Received: from out203-205-221-164.mail.qq.com ([203.205.221.164])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHev4-0001zM-OD; Fri, 16 Oct 2026 06:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792145524; bh=Ya5tqjBgZhnAuHGiFuAXbgQ5Ff0e+cdVNdUEh01SWZU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=E1bTzFYOV7TlrywSbxv0WOGQ9LcBrj1oC6vC522YAdMZf/c2c/0n1Kg1yzgSvFea7
 Y2OdXPUw7mrP5EZdXWQ71RReYlBWPE3J2uOzQVgh6Ug6tTEZvSXhdPDMpxdTpk3bl5
 3un/4gLrzPwZENS7KFltZaZjOxXwaly+FL0nqQjA=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
 id 301876B0; Fri, 16 Oct 2026 18:12:01 +0800
X-QQ-mid: xmsmtpt1792145521tfflccdv7
Message-ID: <tencent_1CD3EC276A11AB6E43A57A66C08F31561809@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+o1QKNDfqQgv8Ytnyj1LZDwy0t76kAW6Z8rtboENnu8dhhrKfE/
 l3pn8SY+qWmctzu4Ns+2DzQf6C84YzTprpkSs7x54X6fUdmpe+zjk756IBJyFWCdVeaUqgb1MwOW
 +UbD4+UrfrR0fO4qDKWzTsyDlFG91mhP2vnhKOkbxGizKrKB6No8UVKzP5eW40iHaGzN4zNmu7v5
 lcLPd1TUwsC34iO4VBYr7BMa67phEYt4ml3EB2GiYfrYqecLEJD/M1R48l9JYg7PHZlVketx5BlK
 D5FSQd4x4IWj/EUsldSVjSRJIlmV5bnk/ESmeJLSqFCM7KRJFwDxFKfIOvrgebFSLgfLRLh8Zw1g
 djDRnGYgsZ8cJI7lpMKrTTNhhdv3h8eCpi9Ow8jPmiAgnoyEGwHpIgcuyLHU3FnuduQ13G3jJ4Px
 jxByBYJlI/811CX5FRAaNEO+KdSXxxwot5f+xDSM8mR/6HtgY49H5N4cHhG7NNKIh9YScVDE9duH
 p7RPwIZ1L35ZjK+zljCvVdt+0vJGEMuYLNfTlwPlYzUqL0p34woD+8WYLY6JUubP+mcsd70n/GiR
 sCTHEbwpmm+7cWmJPq+clXhgpx3DzJsV+W2IUhNh3IXe3vnFff08N7oLmD7i+6GRDX6JZiXyTYEG
 tUXTCpl9av5mZUuvsMCKYTS97gTzxkl6m14ru+75BmMhpyKnSOAZsvmhzfoeZ13BcTXt0zH0tDON
 gofa+82t0+4aeZW5ABuMAb+ND5Y01OPefQAC/Ru2ZmCgNZwgMADCUCIZrNkGav+552wG4/fxtTn2
 0GaPS3Fk3dbWEmDOlWClNwGJWMpYkoMlhQvc6uF9UVnFmAjq/IbTNv/OvVQnphOAimo/5VZvg9Ab
 lW9/ITitzrrtML58aok3HWoSJbGlzGqE8uAT+2pCDNayEQO06tfCLoN68TpPnJUhGmT7HlEXZIao
 v2Gk92DJfgZVkICUU2g39I1OP+qqLG0RS4dzbubg5Cvp+Tr7EqgbY4vxa9Wpt2ADI0REon/ep5fE
 ES1HgrsDvKC58/TMWsKh1s3XAko8n5DSI79wNtfmDJ3MOlloZp
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 18/37] hw/arm/virt: Reserve the MPAM MSC MMIO window
Date: Fri, 16 Oct 2026 18:10:36 +0800
X-OQ-MSGID: <20261016101058.1900808-2-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016101058.1900808-1-2118537295@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.164; envelope-from=2118537295@qq.com;
 helo=out203-205-221-164.mail.qq.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Oct 2026 09:02:42 -0400
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

Reserve a 1 MiB MMIO window at 0x0b006000 for the MPAM MSCs
(MPAM_SIZE * 256 slots, right above the virtio MMIO transports)
and add the VIRT_MPAM_MSC memmap entry the creation code uses.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 hw/arm/virt.c         | 3 +++
 include/hw/arm/virt.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index aaadff6..3ad7de8 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -90,6 +90,7 @@
 #include "hw/virtio/virtio-md-pci.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/char/pl011.h"
+#include "hw/arm/mpam.h"
 #include "hw/core/cpu.h"
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_host.h"
@@ -211,6 +212,8 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_SECURE_GPIO] =        { 0x090b0000, 0x00001000 },
     [VIRT_ACPI_PCIHP] =         { 0x090c0000, ACPI_PCIHP_SIZE },
     [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
+    /* MPAM MSC MMIO windows: MPAM_SIZE (16 KiB) each, 256 slots (1 MiB). */
+    [VIRT_MPAM_MSC] =           { 0x0b006000, MPAM_SIZE * 256 },
     /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
     [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
     [VIRT_SECURE_MEM] =         { 0x0e000000, 0x01000000 },
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index c847136..56bee15 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -81,6 +81,7 @@ enum {
     VIRT_SMMU,
     VIRT_UART0,
     VIRT_MMIO,
+    VIRT_MPAM_MSC,
     VIRT_RTC,
     VIRT_FW_CFG,
     VIRT_PCIE,
-- 
2.43.0


