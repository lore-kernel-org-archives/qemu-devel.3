Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE56A606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 06:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOrKw-0006yS-PS; Thu, 05 Nov 2026 01:52:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xOrKs-0006x8-Jz
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 01:52:34 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xOrKq-0000mc-Kf
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 01:52:34 -0500
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8DxpvCqJ+xqU48cAA--.17401S3;
 Thu, 05 Nov 2026 14:52:26 +0800 (CST)
Received: from fedora.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJAxnM6dJ+xq+IEyAA--.17797S5;
 Thu, 05 Nov 2026 14:52:26 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: pillow <waysorrypub@gmail.com>
Subject: [PULL 03/13] hw/loongarch/virt-acpi-build: Drop UART _CCA declaration
Date: Thu,  5 Nov 2026 14:53:35 +0800
Message-ID: <20261105065345.966691-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105065345.966691-1-maobibo@loongson.cn>
References: <20261105065345.966691-1-maobibo@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxnM6dJ+xq+IEyAA--.17797S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZFWrKFyktFW8ZFW8trykCrX_yoWkXwb_GF
 n7Z3srtw1rZ3W2g34Y934rJw13Xw1IyanIva13WFn5Za18tr15GFZrWanxAF9FvrZruryf
 W3yvgr48CrW3CosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUb7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
 0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
 7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcV
 C0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
 04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
 CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU82g43UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: pillow <waysorrypub@gmail.com>

Remove the _CCA property from the UART device. _CCA describes a
device's DMA cache coherency attributes. This UART does not support
DMA, so there is no need to declare this property.

Signed-off-by: pillow <waysorrypub@gmail.com>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt-acpi-build.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index 981e609ffc..c560f25c0b 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -324,7 +324,6 @@ static void build_uart_device_aml(Aml *table, int index)
     dev = aml_device("COM%d", index);
     aml_append(dev, aml_name_decl("_HID", aml_string("PNP0501")));
     aml_append(dev, aml_name_decl("_UID", aml_int(index)));
-    aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
     crs = aml_resource_template();
     aml_append(crs,
         aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
-- 
2.54.0


