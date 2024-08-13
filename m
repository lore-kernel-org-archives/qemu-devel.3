Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD9B6C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 11:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdpzs-0004X8-SL; Tue, 13 Aug 2024 07:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdpzo-0004SF-Et
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 07:47:24 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdpzm-0004BH-Aa
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 07:47:23 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3db1eb76702so3976298b6e.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 04:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723549640; x=1724154440; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Amw2WQykDTl9X0eWkdz4Yrc8U1P+hKWtArbAtUoA5GA=;
 b=Mo+A+E8ZWgFNt/3lfs7f1Afss0HSFkdfbuTr02qHi51SOCAH/4TS3hB4vyP1M0DU8m
 ypsmx9exkwPGgg8lQiuAn6wxKFvwGKojocmMPeFoGUM2uAy3+WUoKH2O5HyxSikammd4
 br+nUvuVfuMzsDpK6UHr9EKkt5rr8VsQxc2gEBpGBKo3SCDMDU4FizfvXNN2qM0vfU7p
 6ZXeSX/1gIiTJIWSTyvO1bmgvyuILQ/Vg2gEOGiS4tj5fq9g7njRBDIJ6QQp6niDiLm6
 jHphwCMxMrioEWUXVrytUq2/uCA7270BhrcIHnj3U265aj3N43D5FjToRVPnMwoiyPws
 dHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723549640; x=1724154440;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Amw2WQykDTl9X0eWkdz4Yrc8U1P+hKWtArbAtUoA5GA=;
 b=HGKAr4ExYysCl2b1YYIWTiNg1G9ZxhFciTTSrrKbnT3QZckqnUcpZCs1l8idQFa3of
 B4yOlratNAyv6oOwZUt5L26/VtHVHJp80splUwa/pYvVLpnse53PIS7pGQ9ix5PeBV30
 SeJENqbos/wHwqWn5L766f/AqK9Ts2mhTNwtfJByikFtULj4dqaXluF727kCf9QY9MsB
 SedhPqhMELZ8AoVFmfhuaWvSDEpSHmTxp8Mjh5zEQL9gHnmb4oecjAQT/flCIuYjMrVi
 A5297p4a5b4dsb71WGTxV8PaB7v3xdPXJ8JoEn4Ozd1JV/Dp8PuK5bLux4pUCZa2cUbK
 +24g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdyR/BdN6oLD/PbIA1XmGLQzgofgdvjFNCCauIH5A8cL2gha7FjAvSpGigTDhmtLdAQ0C4fDgFuCnmT7gd0KdSlcC1LkA=
X-Gm-Message-State: AOJu0Yw+HqkAQHCNRfJPaVzy0EU7/TPN5acTHIwetxELsgA6yM3AgVbI
 GT1aDqAlE4rxX6E3Rf/WvhM0zTxUHFo/CDC7+kUFB9upBBl5Wp8fTup+qMdujoM=
X-Google-Smtp-Source: AGHT+IFE7mISOPlnt2P/82IRfOe5XmADcyVzVQA62gkBIC6rBoq6VlyG3JD2NSbNAYpQ17SptFkPHA==
X-Received: by 2002:a05:6808:179b:b0:3dc:39e9:e04 with SMTP id
 5614622812f47-3dd1ee2c00cmr4186814b6e.20.1723549640464; 
 Tue, 13 Aug 2024 04:47:20 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7c6979eb64asm1298403a12.34.2024.08.13.04.47.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 04:47:20 -0700 (PDT)
Message-ID: <0a241265-e7d9-45f8-8724-fec38f43626a@linaro.org>
Date: Tue, 13 Aug 2024 21:47:11 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1] buildsys: Fix building without plugins on Darwin
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20240813112457.92560-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240813112457.92560-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 8/13/24 21:24, Philippe Mathieu-Daudé wrote:
> Since commit 0082475e26 the plugin symbol list is unconditionally
> added to the linker flags, leading to a build failure:
> 
>    Undefined symbols for architecture arm64:
>      "_qemu_plugin_entry_code", referenced from:
>          <initial-undefines>
>    ...
>    ld: symbol(s) not found for architecture arm64
>    clang: error: linker command failed with exit code 1 (use -v to see invocation)
>    ninja: build stopped: subcommand failed.
> 
> Fix by restricting the whole meson file to the --enable-plugins
> configure argument.
> 
> Fixes: 0082475e26 ("meson: merge plugin_ldflags into emulator_link_args")
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   plugins/meson.build | 50 +++++++++++++++++++++++----------------------
>   1 file changed, 26 insertions(+), 24 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

