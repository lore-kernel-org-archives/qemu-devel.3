Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDF8CCA471
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 10:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5i7c-0004wq-6r; Mon, 06 Oct 2025 06:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v5i7a-0004vo-At
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 06:07:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v5i7Y-0005MW-55
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 06:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759745225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xQbJeiwp1HUOmdSS+o+g6taW7VYtJIaLYB6r0HcZAgg=;
 b=MgQfgwCMM0dSoKwtOYhqcnGxNJZEYPlSHRbIIA2V2mBBCJKLNmcZZomh+6lAWhQT3DUcEh
 6Mt2Xv6GHF77P78DRPtx9uZBiWaC6vhW7wMYRlP+9co4MY51s8SQPeK+eau5nj/HaxJfyR
 CXj814IaduKp65PpWpehpBDwWsUjdBU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-drC1QMq6N6y18wkMJU6Mnw-1; Mon, 06 Oct 2025 06:07:03 -0400
X-MC-Unique: drC1QMq6N6y18wkMJU6Mnw-1
X-Mimecast-MFC-AGG-ID: drC1QMq6N6y18wkMJU6Mnw_1759745223
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e3af78819so21747595e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 03:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759745222; x=1760350022;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xQbJeiwp1HUOmdSS+o+g6taW7VYtJIaLYB6r0HcZAgg=;
 b=L1eBoRnk80byFYH00L02lF/iu2adIsTNFUX2COy2QzVZDh8Tb9Cv47M/iFWQ9brwUS
 l6h7FFa2BFs+6SUlLf35AI4fCNe8ysxtPxZS79VK2AbgJ8MI5qxGKcwVik9cpE+ujSox
 ESXDC22K61hq5eTWDTozeqiTbJK2EBm7SdzREd0PVzUrSmCHJaU8Mb76yCDbowLWLmDP
 BdwCXorerPDTzWkz4cFOHxtf7agB8MORk+/zuKhTg7ky/F4jI8LuuyCwBnxs+xs33LbR
 IJut7h9qPYY3rDh+UisWeSKXKtnqPHTxdQf7Fuy3FTV03DQ5hwvrsPm+mYpUuQQBARcR
 zGdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/VtEB6GEub/hiRoZswwAG9reGBqRKFGZsHKGB2hgLR2FHlIcHJTL8pK7we7xhQVxVbqfcD9kFJvBi@nongnu.org
X-Gm-Message-State: AOJu0YwOUINLm9UM4XwMTljAQQ3lTV2lO12BRAkrmMPq5ZveD1TSqJS8
 h1Gzl5gMesSduIsmGuJuLzyYRoyEoCloB+EYnwjWUWjkkQ0/NY4sy/yD/3fCexhm1jXuMWB+Zh6
 02ZCcf5gnLVVDOLbmXoPawuFQhzq3fzN1DOERoNUDJHJoISzhkb++s/yj8Enm1V+b
X-Gm-Gg: ASbGncsuYUPa6V0jwlTDVvKAU/ToDU7zPnZ5b6Hp70rm8cjeGO+9uTtOI0RoXckCRtP
 1Xj6T1v/Zqaejc8alsortPD2QZxlpsi5y1RxwbGxQE4m7dRbuROkyAULFPYPenV4lF9b0xFN6Vo
 4SRWDVskL4mtY8L9GZm/scfI2WMITCqFOHk41H2v0wDT2w9Esi/Nn67lyNJWiJsX+LYca/mFVM6
 XoPdYrzVn7adrl/TIhLugq0GRVLw/SQLbpNpVDUeNI+7OTJ9y4GIZf0Me1345R3UPh1ZphUCuKM
 pASwoVn5UX3FWEQCEuNnPD/7Teo6oLzC9mOZpU1ltN78GtbdR66/SKCfBdD3+477nQCTLDm7JFZ
 kFCAzGb1JBg==
X-Received: by 2002:a05:600c:354e:b0:46d:996b:826a with SMTP id
 5b1f17b1804b1-46e7115d49dmr83844985e9.36.1759745222560; 
 Mon, 06 Oct 2025 03:07:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGN1lTKkQF+DcgWBirvzrYt53FKtkUs5ZhNuHf0LS7ohk8un7LzqGMTt2j+b4VKCeAM9jTpNQ==
X-Received: by 2002:a05:600c:354e:b0:46d:996b:826a with SMTP id
 5b1f17b1804b1-46e7115d49dmr83844725e9.36.1759745222166; 
 Mon, 06 Oct 2025 03:07:02 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-056.pools.arcor-ip.net.
 [47.64.114.56]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5c4c0321sm137004735e9.8.2025.10.06.03.07.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 03:07:01 -0700 (PDT)
Message-ID: <bd3505c1-a791-49c3-aec8-c2247d599e10@redhat.com>
Date: Mon, 6 Oct 2025 12:07:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] tests/functional: Adapt reverse_debugging to run
 w/o Avocado
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 berrange@redhat.com, qemu-arm@nongnu.org
References: <20251002020432.54443-1-gustavo.romero@linaro.org>
 <b5cb30d8-65a2-4bf7-b66f-5bfe61e19835@redhat.com>
 <8fb3351e-f1a1-4a1e-9650-33f0d4ee6d44@redhat.com>
 <bb7801f1-67d3-47d7-b5bd-39b1113ea9e0@linaro.org>
 <8d89f02e-9e5b-4cdd-9a54-d55bea8967bc@linaro.org>
 <30fec60e-b0e8-408c-b577-e4875d8bb133@linaro.org>
 <b5b739a9-28ef-4d0c-b82b-878e9aee103c@redhat.com>
 <87qzvg1hdt.fsf@draig.linaro.org>
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
In-Reply-To: <87qzvg1hdt.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 06/10/2025 11.58, Alex Bennée wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>>   Hi Gustavo!
>>
>> On 03/10/2025 17.07, Gustavo Romero wrote:
>>> Hi Thomas,
>>> On 10/3/25 11:38, Gustavo Romero wrote:
>>>> Hi Thomas,
>>>>
>>>> On 10/3/25 10:30, Gustavo Romero wrote:
>>>>> Hi Thomas,
>>>>>
>>>>> On 10/2/25 14:52, Thomas Huth wrote:
>>>>>> On 02/10/2025 18.53, Thomas Huth wrote:
>>>>>>> On 02/10/2025 04.04, Gustavo Romero wrote:
>>>>>>>> The goal of this series is to remove Avocado as a dependency for running
>>>>>>>> the reverse_debugging functional test.
>>>>>>>>
>>>>>>>> After several rounds of discussions about v1 and v2, and experiments
>>>>>>>> done by Daniel and Thomas (thanks for all the experiments and comments
>>>>>>>> so far), I've taken a new approach and moved away from using a runner
>>>>>>>> for GDB. The changes, I believe, are much simpler now.
>>>>>>>
>>>>>>>    Hi Gustavo,
>>>>>>>
>>>>>>> unfortunately, this still seems to be broken on Fedora. After
>>>>>>> applying your series, I get:
>>>>>>>
>>>>>>> stderr:
>>>>>>> Traceback (most recent call last):
>>>>>>>     File
>>>>>>> "/home/thuth/devel/qemu/tests/functional/reverse_debugging.py",
>>>>>>> line 100, in reverse_debugging
>>>>>>>       self.reverse_debugging_run(vm, port, gdb_arch, last_icount)
>>>>>>>       ~~~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>     File "/usr/lib64/python3.13/unittest/case.py", line 156, in
>>>>>>> skip_wrapper
>>>>>>>       raise SkipTest(reason)
>>>>>>> unittest.case.SkipTest: Missing env var(s): QEMU_TEST_GDB
>>>>>>
>>>>>> Looks like it's required to explicitly use the --gdb=...
>>>>>> parameter of configure to make it work, and it does not work
>>>>>> without that paramter? Could you please have a look whether it
>>>>>> works without --gdb with the auto-detected gdb for you?
>> ...
>>> I've just tried it on Fedora 42 and GDB is correctly detected:
>>> $ ../configure --target-list=aarch64-softmmu --disable-docs
>>> $ make -j check-functional-aarch64
>>
>> I just tried it again, and it just seems to be broken in my build
>> folder where I do incremental builds. It works when I build QEMU in a
>> new folder from scratch - quite weird.
>>
>>> I have installed:
>>> gromero@gromero13:~/git/qemu/build$ dnf info gdb
>>> Updating and loading repositories:
>>> Repositories loaded.
>>> Installed packages
>>> Name            : gdb
>>> Epoch           : 0
>>> Version         : 16.3
>>> Release         : 1.fc42
>>> Architecture    : x86_64
>>> Installed size  : 455.3 KiB
>>> Source          : gdb-16.3-1.fc42.src.rpm
>>
>> I've got the very same package installed here.
>>
>>>> Are you sure GDB is installed in your test env?
>>>>
>>>> Do mind checking if:
>>>>
>>>> gromero@gromero0:/mnt/git/qemu_$ gdb_bin=$(command -v
>>>> "gdb-multiarch" || command -v "gdb")
>>>> gromero@gromero0:/mnt/git/qemu_$ echo $gdb_bin
>>>> /usr/bin/gdb
>>>>
>>>> works in your env and if QEMU_TEST_GDB is in:
>>>>
>>>> $ ./pyvenv/bin/meson test  --verbose --no-rebuild -t 1 --setup
>>>> thorough  --suite func-thorough  func-aarch64-reverse_debug
>>>>
>>>> output?
>>
>> $ echo $gdb_bin
>> /usr/bin/gdb
>>
>>   Thomas
> 
> Do you want me to drop the series until we figure out whats going on?

No, I think it's ok. There is no error anymore with v6, the test just got 
skipped. Since the test is normally skipped due to the FLAKY marker anyway, 
I think that's fine.
I can keep an eye on it and try to come up with a fix in case I can figure 
it out, but otherwise, I guess time will simply fix the problem when I 
occasionally blow away my build directory anyway due to other reasons.
So please go ahead and pick up v6.

  Thanks,
   Thomas



