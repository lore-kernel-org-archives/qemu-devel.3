Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AE8C98329
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 13:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vh6Or-0003ll-Mb; Sat, 17 Jan 2026 08:31:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vh6Oo-0003kv-OC; Sat, 17 Jan 2026 08:31:31 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vh6Om-00011H-GO; Sat, 17 Jan 2026 08:31:30 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBHricrj2tpOnkrAw--.5736S2;
 Sat, 17 Jan 2026 21:31:23 +0800 (CST)
Received: from [192.168.31.151] (unknown [113.246.235.43])
 by mail (Coremail) with SMTP id AQAAfwCX7+wnj2tpv3MUAA--.36582S2;
 Sat, 17 Jan 2026 21:31:19 +0800 (CST)
Message-ID: <9d0c3136-d638-4b05-b6ed-70fa5f0e9b7e@phytium.com.cn>
Date: Sat, 17 Jan 2026 21:31:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v8 7/7] tests/qtest: Add SMMUv3 bare-metal test using
 iommu-testdev
To: eric.auger@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20251224034647.2596434-1-tangtao1634@phytium.com.cn>
 <20251224034647.2596434-8-tangtao1634@phytium.com.cn>
 <0b4b21e5-40e4-4d09-8624-7507dbb220e3@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <0b4b21e5-40e4-4d09-8624-7507dbb220e3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCX7+wnj2tpv3MUAA--.36582S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQARBWlpSgQHHAAIsI
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxAry3CFy8JF1DCr4xGryxuFg_yoW5tr1Dpa
 sxCa47tFWxJr1xAwnrJw1kWr1rtrs7Aw1UAry3Jrn3uw4qyryUtr18KrW0gas7XrWkZ3W8
 Zw40k3W5Gr4UJFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Eric,

On 2026/1/17 18:04, Eric Auger wrote:
> Hi Tao,
>
> On 12/24/25 4:46 AM, Tao Tang wrote:
>> Add a qtest suite that validates ARM SMMUv3 translation without guest
>> firmware or OS. The tests leverage iommu-testdev to trigger DMA
>> operations and the qos-smmuv3 library to configure IOMMU translation
>> structures.
>>
>> This test suite targets the virt machine and covers:
>> - Stage 1 only translation (VA -> PA via CD page tables)
>> - Stage 2 only translation (IPA -> PA via STE S2 tables)
>> - Nested translation (VA -> IPA -> PA, Stage 1 + Stage 2)
>> - Design to extended to support multiple security spaces
>>      (Non-Secure, Secure, Root, Realm)
>>
>> Each test case follows this sequence:
>> 1. Initialize SMMUv3 with appropriate command/event queues
>> 2. Build translation tables (STE/CD/PTE) for the target scenario
>> 3. Configure iommu-testdev with IOVA and DMA attributes via MMIO
>> 4. Trigger DMA and validate successful translation
>> 5. Verify data integrity through a deterministic write-read pattern
>>
>> This bare-metal approach provides deterministic IOMMU testing with
>> minimal dependencies, making failures directly attributable to the SMMU
>> translation path.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   tests/qtest/iommu-smmuv3-test.c | 121 ++++++++++++++++++++++++++++++++
>>   tests/qtest/meson.build         |   1 +
>>   2 files changed, 122 insertions(+)
>>   create mode 100644 tests/qtest/iommu-smmuv3-test.c
>>
>> ------------------------------<snip>------------------------------
>>
>>
>>
>> ------------------------------<snip>------------------------------
>> +
>> +int main(int argc, char **argv)
>> +{
>> +    g_test_init(&argc, &argv, NULL);
>> +    qtest_add_func("/iommu-testdev/translation/ns-s1-only",
>> +                   test_smmuv3_ns_s1_only);
>> +    qtest_add_func("/iommu-testdev/translation/ns-s2-only",
>> +                   test_smmuv3_ns_s2_only);
>> +    qtest_add_func("/iommu-testdev/translation/ns-nested",
>> +                   test_smmuv3_ns_nested);
>> +    return g_test_run();
>> +}
>> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
>> index 669d07c06b..e2d2e68092 100644
>> --- a/tests/qtest/meson.build
>> +++ b/tests/qtest/meson.build
>> @@ -263,6 +263,7 @@ qtests_aarch64 = \
>>      config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
>>     (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : []) + \
>>     (config_all_devices.has_key('CONFIG_NPCM8XX') ? qtests_npcm8xx : []) + \
>> +  (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') ? ['iommu-smmuv3-test'] : []) + \
> One question: since it can only run along with VIRT machine, how do we
> make sure this only runs with that machine enabled?


Thanks for the catch. I'll address this in two places:

- Build-time: the test is now added only when both CONFIG_IOMMU_TESTDEV 
and CONFIG_ARM_VIRT are enabled in meson.build.

- Run-time: the test checks qtest_has_machine("virt") and calls 
g_test_skip() if the virt machine is not available.

This ensures the test is only built/selected when virt is present and 
also skips cleanly if the machine isn’t supported at runtime.

Best regards,
Tao


