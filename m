Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398C7D1D494
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 21:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdxJW-000555-Ph; Thu, 08 Jan 2026 16:13:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxJU-00054E-P9
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:13:01 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxJT-0004qv-Ha
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:13:00 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7ade456b6abso2473659b3a.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 13:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767906778; x=1768511578; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2/BXuq2wXJJxMizavzDlLhGRrLq0zjTviArPOtfknAE=;
 b=LeW8ei92zoecuJMfxlT5A3dxoHB3DXf5ynxaBgWM1sBmScaB2v/ykP6AUV/XowpBEr
 vI9RoVt92fdiUUGslMntdQBRmPnBY+OpYLzf473sFf99/6aDEqpBfzT84hP7d7DoK+Ik
 wL2lpY5DPEbdN/WofbnUcYBfSbFGM75nrKqESHe36UnmA7mXP3NgiJ1ltrsN4lE2n9a4
 s+1/TPxMPry0Gt0nT9zwAawx878V8ftN2gLkCvN7yrOfKbIls3VbnbIVafGzfc4F2+B4
 14eJYEgvR1iUGHqMVTfQ7lywK9A5rOWTM4lpigplZ+VYocKO/JIZUm+ixY2IWotJjo7i
 rZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767906778; x=1768511578;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2/BXuq2wXJJxMizavzDlLhGRrLq0zjTviArPOtfknAE=;
 b=URsav0jjIR72A6lSiU4czE9MsWfsH9MmuTU43VO/b5gP5BTNrgiR9nMm9wiCpySzI/
 XmJBErHIEqJyGanRJs8ScN3lwOzys9aBUoaVbP9pG6wrS3w+fMoRRffNaX59fTFcokfx
 yuj0Lqsd9oNEoyBIyPHDHbznfuUtJjT1QW4gq9ZZNiVOd1jPzMuUv1U9+iqAvG7xSuIN
 EvIiqgI958NlB2oFg1CBRshjJCxoUnnaXibDhFzYdnypzcJbNnRXyHnBt6v4oXXJXTg1
 Xs7lRImEZWMPHkxkLBziKG/CLh6VHBBzYug1WgG0pfFTH48eB1OeEGw4Kx87PNQ/X5+9
 PDrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOW1cfqLbRTkKOoWB7OhlQcj6Ojzj55fo/r/3ebKbLTGVTnfOQAzmrFINzLRVtnUZdiA0CD4NAAExe@nongnu.org
X-Gm-Message-State: AOJu0YzLovraK8cYoj4rT/q+Amo4uZvWRSU4qjdpfeD2RgHxBymMa2an
 o+XG3ZzAENrkj2uFZFvKnpJsAsTTH8OxUHkoRHTViU9HdrXyOUnKTGs7bk4b6Sn6iLw=
X-Gm-Gg: AY/fxX7v9qhu4YfLwGAYcRvZOiid3YHOELjO+OcNNO5S0iD3CgI6HyIJOrQ44NodM9m
 m5ZyoV5zmuGqUObegZD/E7T23GaGDJ7ArKQ120CKRLia/oGFCoV6GL+i2Gr9TTsl7Pz+AbF4VBS
 tYGWputmwGNNFBPbQqET5GS8rs8WzQz5/mgAbPcNtkXdQPt7Rr+5EXrHy/ZaktJhMHbX2a9fqPs
 mnutPKBqVwczZYk7UL8nY7FNoVRz3NxcWbB106ezqv5559buSPMIN9oxd78tQLvUqDNC1Zl9GSq
 MWsqG8sI2vsCaYCb/WS49Gmgb0tspKEBi9u+jD/wasjnvSNGE2+Efu7gDkpwbtkZE57QL+TWxdX
 I/mN8Ivs+uXE0Sg/HAj1jNvVjKFSaNhje7U6V0WvPmFgPZW18JTlAHLjNGka9jQlaOawbOzWHgA
 NvL/qgnrcHXIt10a4WLHHG37L2d6JVjXLLfOqOeQCO8h4afHq6rndCYvP2
X-Google-Smtp-Source: AGHT+IFNaf8NumZy+5yTZJNHJhWU+A9XdNCMkHWBDKXljVHxNH9z9VF9aKimN0e8fPO005OHfcKVWg==
X-Received: by 2002:a05:6a00:1d8b:b0:7ff:c1e6:5f46 with SMTP id
 d2e1a72fcca58-81b7d260b98mr6647310b3a.10.1767906777917; 
 Thu, 08 Jan 2026 13:12:57 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81e042e75b0sm243946b3a.21.2026.01.08.13.12.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 13:12:57 -0800 (PST)
Message-ID: <170be7f7-cfb2-43cf-90cd-88b8fe8f165f@linaro.org>
Date: Thu, 8 Jan 2026 13:12:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 39/50] linux-user/arm: Drop CONFIG_ATOMIC64 test
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-40-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-40-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 1/7/26 9:30 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/arm/cpu_loop.c | 19 +------------------
>   1 file changed, 1 insertion(+), 18 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

