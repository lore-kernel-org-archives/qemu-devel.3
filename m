Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380C2C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 13:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXKbT-0003H4-V6; Fri, 26 Jul 2024 09:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sXKbR-0003GT-GF
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 09:03:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sXKbP-0001bI-F3
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 09:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721998996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zK7NHoK52fBt02O1P+IhRQMZhEYyA8bgCXxaZErtyk8=;
 b=DwHcex9w15MUdZziGf46g3hGAGvU7H10vAMUaa6nDNyz/5HMy5WIgjId2nkVoxpUjrgW7f
 c2LA5bBySl8e2XF5RPGf98kjP4K5uvahIwEPdcLam8gUNVMp8OifdhA3Ivf3eLDDIWpINg
 czj49gXhPaXkdzqpgV7KlMn5DJT/Az4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-xC_VVgSFP4mHoJgrRm0_kw-1; Fri, 26 Jul 2024 09:03:15 -0400
X-MC-Unique: xC_VVgSFP4mHoJgrRm0_kw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5a8b0832d9cso1557120a12.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 06:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721998994; x=1722603794;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zK7NHoK52fBt02O1P+IhRQMZhEYyA8bgCXxaZErtyk8=;
 b=pj11wK4638sQf4CA49kuUmUn/EEbRQqiIiCpQQLdajGX51czIMsE2YesRq5C3/Q7ED
 PMwImk4F5Jzp3ym8qOWbsF9Tmc22BJvuERYilVLDT8IOleClzn/naqa8LXB1mYB0UZnC
 jEAZ6oXLrq4SnfTHriUD05HzwjcyYFbGWMJ3H0aHxk8F/jKUacMJMkSJVeFgkr2muXX+
 zNtBPigLLpgHrk5DDAatYx/HGbdXmBHpBspMmsmf38Zo50Zxdh5p6X5uLDHy6Q3sp4iq
 RsLs3uqQHwusmbOAXq6R2WKEMEDLyvtgyxx1QFvwByI/yQ080xQ47zt8kRHCimDbmvdR
 hyoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZYXyTorKrXphqOGt+VEcYxU8PeiZwRwsgow5F+QDTN7dBxUww7nLsE+tYmr1afuRTaHZqyLeNJvIh8xEy5a7A3kqhuWs=
X-Gm-Message-State: AOJu0Yx+A/NOQv+lezdIu+wC8gHkr8iIVirVVXn0JhnAndOqSal9OjvG
 N3d5ZskBGMvoRH6CuuNJ3ajdXK/Kpe6wV6a3gCGnKZ9TFbCni62lzhkqQJo1c0A6VhpH7lpFSSQ
 wumNG5rpypMmu7Mwxn3aZRUuRvsIZ/EceLjU6s21pxuKThDC3NC0h
X-Received: by 2002:a50:d74e:0:b0:58b:73f4:2ed with SMTP id
 4fb4d7f45d1cf-5ac2c5a5e66mr3049781a12.35.1721998993235; 
 Fri, 26 Jul 2024 06:03:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoVpxNGs14B3KJo+2xnZB3dKRfXUXjPQVVVweqH4LliZyq0iD4/p68vfQZRuB2nMt19Ro1Cg==
X-Received: by 2002:a50:d74e:0:b0:58b:73f4:2ed with SMTP id
 4fb4d7f45d1cf-5ac2c5a5e66mr3049753a12.35.1721998992685; 
 Fri, 26 Jul 2024 06:03:12 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-178-36.web.vodafone.de.
 [109.43.178.36]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5af473522cfsm569785a12.86.2024.07.26.06.03.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jul 2024 06:03:12 -0700 (PDT)
Message-ID: <c1cba52c-34fb-49f6-b362-abbb9439629e@redhat.com>
Date: Fri, 26 Jul 2024 15:03:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/23] Convert avocado tests to normal Python unittests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Fabiano Rosas <farosas@suse.de>
References: <20240724175248.1389201-1-thuth@redhat.com>
 <6d609ff1-c4df-4960-be5f-4b29c5911879@linaro.org>
 <ZqIhJSbT2qQKJ7lj@redhat.com>
 <df67c0be-e0d1-4ac2-9a88-2765417875ac@linaro.org>
 <ZqIx9kGMyUShbzUR@redhat.com>
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
In-Reply-To: <ZqIx9kGMyUShbzUR@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 25/07/2024 13.07, Daniel P. Berrangé wrote:
> On Thu, Jul 25, 2024 at 08:42:31PM +1000, Richard Henderson wrote:
>> On 7/25/24 19:55, Daniel P. Berrangé wrote:
>>> On Thu, Jul 25, 2024 at 09:35:22AM +1000, Richard Henderson wrote:
...
>> Avocado runs a first pass doing all of the downloads, and only afterward
>> runs the actual timed tests.  I don't know the specifics of how, but it
>> certainly obvious in the logging.
> 
> Oh interesting, I found how it does it..
> 
> The file avocado/plugins/assets.py will build an AST of the python
> code in a test file, look for all 'fetch_asset' calls, then extract
> the parameters to these calls, and donwload them. This is clever.
> Basically avoids the refactoring that I suggested.
> 
> So yeah, that is a gap.
> 
> Practically speaking, we have a choice of either  calling into this
> avocado python lib as is, or copying tthat python lib into QEMU.

Honestly, I'd prefer to do some refactoring instead, something like you 
suggested in your earlier mail. Rationale: For the basic tests it would be 
good if we would not depend on the Avacodo framework anymore, otherwise we 
likely will continue to run into the situation that our test framework stops 
working on some random new python versions and nobody within the QEMU 
community has a clue how to fix the situation since nobody is really 
familiar with the Avocado framework. Also, while that 
avocado/plugins/assets.py sounds like a very neat trick done by a skilled 
Python wizard, the average QEMU developer (like me) is just a skilled C 
coder with only basic Python knowledge, so I'd prefer if we could use a 
simpler mechanism instead that is easier to understand and to debug for 
everybody once we run into problems with it.

Thus, I'd suggest to bite the bullet and refactor the tests that download 
assets. I can look into this after my summer vacation - but if somebody 
feels interested and wants to look into this during the next two weeks 
already, that would be very welcome, too, of course!

  Thomas


