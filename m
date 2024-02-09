Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38727C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 18:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYW4R-0002Sj-EG; Fri, 09 Feb 2024 13:57:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rYW4P-0002SQ-Ex
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 13:57:53 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rYW4N-0002QU-RG
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 13:57:53 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2d09bdddfc9so14849081fa.2
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 10:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707505068; x=1708109868; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w5tjkzD5+dT/pEawdBPPKkooZploLqHu869R7Wt9kyY=;
 b=E7looAsma2fktAAkBZyvCMibTaNnFTj4o1WYr5HVZbjCCUKbpaGZ79Z6gbrm4q/6It
 Vl/jEXRuHw13rkbyqLeql8lqfYN9nKQDqB4epnufchgu5vmipV9UttdhAjVxa/biNQ6p
 pGIgP8F/MGReIf74scTV1DeC2CiYqryP/gWl0mI0lwVLq1FLdllIvCOCqT4fFGDm7nXZ
 nVO78PGjrefxyEDmOqNOA69Lw68NSkik1IFPlcBkxcGCl3sr4aupzTa6DB13eKdIiie9
 9Xk5keff6zY0Z4P073NaQ9fgpMhu854i/4IW6VVGaX1sTTERmeU/JhbizoHIoBW847z9
 4tWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707505068; x=1708109868;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w5tjkzD5+dT/pEawdBPPKkooZploLqHu869R7Wt9kyY=;
 b=AJ1/DMw0dzseJcz7QfmoA6Vq3NXHETuyNtWxbtqMkxw44C6OHfMTIcruGHD/OLSFYh
 Dd1tGmGs2u/Gg76/SHOycJKMXz5Nt/TADs7W+IVW04GPTLq/Evp3/lbtx5ihz3txKenJ
 82AAxGgeNmKEDxheS2BBT7tyGDAmMpe2aYUOwKV1IvodjJMusWYbHf8rHRpB5FIegi+B
 tZ1ljW2z0sgrV4nlNCZZVAu0fdhvy1MmRvQB74MpNK9mtMaWwdHdHvTbxqv7YUMx6WuT
 bMPPoVG74N3XLKPTSn/gEhDJAcs3uInDUfXBUWFszgXucEqHdID1MvbkKHbGhEs26CPx
 LhFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXKASkq8bqnZ/QhLrysoBkXpZ49Zd9YmWEzzAyT3Gpq0jq+ldmTiNS1ciaafj728A4PJLPF4ryJMbbXkNHTG1fGdx9JNM=
X-Gm-Message-State: AOJu0YzUSO1Hn3aK++bT+A3/+rrqTSNc9/DMXPuHWszlGCBV90mLRiH1
 KOAkVh3enpjebalQ+mtEhopjJUKMGtpGlibqM64E+EFN5WQADh4OPz7Ub2pCaZ1uPJGdO9l4gi6
 2ufvJjE4cF+zVBpV2P0nZwtAHtEdYp8IXrfykIA==
X-Google-Smtp-Source: AGHT+IEwUtWrReVoSqs7fjCm31w7VsfZSxZCG0AER52vw5/s4vZy1dhbYG9wAbszpTjPqAtOYoMZWbmadRmWQr2qoYg=
X-Received: by 2002:a2e:900b:0:b0:2d0:d054:17df with SMTP id
 h11-20020a2e900b000000b002d0d05417dfmr1778421ljg.42.1707505067670; Fri, 09
 Feb 2024 10:57:47 -0800 (PST)
MIME-Version: 1.0
References: <20240209160039.677865-1-eric.auger@redhat.com>
In-Reply-To: <20240209160039.677865-1-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Feb 2024 18:57:36 +0000
Message-ID: <CAFEAcA_SFtmCCFBPwWjJF3uygdpdqoZuYLaQQP186fyQ+dJEHA@mail.gmail.com>
Subject: Re: [RFC v2 0/5] ARM Nested Virt Support
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 miguel.luis@oracle.com, haibo.xu@linaro.org, richard.henderson@linaro.org, 
 maz@kernel.org, gkulkarni@amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22a.google.com
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

On Fri, 9 Feb 2024 at 16:00, Eric Auger <eric.auger@redhat.com> wrote:
>
> This series adds ARM Nested Virtualization support in KVM mode.
> This is a respin of previous contributions from Miguel [1] and Haibo [2].
>
> This was tested with Marc's v11 [3] on Ampere HW with fedora L1 guest and
> L2 guests booted without EDK2. However it does not work yet with
> EDK2 but it looks unrelated to this qemu integration (host hard lockups).
>
> The host needs to be booted with "kvm-arm.mode=nested" option and
> qemu needs to be invoked with :
>
> -machine virt,virtualization=on
>
> There is a known issue with hosts supporting SVE. Kernel does not support both
> SVE and NV2 and the current qemu integration has an issue with the
> scratch_host_vcpu startup because both are enabled if exposed by the kernel.
> This is independent on whether sve is disabled on the command line. Unfortunately
> I lost access to the HW that expose that issue so I couldn't fix it in this
> version.

You can probably repro that by running the whole setup under
QEMU's FEAT_NV emulation, which will be able to give you a CPU
with both FEAT_NV and SVE.

Personally I think that this is a kernel missing-feature that
should really be fixed as part of getting the kernel patches
upstreamed. There's no cause to force every userspace VMM to
develop extra complications for this.

thanks
-- PMM

