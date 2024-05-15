Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A668C25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 08:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7A00-0003lK-U7; Wed, 15 May 2024 04:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s79zy-0003kw-7N
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:28:30 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s79zu-0000d0-VG
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:28:30 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxN+kLckRmUf4MAA--.19317S3;
 Wed, 15 May 2024 16:27:56 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id AQAAf8DxsFUIckRmREMgAA--.8S3; 
 Wed, 15 May 2024 16:27:54 +0800 (CST)
Subject: Re: [PATCH v2 0/6] hw/loongarch: Refine numa memory map
To: Bibo Mao <maobibo@loongson.cn>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240507034904.2391129-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <5b38ce4d-7eed-d4e3-80f6-98e5ca2c41e0@loongson.cn>
Date: Wed, 15 May 2024 16:27:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240507034904.2391129-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8DxsFUIckRmREMgAA--.8S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZrWUWFWxXr1fCr4UXrWkuFX_yoW8Xr45p3
 ySvF15Kr48tF9xAr1fA3s7WF13tr1xK3ZrXFy2vFykCr43Ary8ur1IqF90yF97J34rJr10
 9F18KwnrWa1UJ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL
 05UUUUU==
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

在 2024/5/7 上午11:48, Bibo Mao 写道:
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
>
Hi,  This series need rebase.

And  for this series.

Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> ---
> v1 ... v2:
>    1. Refresh the patch based on the latest qemu version, solve the
> confliction issue.
>    2. Add numa test case for loongarch system.
> ---
> Bibo Mao (6):
>    hw/loongarch: Refine acpi srat table for numa memory
>    hw/loongarch: Refine fadt memory table for numa memory
>    hw/loongarch: Refine fwcfg memory map
>    hw/loongarch: Refine system dram memory region
>    hw/loongarch: Remove minimum and default memory size
>    tests/qtest: Add numa test for loongarch system
>
>   hw/loongarch/acpi-build.c |  58 +++++++------
>   hw/loongarch/virt.c       | 167 +++++++++++++++++++++++++++-----------
>   tests/qtest/meson.build   |   2 +
>   3 files changed, 154 insertions(+), 73 deletions(-)
>
>
> base-commit: 248f6f62df073a3b4158fd0093863ab885feabb5


