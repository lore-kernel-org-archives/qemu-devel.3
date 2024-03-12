Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AB1C54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 08:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjxHW-0007Ur-Ib; Tue, 12 Mar 2024 04:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rjxHT-0007UZ-Q8
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:14:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rjxHS-0007bB-7e
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:14:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710231277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iZX4ia+kzVCPXL4hnW0xJ/6c7JqvR+7+6nledC+T94w=;
 b=RXdKV9gdLsrz5aC5pckMSD3Cf1DyBHYlC6fSPN3Yf8V+yW8JXOuMRScX7CANhy1GezS2KY
 BXoaPDqSgaUIxeEr5BrkhImkNSL7XjIM3NJwMYzi5Z+lDD0rCJhyY3j19ACxPxdhMZEPgA
 niina+RH0AJNTuEW3zxgAjlS/V8iOIk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-tTFiSVmxPC-12YJ8aLDDyQ-1; Tue, 12 Mar 2024 04:14:35 -0400
X-MC-Unique: tTFiSVmxPC-12YJ8aLDDyQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33e95458c42so1116120f8f.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 01:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710231274; x=1710836074;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iZX4ia+kzVCPXL4hnW0xJ/6c7JqvR+7+6nledC+T94w=;
 b=l73YbEdcHpg/lEy+5zFjbef5jjRfGYaLHPc7pRp1fdkVOYurGxRYatqBRaaPsfLDP2
 eAi3/2rcYXYaJV/+9bndvDM2Tiqr+airQtoktyj0okKM461Ei+yP7BTKm4jb15y26tXE
 FRP4uTcTtqlqgk40WPReorG4+NcTdwctFLnaYAHlfxnZE4JvMxewEcUP+Ua+ZSkn2nIp
 GitQLP3wjM3nlVmMDXdHNapMLGCEYjWMi0EWZSJNo36hA7g3XZYA4UlIZkOfo4cINso3
 3EQownLAYe5uwPGW1TY1u4GFCJdoMvm87kTdtQ9kcK3aY2Ks3/XZKSEI5TMjnH/978YC
 4CBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE1iPv0cjenWHoIuJ9EcyxxLy4KpcuPzN0U31u/4zESfDcF2VZMAXivomXco0MOjvfcvKv/rHZcRdmMmi+cV4uBAvHnpw=
X-Gm-Message-State: AOJu0YwRY97IwWOAlyGUyMImLGkv0/t81D6KrTydOQMFIr2+AWXiMXRl
 C0tud0Z0lG+5rKi+N90Q9qe2WB2WLgyDS9FKd3tUEj05NGN2rTaERwngEwmoDGCRwX4SEp5vPSp
 mLtnMgUbOau1Mi+SixtBIEN+YkcgIHXNaQBz35teBjE3M94nabP/3
X-Received: by 2002:a5d:670f:0:b0:33d:c29d:2219 with SMTP id
 o15-20020a5d670f000000b0033dc29d2219mr718979wru.8.1710231274648; 
 Tue, 12 Mar 2024 01:14:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEf4iGmjVGbZvylraLqlFi+dfW+ed939PTMIfv1LsuVh73dpKT2rNxd1SC9lOGd+PqzRJLQXw==
X-Received: by 2002:a5d:670f:0:b0:33d:c29d:2219 with SMTP id
 o15-20020a5d670f000000b0033dc29d2219mr718963wru.8.1710231274348; 
 Tue, 12 Mar 2024 01:14:34 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-177-86.web.vodafone.de.
 [109.43.177.86]) by smtp.gmail.com with ESMTPSA id
 b17-20020a05600010d100b0033e03a6b1ecsm8403477wrx.18.2024.03.12.01.14.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 01:14:33 -0700 (PDT)
Message-ID: <c663a881-161d-431f-8f56-298dbc1f0f36@redhat.com>
Date: Tue, 12 Mar 2024 09:14:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/29] block/vdi: Fix missing ERRP_GUARD() for
 error_prepend()
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Stefan Weil <sw@weilnetz.de>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
References: <20240311033822.3142585-1-zhao1.liu@linux.intel.com>
 <20240311033822.3142585-12-zhao1.liu@linux.intel.com>
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
In-Reply-To: <20240311033822.3142585-12-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
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

On 11/03/2024 04.38, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> As the comment in qapi/error, passing @errp to error_prepend() requires
> ERRP_GUARD():
> 
> * = Why, when and how to use ERRP_GUARD() =
> *
> * Without ERRP_GUARD(), use of the @errp parameter is restricted:
> ...
> * - It should not be passed to error_prepend(), error_vprepend() or
> *   error_append_hint(), because that doesn't work with &error_fatal.
> * ERRP_GUARD() lifts these restrictions.
> *
> * To use ERRP_GUARD(), add it right at the beginning of the function.
> * @errp can then be used without worrying about the argument being
> * NULL or &error_fatal.
> 
> ERRP_GUARD() could avoid the case when @errp is &error_fatal, the user
> can't see this additional information, because exit() happens in
> error_setg earlier than information is added [1].
> 
> The vdi_co_do_create() passes @errp to error_prepend() without
> ERRP_GUARD(), and its @errp parameter is so widely sourced that it is
> necessary to protect it with ERRP_GUARD().
> 
> To avoid the potential issues as [1] said, add missing ERRP_GUARD() at
> the beginning of this function.
> 
> [1]: Issue description in the commit message of commit ae7c80a7bd73
>       ("error: New macro ERRP_GUARD()").
> 
> Cc: Stefan Weil <sw@weilnetz.de>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Hanna Reitz <hreitz@redhat.com>
> Cc: qemu-block@nongnu.org
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   block/vdi.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/block/vdi.c b/block/vdi.c
> index 3b57becb9fe0..6363da08cee9 100644
> --- a/block/vdi.c
> +++ b/block/vdi.c
> @@ -738,6 +738,7 @@ static int coroutine_fn GRAPH_UNLOCKED
>   vdi_co_do_create(BlockdevCreateOptions *create_options, size_t block_size,
>                    Error **errp)
>   {
> +    ERRP_GUARD();
>       BlockdevCreateOptionsVdi *vdi_opts;
>       int ret = 0;
>       uint64_t bytes = 0;

Reviewed-by: Thomas Huth <thuth@redhat.com>


