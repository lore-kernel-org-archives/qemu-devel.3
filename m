Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F673C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 15:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEA2J-0008Kh-KW; Mon, 03 Jun 2024 11:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sEA2I-0008Jv-8P
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:55:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sEA2G-0005lk-H1
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717430143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HGSxPs5T42tQhrMi2chY8UCZ+Zx50Ep0yD+amyfRoqk=;
 b=MT9T7L9tCgcj6ENhFvrwIXl9ZJebqqS7e7vsY6AdOCRWPprkbQ6mZd9C9yQtiEEXXMfppx
 +TmQb8xLQwdvI96e5WfeMU1yofk2cSwrj7YZWvll9/5r39oI/eSG1W4JTaow7JmDKf4p2Z
 3yxrqSF/fDQP8FBU/wKmW0BzDOVP5fA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-apFeErn6NcOVxhrAauzTeg-1; Mon, 03 Jun 2024 11:55:41 -0400
X-MC-Unique: apFeErn6NcOVxhrAauzTeg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-421292df2adso24803245e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 08:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717430139; x=1718034939;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HGSxPs5T42tQhrMi2chY8UCZ+Zx50Ep0yD+amyfRoqk=;
 b=BNYalbNds/Nmm1DC81miLqsqhe3KMvpe8ESlL25fp4+idyxV+7bh83WrNGmchsVe/n
 HAoZp+Jzd38fRBTXvo3lLHAP3WF/w5XlxlvgYrMpD3RbUSshe4Ek/IDVEd/KHt1bElMm
 nuD6avUrfXlrT2guYp4EgifkgkRd+y1SO6/1HMLvrKLe+i2Rt5LL3q/bkBCmNL6dQfak
 MxCQ9t+J6HVSW/FU4M91m5gzV8RiieD4F23GjUPDYAtKPPN/YEDRi8VdC3/OkIvX73io
 gOgsHefmgQ+5gFbgAat1eweBzycwzoesCatX5tQ9gAuZIMxMZs9FoOZyYE68jQrXLSdI
 /hJQ==
X-Gm-Message-State: AOJu0Yw090ysk/MncVJ3xFyDdvE9DpIUFpJNY6cZraUDydxztPdqubOf
 9UWbVV/8NlQiV2qFHAL+cBkBKrF9qpNK1rB3jcCWbLLkeEv+vCdCJ9BCRKzESs18Fj9SVL1/kcD
 Te8OC7PvW93UOjWeqXD4kx3ZLZMBzLLtMYXHdnmkkJ/eTgziC7HDdUxNvGxW3
X-Received: by 2002:a05:600c:5012:b0:420:29a8:ff5e with SMTP id
 5b1f17b1804b1-4212e05f233mr78135565e9.19.1717430139483; 
 Mon, 03 Jun 2024 08:55:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuxr7C0J1Q8Q4BOcdaTzLDWgW4BKZKzDqIpgFRqhPe56ebdppEXvDW0u1M2DrrovUdzZpTfA==
X-Received: by 2002:a05:600c:474a:b0:41b:285:8417 with SMTP id
 5b1f17b1804b1-4212e0be702mr67433115e9.40.1717430118235; 
 Mon, 03 Jun 2024 08:55:18 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-176-229.web.vodafone.de.
 [109.43.176.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42128edaaf0sm143214915e9.15.2024.06.03.08.55.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 08:55:17 -0700 (PDT)
Message-ID: <618857e6-dd88-4834-af1b-561228fd7dc1@redhat.com>
Date: Mon, 3 Jun 2024 17:55:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io/channel-socket: Fix -fsanitize=undefined problem with
 latest Clang
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20240529133106.1224866-1-thuth@redhat.com>
 <CAFEAcA8yOgGS8VdFRmJJKaUZe9Q=jDDh7itK6Q7vUH4TtEbFnw@mail.gmail.com>
 <Zl27orDnp8hOqgKo@redhat.com>
 <844ed2cb-9f91-439f-bd6a-73003acfdef1@redhat.com>
 <Zl3YBQQ5yWdQoH4y@redhat.com>
 <CAFEAcA_kkM6VgeVKxbSB_=UHOn0a6aFFUTUOeNP4otEoboYtvg@mail.gmail.com>
 <CAFEAcA_QPwi093sB3jSD9EcJ43q2vvZMHwJ58NWqWL2-4soo8Q@mail.gmail.com>
 <Zl3myjbEdsiitiB-@redhat.com>
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
In-Reply-To: <Zl3myjbEdsiitiB-@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 03/06/2024 17.52, Daniel P. Berrangé wrote:
> On Mon, Jun 03, 2024 at 04:12:34PM +0100, Peter Maydell wrote:
>> On Mon, 3 Jun 2024 at 15:58, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>
>>> On Mon, 3 Jun 2024 at 15:49, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>> We can't rely on the sanitizers to catch all cases where we're casting
>>>> functions, as we don't have good enough code coverage in tests to
>>>> identify all places that way.
>>>>
>>>> Unless there's a warning flag we can use to get diagnosis of this
>>>> problem at compile time and then fix all reported issues, I won't have
>>>> any confidence in our ability to remove -fsanitize-cfi-icall-generalize-pointers
>>>> for CFI.
>>>
>>> You might think that -Wcast-function-type would detect them at compile
>>> time, but that has two loopholes:
>>>   1. void(*) (void)  matches everything
>>>   2. any parameter of pointer type matches any other pointer type
>>>
>>> It seems to me rather inconsistent that the sanitizers do
>>> not match up with the warning semantics here. I think I
>>> would vote for raising that with the compiler folks --
>>> either the sanitizer should be made looser so it matches
>>> the -Wcast-function-type semantics, or else a new tighter
>>> warning option that matches the sanitizer should be
>>> provided. Ideally both, I think. But it's definitely silly
>>> to have a runtime check that flags up things that the
>>> compiler perfectly well could detect at compile time but
>>> is choosing not to.
>>
>> Slightly further investigation suggests clang 16 and later
>> have -Wcast-function-type-strict for the "report all the
>> same casts that the sanitizer does". gcc doesn't I think have
>> that yet. I didn't spot any option in the sanitizer to
>> loosen the set of things it considers mismatched function
>> pointers.
> 
> I just tried that with
> 
> CC=clang ./configure --target-list=x86_64-softmmu --extra-cflags="-Wcast-function-type-strict"  --disable-werror
> 
> and it rather shows the futility of the task, picking one reoprted
> warning that is repeated over & over in differnt contexts:
> 
> In file included from qapi/qapi-types-block-core.c:15:
> qapi/qapi-types-block-core.h:3620:1: warning: cast from 'void (*)(DummyBlockCoreForceArrays *)' (aka 'void (*)(struct DummyBlockCoreForceArrays *)') to 'void (*)(void)' converts to incompatible function type [-Wcast-function-type-strict]
>   3620 | G_DEFINE_AUTOPTR_CLEANUP_FUNC(DummyBlockCoreForceArrays, qapi_free_DummyBlockCoreForceArrays)
>        | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/include/glib-2.0/glib/gmacros.h:1372:3: note: expanded from macro 'G_DEFINE_AUTOPTR_CLEANUP_FUNC'
>   1372 |   _GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS(TypeName, TypeName, func)
>        |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /usr/include/glib-2.0/glib/gmacros.h:1364:57: note: expanded from macro '_GLIB_DEFINE_AUTOPTR_CLEANUP_FUNCS'
>   1364 |     { if (*_q) g_queue_free_full (*_q, (GDestroyNotify) (void(*)(void)) cleanup); }                             \
>        |                                                         ^~~~~~~~~~~~~~~~~~~~~~~
> 
> 
> IOW, the GLib headers themselves have bad casts in macros which we
> rely on.  So we'll never be cast safe until GLib changes its own
> code...if it ever does.

Ok, thanks for checking! So the ultimate answer to the problem (at least 
right now) is: Let's use -fno-sanitize=function in QEMU.

  Thomas



