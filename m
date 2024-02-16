Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADA7C48BEB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 10:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ravl3-0006vK-80; Fri, 16 Feb 2024 05:47:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ravl2-0006v1-0X
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 05:47:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ravl0-0006NV-B1
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 05:47:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708080469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2eyk6FUh6FdEWzMoTjkZIIKhXTRzNxjdaI+ZyxDfbfQ=;
 b=UxVKl/JlYi8eM5FMG8iBjsB79u4F0dGoV4AwNMP6rwSfOA6wzQRjt8BnfJ1pxeOHEs7xjx
 Abl+q3QHNYaI5pIJABAZZ3GnNFpwqBGSMEtmvHuB18lGJ/gGHTlrWG+/01KL0+H5AvD87s
 T/14TU0ydHuaQQ87f6vSzTE1JKXGF/s=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-jtHCmp2PPTSXoBixYYRZoQ-1; Fri, 16 Feb 2024 05:47:47 -0500
X-MC-Unique: jtHCmp2PPTSXoBixYYRZoQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7873b392eb3so182447585a.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 02:47:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708080466; x=1708685266;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2eyk6FUh6FdEWzMoTjkZIIKhXTRzNxjdaI+ZyxDfbfQ=;
 b=Wvd18cLuMhMumOm0VMvh2/aDm5DkMyzjKImK4lpuCyHlwPQ9e8a9LDtxhULwYbshwd
 V30TF3BDKsIhp8ICp9tFUzmDlozYEiaVVHnLAWbKKxKuknZLue3Jq+OlK6kUsLHi4/Es
 Fz3qGXS6KN/34aMwf5hs6dTYUU5zk+lPEL+LOGJa6dSnyLCCJgWmke5JTMXglaPXfaXY
 rcdBlZ6noWBeSWKYJ3r+yDQGfUdBH+6f8Jofk2xRcj1LpED4Lr1hrLM1l4nW1eivtODi
 SucBU45KsfUudZZjshgJjHdreG2NebwTbeEmBvsQsgQGNF6dTecwIbg/dIURBCzX9I8b
 NrBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1Wbsc+5fv245e9QLzYTq26GZ854CwQo/qAc0e+zk/H0KnsXWaySSLLA2yteqFsVf1GPQAmAoGL9ahWc0FQ6gn7BDjWBM=
X-Gm-Message-State: AOJu0YxGgrMMibQmGCjBmVcC4dcCB+T/9Q63i/LoHO5ZSAtW1aOb/NTA
 LJuWduxkKkHF+3qkYyM88rC2zC1EQt4wpYucE9WUsFf7TtLfqXY/lvAUJ5ovrFIWgx6TSzjy93L
 jXQgRx45gT2z6+Y0NCjbznEjtMCWsaJLP/o1nXaztiYh3/arzjv0F
X-Received: by 2002:a05:620a:562d:b0:785:b189:d486 with SMTP id
 vv13-20020a05620a562d00b00785b189d486mr13711637qkn.17.1708080466633; 
 Fri, 16 Feb 2024 02:47:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/ave/c+YNb/A1KKW32NCUtCkTnHj9nQIwYEcAyuqXm8S2xi4mnB8UjHeYq5x6vYCUd8CpJg==
X-Received: by 2002:a05:620a:562d:b0:785:b189:d486 with SMTP id
 vv13-20020a05620a562d00b00785b189d486mr13711620qkn.17.1708080466376; 
 Fri, 16 Feb 2024 02:47:46 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-177-178.web.vodafone.de.
 [109.43.177.178]) by smtp.gmail.com with ESMTPSA id
 u10-20020ae9c00a000000b00787214b33fdsm1398844qkk.128.2024.02.16.02.47.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Feb 2024 02:47:45 -0800 (PST)
Message-ID: <271ef7a1-aeff-4edd-bd2f-38586399530b@redhat.com>
Date: Fri, 16 Feb 2024 11:47:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] libqos/virtio.c: fix 'avail_event' offset in
 qvring_init()
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 lvivier@redhat.com, pbonzini@redhat.com, ajones@ventanamicro.com,
 alex.bennee@linaro.org
References: <20240213191736.733334-1-dbarboza@ventanamicro.com>
 <20240213191736.733334-3-dbarboza@ventanamicro.com>
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
In-Reply-To: <20240213191736.733334-3-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.772,
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

On 13/02/2024 20.17, Daniel Henrique Barboza wrote:
> In qvring_init() we're writing vq->used->avail_event at "vq->used + 2 +
> array_size".  The struct pointed by vq->used is, from virtio_ring.h
> Linux header):
> 
>   *	// A ring of used descriptor heads with free-running index.
>   *	__virtio16 used_flags;
>   *	__virtio16 used_idx;
>   *	struct vring_used_elem used[num];
>   *	__virtio16 avail_event_idx;
> 
> So 'flags' is the word right at vq->used. 'idx' is vq->used + 2. We need
> to skip 'used_idx' by adding + 2 bytes, and then sum the vector size, to
> reach avail_event_idx. An example on how to properly access this field
> can be found in qvirtqueue_kick():
> 
> avail_event = qvirtio_readw(d, qts, vq->used + 4 +
>                              sizeof(struct vring_used_elem) * vq->size);
> 
> This error was detected when enabling the RISC-V 'virt' libqos machine.
> The 'idx' test from vhost-user-blk-test.c errors out with a timeout in
> qvirtio_wait_used_elem(). The timeout happens because when processing
> the first element, 'avail_event' is read in qvirtqueue_kick() as non-zero
> because we didn't initialize it properly (and the memory at that point
> happened to be non-zero). 'idx' is 0.
> 
> All of this makes this condition fail because "idx - avail_event" will
> overflow and be non-zero:
> 
> /* < 1 because we add elements to avail queue one by one */
> if ((flags & VRING_USED_F_NO_NOTIFY) == 0 &&
>                          (!vq->event || (uint16_t)(idx-avail_event) < 1)) {
>      d->bus->virtqueue_kick(d, vq);
> }
> 
> As a result the virtqueue is never kicked and we'll timeout waiting for it.
> 
> Fixes: 1053587c3f ("libqos: Added EVENT_IDX support")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   tests/qtest/libqos/virtio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/libqos/virtio.c b/tests/qtest/libqos/virtio.c
> index 4f39124eba..82a6e122bf 100644
> --- a/tests/qtest/libqos/virtio.c
> +++ b/tests/qtest/libqos/virtio.c
> @@ -265,7 +265,7 @@ void qvring_init(QTestState *qts, const QGuestAllocator *alloc, QVirtQueue *vq,
>       /* vq->used->idx */
>       qvirtio_writew(vq->vdev, qts, vq->used + 2, 0);
>       /* vq->used->avail_event */
> -    qvirtio_writew(vq->vdev, qts, vq->used + 2 +
> +    qvirtio_writew(vq->vdev, qts, vq->used + 4 +
>                      sizeof(struct vring_used_elem) * vq->size, 0);
>   }
>   

Reviewed-by: Thomas Huth <thuth@redhat.com>


