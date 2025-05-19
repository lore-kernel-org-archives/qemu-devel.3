Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE42C3ABD8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 01:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGovW-0007tO-8X; Sun, 18 May 2025 21:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uGovT-0007t1-E0
 for qemu-devel@nongnu.org; Sun, 18 May 2025 21:04:19 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uGovO-000611-J7
 for qemu-devel@nongnu.org; Sun, 18 May 2025 21:04:19 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxeXGBgypoHHnxAA--.62193S3;
 Mon, 19 May 2025 09:04:02 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMDx_MR8gypo9iDgAA--.45878S3;
 Mon, 19 May 2025 09:03:58 +0800 (CST)
Subject: Re: [PATCH 0/6] Add bios-tables-test for LoongArch64 system
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20250228092729.543097-1-maobibo@loongson.cn>
 <20250511091725-mutt-send-email-mst@kernel.org>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <11868d5a-64ab-8d37-7980-a2f2959ed1e2@loongson.cn>
Date: Mon, 19 May 2025 09:02:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250511091725-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDx_MR8gypo9iDgAA--.45878S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXrW5ZrW5Ar18JrWktry7Arc_yoWrGr13p3
 yY934Skr4IyF9rG3WDXa98Wr1kJrs29FsxuF1agr1xCF1akr1qvw1agF9aga43Aw1jgw10
 9w1kGF1rA3Z8XFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
 XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
 8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
 r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67
 AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
 rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
 v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
 JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1tC7UUU
 UU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.872,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2025/5/11 下午9:17, Michael S. Tsirkin wrote:
> On Fri, Feb 28, 2025 at 05:27:23PM +0800, Bibo Mao wrote:
>> This patchset add bios-tables-test for LoongArch64 virt machine
>> system. It works with UEFI bios, with uefi-test-tools LoongArch64
>> support is added to build bios-tables-test.loongarch64.iso.
>>
>> Also with test case bios-tables-test, LoongArch64 support is added
>> and some basic ACPI tables is added here. It passes with command
>> make check-qtest-loongarch64 with the result:
>>   qtest-loongarch64/bios-tables-test OK 29.52s 4 subtests passed
> 
> Still waiting for Igor's comment on this to be addressed.
Sorry for the late reply because there is on vacation leave last week.

Thanks for your reminder and I do not notice Igor's comments until this 
email. And I will reply and try hard to address it ASAP.

Regards
Bibo Mao
> 
> 
>> Bibo Mao (6):
>>    uefi-test-tools:: Add LoongArch64 support
>>    tests/data/uefi-boot-images: Add ISO image for LoongArch system
>>    tests/qtest/bios-tables-test: Add basic testing for LoongArch64
>>    tests/acpi: Add empty ACPI data files for LoongArch64
>>    tests/acpi: Fill acpi table data for LoongArch
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
>> -- 
>> 2.39.3


