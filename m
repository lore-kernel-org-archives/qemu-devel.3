Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59904606B1D8
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OBM15PNE;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=YdrfycfO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNt6n-0004zC-2i; Mon, 02 Nov 2026 09:34:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xNt6L-0004cH-Ty
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:33:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xNt6K-0007fU-ED
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:33:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793630010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=r5ojuNc5f4EobEE7mRc1MRO5w9RC34eNbCctsWTQlNU=;
 b=OBM15PNEkCSPKzswH5MgdJX09Adj1hSNg+1CBoyo3U2m2TAVYwCqABYpBij3nblCRi0g7H
 +62KUQAbCFRMw9XFd7omEU6gPN1JmW/46JdP1mqtnkM0lZP8wWNXk4OODE7Icm5fhrtaMy
 Lu+VFLnkJImZP+YO8XS3eFNKAxaxUCU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-308qSDxtOMq6mrOeihxmMg-1; Mon, 02 Nov 2026 09:33:27 -0500
X-MC-Unique: 308qSDxtOMq6mrOeihxmMg-1
X-Mimecast-MFC-AGG-ID: 308qSDxtOMq6mrOeihxmMg_1793630006
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48e0c896d05so2649082f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 06:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793630006; x=1794234806; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=r5ojuNc5f4EobEE7mRc1MRO5w9RC34eNbCctsWTQlNU=;
 b=YdrfycfOLxy7LnoL8N8QDgZ78iyJGKJ/5Cst+synKIPuDcFt/0/jWtlV/xaFNO09l/
 3SrWYrAPch+Ovu9T8W7P8Vqeea1bHh5LwnrB/1WkiVVbNt0NkykLgezLR2TWqUEFLx5k
 iL4PRjbOvLpyLgw9nOr4OBYiNx6H3cwTF59aTORhwYbM7ba0M37GLtnz1M6gc5cYyANK
 xAWZl8TyrdZ4mMhgFfzFf6dRj7nyIAHVtq1XrdAxbaMhtRqhvWysWo2mQyp7ESOQTSBu
 t3Ia0O8Ngopqzy45M0vvlZghRXKYAgsgmg6LzPl8TIhmA0Sq3eSFls/TOCWDd5Ar6c1M
 peDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793630006; x=1794234806;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r5ojuNc5f4EobEE7mRc1MRO5w9RC34eNbCctsWTQlNU=;
 b=uIp1SkKfbAnhhgcJP4WVjvIt38h3gW97DRl2+6G4OM1axHgrGvSjVIGRx2vSfgKTMh
 HjRDd/2TI0rRY5wX+EYCGWGL9/Y/uP+LxP4/eDuH8nmfqXRPK/cHpZqZBNQG1zyVfNU7
 5kJyDj3hddJE3erHBz2y8sDx0oN+Rn5oTghcvlpWs2bXaZuB2ecpuI1BaRfdqa799jzt
 a06My31rf/A9zlUdV+89dFhC69S021PiHWVh1IKUDeZQ3l1wDGCJSFqmHdc6PYR0rWyC
 LuZAJv6eyam0Ww6EKQKJUR8o4jTIV1RACpL68qQkBz9mvtGNuWzMkQej4LYmOsZ67/JC
 cROw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8B5WztcUgjiZRWniSqCXS66T7ce0GK5yuaI1hfUOHkjqwZSVjo7ArSVBtieZeO/mZ0+d7ZaWkD9J5@nongnu.org
X-Gm-Message-State: AFq9FYJzOfQiY7S5KXIj2Dvo+yJ17HXsDRUnZpS2qBXqelMCGEMOUS2p
 CSsCLPmE6esiBtccDn9m+IGBXS6b+/Fjai+JKn1kCqFqb9nFLuwwimvzzcxG1deAjbuXfB+pbVv
 ZLxGqGQIxE2xhIc0rsvI+0WciMUfwahMYzwfjhPAnRxfCl7ugt5GWij1l
X-Gm-Gg: AYBFou141HeIsbKZOpU+pBH8nlV5VVJ0RNhckYA02T7v8N7cQgWKrecmXTmK6Gn/ss9
 Kci2pjsNkqY6zc41QQDCATHctVKTA4Beh/2zV8MnbaWARgNkHc/hkA/NQG5QE4+snfu1GqrR6DQ
 HO0A6nfsJVQfpk8vatnk2QShJDNnMTkDcr+iy5FilF+nakRTFVMbaR+z98q9aw7nLZQVKFFcnHk
 MBocBUZ22B4D0y8L3eRXsskrZ8YQltCa2GOE9/e4QzAzpWmeHWfESyAv1v7dG5d1xsb9TChDIRq
 H/vnyV6KVTSg3giKdoT0pEqZwJlFFTclx2DBrN7JGLk17tyz9bC5m7e9xLxXBJ62CeTZaVHB44C
 EsOUSVItshrbQWUTFB33BfTBdY49bAYtrUEOG/LQCpKWL
X-Received: by 2002:a05:600c:348f:b0:4a2:be6:60aa with SMTP id
 5b1f17b1804b1-4ac17d16b14mr238365875e9.10.1793630006040; 
 Mon, 02 Nov 2026 06:33:26 -0800 (PST)
X-Received: by 2002:a05:600c:348f:b0:4a2:be6:60aa with SMTP id
 5b1f17b1804b1-4ac17d16b14mr238365355e9.10.1793630005670; 
 Mon, 02 Nov 2026 06:33:25 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.142])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b77f06sm20296586f8f.21.2026.11.02.06.33.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Nov 2026 06:33:25 -0800 (PST)
Message-ID: <701ea8c8-9a79-4363-8e1a-2e85ababfd5b@redhat.com>
Date: Mon, 2 Nov 2026 15:33:23 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/usb/hcd-xhci: fail Address Device when the DCBAA
 entry is unreadable
To: Junjie Cao <junjie.cao@linux.dev>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-stable@nongnu.org
References: <20261031033725.1275414-1-junjie.cao@linux.dev>
 <20261031033725.1275414-2-junjie.cao@linux.dev>
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
In-Reply-To: <20261031033725.1275414-2-junjie.cao@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 31/10/2026 04.37, Junjie Cao wrote:
> xhci_address_slot() ignores the result of reading the slot's DCBAA
> entry. When that read fails the output context pointer is whatever the
> failed read left behind, zero for unassigned memory, so the slot and
> ep0 contexts land at guest address 0 and the command completes with
> Success.
> 
> Log the failed read and raise HCE, as the context DMA helpers do, and
> return TRB Error, as Address Device already does for an unreadable
> input control context. xhci_die() only flags HCE and leaves the
> controller running; the HSE and halt of xHCI 1.2 section 4.10.2.6 are
> not added here.
> 
> usb_xhci_post_load() reads the same entry; a failure there now disables
> the slot, as an unresolvable slot context already does.
> 
> Fixes: 62c6ae04cf43 ("xhci: Initial xHCI implementation")
> Fixes: 37352df30fbc ("xhci: add live migration support")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4706
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
> ---
>   hw/usb/hcd-xhci.c | 41 +++++++++++++++++++++++++++--------------
>   1 file changed, 27 insertions(+), 14 deletions(-)
Reviewed-by: Thomas Huth <thuth@redhat.com>


