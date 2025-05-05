Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F1CC3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 10:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBt7h-00040v-A4; Mon, 05 May 2025 06:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uBt7e-0003vs-VC
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:32:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uBt7d-0002Di-5m
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746441148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=U95sJgWM05MANjMDloUPTr2wmup9bauuy1bE832hTUY=;
 b=W4wBiQSEqfRftHifVe41oSdFK8vjIBhP0dHvbahac6RpiGBhJOCZ9x51MWphtQct6T0386
 Su1Y3vDuluPxeONmuajo4UmcfadMI/3xyYufAh71ErzPXbdMSpKDqYr7WPxmwXB3Mx5eE4
 zcxHFNw9RxZRx+UibEaC2mKxHbeIMOE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-KH3Ex4YhMk26USnBdq9eaA-1; Mon, 05 May 2025 06:32:27 -0400
X-MC-Unique: KH3Ex4YhMk26USnBdq9eaA-1
X-Mimecast-MFC-AGG-ID: KH3Ex4YhMk26USnBdq9eaA_1746441146
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-391315098b2so1252526f8f.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 03:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746441146; x=1747045946;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U95sJgWM05MANjMDloUPTr2wmup9bauuy1bE832hTUY=;
 b=Vx+AEkD6TAQn1L4pYYW1YPJFK109RO/Xtzlw20aJwMjYm5BBM2cD82F0e+23LowJoO
 zQsHpqnzP0tzZScAvDJvS8qSo9BAulm0FajHeN6s4up3BYby86DI/Njkh1zMqOLNVyVF
 G3/ArYrXakW0bYu/ot5LbaVp7y2OX46ZmgSzZEIl5DraWkm1P0doScXjbd0TXIWTESkZ
 cCrSKCQTFz9gg5Uv87Qn0rI7+oLAlhLaKB62GwgoN4YZMyarNiq3JIlvVRuE/IgHjW/+
 wmnoRIFVY8dZAYm/MsXw2bbgUZndfAI46DXjRdawn5/rKLudl8t2UDIwpZSKyDC74y5Q
 aMEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ+UUaPKLuIcP+042sP6uE4WU3SryLS4591iIJu+eETKPch4TmpLV1vt/rXRUga3tzfVvr0EJCDjxz@nongnu.org
X-Gm-Message-State: AOJu0YwMbqKaz4CyzZV1JLFErv/M1cKHlWumKaA9sLkVrUHWSsOhpeOs
 /drByNoCziY/VxhlaCpX9q3rERBbv+R5lBhVzJUAirt0IxwgSN7m7+LCh7O3bijoojKZqDBJgQy
 phugbjZjS39xo6Pqv/NYoWZugHdPNwc/7cXxqu57EAKg2e/eJyRAC
X-Gm-Gg: ASbGnct3hJH17KcyBUEjjcUG2N0/7ufarZapT8+MpI1Cn6vYhzyFE0En4mEmUL1qO5y
 oYB/UUxj3zq+ZMOoHI1cCXm3DghBJvh0LV+39iXduLQQwIsMFyvtSeSTpROxU6XdEniHo8DyPXQ
 UD32XlfvnlSNGi4kKKArADp2s45Gh4KqcVWOw4ONBuePi3m3RUBMdAKAC5a9PXGqfE902E9l9d9
 i2mOhyBonb5PC2HzZnVuhICUl8lJVFM3KgfxozHmCcMDQNJEMX5+gj44LrNo1KfOxNQnNR+ot91
 nHbP0MJ3c0AyjSRcuz+/vxDUlx9Y4XckJlZ+MRjL
X-Received: by 2002:a05:6000:4387:b0:390:df75:ddc4 with SMTP id
 ffacd0b85a97d-3a09fdbc112mr5706147f8f.44.1746441145892; 
 Mon, 05 May 2025 03:32:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4oi8zdGUTPEp5eiFZx1SK/MpEM0MAZkK/Ho4Ebcp2uDHfS8pPlpFER+aksYoJoTXC8jhpKQ==
X-Received: by 2002:a05:6000:4387:b0:390:df75:ddc4 with SMTP id
 ffacd0b85a97d-3a09fdbc112mr5706127f8f.44.1746441145515; 
 Mon, 05 May 2025 03:32:25 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-87.web.vodafone.de. [109.42.49.87])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099b17074sm10156696f8f.95.2025.05.05.03.32.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 03:32:25 -0700 (PDT)
Message-ID: <f7da46dd-0e8f-42d8-b555-300c088f605e@redhat.com>
Date: Mon, 5 May 2025 12:32:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: use thorough test setup as default
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250503201806.3045723-1-pierrick.bouvier@linaro.org>
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
In-Reply-To: <20250503201806.3045723-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 03/05/2025 22.18, Pierrick Bouvier wrote:
> Allows all tests to be visible by default when using meson test
> directly.
> 
> This has no impact on make check-* commands, which use SPEED=quick by
> default (see scripts/mtest2make.py).
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   meson.build | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index f8bf6e7bb66..57ff3f722d8 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -5,12 +5,13 @@ project('qemu', ['c'], meson_version: '>=1.5.0',
>   
>   meson.add_devenv({ 'MESON_BUILD_ROOT' : meson.project_build_root() })
>   
> -add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_default: true,
> +add_test_setup('quick', exclude_suites: ['slow', 'thorough'],
>                  env: ['RUST_BACKTRACE=1'])
>   add_test_setup('slow', exclude_suites: ['thorough'],
>                  env: ['G_TEST_SLOW=1', 'SPEED=slow', 'RUST_BACKTRACE=1'])
>   add_test_setup('thorough',
> -               env: ['G_TEST_SLOW=1', 'SPEED=thorough', 'RUST_BACKTRACE=1'])
> +               env: ['G_TEST_SLOW=1', 'SPEED=thorough', 'RUST_BACKTRACE=1'],
> +               is_default: true)

I'd rather not make it the default: The thorough functional tests download a 
lot of assets from the internet, so if someone just runs "meson test" 
without further parameters, I think we should not trigger these downloads in 
that case.

  Thomas


