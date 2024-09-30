Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB20CF6491
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 06:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sv9fc-0002Po-CK; Mon, 30 Sep 2024 02:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sv9fT-0002Lr-LQ
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 02:13:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sv9el-0003OF-BN
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 02:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727676700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pGInMw/3XFrZSzuNuSvc0thMedsEaGsWI/UvMX4cdJM=;
 b=e4iyD1rWDch0SXTdqf+oDq4qUoU/n7guIlVrh3vrPP2MwGjO1shJlDVRSggWhyCHOa8l3O
 qOddlHTLPvC78TTDD/MXHxnp20SR8dSXx18iewMQVdCISDWSMr5KyharyZ+lQlH3C9NlSN
 yaD+/dCwhGQdhQ6qSAJyUG7KbZ51C4E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-9B5RxJZ2M4ykVsxasIewHQ-1; Mon, 30 Sep 2024 02:11:38 -0400
X-MC-Unique: 9B5RxJZ2M4ykVsxasIewHQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37cd2044558so1634194f8f.1
 for <qemu-devel@nongnu.org>; Sun, 29 Sep 2024 23:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727676697; x=1728281497;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pGInMw/3XFrZSzuNuSvc0thMedsEaGsWI/UvMX4cdJM=;
 b=OKdKW1+JJ0egtWbOTKiqaHwUV/kXlQpcLEDjZGu+QQ3TW7Z9cH2QPVR/C8MkakiUGe
 SUdlUeulkMALSFM47LuivuSc7xAFvECxCK/iy0X5FfO1ITWmyDqyCe3EbJVY8o18tdVa
 eaJPLKMOWSMGfQPL46staZSij8GxHlOCkm+xvdLkatnA9QoWOFL0WUfUrm5cq7Qdywwp
 b+PcvA/F8k6uLwtKFVOEC5utSgrP4UQRQPo1P/ith53lHDrI/eFnCQqSD2T/hwvD41PX
 Ty1OIuuy5llnhiTgeXFggm6qgsLiTY7kBQakrELiTAC6UOnP4yc8Nkr4Z+Xn/C8ds/8+
 XTGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnMH3QZEFxF2uDUPAPNPrg4uBgdDzo3ltqJABWNHHJKGwG1jzTqxe/JVTtfdNpOMQCc//CgjgJeKAV@nongnu.org
X-Gm-Message-State: AOJu0Yxt3FBHpR0UztkvxeHHERP9dBr9hlr/rOrv7CTsIs71Npqy+5ft
 YQaUkTZOmFYFZonw22C4QdxYcE8m4By2FDxAToe3zxQdAKLseCU3c+jxTf3Xsug6wnXYJps7Ks7
 2wxZMDt0MerIcQ8g0+2Ig5u7rUKicwDgNj3GSOL5fKFqXh/8pe5lj
X-Received: by 2002:a5d:6741:0:b0:378:e8a9:98c5 with SMTP id
 ffacd0b85a97d-37cd5aaa6d4mr6398006f8f.34.1727676696961; 
 Sun, 29 Sep 2024 23:11:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrtnP7Rd2/dy/ZZ69asTz/Ey1jO3goQLUcHJSX4Ors9equtPG/xe9QIywu5khnEtvbFXd3Cw==
X-Received: by 2002:a5d:6741:0:b0:378:e8a9:98c5 with SMTP id
 ffacd0b85a97d-37cd5aaa6d4mr6397984f8f.34.1727676696503; 
 Sun, 29 Sep 2024 23:11:36 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-48-176.web.vodafone.de.
 [109.42.48.176]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd5748918sm8117544f8f.107.2024.09.29.23.11.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Sep 2024 23:11:36 -0700 (PDT)
Message-ID: <614a48bd-0130-434a-8a9b-6e3059254f2a@redhat.com>
Date: Mon, 30 Sep 2024 08:11:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/18] pc-bios/s390-ccw: Remove panics from ISO IPL path
To: Jared Rossi <jrossi@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20240927005117.1679506-1-jrossi@linux.ibm.com>
 <20240927005117.1679506-8-jrossi@linux.ibm.com>
 <77cad234-524d-4166-ab1b-10666c8c676e@redhat.com>
 <00351eda-78c2-46f6-a122-3527736d0fa5@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
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
In-Reply-To: <00351eda-78c2-46f6-a122-3527736d0fa5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 27/09/2024 19.15, Jared Rossi wrote:
> 
> On 9/27/24 11:02 AM, Thomas Huth wrote:
>> On 27/09/2024 02.51, jrossi@linux.ibm.com wrote:
>>> From: Jared Rossi <jrossi@linux.ibm.com>
>>>
>>> Remove panic-on-error from IPL ISO El Torito specific functions so that 
>>> error
>>> recovery may be possible in the future.
>>>
>>> Functions that would previously panic now provide a return code.
>>>
>>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>>>
>>> ---
>>>   pc-bios/s390-ccw/bootmap.h  | 17 +++++++---
>>>   pc-bios/s390-ccw/s390-ccw.h |  1 +
>>>   pc-bios/s390-ccw/bootmap.c  | 64 ++++++++++++++++++++++++-------------
>>>   3 files changed, 55 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/pc-bios/s390-ccw/bootmap.h b/pc-bios/s390-ccw/bootmap.h
>>> index bbe2c132aa..cb5346829b 100644
>>> --- a/pc-bios/s390-ccw/bootmap.h
>>> +++ b/pc-bios/s390-ccw/bootmap.h
>>> @@ -385,17 +385,24 @@ static inline uint32_t iso_733_to_u32(uint64_t x)
>>>     #define ISO_PRIMARY_VD_SECTOR 16
>>>   -static inline void read_iso_sector(uint32_t block_offset, void *buf,
>>> +static inline int read_iso_sector(uint32_t block_offset, void *buf,
>>>                                      const char *errmsg)
>>>   {
>>> -    IPL_assert(virtio_read_many(block_offset, buf, 1) == 0, errmsg);

This IPL_assert() made sure that virtio_read_many() returned 0 (for success)...

>>> +    if (virtio_read(block_offset, buf)) {

... so the new code here checks that virtio_read() (which returns the same 
error code as virtio_read_many()) does *not* return 0 to signal that there 
was an error...

>>> +        puts(errmsg);
>>> +        return 1;
>>> +    }
>>> +    return 0;
>>>   }
>>>   -static inline void read_iso_boot_image(uint32_t block_offset, void 
>>> *load_addr,
>>> +static inline int read_iso_boot_image(uint32_t block_offset, void 
>>> *load_addr,
>>>                                          uint32_t blks_to_load)
>>>   {
>>> -    IPL_assert(virtio_read_many(block_offset, load_addr, blks_to_load) 
>>> == 0,
>>> -               "Failed to read boot image!");

... and this IPL_assert() also checks that virtio_read_many() returns 0 for 
success...

>>> +    if (!virtio_read_many(block_offset, load_addr, blks_to_load)) {

... but this code here checks that virtio_read_many() now returns 0 to 
signal that there is an error...

Either I need more coffee or one of the two if-conditions is wrong...?

>> That "!" looks wrong here? Or do I misunderstood the original IPL_assert() 
>> condition?
>>
> 
> Basically all of the IPL_assert() conditions become logically flipped, but 
> it is
> intended. IPL_assert() panics if success condition is NOT met, but in the new
> version an error code is returned if an failure condition IS met, so we are
> branching on the inverse condition.

Why is one of the two if-statements using a "!" and why is one without it?

>>> +        puts("Failed to read boot image!");
>>> +        return 1;
>>> +    }
>>> +    return 0;
>>>   }
>>>     #define ISO9660_MAX_DIR_DEPTH 8
...
>>> @@ -706,14 +708,18 @@ static inline uint32_t iso_get_file_size(uint32_t 
>>> load_rba)
>>>       sec_offset[0] = 0;
>>>         while (level >= 0) {
>>> -        IPL_assert(sec_offset[level] <= ISO_SECTOR_SIZE,
>>> -                   "Directory tree structure violation");
>>> +        if (sec_offset[level] > ISO_SECTOR_SIZE) {
>>> +            puts("Directory tree structure violation");
>>> +            return -EIO;
>>> +        }
>>>             cur_record = (IsoDirHdr *)(temp + sec_offset[level]);
>>>             if (sec_offset[level] == 0) {
>>> -            read_iso_sector(sec_loc[level], temp,
>>> -                            "Failed to read ISO directory");
>>> +            if (virtio_read(sec_loc[level], temp)) {
>>> +                puts("Failed to read ISO directory");
>>> +                return -EIO;
>>> +            }
>>
>> Any reasons for switching from read_iso_sector() directly to virtio_read() 
>> here?
> 
> I think this is just an oversight on my part.  I had thought to remove the
> read_iso_sector() function entirely since it is just a wrapper for
> virtio_read() that becomes redundant once the panic is removed, but it looks
> like I wasn't consistent with where I removed it.  In my opinion we can remove
> read_iso_sector() and just call virtio_read(), but either way it should be
> consistent, so I will standardize the calls.  I don't see any compelling reason
> to keep the read_iso_sector() function since all it is doing is checking the
> RC of virtio_read(), which we will want to check anyway to determine if we need
> to abort the IPL here.

I agree, I also don't see a compelling reason for keeping read_iso_sector() 
anymore.

  Thomas


