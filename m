Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7507C47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 06:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVQhW-0008Lw-U9; Thu, 01 Feb 2024 01:37:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rVQhV-0008LY-AN
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 01:37:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rVQhT-0000bn-R6
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 01:37:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706769445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=f0HWPLXwxlaOsHo6F4fJ+TichknKlUWhydNPvBI+eag=;
 b=b4oLZ0l4ylp9GXjRgSNuQxR3XIo1XvO42wUd4SdDzP8R/lGL0CpxtjFS8/BVu7NRlF6ssz
 ws2cNvRUuk6SyTLui7XqKuetdezIeQX2iUfFSwBtJ1PVdw3qqd2H7l5LXpsRV/Znnbm/cC
 NVfBKAQ99CXLxYFPjGkZLoGtUg7K858=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-bTTUsyB2PrOHGBbyyadp1g-1; Thu, 01 Feb 2024 01:37:24 -0500
X-MC-Unique: bTTUsyB2PrOHGBbyyadp1g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40fb9d0cfb7so2535855e9.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 22:37:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706769443; x=1707374243;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f0HWPLXwxlaOsHo6F4fJ+TichknKlUWhydNPvBI+eag=;
 b=k1lxkTlYQKyWAFdSc/4Uq0HhkRkHEwEs3dwLdgJzNcHmBayXflG5zFpPThAN6q3m3J
 qpNZTL6SLYDPQeR3CSpROKDiuDb0n5EgDSYgEnRUkakNK3S825B8Nx6OAcuVFLJelJJC
 PW5CbSh2x+R3w2/FtGaz8A5c/eucnsHYNh2d/r9KBZXMr1neWQmu07D01IV5n3ryb4dq
 K7A4MFHi+rCsmxlUWxYKfVShUGgdUyAkFyKR0KxsKVp9/Wc3IcMHcPwISE0anPSizxkv
 7EIlNISAD///PXJmfJh08JZn+QWdQ0D5w61fL7uQzUxCrJZrnOjB9/V+jblM7y8A2XSe
 V6Zg==
X-Gm-Message-State: AOJu0YzsLBC1N7AZ42PLohPuWItRPKfzEbZbdlJ2jDowrEQiNEfJg4iT
 RkZEkF/gSxuH/3KjEJobaciMM3bNmdJpUM0lKvr8FbdXoMYl7z+fxQR+Lt7yqj93brgYxrHtJj4
 9gOwaAVV9EmSNF4BOhSACsts/j/5HCfAJZcDZtvU+EiXoNS2xYQqX
X-Received: by 2002:a05:600c:1549:b0:40e:ac4f:7156 with SMTP id
 f9-20020a05600c154900b0040eac4f7156mr2710728wmg.5.1706769443226; 
 Wed, 31 Jan 2024 22:37:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbzzCw7wM4N2a2nmg5xAbQJVh7rTYcnP63p1jfcc+D5oFBo7hOgFTbJRBqyCzhpwbfr8Irww==
X-Received: by 2002:a05:600c:1549:b0:40e:ac4f:7156 with SMTP id
 f9-20020a05600c154900b0040eac4f7156mr2710718wmg.5.1706769442954; 
 Wed, 31 Jan 2024 22:37:22 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-177-196.web.vodafone.de.
 [109.43.177.196]) by smtp.gmail.com with ESMTPSA id
 k38-20020a05600c1ca600b0040e5945307esm3485266wms.40.2024.01.31.22.37.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jan 2024 22:37:22 -0800 (PST)
Message-ID: <01f5fb2d-28fa-484e-93b2-be49e42d4ec4@redhat.com>
Date: Thu, 1 Feb 2024 07:37:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] tests/tcg/s390x: Test CONVERT TO BINARY
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
References: <20240131230938.325919-1-iii@linux.ibm.com>
 <20240131230938.325919-5-iii@linux.ibm.com>
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
In-Reply-To: <20240131230938.325919-5-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 01/02/2024 00.07, Ilya Leoshkevich wrote:
> Check the CVB's and CVBG's corner cases.
> 
> Co-developed-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tests/tcg/s390x/Makefile.target |  1 +
>   tests/tcg/s390x/cvb.c           | 47 +++++++++++++++++++++++++++++++++
>   2 files changed, 48 insertions(+)
>   create mode 100644 tests/tcg/s390x/cvb.c
> 
> diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
> index 04e4bddd83d..e2aba2ec274 100644
> --- a/tests/tcg/s390x/Makefile.target
> +++ b/tests/tcg/s390x/Makefile.target
> @@ -46,6 +46,7 @@ TESTS+=laalg
>   TESTS+=add-logical-with-carry
>   TESTS+=lae
>   TESTS+=cvd
> +TESTS+=cvb
>   
>   cdsg: CFLAGS+=-pthread
>   cdsg: LDFLAGS+=-pthread
> diff --git a/tests/tcg/s390x/cvb.c b/tests/tcg/s390x/cvb.c
> new file mode 100644
> index 00000000000..47b7a7965f4
> --- /dev/null
> +++ b/tests/tcg/s390x/cvb.c
> @@ -0,0 +1,47 @@
> +/*
> + * Test the CONVERT TO DECIMAL instruction.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include <assert.h>
> +#include <stdint.h>
> +#include <stdlib.h>
> +
> +static int32_t cvb(uint64_t x)
> +{
> +    uint32_t ret;
> +
> +    asm("cvb %[ret],%[x]" : [ret] "=r" (ret) : [x] "R" (x));
> +
> +    return ret;
> +}
> +
> +static int64_t cvbg(__uint128_t x)
> +{
> +    int64_t ret;
> +
> +    asm("cvbg %[ret],%[x]" : [ret] "=r" (ret) : [x] "T" (x));
> +
> +    return ret;
> +}
> +
> +int main(void)
> +{
> +    __uint128_t m = (((__uint128_t)0x9223372036854775) << 16) | 0x8070;
> +
> +    assert(cvb(0xc) == 0);
> +    assert(cvb(0x1c) == 1);
> +    assert(cvb(0x25594c) == 25594);
> +    assert(cvb(0x1d) == -1);
> +    assert(cvb(0x2147483647c) == 0x7fffffff);
> +    assert(cvb(0x2147483647d) == -0x7fffffff);
> +
> +    assert(cvbg(0xc) == 0);
> +    assert(cvbg(0x1c) == 1);
> +    assert(cvbg(0x25594c) == 25594);
> +    assert(cvbg(0x1d) == -1);
> +    assert(cvbg(m | 0xc) == 0x7fffffffffffffff);
> +    assert(cvbg(m | 0xd) == -0x7fffffffffffffff);
> +
> +    return EXIT_SUCCESS;
> +}

Reviewed-by: Thomas Huth <thuth@redhat.com>


