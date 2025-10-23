Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1259FCCD1BF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 23:46:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC4zi-0003EP-1b; Thu, 23 Oct 2025 19:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC4zg-0003EA-Rj
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:45:20 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC4ze-0005rK-SI
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:45:20 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6399328ff1fso2582727a12.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 16:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761263116; x=1761867916; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wl/DpvATYGTNA9S2ruD6WLDx/H/Q0BUswbcZ7HGIcN4=;
 b=InNDN6rS2PRvh4sYmYNaSfJBx2cjcWIF7bI8ZFWrkE5pkEBayCVayx2rca9Z+JOv98
 txY3iykXCfibcK6AbfQu8D843iIXFe0waZuswEh2zRy+ZEmwYZ50cxXTXzvtSZ1DSZrA
 Uepqt1h/q97ieAdXdKei9jToBqoVCRBzAx5S6LtH9eSo70aR3q/uTVY635vgdQtWIDHS
 t2fUuiJYV8LGEYV+E7JbxD3W/wacsNbSv4pW9Q52ko/k2HOtHjKPPqIgkHxW4FThaee+
 Wd4Jbk9216c1tDnWOB4t+CjWSEeN2HskWA1Ra0aAVQDb4YH53QGe13N2O99P5BFfv/BE
 wL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761263116; x=1761867916;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wl/DpvATYGTNA9S2ruD6WLDx/H/Q0BUswbcZ7HGIcN4=;
 b=k23zuhw7gdupqySKP8jlaZUum+/TTygeAoBf5cJnOK3DOBI+8H2ohPaN4kckBfBMRv
 uF+z7SIGIzLlJqQlTshEBZtAvH6VTKqphOIIdmiga7BED0p4NKu9kXQJ8tqR4mRYt+HY
 LYkiJCdadWtNdv7DQJrJe+bZZkFIINVlpPxmKugfSUSahPfRavoLGVO9fU/hIYLFeb0A
 bv90VRnVyg8PVEpEftXMDqD9zSYOIigoFBBKBGRRk3+bTDasbDxOaZ4KZBBE1jS+RfTx
 lDsHifa8z13anjrtIbMFuEYLj4aAxFeTkyeFKlGOEqyOJo56POvAGASuSdzFq3B0y/A1
 WFCg==
X-Gm-Message-State: AOJu0YwkLrE4ihabyhPV/ACiOrrUmB0/UAJLmExrkvw/xnT//eS0Nrhb
 rYZm0BeB+lQf2Ow40WaCuWtYkTiqVX2GK3qUo5qFDZit8l3wZlfJlm0NOCAUAJRUpY5nKhspYgG
 XXV+ZHpSDpt8MlY+1+uOk8sugo/gzbOw=
X-Gm-Gg: ASbGnctIPOjfX1/QItWSpUDwxSG24go5VsPB3OGR0l8+eCYJ487v/+5OfBanhPTO0rN
 m4KoK88DVnPr0nwtfZGxcMyQE0vLAxww4f0KSfDQiSyNv7WFyvI7J8DuYuyo7KSmhBwkGEPPCHC
 Mi2fbwN343TouXxJ/Ih1N5sPR6YxRHbKe4Zs439qyTOK+pYRf8qhUtL69YXzLWP1cLqdTHzsXZd
 l/wM/hY/C0uuYnsAzv3n26zLDgyDdArtLqZDi1wYBYaQ1cvUZwJRdWvlBdBL4T0ovBgAqtK4OYj
 Pt20oXKzKdGZ9ryRXykkGQrxeg==
X-Google-Smtp-Source: AGHT+IHgv2eSTbEzPeEgHTSPnwBGw2+xHrqHp/o+PN1/4fcYOQFlbJAjrxUir6eT5wudeWdf/ka0KV4BP2nDh2ByYXk=
X-Received: by 2002:a05:6402:274c:b0:633:7b1e:9aa3 with SMTP id
 4fb4d7f45d1cf-63e60099747mr358248a12.34.1761263116215; Thu, 23 Oct 2025
 16:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20251023041435.1775208-1-alistair.francis@wdc.com>
 <325c46b7-54fd-4793-95f1-2dc6cc44869c@linaro.org>
In-Reply-To: <325c46b7-54fd-4793-95f1-2dc6cc44869c@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 24 Oct 2025 09:44:49 +1000
X-Gm-Features: AS18NWDX02T7udmyR5oJLpUoESsVvj3uMJVGZrRVgtZrrL_37d9xRGhf-y-4Eio
Message-ID: <CAKmqyKNyFioTOHtBcvZW5gCH8c19ikCrLqhwJC3x7_040r=VJA@mail.gmail.com>
Subject: Re: [PULL 00/37] riscv-to-apply queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Oct 24, 2025 at 4:15=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/22/25 23:13, alistair23@gmail.com wrote:
> > From: Alistair Francis<alistair.francis@wdc.com>
> >
> > The following changes since commit c0e80879c876cbe4cbde43a92403329bcedf=
2ba0:
> >
> >    Merge tag 'pull-vfio-20251022' ofhttps://github.com/legoater/qemu in=
to staging (2025-10-22 08:01:21 -0500)
> >
> > are available in the Git repository at:
> >
> >    https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-2025=
1023
> >
> > for you to fetch changes up to 741566c3e07fd34ed28d4464d1d7fda67db12925=
:
> >
> >    target/riscv: Make PMP CSRs conform to WARL constraints (2025-10-23 =
14:11:45 +1000)
> >
> > ----------------------------------------------------------------
> > Second RISC-V PR for 10.2
> >
> > * Correct mmu-type property of sifive_u harts in device tree
> > * Centralize MO_TE uses in a pair of helpers
> > * Fix Ethernet interface support for microchip-icicle-kit
> > * Fix mask for smsiaddrcfgh
> > * Add support for MIPS P8700 CPU
> > * Fix env->priv setting in reset_regs_csr()
> > * Coverity-related fixes
> > * Fix riscv_cpu_sirq_pending() mask
> > * Fix a uninitialized variable warning
> > * Make PMP granularity configurable
>
> Something in here is causing failures on s390x:
>
> https://gitlab.com/qemu-project/qemu/-/jobs/11827080939#L5859
>
> It seems obvious to suspect the endianness changes from the big-endian ho=
st, but I also
> don't immediately see anything wrong.

It seem like only the new Boston machine is failing, so I think that's
the issue.

Alistair

>
>
> r~

