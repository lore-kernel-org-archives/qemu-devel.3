Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49B1C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 14:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVC0S-0001v4-RR; Wed, 31 Jan 2024 09:56:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rVC0O-0001tE-H9
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 09:56:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rVC0M-0001aw-Jq
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 09:56:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706712957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aeSPJps2+csxl2Of5ZglruBbV7a0AjSJrm8zP7O7xfk=;
 b=YgJbjqrckWAqtucXzsfeyefvil75rgKS/fDmqvcv1fVqMamvPw0Npi0nrlmhkZ3xrKs0zw
 6p7bdcnWpcHgadR2X8dVBWY0hEo+senb4hBw0qaUjo37kdZVZQJfwR47W7RWAK/uQq97J0
 FkK1G2g6btjbNn5D5MqvCqD9HOGlcGA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-le0J8c6LMu-D2z9tK11ejQ-1; Wed, 31 Jan 2024 09:55:55 -0500
X-MC-Unique: le0J8c6LMu-D2z9tK11ejQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33af105d951so1330462f8f.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 06:55:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706712954; x=1707317754;
 h=content-transfer-encoding:in-reply-to:autocrypt:cc:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aeSPJps2+csxl2Of5ZglruBbV7a0AjSJrm8zP7O7xfk=;
 b=C2V2kU1NqEMTdEnIiTIU+8Ps/MgVRRWTYcWtfwOhk6b9Wy0hQdqQOpMH/wZ0M+I63S
 uZHHCymM4GfUpgqfbfst/2+vwiHPUbkkiFeLLtiJzoLh7p4OkNhJQ7+ilKxq5FWyKnCB
 8yjY/n41QgnbvZOpr6veQpZEHyn9+P1atNDLB3yZc3aPvzBy4Pekcxv9uZg9R4z2vbL1
 hh+2TPL8TEj07QYPqWNTcQwV/2wxR1Pvhx+/VHfvyhWGFoHUMkqQtGn4t7T+3xQp05vU
 uZ/X9n+4sIqH+xvRj5972eCclDacHrAY461bQU6TissEL1+NbAJaPSMLWEy5cEswtdzJ
 70xg==
X-Gm-Message-State: AOJu0YwFP9YR0lKQ4pXNNQ1pmP/gYZxXdvEfgmu84wOUliVe20KRLpfF
 yl1tt29glkBr2C+O9JfUkmL2AzZFvTg91wSz0aFLs2ZOJ9jM7yFSoKeBFZ9ggBWUi6BmTaiPbzq
 pd8s8ruJ03P3soLL7zc3mU0tuTOCB5rjijSmn7AO0Ke9pFxywJehU
X-Received: by 2002:a05:600c:444e:b0:40e:f693:94f6 with SMTP id
 v14-20020a05600c444e00b0040ef69394f6mr1479943wmn.35.1706712954672; 
 Wed, 31 Jan 2024 06:55:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGLRL0CYpvP4g+M5rBngMHm/IqCRwcMqSvfdCJ8v83+Aj2mWCZv26iJJcxtCjSCQwaDzNlmA==
X-Received: by 2002:a05:600c:444e:b0:40e:f693:94f6 with SMTP id
 v14-20020a05600c444e00b0040ef69394f6mr1479933wmn.35.1706712954310; 
 Wed, 31 Jan 2024 06:55:54 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-177-196.web.vodafone.de.
 [109.43.177.196]) by smtp.gmail.com with ESMTPSA id
 x11-20020adfec0b000000b0033afc875fd5sm4230059wrn.49.2024.01.31.06.55.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jan 2024 06:55:53 -0800 (PST)
Message-ID: <8d7f3b7a-67d9-4683-ba2c-9f2af1dddb91@redhat.com>
Date: Wed, 31 Jan 2024 15:55:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Enable -Wvla, forbidding use of variable length arrays
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240125173211.1786196-1-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Cc: qemu-ppc@nongnu.org
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
In-Reply-To: <20240125173211.1786196-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 25/01/2024 18.32, Peter Maydell wrote:
> For a while now I've had an on-and-off-again campaign to get rid of
> the handful of uses of C variable-length-array syntax in our
> codebase.  The rationale for this is that if the array size can be
> controlled by the guest and we don't get the size limit checking
> right, this is an easy to exploit security issue.  (An example
> problem of this kind from the past is CVE-2021-3527).  Forbidding
> them entirely is a defensive measure against further bugs of this
> kind.
> 
> I submitted a bunch of patches to this effect last year, and
> the result is we're now down to just a single use of VLAs, in
> a test program. This patchset removes that last VLA usage,
> and enables -Wvla in our warning options, so that we will catch
> any future attempts to use this C feature.
> 
> thanks
> -- PMM
> 
> Peter Maydell (2):
>    tests/qtest/xlnx-versal-trng-test.c: Drop use of variable length array
>    meson: Enable -Wvla
> 
>   meson.build                         |  1 +
>   tests/qtest/xlnx-versal-trng-test.c | 19 +++++++++++--------
>   2 files changed, 12 insertions(+), 8 deletions(-)

There's still a vla left in the ppc kvm code:

  https://gitlab.com/thuth/qemu/-/jobs/6063230079#L2005

../target/ppc/kvm.c: In function ‘kvmppc_save_htab’:
../target/ppc/kvm.c:2691:5: error: ISO C90 forbids variable length array 
‘buf’ [-Werror=vla]
  2691 |     uint8_t buf[bufsize];
       |     ^~~~~~~
../target/ppc/kvm.c: In function ‘kvmppc_read_hptes’:
../target/ppc/kvm.c:2773:9: error: ISO C90 forbids variable length array 
‘buf’ [-Werror=vla]
  2773 |         char buf[sizeof(*hdr) + m * HASH_PTE_SIZE_64];
       |         ^~~~
cc1: all warnings being treated as errors

  Thomas


