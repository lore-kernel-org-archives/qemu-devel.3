Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C1E606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EUKrwD0N;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=OrdYX5YH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSwPm-00043C-LH; Mon, 16 Nov 2026 08:06:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xSwPS-0003tY-Sm
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 08:06:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xSwPJ-0006O7-Ao
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 08:06:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794834361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YZrhKk3RMFkzzSLBZHt1JzOXHi5Eo49OHZzYWsZI8SQ=;
 b=EUKrwD0Ns66a5qjDzci2noCBJ4/hySOujejJxW+ice2ubMMiitPR+2d6QMVMBkMHmyUQ0g
 jL55pY4OLD8NDtBdDEn15F8qH1f3e2gePhoEPqQAszEnG/8Rc2a06jAkWALjYvvhptwd3/
 vfgQGUQ89AIJEd94ww8NN65nptP8uwk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-Wr2K6zbEPNuhAMYLSuOGdA-1; Mon, 16 Nov 2026 08:05:57 -0500
X-MC-Unique: Wr2K6zbEPNuhAMYLSuOGdA-1
X-Mimecast-MFC-AGG-ID: Wr2K6zbEPNuhAMYLSuOGdA_1794834356
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4bb67b2c00cso8070745e9.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 05:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794834356; x=1795439156; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YZrhKk3RMFkzzSLBZHt1JzOXHi5Eo49OHZzYWsZI8SQ=;
 b=OrdYX5YH76cqV0eYl1SBFzke3xih76QHB6DZWTU7NbiO8CusigeelKueGaD211GaYg
 SdBhP4pWkaIoGJKiRMZrqKmDlBYePM3fZuPZA82PK+fPyEkWsckr/pcwJnO9EHahuX9W
 TW5aC+rn5AWZY1GO2K90UVV/QKPTNrkWNKwWpNITlxxZHA4GcVp507tyk8vHhFCZZRTm
 FzSFgTqIDcYlwa60YCxgrtnSc/g3SE8A2aMaaoBQi3JilzKOmGb8nQZTZ55zjQXZrlFG
 KRb5X3+N48bv5WrHSq4UMiTixcqUmIyMIeFCqWSqPwwDfQsqDI3kJ9MSEMgWAROverce
 5NeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794834356; x=1795439156;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YZrhKk3RMFkzzSLBZHt1JzOXHi5Eo49OHZzYWsZI8SQ=;
 b=piJE6ZPmDvWPp3dnWUgpFvva57Bfds/vneEYHWX6nI7k6ginu8yP/uTKfsWohk3yPe
 s52K1JY+oxDXPrhOaXaEEx6czRl2jkK2aoN5OeR+tTK8J/iyO1V+wJFz2Q2ICjK8vdKM
 /AZcmxfPCcE/Xw76MdvKNpB6z5rGxReykc79TPQ14yIVK65zcRm6dJcQooBgPkZLYMIR
 glXaV9prbrHIwDHXrPBeb/PDirbRmsdaKJmx8SZPlQZTm/FGawD4SefeZ/ciezd2/oR2
 EgFW3lyLtL08Oc4cvu+RYSfAO43GF34Idl0XwNglhlE0BdGq0Ug+nFWsP3gl1Xk5ap3X
 vT3Q==
X-Forwarded-Encrypted: i=1;
 AL+hErELwxUUYo+Y3LOM7H7scCfWxwerYhhHOr7qYN6cPwthr960H0uEpfJ0jEGXK3yg47psgdIoEtiQ8JRS@nongnu.org
X-Gm-Message-State: APuU4Z+sGvbw6UZQF3FPsfzlvqozUWvixRdf5C429yH7/Mx0IInHKMvH
 NoMtQd7dF0r/uCiTAADtGOu2e/5Z59H2CVVfqWHXCeH0S2GUOChi/ODlgDcaJSKYwUsdG/bePzB
 JgPtArBS24bQIwBP/1ajI8ysha1+vKW4Xp9Y/TPcRIWAdOGs8iBnkj5Y0
X-Gm-Gg: AYBFou15XcZMGwR9WNRpbh8UcSsmhQa6qJchMmiCqghbyCIbkKhSTbt1FlY/+MP6UY2
 1araxMuKJgMYTApvNdOHGx1Ax72Y7eIiz3nPtn0iXPJBxrdfXpvVvsroHLTQIOnyQE6FCSXzXop
 qiC3fWLkuqvxc+p94GrYC0F5QvYV5/phYN9oRNEhcH7fM341NhBJ/2qjE3f5WrTaFDOyi7+83AX
 EvjrytXNSR/v1WJBcD9TzefmAhLY4ohrwvdE3/qNQCivfVZtN6Cb+nQG+EQqnrU1lAAi1/M5ykj
 tmC/HAaYOO7+uOBtVz2etPSQYGdYZGKxkvgZUXgmPqT8PmO2vK97b8oRPi4a9PElIvKjZ/1zS8U
 SnOiWW5P0omBfjEedSRbRWc+rfGwJSRqndAEOn3RG+Z1b
X-Received: by 2002:a05:600c:4703:b0:4ba:4928:8aec with SMTP id
 5b1f17b1804b1-4bb55a755b2mr228782035e9.9.1794834356249; 
 Mon, 16 Nov 2026 05:05:56 -0800 (PST)
X-Received: by 2002:a05:600c:4703:b0:4ba:4928:8aec with SMTP id
 5b1f17b1804b1-4bb55a755b2mr228781245e9.9.1794834355538; 
 Mon, 16 Nov 2026 05:05:55 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.75]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb571f976esm152496025e9.3.2026.11.16.05.05.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 05:05:54 -0800 (PST)
Message-ID: <10e1e039-17ab-44de-916f-388fd0dc77a3@redhat.com>
Date: Mon, 16 Nov 2026 14:05:52 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/26] hw: mark most virtio PCI devices as secure
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20261113184254.2524253-1-berrange@redhat.com>
 <20261113184254.2524253-2-berrange@redhat.com>
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
In-Reply-To: <20261113184254.2524253-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 13.11.26 um 19:42 schrieb Daniel P. Berrangé:
> These are all intended for use in a virtualization scenario and must
> provide a security boundary. This can be done for almost all virtio
> PCI devices by modifying the common type register helper.
> 
> Exceptions are made for the virtio-gpu-gl, virtio-vga-gl,
> virtio-vga-rutatbaga and virtio-gpu-rutabaga devices.
> 
> Despite being intended for virtualization use cases, the complexity
> of support for 3d acceleration is such that QEMU can't offer security
> for these devices at this time.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/display/virtio-gpu-pci-gl.c   |  2 +-
>   hw/display/virtio-vga-gl.c       |  2 +-
>   hw/display/virtio-vga-rutabaga.c |  2 +-
>   hw/virtio/virtio-pci.c           | 17 ++++++++++++++++-
>   include/hw/virtio/virtio-pci.h   | 10 +++++++++-
>   5 files changed, 28 insertions(+), 5 deletions(-)
Reviewed-by: Thomas Huth <thuth@redhat.com>


