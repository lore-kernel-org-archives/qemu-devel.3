Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A27EE208C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 11:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voK6B-0008MB-D3; Fri, 06 Feb 2026 06:34:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1voK6A-0008Lp-Cr
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 06:34:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1voK69-0002Bz-0B
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 06:34:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770377644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Uvyu2IECIc8WkjrAV0IFDx806jN77eG/w1ozE6jV0X0=;
 b=agHwCZE6rTkJk78RRha7kPFZaB0ljPwHLR6A64f8p9BO7OuyOl2UJRuYjKZZxVadecq1eL
 MgmInIBrpd9BUvduWwT19+shpRbNTrbr3EMAIupiDYDaiqh6x5duF8LTLARPlDnr9cLcfm
 XSd1teBwbO6k91TvoEqr0Q97EIw669k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-GW_9KaPqOcyY8DIrnKDK2g-1; Fri, 06 Feb 2026 06:34:00 -0500
X-MC-Unique: GW_9KaPqOcyY8DIrnKDK2g-1
X-Mimecast-MFC-AGG-ID: GW_9KaPqOcyY8DIrnKDK2g_1770377640
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42fd46385c0so1138749f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 03:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770377639; x=1770982439; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Uvyu2IECIc8WkjrAV0IFDx806jN77eG/w1ozE6jV0X0=;
 b=S1hpOP3g7weLxs6jAGLn/yOZR7Vb3Ux6G7k4dWL4W3YFv/kjLICR2vfqps1BfYLDR5
 zrpVdKzSwIFm8uGkEOpfu4auW9OH6xR+FRHYkpTSbskLLqfv7R3Ch3pQDb6P3htjqA2m
 5A73aUh6LT3flvIBuefhlSGv9Bi3DatpThkFIQiIOVwA4wq7tRvH586azB7uCSwUIc2L
 qHlGly4Bg7QTGkghsSmYRj0uqo11kvM0FSLKwB9C/3weRjIZLJUtVkjuAukG35fbRnR4
 6wRAeW5Tf7Ll6uqseUB4CdwumwI8XGZ+OQZOL52ImwkHxUYMleooTjVXoFIx7TTTMjpG
 oYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770377639; x=1770982439;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uvyu2IECIc8WkjrAV0IFDx806jN77eG/w1ozE6jV0X0=;
 b=IdplN/d1fQlwCHHweLTlaAOrweXHsExD8OngzuascRmSBg8BS0lVqic3RVLSdazjMd
 CnT9jkCdhS6IAeqVuvMUvkD3Wsa48sxPjFqPXNAVkcCUiu3YK0H1eeIVSWZ8xVzcFGlX
 KrqldQSOMiMMkC9l+mItOEbrENlGRWi0QpZjXHfRtHgVAtpA0pHHgZRnqKwtWIr2Wu0k
 EivhC8YjhC5nvdRRY/l9YJzjEwCjUJSvwhZJL1vM35vVFcp8IHlbaGhRupsRwL8/5GEF
 Vtf/wAsCSVQU/lxA3MA318lFB2IjQASn6h/kxnsEscn+oFVey2AB2vJbE+PxUE1ebaJc
 Ipuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf0CiGyV30xcQoq5+TCOEBYeU35ibJ0CJ0B1uonUwBkPjFvpKxCKwZCNj4DGgir/4foCNsiucSIVHm@nongnu.org
X-Gm-Message-State: AOJu0YwjoZK3nY8OQbYpvP+FcMvJtonL6XSKmHxl6jsQzACkBpdO8IiO
 4ymTyLwxvQOIzXmmBdK0MDsRQWt0EV3A+lGD4wPT+K5N7TJMSEMZoR4QOY1OWhV/dqRCMjcPepn
 hMRmB+w74zWb6xiYAlswL/EkJww3+GUdeiRsfXbSChgrBKPP4YFvu+lmLVXuVOFza
X-Gm-Gg: AZuq6aLKExCukPCoXzDAO6tFTfJnfPa+bfeGKCeH8yECUYnlk6n+RNCbhow5LvtfGi+
 1hnL2eGb9B1iVS/0CcwZuC+ArOgz3sYYY5FzN/CK+KBJ4V3XslhN+no3nnKEayIn+ePy1rQopbM
 smbZVhtdfkLwFjDs/L1gMhQEDWrhgzgQvQEwIAl9aXS2gdUhrsv+Grz2MbkBKAanP0WQnXQfD1n
 RsvPMlBSqA//gAKKaFHGnmc9GgCskGYvdqIabivbWBhEphiiIeaZd5j/oRiP2FHoJjCn97YwxCn
 VDE7O7gAX8eg58bHELkVZHLfCrTPzMYPoFikkcegSm3Ph2wQTRoTb+aApy62lAXEeO31LvGFMtq
 ZR11Tq8Y=
X-Received: by 2002:a05:6000:200e:b0:435:aecf:9674 with SMTP id
 ffacd0b85a97d-43629691c17mr3309616f8f.55.1770377639469; 
 Fri, 06 Feb 2026 03:33:59 -0800 (PST)
X-Received: by 2002:a05:6000:200e:b0:435:aecf:9674 with SMTP id
 ffacd0b85a97d-43629691c17mr3309581f8f.55.1770377639099; 
 Fri, 06 Feb 2026 03:33:59 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.203])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4362975ac28sm5428177f8f.42.2026.02.06.03.33.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 03:33:58 -0800 (PST)
Message-ID: <9676a3b7-9da8-47b7-bc15-18e12ff778ca@redhat.com>
Date: Fri, 6 Feb 2026 12:33:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel: s/most/most recent/ ``probe_target_compiler``
 call
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260114102522.4044591-1-alex.bennee@linaro.org>
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
In-Reply-To: <20260114102522.4044591-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 14/01/2026 11.25, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   docs/devel/build-system.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
> index 35c77343914..71331e64ac8 100644
> --- a/docs/devel/build-system.rst
> +++ b/docs/devel/build-system.rst
> @@ -88,7 +88,7 @@ and operating systems:
>     ``$target_ar``, etc. to non-empty values.
>   
>   ``write_target_makefile``
> -  Write a Makefile fragment to stdout, exposing the result of the most
> +  Write a Makefile fragment to stdout, exposing the result of the most recent
>     ``probe_target_compiler`` call as the usual Make variables (``CC``,
>     ``AR``, ``LD``, etc.).
>   

Reviewed-by: Thomas Huth <thuth@redhat.com>


