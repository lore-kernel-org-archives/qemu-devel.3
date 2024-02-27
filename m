Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0744C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 16:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rezx7-0005Vj-9F; Tue, 27 Feb 2024 11:05:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rezx3-0005Se-Ae
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 11:05:05 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rezx0-0002sv-FV
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 11:05:05 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d1094b5568so51020741fa.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 08:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709049900; x=1709654700; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=adtmBOcP+29W7dZmFXERayPMGxwMBowqt+9qJZbAajA=;
 b=dA+sN5kRpww7Yd3e3aR4bNTgME2eHhLLgPVpVDRaOr1mFMXBxXTKK3lOX+Q5Ad4zKm
 VH5tATatTJuhJrR4VG+R/sVBEhtLhGzhje9crk+LwSBmdnC2Loj5LV+uN26qluVH4sFa
 HQvK4ji5WGN7g4iOxXPeNJw8ewZzW/ttWlcT7AuZcr3ImtPplalkYPcb7rgBkCj6GHND
 HL1Pe74+f6K2fnMcTpePHmgwbd1m7ip0ZimRct+Z2YwFXQYepMF7Kswx/kXqDc7McLx/
 4eFCcKlKruNGR6lHvfnmPAl11PcN+DCNg1b7wGaK8lTDUGr3UGZXK6c5FrwFWq9j1c8M
 rM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709049900; x=1709654700;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=adtmBOcP+29W7dZmFXERayPMGxwMBowqt+9qJZbAajA=;
 b=iYJT+/2+xG++3sTzINyvkXbRJ8/RIGtxWkN/RH6oY8oe3R95lJ9awd8a36trO/aATO
 xFzFJAzs93CHLnAN22ocE2hAjKjs1aIkBjueNFviPRZ+kvkKKG0meP88eLNJ2doIBkhM
 e1ZLHNK+Z2/652iXq3JwD3cRRVeE+iHvN4kz3c/bIuPN9yHv/YgBt/8RK1NZkYY+wc5v
 j0U6oov87MEjLZJlTEinhHMO04PTEPETgt3tdjO3d8KYU63uRPZbxpZhkBdW12dGcZoE
 sGCeAvVjwjgBR/urkzSf47icTprHgA5mb+SryDZ+ygTGXxhiPeu+CFhMv6ucGDWUKnAt
 F6yQ==
X-Gm-Message-State: AOJu0Ywy3+Gt11/UD6DOeJcRPhDO3Oi7xUs6QnISmbULoq8X3z8Pgba/
 K3PR+aay6q8Ja7cPGtRY3Io+XSmW70CZaT6otsQZ+YhzOWQwgYayAygnjwBbrQFiiLGxFHPpWKK
 IzVB3SfX2mU2jncnDJJEOq+8tRJknn+1NB7FEbw==
X-Google-Smtp-Source: AGHT+IEyCcu8kmW4ZainAQ2YEsCQq7zTIpuanFDV0x5xkiU5yYQ/plaD751j+2ZjkMbVQB2JYNGEU7O6xpTP5YTB6U0=
X-Received: by 2002:a05:6512:acc:b0:512:f892:7f0c with SMTP id
 n12-20020a0565120acc00b00512f8927f0cmr5042714lfu.38.1709049900098; Tue, 27
 Feb 2024 08:05:00 -0800 (PST)
MIME-Version: 1.0
References: <CAEEPdR4v8G6CHDCCO-fLcWs-iBqoyKTGQzio_C0P-1ur0vgX0w@mail.gmail.com>
In-Reply-To: <CAEEPdR4v8G6CHDCCO-fLcWs-iBqoyKTGQzio_C0P-1ur0vgX0w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2024 16:04:48 +0000
Message-ID: <CAFEAcA_h8OCgRhUefGbH9MR=JxUhW_Py6BhbWBa5DYzNA0kLxg@mail.gmail.com>
Subject: Re: Does cortex-m55 in qemu have PMU?
To: Archith P <archith100@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x229.google.com
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

On Tue, 27 Feb 2024 at 15:55, Archith P <archith100@gmail.com> wrote:
> I am trying to run code on mps3-an547 (QEMU Emulator)
> and want to check if it has PMU (Performance Monitoring Unit)
> Enabled.

No, we don't emulate the PMU on M-profile CPUs.

> [I am getting PMU value from  ARM_PMU_Get_CCNTR() always zero]
>
> I tried using the QMP command query-cpu-model-expansion
> Is this a proper way to find out?
> {
>     "execute": "query-cpu-model-expansion",
>     "arguments": {
>         "type": "full",
>         "model": {
>             "name": "cortex-m55"
>         }
>     }
> }
> Gives:
> {"return": {"model": {"name": "cortex-m55"}}}

No, because we don't track individual processor features this way.

> Is there other way to find? Need Help.

In your guest, if you read the PMU_TYPE register that will tell
you whether the PMU is implemented (and more specifically, if
the CC bit is set then the cycle counter is implemented). For
QEMU it will read as zero.

-- PMM

