Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D01D65544
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 18:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG0J5-0006BU-Rj; Tue, 26 Nov 2024 13:29:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tG0J4-0006Ai-4c
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 13:29:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1tG0J2-0003L8-5R
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 13:29:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732645737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bivVPrvJsSlIeKXx5xuqW/Iw6IJ0w3tXpdKLVPBaxJ8=;
 b=PRuLjyr3l9E2Ipb+s75qcU7DGt1i5OIavPGLAF7ZAsfDhVBIIpXG1//lm57jd1CeFuAmDv
 /xbHSfmpv9hU618D1b7BP3MzdC3qLFVEhceClmc5TUHFT9Y6PisnY/MqYnXxPMmbsVJlx0
 YFrsyCzpzIbq91TsKpksABrebClgCG0=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-kQdTXOTpP-WA1MAkxC1-2w-1; Tue, 26 Nov 2024 13:28:55 -0500
X-MC-Unique: kQdTXOTpP-WA1MAkxC1-2w-1
X-Mimecast-MFC-AGG-ID: kQdTXOTpP-WA1MAkxC1-2w
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-8418f68672eso250051339f.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 10:28:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732645735; x=1733250535;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bivVPrvJsSlIeKXx5xuqW/Iw6IJ0w3tXpdKLVPBaxJ8=;
 b=YC/TzmUNaKOP1VeolFlC4div4a8ga5MacjQFhjcZaSmYrXbxXdraqx/z+2iCQpFO33
 kuwfuEdRZcRNpXLIxklNwDXf3nHeHdq1tnidee+Y1jm5neziyMmPhp7V8FwR6W1EEj/d
 7LCm2nCCY7paNEFOhtRHt9zlBLzG/XIpwZm1fjP6DDx+uQdteYtLx73ZXws/jWCCOV3H
 Vp9QzQgHqiJbBeNJuJjeTQjVWYeon5nJJsHK/nYXrgGF5F9aKUvhOTiqP5WA4s2XHJCt
 aiXny6HArp1nPiJp1IMpMmfC1TxLFrVDLHngurd5mETRQ3mYD+dH+Kmxt6OXzU/Qo9qI
 WMJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhhyaYmpsnxJOPkNuqs5jjD6Te9K+Dx8aGvFkaV+OCVNl8mBz0BxjwvxZBHeMdTpQZ0sU8pAW6/6MG@nongnu.org
X-Gm-Message-State: AOJu0Yyg1+U8ql2jmXZNfzNLSnMecmII8LElQOB+C8kbTOPXEp31pYOj
 /PsH0j39pOiuNTFcL0JXLDhvnQQVdhxKLr3WcaQzQrS+zWh1NeGYX92i78ac+4eY6zIgnNZUFNr
 Ins25++Rh+XbdxyJVS7v3YVKDbVMwtMNNLoWkvSlrVNsNRXq1ncUP
X-Gm-Gg: ASbGncs2zNnDjX7nzS+lZl73BB4UO3SbFj8OwM0UFWqQy9hpZCSWPRKUUClTaza0y1S
 I71v7nvKNIU30eR4Ywzg/wTVOPib7vn2xfoevOn30CzGgxyI+XDMTBMBpTiNSewdTXbLNb+y93C
 84MJtCpfITXxBI5veltx+GwtlZIuevdq4FZbPLR8qa88jWsEQjjBbROU5RKKu5OLkVIEkt3pwP6
 HqLKo/QeOeSSUi0sOl0GyTn0cZ9RHfwN6vca5bSQiBJA1ImfYE=
X-Received: by 2002:a05:6602:6b85:b0:82d:9b0:ecb7 with SMTP id
 ca18e2360f4ac-843ecfa9533mr61545139f.3.1732645734797; 
 Tue, 26 Nov 2024 10:28:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWMlhJe4fXTpjM+3g6MJlk+EcwqOAlCkd7+ka+yqesFA42APV8/zLtIDXpAJvSzhjhyZsPhw==
X-Received: by 2002:a05:6602:6b85:b0:82d:9b0:ecb7 with SMTP id
 ca18e2360f4ac-843ecfa9533mr61536339f.3.1732645733432; 
 Tue, 26 Nov 2024 10:28:53 -0800 (PST)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e21031f7bdsm721640173.101.2024.11.26.10.28.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 10:28:52 -0800 (PST)
Message-ID: <cfe8864c-f830-4b39-b4d5-f219f5a42eea@redhat.com>
Date: Tue, 26 Nov 2024 13:28:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] hw/arm/smmuv3: Add initial support for SMMUv3
 Nested device
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>, Eric Auger <eric.auger@redhat.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 jgg@nvidia.com, linuxarm@huawei.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-3-shameerali.kolothum.thodi@huawei.com>
 <00e8a5d6-c926-44bb-8d11-dab4ddc4820d@redhat.com>
 <ZzTqXCFKV9s++C2N@Asurada-Nvidia>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <ZzTqXCFKV9s++C2N@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 11/13/24 1:05 PM, Nicolin Chen wrote:
> Hi Eric,
> 
> On Wed, Nov 13, 2024 at 06:12:15PM +0100, Eric Auger wrote:
>> On 11/8/24 13:52, Shameer Kolothum wrote:
>>> @@ -181,6 +181,7 @@ static const MemMapEntry base_memmap[] = {
>>>       [VIRT_PVTIME] =             { 0x090a0000, 0x00010000 },
>>>       [VIRT_SECURE_GPIO] =        { 0x090b0000, 0x00001000 },
>>>       [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
>>> +    [VIRT_SMMU_NESTED] =        { 0x0b000000, 0x01000000 },
> 
>> I agree with Mostafa that the _NESTED terminology may not be the best
>> choice.
>> The motivation behind that multi-instance attempt, as introduced in
>> https://lore.kernel.org/all/ZEcT%2F7erkhHDaNvD@Asurada-Nvidia/
>> was:
>> - SMMUs with different feature bits
>> - support of VCMDQ HW extension for SMMU CMDQ
>> - need for separate S1 invalidation paths
>>
>> If I understand correctly this is mostly wanted for VCMDQ handling? if
>> this is correct we may indicate that somehow in the terminology.
>>
>> If I understand correctly VCMDQ terminology is NVidia specific while
>> ECMDQ is the baseline (?).
> 
> VCMDQ makes a multi-vSMMU-instance design a hard requirement, yet
> the point (3) for separate invalidation paths also matters. Jason
> suggested VMM in base case to create multi vSMMU instances as the
> kernel doc mentioned here:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/userspace-api/iommufd.rst#n84
> 
> W.r.t naming, maybe something related to "hardware-accelerated"?
> 
Given that 'accel' has been used for hw-acceleration elsewhere, that seems like a reasonable 'mode'.
But, it needs a paramater to state was is being accelerated.
i.e., the more global 'accel=kvm' has 'kvm'.

For SMMUv3, NVIDIA-specific vCMDQ, it needs a parameter to state that specifically,
since I'm concluding from reading the SMMUv3 version G.a spec, that ECMDQ was added
to be able to assign an ECMDQ to a VM, and let the VM do CMDQ driven invalidations via
a similar mechanism as assigned PCI-device mmio space in a VM.
So, how should the QEMU invocation select what parts to 'accel' in the vSMMUv3 given
to the VM?  ... and given the history of hw-based, virt-acceleration, I can only guess
more SMMUv3 accel tweaks will be found/desired/implemented.

So, given there is an NVIDIA-specific/like ECMDQ, but different, the accel parameter
chosen has to consider 'name-space collision', i.e., accel=nv-vcmdq  and accel=ecmdq,
unless sw can be made to smartly probe and determine the underlying diffs, and have
equivalent functionality, in which case, a simpler 'accel=vcmdq' could be used.

Finally, wrt libvirt, how does it know/tell what can and should be used?
For ECMDQ, something under sysfs for an SMMUv3 could expose its presence/capability/availability
(tag for use/alloc'd for a VM), or an ioctl/cdev i/f to the SMMUv3.

But how does one know today that there's NVIDIA-vCMDQ support on its SMMUv3? -- is it
exposed in sysfs, ioctl, cdev?
... and all needs to be per-instance ....
... libvirt  (or any other VMM orchestrator) will need to determine compatibility for
     live migration. e.g., can one live migrate an accel=nv-vcmdq-based VM to a host with
     accel=ecmdq support?  only nv-vcmdq?  what if there are version diffs of nv-vcmdq over time?
     -- apologies, but I don't know the minute details of nv-vcmdq to determine if that's unlikely or not.

Once the qemu-smmuv3-api is defined, with the recognition of what libvirt (or any other VMM) needs to probe/check/use for hw-accelerated features,
I think it'll be more straight-fwd to implement, and (clearly) understand from a qemu command line. :)

Thanks,
- Don

> Thanks
> Nicolin
> 


