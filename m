Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E79C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 09:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2STk-0002qU-54; Thu, 02 May 2024 05:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s2STg-0002ix-Hl
 for qemu-devel@nongnu.org; Thu, 02 May 2024 05:11:44 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s2STe-00020y-I8
 for qemu-devel@nongnu.org; Thu, 02 May 2024 05:11:44 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-56e6a1edecfso11468050a12.1
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 02:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714641100; x=1715245900; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DURPCI2/FY/kY/gJ1dO6gfuyLlZsIlgz5xq6p4O8Elo=;
 b=b/5OIuxn5fnCxSFBXVOX4YpbVlLaVHd4JVMrKAa6gzZNeZXEzRlIbTRnR7e8FZPTmc
 kcqCdnwGgMtz4tdtdu59bZMUBeIrM2Uku+u+cqAqdC2tPGD1+rpeHMbMAxSeDtwwGO0y
 r+0sfQtLT8/SW63SUrHDsWMgs56WobyZ2PlsOmujjnL9jmyvV1ZVBRH1hjQiWZhQgW5T
 8qMsCrCHTd9h/y9qMpvFQbMz114YOH5xc8Qz7SCN7J4GXzvDwup6XafUr9vDIrHftPLL
 i30e6bZpnOsKsRyYEDYihT5xyjMrfx2BPvIRVU3kZMmX3e/BEdcTfgjrkRSakRzc9NOZ
 6UfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714641100; x=1715245900;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DURPCI2/FY/kY/gJ1dO6gfuyLlZsIlgz5xq6p4O8Elo=;
 b=SCOgLaiMKu+zU3vZjRlU7VahctdWq8J5zBeW7zLVWP2JJv838c+OrG4uSkoXFzlJYd
 WPSwK0Ilh12KvesuncLNlsSwGQ2O1yiiTIjTRiCKveK/tuj69W3V7W/bvoOvMMZrQfkY
 aKe5VIGdKbSWV3ysXGggdLt5r9YnS+rclExtWYgmnaeMbeakrCSBE1bMgVxQLNr+/PDX
 Qn6FQhGqRydrPQ6zM89HE79YrJmvOhYdfl5fTd6FyVQf0EUnmBNM99sx48wlaACZ+9xc
 mRu1V3s757edFoRRLD5a5jXxuVoTvx1IVEQ35YdVnqKqov729m8QVCOtjM5cfWTF+GfC
 oLtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEWQuYUHVDflqmVsKaCNSP3kPrgudbZJXL1742b/fR0M0uJrYu0vSO1MSFVjwIQwpmItRZoCK1ocxaVTIsJGrRFeNx8GI=
X-Gm-Message-State: AOJu0Yy/yfBnExzKRdejyNxiBXVXJQoVI8RWD3Fp0KqEn6r3SkeYDxAp
 jQYpEJ3FOcndRIAwV+RHTlJY4bd3K4Q1K9qJ3UBFitC05YI4HUaEpHSHX1I8bdAxvASPG/NbtVn
 y8po0pfOXBz+RCgWpf/c7hPxXhaX/azPxYVuJMg==
X-Google-Smtp-Source: AGHT+IEx12QEjWXPqpRvcq7d1SN3mgfGG3OGEpRuIDolu4ctRzThPuOqyp+Z1nEtu/+LJp23ZUOvc/aNiGO4jIm5nUk=
X-Received: by 2002:a50:d6dc:0:b0:572:a126:6760 with SMTP id
 l28-20020a50d6dc000000b00572a1266760mr3670342edj.11.1714641100203; Thu, 02
 May 2024 02:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240419183135.12276-1-dorjoychy111@gmail.com>
 <f397f267-06d9-46c1-8acc-1c9ebf9c3773@linaro.org>
 <CAFEAcA8i_wU+RSRk+D1L8YKy72zHz4YFV20r2Z7m+3ARfzb51w@mail.gmail.com>
 <CAFEAcA_kHDGWVic=xRm4xOsi-cQC-fF5Z2FWRCrwe_E35KBmNw@mail.gmail.com>
 <753b3a55-9589-4dcb-b656-8b3025e847df@linaro.org>
 <cb2d4f21-8853-47af-a78f-e0db65460f46@linaro.org>
In-Reply-To: <cb2d4f21-8853-47af-a78f-e0db65460f46@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 May 2024 10:11:28 +0100
Message-ID: <CAFEAcA_aN8ntxKuGPJ=M_Y3dLNjYEV-v--wK1hK8PyOxKSt=zA@mail.gmail.com>
Subject: Re: [PATCH] target/arm: fix MPIDR value for ARM CPUs with SMT
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Dorjoy Chowdhury <dorjoychy111@gmail.com>, 
 qemu-devel@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Wed, 1 May 2024 at 19:08, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> W dniu 22.04.2024 o 17:21, Richard Henderson pisze:
> >>> For Arm's CPUs they fall into two categories:
> >>>   * older ones don't set MT in their MPIDR, and the Aff0
> >>>     field is effectively the CPU number
> >>>   * newer ones do set MT in their MPIDR, but don't have
> >>>     SMT, so their Aff0 is always 0 and their Aff1
> >>>     is the CPU number
> >>>
> >>> Of all the CPUs we model, none of them are the
> >>> architecturally-permitted "MT is set, CPU implements
> >>> actual SMT, Aff0 indicates the thread in the CPU" type.
> >>
> >> Looking at the TRM, Neoverse-E1 is "MT is set, actual SMT,
> >> Aff0 is the thread" (Aff0 can be 0 or 1). We just don't
> >> model that CPU type yet. But we should probably make
> >> sure we don't block ourselves into a corner where that
> >> would be awkward -- I'll have a think about this and
> >> look at what x86 does with the topology info.
> >
> > I'm suggesting that we set things up per -smp, and if the user chooses a
> > -cpu value for which that topology doesn't make sense, we do it anyway
> > and let them keep both pieces.
>
> Aff[0-3] are 8 bit each. On those cpus where they exist.
>
> So "-smp 512" (maximum allowed for sbsa-ref) would need to be split to 2
> clusters by 256 cores or 64 clusters of 8 cores each like it is today so
> it is backward compatible with whatever assumption firmware/OS does.
>
> But if we go for 'newer, better MPIDR_EL1' then maybe it is time to set
> U bit [30] if "-smp X,sockets=Y" where Y > 1? Or when NUMA config with
> multiple cpu nodes are setup.

The U bit is a red herring here -- it indicates a property of the
implementation, not of the topology. It is an almost obsolete
bit that might have been useful on 32-bit cores (eg the A9 had
a UP version and an MP version; we only implement the MP version,
and the Cortex-R5 sets the U bit). I think any modern CPU will have
U=0, whether it happens to be the only CPU in the system or not.

> Also a way to know which AffX fields to check on firmware/OS side would
> be nice. A57/72 use Aff[1-2], N1+ use Aff[0-3]. Sure, it can be checked
> by going through cores, reading then MPIDR_EL1 and if 7:0 has same value
> on all of them then check Aff[1-3], otherwise Aff[1-2].

I think the answer here is "guest software doesn't rely on the Aff
fields to indicate topology". See eg this patch from back in 2020
to the kernel:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20200829130016.26106-1-valentin.schneider@arm.com/
(now kernel commit 3102bc0e6ac752cc5) which notes that the amount
of implementation leniency in the Aff* definitions and some of
the odd stuff that has been shipped in practice means that you
can't get useful topology information out of the MPIDR (which is
why we provide it in the ACPI/dtb).

On the QEMU side I guess we should strive to set up the MPIDR
fields to something plausibly matching the topology as defined
by the user on the command line. Unanswered questions:

 * I guess we need some kind of back-compat thing where for
   old machine types we continue to report the old MPIDR
 * what are the constraints on the Aff* fields (eg that kernel
   commit suggests Aff0 shouldn't be > 15)?
 * should user attempts to eg ask for a topology with threads > 1
   but a CPU type which isn't multithreaded be an error?
   (What is the existing QEMU x86 practice here?)

thanks
-- PMM

