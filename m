Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A661C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 20:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufP2Y-0003lM-IS; Fri, 25 Jul 2025 16:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufP0M-0001dy-Ne
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:26:58 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufP0K-00023S-Ua
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:26:58 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-235f9ea8d08so24173115ad.1
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 13:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753475215; x=1754080015; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+mna7LAqYH/WBUUxi2tlth3liEu4I3TGaJqS5Id3Skw=;
 b=nr51d7IVuLLS9PV/6TlasiO8XCiqzeI8pi7N/4J1aqR7j510T/41mPBbayyIEA5m7f
 a9QVmMhqtIvyvfwG9bV4aTyf7aQvuultFQXuGkILrdcnmGmRf8ZC62eimBuU4ElwvHuG
 jGqiGXx4WHA/VtvBGCEMmNUh1i8cvI0E0+n7Q0K6OFLNP+7kdR8dr4OgUNH9k2Ysf3as
 mGc/kFWRYNopMd4U3OVlBYHv6/wy12DF5i3bANF93PSTyPP3OEdSws2bDBeauUO+f03y
 g/KUw45khdFzVSZ4jrRIVtiK77jC8LPU3if9XNAhJ0c303fGF/eRRhpj0f2VlnYyTlfN
 Il1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753475215; x=1754080015;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+mna7LAqYH/WBUUxi2tlth3liEu4I3TGaJqS5Id3Skw=;
 b=o5VX/r3KXxXV7b1k7BNRmHzNdcRkV9U7VgknCykRyCzkg6eqTnmtOSfKiYjf571mff
 OyxVN+dwZjkcr57nVFEnVXEXRKJzEBWFtV+Xk1psN4IqLYNpCNLp6mqj/wHLRe0RD4te
 QyVjcZWJyjUyiFtgrYoEj7tz2yVxyKPsa3xJAY1J30eGxejb4+NzH92aVduVfSBYRvNj
 /hP2T1b4qsWOAKbMN7G+uJyREGlD7HI+OH8kKzNGLRjmsCOtKqsSt2FDP9Te1coigS2N
 ItmuzMH6k7mrV5gIiRlKjDPA1iZu0mOBXn1sSIB7EEMx8qJ7LI9X/aIlIygbs/abspHN
 awQw==
X-Gm-Message-State: AOJu0Yx+oBiB+974LhgS/KcihEqPxOeKbOnGMb4v/EP2fbu6DaFW2ddp
 KIQQnuaW1aYFR4FyQG6KOUm2tRCFW+sVnKXOrIjjdzZUtCnpGjIiLbx/K6FwILL2aXHTIxCL6sK
 Qvugw
X-Gm-Gg: ASbGncvOtp9sZKnUH2JSmnOSy4eEOjZ//NSeVzKSdPrvKfFdvzd6dIODo/hWVw9BiTR
 P5pc4vd4bAAN46sDcGNJtD5exueI0hj3jLV4CgfW91YE2lJo3KrS9szHIYa1pWN1FHlmxVSeWgy
 Rdi4DIkBWt5x7hrxRfYuvDeYeZqLSXpUIimDqQ8pqsQVJX3tbNYkmGe7emvrIKNReWLt+kfpMh8
 3w9xikP8/IhJA/KWqGy2KVSTOqsIN7qgx4uYXvzxMyIhAwoNH6dVqj6BEd3QVtlA1oUEmXCGR+m
 uIv7EuN+0OywCCqGjuhv5RwLKcSm02kiiSdkxTEbVjmL1UgKIzzDFTUsQfypJmrNUW/PdVWbUNO
 7ioKCaD7CuBbsOKAIraMZ8FmUSdS8M5ZEbjjL9J70re/warFuusXRMzKFKDTKHeQZgv534X1RKN
 0fxTvkHMPh7S2d
X-Google-Smtp-Source: AGHT+IEVOp7vEfI7bihAbk0KaVApojSm833pr+/jmthtDQZmW/kXHXiCtDcfuZWR4RX14C4XD+ww1Q==
X-Received: by 2002:a17:903:189:b0:23d:dd63:2cdb with SMTP id
 d9443c01a7336-23fb303a271mr50934795ad.16.1753475215231; 
 Fri, 25 Jul 2025 13:26:55 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe3100b8sm3737945ad.20.2025.07.25.13.26.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 13:26:54 -0700 (PDT)
Message-ID: <a5b33bb7-18db-403a-920d-542feaace8df@linaro.org>
Date: Fri, 25 Jul 2025 10:26:52 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] migration: compile migration/ram.c once
To: qemu-devel@nongnu.org
References: <20250725201729.17100-1-pierrick.bouvier@linaro.org>
 <20250725201729.17100-2-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250725201729.17100-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 7/25/25 10:17, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   migration/meson.build | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/meson.build b/migration/meson.build
> index 9aa48b290e2..36fb950b3b1 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -31,6 +31,7 @@ system_ss.add(files(
>     'multifd-zero-page.c',
>     'options.c',
>     'postcopy-ram.c',
> +  'ram.c',
>     'savevm.c',
>     'socket.c',
>     'tls.c',
> @@ -50,5 +51,4 @@ system_ss.add(when: uadk, if_true: files('multifd-uadk.c'))
>   system_ss.add(when: qatzip, if_true: files('multifd-qatzip.c'))
>   
>   specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
> -                if_true: files('ram.c',
> -                               'target.c'))
> +                if_true: files('target.c'))

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

