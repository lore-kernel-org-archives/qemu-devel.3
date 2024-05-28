Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240DDC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBzEK-00034l-9d; Tue, 28 May 2024 11:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzEI-00030Y-Ne
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:59:14 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzEH-0007JW-79
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:59:14 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a5cec2c2981so51115666b.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 08:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716911952; x=1717516752; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+aNaF50Jev88tg3uWX+xblCjhz25t6A43YeKwNEzfGk=;
 b=NYZY1gqqOM4wsi0qZotbSusLCih628cCg8rGmJDJO5Aa6RS8zcaSr5dN8Ms5zJIwGQ
 YueL8Tlm4KJVzZrN+mDOYCW+h+BiBZZpOzeYBloz/s853H+duuE+A+aFYiIERPCU38Yw
 Qt4fPhwIhrNRWzBq+LAmDKEWhb/NWkeMFc8CRKhi+RHya0koM+7xG+OzurwpSbivuAr7
 8Cd6wgMJbYgduh7Vcxv5CTci4veMKS68wVmAqxXHLkWU6dTrDgZx6ZmDqw2Vr06iIJpn
 XFXktGyfODfrKxbPOeXZIM+DtiSXA06Y5q09qGjYctIa2rKktSXGQpdwKA+fcF0AAyOA
 dE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716911952; x=1717516752;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+aNaF50Jev88tg3uWX+xblCjhz25t6A43YeKwNEzfGk=;
 b=TLlAu+3UUWr5oLajhJlppcw0f9PkgUj0/7ZZbYrQrMhV8SB5gYtpBCh91uT/il9puw
 XuLeAiwuLaF+MZv1ACoZH4+qs8SeB0VVMfU762SgGiw0D/RKXxwddhET/Acaq51jk25v
 5ZxnTmTrpMdJXzyY5uC32308foj1X+fJ+ryLUc9eGmV6G4hn6TdGi6lQMroO14zWRsB0
 Lvxqw7I9PkeWVP6HaZG+5Wvl2JragHY4I0zoo7KS8KB0zpxrA5i6ftvg6pA48Fav5p8d
 ha3RI8+3kjLtPtd9M59p6+psNTZOCL2p06EqJE0TsTBgcy2Qqo3EXFZFhmQYSLeCD3To
 V+4Q==
X-Gm-Message-State: AOJu0YxnvNKcpHsQUEx0WkrKt6XetZiFM65tQWKBCZmHIOVNeEtmmfNy
 kFPZsGHiwV5aHdDvvvD6T91dJ+9DmnszeWGpUBAlvrBhJ8BuyomCe8Miz2h53vTRYMD6g7TNnjw
 UcDxhJOHxy3kAmuR8IDQPXz3r2233uM5dpTPw6g==
X-Google-Smtp-Source: AGHT+IE/DjyGiTOfTcfMrxBugtvNlJfWT6Rjap2QhLfMTYU1i7w2r1LkKo12rf4tAEvHOAb4AOxI3GTU3CEn124xs7Y=
X-Received: by 2002:a50:9318:0:b0:578:62a8:a5ef with SMTP id
 4fb4d7f45d1cf-57862a8a6damr8244698a12.8.1716911951604; Tue, 28 May 2024
 08:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-54-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-54-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 16:59:00 +0100
Message-ID: <CAFEAcA8gWk0H7kR20JHB86XYps9TMNtY6TUKEcZdXAnqSq4++w@mail.gmail.com>
Subject: Re: [PATCH v2 53/67] target/arm: Use TCG_COND_TSTNE in gen_cmtst_vec
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Sat, 25 May 2024 at 00:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/gengvec.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

