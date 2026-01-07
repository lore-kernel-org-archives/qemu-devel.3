Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23287CF6BE3
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 02:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdJTz-0004u2-Q3; Tue, 06 Jan 2026 21:41:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdJTx-0004oX-SY
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 21:41:09 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdJTv-0006y7-6a
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 21:41:09 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7b7828bf7bcso1492832b3a.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 18:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767753664; x=1768358464; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o8ZRhhjUXd9/cStkn0gOAkgQVqFH35TSbzz/k2yWWXE=;
 b=uBONqQ2mkNFSz8hCJUjFJWPELwt64ewx1tV7Vy0bD4/zW1LpWwv/FwG1E41d9QepSw
 INach7axZlaf4r2b++HJ1Fc09GHUKP5+sK/QILx4xUyDVUrXLeLFISZhDk4V6U7DpXdc
 d8yKUWVt4aSAh6as2vVOCUqcNpBRGx6FFAmh08IXhwFWvhGJA4fbfo17b2JdHsePvpfr
 qfFS3DERUP5cr4glxWWjO+RLa69DDLIuz8InergyILLPT0n0hTjjtrdxH/TDOJT4+M+p
 BHBUhRu81Jm1CyyVTZRmsWTli4kwO3GqDTJE8lMKtet7QUo9PxYO8ds4TYr2blMVU+uV
 lNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767753664; x=1768358464;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o8ZRhhjUXd9/cStkn0gOAkgQVqFH35TSbzz/k2yWWXE=;
 b=in5olb7+lypS970hjNhW51VRO6Ra0G6XWKcKVrVCjypqbLwS2OfGuGQOKhytEQXa88
 EIqe0SLuiKaHZ5fCfxAdhgBmuOWBkKVTgiudtuJe2T4RXk9406Oj6v4+cNVRZSp7Vu2B
 gygnkHslFgVerDzqFuj20r5aaL5KxCq0hIzYoCQUIkJYwDyTIICgAuul3IShgyMR75qY
 JXLMMvzzDYmiA3TbPEZS9DsDL0koHYnEpwTG0akuW6RetCblBUxWeHLP5kKC+kohavFh
 mKwhsuPKc64GUeTbzjQzUYfeqTcDTEBJNUhpHg1EOqCcb/PQST4oeWgorAC1kqyT4k5n
 HtdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgn09Pu96TvsZaXsOVjPxWFLtNkk/KWT5iL/NGnhvueLWfONfPdqp+vI7t/LptGsWlRJp9YPE4xbqF@nongnu.org
X-Gm-Message-State: AOJu0Yxc5Ft21PIiNtn/PHUKRLbCr+E5G95f7WVQ7zxZns4W0Ju6CBJr
 1AcIjFdNBigd4hQBi11I1Q1zqsdtQKvbquvSaTatncxFXpNThYU3b+T4fKAFtKE2dSI=
X-Gm-Gg: AY/fxX4r1O1wXN+RdxyiOVV412kd2Ah3nFEzzPatkLZjSFy/iwlOblsMpWHeug8mtCy
 XD3NVbygSF953HEgt2VTXgaf6oZFgy5hO/9KtTHFnNt8t6pRzgwtaINBFO0LWij5XIuWeWvnF5N
 wh3A11vMosqUnJ94cOFWER6Ewj3TGLJa9ZATcKmYpQde08zG52iz8IxZoMAPinYtaBO3QafKyvs
 0FP+QQJBGlCbO0BnYl9jw4pB/HRVVkJoWKA9gdlsbx43Nw3OC1LFTj+8bvTSyEscmkdCQ13m5yA
 MFI8QsjLBNDxbzwJrv3iNTld/E8t7t3EPKuLq8u41n5kEulps7muEJr7jURiv8oMJHt9eMABlX0
 jqzPX1nGCu0NYEvZmAcGNQUIsiVApd5RmQThiddUO9m7irk4minCSBJ8PKbRsiFpohxiHu9J3Fp
 dRDABS1B2os9eXKTOpeJufdv34WSIZa085+V1PgJXZviVK4sZcvBqAkkLO1iRPJsUDgg4=
X-Google-Smtp-Source: AGHT+IEcM9jQYR7TKFFAKpqe4LlHONLUlRa+W38XePlhA/p7xVaIcnSkOhhRgTr31IQKTH1KIE70qQ==
X-Received: by 2002:a05:6a00:369b:b0:7ab:4106:8508 with SMTP id
 d2e1a72fcca58-81b7de5ded2mr937893b3a.28.1767753664500; 
 Tue, 06 Jan 2026 18:41:04 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819c5edc5e8sm3281492b3a.65.2026.01.06.18.41.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jan 2026 18:41:04 -0800 (PST)
Message-ID: <22adeb9b-98c5-4704-9a8d-e8ae363e4036@linaro.org>
Date: Tue, 6 Jan 2026 18:41:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] meson: Allow system binaries to not have
 target-specific units
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260106235333.22752-1-philmd@linaro.org>
 <20260106235333.22752-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <20260106235333.22752-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 1/6/26 3:53 PM, Philippe Mathieu-Daudé wrote:
> As we are moving toward a single binary, targets might end
> without any target-specific objects (all objects being in
> the 'common' source set). Allow this by checking the
> target_system_arch[] dictionary contains the target key
> before using it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   meson.build | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index db87358d62d..734c801cc77 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4275,9 +4275,11 @@ foreach target : target_dirs
>     endif
>     if target.endswith('-softmmu')
>       target_type='system'
> -    t = target_system_arch[target_base_arch].apply(config_target, strict: false)
> -    arch_srcs += t.sources()
> -    arch_deps += t.dependencies()
> +    if target_base_arch in target_system_arch
> +      t = target_system_arch[target_base_arch].apply(config_target, strict: false)
> +      arch_srcs += t.sources()
> +      arch_deps += t.dependencies()
> +    endif
>   
>       hw_dir = target_name == 'sparc64' ? 'sparc64' : target_base_arch
>       if hw_arch.has_key(hw_dir)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


