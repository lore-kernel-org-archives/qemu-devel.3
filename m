Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698E5606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Bl4oufo8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJn9B-0001aV-Oz; Thu, 22 Oct 2026 03:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xJn99-0001Un-ME
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:23:31 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <waysorrypub@gmail.com>)
 id 1xJn97-0008OA-Oy
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:23:31 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-8a06c60065fso1032661b3a.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 00:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792653808; x=1793258608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iDnGrXeM5qJS/HIDFGKBt8d4A+hZNduu22wnKbnAdwM=;
 b=Bl4oufo8rRo2J3oijjNESa7jjQ900njUyZFTIhQaU1ikyJ4OYrZSQhgRDOtn6RccI/
 v1Ym19lQZg02rEtgDLuD8rUeWqWDOVEuJOEd5NTQLn77no4T/SwaMak5G6/pTti14QG8
 sxt4GFO7syUGj41LWUAqei2XKpUyZ7fY7dRXwIJ3mxIC3PhFqAiETPe5TAbl5fVxAq8l
 glxxZhgou2QJ0BbrUyV/Aj+tfDBu/4FFCHU0oxBRDnlt76D+xKC2f01mujyZWszynf8j
 Fkfg/OHHaE+bbEXTgSub6INPW2QWbSY9xCjYeL2NTBBoT84rz9Ls3tOrralDLJi7EBYw
 Q/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792653808; x=1793258608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iDnGrXeM5qJS/HIDFGKBt8d4A+hZNduu22wnKbnAdwM=;
 b=f+JQenyAXm1ZfCm6y08K8VEymdRq0FlkmjDzFDzJQ9UtmOUhktLABmuDrFhi5ydsiu
 yliAaS+Wrwv6WvVfNcAazb3/7XDaAk2xwiUzuU/VyBC73Zc790HtKO0RIuFaGqCd4PPe
 9vmdgwVnupm2gK9Sm3ghdDFNQUQPsK01/IK03aFoxClsbqmI2T1IoPCXWFQA3u9AHjKi
 Vc35lxp781sqwgVbEDj6Sv0BlhPpiKD3Z1nqUGNq+OZJ4Gr1/cqpMcmVdOd1NbUZ4Aee
 DX5Jy1XYrUqPo+qjw+LOZnPxmGsGCy2o4IhRIKWj0wUJ9uYIj1V6OkItpMVCW+WGvnts
 JDTw==
X-Gm-Message-State: AFq9FYIL4Z8YiLrIF4E1BqxTVLytWLTe2TXdFUjFg4w4z58ZqFdCI1b5
 IENc0HHEHJyvXEXMOYaOXIHOEi0gipxqGa/OZ1M2QLpsUPVEt7/CC8Rm1e5Mekq6Sck=
X-Gm-Gg: AYBFou0iyniLA5Bj6dOEuLaFrThdwO3SSM84wZQFBPKXM7/M7fqk/ajHNsJd4YlewWA
 uIZGvUwQQWpU+RgluM0YJCYNy9aThMJR+c0KwhA/WCIFhCn6VDpqoKj7Eh4p+cY2MUscVjU3Tjx
 FFUfe2GetbGWmv+fnWHd2lhoKD5s3XYuzvoxKRdQQpABbKKbFHa9OXL4luAChFPzHYCa8n3etbd
 N1NUDNplTM+Isv6ZRuMXoxn0z1xLQDbzze3tMToVCuD7EIAGaQXe+RSMv6sn2jHRUjvWgyNxf6y
 tLmRs+UPut0caUYrG2PuAsHjgPPLK0YLjupqWDJnEJ13iBU2stCPqlLEMd8Qh18lySlGIKXnmC4
 uk46bdbgpRDwRfZVXVNXhtptpuDi/U2oj5IyWfxdbBHiMeci7BcKrYt7IcNQdrOxLk4lGMw1Tah
 PnN6ZoQM7c4+zKbAZMCQQwbF0fJ1vdrF6Amw98qsGybax9PPhfb5BBqQLLBrukADdvrQNeT2AzI
 dETvpiFoY8ScvmEBB15AbJ1qws7k53JsRJ650mkzAw6RRedcwjBJ+h6QQCw
X-Received: by 2002:a05:6a00:1c85:b0:880:f278:6b0b with SMTP id
 d2e1a72fcca58-8a089c474d4mr3264750b3a.4.1792653808329; 
 Thu, 22 Oct 2026 00:23:28 -0700 (PDT)
Received: from archlinux ([2409:8949:4c8c:84e:a337:63b8:1a6e:7a9b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a0894b49dcsm1699776b3a.16.2026.10.22.00.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 00:23:28 -0700 (PDT)
From: pillow <waysorrypub@gmail.com>
To: qemu-devel@nongnu.org
Cc: 17746591750@163.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 jiaxun.yang@flygoat.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, pillow <waysorrypub@gmail.com>
Subject: [PATCH v4 3/4] tests/data/acpi/loongarch64: Update expected DSDT.*
Date: Thu, 22 Oct 2026 15:22:37 +0800
Message-ID: <20261022072238.319308-4-waysorrypub@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022072238.319308-1-waysorrypub@gmail.com>
References: <20261022072238.319308-1-waysorrypub@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=waysorrypub@gmail.com; helo=mail-pf1-x42d.google.com
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
    @@ -6,7 +6,7 @@
             {
                 Name (_HID, "PNP0501" /* 16550A-compatible COM Serial Port */)  // _HID: Hardware ID
                 Name (_UID, Zero)  // _UID: Unique ID
    -            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
    +            Name (_STA, 0x0F)  // _STA: Status
                 Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                 {
                     QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
    @@ -21,18 +21,6 @@
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

    @@ -42,7 +30,7 @@
             {
                 Name (_HID, "PNP0501" /* 16550A-compatible COM Serial Port */)  // _HID: Hardware ID
                 Name (_UID, One)  // _UID: Unique ID
    -            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
    +            Name (_STA, 0x0F)  // _STA: Status
                 Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                 {
                     QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
    @@ -57,18 +45,6 @@
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

    @@ -78,7 +54,7 @@
             {
                 Name (_HID, "PNP0501" /* 16550A-compatible COM Serial Port */)  // _HID: Hardware ID
                 Name (_UID, 0x02)  // _UID: Unique ID
    -            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
    +            Name (_STA, 0x0F)  // _STA: Status
                 Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                 {
                     QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
    @@ -93,18 +69,6 @@
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

    @@ -114,7 +78,7 @@
             {
                 Name (_HID, "PNP0501" /* 16550A-compatible COM Serial Port */)  // _HID: Hardware ID
                 Name (_UID, 0x03)  // _UID: Unique ID
    -            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
    +            Name (_STA, 0x0F)  // _STA: Status
                 Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                 {
                     QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
    @@ -127,18 +91,6 @@
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
 tests/data/acpi/loongarch64/virt/DSDT         | Bin 4603 -> 4379 bytes
 tests/data/acpi/loongarch64/virt/DSDT.memhp   | Bin 5824 -> 5600 bytes
 tests/data/acpi/loongarch64/virt/DSDT.numamem | Bin 4609 -> 4385 bytes
 .../data/acpi/loongarch64/virt/DSDT.topology  | Bin 4905 -> 4681 bytes
 tests/qtest/bios-tables-test-allowed-diff.h   |   4 ----
 5 files changed, 4 deletions(-)

diff --git a/tests/data/acpi/loongarch64/virt/DSDT b/tests/data/acpi/loongarch64/virt/DSDT
index 09aa903c4e875f541223e36f59b28e101599df20..686d9078e4d61558d65bdcfec76a2428b83ef56d 100644
GIT binary patch
delta 160
zcmeyZJX?v&CD<iIT9AQ((PJW)G?zD9e6Uk|bdxjNM13jN;1EYH{)rzYCZ=j>2_U4L
z{e2BN;ypZFcmw<b3``9S893rYJzW?%;-MOx_yv5R2Dz{~`}-PAR$vn0V1mm_OkT&R
Y#f_w9vJ8_n+_uTVOj?__F}d;s0NpGpmH+?%

delta 398
zcmbQO^jn$BCD<k8w;%%pW6VS@X)b53_+Y2_=q7K@iTYA3&d!dE6aAcAIO1J`U4)F8
z1ckW-L~i`QwJWd3w`<~_+55c~GYZKt3Q02YFg*Oq%A1^%pPa3mR+O4oSelxbT*)AS
zWZrC;c@h&ZX(f|yqzlxEKAg_}zD6AJ9-c0|0e%4nrUr%#9Py!^E?i6;@er3wOtxpF
ZnpMWwtYSu3wT4m4oJ?PBzQX9v4*-y-dI$gj

diff --git a/tests/data/acpi/loongarch64/virt/DSDT.memhp b/tests/data/acpi/loongarch64/virt/DSDT.memhp
index a069d6878fb45fa6b0e6342eedb0eb3d25eb20da..fb2104170a134bdd414f9f5456f2e37e3489b749 100644
GIT binary patch
delta 160
zcmX@0`#_t^CD<k8fhYq5qu)d>X)bTJ_+Y2_=q6{jiTYBk!6A-Z{1ZP)Oib0%5<o~f
z`}-Pl#Cv$U@CNt=7?>IuGH}F)db%)j#6vYW@eBAs4RT>~_V+cKtiU9~!339=n7ocr
YiyKMJWEm!DxNVbznY1=<W8xA40BABQOaK4?

delta 398
zcmaE$eL$DXCD<k8fEWV<W8y?EX)b53_+Y2_=q7K@iTYA3&d!dE6aAcAIO1J`U4)F8
z1ckW-L~i`QwJWd3w`<~_+55c~GYZKt3Q02YFg*Oq%A1^%pPa3mR+O4oSelxbT*)AS
zWZrC;c@h&ZX(f|yqzlxEKAg_}zD6AJ9-c0|0e%4nrUr%#9Py!^E?i6;@er3wOtxpF
ZnpMWwtYSu3wT4m4oJ?PBzQV{O0swOedA<Mu

diff --git a/tests/data/acpi/loongarch64/virt/DSDT.numamem b/tests/data/acpi/loongarch64/virt/DSDT.numamem
index 78ece52f57a383db128c7d1a08526e15ab911bb7..62374112f9e83ead0be549c8e17bdfe7941017e3 100644
GIT binary patch
delta 160
zcmZovS*XP266_M9D9FITcx57&G?zD9e6Uk|bdxjNM13jN;1EYH{)rzYCZ=j>2_U4L
z{e2BN;ypZFcmw<b3``9S893rYJzW?%;-MOx_yv5R2Dz{~`}-PAR$vn0V1mm_OkT&R
Y#f_w9vJ8_n+_uTVOj?__F?sU?0O+kLy8r+H

delta 398
zcmZ3e)TqMc66_MfD8#_P_<SOlG?z11e6Uk|bdxvdM13h1XJ<#oiGEHl9Puu}E<(mk
zg2G$^A~*iu+LhPi+cj~|?EPMg8HHpRg(R7H7#@CQ<xS4XPtMj&D@x5PEKSWzu4E8E
zGH*7_Jc)^yw35j;(go^7A5Ld~Un7oq4^J1~0KWhOQv*W=j`&bd7cM4_c!<j-CfhSo
Z%_?JTRxu;2TEnPiPNuImUt#p+2LLqfc`X0{

diff --git a/tests/data/acpi/loongarch64/virt/DSDT.topology b/tests/data/acpi/loongarch64/virt/DSDT.topology
index 7ab23f47cc82dd7bc1975e17893a8cd61039e66d..9c37939f91334659662ec9f6dc1f941572029e7f 100644
GIT binary patch
delta 160
zcmZ3fc2b4QCD<jzQ;30qanD39X)bTJ_+Y2_=q6{jiTYBk!6A-Z{1ZP)Oib0%5<o~f
z`}-Pl#Cv$U@CNt=7?>IuGH}F)db%)j#6vYW@eBAs4RT>~_V+cKtiU9~!339=n7ocr
YiyKMJWEm!DxNVbznY1=<V=5K^04K95NdN!<

delta 398
zcmX@9vQmx9CD<iIQ<#B)@%%(CX)b53_+Y2_=q7K@iTYA3&d!dE6aAcAIO1J`U4)F8
z1ckW-L~i`QwJWd3w`<~_+55c~GYZKt3Q02YFg*Oq%A1^%pPa3mR+O4oSelxbT*)AS
zWZrC;c@h&ZX(f|yqzlxEKAg_}zD6AJ9-c0|0e%4nrUr%#9Py!^E?i6;@er3wOtxpF
ZnpMWwtYSu3wT4m4oJ?PBzQR~4007a-dAk4r

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


