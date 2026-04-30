Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6021CD1297
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 05:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIKPy-0008Ed-2p; Thu, 30 Apr 2026 01:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIKPv-0008EL-42
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:58:31 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIKPt-0003eR-HA
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:58:30 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43d734223e4so294934f8f.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777528707; x=1778133507; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rzxJuRzriK3IxHy7OmyF/U7z0pwPMStHGM203SivjQw=;
 b=P3z1K57U4WOwRuKNSGuq9q2l7YjjL/N2AVYN4AsY4Cyk6tnXb2KnEkW3xWKrV44+uP
 B2AyPD6NEWNy1uvwOluGPb+EvctgyvW8VZ+vj/2VEQisTNXFM4GMVh+kV38Tc3XT9zty
 DIhcV04zxpd9Ipr1dQVj9hce3hVAhvouDLxFh7c7jPtXY4Rtc3RUArXKpC4SjPpR/s1i
 QE5qp+PWBrNrUyfd75j+LNtc/Ht6+eKPE+LE6qYRnAkKPwrb7Rd9hX5G7PhGtwRRyJMN
 cG6hIZzLJLqj9ymcs6gnQ3ff0IIaFW/eWYR70b0A6bwyaEeEZWnTrkblgK/Vzean3fzB
 cu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777528707; x=1778133507;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rzxJuRzriK3IxHy7OmyF/U7z0pwPMStHGM203SivjQw=;
 b=fEbw/tqWbe7XROXDdxUFVI1LY82Nce1UtInwkCr0VeQcCpUCL+jNcJlHlRuLmEYYz/
 vImnp/uexCS7PGj239vnCrbAookvk9gDMuA/4piD3grxXtR8GdeNSgFNL8XSaiMM73qx
 9vdk3ZlXLWh5qOF3MtToQB/R8Nv1SyZjyb6apz3LCho1beaOK0zIC6frPdSz6lISWyTB
 a18312GD3F/cWmutpPD+kJ84vqc7cw5XF1OA2vyEvab44REAyfb6UNG9fwve1kJ+ObhQ
 3vn8ov2WT3/0XFyvc1rJ6ZLWmuLLqG+3qEksTV7moAj9oQmy2oLM9vhvvgZ7c/Xsu7bU
 i1qA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ZRJNtUAq0DKrtdmdU14xAF++jdMQxFqa4/WDG98MVjN+b42+4GkFSYtmnqxrbzNOsKCwWFx621RbO@nongnu.org
X-Gm-Message-State: AOJu0YxZk4e71I9raVUGr2dhnwz0IjcgvjX4ff4fqVg1vAvTUeNj6jV5
 EC99v8742DJb/P83rLSugYFSOW+oOZJTlcf2GEoZL2qd4dRYFkggKaukYllj6PsWNic=
X-Gm-Gg: AeBDieuuwUaXeTCLZnX9v4lCYOqFheQ+mtdQN2av5lEJlQGLh7itERD4pi4p4NyjIXO
 NAWSGYQJhFUeGMUG7ekN3H/L3ExgqXBqna8hl/eEiBk7ivDiMJdKmXGZJSMMxXC2ZmHcSbyTOIX
 CnjGuUntFjauYCVmgOrll9G9YMKPXXbez+FdE3BdhKMt1/LDhNkETeG16jANRUKAmY+FezlASIu
 oRhkCbtEl/ihrnWFf/lftc+qJjO4GPO/xR8u/9ICKtAX09Fs6Il5CFTg/662Me2UqEaF8SiNWDh
 GgM6jz/aSXuhq4NpW54423TPOo7iaEEKI888gAewVik0fat91Tx/BjlcrJcVbS+/ey7kOn6CSUW
 hEO9VcgCm1DZu9znCypkDziEgi1B3j1VOfefH6ozeJXZxeDLbWUAIw3Nad921qNTCmRMvJkdcpQ
 cCtQK2P9T9sZLnqaaYccLfdKqKx7TS95rkS5K8VX4iMJ//yAgx5vGVvJlrExhbWCrdxgggCbaLX
 q6J
X-Received: by 2002:a05:6000:128a:b0:448:908a:398b with SMTP id
 ffacd0b85a97d-4494fe78a2amr1015306f8f.14.1777528707420; 
 Wed, 29 Apr 2026 22:58:27 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b76e5c22sm10695084f8f.28.2026.04.29.22.58.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 22:58:26 -0700 (PDT)
Message-ID: <cf1397c0-c4e2-4ab2-a0bb-1ba87e3a0359@linaro.org>
Date: Thu, 30 Apr 2026 07:58:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/40] fpu: Split scalbn from partsN(muladd_scalbn)
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260430000524.56046-1-richard.henderson@linaro.org>
 <20260430000524.56046-25-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430000524.56046-25-richard.henderson@linaro.org>
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

On 30/4/26 02:05, Richard Henderson wrote:
> Handle the scaling separately with parts64_scalbn.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c           | 37 ++++++++++++++++++++++++-------------
>   fpu/softfloat-parts.c.inc | 20 ++++++++++----------
>   2 files changed, 34 insertions(+), 23 deletions(-)

Indeed clearer.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

