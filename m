Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24196EEB595
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 11:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soi7c-0006B8-6e; Thu, 12 Sep 2024 07:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1soi7Y-0006AY-TL
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 07:36:20 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1soi7W-0001ZW-F4
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 07:36:20 -0400
Received: from loongson.cn (unknown [10.20.42.17])
 by gateway (Coremail) with SMTP id _____8Bxb+sm0uJmVNUFAA--.13919S3;
 Thu, 12 Sep 2024 19:36:06 +0800 (CST)
Received: from [10.20.42.17] (unknown [10.20.42.17])
 by front1 (Coremail) with SMTP id qMiowMCxodYa0uJmmrwEAA--.26723S3;
 Thu, 12 Sep 2024 19:36:05 +0800 (CST)
Subject: Re: [PATCH v2 0/2] Add FDT table support with acpi ged pm register
To: Bibo Mao <maobibo@loongson.cn>, "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: Ani Sinha <anisinha@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>, =?UTF-8?Q?Thomas_Wei=c3=9fschuh?=
 <thomas@t-8ch.de>, qemu-devel@nongnu.org
References: <20240911030922.877259-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <72d5883d-815e-1f82-236e-1d3cbdb834a9@loongson.cn>
Date: Thu, 12 Sep 2024 19:35:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240911030922.877259-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxodYa0uJmmrwEAA--.26723S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKr15Ar1xKr4UCw48Cw13WrX_yoWktrcE9r
 n2v348WFyDWFyIkFWqvw1rA348GayxWw1fZ3ZrKr48Ga4rt3yDCrW5X3WxZrnrtr4UWwsY
 qF1vqr1fCr13WosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_Ma
 UUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-2.188, SPF_HELO_NONE=0.001,
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



ÔÚ 2024/9/11 ÉÏÎç11:09, Bibo Mao Ð´µÀ:
> ACPI ged is used for power management on LoongArch virt platform, in
> general it is parsed from acpi table. However if system boot directly from
> elf kernel, no UEFI bios is provided and acpi table cannot be used also.
> 
> Here acpi ged pm register is exposed with FDT table, it is compatbile
> with syscon method in FDT table, only that acpi ged pm register is accessed
> with 8-bit mode, rather with 32-bit mode.
> 
> ---
> v1 ... v2:
>    1. Modify name of macro for acpi ged register from ACPI spec, and also add
>       comments for macro definition.
> ---
> Bibo Mao (2):
>    acpi: ged: Add macro for acpi sleep control register
>    hw/loongarch/virt: Add FDT table support with acpi ged pm register
> 


>   hw/acpi/generic_event_device.c         |  6 ++--
>   hw/i386/acpi-microvm.c                 |  2 +-
>   hw/loongarch/acpi-build.c              |  2 +-
>   hw/loongarch/virt.c                    | 39 ++++++++++++++++++++++++++
>   include/hw/acpi/generic_event_device.h |  9 ++++--
>   5 files changed, 51 insertions(+), 7 deletions(-)
> 
> 
> base-commit: a66f28df650166ae8b50c992eea45e7b247f4143
> Reviewed-by: Song Gao <gaosong@loongson.cn>

Applied series to loongarch-next

Thanks
Song Gao




