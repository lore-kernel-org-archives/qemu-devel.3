Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C7AC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhUu-0005JY-TI; Fri, 04 Jul 2025 10:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXhNE-0007EE-2D
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:26:46 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXhNB-0000JN-Ab
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:26:43 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-70e5d953c0bso10395157b3.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639199; x=1752243999; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zWElIbslX/NnREeHmv51db2w0SDJalpLfsWpjW4/9zc=;
 b=pgeAySqaa4ub/mu4k/6u9KQehU8Aan8S6zX9sNlztIkDJ/TrogUI7U7NT3hfksNkyI
 VlKtNFhHPUQa+6bL5r2PV5Uh10VCwPvEpwY6i4Mr/CrrqumXkJJERkP3yhVy43cxptQi
 8i4Jrij5PQFseTMTmqjo1Mh3vo2QBy9o9icGDCrZBWV6TSNmE6hF+4NOVsVWedOXZ1mY
 u+x7ux3l6SxYzU6sNEFdUTxD8+2mEgINPr9wkCwlwVLDApBMUIrrq1AnZdHaQOxzWhwN
 WxDP/d94uQTecQoHRhK5rIRq16XxnXQd1muHH5tSNwrtlP2MG8lCRuKtqePvxF1kTATT
 L2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639199; x=1752243999;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zWElIbslX/NnREeHmv51db2w0SDJalpLfsWpjW4/9zc=;
 b=PD781zFzzfE3vH30N7+FORp9UYcIp8tFxGqv94ozsHgZ7F0eEhpkM2KOp4Gsem3EvY
 tBJSBXwwgiYJNzTLrz+qipsiR/uvnNdKZ2PwKrOehfMyg0oJp3a+oA57YrDfOvofU88u
 ls3TAVC03cFMGIprEf9MNGm1IyVp1EMDDCh2YWAKy9JSamUQg0ex4jcldiDLWHfdYN4P
 oP6y38/qaO3cf4VNRzHXyLzSoki63D3X58pOMJE1rtWeXWTlvYChxNFanFrYrRYEdyYb
 24n6r3DGx8JGWOWg4mU7cmA+gMMva1kPER0TUUw489qPEC3TFtQ+n6G0JUckilsY7YM1
 hWqQ==
X-Gm-Message-State: AOJu0Yx/meBqrvWGaQbfpGC7wWNBYDnlVXMxqzItXu8kjrh7+gdJ8oJP
 gAU+iraV7neBhaajeXFQXNlxKeZzR1BuD9nX3ULNU/fNafNxcYs5EiJGCZJ8rWN4CXn+oX3OE5K
 3XI1xNAOguuDFhxEXch6GKWEQcSWkbRXedk1Tsf5FIBDg9QghPtD4
X-Gm-Gg: ASbGncudwjBYOuN1pQUYQ21RPdWj1irIzkkxwwwOdOuwivPaju7vjq2enJiSJYFtpF2
 n6Fn3dcDsi4xtXoHqYO/d+eV9TOhGIrJpOPUFnIEOAHwEzzbuz3C0dB+jg+dkwmYptz7S8hoFSb
 1hslJjFi+m2o+lFY7h+hCxzm9IqmAzIi+LUWHbk3iECxRG
X-Google-Smtp-Source: AGHT+IHAHAryYxrpoP9VnPP6lSe9/S0S1Fj9mh1q3cSt4pxCmeLRaQvWwX0NL7zeup8/zVyfEL/coZxOydWmGV3LnTM=
X-Received: by 2002:a05:690c:dc2:b0:70e:82d6:9af2 with SMTP id
 00721157ae682-71668d251b1mr36432967b3.34.1751639198700; Fri, 04 Jul 2025
 07:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
 <20250704142112.1018902-42-richard.henderson@linaro.org>
In-Reply-To: <20250704142112.1018902-42-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jul 2025 15:26:26 +0100
X-Gm-Features: Ac12FXzGQhdSmbA6dxiyD24QGZfJo43i0S4PaoU956ieO6klfbSybtX4q1x6bxw
Message-ID: <CAFEAcA_xnN_h8v8z2yWrGdgC0wnm4X8Y_ZXTD5r3aEMSwHW+xQ@mail.gmail.com>
Subject: Re: [PATCH v4 041/108] target/arm: Implemement SME2 SDOT, UDOT,
 USDOT, SUDOT
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Fri, 4 Jul 2025 at 15:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper.h        |  8 ++++
>  target/arm/tcg/translate-sme.c | 85 ++++++++++++++++++++++++++++++++++
>  target/arm/tcg/vec_helper.c    | 51 ++++++++++++++++++++
>  target/arm/tcg/sme.decode      | 63 ++++++++++++++++++++++++-
>  4 files changed, 206 insertions(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

