Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9202BC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 14:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk2FX-0007rU-Ob; Mon, 17 Feb 2025 09:37:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk2FW-0007qr-4k
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:37:30 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tk2FU-0003Nm-F0
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 09:37:29 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6ef7c9e9592so33326137b3.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 06:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739803044; x=1740407844; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G4SK+HvCc6ptd1LtIP/LSc2/QzgcAAxoa/Y6hkD/GmQ=;
 b=l9ahdTRtqJAEiJgghFGcW7cVhU4tBe02CrqbPWo1AXmbjNSwFOC8kM+wVenIQYRe+I
 i60ubUIyRC2ZgDb3p2PLoGNL0lKEC0G8JKFoJOxTWVH2qsPC7FgCUF4SuZh+xwMwOH6y
 mfIw8kKT8h42rPj5tZA+Erck/L4gZmkjikRh48ANxQYL/fKYZayNfPx49axKE7cimVOp
 xHQPrI1TxZRLX9DDUX1ZQmnaC7GVjepgukuHYcD6lNBF09gLkQmoMdr8z4qkgRgu1u63
 sa9gzh8fwC9kMMIWGYx2N7zSv87hlSx8QU+3NH365kyEm2lIk/t8gHAdvNYe1abFph05
 QxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739803044; x=1740407844;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G4SK+HvCc6ptd1LtIP/LSc2/QzgcAAxoa/Y6hkD/GmQ=;
 b=goTZ2JB4h1PM7OOxuBuOdnynyfPga4HhbpPsq6cGFNx7b+DKK7oiWidqZSLRGeZEvh
 gVwzqcL72q+TshU9y6iiECMYspLTuftwK4HlbfuNBZ6oj+ZW7XvdAoLWYvqkQk9zTA9r
 Bp1r5hnnUKftYDsqir/EPFAd+96qiu2Biy30r4lnXaAzAirTob3eI+3Pqh9iLceMtojU
 IxRUABYjR8RYi6EE6nze526B7g+ACQYwcNrR6/mK4bTaRS7YWUnLqN8ERB3lTz0HBzFE
 wJheCABmM1MNAc8lFyZ7oOTurqb7R/r5L/q4TrcJI7+lJaf16HWYy1plBcgivR6EV1z5
 fnYA==
X-Gm-Message-State: AOJu0YzjU6OP53ODF4/ATeDYQCDFAxogFnQjrxbCAOzk51c1XF25f4o6
 AiKLwg3GBYZCxmQcYwqIQ20Ru9FzTDo6VgTAHF2pFSFGkHzY/4dTDMTUJhND4EutbjIny38PuO4
 sAQ/jZEppxZo0OKfVwuxNN6Cya0hWNnBDE7A5xg==
X-Gm-Gg: ASbGncvxf62Gn8RBga2AANVSZgwhUv9Q+PaHBIZ9IVIWrNbdCUmdS44jIZhSO6OAtky
 pY0VCt0h679HpvNmPQmg3beBPhjlD5XQqR2WU7+Ll02HlNmiRmLticKFuOQg9MHRW/vMkKF66UA
 ==
X-Google-Smtp-Source: AGHT+IFed88iTcWE4fdkwHywI9CoAe7VqnfpWneaaUvIEEs9z7AO56AjZh/4lvLpvlgv4RWKtwM51zb+IfoYfRifY2A=
X-Received: by 2002:a05:690c:46c6:b0:6ef:641a:2a73 with SMTP id
 00721157ae682-6fb5828f911mr75119327b3.9.1739803044663; Mon, 17 Feb 2025
 06:37:24 -0800 (PST)
MIME-Version: 1.0
References: <20250208163911.54522-1-philmd@linaro.org>
 <20250208163911.54522-8-philmd@linaro.org>
In-Reply-To: <20250208163911.54522-8-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2025 14:37:13 +0000
X-Gm-Features: AWEUYZmf28LkTuVlzwrOtzC11OEi7GSyEcTkad7S_xelSk6_j_yISaFozTUyjkM
Message-ID: <CAFEAcA-QVK3gcY4sGNJES=opPK_SqyuqYKpn1CQtDiBLLhaJqw@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] hw/char/pl011: Implement TX FIFO
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Mikko Rapeli <mikko.rapeli@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Sat, 8 Feb 2025 at 16:39, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> If the UART back-end chardev doesn't drain data as fast as stdout
> does or blocks, buffer in the TX FIFO to try again later.
>
> This avoids having the IO-thread busy waiting on chardev back-ends,
> reported recently when testing the Trusted Reference Stack and
> using the socket backend.
>
> Implement registering a front-end 'watch' callback on back-end
> events, so we can resume transmitting when the back-end is writable
> again, not blocking the main loop.
>
> Similarly to the RX FIFO path, FIFO level selection is not
> implemented (interrupt is triggered when a single byte is available
> in the FIFO).
>
> Reported-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> Suggested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

