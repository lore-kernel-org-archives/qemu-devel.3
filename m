Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B5FCF6491
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2024 20:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sudyu-0006ZR-Fe; Sat, 28 Sep 2024 16:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sudyt-0006Yx-Su
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 16:23:55 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sudys-00010u-9t
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 16:23:55 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c883459b19so2106195a12.2
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2024 13:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727555033; x=1728159833; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t+pTS/s6KHkpoMPdFLyc8/xS6UifdCFVOny8tDwN01Y=;
 b=AN3srMVbfNNJ2r9tprbwoFFgMcvZC70F3kaNjENv20UAyQYustSiis8M8U7+ijYXB9
 g6Sq9SCtfr3H7WOrUDBSk+F5V6GJiMFpY5ikIEkQkhJGh30leq2P4nNP901AKJzCb6yl
 BAGHB8HYFt7Ib4NImxThgdMPuSPkuzunxY4Df/D2xw3Z4DVQjNcJbU0exhCFprYJ1JUL
 1ofAuUR3Y+gpAQrO2tsekIeKtUDRhlYY2Ww06+D88EB+/dYKeS/EqKFODsMIWep1ieB6
 UQOAowXgu1EXypAZUjhOEEFvPySoQrhniOjq787uvFgQfAnCq2V15fHt8Rzyu1ritKgg
 qS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727555033; x=1728159833;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t+pTS/s6KHkpoMPdFLyc8/xS6UifdCFVOny8tDwN01Y=;
 b=fc7qw/8b2BOjlFERLLXZoO15nEJoSnV2LY5V6aIjggVdbWPMRokPqel7r0rXdHjuq1
 ruZSdTPBpA+hbPStaSXIAPNBjs71XSePaR3kHaRG3QJu3EyWBsD0DtkulX5k8iytMSs3
 rs7+YDXPrtk+g04//p4Z/+44Etlb7j6wSdcP6/9U7P/occNiiDyRCZgajwPWf4A0ITEU
 QRKsb9+DqMDWR8KvYHhIiNGEWIOKnXpGnZF+SJhgoos6/G2BiThUBGRiYnTqV+kuOSZq
 yvXV3nJtJ6UNix2I5ME8XuldAyPey5XSuO6rWJ4qIzYhecxCW9nhZHOOukc6RYBaGCYR
 +5GQ==
X-Gm-Message-State: AOJu0YzmgbO2aFtc+lOn56aKR2RXNQBenci6OLWEOMkZW/aOi21SelaW
 a2gauGQWjI4mrRhTcM6rJfoYPXm2mQjJR/+wiiJTSb+Qq9I7RH2brT8gCdlJPEAGBMV09N/BV1E
 yEL83miqV0XIXx2oEL7EuAHW1M43cjDvz2Fs+ng==
X-Google-Smtp-Source: AGHT+IGnblQ5bsJMh2aWwO8a/3C65NMWDBkWob8wWwOeSazBgEII+8hSLeapQyF3X8X6cPAky4pxre/Zff0FrrXK7X0=
X-Received: by 2002:a05:6402:158e:b0:5be:d7d8:49ad with SMTP id
 4fb4d7f45d1cf-5c8825fcb70mr6121448a12.22.1727555032750; Sat, 28 Sep 2024
 13:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
 <CAFEAcA9Sb-fpNhm-6DPwss5zMpw=nEp31Wt6q1OA6DqCg3wKEg@mail.gmail.com>
In-Reply-To: <CAFEAcA9Sb-fpNhm-6DPwss5zMpw=nEp31Wt6q1OA6DqCg3wKEg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 28 Sep 2024 21:23:42 +0100
Message-ID: <CAFEAcA_8A=8q8aFSPwy177x6q3RLOS-kOHwyUDhTbpOjNjLexg@mail.gmail.com>
Subject: Re: [PULL v2 00/47] riscv-to-apply queue
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Sat, 28 Sept 2024 at 12:34, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 24 Sept 2024 at 23:18, Alistair Francis <alistair23@gmail.com> wrote:
> >
> > The following changes since commit 01dc65a3bc262ab1bec8fe89775e9bbfa627becb:
> >
> >   Merge tag 'pull-target-arm-20240919' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-09-19 14:15:15 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20240925-1
> >
> > for you to fetch changes up to 6bfa92c5757fe7a9580e1f6e065076777cae650f:
> >
> >   bsd-user: Add RISC-V 64-bit Target Configuration and Debug XML Files (2024-09-24 12:53:16 +1000)
> >
> > ----------------------------------------------------------------
> > RISC-V PR for 9.2
> >
> > * Add a property to set vl to ceil(AVL/2)
> > * Enable numamem testing for RISC-V
> > * Consider MISA bit choice in implied rule
> > * Fix the za64rs priv spec requirements
> > * Enable Bit Manip for OpenTitan Ibex CPU
> > * Fix the group bit setting of AIA with KVM
> > * Stop timer with infinite timecmp
> > * Add 'fcsr' register to QEMU log as a part of F extension
> > * Fix riscv64 build on musl libc
> > * Add preliminary textra trigger CSR functions
> > * RISC-V IOMMU support
> > * RISC-V bsd-user support
> > * Respect firmware ELF entry point
> > * Add Svvptc extension support
> > * Fix masking of rv32 physical address
> > * Fix linking problem with semihosting disabled
> > * Fix IMSIC interrupt state updates
> >
>
> This fails the riscv qos-tests on s390x. My guess is that the new
> IOMMU support has endianness bugs and fails on bigendian hosts.

I have also noticed that the license text comments in the iommu
patches are confused. That must be fixed before we can accept them.
(see my reply to patch 16.)

thanks
-- PMM

