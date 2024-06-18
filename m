Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79207C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 04:02:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJQ1x-000842-QF; Tue, 18 Jun 2024 00:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sJQ1p-00082L-3e
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 00:01:06 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sJQ1i-0001s3-Gr
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 00:01:02 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8DxzOpxBnFmys0HAA--.31384S3;
 Tue, 18 Jun 2024 12:00:49 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxTcduBnFmC88mAA--.28701S3; 
 Tue, 18 Jun 2024 12:00:48 +0800 (CST)
Subject: Re: [PATCH 18/18] tcg/loongarch64: Enable v256 with LASX
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: git@xen0n.name
References: <20240527211912.14060-1-richard.henderson@linaro.org>
 <20240527211912.14060-19-richard.henderson@linaro.org>
 <66800a74-2a89-4c35-acac-30898302b3d0@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <d6497261-4b9d-ff98-9d88-51bde5aecd0d@loongson.cn>
Date: Tue, 18 Jun 2024 12:00:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <66800a74-2a89-4c35-acac-30898302b3d0@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8AxTcduBnFmC88mAA--.28701S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ww1ktr1rtry7AFyrGFy3Awc_yoW8AF4fpr
 ykArn8Xry0qrZ5CrW7GF1UXrykAr1jv3WUWF1fWF1fArsrAryjqr18XrW2gF109a18Xr4Y
 v3Wqqw1SvFW5GacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
 67AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
 8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
 CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
 1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
 daVFxhVjvjDU0xZFpf9x07jOF4_UUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.388,
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

在 2024/5/29 下午2:39, Philippe Mathieu-Daudé 写道:
> On 27/5/24 23:19, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/loongarch64/tcg-target.h     |  2 +-
>>   tcg/loongarch64/tcg-target.c.inc | 11 ++++++++---
>>   2 files changed, 9 insertions(+), 4 deletions(-)
>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>
>> diff --git a/tcg/loongarch64/tcg-target.c.inc 
>> b/tcg/loongarch64/tcg-target.c.inc
>> index e2b5aad5e3..0b41b807e3 100644
>> --- a/tcg/loongarch64/tcg-target.c.inc
>> +++ b/tcg/loongarch64/tcg-target.c.inc
>> @@ -2484,9 +2484,14 @@ static void tcg_target_init(TCGContext *s)
>>       tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S8);
>>       tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S9);
>>   -    if (cpuinfo & CPUINFO_LSX) {
>> -        tcg_target_available_regs[TCG_TYPE_V64] = ALL_VECTOR_REGS;
>> -        tcg_target_available_regs[TCG_TYPE_V128] = ALL_VECTOR_REGS;
>> +    if (cpuinfo & (CPUINFO_LSX | CPUINFO_LASX)) {
>> +        if (cpuinfo & CPUINFO_LSX) {
>> +            tcg_target_available_regs[TCG_TYPE_V64] = ALL_VECTOR_REGS;
>> +            tcg_target_available_regs[TCG_TYPE_V128] = ALL_VECTOR_REGS;
>> +        }
>> +        if (cpuinfo & CPUINFO_LASX) {
>> +            tcg_target_available_regs[TCG_TYPE_V256] = ALL_VECTOR_REGS;
>> +        }
>
> Out of curiosity, could we have LASX without LSX?
No.  LSX depends on FPU.  LASX depends on LSX.

Thanks.
Song Gao



