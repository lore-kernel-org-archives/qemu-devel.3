Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AE7C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 08:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEkoz-0007VW-JI; Tue, 13 May 2025 04:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uEkoy-0007VF-BF
 for qemu-devel@nongnu.org; Tue, 13 May 2025 04:17:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uEkow-0004UL-6N
 for qemu-devel@nongnu.org; Tue, 13 May 2025 04:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747124220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TtiueEWiZviwIh7GeF47XQVseYGD54OAElPbnCaybHs=;
 b=WK9qQCPpKPn5Z50a8J4TwQa5jJHbhVZGcUOAu7trHSc3Wr1xnyOxgBsCYhT2+N5dR16WXO
 BSvSqMLZuN1H+pvlcREthTFqUBKqnbtmcXhKtxj8+W9cbtgt9pB9KeKx1685nCYtUd3JXo
 bjZXQ6MkqphFx/Evj7tCg5vrkZ7UDuE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-J_2PwKmYOXi9tzgf6siQJw-1; Tue, 13 May 2025 04:16:58 -0400
X-MC-Unique: J_2PwKmYOXi9tzgf6siQJw-1
X-Mimecast-MFC-AGG-ID: J_2PwKmYOXi9tzgf6siQJw_1747124217
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d5ca7c86aso25380305e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 01:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747124217; x=1747729017;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TtiueEWiZviwIh7GeF47XQVseYGD54OAElPbnCaybHs=;
 b=ioFcTw1WVivJZBf67bnHWdNLL+cSSvUW5q+ATej3PRwXc2BYCIjsM4LhZ5ZQvcGPK6
 QVkJ/x6Z4NSSC0qfwHwvwJDutT9t7pNFSHcM/IAmj2D8+YZiERtkOKWu/AzIMIobX8Vs
 8UIMwgHGH0CCx4rY0wds/zljJMbRQHFQ0y1QLB15FbZS9x7LgQ6YcM9UVZcbug66109B
 XnssPv1RJH4WH42Qx8hAmDTPop9UBKEJeyXRV84hqzclbpxtAmJiXlDEeFQ9o2KHriy9
 qpy+ORO+l10KCJ1j7ESJjetMMzcwUIeT/c1Pp7RH3w5Ki1vlednyMq3YG8ijTswYYAQY
 jHMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmjKN0Aj9XxqUDQ6StfC/RP/FwBBb2HN+9aPzpeAnzZKwb8kWWBBSMH/eBsUhPtd2kuQX8kGq1kIZY@nongnu.org
X-Gm-Message-State: AOJu0Yw7RpArHuOzanb/72ulO+JyFZk9tRB5nLPcEeUeuImUAv9U2/8J
 ebkGL9wshjerI+v32lt0WGtTzt4JdjtJIG2X40/jENmwLJ6mmqkcniDwPJYpWxVxe9c27mXsGA9
 1LGT+i0FfTw2HUBuTiAiAtr3k4gF1wCuYtKb/7UPS/EzIHUIeoUeV
X-Gm-Gg: ASbGnctGsrK5x9QQ6wENaDpbd9VjuiOLUX9K5NXiAmkggPP4l0OVOlLlD4zy2DAx9Gc
 VTOTRbTwdOj/NQTKPocp6fzuoqtVUFJwPOU3bm09dEYs1rcswN6QCtL2otxYZCqJlzqSKnKjH/m
 lfj3t5mKkz59Q2kYdaVusZ5qbGlYG7jEu7g/u8jt4XfgSXFPg8p/5Se/BM25Nx3sMOrzrD4dId8
 6TPAFRBTLxiVeETuMe7lVNWXBOqxXZ4BKMohoAIk1MVnxhpZoGjSXDgrv7G2REGkKjiXpwoAFN+
 ftc5P0MEBHUTeU3ud9vtln4w6lSQKvhV3cPvo+GBJyc=
X-Received: by 2002:a05:6000:1a87:b0:3a2:6b2:e558 with SMTP id
 ffacd0b85a97d-3a206b2e7cbmr5897787f8f.28.1747124217057; 
 Tue, 13 May 2025 01:16:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfPswOblyV4cGUNvCcq/Q0I9l2BJEKA8SVRI8+dxfH2dwpsY8l/tUTVbBanGOyi9wgYHInKA==
X-Received: by 2002:a05:6000:1a87:b0:3a2:6b2:e558 with SMTP id
 ffacd0b85a97d-3a206b2e7cbmr5897756f8f.28.1747124216678; 
 Tue, 13 May 2025 01:16:56 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-48-129.web.vodafone.de.
 [109.42.48.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58f2ab2sm15094625f8f.46.2025.05.13.01.16.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 01:16:56 -0700 (PDT)
Message-ID: <fee40b62-a98c-46d4-baf1-d108da775c9c@redhat.com>
Date: Tue, 13 May 2025 10:16:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to mark internal properties
To: BALATON Zoltan <balaton@eik.bme.hu>, Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Yi Liu <yi.l.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Yanan Wang <wangyanan55@huawei.com>, Helge Deller <deller@gmx.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Jason Wang <jasowang@redhat.com>
References: <20250508133550.81391-1-philmd@linaro.org>
 <20250508133550.81391-13-philmd@linaro.org>
 <23260c74-01ba-45bc-bf2f-b3e19c28ec8a@intel.com> <aB2vjuT07EuO6JSQ@intel.com>
 <2f526570-7ab0-479c-967c-b3f95f9f19e3@redhat.com>
 <CAFEAcA-kuHvxjuV_cMh-Px3C-k2Gd51jFqhwndO52vm++M_jAA@mail.gmail.com>
 <aCG6MuDLrQpoTqpg@redhat.com> <87jz6mqeu5.fsf@pond.sub.org>
 <e5a305cc-4c8b-48df-99fe-539ebd9b72f9@intel.com>
 <f342557b-e589-f51d-cfd8-04f97e9c5efd@eik.bme.hu>
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
In-Reply-To: <f342557b-e589-f51d-cfd8-04f97e9c5efd@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
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

On 12/05/2025 16.41, BALATON Zoltan wrote:
> On Mon, 12 May 2025, Xiaoyao Li wrote:
...
>> We need something in code to restrict the *internal* property really 
>> internal, i.e., not user settable. What the name of the property is 
>> doesn't matter.
> 
> What's an internal property? Properties are there to make some field of an 
> object introspectable and settable from command line and QEMU monitor or 
> other external interfaces. If that's not needed for something why is it 
> defined as a property in the first place and not just e.g. C accessor 
> functions as part of the device's interface instead? I think this may be 
> overusing QOM for things that may not need it and adding complexity where 
> not needed.

Maybe some things could easily be simplified indeed, but for some others, 
it's currently the way it's deeply rooted in the logic of QEMU. Have a look 
at the hw_compat arrays in hw/core/machine.c ... it all goes via properties, 
so there is certainly no easy and quick solution for this.

  Thomas


