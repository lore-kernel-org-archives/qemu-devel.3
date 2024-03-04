Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79AA2C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 17:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhC7c-0002Q4-DI; Mon, 04 Mar 2024 12:29:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhC7Y-0002Pa-NL
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:29:00 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhC7W-0008LC-R2
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:29:00 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56715a6aa55so1939101a12.2
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 09:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709573337; x=1710178137; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uABA0QIqWo8v9mgRhLK2tIyj7e+Zj4OF2HNmzbGB8yA=;
 b=tQ48XsPMWfY/FXRmcD/mnB6QYUp9ncHdjTUoelGBjy7K4q29t4fZe3hmFoh9feRYzM
 K2nHI3wESp94u8lB/8rwmS5ZZqrqVEsV0Ubke7zH0bWM8qX3mkeKas3hNqZZBcNadPt6
 a+GJHvzT1HpNVJ+/vF8kkA9yQA4HRT9+bnyJBjoUi02kxNWEamzkjVYVpWP+eHgCccVS
 EZqVbBzYdyzAme0TWtwje3NZoGZpZnf9+63pu5RK3FO97/ZsresGXZ1/ycWn5isvHNpl
 x9RxG3uLPNukrrnSfQKEpNFrt5ZfRVr0bep4Ft4KXiECrNsxNpU8bRVN9ZUMazJUjw1y
 Ib6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709573337; x=1710178137;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uABA0QIqWo8v9mgRhLK2tIyj7e+Zj4OF2HNmzbGB8yA=;
 b=ftM7BIcBQ01xwo4ZJHtKIKdmY/86TSqXDeFLKZyPZjEd3VR9UWkcHxhK8DtmFbXKcA
 gYp4inqPha2H9M84O69lQ0mopfj/6gzJU/noEbDsFCZjJfwhVSCgFj0VAc/7iOk8zYJA
 wUc44B90DJTYq0u8/YzwE5flhyO/a4kMVqNjypAB8m1F0fyvcaTnBLFddj70tO0MPwp+
 r8rj7UmLBNA8i0LE//MvH55aN/99C829CzikxzaEdruNtlswL0flI3SsszpdBHeTIRiA
 RbHK3aWerFQDt5BojDE/qVXuSNJfvpIpvB4+96rBUshPSNDKg8QYfOFy8TVT76tRMQjV
 U3cw==
X-Gm-Message-State: AOJu0YzsRa9jxASYnOIeMb2XmDurW/lqBHl3PXVU99Ck7hXJ58iv16Mc
 hKcCSDDkSYT8pWh6MqGOPJbOxKqB8fIeGvhu9acIe6tZxJiOTwy7AxvtvFZTYJaZC/eThqHkE72
 Q0T3oOKJOrdsxas6SLdaW9kuhuhmIh8aNnCCvJe9oahdWg4Bv
X-Google-Smtp-Source: AGHT+IEoeF8Q5LottlNjSibAC+E/J4ULl2oh8Us639xlStubGT0vyg5jqPvrpljJS/bCVJ6GWGJt4BD5MZ/4EIXzQR4=
X-Received: by 2002:a05:6402:3584:b0:566:f66d:bd38 with SMTP id
 y4-20020a056402358400b00566f66dbd38mr5882285edc.25.1709573337218; Mon, 04 Mar
 2024 09:28:57 -0800 (PST)
MIME-Version: 1.0
References: <20240227142316.1827154-1-peter.maydell@linaro.org>
In-Reply-To: <20240227142316.1827154-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2024 17:28:46 +0000
Message-ID: <CAFEAcA9QbbOuzeo+bTRAdTCS2h6gTocbMsgj3k3DNP=H4Bh0Ag@mail.gmail.com>
Subject: Re: [PATCH] tests/tcg/multiarch: Give the 'memory' TCG test a larger
 timeout
To: qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

Ping for review?

thanks
-- PMM

On Tue, 27 Feb 2024 at 14:23, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The 'memory' TCG test times out intermittently on our cross-i686-tci
> CI job. We expect this to be a slow config (it's using TCI), so it's
> possible that when the CI runner is heavily loaded it tips past
> the timeout.
>
> Double the timeout for tests.  If this doesn't resolve the
> intermittents we can assume we're looking at some kind of
> TCI-specific hang.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2079
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I could not figure out a way to get the timeout to apply to the
> 'memory' test specifically (including all its variants like
> running with plugins or the gdbserver or record-replay).
> ---
>  tests/tcg/Makefile.target | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
> index 8cf65f68dd8..af1a18cee1b 100644
> --- a/tests/tcg/Makefile.target
> +++ b/tests/tcg/Makefile.target
> @@ -98,7 +98,8 @@ QEMU_OPTS=
>  #   15s    original default
>  #   60s    with --enable-debug
>  #   90s    with --enable-tcg-interpreter
> -TIMEOUT=90
> +# The 'memory' test in particular is very slow under TCI.
> +TIMEOUT=180
>
>  ifeq ($(filter %-softmmu, $(TARGET)),)
>  # The order we include is important. We include multiarch first and
> --

