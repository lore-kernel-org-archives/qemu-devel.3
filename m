Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4248C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 10:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxPDe-0008MB-TY; Thu, 18 Apr 2024 06:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rxPDc-0008Lo-Fs
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 06:42:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rxPDb-00020t-0s
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 06:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713436933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IXNKvBCYGfqwf7SM2fVSP4SxPXd1Y6oooD+6YcofyXY=;
 b=PFiJe7uYfB36pxIcWtXMTU/civxCqVemdpu8pQynGtcqxInC/Dfej2vpQyXICNqplw8LRG
 BQ3JXuUTaYVzqsJySm59yBEMmEUqg/ScaX6oQjNz3UqqTzhLcpLuF2Szm9dmcan/gV0wOD
 vMEvZOyVXVWSBl7nWxb57upHUeUyd9I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-zDicx8kQM8uI86x7ARxmuw-1; Thu, 18 Apr 2024 06:42:09 -0400
X-MC-Unique: zDicx8kQM8uI86x7ARxmuw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3479b511725so485138f8f.3
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 03:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713436928; x=1714041728;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IXNKvBCYGfqwf7SM2fVSP4SxPXd1Y6oooD+6YcofyXY=;
 b=HOGjDwPsOtGH6/BzlWa2vFlg2Pcvv+Ty/7lxvZcB53dphBQLDtkcHrs9mtBs7uB9K+
 7fD45SdGSRaEQ7cJaLfbuw8kPClXRaHMpBwQZ717IHkojJux2cwEXAmJGIIHx2Xl3umt
 igRQpxU+BbkEyJkvsz5ED7MFUgM4hfedua9Hi18IB4L5A011pjaIfTJSCCyrZfFcP4QZ
 lUARgftZfHvoN3J8QR/V3p9SCLB0/mEcianUG7Xm7EMpVzf/XEc493GtPR6vU2m3I7SP
 JdZMo+nKiQXoTuZwQcUKxtUQj2Z55Ar1wd9WHy+Ti3hYQpvEJMTjIladqFky6SK9PH/H
 LFPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFUpMPCOvXkxurEMOTJvzvcufI1E/g9DsWOWVkqOEy5oA30OCNhVZxd8pl8MPaMPR8dGC1qH3shxiOFDlZ99uh5jwYPFw=
X-Gm-Message-State: AOJu0Yx3HnBV+LbfXj78QORGbKrl7Zd65Zz2vMiGYhdKNLgxhBd3faNl
 ISi07Gt3Rki7HtwvUoKkMSgg7KgTK/3Of9erb0I9Cudu1ydd8p6DjMYyOnO2h4KLuXPQMOlwEvy
 /wKdwaZ1QAEVcmCWFh1vsT6PHXV0QHK1D3Ha4CBscuA0jpEr3iIiL
X-Received: by 2002:adf:fec9:0:b0:349:c50a:ef5a with SMTP id
 q9-20020adffec9000000b00349c50aef5amr1247013wrs.63.1713436928253; 
 Thu, 18 Apr 2024 03:42:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC52RtwPST94ssbolaE5lsJY+ZDxYlGyuraTI8BLky1n7CNDrICGB3qa1dI58F/33fVh/l5Q==
X-Received: by 2002:adf:fec9:0:b0:349:c50a:ef5a with SMTP id
 q9-20020adffec9000000b00349c50aef5amr1246997wrs.63.1713436927849; 
 Thu, 18 Apr 2024 03:42:07 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-177-117.web.vodafone.de.
 [109.43.177.117]) by smtp.gmail.com with ESMTPSA id
 d2-20020a5d6442000000b003479bec98cesm1493453wrw.115.2024.04.18.03.42.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 03:42:07 -0700 (PDT)
Message-ID: <a00f1616-543f-42c0-a5b5-d9eb1a6f56fa@redhat.com>
Date: Thu, 18 Apr 2024 12:42:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost-user-test: no set non-blocking for cal fd less than
 0.
To: "Yuxue Liu yuxue.liu@jaguarmicro.com" <yuxue.liu@jaguarmicro.com>,
 pbonzini@redhat.com
Cc: lvivier@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Raphael Norwitz <raphael@enfabrica.net>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>
References: <20240411073555.1357-1-yuxue.liu@jaguarmicro.com>
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
In-Reply-To: <20240411073555.1357-1-yuxue.liu@jaguarmicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.719,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11/04/2024 09.35, Yuxue Liu yuxue.liu@jaguarmicro.com wrote:
> From: Yuxue Liu <yuxue.liu@jaguarmicro.com>
> 
> In the scenario where vhost-user sets eventfd to -1,
> qemu_chr_fe_get_msgfds retrieves fd as -1. When vhost_user_read
> receives, it does not perform blocking operations on the descriptor
> with fd=-1, so non-blocking operations should not be performed here
> either.This is a normal use case. Calling g_unix_set_fd_nonblocking
> at this point will cause the test to interrupt.
> 
> When vhost_user_write sets the call fd to -1, it sets the number of
> fds to 0, so the fds obtained by qemu_chr_fe_get_msgfds will also
> be 0.
> 
> Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
> ---
>   tests/qtest/vhost-user-test.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
> index d4e437265f..7c8ef6268d 100644
> --- a/tests/qtest/vhost-user-test.c
> +++ b/tests/qtest/vhost-user-test.c
> @@ -458,7 +458,10 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
>       case VHOST_USER_SET_VRING_KICK:
>       case VHOST_USER_SET_VRING_CALL:
>           /* consume the fd */
> -        qemu_chr_fe_get_msgfds(chr, &fd, 1);
> +        if (!qemu_chr_fe_get_msgfds(chr, &fd, 1) && fd < 0) {
> +            qos_printf("call fd :%d, no set non-blocking\n", fd);
> +            break;
> +        }
>           /*
>            * This is a non-blocking eventfd.
>            * The receive function forces it to be blocking,

Could someone experienced with vhost-user please review this?

  Thanks,
   Thomas


