Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C2AC3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 23:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sa1jh-0007qy-AI; Fri, 02 Aug 2024 19:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sa1jf-0007q0-66
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:30:59 -0400
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sa1jd-0002ne-N0
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:30:58 -0400
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-39ae90034bdso38136345ab.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 16:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722641456; x=1723246256; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H/ZXWw9KcE6wQSHvOo1Pknhx7Jx+B6BM4kFYxlez/VM=;
 b=cCdlGQ2iMcNy7SLCQ13GJwdjabz/KJlY92y3nC2xsOOoatRERudu5cKTws6AkWFO+7
 ZmQJf282Etnwl1BI8Cz30pCcntJeOMxu00sbWtuwo9AdKTddf+RNtsJqWzdV17xrA+mN
 5ez+AOr+hP6saLZnNk8ioNqxW5TWXwG4/yl3OvQlj+KdmMdng7cafXiLXHQ59TIEkJvV
 5dpexjHn9+/D+EpmFdYGCGauYVdwMhWPegpwldbeR9AHDWZQuoy7Vi3BclTrHuYO80LZ
 KU+ldJrb5eKBwVpBqiyFe/tEhdCyAhOgkO4H7vILXINYjyGUOQ4uag7zl5uK8IePmz6B
 0hgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722641456; x=1723246256;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H/ZXWw9KcE6wQSHvOo1Pknhx7Jx+B6BM4kFYxlez/VM=;
 b=nO1vOxj2w657nvP0oZl4SOfAwJrrJav9A1q1n5vIV2amK4gwavMOg8TihKj6Hw81l4
 Xb4HYTS2h8RRYO5tvjfpCFqoNVV+i3EZkqki4nDeGILyEK1+SSvcZruBJ0+4aMeHompq
 GyapsPqjlG9bO8o7msODi1YpU2mgzhyWiiei7FictrgG8uXOr4U/RyWLqrTl+YlI6lOI
 MTlSlArT10B+UMtLlKWw42h1iQ97V0Iq8t5ua57TIVWWNRdze6lM1zbs121mpiJN/8pG
 MRzizYXhc930mlroXVQu75g7H/I1oENKFIE/9owUWQafQuoQXNu4GF+3EJs/kIIb9Qgv
 BW9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwYNJiiY7cX+muxoytVqEBb8Mg5jzYCEn1TSC89AQF2NtFa/W73ptBowmMq/l6PfKp/a/ELohCXTIkMaiIf3uPgcGM94Y=
X-Gm-Message-State: AOJu0Yxv/v9zV32o0Ce1X4cFUgrZbKT2h/Mb9PccidPpOt+2zzS/0por
 vXtyT0sZ3OysmLspDem9DEvfdHwA/vqfccXesthJWuaaS14+ksd5kg0AnTlpwOM=
X-Google-Smtp-Source: AGHT+IEGRXvE/gu1YbSIMmEGaVV0+aTp0jP+P2JhUnzaz/kyHbUQfFu4qAMmWDkIZ9bbPytH3M+qXA==
X-Received: by 2002:a92:ccd1:0:b0:374:983b:6ff2 with SMTP id
 e9e14a558f8ab-39b1fbf9017mr58368765ab.20.1722641456392; 
 Fri, 02 Aug 2024 16:30:56 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ed31870sm1820487b3a.211.2024.08.02.16.30.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 16:30:55 -0700 (PDT)
Message-ID: <02ef3bf0-7a68-4896-8488-fde79675f3e7@linaro.org>
Date: Sat, 3 Aug 2024 09:30:49 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hvf: arm: Fix hvf_sysreg_read_cp() call
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Alexander Graf
 <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20240802-hvf-v1-1-e2c0292037e5@daynix.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802-hvf-v1-1-e2c0292037e5@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12f;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12f.google.com
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

On 8/2/24 18:37, Akihiko Odaki wrote:
> Commit 05b8d7249109 ("hvf: arm: Do not advance PC when raising an
> exception") changed val from uint64_t to a pointer to uint64_t in
> hvf_sysreg_read(), but didn't change its hvf_sysreg_read_cp() call.
> 
> Fixes: 05b8d7249109 ("hvf: arm: Do not advance PC when raising an exception")
> Reported-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Akihiko Odaki<akihiko.odaki@daynix.com>
> ---
>   target/arm/hvf/hvf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Applied to master, thanks.


r~

