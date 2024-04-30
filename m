Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C23C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 08:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1ieE-0005hz-4X; Tue, 30 Apr 2024 04:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s1ie8-0005hQ-Kd
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 04:15:30 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s1ie5-0001xu-8H
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 04:15:28 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxJvCVqDBmN1UFAA--.17669S3;
 Tue, 30 Apr 2024 16:15:18 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxY1aQqDBmAPUKAA--.9705S3; 
 Tue, 30 Apr 2024 16:15:14 +0800 (CST)
Subject: Re: [PATCH 0/5] hw/loongarch: Refine numa memory map
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20240318080121.2836548-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <1f480301-996c-f314-e41e-55d842d934e9@loongson.cn>
Date: Tue, 30 Apr 2024 16:15:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240318080121.2836548-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8CxY1aQqDBmAPUKAA--.9705S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJrWxZw4kGFWrKFWrCw17Arc_yoW8Ww18pr
 4fAFn8Kr48tF9xAryfC34DWFn8tw1xGwnrXFy2vrykCr43Ar18Zr10vr9IvF9xZ3y8Jr18
 uF1kKw13Wa18J3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CP
 fJUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.127,
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

Hi,

在 2024/3/18 下午4:01, Bibo Mao 写道:
> One LoongArch virt machine platform, there is limitation for memory
> map information. The minimum memory size is 256M and minimum memory
> size for numa node0 is 256M also. With qemu numa qtest, it is possible
> that memory size of numa node0 is 128M.
>
> Limitations for minimum memory size for both total memory and numa
> node0 is removed here, including acpi srat table, fadt memory map table
> and fw_cfg memory map table.
>
> Also remove numa node about memory region, there is only low memory
> region and how memory region.
For this series,
Reviewed-by: Song Gao <gaosong@loongson.cn>

After PR[1] merge in, patch3 and patch4 need Rebase.
Also, how about enabling LoongArch architecture numa-test?

like this:

    --- a/tests/qtest/meson.build
    +++ b/tests/qtest/meson.build
    @@ -127,6 +127,8 @@ else
        dbus_vmstate1 = []
      endif

    +qtests_loongarch64 = ['numa-test'] + qtests_filter
    +
      qtests_x86_64 = qtests_i386

      qtests_alpha = ['boot-serial-test'] + \


[1] https://patchew.org/QEMU/20240429023043.2607982-1-gaosong@loongson.cn/


Thanks.
Song Gao
> Bibo Mao (5):
>    hw/loongarch: Refine acpi srat table for numa memory
>    hw/loongarch: Refine fadt memory table for numa memory
>    hw/loongarch: Refine fwcfg memory map
>    hw/loongarch: Refine system dram memory region
>    hw/loongarch: Remove minimum and default memory size
>
>   hw/loongarch/acpi-build.c |  58 +++++++------
>   hw/loongarch/virt.c       | 168 ++++++++++++++++++++++++++------------
>   2 files changed, 152 insertions(+), 74 deletions(-)
>
>
> base-commit: ba49d760eb04630e7b15f423ebecf6c871b8f77b


