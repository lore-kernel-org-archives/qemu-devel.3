Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84FDC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 17:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujLO3-0001xG-6C; Tue, 05 Aug 2025 13:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujLNi-0001v3-B8
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 13:23:25 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujLNg-0002UP-EP
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 13:23:21 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-455b00339c8so37493085e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 10:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754414598; x=1755019398; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IZv9bGcWL6z0iBVfwUWSebX5ZqCCCDM9v3eDId9H3OU=;
 b=Cfdgsw2QSNRDkTFPfJsWDQ8djaZ53LU7JybVkFIaMZAMZn5xg7Vu1K7mm83sqlfvzL
 +Q0QQYRZPc5OUNwJh+5j2bowYqpC1NqXMlSRhG8ydUXPnbzAxSvuF6C4GL4MJdQ++Dtb
 sDuzlkZu4bOlIQKy9bb3SRoCPHULo9VqLZXkiktNq/WvQcID6URv1ir6mMcVrLGrOe2j
 gRF9hRD3JUyzpjSLPCB9pTTV/uKp/jqkvrBO9zrCVORCBIox4ShlC38xOdkCybNcDC9C
 kmi6V3PWE2ByK4xfj0mZJSXov3jXGFLHctqU3HMtossq/dlN/I/6wbDw4I62BpBzIxzf
 i30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754414598; x=1755019398;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IZv9bGcWL6z0iBVfwUWSebX5ZqCCCDM9v3eDId9H3OU=;
 b=EMnDXuPWif/9H0oS1lTbof34Cg++kX6Gs7zrwH+Ngi0bkXZSWG8NtYJdmwgqUEU260
 STCF5/HpRhANiRxhpzwTK+Uw4W/bnCO2WcWadCBd090FVfdi831XdDNMj5fjgT6xM+m/
 RcQIaBcdrIZHWsOPNwOpiNh6PZf52PlPZMS2By7/XcsS47vOtThK84cSyK1rdUVPKCHI
 mJJTLGMXwK3TgYPeGkJZCuy6f/YApWi2iLNvewmegCSILMF52tx+vok9SVzJeRi9JXMK
 TFwZGxqxn6YqBCaRLfh5EMJaIKJaLa/AKFtceGxyePw0kPXbh05+ksnDf5pIBrOOcgdh
 AyLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPJdUSLrFJ2gQJVDCYmdwJJI0k/t2ujJLpjvwFycuWmWZgiLSnic9wqxSdiPTyTpRGSxCwE9FCeuDH@nongnu.org
X-Gm-Message-State: AOJu0Yxa5koX57LBZHs5qg8ApS/sdS93MgDje7NENQX40mvzik0hdlKU
 lPObVCuD954sMt5Z68NT1aXtLyr1ErmaXyLhV3XBxGRqIOKjuC0WWMqeyTmvjqXAD0Y=
X-Gm-Gg: ASbGncsyvjX/Zt+bVQD9/ey0iAg0R7juWj755ytmh5L/poBar8t3j7bLUit7dUjzflT
 yXty5FIVCIaWjIN7jzmc5AD22rO5im4rJ4HolEWvAGmsPbhbzp6Oh7bNJ3RAIRJ9ch7y6rcm47X
 tJJ9qH2jubSGQaz0bVJBrKvBEjbDV7hTbp/DcT3ruKIy3SO+m1HB73GlccYUSu5031gs+ni7Z3L
 zHLqpL4b59E2SImXsSj6q7xfTI6VrZDHtFET5nnnbLur2M+XaXC7VXA8bqdkXpjG4/m9klILZ/n
 6RStKlEHKfpxw7i30svVqyzHTlj78WA2d0kfjhFnPqBF8eyHzG0HCLjc6iUCfd6pD/4L4IOQ1a6
 MLbgWI5OaRkWqHCsq5wEN7TA9JQ9t8i3JQCNIqVrP9EAsC61SRNmBWXJK/TyKEYD2dw==
X-Google-Smtp-Source: AGHT+IHai8LtRlHPcDbYxa0cYWufwqfOPGunSJuvtV1fAs0J7QAxLeW55yH7q/BSN+OUoLhdZ12jAw==
X-Received: by 2002:a05:600c:35c8:b0:459:da89:b06 with SMTP id
 5b1f17b1804b1-459da890c07mr79727205e9.16.1754414598436; 
 Tue, 05 Aug 2025 10:23:18 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458953cfd10sm274257275e9.21.2025.08.05.10.23.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Aug 2025 10:23:17 -0700 (PDT)
Message-ID: <7893945e-6287-4f32-9e93-f28c39c7bdc8@linaro.org>
Date: Tue, 5 Aug 2025 19:23:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1] tests/qemu-iotests/tests/mirror-sparse: skip if
 O_DIRECT is not supported
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Cc: qemu-trivial@nongnu.org
References: <20250801122850.27632-1-mjt@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250801122850.27632-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 1/8/25 14:28, Michael Tokarev wrote:
> This test uses cache.direct=true, but does not check if O_DIRECT
> is supported by the underlying filesystem, and fails, for example,
> on a tmpfs (which is rather common on various auto-builders, in CI,
> etc).
> 
> Fix this by using _require_o_direct.
> 
> This example shows where our testing framework is significantly
> lacking.  In this test, qemu produces an error message on stderr
> at startup, because it can't use O_DIRECT mode.  But this error
> message is not shown anywhere at all, even when running this test
> separately outside of meson framework, - stderr is completely
> hidden, and the only error we're getting is
> 
>   +Timeout waiting for capabilities on handle 0
> 
> so it's rather painful to find what the actual error is.  I think
> that besides this change, we should also change the testing framework
> to show stderr at least in case of test failure, and especially when
> the failure occurs at the very beginning when we're checking for
> sanity.
> 
> Fixes: c0ddcb2cbc146e "tests: Add iotest mirror-sparse for recent patches"
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   tests/qemu-iotests/tests/mirror-sparse | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qemu-iotests/tests/mirror-sparse b/tests/qemu-iotests/tests/mirror-sparse
> index cfcaa600ab..19843a622c 100755
> --- a/tests/qemu-iotests/tests/mirror-sparse
> +++ b/tests/qemu-iotests/tests/mirror-sparse
> @@ -41,6 +41,7 @@ _supported_fmt qcow2 raw  # Format of the source. dst is always raw file
>   _supported_proto file
>   _supported_os Linux
>   _require_disk_usage
> +_require_o_direct

Could the correct use be:

   _supported_cache_modes none directsync

?

>   
>   echo
>   echo "=== Initial image setup ==="


