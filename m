Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948B0C3ABC9
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 02:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGq2i-0007i0-2o; Sun, 18 May 2025 22:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uGq2f-0007hj-Ag
 for qemu-devel@nongnu.org; Sun, 18 May 2025 22:15:49 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uGq2c-0007gz-KX
 for qemu-devel@nongnu.org; Sun, 18 May 2025 22:15:49 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxaeBNlCpoTorxAA--.64616S3;
 Mon, 19 May 2025 10:15:41 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMCxPsdElCpoIDvgAA--.51835S3;
 Mon, 19 May 2025 10:15:35 +0800 (CST)
Subject: Re: [PATCH 0/6] Add bios-tables-test for LoongArch64 system
To: Igor Mammedov <imammedo@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20250228092729.543097-1-maobibo@loongson.cn>
 <20250401155034.528b35a8@imammedo.users.ipa.redhat.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <f44eee19-b388-4e62-2c19-557e327f3bc7@loongson.cn>
Date: Mon, 19 May 2025 10:14:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250401155034.528b35a8@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxPsdElCpoIDvgAA--.51835S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr15tF48Ww1xWw43Ww43CFX_yoWrGrW5p3
 yY934Skr4IyF9rG3WDWas8Wr1kJrs7uFsxuF1agr1xCFyakr1UZw1agF9agay3Aw1jgw10
 9w1kGr18A3Z5WagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j8
 3kZUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.872,
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



On 2025/4/1 下午9:50, Igor Mammedov wrote:
> On Fri, 28 Feb 2025 17:27:23 +0800
> Bibo Mao <maobibo@loongson.cn> wrote:
> 
>> This patchset add bios-tables-test for LoongArch64 virt machine
>> system. It works with UEFI bios, with uefi-test-tools LoongArch64
>> support is added to build bios-tables-test.loongarch64.iso.
>>
>> Also with test case bios-tables-test, LoongArch64 support is added
>> and some basic ACPI tables is added here. It passes with command
>> make check-qtest-loongarch64 with the result:
>>   qtest-loongarch64/bios-tables-test OK 29.52s 4 subtests passed
>>
>> Bibo Mao (6):
>>    uefi-test-tools:: Add LoongArch64 support
>>    tests/data/uefi-boot-images: Add ISO image for LoongArch system
>>    tests/qtest/bios-tables-test: Add basic testing for LoongArch64
>>    tests/acpi: Add empty ACPI data files for LoongArch64
>>    tests/acpi: Fill acpi table data for LoongArch
> 
> blobs no longer match (since cpu hotplug was merged after this series)
> so blobs need to be updated and series needs to be re-spun
yes, this patch need be re-spun since cpu hotplug is merged and RSDT 
table is replaced with XSDT table.

Will refresh the patch based on the latest version.

Regards
Bibo Mao
> 
>>    tests/qtest: Enable bios-tables-test for LoongArch
>>
>>   tests/data/acpi/loongarch64/virt/APIC         | Bin 0 -> 108 bytes
>>   .../data/acpi/loongarch64/virt/APIC.topology  | Bin 0 -> 213 bytes
>>   tests/data/acpi/loongarch64/virt/DSDT         | Bin 0 -> 3614 bytes
>>   tests/data/acpi/loongarch64/virt/DSDT.memhp   | Bin 0 -> 4951 bytes
>>   tests/data/acpi/loongarch64/virt/FACP         | Bin 0 -> 268 bytes
>>   tests/data/acpi/loongarch64/virt/MCFG         | Bin 0 -> 60 bytes
>>   tests/data/acpi/loongarch64/virt/PPTT         | Bin 0 -> 76 bytes
>>   .../data/acpi/loongarch64/virt/PPTT.topology  | Bin 0 -> 296 bytes
>>   tests/data/acpi/loongarch64/virt/SLIT         |   0
>>   tests/data/acpi/loongarch64/virt/SLIT.memhp   | Bin 0 -> 48 bytes
>>   tests/data/acpi/loongarch64/virt/SPCR         | Bin 0 -> 80 bytes
>>   tests/data/acpi/loongarch64/virt/SRAT         | Bin 0 -> 104 bytes
>>   tests/data/acpi/loongarch64/virt/SRAT.memhp   | Bin 0 -> 184 bytes
>>   .../data/acpi/loongarch64/virt/SRAT.topology  | Bin 0 -> 216 bytes
>>   .../bios-tables-test.loongarch64.iso.qcow2    | Bin 0 -> 12800 bytes
>>   tests/qtest/bios-tables-test.c                |  62 ++++++++++++++++++
>>   tests/qtest/meson.build                       |   3 +-
>>   tests/uefi-test-tools/Makefile                |   5 +-
>>   .../UefiTestToolsPkg/UefiTestToolsPkg.dsc     |   6 +-
>>   tests/uefi-test-tools/uefi-test-build.config  |  10 +++
>>   20 files changed, 82 insertions(+), 4 deletions(-)
>>   create mode 100644 tests/data/acpi/loongarch64/virt/APIC
>>   create mode 100644 tests/data/acpi/loongarch64/virt/APIC.topology
>>   create mode 100644 tests/data/acpi/loongarch64/virt/DSDT
>>   create mode 100644 tests/data/acpi/loongarch64/virt/DSDT.memhp
>>   create mode 100644 tests/data/acpi/loongarch64/virt/FACP
>>   create mode 100644 tests/data/acpi/loongarch64/virt/MCFG
>>   create mode 100644 tests/data/acpi/loongarch64/virt/PPTT
>>   create mode 100644 tests/data/acpi/loongarch64/virt/PPTT.topology
>>   create mode 100644 tests/data/acpi/loongarch64/virt/SLIT
>>   create mode 100644 tests/data/acpi/loongarch64/virt/SLIT.memhp
>>   create mode 100644 tests/data/acpi/loongarch64/virt/SPCR
>>   create mode 100644 tests/data/acpi/loongarch64/virt/SRAT
>>   create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.memhp
>>   create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.topology
>>   create mode 100644 tests/data/uefi-boot-images/bios-tables-test.loongarch64.iso.qcow2
>>
>>
>> base-commit: b69801dd6b1eb4d107f7c2f643adf0a4e3ec9124


