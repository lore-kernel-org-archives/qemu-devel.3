Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25843606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 06:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOrL0-0006zw-Bs; Thu, 05 Nov 2026 01:52:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xOrKw-0006yR-OJ
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 01:52:38 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xOrKs-0000nI-CM
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 01:52:38 -0500
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8AxYdGtJ+xqV48cAA--.17738S3;
 Thu, 05 Nov 2026 14:52:29 +0800 (CST)
Received: from fedora.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJCx+c2sJ+xq+oEyAA--.18402S3;
 Thu, 05 Nov 2026 14:52:29 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: pillow <waysorrypub@gmail.com>
Subject: [PULL 05/13] tests/data/acpi/loongarch64: Update expected DSDT.*
Date: Thu,  5 Nov 2026 14:53:37 +0800
Message-ID: <20261105065345.966691-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105065345.966691-1-maobibo@loongson.cn>
References: <20261105065345.966691-1-maobibo@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCx+c2sJ+xq+oEyAA--.18402S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Xw4fWr1rJrWkAr4xAF4rXrc_yoWxZFy5p3
 43Z3sxKr1xAFnrGr909Fn5ZFn3trZF9rZxWFyvqr1akF45Cr90va4akr9aga4UA345Xay8
 tFyDWr1rtF9YgFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
 kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j8CztUUUUU=
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

    --- tests/data/acpi/loongarch64/virt/DSDT (before)
    +++ tests/data/acpi/loongarch64/virt/DSDT (after)
    @@ -6,7 +6,6 @@
             {
                 Name (_HID, "PNP0501" /* 16550A-compatible COM Serial Port */)  // _HID: Hardware ID
                 Name (_UID, Zero)  // _UID: Unique ID
    -            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
                 Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                 {
                     QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
    @@ -21,18 +20,6 @@
                         0x00000042,
                     }
                 })
    -            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
    -            {
    -                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
    -                Package (0x01)
    -                {
    -                    Package (0x02)
    -                    {
    -                        0x05F5E100,
    -                        "clock-frenquency"
    -                    }
    -                }
    -            })
             }
         }

    @@ -42,7 +29,6 @@
             {
                 Name (_HID, "PNP0501" /* 16550A-compatible COM Serial Port */)  // _HID: Hardware ID
                 Name (_UID, One)  // _UID: Unique ID
    -            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
                 Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                 {
                     QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
    @@ -57,18 +43,6 @@
                         0x00000043,
                     }
                 })
    -            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
    -            {
    -                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
    -                Package (0x01)
    -                {
    -                    Package (0x02)
    -                    {
    -                        0x05F5E100,
    -                        "clock-frenquency"
    -                    }
    -                }
    -            })
             }
         }

    @@ -78,7 +52,6 @@
             {
                 Name (_HID, "PNP0501" /* 16550A-compatible COM Serial Port */)  // _HID: Hardware ID
                 Name (_UID, 0x02)  // _UID: Unique ID
    -            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
                 Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                 {
                     QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
    @@ -93,18 +66,6 @@
                         0x00000044,
                     }
                 })
    -            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
    -            {
    -                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
    -                Package (0x01)
    -                {
    -                    Package (0x02)
    -                    {
    -                        0x05F5E100,
    -                        "clock-frenquency"
    -                    }
    -                }
    -            })
             }
         }

    @@ -114,7 +75,6 @@
             {
                 Name (_HID, "PNP0501" /* 16550A-compatible COM Serial Port */)  // _HID: Hardware ID
                 Name (_UID, 0x03)  // _UID: Unique ID
    -            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
                 Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                 {
                     QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
    @@ -127,18 +87,6 @@
                     Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )
                     {
                         0x00000045,
    -                }
    -            })
    -            Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
    -            {
    -                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
    -                Package (0x01)
    -                {
    -                    Package (0x02)
    -                    {
    -                        0x05F5E100,
    -                        "clock-frenquency"
    -                    }
                     }
                 })
             }

Signed-off-by: pillow <waysorrypub@gmail.com>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 tests/data/acpi/loongarch64/virt/DSDT         | Bin 4603 -> 4351 bytes
 tests/data/acpi/loongarch64/virt/DSDT.memhp   | Bin 5824 -> 5572 bytes
 tests/data/acpi/loongarch64/virt/DSDT.numamem | Bin 4609 -> 4357 bytes
 .../data/acpi/loongarch64/virt/DSDT.topology  | Bin 4905 -> 4653 bytes
 tests/qtest/bios-tables-test-allowed-diff.h   |   4 ----
 5 files changed, 4 deletions(-)

diff --git a/tests/data/acpi/loongarch64/virt/DSDT b/tests/data/acpi/loongarch64/virt/DSDT
index 09aa903c4e875f541223e36f59b28e101599df20..9850873cfe67a9397149967c66690933f2b69d94 100644
GIT binary patch
delta 133
zcmeyZ{9lpFCD<k8zW@URBjZFaX)YJG_+Y2_=q4Z5iTctLzlcsu)lw2b2s-=w8gj&Y
zc)IWg_yri48W=Kg#D{viO#I-?FW?H*>I+h3G+BX3gpq0DM~TVn7`3>OBqz%-$xQqr
OIysn0Yx6cHSAGEAdL^#_

delta 368
zcmeyb_*<FFCD<k8w;%%pW6VS@X)b53_+Y2_=q7K@iTct^&W;mTOHPc}O5})l33d@O
zW)c+U5)irZ|JJU&9^bBsduH$VTFfXU!zd)l#KZ9LD=TkuPJVK>Zdy@lUSVl!UUDUa
z0K!0Le_un6cn?n(-T=P<15*P-29EepPZvgxcxRA3&MxFz;sSNG59h?6G7wi!)?(D6
Yiiwls8DU0FVAL`v(~+BZFuL;t03+sg%K!iX

diff --git a/tests/data/acpi/loongarch64/virt/DSDT.memhp b/tests/data/acpi/loongarch64/virt/DSDT.memhp
index a069d6878fb45fa6b0e6342eedb0eb3d25eb20da..5a6a3bc29e75ff5a20b7aa1d87dfff0cf8595668 100644
GIT binary patch
delta 133
zcmX@0dqkVdCD<k8h$sUCBilqSX)YJG_+Y2_=q4Z5iTctLzlcsu)lw2b2s-=w8gj&Y
zc)IWg_yri48W=Kg#D{viO#I-?FW?H*>I+h3G+BX3gpq0DM~TVn7`3>OBqz%-$xQqr
OIysn0Yx6cHE)f8elO*N<

delta 368
zcmX@2eL$DXCD<k8fEWV<W8y?EX)b53_+Y2_=q7K@iTct^&W;mTOHPc}O5})l33d@O
zW)c+U5)irZ|JJU&9^bBsduH$VTFfXU!zd)l#KZ9LD=TkuPJVK>Zdy@lUSVl!UUDUa
z0K!0Le_un6cn?n(-T=P<15*P-29EepPZvgxcxRA3&MxFz;sSNG59h?6G7wi!)?(D6
Yiiwls8DU0FVAL`v(~+BZF!G2108#&S0ssI2

diff --git a/tests/data/acpi/loongarch64/virt/DSDT.numamem b/tests/data/acpi/loongarch64/virt/DSDT.numamem
index 78ece52f57a383db128c7d1a08526e15ab911bb7..3a6580b4ee93f9d2a44faffd6ffe9d3ae9ecd4d2 100644
GIT binary patch
delta 133
zcmZovX;tEK33dr#6=Yyw?3u_V&E>)tAM6w#-Q>eMQD1uE7tx8ST1o;4L1%woLymY4
zPZ!<*zW@VM149Om_)t%mi65N#1ze$8eL<>>CMz(BFfvX2C^2~*qZT)k<YXBpnTcOS
OCkHcWZQjP@%?|)6yd+fs

delta 368
zcmZowYE<EJ33dr#6k=dtd_Iv&n#-9hKG-Qfy2+b!qP{efv*X0ok`v>#5;@{sf?b4+
znFNKo1VnE9zqKo`$G2<Zp4t1o7BdRTFbYXB@i096%F3IZlb@Wen^u&XS6G^wmt4sp
zfH2V6-`9{M-ow*{H^48zz|_Eyfg?WD(}j^E-Wg<%vkUo_xIkU)!#VM%48+xwwHURi
XV&dd@MwpQk7`4pFbmZn8jK2H;E9!J{

diff --git a/tests/data/acpi/loongarch64/virt/DSDT.topology b/tests/data/acpi/loongarch64/virt/DSDT.topology
index 7ab23f47cc82dd7bc1975e17893a8cd61039e66d..7901fd9e07225a9d726f94e83e11724d9daae013 100644
GIT binary patch
delta 133
zcmZ3fwpNA9CD<iISBQauv1B5bG?xooe6Uk|bdwM3M1ARrUqmOSYAFdI1fBhT4LRaH
zJY9GL`~nP24GbAL;zK=MCVp_{7jT7Y^#!RinykPi!pJo7qr~KOj9T1Cl9OeaWF~$Q
OogB=hwRsy;u>b&G3?$<K

delta 368
zcmZ3hvQmx9CD<iIQ<#B)@%%(CX)b53_+Y2_=q7K@iTct^&W;mTOHPc}O5})l33d@O
zW)c+U5)irZ|JJU&9^bBsduH$VTFfXU!zd)l#KZ9LD=TkuPJVK>Zdy@lUSVl!UUDUa
z0K!0Le_un6cn?n(-T=P<15*P-29EepPZvgxcxRA3&MxFz;sSNG59h?6G7wi!)?(D6
Yiiwls8DU0FVAL`v(~+BZFqR4c0KD;Z{{R30

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 2ed837faee..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,5 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/loongarch64/virt/DSDT",
-"tests/data/acpi/loongarch64/virt/DSDT.memhp",
-"tests/data/acpi/loongarch64/virt/DSDT.numamem",
-"tests/data/acpi/loongarch64/virt/DSDT.topology",
-- 
2.54.0


