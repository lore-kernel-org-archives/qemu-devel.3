Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E98CEF8FF9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 15:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxoFY-0004I9-JY; Wed, 04 Mar 2026 10:35:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vxoFR-0004Hm-BZ; Wed, 04 Mar 2026 10:34:53 -0500
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vxoFO-00080f-21; Wed, 04 Mar 2026 10:34:53 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCH3dERUahpPsqsAA--.31418S2;
 Wed, 04 Mar 2026 23:34:41 +0800 (CST)
Received: from [192.168.31.94] (unknown [113.246.233.224])
 by mail (Coremail) with SMTP id AQAAfwB3zusOUahpMPweAA--.38826S2;
 Wed, 04 Mar 2026 23:34:38 +0800 (CST)
Message-ID: <7a50275c-46bb-45b2-a419-135cc0e43c45@phytium.com.cn>
Date: Wed, 4 Mar 2026 23:34:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 16/31] hw/arm/smmuv3: Plumb SEC_SID through IOMMU
 notifier path
To: eric.auger@redhat.com, Mostafa Saleh <smostafa@google.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101706.2994213-1-tangtao1634@phytium.com.cn>
 <aaGumxmrKRelouE7@google.com>
 <6a6144fe-3db3-4ce8-8a8c-c1391d7aa550@redhat.com>
 <aaXiQ84t1vxTH-EE@google.com>
 <adbb1e4f-2103-4927-aa5e-638c5dbc3896@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <adbb1e4f-2103-4927-aa5e-638c5dbc3896@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwB3zusOUahpMPweAA--.38826S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAEBWmnT6AGiwAAss
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxuw4xWF15Kr1UGFW3Ar47urg_yoW7KFWDpr
 WkKF4YkFW8Ja4fJF42vw4UCF9Iqr1DK34rXryUG3W5tFyqyr9FqF4Du34j9F98Cr48Ar4q
 q34UWF43Zw1jy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi all,

On 2026/3/3 PM3:49, Eric Auger wrote:
> Hi Mostafa,
>
> On 3/2/26 8:17 PM, Mostafa Saleh wrote:
>> On Mon, Mar 02, 2026 at 07:26:10PM +0100, Eric Auger wrote:
>>> On 2/27/26 3:47 PM, Mostafa Saleh wrote:
>>>> On Sat, Feb 21, 2026 at 06:17:06PM +0800, Tao Tang wrote:
>>>>> Extend IOMMU notifier functions to be SEC_SID-aware, ensuring that
>>>>> invalidation notifications are dispatched to the correct security-aware
>>>>> address space.
>>>>>
>>>>> This ensures IOMMU notifier events (e.g., to VFIO) are correctly routed
>>>>> to the appropriate security world's address space, maintaining isolation
>>>>> between secure and non-secure DMA operations.
>>>> I don’t think that VFIO cares about secure regime, my guess is to
>>>> keep the functions as this and don’t call them for secure invalidations.
>>> So do we want to prevent VFIO devices from working in secure mode along
>>> with the SMMU?
>> Yes, my impression was that VFIO only works with NS devices, for example
>> I see vfio_iommu_map_notify() only deals with system memory:
>>
>>      if (iotlb->target_as != &address_space_memory) {
>>          error_setg(&local_err,
>>                     "Wrong target AS \"%s\", only system memory is allowed",
> Indeed this would need to be changed. I am totally fine not supporting
> VFIO nor vhost devices (which also use unmap notifiers) in secure more.
> However in that case I think the series would need to properly check
> that those devices are not used in secure regime.


Thanks for the clarification.


For this series, I’m fine not supporting VFIO/vhost in Secure regime. 
I’ll add a fail-fast check at smmuv3_inv_notifiers_iova to reject 
devices using IOMMU notifiers when the selected regime is non-NS. The NS 
path stays unchanged.


/* invalidate an asid/vmid/iova range tuple in all mr's */
static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
                                       dma_addr_t iova, uint8_t tg,
                                       uint64_t num_pages, int stage,
                                       SMMUSecSID sec_sid)
{
     SMMUDevice *sdev;
     if (sec_sid != SMMU_SEC_SID_NS) {     // fail-fast check
         return;
     }
     ......
}


Best regards,

Tao


>
> Thanks
>
> Eric
>>
>> Otherwise, the callback needs to be enlighted by different address
>> spaces, I am not sure how (and what uses cases?) will that be done, does
>> QEMU emulate TZ in that case? (and present some devices as secure?)
>>
>> Thanks,
>> Mostafa
>>
>>> Eric
>>>> Thanks,
>>>> Mostafa
>>>>
>>>>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>>>>> ---
>>>>>   hw/arm/smmuv3.c | 18 +++++++++++-------
>>>>>   1 file changed, 11 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>>>>> index 4a4de719a7c..e33a7babd1c 100644
>>>>> --- a/hw/arm/smmuv3.c
>>>>> +++ b/hw/arm/smmuv3.c
>>>>> @@ -1195,15 +1195,16 @@ epilogue:
>>>>>    * @tg: translation granule (if communicated through range invalidation)
>>>>>    * @num_pages: number of @granule sized pages (if tg != 0), otherwise 1
>>>>>    * @stage: Which stage(1 or 2) is used
>>>>> + * @sec_sid: StreamID Security state
>>>>>    */
>>>>>   static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>>>>>                                  IOMMUNotifier *n,
>>>>>                                  int asid, int vmid,
>>>>>                                  dma_addr_t iova, uint8_t tg,
>>>>> -                               uint64_t num_pages, int stage)
>>>>> +                               uint64_t num_pages, int stage,
>>>>> +                               SMMUSecSID sec_sid)
>>>>>   {
>>>>>       SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
>>>>> -    SMMUSecSID sec_sid = SMMU_SEC_SID_NS;
>>>>>       SMMUEventInfo eventinfo = {.sec_sid = sec_sid,
>>>>>                                  .inval_ste_allowed = true};
>>>>>       SMMUTransCfg *cfg = smmuv3_get_config(sdev, &eventinfo, sec_sid);
>>>>> @@ -1251,7 +1252,8 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>>>>>       }
>>>>>   
>>>>>       event.type = IOMMU_NOTIFIER_UNMAP;
>>>>> -    event.entry.target_as = &address_space_memory;
>>>>> +    event.entry.target_as = smmu_get_address_space(sdev->smmu, sec_sid);
>>>>> +    g_assert(event.entry.target_as);
>>>>>       event.entry.iova = iova;
>>>>>       event.entry.addr_mask = num_pages * (1 << granule) - 1;
>>>>>       event.entry.perm = IOMMU_NONE;
>>>>> @@ -1262,7 +1264,8 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
>>>>>   /* invalidate an asid/vmid/iova range tuple in all mr's */
>>>>>   static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
>>>>>                                         dma_addr_t iova, uint8_t tg,
>>>>> -                                      uint64_t num_pages, int stage)
>>>>> +                                      uint64_t num_pages, int stage,
>>>>> +                                      SMMUSecSID sec_sid)
>>>>>   {
>>>>>       SMMUDevice *sdev;
>>>>>   
>>>>> @@ -1274,7 +1277,8 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
>>>>>                                           iova, tg, num_pages, stage);
>>>>>   
>>>>>           IOMMU_NOTIFIER_FOREACH(n, mr) {
>>>>> -            smmuv3_notify_iova(mr, n, asid, vmid, iova, tg, num_pages, stage);
>>>>> +            smmuv3_notify_iova(mr, n, asid, vmid, iova, tg,
>>>>> +                               num_pages, stage, sec_sid);
>>>>>           }
>>>>>       }
>>>>>   }
>>>>> @@ -1307,7 +1311,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
>>>>>       if (!tg) {
>>>>>           trace_smmuv3_range_inval(sec_sid, vmid, asid, addr,
>>>>>                                    tg, 1, ttl, leaf, stage);
>>>>> -        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1, stage);
>>>>> +        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1, stage, sec_sid);
>>>>>           if (stage == SMMU_STAGE_1) {
>>>>>               smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl, sec_sid);
>>>>>           } else {
>>>>> @@ -1331,7 +1335,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
>>>>>           trace_smmuv3_range_inval(sec_sid, vmid, asid, addr, tg,
>>>>>                                    num_pages, ttl, leaf, stage);
>>>>>           smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg,
>>>>> -                                  num_pages, stage);
>>>>> +                                  num_pages, stage, sec_sid);
>>>>>           if (stage == SMMU_STAGE_1) {
>>>>>               smmu_iotlb_inv_iova(s, asid, vmid, addr, tg,
>>>>>                                   num_pages, ttl, sec_sid);
>>>>> -- 
>>>>> 2.34.1
>>>>>


