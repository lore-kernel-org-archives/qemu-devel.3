Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7546C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 17:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEWb4-0005dK-NW; Mon, 12 May 2025 13:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uEWb0-0005b5-OI
 for qemu-devel@nongnu.org; Mon, 12 May 2025 13:05:44 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uEWav-0001bx-QN
 for qemu-devel@nongnu.org; Mon, 12 May 2025 13:05:42 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-7082ad1355bso39874747b3.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 10:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747069536; x=1747674336; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8HTNP+Dz9uUBMvSkat76DOjyJL5YwhYIaJa66H/oiLI=;
 b=IjzfS+Iktd4qoOF2MVgiv8/K23WpT2k+MNuqlYddpKWm+dK6fH/qgWiaOxNXSy7ypE
 8RqMbEbqJpeBzSFo39EwMruL4fuhHhzyis/bCjPO7Fj89+LehmalI0ZTFEnhM4xzikft
 7bY+GRfVcNR+Ig5Jo3IHRyjQrQRPO8yax4iQyW1rpfUsDuohIP6L24W852ZLV+oqlAeq
 E5R2vxtzx9lPmfJE+0TxRG7aR0GSnmJ/q0ENtykUi1kvylEzY4Nzzrs6NZATWcaGvhp/
 DJTf2eBQpq3XeGaJ+TmJfA6hm5TnaZ/O+woSjdWEWp92DR69RdC5fEwy77JPPA7AQD7N
 0djw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747069536; x=1747674336;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8HTNP+Dz9uUBMvSkat76DOjyJL5YwhYIaJa66H/oiLI=;
 b=VbugXcY692ud1zom8+q58V8Jx+bdQkP7zNb0oghU0fN9s7xN5gLDuXjWT1E0IAgwID
 HYU8qTgPuTBwzYlljt30rzs7Y24ZrdX89RV6SkAoFwDE3tBxqDmO7ftgv8FP2QYm4LKt
 2Hbf3vkmLScaUZl7JBbR+HOJ4pXvEUXokUBwF5h+7qg3lGBHr+7gxdwoVu/3eR0FpU+/
 fHSA6zNDr2JmRBpn8VYbWOppEw9A9Fz9+37tTIIRFZkaiCsVnD/kZKOBg76ccXRzkOvo
 fDw3OXjSYSwIr3yqtyIjXvrQLl1NAr3TUZwQGGc3lqAFCvCoLviUjvFyHE0v9w9yxIc+
 yCLw==
X-Gm-Message-State: AOJu0YwSULkn8gwBhlEc4MLjLNNJ09gHPskB55v5Yp+9YOfd00MjL2hV
 ltWZ0NP2RC9qzl53aeBTTAELUxYbAB/Np+pnw6aOsOuLjJ1YUIk818pNFDWSSf9C7qwd48E+AMy
 yu/0OMdWQM3JmTuhYHgjnBmccJ+knWcFCHEGebw==
X-Gm-Gg: ASbGncuNpTJLcoCfJ2AN1AtbjSV0Os6PFF9zk6z1Oh3Ph7CIKVovjTwqsBlruxvVZMu
 kQgHW+qRBmtshuY98RVG7kFLvSemr0ND/6JBEwvKYEuqZJgIxnWrIBngWe3IBeHgUUdVm0lnK5x
 n50eoMisu/3wDik12rz68Wx5N3w5NtmZasew==
X-Google-Smtp-Source: AGHT+IHJUGXvU7eSQD629soUCAbI1o1OOEKe//YGeeBupCFFNme9TLnTnur0ZOEMcwQ6PGCg+MVCB1198KhwGVBMoSE=
X-Received: by 2002:a05:690c:6181:b0:709:966c:b648 with SMTP id
 00721157ae682-70a3fa1fb5bmr187347917b3.10.1747069536192; Mon, 12 May 2025
 10:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
 <CAFEAcA_NgJw=eu+M5WJty0gsq240b8gK3-ZcJ1znwYZz5WC=wA@mail.gmail.com>
 <726ecb14-fa2e-4692-93a2-5e6cc277c0c2@linaro.org>
In-Reply-To: <726ecb14-fa2e-4692-93a2-5e6cc277c0c2@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 May 2025 18:05:25 +0100
X-Gm-Features: AX0GCFvvctnEj9SSRF9WiDdOiktBdw5JBrK0houKTahMILYX6RROtZ1LUTlNoCA
Message-ID: <CAFEAcA_WtAAba9QBS_zOPUPtjdeDv+0mDJiTEepHS2+61aZERA@mail.gmail.com>
Subject: Re: [PATCH v7 00/49] single-binary: compile target/arm twice
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, anjo@rev.ng, 
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org, 
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 12 May 2025 at 17:53, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> Hi Peter,
>
> On 5/11/25 6:40 AM, Peter Maydell wrote:
> > On Thu, 8 May 2025 at 00:42, Pierrick Bouvier
> > <pierrick.bouvier@linaro.org> wrote:
> >>
> >> More work toward single-binary.
> >>
> >> Some files have external dependencies for the single-binary:
> >> - target/arm/gdbstub.c: gdbhelpers
> >> - target/arm/arm-qmp-cmds.c: qapi
> >> - target/arm/tcg/translate*: need deep cleanup in include/tcg
> >> - target/arm/tcg/cpu*: need TargetInfo implemented for arm/aarch64
> >> - target/arm/tcg/*-helper*: need deeper split between aarch64 and arm code
> >> They will not be ported in this series.
> >>
> >> Built on {linux, windows, macos} x {x86_64, aarch64}
> >> Fully tested on linux x {x86_64, aarch64}
> >>
> >> Series is now tested and fully reviewed. Thanks for pulling it.
> >
> > Do you/Philippe have a plan for how you want this to go into
> > the tree? I know Philippe has been taking a lot of the
> > single-binary related patches. Let me know if you want me
> > to pick it up via target-arm.
> >
>
> During the release code freeze, we mostly used tcg-next.
> However, now everything is back to normal, we simply work upstream, with
> a simple "first pulled, first in" strategy, fixing the occasional
> conflicts on our respective sides.
>
> So if you could pull this, that would be appreciated.

I had a go, but it seems to depend on some other patch
or series that isn't in upstream git yet. Specifically,
the changes to include/system/hvf.h assume it has an
include of "cpu.h": you can see it in the context in
patch 2:
https://lore.kernel.org/qemu-devel/20250507234241.957746-3-pierrick.bouvier@linaro.org/
but that include isn't there in upstream git yet, so the
patches touching that file eventually fail to apply cleanly.
I assume that's "accel/hvf: Include missing 'hw/core/cpu.h' header",
but is there anything else this series was based on?

thanks
-- PMM

