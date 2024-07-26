Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4153C3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 09:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXGzR-0004jF-QL; Fri, 26 Jul 2024 05:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sXGzQ-0004gi-6Y
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 05:11:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sXGzN-0000bE-H7
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 05:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721985108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CvwMkeS7ov9fmMaYQzB8CI6TOqND9kALCmv+oilXh04=;
 b=L0TYJHTYpe339QfZ3CafbTEPg6ajYfdW3KKAVPzcAEwxLlHYqFo0X92vfuvxybapr9Gjlb
 8izAyWImFmnT+V5a0sGRWTAlbawKFGD/8gvwhl0vzDJbrVvCx2yBKYlBd9noH3rTKGVFCg
 Vi/kKUUt9nQKMVAPulfW11qRFvIUidU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-4qxq6TMmML2msHjkCUjOrQ-1; Fri, 26 Jul 2024 05:11:46 -0400
X-MC-Unique: 4qxq6TMmML2msHjkCUjOrQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4280805bc0fso9989895e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 02:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721985105; x=1722589905;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CvwMkeS7ov9fmMaYQzB8CI6TOqND9kALCmv+oilXh04=;
 b=UsJycl0I0UmnpeIr3t14Y272MOvO0sNT0/n7cGAX0N5/VxX97R3XLCXMGBH9ceVMsG
 D8MvpiAA56gQDrOKqrHyp0/RmuFUV0L623RGrMxQpGI+Xkuf4L7OMecJ0FS+WHRd1dw4
 ztjNzhsRZ0FJ5E2mjv0i4QdAso5Jh7tsTj604KMzxCMhwmHxGU7EAo+Bvmj5I9zjhjxc
 GcQFzqlm8GLFX6A4KXYXewvg817X7Jm4NcUgsoe1og5UHWdj6XwWSd4bxyC6RpdyZJrC
 6jMC/B7bVkusIt7ljjuvrV6IYRxdUPx7bUUundbQu9v5LuITo/dR0wkqVXtoaXqzSZOb
 MpRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQ38MCD5wV0vBUPlgqxxH4wM9M8UGz3VXl8LVPeFtTXFCs8ONEtffYHH38HRwR4gtJTJSf5MOxGswnolysixhR2QiNn60=
X-Gm-Message-State: AOJu0YzndqITzMDib1xjWUlXuA+yvzrYLU0GapgicSq5nGfBBO2vgNsc
 lEbNUqIDGnQMlhUmipLd2E09CDgeAscxdjhyMCFt7QiLhP+A3lPrYs3VNX+BL0IMIAofUNSvrT8
 o/DphkJVt7LyXLISgaBZZwRktW0C2V3LaVAruKBt6W9tvoxm+r0Ry
X-Received: by 2002:a05:600c:4443:b0:426:5ad9:e1a2 with SMTP id
 5b1f17b1804b1-4280570809dmr37043385e9.9.1721985105319; 
 Fri, 26 Jul 2024 02:11:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMzfB3lFDerj03cXnaVFbsdCVbeetrWWHxZ4Ft6rFCo7OOaf2hWZrOF8cTDR7FO4h9/q7SOA==
X-Received: by 2002:a05:600c:4443:b0:426:5ad9:e1a2 with SMTP id
 5b1f17b1804b1-4280570809dmr37043215e9.9.1721985104914; 
 Fri, 26 Jul 2024 02:11:44 -0700 (PDT)
Received: from [10.33.192.191] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42809e4423dsm32245065e9.13.2024.07.26.02.11.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jul 2024 02:11:44 -0700 (PDT)
Message-ID: <3919ac75-1cce-4fad-a0eb-4ec11865c011@redhat.com>
Date: Fri, 26 Jul 2024 11:11:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/tcg: Skip failing ppc64 multi-threaded tests
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240725154003.428065-1-npiggin@gmail.com>
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
In-Reply-To: <20240725154003.428065-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 25/07/2024 17.40, Nicholas Piggin wrote:
> In Gitlab CI, some ppc64 multi-threaded tcg tests crash when run in the
> clang-user job with an assertion failure in glibc that seems to
> indicate corruption:
> 
>    signals: allocatestack.c:223: allocate_stack:
>      Assertion `powerof2 (pagesize_m1 + 1)' failed.
> 
> Disable these tests for now.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   tests/tcg/ppc64/Makefile.target | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/tests/tcg/ppc64/Makefile.target b/tests/tcg/ppc64/Makefile.target
> index 8c3e4e4038..509a20be2b 100644
> --- a/tests/tcg/ppc64/Makefile.target
> +++ b/tests/tcg/ppc64/Makefile.target
> @@ -11,6 +11,18 @@ config-cc.mak: Makefile
>   
>   -include config-cc.mak
>   
> +# multi-threaded tests are known to fail (e.g., clang-user CI job)
> +# See: https://gitlab.com/qemu-project/qemu/-/issues/2456
> +run-signals: signals
> +	$(call skip-test, $<, "BROKEN (flaky with clang) ")
> +run-plugin-signals-with-%:
> +	$(call skip-test, $<, "BROKEN (flaky with clang) ")
> +
> +run-threadcount: threadcount
> +	$(call skip-test, $<, "BROKEN (flaky with clang) ")
> +run-plugin-threadcount-with-%:
> +	$(call skip-test, $<, "BROKEN (flaky with clang) ")
> +
>   ifneq ($(CROSS_CC_HAS_POWER8_VECTOR),)
>   PPC64_TESTS=bcdsub non_signalling_xscv
>   endif

Could you please check whether this is already fixed by Richard's patch:

  https://gitlab.com/qemu-project/qemu/-/commit/8e466dd092469e5ab0f355775c57

?

  Thanks,
   Thomas


