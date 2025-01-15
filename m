Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FC9C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 19:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY9YL-0001Jo-9V; Wed, 15 Jan 2025 14:59:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY9YJ-0001IM-Nw
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 14:59:47 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY9YI-0004V7-8Q
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 14:59:47 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso635405e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 11:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736971185; x=1737575985; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MzB0s4/oh3KhEMdnl1xM51Z6Lv/nmbk0AMQI3nKPFgI=;
 b=CJ1sXjQS68zGDxvaTg/XMGYckGID4syMLlY1P6EaFKXIEIGWmFuf0GlAW3G1K9y7Mc
 3ImBHL0i0M+WctDLOi/R5VltGaI54MwcTLyqv0NJTpI1E0V78og3VYtdGWeZVY0OalA/
 fl6ytQUj262uRlu3OKIPoI+i6awL0LHMFYLI9ALt7d3jKF66lpfQt4IZjTpoJ7fmKYxX
 WhDTNeQejmyEMMW+Gi0NClIxsgGO4Vmi19KTzg5ri/JdFYwZkS1D4NYULOa4+zxhri5t
 VLLNPB6ibDhmLdR4wcOpn2AUVkdAbdwxgGdMRa9Q4pidHQlYnPP0NAcuOI5itAgwU51U
 0W+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736971185; x=1737575985;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MzB0s4/oh3KhEMdnl1xM51Z6Lv/nmbk0AMQI3nKPFgI=;
 b=mNuNWe0MtNJE/E/vpXlnmGuqBdLQulNzNK8G1o9HzfjUNqYUmyKDexBkWy6WA8VScR
 ALmuTcF4lDFZonpNUh5Mbu79/AhMrx/ankX+UM56yMophoiNvm7CMmhYRwrdeWxLlZ1r
 oB+jmNYkpFIecCe+X/ApBmHMToWq37RRGNpecFM5+hdugQ9RTJpKDSpKgGWNmHn5FFmG
 +NH2w4HqhESt8oqYFAE8LIaGqEnuw4kD1H/RaR0KjVKeYIfySFdss4BAqJia6HR2jIGa
 GZUeDxRuGGOEm00KCCPeCvBxy3Lqz2F6y+jS2Ysj+J7Gr1NX0q+hLSsbng/vUGyxbCuF
 c+Lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV35ezpBg3Sn/c3dlEMyebwcbI4QyEbbR4/BpFL0wQIPJdE0Ia/yfnWNUnsdF4bZF8PcUhuru6t5Sv+@nongnu.org
X-Gm-Message-State: AOJu0YwEewXtvfvWSez2DDym3+WqANFQU2OALrj3qmGLba710QbmhVcE
 RGFC5KoeUB9gpILkLMVdVZC4Yi7cq2Z8bBWvUk27uFYFnuvLDmQCTL+C1uM6QI0=
X-Gm-Gg: ASbGncv2J0ont707rxJDGzKwgD9+y8Dpiqbl45SCT/97lPRj6PnYU/BnChZfa1rX4TQ
 la4tXGgDYRDpB6YCsI4mDYghNWqOKLFCZBvRKin3JZTk4UrMH2uAikWLPDwLww6WwYhj8eUaqYL
 LC30Zk45zuOiM32Ocrw9I1oiN/pDdrmXv4oGWqjsHcc48HpH2I1FiGK6CG+Klw6vGM6DV/DDLDQ
 1PNm5F/iATaJHCuBs/e9pvoMxxmacbCKKqtuv+5ShrzengI9wfzyJ8uIm9po1Gm0NKxYiSfGxBG
 2C81WJyrN0T8q4RcM6vEjFLo
X-Google-Smtp-Source: AGHT+IGtQKD9eIKHhwBx9gfPfG24gqoykMNVq/yOCcPis+cxnrVTBa+rrHXRrdD3+VxzCNBk1jYKjQ==
X-Received: by 2002:a05:600c:46c6:b0:436:5165:f21f with SMTP id
 5b1f17b1804b1-436e26d9482mr249229375e9.26.1736971184793; 
 Wed, 15 Jan 2025 11:59:44 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74c65b7sm34732925e9.23.2025.01.15.11.59.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 11:59:44 -0800 (PST)
Message-ID: <38d78719-738f-4846-a5a5-cedcb86162ba@linaro.org>
Date: Wed, 15 Jan 2025 20:59:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 31/81] tcg: Replace IMPLVEC with TCG_OPF_VECTOR
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-32-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-32-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
> This is now a direct replacement.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h            | 89 +++++++++++++++-----------------
>   tcg/aarch64/tcg-target-opc.h.inc |  4 +-
>   tcg/arm/tcg-target-opc.h.inc     |  6 +--
>   tcg/i386/tcg-target-opc.h.inc    | 22 ++++----
>   tcg/ppc/tcg-target-opc.h.inc     | 12 ++---
>   tcg/s390x/tcg-target-opc.h.inc   |  6 +--
>   6 files changed, 68 insertions(+), 71 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


