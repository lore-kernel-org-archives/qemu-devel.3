Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0346C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 16:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjiLK-0004i9-9Y; Mon, 11 Mar 2024 12:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rjiL3-0004fk-7c
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 12:17:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rjiKt-0006ZF-EU
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 12:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710173829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uBSHU52K1+lsds0Clz0Zp45M3eWi0Euit0DV7vHB8sg=;
 b=NufZeSToNjzHDV61KMgoJM59RtPqkuFZJDMQ+NPTkcnWN/FItYf6DtwoUU+fH0bIV4CvAb
 aPEXUno3PxLXcf3Sc2ef0xDfPmBXI5mLlTbW+ptgngQ8i/zG5qqwDm/uVEHUAwToVvgpTB
 A+HAh3BtrER2a+KJgXOnPdHw0e+Xo0Y=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-57W832huOtWATgwqDwSndg-1; Mon, 11 Mar 2024 12:16:57 -0400
X-MC-Unique: 57W832huOtWATgwqDwSndg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7885aa9b106so292391285a.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 09:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710173817; x=1710778617;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uBSHU52K1+lsds0Clz0Zp45M3eWi0Euit0DV7vHB8sg=;
 b=fRwEIEvloTdKohJQvG9s4RhRYXEoyduSy7ZpDTZWg9BhJpNv2hehFfm8TYhctO1Q7J
 qUbUD5M3HhcJ2at2IydE1vhKZT/fbnuwXct3B+V3GbcsG8fA5s+lBPKsSqFUBCgswREv
 8jcyxMvjl64NooaSyjpgN1C4unnVPwzE9D60pWkVtNFWHR4fxMo+ox82BbwFwRGbO1kN
 MWJ9xkC0kC7PfpPFKB4px/ZGk+R4K8fzq/F5JYY/a/A/VLcBhJpU0gzsNsyg7I9kAqpb
 cbtf2DwvbpG9ELouRSo2DUoINQtYpnlWQeUV5r+Fs/oXEFGZHqSP/Yac8+xcaE3BJAGx
 x0yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBuRWPpRDBhtoh0YmmPYkS7BYFGkVF+TSmOWjQoLFwueUwuPcuij7VFmn+FSHGO+8T5HhQG3m30HUKMV3JR6+mcJopCXY=
X-Gm-Message-State: AOJu0YxBUFYr1RvHp6Gg1U7j5egDkyxpq03dBQSp0Tpyt4vGUGQLlpcv
 I261L3z/u1QY7i1bWCIoS73bmTqJb1py34j0PBTsHNIyrX/RC18YOMClTNVCADq44uXZcGmtsO/
 aMh4jmNGJ8ClP3wRPj53Sb/Ji+5Xs3a8a6JWko6/uYGQcjJjK5Fa49CdR8ulF
X-Received: by 2002:a05:620a:450d:b0:788:188a:37de with SMTP id
 t13-20020a05620a450d00b00788188a37demr8561091qkp.62.1710173817314; 
 Mon, 11 Mar 2024 09:16:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYc+q7fy1w2Ykm9J6eAmtMVfRloca6ZlcEPraTXfQ2KakUteCAi9iZODk5Ym42H+k/fmc44w==
X-Received: by 2002:a05:620a:450d:b0:788:188a:37de with SMTP id
 t13-20020a05620a450d00b00788188a37demr8561078qkp.62.1710173817042; 
 Mon, 11 Mar 2024 09:16:57 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-178-151.web.vodafone.de.
 [109.43.178.151]) by smtp.gmail.com with ESMTPSA id
 s24-20020a05620a16b800b0078863e0f829sm2101172qkj.12.2024.03.11.09.16.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 09:16:56 -0700 (PDT)
Message-ID: <21e5ff33-2325-450c-8b66-05055a99232d@redhat.com>
Date: Mon, 11 Mar 2024 17:16:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] crypto: query gcrypt for cipher availability
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20240311121929.212472-1-berrange@redhat.com>
 <20240311121929.212472-3-berrange@redhat.com>
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
In-Reply-To: <20240311121929.212472-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 11/03/2024 13.19, Daniel P. Berrangé wrote:
> Just because a cipher is defined in the gcrypt header file, does not
> imply that it can be used. Distros can filter the list of ciphers when
> building gcrypt. For example, RHEL-9 disables the SM4 cipher. It is
> also possible that running in FIPS mode might dynamically change what
> ciphers are available at runtime.
> 
> qcrypto_cipher_supports must therefore query gcrypt directly to check
> for cipher availability.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   crypto/cipher-gcrypt.c.inc | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/crypto/cipher-gcrypt.c.inc b/crypto/cipher-gcrypt.c.inc
> index 6b82280f90..4a8314746d 100644
> --- a/crypto/cipher-gcrypt.c.inc
> +++ b/crypto/cipher-gcrypt.c.inc
> @@ -93,6 +93,11 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
>           return false;
>       }
>   
> +    if (gcry_cipher_algo_info(qcrypto_cipher_alg_to_gcry_alg(alg),
> +                              GCRYCTL_TEST_ALGO, NULL, NULL) != 0) {
> +        return false;
> +    }
> +
>       switch (mode) {
>       case QCRYPTO_CIPHER_MODE_ECB:
>       case QCRYPTO_CIPHER_MODE_CBC:

Reviewed-by: Thomas Huth <thuth@redhat.com>


