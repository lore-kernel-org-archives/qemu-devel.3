Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC30C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 09:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6S7M-000821-Qq; Mon, 13 May 2024 05:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6S7H-00081R-38
 for qemu-devel@nongnu.org; Mon, 13 May 2024 05:37:07 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6S7E-0008TR-UJ
 for qemu-devel@nongnu.org; Mon, 13 May 2024 05:37:06 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-420180b59b7so3705895e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 02:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715593023; x=1716197823; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gnScFvVjsQmaEqnosINQ/q9qWhHzscKTY5LCTqv3Lcs=;
 b=XlhK4JJ7hk8T6tkuND/f0IisgI3YpDRPsJxeMjAwu0lhdHpxSnCq8a7RXg2MLv77iR
 RB4Frb4KGpCv4nrpOU/6YvINdZS6N5UZU9dfZfLdNC0g0+EE0lBihuEti4Hw1j7UV0au
 eHGU+d3EYatzz2fYo3qCpgkBYNGecdanVJqcMpGg/wYgnZfq2o7zIHVc4uWvuBCy7TIb
 +S2JA8MhT5eA2cZiWMaROtZIMvVaOTqy0ex5sA3RLlUfDWYqz5Szi/gMNhP+5Yh3wRXa
 sRBwqHvFka8U4teM7bbkRuPFJRizrC1z+WWlnAoQ/hiAUf2d60vDR9iAdmaJU7Q+MPyk
 Y/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715593023; x=1716197823;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gnScFvVjsQmaEqnosINQ/q9qWhHzscKTY5LCTqv3Lcs=;
 b=ettDB2MT4FcioYRBeDyoYRUZorjkQKUf4+HNlKXq7DUcpSAd2aOoWAAo9ttlVu5AfO
 kobGuiM2gvRpHb9grDHhnGeehU+HJZRkI4tC3swUCWjZoezI4AewOYdl0jj+v/+/KxFt
 4vhBke1UxtTiW4zTlpimVzKAssbMbdajx4+QDcY+Ctt+BIPHDw0935nOcxO51R6L/K7f
 lMoP/9R1uuQuQ3ZcZzVpZqleMOfbXRQr6Cn2UQnTdd8y9p4uH4H+xKlya9yN0ViX2wAf
 BVL5vu/lcoDtXBFVsgGoY/QOYUtrptU0VuNWTd4oO3e5s3/Y1hcGRGucpKS6Tqubhkw5
 yeqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTeBBSOX6UC8IMEjFWvL9onkMpC14xtCzjs3kv+pNhqmwab1egQsKXN3AhIhsTnSk8dhxZOuODSup3zlpH0jmOZOn1Yq0=
X-Gm-Message-State: AOJu0YwEkRsUqYY9gNbzAI/Dt/hvUI1DwKNRHAp/9rzHm5cMW90SE4UE
 PomJQadG/KO0i9zaeUtqdjuU4turqEAzeZVhjJkOBMU1X7QiZbTynTbY99pEZP0i3bM57wksvVK
 7Qkw=
X-Google-Smtp-Source: AGHT+IHjFJdWSGC+GkHAp/Vfi1qhvdHPm2bfiB2P+J4SdGXPcsZQeyqe4Eaj2yvK1lresamNMd6qEg==
X-Received: by 2002:a05:600c:4752:b0:41b:fc7a:e7ee with SMTP id
 5b1f17b1804b1-41fea539719mr67174575e9.0.1715593022901; 
 Mon, 13 May 2024 02:37:02 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccbe8f8asm151712605e9.10.2024.05.13.02.37.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 02:37:02 -0700 (PDT)
Message-ID: <5936427b-7aea-46a4-b2bd-5271836cdd8e@linaro.org>
Date: Mon, 13 May 2024 11:37:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/45] target/hppa: Use TCG_COND_TST* in do_unit_addsub
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-24-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240513074717.130949-24-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 13/5/24 09:46, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/translate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



