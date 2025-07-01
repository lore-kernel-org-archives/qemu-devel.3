Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC315C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 15:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcWm-0007QW-DD; Tue, 01 Jul 2025 11:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uWcWk-0007Q2-01
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 11:04:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uWcWd-0001MS-Q8
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 11:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751382237;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+V26RQ9dDGQgTbpoIwnPJwm4j3M31eZGmT8jXNJ3HNY=;
 b=PDpEaXQNtmcyKIPqaQKsHxVxrMRkXzKyv6LFHQ2Zt7LceQGXPfWZFN70stEIcBQVL1EZ71
 9Tspu7rPrvkhYVC0hz0/72YuVx2RU6tv4RFGXrbkOCh1s/T65DPz9IWRfC1TKEmlMxNAz9
 NUA6LHUO35h5Hy/kzAXTXGj4y+HZ3QQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-j4ix_LYtN_yfIhSQxwCBvg-1; Tue, 01 Jul 2025 11:03:56 -0400
X-MC-Unique: j4ix_LYtN_yfIhSQxwCBvg-1
X-Mimecast-MFC-AGG-ID: j4ix_LYtN_yfIhSQxwCBvg_1751382235
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4eee2398bso2324662f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 08:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751382235; x=1751987035;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+V26RQ9dDGQgTbpoIwnPJwm4j3M31eZGmT8jXNJ3HNY=;
 b=RBSJ9lPqZwVVyp8ewk19UTKkfdgX5vemBLQ7T/cHoYCtU7D0az58lorh+dMZ05P1fH
 W5xDyHI8ieSl+sb1r8Jl+S0ndTrybEhWRbt+JDNlUvFu3we7GAcHVKUZwByz6kpofgNf
 PAPcmvbOu/spb1zxdmy8apEUphAUwNsnBWaygqd3Jl79jBQnPZcwrjGLH2ZWH1AdWmxJ
 PmqqrRFEmGTmM74Ck5/NHwJS7tPgLy6L+/VXA/F6F6Iuc3Dpurv8cAoVh90MXbzw4OzD
 NQuE9ZoIKCxghGoqotvOGbe95I3qnsUFD++g+GPzy/ffOMRtuUG97TvnJPbKNUyJNLJk
 TX5Q==
X-Gm-Message-State: AOJu0YwGz1G7WLvaYB3f2ptz+BQDX+eCeHG+lXVw2Cr0IdCrJZZIbD4h
 sH63J/U6/AX2lFdHOZf9rNbqsvSFrZGtfhRdTyRJiB378f7lLVF9pkz0lDm6aZnCn4w6FW5Oa96
 6baAvHWBorzlFf2l8rU1D6iFhckxXLn4p+d4KyBFs1zh7/GxZxWrPxaua
X-Gm-Gg: ASbGnctbJV0PzzJPqQqAZRJKmZd7G+xLrqKy8Qjkeuj0YFLJWaDGPdTysc266DuMjcK
 1oTUW2gWAt4jmyEjWO1GyR3W76TQYLB11ayhITX5VhwyM9xwT++cggyshaSFczKpmPYn+Gi6T7T
 31MThShKfSFMI0MHUB9ey3VvLqzfsQMT/J8yr/zp976QMrMwT15ur0XFZGdhR2KZTU3rP9f4lUE
 gIyyFBqQ5IJBVfvN8nGvKcaOCqu460PXmoEaH8J5NNz+yelZYMafxsvyBDv3JQe8GLlLOSU2xqy
 lR68cgTpCbHhi6okgafI57pFjpRXekeKvF0zrYuVt0Kifn0sUdzfBB9C/K2IUm9Vv5HJWQ==
X-Received: by 2002:a05:6000:4009:b0:3a8:2f65:373f with SMTP id
 ffacd0b85a97d-3aa9fc2002dmr14430366f8f.16.1751382234607; 
 Tue, 01 Jul 2025 08:03:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5ip4Lsfs511rWGCphqHTr2OYeW2YS07ZtdCFVV6qDRDtOPxnE/M6i+tt8fVSUZRoLJeUOug==
X-Received: by 2002:a05:6000:4009:b0:3a8:2f65:373f with SMTP id
 ffacd0b85a97d-3aa9fc2002dmr14430281f8f.16.1751382233984; 
 Tue, 01 Jul 2025 08:03:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538233c4acsm195314915e9.1.2025.07.01.08.03.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 08:03:53 -0700 (PDT)
Message-ID: <d36b7df3-50b0-4dda-ba27-b948d8de3a20@redhat.com>
Date: Tue, 1 Jul 2025 17:03:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu v16 3/5] hw/arm/virt: Basic CXL enablement on
 pci_expander_bridge instances pxb-cxl
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>,
 Peter Maydell <peter.maydell@linaro.org>, mst@redhat.com,
 Zhijian Li <lizhijian@fujitsu.com>, Itaru Kitayama
 <itaru.kitayama@linux.dev>, linuxarm@huawei.com, linux-cxl@vger.kernel.org,
 qemu-arm@nongnu.org, Yuquan Wang <wangyuquan1236@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250625161926.549812-1-Jonathan.Cameron@huawei.com>
 <20250625161926.549812-4-Jonathan.Cameron@huawei.com>
 <4ceea721-b633-499e-9fcd-735990ee0704@redhat.com>
 <20250701154110.00007675@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250701154110.00007675@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Jonathan,

On 7/1/25 4:41 PM, Jonathan Cameron wrote:
> On Tue, 1 Jul 2025 15:26:26 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> Hi Jonathan,
>>
>> On 6/25/25 6:19 PM, Jonathan Cameron via wrote:
>>> Code based on i386/pc enablement.
>>> The memory layout places space for 16 host bridge register regions after
>>> the GIC_REDIST2 in the extended memmap. This is a hole in the current
>>> map so adding them here has no impact on placement of other memory regions
>>> (tested with enough CPUs for GIC_REDIST2 to be in use.)  
>> Doesn't it depend on the init RAM size setting.
>> if the init RAM top + REDIST2 aligns to a 256MB boundary (size of the
>> PCI ECAM) aren't you likely to have no hole?
> Hi Eric,
>
> Is that possible?  I think the device_memory_base being force to align
> to a 1 GiB means that never happens.  That seems to occur even
> if there is no device_memory.  
>
>     device_memory_base =
>         ROUND_UP(vms->memmap[VIRT_MEM].base + ms->ram_size, GiB);
>     device_memory_size = ms->maxram_size - ms->ram_size + ms->ram_slots * GiB;
>
>     /* Base address of the high IO region */
>     memtop = base = device_memory_base + ROUND_UP(device_memory_size, GiB);
> //So here we are GiB aligned.
Yes you are totally right, even without device memory, base is 1GiB
aligned when entering virt_set_high_memmap. I forgot this alignment
enforcement.

So we are good. Sorry for the noise

> ...
>
>     if (base < vms->memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES) {
>         base = vms->memmap[VIRT_MEM].base + LEGACY_RAMLIMIT_BYTES;
>     }
>
> //That's 256 GiB in or leave it alone as more than that but GiB aligned.
>
>    /* We know for sure that at least the memory fits in the PA space */
>     vms->highest_gpa = memtop - 1;
>
>     virt_set_high_memmap(vms, base, pa_bits);
>
>
> So I think I'm fine. I should call out that REDIST2 is GiB
> aligned though in this patch description.
>>
>>> The CFMWs are placed above the extended memmap.  Note the confusing
>>> existing variable highest_gpa is the highest_gpa that has been allocated
>>> at a particular point in setting up the memory map.  
>> what kind of improvement would you foresee wrt highest_gpa?
> This was mostly a response to Peter expressed that he was expecting
> highest_gpa to reflect the limit, not the highest yet seen.
>
> I'm not sure how to resolve that without having awkward naming
> like highest_gpa_sofar. There are existing comments where it is updated
> so I'm not thinking we need to change anything for this.

OK I understand now.

Eric
>
>
> Thanks for taking a look,
>
> Jonathan
>


