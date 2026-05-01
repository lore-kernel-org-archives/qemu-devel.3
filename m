Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE542CD3424
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 10:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIkhB-0006pZ-9A; Fri, 01 May 2026 06:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIkh9-0006pA-PT
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:02:03 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIkh8-0002Uk-Am
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:02:03 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c76b994f7a8so709693a12.3
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 03:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777629721; x=1778234521; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8lM0TP6AUT9UIAUxiMJVpvJ7ZaKHZi5WZQybrrZRgTA=;
 b=UbGLp6Yjn1AKeDuNqhv0X+croxNYhXqzZjbm7uWQcdH09eu446QrolvQYYvAQoQuCp
 6Dt86XZBKdBL7LAUfGJhVUL5IWn7xsElfliWDY9Xwcl257NFqLO4UflkMi7C0wlK7vQr
 UxG1qhhiMNcnHlvg4+wRCdjIT74MWwrSHOcRHsdft8sHZ2LZ8UITJAjXZbR2YnahMkvi
 Nr0rqIxHAmgFYy72qUg0j9VuHq2dGVvSFoIKnz9+kcKg4nySwzFghqLeFDNOeW78YGM2
 dnIJSzrTHKj4g2s6L5hWe4GEBuAzmMUViTxUPK4ETfn5rzoV7j+fuKitV/x9SIxDAsg5
 mPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777629721; x=1778234521;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8lM0TP6AUT9UIAUxiMJVpvJ7ZaKHZi5WZQybrrZRgTA=;
 b=dwB8obHnWkGNp6rkUd48t3wlaEVzaOXKGmP4SSLM7dYIYRCeT5vfpLR4BE3ggOFZL/
 mXtBj9yQvHFAWQCwH5Xk7/dnogl/vVIE1iCH6RS198CfjM3bk8VTApPzqwGsdiU+uYeo
 +KPsDHjWaMhzQ08/MK7kPlG5OLpZqoXD130QeZgFQXMwOOSrbd3eMBTkCGE/RwiBljBg
 XWLI6IMduIAhQ7ibqC9iY4ALzpBR0axfFLvlazZjWeCIydVsissjvO/UWkI3o5Svl90+
 Jy9wMhNG5CaqaWKEKr7u03Wl5v8TEq5s+DnCEzFMZP7hbctwT282YNU3pBxRXIvHfJQ2
 1gnA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Oqe+v4LAf9Mi1gDtrdoB5U4CarkNK6xoHF/sMpgc2dxpIkcBOmeWsqISl8zU1Eg7ZP9z+N9nSjIZ4@nongnu.org
X-Gm-Message-State: AOJu0YzawHi+PiGDV/i9dohKUKUyiBTsWT7c3qAoQb9DCNEOweBIhCAA
 iugGByoedOzV64uSdhCpO1+PrurMlumMgqVdOiC/WArTmJV29vyI6PKaCF63tapRq5M=
X-Gm-Gg: AeBDieumLesMGdo1w+gx2HK7Fn+XoEg271b5pZsD+ecwwwoQwe6101x/sWdHfMh7J87
 A93Bgzup6AA1B9ZEiX2goa9MS2Q5mpgRIdJqiM+SVcLTZGCk/LIMrryBoCXJVf5ywA+LVkidbr0
 SA2fchbtDk7HiFsdtSi1OlyJ4Ig4t/Pg4em9IA/XGGAyqZMRT1skDqcJ8eZU7bxAMuqO/LFZtQM
 r5JHXygAV3BN5yl3lvFUJHGlkTYULZC4aETcrA3ig7L/IjJIvbIvOD9KpD2fAzKz0I0tN/+2P0o
 ZOuXZMY7fYxYo6cUmOtwot9sU86AKTETQJ9oXJA3i/Fxsl/v/6BVWCvGyLcDgEdvaVpX/Yeqjpd
 KiwfaM/nJGcdUv0Rh36BR+BnthnrfJGphZfpbJ3HovQ3FTYsLLS/+YfuLN8IJlIg+hdIdWslcC2
 g4moYQEiRRqB5BTAdZvVC77cnV21rFt0cYnsj6MGo3wjJXOuTl67FR41eJAyOnIM4=
X-Received: by 2002:a17:902:cec3:b0:2b2:57f3:8d07 with SMTP id
 d9443c01a7336-2b9a22f5926mr68990345ad.7.1777629720625; 
 Fri, 01 May 2026 03:02:00 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b9caad2459sm18477945ad.33.2026.05.01.03.01.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2026 03:02:00 -0700 (PDT)
Message-ID: <65dba7c9-790e-4c16-aa95-32d224bc9dab@linaro.org>
Date: Fri, 1 May 2026 20:01:56 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/25] monitor/hmp-cmds: Use cpu_translate_for_debug()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
 <20260430093810.2762539-24-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260430093810.2762539-24-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/30/26 19:38, Peter Maydell wrote:
> We want to remove the cpu_get_phys_addr_debug() function; update the
> HMP gva2gpa command implementation to use cpu_translate_for_debug()
> instead.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   monitor/hmp-cmds.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

