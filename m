Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7B1C54791
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 17:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdChJ-0006ao-Bk; Thu, 22 Feb 2024 12:17:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdChH-0006aQ-Km
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 12:17:23 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdChF-000180-Cm
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 12:17:23 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d2305589a2so131551fa.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 09:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708622238; x=1709227038; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=APtQ1w4RyEN4SoAmVY3OlRegokxIVcpkwFrVOmRN52w=;
 b=MfluM/aQR9s0fMhyKvJcC24e40MS9KougjkIOdLl0zLvf8Xntvl3OSbD1753AfiX8i
 pOJW+LZgIhH/gZyeVNkhLNuqWRwOLlSHnZcby3bDOa6xW/HixOChX+JogmUEFpEmZ20H
 S5E05HbzIBtoVXWuVDoZez+qXviSWEKzLB91d5kDWV8kkUvzchIsBTeGcsIk7IF0tD3m
 KxADo6tv+51MLKS5P/R7w/ba8yNZc4UX76qdJFZdjtgWUVPihW1ddTIQof28i475jS6l
 6xsbxaCKmIYfXcJtJvT7JxJYrhLVkcdPRtNpsDg9a86eX6HeNo85wLk6XEGA7zzi4o9x
 lC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708622238; x=1709227038;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=APtQ1w4RyEN4SoAmVY3OlRegokxIVcpkwFrVOmRN52w=;
 b=c/fVqJ5nTwHA+CUQp1rz6+6Bc+r7ObIYHfrBeESGwOnt69RpdCw3/j45kO2mZVHk+A
 Oy43Ii1amONnsV8V10ul9JpsfPAkDZ8jJ7F9wMoadCDmZ3EOtrGoqZdS54xI3fX3tPGr
 ENUUV0Pl/7s5/VL14rTRGxRHHc/VpT25cfJyBH0AK8TZX7CF0XA470PiFwc3A5JFluFk
 VFefPFdNlNq5U2pYGJ1atpUgnBxOljHeRWb7oqbU1sLQYrp5Ho0SfBnAw11kKfwObHV/
 FEcmUpBQwFKBFgKRZyusK9h115YwgGQxFsZ1KrXSSIbJ1Z89XxnTug69AHtusrl4Av+Q
 mY5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+v2bo65je3EZcmsCcD4FaVdkW1rhOkjkrmISIi39f65115NbeD4enqQRjRmydVD3vmJkcABpWZ0Srelybqvb9DPz9CGw=
X-Gm-Message-State: AOJu0YxSf2qP1M+SQo2NXHThLgNt1Geg4MB7p7wf4V6lMfFVklGZ8qyW
 GRXG+I8WRQF15BpV/mYu9xnk9ZUWlOhQkgX0c2a9USf4bTJ43U2HrbfjHXPWUeBo7qaXPTOPfLM
 VPBQ+GWa1lHfANtQblu8SM1gJByzlYcJIocPO+A==
X-Google-Smtp-Source: AGHT+IFPqb4wNkeD96R/ZnFSrXtMWhOiemHby6TV2nmDSfhyDnznRUtPAzbppDaiSuFTygnvPuJCT65Ycos9ocq9Vdc=
X-Received: by 2002:a05:6512:131d:b0:512:b187:ae0a with SMTP id
 x29-20020a056512131d00b00512b187ae0amr10414137lfu.6.1708622238063; Thu, 22
 Feb 2024 09:17:18 -0800 (PST)
MIME-Version: 1.0
References: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
In-Reply-To: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2024 17:17:07 +0000
Message-ID: <CAFEAcA-Wir3M7dVV5247uMPxCtrYs8j4Z3S7nucCx3Ha8pA1dg@mail.gmail.com>
Subject: Re: [PATCH v5 00/41] Raspberry Pi 4B machine
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x229.google.com
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

On Mon, 19 Feb 2024 at 01:19, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Introducing Raspberry Pi 4B model.
> It contains new BCM2838 SoC, PCIE subsystem,
> RNG200, Thermal sensor and Genet network controller.
>
> It can work with recent linux kernels 6.x.x.
> Two avocado tests was added to check that.
>
> Unit tests has been made as read/write operations
> via mailbox properties.
>
> Genet integration test is under development.
>
> Every single commit
> 1) builds without errors
> 2) passes regression tests
> 3) passes style check*
> *the only exception is bcm2838-mbox-property-test.c file
> containing heavy macros usage which cause a lot of
> false-positives of checkpatch.pl.
>
> I did my best to keep the commits less than 200 changes,
> but had to make some of them a bit more in order to
> keep their integrity.
>
> This is v5 patchset with the most of v1..v4 comments fixed.

I reviewed quite a lot of v4, but I don't see any of
my Reviewed-by tags in this version. Did you really change
every patch so much you had to drop the tags?

thanks
-- PMM

