Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C722DC27C43
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 14:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCh3s-00043C-8Y; Thu, 30 May 2024 10:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCh3q-00042U-Pi
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:47:22 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCh3n-0000cn-VK
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:47:22 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a66cbe67ce7so17893466b.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 07:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717080438; x=1717685238; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uKtEcIZbgbRMJ2tj3UgRE99DmXA0Hpyba50+nYLPawQ=;
 b=nSufcHPmtPRfvnHc5M3uCDksWQoi7bS0H2xlZZA29WbdlIou1YmzIrlfegljysK+/T
 bEYu49HgySyXsEu+t/n6Viwq1nhYL/ueI9wYm+BOu74mjHcaoMiKZvBJ3CFuVL+m4b5X
 jVRX0Yi13+UexHOG+LsAa8+YOmVLbKoDg7TCD01ypeNppXzVJTyKPX42DegsEOM0bVP2
 3Su/O3Ud0NHkmM/lmzgqUL+/hCS0eyD42pQu603YJN01WGXlJkhL89VB0bpm6rT64k6Q
 qJ8+6tPv6YbC4t/b1FgWopuHFdLZz8FlfmBUd5njfcQqbvoh1N/8497oEiRIXIbE1iaI
 oHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717080438; x=1717685238;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uKtEcIZbgbRMJ2tj3UgRE99DmXA0Hpyba50+nYLPawQ=;
 b=f/zZDvy+rey+FC7SW8ezrhiu1BFF2WuC3vlDTUu6odLcuSay1Di4OG4ukKORIpY7pD
 E1ajReWBiDzehayIba2PZO7KbJwRakSXrsGAiX/17BTiOhHzzUkfn1CK4SHR6J4P8ItV
 FYVhzo8it4hKfuMowbeofMSu3Rw34ybP5D0PMGPwwLnMWS2rnNIUKYJDoUyut6bshhB6
 vpYkDbCcarQzd1ettufBjJL086QtMtAYEVjC+r1zndrXmi4OXNNkBPQWD/3Lyg8gvO1L
 w02l++0T/V5nb7vUgaOH5dno651jUr1NmvgBXyw7O8A6K0Ex+l/w2KQEKCN+PWhVhGCX
 jRPw==
X-Gm-Message-State: AOJu0Yz1sNEgmbsFChH4B3ZyEp12GPIHqqPMNVQVZQTPcdeyl+U9TNeS
 3uKL2UHSGFlgMV5BOgdr2bjSb2guQ909rTLDYj4SPHDC29A0aNDGq/gLNEuNZMDlbwvpa8YTzJD
 voq2nxQ/NxvOYpVTPoLpP+TqoAhZ0WO9L/3RnUA==
X-Google-Smtp-Source: AGHT+IFC3zpZHGWpT7r5ozuTiS3dyG1474c4+zUXIoDvOynX1uUoznx7cz088tSeyICv9ET5beMcBhnP9H791CbYCZ0=
X-Received: by 2002:a50:8e57:0:b0:579:f196:487f with SMTP id
 4fb4d7f45d1cf-57a1793b35amr2083303a12.31.1717080437736; Thu, 30 May 2024
 07:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240526204551.553282-1-richard.henderson@linaro.org>
In-Reply-To: <20240526204551.553282-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 15:47:04 +0100
Message-ID: <CAFEAcA9i12yZdo3rM2y0+KywJ2EGbcr5ioiygPH83COHa93dnw@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Disable SVE extensions when SVE is disabled
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Sun, 26 May 2024 at 21:46, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2304
> Reported-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Applied to target-arm.next, thanks.

(Looks like we already got this right for SME:
arm_cpu_sme_finalize() clears ID_AA64SMFR0_EL1 if
SME is disabled.)

-- PMM

