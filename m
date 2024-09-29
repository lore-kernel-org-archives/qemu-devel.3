Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB65ACF6495
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 15:39:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suw0e-0005dK-9J; Sun, 29 Sep 2024 11:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1suw0b-0005cX-Ge
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 11:38:53 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1suw0Z-0002rg-UG
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 11:38:53 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a8a789c4fc5so794467466b.0
 for <qemu-devel@nongnu.org>; Sun, 29 Sep 2024 08:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727624330; x=1728229130; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8w/6NR/Hyr0i1kMu618YopQITagJnncKr7G0aPrq6Hk=;
 b=g9WOcdUqnegnzJKQdDOjlxvAur1xJ9tCUxMzy4CiFfjLkk+Z5S2fLMfU7uo1Ebt6Fm
 uNDgAqfvPH9Iy4wOnnr4fHm9/53XscAlZwFavwLE6f/Si1LdaWUuRbfXrMq4KDt5tLrO
 XgSxIEeOYqCvfh2rv/73/I9saRmeZ66jNBSOA6SkgBxsVnwukEwCiqGNfgQvkjHvN/xf
 dD1SsD2Pi35ilVpKa1ycBybs1n5AeKQWIkx55WUKDgnPKlMOtEXFZKNzJ64WTN/Ui3iV
 YkD882iXq637AMK/MzoVmybsMfR/LTaOdzTL1dxlOsB9vqFdfHgOTGbLtkCtwIq06wT3
 KnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727624330; x=1728229130;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8w/6NR/Hyr0i1kMu618YopQITagJnncKr7G0aPrq6Hk=;
 b=CGPZqZFK8wrKt00VjSoirFAcA5IUdjkWBE4zfY4+JMl38//Hmx8hJsWsARRhRK8ZFc
 xAxP3dZAudalzbdRndRH5UySrG42tvLPuhWPN5Y45NHnwRorEueFBbSzAtd9M/+sOY7j
 yFI5Gca1+o+VAEvnOfPLMhdDAxLyMHsL+6HJGWBklZBy9yPMERWTlmAs383Wx+lwAImN
 Cz4eF3tt6Q8F5+5odIOihyYT+l29DD+38yx77K9aAHUQ1R6yv70lGQgc5VRMEhwgeiu2
 biMK6XXkmMd9276+knepqOZPExh/BHvyf3ho8Zy87lzcUJwJmQWjTiZ6bAYnwEQCRrnM
 ktTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAp+qXlGEtntbnfQ9RKRopQLCq/hHSDEYdV4ZK3OGF54R/w3knldCQy8921SmV2N4QttemDKJDrceX@nongnu.org
X-Gm-Message-State: AOJu0YzyWwXLImlCKNC/8amvupz83WVc5ymqca+3ZmMYS0sUCB3iiZ23
 lKqnAOTp0rJj3hIEePXUjyPPOmJ2DkS8I8Qb/g99aa4Uf1MY/8a3Ihc/pPXD4eMBb/ZdDIK6mmq
 JgCLx1yitml8gGmHMy4QCMnNAhn3/qgEyLon2UA==
X-Google-Smtp-Source: AGHT+IGkPQ+khnKWAMJ8LlKweJ2STbNOc7QcDMILUu64AaguX+hMlnTpO+k1ov/ofmbHm1QV6BLRPzC9ZnEACuD7hiU=
X-Received: by 2002:a17:907:9496:b0:a91:1592:f5c5 with SMTP id
 a640c23a62f3a-a93b15d399fmr1267709866b.10.1727624329808; Sun, 29 Sep 2024
 08:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
 <CAFEAcA9Sb-fpNhm-6DPwss5zMpw=nEp31Wt6q1OA6DqCg3wKEg@mail.gmail.com>
 <13ee9889-b503-45ea-a074-ffafbd052c4e@ventanamicro.com>
In-Reply-To: <13ee9889-b503-45ea-a074-ffafbd052c4e@ventanamicro.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 29 Sep 2024 16:38:38 +0100
Message-ID: <CAFEAcA_nn2fUyo9Pkd8jW2NG1oJLbAJrfiC7sziuhGthqL3=4Q@mail.gmail.com>
Subject: Re: [PULL v2 00/47] riscv-to-apply queue
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Sat, 28 Sept 2024 at 21:40, Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 9/28/24 8:34 AM, Peter Maydell wrote:
> > The assertion failure is
> > ERROR:../tests/qtest/riscv-iommu-test.c:72:test_reg_reset: assertion
> > failed (cap & RISCV_IOMMU_CAP_VERSION == 0x10): (0 == 16)
>
> The root cause is that the qtests I added aren't considering the endianess of the
> host. The RISC-V IOMMU is being implemented as LE only and all regs are being
> read/written in memory as LE. The qtest read/write helpers must take the qtest
> endianess into account. We make this type of handling in other qtest archs like
> ppc64.
>
> I have a fix for the tests but I'm unable to run the ubuntu-22.04-s390x-all-system
> job to verify it, even after setting Cirrus like Thomas taught me a week ago. In
> fact I have no 'ubuntu-22-*' jobs available to run.

It's on the private s390 VM we have, so it's set up only to
be available on the main CI run (there's not enough capacity
on the machine to do any more than that). If you want to point
me at a gitlab branch I can do a quick "make check" on that
if you like.

thanks
-- PMM

