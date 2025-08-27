Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE9ACA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 21:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urNfc-0006oc-5q; Wed, 27 Aug 2025 17:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urNfa-0006na-V7
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 17:27:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urNfZ-0002cb-1W
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 17:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756330018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fkSyURDGWgiZX9eN7RO0tznL+41W8P+x4F312hpYhYs=;
 b=GdOyDSvrypNdFslMO0RQ66wUmuG9whXIxF4dmhDXJQ4qnv4CFL/dqJQTLLVTFv68CwY8mM
 ls0/WwZFS2BFH22AFgk/oqaGbs2H6ZRfHBWfxZqtE0a/UjcCCcREiAzYJwePF8YRuhi45a
 a+bLzm0Kg1+A5pousVkUkVwYs0Dj5Tc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-uvZROaITMAWW-BQGPvQWjg-1; Wed, 27 Aug 2025 17:26:56 -0400
X-MC-Unique: uvZROaITMAWW-BQGPvQWjg-1
X-Mimecast-MFC-AGG-ID: uvZROaITMAWW-BQGPvQWjg_1756330016
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-afe77857691so130025166b.0
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 14:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756330015; x=1756934815;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fkSyURDGWgiZX9eN7RO0tznL+41W8P+x4F312hpYhYs=;
 b=tLx8TZHFzevv35eq64WYuEDa8bZ4/Pvi1an6AyyAPRx9ImRdxRxkniQe6GV9QRUOXw
 Ea8XhFU0kxp+CQvp+DxL0Jwyv8fLsPMNwAtL/XQa9gm8bEIQrBa2Cw7QXZoGGkX6Ks94
 LSg+QvtbeR3aPAQnQS92I9zuKn9RSV3PvW/yqWMUTdiljMr1RolVTeAZoVX+gMx1MDoJ
 qvIqoNPfh9rDEJyxc61DXPz9SQUDi3B6JWoPZKB47dsBNigpMwwL3V6a2k1XH3UbeLxH
 47LqLSPtm7cG9hWQ4jkByWN9eLysrD3UtGvbiA/VAFR+EjPH/VTxLBUlVeUoBgPUMGv0
 L6Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZZ6+aJRdzQ5fsEb+HDYSygEx9Ro+0B8KdngoBbZFXryACNsdjLj97yES39kVfgNgK/q+arqivXyr4@nongnu.org
X-Gm-Message-State: AOJu0Yw5KvPqU2u8X/s0z1UQqe4LYCgyhG6x2W4lgH7hJbGhDOk+0yQ9
 /nMzF0GkhuXnVQR+RczEvIh7GWYnb010AlRSSi1ZXvaBxQ15atURAsFlSnWYab727QRCUDnhLCl
 QExsoHFMA64RMR3DYjlhBorzoE19j7kmlBAznh9bHL1Cw9lDLQvlVHC69
X-Gm-Gg: ASbGncvwZVbB0LcIIsCfTFAAe6Rr5V7IqBL06gYFf5w+f3+D9INRWQB09xOYMGzkeyv
 aKXp6X6OaVbjHH7KnLBmwbNZSfV7p1hzsE+sF0720m6STQUj+E4io4T1VvykMcvXBjbpTcq0nb9
 ovGuq5N/oxK0Rovz95QmQOM/nDNo4cB5CNMul1WYtm5eWXows+9JJ9C38f5kEyDboKD7hwRJ5ZC
 jF4YBVla/KjcSXmoaSlzTNKiEG8MHWORjRL141MJ5ym+g0Ck9iKgnLeFbMFOhrNQuKXVK1pKozD
 OL85EyxxfiC1JFTaJZRdVM+D6PbaOq3AToyRSwmKnqBafB4Db/0wqtZUcWY99I8qDVBe+fw+c+o
 GK8xi
X-Received: by 2002:a17:907:9447:b0:af9:5c10:a51e with SMTP id
 a640c23a62f3a-afeafec8289mr575242366b.24.1756330015659; 
 Wed, 27 Aug 2025 14:26:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtrnA24R8ncgqjecxlw65ePnepd0H84UU6ez9IzYjmWARZzmKTCYU+MbxOKn8OMGX/ISgO9w==
X-Received: by 2002:a17:907:9447:b0:af9:5c10:a51e with SMTP id
 a640c23a62f3a-afeafec8289mr575241866b.24.1756330015284; 
 Wed, 27 Aug 2025 14:26:55 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-113-247.pools.arcor-ip.net.
 [47.64.113.247]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-afe48fc3d82sm1068466566b.44.2025.08.27.14.26.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 14:26:54 -0700 (PDT)
Message-ID: <4a7be62c-b251-45f0-a371-ba63f3e52dba@redhat.com>
Date: Wed, 27 Aug 2025 23:26:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] MAINTAINERS: add a few more files to "Top Level
 Makefile and configure"
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20250827174414.814138-1-pbonzini@redhat.com>
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
In-Reply-To: <20250827174414.814138-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 27/08/2025 19.44, Paolo Bonzini wrote:
> A few files in scripts, and the list of packages in pythondeps.toml, are
> strictly related to the toplevel build scripts.  Add them to the
> MAINTAINERS file stanza.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   MAINTAINERS | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


