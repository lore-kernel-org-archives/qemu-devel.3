Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0099C0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 08:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thPLO-00022S-LT; Mon, 10 Feb 2025 03:40:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1thPLM-00021N-A2
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:40:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1thPLK-0003YY-M2
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:40:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739176837;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PZFNEVFDlrWm+u1kbI2WmOD10Sb/Fn/tYL+zwgQm1aE=;
 b=frfjX9hoHH7QsnbfynrwLmK8SibFgM9EXV+UXXpHbu/PA+/kMHGyYc/V6rCDEe21bp3kv7
 NC62hiSjXjaRydKoho2GJBFXottayW1oz2UhaE8l3+hAhNBDH0nIiiHeppFQGx5Mv4pCk7
 zo/IIoxlnh7LKPLKHDvBMtK6/eDQ5sU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-Vk7PuksvPHaYAdbu7tyTLg-1; Mon, 10 Feb 2025 03:40:35 -0500
X-MC-Unique: Vk7PuksvPHaYAdbu7tyTLg-1
X-Mimecast-MFC-AGG-ID: Vk7PuksvPHaYAdbu7tyTLg
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38ddee833e0so311479f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 00:40:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739176834; x=1739781634;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PZFNEVFDlrWm+u1kbI2WmOD10Sb/Fn/tYL+zwgQm1aE=;
 b=l9+utLcQHLq2q8GlI9CsG9QBZm2wkTorBrGq7cxeru0H4gZWNfWDxGrDW6n7cF3ErX
 x5Ce9RWKjvnLZboHiSyfuMXKODE0jcUHFAsSNqHCnxKs3BxUPjWaMou7+yhmXpgXTWh7
 /aQ61KVCIdMAOCHcpZBhKXC0CIFTmj4+9Aicj/5P87sfAK8wqsB1wiSEP5N8yjmnBocM
 oF/qFtJbdwn41My2SPaIghG0sKSwuZQCc0/eWCbBLAGAASFe/FEqoQrQr3PRPiTiEDvI
 SQHhNpY0E+azDQHUTdy+EGEW+wque7jgilI4HVpR+B1aaNzC2um7ScEw5ONhg1F0QKkI
 +FZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW03iCbJBUZYFxvKG3cfQJCJyrfZ9dSVCMiPIwR4kgIPM1Ca2n2oT/nfprLOkJRo94W3J35IvM4Dtrs@nongnu.org
X-Gm-Message-State: AOJu0Yxt9CBuwW080MOBmYJrwYPiVhWla1rmCHJbT6jQX46PibI3KBRt
 V0L38uEuo8zwdY2Cs/EAweQPOD6znlzZsI0AbV/MRm9BrQ/Haj3siG112v6zCJqAXC7MM0Ez1YW
 4nageNkdT+ONs2ve5GU36qGe0zE0juVyHUliYFQYSGMdutSIEMpBb
X-Gm-Gg: ASbGncs24zq/DsOC2R750z+ncSEM6wFfyFk8q4Bs/w114h4I2CJNICqQywSOkwz8z0E
 VdRdKyKIrIYB35e+WwQ07oKPAVmSMgp5RZrfXhA3bS9Db2r0zB7fVEJNn493ffDm7q+zHiKX7fa
 8RXG/ZBOWS8Au9xDoShLTTU8hydZUMvVpsQp93SUB8MZ3+//ntx2DhFuYEp2hFJQPIsxEkj8n77
 Z0e/r673ZnFaP8sm5+mQFO/TKKetAWrF+vfEMY02rox0eMJ4h4BqerPAKtHUPRiehzzQ29uQBXJ
 7+RVsnsZGIqa+DUvKFBMlm5hsXDEe7F6yFP0xyXDCLe65tj3Pl8B
X-Received: by 2002:a05:6000:402b:b0:38d:afc8:954e with SMTP id
 ffacd0b85a97d-38dbb251e08mr14070533f8f.11.1739176834259; 
 Mon, 10 Feb 2025 00:40:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHp1PS+2BrQFxLxAM0N8CIFDSGfomfKGiHqthfrvuUBSU7Re2VtdHw31ZeSF29DZ24wjlC5kA==
X-Received: by 2002:a05:6000:402b:b0:38d:afc8:954e with SMTP id
 ffacd0b85a97d-38dbb251e08mr14070500f8f.11.1739176833855; 
 Mon, 10 Feb 2025 00:40:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43946bff4d4sm14580465e9.3.2025.02.10.00.40.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 00:40:33 -0800 (PST)
Message-ID: <4f058421-e0de-4a81-9452-e19684132998@redhat.com>
Date: Mon, 10 Feb 2025 09:40:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] hw/arm/smmuv3: Move reset to exit phase
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 mst@redhat.com, jasowang@redhat.com, imammedo@redhat.com, peterx@redhat.com,
 alex.williamson@redhat.com, clg@redhat.com, philmd@linaro.org,
 zhenzhong.duan@intel.com, ddutile@redhat.com
References: <20250206142307.921070-1-eric.auger@redhat.com>
 <20250206142307.921070-5-eric.auger@redhat.com>
 <CAFEAcA_LgrBRbafVQ0vLGPd8xG=wsLjWnKTJ2JSEREYUqgRQBQ@mail.gmail.com>
 <7102d470-ac72-4c02-b8bc-20f1379a4843@redhat.com>
 <CAFEAcA-XK5GwT0b_Ff-8fYnWcDgzaE-0Ei-YqDoXv-aXFGNXUQ@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFEAcA-XK5GwT0b_Ff-8fYnWcDgzaE-0Ei-YqDoXv-aXFGNXUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


Hi Peter,

On 2/7/25 5:58 PM, Peter Maydell wrote:
> On Fri, 7 Feb 2025 at 16:50, Eric Auger <eric.auger@redhat.com> wrote:
>>
>>
>>
>> On 2/7/25 5:37 PM, Peter Maydell wrote:
>>> On Thu, 6 Feb 2025 at 14:23, Eric Auger <eric.auger@redhat.com> wrote:
>>>> Currently the iommu may be reset before the devices
>>>> it protects. For example this happens with virtio-scsi-pci.
>>>> when system_reset is issued from qmp monitor, spurious
>>>> "virtio: zero sized buffers are not allowed" warnings can
>>>> be observed.
>>>>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>> ---
>>>>  hw/arm/smmuv3.c     | 9 +++++----
>>>>  hw/arm/trace-events | 1 +
>>>>  2 files changed, 6 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>>>> index c0cf5df0f6..7522c32b24 100644
>>>> --- a/hw/arm/smmuv3.c
>>>> +++ b/hw/arm/smmuv3.c
>>>> @@ -1870,13 +1870,14 @@ static void smmu_init_irq(SMMUv3State *s, SysBusDevice *dev)
>>>>      }
>>>>  }
>>>>
>>>> -static void smmu_reset_hold(Object *obj, ResetType type)
>>>> +static void smmu_reset_exit(Object *obj, ResetType type)
>>>>  {
>>>>      SMMUv3State *s = ARM_SMMUV3(obj);
>>>>      SMMUv3Class *c = ARM_SMMUV3_GET_CLASS(s);
>>>>
>>>> -    if (c->parent_phases.hold) {
>>>> -        c->parent_phases.hold(obj, type);
>>>> +    trace_smmu_reset_exit();
>>>> +    if (c->parent_phases.exit) {
>>>> +        c->parent_phases.exit(obj, type);
>>>>      }
>>> If we need to do something unexpected like reset
>>> register values in the exit phase rather than the
>>> hold phase, it's a good idea to have a comment explaining
>>> why, to avoid somebody coming along afterwards and tidying
>>> it up into the more usual arrangement.
>> sure
>>> If I understand correctly we need to keep the whole IOMMU
>>> config intact until the exit phase? What's the thing the
>>> device behind the IOMMU is trying to do during its reset
>>> that triggers the warning?
>> The virtio-pci-net continues to perform DMA requests and this causes
>> some weird messages such as:
>> "virtio: bogus descriptor or out of resources"
>>
>> Also VFIO devices may continue issuing DMAs causing translation faults
> Hmm, right. I guess this only happens with KVM, or can you
> trigger it in a TCG setup too? Anyway, presumably we can
I have only tested with KVM acceleration for now.
> rely on the devices quiescing all their outstanding DMA
> by the time the hold phase comes along.
>
> (I wonder if we ought to suggest quiescing outstanding
> DMA in the enter phase? But it's probably easier to fix
> the iommus like this series does than try to get every
> dma-capable pci device to do something different.)
at least we can document this, as Peter later suggests. Indeed fixing it
at vIOMMU level looked much easier for me, hoping that no other DMA
capable device would stop DMAs at exit phase

Eric
>
> thanks
> -- PMM
>


