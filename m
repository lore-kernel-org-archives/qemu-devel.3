Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D456EC27C53
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 02:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF2gs-0007J3-7j; Wed, 05 Jun 2024 22:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sF2gp-0007Hy-IU
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 22:17:19 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sF2gm-0008Kk-JZ
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 22:17:19 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Dxi+okHGFmEA0EAA--.17410S3;
 Thu, 06 Jun 2024 10:17:08 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxmsYhHGFm1l8WAA--.55737S3; 
 Thu, 06 Jun 2024 10:17:07 +0800 (CST)
Subject: Re: [PATCH 1/2] util: Add lasx cpuinfo for loongarch64
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20240605093213.2191929-1-maobibo@loongson.cn>
 <20240605093213.2191929-2-maobibo@loongson.cn>
 <b4335eb7-0143-4a37-8fbf-3cf5ff528411@linaro.org>
From: maobibo <maobibo@loongson.cn>
Message-ID: <33c428d9-b09f-07f3-e273-862a1252133a@loongson.cn>
Date: Thu, 6 Jun 2024 10:17:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b4335eb7-0143-4a37-8fbf-3cf5ff528411@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxmsYhHGFm1l8WAA--.55737S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kr18WF1xtw43trWxCr4DAwc_yoW8AFy7pF
 Z7AF1fJFW8GrykWryDXr4Sqr9rXrsrG3W2gF13GF1vyFsIyr1YqF1kZFyj9FnFqan7JF10
 qr18Xw18ZF15JrcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j8yCJU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.975,
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



On 2024/6/5 下午7:53, Philippe Mathieu-Daudé wrote:
> On 5/6/24 11:32, Bibo Mao wrote:
>> Lasx is 256bit vector FPU capability, lsx is 128bit vector VFP. lsx
>> is added already, lasx is added here.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   host/include/loongarch64/host/cpuinfo.h | 1 +
>>   util/cpuinfo-loongarch.c                | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/host/include/loongarch64/host/cpuinfo.h 
>> b/host/include/loongarch64/host/cpuinfo.h
>> index fab664a10b..d7bf27501d 100644
>> --- a/host/include/loongarch64/host/cpuinfo.h
>> +++ b/host/include/loongarch64/host/cpuinfo.h
>> @@ -8,6 +8,7 @@
>>   #define CPUINFO_ALWAYS          (1u << 0)  /* so cpuinfo is nonzero */
>>   #define CPUINFO_LSX             (1u << 1)
>> +#define CPUINFO_LASX            (1u << 2)
>>   /* Initialized with a constructor. */
>>   extern unsigned cpuinfo;
>> diff --git a/util/cpuinfo-loongarch.c b/util/cpuinfo-loongarch.c
>> index 08b6d7460c..bb1f7f698b 100644
>> --- a/util/cpuinfo-loongarch.c
>> +++ b/util/cpuinfo-loongarch.c
>> @@ -29,6 +29,7 @@ unsigned __attribute__((constructor)) 
>> cpuinfo_init(void)
>>       info = CPUINFO_ALWAYS;
>>       info |= (hwcap & HWCAP_LOONGARCH_LSX ? CPUINFO_LSX : 0);
>> +    info |= (hwcap & HWCAP_LOONGARCH_LASX ? CPUINFO_LASX : 0);
>>       cpuinfo = info;
>>       return info;
> 
> This is 
> https://lore.kernel.org/qemu-devel/20240527211912.14060-6-richard.henderson@linaro.org/ 
oops, I did not notice this.

And I will drop patch 1 and refresh the patch based on this weblink.

Regards
Bibo Mao


