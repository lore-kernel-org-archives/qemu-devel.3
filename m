Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C095D735F8
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2024 10:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHKGn-0001W0-KG; Sat, 30 Nov 2024 05:00:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tHKGk-0001Uc-Pw
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 05:00:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tHKGj-0000wH-44
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 05:00:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732960802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5H9MczYwI5N2ZfSxLXvjJtZrOYiTZnYvOSslVprutvo=;
 b=OeuBnwManwBOI5oFY5aOE4zOiTUoswHA7NCuVv6wKriMPk6FgSh1wGGUMD83W+aPbT2arq
 +3i92lfA0SMTRtK+ODGhaDCCup1Z/shXxGLKsBcZRwL8teKNW24yDd05XHFWaJmIBjA7sm
 YBZBtbCossQeW8Y0QmUxNjOYT+GpgJA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-di91bJqzO9umlhbnM48Jkg-1; Sat, 30 Nov 2024 04:59:58 -0500
X-MC-Unique: di91bJqzO9umlhbnM48Jkg-1
X-Mimecast-MFC-AGG-ID: di91bJqzO9umlhbnM48Jkg
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5d0c9402f82so404824a12.3
 for <qemu-devel@nongnu.org>; Sat, 30 Nov 2024 01:59:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732960797; x=1733565597;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5H9MczYwI5N2ZfSxLXvjJtZrOYiTZnYvOSslVprutvo=;
 b=H1qa5NpBNJ6IS/leYfcHcVYJBp4NV+tJx8zwiG90+2i3dQ/XPtQQYC36MMjdBLWcXh
 GoLtBXUXPZ8ZBx0JpmjHmcdcDXHwamIW1/hqgRTwApOCm/I336Ab/tJpTJZJdvPxUi5Q
 099N+KzKNlj+eO59QFQPUWaD2T2WYDYPnczMmS2FTwxtie06lAr5zgQzTLEyK/MNvtLG
 S+DALwosamJMdZddu0aKpPxnSZPk5GWfFtQuY8FnXmzZoiG47gCPA9w/lSRXNBP3HpER
 cPF4lzt5IvHxNHspS/B4zJ8Y/gkP/o8cK4M80NF9UbWrf1Dw7NTVco6VXueuR/MmpQxX
 dC2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpKQa9iPDX4/hPp7eDCznU1FKbdKylv8kIMRurRSWJFccLi1p79odi+L8pZwixUpZbhC9mSqc1ckxR@nongnu.org
X-Gm-Message-State: AOJu0YyRnFE/9kP+jxMsRpp53FJmApuiNycnyJZbhuWDH2HdvGdtR2da
 TPIT3c0tiE5hU2ZV1xagPMONiWahhZjC5WwM2lV7dzeaM/FWtjbwZ0ApMJE34qZoRJjm5E0Jsnq
 eoohYm+jX2+Rqo/3Q17c3dZ+lMvtzyvLUPj3k0NlNCIUoS2uGwta2
X-Gm-Gg: ASbGncuPs9yqbRC9etAYVZMQdkqEKKf9KTqWWp4EY0XfQRBeVjfEP9xEA6XNlHZ0Vqw
 SO0geUFBz1sQ4HV2Lum0gDyPhbguF0eMwBoMH7lYxS2VzeIkIycGseIreIczTjL7hDS+tM+EuyT
 EWtoBYvzug/VavIBQru7+8OLPNF1txXK4iBB5CxG3wak2CxBXy5IXZVN/yBqMKeok/CMI+X+5bu
 UKnf0nAk2Cct9Zq9h2woluxfYLMF4JHVoamEIAqH1vAHzT36RihbmJxjTTut1/NOr2FopVOFuQ4
 VpUuYg==
X-Received: by 2002:a17:906:32c2:b0:aa5:37b4:cd60 with SMTP id
 a640c23a62f3a-aa580ef0df5mr1128411766b.6.1732960797298; 
 Sat, 30 Nov 2024 01:59:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqWJ/AiJ5o4DsdemryVa3tJw4iPLIh5WmkhDRfh/kgnnsDQtvj6D/pZJaP3F59AEwONUD6BA==
X-Received: by 2002:a17:906:32c2:b0:aa5:37b4:cd60 with SMTP id
 a640c23a62f3a-aa580ef0df5mr1128410866b.6.1732960796950; 
 Sat, 30 Nov 2024 01:59:56 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-143.web.vodafone.de.
 [109.42.48.143]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa5996c192fsm267812666b.27.2024.11.30.01.59.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Nov 2024 01:59:56 -0800 (PST)
Message-ID: <c854cfed-137e-46ba-bb1c-393f3bed685c@redhat.com>
Date: Sat, 30 Nov 2024 10:59:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/22] tests/functional: remove unused system imports
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20241129173120.761728-1-berrange@redhat.com>
 <20241129173120.761728-3-berrange@redhat.com>
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
In-Reply-To: <20241129173120.761728-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
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

On 29/11/2024 18.31, Daniel P. Berrangé wrote:
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/test_aarch64_sbsaref.py       | 1 -
>   tests/functional/test_acpi_bits.py             | 1 -
>   tests/functional/test_m68k_mcf5208evb.py       | 2 --
>   tests/functional/test_microblaze_s3adsp1800.py | 1 -
>   tests/functional/test_mips64el_loongson3v.py   | 1 -
>   tests/functional/test_or1k_sim.py              | 2 --
>   tests/functional/test_s390x_topology.py        | 1 -
>   tests/functional/test_sh4_tuxrun.py            | 4 ----
>   tests/functional/test_sh4eb_r2d.py             | 1 -
>   tests/functional/test_virtio_version.py        | 2 --
>   10 files changed, 16 deletions(-)

Out of curiosity: Is there a way to check for this with a program, or did 
you check it manually?

Reviewed-by: Thomas Huth <thuth@redhat.com>


