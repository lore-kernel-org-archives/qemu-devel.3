Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD44C48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 08:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWu6W-0008Np-PE; Mon, 05 Feb 2024 03:13:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1rWu6S-0008NJ-5T; Mon, 05 Feb 2024 03:13:20 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>)
 id 1rWu6O-0002tu-Fj; Mon, 05 Feb 2024 03:13:19 -0500
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8CxbeuTmMBl09AKAA--.30622S3;
 Mon, 05 Feb 2024 16:13:07 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Ax3c6QmMBlPQAwAA--.49656S3; 
 Mon, 05 Feb 2024 16:13:06 +0800 (CST)
Subject: Re: [PATCH] tests/cdrom-test: Add cdrom test for LoongArch virt
 machine
To: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20240205021318.3759925-1-maobibo@loongson.cn>
 <613f883e-cf64-43e5-85b6-64381c46ffa2@redhat.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <e3e3ee04-c50e-9f0d-6fa8-e650a6c96a15@loongson.cn>
Date: Mon, 5 Feb 2024 16:13:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <613f883e-cf64-43e5-85b6-64381c46ffa2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Ax3c6QmMBlPQAwAA--.49656S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7AryxZFW7Gw1Duw1xGryfAFc_yoW8WF4kpr
 1kAF10k3y8Wr95Jry7Gw1DWFy8Jr4Dta4DCr18ZF48AFZ8Jr1jgr48Wr1j9w1DJayfXr17
 Zw1kJr13ZF17XrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j8
 yCJUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.214,
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



On 2024/2/5 下午3:47, Thomas Huth wrote:
> On 05/02/2024 03.13, Bibo Mao wrote:
>> The cdrom test skips to execute on LoongArch system with command
>> "make check"
> 
> Are you sure the test is marked with "skip"? ... it should at least test 
> with the "none" machine...?
With the latest code, cdrom testcase passes to run. It is strange that 
about two weeks ago, the result displays SKIP, so I post this patch -:)

Regards
Bibo Mao

> 
>> this patch enables cdrom test for LoongArch virt
>> machine platform.
>>
>> With this patch, cdrom test passes to run on LoongArch virt
>> machine type.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   tests/qtest/cdrom-test.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
>> index 0945383789..c8b97d8d9a 100644
>> --- a/tests/qtest/cdrom-test.c
>> +++ b/tests/qtest/cdrom-test.c
>> @@ -271,6 +271,9 @@ int main(int argc, char **argv)
>>               const char *virtmachine[] = { "virt", NULL };
>>               add_cdrom_param_tests(virtmachine);
>>           }
>> +    } else if (g_str_equal(arch, "loongarch64")) {
>> +        const char *virtmachine[] = { "virt", NULL };
>> +        add_cdrom_param_tests(virtmachine);
>>       } else {
>>           const char *nonemachine[] = { "none", NULL };
>>           add_cdrom_param_tests(nonemachine);
> 
> Anyway, using the virt machine is certainly better than the "none" 
> machine, so:
> Acked-by: Thomas Huth <thuth@redhat.com>


