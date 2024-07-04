Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810B8C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 15:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPNxY-0001hO-ST; Thu, 04 Jul 2024 11:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sPNxW-0001gc-Td
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 11:01:19 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sPNxU-00035n-KV
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 11:01:18 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-58b3fee65d8so960737a12.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 08:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720105275; x=1720710075; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z+htez+DmcCiNT11InJtmwIXm25KfRv4bbSjPEjgIHY=;
 b=EH7mn24aBBf2P4LNQ4kPa+y5U1GKx8jBLJ9zOKm1T3PG8mC36espKgqxxtEL3uL90h
 t3/tNwsUtAjBLfhaVrxuYaUBjc9w0nBC1WxqttjeU6I1bHiILVFULQ9L/YD0csRLEZZJ
 5KZfhYgr1XmVMiQWuU1KTyGsZ95hrkp9l70tYgNyRBlqi5KGKrMB7gNTN3qHQNKn29Ck
 yuXN75vgpn43k04MnHdRnV0mWNyGc8+kDgRLDobvxyskFpvOObyoCiODAFf8jsXMyQSv
 iLMi4DgCLgiM/asG8AU6KAhmGe2iPrAwQApsRd66iFqIoWxg7AsLl9xbqi/lC53J6HBX
 8bmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720105275; x=1720710075;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z+htez+DmcCiNT11InJtmwIXm25KfRv4bbSjPEjgIHY=;
 b=D3EpFZ+YXgCHjRUVrwwxB93C7XNTKSl6E7oR+wEpwiTo+ue12VlHKwI5Ze99iyRUpU
 4sNFd7qpq5pJ55wwFWooOZhb7om5NVngS3TG9ZVNQXZ5ozM1Yix3bcUGeiJcj9lJNkbW
 5rWhLYa+54UcBpHhT3PT8SMnIytcZyCqtUzakQjh4ZhaGr0XTubU+Jo1hpcQ7J47dAez
 aOOETbX5MxJPSNjbsFHqkUcWsS5XtEHkP6y9E+7bpwb6uq3+/D6zspRzPcpPPN99WGBZ
 OTqRJTVZsgShU9Nf0ej1AYPVaE/x15DtA4z16JsIKJLsLqZbi8RUyySUr3gCEWH0DYTx
 ZFnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqCDadxGU+n1vFVlx8UTl7rIdQrzYgOlbbTpA5fmPf4D3pavD8dHyTeze79KqFnaIUzT2gqA90nouV19mPmoY1bHZnxVU=
X-Gm-Message-State: AOJu0YwJfkRnq8QLnFGQUoj49PK4eMw7Rpj6kj+n9ghJa9nTI7wdHZ09
 LdofitEIrVjUvuJVexVL7DVhAP+8C0Nh59hI+wuMpt1Y1FIbLBbfazFrRui33Zq0YupAW3ab7Ya
 tu2F6Jchzu0Yv7e8fkmpE0tXN6s2jMcv24FHs2A==
X-Google-Smtp-Source: AGHT+IFvvvx4Co1IO5xjLilNYI+h3u6lhZRJugVsFW5eTek5DU6KuA86mRMoX9vQBkM3/reHNwFwtNya60fjjUPqqEk=
X-Received: by 2002:a05:6402:1ec9:b0:584:a6f8:c0c5 with SMTP id
 4fb4d7f45d1cf-58e5629b3f1mr1571313a12.0.1720105274924; Thu, 04 Jul 2024
 08:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240619124903.56898-1-philmd@linaro.org>
 <42de8f25-3624-4e7c-b38c-ad8e3b8e61a4@linaro.org>
 <83667101-daba-43ea-ba33-1df547020cd9@linaro.org>
 <ebfa6ca6-d93e-45b3-8786-cb52505e2d7c@linaro.org>
In-Reply-To: <ebfa6ca6-d93e-45b3-8786-cb52505e2d7c@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jul 2024 16:01:03 +0100
Message-ID: <CAFEAcA9bqgFwxsbvKFLUiGu=ThzF0zAy7-rD+7Yo4yNEoi4Pbg@mail.gmail.com>
Subject: Re: [PATCH 0/2] target/arm: Always build Aarch64 gdbstub helpers
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>,
 qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Fri, 28 Jun 2024 at 17:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 6/28/24 09:37, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 28/6/24 16:31, Richard Henderson wrote:
> >> On 6/19/24 05:49, Philippe Mathieu-Daud=C3=A9 wrote:
> >>> Merge gdbstub64.c in gdbstub.c and remove uses of
> >>> target specific TARGET_AARCH64 definition.
> >>> Small step toward single ARM/Aarch64 binary.
> >>>
> >>> Philippe Mathieu-Daud=C3=A9 (2):
> >>>    target/arm: Merge gdbstub64.c within gdbstub.c
> >>>    target/arm: Always build Aarch64 gdbstub helpers
> >>>
> >>>   target/arm/cpu.h       |   8 +-
> >>>   target/arm/internals.h |   2 -
> >>>   target/arm/gdbstub.c   | 363 +++++++++++++++++++++++++++++++++++++-
> >>>   target/arm/gdbstub64.c | 383 --------------------------------------=
---
> >>>   target/arm/meson.build |   1 -
> >>>   5 files changed, 364 insertions(+), 393 deletions(-)
> >>>   delete mode 100644 target/arm/gdbstub64.c
> >>>
> >>
> >> Are we attempting a single binary for user-only as well?
> >
> > No, due to ABI constraints, right? I did a user-emulation
> > smoke build, no failure, did I miss something?
>
> Well, no.  But qemu-arm does not need gdbstub64.c.
> Given TARGET_AARCH64 will be set on a combined build, I'm not sure what i=
s the fix?

Richard: I'm a bit confused about where we are with this
patchset. Do your comments mean:
 * this patchset is OK for system emulation but we
   should (later) think also about user-mode ?
 * this patchset has a problem with user-mode so it
   needs rethinking ?
 * something else ?

thanks
-- PMM

