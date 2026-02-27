Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C731FFEFB6E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 16:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw0WK-0006um-9n; Fri, 27 Feb 2026 11:16:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vw0Vz-0006ru-UX; Fri, 27 Feb 2026 11:16:40 -0500
Received: from zg8tmtu5ljy1ljeznc42.icoremail.net ([159.65.134.6])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vw0Vx-0007yt-0j; Fri, 27 Feb 2026 11:16:31 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwBnvdFXw6Fp8uSXAA--.29959S2;
 Sat, 28 Feb 2026 00:16:23 +0800 (CST)
Received: from [192.168.31.151] (unknown [113.246.232.133])
 by mail (Coremail) with SMTP id AQAAfwDXLetQw6FpIrodAA--.36516S2;
 Sat, 28 Feb 2026 00:16:16 +0800 (CST)
Message-ID: <b5da3509-fff4-4b38-8bcc-a54ad21e7eb0@phytium.com.cn>
Date: Sat, 28 Feb 2026 00:16:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 30/31] hw/arm/smmuv3: Add secure bank migration and
 secure-impl property
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101926.2997959-1-tangtao1634@phytium.com.cn>
 <831335ed-7463-4020-847a-b65518875376@linaro.org>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <831335ed-7463-4020-847a-b65518875376@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDXLetQw6FpIrodAA--.36516S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQATBWmguFMsVgAQsf
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxKr45try3WFyfGFyUAF1UWrg_yoW3GF17pF
 4kJrW5GryUGFn3Zr47J3WUCa45Cr48J3WDGr1kWFy5JF4kGrnIqw4UWr909rykJr48Jw42
 vF4UZrsrZr47ArJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=159.65.134.6;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtu5ljy1ljeznc42.icoremail.net
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Pierrick,

On 2026/2/26 06:20, Pierrick Bouvier wrote:
> On 2/21/26 2:19 AM, Tao Tang wrote:
>> Add a secure-impl device property and advertise it through
>> S_IDR1.SECURE_IMPL.
>>
>> Usage:
>>      -global arm-smmuv3,secure-impl=true
>>
>> Add the smmuv3/bank_s migration subsection for the secure register bank.
>> Serialize secure bank state including GBPA, IRQ config, stream table and
>> queue state.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmuv3.c         | 56 +++++++++++++++++++++++++++++++++++++++++
>>   include/hw/arm/smmuv3.h |  2 ++
>>   2 files changed, 58 insertions(+)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index f0fbc5fc96b..678cbd584e2 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -327,6 +327,7 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
>>       memset(sbk->idr, 0, sizeof(sbk->idr));
>>       sbk->idr[0] = FIELD_DP32(bk->idr[0], S_IDR0, STALL_MODEL, 1); 
>> /* No stall */
>>       sbk->idr[1] = FIELD_DP32(sbk->idr[1], S_IDR1, S_SIDSIZE, 
>> SMMU_IDR1_SIDSIZE);
>> +    sbk->idr[1] = FIELD_DP32(sbk->idr[1], S_IDR1, SECURE_IMPL, 
>> s->secure_impl);
>>       smmuv3_accel_idr_override(s);
>>   }
>>   @@ -2632,6 +2633,54 @@ static const VMStateDescription 
>> vmstate_smmuv3_queue = {
>>       },
>>   };
>>   +static const VMStateDescription vmstate_smmuv3_secure_bank = {
>> +    .name = "smmuv3_secure_bank",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_UINT32(features, SMMUv3RegBank),
>> +        VMSTATE_UINT8(sid_split, SMMUv3RegBank),
>> +        VMSTATE_UINT32_ARRAY(cr, SMMUv3RegBank, 3),
>> +        VMSTATE_UINT32(cr0ack, SMMUv3RegBank),
>> +        VMSTATE_UINT32(gbpa, SMMUv3RegBank),
>> +        VMSTATE_UINT32(irq_ctrl, SMMUv3RegBank),
>> +        VMSTATE_UINT32(gerror, SMMUv3RegBank),
>> +        VMSTATE_UINT32(gerrorn, SMMUv3RegBank),
>> +        VMSTATE_UINT64(gerror_irq_cfg0, SMMUv3RegBank),
>> +        VMSTATE_UINT32(gerror_irq_cfg1, SMMUv3RegBank),
>> +        VMSTATE_UINT32(gerror_irq_cfg2, SMMUv3RegBank),
>> +        VMSTATE_UINT64(strtab_base, SMMUv3RegBank),
>> +        VMSTATE_UINT32(strtab_base_cfg, SMMUv3RegBank),
>> +        VMSTATE_UINT64(eventq_irq_cfg0, SMMUv3RegBank),
>> +        VMSTATE_UINT32(eventq_irq_cfg1, SMMUv3RegBank),
>> +        VMSTATE_UINT32(eventq_irq_cfg2, SMMUv3RegBank),
>> +        VMSTATE_STRUCT(cmdq, SMMUv3RegBank, 0,
>> +                       vmstate_smmuv3_queue, SMMUQueue),
>> +        VMSTATE_STRUCT(eventq, SMMUv3RegBank, 0,
>> +                       vmstate_smmuv3_queue, SMMUQueue),
>> +        VMSTATE_END_OF_LIST(),
>> +    },
>> +};
>> +
>> +static bool smmuv3_secure_bank_needed(void *opaque)
>> +{
>> +    SMMUv3State *s = opaque;
>> +
>> +    return s->secure_impl;
>> +}
>> +
>> +static const VMStateDescription vmstate_smmuv3_bank_s = {
>> +    .name = "smmuv3/bank_s",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .needed = smmuv3_secure_bank_needed,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_STRUCT(bank[SMMU_SEC_SID_S], SMMUv3State, 0,
>> +                       vmstate_smmuv3_secure_bank, SMMUv3RegBank),
>> +        VMSTATE_END_OF_LIST(),
>> +    },
>> +};
>> +
>>   static bool smmuv3_gbpa_needed(void *opaque)
>>   {
>>       SMMUv3State *s = opaque;
>> @@ -2686,6 +2735,7 @@ static const VMStateDescription vmstate_smmuv3 = {
>>       },
>>       .subsections = (const VMStateDescription * const []) {
>>           &vmstate_gbpa,
>> +        &vmstate_smmuv3_bank_s,
>>           NULL
>>       }
>>   };
>> @@ -2707,6 +2757,12 @@ static const Property smmuv3_properties[] = {
>>       DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
>>       DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
>>       DEFINE_PROP_UINT8("ssidsize", SMMUv3State, ssidsize, 0),
>> +    /*
>> +     * SECURE_IMPL field in S_IDR1 register.
>> +     * Indicates whether secure state is implemented.
>> +     * Defaults to false (0)
>> +     */
>> +    DEFINE_PROP_BOOL("secure-impl", SMMUv3State, secure_impl, false),
>>   };
>>
>
> As mentioned before, should we enable it automatically in case 
> secure-memory address space is available at realize time?


Let me take this opportunity to address the same concern you raised 
across patches #07, #17, and #30 on the secure-impl vs secure-memory topic.


My initial intent was a demand-driven (lazy) validation model — i.e. 
only validate Secure capability when a device actually declares 
sec-sid=secure and we go through smmu_init_sdev() / 
smmuv3_validate_sec_sid(). That avoids forcing Secure-related 
configuration checks on machines that never exercise Secure DMA.

That said, I agree with your point that secure-impl=on without a 
corresponding secure-memory link is an unconditional misconfiguration 
and should fail fast at realize time. For v5 I’ll combine both approaches:

1) Realize-time inference + fail-fast

- If a secure-memory address space is wired at realize time, the SMMU 
should “do the right thing out of the box” and enable Secure support 
automatically.

- If Secure support ends up enabled (either explicitly or via 
auto-inference) but secure-memory is missing, smmuv3_realize() will 
error out with a clear message.

Importantly, I’ll preserve the explicit user override you mentioned 
(-global arm-smmuv3.secure-impl=off).


2) Make helpers assume the invariant

With the realize-time invariant in place, the Secure branch in 
smmu_get_address_space() will no longer “warn + return NULL”; it will 
become an assert (or equivalent hard failure) because the machine 
configuration is already validated.


3) Keep the device-level guard

I will keep smmuv3_validate_sec_sid() as a complementary per-device 
guard. This still matters when the user forces secure-impl=off: if a 
device declares sec-sid=secure, we can reject it immediately with a 
targeted error at device init/hotplug time, which is a different 
granularity than the SMMU-wide realize check.


I’ll incorporate these changes in the next revision.


>
>>   static void smmuv3_instance_init(Object *obj)
>> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
>> index d07bdfa1f27..79ce7c754c4 100644
>> --- a/include/hw/arm/smmuv3.h
>> +++ b/include/hw/arm/smmuv3.h
>> @@ -78,6 +78,8 @@ struct SMMUv3State {
>>       bool ats;
>>       uint8_t oas;
>>       uint8_t ssidsize;
>> +
>> +    bool secure_impl;
>>   };
>>     typedef enum {
>
> Otherwise, congrats for the great series!

Thanks for your time!

Tao

>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



