Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2D1C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 14:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roku5-0007Pe-B4; Mon, 25 Mar 2024 10:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1roku3-0007Ox-GR
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:02:19 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1roku2-0003rr-2Z
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:02:19 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5101cd91017so5251029e87.2
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 07:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711375335; x=1711980135; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7aQrNjfmrXLeV7ouaPEUcZ7moCumB/669nRzEkBge/Y=;
 b=NQbdOV90L8f+yH5hkFEtbn5cWwesPXlhIdvrpqsk/4iqjrYJxg3ztCqzPoCGyV4ce9
 0MtWmp47q5YdZ1G9ZA1JHzvKOcVgRtgI8wXbMpX2xvpof/Q3jKsoGFMGtWKbOW8mHKaj
 0ElEFmWaCSuUyL/JOIc22RLMwXJyTVQeLkGk3rydQVXLPP5xbgM/DU0kB/KseGd0JjXu
 Sq0oReS+46OcwH8I7UdCFSEPfG/3iKJEriNAhYkO86WUp3lLw/VWSjoRxBpdCwbtbP2B
 i66LXQ5v7UsnW6P4VbKNPpF5nJND8JWMZoTq8ODyh9pvkBYI26oy8YkgnV+KUeG55Bgn
 nvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711375335; x=1711980135;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7aQrNjfmrXLeV7ouaPEUcZ7moCumB/669nRzEkBge/Y=;
 b=eEII7OLRoJdx7K93LSDOpfYh0cpZCgpiILVELQFb1f9IUnzAISX6yHWY1d9wkiF2Kk
 AC86HAfHbLjFcuZyZioUK1eBYUKBQMay/0NZXs+5oOlUf6R+v+DCMV+L+B5nTIDCHRT1
 OVWSzNpiYs05zGES2GRt/H2fZLfJsNR+BdIMHu7+UlsBm0k+58JkrVH62BxXw/EGlGUm
 ZCul/n3r9nhU+/3MnmlWvSUGB4KMIbdIaG7wb+HTGD1podT8QW3Jk2IxHpM+mpm03XRV
 w0D5rKHThJKm1o3fMMf5Vn6aEyny2G/uf5I9X3uW/N3ukdlNgv7OlrzeDo/eCq68Ismw
 tRIA==
X-Gm-Message-State: AOJu0YyDEgSE43Sx/o3O6Cle3bP0CTDQ6RlarxAlP89X1PB8JeeFBkkH
 WSCmunHBhVUT9jd2h8ZxXQMkX4sTW3bwPkwmEqqBal3aRG6QCCHUCFomA34ghIhQH3l8foG2P5V
 lX0XCUT3K+yX9jlMmgbdik8r8ooAbZ0bnalRoVw==
X-Google-Smtp-Source: AGHT+IGLlromjL4Nh6DVoDIuOcO6AGeTl7EenSGInTGJChC51ow+qpYLXugs1tdSd45lHeA5fzFdpz4YVXzlRCkXTAo=
X-Received: by 2002:ac2:4992:0:b0:513:cd2e:ceb1 with SMTP id
 f18-20020ac24992000000b00513cd2eceb1mr4201832lfl.48.1711375335462; Mon, 25
 Mar 2024 07:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240325135906.1372946-1-pbonzini@redhat.com>
In-Reply-To: <20240325135906.1372946-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Mar 2024 14:02:04 +0000
Message-ID: <CAFEAcA9jZQ9UB1Fpi-rMjra1Z63HKa9V=Et0X0UpgJy9Or2YuA@mail.gmail.com>
Subject: Re: [PATCH] pc_q35: remove unnecessary m->alias assignment
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, cohuck@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
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

On Mon, 25 Mar 2024 at 13:59, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The assignment is already inherited from pc-q35-8.2. -s

Missing signed-off-by and a stray "-s" in the commit message :-)

-- PMM

