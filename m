Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9067DCD5BD1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 02:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSmzu-0000g1-Cp; Thu, 28 May 2026 22:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangxiang@iscas.ac.cn>)
 id 1wSmzs-0000fU-5W
 for qemu-devel@nongnu.org; Thu, 28 May 2026 22:30:52 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangxiang@iscas.ac.cn>)
 id 1wSmzp-0007N0-8o
 for qemu-devel@nongnu.org; Thu, 28 May 2026 22:30:51 -0400
Received: from localhost (unknown [122.194.100.152])
 by APP-03 (Coremail) with SMTP id rQCowAAHI9pS+hhq7ULNEg--.64S2;
 Fri, 29 May 2026 10:30:42 +0800 (CST)
From: Xiang W <wangxiang@iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: Xiang W <wangxiang@iscas.ac.cn>, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, peter.maydell@linaro.org
Subject: [PATCH v2 2/3] hw/acpi: Fix Terminal Type and Language field order in
 SPCR table
Date: Fri, 29 May 2026 10:30:59 +0800
Message-ID: <20260529023100.42508-3-wangxiang@iscas.ac.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529023100.42508-1-wangxiang@iscas.ac.cn>
References: <20260529023100.42508-1-wangxiang@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAAHI9pS+hhq7ULNEg--.64S2
X-Coremail-Antispam: 1UD129KBjvJXoW7XF48CFWxJr4xAw4kJw17trb_yoW8JF1UpF
 s0qrW3KrsrJ34fCa1UAF9rCF1rWaykJ3yxCayqkwn8ua4Ig348tFy5Kw4fX3W7K348Wayk
 Cr4jq3W8Wr4IyFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
 1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
 6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
 0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
 6r1q6r43MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
 W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
 1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6x
 IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
 x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
 DU0xZFpf9x0JUyGQDUUUUU=
X-Originating-IP: [122.194.100.152]
X-CM-SenderInfo: pzdqw5pldqwq5lvft2wodfhubq/
Received-SPF: pass client-ip=159.226.251.81;
 envelope-from=wangxiang@iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This fixes:
  - hw/acpi/aml-build.c

Reference:
https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/serial-port-console-redirection-table

Signed-off-by: Xiang W <wangxiang@iscas.ac.cn>
---
 hw/acpi/aml-build.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
-- 
2.47.3


