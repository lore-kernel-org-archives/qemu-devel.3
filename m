Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D0ECD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 09:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSXHC-0002NZ-Mr; Thu, 28 May 2026 05:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangxiang@iscas.ac.cn>)
 id 1wSXH9-0002NJ-PV
 for qemu-devel@nongnu.org; Thu, 28 May 2026 05:43:39 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangxiang@iscas.ac.cn>)
 id 1wSXH6-0007BK-5R
 for qemu-devel@nongnu.org; Thu, 28 May 2026 05:43:39 -0400
Received: from localhost (unknown [122.194.100.152])
 by APP-03 (Coremail) with SMTP id rQCowACHotlADhhqi9axEg--.1563S2;
 Thu, 28 May 2026 17:43:29 +0800 (CST)
From: Xiang W <wangxiang@iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 Xiang W <wangxiang@iscas.ac.cn>
Subject: [PATCH] hw/acpi: Fix Terminal Type and Language field order in SPCR
 table
Date: Thu, 28 May 2026 17:43:52 +0800
Message-ID: <20260528094352.177947-1-wangxiang@iscas.ac.cn>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACHotlADhhqi9axEg--.1563S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF1kXr43Gw47JFy8AF1UJrb_yoW8tr4fp3
 yjqrW3Krnrtr93Ga1jyF9ruFn5JFs8Cw47uan0kr1q9F17Cry8t3WrK3ySqa4ak348Way8
 ur1DtF18ur4xZFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
 tVW8ZwCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
 1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
 14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
 IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
 87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
 IFyTuYvjfU04SoDUUUU
X-Originating-IP: [122.194.100.152]
X-CM-SenderInfo: pzdqw5pldqwq5lvft2wodfhubq/
Received-SPF: pass client-ip=159.226.251.81;
 envelope-from=wangxiang@iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URI_TRY_3LD=0.645 autolearn=ham autolearn_force=no
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

According to the ACPI Serial Port Console Redirection Table (SPCR)
specification, the field order after Flow Control is:

 - Terminal Type (offset 62, 1 byte)
 - Language (offset 63, 1 byte)

Previously they were swapped in both:
 - The table generation code (aml-build.c)
 - The golden reference blobs

This fixes:
  - hw/acpi/aml-build.c
  - tests/data/acpi/riscv64/virt/SPCR
  - tests/data/acpi/loongarch64/virt/SPCR

Reference:
https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/serial-port-console-redirection-table

Signed-off-by: Xiang W <wangxiang@iscas.ac.cn>
---
 hw/acpi/aml-build.c                   |   4 ++--
 tests/data/acpi/loongarch64/virt/SPCR | Bin 80 -> 80 bytes
 tests/data/acpi/riscv64/virt/SPCR     | Bin 90 -> 90 bytes
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 7edc8aed42..2adf2810c3 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -2116,10 +2116,10 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
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
diff --git a/tests/data/acpi/loongarch64/virt/SPCR b/tests/data/acpi/loongarch64/virt/SPCR
index 3cc9bbcfb8051e632592d9db0fe3dba0af53ed8d..7bb819cd0d2ad20269e40e4a738709a45260cbb2 100644
GIT binary patch
delta 23
TcmWFtm|!Qw%<vxw7?1z}S|J61

delta 23
TcmWFtm|!Qw!2BNw7?1z}S{?;}

diff --git a/tests/data/acpi/riscv64/virt/SPCR b/tests/data/acpi/riscv64/virt/SPCR
index 09617f8793a6f7b1f08172f735b58aa748671540..59d2c8f7f215a604612cbd0294c18bc6301e208a 100644
GIT binary patch
delta 10
Rcma!wnqbGo%rMbG3IGpM0&@TW

delta 10
Rcma!wnqbGoz&z1G3IGpJ0&@TW

-- 
2.47.3


