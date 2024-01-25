Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875FEC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 11:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSxcg-0003K4-H2; Thu, 25 Jan 2024 06:10:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rSxcd-0003Jn-NN
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 06:10:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rSxcb-0002VR-6d
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 06:10:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706181010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=u1Z6DEDOJiGHx/Mzml9iIfEBr42eab2zaLEWipZXmz4=;
 b=G7+9g9/d0KZF/dPer6DrP6YYAn0UiIS8BnBwhyglN46ywcpJmAl7d8Bx5nS2QqqnadqX9t
 +y2722K++zu1DmlBJA4+1y0uQzSMsWp7n0W2ynKmUQxGZSjpmDDEFC3m1PyKExx9vxeCZb
 iLDX9ikvHA/JwK4NW3b88jxeJWodxfo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-BGN862u-OdmqqWer251brQ-1; Thu, 25 Jan 2024 06:10:09 -0500
X-MC-Unique: BGN862u-OdmqqWer251brQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6868e2ed965so53860316d6.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 03:10:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706181009; x=1706785809;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u1Z6DEDOJiGHx/Mzml9iIfEBr42eab2zaLEWipZXmz4=;
 b=ZRAHH8t9SbSMfPHpOaHurAFjiabaO5P1osE8TV/zThnovym2NgwcEaXJ5gdQFyosxq
 ocqumlk4NN9OaPexVsm4CkxjhMxEYAIJMOioAGSTwIKTVLz6/0AQNNFUWrya4GI+iAMn
 nOPOfkb7POwsoEpvvVZyo7f7A8KmYLz4jqIIpdyMtkrkNd1kjedrlHfOGU8dgIiHu3Tg
 0pvsaRm3BbqZ8C6N9nwbOxzZxr3JGQZecBoUPx/BkGNRdlVwlP/vgH+eUsXBuXE53HSW
 pLhYSmVl9yuxHKTeqzF9x2hec7HhgCPu2nWuHxhb6uQXi01cOVS0tYwZX6jny/7+lIbK
 y5GA==
X-Gm-Message-State: AOJu0YwtXgwpioVzJC9Nw2TLvD3OtKgusMQda95YDlA157KTmSuFIVUz
 B65EoYuQT4R4g3Z3ReGLjaXaZ6Y/8SNxFMzNYPCqLgE9yd/qa3deEnjSiJ3Yq2QvdKJyDisaziT
 7sSn5G/lY8DpTGgWsHGn+Gwo9csJaoakzyYDjGqfjmceZZta9lVz2
X-Received: by 2002:a05:6214:d65:b0:686:c70:2ae0 with SMTP id
 5-20020a0562140d6500b006860c702ae0mr808670qvs.45.1706181008879; 
 Thu, 25 Jan 2024 03:10:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNn1b4h1pKONLnduAn5KVCf5kgkCKzzqYJh6WQtuB8OcUO65QZJF0xRgDKyfO3IDjI7+Dy5g==
X-Received: by 2002:a05:6214:d65:b0:686:c70:2ae0 with SMTP id
 5-20020a0562140d6500b006860c702ae0mr808657qvs.45.1706181008540; 
 Thu, 25 Jan 2024 03:10:08 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-176-119.web.vodafone.de.
 [109.43.176.119]) by smtp.gmail.com with ESMTPSA id
 oi1-20020a05621443c100b006864a1d5952sm4831504qvb.116.2024.01.25.03.10.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jan 2024 03:10:08 -0800 (PST)
Message-ID: <95573827-150c-4533-a707-e1d6a6d9f5e7@redhat.com>
Date: Thu, 25 Jan 2024 12:10:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Do we still need pre-meson compatibility hacks?
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Wolf, Kevin" <kwolf@redhat.com>,
 "P. Berrange, Daniel" <berrange@redhat.com>
References: <CABgObfaCq+++xj7ow5Sm22P5nfMZyh-BKt57m3Po6voKyCnuXQ@mail.gmail.com>
 <CAFEAcA-fnOjEOWGjw1vqyx3Evnf6U99-Yo-mqMkXD87J_ZdTgg@mail.gmail.com>
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
In-Reply-To: <CAFEAcA-fnOjEOWGjw1vqyx3Evnf6U99-Yo-mqMkXD87J_ZdTgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 25/01/2024 12.04, Peter Maydell wrote:
> On Thu, 25 Jan 2024 at 07:54, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> Right now configure contains a couple hacks to preserve some of the semantics of the pre-meson build system:
>>
>> 1) emulation of ./configure by creating a build directory and a forwarding GNUmakefile (requested by Kevin)
>>
>> 2) creation of symlinks such as x86_64-softmmu/qemu-system-x86_64 and arm-linux-user/qemu-arm (requested by Peter)
>>
>> Neither of these are a lot of code, but if people aren't relying on them we might as well delete them. Do they have any users still?
> 
> Personally I have moved away from using the old $TARGET/qemu-foo
> so I would not miss the symlinks if they went away. Can't
> speak for anybody else on that one.
> 
> I suspect that "just run configure in the source tree" is still
> popular with the kind of people who don't frequently build
> QEMU, though.

I agree with Peter - I guess there are still people around who try an 
"in-tree" build, so we should keep that possibility, but the symlinks for 
the binary can go away, IMHO.

  Thomas



