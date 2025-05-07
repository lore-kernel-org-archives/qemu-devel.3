Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2A6C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 18:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCjDg-00064t-9P; Wed, 07 May 2025 14:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uCjDe-000638-LC
 for qemu-devel@nongnu.org; Wed, 07 May 2025 14:10:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uCjDc-0000WT-Le
 for qemu-devel@nongnu.org; Wed, 07 May 2025 14:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746641405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KYtji/e6/3OspXTLj2p2HxrAay+1j99Hy/76LgoF2TQ=;
 b=hYBkhqRY6VO7028xjoJo5NxCAWZLUlIcpqw+9OhmaDwUtjVojn9mCxCmDt0WVQVHARpX8C
 +8q9MHJovQeTvfiMG6Qc/JW3ML1WYoBDkEqempFHGfp06DUt9WC2L3N3oPlZ04KIrGVSMX
 dowYKRTPm8qB54M8t4T42bCN7EMttAg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-BcdTEcAHMsGaDF9YrP6sHw-1; Wed, 07 May 2025 14:10:02 -0400
X-MC-Unique: BcdTEcAHMsGaDF9YrP6sHw-1
X-Mimecast-MFC-AGG-ID: BcdTEcAHMsGaDF9YrP6sHw_1746641401
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-441c122fa56so593635e9.2
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 11:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746641401; x=1747246201;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KYtji/e6/3OspXTLj2p2HxrAay+1j99Hy/76LgoF2TQ=;
 b=KckW5DIGIoIT2PTDageaULKXoGRxtUkvkFjZoywH8JC8g+tWtlF7K5LxovPYBioIQW
 R47/ul7VCC2jVtXAX7l1R5WdiW3D0SM4IiVdiRXLv2/3L8Akhou8cNwhqHNDp4eiJpvR
 oxMpi6S3sPoLIO91B1elkYl93pK1Pk8NqVbc3CqiiFQAl7h1dlIdpqPKG3a9Rg71ptlh
 IkgB0ybKBAWKUS88Z2i9mKhtZHisbVL+hrBFmzk8luokyTrlUEAx8gGDuUpd4kYrnu0H
 fJ8cyyW6nn3gvqlo+SQqLf+StR3FFZGWRGToDBzrtITnN29QdEcl4Ls7M+s0Gv4rbozo
 7R3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuu35x78WecyGTBcF+Q7Qy3/XtVB+/zwbEv8XVn76x9+cB35LFlO6m8R/68KZIa4BUWUZm4ZI8maFn@nongnu.org
X-Gm-Message-State: AOJu0YynE8ZiTQFQ0ad7MfgDQkO5qruV90vIUUEUtgPb3N2ALsHEPNHl
 JWWKyHEGOCPrT558s7CuGKnlqf/eRk517KDgx8ncJuETZmxQKIXGG+cBiY+AXrwhX5UlM+Z/q7L
 Fqf4wuqP3x4w5S/PAsO77SppTJnBRVrOcAA7FPiNEd5KIgQfCq5Kq
X-Gm-Gg: ASbGnctr6ryTECyChMDoZPsYO4NQz13/mqddrNETdyv4dFIjJFjoJKwmKkfad5JOVPS
 C69SdJW5skyrV6S2szMrxMPCnF/kSt8TX4uLQj5BQ3yjAGp4vpbl+6hNxg4mPKyqexEtk62KbVh
 8FZng8DLk96Kzu8uVyWKT8lqMa7mK1k1BZo84ENxPFITGLpBgvM6SHM/Bk6bvIICgwNQkhqe5Rt
 CA+vMREqBt+JrB3LHcikjskKDH0nVswQ2gD89Yox5ld4OakzYGUmeJrAJIp75PkmuBN32D8D8pX
 vb5G8w0Z/kc/irXYdse1HE4cykQj69yT/XmxPGxPVpt39LGwVoDQ
X-Received: by 2002:a05:600c:a47:b0:43c:e2dd:98ea with SMTP id
 5b1f17b1804b1-441d44dc067mr35416035e9.22.1746641401216; 
 Wed, 07 May 2025 11:10:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6uyePdIR9XNV31B8j4+YTfChHzx8t5CY04fG+aQZBCHahG9cdl3UggvtuH6KnPrRsw+zdcg==
X-Received: by 2002:a05:600c:a47:b0:43c:e2dd:98ea with SMTP id
 5b1f17b1804b1-441d44dc067mr35415815e9.22.1746641400824; 
 Wed, 07 May 2025 11:10:00 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-173.pools.arcor-ip.net.
 [47.64.115.173]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0b695dd16sm2171909f8f.87.2025.05.07.11.09.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 11:10:00 -0700 (PDT)
Message-ID: <2dfcf252-99e2-45f9-b958-770d14a1ab7b@redhat.com>
Date: Wed, 7 May 2025 20:09:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] util: Add functions for s390x mmio read/write
To: Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, stefanha@redhat.com, mjrosato@linux.ibm.com,
 schnelle@linux.ibm.com, philmd@linaro.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net
References: <20250430185012.2303-1-alifm@linux.ibm.com>
 <20250430185012.2303-2-alifm@linux.ibm.com>
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
In-Reply-To: <20250430185012.2303-2-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 30/04/2025 20.50, Farhan Ali wrote:
> Starting with z15 (or newer) we can execute mmio
> instructions from userspace. On older platforms
> where we don't have these instructions available
> we can fallback to using system calls to access
> the PCI mapped resources.
> 
> This patch adds helper functions for mmio reads
> and writes for s390x.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>   include/qemu/s390x_pci_mmio.h |  24 ++++++
>   util/meson.build              |   2 +
>   util/s390x_pci_mmio.c         | 146 ++++++++++++++++++++++++++++++++++
>   3 files changed, 172 insertions(+)
>   create mode 100644 include/qemu/s390x_pci_mmio.h
>   create mode 100644 util/s390x_pci_mmio.c

FWIW,
Acked-by: Thomas Huth <thuth@redhat.com>


