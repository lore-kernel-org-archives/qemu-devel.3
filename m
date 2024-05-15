Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5A5C25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 12:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7E71-0008UM-L4; Wed, 15 May 2024 08:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7E6o-0008Ow-70
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:51:50 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7E6m-0000QO-LL
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:51:49 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2e3e18c24c1so73456261fa.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 05:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715777506; x=1716382306; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jqM54zAj05kMI4eCrx7iyBzziAkzz4CYe1PDJFMFx/I=;
 b=lPiMK2vY+LbXwNrSpPOL3FEyxgCvXs7tFL5Yk1NY6xZ4YR4J0ky/27j2zMrfmMV7+m
 k9PjA9pS1TqB8zXlQN4L5SGCpbrXJQat0s2jvtBdnP1oTL9sZWgqPIqPitXm9EWNv7KZ
 16G87tEWHqjp/EJXIvpTjHRjfc88djK4Bvp8XHJzOI+YxFrhNR62027bWLM1F1LIWHrR
 VCi15a/lvBifEl9FQ+oezOrPfaKibajBMvB5uS53AjNrgOtmaVIa6mnpQiMBuTxnRZ4b
 XNfknkWGf7ykACuO5ZN/pZuf7fVXaJu/dHVCFQdV6QduPal16xb7iP876Q+mwgFRTd/o
 ckTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715777506; x=1716382306;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jqM54zAj05kMI4eCrx7iyBzziAkzz4CYe1PDJFMFx/I=;
 b=DFDhsdHP3jWyhVUip2eW+b4lUFyYLVSecvJwtGKIZmu+Eb2xeOF6P+vS1LaEfV/nxb
 p+khY7AzRI54e/q/c8373YftLqtRkgkT5RjtNJz11FeN0Pcu7y7ngNbfyKpp69hsrYdi
 bmit5fWEs2O2Fu8wTRPL0/8R9rZCiUVhAWIrTZLZFRFCiiFMuexyBPCkF701vbuLM+JD
 EaGawCHRhDK7iV0ejY40yZ01jGgC33RkK4lJ1tQx2ThyfRXyRpiCUEM71xu/w05voXah
 vvECSA7yEIm0ZHGQH2LfD4SeLqUYT1TFZdFzHYD6fb720G2H6OmIjd4V5eysbNzO6Fcl
 tQiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+G/QSE6LAs9xfKmfcGDYkx3Qrk3XOJkjoR44P9gHQt13/yM14LH7lO2a0XO5DZrn/Zp4MFYeKATstoPOlYA4ifPAFJto=
X-Gm-Message-State: AOJu0YxbbfdYpwIFmLnOoicC0LmcpCWPLZLVfY9cPyC3q/d+8wmcRnhk
 q/qhIFxMjQLwwxI19wh/XvMCwsd0ySquCuZKPQnfnXAmspVVPthSOjlqUjcaPJs=
X-Google-Smtp-Source: AGHT+IEeDMsBv0mOY9XQWvJtnxvS3sSWOw/POp4OliRR1L8UiRvI7ojrvzbsHe1JCEfPOqIghfiAyg==
X-Received: by 2002:a2e:9355:0:b0:2df:e0c4:8429 with SMTP id
 38308e7fff4ca-2e51fd4afb7mr102409291fa.18.1715777505937; 
 Wed, 15 May 2024 05:51:45 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccce9431sm226953745e9.28.2024.05.15.05.51.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 05:51:45 -0700 (PDT)
Message-ID: <67fb79a0-aa9a-442b-b6e7-df78be9f464f@linaro.org>
Date: Wed, 15 May 2024 14:51:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] Fix load_image error check for mmap
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20240511115400.7587-1-richard.henderson@linaro.org>
 <20240511115400.7587-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240511115400.7587-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
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

On 11/5/24 13:53, Richard Henderson wrote:
> mmap does not return null on failure, but MAP_FAILED.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   risu.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



