Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBAED1D48A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 20:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdx5A-00058c-BH; Thu, 08 Jan 2026 15:58:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdx58-00056n-Id
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:58:10 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdx57-00037A-4b
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:58:10 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2a0c09bb78cso18857955ad.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 12:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767905888; x=1768510688; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Te2WEPIK1YmCvFbRP2oRZFT5F2NqB7LK0GkR6ahKnWo=;
 b=wTwkEdX0uYFdk1xNtFm/J6n47uy0JqpUFj8WRpNgZJGX2pq4s0vVYUXSTh/9tgGuLH
 dlYMaUxw+rfKMio/pBzLKS+Nxd8i82Ee6LkUMae1OgO7cPFiWFZIWf+6cUasEiiq5f31
 6I4arxzHrYZUinwpmLUS1hMSNAx005ScA9a18sONTKOxviySDMVTuayidZo/a9rFUiv/
 p5e994cjafzaKMZmQZYjOLeKkd3n8VYqhojnmPwr+BaA6bjKG6bwU6YI+0oYkGGxEz65
 hRk4rGGTPLwtL7RK223W5OYB74oGOfMLFwmJLTFPNT6Izr1yEowMCzhRLx2hZ6WwD8re
 o0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767905888; x=1768510688;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Te2WEPIK1YmCvFbRP2oRZFT5F2NqB7LK0GkR6ahKnWo=;
 b=JExAopc+AwfyyvhX7hbGC2Mr0t6SKgTt4Lf5nnwQEoFm/xaHf6uJ8LYGKzzPX4jMNZ
 UW5RO65HSkPHoekTjUGpQLtcMIdAhL5AmfAbXsDT25u8AfBYB7Ub4s01pcGCL7YyYvti
 MP3O+y+0R5KQlLiWG1dWFrHLHCfcJZzBBvWPITpIx7FHPt0+uOrNj3XZAOi1wXw6Nx48
 r9Q2FhrST4PNKLXYqBMp3hGKykonbndw9HgiD4STnUiHjEeQzqqhVVjGcnJhmtYrUocr
 1mj5dLRY5SBR5+n/+aPQFVvyuGSFkowtLY0Hgzmv55+sZNsh2jO0cJLM/2WztRHdGsVg
 bWbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIkMsK/Fg9IVc3aserSQ4PfvX1x6J+u8pXZc0FmIAF1xlQ1jv4Oe0m6a3U4E3NKcABcJW0VeqalQxR@nongnu.org
X-Gm-Message-State: AOJu0YzaVXoJcjPLtd1eYSVmVAE2vMNnA1uJj8DiqG/Ya9w2AoDXVA5E
 U0i+BA3mlGwEuDQZBoPkTvckgD89psLhqUtZHFsofbQ2/LW1JeXBbAR0T+UURd7x+GzO4Vie1gQ
 +RIX7
X-Gm-Gg: AY/fxX6ejbNU4iPuEyHQL8+Dn01RCvRpQZ4Gz9AmguMKUhA+gxMYSTw+2Q71REZJDjO
 TKOFO+eh24wgcriHw8glgbkD9/tzyS+yqaKeUbWSEvt5BWR7qtb7hhDMwlXo5Q0n6ciKaOp59zQ
 mFkt7yf5xln6t3iHSf7xfbarM16d7K0eEJwLpZvxpbWkj9dDXeWdKusVnUtloascAkQHzHIItAI
 PJNLZeUcY1Ys6Yd8woAUjRhpDJPnVY7YzREj2VmbKCzdY1bBY+JRLWOh+9sYtbJU49k4Tzpn/rw
 x3/mAzK5mKbPgG1WqvHvMC8DY5mSlSMo7pqggKHj50ZIqW+TZBDysAlQfvMfs691LD5OLQbBwhX
 DMMTeWyrg3IeGxS/rbXeGjkeeu4iQDHT225DNRG5wtu0TGwaIyqj3nD5n4UwGgq0W1sVuahQb2i
 utvVPtR+6SmLhG/Qsv7hDrjShHRZqT/R2IRvscWTYvL4yB9YUiLeFauLjl
X-Google-Smtp-Source: AGHT+IEZwHelotJI41Dkq4J4AtKJM7ca5D/46HUrmvcMCs5aZWufrt+8et22wvXoALZuonaUVCd6kA==
X-Received: by 2002:a17:902:c40c:b0:29e:e5e6:247c with SMTP id
 d9443c01a7336-2a3e39d82bdmr95137035ad.14.1767905887613; 
 Thu, 08 Jan 2026 12:58:07 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c4796asm87554695ad.34.2026.01.08.12.58.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 12:58:07 -0800 (PST)
Message-ID: <e7fb0ac3-c28a-4bcd-8b88-583327590d67@linaro.org>
Date: Thu, 8 Jan 2026 12:58:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/50] tcg: Drop TCG_TARGET_REG_BITS tests in tcg-op-ldst.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-28-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-28-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 1/7/26 9:29 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-op-ldst.c | 113 +++++++++++-----------------------------------
>   1 file changed, 27 insertions(+), 86 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

