Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724AEC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 05:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5IZQ-0007mB-O7; Fri, 10 May 2024 01:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s5IZN-0007lm-5H
 for qemu-devel@nongnu.org; Fri, 10 May 2024 01:13:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s5IZB-0003Ts-I7
 for qemu-devel@nongnu.org; Fri, 10 May 2024 01:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715317988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GDO4URBpy/B8Pyf3jaCjdXLwiXk/IFjYXKw8KhbR+/g=;
 b=HObX9owlMN+K91Yp+hXU6OJRqZWMPTE6IdllHVxJmQEmi4320jIyaxFQzmjhbEy0BAXmE/
 VzlSrJ8XhVDUmNVkVk/J5lBu75iOGg9IRJKj3NOUwuaf0C3jayefABlo1uzIdNtXsIHNPj
 XvJ/0lIn26Ju3JmXPUW0JlzjKRcnLw8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-kP_QQOv5OYOZoUrLJawafA-1; Fri, 10 May 2024 01:13:06 -0400
X-MC-Unique: kP_QQOv5OYOZoUrLJawafA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a59efa9f108so76614266b.2
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 22:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715317985; x=1715922785;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GDO4URBpy/B8Pyf3jaCjdXLwiXk/IFjYXKw8KhbR+/g=;
 b=dRDqLR7C3GicLZixg7wo5HH0K3TUSI44vTD9iPQN//+4DNKVRh6U4hkmKgilXltKYg
 3HQZeLD5fw2kLVB/ETF6vV4yiqln3ZoC8aQ1SnX5KjrjHv+z3MZ+Rqtc1nlzhnrTh5zl
 I0M976xCjUjKQBHh/qCa0hkFHmzRDSrWJ6gjXIVXrC+EqlwilVuNJhAMJKme6jbSU1Rd
 6yk0e/T1wP9ZyjaauzFUOZbI2gz0MaQxQM2kJ9watMj8hgKTO+24vrVPmwIELpbl/rKw
 /VUzqtwvs+cStMyY2CFIjxJiBoL2mlrkYwhBUEUgefVbDcP04KhsHIMlvwqfuvR6FLqP
 vGXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgpZPL87YYnWP3PRsMSnCIB15AF/KAlRoXxN0iJGsc0jAwZVl0UNRrQPkb9ncF+sFrxGT1raXU6LgZ09Qjov4R7LQEp3s=
X-Gm-Message-State: AOJu0Yx5WC559uySP+FFMwxnk0zkFG/ls+1y9t6p8CjVCUl563Rq8zLq
 pp8o1SWbQH+NaFXXp2UTUcSy2Bh1kCXSEtsV9CMpgeQoU6Su36VT9LX7OLqIf55L82y+fY0ws+1
 EMSUpDzC0azHyMOvisR9p5/RSyzOr/yK/CTWipvWIkEnCmJS+xkjH
X-Received: by 2002:a17:906:7f13:b0:a59:ca9c:4de9 with SMTP id
 a640c23a62f3a-a5a2d67ad68mr96751266b.76.1715317985267; 
 Thu, 09 May 2024 22:13:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESkHYsHNE8lGNF3HQrXOMfpZrhthzKx2ut1ukr5bSr6G0715tGw3kCyJjLymSCPGzsaY5NGg==
X-Received: by 2002:a17:906:7f13:b0:a59:ca9c:4de9 with SMTP id
 a640c23a62f3a-a5a2d67ad68mr96749966b.76.1715317984881; 
 Thu, 09 May 2024 22:13:04 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-40-241-109.web.vodafone.de.
 [109.40.241.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781c269sm143494966b.38.2024.05.09.22.13.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 May 2024 22:13:04 -0700 (PDT)
Message-ID: <b1f83085-001e-4b1e-8589-dc974220e55d@redhat.com>
Date: Fri, 10 May 2024 07:13:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] tests/qtest: s390x: fix operation in a build
 without any boards or devices
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240509170044.190795-1-pbonzini@redhat.com>
 <20240509170044.190795-6-pbonzini@redhat.com>
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
In-Reply-To: <20240509170044.190795-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 09/05/2024 19.00, Paolo Bonzini wrote:
> Do the bare minimum to ensure that at least a vanilla
> --without-default-devices build works for all targets except i386,
> x86_64 and ppc64.  In particular this fixes s390x-softmmu; i386 and
> x86_64 have about a dozen failing tests that do not pass -M and therefore
> require a default machine type; ppc64 has the same issue, though only
> with numa-test.
> 
> If we can for now ignore the cases where boards and devices are picked
> by hand, drive_del-test however can be fixed easily; almost all tests
> check for the virtio-blk or virtio-scsi device that they use, and are
> already skipped.  Only one didn't get the memo; plus another one does
> not need a machine at all and can be run with -M none.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tests/qtest/drive_del-test.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/drive_del-test.c b/tests/qtest/drive_del-test.c
> index 8a6f3ac963d..7b67a4bbee4 100644
> --- a/tests/qtest/drive_del-test.c
> +++ b/tests/qtest/drive_del-test.c
> @@ -173,7 +173,7 @@ static void test_drive_without_dev(void)
>       QTestState *qts;
>   
>       /* Start with an empty drive */
> -    qts = qtest_init("-drive if=none,id=drive0");
> +    qts = qtest_init("-drive if=none,id=drive0 -M none");
>   
>       /* Delete the drive */
>       drive_del(qts);
> @@ -192,6 +192,11 @@ static void test_after_failed_device_add(void)
>       QDict *response;
>       QTestState *qts;
>   
> +    if (!has_device_builtin("virtio-blk")) {
> +        g_test_skip("Device virtio-blk is not available");
> +        return;
> +    }
> +
>       snprintf(driver, sizeof(driver), "virtio-blk-%s",
>                qvirtio_get_dev_type());
>   

Reviewed-by: Thomas Huth <thuth@redhat.com>


