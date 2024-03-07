Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83EDC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 16:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riGIP-0007SP-KV; Thu, 07 Mar 2024 11:08:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1riGIN-0007PQ-O5
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 11:08:35 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1riGIK-00006h-Fc
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 11:08:35 -0500
Received: from loongson.cn (unknown [117.67.153.132])
 by gateway (Coremail) with SMTP id _____8Bxieh75ull8vsVAA--.35106S3;
 Fri, 08 Mar 2024 00:08:28 +0800 (CST)
Received: from [192.168.2.12] (unknown [117.67.153.132])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxTRNm5ullEVlQAA--.17246S3; 
 Fri, 08 Mar 2024 00:08:26 +0800 (CST)
Subject: Re: [PULL v2 00/17] loongarch-to-apply queue
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>
References: <20240307152835.299233-1-gaosong@loongson.cn>
 <CAFEAcA81hgtmpvQopayV6AL2bi1gz3nYvfyga=jRpp9xnw3puQ@mail.gmail.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <b49a6dc3-8d67-5db3-2d05-2f7b98e5318a@loongson.cn>
Date: Fri, 8 Mar 2024 00:08:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA81hgtmpvQopayV6AL2bi1gz3nYvfyga=jRpp9xnw3puQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxTRNm5ullEVlQAA--.17246S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WrW3tr1xXr43Cr13ZF4rXrc_yoW8ZFy3pr
 W3A3W3Ar48GFsrAr1kt3sFgr1jyrn7Gry2q3W7Xr18CFZrZr1rXF1xArW8ZFyUK34kJryj
 vr1Fyw1jqF4DJwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Jr0_Gr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrNtxDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.08,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



在 2024/3/7 23:37, Peter Maydell 写道:
> On Thu, 7 Mar 2024 at 15:28, Song Gao <gaosong@loongson.cn> wrote:
>>
>> The following changes since commit 8f6330a807f2642dc2a3cdf33347aa28a4c00a87:
>>
>>    Merge tag 'pull-maintainer-updates-060324-1' of https://gitlab.com/stsquad/qemu into staging (2024-03-06 16:56:20 +0000)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240307
>>
>> for you to fetch changes up to 4dc2edfd6f8abfc38f0ba110502790aa5051b1b5:
>>
>>    hw/loongarch: Add cells missing from rtc node (2024-03-07 21:58:00 +0800)
>>
>> ----------------------------------------------------------------
>> pull-loongarch-20240307
>>
>> ----------------------------------------------------------------
>> Song Gao (17):
>>        hw/loongarch: Move boot fucntions to boot.c
>>        hw/loongarch: Add load initrd
>>        hw/loongarch: Add slave cpu boot_code
>>        hw/loongarch: Add init_cmdline
>>        hw/loongarch: Init efi_system_table
>>        hw/loongarch: Init efi_boot_memmap table
>>        hw/loongarch: Init efi_initrd table
>>        hw/loongarch: Init efi_fdt table
>>        hw/loongarch: Fix fdt memory node wrong 'reg'
>>        hw/loongarch: fdt adds cpu interrupt controller node
>>        hw/loongarch: fdt adds Extend I/O Interrupt Controller
>>        hw/loongarch: fdt adds pch_pic Controller
>>        hw/loongarch: fdt adds pch_msi Controller
>>        hw/loongarch: fdt adds pcie irq_map node
>>        hw/loongarch: fdt remove unused irqchip node
>>        hw/loongarch: Add cells missing from uart node
>>        hw/loongarch: Add cells missing from rtc node
> 
> Looks like our emails crossed, but see my remarks on v1
> about test/compilation failures.
>
Ah, I'll fix these issues.

> Also I have just noticed that none of these patches have
> Reviewed-by: tags. Please make sure patches are code
> reviewed before submitting them in pull requests.
> OK.

and BiBo, Could you help review the v6 series?

Thanks.
Song Gao
> thanks
> -- PMM
> 


