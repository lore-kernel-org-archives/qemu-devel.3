Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45FFFD0066
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 13:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwhEm-0003hq-3T; Sun, 01 Mar 2026 08:53:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vwhEj-0003hU-CJ; Sun, 01 Mar 2026 08:53:33 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vwhEh-0006Fr-Bw; Sun, 01 Mar 2026 08:53:33 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwB3WGDWRKRpCV+mBw--.8436S2;
 Sun, 01 Mar 2026 21:53:26 +0800 (CST)
Received: from [192.168.31.94] (unknown [113.246.118.211])
 by mail (Coremail) with SMTP id AQAAfwAXb+zVRKRpJS4eAA--.37562S2;
 Sun, 01 Mar 2026 21:53:25 +0800 (CST)
Message-ID: <df545e5d-0380-49bd-97f1-5b7b9a4259da@phytium.com.cn>
Date: Sun, 1 Mar 2026 21:53:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 06/31] hw/arm/smmuv3: Track SEC_SID in configs and events
To: Mostafa Saleh <smostafa@google.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221100250.2976287-7-tangtao1634@phytium.com.cn>
 <aaGsltcRyTu7j1tU@google.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <aaGsltcRyTu7j1tU@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAfwAXb+zVRKRpJS4eAA--.37562S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAABWmiCd8FiAAEsQ
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxGryDWFyfZr4ruw43AryDtrb_yoW5Ary3pr
 1DJF95Kr4Dta4SvFy3Xa1xZ3W7W3yxKrn0grnrKFyrAwnY9r13XF1DGr909r909ryrWrWI
 vayIg3W3WryjyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

Hi Mostafa,

On 2026/2/27 PM10:39, Mostafa Saleh wrote:
> On Sat, Feb 21, 2026 at 06:02:25PM +0800, Tao Tang wrote:
>> Cache the SEC_SID inside SMMUTransCfg to keep configuration lookups
>> tied to the correct register bank.
>>
>> Plumb the SEC_SID through tracepoints and queue helpers so diagnostics
>> and event logs always show which security interface emitted the record.
>> To support this, the SEC_SID is placed in SMMUEventInfo so the bank is
>> identified as soon as an event record is built.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>   hw/arm/smmuv3-internal.h     |  1 +
>>   hw/arm/smmuv3.c              | 20 +++++++++++++-------
>>   hw/arm/trace-events          |  2 +-
>>   include/hw/arm/smmu-common.h |  1 +
>>   4 files changed, 16 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
>> index 866d62257e3..a1071f7b689 100644
>> --- a/hw/arm/smmuv3-internal.h
>> +++ b/hw/arm/smmuv3-internal.h
>> @@ -274,6 +274,7 @@ static inline const char *smmu_event_string(SMMUEventType type)
>>   
>>   /*  Encode an event record */
>>   typedef struct SMMUEventInfo {
>> +    SMMUSecSID sec_sid;
>>       SMMUEventType type;
>>       uint32_t sid;
>>       bool recorded;
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 2c107724e77..3438adcecd2 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -148,9 +148,9 @@ static MemTxResult queue_write(SMMUQueue *q, Evt *evt_in)
>>       return MEMTX_OK;
>>   }
>>   
>> -static MemTxResult smmuv3_write_eventq(SMMUv3State *s, Evt *evt)
>> +static MemTxResult smmuv3_write_eventq(SMMUv3State *s, SMMUSecSID sec_sid,
>> +                                       Evt *evt)
>>   {
>> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>>       SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>>       SMMUQueue *q = &bank->eventq;
>>       MemTxResult r;
>> @@ -178,7 +178,8 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
>>   {
>>       Evt evt = {};
>>       MemTxResult r;
>> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>> +    SMMUSecSID sec_sid = info->sec_sid;
>> +    g_assert(sec_sid < SMMU_SEC_SID_NUM);
> What does this defend against?


sec_sid is now taken from SMMUEventInfo, so the assert is to catch 
programming errors early and avoid out-of-bounds bank accesses in 
smmuv3_record_event.

>
> Thanks,
> Mostafa


Best regards,

Tao

>
>>   
>>       if (!smmuv3_eventq_enabled(s, sec_sid)) {
>>           return;
>> @@ -258,8 +259,9 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
>>           g_assert_not_reached();
>>       }
>>   
>> -    trace_smmuv3_record_event(smmu_event_string(info->type), info->sid);
>> -    r = smmuv3_write_eventq(s, &evt);
>> +    trace_smmuv3_record_event(sec_sid, smmu_event_string(info->type),
>> +                              info->sid);
>> +    r = smmuv3_write_eventq(s, sec_sid, &evt);
>>       if (r != MEMTX_OK) {
>>           smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_EVENTQ_ABT_ERR_MASK);
>>       }






