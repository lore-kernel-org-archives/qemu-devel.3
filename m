Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFD1D6DDD7
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 06:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBplU-0005o8-Oi; Fri, 15 Nov 2024 01:25:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tBplN-0005nZ-40
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 01:25:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tBplK-0003Ky-AX
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 01:25:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731651897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nkzU3zyQ22UqfGmgDB0OMeTbGX61iAecEEZ+zqQrrFE=;
 b=W68vBBvwAIFuf1tmjuLVNyQ79mGvK3q2095u1lcVpPqTEQ2RKTl0TflxSH+n2B8XnFX5r8
 JlYvbvL7LhI5ndnyPmVWgHCM809S/8l/BzfVXtNjaMSvgSTgNim/7gAiqbp1LsDB8DFQSp
 4Iid1NVIwqJGVSvkTNC42eVK9VjcBXU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-jNbevSMGNkae9KyuM8TSsA-1; Fri, 15 Nov 2024 01:24:53 -0500
X-MC-Unique: jNbevSMGNkae9KyuM8TSsA-1
X-Mimecast-MFC-AGG-ID: jNbevSMGNkae9KyuM8TSsA
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b14fc05206so174126785a.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 22:24:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731651892; x=1732256692;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nkzU3zyQ22UqfGmgDB0OMeTbGX61iAecEEZ+zqQrrFE=;
 b=io5NGgzE6YTL/YG7Gi+5ekYzrqUeYGi/YIVCOanZzfbe/XJ5Vc6ZsfmesjG+MunWel
 eF7QWQ1iOqo6mc6baCtoIY1FxZEocNbjZzUk9IcOXGt9geJmRfrykR5PdYsHcZKbSIoy
 vIkWZGodibz8MraXnOFKwx1IzoxR1o45s+Wcc9wwXcs0x6bj7uJjUUAyddEI4Yc3yQyA
 TumOwFUlnobc8eh9byw6yRq5zMCf9EsIGtbf4Bi6t2Lv45i4crd+u7ufV/2Zjw43coh7
 QTDH2C5QOaHtTubLo1+YwTGxVaQ7ZYidk5rnbmgPrPGAsj5eRurmWuF+Zr3bBFaJUYe1
 q/6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKBh7WSTrpGeZA8HlCzmJYvE+J8MeZRrAlqnMqBrU3DYkh+3VsyxlJn9PQxp/hQsDVbo2wCErtK4dS@nongnu.org
X-Gm-Message-State: AOJu0YytleYoFsCGeK3wheequy7xyQ5oxXkSIB6rlSTyoqBTa+xXylIZ
 OMaecZU1UTF3pou1BHMC3wxPuT7UJ89OyKEL94tG7fd5+bnZ63vawwFQL0bo/REJRjT+GGLT3ON
 8LeljAawIGr3FL/BTnYT6o2ahF7/WqX1AOj36IeiZIYv0sNUY1G4f
X-Received: by 2002:a05:620a:4588:b0:7b1:3b5e:4b50 with SMTP id
 af79cd13be357-7b3622d2c70mr188158685a.19.1731651892517; 
 Thu, 14 Nov 2024 22:24:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRkuEGRHInQe2NuArp7cfOwx+Y6Za8z9Y8iuRw4S++5BZLKdtc/Ridv2aKlUxIigKZt+DA1w==
X-Received: by 2002:a05:620a:4588:b0:7b1:3b5e:4b50 with SMTP id
 af79cd13be357-7b3622d2c70mr188157685a.19.1731651892152; 
 Thu, 14 Nov 2024 22:24:52 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-49-115.web.vodafone.de.
 [109.42.49.115]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b35ca2f7a3sm128914785a.82.2024.11.14.22.24.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 22:24:51 -0800 (PST)
Message-ID: <51aea464-19dc-4129-b8f5-86ed7eb419ba@redhat.com>
Date: Fri, 15 Nov 2024 07:24:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/system/s390x/bootdevices: Update loadparm
 documentation
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
References: <20241115002742.3576842-1-jrossi@linux.ibm.com>
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
In-Reply-To: <20241115002742.3576842-1-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 15/11/2024 01.27, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Update documentation to include per-device loadparm support.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   docs/system/s390x/bootdevices.rst | 24 +++++++++++++++++++++++-
>   1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/system/s390x/bootdevices.rst b/docs/system/s390x/bootdevices.rst
> index 1a1a764c1c..ecb22de04a 100644
> --- a/docs/system/s390x/bootdevices.rst
> +++ b/docs/system/s390x/bootdevices.rst
> @@ -79,7 +79,29 @@ The second way to use this parameter is to use a number in the range from 0
>   to 31. The numbers that can be used here correspond to the numbers that are
>   shown when using the ``PROMPT`` option, and the s390-ccw bios will then try
>   to automatically boot the kernel that is associated with the given number.
> -Note that ``0`` can be used to boot the default entry.
> +Note that ``0`` can be used to boot the default entry. If the machine
> +``loadparm`` is not assigned a value, then the default entry is used.
> +
> +By default, the machine ``loadparm`` applies to all boot devices. If multiple
> +devices are assigned a ``bootindex`` and the ``loadparm`` is to be different
> +between them, an independent ``loadparm`` may be assigned on a per-device basis.
> +
> +An example guest using per-device ``loadparm``::
> +
> +  qemu-system-s390x -drive if=none,id=dr1,file=primary.qcow2 \
> +                   -device virtio-blk,drive=dr1,bootindex=1 \
> +                   -drive if=none,id=dr2,file=secondary.qcow2 \
> +                   -device virtio-blk,drive=dr2,bootindex=2,loadparm=3
> +
> +In this case, the primary boot device will attempt to IPL using the default
> +entry (because no ``loadparm`` is specified for this device or for the
> +machine). If that device fails to boot, the secondary device will attempt to
> +IPL using entry number 3.
> +
> +If a ``loadparm`` is specified on both the machine and a device, the per-device
> +value will superseded the machine value.  Per-device ``loadparm`` values are
> +only used for devices with an assigned ``bootindex``. The machine ``loadparm``
> +is used when attempting to boot without a ``bootindex``.

Reviewed-by: Thomas Huth <thuth@redhat.com>


