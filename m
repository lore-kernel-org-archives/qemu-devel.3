Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C9AC4828F
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 13:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWG3O-0003Es-Oi; Sat, 03 Feb 2024 08:27:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rWG3M-0003Ek-Vd
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 08:27:28 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rWG3K-0000Sd-3l
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 08:27:28 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-55fc7f63639so3423423a12.1
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 05:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706966844; x=1707571644; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BVH+S6PM3kvhs9uvwWKBe2oCg/7dsBePFdVK1RP/STU=;
 b=fFKomll374eh9CzDXceoVU+It29ALLuiVgSsmS2gkFI2wmqY8sozOO7LAnqPm/J8yK
 J1HfTf2229Byy0WxnS2ieD+ovxr0l/gBP9leP1kXQOzJE5OjRwQ9wApS7Pf8aukczPPw
 n81qivRRWcCu4iMBVY59ipNQLjJRY6ms9Q9qIvCaMl3NbzavDO1kGvkQGlbb0uN+ZXb4
 Qrd5lqePQ+If28LkcpMl+n6y8H7r8HIOPcRogMd6PJFjeDnIPYePd9TZB21SNM84e34T
 +yHHxBoFAdYqIajS/6g0Xu6Cv7gbVJ7V0c7dAusRhJZ7B650KRy1EhJ9B92w0qaObkwe
 6bHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706966844; x=1707571644;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BVH+S6PM3kvhs9uvwWKBe2oCg/7dsBePFdVK1RP/STU=;
 b=ceFXWiqTlf4+hnakEzVbsql/4oelCXjnzcxAj6h3X4dYVTbuK6rOG18pzwmszSClqZ
 WeSqbEMxdU4f90bnb9OP2q2OmZhNev1RFqfGHL+8bAKhCL9dnQdoxXixlXwgm26GeEW5
 Zejy0QXDoLFOIsVd4WOQ/1DBj2bG+X9Pc6fcGtACVtkWrSepoCKEqLEr4U1JeLlRIknd
 Sdh1INLDsrGlwGZZAFfWmG2iajI6w5HizwoyRAry/vYvCTIS3Fwbw296QVnqM2KaLwcs
 qrRxBOZAhTMpc3lnbIu9BgPDxlDbGonWlzCnAJQY6AsKPY/u6/BiqC8+H8pL9UFv3F63
 xN5A==
X-Gm-Message-State: AOJu0Yyzzpsfr+jB5/QrjZ0PKIsWhejQ7xb4JLMp0uB++e+wMojyVovw
 P1nXl0iOLxM2iR4hhPSGcKcBY/6zxCyiLYlNIG/XJAE/7VhYNM8nJ59IgODPN69Go8C1+kSvr+t
 e0iOxobSCeits+NcsThzOW7t1KvGeFjzYu+5t97VJwWVgr+PL
X-Google-Smtp-Source: AGHT+IFbhpfk5dSlNbFLByRjdVlh12BBUpGvvGN3CWz5uVLwlj1QkpL/XPrK1q+Hh07iTjhUSPRtdCcXkDnOO1x5df4=
X-Received: by 2002:aa7:d6cc:0:b0:55f:fb25:47d9 with SMTP id
 x12-20020aa7d6cc000000b0055ffb2547d9mr1705415edr.8.1706966844127; Sat, 03 Feb
 2024 05:27:24 -0800 (PST)
MIME-Version: 1.0
References: <20240202153637.3710444-1-peter.maydell@linaro.org>
In-Reply-To: <20240202153637.3710444-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 3 Feb 2024 13:27:13 +0000
Message-ID: <CAFEAcA8n8wbesEFRP9KUBKBqOhe1hj51sxD3dGf3h62JDVFHkA@mail.gmail.com>
Subject: Re: [PULL 00/36] target-arm queue
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Fri, 2 Feb 2024 at 15:36, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The following changes since commit c3709fde5955d13f6d4f86ab46ef3cc2288ca65e:
>
>   Merge tag 'pull-aspeed-20240201' of https://github.com/legoater/qemu into staging (2024-02-01 14:42:11 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240202
>
> for you to fetch changes up to f09c2b7ba9908714a3e2f1decd989462536cf731:
>
>   hw/arm: Connect SPI Controller to BCM2835 (2024-02-02 13:51:59 +0000)
>
> ----------------------------------------------------------------
> target/arm: fix exception syndrome for AArch32 bkpt insn
> pci, vmbus, adb, s390x/css-bridge: Switch buses to 3-phase reset
> system/vl.c: Fix handling of '-serial none -serial something'
> target/arm: Add ID_AA64ZFR0_EL1.B16B16 to the exposed-to-userspace set
> tests/qtest/xlnx-versal-trng-test.c: Drop use of variable length array
> target/arm: Reinstate "vfp" property on AArch32 CPUs
> doc/sphinx/hxtool.py: add optional label argument to SRST directive
> hw/arm: Check for CPU types in machine_run_board_init() for various boards
> pci-host: designware: Limit value range of iATU viewport register
> hw/arm: Convert some DPRINTF macros to trace events and guest errors
> hw/arm: NPCM7XX SoC: Add GMAC ethernet controller devices
> hw/arm: Implement BCM2835 SPI Controller
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

