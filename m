Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A2BCEF17A
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 14:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syB1C-0000Pu-4M; Tue, 08 Oct 2024 10:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1syB1A-0000Pf-IA
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:16:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1syB17-00088G-Q3
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728397008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dPdfNz098aSK0DFWyt/wKu1/+aVFLrm55RwsNq4kUNA=;
 b=Kuf991VkuCylGjdlbA0Kr2tsIPXQ9Hpsx7Bgm+qrrLRZo/D0LwB9boGnhcT7Bxr7qqk+H6
 ctOa8S70IMai6NfA330jfM0C7tRdXknJvfw9RdyGSx39sytjgd9nY81WeQGJ5SLkfB+Oba
 CMNdOJ1JPoHgq/CqCPhPtRKF486Uau0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-z2kIcfexN_yWgSQ4MUYomg-1; Tue, 08 Oct 2024 10:16:46 -0400
X-MC-Unique: z2kIcfexN_yWgSQ4MUYomg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a994d8d6003so104249166b.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 07:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728397005; x=1729001805;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dPdfNz098aSK0DFWyt/wKu1/+aVFLrm55RwsNq4kUNA=;
 b=wNpc7d1oeRN79exEEjIDOC6dKF4LwSKyui+ja3vl+en36SUpW7MkcS573Xh/C91jpw
 b7gt9e1vE7RRnAikR1zEsOTMkwWw9Mjng4JVkonrIoPKYN8jQImutzA+tbkHJ2M8ciX9
 0R4Dt/h8Ie98dH+f/GofM1b6qvFIpEZpq1fiiDxr6qDq27jxZiMr3/Q0eLWYyOPvEtnL
 IyB2hQJcQpWc1xKcxgPPGMKfrvh1IHJYktfilOHuwpMHpUVdDo3B/OPSg5/kIATi8cri
 oLC1PqnY0Nn+GhPB3pX9XpAhGHSdeI0LjUmIjoWOnQSUTs2VrUUD70G1diAM9s79StII
 F7tA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsZ1MKbhYdt7O3WG0YSD7Y25S45rcUOc63Zzr+nutC48y+gVcNrGFXyKHFJRJDqy+m3JhXhQueeLnc@nongnu.org
X-Gm-Message-State: AOJu0YzY8KmotITsOuBUM+rPJLo5l+nPulb2QCsqi62jVNlFlTXE7ykZ
 YCjjNksValWfJ83QMUlAuJNIVMOGXGBB7G2oFrrI8oouZSZlahDdefy9DptKbZOsaiKjuhoRe2/
 qlni5OHjbIjF6vDF7EiOqYMHvgIDxaXCk2ie5PxUN+oyzlsLhNkE+LePAqnUpV/Q=
X-Received: by 2002:a05:6402:27c9:b0:5c8:9529:1b59 with SMTP id
 4fb4d7f45d1cf-5c8d2e48716mr18626408a12.20.1728397004832; 
 Tue, 08 Oct 2024 07:16:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFO+4uoY6TxbPfJwtTXuGC4LFI5Us0oSR3ccwY/iCuujLsB/jnD58iZUxl26/+zUoFZYEO6wQ==
X-Received: by 2002:a05:6402:27c9:b0:5c8:9529:1b59 with SMTP id
 4fb4d7f45d1cf-5c8d2e48716mr18626373a12.20.1728397004274; 
 Tue, 08 Oct 2024 07:16:44 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-26.web.vodafone.de. [109.42.51.26])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c8e05940a6sm4380570a12.1.2024.10.08.07.16.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2024 07:16:43 -0700 (PDT)
Message-ID: <5f6f6e20-988e-4455-bb76-34416463c930@redhat.com>
Date: Tue, 8 Oct 2024 16:16:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest: Bump qmp-cmd-test timeout to 120s
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241008141337.2790423-1-peter.maydell@linaro.org>
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
In-Reply-To: <20241008141337.2790423-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 08/10/2024 16.13, Peter Maydell wrote:
> The qmp-cmd-test test takes typically about 15s on my local machine.
> On the k8s runners it takes usually 20s but sometimes about 60s,
> because the k8s runners have wildly variable execution time.  If
> they're running slow, we hit the default timeout.  Bump the
> qmp-cmd-test timeout to 120s to avoid this.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/qtest/meson.build | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 2b90abf0007..b207e386965 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -7,6 +7,7 @@ slow_qtests = {
>     'migration-test' : 480,
>     'npcm7xx_pwm-test': 300,
>     'npcm7xx_watchdog_timer-test': 120,
> +  'qmp-cmd-test' : 120,
>     'qom-test' : 900,
>     'stm32l4x5_usart-test' : 600,
>     'test-hmp' : 240,

Reviewed-by: Thomas Huth <thuth@redhat.com>


