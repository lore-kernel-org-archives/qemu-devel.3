Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69ABCDB47B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 08:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbZft-00024d-5m; Mon, 22 Jun 2026 04:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wbZfl-00024P-OH
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 04:06:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wbZfk-0006rq-53
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 04:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782115580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OUupwX9QM8Q74Thn0WQCCHi6Qm19LflNdouuc4KwwYg=;
 b=PHmxzeiLagKCcHobuCZMjs8wQlGbB35sT8Sguy3PYFawO/SuLh73i32/wcWv14b/XgoJfK
 ET9kpkFwg8I8YXxo5OZsvxEGZ35w5fUG96v+jKgK7tV5jmCUOWxgWBPYLIpFT0o+5Gpxz9
 EI17HToVDTL4m9/PcPaKbAM4HTN3NYs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-5UYPj19kOsWnMGc92Orplg-1; Mon, 22 Jun 2026 04:06:17 -0400
X-MC-Unique: 5UYPj19kOsWnMGc92Orplg-1
X-Mimecast-MFC-AGG-ID: 5UYPj19kOsWnMGc92Orplg_1782115576
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49221de4ed4so26211545e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 01:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782115576; x=1782720376; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=OUupwX9QM8Q74Thn0WQCCHi6Qm19LflNdouuc4KwwYg=;
 b=b5b5Igz1HPUMSajWjfb0wjWoWDjTNMCYNF4iUQcTCt/c5mIhxAZsmcerWnepoCzoMZ
 m6hU0gBRd1tsR+kw49J1hp0wCa+sw1n6uETT/EdcAYEWsxQ5KHdFgGHpJdfmd2Zgxbec
 JcX8FjzfQADb3IT3AqsBYObjZdT+eYdL+KDB0ghrEnn+eVzgnv6lUyHHA891xhAs6Ptd
 MQOfwhZ9cr0nwUgrMth6GHKvPWHql9XlQhmiIv0l2OYFq1BGUUo74sOsYSVs8AVRnviS
 dcjBrnA92Xrv7ELrJ+1w4jyALAW8RwCmWn5Tg4M6eW/Zr6GHplGebyVlCuw2iYKuo3TN
 1OvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782115576; x=1782720376;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OUupwX9QM8Q74Thn0WQCCHi6Qm19LflNdouuc4KwwYg=;
 b=q9ERU4CbsqHyQWRkSF5ixdPfruSgsd44u6r7hxcb6jVPN60ss5GvoZmxyfv1YgxIj4
 5wqPtmFBfHPTOS+dAOSyd+UF2vxsGx/xeZuZjCDlG4VZui0yc3SPoB1wlfdHKyFssaN0
 xlPJgsrYuLdqdQLJekizz0Mzu9AMO/Wty1r5/DD9VnMWjiV++7/3DHYz83HJ5Pi+lvu+
 aFSyeToGYgUfNt/wwgIYtzME1bf2ZnrqhVfYxk6SmeTUNRy8m1e9E9WFmGYQDVBK9+h3
 odXvQhU3SW9FiBP66bacn20snHUjEt8cyj21dJZCmM7bUhrfJOhgSBQU2w0PvrAV/KPL
 Ienw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Az4PUo8gudWfTxPi1goXQu0V/GiXmnLETVYLnau6EjMHxgy6XQ8SNFUB86y3Kbe0L2qd+uEGMZAnt@nongnu.org
X-Gm-Message-State: AOJu0YzBocr7kCHmmQaHaSBTxwNVAquinNWxCGoPEntSP823OwVcMd3d
 mRuJ5zH9pHU3tVcgFt4QbyO/XIuOWo4tbtyNXRerOe7weQzEV/4dtGrv8M4Hd9G3ARzA4QlDm8L
 nVIAQ9wfyHdSStBJyeYyu4W1Gevqxhp50PYdEfnkcIF/Jo+lFksEoXTuc
X-Gm-Gg: AfdE7clUXBQrZ5Ga+KtQVDTbaExoY2qQ+nWumEOAN9zSZ3NPVQWnZSHt0IMDPdov/KD
 +dkTOJ+3shNiRTsMEIQd8nv5CNVHlcShPvXLxw12LuBWxQfVS+Ch7dkrye4bKJgUiSUyZt1dmJs
 bc8HDqis4xOZNmyES7dOLnLR3+45P48fr9mUZeS38Koljrn926xcFq71dXuZvhOeckiSqvmKS4Q
 SxK/gsUJfPhu59N+6hMsR87Q7ztXJLJxjpHWIiaF/fGV18DDDIaTxZvOPjHtIILGSqFlF74gAE3
 5MuyZP83/B/KklBKGgD/JDcyJWgiwbRbCcNXbbGI+z8lfsKreQkmNeQwPHz4lUKMNTewzOmeq6s
 s/MhLCk3v
X-Received: by 2002:a05:600c:3ba9:b0:490:48df:2793 with SMTP id
 5b1f17b1804b1-49240e93196mr231217895e9.26.1782115576497; 
 Mon, 22 Jun 2026 01:06:16 -0700 (PDT)
X-Received: by 2002:a05:600c:3ba9:b0:490:48df:2793 with SMTP id
 5b1f17b1804b1-49240e93196mr231217455e9.26.1782115576148; 
 Mon, 22 Jun 2026 01:06:16 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.107])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fd33dafsm307462995e9.8.2026.06.22.01.06.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 01:06:15 -0700 (PDT)
Message-ID: <54334ba9-d44d-452d-8ee1-11c40063275d@redhat.com>
Date: Mon, 22 Jun 2026 10:06:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [qemu-web PATCH v2] security: rework guideline about issue URL /
 CVE references
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260619091508.1194994-1-berrange@redhat.com>
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
In-Reply-To: <20260619091508.1194994-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 19/06/2026 11.15, Daniel P. Berrangé wrote:
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
> 
> In v2:
> 
>   - Use non-existing issue number as example
>   - Mention both issue URL and CVE to be optionally included
>     in all commit messages in a series
> 
>   contribute/security-process.md | 23 ++++++++++++++++-------
>   1 file changed, 16 insertions(+), 7 deletions(-)
Thanks, applied!

  Thomas


