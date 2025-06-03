Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82420C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 01:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMGBJ-0002tT-3F; Mon, 02 Jun 2025 21:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uMGBG-0002sm-98
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 21:11:06 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uMGBC-0003z4-Rr
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 21:11:06 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxXWubSz5oYnMJAQ--.31949S3;
 Tue, 03 Jun 2025 09:10:51 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMAxDcWUSz5oK9gFAQ--.18137S3;
 Tue, 03 Jun 2025 09:10:46 +0800 (CST)
Subject: Re: [PULL 00/31] virtio,pci,pc: features, fixes, tests
To: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <cover.1748791463.git.mst@redhat.com>
 <CAJSP0QUCipXvUWQ7uOm4Ct2a0O7=SFF9XZAozTFtAZfak8-EGg@mail.gmail.com>
 <20250602135333-mutt-send-email-mst@kernel.org>
 <CAJSP0QWvkMMcuy=5hU=4Ps4DtoE2TQ8Up4fDSLZZ8ia_+9jjEA@mail.gmail.com>
 <20250602142634-mutt-send-email-mst@kernel.org>
 <20250602175809-mutt-send-email-mst@kernel.org>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <d45e8034-01b4-8957-ecd4-30f3dbb9a05d@loongson.cn>
Date: Tue, 3 Jun 2025 09:09:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250602175809-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxDcWUSz5oK9gFAQ--.18137S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jw4DWw1ruFW3Cr1DXrW5urX_yoWfGFWkp3
 y3AF1akr1xJFy7J3ZFqas5Xr1Dtrs29r17WF13Wr18CFnFkrn8Ar13XFyfWa47AryUWw18
 Zw18Gr17Xrn8XFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j8yCJU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.054,
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



On 2025/6/3 上午5:58, Michael S. Tsirkin wrote:
> On Mon, Jun 02, 2025 at 02:31:19PM -0400, Michael S. Tsirkin wrote:
>> On Mon, Jun 02, 2025 at 02:25:48PM -0400, Stefan Hajnoczi wrote:
>>> On Mon, Jun 2, 2025 at 1:54 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>
>>>> On Mon, Jun 02, 2025 at 12:39:17PM -0400, Stefan Hajnoczi wrote:
>>>>> On Sun, Jun 1, 2025 at 11:34 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>>>
>>>>>> The following changes since commit d2e9b78162e31b1eaf20f3a4f563da82da56908d:
>>>>>>
>>>>>>    Merge tag 'pull-qapi-2025-05-28' of https://repo.or.cz/qemu/armbru into staging (2025-05-29 08:36:01 -0400)
>>>>>>
>>>>>> are available in the Git repository at:
>>>>>>
>>>>>>    https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>>>>>>
>>>>>> for you to fetch changes up to 1c5771c092742b729e2a640be184a0f48c0b2cdb:
>>>>>>
>>>>>>    hw/i386/pc_piix: Fix RTC ISA IRQ wiring of isapc machine (2025-06-01 08:30:09 -0400)
>>>>>>
>>>>>> ----------------------------------------------------------------
>>>>>> virtio,pci,pc: features, fixes, tests
>>>>>>
>>>>>> vhost will now no longer set a call notifier if unused
>>>>>> loongarch gained acpi tests based on bios-tables-test
>>>>>> some core pci work for SVM support in vtd
>>>>>> vhost vdpa init has been optimized for response time to QMP
>>>>>> A couple more fixes
>>>>>>
>>>>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>>>
>>>>> Please take a look at this CI failure:
>>>>> https://gitlab.com/qemu-project/qemu/-/jobs/10225580735#L4750
>>>>
>>>> Hmm must be how it interacts with something in your tree.
>>>> Which commit are you merging with?
>>>> Let me know, I'll try to rebase.
>>>
>>> commit 25de0b9aa129b2b014a0595befef05f04511868d (HEAD -> staging)
>>> Merge: 3e82ddaa8d 6e672b2a08
>>> Author: Stefan Hajnoczi <stefanha@redhat.com>
>>> Date:   Mon Jun 2 09:56:12 2025 -0400
>>>
>>>      Merge tag 'for_upstream' of
>>> https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging
>>>
>>>      virtio,pci,pc: features, fixes, tests
>>>
>>> Commit 6e672b2a08 is the one you published and 3e82ddaa8d is the
>>> qemu.git/master.
>>
>> I could not figure it out. Must be a loongarch bug dealing
>> with s390 hosts. I dropped them from the tag for now.
>> Cc contributor to figure it out.
>> Bibo Mao pls take a look.
>>
>> New tag:
>> 0b006153b7ec66505cb2d231235aa19ca5d2ce37
>>
>>
>> Thanks!
> 
> 
> hope this is ok now. going offline for vacation. see you after the 10th!
Sorry for the trouble, I will look into this issue. And have a good 
summer vacation.

Regards
Bibo Mao
> 
>>
>>>>
>>>>>>
>>>>>> ----------------------------------------------------------------
>>>>>> Bernhard Beschow (1):
>>>>>>        hw/i386/pc_piix: Fix RTC ISA IRQ wiring of isapc machine
>>>>>>
>>>>>> Bibo Mao (8):
>>>>>>        uefi-test-tools:: Add LoongArch64 support
>>>>>>        tests/data/uefi-boot-images: Add ISO image for LoongArch system
>>>>>>        tests/qtest/bios-tables-test: Use MiB macro rather hardcode value
>>>>>>        tests/acpi: Add empty ACPI data files for LoongArch
>>>>>>        tests/qtest/bios-tables-test: Add basic testing for LoongArch
>>>>>>        rebuild-expected-aml.sh: Add support for LoongArch
>>>>>>        tests/acpi: Fill acpi table data for LoongArch
>>>>>>        tests/acpi: Remove stale allowed tables
>>>>>>
>>>>>> CLEMENT MATHIEU--DRIF (11):
>>>>>>        pcie: Add helper to declare PASID capability for a pcie device
>>>>>>        pcie: Helper functions to check if PASID is enabled
>>>>>>        pcie: Helper function to check if ATS is enabled
>>>>>>        pcie: Add a helper to declare the PRI capability for a pcie device
>>>>>>        pcie: Helper functions to check to check if PRI is enabled
>>>>>>        pci: Cache the bus mastering status in the device
>>>>>>        pci: Add an API to get IOMMU's min page size and virtual address width
>>>>>>        memory: Store user data pointer in the IOMMU notifiers
>>>>>>        pci: Add a pci-level initialization function for IOMMU notifiers
>>>>>>        pci: Add a pci-level API for ATS
>>>>>>        pci: Add a PCI-level API for PRI
>>>>>>
>>>>>> Eugenio Pérez (7):
>>>>>>        vdpa: check for iova tree initialized at net_client_start
>>>>>>        vdpa: reorder vhost_vdpa_set_backend_cap
>>>>>>        vdpa: set backend capabilities at vhost_vdpa_init
>>>>>>        vdpa: add listener_registered
>>>>>>        vdpa: reorder listener assignment
>>>>>>        vdpa: move iova_tree allocation to net_vhost_vdpa_init
>>>>>>        vdpa: move memory listener register to vhost_vdpa_init
>>>>>>
>>>>>> Huaitong Han (1):
>>>>>>        vhost: Don't set vring call if guest notifier is unused
>>>>>>
>>>>>> Sairaj Kodilkar (1):
>>>>>>        hw/i386/amd_iommu: Fix device setup failure when PT is on.
>>>>>>
>>>>>> Vasant Hegde (1):
>>>>>>        hw/i386/amd_iommu: Fix xtsup when vcpus < 255
>>>>>>
>>>>>> Yuri Benditovich (1):
>>>>>>        virtio: check for validity of indirect descriptors
>>>>>>
>>>>>>   include/hw/pci/pci.h                               | 316 +++++++++++++++++++++
>>>>>>   include/hw/pci/pci_device.h                        |   1 +
>>>>>>   include/hw/pci/pcie.h                              |  13 +-
>>>>>>   include/hw/pci/pcie_regs.h                         |   8 +
>>>>>>   include/hw/virtio/vhost-vdpa.h                     |  22 +-
>>>>>>   include/system/memory.h                            |   1 +
>>>>>>   hw/i386/amd_iommu.c                                |  20 +-
>>>>>>   hw/i386/pc_piix.c                                  |   5 +
>>>>>>   hw/pci/pci.c                                       | 206 +++++++++++++-
>>>>>>   hw/pci/pcie.c                                      |  78 +++++
>>>>>>   hw/virtio/vhost-vdpa.c                             | 107 ++++---
>>>>>>   hw/virtio/virtio-pci.c                             |   7 +-
>>>>>>   hw/virtio/virtio.c                                 |  11 +
>>>>>>   net/vhost-vdpa.c                                   |  34 +--
>>>>>>   tests/qtest/bios-tables-test.c                     |  99 ++++++-
>>>>>>   tests/data/acpi/loongarch64/virt/APIC              | Bin 0 -> 108 bytes
>>>>>>   tests/data/acpi/loongarch64/virt/APIC.topology     | Bin 0 -> 213 bytes
>>>>>>   tests/data/acpi/loongarch64/virt/DSDT              | Bin 0 -> 4641 bytes
>>>>>>   tests/data/acpi/loongarch64/virt/DSDT.memhp        | Bin 0 -> 5862 bytes
>>>>>>   tests/data/acpi/loongarch64/virt/DSDT.numamem      | Bin 0 -> 4647 bytes
>>>>>>   tests/data/acpi/loongarch64/virt/DSDT.topology     | Bin 0 -> 5352 bytes
>>>>>>   tests/data/acpi/loongarch64/virt/FACP              | Bin 0 -> 268 bytes
>>>>>>   tests/data/acpi/loongarch64/virt/MCFG              | Bin 0 -> 60 bytes
>>>>>>   tests/data/acpi/loongarch64/virt/PPTT              | Bin 0 -> 76 bytes
>>>>>>   tests/data/acpi/loongarch64/virt/PPTT.topology     | Bin 0 -> 296 bytes
>>>>>>   tests/data/acpi/loongarch64/virt/SLIT              |   0
>>>>>>   tests/data/acpi/loongarch64/virt/SLIT.numamem      | Bin 0 -> 48 bytes
>>>>>>   tests/data/acpi/loongarch64/virt/SPCR              | Bin 0 -> 80 bytes
>>>>>>   tests/data/acpi/loongarch64/virt/SRAT              | Bin 0 -> 104 bytes
>>>>>>   tests/data/acpi/loongarch64/virt/SRAT.memhp        | Bin 0 -> 144 bytes
>>>>>>   tests/data/acpi/loongarch64/virt/SRAT.numamem      | Bin 0 -> 144 bytes
>>>>>>   tests/data/acpi/loongarch64/virt/SRAT.topology     | Bin 0 -> 216 bytes
>>>>>>   tests/data/acpi/rebuild-expected-aml.sh            |   4 +-
>>>>>>   .../bios-tables-test.loongarch64.iso.qcow2         | Bin 0 -> 12800 bytes
>>>>>>   tests/qtest/meson.build                            |   1 +
>>>>>>   tests/uefi-test-tools/Makefile                     |   5 +-
>>>>>>   .../UefiTestToolsPkg/UefiTestToolsPkg.dsc          |   6 +-
>>>>>>   tests/uefi-test-tools/uefi-test-build.config       |  10 +
>>>>>>   38 files changed, 846 insertions(+), 108 deletions(-)
>>>>>>   create mode 100644 tests/data/acpi/loongarch64/virt/APIC
>>>>>>   create mode 100644 tests/data/acpi/loongarch64/virt/APIC.topology
>>>>>>   create mode 100644 tests/data/acpi/loongarch64/virt/DSDT
>>>>>>   create mode 100644 tests/data/acpi/loongarch64/virt/DSDT.memhp
>>>>>>   create mode 100644 tests/data/acpi/loongarch64/virt/DSDT.numamem
>>>>>>   create mode 100644 tests/data/acpi/loongarch64/virt/DSDT.topology
>>>>>>   create mode 100644 tests/data/acpi/loongarch64/virt/FACP
>>>>>>   create mode 100644 tests/data/acpi/loongarch64/virt/MCFG
>>>>>>   create mode 100644 tests/data/acpi/loongarch64/virt/PPTT
>>>>>>   create mode 100644 tests/data/acpi/loongarch64/virt/PPTT.topology
>>>>>>   create mode 100644 tests/data/acpi/loongarch64/virt/SLIT
>>>>>>   create mode 100644 tests/data/acpi/loongarch64/virt/SLIT.numamem
>>>>>>   create mode 100644 tests/data/acpi/loongarch64/virt/SPCR
>>>>>>   create mode 100644 tests/data/acpi/loongarch64/virt/SRAT
>>>>>>   create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.memhp
>>>>>>   create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.numamem
>>>>>>   create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.topology
>>>>>>   create mode 100644 tests/data/uefi-boot-images/bios-tables-test.loongarch64.iso.qcow2
>>>>>>
>>>>>>
>>>>


