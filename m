Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA07CCF2C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhaF-0007QI-1c; Fri, 16 Oct 2026 09:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHex5-0001vU-3C; Fri, 16 Oct 2026 06:14:15 -0400
Received: from out162-62-57-252.mail.qq.com ([162.62.57.252])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <2118537295@qq.com>)
 id 1xHex2-00025D-Pt; Fri, 16 Oct 2026 06:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792145647; bh=Ya5tqjBgZhnAuHGiFuAXbgQ5Ff0e+cdVNdUEh01SWZU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FMj5ADnooz+ay653PAnKBpKsv9uIPyYMYq7p8cafI2soqiD+MfDot0K2U7gq2MDkH
 1uPSS7ENTfBdtovA8P64VbY1R7LYQInEGZmQe3WkwJeJWUJ3lkHYr7zkSR64bQ2vN3
 xaLf5a6yw+ZllvInasC3tHD00lCncjF7N7GLF7XU=
Received: from r00799764-ThinkCentre-M920t-N000.. ([139.159.170.67])
 by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
 id 38486EEC; Fri, 16 Oct 2026 18:14:04 +0800
X-QQ-mid: xmsmtpt1792145644tnpmj9yw6
Message-ID: <tencent_48E88E1B57F8D2D027AA10AB6E9FA4486609@qq.com>
X-QQ-XMAILINFO: NCvoIAqeA6m0+p6EOexeD+ZoFb0l6Dpkj6gJEBKXrxsU5DRvGRe/Vo4xAVViZ0
 FKrgpD/7KamHtbt5olWNVAyUaAcebJRE2PYdEc3ooT2xHM1Ym7PHl+WicX/TXS7Xk09GNlM0Jyhr
 t2AYJb/+v2CPR2gWUWjwYVoZWDYgR/yB0udJQpAOoIHdf8Cz/FtmNu+q5awUHCIKY2FtB6otUG3y
 09SIzPLJqMBqmUAZZZwUTQFN14s8T8V8nTdLr6Avi7B8+6k5n+wStrsNlqS4CdInqevrbh7Zma2B
 yWZVMcLtDcIxMj7Pb1s+vqHgVy9XF0VrHUquKS4iO7XrGvQCyUBfc8RkjAw9Lhz5WLx/kU9vdSKy
 d72jaf30kpr2KKxpmWEQIJnVnVoZRdKvLRB9DokOwGpSWr0MKb7bZ6AdB75K+yZFOEZdvr+6AfMe
 Ah2Ty2jFaiDkCpZguznK81Njuxq5UuOF17BuR7/uEIfsY+lGNzaHfHpih+6cnoU+lSKWt0COP1BZ
 A/wvQS7wd5M7B12yIfOcSm+8ehAUXaWzAHBsKcF6g08juPRuUSguxg2Jr1ItRBWB/hCDi3/grfwm
 XLI03vBEmSPQkkbSIB96o3xdhBsTW3VnUL9jvWzVr8y8AP2F9shPo2zuHsfwTiaYjtWfyzeQ0cqx
 UQBc8PYrLg8FqtSWKF1lsBtfZv2EICjeJ8d/YGzM5i20CnMW9VcfVosG3urE6YV5pww5v8Bo/g/g
 JhZ37VeQ0+TDycC4qH3ZBnCZJl/Ibq5hg+PlQfVRoisVHcFTpCeG0s53hYnZuJwFM/TmNzCpPNJt
 Smx9E+HmF6aCSwMInfj33+/YX/FEEzuWumSOiwNQoZNVWeUmx9ycPvGMJCMcqB/BzQslWWyhIyuS
 /Ccdf7G5PZgCe3Ofvb0DTyWBSvw8XKbDkQpH5XklCS1o89dpMiKbIzSou0YJ9t5qTAxTYrtnKAMh
 SfjeQyU0dhsOvruOSrAY5J16vAJjVtmRiN9f3PEFvQ0P/5o6u/UB7cL5f3jyYfd6YTkcxEaxnO8I
 AJc6H1rqMG6NuoHy3jkX0BsZuLUYX3zbZZjmNZDCrX+FZJJBqiLtgQw0i3Mrh/9o+/uhzQ1pZ/Qp
 c6c41OrOc9R7teEnLEEk4mHXhPNg==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Jinjie Ruan <2118537295@qq.com>
To: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com,
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: ruanjinjie@huawei.com
Subject: [PATCH 18/37] hw/arm/virt: Reserve the MPAM MSC MMIO window
Date: Fri, 16 Oct 2026 18:10:38 +0800
X-OQ-MSGID: <20261016101058.1900808-4-2118537295@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016101058.1900808-1-2118537295@qq.com>
References: <20261016101058.1900808-1-2118537295@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.62.57.252; envelope-from=2118537295@qq.com;
 helo=out162-62-57-252.mail.qq.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Oct 2026 09:02:43 -0400
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


