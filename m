Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F86C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 19:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1soB-0003Ja-Tr; Tue, 30 Apr 2024 15:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1so9-0003JF-S0
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 15:06:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1so7-0000pg-Nb
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 15:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714503982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=idA994zUAkyXNdYTuuSFRCgTn38s+Xn+H8JL7r7rAq0=;
 b=c9nePHB/KCLTpfKyANe2zNgG7d5Ez1smgcdj/7LN4VZjvPDwRx28qy9oz6QMQ5WmifCUBw
 U+w6W2BK4n+/AfF/vbZybiOQx8DUsZmWXM0vVf74i4b1L4rEHlmPvobe2bdkB5tNFDH/5V
 9/Xda27d0p47JmSWaIBFXQcUYzApNqE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-uYdeG0lqOuOzTou_ACuCgg-1; Tue, 30 Apr 2024 15:06:20 -0400
X-MC-Unique: uYdeG0lqOuOzTou_ACuCgg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-41c01902e60so14226335e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 12:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714503979; x=1715108779;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=idA994zUAkyXNdYTuuSFRCgTn38s+Xn+H8JL7r7rAq0=;
 b=RJahw8TGsszxi2jNQp6Ox6c/LVsX0Wx7R7IWm00Htytl75bq3MKu1n+964M97AzfwN
 zmYaIVhbac65+S69YwXj6ZHq9B2bdLheFOMwYsfqrXtGdXTvxy8IrydcSrRk6u3wvf0J
 SZN9Jn5zenya78vi3fm8I6Ph2rwD/JyaoV0ObSQj1Sb6PnpUGEaItn9h2UK6zKYWwwy6
 k5PcELQtJkZNh53IEgzBbOBySuPOARuQC8JGkTHKMIMrJ1zokaBfRWoqcgqSzpdLX2Wr
 8XslguugTbFexX3mAEA63TqrgNz5i3ll4I2ba84i9XBB5EVC0d1lJ4CxZWkXa0nfVbvl
 5iRg==
X-Gm-Message-State: AOJu0YxdzXKKBAvMHjHvuNyCybnhIKqPOhFAHz0JvGkyf/1guAHYdwOG
 AB2SVgr/Ud2cuhgY/TZO3nCnTRmEbmbqkhEDj2k3gFA5JP5rX5XsxniUkfZAIhVPQqdFhW9wsrc
 v+AD56iTaW2sTRrWXbMix518YS2U2rb3+kDdeYOpdUXk5iDomP0U2
X-Received: by 2002:a05:600c:1c83:b0:41b:aa11:29b3 with SMTP id
 k3-20020a05600c1c8300b0041baa1129b3mr316086wms.35.1714503979568; 
 Tue, 30 Apr 2024 12:06:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGfIXGFOikR8FmYf2wCDpc0g+QVQVlpVDRF/rdv0lKlEyYVSbX2YF33Okm6jN7iSpEEtHdtw==
X-Received: by 2002:a05:600c:1c83:b0:41b:aa11:29b3 with SMTP id
 k3-20020a05600c1c8300b0041baa1129b3mr316073wms.35.1714503979234; 
 Tue, 30 Apr 2024 12:06:19 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-179-34.web.vodafone.de.
 [109.43.179.34]) by smtp.gmail.com with ESMTPSA id
 fl23-20020a05600c0b9700b0041bc41287cesm14652962wmb.16.2024.04.30.12.06.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 12:06:18 -0700 (PDT)
Message-ID: <cf84dff2-b2d9-481e-8e54-8fb78dc214b3@redhat.com>
Date: Tue, 30 Apr 2024 21:06:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/s390x: Attach the sclpconsole to the /machine/sclp node
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>,
 qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240430080408.415890-1-thuth@redhat.com>
 <e6954259-a211-4fa3-9093-3675b97c4a5c@redhat.com>
 <f958af03-00d3-4d3a-b54b-f060c8fc70df@redhat.com>
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
In-Reply-To: <f958af03-00d3-4d3a-b54b-f060c8fc70df@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 30/04/2024 16.24, Thomas Huth wrote:
> On 30/04/2024 13.58, Cédric Le Goater wrote:
>> On 4/30/24 10:04, Thomas Huth wrote:
>>> The sclpconsole currently does not have a proper parent in the QOM
>>> tree, so it shows up under /machine/unattached - which is somewhat
>>> ugly. Let's attach it to /machine/sclp instead.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   include/hw/s390x/sclp.h    |  2 +-
>>>   hw/s390x/s390-virtio-ccw.c | 11 +++++++----
>>>   hw/s390x/sclp.c            |  4 +++-
>>>   3 files changed, 11 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
>>> index b405a387b6..abfd6d8868 100644
>>> --- a/include/hw/s390x/sclp.h
>>> +++ b/include/hw/s390x/sclp.h
>>> @@ -222,7 +222,7 @@ static inline int sccb_data_len(SCCB *sccb)
>>>   }
>>> -void s390_sclp_init(void);
>>> +Object *s390_sclp_init(void);
>>>   void sclp_service_interrupt(uint32_t sccb);
>>>   void raise_irq_cpu_hotplug(void);
>>>   int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code);
>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>>> index 4dcc213820..e2f9206ded 100644
>>> --- a/hw/s390x/s390-virtio-ccw.c
>>> +++ b/hw/s390x/s390-virtio-ccw.c
>>> @@ -237,11 +237,13 @@ static void s390_create_virtio_net(BusState *bus, 
>>> const char *name)
>>>       }
>>>   }
>>> -static void s390_create_sclpconsole(const char *type, Chardev *chardev)
>>> +static void s390_create_sclpconsole(Object *sclp, const char *type,
>>> +                                    Chardev *chardev)
>>>   {
>>>       DeviceState *dev;
>>>       dev = qdev_new(type);
>>> +    object_property_add_child(sclp, type, OBJECT(dev));
>>>       qdev_prop_set_chr(dev, "chardev", chardev);
>>>       qdev_realize_and_unref(dev, sclp_get_event_facility_bus(), 
>>> &error_fatal);
>>>   }
>>> @@ -252,8 +254,9 @@ static void ccw_init(MachineState *machine)
>>>       int ret;
>>>       VirtualCssBus *css_bus;
>>>       DeviceState *dev;
>>> +    Object *sclp;
>>> -    s390_sclp_init();
>>> +    sclp = s390_sclp_init();
>>
>> I would simply drop s390_sclp_init(), same for :
>>
>>    void s390_init_tod(void);
>>    void s390_init_ap(void);
>>    void s390_stattrib_init(void);
>>    void s390_skeys_init(void);
>>    void s390_flic_init(void);
>>
>> These routines all do the same and are not very useful TBH, and I would
>> add pointers under the s390x MachineState possibly.
> 
> Some of them seem to do a little bit more things, like checking whether the 
> feature is available or not, e.g. s390_init_ap() ... IMHO it makes sense to 
> keep at least those?
> 
> But for s390_sclp_init ... it could be inlined, indeed, especially if we 
> also switch the object_unref + qdev_realize in there into 
> qdev_realize_and_unref. Let me try to do that in a v2 ...

Actually, after looking at the code a little bit longer, it seems to me like 
the sclpconsole should be attached to /machine/sclp/s390-sclp-event-facility
instead of just /machine/sclp, since the other devices of type 
TYPE_SCLP_EVENT are also located there. That makes the patch even easier 
since we already have the pointer from sclp_get_event_facility_bus() in that 
function.

  Thomas



