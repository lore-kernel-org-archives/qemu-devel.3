Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2251FCC04D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 17:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyZB1-0000rP-Kv; Fri, 06 Mar 2026 12:41:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyZAz-0000ma-Qu
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 12:41:25 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyZAy-0005oL-4Y
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 12:41:25 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-823c56765fdso4932624b3a.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 09:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772818883; x=1773423683; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wTy488E1rgEmqqX+pe4K8lUXT/VnW1eejnnubBalO9Y=;
 b=oWXP/uTStUCaSF0jUbO+j3LMdjnCr3y+I9UY5Px+e/Kit4k/5pFzM0NsUnN1jwY5U4
 TIOujOMrmHHhXOwmIFTvoCqVeWktsUn1W2pxT4eMZ+yoDVaYy0SqkaJvwP257DkW54eT
 XaSDiXwxH9MOLWF9urb1OO4f3wLeGBvFxnesgjcsNnUGmCcrBsfPKT7JKY/8eJm8NKfe
 IWHFBHnE+dtU/Vs5COXWJk8g3+lijBNon5W1uOc1I2XOW+dcXvQd5fJ81E5aiS8TCaDV
 cvcq/AZpwleMsQwURkuL16XpZrQdW6nZhLq2c+nzJOy4CIzwTNPKw2uIpYTX6w8aCq39
 +4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772818883; x=1773423683;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wTy488E1rgEmqqX+pe4K8lUXT/VnW1eejnnubBalO9Y=;
 b=HBD2PoWsnSlxs9QT+sKczkJtxh/VSYlcyI60p2/b0nNGsgCaqPIg5b4uk00Uh/nfqW
 8H5qdEruFEv2gcusEgATXO1opWJKZxOtn/opIKn/rTKm3YDNZkgJUhlIyYOeN7jhTj3i
 8Fh/vPSZIyU1inv++QNKZoXv4usq/4jzVkgbROAu7BpwSitAur8kgEPYXF9wxtUy90Fl
 LIBAgNCF3gs9sWIRGLRAtwRDSGiVAI2EbmmwQgzWkqynLXE8U+A2wHwn8G/4AQtaJTaj
 mvGRxkyWhqoDOqR1NRMgJ83Q6p+i8Q50o5GXkWRGY68Qlfy/2WLOHJVHPOPrEQQ9PhEF
 BgmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBI1G0qVj/Gk05LjssF8/JVsBZHOS95KzUgBuAl37GTcwDpiNck4upA9bBoQOSNA7R9Dv5g/t8rjOu@nongnu.org
X-Gm-Message-State: AOJu0YwPssb4Naw4exiI6jl0UlnOVf0xmpiV9ybj1WTAAO3PE5+r+9aS
 rscCK0Jr7+F14Zmzx8BGvQIASi/jBW+77qicVjHmW7H4mmW3zCtQ8cDAB4o4xWAeZdk=
X-Gm-Gg: ATEYQzwhaHmvig8f2jiubO4A27Jl7Gk8IQeXa0z8d0hyBjBOhVvAWhkDTtm2mP0uiKc
 enfPxPtJVu91Z9HBzS8kjzTNSAeFwSgtmfjjqLKPW7QDDyyPvF2eNj6wZA6gxuwrWuKDqrdBGxP
 KUU1DY0+DCcbVsdx6kwXGGJBUaDXdDtKIlJqKdwQZHh9IEMKZgO42j3/7KorXxhVqNIweOag97h
 1ckVoMyLVBqWbfJjJSx6QsHapK5oPyM56y9iNw5+Q7Wk4I3q4Vcn/hWBVZfcRAFvCMGHm4d43Da
 ZvQ8xqByVqsREwzofA0wutzOTTppsr5IdaItvRLD2RmkI4JsCSjc/BI/1PSRdFoAtRNaEhSTUxt
 WiDOejpuX+htNl51uw7DrkjqoXDKEPpWLGb8gJsvOoFfashCYwQWaMhS3cj/ZnWhMomWNHwXcU4
 5R8Iy7oZDCPcCtLX0jnmRDV8I7PAQyXfiiUKnUYEyuCdYg57HGZaLr9l4dU9qQNjqgsRZP
X-Received: by 2002:a05:6a00:9510:b0:829:8942:2c93 with SMTP id
 d2e1a72fcca58-829a2d86b43mr2935656b3a.9.1772818882618; 
 Fri, 06 Mar 2026 09:41:22 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-829a46369d3sm2418657b3a.2.2026.03.06.09.41.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2026 09:41:22 -0800 (PST)
Message-ID: <9898100f-b6e4-4386-ae3d-bfc88d5b909b@linaro.org>
Date: Fri, 6 Mar 2026 09:41:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] tests/functional: add the ability to send keys
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260306161728.2657486-1-alex.bennee@linaro.org>
 <20260306161728.2657486-7-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260306161728.2657486-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/6/26 8:17 AM, Alex Bennée wrote:
> To navigate things like grub we need to send individual keys without
> trying to look for success messages.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/functional/qemu_test/__init__.py |  3 ++-
>   tests/functional/qemu_test/cmd.py      | 15 +++++++++++++++
>   2 files changed, 17 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

