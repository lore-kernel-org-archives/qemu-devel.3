Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6768C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 07:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfacy-0004qI-Sx; Thu, 29 Feb 2024 02:14:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rfacw-0004pF-53
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 02:14:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rfacu-0004x6-51
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 02:14:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709190881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bpmErMJ5rAXVBJRHDqnSobGSBAJ7lTd5CBRax2AFj7E=;
 b=VfJyjuPNuxFrLjyvoYAGi3QXFS6XidUTEXoJ1ukNDfvLvbXxUEJNDE4WH/XvL1KVMQV3Hn
 BN3QWDjKpfkkSDS50aMzcpmFhOAOq7Rib03ZHyv5qFiw0qt/mkAKPUAr6wmtoUEouBlHDV
 SwHikmJjZGSzNDv51eURMFvDvmb7QXY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-sgxBeGVqPPOq6JZa8bMdOQ-1; Thu, 29 Feb 2024 02:14:38 -0500
X-MC-Unique: sgxBeGVqPPOq6JZa8bMdOQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-68fd00ac245so5497866d6.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 23:14:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709190878; x=1709795678;
 h=content-transfer-encoding:in-reply-to:autocrypt:cc:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bpmErMJ5rAXVBJRHDqnSobGSBAJ7lTd5CBRax2AFj7E=;
 b=HLiAn+CRhwbunO26OdgShrB7i2h4Kb9XcL7/Eoc53LELM+3u19ebdvbbojs5MXWf5/
 ScygrfnyuovuS1KUeSlsQ8Ej+fkcdXhOqRgQcF2t5ICfGdDuBeqk9Yw3DCSqGtsIA+BF
 rOnzBeQQKfxQ2DwX32HKM7SLYpP8+HkCuh0sZyLuG1oL/phL2UZ/YD6cn/GJEjEWJBVT
 AcyIanvakJ8Z3Kr2q+Hg6UTue+FkawkUpFzUH4DCPzdFfHYKhYjgOGl5Evsfb4Vxl+bN
 VrF4ujochbphzj3EkOKnEMsHIh6cbY0wf+vS5buj5v9q29tg3SA0nCIrWzsVOL04YdZC
 oBGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuKYpmAGA5Za5Tss8GcvZBrraxKSbhmTA8wLhtnUQ4QZ9OxXzik2TK5lejT3cWwrU+i8uVpZgbT9IA/RHNP0031SH5UrU=
X-Gm-Message-State: AOJu0YyrYU027XLGN2k6GfTjo31l5eA8KSmCkNeiCdtZYCc4HdzCA29Y
 Blv97Q+KPuUtU4Tax4rFwRutyyQodKHRS4qcBN2MIt1lRgRtN/U6MQy0p+COryQCRLGf96WtLrE
 MXQfh+AWlcHQgnAvI60s9dGgTJOnUeS1VjstsWiULP4nLGmH15IBaLdK9LFlU
X-Received: by 2002:ad4:57d0:0:b0:690:46bf:13a5 with SMTP id
 y16-20020ad457d0000000b0069046bf13a5mr965732qvx.18.1709190878225; 
 Wed, 28 Feb 2024 23:14:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGL70qy1Ep50ZY3zF0k0rQd4XIgQHei8Z2P4DMEAUnItmrCs3EH/jg4hRjuoMQbRns5sTdXCQ==
X-Received: by 2002:ad4:57d0:0:b0:690:46bf:13a5 with SMTP id
 y16-20020ad457d0000000b0069046bf13a5mr965728qvx.18.1709190877944; 
 Wed, 28 Feb 2024 23:14:37 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-133.web.vodafone.de.
 [109.43.178.133]) by smtp.gmail.com with ESMTPSA id
 f13-20020ad4558d000000b0068fe4969e23sm439072qvx.87.2024.02.28.23.14.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 23:14:37 -0800 (PST)
Message-ID: <b333af78-88f8-4fc1-8d13-945e51d4bc55@redhat.com>
Date: Thu, 29 Feb 2024 08:14:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ISO C90 compilation error
To: Paz Offer <poffer@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <MW4PR12MB6997B8D6225D08E8F3E2DE55A05F2@MW4PR12MB6997.namprd12.prod.outlook.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
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
In-Reply-To: <MW4PR12MB6997B8D6225D08E8F3E2DE55A05F2@MW4PR12MB6997.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
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

On 29/02/2024 08.03, Paz Offer wrote:
> Hi,
> 
> I am trying to build my code with QEMU and getting compilation error 
> according to the /ISO C90 /standard:
> 
>       const size_t buf_size = 31;
>       char buffer[buf_size + 1];
> 
>       error: ISO C90 forbids array ‘buffer’ whose size can’t be evaluated 
> [-Werror=vla]
> 
> I noticed that the code builds with '-std=gnu11', which is newer then C90, 
> so this is not clear to me why I get this error.
> Where is the correct place to specify the language version for this?

The "ISO C90" part of the error message is quite misleading here. It's 
rather that we explicitly enabled -Werror=vla in our codebase recently:

  https://gitlab.com/qemu-project/qemu/-/commit/64c1a5443528ac09d8cd50f365d6

See the commit description there for the rationale.

  Thomas


