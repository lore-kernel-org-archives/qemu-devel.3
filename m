Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0EC10F285F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 17:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6Awo-0003wF-NF; Fri, 27 Mar 2026 13:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6Awi-0003sV-AM
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 13:26:08 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w6Awg-00053w-3e
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 13:26:08 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43b41b545d9so2461798f8f.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 10:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774632364; x=1775237164; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0TtG+BgG5tZjsfByAZmaZW5KeUJ97ibJiE2T0OB+Mk0=;
 b=NPnvN9uBkYY7Z5KzF9bQzYeMmI/t5cPYubf4T6ZSxMJVSddTA/aWIQj1nGiFqNiRHW
 cWgKoWdbGuCkeaga8dV62VQWZxMc2OHRzsiXH3u00LhS6mDkYnxIb4hC52wbi11DUtch
 bJuo727OTVlCYefz1tltNsUpSoIUWPS9I1vvb9wSN8rpy1lntQwaNQx0+iVa4zFs5SQs
 XzqSDivOPEspBE4i7eFqqTz+lgG3AAa6HPnW5xFLHLOCaeb/DV2wvzliWLJ5XUBdm3Wk
 7UISjtL+ds2dS2SMjcXyUZVsZukIBUWkRhOug1jiI2pguLkqxErreRWBaMFrqItjH37b
 5ahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774632364; x=1775237164;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0TtG+BgG5tZjsfByAZmaZW5KeUJ97ibJiE2T0OB+Mk0=;
 b=XlhKNTxNgZ4xG/bRD85dImKMmIK4YKC+ZenOJNGcWPuNvm+APYD56PIqKTkAhBgjPf
 dHwP6tTB3EcSRn6H30rB6puZcMt1r7pyVWXTRhv62Yp9locItcdmnh6+12A7TTX/DSij
 jrL0MawsH7s2KtgSQd525enVQU9ukjP1kQSMBUiQfVUxkbNMUDgxeIz20GGPs96moklY
 HMH4Laj7D20MfM3cZhM4acLFye25SIomNTXLEm2itZPjuESjL9fHb4X1xkx/he7Nz1k+
 h08hDGRpdJBm1Wdr4fVC4XVzdcGlwb3HsqgYkViJg42eLuAT+8O9msjkVIB4gEByU+GJ
 34Gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuu98bUxdmhxvouO+0xoMkhiA1cKqav/c/X84QifaqpQ5h9tiRfG3H1rN2IxaWqA7FIA4+W79aMisz@nongnu.org
X-Gm-Message-State: AOJu0YyLOtcQdOkhhx5spui743NuZSMDo3XmeVTp9FvbmMzRr2pgw9Re
 NruJx5UqcxeO2PYfAZ85yd7+Gbl5k+w33GbXs7nxcEoaFjqhPkW6hfrzb6gn7PJCMMk=
X-Gm-Gg: ATEYQzyHc4pMWVVdBojlY2rNQLANYeuanDarrjBlp7Q8X0KHfv13IzfNt6R5Yif3kW4
 xaZvOjEEZDZvBSIX6fdi7HoK5qwD8UdTAWegGcuhdHRoDcEodYQBGuMhRUqgUutLurLq8DFGExx
 /bBxnTLsjEorQCNrnXEGYoFi2VWEwt9MIpKIzFpifq/EBQDaSGNa/PF64fAb6QAu9XB3QHlDC5S
 9Npwq13i9TzGI/xcOwcUn85Vudo1w3uJo/PWnWxLfmAyJ918u44+2A0yvWenC7RA120yhaRxoqg
 wB7ZEMWcykUQ7XY19OGTBaldKkL0bEoPTWwgDJm0MR/NTZwMPNRPxlOZJWQWmsSryDvrJcLiGWS
 tTBv285ceHY4AV+cU0AmEShFeJrhWbVRszKhC9aXEXpWYW5VlewA1lQ3mhv/PWImRrnIvN6mBDx
 /mrJGtpVDQBvVHf05OZ245sjbbY0C1EVe3EOrezpmlM7Rfrbuf/cQxL7uZhuKpVQ==
X-Received: by 2002:a05:6000:2006:b0:43b:86ce:27a1 with SMTP id
 ffacd0b85a97d-43b9e9ea409mr6134749f8f.17.1774632364040; 
 Fri, 27 Mar 2026 10:26:04 -0700 (PDT)
Received: from [10.202.147.66] (109.243.130.77.rev.sfr.net. [77.130.243.109])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b9179b212sm17351988f8f.0.2026.03.27.10.26.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 10:26:03 -0700 (PDT)
Message-ID: <36d7e3d6-3907-484b-8a58-f05a9ef6cae4@linaro.org>
Date: Fri, 27 Mar 2026 18:26:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/12] target/arm/tcg/translate.h: remove TARGET_AARCH64
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org
References: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
 <20260327165042.604105-5-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260327165042.604105-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 27/3/26 17:50, Pierrick Bouvier wrote:
> We need to stub a64_translate_init and gen_a64_update_pc.
> At this point, we don't need to do anything for aarch64_translator_ops
> since it's just an external symbol.
> 
> We can now include target/arm/tcg/translate.h from common code, since
> all target specific bits have been removed, or can be specialized with
> specific defines.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/translate.h | 10 ----------
>   target/arm/tcg/stubs32.c   | 17 +++++++++++++++++
>   target/arm/tcg/meson.build |  1 +
>   3 files changed, 18 insertions(+), 10 deletions(-)
>   create mode 100644 target/arm/tcg/stubs32.c


> diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
> index 5f591560551..3e96c77df73 100644
> --- a/target/arm/tcg/meson.build
> +++ b/target/arm/tcg/meson.build
> @@ -21,6 +21,7 @@ gen_a32 = [
>   
>   arm_ss.add(gen_a32)
>   arm_ss.add(when: 'TARGET_AARCH64', if_true: gen_a64)
> +arm_ss.add(when: 'TARGET_AARCH64', if_false: files('stubs32.c'))

Add via stub_ss[]?

