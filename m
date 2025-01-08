Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0A1E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 20:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVd9O-0000Un-9W; Wed, 08 Jan 2025 15:59:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVd9M-0000Rk-IW
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 15:59:36 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVd9K-0007g5-V6
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 15:59:36 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3862d16b4f5so154603f8f.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 12:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736369973; x=1736974773; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GtUZtzYsN2dItAaCJMu1gAOPiJAuTbUlZb8oRT8y3zo=;
 b=U4wQgXASdLsZ/odsEL4sxngWFP5Fui/Nik1+Yc2qFaYPYfNAUqQR1XKTPmfF8IRabP
 wp+gh0RzQQ5LvCP1bC4Nb+PufNucIKYMG4lnSDGP8QviYRiQYOp63Ut4xgLvU6hdKOR4
 wy1bNvCDTj1OKVwwKk5NJ0UyvGZNRVsNBHWnast1v013lRvN2Glm2HbgMvpqyRwfBXjA
 /8nh92a72jWknxJMyf1AwrjlYBD2yBf3MU7v+E5jnmZnGjzHV1lKGbsgToZ8nbIxwI39
 moUXnJzZ4Erv3fexnjUFLKLROe3nN6+apnOK+ey/tlMgzXr0WypFjYU2QNkENyP39Gfp
 yX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736369973; x=1736974773;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GtUZtzYsN2dItAaCJMu1gAOPiJAuTbUlZb8oRT8y3zo=;
 b=RYbMGRzkWC0lEdo3Q/UzSWpSX3HzmTAoI1lXr4md1Ub8EBwcm8ytwl8OLnpGsEinUs
 wY4m0hVsoLGgNibNbuAAVnQlBS6JNvdV8I7mnLE1uyICVHwyHxYXbHZdZqC2I5kL0HFq
 yembMfsRPzL2aAZ40Lp39Ef5QigxPmE6HrwDWl/HIJeJt0b5A6tJyu3ekcGVNg1DP4n9
 KH51162rjPbJpqDWHkEEPTOyYaR1kbTue8JDMc8kd8UgQf9jIsmZ+eqM4o9PX6pSyz7x
 /PuhlZFsDKovfUUZHpgAT7RW6f3WzkygqK5MHJNYuUgrtcjKoBIfc+IorpGh0C+zkKNd
 prvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUFiPyNw24CXvd97fiXT4dekJmQk2QtqqFrw/2NbjAtn12YhkOzR+4BRb9H2bZywg2/d3XjaoFwVBG@nongnu.org
X-Gm-Message-State: AOJu0YzxexJNLHcoc3SPHhUGlimZOvOf51/dTLpNuImt1MzY0E4XOFbq
 cDc8HP3Ezmr+pCvtMvcoRfk+rCQ96sSOr9zR9k3SvvVWPvRc7+ooKlO51Si4wMnv4wnt0gobLH5
 M9ME=
X-Gm-Gg: ASbGnctd3plA17MkxT8cLkxJU18R4Zg8XLC/sjgg9A6DlPEZBLdnEzIhtUJN/6cVA/3
 cF5bUQa544JWKEz2uRMvidzInmm7m9J9qQuBba0NQZLagrh48CEgLZ37iEP2JhS533eFXvL2Ij3
 8jpSSWlc9g2+kPDdz+jjl89fwNs1UreaA36Nriw9TP6wqLGBaQOqhn6QOwkDW5yGN99Fa2aoAXS
 nahJTlegjPSlL/deJxbmIF0AXc656X5PegaeYsgeNJ189XALtS+KlMI+1zQz8Y9FORzbSDTIgUk
 ePnmgptHK4JRzNYCiL0Gi+Or
X-Google-Smtp-Source: AGHT+IEiAJopkRowctmgzm2BUcLY6Qj1qttocePcdqnoVOE27s7JMVVbfITjBpOxw0Lj0fNHZQb9LQ==
X-Received: by 2002:a5d:6daf:0:b0:385:e986:416f with SMTP id
 ffacd0b85a97d-38a8b0c7109mr629965f8f.10.1736369973583; 
 Wed, 08 Jan 2025 12:59:33 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c828ba0sm52918568f8f.14.2025.01.08.12.59.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 12:59:33 -0800 (PST)
Message-ID: <12446b1c-b466-4942-9b90-acc3ffd50d0f@linaro.org>
Date: Wed, 8 Jan 2025 21:59:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 64/81] tcg: Merge INDEX_op_orc_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-65-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-65-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 7/1/25 09:00, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h          | 3 +--
>   target/arm/tcg/translate-sve.c | 2 +-
>   target/tricore/translate.c     | 2 +-
>   tcg/optimize.c                 | 6 ++++--
>   tcg/tcg-op.c                   | 8 ++++----
>   tcg/tcg.c                      | 6 ++----
>   tcg/tci.c                      | 5 ++---
>   tcg/tci/tcg-target.c.inc       | 2 +-
>   8 files changed, 16 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


