Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF60606E86E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZaE9XsTl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU2Wh-0001jY-A7; Thu, 19 Nov 2026 08:50:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xU2Wb-0001j8-QW
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 08:50:05 -0500
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xU2WZ-0005ry-LF
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 08:50:05 -0500
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-67da7d18f2fso1167690d50.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 05:50:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795096202; cv=none;
 d=google.com; s=arc-20260327;
 b=QwjXL9c/MfSfAkl6hAQ+rpWheA0ufR4Rih9sI5D8D2NZ9Wf+NrHE2F6m4ydEL6SGu+
 5RHu9RQFadfNB5nq9AdKa51WUMOAugROJhY7MPAy/j2cNAa+5vdxI5jct55POEpLXt57
 enz5JrRTHEJ0pL5F8cXqxnIFpvfYoYMRhq8egKL1itgHFWcJVl9xxLTj1cDNHakC+4og
 wjmmTajrzECJO1Z7Ey3gd4Tf2TU26JF6NxpWOpIXSeatOGxlF3NUgTPCO2iKfFnGIQBW
 hhfh6VRFcxtC7iVuLr7B8fgmQdCfo61jg8xh6zVYPJxE6tXvUDm2XB3fmcbhDM4T6fjj
 LbBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Nta8dsSXguqHYph67QA9MDb9jQVd5q47MMBE1TsgWis=;
 fh=B22JtR9ZUsXUrdiOg5Iw9LSBCcKra7oUC9BuSyZP/90=;
 b=Isp/JETWHgn43JimtxbCETpw1dXUhcVaVK4wFH4a+CE4Eb2mQg71f2v/roHDf4nRrn
 Xj4m84exfKMexLkNyMXhGELDvf8+pzhw8gRSo35IUgaPH1mt8qc/PpAZ/xlae2j+HYL6
 xb5gSngpkwAOyS4cVWzCVM4ouhd+UVZZ58/QlAZOTcY1x5yzBkkmw5V3GOhkezrIVG6m
 lBDYLf6bpY84coOOM/5BYAzfthKu+60+DncPfc06wikw4jeEIWILTCpe/pdugw3BuOGa
 hxUYHyMiRSkGzSRd31r17iBx2bSavh8YNudXefkVRI4P6dnLd6QFL2L9AHl3ZW32V5xY
 NnkQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795096202; x=1795701002; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Nta8dsSXguqHYph67QA9MDb9jQVd5q47MMBE1TsgWis=;
 b=ZaE9XsTl+rO7v6eNkmbJecEJYc03gplqvO64Z5dCT/IB6fPyTezMVT6qcWXpdMGnsD
 3fd6unUi7HDiLB3oFdtGzwuNvwrN8/95bxCheHvHPelpP4nxzMLXi33z6kNUy0LK1ViR
 XsTHk8JWRLv2wz3wTRxgWfN1ay9X5ellw/CLjcCn0a6v0H9gwP4y+5XANOEJUBVEciAc
 gM1Q9Z/ircnXf4M1eXgB/ptco7J84LhH7SsqcXXWmcIWSv7J0l9dSIjuHS0AadhN94KF
 52UPimJuROepZs0kOBTBYeZDLhXPerHIVxKq/7FMLLJImEujW0d1KIp/306DEtMmrJ6g
 Hcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795096202; x=1795701002;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Nta8dsSXguqHYph67QA9MDb9jQVd5q47MMBE1TsgWis=;
 b=qVTaCRKTNlEGdP1V1+HC9AAGNPgmL8Mh3AZ87Y8ZSDI8PQpMqttfHMuxzDd1hIqrtZ
 2/vL4v85Hm76a3J7p7857C4LHGYZG/Jcpu5b7osVLz/goFuTmiTlz07cVnbxh5G78Bgw
 wgHAInBVDMb1LcntJOD1DAIMcBjrouS3KmTImpyphP+u84twN9832P9mo00lEf5KJWDi
 Pi3CJiBQA5ByyaKgx9r4vYVZ29D0j9Suj+uHiXRVaO1BTnKF/SX1fSpQ13PqP4Xu9Thu
 uFitIrzSc/j/KqE0Ey1hwwYwkcpPyvNJ1YVR5xSn/aOPbeh7+KsnyO0ahFvS2Kj6UZ7h
 H30g==
X-Gm-Message-State: APuU4Z8GDa2h+sWGpYJRoVJYgWX8o0s9OcpPMMIxTnQwgt3JHCYeHU0J
 rl+05ZxXrlCmFFgryQIJQX746m++1jmo5KHPUsn6rUcxg4CjrUp/NhqGIk6/voQVOFvt0O7w6Iy
 J2Ml9sDa+rFmihBPwbho0r3xevjFdpyW95lfAr0ggBQ==
X-Gm-Gg: AZFdTZd93CmgQdW50ZfCFd6YcfYFUwS2m3yeRPXztCGJScWu5z+gKYoVeGWIqLxs+7t
 zuC0UY0h9nZla/cPejr/d3hJO3wmEi75IRpFHebHeB8vAB9mz4NTOfnlQL/rCo9BQGFW9LW70Kb
 E39SktfDDex5QOYs/m9S8jwQyd4s79kFH2ONLobWDzPVK8AejNDhbFrJZtZrTItxIs87sbYomDa
 qWxSrKJydh0zU5hL77ER2DMjCxCQJbZAUA6NxNARug2VuylLvB7dwW95rN1LOxZbdvYg2ZqRdre
 ZzMQf58UxgUMv/DhXhpJlCVc5E+EA81wyLE64wkfvJqws1qE3gccBLD8ekmRyqP5VX5r+tk4IvS
 snTFkiGtvogmTeToP+unmIH8vhhfvBsmpsmm1qVQ489aYXRK8dkie9PRznsGG4nxePL7miRkNyz
 ghQfZY8uW2lHL5hW0pEMxp
X-Received: by 2002:a05:690e:4009:b0:67d:c045:d0bb with SMTP id
 956f58d0204a3-67dec2bb682mr469603d50.5.1795096201719; Thu, 19 Nov 2026
 05:50:01 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119130738.269817-1-pbonzini@redhat.com>
In-Reply-To: <20261119130738.269817-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Nov 2026 13:49:50 +0000
X-Gm-Features: AclHuK9F3vGXo6K7LSh0yRnKo5fecY1LzcmTzIwETFXnXV7aqNZSKOt8ZT_lfuk
Message-ID: <CAFEAcA-C2Zny3--QjgDafGzBzQCdDMK5sh0cH5=WXVKUFk36_g@mail.gmail.com>
Subject: Re: [PATCH] tests/tcg/i386: compile test-i386-blendv.c with -msse4.1
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 19 Nov 2026 at 13:07, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Otherwise, the test case fails to build for a 32-bit target.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/tcg/i386/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/tcg/i386/meson.build b/tests/tcg/i386/meson.build
> index d2ba8410413..02ac2bbd6cd 100644
> --- a/tests/tcg/i386/meson.build
> +++ b/tests/tcg/i386/meson.build
> @@ -10,7 +10,7 @@ tests += {
>    },
>    'test-aes.c': {'cflags': ['-O1', '-msse2', '-maes']},
>    'test-i386-adcox.c': {'cflags': ['-O2']},
> -  'test-i386-blendv.c': {},
> +  'test-i386-blendv.c': {'cflags': ['-msse4.1']},
>    'test-i386-bmi2.c': {'cflags': ['-O2', '-fwrapv']},
>    'test-i386-f2xm1.c': {},
>    'test-i386-fbstp.c': {},
> --

Fixes: 0f9a4145bf55 ("target/i386/tcg: reject VEX encodings of
PBLENDVB, BLENDVPS and BLENDVPD")

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

