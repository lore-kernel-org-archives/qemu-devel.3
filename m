Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56954C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMbr-0003W4-MG; Tue, 20 May 2025 09:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uHMbi-00039i-Ui
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:02:11 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uHMbe-0002Nh-3a
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:02:10 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxaeFJfSxoXG7zAA--.22354S3;
 Tue, 20 May 2025 21:02:01 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCx_cZGfSxoW1bjAA--.62430S4;
 Tue, 20 May 2025 21:02:00 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 2/8] tests/data/uefi-boot-images: Add ISO image for
 LoongArch system
Date: Tue, 20 May 2025 21:01:52 +0800
Message-Id: <20250520130158.767083-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250520130158.767083-1-maobibo@loongson.cn>
References: <20250520130158.767083-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCx_cZGfSxoW1bjAA--.62430S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, LOTS_OF_MONEY=0.001,
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
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
---
 .../bios-tables-test.loongarch64.iso.qcow2      | Bin 0 -> 12800 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 tests/data/uefi-boot-images/bios-tables-test.loongarch64.iso.qcow2

diff --git a/tests/data/uefi-boot-images/bios-tables-test.loongarch64.iso.qcow2 b/tests/data/uefi-boot-images/bios-tables-test.loongarch64.iso.qcow2
new file mode 100644
index 0000000000000000000000000000000000000000..18daee0c52fcc703a0645dbcdc598aa1f101d96b
GIT binary patch
literal 12800
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
G4EbN%8c56l

literal 0
HcmV?d00001

-- 
2.41.0


