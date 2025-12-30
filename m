Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D9FE95A8C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 12:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaZE3-0006hz-UC; Tue, 30 Dec 2025 07:53:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vaZDQ-0006ed-QM; Tue, 30 Dec 2025 07:52:48 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vaZDL-0001PH-Tm; Tue, 30 Dec 2025 07:52:44 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDHzWELy1Np_IkBBQ--.2044S2;
 Tue, 30 Dec 2025 20:52:27 +0800 (CST)
Received: from [192.168.31.153] (unknown [113.246.117.135])
 by mail (Coremail) with SMTP id AQAAfwB3z+wKy1Np8NUPAA--.29220S2;
 Tue, 30 Dec 2025 20:52:26 +0800 (CST)
Message-ID: <4fcb8aa9-1ae2-4326-b0fe-73692bfb971e@phytium.com.cn>
Date: Tue, 30 Dec 2025 20:52:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/1] hw/pci: Add sec-sid property to PCIDevice
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20251211102729.227376-1-tangtao1634@phytium.com.cn>
 <20251211102729.227376-2-tangtao1634@phytium.com.cn>
 <ea6a119a-49fb-490f-9532-6de60e9f049a@linaro.org>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <ea6a119a-49fb-490f-9532-6de60e9f049a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwB3z+wKy1Np8NUPAA--.29220S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAABWlS4KwLXAAAsk
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxXF4xJF1rZF1Dtw1rGr4UArb_yoW5uw1rpF
 Z5Ja40yFZ5GFykJws2qa1UWFWUAa9rKa45Gr40g3W7CF47Ar1Ygr4Y9r4j9w4UXr4ru3W8
 tryjvry8Zr12qrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Pierrick,

On 2025/12/12 06:26, Pierrick Bouvier wrote:
> Hi Tao,
>
> On 12/11/25 2:27 AM, Tao Tang wrote:
>> Arm SMMUv3 uses SEC_SID to control how it interprets the security
>> state of incoming DMA requests. When SEC_SID=Secure, the SMMU
>> examines additional signals to distinguish Secure vs Non-secure
>> streams; when SEC_SID=Non-secure, all requests are treated as
>> Non-secure streams regardless of other signals.
>>
>> The SMMU spec states that SEC_SID is a system-defined property.
>> And devices capable of SEC_SID=Secure should be statically marked
>> by the system.
>>
>> This adds a uint8_t sec_sid field and "sec-sid" QOM property to
>> PCIDevice, allowing boards to configure this attribute. Values are
>> 0 (Non-secure, default) and 1 (Secure).
>>
>> Note: This is not a PCIe architectural feature. It is purely an
>> SMMU integration mechanism and does not affect PCIe transactions.
>>
>> Future RME-DA/TDISP work will use the PCIe TDISP/DTI protocol to model
>> Realm and Non-secure streams, instead of extending this static field.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/pci/pci.c                | 7 +++++++
>>   include/hw/pci/pci_device.h | 3 +++
>>   2 files changed, 10 insertions(+)
>>
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index b1eba348e0..1f944d0e39 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -98,6 +98,13 @@ static const Property pci_props[] = {
>>       DEFINE_PROP_STRING("sriov-pf", PCIDevice, sriov_pf),
>>       DEFINE_PROP_BIT("x-pcie-ext-tag", PCIDevice, cap_present,
>>                       QEMU_PCIE_EXT_TAG_BITNR, true),
>> +
>> +    /*
>> +     * System-defined, statically configured SEC_SID for this PCI 
>> device, used
>> +     * by Arm SMMU. Currently only support Non-secure (0) and Secure 
>> (1)
>> +     * security states.
>> +     */
>> +    DEFINE_PROP_UINT8("sec-sid", PCIDevice, sec_sid, 0),
>>       { .name = "busnr", .info = &prop_pci_busnr },
>>   };
>>   diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
>> index 88ccea5011..16364731da 100644
>> --- a/include/hw/pci/pci_device.h
>> +++ b/include/hw/pci/pci_device.h
>> @@ -184,6 +184,9 @@ struct PCIDevice {
>>       uint32_t max_bounce_buffer_size;
>>         char *sriov_pf;
>> +
>> +    /* Arm SMMU SEC_SID */
>> +    uint8_t sec_sid;
>>   };
>>     static inline int pci_intx(PCIDevice *pci_dev)
>
> this is an excellent addition, and something we definitely need for 
> Secure support in SMMU.
>
> May I suggest we have a string value instead of a uint8_t?
>
> This way, it would be explicit to have:
> sec-sid=non-secure (default)
> sec-sid=secure
> It can be backed by a proper SMMUSecSID variable, so once command line 
> is parsed, we don't deal with string anymore, but with a proper enum 
> instead.
>
> Thanks,
> Pierrick


Thank you for the review and for the suggestion. I agree that using a 
string property backed by an enum would provide better clarity than a 
raw uint8_t value. I plan to rework the patch accordingly in the next 
revision.

Also, a gentle ping to the thread — further comments or opinions from 
other reviewers would be appreciated when convenient.


Best regards,


Tao


