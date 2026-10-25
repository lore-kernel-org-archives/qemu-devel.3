Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B399B606A327
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 13:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FkyWWeil
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKyj0-0002Q4-MP; Sun, 25 Oct 2026 09:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xKyil-0002PP-Nt
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 09:57:11 -0400
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xKyij-0007Sq-Ey
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 09:57:11 -0400
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-35f1f76ea84so3785657eec.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 06:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792936628; x=1793541428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zNGNZ8yHXsIEHpJ8q8VFf36/hM43X21RvpSY4NIHw+0=;
 b=FkyWWeilt9JI38jXPdeIE5HxAfAqTV18DGc5XrVly0lqe2f8SgQCb0ecfZhWjvDCLX
 ryzPXDR7TL+1JwnzKzpQc1HQlIDWHOr4yhfbB469GjTvjt2qC/pWQ/8iQZxK7nTokgot
 sxxObpdfbtDrXx8qlZsEVU9gJuGG1yPI/qnycRxFr8eSF8Rl4NS5RjX1EDU1OZnpcTvH
 cyvrKH9bpjx9Vxv7ow0U15VZ2qG5j6oeJnSXg/hwVHO2rccLUj69qE3cRZwMnUE0Ilzc
 uw9LwNtOJGiAM4ksxCADWksUEik69daAmUWRXRncm85aBjDkFBV69/zhl2Rbho9Awheo
 r6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792936628; x=1793541428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zNGNZ8yHXsIEHpJ8q8VFf36/hM43X21RvpSY4NIHw+0=;
 b=GcHSsTxfYAIFAzxf9RA80MeimSL7ZIh3apRqrOkf4bAB63btTcH8UhaKO75+cm8+n0
 a2vEfCLB/7643XJDj1FjSlBeZSppnRBlPGGX1GJEJW3/qWNkgX2jOG+4oXqMtSgibCSc
 UvtFxfo6sf8+ed0fCLFCi/OEIpRfhIJSWWYPEBbNKthYGsaq0Q5/ncG0zfWppe0qwars
 sBj/PSfpABabfbvMKHLNziijgLVl6u7XUMYGwT32RYgFI3MfKyvYT+tQufOfcyfHTS1o
 tfzVhy0K1lg7IkchZqDQz7reu4mn4E+mowM1otVr/m2MFi8Aj/EMH/I0VrmBgI/EBxbM
 cEEg==
X-Gm-Message-State: AFq9FYLnDG8Z+bjTpFyvrN0UdVdOqH9SLHVUXYk+t2WmtNK+ab/tD1XP
 dBPp7TUIyDY8WU1cD6kEftJ/d2xXzNso5pcoubZ2RZakSHA+rxVBw1i4PwIVXJV5
X-Gm-Gg: AYBFou1UpQGSWLEy5YCz3IzAwwt2rBkG75/DnkCyZ8rED74J2E07SXsaeAa03orjXQt
 4+AqfM4oFtrKv3yjJIh4NyGJCulK/xpoP0+V1eV6EKl6QtkWO8TxzfxGKhAYZaGe0UFKPzu9U3s
 jAwLq9w180MqHm1AqfCTmSS1RiVPwd4r3IguM7XpWasJTPRGQnzGPIvrEvgv1hDX4AUdgIqRJYJ
 yPZMKUpZSMSoRBpir/BbXISk5rfbxt3lqVFlsOdwCueOiV5urps/BKv624a2gEDvYB1VUvvWLZB
 A2QwYjlPjzloIdsLfqTOS+4aIkkL+u7aeh+jzRIIDOEY11Q+ClYBU1IPcwyhl9CT9UFV+BazDGc
 d1UDPyawYDB7NHES5+4rQYB446qs9PU+dC2ChehWj7FCE+6a6oGIqliY1E10XEWbkCCbRVaHBel
 AG0qL/2PZWPMJHnIrwry+VNtb43lpLdkya8D5R7AOqV3SpmzVrA5XA95HFeoVXVKmOfm+SPe16g
 9ejuXYGqA4rQm0H2BPgN3VtxkC4qz84UVKshrr6H3r82qFSO+KBB+sYEvp7Ch35oTJ3XcADNBXU
 /HN52DA=
X-Received: by 2002:a05:693c:63d0:b0:369:fdae:c9fd with SMTP id
 5a478bee46e88-369fdaece2emr1223848eec.13.1792936627875; 
 Sun, 25 Oct 2026 06:57:07 -0700 (PDT)
Received: from archlinux ([2409:8949:4c8c:84e:a337:63b8:1a6e:7a9b])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8d845ddsm16795724eec.11.2026.10.25.06.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 06:57:07 -0700 (PDT)
From: pillow <waysorrypub@gmail.com>
To: qemu-devel@nongnu.org
Cc: 17746591750@163.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 jiaxun.yang@flygoat.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, waysorrypub@gmail.com
Subject: [PATCH v5 5/5] tests/data/acpi/loongarch64: Update expected DSDT.*
Date: Sun, 25 Oct 2026 21:55:59 +0800
Message-ID: <20261025135559.236356-6-waysorrypub@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261025135559.236356-1-waysorrypub@gmail.com>
References: <20261025135559.236356-1-waysorrypub@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1329;
 envelope-from=waysorrypub@gmail.com; helo=mail-dy1-x1329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
zc)IWg_yri48W=Kg#D{viO#I-?FW?H*>dWfv?`t$!fk}jsY2rtT$?F)kxRE3$%P`4I
Q{31Fzm`Q8%HYQho0N#2fuK)l5

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
zc)IWg_yri48W=Kg#D{viO#I-?FW?H*>dWfv?`t$!fk}jsY2rtT$?F)kxRE3$%P`4I
Q{31Fzm`Q8%HYP3+0F#p><^TWy

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
zPZ!<*zW@VM149Om_)t%mi65N#1ze$8eOaCTeT^n7Fo`fSP5dY^c^#t`H<ILJ877&D
QUqmMdGihz!#^lWp04cmARR910

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
zJY9GL`~nP24GbAL;zK=MCVp_{7jT7Y^<{PT_cfZVz$C)RH1VUv<aLZ%+(?p>Wte0p
Qei5A<%%rt>8&k0W0A36v;{X5v

delta 368
zcmZ3hvQmx9CD<iIQ<#B)@%%(CX)b53_+Y2_=q7K@iTct^&W;mTOHPc}O5})l33d@O
zW)c+U5)irZ|JJU&9^bBsduH$VTFfXU!zd)l#KZ9LD=TkuPJVK>Zdy@lUSVl!UUDUa
z0K!0Le_un6cn?n(-T=P<15*P-29EepPZvgxcxRA3&MxFz;sSNG59h?6G7wi!)?(D6
Yiiwls8DU0FVAL`v(~+BZFqR4c0KD;Z{{R30

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 2ed837f..dfb8523 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,5 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/loongarch64/virt/DSDT",
-"tests/data/acpi/loongarch64/virt/DSDT.memhp",
-"tests/data/acpi/loongarch64/virt/DSDT.numamem",
-"tests/data/acpi/loongarch64/virt/DSDT.topology",
-- 
2.56.0


