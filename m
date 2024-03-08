Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30AC8C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 16:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricpt-0005w9-R5; Fri, 08 Mar 2024 11:12:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ricpf-0005qE-Po
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 11:12:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ricpd-0008FE-97
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 11:12:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709914343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vT/gUmtTEoi5r7THyV02kBbwLoflnsW97aqYq/QYLnw=;
 b=ahUZljCwNl26dSiHfabbNCp6fnzpBg5LbcJDyiRp3sUcRXv5LN2emanKNexswtNwSVXPwa
 lh+14DNWfQLQZGqAz+gLef8dl0bPwdDQMFDl1PFFnp2FxJKWx3p5Cw5xqdR+ZOzDdbSnJD
 cafTc0EnrNSlZ5GHGdvmqSxioBIUJ9o=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-xUrmJxD1OjyC2qXqhmzb2g-1; Fri, 08 Mar 2024 11:12:22 -0500
X-MC-Unique: xUrmJxD1OjyC2qXqhmzb2g-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-788228e459dso108469385a.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 08:12:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709914342; x=1710519142;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vT/gUmtTEoi5r7THyV02kBbwLoflnsW97aqYq/QYLnw=;
 b=XbtXA4W0VB44GB9OaE/tqOGfKVXzA2dTsIbh52m3GoMzb/+Y4wfO6R+8AJCMg2gwTr
 Ze/rr1cNY1SPIlKAXDijBAqjTA3YK53xnba6KLFnc9tEQDgxRMKN51Ax1IITVom6c6TZ
 pfphvZnSonYxvs4h72+z0f6fDFNaZ/AftyscLZFHhAI83+ZnEGPB0rI7A8MsH++USZwv
 oppiPFcuJ3FB0/ZFwSSI68gZ+2gZkPOFZFiV2ChWmIrpjRcmXuj5kN1QG7yHy+LVx24U
 4slbQn4RGI3Wtssgod07RVvogMqz9c46LDoMIrAYrZuuoZxpyUcKXRsNvC+H49lwD2GH
 UHvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLcuiuJs8N97wcHlUqHXxg9KQ8f4MU3L39VQN8fhNFNytvfQFXOU0/6ZWx7YrFXTCLkGmSeaAzU0MFdkhQOCmMhdW32kk=
X-Gm-Message-State: AOJu0Yy9BIhDRfXxtGJfUqMn43197pld6Amfvq5TegrFD0mBTYAzMlNw
 xyqWYT15SdfkA9UVe7UelEoD6LWRkPpqlDr3bvp1rSUoz3HwyWrQR9+8kSHS74rBIxcPaUtc3dI
 JESPReNAWDn7FzPHqX/hChrfkR9A8cHlwCGHqRVEDpc+XLkozokLm
X-Received: by 2002:a05:620a:1a0f:b0:788:1f41:1ead with SMTP id
 bk15-20020a05620a1a0f00b007881f411eadmr13953387qkb.31.1709914341819; 
 Fri, 08 Mar 2024 08:12:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyDA/VpSnRRTWiL3AT7IY5aRG9Uu7KJQ61uU5JMk/WrHrWZTJ7kBtI6GogC8dT405EU5xlwg==
X-Received: by 2002:a05:620a:1a0f:b0:788:1f41:1ead with SMTP id
 bk15-20020a05620a1a0f00b007881f411eadmr13953367qkb.31.1709914341533; 
 Fri, 08 Mar 2024 08:12:21 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-151.web.vodafone.de.
 [109.43.178.151]) by smtp.gmail.com with ESMTPSA id
 vq5-20020a05620a558500b00788242166dbsm5872805qkn.133.2024.03.08.08.12.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 08:12:21 -0800 (PST)
Message-ID: <995e17f7-4965-4e7e-b039-a2b646b5397f@redhat.com>
Date: Fri, 8 Mar 2024 17:12:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/13] hw/core/machine-smp: Deprecate unsupported
 "parameter=1" SMP configurations
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 qemu-devel@nongnu.org
Cc: Xiaoling Song <xiaoling.song@intel.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20240308160148.3130837-1-zhao1.liu@linux.intel.com>
 <20240308160148.3130837-3-zhao1.liu@linux.intel.com>
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
In-Reply-To: <20240308160148.3130837-3-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
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

On 08/03/2024 17.01, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Currently, it was allowed for users to specify the unsupported
> topology parameter as "1". For example, x86 PC machine doesn't
> support drawer/book/cluster topology levels, but user could specify
> "-smp drawers=1,books=1,clusters=1".
> 
> This is meaningless and confusing, so that the support for this kind of
> configurations is marked deprecated since 9.0. And report warning
> message for such case like:
> 
> qemu-system-x86_64: warning: Deprecated CPU topology (considered invalid):
>                      Unsupported clusters parameter mustn't be specified as 1
> qemu-system-x86_64: warning: Deprecated CPU topology (considered invalid):
>                      Unsupported books parameter mustn't be specified as 1
> qemu-system-x86_64: warning: Deprecated CPU topology (considered invalid):
>                      Unsupported drawers parameter mustn't be specified as 1
> 
> Users have to ensure that all the topology members described with -smp
> are supported by the target machine.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   docs/about/deprecated.rst | 14 +++++++++
>   hw/core/machine-smp.c     | 63 +++++++++++++++++++++++++++++----------
>   2 files changed, 61 insertions(+), 16 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>



