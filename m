Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6421EC0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMuB-0000RS-C8; Fri, 24 Jan 2025 11:51:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbMu5-0000FT-NE
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:51:35 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbMu4-0001zm-5O
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:51:33 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ee86a1a92dso3506843a91.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737737491; x=1738342291; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0LCjAHMbeciqIRiCxO32hVPO0Zm5aqjupkpfzKpyKb4=;
 b=pTxfqGnDoaZ9W2q6KM7SpUS6ZGQbdT54vNQyhiXZLHgkYxEL1/7XGN0a01wiEZS5ER
 c1x6ksg++alKM5JZWTTP38wjP92PWNO+P3OXLZujbSTtDI39lYSdmcmMumyls95/UUsg
 D+06xCzidmFL86eat3pCHzz1CrhIxbFlP9C/hYnr5WPQ+gW/CmmlG/TIXfn6iNQ4Txmi
 xsl+AegPROwMtpTzzViDOsWvJ+WAEX39XKgm8aGP9rgQ0PWN5Yw/Li//J/eTXlAOvzVx
 SCcUriapPN4t8wDwUhZ4PbBsu1yXaRbThW1zJOi0Xv3U8I4kdLYSHh5cSUl2st5nQB0y
 WRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737737491; x=1738342291;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0LCjAHMbeciqIRiCxO32hVPO0Zm5aqjupkpfzKpyKb4=;
 b=fFYIuXYYQ5M/9SLQ2ODXhAZ6h7pQxDQsldMkHEK3BFMZw8cDc9bTiph1J4KCT0zUV4
 mWs1wivBzFMHkHHmAon8sThIDaD5SS5XYW7VKNGn/wc+AehVLH1e8bl2y9MpJZ0B7H84
 r/PhNZl6qqPOYoj0zKtLDeeEtfO/JGIB3NkvthoV368MGde3V9OElhwOvl73fExpKg+T
 kqxkmmQ8E6PEsy+m7r5nn3hhuD54GtJOWIJIlxh+IdXIbd3+EdFjMyTEBELNoAkVI3+Q
 oJENTnSHFjL8tSdxD4vNzQfYW7SRH2hCnbanoKiRLZGFKe61ieUhOM3LigFz4Ci2JNci
 824Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCViPwariviH0Dj4lJuy8uQ+OQjixX6X2zLd3oJIwrwSDTKD0eXN4ln1SPv7ce6TepMTQVh6lXj7/0JY@nongnu.org
X-Gm-Message-State: AOJu0YwvQwpunaUd0ap5pjz0Sf8NF+tIEcyENcAquNRTKxb2J8hdmFVd
 duNpiDBlLK73YVMucnnkSgiObnsAkWxcE84+p5/2C4XS4TpPXfsFn+QT8sw0TYE=
X-Gm-Gg: ASbGncu5KCbxZkhG7RqD3b5Z88afsNXd09Pczq36mnn0KBXwD6OS1QtXgTweghWUkW2
 9YwJpQlfaLoIEMVAcZ60K1K5pLkGcyzGnx6KqvKMyk7Flp0EvIMhXizReUn0u8av+0IwOrFUIx3
 COtpoX3RPkq9f3/0uzkWdDgWOxCiEQBUqPXOU2R0cv0veURZJYdq/8iga+JG/WKrYC6qhoOARTC
 kmMKTwQ+56gFvGR8jobKdtJgoBe5avKbmNGGaydTjxxTkv5OFqjbr4RfQnGSipW0SHYVYcNwewt
 HuJVA4enPBuuW/NAT9Cx6dke
X-Google-Smtp-Source: AGHT+IGiBFXU1FP/msO2nZAPr++pQPir4NIlwm76nIwl0zBqTzCznq8N+NrkqsA19Z0oU4UCFIpWIw==
X-Received: by 2002:a17:90b:5249:b0:2ee:e518:c1cb with SMTP id
 98e67ed59e1d1-2f782c4bdd2mr48156264a91.7.1737737490973; 
 Fri, 24 Jan 2025 08:51:30 -0800 (PST)
Received: from [192.168.163.227] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffa56147sm1975389a91.15.2025.01.24.08.51.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 08:51:30 -0800 (PST)
Message-ID: <52eac72e-d86e-4cee-a7a5-2f982fd781be@linaro.org>
Date: Fri, 24 Jan 2025 08:51:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/28] target/tricore: Ensure not being build on user
 emulation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250121142341.17001-1-philmd@linaro.org>
 <20250121142341.17001-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121142341.17001-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 1/21/25 06:23, Philippe Mathieu-Daudé wrote:
> Currently only system emulation is supported.
> Assert no target code is built for user emulation.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/tricore/cpu.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
> index 8e431d79222..cf9dbc6df8e 100644
> --- a/target/tricore/cpu.h
> +++ b/target/tricore/cpu.h
> @@ -26,6 +26,10 @@
>   #include "qemu/cpu-float.h"
>   #include "tricore-defs.h"
>   
> +#ifdef CONFIG_USER_ONLY
> +#error "TriCore does not support user mode emulation"
> +#endif
> +
>   typedef struct CPUArchState {
>       /* GPR Register */
>       uint32_t gpr_a[16];

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

