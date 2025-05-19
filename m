Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7320CC3ABC9
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 02:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGqYD-0002KU-6J; Sun, 18 May 2025 22:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uGqY9-0002KK-AB
 for qemu-devel@nongnu.org; Sun, 18 May 2025 22:48:21 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uGqY6-0003KU-OG
 for qemu-devel@nongnu.org; Sun, 18 May 2025 22:48:21 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxaeHpmypo+JDxAA--.19352S3;
 Mon, 19 May 2025 10:48:10 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMAxDcXlmypocUbgAA--.46754S3;
 Mon, 19 May 2025 10:48:08 +0800 (CST)
Subject: Re: [PATCH 4/6] tests/acpi: Add empty ACPI data files for LoongArch64
To: Igor Mammedov <imammedo@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20250228092729.543097-1-maobibo@loongson.cn>
 <20250228092729.543097-5-maobibo@loongson.cn>
 <20250401154840.1d591aa8@imammedo.users.ipa.redhat.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <988dfbf4-b60c-a6ff-81f0-e7bca770da76@loongson.cn>
Date: Mon, 19 May 2025 10:46:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250401154840.1d591aa8@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxDcXlmypocUbgAA--.46754S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGw1DZry7Ar1xGw17JFW5urX_yoW5CFW7p3
 y5Awn3Kr4xtF9rKa47W3s8XF1kJrsxuFnruF13Wr12kF12kr1qvw1SqFySkayay34UXa18
 Zr1kGFy0qF15WagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
 XVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
 8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
 r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67
 AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
 rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
 v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
 JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUc3kuDU
 UUU
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



On 2025/4/1 下午9:48, Igor Mammedov wrote:
> On Fri, 28 Feb 2025 17:27:27 +0800
> Bibo Mao <maobibo@loongson.cn> wrote:
> 
>> Add empty acpi table for LoongArch64 virt machine, it is only empty
>> file and there is no data in these files.
> 
> this patch after 3/6 doesn't make sense,
> either drop.
Empty acpi table can be dropped.
> 
> Adding empty blobs, can be useful (as then you can get ACPI diff during test)
> but only if you follow update acpi blos process as described in
> bios-tables-test.c
> 
> 
> as is, the next patch (5/6) should precede 3/6
yes, it is strange about patch order. How about split patch 3/6 into 
smaller patches, one patch for one test case, and move specified acpi 
table into smaller patches.

Regards
Bibo Mao
> 
> 
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   tests/data/acpi/loongarch64/virt/APIC | 0
>>   tests/data/acpi/loongarch64/virt/DSDT | 0
>>   tests/data/acpi/loongarch64/virt/FACP | 0
>>   tests/data/acpi/loongarch64/virt/MCFG | 0
>>   tests/data/acpi/loongarch64/virt/PPTT | 0
>>   tests/data/acpi/loongarch64/virt/SLIT | 0
>>   tests/data/acpi/loongarch64/virt/SPCR | 0
>>   tests/data/acpi/loongarch64/virt/SRAT | 0
>>   8 files changed, 0 insertions(+), 0 deletions(-)
>>   create mode 100644 tests/data/acpi/loongarch64/virt/APIC
>>   create mode 100644 tests/data/acpi/loongarch64/virt/DSDT
>>   create mode 100644 tests/data/acpi/loongarch64/virt/FACP
>>   create mode 100644 tests/data/acpi/loongarch64/virt/MCFG
>>   create mode 100644 tests/data/acpi/loongarch64/virt/PPTT
>>   create mode 100644 tests/data/acpi/loongarch64/virt/SLIT
>>   create mode 100644 tests/data/acpi/loongarch64/virt/SPCR
>>   create mode 100644 tests/data/acpi/loongarch64/virt/SRAT
>>
>> diff --git a/tests/data/acpi/loongarch64/virt/APIC b/tests/data/acpi/loongarch64/virt/APIC
>> new file mode 100644
>> index 0000000000..e69de29bb2
>> diff --git a/tests/data/acpi/loongarch64/virt/DSDT b/tests/data/acpi/loongarch64/virt/DSDT
>> new file mode 100644
>> index 0000000000..e69de29bb2
>> diff --git a/tests/data/acpi/loongarch64/virt/FACP b/tests/data/acpi/loongarch64/virt/FACP
>> new file mode 100644
>> index 0000000000..e69de29bb2
>> diff --git a/tests/data/acpi/loongarch64/virt/MCFG b/tests/data/acpi/loongarch64/virt/MCFG
>> new file mode 100644
>> index 0000000000..e69de29bb2
>> diff --git a/tests/data/acpi/loongarch64/virt/PPTT b/tests/data/acpi/loongarch64/virt/PPTT
>> new file mode 100644
>> index 0000000000..e69de29bb2
>> diff --git a/tests/data/acpi/loongarch64/virt/SLIT b/tests/data/acpi/loongarch64/virt/SLIT
>> new file mode 100644
>> index 0000000000..e69de29bb2
>> diff --git a/tests/data/acpi/loongarch64/virt/SPCR b/tests/data/acpi/loongarch64/virt/SPCR
>> new file mode 100644
>> index 0000000000..e69de29bb2
>> diff --git a/tests/data/acpi/loongarch64/virt/SRAT b/tests/data/acpi/loongarch64/virt/SRAT
>> new file mode 100644
>> index 0000000000..e69de29bb2


