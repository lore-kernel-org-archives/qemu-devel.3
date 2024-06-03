Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBBAFC25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 14:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE98w-0004aX-PZ; Mon, 03 Jun 2024 10:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sE98v-0004Zz-6o
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 10:58:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sE98s-0001s5-Oa
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 10:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717426713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+OXiYdHlhnBu2Ifqe/8txD3e6kU5YnhC1L5t/jpw8FI=;
 b=UIwjBR9ez8AKglSd+ILahS/o0yc6b4oUzSYbX2OW9PuAVAzmMgtTYOs38wcF++WAeTOie9
 Uokkqeo5hX276GLT3FmQh0KHOtHcwuHnsZtlo5q/T4m3bZvx4O1OFYiENUymwgYjCNxRRK
 yyI/pd1zIY3zvn2KssYpbqI4cwBBgvg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-dFkZcoxFOfO-gRnYUXRvbg-1; Mon, 03 Jun 2024 10:58:31 -0400
X-MC-Unique: dFkZcoxFOfO-gRnYUXRvbg-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-43fb0a1c81eso38577491cf.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 07:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717426711; x=1718031511;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+OXiYdHlhnBu2Ifqe/8txD3e6kU5YnhC1L5t/jpw8FI=;
 b=V+WXbc0igibA4i+yGW3y7TGJdKKUH44NcNPutg6kVaH77icbc4Wm9CMLb6doHjfzd+
 suRxkW5zz8kKQ64ZT9nkPAuwl1BuM2f2PM4+70p/Ih0Jke4XH9m4GGStL6bMhLCyaXys
 53MIuMpXlDyEtrhn24lP2XxytJqYRrmflqUzivBgA04Zv2lhKiwpVKP/inb5A0v1uNmc
 oRiGDa1H20NK8yE1zd/Msul1vE6RnB/N7nUsTnhv6ndeO4D60QLGuvnBP0bV5yeicho9
 hdYtlFoG/k+/nsTLSNqdNXy8I+3qykFLajtk/vYdP4OR5X4wTAiTlB6Xez+XV/7DbQ8A
 jFkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW16gQHyCaWrY1j/LriySJRuUBzP1M2k4IYsD1IOq0r+la+iY7aXkDWVFv/OgkxytZQmQgKBP8T7WFirKToFgqMzce07qE=
X-Gm-Message-State: AOJu0YxeOTLq+Fja2O9nlKAy/OtqnK0CFX1YPSy5tbiSGWNMUPqWXIh9
 BWGC3E39Zk5g+CPASDEuN0skpLAdEVA4/ynAO61WriivUWYAvJz5Xb39+8ST+5IIQCyM+zvsaSq
 QhIYfmjbPlT72IiZ5FsDb3WCqpCwASfnJ/RTL8Haa01Zv6+RMYHh+
X-Received: by 2002:a05:622a:48:b0:43f:f30a:a596 with SMTP id
 d75a77b69052e-43ff52ab262mr89297811cf.41.1717426710983; 
 Mon, 03 Jun 2024 07:58:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3nbRAHw8fWdIdO7+jrk3ZbzUXAlc9KjBUcdRHKaJwL/MFtVe99jef2t0bqeDb8IFL8sScpg==
X-Received: by 2002:a05:622a:48:b0:43f:f30a:a596 with SMTP id
 d75a77b69052e-43ff52ab262mr89297671cf.41.1717426710543; 
 Mon, 03 Jun 2024 07:58:30 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-176-229.web.vodafone.de.
 [109.43.176.229]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43ff23a18e3sm40287691cf.10.2024.06.03.07.58.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 07:58:30 -0700 (PDT)
Message-ID: <3e9acafb-9d63-4177-87c7-a7f8faa290f1@redhat.com>
Date: Mon, 3 Jun 2024 16:58:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] update-linux-headers: move pvpanic.h to correct
 directory
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: cohuck@redhat.com
References: <20240603131141.834241-1-pbonzini@redhat.com>
 <20240603131141.834241-3-pbonzini@redhat.com>
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
In-Reply-To: <20240603131141.834241-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 03/06/2024 15.11, Paolo Bonzini wrote:
> Linux has <misc/pvpanic.h>, not <linux/pvpanic.h>.  Use the same
> directory for QEMU's include/standard-headers/ copy.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/standard-headers/{linux => misc}/pvpanic.h | 0
>   hw/misc/pvpanic-isa.c                              | 2 +-
>   hw/misc/pvpanic-pci.c                              | 2 +-
>   hw/misc/pvpanic.c                                  | 2 +-
>   scripts/update-linux-headers.sh                    | 6 ++++--
>   5 files changed, 7 insertions(+), 5 deletions(-)
>   rename include/standard-headers/{linux => misc}/pvpanic.h (100%)

Reviewed-by: Thomas Huth <thuth@redhat.com>


