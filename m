Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD60C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 00:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMcGj-0001N8-4p; Tue, 03 Jun 2025 20:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uMcGh-0001Mv-3E
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 20:46:11 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uMcGe-0000rc-44
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 20:46:10 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxeXFIlz9oc84KAQ--.33540S3;
 Wed, 04 Jun 2025 08:46:00 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMDxvhtFlz9oZBUIAQ--.40147S3;
 Wed, 04 Jun 2025 08:45:58 +0800 (CST)
Subject: Re: [PATCH v5 0/4] Building PPTT with root node and identical
 implementation flag
To: Alireza Sanaee <alireza.sanaee@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, anisinha@redhat.com, imammedo@redhat.com,
 jonathan.cameron@huawei.com, linuxarm@huawei.com, peter.maydell@linaro.org,
 prime.zeng@hisilicon.com, shameerali.kolothum.thodi@huawei.com,
 wangyanan55@huawei.com, yangyicong@hisilicon.com
References: <20250523102654.1719-1-alireza.sanaee@huawei.com>
 <20250601082826-mutt-send-email-mst@kernel.org>
 <20250603164005.00003d56.alireza.sanaee@huawei.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <99a37f40-56dc-ab7a-86ff-1a9dcb3cc711@loongson.cn>
Date: Wed, 4 Jun 2025 08:44:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250603164005.00003d56.alireza.sanaee@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxvhtFlz9oZBUIAQ--.40147S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJF45CFWDtryxGFyDCFy3trc_yoW5XFyUpF
 WrC3WrKr4kG3Wxur1Sgw4xAr13trZ7Ar47WryDZ34UCa909rnakr1rKry5Gay7Jws3ua1I
 9r4vgw129ryjvagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
 7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
 8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
 CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
 1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
 vfC2KfnxnUUI43ZEXa7IU8aZX5UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.229,
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



On 2025/6/3 下午11:40, Alireza Sanaee via wrote:
> On Sun, 1 Jun 2025 08:32:52 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
>> On Fri, May 23, 2025 at 11:26:50AM +0100, Alireza Sanaee wrote:
>>> OS like Linux is using PPTT processor node's identical
>>> implementation flag [1] to infer whether the whole system or a
>>> certain CPU cluster is homogeneous or not [2]. QEMU currently only
>>> support building homogeneous system, set the flag to indicate the
>>> fact. Build a root node in PPTT for indicates the identical
>>> implementation which is needed for a multi-socket system. Update
>>> the related PPTT tables as well.
>>>
>>> [1] ACPI 6.5 Table 5.158: Processor Structure Flags
>>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/acpi/pptt.c?h=v6.11-rc1#n810
>>>
>>> History:
>>>      * v4->v5: fixed a typo
>>>
>>>      * v3->v4: PPTT rev to 2
>>>
>>>      * v2->v3: rebase to 10
>>>
>>> Alireza Sanaee (2):
>>>    hw/acpi/aml-build: Build a root node in the PPTT table
>>>    tests: virt: Update expected ACPI tables for virt test
>>>
>>> Yicong Yang (2):
>>>    tests: virt: Allow changes to PPTT test table
>>>    hw/acpi/aml-build: Set identical implementation flag for PPTT
>>>      processor nodes
>>>
>>>   hw/acpi/aml-build.c                           |  24
>>> +++++++++++++++--- tests/data/acpi/aarch64/virt/PPTT             |
>>> Bin 76 -> 96 bytes .../data/acpi/aarch64/virt/PPTT.acpihmatvirt  |
>>> Bin 156 -> 176 bytes tests/data/acpi/aarch64/virt/PPTT.topology
>>> | Bin 336 -> 356 bytes 4 files changed, 20 insertions(+), 4
>>> deletions(-)
>>
>>
>> This interacts weirdly with loongarch. I tried applying patches
>> on top of that, and on loongarch, I see:
>>
>> -[0F0h 0240 004h]       Flags (decoded below) : 00000000
>> +[0F0h 0240 004h]       Flags (decoded below) : 0000000E
>>                               Physical package : 0
>> -                     ACPI Processor ID valid : 0
>> -                       Processor is a thread : 0
>> -                              Node is a leaf : 0
>> +                     ACPI Processor ID valid : 1
>> +                       Processor is a thread : 1
>> +                              Node is a leaf : 1
>>                       Identical Implementation : 0
>>
>>
>> I'm sending a pull request later today. Once merged, pls
>> rebase on top of that, updating loongarch as appropriate
>> and repost copying relevant people.
>>
>> Cc Bibo Mao for more insight.
> Hi Micheal,
> 
> I am trying to reproduce this issue. I have applied the
> patchset on the master branch now, and then run:
> make check-qtest-loongarch64 V=2 -j, but I don't seem to get any diffs
> on the binaries, and all tests passed.
It is an host endian issue, only happens on big endian host machine such 
as S390x :(  And there is problem on LoongArch virt machine code about 
endian setting.

Regards
Bibo Mao
> 
> May I know if that's how you noticed the problem?
> 
> Thanks,
> Alireza
>>
>>
>>> -- 
>>> 2.34.1
>>
>>
> 


