Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C9EC25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 19:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG28b-00063P-PQ; Sat, 08 Jun 2024 15:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG28Z-00062r-PG
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 15:54:03 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG28Y-0001fH-8k
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 15:54:03 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f67fa9cd73so30651975ad.0
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 12:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717876440; x=1718481240; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kqBt0yBwL+0j9ErHKSKJsAJ6IfkDDT8iAgkV6O2m0Hw=;
 b=ao4oFAf2Wa2CvvlKud1VGHKg6dPNkzhjNeR9Ls6SbrchX5LzfRJwcE7dlYRN6vWSle
 94iRaV7rv+Mux2EsZ8hyYNvhC3k6YriUfWC3eN6ALHbEtZH0pGbS/BhVKc3fJ3Z7xcrm
 x+Q7NrlAYT3uXzbULF5qFbpXzZ0k0xADiEj94H8Vsv8FkJ/bhWbF8arcYF2gndil8xRe
 8bzI6aw3L/buT5gSHul/wNMDndxWqqNG89P0npsWUWW2zedVtBB2HomZ7QvHM/K+N42r
 SWIyc7Pab9RKiB8FQnGeRbJEVzM7TvhvgJDMyIrplpGmwrYWsji4JFtabWB+yPmaP9qT
 oNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717876440; x=1718481240;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kqBt0yBwL+0j9ErHKSKJsAJ6IfkDDT8iAgkV6O2m0Hw=;
 b=j7UueXoAimF7E6i5Ou4xvDtgeG3+Smfu9oLSEsWBcOWB3ThoIzapJuS+1F0Ct9NgKg
 svkx2s85TodC+VbO35AB0gFovCO1sFO3bEHCaBK1MpB2EmIQdB0STwwm1K79kSNKT7r2
 A8WvpCr4Jyv+DVR0gVOWb7H1iqPxAC/7tZQXMjSRlrLszaCD3mUL34tvkzF/UqaOK8Rj
 vQReVHf5zxwVjTgZa/GKZ7KD06rvBENaUYCsEWqjCGiUSHcT2HaU4AWva6Okwlqtsb28
 Q3suz1M0mCAP4hA/25FxSAj0GgPw5kLQSXATgqe3NXKjmTo2/2KAXGKGSMHkXDwY/k8p
 abBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq+EzYmoBUHa24vmNKMi6vzrXYrTundbwRo7lYBZ7lW3lYpmLcoQHaPbNDt+Ob2LGL1fDEyaXYGTMZWNxf+eydfHep1wQ=
X-Gm-Message-State: AOJu0YzjVQXWL5O2owxHsbmEXXV3OyrvNUpvNM6x7xvad0I3FlbcQbT4
 4DopFbaYOFpMATFW32mS4KIPrTy8qbXzFvOssBEG4YIuagBe6IOrPZ+EqyMg9uM=
X-Google-Smtp-Source: AGHT+IHCb/ulnEFLaRDnZEJ2VzWJkdQ7soaw2t7+Zpv1d+xX8+lRACAjhSZOw45RtzW6a6xS2wXfFw==
X-Received: by 2002:a17:902:fc43:b0:1f0:8cbf:c1b5 with SMTP id
 d9443c01a7336-1f6d0151b6fmr85258425ad.16.1717876440399; 
 Sat, 08 Jun 2024 12:54:00 -0700 (PDT)
Received: from [192.168.64.11] ([50.78.183.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6bd75f808sm55022695ad.23.2024.06.08.12.53.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jun 2024 12:54:00 -0700 (PDT)
Message-ID: <cc1327f5-cc62-4b7b-a9a1-b88257a5385f@linaro.org>
Date: Sat, 8 Jun 2024 12:53:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/25] target/i386: convert LZCNT/TZCNT/BSF/BSR/POPCNT to
 new decoder
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240608084113.2770363-1-pbonzini@redhat.com>
 <20240608084113.2770363-19-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240608084113.2770363-19-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 6/8/24 01:41, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.h     |  1 +
>   target/i386/tcg/translate.c      | 74 ----------------------------
>   target/i386/tcg/decode-new.c.inc | 51 +++++++++++++++++++-
>   target/i386/tcg/emit.c.inc       | 82 ++++++++++++++++++++++++++++++++
>   4 files changed, 132 insertions(+), 76 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

