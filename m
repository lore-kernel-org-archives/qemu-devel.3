Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1711091923
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 21:18:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3KlN-0004wk-QQ; Thu, 19 Mar 2026 17:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w3KlM-0004wM-5g
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 17:18:40 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w3KlK-0004PA-Kn
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 17:18:39 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-35b95a7444bso5668a91.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 14:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773955116; x=1774559916; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=APKhRkVwaGmF4WhMHEWeVZjWCJxbjwoVdAuO555U5JU=;
 b=VoSg6E8rBVIh0TublD+h86V/pSt7XV3phSDiKJGr+z2LJJ518+7ELGcPdrlg92LKk2
 N4sBrgcq4XTSyE5XvWaadiCU3JJxp82DG34d2ET/lYhAlWVM81/5Tx8sXJIoHUECQLu5
 axLs/Fsgcow+muUYLFwxMyrZb41+r7fBJJjvuFslo2R1pK2EZJ5sjXzDgGm/qI9xnLbj
 JrQM3RExfR9gPVRy+12iJaUpoIgSkdexsow5iDcIFZBcR7EhvfrW2k8R3qrmpNkYt/ks
 a7QastSWxdIhPZKcGnBJiYzqPkT37C2w87jAabiRzyLG8PqySqflOUKivgS4rDDCc/sJ
 rR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773955116; x=1774559916;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=APKhRkVwaGmF4WhMHEWeVZjWCJxbjwoVdAuO555U5JU=;
 b=gMmUmsmGE488+Zq9QGE6RO7afQIMyMwXeiKiVGAAaGkaB40kDlRH8B1f2Qepn64Ecg
 evSx3fhXovAAt7a0m5h4X/HLE58uDouSAUY+6i5jJPyGcEZCVKChQBYG3dUbeBleYtcq
 33zYTGsp2Yj8ZrMHI04xjYhjvxH7nXyNYocGukD8mVFxmFGrAVuk+X3uCtp4WvrfXftk
 mAQOFbel4wOyf0HvNHii397rAjoHuJ0f2DRgeqpHBR7QP+YuE5kmTa5aUtDoZ9dmJWq+
 m5inKccRS2/R3vGQRmRUerrkfMTAmhw2QaZzN0GwaMBE4A4gPLrvNQT8KXiiZUiUaoQQ
 pmKg==
X-Gm-Message-State: AOJu0YwMu+L0WQujHwaC7JCnU5cmVudsstRo3b48C6NUjqmzQyd+rdzr
 WSN8l1DYNHpxiDmDCi0bfT0+HtOKKLaGZ64QgFP0nVYDItZLGKIAUswRh4iUZodPyYVb0HP/LcF
 9Ds1kFF0=
X-Gm-Gg: ATEYQzw/FnKPn51lb7I5iUjFEVSLPMTbTTXzzWXkfRqX7F+ufew5UfS8yE7StEom1FY
 OCnn1l17mU44Z0NAOhF/Cz+oMw1mPl4zN/gOdNO1wWXhr8nT3p4FKa9+MKjxVi2sfBMJe2WyCNP
 VvBQQjo5tSSk+iF2I2EuVv9kq37jTIlRoMC/fJxd/aVfD3eZ91o0XdSNYYbnoWWhO6Gf1rJBmkX
 YCAH7StUIgCrI5fmc5FQLvsrPSKgYEFeX/p1/sUQG6236sFU0/SR/u4+2xEVZSxBUO0yTI+iwr6
 f0Q4vuaz38unKEtdJlQlO7xvc5YiToh78Cag3eb21RtdnNVmCl6KKrgTXYNYGmrPn9mJGLFw6Zf
 L1cjwIQdDh53eRGvMy5DUnMqeJIP4NQbh6RhQuetY3/M5KE7qtojdHdXV3dRQXBrzJzZS2f5xu7
 uebgSkjAqNoHhDURR2TCjn/sEjxiNqbF+rObw=
X-Received: by 2002:a17:90b:28c3:b0:35b:952c:43bd with SMTP id
 98e67ed59e1d1-35bd2b9e0c6mr470103a91.2.1773955116134; 
 Thu, 19 Mar 2026 14:18:36 -0700 (PDT)
Received: from [10.5.0.209] ([114.23.167.13]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bd26420cdsm120051a91.2.2026.03.19.14.18.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 14:18:35 -0700 (PDT)
Message-ID: <7ed1952d-2707-4f11-9322-c5a2e59b77b8@linaro.org>
Date: Fri, 20 Mar 2026 10:18:30 +1300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configure: Remove unused variable default_cflags
To: qemu-devel@nongnu.org
References: <20260317120215.2075164-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260317120215.2075164-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 3/18/26 01:02, Peter Maydell wrote:
> configure has a variable default_cflags, which was originally added
> in commit bafe78ad3bc4c ("contrib/plugins: use an independent
> makefile") as part of it setting up the build environment for
> contrib/plugins, which at the time used make.  However, we now build
> the plugins with meson, and in commit 55c84a72aba4 ("contrib/plugins:
> remove Makefile for contrib/plugins") we dropped the logic from
> configure that does that makefile setup, leaving default_cflags
> as an unused variable.
> 
> shellcheck helpfully reports this:
>        default_cflags='-O0 -g'
>        ^------------^ SC2034 (warning): default_cflags appears unused. Verify use (or export if used externally).
> 
> Remove the unused variable.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   configure | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/configure b/configure
> index cd1dadd8bb..42c45fe47a 100755
> --- a/configure
> +++ b/configure
> @@ -248,7 +248,6 @@ for opt do
>     esac
>   done
>   
> -default_cflags='-O2 -g'
>   git_submodules_action="update"
>   docs="auto"
>   EXESUF=""
> @@ -707,7 +706,6 @@ for opt do
>         meson_option_parse --enable-debug-graph-lock ""
>         meson_option_parse --enable-debug-mutex ""
>         meson_option_add -Doptimization=0
> -      default_cflags='-O0 -g'
>     ;;
>     --disable-tcg) tcg="disabled"
>     ;;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

