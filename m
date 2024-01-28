Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0352AC47258
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 16:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rU82c-0005pb-TG; Sun, 28 Jan 2024 11:29:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rU82a-0005pQ-UA
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 11:29:52 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rU82U-0003FN-FZ
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 11:29:51 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a35899ed8d3so50799566b.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jan 2024 08:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706459385; x=1707064185; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gIMK+fj3xdLSqa25THsmAJhBs7ihf8MjAonKo1mKIbA=;
 b=Vhiv/k/eT9fxPPESPwlmznIKAQb11tJJqlYn0F2lYj+1sRvXuuQwSjXRx9qYbeW7q9
 amxMqd5HkW8XpN/YmoLfg+WPBTneoFfA1hScXVtJ3kFrc/SEOye7/JXj9UFWnkICZZ8n
 bHo/MTqMLZPWmbd/W78k19mlnNXBYrEI0vIG0yH2Spv9RfqcPt1M4DMuuQAnFyH3hy1E
 ZesQuPKjOH2Z/1NPruB5dOhaunY4l82bjZE2iR4HGkvWcWofMvumMZKxx/4mfXDkHAqN
 +17oUlD3bfez7TNsV8ocHuq9l4ZrZuNaLd7m1oCIephi7AajHJOUeCiRpsQHaiFrB3cs
 NOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706459385; x=1707064185;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gIMK+fj3xdLSqa25THsmAJhBs7ihf8MjAonKo1mKIbA=;
 b=T3j33rrRqrKlATogoEAYwBLccS5SMx+U1tPIgpVxJaPnGBsYBtEJWAlWT+nxseCcF7
 Ygzfe1p9JK6I5cqHnXCzN0+7rOBYzNdYhlhYjT2XKzZoz/PrtuuDKdowsgGiEvABC5Uf
 GuD6BiB7GtDcZz1PrZ6LFC7QZD3QDEXDJm955Rp0+2CaUx35ZjZ06MrballZzCiY+PQC
 a9lA8h5+Qccgl0O31yX+GuaHTvxPUtSzDZk0HSFvkGV8OlOrDqH/Ks/hfVqqF0WZsDxA
 npv/alpDrkrKkbH+O8ylWmjx8BescudoF9azpF2YBUKS4BITuN3iP+tCj0aDlpXGMuwH
 Io4g==
X-Gm-Message-State: AOJu0Yxkhupd0HhIZcV9kTVF7LmTOptRZlXF6CKfYdUHYyP2KlaIPWyi
 4HenUKkOX9gPYdOGVOAie9YJRmsyodKAEWpaTXgxR8XcL9L4cmzzSFWeFRosL9e0RHQA7GSvAM7
 u
X-Google-Smtp-Source: AGHT+IFjCn2Ycey6+s0Qvjb3cVLPeWhhd7eOOJf3/dcqaNjFdt3MLeIGKzpuMrJ9f6be5gcez+i3SA==
X-Received: by 2002:a17:906:6d44:b0:a35:4664:8830 with SMTP id
 a4-20020a1709066d4400b00a3546648830mr2503231ejt.0.1706459384791; 
 Sun, 28 Jan 2024 08:29:44 -0800 (PST)
Received: from [192.168.69.100] (sev93-h02-176-184-17-196.dsl.sta.abo.bbox.fr.
 [176.184.17.196]) by smtp.gmail.com with ESMTPSA id
 vh5-20020a170907d38500b00a3517d26918sm2440504ejc.107.2024.01.28.08.29.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jan 2024 08:29:44 -0800 (PST)
Message-ID: <5b95f541-d46a-49c2-9315-246601b4c6bf@linaro.org>
Date: Sun, 28 Jan 2024 17:29:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/33] include/exec: Move cpu_*()/cpu_env() to common
 header
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
 <20240128044213.316480-11-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240128044213.316480-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

On 28/1/24 05:41, Richard Henderson wrote:
> From: Anton Johansson <anjo@rev.ng>
> 
> Functions are target independent.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Message-Id: <20240119144024.14289-17-anjo@rev.ng>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu-all.h    | 25 -------------------------
>   include/exec/cpu-common.h | 26 ++++++++++++++++++++++++++
>   2 files changed, 26 insertions(+), 25 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


