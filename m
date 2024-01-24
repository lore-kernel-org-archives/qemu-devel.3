Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F348CC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 03:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSTiH-00068A-Jp; Tue, 23 Jan 2024 22:14:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSTiG-00067m-BL
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 22:14:04 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSTiE-0001ud-Nl
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 22:14:04 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6dd7c5437b0so1142136b3a.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 19:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706066041; x=1706670841; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KSJjUSWLo81XVckrzD+uh54rAlTKlaUo3FnkeS2gPic=;
 b=ydCpR+zRMG3RAu7I9C6Zo3F1PrIssFLn95JkyBWWgy1/SFzv6J9BSVoNkvzCY0d/9J
 qct0q+eqKrRYSSF31BxF6eA1OF4YifHHDx8cJSRmQT+3/zCsjXFtNT7IKXpiDL0X3v9a
 EFfRXC0ylvxHhYY5+uQbbZ/J08DkNEEq06Bw9MfXlNeHyazizD0rokZlgS55L3JnQm8p
 LxdGNPT9ou+JUifeZI3YfDW+kt7+ATRy+zmIiSbSWORFT1R8SKo24jOwRTwQEogJximM
 lxMC0kJTdW+/SffYF5qxNPZZ0KlCiY5kiztqHpdl/8LygC50byI0izGvBuopHuAYvpRj
 sssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706066041; x=1706670841;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KSJjUSWLo81XVckrzD+uh54rAlTKlaUo3FnkeS2gPic=;
 b=SX9J8fqDFFamM1uF9sRkz24+gFaVDgOBTs4hC/ebRR27nUHYo2lvUZ7bU1hjMOakrL
 RvsMrb/f+BSgA4Axw+hl+MoZXJE/N6HFe2qjS1vFgk61Hitt+RLTnQ/fS5s6Vt8TQW20
 gZspG5IBOFO5NVBIExvXv7y/a9SzhZKMvLh5eUalg7+YJvPG4ayHQn0PJ1hdzhOaXozW
 1QW0pxSA3IpbFyWlui6WKwlo51rEWoSEWi66rrfsWxUVNuI94m2FwSmF8J2fGn31RK9X
 OcpYPK5FRhwKcJvz37zXEMaakDvk0IC75t6rqS2bOa6mjd+EElNPG78tPyi8PWHmafMD
 v26w==
X-Gm-Message-State: AOJu0Ywn5A0mZ3ASG6BdrOAIt8ZVcax5R5oVcvoS9ArC/vB0NXJecjEH
 tl+d5t+zyfGj8F0yV1aqxal4yMEfdhL44T3AywBBmnImMlBVsieqv3zrMLjgSARWbapr6IdbzWJ
 j
X-Google-Smtp-Source: AGHT+IEWT5ZfgZMF+ESzl4iAeqp5lgTb17AkJDtJ0AVkU1IPc6d3HxoAZPyRZGikc0W2KHfhZcKGEA==
X-Received: by 2002:a05:6a21:a58c:b0:19b:56d6:dd19 with SMTP id
 gd12-20020a056a21a58c00b0019b56d6dd19mr320666pzc.10.1706066040873; 
 Tue, 23 Jan 2024 19:14:00 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:dd1:291f:3c3c:2485?
 (2001-44b8-2176-c800-0dd1-291f-3c3c-2485.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:dd1:291f:3c3c:2485])
 by smtp.gmail.com with ESMTPSA id
 lc14-20020a056a004f4e00b006db00cb78a8sm12927500pfb.179.2024.01.23.19.13.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 19:14:00 -0800 (PST)
Message-ID: <d82b3fee-6fd6-469b-93de-84ae5cff238e@linaro.org>
Date: Wed, 24 Jan 2024 13:13:55 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 30/34] accel/tcg: Make tcg-all.c target indpendent
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-31-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-31-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 1/20/24 00:40, Anton Johansson wrote:
> Uses target_supports_mttcg() and target_long_bits() to turn ifdefs into
> runtime branches.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   accel/tcg/tcg-all.c | 25 +++++++++----------------
>   1 file changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index a40e0aee37..b8e920e3a8 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -28,7 +28,6 @@
>   #include "exec/replay-core.h"
>   #include "sysemu/cpu-timers.h"
>   #include "tcg/tcg.h"
> -#include "tcg/oversized-guest.h"
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
>   #include "qemu/accel.h"
> @@ -67,20 +66,13 @@ DECLARE_INSTANCE_CHECKER(TCGState, TCG_STATE,
>    * there is one remaining limitation to check:
>    *   - The guest can't be oversized (e.g. 64 bit guest on 32 bit host)
>    */
> -
>   static bool default_mttcg_enabled(void)
>   {
> -    if (icount_enabled() || TCG_OVERSIZED_GUEST) {
> +    const bool oversized_guest = target_long_bits() > TCG_TARGET_REG_BITS;
> +    if (icount_enabled() || oversized_guest) {
>           return false;
>       }
> -#ifdef TARGET_SUPPORTS_MTTCG
> -# ifndef TCG_GUEST_DEFAULT_MO
> -#  error "TARGET_SUPPORTS_MTTCG without TCG_GUEST_DEFAULT_MO"
> -# endif
> -    return true;
> -#else
> -    return false;
> -#endif
> +    return target_supports_mttcg();
>   }
>   
>   static void tcg_accel_instance_init(Object *obj)
> @@ -137,17 +129,18 @@ static char *tcg_get_thread(Object *obj, Error **errp)
>   static void tcg_set_thread(Object *obj, const char *value, Error **errp)
>   {
>       TCGState *s = TCG_STATE(obj);
> +    const bool oversized_guest = target_long_bits() > TCG_TARGET_REG_BITS;
>   
>       if (strcmp(value, "multi") == 0) {
> -        if (TCG_OVERSIZED_GUEST) {
> +        if (oversized_guest) {
>               error_setg(errp, "No MTTCG when guest word size > hosts");
>           } else if (icount_enabled()) {
>               error_setg(errp, "No MTTCG when icount is enabled");
>           } else {
> -#ifndef TARGET_SUPPORTS_MTTCG
> -            warn_report("Guest not yet converted to MTTCG - "
> -                        "you may get unexpected results");
> -#endif
> +            if (target_supports_mttcg()) {
> +                warn_report("Guest not yet converted to MTTCG - "
> +                            "you may get unexpected results");
> +            }
>               s->mttcg_enabled = true;
>           }
>       } else if (strcmp(value, "single") == 0) {


All of this happens at startup.  Are you sure you're going to have determined these values 
early enough for heterogeneous mode?  I guess for the moment you don't care, because 
they're all constants supplied by functions.

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

