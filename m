Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCD6C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 14:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd9cY-0002zd-So; Thu, 22 Feb 2024 09:00:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rd9cV-0002xl-Ay
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 09:00:16 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rd9cS-0000nf-SB
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 09:00:15 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-55a8fd60af0so11448345a12.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 06:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708610411; x=1709215211; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2hFGk6XPuUEhnSARm3LRyJ0MRKVV4i2hJYqf5akPQ78=;
 b=Je6RakzOkuEGo/qrfO8iz5lqrDPZ5oo2bRecHlt6ySpoMXb1ILBXkPwb+bFBSBQduf
 e+dh7OE+mKYOjEaUyOkqBe3PJ4ErWica23VzDa5VOD3+Bin3TIhkkRK5EzBcb7LVO6Cr
 ATUZPlhV1y+fXjQYW/OWurSXH3QEsXyBVoAXfV5JVrsRgQ+fZXgUr96gAaYiimR9SrB5
 uZA8v7FjAuwYU6wRHRYGhNcCqoD6eCZYYJEXK/q/MWtcHcSjJ/+UibB2ngB9y6EyZKpS
 fZ623VfM1EnPzyEXKOdfvM2n2bPdDVYde/B7F7J4QJicQowlaWAuN9YnyO/PdGH4TlAW
 hqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708610411; x=1709215211;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2hFGk6XPuUEhnSARm3LRyJ0MRKVV4i2hJYqf5akPQ78=;
 b=hDJL1xoTXodjixcYdDN/xb9Hf/DZq05zMuDdM0a54o/7QVDnS3YEi0vDVspa/P42r/
 3k8P1/1/mWOTtuOvRp5z5rCmXVtYnh/yzjM95vZMR4mEOnbJcqfLLpePQX7th4ixPhQ7
 oZ3AzQDD3J1M1AVzz5YUZxs1s3Er5aGpg/EK/5edTmwRxrAc/728jR0wt5TmWi3Tmd/C
 vFL2NHaOA7SDaIx2pVj7Dts+1iDYCZG5fL0Klc+qnaMMV7Ja+15roMivX7dvUZapNzBp
 iMYZNlm8c3g8Ls0zV4A2xOJh2BBWAULFAi2+vJwlUK/wG7J+IEoUBKxZgZpgfLaNSx/0
 QCSw==
X-Gm-Message-State: AOJu0YwC8PPOQlJn7eFuxlq0LsBO9XwBp1Zczt5DUcLd04QsJ/9BHMGN
 9M7lPd1UYTBFDBwjpRR6UY4E3zMwS946FzefaOzZawdNALmjODRJ6RbBgGfYiQk1TcBIUSNEUVO
 4++QeA1PRtsSBdHOMBebof9TPGDXnKSFfzV8b+g==
X-Google-Smtp-Source: AGHT+IEz5xwWf6y0i3/CGA0YIC2H2Y0FPuN+8vTzrFsNDF3Q9ZENm3eGQKygjLElxj/J+Omyjb1IIH0to5gI35lJ8W4=
X-Received: by 2002:a05:6402:176b:b0:565:396b:2c1 with SMTP id
 da11-20020a056402176b00b00565396b02c1mr1229669edb.8.1708610411221; Thu, 22
 Feb 2024 06:00:11 -0800 (PST)
MIME-Version: 1.0
References: <20240215160713.80409-1-philmd@linaro.org>
In-Reply-To: <20240215160713.80409-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2024 14:00:00 +0000
Message-ID: <CAFEAcA9C4WB6NZhs-i4pw-rruE4nDP-eJ2i1Q4CQ1inHicoe7Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Cover hw/ide/ahci-allwinner.c with AllWinner
 A10 machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Beniamino Galvani <b.galvani@gmail.com>,
 qemu-arm@nongnu.org, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 15 Feb 2024 at 16:09, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> This code -- which was moved many times around -- was added in
> commit 377e214539 ("ahci: Add allwinner AHCI") and belong to the
> AllWinner machines. See also commit dca625768a ("arm: allwinner-a10:
> Add SATA").
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---



Applied to target-arm.next, thanks.

-- PMM

