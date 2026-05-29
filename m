Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150EFCD6E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 02:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSmzu-0000gI-RG; Thu, 28 May 2026 22:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangxiang@iscas.ac.cn>)
 id 1wSmzt-0000fe-18
 for qemu-devel@nongnu.org; Thu, 28 May 2026 22:30:53 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangxiang@iscas.ac.cn>)
 id 1wSmzp-0007My-8y
 for qemu-devel@nongnu.org; Thu, 28 May 2026 22:30:52 -0400
Received: from localhost (unknown [122.194.100.152])
 by APP-03 (Coremail) with SMTP id rQCowACXt95R+hhqxULNEg--.10253S2;
 Fri, 29 May 2026 10:30:41 +0800 (CST)
From: Xiang W <wangxiang@iscas.ac.cn>
To: qemu-devel@nongnu.org
Cc: Xiang W <wangxiang@iscas.ac.cn>, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, peter.maydell@linaro.org
Subject: [PATCH v2 0/3] acpi: Fix Terminal Type and Language field order in
 SPCR table
Date: Fri, 29 May 2026 10:30:57 +0800
Message-ID: <20260529023100.42508-1-wangxiang@iscas.ac.cn>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACXt95R+hhqxULNEg--.10253S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XF48CFWxJr4xCr13ur1DAwb_yoW3Wrg_uw
 n7KFykJwnrZ3WkZr1xA3ZrA3s09a17CF1fCrnxtrZYkr1xZFsrAFs2qasYvF1xAa1fGr4x
 twnYvrW3Grs3WjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbsAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
 Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
 0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
 Jw0_GFylc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
 4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
 67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
 x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
 z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
 UI43ZEXa7VUbznQUUUUUU==
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

Reference:
https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/serial-port-console-redirection-table

Sia Jee Heng (1):
  qtest: allow SPCR acpi table changes

Xiang W (2):
  hw/acpi: Fix Terminal Type and Language field order in SPCR table
  tests/qtest/bios-tables-test: Fix Terminal Type and Language field
    order in SPCR table

 hw/acpi/aml-build.c                   |   4 ++--
 tests/data/acpi/loongarch64/virt/SPCR | Bin 80 -> 80 bytes
 tests/data/acpi/riscv64/virt/SPCR     | Bin 90 -> 90 bytes
 3 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.47.3


