Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54186CEF17C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 14:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syAxg-0006ci-7M; Tue, 08 Oct 2024 10:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syAxe-0006c7-Uy
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:13:14 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syAxa-00078v-37
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:13:14 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2facf48166bso64754021fa.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 07:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728396788; x=1729001588; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IilAgLFf9D3WPiImik68r3HP0LrP4VXSn1RvllVJUL0=;
 b=U3XSiefpwWVPQgIo8D3tdg+TBkXCzzd6VnrXhvTMVTebd5gdaMbdbfMQwrQZKohzfL
 ugEJ3WGuU7vi7KYR1PkOF+1qJCvrvkj1AZcGjvyyk4EO/paj23rf6DXQcA7fi0D+58Us
 tz+B6hZfG4R7QWwaBvNVSxg4SokZgHQIci4h0cES2osgEE5KLQdMEZeN4sRFpz65L9iv
 ay09Wrv9XRWWAXJ6GbWoamJL3TtuClaYHDoAPeMUI4SfmxJ01ivTZQl2EUxNx9fTux/o
 ej4kXZ9ISP5tO/9/uRFa89LeYc9s9uzxwb2C722/ANfjugMJHBfrk2CTPwcpHlzFnqCl
 V+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728396788; x=1729001588;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IilAgLFf9D3WPiImik68r3HP0LrP4VXSn1RvllVJUL0=;
 b=OynvQmbvXtYM0rz243XHP+gEKEnxbvrmQWolUpokAnup63xnLQxSUvTtPw1iaDExuK
 cAdGrGD7sLnmLaCoiXGCuvxnVtx/CgKUrRU8R6hBSzbe01E4NFqK1NT+GYxniErhF4Vn
 rGIgny9ClDVI/fVrHTozZtH39OI+NyYr3dhI1x3gDwf1MshDz0AfKeQF2fs8nJXqDEp/
 UVp8YAIQNd9FyoNXGSzjbJgv6offUB1AzjVAuNLQmI2aDwlon6kScXwovQqS5pvJnups
 OgQI+7AheWZqJnuNMtoKQjFowvRC2/ME6RCWzhqfRgykpJz84cMcl5IjX/5TA2SkViYd
 ysrA==
X-Gm-Message-State: AOJu0YxOiiR3XLxlOTcAaWm9VZlEap4UZwMkz1e71NfHgemLsem9PuBV
 gYJ+XITCUfnjhD1U7Ts6zOKNciAP6Y8+OOyVyxk2wpgfC9FJSxhSRtkSN3uMqpoB+bDeFksJykm
 SpKh5MAF4gCiylFHC+oq8ZIdw5GKMeIEBh0keRwm+3vF/zD58
X-Google-Smtp-Source: AGHT+IHX8WDeU6G0DWTwtDykB80Fzl5sFUDON9fa7jmgPNRDLEDPb4CCr71S9cNPuXQATiVBxQVvICmfLTtgmJ0ORaM=
X-Received: by 2002:a05:651c:a0b:b0:2fa:c6b3:bf1c with SMTP id
 38308e7fff4ca-2faf3c01f43mr79822331fa.8.1728396788120; Tue, 08 Oct 2024
 07:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <20241005200600.493604-1-richard.henderson@linaro.org>
 <20241005200600.493604-8-richard.henderson@linaro.org>
In-Reply-To: <20241005200600.493604-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Oct 2024 15:12:56 +0100
Message-ID: <CAFEAcA_HQvZf0GT64vy3_KgXrGK2hq+Tu21y8w-WLbHsWGiBGw@mail.gmail.com>
Subject: Re: [PATCH v2 07/21] accel/tcg: Use the tlb_fill_align hook
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@kernel.org, alex.bennee@linaro.org, 
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, 5 Oct 2024 at 21:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> When we have a tlb miss, defer the alignment check to
> the new tlb_fill_align hook.  Move the existing alignment
> check so that we only perform it with a tlb hit.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

