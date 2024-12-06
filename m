Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64981E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 15:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJad7-0000yt-E5; Fri, 06 Dec 2024 10:52:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJacv-0000y3-GE
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:52:21 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJact-0005BM-5f
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:52:21 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5d3d74363cbso260367a12.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 07:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733500337; x=1734105137; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Zz7FLpt0j08lcOYcHYv1ZI1YtjEZIrrGwQIAc8ph0D4=;
 b=sxkc6WeH/77dp679H8/mCzmBKkXAkT6BgPbcL/vUFWPjnVnPYM6FY1tx2KEwlrYLRc
 T8OAQL5SohrO//bPdd07S123yVxCgogtSokvGce2XO10296SZLaJSLECag6JvaldVLFC
 I4TuQPCK9i65F/axUCsq4VqOct0eKiy/cjI1p2ZOEgE6WF/zdF6luPoOpzDCDVHk62W0
 jVLktGN5LK4gQiwqvJrD9o66Sq/NaUCFXQq1QfK7/UmGOlBnAES9CtELq+glvVepqnpV
 KWa3T9loPyL8Bhn5AbtzqRyU7LbvHKiyyGVLH9QTMy3vxfYPeQR0cRiA47O6Fk13fP8J
 jUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733500337; x=1734105137;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zz7FLpt0j08lcOYcHYv1ZI1YtjEZIrrGwQIAc8ph0D4=;
 b=Vc2vpZZvCfCZPl3jW7WHAR+byV6X+VAv5YxQIhf6TKbi8xwgRA6cHYST9ZKexeE+Dn
 vjUN8/7BH105Lo9yFTbqGVUuvLWXAt8E9jjTKxR7bCEHjBmFWOqs9HBBN56F63+ZcFwE
 r0ef8aL/ng1DjqAdm2IBl4hQmAqrdujtvN5IrQ2Tys2G5qo88UNSFVrdB+FxSjpgHaQG
 UXq8wFZpf7sm15iXeZbdkl7Ng+5SrOg6ShwQCQPq7jp0uZf/LN3qK7jfp7GY6qwJnmTC
 qzQBFQnypYCtTLfHMcZHvUeVmyvN/wwew4kTO/Wh6gTd8HtQ1hCDyLdOaRoA6ehcofON
 2SxA==
X-Gm-Message-State: AOJu0YyvED67+4DM2KTNlM6IOVXHWdssIwCC8KIk6bRPDYVMNu9MI4Go
 Hyb+QRrZ52Dyc67IAVmX/38BnffpChv4JxnKBbszrVKyL6U2HOA+eRB6w0y1zJsVTkKZZsaTGgc
 hT0kL+Zy7zIoOXGreS3p0T+zTcMubKjywyIlv6DLY617gJCaz
X-Gm-Gg: ASbGncsrcpTNdH9okFq3KSVHfqgUobIE5ZGmxeotnm7vZICEJ/XT7b9p6k8drMLKA3r
 MKGTfIYbEKDGDe20aBvCfqrra+UljdPoz
X-Google-Smtp-Source: AGHT+IF9iOHsiTuoG2Ozd4II0C9yobAL7795HlSTBevRUKzrspw8IaJjO4nlSRs8ay7YFLxPdg9L4J8oXl7R/hFpTJQ=
X-Received: by 2002:a05:6402:2742:b0:5d2:723c:810f with SMTP id
 4fb4d7f45d1cf-5d3be783193mr4440217a12.30.1733500337087; Fri, 06 Dec 2024
 07:52:17 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-52-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-52-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2024 15:52:06 +0000
Message-ID: <CAFEAcA-h3wbZChEZ=EuEA7ScM-EF3CQnmkx5fODuc6y=7W_eqA@mail.gmail.com>
Subject: Re: [PATCH 51/67] target/arm: Convert SHLL to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Sun, 1 Dec 2024 at 15:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 75 +++++++++++++++++-----------------
>  target/arm/tcg/a64.decode      |  2 +
>  2 files changed, 40 insertions(+), 37 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

