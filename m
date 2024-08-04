Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E7E3C3DA7F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 09:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saXGy-0000ZN-Rr; Sun, 04 Aug 2024 05:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1saXGu-0000MN-SK
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 05:11:25 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1saXGs-0002Uz-Ts
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 05:11:24 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-70eb0ae23e4so6833822b3a.0
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 02:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722762681; x=1723367481;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0AU6SCxZvqbJ3FAJC+6m51jznIlKNtpmUeyB5zy8ZWE=;
 b=jN+PFTIDF4PRopbpAhAgO/4WAf+OxhW9m7VDTPUGZgo4dT8GFWzIPSt47Gj5kpJRvf
 F6HKvRcP9952MOXQLqW7yrmQnKlDeNrdmm8kbTyzBdeiKZiqmFTRaa2+lPzCtAqJ/2u9
 A4HnIEHBcq1REESa0vlTiMIrMwRzZlf3W1r+nBkdiI6n3ovQdqUwcPMJ5b8zgm1E1zzZ
 t61aSowL6gnNr+c4ylvnxQQBgw1sJWhFkBfziVkMjijt2EBGOn15myUII1kGx2oPpcVB
 gV12QgTWPnQORqleIzRybLztPR8ocDrJKJydRKkBpKMW+AggG9dTF5vEP6UGzxJM6FTE
 gnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722762681; x=1723367481;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0AU6SCxZvqbJ3FAJC+6m51jznIlKNtpmUeyB5zy8ZWE=;
 b=I3++uxaMcMvcis/epLKTf9/oOTY8GxcaK9emPkaupyORd0uzc8LiJN8OE6r+811rxw
 X+XTHZ0YVZg4O9oWtrelhUJ9k8WyTVnekBP8pQIP9ZUUIGzrCAcPo/YXE27jPz6pUQqu
 0vo26mgM7vSy81eD9pkSY+CMMsK+DR4Ucbh5UJ8BmDXH10TDuVIK5SGyRx9CEW9ZB0vY
 jqtyIJ4fP+0TX8q4/tdzJiISiWo6kq9NIIgYwR+9VDhGHCPnunxkH1jXjwi+Ax9EvUjP
 8vu04ua8sBjNbj0vmxjInhlv7AHFRABoa8pJv0Yr2jdfOxkvbZxAciIkOlDavDBAi8px
 aoMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBcepBHS0KRwLoOigd6SeTY65ozJ/0VPet/23rAopNVbRJ/4iNBV+BulAPTK7AYO8SC+X5z2rLqVXiBTeDq2jjXuxFDSo=
X-Gm-Message-State: AOJu0YzPTVMcPpSF2v8YMqTDCPTGIQEGVZponA17Mx5GIIlDgVeOBPH8
 anfCggicR9s0spzb8oaZo5A1V9Pha292oovu6C+cJ9sKMVino/lv+H78WGfMKc4=
X-Google-Smtp-Source: AGHT+IEklpdcsEJZXLvef3te9We6NvnH9sZHjrxqE6I63QrZqSvE45xMsGS9IHtZu1DDl5J63xsJrA==
X-Received: by 2002:a05:6a00:a16:b0:70d:3354:a190 with SMTP id
 d2e1a72fcca58-7106d046b59mr8571299b3a.27.1722762680589; 
 Sun, 04 Aug 2024 02:11:20 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec4169csm3709890b3a.64.2024.08.04.02.11.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Aug 2024 02:11:20 -0700 (PDT)
Message-ID: <3670cc79-d52c-4e64-98a7-8a76bb7685bb@daynix.com>
Date: Sun, 4 Aug 2024 18:11:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 v11 08/11] pcie_sriov: Remove num_vfs from
 PCIESriovPF
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20240802-reuse-v11-0-fb83bb8c19fb@daynix.com>
 <20240802-reuse-v11-8-fb83bb8c19fb@daynix.com>
 <20240802083911-mutt-send-email-mst@kernel.org>
 <5058d9d4-7922-4746-b6d1-b16046bf69f9@daynix.com>
 <20240802124956-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240802124956-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/08/03 1:52, Michael S. Tsirkin wrote:
> On Sat, Aug 03, 2024 at 12:38:10AM +0900, Akihiko Odaki wrote:
>> On 2024/08/02 21:58, Michael S. Tsirkin wrote:
>>> On Fri, Aug 02, 2024 at 02:17:58PM +0900, Akihiko Odaki wrote:
>>>> num_vfs is not migrated so use PCI_SRIOV_CTRL_VFE and PCI_SRIOV_NUM_VF
>>>> instead.
>>>>
>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> ---
>>>>    include/hw/pci/pcie_sriov.h |  1 -
>>>>    hw/pci/pcie_sriov.c         | 28 ++++++++++++++++++++--------
>>>>    hw/pci/trace-events         |  2 +-
>>>>    3 files changed, 21 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
>>>> index 70649236c18a..5148c5b77dd1 100644
>>>> --- a/include/hw/pci/pcie_sriov.h
>>>> +++ b/include/hw/pci/pcie_sriov.h
>>>> @@ -16,7 +16,6 @@
>>>>    #include "hw/pci/pci.h"
>>>>    typedef struct PCIESriovPF {
>>>> -    uint16_t num_vfs;   /* Number of virtual functions created */
>>>>        uint8_t vf_bar_type[PCI_NUM_REGIONS];   /* Store type for each VF bar */
>>>>        PCIDevice **vf;     /* Pointer to an array of num_vfs VF devices */
>>>>    } PCIESriovPF;
>>>> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
>>>> index 9bd7f8acc3f4..fae6acea4acb 100644
>>>> --- a/hw/pci/pcie_sriov.c
>>>> +++ b/hw/pci/pcie_sriov.c
>>>> @@ -57,7 +57,6 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
>>>>        pcie_add_capability(dev, PCI_EXT_CAP_ID_SRIOV, 1,
>>>>                            offset, PCI_EXT_CAP_SRIOV_SIZEOF);
>>>>        dev->exp.sriov_cap = offset;
>>>> -    dev->exp.sriov_pf.num_vfs = 0;
>>>>        dev->exp.sriov_pf.vf = NULL;
>>>>        pci_set_word(cfg + PCI_SRIOV_VF_OFFSET, vf_offset);
>>>> @@ -186,6 +185,12 @@ void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
>>>>        }
>>>>    }
>>>> +static void clear_ctrl_vfe(PCIDevice *dev)
>>>> +{
>>>> +    uint8_t *ctrl = dev->config + dev->exp.sriov_cap + PCI_SRIOV_CTRL;
>>>
>>> space here, after definition
>>>
>>>> +    pci_set_word(ctrl, pci_get_word(ctrl) & ~PCI_SRIOV_CTRL_VFE);
>>>> +}
>>>> +
>>>
>>> Pls use pci_word_test_and_clear_mask
>>
>> That sounds good. I'll do so with the next version.
>>
>>>
>>>
>>>>    static void register_vfs(PCIDevice *dev)
>>>>    {
>>>>        uint16_t num_vfs;
>>>> @@ -195,6 +200,7 @@ static void register_vfs(PCIDevice *dev)
>>>>        assert(sriov_cap > 0);
>>>>        num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
>>>>        if (num_vfs > pci_get_word(dev->config + sriov_cap + PCI_SRIOV_TOTAL_VF)) {
>>>> +        clear_ctrl_vfe(dev);
>>>>            return;
>>>>        }
>>>> @@ -203,20 +209,18 @@ static void register_vfs(PCIDevice *dev)
>>>>        for (i = 0; i < num_vfs; i++) {
>>>>            pci_set_enabled(dev->exp.sriov_pf.vf[i], true);
>>>>        }
>>>> -    dev->exp.sriov_pf.num_vfs = num_vfs;
>>>>    }
>>>>    static void unregister_vfs(PCIDevice *dev)
>>>>    {
>>>> -    uint16_t num_vfs = dev->exp.sriov_pf.num_vfs;
>>>>        uint16_t i;
>>>> +    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
>>>>        trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
>>>> -                               PCI_FUNC(dev->devfn), num_vfs);
>>>> -    for (i = 0; i < num_vfs; i++) {
>>>> +                               PCI_FUNC(dev->devfn));
>>>> +    for (i = 0; i < pci_get_word(cfg + PCI_SRIOV_TOTAL_VF); i++) {
>>>
>>> Why PCI_SRIOV_TOTAL_VF not PCI_SRIOV_NUM_VF/pcie_sriov_num_vfs?
>>
>> Because PCI_SRIOV_NUM_VF is overwritten when unregister_vfs() is called.
> 
> 
> maybe this function should get the range of VFs to unregister, then.

PCI_SRIOV_TOTAL_VF gives always a valid value, and it is the only value 
known to valid when PCI_SRIOV_CTRL gets written with a value clearing 
PCI_SRIOV_CTRL_VFE.

> 
>>>
>>>
>>>>            pci_set_enabled(dev->exp.sriov_pf.vf[i], false);
>>>>        }
>>>> -    dev->exp.sriov_pf.num_vfs = 0;
>>>>    }
>>>>    void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
>>>> @@ -242,6 +246,9 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
>>>>            } else {
>>>>                unregister_vfs(dev);
>>>>            }
>>>> +    } else if (range_covers_byte(off, len, PCI_SRIOV_NUM_VF)) {
>>>> +        clear_ctrl_vfe(dev);
>>>> +        unregister_vfs(dev);
>>>
>>> So any write into PCI_SRIOV_NUM_VF automatically clears VFE?
>>>
>>> Yes writing into PCI_SRIOV_NUM_VF should not happen when VFE
>>> is set, but spec does not say we need to clear it automatically.
>>> Why come up with random rules? just don't special case it,
>>> whatever happens, let it happen.
>>>
>>> And what does this change have to do with getting rid of
>>> num_vfs?
>>
>> Keeping VFs working requires to know the number of VFs, but we do no longer
>> know it because PCI_SRIOV_NUM_VF is overwritten. This disables all VFs
>> instead of trying to keep VFs alive.
>>
>> Regards,
>> Akihiko Odaki
> 
> However, we then get into a situation where VFE is set but
> PCI_SRIOV_NUM_VF no longer reflects the # of registered VFs.
> Given you removed num_vfs which was exactly
> the # of registered VFs, it is hard to say if that will lead to
> confusion now or later.

I masked writes to PCI_SRIOV_NUM_VF when PCI_SRIOV_CTRL_VFE is set in v12.

Regards,
Akihiko Odaki

