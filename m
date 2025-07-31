Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35408C87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhbIM-0002mV-02; Thu, 31 Jul 2025 17:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhb9t-00036M-1G
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:49:53 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhb9r-0002gn-JE
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:49:52 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-76bd050184bso1267707b3a.2
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753998590; x=1754603390; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rk4eYovVpGxfM3B6ShS7EhV/vVImOV7bPRhmnJl/qNk=;
 b=A+jwf/uXWtwoyUtQdIhZFqhqGGSCZcOrseiReLLTBNlvPvX8ZnvE/FOdV0LD5fgzl5
 03N3dHtXwhqSz41B0/H7u44/5n5I7V0al7wKBU6C47fGU6kMc8dYAbxqSmViVBbu98yP
 ZarBGrv2JEuURNpon0YUnnwVEzE7gZqoXYKEcItbJ6uaHzRoTBOlYtXbouMhNShuBQfz
 0bIINYqSZ8XMLCb6tsKXM4E1szuWwOiZUzmn+D73qFqDqcCFnfcADkxl8cjfPzLRt+b3
 ODYVRJG2kBjBkPS/FQOaHX0VQrbLklETMaVtq0xb7wbSObc8FuQP5sHryHR/ys4fJuC0
 irhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753998590; x=1754603390;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rk4eYovVpGxfM3B6ShS7EhV/vVImOV7bPRhmnJl/qNk=;
 b=pwZo3cIyAW4jByeoeMFbpjwLF862bX30irhQpypj5gfwBSd//8SWWUt6lbLr3hgFFp
 TZdjz9yncAuivkb5a8GVXBkbyHyy2r0004z2MiEV/X1PaZDT6+IXuVumiIvtwe0gjR4X
 WmyApSOQ0ARw9GAltlLpsnXO8Gh/cj2YBEk2eEMUav4yOQXC7qSzxSVI2on5LxcoQVV5
 Di2Nbx3fvOsJMYhB2jZeFefFKF+DHE+mHMscpuVSvdJpS6w9KDsfGSHe8g3wDe4EvCFA
 FL/8dkfFsBAIGGRcuOLuINcMNEewXr69BWz21OkT4CUsg4MUCjcCl+eL/pNpNEu9Ud78
 +TJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/nB4lPfQPJEZZo/QMiUL603eUCjQQUNHfj+MmbYi/d9CQK6AW2cYqkkfI7quOdGHYKhGsq/5RFqk9@nongnu.org
X-Gm-Message-State: AOJu0YwCGa1zWWjMCY5v9yw6lCmX4mKWslALny7xmpTi9rBiNP3C8HjW
 WHze6fR9akjwftG8srI1LKvWy1Rwdvaorb5+cWfEWNGK6Kk/XE1gCO2sAqPfc9OAXe1dgB8C2Hs
 PQNwA
X-Gm-Gg: ASbGncsmczEgpk+hZ40K4zf75zyR2u6y3VmJ4PViefDHbLl+FOYL1lbyN4UF6/5DNGa
 DCuAd/cEFhPwTZdiQ6NKtYLIuFPaSG4gAjpF8AC/qTbA9kt4gKnGP9eQ5TT6ZPv9qsDoN6uW9Sz
 p+1NoRkrSHDgG1cptLz2nQ3qh7HuhkBe4/bMoZSekfBM2w4RjQb/Gi1/ba+6lz3BzL5Y42DaceB
 vJn3dJXXAUdv6Kby4DUdTuYXk1bkkO0SDJu9qbE1WWDUPI/Z8RvXYTHMZVR4OTVNwMvEjQWwYTn
 Ax465RUUkmMRPgwMqSaGabfm4znXsm0mb3jQmsRe3y4gstaM5dIlFbmDmTSuDw0e5+c9V49Fg4Q
 GUnYQNnpidLj4HcvN24l3IKwPXpyZWsVAc/k=
X-Google-Smtp-Source: AGHT+IE+thN94Yy6LIAOFS5z61uygRKGDXJDZUU1K29ur41vUcIzqFfEkLz/qNurcC68FglajWuUkA==
X-Received: by 2002:a05:6a00:2d23:b0:76b:d746:733a with SMTP id
 d2e1a72fcca58-76bd7467508mr3355948b3a.21.1753998590121; 
 Thu, 31 Jul 2025 14:49:50 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfd1a42sm2475404b3a.97.2025.07.31.14.49.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:49:49 -0700 (PDT)
Message-ID: <93d10215-ce67-4659-9867-e16cadbaf2f6@linaro.org>
Date: Thu, 31 Jul 2025 14:49:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 70/82] target/arm: Enable FEAT_GCS with -cpu max
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-71-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-71-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/cpu64.c        | 1 +
>   docs/system/arm/emulation.rst | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


