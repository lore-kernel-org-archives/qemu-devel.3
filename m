Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA78C54E58
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Mar 2024 14:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjK18-0001Y6-Oq; Sun, 10 Mar 2024 10:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjK14-0001XL-Vp
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 10:19:06 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjK0x-0005QG-GR
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 10:19:06 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2d26227d508so51838411fa.2
 for <qemu-devel@nongnu.org>; Sun, 10 Mar 2024 07:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710080336; x=1710685136; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9iknqVKgMXEkktv3Drr+1eISgvd3sJtI/KmNu18WBSI=;
 b=lZ3hLPnFkeuNbPnmh8+vXzdFwRj03OsZ131YgDyCHqo4ZPRn3CobMtANtbnW7WLuid
 SlwSMFCW4puTWuOBFEiXA++aekCZxW3CTwQmLbzRDw7kfNQpZKLZXzkp9ODm7PtHvGKp
 mAaPEG6nNO/RyQoDA67587vm0Nh3EmWyDp/HuKyr1VL8DROUBtCTE+X28cjnXqyliTYj
 B+DSHTIUb7xEtgy4PCYBCnfFTGtzYOAlLXuJOvTcCfygdCt+tw0yF5rmu7YjNpStVTIO
 3r9xSVbFYM9dMbSdiUZddcYNydwkS6zXUKjLb/64ZJvEFBvjMVUI0DaRlIkR7F2NVKJB
 GU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710080336; x=1710685136;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9iknqVKgMXEkktv3Drr+1eISgvd3sJtI/KmNu18WBSI=;
 b=DcbYA0HgI2SPEZaUtq9ZXjOeM+tl88UXLnS674L7cOxsAfJ+rzRN7qFC+NWHsaIIm4
 OnBrsSYQqe4vCvmyaTIovC1W9XiCJBMswxjaxhaSi7tQr8NNNzdhkK38lgIWrBYDzgmK
 Njqx3i1y+Io/9zsH35297/Fm9EcLW5nwkQbZrBb+zqqZBeo8RoWqXFEYYv40M0hvB4Bj
 9JeV/ca16IPGlKl83r1rbcHRSxZ+/AZV+R0KgpB/antYCaq+6++jOW24tE8MeAU5rscJ
 Sh1o5opEBO65L8F0boKk0o91zL3133Kv4bQtbIYy1+RQGPpqi9FvCgSpFYtkWgK2Gzu0
 XiJQ==
X-Gm-Message-State: AOJu0Ywl4NFiyBX3qWL3y3NIsO+db/OfC673B7x/2/FzETFNhvwRYa5F
 iY8YNnbPTgLt2mxZLszIRoT9KhwR7OV/UbHhuIbXDB/U50dTi63gNF1UbRnaqgEz7APGPX4Gw9W
 hAN7MM5Y8PlM6MtdJnidjyQeQcUFGLubsbk1WErhnJPVkCXZ5
X-Google-Smtp-Source: AGHT+IGvUbtbCMUutW8lgVaX/SbjytWREkeE7MKbVGbnw32tr8gSHOE8o06HTLmHj6Q2UMFVtA0YgGBXmVz2ODCoeLk=
X-Received: by 2002:a2e:8e8d:0:b0:2d3:a9e1:e559 with SMTP id
 z13-20020a2e8e8d000000b002d3a9e1e559mr2607104ljk.41.1710080336480; Sun, 10
 Mar 2024 07:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240309192213.23420-1-philmd@linaro.org>
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 10 Mar 2024 14:18:45 +0000
Message-ID: <CAFEAcA91G5ZWdKY3b92ENqxd0hC9umJ6GxCO1cRLZn9pA47YqQ@mail.gmail.com>
Subject: Re: [PULL 00/43] Misc HW patches for 2024-03-09
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22c.google.com
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

On Sat, 9 Mar 2024 at 19:23, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> The following changes since commit 84644ac1b0f80d41b8a2f66547b83b2ad4a985=
76:
>
>   Merge tag 'darwin-20240305' of https://github.com/philmd/qemu into stag=
ing (2024-03-08 18:19:25 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/hw-misc-20240309
>
> for you to fetch changes up to d3c79c397484ad117063702e6246e39f22f020f6:
>
>   hw/m68k/mcf5208: add support for reset (2024-03-09 19:17:01 +0100)
>
> ----------------------------------------------------------------
> Misc HW patch queue
>
> - hmp: Shorter 'info qtree' output (Zoltan)
> - qdev: Add a granule_mode property (Eric)
> - Some ERRP_GUARD() fixes (Zhao)
> - Doc & style fixes in docs/interop/firmware.json (Thomas)
> - hw/xen: Housekeeping (Phil)
> - hw/ppc/mac99: Change timebase frequency 25 -> 100 MHz (Mark)
> - hw/intc/apic: Memory leak fix (Paolo)
> - hw/intc/grlib_irqmp: Ensure ncpus value is in range (Cl=C3=A9ment)
> - hw/m68k/mcf5208: Add support for reset (Angelo)
> - hw/i386/pc: Housekeeping (Phil)
> - hw/core/smp: Remove/deprecate parameter=3D0,1 adapting test-smp-parse (=
Zhao)
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

