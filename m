Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6F0C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 15:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raHSF-0001Cx-IY; Wed, 14 Feb 2024 10:45:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1raHS8-000194-3U
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 10:45:42 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1raHS4-000739-Rh
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 10:45:39 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5638dbf1417so694730a12.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 07:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707925532; x=1708530332; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z6AcvSbimzMISU329UmkO1SZgTL/DXIiACZuAr+QSnE=;
 b=C2p/jAkoWx247N3+wUf70i8lzoJA/suP+dib1dtFkYVzaSH+Lf+VYQZ0bu+lhsbR4x
 jBypcve6rrLoaQTYyagpigHPZKaqMdVepi63vG8SzmLmof9k6olJGndotoa5BXbV1JF9
 uz5fKu6DYg/Qy/bO7HUGeJMspMGYDGW8e3ZQHXKIKujrtyVCgWUkVF2YEd5HDreZL1ii
 VdgU1OaESSHGSLWsH95lE4J0SqVNM0sg2Fh7EER8/PyiJ7EzZ27txZuIz2mN1JTbSPaz
 v91I8qJMUhjTEEk1wPD92d/ysvPt5SN1dII0vYWU5BULqklZbmIgtqu8hcb8Cqp4eIMN
 F4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707925532; x=1708530332;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z6AcvSbimzMISU329UmkO1SZgTL/DXIiACZuAr+QSnE=;
 b=wYbWPA1iXEjhDfUNLH3v9MxId033/9sFelqOU5VwjXvMbosPgKuyhsWKNQ1ZZ8aUD3
 SOdxYwl6ZGwIDr7Qva1pIm3R/VdPVppc5wEDlgUTYk5a0HVqmCzihByZT4Pov3Q/oNPx
 CPpkd1J87hTZ+cSY/8S5/9DCzYBGDwIHMKDc1Rs2dyMZ8ivnJn5v7VahZ4OyN20OY1+D
 kKlIL7aKtdmiuFF9KkCEn48elxCnfA5CZZGVoOR4RJ4HnVLzj14Mp3s4OY3T6UWxdB6s
 DerBA1xQ50TVg8Hay7rAE9W3eKOQ9IJ+FFnEKyHmbXG68EOkGuxX56Gi+F/0NcHJj8A2
 xkBg==
X-Gm-Message-State: AOJu0YwsGgR4m4DbQsuYnFPyftqRFvM55KN0ZFELi1pvAO5o10V3qMZf
 /1+BQyqPgaBQPRhe+CBeRXpjWHoVVU0EwxKuLwhQL/vEJeltOeLIGGF7HxeuF4owaMYthkkcGeD
 avdOjfvLKBrtgNAvG8cfiSvJsNT2lNhctbRhFfQ==
X-Google-Smtp-Source: AGHT+IE2vSspHrYJjMOEYBu5jgvCgSSHgfmMeAta5HUO8ViwRa94jBwkp55DhqOfWEChCrbKMvuTnZEa7HzM9fSCH10=
X-Received: by 2002:a05:6402:1352:b0:562:1209:ae04 with SMTP id
 y18-20020a056402135200b005621209ae04mr2175780edw.5.1707925532460; Wed, 14 Feb
 2024 07:45:32 -0800 (PST)
MIME-Version: 1.0
References: <20240214012533.453511-1-richard.henderson@linaro.org>
In-Reply-To: <20240214012533.453511-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Feb 2024 15:45:21 +0000
Message-ID: <CAFEAcA8Tit+YQiO7vbfxOVGQYpz3BRYCDwOTw5buBmauxN2f8Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Wed, 14 Feb 2024 at 01:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit bc2e8b18fba33f30f25b7c2d74328493c0a2231d:
>
>   Merge tag 'hppa64-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2024-02-13 13:56:46 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240213
>
> for you to fetch changes up to e41f1825b43796c3508ef309ed0b150ef89acc44:
>
>   tcg/arm: Fix goto_tb for large translation blocks (2024-02-13 07:42:45 -1000)
>
> ----------------------------------------------------------------
> tcg: Increase width of temp_subindex
> tcg/arm: Fix goto_tb for large translation blocks
>
> ----------------------------------------------------------------
> Richard Henderson (2):
>       tcg: Increase width of temp_subindex
>       tcg/arm: Fix goto_tb for large translation blocks
>
>  include/tcg/tcg.h        | 2 +-
>  tcg/arm/tcg-target.c.inc | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

