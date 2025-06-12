Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC76C61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 15:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPk1W-0006tT-NS; Thu, 12 Jun 2025 11:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uPk1U-0006t4-2T
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 11:39:24 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uPk1P-0001AR-6z
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 11:39:23 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-710e344bbf9so9809557b3.2
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 08:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749742757; x=1750347557; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JXT9+xCu2kLTPNMjKZBijcIVT4PBIX3CMqzxcmCHJhc=;
 b=OamAyD1uYayrae+Laow3X0++iEM43kutygkZHPP8XANoz7IKJV2FJKjkwNiENBlC9U
 0+7P26ce/0Yi+lLUO7r7UeijiUZEGB7EbVkvZISHjdTDpMhIH58bz+HEGqspXn+Js3Pg
 DLs2mlz2/z04rHO+yC1W3idPHeDH18x/toVMdOrt5YyKb3Ql6uQv5iIKs3LZhOG5M1MT
 dkhTdotOk4eoiGC9K3DYJdjk1c4kEL6I/AKQVb6PksUDOHAPMnclkwm/nVE008zhRg0X
 5SX27eR07TlWc1T4H4JLtBJDuq2+NptLNHZmJ51lAouXg7/JhQ512jLXYzHjGuPVyh9k
 TSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749742757; x=1750347557;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JXT9+xCu2kLTPNMjKZBijcIVT4PBIX3CMqzxcmCHJhc=;
 b=rqhHEHe7UuNiE12mcoEGo4y+yfdU8wuYQUjgTOvJm6bmViGPkaB7KcVow2hawnY2+e
 O6Dl1zCxVkkxYnklxsbTzf6/ilkmo2/HLtNIT1MsHf2m3tkQRPd9c2pJFDmEs1MoRjdP
 mRxzkiC2JPYaSTcaCOzwVs3lL0D0rIyP/KaeXPRUqnVFKzMKD1BQ5kWOxcaSdFLf6gg9
 k4eXlJvrqSqZPOAJ76TlQyoeAldvktRNBfpjpRqbnU2a9SLKIrCGkblxWWR92gMit8a1
 iufkoNZuQZmL1H6Pky8dQyZ7XxcDduPSqZN0RFOrUPTtyggW2lQbR0AOxMPfdy5mcEgQ
 eJOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpkeWQyuaDuUy27Wst6wqssG47t8GFCV8kh5fNfStJlSvHWWVluzWV5MuHIiCeKF/THpHQ6PsOsSd6@nongnu.org
X-Gm-Message-State: AOJu0YwXzNIudDM4tcQGMNmJ0pQ8VytyFUTFPZHq63E0nRDAr4H+lAt0
 0Ha3/H1eYTuCd8FG6MsXmfFkmOjhgjH37Hz1GewmCZvoBaAsk4Z6bSbYEXEkcZsriUHDjFLDm1z
 b223l1NLqDMq/zE2rNmXztbaxUzh87Qa7RjbsDYXZqg==
X-Gm-Gg: ASbGnctcB2RPqdR9WJGGrZ0raAeag6sJgG/JmeybMUpXd9+pY7S+R6h6cbDPyHhxl6H
 tIe/IsTprB0CV/XEuqvvoJJiulvX7A0WPYJG3bA5R4c8cjuxaH56XwZ3dLmb/gNIJ9HWvLlEiPG
 DGr8uvVB3x01UFZWALveQoqEo8gpgIkU6DDvmGXsLmn5on
X-Google-Smtp-Source: AGHT+IHlkIH86GpFkBYLnTKRfBrIjt+QS7YNu/3E5ZRMJuF1GJLPYhHPNq89j0URmxtX1O2VULTTrxcSXSpqiX18NXM=
X-Received: by 2002:a05:690c:907:b0:70e:143:b827 with SMTP id
 00721157ae682-71161e26ee3mr5727027b3.8.1749742757338; Thu, 12 Jun 2025
 08:39:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250515153907.151174-1-cohuck@redhat.com>
 <20250515153907.151174-9-cohuck@redhat.com>
 <CAFEAcA-c=EaE-Y4DMVz_meVd2cbxuCyFGFOXET-COOgMWHXWWA@mail.gmail.com>
 <87a56d9dlb.fsf@redhat.com>
In-Reply-To: <87a56d9dlb.fsf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jun 2025 16:39:04 +0100
X-Gm-Features: AX0GCFuzI2YyCIMD8vpl4ErMfb7p-rmxq7r54GM8puuwIMjmPs8pzpmH3mOQeEs
Message-ID: <CAFEAcA-rYNaaZ3LFFkhek0duptPeMXUBbPbBnWa7teNPM+c6ug@mail.gmail.com>
Subject: Re: [PATCH v7 08/14] arm/cpu: Store id_isar0-7 into the idregs array
To: Cornelia Huck <cohuck@redhat.com>
Cc: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, richard.henderson@linaro.org, 
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev, 
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com, 
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com, 
 agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Thu, 12 Jun 2025 at 16:36, Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Thu, Jun 12 2025, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> > On Thu, 15 May 2025 at 16:40, Cornelia Huck <cohuck@redhat.com> wrote:
> >>
> >> From: Eric Auger <eric.auger@redhat.com>
> >>
> >> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> >> Reviewed-by: Sebastian Ott <sebott@redhat.com>
> >> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> >> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> >> ---
> >>  hw/intc/armv7m_nvic.c     |  12 ++--
> >>  target/arm/cpu-features.h |  36 +++++-----
> >>  target/arm/cpu.c          |  24 +++----
> >>  target/arm/cpu.h          |   7 --
> >>  target/arm/cpu64.c        |  28 ++++----
> >>  target/arm/helper.c       |  14 ++--
> >>  target/arm/kvm.c          |  21 ++----
> >>  target/arm/tcg/cpu-v7m.c  |  90 +++++++++++++-----------
> >>  target/arm/tcg/cpu32.c    | 144 +++++++++++++++++++++-----------------
> >>  target/arm/tcg/cpu64.c    | 108 ++++++++++++++--------------
> >>  10 files changed, 243 insertions(+), 241 deletions(-)
> >
> > This doesn't compile:
> >
> > ../../target/arm/tcg/cpu-v7m.c:70:5: error: incompatible pointer types
> > initializing 'ARMISARe
> > gisters *' (aka 'struct ARMISARegisters *') with an expression of type
> > 'uint64_t *' (aka 'unsigned long *')
> > [-Werror,-Wincompatible-pointer-types]
> >    70 |     SET_IDREG(idregs, ID_ISAR0, 0x01141110);
> >       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ../../target/arm/cpu.h:875:26: note: expanded from macro 'SET_IDREG'
> >   875 |         ARMISARegisters *i_ = (ISAR);
> >          \
> >       |                          ^    ~~~~~~
> > ../../target/arm/tcg/cpu-v7m.c:71:5: error: incompatible pointer types
> > initializing 'ARMISARegisters *' (aka 'struct ARMISARegisters *') with
> > an expression of type 'uint64_t *' (aka 'unsigned long *')
> > [-Werror,-Wincompatible-pointer-types]
> >    71 |     SET_IDREG(idregs, ID_ISAR1, 0x02111000);
> >       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ../../target/arm/cpu.h:875:26: note: expanded from macro 'SET_IDREG'
> >   875 |         ARMISARegisters *i_ = (ISAR);
> >          \
> >       |                          ^    ~~~~~~
> >
> > (and more similar errors until the compiler gives up).
>
> What configs/compiler are you using? I obviously would have fixed that
> if I had hit it...

This is clang 18.1.3 (1ubuntu1) on x86-64 Linux, configured with

'../../configure' '--cc=clang' '--cxx=clang++' '--enable-ubsan'
'--target-list=arm-softmmu,arm-linux-user,aarch64-softmmu,aarch64-linux-user'

Whatever the problem is, it goes away on a later patch, so probably
it's just that some fragment in a later patch needs to move into
this one.

thanks
-- PMM

