Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77007C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 16:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk4zu-0003UX-OO; Tue, 12 Mar 2024 12:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk4zt-0003RC-0u
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:29:01 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk4zq-00022W-Ai
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:29:00 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d094bc2244so88154441fa.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 09:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710260936; x=1710865736; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ourPPBXgHsJzAv8BNAT3mWUg6FCmtfwZF1S8XNHaZ1A=;
 b=wWjO4hsfBEDeb4N7WmNXj5MQzxisKBkDqOupHWMfXn5rbNOwE6lfJmWz+1hfry7xbd
 sG2slsewVayCUTpOI4b3gZf+H0H79inqthI0uMwo/xAccln8S0B1OHApTJB3YMo7HKkR
 qY/YqssGD2CPwuw+GrpsuHZ6129QSctLli9eTJ1fowsx1LJ8b5l1KaBK3sCdyk+KIXAT
 8mFZGaPsCBk8DuXWVDVPAE2Ex8k454DWJrbCSUM0qf3OmP+rj9E9AQ1SferIr9Nbu7q9
 pEYut+yPKzwBA84mv2hDMcevgq+UKZR1RfHQbsnYUJvElc5HUJovZpHZH6fG9PAvQ7l5
 unSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710260936; x=1710865736;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ourPPBXgHsJzAv8BNAT3mWUg6FCmtfwZF1S8XNHaZ1A=;
 b=U7w3CfnEBac8nOd0vln84jYu38J45yedUtNy3TYMQhyMSpQtUEcTkgFKDIK/jYzvDf
 suAEE1BlIlVlvawix3IkLf56JC9gykWeS6KmIG+KkND6Z0dJD9BB+kKIQAlXnaxmWBmp
 fcYscV+k7JYXz4ys7ne70U5NSY7SmET/5O48qMg7WRmjVEHXyY6MYslBvEt0jF+QO606
 IZyhnlbFuMYQqXZOuKxJcaFez/Fii/zvuYDab3yU5hcm3Gt0boVJQxuJZb62ntQZPO2m
 BGPzRyW+lddTHKma0DeY0/MFempIJR6MkfYYIh7zWK2+qXePsGLvrz3iXkGbHKedwAv9
 YZOQ==
X-Gm-Message-State: AOJu0YywJB1Yd7Pc9/wO3iaysxJ/Tyex2Zl7ZBN2MofisXXCqs3UbpyH
 wFZosPDAzXLLKVkKdLH08A517XDj5WtdfPtQ0iauALPjBsOi2EpOAbnPuwmjnZGNXIGMPvQq0BX
 lRoK0b9Ib0pgwEuwXmBgKk4+cOJp/JJwhTo0ouEe8HpKvFPAq
X-Google-Smtp-Source: AGHT+IFAucfVR+ngFIwASocJVMMsArgAzYy5vy12NzQ8LoyqU3lWsL3KWK6hMRj2zP4BgDn2JThoWohYET8u2I/V1dg=
X-Received: by 2002:a2e:b527:0:b0:2d4:2651:1483 with SMTP id
 z7-20020a2eb527000000b002d426511483mr1681282ljm.35.1710260936150; Tue, 12 Mar
 2024 09:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240312082239.69696-1-philmd@linaro.org>
In-Reply-To: <20240312082239.69696-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Mar 2024 16:28:44 +0000
Message-ID: <CAFEAcA9+69CidzthzAZX8vxnwU5rF330icLCDyJ7tfWv=bb_oA@mail.gmail.com>
Subject: Re: [PULL 00/13] Misc HW patches for 2024-03-12
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, 
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x235.google.com
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

On Tue, 12 Mar 2024 at 08:24, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> The following changes since commit 7489f7f3f81dcb776df8c1b9a9db281fc21bf0=
5f:
>
>   Merge tag 'hw-misc-20240309' of https://github.com/philmd/qemu into sta=
ging (2024-03-09 20:12:21 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/hw-misc-20240312
>
> for you to fetch changes up to afc8b05cea14b2eea6f1eaa640f74b21486fca48:
>
>   docs/about/deprecated.rst: Move SMP configurations item to system emula=
tor section (2024-03-12 09:19:04 +0100)
>
> ----------------------------------------------------------------
> Misc HW patch queue
>
> - Rename hw/ide/ahci-internal.h for consistency (Zoltan)
> - More convenient PCI hotplug trace events (Vladimir)
> - Short CLI option to add drives for sam460ex machine (Zoltan)
> - More missing ERRP_GUARD() macros (Zhao)
> - Avoid faulting when unmapped I/O BAR is accessed on SPARC EBUS (Mark)
> - Remove unused includes in hw/core/ (Zhao)
> - New PCF8574 GPIO over I2C model (Dmitriy)
> - Require ObjC on Darwin macOS by default (Peter)
> - Corrected "-smp parameter=3D1" placement in docs/ (Zhao)
>
> ----------------------------------------------------------------
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

