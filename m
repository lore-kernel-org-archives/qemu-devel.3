Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B1EC79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 14:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4fdV-0008Rg-6c; Thu, 10 Sep 2026 10:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x4fdN-0008Qt-KL; Thu, 10 Sep 2026 10:20:14 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x4fdI-00074f-VQ; Thu, 10 Sep 2026 10:20:12 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwDH7mqOvKJq8gc2AA--.42602S2; 
 Thu, 10 Sep 2026 22:19:58 +0800 (CST)
Received: from [192.168.2.9] (unknown [113.246.116.243])
 by mail (Coremail) with SMTP id AQAAf8Dw4XWJvKJqjafSAA--.29403S2;
 Thu, 10 Sep 2026 22:19:53 +0800 (CST)
Message-ID: <e2cbd1f4-fa11-4868-a826-568786b75be9@phytium.com.cn>
Date: Thu, 10 Sep 2026 22:19:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 23/28] hw/pci: Add sec-sid property to PCIDevice
To: eric.auger@redhat.com, "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162145.2800835-1-tangtao1634@phytium.com.cn>
 <d39ce149-8479-40bc-8411-a52a635c7a0a@redhat.com>
 <a5cad895-37ff-4bf5-baae-cc9fdb708a02@phytium.com.cn>
 <81aebdfa-b550-4ef9-8c7e-1009ff1d9bb9@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <81aebdfa-b550-4ef9-8c7e-1009ff1d9bb9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dw4XWJvKJqjafSAA--.29403S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAOBWqhs8kH-gAAsC
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxJFy7Kw47ZrW3ArWxJr4rGrg_yoWrZFWkpF
 ZYka48KayDGFyfAr4Iqa17ua4jk3y8Jw45Jry5KFnxu3Z8t3s2qFWIg3yY9rWDWr48u3Wj
 q34UAryxZr98ArJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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


On 9/7/2026 11:59 PM, Eric Auger wrote:
>
> On 9/3/26 6:07 PM, Tao Tang wrote:
>> Hi Eric,
>>
>> On 2026/8/31 14:03, Eric Auger wrote:
>>> Hi Tao,
>>>
>>> On 8/13/26 6:21 PM, Tao Tang wrote:
>>>> Arm SMMUv3 uses a SEC_SID (StreamID Security state) to determine the
>>>> security state of the programming interface that controls a
>>>> transaction.
>>>> The architecture explicitly states that the association between a
>>>> device
>>>> and its SEC_SID is a system-defined property, not something derived
>>>> from
>>>> the physical address space.
>>>>
>>>> We need a way to represent this system-defined SEC_SID for PCI devices
>>>> if we want to implement SMMU's Secure state. So that SMMUv3 can select
>>>> the correct register bank and configuration when handling their
>>>> streams.
>>>>
>>>> This patch adds a new char *sec_sid field to PCIDevice, together with
>>>> a "sec-sid" QOM property. The property is intended to carry the
>>>> platform-defined SEC_SID for the device; for now only Non-secure and
>>>> Secure security states are supported.
>>> You shall add PCI maintainers in cc.
>>>
>>> Is it only SMMU intended? I mean if you set this property, the PCI
>>> device shall send DMA requests with secure attributes too?
>>
>> Yes, the current consumer is Arm SMMUv3 only. The property represents
>> the system-defined SEC_SID presented to the SMMU, selecting its
>> programming interface and Stream table. It does not make the PCI
>> function issue DMA with Secure MemTxAttrs; that per-transaction
>> attribute is passed separately through attrs_to_index(). Some code
>> pieces:
> yes you're right. Those are different. But how do you tell a device to
> send DMA transactions with attrs.secure (-> iommu_idx). That's what I am
> confused about. Do we plan to have a prop for that or will it be
> hardcoded such as in hw/misc/tz-mpc.c?


Hi Eric,

According to IHI 0070 G.b, Page 53, section 3.3.4, “Transaction 
attributes: incoming, two-stage translation and overrides”:

 > The input attributes are conceptually provided from the system, 
either conveyed from a client device that defines the transaction 
attributes in a device-specific way, or set in a system-specific way by 
the interconnect before the transaction is input to the SMMU.

I think this means a device model may select Secure or Non-secure 
transaction attributes according to its internal logic, or always issue 
transactions with fixed Secure attributes. Both approaches are permitted 
by the architecture.

We therefore may need to define the SMMU-facing interface: 
MemTxAttrs.space and MemTxAttrs.secure convey the incoming transaction's 
security attributes. How a device generates those attributes remains 
flexible and depends on the device implementation. hw/misc/tz-mpc.c 
always treats unspecified attributes like Secure for example.

>> ```
>> static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>>                                        IOMMUAccessFlags flag, int
>> iommu_idx)
>> {
>> .....
>>      SMMUv3State *s = sdev->smmu;
>>      SMMUSecSID sec_sid = sdev->sec_sid;
>>      SMMUv3RegBank *bank = smmuv3_bank(s, sec_sid);
>> .....
>>      entry.target_as = smmuv3_bypass_target_as(s, sec_sid, iommu_idx);
>> ......
>>      if (!smmu_enabled(s, sec_sid)) {
>>          if (FIELD_EX32(bank->gbpa, GBPA, ABORT)) {
>>              status = SMMU_TRANS_ABORT;
>>          } else {
>>              status = SMMU_TRANS_DISABLE;
>>          }
>>          goto epilogue;
>>      }
>> .....
>> }
>> ```
>>
>> We use the device-inherent `PCIDevice->sec_sid` to select the SMMU
>> Programming Interface. The actual per-transaction attribute, on the
>> other hand, is passed to `smmuv3_translate()` through the `int
>> iommu_idx` parameter for each transaction.
>>
>> And Michael is already included in To: for both the cover letter and
>> this patch. I agree that this needs PCI maintainer review.
> OK fine, sorry fo the noise.


That's OK!

Thanks for the review.

Tao

>
> Eric
>> @Michael, Could you please help review this patch?
>>
>> Thanks,
>> Tao
>>
>>
>>> Eric
>>>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> ---
>>>>    hw/pci/pci.c                | 7 +++++++
>>>>    include/hw/pci/pci_device.h | 3 +++
>>>>    2 files changed, 10 insertions(+)
>>>>
>>>>


