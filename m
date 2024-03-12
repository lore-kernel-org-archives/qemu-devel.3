Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BE8C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 19:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk7i2-0008Fe-D4; Tue, 12 Mar 2024 15:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk7ht-0008CJ-Ln
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 15:22:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk7hs-0000Yf-62
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 15:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710271355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Xi4TIvOaencI0MEp0ynLOaxqX36+24Q63nmc9fM5rTs=;
 b=GOjPhJBV8iPZS+O0dwa4lBhPy6RbG2Wu7H6cMM1U6AZhJW2HqyAmogd++Ne4+U+7N3BEP0
 KhENIYOSedyp14wRpP7auHrhOi4yBakRLCL26yra2eRqD9BtE1tRSRcIFFcHsbT4nGPCyX
 EcY/YKvnyQfiixFjNAWsSIIrr9d2FNM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-A964MRqZPTOXUtSe1XU20A-1; Tue, 12 Mar 2024 15:22:33 -0400
X-MC-Unique: A964MRqZPTOXUtSe1XU20A-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2d449d2db37so14954681fa.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 12:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710271351; x=1710876151;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xi4TIvOaencI0MEp0ynLOaxqX36+24Q63nmc9fM5rTs=;
 b=BCe32ZPQhoq486XyCVJSg3Gh7WMUqy+Xv6Yb7se/jc8WjnSCisKz5jCVsu8Fn1MiFr
 z6iJX2buA4GZfTDfEfO4Q9rDZJVdNOjLag2xC7/9v2hLdoS+GX11eiPk5kbWT7mL5s0d
 P6UeV2/mz8pLjsK624KfZFWqxItoFHklRrm4H+bXptP09Bt59xfJKdDXxDAoa3PsSgm8
 R2hU7yiCA+7/LJUs19ZIJPVIyrAH0mDxvlml6Uv+yPjxuDgk64W6qAmnAItUjGFyqKXR
 zBN0oZXCnZ4seoryHzUZ/t9bBK+bWMxJQJtogKgR88RRsH2B3aNCR8BkTIAXbPjXvqDI
 IJxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpUG0vpYlc20cVR3nzZln1eqPZ+751vkDOjLIymAbyg99KfS1HH0EgzRrHR9oxwYCZeO/PKMf+bGWfB9Gbg+N5RuGDTCE=
X-Gm-Message-State: AOJu0YzY4PGmwTrsfuh6PlofjGhSOdIjGwZqtcgs7Bb/Y6AALWMoa0EV
 fsHWoqVhpGVqNuDYkxrMNaPGwwF3vhJATATMpj8P331n12IF1tTtVFDpy89cQx50OxQmL20sOn2
 W0sBvb7SJ4sSUmng2fm5XLKePaBnIAaqkMRaLi/w7dfLR67pROtuG
X-Received: by 2002:a2e:b178:0:b0:2d4:35d6:1984 with SMTP id
 a24-20020a2eb178000000b002d435d61984mr5223540ljm.6.1710271351681; 
 Tue, 12 Mar 2024 12:22:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEyhIn618CD3pNYMyrwZRCOzP8U0Ax9cC8I3OdcGbsttAGmY5jkZcTKCUja3/SrqwmpaH2kg==
X-Received: by 2002:a2e:b178:0:b0:2d4:35d6:1984 with SMTP id
 a24-20020a2eb178000000b002d435d61984mr5223529ljm.6.1710271351293; 
 Tue, 12 Mar 2024 12:22:31 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-177-86.web.vodafone.de.
 [109.43.177.86]) by smtp.gmail.com with ESMTPSA id
 d23-20020a056402001700b0056857701bf5sm2474962edu.81.2024.03.12.12.22.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 12:22:30 -0700 (PDT)
Message-ID: <1d3ed049-c1c9-4cc8-a3b3-db71f3d88d6a@redhat.com>
Date: Tue, 12 Mar 2024 20:22:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] tests/unit/test-throttle: Avoid unintended integer
 division
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240312183810.557768-1-peter.maydell@linaro.org>
 <20240312183810.557768-7-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240312183810.557768-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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

On 12/03/2024 19.38, Peter Maydell wrote:
> In test_compute_wait() we do
>   double units = bkt.max / 10;
> which does an integer division and then assigns it to a double variable,
> and similarly later on in the expression for an assertion.
> 
> Use 10.0 so that we do a floating point division and calculate the
> exact value, rather than doing an integer division.
> 
> Spotted by Coverity.
> 
> Resolves: Coverity CID 1432564
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/unit/test-throttle.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/unit/test-throttle.c b/tests/unit/test-throttle.c
> index 2146cfacd36..24032a02667 100644
> --- a/tests/unit/test-throttle.c
> +++ b/tests/unit/test-throttle.c
> @@ -127,13 +127,13 @@ static void test_compute_wait(void)
>       bkt.avg = 10;
>       bkt.max = 200;
>       for (i = 0; i < 22; i++) {
> -        double units = bkt.max / 10;
> +        double units = bkt.max / 10.0;
>           bkt.level += units;
>           bkt.burst_level += units;
>           throttle_leak_bucket(&bkt, NANOSECONDS_PER_SECOND / 10);
>           wait = throttle_compute_wait(&bkt);
>           g_assert(double_cmp(bkt.burst_level, 0));
> -        g_assert(double_cmp(bkt.level, (i + 1) * (bkt.max - bkt.avg) / 10));
> +        g_assert(double_cmp(bkt.level, (i + 1) * (bkt.max - bkt.avg) / 10.0));
>           /* We can do bursts for the 2 seconds we have configured in
>            * burst_length. We have 100 extra milliseconds of burst
>            * because bkt.level has been leaking during this time.

Reviewed-by: Thomas Huth <thuth@redhat.com>


