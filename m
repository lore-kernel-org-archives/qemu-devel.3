Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582E7D15D93
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 13:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2ssb-0001cS-1z; Mon, 21 Oct 2024 09:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2ssZ-0001ba-5Z
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 09:55:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2ssX-0004OI-2S
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 09:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729518923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=n+Z/+fJqw/R9O11gMBH7oHIZKDIeMIhEs2mZgc+3QvE=;
 b=SWIhQ8uPkRLZ+9o7owaE6XGpjHYkGMO7FWS63nNS6IZdfjTUJSL09iqLuwW/zJNeja793o
 lGC8wPn5mScJFr0nioejRmlcxdc9ECey7t5z3b10h1q/a5A07pPzfPJAv6keabXLwoT/Ti
 w/YMwPM/Pd3GestXpxS3l+0RASj5SEc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-nkay4-HmP16NH2OEX4hgaA-1; Mon, 21 Oct 2024 09:55:22 -0400
X-MC-Unique: nkay4-HmP16NH2OEX4hgaA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d45de8bbfso3178678f8f.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 06:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729518921; x=1730123721;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n+Z/+fJqw/R9O11gMBH7oHIZKDIeMIhEs2mZgc+3QvE=;
 b=VMQsVMYTlmG105Oh0f/7o3ZGUyWaTelBMAZL3s9ykvDBegrSQVo/iLXZPmYJMzKQ0b
 8O5Tzy1MWuag33KDRN6W7P9wg8knMoLec5j8Al2YHc3PoGCjYlQMjS1nhJbMBcyBAxGk
 KP53E9pKNwDEu5JTThMb7gpD2Edjji+N8fsixCkPNTNT8kREmzKxS4BqpILKkRnVFn7k
 j3EbT0/bkVOoA2MfsRFOByy7tINHvrvIppgBRzbTUpEbZul7rQg7EaJuFjcEky+jQe2X
 R/lgtmBRYQ9+OjBYEM/ObGKORLKoqZb7XvIWWlPZY79T3cdYByhUjmMl5J2HvmUq6sZO
 Y63A==
X-Gm-Message-State: AOJu0YyDc2k/e8UiVp4P6f8nNkeZ625Z5TkhRSCmmHHzvQ35UrJvaXYE
 EHQjqZPPXqQW6O7ZC3PJTwdkMAMTq64Ghqclb6pMC3PXGdwwsRAO/JoNW0+Wk0ogcXQ76hosIRw
 zF6VVfou/Ixr3mCUUouB9sx77UNF8m4oW2gHlkEFAQogzafOcXRFUU2n6oyKJ5+A=
X-Received: by 2002:a5d:4dce:0:b0:37c:d1fb:82f4 with SMTP id
 ffacd0b85a97d-37eab75583amr9394020f8f.36.1729518921128; 
 Mon, 21 Oct 2024 06:55:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWfxHt7H5rP3kZ50CLgzMsT45LDEFALpQVY914OMVAN4hXk0elawlJFOyk5XzReGQaerv5lA==
X-Received: by 2002:a5d:4dce:0:b0:37c:d1fb:82f4 with SMTP id
 ffacd0b85a97d-37eab75583amr9393996f8f.36.1729518920757; 
 Mon, 21 Oct 2024 06:55:20 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-50-24.web.vodafone.de. [109.42.50.24])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b9bb66sm4365364f8f.95.2024.10.21.06.55.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 06:55:20 -0700 (PDT)
Message-ID: <d5db0cb8-0ec3-4f41-a14c-7d07cbe6f4ec@redhat.com>
Date: Mon, 21 Oct 2024 15:55:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/21] Test updates (tuxrun tests, new QTest maintainer,
 ...)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20241021113500.122500-1-thuth@redhat.com>
 <CAFEAcA9VKkjfYgnv=x5kp+KUZ4rC0y9-KiCWBG+F84MBh7rxPw@mail.gmail.com>
 <a8bbb335-55f4-4c34-b56f-76482391c80e@redhat.com>
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
In-Reply-To: <a8bbb335-55f4-4c34-b56f-76482391c80e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 21/10/2024 15.18, Thomas Huth wrote:
> On 21/10/2024 15.00, Peter Maydell wrote:
>> On Mon, 21 Oct 2024 at 12:35, Thomas Huth <thuth@redhat.com> wrote:
>>>
>>> The following changes since commit f1dd640896ee2b50cb34328f2568aad324702954:
>>>
>>>    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into 
>>> staging (2024-10-18 10:42:56 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>    https://gitlab.com/thuth/qemu.git tags/pull-request-2024-10-21
>>>
>>> for you to fetch changes up to ee772a332af8f23acf604ad0fb5132f886b0eb16:
>>>
>>>    tests/functional: Convert the Avocado sh4 tuxrun test (2024-10-21 
>>> 13:25:12 +0200)
>>>
>>> ----------------------------------------------------------------
>>> * Convert the Tuxrun Avocado tests to the new functional framework
>>> * Update the OpenBSD CI image to OpenBSD v7.6
>>> * Bump timeout of the ide-test
>>> * New maintainer for the QTests
>>> * Disable the pci-bridge on s390x by default
>>>
>>> ----------------------------------------------------------------
>>
>> Couple of failures on the functional-tests:
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/8140716604
>>
>> 7/28 qemu:func-thorough+func-aarch64-thorough+thorough /
>> func-aarch64-aarch64_tuxrun TIMEOUT 120.06s killed by signal 15
>> SIGTERM
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/8140716520
>>
>> 14/17 qemu:func-thorough+func-loongarch64-thorough+thorough /
>> func-loongarch64-loongarch64_virt TIMEOUT 60.09s killed by signal 15
>> SIGTERM
>>
>> I'm retrying to see if these are intermittent, but they
>> suggest that we should bump the timeout for these.
> 
> Everything was fine with the gitlab shared runners (https://gitlab.com/ 
> thuth/qemu/-/pipelines/1504882880), but yes, it's likely the private runners 
> being slow again...
> 
> So please don't merge it yet, I'll go through the jobs of the private 
> runners and update the timeouts of the failed jobs and the ones where it is 
> getting close to the limit.

Actually, looking at it again, the func-loongarch64-loongarch64_virt test is 
not a new one, this has been merged quite a while ago already. And in 
previous runs, it only took 6 - 10 seconds:

  https://gitlab.com/qemu-project/qemu/-/jobs/8125336852#L810
  https://gitlab.com/qemu-project/qemu/-/jobs/8111434905#L740

So maybe this was just a temporary blip in the test runners indeed? Could 
you please try to rerun the jobs to see how long they take then?

  Thanks
   Thomas


