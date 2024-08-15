Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30433C52D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 08:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seVaW-0007Hj-2i; Thu, 15 Aug 2024 04:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1seVaU-0007Dr-Ko
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 04:12:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1seVaT-0002QI-1d
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 04:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723709519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=F1UzcRGOHac+9cr0BFH9tSjolQG7Qmvqxq+/xXEjxgA=;
 b=d8UTwFoH/ics0J0FkfNe7SKoopOtqHcG+9YniMyXXCADmdg4sK3Mqpyz4IPOIkzLFIDnPC
 YfNCYWi3yuoBRP9D0V1DUPW/IFM0hFF7sFK92ZslmhiUspWTwpjHS4dqolamzijrTEVq96
 UpRHO6sbsQo5aHMP9MJsJg6Pt8XUAyY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-yUPRF7RnMDi7KYq4lqDgNA-1; Thu, 15 Aug 2024 04:11:56 -0400
X-MC-Unique: yUPRF7RnMDi7KYq4lqDgNA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a7a97665b8bso71845266b.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 01:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723709515; x=1724314315;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F1UzcRGOHac+9cr0BFH9tSjolQG7Qmvqxq+/xXEjxgA=;
 b=DhwO3w7pxVRUY7IIgBLHXk3lFdVYHjB1f46QDLU3io+rtEkMIqVJTPyXt/5L1T1htD
 AUP2lms64Eoo7kl/YdArX0OusRz6mKz7AB2EOXebItmCzPf2xp5LWiBlFr/1qYAuptqZ
 y8DYayn/jgTsCklkjlvgmNPpm5KcHZrtyaePYFytumIp3lR8rZZAvqnqyHdNzBGmXKSw
 y3UgRtB2PlvVkK0p6N3Hq6FZnF2zzm3V/mNsjTryzj31HX8iFPktV6UeL7t7OTjVJIr8
 CFy+vpvGzAb53chqtyOEYVtPJ+tpWoUiKV0sFkPK4j22/Z/8VHdaqqG7cMstEGqowdrI
 AwxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu4odh/H17l1oGeX3eVf26WPPbUeYLm79nUB3zgfa6OqoLlwdHQXAjuH5MwLcr7nl4qC6HjgGLvsRq7BcWe4XVTbFAcd0=
X-Gm-Message-State: AOJu0Yx2MTnfDH9hX9uufcIfEGa6eqCj3zUXhIhw3yBW2AWsrtjMxHK8
 fzfx2Dl08Q1YXKlOVBtz1q1ErPJXkglv1Sa11iuq6gmRShkPwc9VmV+sjUzNjOSZApJhpKH4DLe
 2V4/q+UpsJNeQLHDmGc+bFk/48GQdudNMNps6cvwI0kEXjJ+bOhNb
X-Received: by 2002:a17:907:a0c8:b0:a80:f81c:fd75 with SMTP id
 a640c23a62f3a-a83663f73e1mr278116766b.0.1723709515182; 
 Thu, 15 Aug 2024 01:11:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3ZRKrGQoEwCKmhv38n1w1JKKEdBIKA/nRR4qpEH78rK6JbYC0COb3CDvAuafvLXQSuTEqGQ==
X-Received: by 2002:a17:907:a0c8:b0:a80:f81c:fd75 with SMTP id
 a640c23a62f3a-a83663f73e1mr278114666b.0.1723709514634; 
 Thu, 15 Aug 2024 01:11:54 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-177-15.web.vodafone.de.
 [109.43.177.15]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a838396d4b2sm63317366b.220.2024.08.15.01.11.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 01:11:54 -0700 (PDT)
Message-ID: <491b34f6-a81a-4793-984c-6a588910d0e1@redhat.com>
Date: Thu, 15 Aug 2024 10:11:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] contrib/plugins/cache: fix warning when compiling on
 32bits host
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
 <20240814233645.944327-3-pierrick.bouvier@linaro.org>
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
In-Reply-To: <20240814233645.944327-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.135,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 15/08/2024 01.36, Pierrick Bouvier wrote:
> Found on debian stable (i386).
> 
> ../contrib/plugins/cache.c: In function 'vcpu_tb_trans':
> ../contrib/plugins/cache.c:477:30: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>    477 |             effective_addr = (uint64_t) qemu_plugin_insn_haddr(insn);
>        |
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   contrib/plugins/cache.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
> index 512ef6776b7..82ed734d6d4 100644
> --- a/contrib/plugins/cache.c
> +++ b/contrib/plugins/cache.c
> @@ -471,12 +471,12 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>       n_insns = qemu_plugin_tb_n_insns(tb);
>       for (i = 0; i < n_insns; i++) {
>           struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
> -        uint64_t effective_addr;
> +        uintptr_t effective_addr;
>   
>           if (sys) {
> -            effective_addr = (uint64_t) qemu_plugin_insn_haddr(insn);
> +            effective_addr = (uintptr_t) qemu_plugin_insn_haddr(insn);
>           } else {
> -            effective_addr = (uint64_t) qemu_plugin_insn_vaddr(insn);
> +            effective_addr = (uintptr_t) qemu_plugin_insn_vaddr(insn);
>           }

Is this the right fix? I assume effective_addr stores an address of the 
guest, so if the guest is 64-bit and the host is 32-bit, you now lose the 
upper bits of the address...?

The casting for qemu_plugin_insn_vaddr is not required at all since it 
already returns an uint64_t, so you can remoe that one. For the haddr part, 
maybe do a double-cast:

   effective_addr = (uint64_t)(uintptr_t)qemu_plugin_insn_haddr(insn)

?

  Thomas


