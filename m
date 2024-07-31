Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20866C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 09:45:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ5th-00060F-6h; Wed, 31 Jul 2024 05:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZ5t6-0004ph-Hg
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 05:44:55 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZ5t4-0006Ro-3l
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 05:44:51 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5a1f9bc80e3so4544845a12.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 02:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722419087; x=1723023887; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mKkedlz8qgq0I5fnBMu3HnJ8d7R8AOMNegXNNSRSQOw=;
 b=pcUD+/KNo++QdI+EjP0x5Nm2y0OYjjK93fvIwbjZVlGsXS7YIUAAvOSbkTaVDty6F9
 OrWrgwXZKxavLbX6B6QYNRfVV2tQnln7s6XwDiJl2Tfo/X3PTwz+oVDtgj8P+BRbApTl
 rSIDz/E9lKMFPg2b8pwnLctOM+7Y2Tk5jTQ0367DvxBDEHCSwsAeaJHsvC3YqfjzkpYG
 pBzhtGghb8dBGeh1QqpbW/6az9QFBmHvGBBqs06T5yFHlG9kxvt3/GwbIWv7a2WVPYJR
 KWgkv3y8AwWiOPsUTKyB2XgaAhBL3VmI2jz6Y7EhiJPEh/EkxarI8atPgx0R4tBMViOQ
 D5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722419087; x=1723023887;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mKkedlz8qgq0I5fnBMu3HnJ8d7R8AOMNegXNNSRSQOw=;
 b=A76ZZ/6yeCBzlLAXp7KKdo8oS9DX42XigA35mgEMzITRkZN9rofbnk2CZ5gqdpEmLv
 kvRggZi3rujqKMm9l7Ast4gMXJ3Ki0rbGQjNZ7MRnYdUlAgPoznLGndu7OKxLxMyxT5a
 jq4QNg/y/bHHZni4tE2P9ugV7HUHZxH/lcQUOqRQdFH2DgeiBHZhMchnguzsEXKKE8oJ
 JRSMJ62MpOoqsVo2/CGjQPLVBdGFQK/PcFCfFlsH/yfZOoZZvJzo84Fvtf6XsCyV3ysC
 C/Jc3L86K3Os1QIOWz3RkoZisZPY+5n7MkVqxzCzTSqcZgj7o3RPHpUpIrmoe+mcrayV
 fhSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2+JZGc49+lLbG2Cz8W/4d0gFcg6XJOw7MDuXL87KEeRi2ZQHom5v6ZgnZUMG6yj2+LF4ki0J2jQEMpodQ11pY0kBYn10=
X-Gm-Message-State: AOJu0Yy9dPIbyQv/Af+o7ysF3toJ850uu4Xn7auMmu5rtlhCbIbs29Ca
 TOS4YTiFcJNu9isBPNF6gUJV6RS2VjKzzflyGjN2iysbbECF9rcmI16qMTAqdJ/Kr3eagqW1OvU
 1vKuhzFDi17JOE3GTCU/djg/+sigLfkVvyOPfVQ==
X-Google-Smtp-Source: AGHT+IGVdFOf/HpsR1geNOfjv5SLl/36nOYmYP2ZuSZsk96DUvgL8R441p//1zdYPQocszyNCJ+S5zOQjmmdzNZIfgk=
X-Received: by 2002:a50:d7c1:0:b0:57d:3df:f881 with SMTP id
 4fb4d7f45d1cf-5b021190495mr11985226a12.3.1722419087438; Wed, 31 Jul 2024
 02:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240724-fixes-v1-1-4a64596b0d64@rivosinc.com>
 <CAKmqyKPhCzrYxwpBF+NQi-5KgcKkhWeVNX6nwwx3ZjeE9rWEAg@mail.gmail.com>
 <CAHBxVyHBtnhFnFYN0=_5PoKvc7DadJABH71s+wCZzPiYAmPM_g@mail.gmail.com>
In-Reply-To: <CAHBxVyHBtnhFnFYN0=_5PoKvc7DadJABH71s+wCZzPiYAmPM_g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 31 Jul 2024 10:44:36 +0100
Message-ID: <CAFEAcA8DJ8=O2C3XO0hTT3ujksq6MQOh8P-quaES3mpeit23iQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Add asserts for out-of-bound access
To: Atish Kumar Patra <atishp@rivosinc.com>
Cc: Alistair Francis <alistair23@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Sat, 27 Jul 2024 at 02:36, Atish Kumar Patra <atishp@rivosinc.com> wrote=
:
>
> On Thu, Jul 25, 2024 at 10:12=E2=80=AFPM Alistair Francis <alistair23@gma=
il.com> wrote:
> >
> > On Wed, Jul 24, 2024 at 6:33=E2=80=AFPM Atish Patra <atishp@rivosinc.co=
m> wrote:
> > >
> > > Coverity complained about the possible out-of-bounds access with
> > > counter_virt/counter_virt_prev because these two arrays are
> > > accessed with privilege mode. However, these two arrays are accessed
> > > only when virt is enabled. Thus, the privilege mode can't be M mode.
> > >
> > > Add the asserts anyways to detect any wrong usage of these arrays
> > > in the future.
> > >
> > > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> >
> > Fixes: Coverity CID 1558459
> > Fixes: Coverity CID 1558462
> >
>
> I think one of the Coverity issues was about the get_field issue in
> the other thread?
> This doesn't necessarily fix the coverity issue also as the issue
> reported is a false positive.
> But I don't mind citing the coverity issues as it is reported by that.
>
> Is there a link to both coverity issues to know which issue describes
> the out-of-bound access one ?

You can't do deep links into the Coverity Scan UI, but if you
want to ask for an account at https://scan.coverity.com/projects/qemu
we generally give them to any developer who asks.

In this case 1558459 is complaining about the call to
     riscv_pmu_update_fixed_ctrs(env, newpriv, virt_en);
in riscv_cpu_set_mode(), and 1558462 is complaining about the call to
 riscv_cpu_set_mode(env, PRV_M, virt)
in riscv_cpu_do_interrupt().

So it's basically reported the same problem twice, at different
levels in the callstack. I don't know why it's done that, but it's
not that uncommon that the same problem gets detected several ways.

The complaints about get_field/set_field were different: those were
1558461, 1558463. I've already marked those as false-positives in the UI.

(Generally my practice is that where we think there's no point in
making a change to QEMU's code I mark the issue as a false-positive;
where we think it is reasonable to make a change to QEMU's code
(e.g. to aid the human reader or where we think an assert() is useful)
I leave it marked as "bug" to indicate we want to change something,
even if Coverity's analysis is wrong and it's a can't-happen case.)

thanks
-- PMM

