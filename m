Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9A9606A330
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UKSepm37;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=npgS28S5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSwWk-0008B9-Ic; Mon, 16 Nov 2026 08:13:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xSwWA-0007vn-K9
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 08:13:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xSwW8-0001xl-2I
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 08:13:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794834782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ux0QpooHzTY9IZo8gKcvqIfbSNJyhlHtlZn5ux2g0ZM=;
 b=UKSepm37A/MqHW3opy3hl6hJg2aU8aeX5lBPrthaYjvpvocTu+UnQ4rzp1aML5m4MY/63i
 KAh4GuBxFZKLrd5YNf2Y0uT+Sf4p6HvTXMlZwBTjWxWlMKIqPQi2CDGDgGbmCv6dwMj5ak
 CoskLywT52yj4qhFjb86zOXgwU8wrXI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-JLUOQhB2OHWQmcMivSH0YQ-1; Mon, 16 Nov 2026 08:13:00 -0500
X-MC-Unique: JLUOQhB2OHWQmcMivSH0YQ-1
X-Mimecast-MFC-AGG-ID: JLUOQhB2OHWQmcMivSH0YQ_1794834780
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a2065a2ef9so26464055e9.3
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 05:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794834779; x=1795439579; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ux0QpooHzTY9IZo8gKcvqIfbSNJyhlHtlZn5ux2g0ZM=;
 b=npgS28S5D8J+F2QNHdkNwtcjsloVNejj7AesVQy+tVWYKwiN8434qrpV7w2KEsCf7A
 IvUz4IHOz/72Ss1ZtyfDXFrZUsAAGuLizcR+IVurkSdqqtlKGkzZoWnwe+qKn83j5Nmt
 sC5X++jymquxNZoFLmo2Yq+nF/8PhokZiQxCxh69T22eR71IS4Wb/98/zZoYw8l3q5wL
 QjtNsHEk9ymy+k2eE8uD8G0TqQe0YE3oqsBiskV4a4ZPk5ymVSt4KtxgrTLzfCZ/VjM0
 c/NmBZEla3PSbDPRx8wlwkrsrT1AT4joHHag7K2PyUKessnYWjY/AZN+EKq4zuQn6wbe
 h/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794834779; x=1795439579;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ux0QpooHzTY9IZo8gKcvqIfbSNJyhlHtlZn5ux2g0ZM=;
 b=G5LlVgs+agrhjPOVKLEeOJNvDvBqChxNm42EdVJHlPlWK65kxcuPjB5AWwkjvV5T5E
 bGji277FYYitJ4m7ESejGZBZ+LRuc0gBu+jrGxm4i1jQSQxgN5DLQCPmqQw6TDGNHH/3
 jkTGvk4Oakr08z66m/Qd567FpgPq9xL3OLQosvS0PN8nRi+bhQ8svjKKyagTsC/PobbN
 PYQgd5WrPINxuU4EKuHpkGzDGZebWExRzKqoaIH4CgGqOGIwLQQ/nCQ8tCE9kp/X6IF9
 1hTYwnKXOLWhI/utp/zt4YXSw4vwILW6lMo9zs9lkhHmDvNNSgCn0udrbmjtDSgB13MT
 0TIQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGiveM/I0CTC6f23K09yD5hO9eRE/RJbAKTvoNgomqb3lXjPp12RYtnYk1rnhJR9sxV136C/2fuKkxY@nongnu.org
X-Gm-Message-State: APuU4Z9iaurxgiqgpfUWMJbQeIcSBx4rxVkT9fk+HJWYznAox+JyZdRF
 /Ll8peXzKOjpePImFDg+EJ4e60agVjPGViEj9GarD0aYg1Gnw6GOujR5gLPFJviYmuFoRxU4q21
 jeoNOqH1A0CGtNRi7K2JEceuWuwA7sVOqwjcFStJXMgs1i4Pdhty39vqx
X-Gm-Gg: AYBFou0ePA1bgL5CVnobS4DKz+Zw8JckKXmuWxpqkkLUnYfEWgZuZ9qgQmgnTcOrp6R
 I6AeVVy0MABZ8oYXDb7qpj8VRwwAg583cj2GeQzpHyEK52fKPTlI3pXPqdU80gZRvmXvPrmoSN7
 I1LYAiN6QGcxNaGo/qtlAzqwpzUU2frRj59tgtCbK4QlXWMrlx3F0UWrxmMSsUJJqgHujvisdvQ
 o6Pig0jkhJF+9ybUGESNcB/J9fMAtBKKrggeRWXxrb9a2BCvDA65ptIR1+cR/L8Zd/KzvZDl/dc
 2WMadKNaug40hDzGEK9Tovb9SxBLLZQTyjaT/BtpZIAqwrpwXmNq02yT+qcEBRExtcDoEE/NHge
 GY4gSeZEsxDKDbuI/TD8iHg8o4AFTyP5yFwe82Go1yc+Pgw==
X-Received: by 2002:a05:600c:8b23:b0:4bb:6f6a:1976 with SMTP id
 5b1f17b1804b1-4bb6f6a1e5amr89047035e9.2.1794834779695; 
 Mon, 16 Nov 2026 05:12:59 -0800 (PST)
X-Received: by 2002:a05:600c:8b23:b0:4bb:6f6a:1976 with SMTP id
 5b1f17b1804b1-4bb6f6a1e5amr89046365e9.2.1794834779311; 
 Mon, 16 Nov 2026 05:12:59 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.75]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb70105a98sm64645775e9.5.2026.11.16.05.12.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 05:12:58 -0800 (PST)
Message-ID: <6f2d27ed-bd61-4390-97c8-a532073293cc@redhat.com>
Date: Mon, 16 Nov 2026 14:12:57 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/26] hw/pci-host: mark common x86, ppc, arm and s390
 PCI hosts as secure
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
References: <20261113184254.2524253-1-berrange@redhat.com>
 <20261113184254.2524253-15-berrange@redhat.com>
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
In-Reply-To: <20261113184254.2524253-15-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> Mark the PCI hosts secure if they are used from machine types
> that are considered for the virtualization use case.
> 
> There is also a special case for the Xen passthrough type.
> 
> Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Acked-by: Cornelia Huck <cohuck@redhat.com> #s390
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/pci-host/gpex.c       | 2 ++
>   hw/pci-host/i440fx.c     | 2 ++
>   hw/pci-host/q35.c        | 2 ++
>   hw/pci-host/xen_igd_pt.c | 1 +
>   hw/ppc/spapr_pci.c       | 1 +
>   hw/s390x/s390-pci-bus.c  | 4 ++++
>   6 files changed, 12 insertions(+)

Reviewed-by: Thomas Huth <thuth@redhat.com>


