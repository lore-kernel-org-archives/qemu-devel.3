Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFABC71136
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 13:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ4jx-0006Ey-KE; Fri, 13 Jun 2025 09:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uQ4je-0006Cu-BW
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 09:46:24 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uQ4jY-0006sp-Aa
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 09:46:19 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-60789b450ceso4098489a12.2
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 06:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1749822374; x=1750427174; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mc8wSP+/FV9P/n2j5WAoDMSG4PUhKFwccG4V6/uG2pc=;
 b=XRazCXMGT9bXzub8T4s+drZibUxvqW+n6GCrnWuw273C0+nkoKRKAhiAa1cgFQnSaL
 0SMdz4Cu3EmqN/UFtESNj69vR+u3WvwqBbqlckqf/S9xgSplcIvtAWLR9CmRCSdtdYN2
 nNpveOa4A6ivJMbYfHzSpZLiRjMPB5LSmR1wq23uCp2sxRc51ww+YMqhgrjreU6vmYSR
 85Zkv1hanR5uFF5/CkhrxXdWm5OKKeXB+cIfdWv+Fj+ROY9qwoqm7eu2RY8aVmvHnSzw
 pvPJDWUhWfzkMEyIwKvyNFGow40G9+VZYpCG8Bj/59Q78xhF0CZjJVbfLRVPRAk0e/8P
 MWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749822374; x=1750427174;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mc8wSP+/FV9P/n2j5WAoDMSG4PUhKFwccG4V6/uG2pc=;
 b=G+gY1A/Om4N4jM4WGcKck/Q+FdK2t0TUO/RbzOHYBqFaIAK5wUqqhGoeZgjXTZwcT8
 NuiF8sGC7fCIb5+q2jt0AmNmTHHIWqsHLwCeB8F9o999gdRyBrVZCD7Oq+ixrb8a8683
 VtixbHn0/Axmb/3erDOdPYP3B/1FA7Sn6lSSeUNVSk5yxgz92k8ipAOosrQojg3kQEmR
 mRuigDjapBajx2DQD4TUe4lbSRs2yKo4DJ/8hl2WYu0OwZuZq9WcU62f43+8q0TZKthX
 mSammxVnMFGi/+8f/qBDXl9rPuO9Pdv/6+uy0vWmX5xMD6jarAuErO8xcs8OhtUwN456
 bgjA==
X-Gm-Message-State: AOJu0YyeG0kdGvpx7Fc8r0m0l5mjlULli1na0nKBK2WsTBhZVVIEvWyf
 6VJ0lX7d1PNE8Cb0DJBHTn5+Vrs5I0rG1lbTnScudmh+Uwlm42htbqdmygPrHI4RKdbK1tDK8A5
 jI+Bhj9mxqqP/Gttc1c47Ik4x1hyujZ4VaVXZorOZ
X-Gm-Gg: ASbGncstBHzy7W14nqlKTtnuf/QkH3L/Gy0Av/3NvVYfi8VhzoCxulfnk/k6kz+MQSx
 SYx3T9N3bi03h4k65RkP0ZXxhM7Eb3hGFE6zp1HgG69P7S3/AAkzh4l56PE2P7rZJ2nCUG2/a/Z
 rXGx7uWjG2TGb9+Yqdi/2vwL+TcPYuNqI3/Eb9emLtQbOmvVMiAwAb90CoTo5K83U02VNYjm1Yu
 OOMNg==
X-Google-Smtp-Source: AGHT+IEQWZPZiq3MrFlwEg3yz4tF3UugQGAR5uG0fm4+7wnUF8Mn+61dAEUiNNO380Imf5sEv/L0zetelsFYPNU0gLg=
X-Received: by 2002:a05:6402:2115:b0:607:ec09:d462 with SMTP id
 4fb4d7f45d1cf-608b48c758amr2887829a12.7.1749822374469; Fri, 13 Jun 2025
 06:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250526085523.809003-1-chigot@adacore.com>
 <CAFEAcA-2fnu9hsGirQ5FJGqtNktNX2X52UgQBu4yYN4WjeSVQg@mail.gmail.com>
In-Reply-To: <CAFEAcA-2fnu9hsGirQ5FJGqtNktNX2X52UgQBu4yYN4WjeSVQg@mail.gmail.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Fri, 13 Jun 2025 15:46:03 +0200
X-Gm-Features: AX0GCFuTHFrLMQWmQj1Hpk1c4MVGv7bN_bui-dYiv0vfvKVT1lWpTZv93IVj-2s
Message-ID: <CAJ307EiPsrCDP2_5urEROOZj-3TRc4rOAQA-wOHEGUuhO3T=7w@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] xlnx-zynqmp: add support to boot on RPUs
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, edgar.iglesias@gmail.com, 
 alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=chigot@adacore.com; helo=mail-ed1-x52a.google.com
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

On Fri, Jun 13, 2025 at 1:58=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Mon, 26 May 2025 at 09:55, Cl=C3=A9ment Chigot <chigot@adacore.com> wr=
ote:
> >
> > This series enhances Xilinx ZynqMP support to allow booting on RPUs and
> > ease gdb connections to them.
> >
> > It was validated with home-made binaries. FreeRTOS was tested but witho=
ut
> > success: outputs/IRQ seems broken. AFAICT, FreeRTOS is expecting Xilinx=
's
> > QEMU thus I didn't investigate further, but I'd still like advice
> > on the 3rd patch ("wire a second GIC") since it could be related to it.
> >
> > Changes since v1:
> >  - add doc for "first-cpu-index" new property in arm_gic.h.
> >
> > Cl=C3=A9ment Chigot (2):
> >   hw/arm: make cpu targeted by arm_load_kernel the primary CPU.
> >   hw/arm/xlnx-zynqmp: adapt cluster-id based on the boot cpu
> >
> > Frederic Konrad (2):
> >   hw/intc/arm_gic: introduce a first-cpu-index property
> >   hw/arm/xlnx-zynqmp: wire a second GIC for the Cortex-R5
>
> Hi; I've taken the first 2 patches in this series into
> target-arm.next. I left some review comments on patch 3.

Thanks a lot. I've just sent a v3 addressing them.

> For patch 4, I still feel this is something that should
> be dealt with at the gdb end (e.g. gdb should support
> "connect to this target and connect to remote-inferior 2,
> not inferior 1, and don't fall over just because you
> don't know the architecture of inferior 1").

Yeah, I'm totally fine with that, I've removed it from v3.

PS: I'll be off for a few weeks but should be able to make a v4 if
needed before 10.1 soft freeze.

Thanks, Cl=C3=A9ment

