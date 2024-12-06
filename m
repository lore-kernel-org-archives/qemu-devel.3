Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E09E77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 15:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJaXe-0006Yu-G6; Fri, 06 Dec 2024 10:46:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJaXc-0006VY-9f
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:46:52 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJaXa-0004Pe-T1
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:46:52 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5cecbddb574so2552891a12.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 07:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733500009; x=1734104809; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U6SNQ+yfHAdSrUciOzwgTiudfubcDQS4W/05+DvyOVQ=;
 b=QgbbSWJswSj883zKlKX2OJNesbJD1/YUzUnvYEBu3gd5ATIQOUiDKlmklNFs2t7IrA
 anzrh/YDkxquwgqZKtXWqubc3fLhPw7XG5uHSRqICIc+v5IMfWxsWCtmuwNCj7fDiqU1
 qms1y5Ir3ZGnUH2aS/jW1aNUJKPBdy7iNSbAI26YqYnmGFgbvq6eFtNMgrX0XjtKym5d
 NDDpNX1IhSKTwTAviISO3fCOb15ooHj1AKBLvt3uZP/jUIxjgu3BLgQeLvSB0FnW6JN3
 lejb6ic1zRMONl00VmyOOlS4GX8uiMxjnYtt0pTild52eGh2NKHAIiTN0mKBsG9Xxwiy
 TMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733500009; x=1734104809;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U6SNQ+yfHAdSrUciOzwgTiudfubcDQS4W/05+DvyOVQ=;
 b=H+KsWWfNevRV8Yk4AYEdQLF//B4O8AX1rXjGM89v4sBhP7dHEALBIw5XxNJWUKtApu
 WNCOutYH8TN4pjK1RNZewfrL/y/8KgqnXi9RtL75MuJTGVBkMDf1qwg63YMfiY77FJiW
 wm1VDkqdbDyIsq2T8+DucSPrUNctrXBJZjexyapZcY+PGH2J9a+zZcoBvG93lkLa1KhN
 qxE0ukWqpcEtqhYOVVEvHCIwTe3CBaQ03usHdiy04bYmn63MTfumoiAQxkNV6qp6c3jD
 UYvWRgUEJI7SKN51cBCDi6UN8IBhkTosSgICJCflU+WnzkVv/xx1kWNAVJBf3bMIVub7
 yp9Q==
X-Gm-Message-State: AOJu0YyJ34gw6BTEqh1i7jIVWL4NQpCrw400yvrqbmK9pRJSdXfVHt0g
 Qa7NAIn7t+UYq/8KmVGNFyOvYy3xSkLZsS7F/1fJQhYAbXHpiyR4PHHJEPQKGArrP9TJadkrttR
 qJooRka3YCzadzqynmyWWJw8jnbhHk+DLlXzBmg==
X-Gm-Gg: ASbGnct0M1m1T9B13dD+/HQPIiMt3jprWJhulGdm2UVhBUlk2hj+pySi6hCxK4tsDzS
 EMY2QSttARVc3Sd/ckwkXxowSztaPiuXs
X-Google-Smtp-Source: AGHT+IFpVL6csAq2dLwPpTdyMDMi8Te0aYCIivOggCxlObV7NcOdUiJUBWH1ZZ2dCS1wVfX4msm8oNITkO7w31mFfJ4=
X-Received: by 2002:a05:6402:40c3:b0:5d0:c67e:e263 with SMTP id
 4fb4d7f45d1cf-5d3be678280mr2843400a12.8.1733500008960; Fri, 06 Dec 2024
 07:46:48 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-49-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-49-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2024 15:46:38 +0000
Message-ID: <CAFEAcA9wqWr_2_sa-yj6e7m7qxp-Lyr2u1HGKjpCbYxeReFCnA@mail.gmail.com>
Subject: Re: [PATCH 48/67] target/arm: Convert XTN, SQXTUN, SQXTN,
 UQXTN to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Sun, 1 Dec 2024 at 15:18, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 153 ++++++++++++++++++++-------------
>  target/arm/tcg/a64.decode      |   9 ++
>  2 files changed, 102 insertions(+), 60 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

