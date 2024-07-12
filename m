Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 752B0C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 01:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS5CS-0003WV-UB; Thu, 11 Jul 2024 21:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sS5CF-0003BD-VD
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 21:35:44 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sS5CC-0008Cf-1d
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 21:35:39 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Cx5OliiJBmF4MDAA--.979S3;
 Fri, 12 Jul 2024 09:35:30 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxjsdfiJBmACJFAA--.26699S3; 
 Fri, 12 Jul 2024 09:35:29 +0800 (CST)
Subject: Re: [PULL 0/9] loongarch-to-apply queue
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
References: <20240711074829.3338879-1-gaosong@loongson.cn>
 <78d9f6d3-9257-40a8-b9e1-6690b80e122b@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <629d1223-087b-0ae6-81c7-cec885d11d77@loongson.cn>
Date: Fri, 12 Jul 2024 09:35:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <78d9f6d3-9257-40a8-b9e1-6690b80e122b@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8AxjsdfiJBmACJFAA--.26699S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7urW3trW7Wr17Xry3tFyxZwc_yoW8CrWrpr
 ZavF17JrWrGws7Jr1ktwn8XryUtw17Jw47X3WUXFy8AF4UAr1Yqrn5XryvgFy7J3y8Jr15
 XF18Aw1UZF47XrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.862,
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

在 2024/7/11 下午5:57, Philippe Mathieu-Daudé 写道:
> Hi Richard,
>
> On 11/7/24 09:48, Song Gao wrote:
>> The following changes since commit 
>> 59084feb256c617063e0dbe7e64821ae8852d7cf:
>>
>>    Merge tag 'pull-aspeed-20240709' of 
>> https://github.com/legoater/qemu into staging (2024-07-09 07:13:55 
>> -0700)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240711
>>
>> for you to fetch changes up to 78341408e705e1b8dc92eaae2071ae0023d586b0:
>>
>>    target/loongarch: Fix cpu_reset set wrong CSR_CRMD (2024-07-11 
>> 15:56:50 +0800)
>>
>> ----------------------------------------------------------------
>> pull-loongarch-20240711
>>
>> ----------------------------------------------------------------
>> Bibo Mao (2):
>>        hw/loongarch/virt: Remove unused assignment
>>        target/loongarch/kvm: Add software breakpoint support
>>
>> Dmitry Frolov (1):
>>        hw/loongarch/boot.c: fix out-of-bound reading
>>
>> Feiyang Chen (1):
>>        target/loongarch: Remove avail_64 in trans_srai_w() and 
>> simplify it
>>
>> Jiaxun Yang (1):
>>        MAINTAINERS: Add myself as a reviewer of LoongArch virt machine
>>
>> Song Gao (2):
>>        target/loongarch: Set CSR_PRCFG1 and CSR_PRCFG2 values
>>        target/loongarch: Fix cpu_reset set wrong CSR_CRMD
>>
>> Xianglai Li (2):
>>        hw/loongarch: Change the tpm support by default
>>        hw/loongarch: Modify flash block size to 256K
>
> Please hold on before merging, I'd like to check with
> the author for migration issue regarding the flash block size
> change.
>
I'll drop this patch on v2, and push it next time.

Thanks
Song Gao
> Thanks,
>
> Phil.


