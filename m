Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6D9C83F1D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 11:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZpdI-00030g-4m; Thu, 10 Jul 2025 07:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZpd6-0001Zh-IP
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 07:39:57 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZpd0-0000q9-Jt
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 07:39:52 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-710fd2d0372so14896057b3.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 04:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752147588; x=1752752388; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tIsnJmc4BYdANKZrBp9iS9Y2HYZLnT2AXCkX/9Ooasc=;
 b=zfji9Irn/o/Loblrt/avkG89PCEMfTVdSqYI2tIDG8e30tXmxzAu3kNDB3Vhw3F1P9
 R29ylDV21+PZcujoktJJ9y4jHx2O5sHfyHl3+Hbn6EUdKRxTzT4RfOgNtgVcn13eBmBM
 DYUeWN/n1SseVCmUBm0l/vmCgD+Yi42CIBlxqoiPvxFUZW7/slrYZat0SkvGqNOT6cbL
 TM9crb7a5Q+kc4kIlDI5ou0AYRJV8GTSpNKDxHdKOkeYBWMI/pVXiTbesw733SY1A3He
 hoj+Q5KtVH7uabLEeeNvmQ8PuC6Up3ZOWLVI5mfoR/IpIu41FRZCbo53yysZYv0tfD5p
 OtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752147588; x=1752752388;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tIsnJmc4BYdANKZrBp9iS9Y2HYZLnT2AXCkX/9Ooasc=;
 b=uLscRTKnu5Da/IF385pHCMliO0Ikj9SnQsfTQ+48T/jChLuQlrIWduTXN4GsVSi25X
 w2aY/8dWCXjOtmRgc2M71vCQ6iQUd1V4rum9+NtNI+vu6TQAtTm9PZWqfoUaJ9Zu4XR6
 vEhUOBwYWPB1OnvGzUK+FQ85T9hjM2x06Jpx8NdFLlfr2xLF20ujq0DQy1t/WV93geiN
 ubPQ0E8TTrtdw83KifbSpH0wMV+ejigxgPseU/uuTMqTl9fe8IDCnaPHrIP2YoksNF+K
 XCCLwatw6BjpVBT8cUFJaicxkc8gMB+9Kn/V5dCwl36jjvp1/UDdh39du3568NTY97Dp
 8ZAA==
X-Gm-Message-State: AOJu0Yyk13S+mhsVyY6iP/ooHalZs3ydRMBpCei+7mly//2DEFL8zHOy
 7rm6V0v7KZ8DZZrr1cbJaoaSZ9dzZr6XIHTMwm+Oh3l2yha+zi4r4nOD+6pcMg6rbWby3oIrSeZ
 fgui3yVUyCqrj+2MYYm6ymYYZ4RK5MCRg+b+d3iREyQiw9el91t3c
X-Gm-Gg: ASbGnctkK7eqtd0CntFeCBVoCIC2gtagwaE+gsS698TUQEMewAzJ/7q/8nx/xIqBVT4
 2WSegppm8nK4MwUFsciEr7BokZjoZ7UiZQgJu7QrSMiUGbh1aEwvsa3GAe1KTXPQtOoKFEeyLnD
 Xoimnp7DUOqhi+HTf5Zt+rWDRJ3cQSMxE1ErACxXuQE7eu
X-Google-Smtp-Source: AGHT+IG8uaDhqnF8Va8jgUDBVkhDnLq0cHudXrigf5ZWb7zGKwe+sjJ6dQHmJl+DIMYNTvi3SJmDfrG9JlK7V5QGyUc=
X-Received: by 2002:a05:690c:4d02:b0:714:b7fa:2d7 with SMTP id
 00721157ae682-717c15d922cmr48461447b3.13.1752147587569; Thu, 10 Jul 2025
 04:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250710113123.1109461-1-peter.maydell@linaro.org>
 <CAFEAcA9zJAeYbtQkWC8Za0DGEukdKAcZpnM6vPiAQ358Ue_k6g@mail.gmail.com>
In-Reply-To: <CAFEAcA9zJAeYbtQkWC8Za0DGEukdKAcZpnM6vPiAQ358Ue_k6g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jul 2025 12:39:36 +0100
X-Gm-Features: Ac12FXzuY53Dm1k9Vcbm-jBkYJl-Rxe10sONsE8DKoBS3yO02kWONfEh3XcHano
Message-ID: <CAFEAcA_Hhj9guH2C+CQF-X7VGBKNTN-K3WzQ6FfmTbonuuCm_Q@mail.gmail.com>
Subject: Re: [PATCH v2] linux-user: Implement fchmodat2 syscall
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Thu, 10 Jul 2025 at 12:36, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 10 Jul 2025 at 12:31, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > The fchmodat2 syscall is new from Linux 6.6; it is like the
> > existing fchmodat syscall except that it takes a flags parameter.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > v1->v2: don't bother with trying to fall back to libc fchmodat();
> > add missing braces for if()
>
> I forgot to put 'v2' in the subject, but this is indeed version 2 :-)

Oh, and also

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3019

thanks
-- PMM

