Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D32FC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 16:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ridPU-0008QA-0g; Fri, 08 Mar 2024 11:49:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ridPP-0008Mi-3S
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 11:49:23 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ridPC-0006c3-Ph
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 11:49:22 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-568307fe62eso910863a12.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 08:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709916549; x=1710521349; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fnlbVSMPpB1kCKeMZkzCIPdEgio+rl8vlhNEleoaIkM=;
 b=VJmFNg+HG2tvQKT7tl15LfzkNOPxbPt122WUSEwwQnwcIvthFmUGduEgGBrItA8woL
 FijUSwQCo3y2zijNFzBft5TtbeHgR8jmweYpypVlrgRUKbc7taMwlzqgdjN0Zs18NJRv
 kduKAAD/xCCBg0HngonHfl8igucvLFKIV+sWoKfVilb7RMVdML9CyGOuszeOgtp/tF05
 mRfWDwTg2IQOMoCGc4AtPN6TX6P33JUpA8WCrTMS0BkTjYfHqIXTaOa9MIXIRyOiS5+s
 kfGh5ErX0Gf6yLHYBm9uCivS+1+EcZgdecG3rmSpQGSNidfPRnyiQcqIcM7weaKDwTpm
 nFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709916549; x=1710521349;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fnlbVSMPpB1kCKeMZkzCIPdEgio+rl8vlhNEleoaIkM=;
 b=u7ahxqgsF3lK0N7mqFRF5EWwmtdOjBPJGu8OF8ts/zBkMs5sWRWwz2opfRJ6TIK99+
 1AHNh39WlCC/PHlm6KhDEv6rii06QNyreSYlQsZEvEUFmOwY9Qp69sxyS5RECvArZciR
 w3HDCQFDosVoBX7NJgcVx9zQgAbb4nJc9b7HGcX8NLM9S5Q5aDGplPQw6euS7jTvABaK
 vGd6WVvZXZvxPd4b8HEcfcD7tVyl69rx1ZgL+QThefxx/zNGdMX7uezptugPrqfSmJzV
 zSzPtSqqSTUp9vqcug95qHIpPMfhaTe5PugKhDqHLmas4MHyBPvFzBGM3hWRIKb21j+W
 h6qA==
X-Gm-Message-State: AOJu0YzvWOKZG3rllLwNxfEnz2br0FCS16wvuL23RvBHhFF89IvdoU0V
 XdXNKMLUVGLwK63winqWiNnzqu3E1pJFUbcRpmyQc+v1q96BLa4L0HLFNfoCiwTIqExYVT8w/Qy
 x19mxx/ilNUbNGmRdQz6/MChaGdxD/LZN88rOqw==
X-Google-Smtp-Source: AGHT+IEeCldgLZdvtBQxeB5LsQLeWTxhhTBPTiskmhv/LuGmDAa66ItNvKOBAjCViv/UhvayJs/COcotPRul1CmJllc=
X-Received: by 2002:a50:bb41:0:b0:565:98c5:6c38 with SMTP id
 y59-20020a50bb41000000b0056598c56c38mr2392594ede.7.1709916549258; Fri, 08 Mar
 2024 08:49:09 -0800 (PST)
MIME-Version: 1.0
References: <20240308111152.2856137-1-alistair.francis@wdc.com>
In-Reply-To: <20240308111152.2856137-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2024 16:48:57 +0000
Message-ID: <CAFEAcA90Jjvcjn_wPkR0pa_BQvcFbjO0k=SM76aJo2pO0zp=ew@mail.gmail.com>
Subject: Re: [PULL 00/34] riscv-to-apply queue
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, 8 Mar 2024 at 11:13, Alistair Francis <alistair23@gmail.com> wrote:
>
> The following changes since commit 8f6330a807f2642dc2a3cdf33347aa28a4c00a87:
>
>   Merge tag 'pull-maintainer-updates-060324-1' of https://gitlab.com/stsquad/qemu into staging (2024-03-06 16:56:20 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20240308-1
>
> for you to fetch changes up to 301876597112218c1e465ecc2b2fef6b27d5c27b:
>
>   target/riscv: fix ACPI MCFG table (2024-03-08 21:00:37 +1000)
>
> ----------------------------------------------------------------
> RISC-V PR for 9.0
>
> * Update $ra with current $pc in trans_cm_jalt
> * Enable SPCR for SCPI virt machine
> * Allow large kernels to boot by moving the initrd further away in RAM
> * Sync hwprobe keys with kernel
> * Named features riscv,isa, 'svade' rework
> * FIX xATP_MODE validation
> * Add missing include guard in pmu.h
> * Add SRAT and SLIT ACPI tables
> * libqos fixes and add a riscv machine
> * Add Ztso extension
> * Use 'zfa' instead of 'Zfa'
> * Update KVM exts to Linux 6.8
> * move ratified/frozen exts to non-experimental
> * Ensure mcountinhibit, mcounteren, scounteren, hcounteren are 32-bit
> * mark_vs_dirty() before loads and stores
> * Remove 'is_store' bool from load/store fns
> * Fix shift count overflow
> * Fix setipnum_le write emulation for APLIC MSI-mode
> * Fix in_clrip[x] read emulation
> * Fix privilege mode of G-stage translation for debugging
> * Fix ACPI MCFG table for virt machine
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

