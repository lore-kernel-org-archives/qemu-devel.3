Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E757C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 13:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCfmy-0003kC-9B; Thu, 30 May 2024 09:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arikalo@gmail.com>) id 1sCdvn-0005yB-4l
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:26:51 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arikalo@gmail.com>) id 1sCdvl-0003Xo-K0
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:26:50 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-68197edc2d3so611332a12.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 04:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717068408; x=1717673208; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dwPOExy8G40EPnXA40Bht8ugnZhIVQVOwjOVYfQkrYs=;
 b=b2EQyX1ZS6eyqhHTAaS+Y1Svxs4QZ8MyvLjSH3VQtw8POsZUNAJxb1078J4F69x0wt
 qT8+OfH5VOt3cFVn3tsZndoob/7t0HQlEof5NypLasTW5LnwF9nMs9HpHzWwAkV20e2x
 ruj8Rj1jMM5rydnjMToGo8jK66/T08+wtNvPobvyQ2s+WWGg0uS2oM8Bu2CZdWhODFNb
 7viGS8MmRKMRp4vy+N2yunNmkuFvJIqcqg+mI9q1lg1C8+UYIW/7j44IzEtSIpDJ3E7e
 L2ARJYkZhtvE3ffglgh+zrofeD8fc3pbrR/QZtrpepZrG8p40kwKnxreqPzrI53CUB9t
 5xuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717068408; x=1717673208;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dwPOExy8G40EPnXA40Bht8ugnZhIVQVOwjOVYfQkrYs=;
 b=TMIbJtz4dDhUKRCqHGOWePm4te+JyePJTTW/noQB8FjpZK0IKk5MwrrfpS37xZaSQd
 lYnOUP+BgNb10e3K1J85mTHg7Wk6jypDwXYYl9HxceXtSwJs1rHz39U0SsSyYUXoVWxd
 eiJcLouQWYv5tj5n4fIHzyj1z2uMKD2HZ46rY2BFOLTku12sQ8pQHZPEu5aSKLNP8s1G
 wj7VAxtmkJCFn1V9Idb31aCaif8zxeLMiXOZlwEbdNvaAZQmaGUvZlny4JqMPtz0o0xh
 DCvwfShry3McYXiewB9K/8dcK6bCFHvkswCR9gxN0FxccS28JhX9S5lTb+5aPzL/Sf9f
 jo/w==
X-Gm-Message-State: AOJu0YzdeYe/n/f7+jfgtH9B9KZU/rkxQlz/INsOOk8cQM5fNnbtY3jp
 +Q40EErvouebbgi0zm7692dnCEmVE15suVzT4Nt7Q2w63ZrKB9+0g4kVViSEFcT9jU8EZMVyWWr
 K2Uw6YLfYu3Iyj6f/5o88VZDa2iY=
X-Google-Smtp-Source: AGHT+IHk8fIwx8b1ZsRIv8RCbkBVyoH0ibl0E+uwbodul/Rk+9SMXjRdv+KhHEyBkUWwq6/y0mWDSLymhwYGIdOajbY=
X-Received: by 2002:a05:6a20:a120:b0:1b0:106e:89c3 with SMTP id
 adf61e73a8af0-1b264520d39mr2237024637.9.1717068407695; Thu, 30 May 2024
 04:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240529155216.5574-1-philmd@linaro.org>
In-Reply-To: <20240529155216.5574-1-philmd@linaro.org>
From: Aleksandar Rikalo <arikalo@gmail.com>
Date: Thu, 30 May 2024 13:26:35 +0200
Message-ID: <CAGQJe6ooyqQFtuPtJxUk59cyf5aU8yLvJvtg_5wqBDR5McQfYw@mail.gmail.com>
Subject: Re: [PATCH] target/mips: Remove unused 'hw/misc/mips_itu.h' header
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=arikalo@gmail.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 30 May 2024 09:25:50 -0400
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

> Since commit e1152f8166 ("target/mips: Remove helpers accessing
>
> SAAR registers") this header is not needed.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/mips/tcg/sysemu/cp0_helper.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/target/mips/tcg/sysemu/cp0_helper.c b/target/mips/tcg/sysemu=
/cp0_helper.c
> index ded6c78e9a..79a5c833ce 100644
> --- a/target/mips/tcg/sysemu/cp0_helper.c
> +++ b/target/mips/tcg/sysemu/cp0_helper.c
> @@ -28,7 +28,6 @@
>  #include "qemu/host-utils.h"
>  #include "exec/helper-proto.h"
>  #include "exec/exec-all.h"
> -#include "hw/misc/mips_itu.h"
>
>
>  /* SMP helpers.  */
> --
> 2.41.0

Reviewed-by: Aleksandar Rikalo <arikalo@gmail.com>

