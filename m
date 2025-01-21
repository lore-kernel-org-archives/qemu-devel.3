Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA48CC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 12:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taDk6-0007Xr-KC; Tue, 21 Jan 2025 07:52:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1taDk1-0007OE-MJ
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 07:52:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1taDjz-0005WH-FI
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 07:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737463941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=z35EzCDbc+CQYTWls//bFZ6X+OXu42ZALVtSrwU0u+M=;
 b=iY1qOnVwPuCjlh7EIsIoqICgDY11WAKlS+llqfUGclL2y3ZXHWCACAAOUMrhLv425JfVCJ
 ThxjOuqDDl5nBlHNv5+WWrsueDRPot/mkJfq/lwUY6AoCvKa2qYbaLybIwIxEEF9nM6tbZ
 Mrpv7d3owpyG+Pv/FVm0u967isI5y8g=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-8F07i15CPuOhsqXW5WzboA-1; Tue, 21 Jan 2025 07:52:19 -0500
X-MC-Unique: 8F07i15CPuOhsqXW5WzboA-1
X-Mimecast-MFC-AGG-ID: 8F07i15CPuOhsqXW5WzboA
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6df9ac8dcbeso197251476d6.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 04:52:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737463939; x=1738068739;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z35EzCDbc+CQYTWls//bFZ6X+OXu42ZALVtSrwU0u+M=;
 b=RBrWZKFRvM9okRCSVd0ksRm9w2EO7GJu8H5+jEBQUT5WtIxaQdu73kFIfJZmLBSQrt
 Bixo2tkg3VWqHpjwOSkSni4DuwTGogaroFYhM01YVVSVStE/ioXW8j2n3HO5NHzxPEVD
 oyDU9Anntr6QUCUVuTKdlaxk0uRi6VdOaFImHG3pj2xeJtzi26sG8SOmoGz9Y3LWIajC
 m66jZAJ6tk9LsVVvs7qG5Q4e0Qv9PdOBHsXGh8euHGV1fDNL9eVL4GwqM5thExsBa0z1
 pe9BuHxeYddQ9cimbFZPu1QqPCggzmKhdjSi7jAjuitaIgcHYljml7yR65UvBkguK5pu
 /pBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHIblnZk9RwcNITXJ0GcwiHfl2VgXsiByx+iWgCIP75UzoscrKIYXnHLdB7C/HJf0E9PwOYHsahbxF@nongnu.org
X-Gm-Message-State: AOJu0YzL7/2bAEcCsbZR7Qg2SlhXXz0k1GJmvjek7lmUWxKuU5bmv/td
 yKGIb4Sb0vklcoTbwBRKqXSiATQnGH9hpP9dfcOTrbhZIheaoiM2UKsrnE2YOSJskiHfZgBeesQ
 7e5pckwbJcfNRG2ObPqyosa/mC3yML0gKH2KDOXi9H7g5CO01jebW
X-Gm-Gg: ASbGnctn0lVZi5JR0fINxELlf0Ycki2jZ0LVyVxNB6+ZBpVFe49xwwUXjL2oG6uqP0B
 W2JYt+8YnMRiSC6U3YGvWZPLdZOQM5A5fSxh03P2KeWWvnlvD9UfYOS4bdHbHSE/51lB6poTnF2
 f4jRlRIT4apdwKiRHGV+gWD/gTWoX42eO51V3qlNUdPgePG3rcjnccgfcVLcq6R+ljCQ/Sjb+Vf
 7ktgWiYhaSnV+RUGjl2o30+TdQ5TWN4FE86E5FDlZQFEJfjQgJomav5+tViYoAgqh/Kn4xjHJDh
 bnNYanEXqk8feh2R0ofDffNsIw==
X-Received: by 2002:a05:6214:23ce:b0:6d9:3016:d10d with SMTP id
 6a1803df08f44-6e1b2230a18mr298634016d6.42.1737463939047; 
 Tue, 21 Jan 2025 04:52:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuOxuhvjsQz1BkN5BlN8oKR1FqpydPkU1t80xxOUh8Kw9gcKDxCEHMx/UvlQcR02AQFuik1A==
X-Received: by 2002:a05:6214:23ce:b0:6d9:3016:d10d with SMTP id
 6a1803df08f44-6e1b2230a18mr298633656d6.42.1737463938753; 
 Tue, 21 Jan 2025 04:52:18 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-103.web.vodafone.de.
 [109.42.48.103]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afcd66c2sm50828556d6.75.2025.01.21.04.52.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 04:52:18 -0800 (PST)
Message-ID: <503fe36f-c0ce-42d7-a08d-21c46b495ab0@redhat.com>
Date: Tue, 21 Jan 2025 13:52:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] tests/qtest: don't step clock at start of npcm7xx
 periodic IRQ test
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250120210212.3890255-1-alex.bennee@linaro.org>
 <20250120210212.3890255-4-alex.bennee@linaro.org>
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
In-Reply-To: <20250120210212.3890255-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.086,
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

On 20/01/2025 22.02, Alex Bennée wrote:
> Until there are timers enabled the semantics of clock_step_next() will
> fail. Since d524441a36 (system/qtest: properly feedback results of
> clock_[step|set]) we will signal a FAIL if time doesn't advance.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/qtest/npcm7xx_timer-test.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tests/qtest/npcm7xx_timer-test.c b/tests/qtest/npcm7xx_timer-test.c
> index 58f58c2f71..43711049ca 100644
> --- a/tests/qtest/npcm7xx_timer-test.c
> +++ b/tests/qtest/npcm7xx_timer-test.c
> @@ -465,7 +465,6 @@ static void test_periodic_interrupt(gconstpointer test_data)
>       int i;
>   
>       tim_reset(td);
> -    clock_step_next();
>   
>       tim_write_ticr(td, count);
>       tim_write_tcsr(td, CEN | IE | MODE_PERIODIC | PRESCALE(ps));

Reviewed-by: Thomas Huth <thuth@redhat.com>


