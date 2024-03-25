Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619B5C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 19:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ropp1-0003tG-Uj; Mon, 25 Mar 2024 15:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ropoy-0003s8-8a
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:17:24 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ropou-0006mF-HW
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:17:22 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1e0878b76f3so23302955ad.0
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 12:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711394238; x=1711999038; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+bufPoBIBD/m5wohT4zQPy2x7Dlghf72dvtJxL4JCxY=;
 b=lZMJeWL8kIZeLwlMJdXadqraZF+XB1mL5XPzRFZRgOlW/OYTQSaUsfFNSqTJ0zYMbU
 /nQMbglurzD+HT5/R8DGiOWuPcXKtlMH+5/G3vLQvNuVKebkiI7dS+d1CtmzkSMPDXao
 +qa7BkMLsjqEVLQzN/7VY53kc0r/2GDPxFTdNbSQ5d3YllUo7whPNtCjuA5KF02owJ3/
 dS7USUnHmm4rx8rCYXrB+cgViEmRY8NTJotvR2btwUIvAELBAw6Yje5xQu6p0V+rg2va
 r8AnurSW0CPrVYmMfgj+7yau5KnNW4E9P3vRqeOqZ9t0pWq7qHKQ2dLAhb/pLhSP37Af
 TrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711394238; x=1711999038;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+bufPoBIBD/m5wohT4zQPy2x7Dlghf72dvtJxL4JCxY=;
 b=jNmrm2pmDbLvj7f0LuMlI+2I4OBBUvPOlFmYYZrbLsFkaqzFKjyKjNjOot28fCELmX
 n2S7fTvgwAsfMwDZD3Ptm0itr0f8K3oUn4dbGLFuXnoLlStm5enJpi4x6xpQB+VePCFq
 bXz4kFymoCnrwBkR+vbl/Gx2vXby/mCo+hd1Tzuoyj14dCZ/VKvK9VayRR0uwBobOoGr
 ZV3xMJrtJ+hfY7TlaMzW3c7zUDjBEvmuMTLbXdj43iUO8TosqqOD0mUTotbpK9fHjEWi
 zc9zMV8pjt/Z6L2KpA856NFTWrQTT5z2FsUVNKxgXLoB/TsZ+E/twSbCa9cu2lLIPtoE
 Ah9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW49fJf2y2ifPq7xM68PskRVTHhEvX+hL3WbHuhdCdmbHnMnfuXj7yCd5oXIBCw7iZ2MUZ/GDZV9CG9vNpISJoYCgnQY8M=
X-Gm-Message-State: AOJu0Yy3aXZrK43jvT5kPPyA/CGAbDPEV3sqcFcLfbZ30r3+P/wjG1+1
 iMxZbcp2EPWOJGJsMElKLo79N0QXaV4Emw+CLEWo8cD2d9oiHcfw8fq8NyX4UUI=
X-Google-Smtp-Source: AGHT+IEisuVKqOZdNEg+aegnIblE7zSVNdMzk5f1oBLFvAhoReQNTpkOA8zHWHa5vWbWb0xiWgC3fg==
X-Received: by 2002:a17:902:e546:b0:1de:eca6:483b with SMTP id
 n6-20020a170902e54600b001deeca6483bmr10830262plf.4.1711394238597; 
 Mon, 25 Mar 2024 12:17:18 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 t24-20020a1709028c9800b001dbcfb4766csm5027389plo.226.2024.03.25.12.17.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 12:17:17 -0700 (PDT)
Message-ID: <67ae3c62-9261-4fb8-b0dc-8f735ed5d73e@linaro.org>
Date: Mon, 25 Mar 2024 09:17:14 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] plugins: conditional callbacks
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240325124151.336003-1-pierrick.bouvier@linaro.org>
 <20240325124151.336003-6-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240325124151.336003-6-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 3/25/24 02:41, Pierrick Bouvier wrote:
> Extend plugins API to support callback called with a given criteria
> (evaluated inline).
> 
> Added functions:
> - qemu_plugin_register_vcpu_tb_exec_cond_cb
> - qemu_plugin_register_vcpu_insn_exec_cond_cb
> 
> They expect as parameter a condition, a qemu_plugin_u64_t (op1) and an
> immediate (op2). Callback is called if op1|cond|  op2 is true.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/qemu/plugin.h        |  8 ++++
>   include/qemu/qemu-plugin.h   | 76 ++++++++++++++++++++++++++++++++++++
>   plugins/plugin.h             |  8 ++++
>   accel/tcg/plugin-gen.c       | 48 +++++++++++++++++++++++
>   plugins/api.c                | 39 ++++++++++++++++++
>   plugins/core.c               | 32 +++++++++++++++
>   plugins/qemu-plugins.symbols |  2 +
>   7 files changed, 213 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

