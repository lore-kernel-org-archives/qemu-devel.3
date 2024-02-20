Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC20AC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 15:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcS7W-0007Ed-I4; Tue, 20 Feb 2024 10:33:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rcS7U-0007Df-Gs
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:33:20 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rcS7R-0008B7-A7
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 10:33:20 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1dbd32cff0bso21137125ad.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 07:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708443195; x=1709047995;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uul1BnkVoEcs47XlKSAL2b72uaaNdjJ3+iWhFzhXM8Y=;
 b=JIEYrpGhhV6YMfTS4MvHE2ypSPfG84f4DI4Ph89qdQdZrnfjgjYGB+qYWtogMbv1tN
 bLtdNetoMeIt4oElXzfpp3dc0cMcOz8LMgaHy/okS+6tB2Kgj1+CdC6mgI7LnUaMOyS4
 FM3UNc3X3Sf8o8uzCa1ccNqDSTYM0Vzb4PI700shrxZIQuNcnO44gJ89a1sDjiL7/sSc
 LtaelrbRDQhW+cpRNUh9gIUlw9RZkMk4mup65CrSevclKGY9ZKkV06bQc95gZELbh0Ko
 8y8Nqa1NpPR3nd+iFPajC1uFTISTMGyxUjLkFlQsmpHhttIFEKBFNTKcv/9yp1+BVgep
 SBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708443195; x=1709047995;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uul1BnkVoEcs47XlKSAL2b72uaaNdjJ3+iWhFzhXM8Y=;
 b=CVL/J7lVpGjfWTAOBSfpu20ZOv44NZrR/U+2xe4kw3LxzRuz7erYFnxeGZRRdLg7Ic
 iwg+kUfkTs1Pi4+KPpjjzkxsmkQhR+jQS4HYDB0j4dcOG3M+XtuhL3h7gHEWtG0bPWQ4
 PuSYVLvEffU0UBtRe3R8tY455+gg+l7r0i7+0myHrW38W42hIWRirdkG/19F71tyGNHB
 Ic+lmh7zdO1nVSAQKk5jtF5EcTyUtGhBkQzKTvcCbwlBPv1xj+lSd2g9nAsxC8PLmYiw
 SgzYXhOYfsp4Qg61Ito7jGzhz9EUnjJMq2VnlghRKH6NCzdjSpex5HsaZzMA42wByUoL
 NGOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPAnEqYpHVVdLuzQPOZZ+Oi/TlGPOEv3SrR5zOmAdUMozLORpNgKcK1CjmYOXWQvUm3aY+hfNphTZcjW7nRBLXnskGQg4=
X-Gm-Message-State: AOJu0YzBQ4/C4CKd4mvZd/Lai1XrI9PiGjttRfU2shBbFdKuoFiFiSxr
 Lpg7A1HssvxrgSMYHp9jqHxfz9FNWIq40TbeFVnrQ+yO1l9gHspE2LTPpPFEoQc=
X-Google-Smtp-Source: AGHT+IFol9jW/IC0vul6xDEHxB1UoKyLC8bE7KN7z79RE5t0xk+NMIzkU+nKN7hb5/j12cMn19RCuA==
X-Received: by 2002:a17:902:f785:b0:1dc:10a5:8bed with SMTP id
 q5-20020a170902f78500b001dc10a58bedmr3547158pln.23.1708443195567; 
 Tue, 20 Feb 2024 07:33:15 -0800 (PST)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 mm11-20020a1709030a0b00b001db6da30331sm6395769plb.86.2024.02.20.07.33.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 07:33:15 -0800 (PST)
Message-ID: <763f68fa-5c50-4f68-a758-fadcba36b857@daynix.com>
Date: Wed, 21 Feb 2024 00:33:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/15] hw/nvme: Use pcie_sriov_num_vfs()
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-stable@nongnu.org
References: <20240220-reuse-v6-0-2e42a28b0cf2@daynix.com>
 <20240220-reuse-v6-1-2e42a28b0cf2@daynix.com> <ZdS3OI9vIu-jvJ37@redhat.com>
 <ZdS8-VoNPYAMItEy@redhat.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ZdS8-VoNPYAMItEy@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 2024/02/20 23:53, Kevin Wolf wrote:
> Am 20.02.2024 um 15:29 hat Kevin Wolf geschrieben:
>> Am 20.02.2024 um 13:24 hat Akihiko Odaki geschrieben:
>>> nvme_sriov_pre_write_ctrl() used to directly inspect SR-IOV
>>> configurations to know the number of VFs being disabled due to SR-IOV
>>> configuration writes, but the logic was flawed and resulted in
>>> out-of-bound memory access.
>>>
>>> It assumed PCI_SRIOV_NUM_VF always has the number of currently enabled
>>> VFs, but it actually doesn't in the following cases:
>>> - PCI_SRIOV_NUM_VF has been set but PCI_SRIOV_CTRL_VFE has never been.
>>> - PCI_SRIOV_NUM_VF was written after PCI_SRIOV_CTRL_VFE was set.
>>> - VFs were only partially enabled because of realization failure.
>>>
>>> It is a responsibility of pcie_sriov to interpret SR-IOV configurations
>>> and pcie_sriov does it correctly, so use pcie_sriov_num_vfs(), which it
>>> provides, to get the number of enabled VFs before and after SR-IOV
>>> configuration writes.
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Fixes: CVE-2024-26328
>>> Fixes: 11871f53ef8e ("hw/nvme: Add support for the Virtualization Management command")
>>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> ---
>>>   hw/nvme/ctrl.c | 26 ++++++++------------------
>>>   1 file changed, 8 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
>>> index f026245d1e9e..7a56e7b79b4d 100644
>>> --- a/hw/nvme/ctrl.c
>>> +++ b/hw/nvme/ctrl.c
>>> @@ -8466,36 +8466,26 @@ static void nvme_pci_reset(DeviceState *qdev)
>>>       nvme_ctrl_reset(n, NVME_RESET_FUNCTION);
>>>   }
>>>   
>>> -static void nvme_sriov_pre_write_ctrl(PCIDevice *dev, uint32_t address,
>>> -                                      uint32_t val, int len)
>>> +static void nvme_sriov_post_write_config(PCIDevice *dev, uint16_t old_num_vfs)
>>>   {
>>>       NvmeCtrl *n = NVME(dev);
>>>       NvmeSecCtrlEntry *sctrl;
>>> -    uint16_t sriov_cap = dev->exp.sriov_cap;
>>> -    uint32_t off = address - sriov_cap;
>>> -    int i, num_vfs;
>>> +    int i;
>>>   
>>> -    if (!sriov_cap) {
>>> -        return;
>>> -    }
>>> -
>>> -    if (range_covers_byte(off, len, PCI_SRIOV_CTRL)) {
>>> -        if (!(val & PCI_SRIOV_CTRL_VFE)) {
>>> -            num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
>>> -            for (i = 0; i < num_vfs; i++) {
>>> -                sctrl = &n->sec_ctrl_list.sec[i];
>>> -                nvme_virt_set_state(n, le16_to_cpu(sctrl->scid), false);
>>> -            }
>>> -        }
>>> +    for (i = pcie_sriov_num_vfs(dev); i < old_num_vfs; i++) {
>>> +        sctrl = &n->sec_ctrl_list.sec[i];
>>> +        nvme_virt_set_state(n, le16_to_cpu(sctrl->scid), false);
>>>       }
>>>   }
>>
>> Maybe I'm missing something, but if the concern is that 'i' could run
>> beyond the end of the array, I don't see anything that limits
>> pcie_sriov_num_vfs() to the static size of 127 that n->sec_ctrl_list.sec
>> has. register_vfs() seems to just take whatever 16 bit value the guest
>> wrote without imposing additional restrictions.
>>
>> If there is some mechanism that makes register_vf() fail if we exceed
>> the limit, maybe an assertion with a comment would be in order because
>> it doesn't seem obvious. I couldn't find any code that enforces it,
>> sriov_max_vfs only ever seems to be used as a hint for the guest.
>>
>> If not, do we need another check that fails gracefully in the error
>> case?
> 
> Ok, I see now that patch 2 fixes this. But then the commit message is
> wrong because it implies that this patch is the only thing you need to
> fix the problem with nvme. You can't say "Fixes: CVE-2024-26328" if half
> of the fix is still missing.

I didn't assign CVE-2024-26328 for the case that the value of 
PCI_SRIOV_NUM_VF is greater than PCI_SRIOV_TOTAL_VF; it's what 
CVE-2024-26327 deals with.

The problem I dealt here is that the value of PCI_SRIOV_NUM_VF may not 
represent the actual number of enabled VFs because another register 
(PCI_SRIOV_CTRL_VFE) is not set, for example.

If an assertion to be added, I think it should be in 
pcie_sriov_num_vfs() and ensure the returning value is less than the 
value of PCI_SRIOV_TOTAL_VF (aka sriov_max_vfs in hw/nvme/ctrl.c), but I 
think it's fine without it.

> 
> Maybe asserting old_num_vfs < n->sec_ctrl_list.numcntl would still be a
> good idea. But looking at this one, it seems to me that numcntl isn't
> completely correct either:
> 
>      list->numcntl = cpu_to_le16(max_vfs);
> 
> Both list->numcntl and max_vfs are uint8_t, so I think this will always
> be 0 on big endian hosts?

Indeed it looks wrong. Will you write a patch?

Regards,
Akihiko Odaki

