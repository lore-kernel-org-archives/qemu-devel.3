Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C270C54756
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 09:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI22E-0006HR-KG; Thu, 22 May 2025 05:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uI22B-0006GJ-D7
 for qemu-devel@nongnu.org; Thu, 22 May 2025 05:16:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uI228-00037Z-55
 for qemu-devel@nongnu.org; Thu, 22 May 2025 05:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747905368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tMkucFVvTfKQmJcqUoRGB+2vvpFuojEVMxDwar6PfPI=;
 b=AHURVA91NNDnfj1RldRsiYSXJ3B0mA2oR/ry+tgTSEyXn+jHAGgQbEwuw42pSmuMGStubF
 IRwIckdXbI8lO6DlWW3ENly2qfLs31PLx53lZ8z3PR6bgO2v1QpcsStc8sjCxXhIEQVTg3
 S7vcrizgbYL8rGzb7eeXxVggoyf/dLw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-7FlJ1irbNPaXS7S6CvGt8A-1; Thu, 22 May 2025 05:16:06 -0400
X-MC-Unique: 7FlJ1irbNPaXS7S6CvGt8A-1
X-Mimecast-MFC-AGG-ID: 7FlJ1irbNPaXS7S6CvGt8A_1747905366
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-441c96c1977so51585455e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 02:16:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747905365; x=1748510165;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tMkucFVvTfKQmJcqUoRGB+2vvpFuojEVMxDwar6PfPI=;
 b=Qv3nL9kJTbkiNeVahkSTjUUqgAvqlU7jKFNJSk/aio4ahHh2bv53nOIDexM8gJMDmT
 2xRJFvsvFDSNqhs8czk72wbd58Ta2SXL6tRNUhOIujLPf4IgL/2WcziceirMq2Sp31EE
 KKK2qDQ0jO9aoyTVPVT403QosDu7FQMj0LaIOAn36w5aAWMXo4weSEVjYab2+Ob+fcG6
 9o0F5hK2D625eefPCDxD6sK1QGIgYJfHBeV1BRpzDW9ywpqHCaGLVYON8Tvulk4ZGj0M
 rbA3x2ykTZ55sOCH9xIu8NU8VrtOT52PXB4PixSn8cT7WRplO941GuXqWQ9KDGtHAo51
 eK3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/1RPkraXgsDPp1+sQ/LDhUtqU8QjiwMkGIKL4SncIlpBo7OEFTt/sBStzz+hpZUrAcR++j91dcu+n@nongnu.org
X-Gm-Message-State: AOJu0Yynfe0FabTx3+8c+QSz2EKIpQDRP2pc8TneaEJz2L9uvM0hrDJB
 edCwdvJTD3ff4UmR4TtITqxtk+t1adlKpGMfWt2ip0vCVrP9XGhha45AK14D1IoS34snbA7xqI7
 VSNVKveduhkRuM4LJUJrMx5VZnQSuaiZJGGJNmnnjz3KWovEOvuCX4A7u
X-Gm-Gg: ASbGncvEmsf++STtVW4Fch518uIefkuCczu8eeroISDKYJQO5ay7DxP6QzTnTiML3G7
 7OKICNTji4nZ9sd3q91wwxvi4OkKNY6BmKmtXEyD3waSrgkN9TWe4gYShqUchB0WpaS5+nzaJ9z
 R3Dzlke6sTeNKpCj828oIue0GjXeysx/OXra1XbKweteua9KEBIRXJg3ObsNJNFad10aTrgZ/18
 ggNprocxKqy5JWb6xnQCcv3OhvLaskbmJGv5pop7uCXwMqeeKuFKFtBF24BPWAw7lA8EKm48tv6
 AhjJKql0pVZAXgxHqra4VmEreA1FL5GwVEjY8m9HNU8=
X-Received: by 2002:a05:600c:3b86:b0:442:f8e7:25ef with SMTP id
 5b1f17b1804b1-442fefeefebmr172659275e9.11.1747905365477; 
 Thu, 22 May 2025 02:16:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlMPBoAOTKAgu+9GVxLiUfRX0sIA/4CQK64j952loUK7oHFh6i5ImRSbaWXIPFGqX4DbBSaA==
X-Received: by 2002:a05:600c:3b86:b0:442:f8e7:25ef with SMTP id
 5b1f17b1804b1-442fefeefebmr172658905e9.11.1747905365042; 
 Thu, 22 May 2025 02:16:05 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-201.web.vodafone.de.
 [109.42.49.201]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f3dd9c21sm100971305e9.38.2025.05.22.02.16.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 May 2025 02:16:04 -0700 (PDT)
Message-ID: <0e4a5fe1-186b-4c69-87d0-9b0743d795b7@redhat.com>
Date: Thu, 22 May 2025 11:16:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] tests/functional: add memlock tests
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 "yc-core @ yandex-team . ru" <yc-core@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250521135522.11180-1-dtalexundeer@yandex-team.ru>
 <20250521135522.11180-3-dtalexundeer@yandex-team.ru>
 <430eaa84-5695-4fc2-90d5-d488a204e999@redhat.com>
 <af6b28bd-44cf-4540-b5f8-49d8b2781e13@yandex-team.ru>
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
In-Reply-To: <af6b28bd-44cf-4540-b5f8-49d8b2781e13@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 22/05/2025 10.51, Alexandr Moshkov wrote:
> 
> On 5/22/25 12:49, Thomas Huth wrote:
>> On 21/05/2025 15.55, Alexandr Moshkov wrote:
>>> Add new tests to check the correctness of the `-overcommit memlock`
>>> option (possible values: off, on, on-fault) by using
>>> `/proc/{qemu_pid}/smaps` file to check in Size, Rss and Locked fields of
>>> anonymous segments:
>>>
>>> * if `memlock=off`, then Locked = 0 on every anonymous smaps;
>>> * if `memlock=on`, then Size, Rss and Locked values must be equal for
>>> every anon smaps where Rss is not 0;
>>> * if `memlock=on-fault`, then Rss and Locked must be equal on every anon
>>> smaps and anonymous segment with Rss < Size must exists.
>>>
>>> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
>>> ---
>> ...
>>> diff --git a/tests/functional/test_memlock.py b/tests/functional/ 
>>> test_memlock.py
>>> new file mode 100755
>>> index 0000000000..a090e7f9ad
>>> --- /dev/null
>>> +++ b/tests/functional/test_memlock.py
>>> @@ -0,0 +1,107 @@
>>> +#!/usr/bin/env python3
>>> +#
>>> +# Functional test that check overcommit memlock options
>>> +#
>>> +# Copyright (c) Yandex Technologies LLC, 2025
>>> +#
>>> +# Author:
>>> +#  Alexandr Moshkov <dtalexundeer@yandex-team.ru>
>>> +#
>>> +#
>>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>>> +# later.  See the COPYING file in the top-level directory.
>>
>> I just noticed: New file need a SPDX identifier nowadays to keep scripts/ 
>> check_patch.pl happy.
> 
> Hello, thanks for reply, i fix that in a moment!
> 
>>
>> Anyway, I now also tested the patch, but for me, it's not working: After 
>> setting ulimit -l to 2G and running the test, I get:
>>
>> $ ~/devel/qemu/tests/functional/test_memlock.py
>> TAP version 13
>> ok 1 test_memlock.MemlockTest.test_memlock_off
>> Traceback (most recent call last):
>>   File "~/devel/qemu/tests/functional/test_memlock.py", line 60, in 
>> test_memlock_on
>>     self.assertTrue(smap['Size'] == smap['Rss'] == smap['Locked'])
>>     ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> AssertionError: False is not true
>>
>> not ok 2 test_memlock.MemlockTest.test_memlock_on
>> Traceback (most recent call last):
>>   File "~/devel/qemu/tests/functional/test_memlock.py", line 70, in 
>> test_memlock_onfault
>>     self.assertTrue(smap['Rss'] == smap['Locked'])
>>     ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> AssertionError: False is not true
>>
>> not ok 3 test_memlock.MemlockTest.test_memlock_onfault
>>
>> I added two print statements right in front of the asserts to see the 
>> values, and for the first one it shows (after many successfully comparisons):
>>
>> line 60: 4 == 4 == 0
>>
>> And similar for the second one:
>>
>> line 70: 4 == 0
>>
>> FWIW, this is on Fedora 41.
>>
>> Looking at the smaps file, it seems like this comes from a shared library:
>>
>> 7ff16c7c9000-7ff16c7ca000 r--p 00000000 00:2a 29149631 /usr/lib64/spa-0.2/ 
>> support/libspa-support.so
>> Size:                  4 kB
>> KernelPageSize:        4 kB
>> MMUPageSize:           4 kB
>> Rss:                   4 kB
>> Pss:                   0 kB
>> Pss_Dirty:             0 kB
>> Shared_Clean:          4 kB
>> Shared_Dirty:          0 kB
>> Private_Clean:         0 kB
>> Private_Dirty:         0 kB
>> Referenced:            4 kB
>> Anonymous:             0 kB
>> KSM:                   0 kB
>> LazyFree:              0 kB
>> AnonHugePages:         0 kB
>> ShmemPmdMapped:        0 kB
>> FilePmdMapped:         0 kB
>> Shared_Hugetlb:        0 kB
>> Private_Hugetlb:       0 kB
>> Swap:                  0 kB
>> SwapPss:               0 kB
>> Locked:                0 kB
>> THPeligible:           0
>> ProtectionKey:         0
>>
>> So maybe you've got to ignore the mappings of .so files in your test?
> 
> Oh, this segments are already ignored in _parse_anonymous_smaps(), so this 
> segment should not have returned from it.
> 
> Maybe it comes from another segment? Or i have bug in anon segments 
> parsing.. I'll take a closer look, thanks.

Yes, it seems to be another segment. After looking through the smaps a 
little bit longer, I also spotted this one here:

7f8fcc6a1000-7f8fcc6a2000 rw-p 00000000 00:00 0
Size:                  4 kB
KernelPageSize:        4 kB
MMUPageSize:           4 kB
Rss:                   4 kB
Pss:                   4 kB
Pss_Dirty:             4 kB
Shared_Clean:          0 kB
Shared_Dirty:          0 kB
Private_Clean:         0 kB
Private_Dirty:         4 kB
Referenced:            4 kB
Anonymous:             4 kB
KSM:                   0 kB
LazyFree:              0 kB
AnonHugePages:         0 kB
ShmemPmdMapped:        0 kB
FilePmdMapped:         0 kB
Shared_Hugetlb:        0 kB
Private_Hugetlb:       0 kB
Swap:                  0 kB
SwapPss:               0 kB
Locked:                0 kB
THPeligible:           0
ProtectionKey:         0

  HTH,
   Thomas


