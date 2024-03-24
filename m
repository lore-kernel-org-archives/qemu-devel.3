Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51732C47DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Mar 2024 19:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roTmz-0007le-5l; Sun, 24 Mar 2024 15:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1roTmx-0007ko-P1
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:45:51 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1roTmw-0002DO-1x
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:45:51 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56a2bb1d84eso6623183a12.1
 for <qemu-devel@nongnu.org>; Sun, 24 Mar 2024 12:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711309548; x=1711914348; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N2JsNotPsxrW+11ThuWn1EOfLxqHr2RtWo996k/wJHk=;
 b=iAaKCvZ1Xf10Bcp2+e0ZQjymbIINdZvqEnkIgNp+PQotmZIxSpqLbqJyyvIiACZocP
 FXqsIIu3d6rRq9DDqPc9f3urhiMck7J4SsXV5xR3ZT1gHFmN3PCxhte4zNUw5uLIrsSD
 L3Je9D//Zuv0a/eGTDsHcjSY36friQ0ITx2J/Usi34kmIJXtlKU3e8BZYZUIaNAYxPfj
 cCYpzT9VSBBylk17Bb2nyZkA8YVKNei/XgvCmxUk1CTdyrS3Pv+OXhDsilB2++G0n8yZ
 nj/WI9X4DhwnJ6+oau741NLDOkpM/KIACrX0XEFLLxiLqKTYR/9F5KNRCzIyF3NAmgw+
 mf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711309548; x=1711914348;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N2JsNotPsxrW+11ThuWn1EOfLxqHr2RtWo996k/wJHk=;
 b=jLpNfc9MW3byXu9zaKS6pslqhtEntMnisPgVFWwVYb4/n0uLyiGw7pqcUk38wMEno0
 CMJf974YfLXodTvOKWpwP7EbYckmJq8LR9lPUSxb+xsiHJI/ib2wNzDEa1aATgE0Sh/K
 jJoV+EZPtbIzZ4LTONlKxrBKu73sfMJLB47COJQlOCPbWNskrAASoDFtjXLH1R4tp2M0
 5Tc/MJhXL3qdi5DHnI7fY00oywZ7jSBYvTpU/uXKcR5cT+F6Kt11hxwYHiUhNADtLJ1B
 1C+e6VlsnRwKLBBWIA5xibVxJur+29O3FCRnBI5lu6BFWZRJb8sPXzCra/zH/LmWvslS
 I3TQ==
X-Gm-Message-State: AOJu0YwD+saa4J6Alu61EI6O0Swq84vfujzOYh7L8uDMi9TQ7y1oj1op
 yMyefn3NicLacYIrWcwosIFjlph3uo7QyupOQAOlfxT7y7l/yL0UlCNKYz+YWwkrTYJ96wirty2
 GKVN0ZsP0rvq9e6nLzvuSETgAKgS3TlpxBjF8LQ==
X-Google-Smtp-Source: AGHT+IHmPaiLgN25rN8RifcETYY9CLkocn/OH7qT6Mca+Xvcc8A3R8VQbWqbFvgiKA+9tlr6P7D8wvuJJ8lAGB9AOdA=
X-Received: by 2002:a50:cdd2:0:b0:566:624a:9e3f with SMTP id
 h18-20020a50cdd2000000b00566624a9e3fmr4202972edj.3.1711309548263; Sun, 24 Mar
 2024 12:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240324161148.4650D4E601F@zero.eik.bme.hu>
In-Reply-To: <20240324161148.4650D4E601F@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 24 Mar 2024 19:45:37 +0000
Message-ID: <CAFEAcA9-UUOpC56d=N8T=2ELZAS7s2eqmMv0L+QVSGLp6odAEg@mail.gmail.com>
Subject: Re: [PATCH] docs/system/ppc/amigang.rst: Fix formatting
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Sun, 24 Mar 2024 at 16:13, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> Add missing space to fix character formatting where it was missed in
> two places.
>
> Fixes: 623d9065b6 (docs/system/ppc: Document running Linux on AmigaNG machines)
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

