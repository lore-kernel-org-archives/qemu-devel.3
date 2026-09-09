Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CAAC79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 15:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4KRF-0007q5-8N; Wed, 09 Sep 2026 11:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x4KRC-0007pl-3R; Wed, 09 Sep 2026 11:42:14 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x4KR8-0000F2-5K; Wed, 09 Sep 2026 11:42:13 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwDXfaxJfqFqHhoFAA--.6498S2;
 Wed, 09 Sep 2026 23:42:01 +0800 (CST)
Received: from [192.168.2.9] (unknown [113.246.116.243])
 by mail (Coremail) with SMTP id AQAAf8Dwe3VIfqFqPgjSAA--.29569S2;
 Wed, 09 Sep 2026 23:42:00 +0800 (CST)
Message-ID: <3b027cd7-c200-40f3-b6da-5c52a9823ecb@phytium.com.cn>
Date: Wed, 9 Sep 2026 23:41:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 21/28] hw/arm/smmuv3: Implement SMMU_S_INIT register
To: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162624.2809349-1-tangtao1634@phytium.com.cn>
 <5d280603-e2f9-4d24-a31b-19f908a30c55@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <5d280603-e2f9-4d24-a31b-19f908a30c55@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dwe3VIfqFqPgjSAA--.29569S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQANBWqgYksHPwAHsV
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxZF17WF45CF17ArWxZry5Arb_yoWrGw43pr
 yUG3W5KFs8AF1xZr13Kw4xZF13u397Kr1UCrZxK3Z0ka4qvry8ta1vgr4YgFZrZrnxJw47
 tw429FZ7uw1YyaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 8/31/2026 1:23 PM, Eric Auger wrote:
> Hi Tao,
>
> On 8/13/26 6:26 PM, Tao Tang wrote:
>> Implement read/write handlers for the SMMU_S_INIT secure-only register.
>>
>> Writing INV_ALL provides a mechanism for software to perform a global
>> invalidation of ALL caches within the SMMU, including IOTLBs and
>> configuration caches across all security states.
>>
>> The MMIO dispatcher decodes the target register bank from the offset and
>> normalizes Secure-window offsets by subtracting SMMU_SECURE_REG_START
>> before switching on the bank-local offset. S_INIT is a Secure-only
>> register and its A_S_INIT constant is an absolute Secure-window offset,
>> so the handler matches it using A_S_INIT - SMMU_SECURE_REG_START and
>> rejects accesses through Non-secure banks.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   hw/arm/smmuv3.c     | 43 +++++++++++++++++++++++++++++++++++++++++++
>>   hw/arm/trace-events |  1 +
>>   2 files changed, 44 insertions(+)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index d69fc0898af..dc3fa618883 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -393,6 +393,21 @@ static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
>>   
>>   }
>>   
>> +static void smmuv3_invalidate_all_caches(SMMUv3State *s)
>> +{
>> +    SMMUState *bs = &s->smmu_state;
>> +    trace_smmuv3_invalidate_all_caches();
>> +
>> +    /* Clear all cached configs including STE and CD */
>> +    if (bs->configs) {
>> +        g_hash_table_remove_all(bs->configs);
>> +    }
>> +
>> +    /* Invalidate all SMMU IOTLB entries */
>> +    smmu_inv_notifiers_all(&s->smmu_state);
>> +    smmu_iotlb_inv_all(bs);
>> +}
>> +
>>   static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>>                                                    SMMUTransCfg *cfg,
>>                                                    SMMUEventInfo *event,
>> @@ -2206,7 +2221,29 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>>   
>>           bank->eventq_irq_cfg2 = data;
>>           break;
>> +    case A_S_INIT - SMMU_SECURE_REG_START:
>> +        if (reg_sec_sid != SMMU_SEC_SID_S) {
>> +            goto unhandled;
>> +        }
>> +        if (data & R_S_INIT_INV_ALL_MASK) {
>> +            /*
>> +             * If SMMU_ROOT_CR0.GPCEN == 0, a write of 1 to INV_ALL when any
>> +             * SMMU_(*_)CR0.SMMUEN == 1, .... , is CONSTRAINED UNPREDICTABLE
>> +             * according to (IHI 0070G.b) 6.3.62 SMMU_S_INIT, Page 465.
>> +             */
>> +            if (!smmuv3_smmu_disabled_stable(s, SMMU_SEC_SID_NS) ||
>> +                !smmuv3_smmu_disabled_stable(s, SMMU_SEC_SID_S)) {
>> +                /* CONSTRAINED UNPREDICTABLE behavior: Ignore this write */
>> +                qemu_log_mask(LOG_GUEST_ERROR, "S_INIT write ignored: "
>> +                              "(S_)CR0.SMMUEN or (S_)CR0ACK.SMMUEN is set\n");
>> +                return MEMTX_OK;
>> +            }
> shall we really bother: I read:
> "
> If SMMU_ROOT_CR0.GPCEN == 0, a write of 1 to INV_ALL when any
> SMMU_(*_)CR0.SMMUEN == 1,
> or an Update of any SMMUEN to 1 is in progress, or
> SMMU_ROOT_CR0.ACCESSEN == 1, or an Update of
> ACCESSEN to 1 is in progress, is CONSTRAINED UNPREDICTABLE and has one
> of the following behaviors:
> • The write is IGNORED.
> • The invalidation operation occurs and completes, with INV_ALL reset to
> 0 on completion.
> "
> So the second behavior would let us simplify the code, no?

Hi Eric,

Yes, the second permitted behavior lets us remove the SMMUEN checks and 
complete the invalidation synchronously. I'll simplify this in v6.

>
> By the way where is GPCEN checked?

GPCEN is not currently checked because this SMMU model does not 
implement the Root programming interface or granule protection checks. 
I'll clarify that limitation. When that support is added, INV_ALL must 
have no effect while GPCEN is set.


Best regards

Tao

>
> Eric
>> +            smmuv3_invalidate_all_caches(s);
>> +        }
>> +        /* Synchronous emulation: invalidation completed instantly. */
>> +        break;
>>       default:
>>


