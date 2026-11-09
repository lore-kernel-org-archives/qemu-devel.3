Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C95606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 03:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQGMQ-0000Q5-C4; Sun, 08 Nov 2026 22:47:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xQGMM-0000Pb-52; Sun, 08 Nov 2026 22:47:54 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xQGMI-0005Mb-QV; Sun, 08 Nov 2026 22:47:53 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwAnLMBbQvFqzW7ABQ--.56471S2; 
 Mon, 09 Nov 2026 11:47:39 +0800 (CST)
Received: from [10.31.91.158] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwBnNPQvFqpNT3AA--.21006S2;
 Mon, 09 Nov 2026 11:47:31 +0800 (CST)
Message-ID: <ea766a6f-b8b3-47e8-9c1f-094b2da7b4d3@phytium.com.cn>
Date: Mon, 9 Nov 2026 11:47:27 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/ide: add SPDM + IDE + TEE pci support to ICH9 SATA
 driver
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "jim.macarthur@linaro.org" <jim.macarthur@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jag.raman@oracle.com" <jag.raman@oracle.com>,
 "mst@redhat.com" <mst@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "den@openvz.org"
 <den@openvz.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>
References: <20261104-ich-driver-spdm-v1-0-60d361bc0417@linaro.org>
 <20261104-ich-driver-spdm-v1-2-60d361bc0417@linaro.org>
 <82fe2840-2775-47b3-b077-180fbd811b03@oss.qualcomm.com>
 <3c7816f3-b8ad-4ab2-8057-9cbac6805fba@oss.qualcomm.com>
 <8b590f1f1d3e6ff6c650d25078fe1f1bc9dd5211.camel@wdc.com>
 <41ef0bbb-1da2-427c-920f-ffe94d36d864@oss.qualcomm.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <41ef0bbb-1da2-427c-920f-ffe94d36d864@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwBnNPQvFqpNT3AA--.21006S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQALBWrs2U8HyQAwsh
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3JF4DCw4fXr4xCw48WF4fAFb_yoWDGFW5pF
 4kJFW5JFW5Jrn7JrnFqw1UXryqyr1kJ3W7Xr18WF1UJrsrtF1agr48Xr4qgr18Jr4kJF1j
 vr1UJrZ7ur45JFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 2026/11/6 15:56, Pierrick Bouvier wrote:
> On 11/5/26 10:39 PM, Alistair Francis wrote:
>> On Thu, 2026-11-05 at 00:11 -0800, Pierrick Bouvier wrote:
>>> On 11/4/2026 11:12 PM, Philippe Mathieu-Daudé wrote:
>>>> On 4/11/26 17:34, Jim MacArthur wrote:
>>>>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>
>>>> Rationale?
>>>>
>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
>>>>> ---
>>>>>    hw/ide/ich.c | 82
>>>>> ++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>> ++++++++--
>>>>>    1 file changed, 80 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/hw/ide/ich.c b/hw/ide/ich.c
>>>>> index b00987f08d..58e2d3b998 100644
>>>>> --- a/hw/ide/ich.c
>>>>> +++ b/hw/ide/ich.c
>>>>> @@ -70,6 +70,7 @@
>>>>>    #include "hw/ide/pci.h"
>>>>>    #include "hw/ide/ahci-pci.h"
>>>>>    #include "ahci-internal.h"
>>>>> +#include "system/spdm-socket.h"
>>>>>      #define ICH9_MSI_CAP_OFFSET     0x80
>>>>>    #define ICH9_SATA_CAP_OFFSET    0xA8
>>>>> @@ -90,6 +91,10 @@ static const VMStateDescription
>>>>> vmstate_ich9_ahci = {
>>>>>        },
>>>>>    };
>>>>>    +static const Property ich_props[] = {
>>>>> +    DEFINE_PROP_UINT16("spdm_port", PCIDevice, spdm_port, 0),
>>>>> +};
>>>>> +
>>>>>    static void pci_ich9_ahci_update_irq(void *opaque, int irq_num,
>>>>> int
>>>>> level)
>>>>>    {
>>>>>        PCIDevice *pci_dev = opaque;
>>>>> @@ -120,13 +125,39 @@ static void pci_ich9_ahci_init(Object *obj)
>>>>>        d->ahci.irq = &d->irq;
>>>>>    }
>>>>>    +/* Sends an SPDM message and receives the response */
>>>>> +static bool pcie_doe_spdm_rsp(DOECap *doe_cap)
>>>>> +{
>>>>> +    void *req = pcie_doe_get_write_mbox_ptr(doe_cap);
>>>>> +    uint32_t req_len = pcie_doe_get_obj_len(req) * 4;
>>>>> +    void *rsp = doe_cap->read_mbox;
>>>>> +    uint32_t rsp_len = SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE;
>>>>> +
>>>>> +    uint32_t recvd = spdm_socket_rsp(doe_cap->spdm_socket,
>>>>> +                             SPDM_TRANSPORT_TYPE_DOE,
>>>>> +                             req, req_len, rsp, rsp_len);
>>>>> +    doe_cap->read_mbox_len += DIV_ROUND_UP(recvd, 4);
>>>>> +
>>>>> +    return recvd != 0;
>>>>> +}
>>>>> +
>>>>> +/* SPDM protocols: plain and secured SPDM messages */
>>>>> +static DOEProtocol doe_spdm_prot[] = {
>>>>> +    { PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_CMA, pcie_doe_spdm_rsp
>>>>> },
>>>>> +    { PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_SECURED_CMA,
>>>>> pcie_doe_spdm_rsp },
>>>>> +    { }
>>>>> +};
>>>>> +
>>>>>    static void pci_ich9_ahci_realize(PCIDevice *dev, Error **errp)
>>>>>    {
>>>>>        AHCIPCIState *d;
>>>>>        int sata_cap_offset;
>>>>>        uint8_t *sata_cap;
>>>>> -    d = ICH9_AHCI(dev);
>>>>>        int ret;
>>>>> +    uint16_t cap_offset; /* Next offset for extended
>>>>> capabilities */
>>>>> +
>>>>> +    cap_offset = PCI_CONFIG_SPACE_SIZE;
>>>>> +    d = ICH9_AHCI(dev);
>>>>>          d->ahci.ports = 6;
>>>>>        ahci_realize(&d->ahci, DEVICE(dev),
>>>>> pci_get_address_space(dev));
>>>>> @@ -145,6 +176,7 @@ static void pci_ich9_ahci_realize(PCIDevice
>>>>> *dev,
>>>>> Error **errp)
>>>>>        pci_register_bar(dev, ICH9_MEM_BAR,
>>>>> PCI_BASE_ADDRESS_SPACE_MEMORY,
>>>>>                         &d->ahci.mem);
>>>>>    +    /* Legacy capability for ICH9_SATA_CAP */
>>>>>        sata_cap_offset = pci_add_capability(dev, PCI_CAP_ID_SATA,
>>>>> ICH9_SATA_CAP_OFFSET,
>>>>> SATA_CAP_SIZE,
>>>>>                                              errp);
>>>>> @@ -165,6 +197,29 @@ static void pci_ich9_ahci_realize(PCIDevice
>>>>> *dev,
>>>>> Error **errp)
>>>>>        /* Any error other than -ENOTSUP(board's MSI support is
>>>>> broken)
>>>>>         * is a programming error.  Fall back to INTx silently on -
>>>>> ENOTSUP */
>>>>>        assert(!ret || ret == -ENOTSUP);
>>>>> +
>>>>> +    /*
>>>>> +     * Initialise a capability in the legacy space after the
>>>>> ICH9_SATA_CAP.
>>>>> +     */
>>>>> +    pcie_endpoint_cap_init(dev, ICH9_SATA_CAP_OFFSET +
>>>>> SATA_CAP_SIZE);
>>>>> +
>>>>> +    if (dev->spdm_port) {
>>>>> +        /* Set up the DOE extended capability, mailboxes etc */
>>>>> +        pcie_doe_init(dev, &dev->doe_spdm, cap_offset,
>>>>> +                      doe_spdm_prot, true, 0);
>>>>> +        cap_offset += PCI_DOE_SIZEOF;
>>>>> +
>>>>> +        dev->doe_spdm.spdm_socket = spdm_socket_connect(dev-
>>>>>> spdm_port,
>>>>> +
>>>>> errp);
>>>>> +        assert(dev->doe_spdm.spdm_socket > 0);
>>>>> +    }
>>>>> +
>>>>> +    /* IDE extended capability */
>>>>> +    pcie_ide_init(dev, cap_offset);
>>>>> +    cap_offset += PCI_IDE_SIZEOF;
>>>>> +
>>>>> +    /* TEE capability bit in legacy space*/
>>>>> +    pcie_cap_tee_init(dev);
>>>>
>>>> Which section of the ICH9 spec describes that? AFAICT ICH9 predates
>>>> DOE / IDE. Is there some amendment? Otherwise this might not be the
>>>> correct place to add that capability. Either use a Frankenstein
>>>> ICH9
>>>> with a distinct model name, or add at the SATA layer, possibly like
>>>> a class interface (we only need the SATA_CAP_OFFSET IIUC).
>>>>
>>>
>>> It's an ad hoc addition, reproducing what Arm has been doing on fvp
>>> for
>>
>> Can you share any details on how you are testing this?
>>
>
> The last setup I used (february 2026) is:
> - qemu: https://gitlab.com/p-b-o/qemu/-/tree/smmu-da-2026-02-24
> - system: 
> https://github.com/p-b-o/qemu-linux-stack/tree/rme_sbsa_device_assignment_v2
>
> It follows all those instructions:
> https://git.trustedfirmware.org/plugins/gitiles/TF-RMM/tf-rmm.git/+/b57eb11bb73ed4b0a573f6f44e7379a58fc1bc66/docs/getting_started/building-with-shrinkwrap.rst 
>
>
> Since it's a pain to reproduce and run all this, I automated it.
> To build the system, you just need podman and qemu-user-binfmt 
> installed, then it's fully reproducible.
>
> $ git checkout rme_sbsa_device_assignment_v2
> $ ./build.sh # take a coffee
> $ ./run.sh qemu-system-aarch64
>
> This creates a disk, pass it to the vm. vm boots a realm and assign 
> the disk. We check disk content is the one expected from the realm, 
> host, and outside. spdm-emu is used for TDISP.
>
> see build.sh for which component are used.
> see run.sh for disk creation + qemu cmd line + spdm-emu.
> see host.sh for how the vm uses it.
>
> qemu branch has additional patches (smmu related to support device 
> assignment).
>
> You can also do the same with arm fvp using:
> $ ./fvp_build.sh
> $ ./fvp_run.sh
>
>>> device assignment. It does not really model a real device, and nvme
>>> was
>>> (is?) not supported due to other limitations.
>>
>> What limitations? NVMe + DOE should work here
>>
>
> It's not a limitation from QEMU, but what Arm implementation was 
> supporting at this time. IIRC, it was related to not supporting 
> devices having BAR mixing msi-x table and PBA. I don't remember if it 
> was a firmware or kvmtool issue.
> It might be better supported now, I didn't follow this since, being 
> busy with my new position at Qualcomm.


.....


>
>> Alistair
>>
>>>
>>> IIRC, we found that in the tf-rmm branch supporting device
>>> assignment.
>>>
>>> While it does not hurt, that's why I never sent patches before
>>> because
>>> that's indeed a custom thing, that works for a custom software stack
>>> that was (is?) not yet finalized.
>>>
>>> That said, it should not hurt to add it, since it's just an extra
>>> capability.
>>>
>>> @Jim: Feel free to complete my answer with links to the code and a
>>> spec,
>>> if there is one to share now. I'm sure Mathieu Poirier has all this
>>> info
>>> also.
>>>
>>>> Michael, Tao, what are your view on this? 
I agree with Philippe that we should avoid changing the guest-visible 
behaviour of the existing ICH9 model.

Regarding the NVMe limitation Pierrick mentioned, I found a related 
discussion in the original Arm CCA Device Assignment RFC, where Arto 
pointed out that skipping an entire BAR containing MSI-X Table/PBA could 
also skip other MMIO regions in the same BAR. [1]

More recently, Ankit posted a PCI/TSM patch that parses individual MMIO 
ranges from the TDISP Interface Report rather than treating an entire 
BAR as a single region.[2]

I'm not entirely sure whether the MSI-X/BAR layout issue discussed in 
the first thread is exactly the limitation Pierrick encountered, or 
whether the recent PCI/TSM patchset fully addresses it. The changes look 
relevant, particularly the handling of individual MMIO ranges within the 
same BAR, but I may have missed some related changes in the CCA software 
stack. I think some further testing with NVMe and the current software 
stack would help clarify this.

Given that QEMU NVMe already supports SPDM over DOE, if NVMe works for 
the complete device assignment flow, reusing it might be simpler than 
introducing another storage device model. Otherwise, I would favour a 
separate PCIe AHCI model as Philippe implemented.

[1] 
https://lore.kernel.org/all/d57d12ce-78c6-4381-80eb-03e9e94f9903@nvidia.com/

[2] https://lore.kernel.org/all/20261105152909.53452-2-ankita@nvidia.com/
>>>>
>>>
>>> Regards,
>>> Pierrick

Best regards,

Tao


