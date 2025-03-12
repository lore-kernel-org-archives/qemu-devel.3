Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7054C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 07:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsG6m-0004lb-T5; Wed, 12 Mar 2025 03:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tsG6h-0004jP-H5
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 03:02:23 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tsG6d-0002DD-OB
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 03:02:23 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxbKxvMdFnbgmTAA--.54192S3;
 Wed, 12 Mar 2025 15:02:08 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMCx7MRkMdFn+GxFAA--.59957S3;
 Wed, 12 Mar 2025 15:02:06 +0800 (CST)
Subject: Re: [PATCH v2] tests/qtest/cpu-plug-test: Add cpu hotplug support for
 LoongArch
To: Thomas Huth <thuth@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20250312034445.3350705-1-maobibo@loongson.cn>
 <2c9e0443-538a-442e-a03b-58e5117e4a2f@redhat.com>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <56959c91-2b83-2b21-4769-0c4bf0b2f86b@loongson.cn>
Date: Wed, 12 Mar 2025 15:01:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <2c9e0443-538a-442e-a03b-58e5117e4a2f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCx7MRkMdFn+GxFAA--.59957S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxur4fJFyktFWkKw18Zr1fAFc_yoWrXF1Dpr
 ykArWFkrW8Arn3Jw1xGF1UWFyrJr17G3Z8Jr4xXF1UCr4DAr1jgr4jga1qgFnrAw48Xr18
 Aw1DXrnxuFnrJFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.105,
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



On 2025/3/12 下午2:29, Thomas Huth wrote:
> On 12/03/2025 04.44, Bibo Mao wrote:
>> Add cpu hotplug testcase support for LoongArch system, it passes to
>> run with command "make check-qtest-loongarch64" as following:
>>    qemu:qtest+qtest-loongarch64 / qtest-loongarch64/cpu-plug-test OK 
>> 0.38s 1 subtests passed
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>> v1 ... v2:
>>    1. Call test function add_loongarch_test_case() directly rather than
>>       qtest_cb_for_every_machine() since compatible machine is not
>>       supported on LoongArch system.
>>    2. Add architecture specified test case in separate line.
>> ---
>>   tests/qtest/cpu-plug-test.c | 28 ++++++++++++++++++++++++++++
>>   tests/qtest/meson.build     |  3 ++-
>>   2 files changed, 30 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/qtest/cpu-plug-test.c b/tests/qtest/cpu-plug-test.c
>> index 6633abfc10..6af81330c0 100644
>> --- a/tests/qtest/cpu-plug-test.c
>> +++ b/tests/qtest/cpu-plug-test.c
>> @@ -156,6 +156,32 @@ static void add_s390x_test_case(const char *mname)
>>       g_free(path);
>>   }
>> +static void add_loongarch_test_case(const char *mname)
>> +{
>> +    char *path;
>> +    PlugTestData *data;
>> +
>> +    if (!g_str_has_prefix(mname, "virt")) {
>> +        return;
>> +    }
> 
> Should be ok to drop that check now ?
Both are ok for me -:)

By now there are three machine types supported, only type virt passes to 
run cpu hotplug test case, machine type none/x-remote fails to run.

# ./qemu-system-loongarch64 --machine help
Supported machines are:
none                 empty machine
virt                 QEMU LoongArch Virtual Machine (default)
x-remote             Experimental remote machine

Regards
Bibo Mao
> 
>> +    data = g_new(PlugTestData, 1);
>> +    data->machine = g_strdup(mname);
>> +    data->cpu_model = "la464";
>> +    data->device_model = g_strdup("la464-loongarch-cpu");
>> +    data->sockets = 1;
>> +    data->cores = 3;
>> +    data->threads = 1;
>> +    data->maxcpus = data->sockets * data->cores * data->threads;
>> +
>> +    path = g_strdup_printf("cpu-plug/%s/device-add/%ux%ux%u&maxcpus=%u",
>> +                           mname, data->sockets, data->cores,
>> +                           data->threads, data->maxcpus);
>> +    qtest_add_data_func_full(path, data, test_plug_with_device_add,
>> +                             test_data_free);
>> +    g_free(path);
>> +}
>> +
>>   int main(int argc, char **argv)
>>   {
>>       const char *arch = qtest_get_arch();
>> @@ -168,6 +194,8 @@ int main(int argc, char **argv)
>>           qtest_cb_for_every_machine(add_pseries_test_case, 
>> g_test_quick());
>>       } else if (g_str_equal(arch, "s390x")) {
>>           qtest_cb_for_every_machine(add_s390x_test_case, 
>> g_test_quick());
>> +    } else if (g_str_equal(arch, "loongarch64")) {
>> +        add_loongarch_test_case("virt");
>>       }
>>       return g_test_run();
>> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
>> index 8a6243382a..7e62204dcc 100644
>> --- a/tests/qtest/meson.build
>> +++ b/tests/qtest/meson.build
>> @@ -149,7 +149,8 @@ qtests_hppa = \
>>   qtests_loongarch64 = qtests_filter + \
>>     (config_all_devices.has_key('CONFIG_LOONGARCH_VIRT') ? 
>> ['numa-test'] : []) + \
>> -  ['boot-serial-test']
>> +  ['boot-serial-test',
>> +   'cpu-plug-test']
>>   qtests_m68k = ['boot-serial-test'] + \
>>     qtests_filter
> 
> With preferably the redundant check removed:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 


