Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05789C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 15:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXLSi-0000ik-2K; Thu, 03 Jul 2025 11:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uXLSc-0000iK-KQ; Thu, 03 Jul 2025 11:02:51 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uXLSX-0001TP-L8; Thu, 03 Jul 2025 11:02:49 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bY0NZ4g0Pz6L5XT;
 Thu,  3 Jul 2025 23:02:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id EAEA21404C4;
 Thu,  3 Jul 2025 23:02:35 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 3 Jul
 2025 17:02:35 +0200
Date: Thu, 3 Jul 2025 16:02:33 +0100
To: Eric Auger <eric.auger@redhat.com>
CC: <eric.auger.pro@gmail.com>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>, <peter.maydell@linaro.org>, <imammedo@redhat.com>,
 <gustavo.romero@linaro.org>, <anisinha@redhat.com>, <mst@redhat.com>,
 <shannon.zhaosl@gmail.com>, <pbonzini@redhat.com>, <philmd@linaro.org>,
 <alex.bennee@linaro.org>
Subject: Re: [PATCH v5 35/36] qtest/bios-tables-test: Generate reference
 blob for DSDT.hpoffacpiindex
Message-ID: <20250703160233.00001571@huawei.com>
In-Reply-To: <20250703123728.414386-36-eric.auger@redhat.com>
References: <20250703123728.414386-1-eric.auger@redhat.com>
 <20250703123728.414386-36-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu,  3 Jul 2025 14:35:35 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> The disassembled DSDT table is given below

I'd suggest maybe a spot of cropping to bring this down to a reasonable length.
See inline.

Otherwise LGTM

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> 
>  * Original Table Header:
>  *     Signature        "DSDT"
>  *     Length           0x000014E3 (5347)
>  *     Revision         0x02
>  *     Checksum         0x92
>  *     OEM ID           "BOCHS "
>  *     OEM Table ID     "BXPC    "
>  *     OEM Revision     0x00000001 (1)
>  *     Compiler ID      "BXPC"
>  *     Compiler Version 0x00000001 (1)
>  */
> DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
> {
>     Scope (\_SB)
>     {
>         Device (C000)
>         {
>             Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
>             Name (_UID, Zero)  // _UID: Unique ID
>         }
> 
>         Device (COM0)
>         {
>             Name (_HID, "ARMH0011")  // _HID: Hardware ID
>             Name (_UID, Zero)  // _UID: Unique ID
>             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
>             {
>                 Memory32Fixed (ReadWrite,
>                     0x09000000,         // Address Base
>                     0x00001000,         // Address Length
>                     )
>                 Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
>                 {
>                     0x00000021,
>                 }
>             })
>         }
> 
>         Device (FWCF)
>         {
>             Name (_HID, "QEMU0002")  // _HID: Hardware ID
>             Name (_STA, 0x0B)  // _STA: Status
>             Name (_CCA, One)  // _CCA: Cache Coherency Attribute
>             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
>             {
>                 Memory32Fixed (ReadWrite,
>                     0x09020000,         // Address Base
>                     0x00000018,         // Address Length
>                     )
>             })
>         }
> 
>         Device (VR00)
>         {
>             Name (_HID, "LNRO0005")  // _HID: Hardware ID
>             Name (_UID, Zero)  // _UID: Unique ID
>             Name (_CCA, One)  // _CCA: Cache Coherency Attribute
>             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
>             {
>                 Memory32Fixed (ReadWrite,
>                     0x0A000000,         // Address Base
>                     0x00000200,         // Address Length
>                     )
>                 Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
>                 {
>                     0x00000030,
>                 }
>             })
>         }
If you want to keep these, maybe a single representative LNRO0005 only.

> 
>         Device (PCI0)
>         {
>             Name (_HID, "PNP0A08" /* PCI Express Bus */)  // _HID: Hardware ID
>             Name (_CID, "PNP0A03" /* PCI Bus */)  // _CID: Compatible ID
>             Name (_SEG, Zero)  // _SEG: PCI Segment
>             Name (_BBN, Zero)  // _BBN: BIOS Bus Number
>             Name (_UID, Zero)  // _UID: Unique ID
>             Name (_STR, Unicode ("PCIe 0 Device"))  // _STR: Description String
>             Name (_CCA, One)  // _CCA: Cache Coherency Attribute
>             Name (_PRT, Package (0x80)  // _PRT: PCI Routing Table
>             {
>                 Package (0x04)
>                 {
>                     0xFFFF,
>                     Zero,
>                     L000,
>                     Zero
>                 },
> 

Could probably crop this to just leave a representative chunk.

>             })
>             Method (_CBA, 0, NotSerialized)  // _CBA: Configuration Base Address
>             {
>                 Return (0x0000004010000000)
>             }
> 
>             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
>             {
>                 WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
>                     0x0000,             // Granularity
>                     0x0000,             // Range Minimum
>                     0x00FF,             // Range Maximum
>                     0x0000,             // Translation Offset
>                     0x0100,             // Length
>                     ,, )
>                 DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
>                     0x00000000,         // Granularity
>                     0x10000000,         // Range Minimum
>                     0x3EFEFFFF,         // Range Maximum
>                     0x00000000,         // Translation Offset
>                     0x2EFF0000,         // Length
>                     ,, , AddressRangeMemory, TypeStatic)
>                 DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
>                     0x00000000,         // Granularity
>                     0x00000000,         // Range Minimum
>                     0x0000FFFF,         // Range Maximum
>                     0x3EFF0000,         // Translation Offset
>                     0x00010000,         // Length
>                     ,, , TypeStatic, DenseTranslation)
>                 QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
>                     0x0000000000000000, // Granularity
>                     0x0000008000000000, // Range Minimum
>                     0x000000FFFFFFFFFF, // Range Maximum
>                     0x0000000000000000, // Translation Offset
>                     0x0000008000000000, // Length
>                     ,, , AddressRangeMemory, TypeStatic)
>             })
>             Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
>             {
>                 CreateDWordField (Arg3, Zero, CDW1)
>                 If ((Arg0 == ToUUID ("33db4d5b-1ff7-401c-9657-7441c03dd766") /* PCI Host Bridge Device */))
>                 {
>                     CreateDWordField (Arg3, 0x04, CDW2)
>                     CreateDWordField (Arg3, 0x08, CDW3)
>                     Local0 = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
>                     Local0 &= 0x1F
>                     If ((Arg1 != One))
>                     {
>                         CDW1 |= 0x08
>                     }
> 
>                     If ((CDW3 != Local0))
>                     {
>                         CDW1 |= 0x10
>                     }
> 
>                     CDW3 = Local0
>                 }
>                 Else
>                 {
>                     CDW1 |= 0x04
>                 }
> 
>                 Return (Arg3)
>             }
> 
>             Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
>             {
>                 If ((Arg0 == ToUUID ("e5c937d0-3553-4d7a-9117-ea4d19c3434d") /* Device Labeling Interface */))
>                 {
>                     If ((Arg2 == Zero))
>                     {
>                         Return (Buffer (One)
>                         {
>                              0x01                                             // .
>                         })
>                     }
>                 }
> 
>                 Return (Buffer (One)
>                 {
>                      0x00                                             // .
>                 })
>             }
> 
>             Device (RES0)
>             {
>                 Name (_HID, "PNP0C02" /* PNP Motherboard Resources */)  // _HID: Hardware ID
>                 Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
>                 {
>                     QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
>                         0x0000000000000000, // Granularity
>                         0x0000004010000000, // Range Minimum
>                         0x000000401FFFFFFF, // Range Maximum
>                         0x0000000000000000, // Translation Offset
>                         0x0000000010000000, // Length
>                         ,, , AddressRangeMemory, TypeStatic)
>                 })
>             }
>         }
> 
>         Device (\_SB.GED)
>         {
>             Name (_HID, "ACPI0013" /* Generic Event Device */)  // _HID: Hardware ID
>             Name (_UID, "GED")  // _UID: Unique ID
>             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
>             {
>                 Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
>                 {
>                     0x00000029,
>                 }
>             })
>             OperationRegion (EREG, SystemMemory, 0x09080000, 0x04)
>             Field (EREG, DWordAcc, NoLock, WriteAsZeros)
>             {
>                 ESEL,   32
>             }
> 
>             Method (_EVT, 1, Serialized)  // _EVT: Event
>             {
>                 Local0 = ESEL /* \_SB_.GED_.ESEL */
>                 If (((Local0 & 0x02) == 0x02))
>                 {
>                     Notify (PWRB, 0x80) // Status Change
>                 }
>             }
>         }
> 
>         Device (PWRB)
>         {
>             Name (_HID, "PNP0C0C" /* Power Button Device */)  // _HID: Hardware ID
>             Name (_UID, Zero)  // _UID: Unique ID
>         }
>     }
> 
>     Scope (\_SB.PCI0)
>     {
>         Method (EDSM, 5, Serialized)
>         {
>             If ((Arg2 == Zero))
>             {
>                 Local0 = Buffer (One)
>                     {
>                          0x00                                             // .
>                     }
>                 If ((Arg0 != ToUUID ("e5c937d0-3553-4d7a-9117-ea4d19c3434d") /* Device Labeling Interface */))
>                 {
>                     Return (Local0)
>                 }
> 
>                 If ((Arg1 < 0x02))
>                 {
>                     Return (Local0)
>                 }
> 
>                 Local0 [Zero] = 0x81
>                 Return (Local0)
>             }
> 
>             If ((Arg2 == 0x07))
>             {
>                 Local0 = Package (0x02)
>                     {
>                         Zero,
>                         ""
>                     }
>                 Local1 = DerefOf (Arg4 [Zero])
>                 Local0 [Zero] = Local1
>                 Return (Local0)
>             }
>         }
> 
>         Device (S00)
>         {
>             Name (_ADR, Zero)  // _ADR: Address
>         }
> 
>         Device (S08)
>         {
>             Name (_ADR, 0x00010000)  // _ADR: Address
>         }
> 
>         Device (S38)
>         {
>             Name (_ADR, 0x00070000)  // _ADR: Address
>             Device (S00)
>             {
>                 Name (_ADR, Zero)  // _ADR: Address
>                 Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
>                 {
>                     Local0 = Package (0x01)
>                         {
>                             0x0C
>                         }
>                     Return (EDSM (Arg0, Arg1, Arg2, Arg3, Local0))
>                 }
>             }
>         }
>     }
> }
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  tests/qtest/bios-tables-test-allowed-diff.h      |   1 -
>  tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex | Bin 0 -> 5347 bytes
>  2 files changed, 1 deletion(-)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index 02f4f0b29f..dc3ab24d05 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,3 +1,2 @@
>  /* List of comma-separated changed AML files to ignore */
>  "tests/data/acpi/aarch64/virt/DSDT.acpipcihp",
> -"tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex",
> diff --git a/tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex b/tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex
> index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..970d43f68bca060361105f70dbb00b3a25646db4 100644
> GIT binary patch
> literal 5347
> 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  
> 
> literal 0
> HcmV?d00001
> 


