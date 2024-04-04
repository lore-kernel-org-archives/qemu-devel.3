Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BFCCD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 22:15:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsVLu-0007MZ-2G; Thu, 04 Apr 2024 18:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsVLs-0007MB-2P
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 18:14:32 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsVLn-00044W-8k
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 18:14:31 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1e0bfc42783so13518805ad.0
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 15:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712268865; x=1712873665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HRG4wrKQl7M9h6KbiIGUPXjsJLale54brrRtnGaO9Q4=;
 b=uNS/cTGWsXZaJ8s12iYPtlmFPM4QcmdSa4nlpP4lgMb0WcHgLUQf3YpHBZ59oOAbf9
 mmQ++zoEL+Isi9uMpkBcsI00IR4YKxXuqPWs/p6HGY7FQei6v6IPOJV5FLAZJBunSY7x
 wc/0vI9vM4NWyWRjzdfU9+f4Mt/ZBiH+kQ+7G46ZsS/yNl31AimCynGT7jgGYYPURx68
 HLEoJSiXp3QXIVJwfYaZ9p0ajR0xOEpQyZIgSxwiesQNY6UGuk8llGBQr8/cotOaHonM
 15wA2hsSxlIE5zCtd6ZDq8tD82fueScqZ/6aOWNC4NkxEqo2TTu2xFL9ApKXYxbyIr2C
 1p5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712268865; x=1712873665;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HRG4wrKQl7M9h6KbiIGUPXjsJLale54brrRtnGaO9Q4=;
 b=rt9OvNlFunBIGpON7dTSVCjoTlyDw/LzIBzlMkP2CN+Cjq2NCT+aa3mwABxda0hUdN
 sLB7399z+bwrk05QTEtia3Bw4YHzaZNxwmmTBmRo9PesZRkViDQYpxovbAyocNnW5hTp
 3LaR2JPQannLHp9CQb8ulOrRZogfv9zIQlOgQABg5wQVYCBADZE2Oo1O1TY/GTKYDxiE
 0YrYvNCm+Y29fVXFttQShn9lZAAyk2yyHjMfRmDVgfi6/492AxxvKRl3MKP1RyDD9ywe
 cv9ew3t52XHiobUNiNXw+zks1KBunKUHvatMuer0+DeMjHqkWIoLpdvUfib11W5hSUMi
 2yxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgl9y9hkb52wS8mJsetfPM3r67UhEfVQ8wXOQCzuXnIg1GY74JFli/2nhtRfpQp7Cb4OPCjUgoDLaynACI0X77X1QCBUg=
X-Gm-Message-State: AOJu0YyfZAg6sWTfncxs1NiWEVtXpmZYevgkk5orkkqKc8dZeHMbn8Q7
 dR0ZhB9BOy5qCQanQ2rSc0IyeEwtIODO4H/KP0+/eMV/fYvbRmr5WBkKTUrE7CE=
X-Google-Smtp-Source: AGHT+IEPlLzOmVW/d2OPexvJZDQk50yd7vUGpSfIpkUYeQDHYhfwraZTIpBg/8LbOBbcFV51Lthivg==
X-Received: by 2002:a17:902:e98d:b0:1e0:d544:8818 with SMTP id
 f13-20020a170902e98d00b001e0d5448818mr3293640plb.20.1712268865404; 
 Thu, 04 Apr 2024 15:14:25 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a170902f54c00b001dd99fe365dsm126921plf.42.2024.04.04.15.14.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Apr 2024 15:14:24 -0700 (PDT)
Message-ID: <f56a659d-e490-4226-acaf-a75ff6a024ab@linaro.org>
Date: Thu, 4 Apr 2024 12:14:20 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 1/7] ebpf: Restrict to system emulation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>
References: <20240404194757.9343-1-philmd@linaro.org>
 <20240404194757.9343-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240404194757.9343-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 4/4/24 09:47, Philippe Mathieu-Daudé wrote:
> eBPF is not used in user emulation.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   ebpf/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

