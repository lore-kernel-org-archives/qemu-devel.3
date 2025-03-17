Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11AFFC28B2F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 01:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttz55-00007n-Pl; Sun, 16 Mar 2025 21:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1ttz53-00007F-C2
 for qemu-devel@nongnu.org; Sun, 16 Mar 2025 21:15:49 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1ttz50-0004SQ-NY
 for qemu-devel@nongnu.org; Sun, 16 Mar 2025 21:15:49 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxGHG7d9dn1DiZAA--.64179S3;
 Mon, 17 Mar 2025 09:15:39 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMCx7MS2d9dngHtOAA--.25697S3;
 Mon, 17 Mar 2025 09:15:36 +0800 (CST)
Subject: Re: [PATCH] util/loongarch64: Add clang compiler support
To: Yao Zi <ziyao@disroot.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250307011339.2246600-1-maobibo@loongson.cn>
 <Z9RlPak0A9rjci0X@pie.lan>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <cf1473e1-08fc-3144-f345-8d1922ddfecd@loongson.cn>
Date: Mon, 17 Mar 2025 09:14:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <Z9RlPak0A9rjci0X@pie.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCx7MS2d9dngHtOAA--.25697S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uFWUWFykAr1DKryUCr4rJFc_yoW8ur1rpF
 9Iyrs8Xr48Xw1ftFWUAr1aqrnxX34qvr1xWrZ8Kw1UAFyYqF15Xr4DCF4jkF42vrZ7KF1I
 qF48G39Igayvv3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8wN
 VDUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.664,
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



On 2025/3/15 上午1:19, Yao Zi wrote:
> On Fri, Mar 07, 2025 at 09:13:39AM +0800, Bibo Mao wrote:
>> Float register name f0 - f31 is not recognized with clang compiler
>> with LoongArch64 target, its name should be $f0 - $f31. It is ok
>> for both gcc and clang compiler.
> 
> Sorry I didn't search the list carefully and sent a similar patch[1].
> 
> Apart from preventing the disk tools to be built, this issue affects
> several headers used by linux-user emulators as well. IMHO this should
> be fixed, too, or my patch could be taken.
Yao,

Thanks for your patch. It is found only if clang is used on LoongArch 
host, and your change log note is clearer than mine. Your patch should 
be taken.

Regards
Bibo Mao
> 
> Sorry for the inconvenience,
> Yao Zi
> 
> [1]: https://lore.kernel.org/all/20250314033150.53268-3-ziyao@disroot.org/
> 
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   host/include/loongarch64/host/bufferiszero.c.inc | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/host/include/loongarch64/host/bufferiszero.c.inc b/host/include/loongarch64/host/bufferiszero.c.inc
>> index 69891eac80..bb2598fdc3 100644
>> --- a/host/include/loongarch64/host/bufferiszero.c.inc
>> +++ b/host/include/loongarch64/host/bufferiszero.c.inc
>> @@ -61,7 +61,8 @@ static bool buffer_is_zero_lsx(const void *buf, size_t len)
>>       "2:"
>>           : "=&r"(ret), "+r"(p)
>>           : "r"(buf), "r"(e), "r"(l)
>> -        : "f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "fcc0");
>> +        : "$f0", "$f1", "$f2", "$f3", "$f4", "$f5", "$f6", "$f7", "$f8",
>> +          "$fcc0");
>>   
>>       return ret;
>>   }
>> @@ -119,7 +120,8 @@ static bool buffer_is_zero_lasx(const void *buf, size_t len)
>>       "3:"
>>           : "=&r"(ret), "+r"(p)
>>           : "r"(buf), "r"(e), "r"(l)
>> -        : "f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "fcc0");
>> +        : "$f0", "$f1", "$f2", "$f3", "$f4", "$f5", "$f6", "$f7", "$f8",
>> +          "$fcc0");
>>   
>>       return ret;
>>   }
>>
>> base-commit: 661c2e1ab29cd9c4d268ae3f44712e8d421c0e56
>> -- 
>> 2.39.3


