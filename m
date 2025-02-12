Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A627DC021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 03:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti3FB-0000gI-Gn; Tue, 11 Feb 2025 22:16:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1ti3F7-0000eq-DN
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 22:16:53 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1ti3F0-00017D-2S
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 22:16:53 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxdXCYEqxncchyAA--.3267S3;
 Wed, 12 Feb 2025 11:16:40 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxPseSEqxnkg0NAA--.51828S3;
 Wed, 12 Feb 2025 11:16:39 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/6] hw/loongarch/virt: Rename filename acpi-build with
 virt-acpi-build
Date: Wed, 12 Feb 2025 11:16:28 +0800
Message-Id: <20250212031633.3548108-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250212031633.3548108-1-maobibo@loongson.cn>
References: <20250212031633.3548108-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxPseSEqxnkg0NAA--.51828S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

File acpi-build.c is relative with virt machine type, rename it with
virt-acpi-build.c

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/loongarch/meson.build                         | 2 +-
 hw/loongarch/{acpi-build.c => virt-acpi-build.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename hw/loongarch/{acpi-build.c => virt-acpi-build.c} (100%)

diff --git a/hw/loongarch/meson.build b/hw/loongarch/meson.build
index 005f017e21..3f020de7dc 100644
--- a/hw/loongarch/meson.build
+++ b/hw/loongarch/meson.build
@@ -4,6 +4,6 @@ loongarch_ss.add(files(
 ))
 common_ss.add(when: 'CONFIG_LOONGARCH_VIRT', if_true: files('fw_cfg.c'))
 loongarch_ss.add(when: 'CONFIG_LOONGARCH_VIRT', if_true: files('virt.c'))
-loongarch_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-build.c'))
+loongarch_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
 
 hw_arch += {'loongarch': loongarch_ss}
diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/virt-acpi-build.c
similarity index 100%
rename from hw/loongarch/acpi-build.c
rename to hw/loongarch/virt-acpi-build.c
-- 
2.43.5


