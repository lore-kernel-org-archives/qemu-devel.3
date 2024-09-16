Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63FCC3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 06:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sq4yS-00064K-Ji; Mon, 16 Sep 2024 02:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sq4yO-00061U-2Y
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 02:12:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sq4yM-0003yw-0m
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 02:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726467148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IU43YZLnlqou3HGWHsz4HNQvzRKfvBLc3jIplNcGmY0=;
 b=MyQjORBPoaTr03xhAOCZwVZ/N4wNjcqEqyl75m/1Veb/SYCkEDVfYw9wr1eyhgRcYdeS3l
 fThSiw99A/SVZSPOeIn/Ru27eE/ir0tS/1psvgTCbylC/k5NwtXo+FXVPBAPi38CmFN+Oj
 3dQ0lz+2qh1+aPkVt1VvacFLlhwMlrs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-d3DjdUgwPaaC-4nFvefBJw-1; Mon, 16 Sep 2024 02:12:26 -0400
X-MC-Unique: d3DjdUgwPaaC-4nFvefBJw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5c251bcb728so2131004a12.2
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2024 23:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726467145; x=1727071945;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IU43YZLnlqou3HGWHsz4HNQvzRKfvBLc3jIplNcGmY0=;
 b=CztTJt0odi2+8+zUd9fsF+0m0AQo+u4scwCZTFGDlZbbB9/3HC6YZxt1OHJLjYx2X+
 fJGYVSMW/TiIuHtvIJRfQpv8v7L2FGE4/7E4YCHp+XYIcTxF2oYC6qs53RBWHwziopFD
 SfglXk5Tvi5ja9Qpfko84HPV1YS8SbN9EzylVkEcUp1fimB1AbYMmLkA+suzAXDhvXg4
 e81DLKj9NrqGq9vx/wii28MItnbP8T+2p8y3Kt/KMYJOIrDzi/rERcb+456dSNeqbAqk
 BGW83xfA682uNK5o5kbpL9eL2ulJ6BfH0/JyRIBAY7L3kLmZLAWv9hUkyVssLZoyVf6V
 DY6g==
X-Gm-Message-State: AOJu0YzQ/MhxKMa0gjWTTe7rGb+1fRj2XRZo0YEUzL5RPr6rz77HaxbL
 p+tDQkWgKA5QsDwQN1T55r8JzijG6MAHHVLdFSjlMHVp859m0vPZjLlKZglceF5PigLHTsZeulo
 JwO5yMU7BpmW0aRhaH9xPP1mBOZ8/RofoAg9Lbr6At++9oFhUmZyb
X-Received: by 2002:a05:6402:2750:b0:5c2:60ac:fdd8 with SMTP id
 4fb4d7f45d1cf-5c413e12321mr11658604a12.13.1726467145503; 
 Sun, 15 Sep 2024 23:12:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2QjxEgCc1V4Dy3Y+kmhjXumgNgSrN9xr56g7752QGhQZIPoeUB/BuyimlpgAeOJSxVwdE3Q==
X-Received: by 2002:a05:6402:2750:b0:5c2:60ac:fdd8 with SMTP id
 4fb4d7f45d1cf-5c413e12321mr11658585a12.13.1726467144924; 
 Sun, 15 Sep 2024 23:12:24 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-178-133.web.vodafone.de.
 [109.43.178.133]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bb89d44sm2211982a12.70.2024.09.15.23.12.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Sep 2024 23:12:23 -0700 (PDT)
Message-ID: <9b97cbc4-7074-40bb-aa47-93e495c8786e@redhat.com>
Date: Mon, 16 Sep 2024 08:12:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/47] riscv-to-apply queue
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair23@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Ajeet Singh <itachis6234@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
 <CAFEAcA_W5bTcCmeAx+dB4+djcUHzjRH4GfBobaHot5VjE+x05g@mail.gmail.com>
 <CAKmqyKOFnajGSsKS2k=kYsB--uRjoCZZTv3QSxbEm40HK_k1jA@mail.gmail.com>
 <4aa984d0-db18-4a41-808c-e4d164c03d13@ventanamicro.com>
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
In-Reply-To: <4aa984d0-db18-4a41-808c-e4d164c03d13@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 15/09/2024 21.58, Daniel Henrique Barboza wrote:
> Hi Peter, Alistair,
> 
> On 9/14/24 6:15 AM, Alistair Francis wrote:
>> On Fri, Sep 13, 2024 at 8:37 PM Peter Maydell <peter.maydell@linaro.org> 
>> wrote:
>>>
>>> On Thu, 12 Sept 2024 at 06:30, Alistair Francis <alistair23@gmail.com> 
>>> wrote:
>>>>
>>>> The following changes since commit 
>>>> a4eb31c678400472de0b4915b9154a7c20d8332f:
>>>>
>>>>    Merge tag 'pull-testing-gdbstub-oct-100924-1' of https://gitlab.com/ 
>>>> stsquad/qemu into staging (2024-09-11 13:17:29 +0100)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>    https://github.com/alistair23/qemu.git tags/pull-riscv-to- 
>>>> apply-20240912-1
>>>>
>>>> for you to fetch changes up to 90d5d3c1115399d8e27621efd69dfa74a35a4932:
>>>>
>>>>    hw/intc: riscv-imsic: Fix interrupt state updates. (2024-09-12 
>>>> 15:05:10 +1000)
>>>>
>>>> ----------------------------------------------------------------
>>>> RISC-V PR for 9.2
>>>>
>>>> * Add a property to set vl to ceil(AVL/2)
>>>> * Enable numamem testing for RISC-V
>>>> * Consider MISA bit choice in implied rule
>>>> * Fix the za64rs priv spec requirements
>>>> * Enable Bit Manip for OpenTitan Ibex CPU
>>>> * Fix the group bit setting of AIA with KVM
>>>> * Stop timer with infinite timecmp
>>>> * Add 'fcsr' register to QEMU log as a part of F extension
>>>> * Fix riscv64 build on musl libc
>>>> * Add preliminary textra trigger CSR functions
>>>> * RISC-V IOMMU support
>>>> * RISC-V bsd-user support
>>>> * Respect firmware ELF entry point
>>>> * Add Svvptc extension support
>>>> * Fix masking of rv32 physical address
>>>> * Fix linking problem with semihosting disabled
>>>> * Fix IMSIC interrupt state updates
>>>
>>> Hi; this fails to build on FreeBSD:
>>>
>>> https://gitlab.com/qemu-project/qemu/-/jobs/7817823771
> 
> Is this one of those jobs that are only available when running the main 
> pipeline? I don't
> have this x86-freebsd runner when triggering the gitlab pipeline. I ended up 
> installing a
> FreeBSD VM and using it to reproduce the problem.
> 
> Would be nice to have access to a FreeBSD runner as a regular user, even if 
> just for x86_64,
> to help detect these build problems before sending a PR.

You can enable this job for your pipelines, too, see 
.gitlab-ci.d/cirrus/README.rst for information how to configure it.

If you have a Linux host with KVM, you could alternatively also use "make 
vm-build-freebsd" on your local machine instead.

  Thomas


