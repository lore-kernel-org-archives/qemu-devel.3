Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B0AC52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 09:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdR3o-0004Lx-9W; Mon, 12 Aug 2024 05:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdR3n-0004LT-2z
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 05:09:51 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdR3l-0000hk-MC
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 05:09:50 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3db14930a1aso3132535b6e.3
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 02:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723453788; x=1724058588; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l1evJnFymz+wgckJ2sjWESRUvsUKi1KCPmbxkaIKnEs=;
 b=RGun60bhTkKq0RYG9HU9FRbHYTNCDQr38Tuuqvocm3eqGGIeFF/iBTkt/WF8vdF5xG
 NSJcVwZBHSWbWpEJqpsLBId8DpjoR9OkoUMseQXZGxKHFhpSXed5E3GEHy0a3YeqzvJr
 ePNBrZ/DxDnYuC6iv2YzgNHWUxgnnRAnXsXF90GwhCv40Raz2FoW3ho/SorHM7jee5ui
 MOMWKTuWdaN5vxR5qEbebP1kZkv/Q0kmlmQNZ/XRFWr+XmSGYu2sGq8E/0o/eFjfs8pK
 mha4mrVXNlwTiWelWJtscQGM50smcPdYxBCthIOhI4pAM+aYVNHuCU3DFo1cNWhhqr/A
 l0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723453788; x=1724058588;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l1evJnFymz+wgckJ2sjWESRUvsUKi1KCPmbxkaIKnEs=;
 b=iF47SCOM+u4TGW6y8wOMjj3U617UPKDdsPbZ7tHbt6ksMbqyqvL7jQp/F/oXfT1XYV
 TW3ldSM7SY7b+HAAO6ETrQ/ZrUqCOLDRZ6loWKkbLU7VyEyim6B4skQVvv3HFkXN7Sd+
 jSBG1N8+/q00jJ3WPdF5pGIF/j5DjC9rksys3PJ6HN9aZf+/lWT30A/onVKhidXbhHfv
 q6LE0amIYHW58RlTMknpX78ky0W7B5dYqlD8t16/fi4VbUAab+X9trwwnCfBEwPhDhVo
 jWUMEMKDlbYTUQArUlOw4V5QL/2txSNOEtnaiqElaXahOIrN0GO8pwspR/mWw37abBmj
 Qq/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdxktq0yYVic/bL4cWr5W17FzrLT69QSWf9NUv/CozgeushCWihATyd11AUUBgZrF8eWV6Xx3LqemMNaF8XMYNGNKl48k=
X-Gm-Message-State: AOJu0YwX4Em9SN3e8e7f/pfQc465E0Ziq1FwTEeQ2PFSPiA84j9lwvVR
 m635Mw+lS35G9TnyaIKsUt87cqo2ADXDOn5Re3Ic3xHSEdS1K5Kq10Esi+cuczE=
X-Google-Smtp-Source: AGHT+IFJNiNSb8HccjKcQzQzNlqDkdzxyPc2EjjmUHrYep4eeFol8DwcrVRHDV5cpovUR+jrlWTaMg==
X-Received: by 2002:a05:6808:1385:b0:3da:409f:46d7 with SMTP id
 5614622812f47-3dc41691779mr14036579b6e.30.1723453788362; 
 Mon, 12 Aug 2024 02:09:48 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e58a8077sm3573418b3a.61.2024.08.12.02.09.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 02:09:47 -0700 (PDT)
Message-ID: <80eab7c1-05d2-4db7-b4e8-2cd4d6d59b24@linaro.org>
Date: Mon, 12 Aug 2024 19:09:42 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] module: Move local_err initialization to the loop
 in module_load_qom_all()
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: den@virtuozzo.com, andrey.drobyshev@virtuozzo.com, cfontana@suse.de,
 kraxel@redhat.com, laurent@vivier.eu, mjt@tls.msk.ru
References: <20240812085725.1093540-1-alexander.ivanov@virtuozzo.com>
 <20240812085725.1093540-2-alexander.ivanov@virtuozzo.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240812085725.1093540-2-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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

On 8/12/24 18:57, Alexander Ivanov wrote:
> Move local_err initialization inside the loop in the module_load_qom_all()
> function. This change ensures that the error variable is reset to NULL for
> each iteration of the loop. This prevents triggering assert(*errp == NULL)
> failure in error_setv() when local_err is reused in the loop.
> 
> Note: The local_err variable is freed in error_report_err() so there is no
> any leak.
> 
> Signed-off-by: Alexander Ivanov<alexander.ivanov@virtuozzo.com>
> ---
>   util/module.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

