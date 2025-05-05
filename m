Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCC3C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBrmV-0005Pg-Hy; Mon, 05 May 2025 05:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uBrm8-0004qk-DV
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:06:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uBrm6-00066v-Kh
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746435969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VGRmd5/9SWtUPPususO3YRijD27RSs2hAqfNB5777fE=;
 b=DnhWxzK4S3eYPb6/F0ClRO9YQ/6M8Kye4S2JaEdcc7QY8LTS1JXKBjIPkDTrS4mq7pLud0
 6n1GAdjPLeHajyH4HaIVM/OZpB/mzKhlD4eeqxX9v0IvhV3K9qwk3AV8vQOZtmMyVXkFzY
 D+9rw5ZUI3O7D6ZroDvOQ8HoPZgAqSU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-f0QKLM6bNemXeJkM1g54yQ-1; Mon, 05 May 2025 05:06:09 -0400
X-MC-Unique: f0QKLM6bNemXeJkM1g54yQ-1
X-Mimecast-MFC-AGG-ID: f0QKLM6bNemXeJkM1g54yQ_1746435967
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39134c762ebso1149809f8f.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 02:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746435967; x=1747040767;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VGRmd5/9SWtUPPususO3YRijD27RSs2hAqfNB5777fE=;
 b=gMlV546IakoG8PXDRZhvxZP8iklB3KARl+xfF5GSinBUoTsK8CTboY57jiOIsBV+d5
 NmtGWxALGRgfUzyG+Y0/hEBl497YRgW8Z2MuBN9pUfRqEmGgK609IfETMZZrcbPNltDK
 xen0G4tN/Mmd4z1c1kKs5C5IBdXjUfVACGl+GiLoKPeoUCull55P+S2rfPkqP7VUzIFp
 aMrp8/7ZY/2VMPv55nObPXBC/kzpubdjbnv59gXouSFGIDwyyNqHZH4rYykwkvTeqzsk
 xuq0hYZWUPgLXdNSJ7WVnIrNix3R3YreCQ0QJ4gqsJ2nheF7lf990+bXmUgfrm1wtR8B
 k6Ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8kRm7OWcd3/Kv8aMjOY14NxymH77vZoQvQ26agYrA1lP4YbYLn2YJPTU3fZGKD1OS9tlSD1wt+R2w@nongnu.org
X-Gm-Message-State: AOJu0YweYQtmyJ71Swxi1aYXZwBL2cAJA0TkUKy+4nBmOPQ8q7GYMoz4
 I4uhuwc4tdD84WmkzXSDqzBqsdrAkpWjWNS/wfJhliw9mfWyGHRZomciaazREMVtHJw3Q2j8AQC
 GfrIeNnbfBrStEkqJtPvwKNKwKoYmxFuDV4fLGhSD5GRb95bayTY9
X-Gm-Gg: ASbGncumJOm3jMrc0HBY8QtGiJorzEaX5UfHlBrM+SBuV1/lWUm1VEh/WiDZPVnmXNK
 y1nZjTmlh4vPmO5SUpJsl/7DHjs95q1gh2+bcUXb9a1mNb5eOMR1z9NaGXkBjVEmOXslR4EyerZ
 Uux9C87xCeKNI7bdXWsrS1xncfHy0BVnqYMtIXmxRKDe0pQEKUDLQNREptIHP/nVKSLkZaf8CQY
 o4nTU1slgI4f1U535Qu9yxrFAySdoxBVDd+2ixIX5HrCE6xoRfghFMq81h1SCry97zgtnmx9Lj1
 w4iXDQh7RZX0SF+l40SdW6cUuRmLc7D4MmwmJo0a
X-Received: by 2002:a05:6000:240d:b0:3a0:7ed2:46b8 with SMTP id
 ffacd0b85a97d-3a09ceafecbmr6031687f8f.16.1746435967201; 
 Mon, 05 May 2025 02:06:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvyVuslvzKqbnRVvRVLkLL76JL7tsvVMPkvvAK6hudai9rkCrpUCucoPAl52Kaj7217gcl6g==
X-Received: by 2002:a05:6000:240d:b0:3a0:7ed2:46b8 with SMTP id
 ffacd0b85a97d-3a09ceafecbmr6031656f8f.16.1746435966800; 
 Mon, 05 May 2025 02:06:06 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-87.web.vodafone.de. [109.42.49.87])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89cc480sm129299755e9.2.2025.05.05.02.06.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 02:06:06 -0700 (PDT)
Message-ID: <bd23ff1c-d1a2-4967-b8bb-a6eda6a4ca33@redhat.com>
Date: Mon, 5 May 2025 11:06:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] hw/i386/x86: Remove
 X86MachineClass::fwcfg_dma_enabled field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-devel@nongnu.org,
 Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>
References: <20250501183628.87479-1-philmd@linaro.org>
 <20250501183628.87479-4-philmd@linaro.org>
 <2acc8c0c-f563-4d27-b73d-ce4c0f8ef424@nutanix.com>
 <54d72848-9108-4b04-a46c-1f82492e06cb@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <54d72848-9108-4b04-a46c-1f82492e06cb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 02/05/2025 12.45, Philippe Mathieu-Daudé wrote:
> On 2/5/25 11:08, Mark Cave-Ayland wrote:
>> On 01/05/2025 19:36, Philippe Mathieu-Daudé wrote:
>>
>>> The X86MachineClass::fwcfg_dma_enabled boolean was only used
>>> by the pc-q35-2.6 and pc-i440fx-2.6 machines, which got
>>> removed. Remove it and simplify.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   include/hw/i386/x86.h | 2 --
>>>   hw/i386/microvm.c     | 3 ---
>>>   hw/i386/multiboot.c   | 7 +------
>>>   hw/i386/x86-common.c  | 3 +--
>>>   hw/i386/x86.c         | 2 --
>>>   5 files changed, 2 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
>>> index fc460b82f82..29d37af11e6 100644
>>> --- a/include/hw/i386/x86.h
>>> +++ b/include/hw/i386/x86.h
>>> @@ -29,8 +29,6 @@
>>>   struct X86MachineClass {
>>>       MachineClass parent;
>>> -    /* use DMA capable linuxboot option rom */
>>> -    bool fwcfg_dma_enabled;
>>>       /* CPU and apic information: */
>>>       bool apic_xrupt_override;
>>>   };
> 
> 
>>> diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
>>> index 6e6b96bc345..bfa7e8f1e83 100644
>>> --- a/hw/i386/multiboot.c
>>> +++ b/hw/i386/multiboot.c
>>> @@ -153,7 +153,6 @@ int load_multiboot(X86MachineState *x86ms,
>>>                      int kernel_file_size,
>>>                      uint8_t *header)
>>>   {
>>> -    bool multiboot_dma_enabled = X86_MACHINE_GET_CLASS(x86ms)- 
>>> >fwcfg_dma_enabled;
>>>       int i, is_multiboot = 0;
>>>       uint32_t flags = 0;
>>>       uint32_t mh_entry_addr;
>>> @@ -402,11 +401,7 @@ int load_multiboot(X86MachineState *x86ms,
>>>       fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, mb_bootinfo_data,
>>>                        sizeof(bootinfo));
>>> -    if (multiboot_dma_enabled) {
>>> -        option_rom[nb_option_roms].name = "multiboot_dma.bin";
>>> -    } else {
>>> -        option_rom[nb_option_roms].name = "multiboot.bin";
>>> -    }
>>> +    option_rom[nb_option_roms].name = "multiboot_dma.bin";
>>
>> Question: now that all machines support DMA-capable fw_cfg, does that mean 
>> that the non-DMA options roms above can also be removed?
> 
> All x86 machines, but there are still 2 not supporting it: HPPA and
> MIPS Loongson-3:
> 
> hw/hppa/machine.c:204:    fw_cfg = fw_cfg_init_mem(addr, addr + 4);
> 
> hw/mips/loongson3_virt.c:289:    fw_cfg = fw_cfg_init_mem_wide(cfg_addr, 
> cfg_addr + 8, 8, 0, NULL);
> 

But these don't use "multiboot.bin", do they? So I think you could remove 
pc-bios/multiboot.bin now from the repo?

Same question for "linuxboot.bin" : All users in hw/i386 seem to enable DMA, 
so fw_cfg_dma_enabled() should always return true here? If so, I think the 
normal "linuxboot.bin" could go away, too?

  Thomas


