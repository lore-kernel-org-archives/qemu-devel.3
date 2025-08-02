Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFF6C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 11:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiAF0-0007kv-F1; Sat, 02 Aug 2025 07:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiAEw-00072H-72
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 07:17:27 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiAEu-0007e9-IG
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 07:17:25 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e8e1ae319c6so1500226276.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 04:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754133442; x=1754738242; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LMt6bnbzE7Nn4zp+PsW/0crFSvwAQSFszeigm8kir+A=;
 b=wdUMMxujeuIZUxTWatk57UrMT6OUiV3vxLgywJDMdwoWWu2rJcvABo/mTYQXhj2p1L
 jxafwFV6iL0XENRd55AMIgvrmXVHNYZ16FNBjV2abn08ztBZRRbUWOJfotI/AVmzzPyB
 huggul3FfhuuH2fQn8RAALwRFsnbX19rIU4J08F2p5eoy0NG3+VaGfPjdo7j70YJmHOO
 Tjixbh5sxx+CCy5pZYrUWdA1sCG7P6Amk7CycHJdMXA/Gb/fC7wgIx2KqdnRxfxWARIG
 e/n9f2+xDBHLO+FV+3ylH9pTfV2ZnoUBHb951l7RvEpc7E3qHfCiGv4jpXtRabVKgK3E
 mCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754133442; x=1754738242;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LMt6bnbzE7Nn4zp+PsW/0crFSvwAQSFszeigm8kir+A=;
 b=FXqRtjq7M6Cg5vaKGObQ2Tfhlmumk4ycQ8yavzilM95RE1aMLDht4jnlOw3nVn+myo
 ViR74BG9fUfQWvY9ZXc1FZlvz0KFfjMZ8ZjSptQhciHau+FFmFsF2toUEweYEN2svamz
 qPZjGyvt3femAFTmGuX1ZotHejpT/vVnwUdUC9bps5yE/YUx2lkMYB3zMaMu6BHdPyfj
 dT4Ye1/wVSQ9goUOJ4hUtO4/3AhAs8kZhp3DPKvT/EkhTQsNaS5UT9LR0Lqq2Vo1ib3C
 I3EJBdFbzR70rucTpoK6UYMEjtDcga5gkLvpYeMg97KkqRc88+Fwk7kD4oE+qZWDpT5g
 5xKw==
X-Gm-Message-State: AOJu0Yyh8NnVwVbMGAP0/wySzp74o45bUa45MqQr0QLlV8b8tRF53TbQ
 Bwlc5FTSXGUo1uOvXRtAmNdPAhevNLml2G6xSa/EC//bc/TCjG8wI7Yupf8Pc7pQ5FzzdFnVZOv
 o+ZiT5xxsKGsH9s6l2ogm4oC5s83BxhPbZLRvGpJv8HnA2M20xVgu
X-Gm-Gg: ASbGncs8m1ba7oYRc8HqwIVdci+zlIDKP5VA57KbTfqMijs9LmNoSSnmRmxzf6BYU89
 U8Mtu5fFnKUNgCu3KFwyLcGso9ez6GMy6uonHIQYCJdA+zoau47rTXxgemaEaISPgX/8FmQypnh
 UmiOfyfZsRnLCFvypk0TNO8j+IIL7DbE9xK2VI3rBdK5Vf+DRmI37wi2aR+jWsg7QSs4rFTkzBc
 s0MzDDs
X-Google-Smtp-Source: AGHT+IEAYUU8hvQsNPnziu17knJvU4ZKg6vePV3NfcQZddnHl0xXFndOZVbeh2dTkuWOCCwReElf+XCnWE8eN2gkLcE=
X-Received: by 2002:a05:690c:6083:b0:71b:72b2:b8bb with SMTP id
 00721157ae682-71b7f084cb4mr39177507b3.36.1754133442687; Sat, 02 Aug 2025
 04:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250721201134.13270-1-fanyihao@rt-thread.org>
 <AJgA9AAZJYcrbcAf1ETElKot.2.1754115134548.Hmail.fanyihao@rt-thread.org>
In-Reply-To: <AJgA9AAZJYcrbcAf1ETElKot.2.1754115134548.Hmail.fanyihao@rt-thread.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Aug 2025 12:17:11 +0100
X-Gm-Features: Ac12FXwVUZk7W2drCWHcFqOGmgzOxDBElnr1qyXBo93yJUr9qV6sK7wz_wGCWCw
Message-ID: <CAFEAcA-dXnERwbgfMpXc40rDSqFJLN-iNWWH8ZXrv-Ap1M+2Eg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add STM32F4 support and USART device model
To: =?UTF-8?B?6IyD6Im66LGq?= <fanyihao@rt-thread.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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

On Sat, 2 Aug 2025 at 07:12, =E8=8C=83=E8=89=BA=E8=B1=AA <fanyihao@rt-threa=
d.org> wrote:
>
> Hi,
> Just a gentle ping on this patch series:
>   [PATCH v2 0/3] Add STM32F4 support and USART device model
> https://patchew.org/QEMU/20250721201134.13270-1-fanyihao@rt-thread.org/
>
> This patch adds support for the STM32F407 SoC, a new STM32F4spark board,
> and a USART device model. Feedback would be greatly appreciated

Hi; thanks for the ping. This series is on my list to review,
but right now we are in the freeze period for the 10.1
release, so I've been concentrating on bug fix patches which are
going into the release. It may be a little while before I
can get to it. (Other people are of course welcome to review
it instead!)

thanks
-- PMM

