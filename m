Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF813C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 07:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0b7q-0005JI-75; Fri, 04 Apr 2025 03:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u0b7o-0005IZ-Ll
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 03:06:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u0b7m-000830-ID
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 03:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743750355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=as7gkhlLlh+FOTGhb/cv0Uta24eTZhW2eO5ky7vgHhM=;
 b=Qh3NapxJdlnu334KvpIg+7XRudezIJn9NFEJgTvn9g/0hE5dMde8YkAdmtAKgHsBQYcT4F
 CnrrG3eQL+g0XcvQrx2a8QZNwQ56u4IDCcR7A3naNiZYUCQkuwIT5Ct0u1Ht7iXy1vWnKk
 T+iSPsmPt1WcE5vIuvQ7pGzxb4PqvBg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-IkHJ67iJPKa_pcu_z0-Qag-1; Fri, 04 Apr 2025 03:05:53 -0400
X-MC-Unique: IkHJ67iJPKa_pcu_z0-Qag-1
X-Mimecast-MFC-AGG-ID: IkHJ67iJPKa_pcu_z0-Qag_1743750352
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d209dc2d3so9567765e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 00:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743750352; x=1744355152;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=as7gkhlLlh+FOTGhb/cv0Uta24eTZhW2eO5ky7vgHhM=;
 b=Q7HGJpx1DbUhjrntIj9PqQoiIeXULvJ6ODYQoipDm9ODLT/HVXzWSPwMMZ6o5WBK6d
 SC48KzeWRaVqmC53RZmQJbyBC766eCygFFo1UxOHviDmcOLpLzgmbVfXCi7j5ZX1XsRl
 xhR2BGf7ertvWdg38bTNH9UikpD8TaZe+b0V+XCV4UKKU8TiUqewafDaupA5JssewA9P
 Qa+Hz92d6UZrewygNDkeOrpniyfIqIGAlZ+cyyLrbItqbjzCuBzypTPeX0kFaVXuyTM+
 6/j8MVtd8/Jmuco5dUsi7cbb2DddwZ1PungWWbC6LNOy5reJH59UKgtV8Yl+dTO/PpMV
 1gow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK7DfyfyuS9iK4+YIO4wJC6g1asgGsQqqvEmwlI7vMa1gmUU2J4svP8CDCqXxahfLtSPvqFCrYA8x7@nongnu.org
X-Gm-Message-State: AOJu0YymxCfnP/dgm1sO01lRL6Z7ueJh/PrVfGWSJb/LW/6vJ9CaUYZB
 aDbpx/TojbgL1YvIKx4Lw2Ydvi7BuWAci8sjhasHUP5MeTk5hpJ3fQcuAhjGXC8RuuL69LvBbOx
 4/aSSqDnn43m4hHsiOrzn0ZYOczWch0p52S66Y9YrqA/CrLgySGkp
X-Gm-Gg: ASbGnctxyTVIlkzcVq8+fiXBMfh7X9ZerBsoreOeafvmAF/sAoeOTgflezZvZ/CYfn0
 IBhnIkUkQyI5KI/Xf0p/MvrGwyaHb0pps79nI2dU5GaSGHrm2PJBym9NWgLXbBwGgQarJxGo+nt
 TG6bW+2FkcQwWqXrq6AbJ76SYGw2j7yY9YwjOpfPjmbmlRZfCuRS00l1E22bWV8K8PqYOJO85eL
 6W9yEVXIUOdBaez3SyzCOpoBEqQEJ65QvA2iYk8K3WwjCJKlEv2shy8r5W6mZ+D/R4jRs92FGWt
 wTZ4D/4jAdomgY8C+257lM++tTv7x18KLM25arLruP6H9ZHaz9LgEw==
X-Received: by 2002:a05:600c:3c9a:b0:43d:172:50b1 with SMTP id
 5b1f17b1804b1-43ecfa18703mr12399945e9.29.1743750352283; 
 Fri, 04 Apr 2025 00:05:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETetlvKyj19eV4J8JG3srze/L8z1v752o0JCsESiIDdUNLbue3Rmea7KKx54TbguG0CW9b3w==
X-Received: by 2002:a05:600c:3c9a:b0:43d:172:50b1 with SMTP id
 5b1f17b1804b1-43ecfa18703mr12399645e9.29.1743750351828; 
 Fri, 04 Apr 2025 00:05:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec17b18easm40761125e9.38.2025.04.04.00.05.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 00:05:51 -0700 (PDT)
Message-ID: <f0bee41e-a3d2-44a2-b28c-2a02cfe2989f@redhat.com>
Date: Fri, 4 Apr 2025 09:05:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Enable QEMU NVMe userspace driver on s390x
To: Farhan Ali <alifm@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, fam@euphon.net,
 philmd@linaro.org, kwolf@redhat.com, hreitz@redhat.com, thuth@redhat.com,
 mjrosato@linux.ibm.com
References: <20250401172246.2688-1-alifm@linux.ibm.com>
 <20250402155152.GE304512@fedora>
 <2c11a602415f0780030d4e68a28eee7ffcdd8cb7.camel@linux.ibm.com>
 <20250403154442.GA349582@fedora>
 <20250403102704.7e1f4452.alex.williamson@redhat.com>
 <2c244588-b37b-4e86-863e-ef462343edad@linux.ibm.com>
 <20250403120504.2f660171.alex.williamson@redhat.com>
 <d9e4feb3-351c-4c0b-8c8e-a5141e80ed5e@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <d9e4feb3-351c-4c0b-8c8e-a5141e80ed5e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.649,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/3/25 22:33, Farhan Ali wrote:
> 
> On 4/3/2025 11:05 AM, Alex Williamson wrote:
>> On Thu, 3 Apr 2025 10:33:52 -0700
>> Farhan Ali <alifm@linux.ibm.com> wrote:
>>
>>> On 4/3/2025 9:27 AM, Alex Williamson wrote:
>>>> On Thu, 3 Apr 2025 11:44:42 -0400
>>>> Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>>>> On Thu, Apr 03, 2025 at 09:47:26AM +0200, Niklas Schnelle wrote:
>>>>>> On Wed, 2025-04-02 at 11:51 -0400, Stefan Hajnoczi wrote:
>>>>>>> On Tue, Apr 01, 2025 at 10:22:43AM -0700, Farhan Ali wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> Recently on s390x we have enabled mmap support for vfio-pci devices [1].
>>>>>>> Hi Alex,
>>>>>>> I wanted to bring this to your attention. Feel free to merge it through
>>>>>>> the VFIO tree, otherwise I will merge it once you have taken a look.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Stefan
>>>>>>>> This allows us to take advantage and use userspace drivers on s390x. However,
>>>>>>>> on s390x we have special instructions for MMIO access. Starting with z15
>>>>>>>> (and newer platforms) we have new PCI Memory I/O (MIO) instructions which
>>>>>>>> operate on virtually mapped PCI memory spaces, and can be used from userspace.
>>>>>>>> On older platforms we would fallback to using existing system calls for MMIO access.
>>>>>>>>
>>>>>>>> This patch series introduces support the PCI MIO instructions, and enables s390x
>>>>>>>> support for the userspace NVMe driver on s390x. I would appreciate any review/feedback
>>>>>>>> on the patches.
>>>>>>>>
>>>>>>>> Thanks
>>>>>>>> Farhan
>>>>>> Hi Stefan,
>>>>>>
>>>>>> the kernel patch actually made it into Linus' tree for v6.15 already as
>>>>>> commit aa9f168d55dc ("s390/pci: Support mmap() of PCI resources except
>>>>>> for ISM devices") plus prerequisites. This went via the PCI tree
>>>>>> because they included a change to struct pci_dev and also enabled
>>>>>> mmap() on PCI resource files. Alex reviewed an earlier version and was
>>>>>> the one who suggested to also enable mmap() on PCI resources.
>>>>> The introduction of a new QEMU API for accessing MMIO BARs in this
>>>>> series is something Alex might be interested in as QEMU VFIO maintainer.
>>>>> That wouldn't have been part of the kernel patch review.
>>>>>
>>>>> If he's aware of the new API he can encourage other VFIO users to use it
>>>>> in the future so that you won't need to convert them to work on s390x
>>>>> again.
>>>> I don't claim any jurisdiction over the vfio-nvme driver.  In general
>>>> vfio users should be using either vfio_region_ops, ram_device_mem_ops,
>>>> or directly mapping MMIO into the VM address space.  The first uses
>>>> pread/write through the region offset, irrespective of the type of
>>>> memory, the second provides the type of access used here where we're
>>>> dereferencing into an mmap, and the last if of course the preferred
>>>> mechanism where available.
>>>>
>>>> It is curious that the proposal here doesn't include any changes to
>>>> ram_device_mem_ops for more generically enabling MMIO access on s390x.
>>>> Thanks,
>>>>
>>>> Alex
>>>
>>> Hi Alex,
>>>   From my understanding the ram_device_mem_ops sets up the BAR access for
>>> a guest passthrough device. Unfortunately today an s390x KVM guest
>>> doesn't use and have support for these MIO instructions. We wanted to
>>> use this series as an initial test vehicle of the mmap support.
>> Right, ram_device_mem_ops is what we'll use to access a BAR that
>> supports mmap but for whatever reason we're accessing it directly
>> through the mmap.  For instance if an overlapping quirk prevents the
>> page from being mapped to the VM or we have some back channel mechanism
>> where the VMM is interacting with the BAR.
>>
>> I bring it up here because it's effectively the same kind of access
>> you're adding with these helpers and would need to be addressed if this
>> were generically enabling vfio mmap access on s390x.
> 
> On s390x the use of the MIO instructions is limited to only PCI access. So i am not sure if we should generically apply this to all vfio mmap access (for non PCI devices).
> 
> 
>>
>> Prior to commit 2b8fe81b3c2e ("system/memory: use ldn_he_p/stn_he_p")
>> the mmio helpers here might have been a drop-in replacement for the
>> dereferencing of mmap offsets, but something would need to be done
>> about the explicit PCI assumption introduced here and the possibility
>> of unaligned accesses that the noted commit tries to resolve.  Thanks,
>>
>> Alex
> 
> AFAICT in qemu today the ram_device_mem_ops is used for non PCI vfio mmap cases. For s390x these helpers should be restricted to PCI accesses. For the unaligned accesses (thanks for pointing out that commmit!), are you suggesting we use the ld*_he_p/st*_he_p functions in the helpers i defined? Though those functions don't seem to be doing volatile accesses.

I think that's fine. We had the same problem to deal with the XIVE
ESB MMIO pages. See xive_esb_rw() in hw/intc/spapr_xive_kvm.c.

Thanks,

C.


