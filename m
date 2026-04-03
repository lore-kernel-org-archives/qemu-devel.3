Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0435E88D63
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 21:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8lww-0006qm-Ot; Fri, 03 Apr 2026 17:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8lwu-0006j0-Dw
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 17:21:04 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8lws-0003wr-Ty
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 17:21:04 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2b23fcf90b2so21205125ad.3
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 14:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775251261; x=1775856061; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FKQOiu8uzFuxHT2NoyVPUR27Zi5sXrhv/B5Geiv3d5M=;
 b=war1I2ZFEuR7Yz+z7XWHBGko+g+y6dFy2JXTgg0AGakKZGaqC6jjCKuWDJEJy9hj48
 RgUyRtgnnrRyM2DSaVKEplC3s6dU6lpwnQ0DI4O1YPfC8dewYSFVPbiUaPPgLrFd4SIL
 V3fBvII3JiJXgemjzyUdPKejw96QyvtXRg35sPPXJ/DKwbrojaA+Il2R9h0p9qJSqmzg
 SFaV2EEAhOX/01m0UmgEhbm38Rj8OX1m5pekP0YRCSpgMMHEPDbz1Z3nbHp66HFGHSug
 OO139NKWC/Ugc7Ruo54udxxCtUBlKCnNDKPTjJkdH3fH3vKW72cvS2Qiv/DEL7pd3wLW
 SwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775251261; x=1775856061;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FKQOiu8uzFuxHT2NoyVPUR27Zi5sXrhv/B5Geiv3d5M=;
 b=aB2qDxQwn2pPzy+tb+nAwqwBb1HBljrC5yrS3lfH0Z8jhMsBJNN4pX9JLwfGQ+edqz
 uiM6Sf1feT323163VxSPE4eO7Yp9M5W2S8bZT3UyN6cq+jBYzgeKXRWuqHga4G+AorY+
 xhw24efrp6rEJRx8XausGcsuSgLKusUJRuoeO6Wa3uRrd4/Y2Y293eBqtgfqs3rcx3Vu
 QMbQvsMztmcJLrh7D5zGw+pRG7tABaDK8TYok591BbiIk5TJDerRpCG7wky/klWuKL7Q
 OIIlToffcYZnm+VBdp55VAsX6MIKJ7Zn0nLWHK8mzXU8owIqCXkpah7wKiiRyMmOHxrL
 UD1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZYVLSyZvWHfobZABbmgVE4VzyTw1O6gtswgRLr+eTm7MYJKAxeoj9oT6QCQNDfBCDgi7JDYQYTy3/@nongnu.org
X-Gm-Message-State: AOJu0Yy69S2QbSTEoX5YjvZx1ggCxj7O47nsZokZPxZVKfqDevO5wCzL
 RDS3hxerJU0XfxHgryVRQAmLjqdKAzChDclC8roCZThZf/oGTtZna2gCy9+OA5lM1oihYIF8wV5
 VLkxaHtw=
X-Gm-Gg: AeBDieumQz4Fdg/qQ/v2bQEwncs7uRqvlmWwFh1Rt0VwfSX/LrSUDyrO7+XnD2owouK
 LppznvMEuVhe7iXf/oWDF132+wFPlzalzxxsWTgc5eg8cWSVABF2XXkoJiIvo1UOJqIICMIdbjj
 Gnsujo/sLdEvcuiVolvDp/NegeR4DcnVqiOxwWNXQ07k30msHZxZ4ok4+osVJobQRa+8OcMrkhR
 fmxdInpzLuk86WDmSbv2rwNULNveAcZIYEuAC+yvXr/2vAuOGQGmXDk4aIOzmXt7FlGROJWGWyM
 wdYm1jF1LFVr2mvN81tl9e60r6A6pvnOeY90N2YtHlsWpyyZNohmYxdZspD7gg2R4h4W2wgdTLg
 jWsxRL+vQFtlMaQZGW9uoDmfW+rhWyb7b8QSKhe2uC+K0TX8wjbG+iQAxXskpAbplMcT1iG+l5L
 G24kIK2Xk997Kadvrbuiqt9yU2FXn3JuFHxDGSWqarlGzlIHv/Lw7JojvXPYYWph8KbF0=
X-Received: by 2002:a17:903:1a28:b0:2b0:c90f:44b2 with SMTP id
 d9443c01a7336-2b28173548amr46198715ad.12.1775251261115; 
 Fri, 03 Apr 2026 14:21:01 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2747530e4sm68066785ad.18.2026.04.03.14.20.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2026 14:21:00 -0700 (PDT)
Message-ID: <0f441ddb-d2b2-4095-b0ce-c35090133366@linaro.org>
Date: Sat, 4 Apr 2026 07:20:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/12] target/arm/tcg/gengvec.c: make compilation unit
 common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 jim.macarthur@linaro.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260401192057.1182724-1-pierrick.bouvier@linaro.org>
 <20260401192057.1182724-11-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260401192057.1182724-11-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 4/2/26 05:20, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/meson.build | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
> index 1fa26670587..0740de92c1a 100644
> --- a/target/arm/tcg/meson.build
> +++ b/target/arm/tcg/meson.build
> @@ -33,7 +33,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_false: files('stubs32.c'))
>   
>   arm_ss.add(files(
>     'cpu32.c',
> -  'gengvec.c',
>     'translate.c',
>     'm_helper.c',
>     'mve_helper.c',
> @@ -72,6 +71,7 @@ arm_common_system_ss.add(
>     'cpregs-at.c',
>     'debug.c',
>     'hflags.c',
> +  'gengvec.c',
>     'neon_helper.c',
>     'op_helper.c',
>     'psci.c',
> @@ -91,6 +91,7 @@ arm_user_ss.add(
>     vfp_d,
>     files(
>     'debug.c',
> +  'gengvec.c',
>     'hflags.c',
>     'neon_helper.c',
>     'op_helper.c',

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

With slightly more work, this one could really be compiled once, via arm_common_ss. We'd 
need to split out the function declarations from translate.h though, because there are 
other CONFIG_USER_ONLY uses in there.


r~

