Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C55E77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 10:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVqEG-0000ue-Kp; Thu, 09 Jan 2025 05:57:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tVqEF-0000sV-34
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 05:57:31 -0500
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tVqED-0000AV-JI
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 05:57:30 -0500
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e3a26de697fso1069152276.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 02:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736420248; x=1737025048; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bHj4hLuF3y3ULgR5Uc6vUTiyHT/K9Q//sI3ccL3JdeE=;
 b=gmCcciUwp34MFFBIdEdjMH9dzRDdI+lf0NzolQLuYhVu2pkANsy+W+SwSDmlEPxvCs
 ZOoqx4r7UY+Y4b+ctttOWEOAXmvOzRjTHyoYMA21ZwhQXPRttTM4ehenrtGh3X/wRVP7
 RE+DB7sgwqyKZCukefRGrMobYAUr+ANKtsfUXDwAJLFonj5408EKZF/+VS1P7kPNXcW7
 cI3MIiNXJoXKK6lVvuSb7xGsu28v7OOmcC3s5aB9XsnYG2URXln9PXxSt3MTJd3QzfT2
 i3Ty6+XryMk+EL/e7cFUF607xYXJRrHlj/7aHuHk67JB1CjsQh3PU2ECt6SkCf5TkXYA
 yPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736420248; x=1737025048;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bHj4hLuF3y3ULgR5Uc6vUTiyHT/K9Q//sI3ccL3JdeE=;
 b=F1m+ZeJ5KyiFNzTmNcC9NySsXagnuoXDq/cxVON9zPPgwkFRDz9CnD33f3wRMBx5KY
 u7V7++vZ2n4JwTVKT7dkrJcCMNo9fknAwSnw8Wd94gFp7mDqJj7z57sJV5ZkHiYaeMCv
 4qpxgrozS4VBt1W0H02lR1J/yoMlB4S89ZFnwPCoVIshjWxvukdjml0yZJ+MK6k2aLRf
 rVH/RlrYRQo/G6CmfofK6TYEF2tAtk8DaT1yGxoXFjcHhYXULy2DFHl5Xz2YeFZAJbd7
 yn/lvyPyQlF7L+BeWjIjO0r6SjhEIT8eeVsbA0feZrSe2R2iZa7sYeevWdnfkbV8Y9+r
 BhaA==
X-Gm-Message-State: AOJu0YxK95yLWZI6exvCmQguV6z28mlVmr9WRe0iFE3FCTbtm9SPKhqp
 EuXrIjvijesAIFQ4+BAHFxemjG7gP2q7TqWEctipAL1f1beOFOlQ6s1TZxeTD4kldVV4Fo9/WkW
 byStWfwvtTLS2AGr0afxy5ZXPXO4tTXDPSF03AA==
X-Gm-Gg: ASbGncswuFX3paqaHTJhnlZ8IhGmhxAYfQrhJENb6rN2+Y/K4SrfE2537a37Zspd+4x
 xcRvIPwKSBe4pUes1//jsQR/hCduSQkghvF3mBGs=
X-Google-Smtp-Source: AGHT+IFPDhsY1f5fYN8UTs1c6wySCRGX4h+rdsaCJLX3s7uMJT2wIbKkXedhQ2FAR8WEJ62xLjU3jTbKXuo26oQqt6c=
X-Received: by 2002:a25:6a8a:0:b0:e4d:d319:b9d with SMTP id
 3f1490d57ef6-e54edf3a172mr3349097276.16.1736420248135; Thu, 09 Jan 2025
 02:57:28 -0800 (PST)
MIME-Version: 1.0
References: <20241218181511.3575613-1-alex.bennee@linaro.org>
 <87cygw9snv.fsf@draig.linaro.org>
In-Reply-To: <87cygw9snv.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jan 2025 10:57:16 +0000
X-Gm-Features: AbW1kvYdNmoc7BrTcSE-FT9fq4BSthFnB_OvF-FCo6I2GPMrDZF1h9va4GhLofA
Message-ID: <CAFEAcA9PBaHz1=Rix7nXZzHce6Ftb38bgS2H1rD2+mHnNvW-nA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] target/arm: implement SEL2 physical and virtual
 timers
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>, 
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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

On Thu, 9 Jan 2025 at 10:40, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
> > Follow Peter's review I've split this into a several patches as there
> > are some other fixes that should be made to other EL2 times that
> > shouldn't be rolled together.
> >
> > v2
> >   - split machine enabling into patches
> >   - rename IRQ
> >   - use CP_ACCESS_TRAP_UNCATEGORIZED for UNDEF cases
> >
> > v1
> >   - improve GTIMER docs
> >   - fix gt_recalc bug
> >   - address review comments for the main patch
> >   - cc qemu-stable (no rush for 9.2.0)
> >
> > The following still need review:
> >
> >   hw/arm: enable secure EL2 timers for sbsa machine
> >   hw/arm: enable secure EL2 timers for virt machine
> >   target/arm: implement SEL2 physical and virtual timers
> >   target/arm: ensure cntvoff_el2 also used for EL2 virt timer
>
> Gentle ping - I think everything is ready for merging.

It's on my queue to test and review, but I'm likely to be lagging
behind on code review til the end of the month :-)

-- PMM

