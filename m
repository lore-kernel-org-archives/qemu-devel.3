Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71432E7DF16
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 17:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmyBf-0007t2-Od; Mon, 02 Feb 2026 12:58:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vmyBc-0007rz-TH
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 12:58:09 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vmyBb-0008LS-Gu
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 12:58:08 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a0d67f1877so31511115ad.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 09:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770055086; x=1770659886; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SdA4IpK0kR+IIn2kWTGKdcLcG7pScgogNzYq3sKC/ZM=;
 b=hOSNJaahrjv704nAny9LzpsME2Wx/q+Cq0pXVPGJQGWvSIWi6REkdKRPiFGX2XWd31
 aGvyJjmfe+EEmqbiKT5/UDeCxp0Lbvc/4MYXHRM1HNjGJUx5I5WOtzaATg8wvxXdTby9
 9sU2CWZmaitQFS0Ghvmcs5nI1BLN7vXIefbyHTN6r+Za5By0u8zBH3EXH4Oe6yUlvmdD
 wxUsFR8ytqTL5rXTz8zr2nV1VsFIp3lzkBGUOlfDWtb9LDKiL2wC3RhY0rrX0EKfcyLS
 4b3agIAtdboDD9+DG8QwPH+2p0uduriuPxf4WC3nIGl5EG5EWwuj6KpFYad2DKr6wRbr
 aDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770055086; x=1770659886;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SdA4IpK0kR+IIn2kWTGKdcLcG7pScgogNzYq3sKC/ZM=;
 b=swi6DM30k0VkqmsohDwjBAqZ8alNlcGiHXzcTlwYGbq84xa6R52zKx8Veh3/zOJjJ/
 URSWdc1m0k6P4jhmUY8m2a+0yGb6AvLL3313T+vZv22bEYK1iOHdlcYDiCGIBXCY9/3x
 3peHWwnyOZyaMm7oVSNsM8+eD3l/kJtV1WB4dbAt7ou9HPscLaoGfWXHAouqYaqzg4ek
 ZPB62OSew9ckmTQAyVyxiyd7Oelw0LUIAJXFFUTlKSAi0fapFZC+Juc1hTVa9dNTcHxO
 qN4PNYMF6l3EAGf0L3j9dfMWPWc9BySCT6T3KHFyMwNguZKVB59TAZMksNj1p+0uidRa
 dPwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUudYd5wcc5YVEyZN4VRpieHVBKj36KoLPMjMuhbcpQggNEnNpGma56AXPxcG0C8Rf0Bxtf3JgQ0OtN@nongnu.org
X-Gm-Message-State: AOJu0YzVCyXsE/6jg2cbck3KFFQojCF3acxRyx2IsLK4OVEBCIpumPHy
 BJ7JrlqLBSbvYCobxNJms4mc0Pv0v8N30N8yaz6d0hSRw9nSR5rKQiH0rIqLQ6bg7+M=
X-Gm-Gg: AZuq6aKHhhFcJZWwa1vodEb8EK4ZYG6PdFKT47kyNp7PexENKEo4R0WaFc+RpHMu4/h
 3mHagD/NhxHtTUYxrutgUjIEzstE7waxjYCdJJrY+QdxM1bErEnQOj/Z0FyefAvlxgH4I2FxgJh
 nvVL2mdP3lPOEggPhlGmLZvMmaYUv5Y7a96xfhu5sdfYgZkrEXnhJz1Mevh7Jb4u47k9luYu3lY
 cg4WfwQLpx3CsqEc/icqxGfY2CFFv74tZpLXzs/WpsECaiQ7jxMAoGsZsXW6TnVoHqXr8+CNk3U
 FkpY06HtEl+/8ZdS4QHI2otHqWeFcYT1YCSkMec7qLJF/nL48mSZAbIjEIErMkmAWpxj66UI6rC
 7LDcX3pm8cUBs6xneFvV7iK/Bl4r/ro5dsVuduQzwFNNirMlY4tSgGKNdRldrcJENkNlSdzZkOd
 jJ5CXjbewfVRmRQZ1mJ2yKiFnMT79bpiCnsjA6LbBHzPYKoWF5KFCHmwUL
X-Received: by 2002:a17:903:8cb:b0:2a0:fe4a:d666 with SMTP id
 d9443c01a7336-2a8d7eabf38mr133246955ad.10.1770055085898; 
 Mon, 02 Feb 2026 09:58:05 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b4c4e75sm155094095ad.47.2026.02.02.09.58.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 09:58:05 -0800 (PST)
Message-ID: <b08b5d68-cc5f-4315-aeff-d9eb5871552a@linaro.org>
Date: Mon, 2 Feb 2026 09:58:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] target/arm: Deprecate '-cpu any' (remplaced by
 '-cpu max')
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 devel@lists.libvirt.org, Richard Henderson <richard.henderson@linaro.org>
References: <20260202153618.78675-1-philmd@linaro.org>
 <20260202153618.78675-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260202153618.78675-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 2/2/26 7:36 AM, Philippe Mathieu-Daudé wrote:
> Since more then 5 years the '-cpu any' is aliased to '-cpu max'
> (see commit a0032cc5427 "target/arm: Make 'any' CPU just an alias
> for 'max'"). Time to deprecate the alias so we can eventually
> remove the alias code. Emit a warnig meanwhile.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   docs/about/deprecated.rst | 8 ++++++++
>   target/arm/cpu.h          | 2 +-
>   target/arm/cpu.c          | 1 +
>   3 files changed, 10 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

