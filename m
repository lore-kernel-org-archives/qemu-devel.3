Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32E2C00A94
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 10:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvDks-0003wJ-KV; Fri, 12 Apr 2024 06:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvDkd-0003ez-6C
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 06:03:25 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvDkV-0001RK-HR
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 06:03:17 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4167fce0a41so10057385e9.0
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 03:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712916188; x=1713520988; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K2DKCx8uwiUb+wrtkkYyVTZJllPzqofYHsVxp9i3iX4=;
 b=RVdAbl9fJXip9r1QNVIAAOVEFmdz6FaeN51dLyXKX8saChExwspjJxesvH5JT9M0N8
 zhvCMKgDd1C7gW6ZlO0ZP0Wlw/niH3snlTfoqcW+hJuKYGxYAEplJu6wLx+XF5eWEvrg
 a5n5wo55jNBBgXISnIbiuwMO33V+RYtV4lmq/OPALiulV2TxgfZ6ebMx5onlTZ3PBhoU
 nuT2BDz/KV7OwPgAhQIrSGg86/os/VDFH2mg4kSqydP/c84QfVNKxjBK+OGITvEuytli
 1XL1BZ9F7f/yiXBTKr5E0gDwpuczuFEoD41U/gpPO8Bdh48jjDaO6cKA42iiaSNGGZnx
 maNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712916188; x=1713520988;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K2DKCx8uwiUb+wrtkkYyVTZJllPzqofYHsVxp9i3iX4=;
 b=MHgOcho8jCmbYa5mx6j+KT51hG8LV6kIAU1sjcj4N+AG3UIymSeMasi2Nn0MQ8E2gy
 7ECaiTyjDIWxUAjH7GZnJpInzi1jxVzECjCxYQndTQVd1fuLLOZKAdbNtdDjjtDp1/wE
 MyWRqgw6lzyCEOdOlRuFa7uyRFfP8yCPduVoxU4IUkoTMqkDeHG6cj665+mub09jbuNa
 pdY5qg/3Ui1qmLh9Tq3V3mDOK/GX6em7bLo8dZBVDg+GjF50KkS24ah1f7VgNvD0Lnr0
 w9hGB+N1FCxITDbtYvAgVl5wjvOtphMUgIhdoKcVJmrat02+OLf6kRjwi6eDHXug56Zm
 m6Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsGj6pGrk0ksthXVPsSjygVGpAMRzUJ3gmUHvER3SttkIvUzQRZID78mtb7cq3W4tEcph8U0JF51RyNgaJIs0Z6p8XVU8=
X-Gm-Message-State: AOJu0Yy+EHulin8VO65N0+pTXEb9V8f5j9k6GHRj12YePNNqmmfgeLKf
 gkceis1W6v0AMmIOYibz6F0cZ1tzxqz0k68Z/fPg0q5ACGTRg6l+a3cmlFx6m9c7EjPKAILnopf
 ZhJ4=
X-Google-Smtp-Source: AGHT+IFZbnUoxZucUxvDp7CFliO/KbB2ibaQ0uHemcTv96PKKVOCBcDQVpRqztWTkjDyrJZ8By7t7w==
X-Received: by 2002:adf:e40c:0:b0:346:ac25:ec5d with SMTP id
 g12-20020adfe40c000000b00346ac25ec5dmr3800986wrm.11.1712916187714; 
 Fri, 12 Apr 2024 03:03:07 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 h8-20020a05600c350800b0041488978873sm8297470wmq.44.2024.04.12.03.03.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 03:03:07 -0700 (PDT)
Message-ID: <e2ccd623-96b3-4ce1-8017-2f5d31b50c55@linaro.org>
Date: Fri, 12 Apr 2024 12:03:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/27] util/hexdump: Remove ascii parameter from
 qemu_hexdump_line
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240412073346.458116-1-richard.henderson@linaro.org>
 <20240412073346.458116-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240412073346.458116-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 12/4/24 09:33, Richard Henderson wrote:
> Split out asciidump_line as a separate function, local to hexdump.c,
> for use by qemu_hexdump.  Use "%-*s" to generate the alignment
> between the hex and the ascii, rather than explicit spaces.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/cutils.h  |  3 +--
>   hw/virtio/vhost-vdpa.c |  2 +-
>   util/hexdump.c         | 54 ++++++++++++++++++++++++------------------
>   3 files changed, 33 insertions(+), 26 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


