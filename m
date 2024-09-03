Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8FACD3448
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slWXQ-0002sB-25; Tue, 03 Sep 2024 12:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slWXO-0002nO-OG
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:37:50 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slWXM-000700-GX
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:37:50 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-374b5f27cf2so2675663f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725381467; x=1725986267; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4nkSogmG8EqlyWUOtW2AZGduld22wLpFVTNuCgxWRD0=;
 b=zj+gN3oULC+uPSTSspigI6Eml5uAAFB7LacZV61AFVYUNXGTY2Sh3LQoJMDwwT/HD5
 WABoqrDv0rtb5XTBLvFVqjpoMiYpDcAszUq5fgGHAgXE9fRa4FSezOgP9ETA83oKQK8/
 PpeF55EWWGLam5KpJSQ+U3smq3wS27RLSwrCisSQyyyaTqvQfb0UqjNTmnFFCkV7YN+W
 O0CyqXal33xb8FAoqDZb7kLcaS8au62OmNvH8gk1SxLh44s92xRAHzFqET3i+a7DSo+1
 nRLWjYKpFaHfAeBHroj9AwK4rstkOPNlBZf9Ur1Eybv8RmnkaejbeWVUgEg3M6RzLcKW
 wTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725381467; x=1725986267;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4nkSogmG8EqlyWUOtW2AZGduld22wLpFVTNuCgxWRD0=;
 b=kU/BNnIhX5/xXZBuWfbj3Ct8gY78oXdD/LnSQ32zt2XqsjLbqpXa6Ye7ogvZHoUWwg
 8zWQVJf5fuNBJ6b5xfCxfORjRYIxNpFqukdogMPdCiPFrRU7TysOhnU0b1ZELuxvUxe4
 JpDlZtEENaucXvED9UI3kq5zRNDfS4mqsnBqRQ84zch7NRiUBgV/a3dbISQbrkFLva7f
 cpJ3x/rKq9SDn3ndMKf/Wvc9XKeA7Mm/J26REDmUJrH7rK6u+czVvPMdK7mLY98qVmWT
 Vl6wsnmysf94xEXiQixAMSndnYbtt7aQuNF1/kSquy11B1SaY9ldKARhNzFkZCcP10Vw
 OcFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5UfUlbKcgqfl13XITIbqk/Ak1sUHx1Dwswf7btUJVaecoT6Awm/0gUPUZusap9+qLNEZ2AjnnZ5oa@nongnu.org
X-Gm-Message-State: AOJu0YwBX91tiqQs8N4mgNKALNedlRdV0DSJ2NGSie5AJ5UC1xGgLjLF
 e6zw/ZvGA8iAKu4Hh8rmve30QleS18sBwwPbPCS7fxFRmtbkR7MhNVA86p2c2EcOfeQQh4Wtktj
 72EgT/UIr7bVGPBdXVz9aWBmKWX/tzEB7L4VSIw==
X-Google-Smtp-Source: AGHT+IG1gKliWGlQ3Hwbqj0R5Sc7Bndg26M/nbxPBIaIbsrafGCz0q6JOsMCX9DZ6eXQGWzaJXhDyMVJJdGBCKTeXzo=
X-Received: by 2002:adf:e98f:0:b0:374:c287:2afe with SMTP id
 ffacd0b85a97d-374c2872bf0mr7397571f8f.56.1725381466585; Tue, 03 Sep 2024
 09:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240828005019.57705-1-sebastian.huber@embedded-brains.de>
 <CAFEAcA-p+CBeKTgH-YXzrATKDpwG5iY+A3WGaVkbEeHCXxTzug@mail.gmail.com>
 <ZtF9P_QtnH1nAYuu@zapote>
In-Reply-To: <ZtF9P_QtnH1nAYuu@zapote>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Sep 2024 17:37:19 +0100
Message-ID: <CAFEAcA8Lv_9nW7GwHwEdc-CQb36iRC0hx5X75BC_cjR=sVGuUA@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/xilinx_zynq: Enable Security Extensions
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

On Fri, 30 Aug 2024 at 09:05, Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> On Thu, Aug 29, 2024 at 01:50:02PM +0100, Peter Maydell wrote:
> > On Wed, 28 Aug 2024 at 01:51, Sebastian Huber
> > <sebastian.huber@embedded-brains.de> wrote:
> > >
> > > The system supports the Security Extensions (core and GIC).  This change is
> > > necessary to run tests which pass on the real hardware.
> > >
> > > Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
> >
> > (Added the maintainers to cc.)
> >
> > Does the system have any secure-only devices, RAM, etc?
>
> Yes, on real HW there are but I don't think we've modelled any of it yet.
> There's TZ both on the SoC and also ability to create FPGA logic that
> can issue secure/non-secure transactions. Here's an overview:
> https://docs.amd.com/v/u/en-US/ug1019-zynq-trustzone
>
> The primary use-case for the upstream Zynq-7000 QEMU models has historically
> been to run the Open Source SW stack from Linux (some times from u-boot)
> and up. It's important that we don't break that.
>
> So as long as we add additional support without breaking direct Linux
> boots, I think it's OK to incrementally enable missing pieces even
> if there's not yet coherent support for firmware boot.
>
> In this case, IIUC, when doing direct Linux boot, TYPE_ARM_LINUX_BOOT_IF
> will take care of the GIC setup for us.

Yep, that's the way it's supposed to work. OK, let's enable this;
it's the beginning of the release cycle for 9.2 so there's
plenty of time to fix any problem that might get reported
to us before release.

Applied to target-arm.next, thanks.

-- PMM

