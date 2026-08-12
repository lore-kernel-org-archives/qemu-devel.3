Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A377C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 06:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu1zZ-0000zb-Jw; Wed, 12 Aug 2026 01:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wu1zV-0000zA-Vq
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 01:59:06 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wu1zU-0006tj-BN
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 01:59:05 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-39266382df6so433831a91.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 22:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786514342; x=1787119142; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=X2YEhq6ig7Bi41g2973NC+D5SsF89pB04WlbAs3ygdI=;
 b=seSj2XHBiBsQWjBlSj3K3mHaO6zvy2XVvGV/VInrhGCPpDJSAMPRz7p2dqkis2HM6/
 uHylVCEsM/YpWgsrq2Zslg0E5mPmCFA0vVrz1D1yWiRE8T0N49JSF+jEeUYWDYTV6nx7
 A4Kf6DvbQ8YN/kUOW2T6JXHRa6uGdtZRQGBZ0TmQhNsf1d806BPUvAfjIQa0ID7LHxaI
 zkgVCMHTIC9TNJhClyeBgkv1ckWA8VQ6nsV77HZo9/mvtu41Lddtxjhl8sovp9Bl+/XM
 DrqM4ZmNHD6lmcOYD9u+HoUKIeLgJnfRM1iFh66nnNneHUkr6wA48Oxx4N75CVKXM3Ke
 PVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786514342; x=1787119142;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X2YEhq6ig7Bi41g2973NC+D5SsF89pB04WlbAs3ygdI=;
 b=RIxEgoi/j8jXR3RtV9+J6Vssdno7smsvg2ve2rZTAj328nFABCUTwUxC8M0vQ2fSXS
 UJEOcxdDHj0g0DEi7NxBIElcyYbRl1dfwaVB95/CINnOk/21Y6bYfNybptzc4YtiTGMt
 AwwmMunhL6fj8JIa6imOKC3o+Uf/w3SsBUQxWUbkKyC5QHEG+/lsUR2OlU7yxB8WICe/
 RN89V3ljD24Qt3YeTv4xhuRU8lFhqNQubSIOuAfRxPf3b++wyeang7U7I0sz9aBthr/2
 apwzC9fiBimv0TSfF2X7reFfiqN2W8VVfGfkb++DABwdCoRbrP1o7EGe/QM/R1KylJp2
 ADCg==
X-Gm-Message-State: AOJu0Yxxg7NcNpTOsByc+u8/GPeeI+S8n6n97NOvx6pFu2kTQgsvrLxk
 nMhjKkegVsAyckDtHGoPgpkFi96u3Wf3hphvKvMqpOtp/zdwiAyxgnRISHCOQ8yl
X-Gm-Gg: AR+sD129oN59mOkArUIh+4DePQvBzuI0J1hH4hED7yehp+0eE/jl9s7tmHe8bQF9Hcq
 64phzwkYbovQRTD8x+kvU24dfam9+miqZFeapfTL4MQ4qm+TjP78t7QQ/R7toJCSAAZEuzF9lii
 bNTwznhch+TuXDxbFEFHK1GNIvR9pKOXMJWxiZn/SXdBYI8uOsAYpeJLEwhtNC3YpX3FWQQUmkt
 paFVNAqGi+65ZYZtMP0YRqXbOb+Yqn9BEZw/gFnCPNghVTnItcb1TwgdUpCUDB/WTE6e7wRb6Hn
 obtqepw3hR/MHGvjA0+hqed6enIkjutT4dwuGnFXXCIWZjKDwMQ/Oqj00md7b2sgjmkcqzef4SF
 mJp90AUHemJZpnwMzxTuY46UGjpKuJJV1Ej4m9FHV3Ku62JCWlf7gPu7qp5Pfte1iMbSjeA+4GS
 fJIIAm5oBD2cEzloWhVyLeYUBRfCzRmZwur2nQF2avHMig8wX9mCskmQp4qXJ2WrKFlw==
X-Received: by 2002:a17:90b:1c01:b0:392:c80b:8eff with SMTP id
 98e67ed59e1d1-3930161df9bmr2516027a91.11.1786514342096; 
 Tue, 11 Aug 2026 22:59:02 -0700 (PDT)
Received: from smtpclient.apple ([82.40.42.115])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392f8cffe2csm2219610a91.10.2026.08.11.22.59.00
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Aug 2026 22:59:01 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v2 0/2] hw/riscv/k230: add the K230 Reset Management Unit
From: Jack wang <163wangjack@gmail.com>
In-Reply-To: <20260719180247.8660-1-163wangjack@gmail.com>
Date: Wed, 12 Aug 2026 13:58:45 +0800
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F71CFF07-B657-4547-B3FB-5F40A14453E5@gmail.com>
References: <20260719180247.8660-1-163wangjack@gmail.com>
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=163wangjack@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi all,

A polite ping for this RFC series.=20
I just fix problems generated by chao liu and Daniel.
Could anyone please take a look when you have a moment? Any feedback or =
guidance would be greatly appreciated.

Thanks,
Jack Wang

> 2026=E5=B9=B47=E6=9C=8820=E6=97=A5 02:02=EF=BC=8CJack Wang =
<163wangjack@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> References: <20260709031237.21284-1-163wangjack@gmail.com>
>=20
> This v2 patch reply on review of=20
> This series models the Kendryte K230 Reset Management Unit (RMU), a =
bank of
> reset-control registers at 0x91101000, and wires it into the K230 SoC. =
It
> replaces the create_unimplemented_device("rmu") stub so guest reset =
drivers
> (drivers/reset/reset-k230.c) work against a real model.
>=20
> Patch 1 adds the standalone device model; patch 2 wires it into the =
SoC and
> adds the qtest. The qtest is deliberately placed in patch 2 =
accorinding to=20
> suggestion from Daniel: it drives "-machine k230", which only
> exists once the device is wired up.
>=20
> Register semantics, reset values and reserved-bit masks are taken from =
the
> K230 TRM chapter 2.1 "Reset" (V0.3.1) and cross-checked against the =
mainline
> Linux driver.
>=20
> Changes since v1:
> - Switched to the Resettable API (phases.hold instead of the legacy
>   device_class_set_legacy_reset()), per Daniel's review.
> - Model real reset propagation: the RMU now cold-resets the two linked
>   watchdogs via "wdt0"/"wdt1" QOM links when their PERI0 reset bits =
are
>   written (Cao review).
> - CPU1 reset request is now a two-step assert/deassert (not =
self-clearing),
>   matching the hardware (Cao review ).
> - Filled in the documented per-register reset values and reserved-bit
>   (writable) masks from the TRM; the *_rst_done status bits reset to =
0, so
>   they follow the per-bit "Reset" column rather than the summarised =
total.
> - Added the reset-time-control (*_RST_TIM) registers as plain storage =
with
>   their documented reset values.
> - Fixed the storage mask so the upper half of non-write-enable =
registers is
>   writable (surfaced by the new TIM registers).
> - New qtests: reset values, TIM storage, reserved-bit read-only, CPU1
>   two-step, and real watchdog reset propagation.
> - Moved the qtest from patch 1 to patch 2 for bisectability; added the
>   MAINTAINERS entries.
>=20
> Jack Wang (2):
>  hw/misc/k230_rmu: add Kendryte K230 Reset Management Unit model
>  hw/riscv/k230: wire up the RMU device
>=20
> MAINTAINERS                 |   3 +
> docs/system/riscv/k230.rst  |   1 +
> hw/misc/Kconfig             |   3 +
> hw/misc/k230_rmu.c          | 425 ++++++++++++++++++++++++++++++++++++
> hw/misc/meson.build         |   1 +
> hw/misc/trace-events        |   7 +
> hw/riscv/Kconfig            |   1 +
> hw/riscv/k230.c             |  15 +-
> include/hw/misc/k230_rmu.h  | 126 +++++++++++
> include/hw/riscv/k230.h     |   2 +
> tests/qtest/k230-rmu-test.c | 225 +++++++++++++++++++
> tests/qtest/meson.build     |   3 +-
> 12 files changed, 808 insertions(+), 4 deletions(-)
> create mode 100644 hw/misc/k230_rmu.c
> create mode 100644 include/hw/misc/k230_rmu.h
> create mode 100644 tests/qtest/k230-rmu-test.c
>=20
> --=20
> 2.53.0
>=20


