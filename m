Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61E6D75E30
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 12:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tESqP-00055p-MU; Fri, 22 Nov 2024 07:33:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tESqM-000549-Qc
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 07:33:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tESqK-0004Hi-S8
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 07:33:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732278773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7dcLeRfvRq84WfdwQfYsnrrCw4UsQMiHXXPRYpseIFw=;
 b=UHwqraq6iTlYp5MzIeGRwxX5lYHltW2RgaG4EDjG9f1dOJksCiergVSDIec/2UXsa/w9sv
 HkLg+Cqh0yChLQpWca6Tp6elBsJ9WMLRmOsYLt8W6tn4QlHufBPdpPdPte11vgG92dPaVw
 h2l8nVD9Rg/HTdtASBRKTk71AiUmNc8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-VSmpXjLdOh2WtDkv3aq8Kg-1; Fri, 22 Nov 2024 07:32:52 -0500
X-MC-Unique: VSmpXjLdOh2WtDkv3aq8Kg-1
X-Mimecast-MFC-AGG-ID: VSmpXjLdOh2WtDkv3aq8Kg
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43154a0886bso13841505e9.0
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 04:32:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732278771; x=1732883571;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7dcLeRfvRq84WfdwQfYsnrrCw4UsQMiHXXPRYpseIFw=;
 b=Faszon1Y/3fH63gMzPPBGi1U61R6cJ97tLNpSqN+JbJ80VDChSWbnrbYPFoyGERGYz
 gGIAGHdk32HGD+KYX8UyEvRpp4l0Zj9Y7f+esv7q36TJvCZMPLOCThhR+z4moW6JFUSm
 SfrASS7Q6aZFE2A4RnNbztNkXOhNW5epriGWldxtfb/oMiNF0qNEjQGZLPXjd9hAf5c3
 0RTFL+yfuYzh7EBm2zWrlvc9GxzDpXEmggHsguxFXpq6t64w2eANdvpXGhOTLW6v2jQI
 oqjp4+TJzc8nyXGez2t+fRPFmjsCoagNXVmxSgKIq6WlWX7y7xp25cmPGPi0DGeqYbWo
 gvKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKQyg8lWmI+G2tSy3A1JkjFjJwrv8pb8790dGg47389/qrJOnAKqNb6BAOdgVg7/J45iS96aYed/oY@nongnu.org
X-Gm-Message-State: AOJu0Ywx5soVA/RnBvKQzpm9nJbfrc7nRRNBCkVC55TaQ22RGVQjwbEa
 n3USiZs3LrWERd7KHNUA0LGjDsTW5zwCJTTASH4MvqiW/2H4lniS0EbcaDw/4olslOfytkAyVTi
 S95Xffhgj5RpDvhDewWZ2bWhC2DLm6MTWr//wDB1+F+ypxwDlfTIm
X-Gm-Gg: ASbGncs5ORUhw/ir8lHcwSthOY0YplsbyVqdbtyrTWRPQ3OouwMZYP2p6A5HHePbhBW
 ysTRA07BSmoHXJCJ9ewPQMAR9bT7Ev3IYouxjwf5Qujjo4whSI+r18TeSGxG6FuI4fNLgcuiSuK
 xpaTFvVr4tpoO67gAV302peQk+7r5rQM1F0VIrViviEzfeyRi6G1uAhRbkaDoE5XYgrtFVax8vP
 siajqA4lR8TixZFqCgg5JD7kXoOu57yYVVTV61iKWcGuMCOC3tjOzVmAp5GrJC8PNU1TZG5o10=
X-Received: by 2002:a05:600c:1c24:b0:426:6f27:379a with SMTP id
 5b1f17b1804b1-433ce42560amr24531705e9.13.1732278770897; 
 Fri, 22 Nov 2024 04:32:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwwvjVOcJsaleiUXP6M3FkignGyluKj6GqgoP5j+zudQ5/jrDYuXeWsHt2MA8mjzV8y9Nziw==
X-Received: by 2002:a05:600c:1c24:b0:426:6f27:379a with SMTP id
 5b1f17b1804b1-433ce42560amr24531385e9.13.1732278770526; 
 Fri, 22 Nov 2024 04:32:50 -0800 (PST)
Received: from [10.33.192.206] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fb2685csm2339929f8f.46.2024.11.22.04.32.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 04:32:50 -0800 (PST)
Message-ID: <6133bd27-7907-4f7d-b3ef-94d7f17785c1@redhat.com>
Date: Fri, 22 Nov 2024 13:32:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/39] maintainer updates for -rc2 pre-PR
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-riscv@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>, Bernhard Beschow <shentey@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-s390x@nongnu.org, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org, John Snow <jsnow@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-rust@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Markus Armbruster <armbru@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Ani Sinha <anisinha@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20241121165806.476008-1-alex.bennee@linaro.org>
 <2b8f6079-f2ca-471f-8580-43352437625d@redhat.com>
 <a3935ca8-5a44-4f2a-a414-aaa39f8e193c@redhat.com>
 <0cbbec0d-5be0-4ec2-8791-470c70d93e33@redhat.com>
 <ae1ee2e9-4be2-49ae-a5dc-2bc6e72a8506@redhat.com>
 <f30aa80f-613e-4a01-94ce-b2779349ece7@redhat.com>
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
In-Reply-To: <f30aa80f-613e-4a01-94ce-b2779349ece7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 22/11/2024 12.59, Cédric Le Goater wrote:
> On 11/22/24 11:47, Thomas Huth wrote:
>> On 21/11/2024 22.46, Cédric Le Goater wrote:
>>> On 11/21/24 20:10, Thomas Huth wrote:
>>>> On 21/11/2024 20.03, Cédric Le Goater wrote:
>>>>> Hello Alex,
>>>>>
>>>>> On 11/21/24 17:57, Alex Bennée wrote:
>>>>>> This is a mostly testing focused set of patches but a few bug fixes as
>>>>>> well. I plan to send the PR in on Monday. I can drop any patches that
>>>>>> are objected to but I think its pretty safe.
>>>>>>
>>>>>> Contains:
>>>>>>
>>>>>>    - Daniel's clean-up of functional tests
>>>>>>    - Another avocado->function conversion from Thomas
>>>>>>    - Update the tuxrun baseline images
>>>>>>    - Minor fix to the rust pl011 device
>>>>>>    - Documentation clarification on identity
>>>>>>
>>>>>> The following could do with some review:
>>>>>>
>>>>>>    tests/functional: update the x86_64 tuxrun tests
>>>>>>    tests/functional: update the sparc64 tuxrun tests
>>>>>>    tests/functional: update the s390x tuxrun tests
>>>>>>    tests/functional: update the riscv64 tuxrun tests
>>>>>>    tests/functional: update the riscv32 tuxrun tests
>>>>>>    tests/functional: update the ppc64 tuxrun tests
>>>>>>    tests/functional: update the ppc32 tuxrun tests
>>>>>>    tests/functional: update the mips64el tuxrun tests
>>>>>>    tests/functional: update the mips64 tuxrun tests
>>>>>>    tests/functional: update the mips32el tuxrun tests
>>>>>>    tests/functional: update the mips32 tuxrun tests
>>>>>>    tests/functional: add a m68k tuxrun tests
>>>>>>    tests/functional: update the i386 tuxrun tests
>>>>>>    tests/functional: update the aarch64 tuxrun tests
>>>>>>    tests/functional: update the arm tuxrun tests
>>>>>>    tests/functional: Convert the Avocado aarch64 tuxrun tests 
>>>>>
>>>>> Do you think we could include patches 2-4 from this series ?
>>>>>
>>>>> https://lore.kernel.org/all/20241112130246.970281-1-clg@redhat.com/
>>>>>
>>>>> Only patch 3 lacks a R-b.
>>>>
>>>> I had a question on patch 3 and a suggestion on patch 4 ... could you 
>>>> maybe address them first? Thanks!
>>>
>>> Oh Sorry I forgot.
>>>
>>> I did address patch 4 in my tree ... In Patch 3, EXTRA_BOOTARGS was
>>> added by Alex IIRC to work around the console issue. We ended up
>>> adding the sleep call. I can resend tomorrow.
>>
>> IMHO v4 looks fine now ( https://lore.kernel.org/qemu- 
>> devel/20241122090322.1934697-1-clg@redhat.com/ ) in case you want to pick 
>> it up, Alex.
>>
>>   Thomas
>>
> 
> Here is a check-functional run with this series and the v4 I sent :
> 
>    https://paste.debian.net/1336417/
> 
> This system is fast so the timeouts are more certainly tests failures :
> 
>    func-sh4-sh4_tuxrun        ?
>    func-rx-rx_gdbsim         https://gitlab.com/qemu-project/qemu/-/issues/2691

Both tests are marked with QEMU_TEST_FLAKY_TESTS, so yes, it's likely the 
flakiness of the tests.

  Thomas



