Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2BAC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 09:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raXve-0007tb-Ll; Thu, 15 Feb 2024 04:21:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1raXvZ-0007jn-Dy
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 04:21:09 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1raXvU-0002hI-EF
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 04:21:09 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E43E24D7E5;
 Thu, 15 Feb 2024 12:21:02 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id BCD707FAD3;
 Thu, 15 Feb 2024 12:20:53 +0300 (MSK)
Message-ID: <39efcede-002c-49e6-be36-6637f3cb16fa@tls.msk.ru>
Date: Thu, 15 Feb 2024 12:20:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/60] virtio,pc,pci: features, cleanups, fixes
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Ira Weiny <ira.weiny@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <cover.1707909001.git.mst@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 xsBLBETIiwkBCADh3cFB56BQYPjtMZCfK6PSLR8lw8EB20rsrPeJtd91IoNZlnCjSoxd9Th1
 bLUR8YlpRJ2rjc6O1Bc04VghqUOHgS/tYt8vLjcGWixzdhSLJgPDK3QQZPAvBjMbCt1B6euC
 WuD87Pv5Udlpnzf4aMwxkgfTusx+ynae/o+T5r7tXD+isccbC3SiGhmAPxFyY3zGcFk4+Rxc
 0tP8YY2FWE/baHu+lBDTUN79efWAkHhex1XzVZsV7ZD16rzDbXFK5m6ApvGJWlr5YDEEydTF
 WwmvwBfr4OINVxzEG/ujNiG4fpMf2NsnFGyB9aSbFjXZevB4qWkduYYW+xpK1EryszHtAAYp
 zSBNaWNoYWVsIFRva2FyZXYgPG1qdEB0bHMubXNrLnJ1PsLAlgQTAQoAQAIbAwYLCQgHAwIE
 FQIIAwQWAgMBAh4BAheAAhkBFiEEbuGV0Yhuj/uBDUMkRXzgoIBEZcUFAmBbcjwFCS5e6jMA
 CgkQRXzgoIBEZcUTIQgA1hPsOF82pXxbcJXBMc4zB9OQu4AlnZvERoGyw7I2222QzaN3RFuj
 Fia//mapXzpIQNF08l/AA6cx+CKPeGnXwyZfF9fLa4RfifmdNKME8C00XlqnoJDZBGzq8yMy
 LAKDxl9OQWFcDwDxV+irg5U3fbtNVhvV0kLbS2TyQ0aU5w60ERS2NcyDWplOo7AOzZWChcA4
 UFf78oVdZdCW8YDtU0uQFhA9moNnrePy1HSFqduxnlFHEI+fDj/TiOm2ci48b8SBBJOIJFjl
 SBgH8+SfT9ZqkzhN9vh3YJ49831NwASVm0x1rDHcIwWD32VFZViZ3NjehogRNH9br0PSUYOC
 3s7ATQRX2BjLAQgAnak3m0imYOkv2tO/olULFa686tlwuvl5kL0NWCdGQeXv2uMxy36szcrh
 K1uYhpiQv4r2qNd8BJtYlnYIK16N8GBdkplaDIHcBMbU4t+6bQzEIJIaWoq1hzakmHHngE2a
 pNMnUf/01GFvCRPlv3imkujE/5ILbagjtdyJaHF0wGOSlTnNT4W8j+zPJ/XK0I5EVQwtbmoc
 GY62LKxxz2pID6sPZV4zQVY4JdUQaFvOz1emnBxakkt0cq3Qnnqso1tjiy7vyH9CAwPR/48W
 fpK6dew4Fk+STYtBeixOTfSUS8qRS/wfpUeNa5RnEdTtFQ9IcjpQ/nPrvJJsu9FqwlpjMwAR
 AQABwsBlBBgBCAAPBQJX2BjLAhsMBQkSzAMAAAoJEEV84KCARGXFUKcH/jqKETECkbyPktdP
 cWVqw2ZIsmGxMkIdnZTbPwhORseGXMHadQODayhU9GWfCDdSPkWDWzMamD+qStfl9MhlVT60
 HTbo6wu1W/ogUS70qQPTY9IfsvAj6f8TlSlK0eLMa3s2UxL2oe5FkNs2CnVeRlr4Yqvp/ZQV
 6LXtew4GPRrmplUT/Cre9QIUqR4pxYCQaMoOXQQw3Y0csBwoDYUQujn3slbDJRIweHoppBzT
 rM6ZG5ldWQN3n3d71pVuv80guylX8+TSB8Mvkqwb5I36/NAFKl0CbGbTuQli7SmNiTAKilXc
 Y5Uh9PIrmixt0JrmGVRzke6+11mTjVlio/J5dCM=
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

14.02.2024 14:13, Michael S. Tsirkin:

> virtio,pc,pci: features, cleanups, fixes
> 
> vhost-user-snd support
> x2APIC mode with TCG support
> CXL update to r3.1
> 
> fixes, cleanups all over the place.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ----------------------------------------------------------------
> Akihiko Odaki (2):
>        hw/smbios: Fix OEM strings table option validation
>        hw/smbios: Fix port connector option validation
> 
> Alex Bennée (6):
>        virtio: split into vhost-user-base and vhost-user-device
>        hw/virtio: convert vhost-user-base to async shutdown
>        hw/virtio: derive vhost-user-rng from vhost-user-base
>        hw/virtio: derive vhost-user-gpio from vhost-user-base
>        hw/virtio: derive vhost-user-i2c from vhost-user-base
>        docs/system: add a basic enumeration of vhost-user devices
> 
> Andrey Ignatov (1):
>        vhost-user.rst: Fix vring address description
> 
> Bernhard Beschow (14):
>        hw/i386/x86: Reverse if statement
>        hw/i386/x86: Fix PIC interrupt handling if APIC is globally disabled
>        target/i386/cpu: Fix typo in comment
>        hw/block/fdc-isa: Move portio_list from FDCtrl to FDCtrlISABus
>        hw/block/fdc-sysbus: Move iomem from FDCtrl to FDCtrlSysBus
>        hw/char/parallel: Move portio_list from ParallelState to ISAParallelState
>        exec/ioport: Resolve redundant .base attribute in struct MemoryRegionPortio
>        exec/ioport: Add portio_list_set_address()
>        exec/ioport: Add portio_list_set_enabled()
>        hw/block/fdc-isa: Implement relocation and enabling/disabling for TYPE_ISA_FDC
>        hw/char/serial-isa: Implement relocation and enabling/disabling for TYPE_ISA_SERIAL
>        hw/char/parallel-isa: Implement relocation and enabling/disabling for TYPE_ISA_PARALLEL
>        hw/ppc/pegasos2: Let pegasos2 machine configure SuperI/O functions
>        hw/isa/vt82c686: Implement relocation and toggling of SuperI/O functions
> 
> Bui Quang Minh (7):
>        i386/tcg: implement x2APIC registers MSR access
>        apic: add support for x2APIC mode
>        apic, i386/tcg: add x2apic transitions
>        intel_iommu: allow Extended Interrupt Mode when using userspace APIC
>        test: bios-tables-test: prepare IVRS change in ACPI table
>        amd_iommu: report x2APIC support to the operating system
>        test: bios-tables-test: add IVRS changed binary
> 
> Davidlohr Bueso (1):
>        hw/cxl/mbox: Remove dead code
> 
> Dmitry Osipenko (1):
>        virtio-gpu: Correct virgl_renderer_resource_get_info() error check
> 
> Hyeonggon Yoo (1):
>        hw/cxl/device: read from register values in mdev_reg_read()
> 
> Ira Weiny (2):
>        cxl/cdat: Handle cdat table build errors
>        cxl/cdat: Fix header sum value in CDAT checksum
> 
> Jonathan Cameron (11):
>        hw/mem/cxl_type3: Drop handling of failure of g_malloc0() and g_malloc()
>        hw/pci-bridge/cxl_upstream: Drop g_malloc() failure handling
>        hw/mem/cxl_type3: Fix potential divide by zero reported by coverity
>        tests/acpi: Allow update of DSDT.cxl
>        hw/i386: Fix _STA return value for ACPI0017
>        tests/acpi: Update DSDT.cxl to reflect change _STA return value.
>        hw/cxl: Update HDM Decoder capability to version 3
>        hw/cxl: Update link register definitions.
>        hw/cxl: Update RAS Capability Definitions for version 3.
>        hw/cxl: Update mailbox status registers.
>        hw/cxl: Standardize all references on CXL r3.1 and minor updates
> 
> Leo Yan (4):
>        hw/virtio: Support set_config() callback in vhost-user-base
>        docs/system: Add vhost-user-input documentation
>        hw/virtio: Move vhost-user-input into virtio folder
>        hw/virtio: derive vhost-user-input from vhost-user-base
> 
> Li Zhijian (2):
>        hw/cxl: Pass CXLComponentState to cache_mem_ops
>        hw/cxl: Pass NULL for a NULL MemoryRegionOps
> 
> Manos Pitsidianakis (4):
>        hw/virtio: add vhost-user-snd and vhost-user-snd-pci devices
>        hw/display/virtio-gpu.c: use reset_bh class method
>        virtio-gpu.c: add resource_destroy class method
>        virtio-gpu-rutabaga.c: override resource_destroy method
> 
> Peter Xu (1):
>        MAINTAINERS: Drop myself as VT-d maintainers
> 
> Raphael Norwitz (1):
>        MAINTAINERS: Switch to my Enfabrica email
> 
> Zhenzhong Duan (2):
>        virtio_iommu: Clear IOMMUPciBus pointer cache when system reset
>        smmu: Clear SMMUPciBus pointer cache when system reset
> 

 From this list, I'm picking

  hw/smbios: Fix table option validation (Akihiko Odaki)
   (already applied to master and picked for -stable)

  virtio_iommu: Clear IOMMUPciBus pointer cache when system reset (Zhenzhong Duan)
  smmu: Clear SMMUPciBus pointer cache when system reset (Zhenzhong Duan)

  hw/i386: Fix _STA return value for ACPI0017 (Jonathan Cameron)
    (with 2 surrounding commits for acpi-tables-test)

  cxl/cdat: Handle cdat table build errors (Ira Weiny)

  cxl/cdat: Fix header sum value in CDAT checksum (Ira Weiny)

  hw/cxl/device: read from register values in mdev_reg_read() (Hyeonggon Yoo)

  hw/cxl: Pass CXLComponentState to cache_mem_ops (Li Zhijian)
   (a basically no-op bugfix just to have correct code)

for stable-8.2 and (almost all) for stable-7.2.  Please let me know
if these should not go to -stable, or if there are other changes which
you think should go to stable.

Thanks,

/mjt

