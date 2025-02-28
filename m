Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E32CC282C5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 09:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnwex-0000u5-Uy; Fri, 28 Feb 2025 04:27:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tnwei-0000Vi-VJ
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 04:27:40 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tnwee-0001DI-G5
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 04:27:40 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxaWqEgcFnbNOFAA--.33226S3;
 Fri, 28 Feb 2025 17:27:32 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxLseBgcFnU5YtAA--.40659S4;
 Fri, 28 Feb 2025 17:27:30 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 2/6] tests/data/uefi-boot-images: Add ISO image for LoongArch
 system
Date: Fri, 28 Feb 2025 17:27:25 +0800
Message-Id: <20250228092729.543097-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250228092729.543097-1-maobibo@loongson.cn>
References: <20250228092729.543097-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxLseBgcFnU5YtAA--.40659S4
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

To test ACPI tables, edk2 needs to be booted with a disk image having
EFI partition. This image is created using UefiTestToolsPkg.

The image is generated with the following command:
  make -f tests/uefi-test-tools/Makefile

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 .../bios-tables-test.loongarch64.iso.qcow2      | Bin 0 -> 12800 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 tests/data/uefi-boot-images/bios-tables-test.loongarch64.iso.qcow2

diff --git a/tests/data/uefi-boot-images/bios-tables-test.loongarch64.iso.qcow2 b/tests/data/uefi-boot-images/bios-tables-test.loongarch64.iso.qcow2
new file mode 100644
index 0000000000000000000000000000000000000000..2fc19b10b36f0493121c526646965ac7ea377b4c
GIT binary patch
literal 12800
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
P-!c3byK?a_mCk<yI~3Lu

literal 0
HcmV?d00001

-- 
2.39.3


