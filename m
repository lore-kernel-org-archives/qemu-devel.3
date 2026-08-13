Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031F6C5AC67
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 03:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuMIM-0003a0-W1; Wed, 12 Aug 2026 23:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wuMIL-0003ZA-4d
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 23:39:53 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wuMIJ-0004Ss-7h
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 23:39:52 -0400
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8AxS_CCPH1qysgAAA--.2463S3;
 Thu, 13 Aug 2026 11:39:46 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front1 (Coremail) with SMTP id qMiowJBx6c2EPH1qVO8CAA--.4092S2;
 Thu, 13 Aug 2026 11:39:48 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Dongyan Qian <qiandongyan@loongson.cn>
Subject: [PULL 4/5] tests/acpi: Update LoongArch virt MADT
Date: Thu, 13 Aug 2026 11:40:51 +0800
Message-ID: <20260813034052.79094-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260813034052.79094-1-maobibo@loongson.cn>
References: <20260813034052.79094-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBx6c2EPH1qVO8CAA--.4092S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zw1fCr18CFWktr1UWFW5XFc_yoW8CF45p3
 y7Awn2kr47tF9rGws5GFZ7XF1kJFZruanrWFWDXw17uF1DCryDZr13K3s2ga43A340vFWf
 Zw1DKryrA3WrXFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
 vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
 jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2I
 x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
 8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
 0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UMpBfUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

From: Dongyan Qian <qiandongyan@loongson.cn>

Regenerate the APIC and APIC.topology test data after correcting the
LoongArch virt MADT revision.

The generated tables change only Header.Revision from 1 to 6 and the
corresponding checksum. Their lengths and interrupt controller
subtables remain unchanged.

Signed-off-by: Dongyan Qian <qiandongyan@loongson.cn>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 tests/data/acpi/loongarch64/virt/APIC          | Bin 108 -> 108 bytes
 tests/data/acpi/loongarch64/virt/APIC.topology | Bin 153 -> 153 bytes
 tests/qtest/bios-tables-test-allowed-diff.h    |   2 --
 3 files changed, 2 deletions(-)

diff --git a/tests/data/acpi/loongarch64/virt/APIC b/tests/data/acpi/loongarch64/virt/APIC
index 3477789f422cad54f16734b3ec9ad1ff5135165d..e90c267e1fdd83143edc732df41ca5659415090d 100644
GIT binary patch
delta 16
Xcmd1F;c^V{bk1R5U|{<&kt+!RBvAxk

delta 16
Xcmd1F;c^V{bk1R5U|{?@kt+!RBuoTf

diff --git a/tests/data/acpi/loongarch64/virt/APIC.topology b/tests/data/acpi/loongarch64/virt/APIC.topology
index da0089d57f608aca230a76b67e72f9f0ad8e71f2..d00b7241c7ad76867781d5649e2de5fb6a5f45bc 100644
GIT binary patch
delta 18
ZcmbQqIFpgfF~HM#CIbTlTi`^legG=>1a<%b

delta 18
ZcmbQqIFpgfF~HM#CIbTlW7tHlegG=+1a<%b

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 0e18673fcd..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,3 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/loongarch64/virt/APIC",
-"tests/data/acpi/loongarch64/virt/APIC.topology",
-- 
2.54.0


