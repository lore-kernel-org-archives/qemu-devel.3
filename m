Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213FAC28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 10:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu7pf-0002cg-NR; Mon, 17 Mar 2025 06:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tu7pd-0002by-GV
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 06:36:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tu7pb-00063W-Qm
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 06:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742207784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bM2dyKJpstUzKe5NW+C4OxEF497of7da5cfefbVtcrg=;
 b=VSEpXI10DvWf+BLyxOJ8qnu/G9JxUckb/MFblS+yEtyZB3cvX6G4lfIwKCPGxjd5R1i+U9
 jD/mDpXxj3MEqwa7d9VIlzOOt4QqGKdjg0zQ59fyT0+8v9sBQ2oMOwYdHfiO+Jowq5DAWT
 MxW+YF1Vd29ZOJ9mo0ECokanQZr9fFE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-VZf7QduIP5KLBCAxRslPvg-1; Mon, 17 Mar 2025 06:36:21 -0400
X-MC-Unique: VZf7QduIP5KLBCAxRslPvg-1
X-Mimecast-MFC-AGG-ID: VZf7QduIP5KLBCAxRslPvg_1742207780
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43ab5baf62cso17814855e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 03:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742207780; x=1742812580;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=bM2dyKJpstUzKe5NW+C4OxEF497of7da5cfefbVtcrg=;
 b=btq+//4VWHFBaaUi/ZB/JDtxZ451R8tcr3NLZYoOfRzrgMHisNn8FjqjES1du/JzIe
 aRkYSTlq7SaOnBt0VjEWE3r0f6orvU9rzum3GLtdEtQVEUK+uv9eHO050vAu3wtDvRvs
 ymrl3K1bdpieYU7tDEh8/nf5bXe+IhKupgGu5MxiYu6nMUtQ654gZIX02WT8T26eRlm3
 uGZH8cP8sWIjbSxD/riiIcALgnc8OI0SrZc3jxkY2bEfm5HcrBE8dIufT3A0gS8yCaWd
 g3Du5bTlfM0salE8OVcFcMyhOlPNGFi2xdOF/OPWAHOIrtLrYAhssiro9z00kgVP2pGF
 CkvQ==
X-Gm-Message-State: AOJu0YyRP3cmRDURKX73TWSMrkkwWfB6OZkVQSCSqWOlEneR1GX2NZlc
 EYZVk9mPpu4D3wHY0NE6vCC1obUMD9ZcPypO3s5JNfy2xbPcKO+U8zEATOFg6x3ieY0gpdJWUrJ
 0jkamO+2XubOvmHTvu32VSXbquCc3hQC1LVsikf/mJ6s9Dv14MHEZ
X-Gm-Gg: ASbGncsuURVSmJu7ahkbqgVbShGzxbKZRWUOcGpKjbA+9SzYBeWlEI27jDUqnVYMnla
 Tg/r4tWhl3DR/uY1bzYKjVna8ISfNW+WjS2I/3UX/9oX0/9w2PyAkcEb6HD7HSM+soPgavmVkCh
 vOjIqeCyH3G+ejbGm9ChRpjCx24EtJTaPugslHENh45c80pS5Ujgj8p+S5J+Bw7NjGCZNNg567i
 bYfHfOyxyCl/Jszraqpdrl1wYtLPqmPEhkNTHO0Fd1XeUSFZ/2d7/KtST+q7x4RIOFAkZjtzc6N
 rfjHcpPOk+4Y1Vev4UW2uIgGvLjpCYKIopVNLktKXwiV0wD6bT03CLWdfPY7t2mKll/vb1LUTG2
 TFCWRs0wN69aiBvpKFjeJTAqWcPGimdza07S2t+a0F98=
X-Received: by 2002:a5d:64cf:0:b0:38f:2efb:b829 with SMTP id
 ffacd0b85a97d-3971f5113f7mr10374680f8f.50.1742207779896; 
 Mon, 17 Mar 2025 03:36:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWs4TgZN7EpkNdNwfgAZlMLTvoqVsv2Gn4ZHvm/LbyORj0yeGh6VUTmO0DyNPbaa2C5WSJTg==
X-Received: by 2002:a5d:64cf:0:b0:38f:2efb:b829 with SMTP id
 ffacd0b85a97d-3971f5113f7mr10374655f8f.50.1742207779487; 
 Mon, 17 Mar 2025 03:36:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73c:aa00:ab00:6415:bbb7:f3a1?
 (p200300cbc73caa00ab006415bbb7f3a1.dip0.t-ipconnect.de.
 [2003:cb:c73c:aa00:ab00:6415:bbb7:f3a1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7eb953sm14725162f8f.93.2025.03.17.03.36.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 03:36:19 -0700 (PDT)
Message-ID: <58ad6709-b229-4223-9956-fa9474bad4a6@redhat.com>
Date: Mon, 17 Mar 2025 11:36:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] memory-attribute-manager: Introduce
 MemoryAttributeManager to manage RAMBLock with guest_memfd
To: Chenyi Qiang <chenyi.qiang@intel.com>,
 "Gupta, Pankaj" <pankaj.gupta@amd.com>, Alexey Kardashevskiy <aik@amd.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
References: <20250310081837.13123-1-chenyi.qiang@intel.com>
 <20250310081837.13123-5-chenyi.qiang@intel.com>
 <2ab368b2-62ca-4163-a483-68e9d332201a@amd.com>
 <3907507d-4383-41bc-a3cb-581694f1adfa@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <3907507d-4383-41bc-a3cb-581694f1adfa@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.333,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 17.03.25 03:54, Chenyi Qiang wrote:
> 
> 
> On 3/14/2025 8:11 PM, Gupta, Pankaj wrote:
>> On 3/10/2025 9:18 AM, Chenyi Qiang wrote:
>>> As the commit 852f0048f3 ("RAMBlock: make guest_memfd require
>>> uncoordinated discard") highlighted, some subsystems like VFIO may
>>> disable ram block discard. However, guest_memfd relies on the discard
>>> operation to perform page conversion between private and shared memory.
>>> This can lead to stale IOMMU mapping issue when assigning a hardware
>>> device to a confidential VM via shared memory. To address this, it is
>>> crucial to ensure systems like VFIO refresh its IOMMU mappings.
>>>
>>> RamDiscardManager is an existing concept (used by virtio-mem) to adjust
>>> VFIO mappings in relation to VM page assignment. Effectively page
>>> conversion is similar to hot-removing a page in one mode and adding it
>>> back in the other. Therefore, similar actions are required for page
>>> conversion events. Introduce the RamDiscardManager to guest_memfd to
>>> facilitate this process.
>>>
>>> Since guest_memfd is not an object, it cannot directly implement the
>>> RamDiscardManager interface. One potential attempt is to implement it in
>>> HostMemoryBackend. This is not appropriate because guest_memfd is per
>>> RAMBlock. Some RAMBlocks have a memory backend but others do not. In
>>> particular, the ones like virtual BIOS calling
>>> memory_region_init_ram_guest_memfd() do not.
>>>
>>> To manage the RAMBlocks with guest_memfd, define a new object named
>>> MemoryAttributeManager to implement the RamDiscardManager interface. The
>>
>> Isn't this should be the other way around. 'MemoryAttributeManager'
>> should be an interface and RamDiscardManager a type of it, an
>> implementation?
> 
> We want to use 'MemoryAttributeManager' to represent RAMBlock to
> implement the RamDiscardManager interface callbacks because RAMBlock is
> not an object. It includes some metadata of guest_memfd like
> shared_bitmap at the same time.
> 
> I can't get it that make 'MemoryAttributeManager' an interface and
> RamDiscardManager a type of it. Can you elaborate it a little bit? I
> think at least we need someone to implement the RamDiscardManager interface.

shared <-> private is translated (abstracted) to "populated <-> 
discarded", which makes sense. The other way around would be wrong.

It's going to be interesting once we have more logical states, for 
example supporting virtio-mem for confidential VMs.

Then we'd have "shared+populated, private+populated, shared+discard, 
private+discarded". Not sure if this could simply be achieved by 
allowing multiple RamDiscardManager that are effectively chained, or if 
we'd want a different interface.

-- 
Cheers,

David / dhildenb


