Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B392C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 09:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4dQf-00087Q-Pd; Wed, 08 May 2024 05:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1s4dQd-000876-9C
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:17:35 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1s4dQa-0000Y5-Ae
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:17:35 -0400
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8DxPOslQztm_0wJAA--.18251S3;
 Wed, 08 May 2024 17:17:26 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxBlcjQztmknEVAA--.25108S3; 
 Wed, 08 May 2024 17:17:25 +0800 (CST)
Subject: Re: [PATCH] tests/qtest/boot-serial-test: Add support on LoongArch
 system
To: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240508085514.2510592-1-maobibo@loongson.cn>
 <4ce31fa5-16b0-491c-9956-35ed68af2a6f@redhat.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <e3d419c0-a1f3-9158-fccd-db6931cc4757@loongson.cn>
Date: Wed, 8 May 2024 17:17:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <4ce31fa5-16b0-491c-9956-35ed68af2a6f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxBlcjQztmknEVAA--.25108S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGF1DZr1ktFyktw1UZrWUtrc_yoW5Ww47p3
 WkA3y5tFy8GFn5tr17WF15XFyrXr1DJ3WDGF10gF17JrsxAr10gr1agrWjgr1DJF4kZF18
 AwnrJr1rZF17trXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07Ui
 iSdUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.593,
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



On 2024/5/8 下午5:00, Thomas Huth wrote:
> On 08/05/2024 10.55, Bibo Mao wrote:
>> Add boot-serial-test test case support on LoongArch system.
> 
> ... and also the filter tests?
yes, it is :) Will update changelog in next version.

> 
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   tests/qtest/boot-serial-test.c | 10 ++++++++++
>>   tests/qtest/meson.build        |  4 ++++
>>   2 files changed, 14 insertions(+)
>>
>> diff --git a/tests/qtest/boot-serial-test.c 
>> b/tests/qtest/boot-serial-test.c
>> index e3b7d65fe5..631015e8c8 100644
>> --- a/tests/qtest/boot-serial-test.c
>> +++ b/tests/qtest/boot-serial-test.c
>> @@ -129,6 +129,14 @@ static const uint8_t kernel_stm32vldiscovery[] = {
>>       0x04, 0x38, 0x01, 0x40                  /* 0x40013804 = USART1 
>> TXD */
>>   };
>> +static const uint8_t bios_loongarch64[] = {
>> +    0x0c, 0xc0, 0x3f, 0x14,            /* lu12i.w $t0,  0x1fe00    */
>> +    0x8c, 0x81, 0x87, 0x03,            /* ori     $t0,  $t0, 0x1e0 */
>> +    0x0d, 0x50, 0x81, 0x03,            /* li.w    $t1,  'T'        */
>> +    0x8d, 0x01, 0x00, 0x29,            /* st.b    $t1, $t0,  0     */
>> +    0xff, 0xf3, 0xff, 0x53,            /*  b      -16  #loop       */
>> +};
>> +
>>   typedef struct testdef {
>>       const char *arch;       /* Target architecture */
>>       const char *machine;    /* Name of the machine */
>> @@ -181,6 +189,8 @@ static const testdef_t tests[] = {
>>       { "arm", "microbit", "", "T", sizeof(kernel_nrf51), kernel_nrf51 },
>>       { "arm", "stm32vldiscovery", "", "T",
>>         sizeof(kernel_stm32vldiscovery), kernel_stm32vldiscovery },
>> +    { "loongarch64", "virt", "-cpu max", "TT", sizeof(bios_loongarch64),
>> +      NULL, bios_loongarch64 },
>>       { NULL }
>>   };
>> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
>> index 6f2f594ace..6619b630e6 100644
>> --- a/tests/qtest/meson.build
>> +++ b/tests/qtest/meson.build
>> @@ -256,6 +256,10 @@ qtests_s390x = \
>>   qtests_riscv32 = \
>>     (config_all_devices.has_key('CONFIG_SIFIVE_E_AON') ? 
>> ['sifive-e-aon-watchdog-test'] : [])
>> + qtests_loongarch64 = \
>> +  qtests_filter + \
>> +  ['boot-serial-test']
> 
> It's already a little bit messed up, but I think we originally had the 
> entries in alphabetical order, so I'd like to suggest to add this 
> between qtests_hppa and qtests_m68k instead.
sure, will do.

Regards
Bibo Mao
> 
>   Thomas
> 
> 
>>   qos_test_ss = ss.source_set()
>>   qos_test_ss.add(
>>     'ac97-test.c',
>>
>> base-commit: 4e66a08546a2588a4667766a1edab9caccf24ce3
> 


