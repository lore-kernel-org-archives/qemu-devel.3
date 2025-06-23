Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E9BC77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 15:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTiwo-0002kn-4q; Mon, 23 Jun 2025 11:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTiwk-0002k6-F0
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 11:18:58 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTiwi-0002Qm-6X
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 11:18:57 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-711756ae8c9so35940947b3.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 08:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750691935; x=1751296735; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nleg1g53wTR//7geS/FdzKYKumdNWkKvu6cQdMH4nW8=;
 b=OvfhhckCND9NgPlVdF0N1x/JrI0VI3Hq1KcAtpQotQsCiLjf/s+R7SDyVEHUNJ/lxK
 u3mW+W6X8GnzyxAAcWbP8zOqdL93tNaVJHmepyuQxVGv1FPmmBzTiwYmOJ4OvU0ONeRM
 Q9vfsyBugilWEZLR3yd8HRLERZ/pH4qdIXqbAtkZmpV3JCTpyAxyIiEUqGZTep73bFZa
 rsUdl8th41nYyn6KCmLNWoUPPIE12wiws2C6Zzfsp/dhwRoEmaLoz1kdt2lIMhPHdA1F
 BmbIWnoCRHKKNx9yIOB9uP4s/tCkKijg5Utc6RF/OmyuZzWoRrMcWX4+o1znfzliZ6ml
 hIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750691935; x=1751296735;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nleg1g53wTR//7geS/FdzKYKumdNWkKvu6cQdMH4nW8=;
 b=XRGcfzcmAYOORbqruUYYVnNUlOghuGkek+B3oS48Mf3I/6TRIttkicaYKrw/Zo2jsk
 bfu5dkBgBAkQCbv6Oj4DZQbgy5E4xzwUTkGx1Ne7Mue2OMI5lmFVtkl+DlXD/0nBuq2d
 yksTIyBfOGki/j8l3ZR6mqYwKXBMC/UFvVxlT0pApXAtj43XPkWIAs2J5zeSQ+ICkC/b
 Nv1rJD98FpCmrPnbvTxsnC6/JW5ZFX1i1+YYSRvSA2HaihBsEu+TCywml1ROfP4j9Cd/
 9MaTIU6QeZ2iZAQhfKRElcfsWCi4qiPErBYwHY7AXXNiQfIp3BPVXAI3FTSuaPW2qW2d
 PeSw==
X-Gm-Message-State: AOJu0Yyl8AwQk5zsTMLMUOVBM6DPmrgNTw6xTfwq+KFmlv4vjly3QiXm
 0LaT2VuAhOgp+Rb4Y2yKa42UoTqe3VnrXqYSA67O2aiOlvlBT36Y+sstwN6DvLGM/asmMGnGQSc
 SXMOkeOpaL+2TKYcCKV7RZwU9bEkbE4V3CLmdcfmD+A==
X-Gm-Gg: ASbGncsvNzAypx0sC7lBs6C5hjNYsoZ7WnZW0vpOPacUDl3PSiVGMv4AoRDrIJeOKiz
 DhEWWp9qxY+E8OHHOlGL64T4Jz6WkrJGXhzWZe0fFtFRlBE7I8+9hMtSJajz3fM4NR/Wm9NRG1n
 QvkUtzSabNTh7019vMpidWRHjS5B08CKussAwZZsxD86kQ
X-Google-Smtp-Source: AGHT+IGbikx95LJFJ9HirulV72pjp1x1doYlll0wM4OzzyGNT4t0DdLDquavxROvjLXLDOzhWwhAMSLlw+7aLTAGb74=
X-Received: by 2002:a05:690c:60ca:b0:710:e7ad:9d41 with SMTP id
 00721157ae682-712c63bd878mr179300757b3.12.1750691934347; Mon, 23 Jun 2025
 08:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-30-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-30-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 16:18:43 +0100
X-Gm-Features: AX0GCFtRFJK6Gquz-1-GVq-KCUiOdNCn72ZmqsYU8ATwSbVLOyyeXrg5R0HDP2I
Message-ID: <CAFEAcA-A+4ukCbhPqsggKqcKPGV80FqiEub==ph5Ne=mvL=pgQ@mail.gmail.com>
Subject: Re: [PATCH v2 029/101] target/arm: Implement SME2 Multiple and Single
 SVE Destructive
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Sun, 22 Jun 2025 at 00:55, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sme.h    |  13 ++++
>  target/arm/tcg/vec_internal.h  |   4 ++
>  target/arm/tcg/helper-a64.c    |   2 +
>  target/arm/tcg/translate-sme.c | 115 +++++++++++++++++++++++++++++++++
>  target/arm/tcg/vec_helper.c    |   7 ++
>  target/arm/tcg/sme.decode      |  40 ++++++++++++
>  6 files changed, 181 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

