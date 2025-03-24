Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13676C36008
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 06:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twbFL-0003PE-Fj; Mon, 24 Mar 2025 02:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1twbFG-0003OP-G6
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 02:25:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1twbFB-0003iO-Na
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 02:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742797504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=o7yro2ewmPxDuWq1VEmeEJLhfIhUk3+GJMzodbI33V8=;
 b=BiRuQAhO9vhvON1bQCJBJE+rahXwEFp8LoBd5LOfeHG0lnBDw4GPUwsNS+FyOOMZxRqgzN
 UUvTO6v4/oNvupouHg8gBnxJN9NG9rsygC/Q82xGORLrNdjH4MRva2TQ3UJLSd+WVG+8kB
 M3TEVdHla1ST/gBQmImBY0G6UbNo1JE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-PiEy388ZMwCqsPygoT6eWQ-1; Mon, 24 Mar 2025 02:25:02 -0400
X-MC-Unique: PiEy388ZMwCqsPygoT6eWQ-1
X-Mimecast-MFC-AGG-ID: PiEy388ZMwCqsPygoT6eWQ_1742797501
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ac3df3f1193so284285066b.2
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 23:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742797501; x=1743402301;
 h=content-transfer-encoding:in-reply-to:autocrypt:cc:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o7yro2ewmPxDuWq1VEmeEJLhfIhUk3+GJMzodbI33V8=;
 b=HiTJgk7EEsoBHLKxQprcy8WFmKaEfZpvr4TI2IcMYFKf/qxxPdDODaaYviVtjtc4Ff
 3dvLiOLjYlqgAv5TVRbniAaMAk8RR4xyzGHzC5xpnpbYPNrAN+QQKNfWttG92OtMtZAv
 Zs6Lzh+x7meiIEzie2/XFht46GZuN7x3/Gnk272n3JWM6jOkDZIh3esxw+Hv5aga7rJ2
 6TqeSvWtv+Bll10+TilGCZzUvP5+axYadd60RklbQNZYYtaRWC1RxkyQTczeWGPWPPDU
 FuLihaDTn5EbN2MEkw6X9vEE7XUWqhSVJMvUf2CzlK/wdnd9fCe2AKqABNYfdxbRUw/f
 +HnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNva/c2N/Aabu4ozZnUk2FseHYoCTBUwQjvchJqVYzbd2RSJy6sdtVKSNGKpm255NisdOmMOtd4tpB@nongnu.org
X-Gm-Message-State: AOJu0YxwnNSMVAO53kKDxK9yykJQD1Enfrx5fMbKmt4VIAxXNMo7+Yyd
 TgOCZcxfizmHeOSTWKioP9pYibgj+F+EJXUtBSpQuRexOuLQGXa8mQs0/dZQQeZdsla6qoUfrg9
 bAzA9sEWdYUmY3x6dNThNcO/sCyhA4uRcNOySzyJ2A6Ffs18T8wpl
X-Gm-Gg: ASbGncs66RMoiIR/zhOp7x4U5DMwzIBqtlr24EUvphKvbnMkrMdZ2kr7v8/ZRCd86ws
 wq65d6UE9NqD98M7nN1ZAx9/pDC/02JfnqF68kQSCRIiNqMuosKugt9Jzgf33+XKwKOtzhpDj1j
 EU8Y72A8f8KgS3XEvN/e6GjHS2a5rwgKFgOZGS7XOnCzAd/4T8IId6K2lNH9unqfqBar4rVFX0o
 bL+xfcyAvTqhZhUc6oN+Oz+mIJm1yBMkjprsSaDAKmp3VNmtMAaEd7AfDvdg17Zp7NvMfwICCxA
 OmW+kZXZnjhBZddsqzuukOXbt5+jxEuVjEDXVHIPvA==
X-Received: by 2002:a17:907:9482:b0:ac3:10e3:7fa5 with SMTP id
 a640c23a62f3a-ac3f20f51cbmr963894366b.21.1742797501296; 
 Sun, 23 Mar 2025 23:25:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHz8M+JwrrwtcwEoZ8r/UjlHEFdHnHtztmQ2TTIzsbZQy3GYhV29YaDnAdI9ZgQsHnlXs5ww==
X-Received: by 2002:a17:907:9482:b0:ac3:10e3:7fa5 with SMTP id
 a640c23a62f3a-ac3f20f51cbmr963893066b.21.1742797500885; 
 Sun, 23 Mar 2025 23:25:00 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-50-2.web.vodafone.de. [109.42.50.2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3efd8f37asm626899766b.179.2025.03.23.23.25.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 23:25:00 -0700 (PDT)
Message-ID: <c82ea7ec-7f53-4113-a4ee-95d215522d4d@redhat.com>
Date: Mon, 24 Mar 2025 07:24:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smbios: Fix buffer overrun when using path= option
To: Daan De Meyer <daan.j.demeyer@gmail.com>, qemu-devel@nongnu.org
References: <20250323213622.2581013-1-daan.j.demeyer@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
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
In-Reply-To: <20250323213622.2581013-1-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 23/03/2025 22.35, Daan De Meyer wrote:
> We have to make sure the array of bytes read from the path= file
> is null-terminated, otherwise we run into a buffer overrun later on.
> 
> Fixes: bb99f4772f54017490e3356ecbb3df25c5d4537f ("hw/smbios: support loading OEM strings values from a file")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2879
> 
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> ---
>   hw/smbios/smbios.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 02a09eb9cd..ad4cd6721e 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -1285,6 +1285,9 @@ static int save_opt_one(void *opaque,
>               g_byte_array_append(data, (guint8 *)buf, ret);
>           }
>   
> +        buf[0] = '\0';
> +        g_byte_array_append(data, (guint8 *)buf, 1);
> +
>           qemu_close(fd);
>   
>           *opt->dest = g_renew(char *, *opt->dest, (*opt->ndest) + 1);

Please make sure to put the maintainers on CC: (done now, for the next time 
please see the MAINTAINERS file or use the scripts/get_maintainers.pl 
script), otherwise your patch might go unnoticed.

  Thomas


