Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BDC606A327
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 05:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CvR2o/Qb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xS68P-0003So-2G; Sat, 14 Nov 2026 00:17:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xS68E-0003Nk-KR
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 00:16:55 -0500
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xS68C-0002DF-Cp
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 00:16:53 -0500
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-93f3c616c84so209114285a.1
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 21:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794633410; x=1795238210; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3EKPpAWJHhuuWJ/IHp8Az6/d+FcEKltZ4E31hF+uVGU=;
 b=CvR2o/Qb+mwRsiXKIBbMj+21jKhbuhg0zA4F8V9ju5wjGzGmDf2i+EzX3xA77HEJIQ
 h01xaw246CUV+kBKsZ3N4jq3+O8/V0N86O9MH0lvcLxC6QqFtzHHbo8DwHwSbik478dH
 XDvodqKMBswQtc9ZN443M1mxEqb1+c/XNUxIUDVzOxIq2mofAxHzAPs9YysmV/ZM0KbU
 3GHEn6BkWro59iJ4lF3CM21s0xSr/p2m/dcjVjE/JQPRigcufzDyeH87gDBbGWDSHMgs
 Q2AuWCkL4KJ0w9+csaTIvuAwCv2r9qnCLEWVafGHBVcvSNnMo0z5nKoZ+CH4726ZvBvJ
 EHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794633410; x=1795238210;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3EKPpAWJHhuuWJ/IHp8Az6/d+FcEKltZ4E31hF+uVGU=;
 b=VJSAJWulZZkAKLasU3KTV8A9dijGwgm9WvJCvlHLDg8QPlFJOslaLyaADH3eFL2pdK
 pdYFygI9ItMzRaDW5oJ2+zEkjz9KkB0mboN67SEF6mtMs8jSib+OMsLXJWAZOG0b8E7L
 9UCz8YWaVaWVJfDS8wZV/i+nxMilKpNUdUZLo8NaSPeYH5vV5dlkibdIiEBfMKO+0mPs
 fKL6vCdC5CVF2AbWIYSL3MThEYBW8wEgPdXG5pmt82KIyqLX+3luZpVitfSw9UsdVymj
 tma/r/i9ddw8Nnmyqmq7WOfb1giO9o2CVlUdbe02/m3wY5cxRH3V2yJyJ85P7KgXMhcC
 Yfmw==
X-Forwarded-Encrypted: i=1;
 AL+hErH26sHcXO/JQu8tjogNUde1FvPD0c76i7JCDKN50kmWYdkIa9g1xgVwCquSs52HYBqcCxR0QTs/fjke@nongnu.org
X-Gm-Message-State: APuU4Z+9GWKw+hpgpo1zVRAndQHT45Sw+92CyZYwJxPuG8YwOM1NICet
 +o0/ECt0UaaqOGTfUyMSzGdJYDFPiTasumg2fRAhxGQA5V63m5jb69zaEBc9cZAdySM=
X-Gm-Gg: AYBFou34VInjYjyUvCQnC8BZHe+VQ1HwxDCsswM4cd1sJVs2mW4Zn5s9IOtks6sffQO
 u0vBV3WKcZVyNnBAUvOCapl43OBorSh49LnbmcN1HYzlSjseiSc98rA6Vk1pNs1GtUU6pATkP6Q
 bdIymIWG/y/RS8IQO1kdFiE93hIt7jDBq82QpM13mGxK0QsTIZ+xzbeN7v67cyQLp+nocO2OCw8
 56WUVHFTE99R3qyXon4riTdf8HHhTckCsbmLY2EcrIg7XWnkTckKqf3FKB6AGu01pc8TLy0FdzU
 SEMBhoIeB6x6eSu+oH4yu3V2dYbScExQJISh6l+eO6AthEac0wSmRoaAmleyEnfVDQHneKeuQa6
 v15w945HBzEu909Jq+YMNi3ETb2BOYrEJQN2xwWj4Ph92zg9/7cuBySteVLXRmDo49vWoAEbzMr
 DWCzBrCAHExuRL6ubs9ePLyn3/xMGQo9yzxMXJIWRSyb7YUJLqB83/BtNnAFABA96nf2lepGIyp
 JKdC66JKCWVQy5djsyuzqWhxEqZmSkNLK1yYEGUkYuWQE7NRdB+53pKoFoeW0KSgYb14EB7gaj5
 jtZhEe8Sxs6Woj2QkunfhqIfH6kWBinM4N3eFNmOySvt
X-Received: by 2002:a05:620a:372a:b0:93e:5dcb:eb9b with SMTP id
 af79cd13be357-9494bbf568bmr723992685a.42.1794633410472; 
 Fri, 13 Nov 2026 21:16:50 -0800 (PST)
Received: from [172.31.6.247] ([209.52.143.85])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9494c6025f5sm338515985a.5.2026.11.13.21.16.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2026 21:16:50 -0800 (PST)
Message-ID: <199fbbeb-f9d9-4220-97a9-da8c4d18ded7@linaro.org>
Date: Fri, 13 Nov 2026 22:16:45 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net/checksum: Correct handling of checksums when IP
 options present
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20261112180239.489819-1-peter.maydell@linaro.org>
 <20261112180239.489819-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261112180239.489819-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/26 11:02, Peter Maydell wrote:
> In net_checksum_calculate() we calculate the position of the TCP or
> UDP header in the buffer with:
>    tcp_header *tcp = (tcp_header *)(ip + 1);
> where ip is a 'struct ip_header' (and similarly for udp).
> 
> This only gives the correct location if the IP packet has no options
> and its header is the minimum length.  Otherwise we will corrupt some
> part of the packet in writing the checksum word.
> 
> Fortunately packets with IP options are rare (and often get blocked
> by routers or firewalls), so this probably didn't often cause
> problems, and the incorrect offset we write to is always inside the
> packet, not out-of-bounds.
> 
> Use the IP header length value from the packet to locate the TCP or
> UDP header, instead of the fixed minimum size.  While we're adjusting
> this code, make sure that we don't assign to the tcp_header or
> udp_header pointer until after we've made the length check that the
> buffer is big enough (the previous ordering of operations was
> harmless as we never used the resulting pointer, but not ideal).
> 
> This was mentioned in passing in issue #4791 (which is otherwise
> a duplicate of #4720).
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 50dbce6538d1 ("net: improve UDP/TCP checksum computation.")
> Reported-by: Alex Meiburg <https://gitlab.com/timeroot.alex>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   net/checksum.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/net/checksum.c b/net/checksum.c
> index 997a0dd2350..277b2e652d9 100644
> --- a/net/checksum.c
> +++ b/net/checksum.c
> @@ -62,6 +62,7 @@ void net_checksum_calculate(void *data, int length, int csum_flag)
>       int mac_hdr_len, ip_len, ip_hdr_len;
>       struct ip_header *ip;
>       uint16_t csum;
> +    uint8_t *ip_payload;

Why uint8_t*z and not void*?

With that...

>   
>       /*
>        * Note: We cannot assume "data" is aligned, so the all code uses
> @@ -142,20 +143,23 @@ void net_checksum_calculate(void *data, int length, int csum_flag)
>       }
>   
>       ip_len -= ip_hdr_len;
> +    ip_payload = (uint8_t *)ip + ip_hdr_len;
>   
>       switch (ip->ip_p) {
>       case IP_PROTO_TCP:
>       {
> +        tcp_header *tcp;
> +
>           if (!(csum_flag & CSUM_TCP)) {
>               return;
>           }
>   
> -        tcp_header *tcp = (tcp_header *)(ip + 1);
> -
>           if (ip_len < sizeof(tcp_header)) {
>               return;
>           }
>   
> +        tcp = (tcp_header *)ip_payload;

... no cast required.

This could also plausibly be reordered to

         case IP_PROTO_TCP:
             if ((csum & CSUM_TCP) && ip_len >= sizeof(tcg_header)) {
                 tcp_header *tcp = ip_payload;
                 ...
             }


r~

