Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDADC48BEF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 03:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbBkG-0001J5-8U; Fri, 16 Feb 2024 22:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1rbBkE-0001I6-9h; Fri, 16 Feb 2024 22:52:06 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>)
 id 1rbBkB-0006jq-CM; Fri, 16 Feb 2024 22:52:06 -0500
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8AxjutYLdBl+PENAA--.37018S3;
 Sat, 17 Feb 2024 11:51:53 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxZMxXLdBlduY4AA--.20163S3; 
 Sat, 17 Feb 2024 11:51:52 +0800 (CST)
Subject: Re: [PATCH] tests/cdrom-test: Add cdrom test for LoongArch virt
 machine
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20240205021318.3759925-1-maobibo@loongson.cn>
 <678324f1-2b8d-45a1-aea8-03c187f069d1@linaro.org>
 <e0052a77-d6b1-fee9-a179-d7074132304f@loongson.cn>
 <387d27bf-2bdb-432a-baf1-19fb0d026045@redhat.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <afd8bd94-6d32-a387-1b9b-91ac5ef83030@loongson.cn>
Date: Sat, 17 Feb 2024 11:51:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <387d27bf-2bdb-432a-baf1-19fb0d026045@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxZMxXLdBlduY4AA--.20163S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KryUZryfZrWfGry5uFWUKFX_yoW8ur1Upr
 1kAa40kayUGr18Jr1xKw1DWFyYyr4DAa4kur1vqF18GFZ8XryqgrW0gr1Y9r1kJFWfXF18
 Zw18tw13uF1UZrcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
 xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jb_-PU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.399,
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



On 2024/2/6 下午5:20, Thomas Huth wrote:
> On 06/02/2024 03.29, maobibo wrote:
>> Hi Philippe,
>>
>> On 2024/2/5 下午8:58, Philippe Mathieu-Daudé wrote:
>>> Hi Bibo,
>>>
>>> On 5/2/24 03:13, Bibo Mao wrote:
>>>> The cdrom test skips to execute on LoongArch system with command
>>>> "make check", this patch enables cdrom test for LoongArch virt
>>>> machine platform.
>>>>
>>>> With this patch, cdrom test passes to run on LoongArch virt
>>>> machine type.
>>>>
>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>> ---
>>>>   tests/qtest/cdrom-test.c | 3 +++
>>>>   1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
>>>> index 0945383789..c8b97d8d9a 100644
>>>> --- a/tests/qtest/cdrom-test.c
>>>> +++ b/tests/qtest/cdrom-test.c
>>>> @@ -271,6 +271,9 @@ int main(int argc, char **argv)
>>>>               const char *virtmachine[] = { "virt", NULL };
>>>>               add_cdrom_param_tests(virtmachine);
>>>>           }
>>>> +    } else if (g_str_equal(arch, "loongarch64")) {
>>>> +        const char *virtmachine[] = { "virt", NULL };
>>>> +        add_cdrom_param_tests(virtmachine);
>>>
>>> What is the default device used, virtio-blk-pci?
>>>
>> yes, it is. For virt machine type, the default type for block device is
>> virtio interface, and it is defined at function loongarch_class_init().
>>     mc->block_default_type = IF_VIRTIO
> 
> Ok, then you might need to check whether your patch still works when you 
> run "configure" with "--without-default-devices". You might need to 
> check with 'if (qtest_has_device("virtio-blk-pci"))' whether the device 
> is really available in the binary, like it is done some lines earlier in 
> the arm case.
Sorry for the late response. Yes cdrom test case will report failure 
with it is compiled with --without-default-devices option.

I will refresh the patch like arm case.

Regards
Bibo Mao
> 
>   Thomas
> 


