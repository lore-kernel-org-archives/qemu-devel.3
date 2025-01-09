Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54628E7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 23:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW28Y-00035n-E5; Thu, 09 Jan 2025 18:40:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW28W-00035Y-8H
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 18:40:24 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW28U-0004sx-Ff
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 18:40:23 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso11787875e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 15:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736466020; x=1737070820; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w3fvygan0RdgUxJplyfATW0gkV1Zp6LwByjxu0dpBi0=;
 b=YMft10ax8XzIj0pNVNKZF737U/dWlsIy7w/2Y9NY9sBK70CpuCRZwA8JH3HTWp/Q4X
 pcBDVJo/SnxcFGHxMFKjcdeNn/uSH3RbtpeXvtBDlS/AcBLhKUFx+t9nbWA4yOXTAUYB
 LjPpZN4bfjn4cyY+QKtdhU3u70X3Z3rUa34NDGAKqwARCLbsB4oJShqNmCDxRV+mBejL
 4fZea91QfYbF7b02hI70riT1snNWy5aw8JpoCcvgIy4V3ZfJ2N/ZWK1fCuMA2/oGttz7
 xKHfEiMIw0XgHX30E9uMnVU+mstb17z+n+E0PTrfVBa3pHajJvsn9uYXOr36dulYsIz5
 5Beg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736466020; x=1737070820;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w3fvygan0RdgUxJplyfATW0gkV1Zp6LwByjxu0dpBi0=;
 b=fvHi4LbhprAFiW+qnGAHAnPjSfU+mu5qfv1fGY9eRMT5FQTI0OJdIZ2TF0s4ZGNO8f
 manykHWy8sXj1DzSBZ2rHW6Qb/bmqSeVVqkvPinEeOVjCPQALstlHbcJhlLUxyS2N9fD
 VxM4GD27JfjIlqScInnxu/7wP5amXTqrFdsfO0a8Os04cdTMObbbS4AfsJNvG42/Vu6g
 3pCKgEPqOqQjleWI1jYnCyzbjpjxdtmJouG4ybSWbJnTv6WvTulXst5w7fJmmr9WTqmK
 p1sM7N58dgD0NOzGNf3iEX/+ucr+O6EOq29JdF4c5PjubWtGcNa6r8OfL625MO5a4nDc
 XBzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUucbYX3PvOLFrfGdyLeNQ3s0n1BdCAlrbBQ61NCFD5Z/8kBB4zjm8PMbLoaFBDxM9biJNKd0nUgOHS@nongnu.org
X-Gm-Message-State: AOJu0YybFSfHdlu92oAvqo2F4XZOh2n0sJROOvP1iCYx2LmQhY03cwN+
 7+mJj82zq/0g8WoM5raDH67lbGMaSxd7ijsGByJJLTD2xoKhnr/XkbUZGFISkTkoYLlHOfthASB
 Vgsc=
X-Gm-Gg: ASbGncvRbpjxTIsb4jT2cKrGPPTHR1bBs+SxZRPAKP6RPh7ONLbcIakir1ZQQ1HJAXM
 mi52bcKUPp5FgSJqVorTBCdf9XbcemBnVZMoes3zkmJkBGSO9w0jOL2i7frSRnq3SqRLNc2WaGS
 yjJ8w25dLPMpX98SGdw3EWdCTsCK4zgWY64ax07Z7ibXvqI7MqY3lUcDEcokNphuMYm578BdtUz
 cii14HRCxOUt0cJYorU3FKIYispP7hxZQm6pm2adA7xG7tRYardw0UVLIMXre6DesaYHFl8oBXp
 WJBzyFkY5ICivfx5q00QbdlwFNQ=
X-Google-Smtp-Source: AGHT+IFB0oc91t2PElBd45vOApvNZ0c76TNeukRbJAD5UoBPnolnKnXMb+cTIw4yA65V+5ifIxBnig==
X-Received: by 2002:a05:600c:4f49:b0:435:194:3cdf with SMTP id
 5b1f17b1804b1-436e26bd59amr76977645e9.19.1736466020579; 
 Thu, 09 Jan 2025 15:40:20 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e89dfesm69422805e9.32.2025.01.09.15.40.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 15:40:19 -0800 (PST)
Message-ID: <d42bbe98-8221-41a2-83a5-58e537906969@linaro.org>
Date: Fri, 10 Jan 2025 00:40:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 38/81] tcg/loongarch64: Fold the ext{8, 16,
 32}[us] cases into {s}extract
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-39-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-39-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
> Accept byte and word extensions with the extract opcodes.
> This is preparatory to removing the specialized extracts.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/loongarch64/tcg-target-has.h | 15 ++++++++++++--
>   tcg/loongarch64/tcg-target.c.inc | 34 ++++++++++++++++++++++++++++++--
>   2 files changed, 45 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


