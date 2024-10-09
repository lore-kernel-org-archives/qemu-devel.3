Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA42CEDD85
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 11:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syUxd-0003Gb-Sd; Wed, 09 Oct 2024 07:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1syUxa-0003GP-GW
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 07:34:30 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1syUxX-00054P-Ia
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 07:34:30 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8DxPIsyagZnweMQAA--.24176S3;
 Wed, 09 Oct 2024 19:34:10 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front2 (Coremail) with SMTP id qciowMBxe8YvagZnJrgkAA--.50407S3;
 Wed, 09 Oct 2024 19:34:08 +0800 (CST)
Subject: Re: [PULL 0/7] loongarch-to-apply queue
To: Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: qemu-devel@nongnu.org
References: <20240929081724.2139556-1-gaosong@loongson.cn>
 <CAFEAcA-zgk0rJPqBhHQQwV-pQ-eR8+Mo5F+U3=F31NRk9Vy9tw@mail.gmail.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <8af135b6-1f56-6863-2c1e-ba5280764c0a@loongson.cn>
Date: Wed, 9 Oct 2024 19:34:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-zgk0rJPqBhHQQwV-pQ-eR8+Mo5F+U3=F31NRk9Vy9tw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qciowMBxe8YvagZnJrgkAA--.50407S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cry3AFyxWr1rGr1Dtr1rZrc_yoW8uF13pF
 WfAFn7GrW8Jr1Utr4xJryUAr1Yyrn3G34UZw1UJrykXF42vr95Wr1xWrWrWFy7W348KrWF
 9ry5J3WDXF98AabCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7XTm
 DUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.649,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

在 2024/9/30 下午10:06, Peter Maydell 写道:
> On Sun, 29 Sept 2024 at 09:35, Song Gao <gaosong@loongson.cn> wrote:
>> The following changes since commit 3b14a767eaca3df5534a162851f04787b363670e:
>>
>>    Merge tag 'qemu-openbios-20240924' of https://github.com/mcayland/qemu into staging (2024-09-28 12:34:44 +0100)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240929
>>
>> for you to fetch changes up to f7c8ef7bad7495d8c84b262a8b243efe39e56b13:
>>
>>    hw/loongarch/fw_cfg: Build in common_ss[] (2024-09-29 16:22:56 +0800)
>>
>> ----------------------------------------------------------------
>> pull-loongarch-20240929
>>
>> ----------------------------------------------------------------
> Hi; this fails to build on 32-bit hosts:
>
>
> https://gitlab.com/qemu-project/qemu/-/jobs/7953018819
> https://gitlab.com/qemu-project/qemu/-/jobs/7953018846
>
> ../hw/loongarch/boot.c: In function ‘init_systab_32’:
> ../hw/loongarch/boot.c:187:10: error: cast to pointer from integer of
> different size [-Werror=int-to-pointer-cast]
> 187 |           ((typeof(p))((uintptr_t)(s) + \
>      |            ^
> ../hw/loongarch/boot.c:201:9: note: in expansion of macro ‘BOOTP_ALIGN_PTR_UP’
> 201 |      p = BOOTP_ALIGN_PTR_UP(p, start, EFI_TABLE_ALIGN); \
>      |          ^~~~~~~~~~~~~~~~~~
> ../hw/loongarch/boot.c:243:1: note: in expansion of macro ‘EFI_INIT_SYSTAB_GEN’
> 243 | EFI_INIT_SYSTAB_GEN(32)
>      | ^~~~~~~~~~~~~~~~~~~
> ../hw/loongarch/boot.c:187:10: error: cast to pointer from integer of
> different size [-Werror=int-to-pointer-cast]
> 187 |          ((typeof(p))((uintptr_t)(s) + \
>      |           ^
>
> etc.
>
> This happens because if the argument 'n' to BOOTP_ALIGN_PTR_UP()
> is a 64-bit type (as EFI_TABLE_ALIGN happens to be) then the
> expression ends up being calculated as 64-bits, which is bigger
> than the type of a pointer on these hosts.
>
> -- PMM
Sorry for  the late reply.

@Jiaxun  Could you fix this and update the patch?

Thanks.
Song Gao


