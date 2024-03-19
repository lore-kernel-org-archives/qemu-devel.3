Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F36C54E68
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 19:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmes8-0002ha-T2; Tue, 19 Mar 2024 15:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmes7-0002go-11
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 15:11:39 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmerx-0003bW-Bm
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 15:11:38 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56ba72fffd6so529871a12.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 12:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710875484; x=1711480284; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cR1VlHK6LdEZUPQ6hcICWsUc+1PyUdAa+M2l34BbtnY=;
 b=GKh5UauMpSmOyCQsdw3S0rjaTqHP8cWVsoZvWhCEcO33Z3peHr0UxLYtbqUsfTyZ9Q
 mzWGvBrFGd1qdDwpjh27vo9xLZnva9ETK1jPpZeKJu0Rwcsaueovr+bi5WoRHseY5oOL
 +fY4Q0uDWKG5kzUiKLw1tXdqaj/03sJmdqS/lM+cyyxtplSaN8BITjiS9CCP9MsTtLYn
 A0hII0CV1ntEH0cZ7+6RU/rDUN+Dos/VuPYYzkqsdSDkV2xk2hraMYQ7W+lt3Osrm8Sl
 3MwQcmKNI7Gfc/xzDR8WZ5PA9B5Df32EPOMwSiZgVVfOkusFM4TyuCUkWNgXaJofTW5r
 9Ppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710875484; x=1711480284;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cR1VlHK6LdEZUPQ6hcICWsUc+1PyUdAa+M2l34BbtnY=;
 b=cyokd3WXfiZ/BdfczecU7ouiPLQpB1gzUpkuZ1Ce57x7/pqROCfleMU+mAwYIipDDA
 VVYkK1TI/oatjaU5DjvQpbC3tL1laXh3qGesPQeCUHn60F+/CGyxXocG/Dc/haPIEjxj
 hzy7xAwLyXtDlHClHKxRSWu1pZK0frq++h3mcX4Ye0WoFt9T+jV+1f1CvgwGTP1T7vNt
 wiO53zEQMmqDnMbdP1cJSgiZbkvQ5ypBEr0W8r5jJExRoDT0VxhmjMVhvTI+kelXtnkV
 SPg5zn1Pfra18dUICYT2lb6E5TmBWbhw9M8V7q4Bxt4GYg5P8PvB1vQwAX4rVXODMzlk
 dRQw==
X-Gm-Message-State: AOJu0YyADm/ym8pz/n/fkihNGcBk2RdKmzno3pvpRJISKMU1OQIMtfex
 oP1aCfjzeL8v3wQ1pl9EDrKAdPCsK8QQssXk5TZQI4ZLPEURaKZA+Mposx2QIBicLk7jZ5Qtygj
 TaM1VMtThcDf/BQVoi0OIemKn0Dz+iH6owsarEA==
X-Google-Smtp-Source: AGHT+IHDRXRPoiQE1FGFEzGLp74gSVHi5l/BIBrg/GJoxDTd/AJYZuRrBse8wdgBxzp5NDrdNXoYDMwsl4Uzlg5yxG4=
X-Received: by 2002:aa7:cd58:0:b0:568:260b:e502 with SMTP id
 v24-20020aa7cd58000000b00568260be502mr8645814edw.13.1710875484551; Tue, 19
 Mar 2024 12:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240319150938.1108941-1-stefanha@redhat.com>
In-Reply-To: <20240319150938.1108941-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Mar 2024 19:11:13 +0000
Message-ID: <CAFEAcA_6+RBNEtxiJvOovx9RvEgh5s65SBKEvasJ0y_D84WsxQ@mail.gmail.com>
Subject: Re: [PULL 0/1] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 19 Mar 2024 at 15:09, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit ddc27d2ad9361a81c2b3800d14143bf420dae172:
>
>   Merge tag 'pull-request-2024-03-18' of https://gitlab.com/thuth/qemu into staging (2024-03-19 10:25:25 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 86a637e48104ae74d8be53bed6441ce32be33433:
>
>   coroutine: cap per-thread local pool size (2024-03-19 10:49:31 -0400)
>
> ----------------------------------------------------------------
> Pull request
>
> This fix solves the "failed to set up stack guard page" error that has been
> reported on Linux hosts where the QEMU coroutine pool exceeds the
> vm.max_map_count limit.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

