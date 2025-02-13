Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D599C0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 12:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiYlT-0006YC-NG; Thu, 13 Feb 2025 07:56:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiYlO-0006Wo-SK
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 07:56:19 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiYlL-00088r-6A
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 07:56:16 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4395578be70so8796175e9.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 04:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739451373; x=1740056173; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BDCNxIhE766XzcNcnwFdyRBMPD2DEfS3YNwN5fSdqFM=;
 b=EmtTZhnIsbVWEvWSUVrwnM4q2iBs01tDXICUS6h4Ota+VPCVgS2URQMK1Gmx46FOLF
 QOk5StF27ZcCC6p4nFtfLS9GNuSgSOYCSB8N6YSuryG2VTz5yPmbljAhevzhu5w6LE/8
 6CBwV6HV6vD62oGACriGYItOFG/U+9UPWGx7+bcDJVQF0N1sp7CnBbXxDV/dEUCB7dTL
 eC33/df3ApceJeN2BsmzC9qLLnxyqSvlFqIpdoeD1E1/AbMlFCBgDvx0tWXaNKuzeg7u
 //iplJCqNt2g+dneWZClUjDlmPqOHA7HqJie0Kz7DWEECgzpLyBuujZGTtep836i9tq8
 /M2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739451373; x=1740056173;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BDCNxIhE766XzcNcnwFdyRBMPD2DEfS3YNwN5fSdqFM=;
 b=sONCdmON7AmXuhhlcS9TltbhqQbmNA322jF5KowAE7uUfIRiBK5Q+k2HLAzuY/mVWg
 uIsN+MG6dGPrVOlXLEs3oT2Vd89NH/WoLdLb+cNSzYcnCw6+z5lOjctvEeLKVjopfVgF
 w7F7BKK5xvrNLpkVXtNwJ7H5D3U7+qX8tHSysarFsh84nPtiI2dhSq1dWkQjNG/vL606
 1xmiW9jvyLo2DsYOaLWKObsLRH18JnrUnmFelsVF6ekOT7rqzQlaW7A8gKCHtYoau1x2
 prZzeoEIECARnhpxw9+nhWPMOwisLYKqNd0rj9EC+hCYzT2hPOxlMi66YTCyL64epnk4
 ewwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUO4d6ALnoN6tJ+jm1coJo6Qr+DzyMRBK5fjYS387EZ8L+ozSNy/h0VcJ7TnbsYebCgn3g1ZZVYJ2Ob@nongnu.org
X-Gm-Message-State: AOJu0Yx+YlDJguN3UCeH4OmeW7zOzmiWbTAjS8e+W9zW6RvlbQ/Y9orj
 B7e2RspccqcwohDSpwsAYghIxpUSWQDW9Qz5cJ7ByI3hVKKCQsI8VvLtnn6EadY=
X-Gm-Gg: ASbGnctu0IsdQLTGPXjizs4FHvMEIKJZXXzMj17iFqOL9Nc46cnFQaW3Ejk+jvAt9om
 aUDhEsDag7b9EUSHX4I4svE+o/74kd73BdNo1VjfTSrw/NUiTaWjR77XfpuZGhSoZoBZiRCX3Rl
 QPlzgoX5mXTd00Z2GxjtnyyYbdoLI9L2DueDdn6Pm5cDgo29dnlRcou3UXe1LsvoiVhPMI13+i/
 P82U3TUM7P0IkUVKCla7ZuXGYlv6VPHxsBM+4LMz1ch/MQfqDkp0RE8liisiTSY+oyvTdoXIuXc
 Kc30pNewkRvEwmUm+aPprkg6/c7TfqJijeXmQsvzwAzE8cI=
X-Google-Smtp-Source: AGHT+IHhStVW3iVmIyFAdHoz8eRApGxZSW35w00k2d7HOD4STWYIL771jb1uhUYusxvIdOgs6lT0Cw==
X-Received: by 2002:a05:600c:4f41:b0:439:30bd:7df9 with SMTP id
 5b1f17b1804b1-439581665a3mr70926115e9.9.1739451371865; 
 Thu, 13 Feb 2025 04:56:11 -0800 (PST)
Received: from [10.223.46.213] (6.170.88.92.rev.sfr.net. [92.88.170.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43961884f48sm16786995e9.30.2025.02.13.04.56.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 04:56:11 -0800 (PST)
Message-ID: <86c11702-3d41-4ee3-87ed-fc19ff00f87a@linaro.org>
Date: Thu, 13 Feb 2025 13:56:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] target/microblaze: Simplify
 compute_ldst_addr_type{a,b}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com
References: <20250212220155.1147144-1-richard.henderson@linaro.org>
 <20250212220155.1147144-10-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250212220155.1147144-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 12/2/25 23:01, Richard Henderson wrote:
> Require TCGv_i32 and TCGv be identical, so drop
> the extensions.  Return constants when possible
> instead of a mov into a temporary.  Return register
> inputs unchanged when possible.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/microblaze/translate.c | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


