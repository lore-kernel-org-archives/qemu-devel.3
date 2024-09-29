Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D457CCF6495
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 07:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suocE-0003En-Tr; Sun, 29 Sep 2024 03:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1suocC-00036O-PS
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 03:45:12 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1suocA-0001Ss-RB
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 03:45:12 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxEIiDBflmeLYDAA--.3291S3;
 Sun, 29 Sep 2024 15:45:07 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front2 (Coremail) with SMTP id qciowMBx+cWCBflmtdUXAA--.19913S3;
 Sun, 29 Sep 2024 15:45:07 +0800 (CST)
Subject: Re: [PATCH v3 0/2] Add FDT table support with acpi ged pm register
To: Bibo Mao <maobibo@loongson.cn>, "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>, =?UTF-8?Q?Thomas_Wei=c3=9fschuh?=
 <thomas@t-8ch.de>, qemu-devel@nongnu.org
References: <20240918014206.2165821-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <59e3f1e9-408e-9884-12ce-31431ed82e33@loongson.cn>
Date: Sun, 29 Sep 2024 15:45:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240918014206.2165821-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qciowMBx+cWCBflmtdUXAA--.19913S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWrKr15Ar1xKr4UCw48Cw13WrX_yoW8Jry3pa
 yq9F98Gr13XFWa9a1fta4vg3Z8Wr4IkrWDuF42k3y8GF43W3sYqF48Aw1Dua4Utwn7Xw4v
 qay7K345uFW5ZrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1Li
 SJUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.165, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

ÔÚ 2024/9/18 ÉÏÎç9:42, Bibo Mao Ð´µÀ:
> ACPI ged is used for power management on LoongArch virt platform, in
> general it is parsed from acpi table. However if system boot directly from
> elf kernel, no UEFI bios is provided and acpi table cannot be used also.
>
> Here acpi ged pm register is exposed with FDT table, it is compatbile
> with syscon method in FDT table, only that acpi ged pm register is accessed
> with 8-bit mode, rather with 32-bit mode.
>
> ---
> v2 ... v3:
>    1. Keep orginal macro name ACPI_GED_SLP_TYP_S5 unchanged, renaming
>       ACPI_GED_SLP_TYPx_y with  ACPI_GED_SLP_TYP_y
>    2. Add acpi chapter reference with notation
>
> v1 ... v2:
>    1. Modify name of macro for acpi ged register from ACPI spec, and also add
>       comments for macro definition.
> ---
> Bibo Mao (2):
>    acpi: ged: Add macro for acpi sleep control register
>    hw/loongarch/virt: Add FDT table support with acpi ged pm register
>
>   hw/acpi/generic_event_device.c         |  6 ++--
>   hw/loongarch/virt.c                    | 39 ++++++++++++++++++++++++++
>   include/hw/acpi/generic_event_device.h |  7 +++--
>   3 files changed, 47 insertions(+), 5 deletions(-)
>
>
> base-commit: 2b81c046252fbfb375ad30632362fc16e6e22bd5
Applied to loongarch-next

Thanks.
Song Gao


