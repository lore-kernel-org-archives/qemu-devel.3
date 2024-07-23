Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A24C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 15:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWHgu-0000yH-Ei; Tue, 23 Jul 2024 11:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWHgq-0000v2-9E
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 11:44:39 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWHgo-00089n-L2
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 11:44:36 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42660b8dd27so40755625e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 08:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721749473; x=1722354273; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+184Huir4n1uAeIikCf/rEogrgZqFl5XozTMvYy4X+E=;
 b=Br2muVBc3pruFImOQuuedg7NtC0Gckjn6Hkgt9GO6N0gV5pkAjpvye6UkvyHv4WZAj
 oG06BgxNcy/+WTnihVU4PgJkcOdfQO5oHxZ+Dw12wbJ24fJ8vJzoYbCDYHdKFg8GfFug
 N8TNV4p+YQTNR/44o5Xo5Uu0B4goyQPKEeuu1ectz2baBevIb4qbqeLCl34cM4AjqpAd
 QudEzwr+bh0dr0pqztPRXW3pSS+gfv9mGioa7l0TwMu9NsjNkaUs7ITMV0kRiRwvqKg/
 R1l4JNC7RrdB52Phs1J4k2tyHFw5Wr9P83YdmoCOPTQeiw4LXPxrGT+bIP6/v9PLHsUK
 wjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721749473; x=1722354273;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+184Huir4n1uAeIikCf/rEogrgZqFl5XozTMvYy4X+E=;
 b=kD8ImeCYBhl6Ie8iEMCnZbjf3P7uYVJN1zIms2aiohHACjv/oG4p20jcdNtRe0ZtPa
 wZVLBYUtnBEkFgMvqiNZ53WeABDaeG635dQkGzkeVS1/VIB3UYnDxzWbtNWRCD33oUjp
 5fnQ6VgSZAVV7kSVwOIaBxfx+GOEloediKqDpIuQi+eLBS0u6Xg48heJHfPJPfAzyNdN
 aedB/iXYd0+6G4lLxG9o2r/O5g95C3DDHLKOBReF/VjCDqvHTFj2qjynqq1rxd0yfgiF
 oXZ/fml+QvYIFUWTrz+EiCUUJrQR4+T5jFzy+MhgHWM9RUMNw/LnqGSF2qLGJZDLfvdW
 ldVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2qPSNEVsWHTa1Fhi2j+/6UooNEUeJy5dmhFgr5co4PUnoekXa9o5PrkyW/Ezd7r3WPFQi2hjuiAbgXrfBP3sk/Qq5bhA=
X-Gm-Message-State: AOJu0YyOdr5fvwajyamyFGqTfjlQUCYaGeawnzjJZWXx6jvjPsJjOtuZ
 uRbhAtdZ/8OYmhLRiMUA7kbXmic/I5vMH8X0ru60UlkDJFk4Yerl+kd3pt13xlo=
X-Google-Smtp-Source: AGHT+IFxl/ZEAIBTbj3pqmEIeyX/Ix8zUoq5abuWBuvLmrCZp2Y5G6oo0eABFafFrQDEVIuZdgj2Vw==
X-Received: by 2002:a05:600c:83c8:b0:427:abf6:f0e6 with SMTP id
 5b1f17b1804b1-427dc51f966mr78163785e9.9.1721749472904; 
 Tue, 23 Jul 2024 08:44:32 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f1f5d7c5sm14218505e9.1.2024.07.23.08.44.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 08:44:32 -0700 (PDT)
Message-ID: <331c454b-56f1-485b-bc70-c1b433db20f7@linaro.org>
Date: Tue, 23 Jul 2024 17:44:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util/async.c: Forbid negative min/max in
 aio_context_set_thread_pool_params()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org
References: <20240723150927.1396456-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240723150927.1396456-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 23/7/24 17:09, Peter Maydell wrote:
> aio_context_set_thread_pool_params() takes two int64_t arguments to
> set the minimum and maximum number of threads in the pool.  We do
> some bounds checking on these, but we don't catch the case where the
> inputs are negative.  This means that later in the function when we
> assign these inputs to the AioContext::thread_pool_min and
> ::thread_pool_max fields, which are of type int, the values might
> overflow the smaller type.
> 
> A negative number of threads is meaningless, so make
> aio_context_set_thread_pool_params() return an error if either min or
> max are negative.
> 
> Resolves: Coverity CID 1547605
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   util/async.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/async.c b/util/async.c
> index 0467890052a..3e3e4fc7126 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -746,7 +746,7 @@ void aio_context_set_thread_pool_params(AioContext *ctx, int64_t min,
>                                           int64_t max, Error **errp)
>   {
>   
> -    if (min > max || !max || min > INT_MAX || max > INT_MAX) {
> +    if (min > max || max <= 0 || min < 0 || min > INT_MAX || max > INT_MAX) {
>           error_setg(errp, "bad thread-pool-min/thread-pool-max values");
>           return;
>       }

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

I don't get the point of using signed min/max here...

