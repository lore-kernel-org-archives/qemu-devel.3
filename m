Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F83CCD185
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 03:24:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9EaH-0004X5-2w; Wed, 15 Oct 2025 23:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9EaE-0004Wv-Nf
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 23:23:18 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9Ea7-0005OR-MW
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 23:23:18 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-63c1006fdcfso53454a12.2
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 20:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760584989; x=1761189789; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UpnGGrB5PMNwvV/RvMbbo4nd5HyujIkFcFof7YCCbfY=;
 b=kOujdhXmCnYQuGj3KvUtjWLpXEXg022GiePkFON6lChCWV3b8zUv3sfoN7tcYDOyv4
 kryru1oRZyi1Y0rvTFwsgkzsFEQn6NqsoMyzCB6mG5gtUsBUxwvSxyQnvB+0W4RLIsS0
 hXJMLVn/dcNTWtU6V3lKMXswlX6M4Dvs6Qt30e53NE0iutRaJWsWY0JJWdllIp1Ag5xD
 vNv5knnwywLICQhhtSFT2tv6BoTJF+GPtyVEWQ+D9x4/MNKrcKl5kc9wEdvnamtOWJ+I
 xq3uXufkFROubTTcuJORcNOn57j8gMqnG1q5llKmK2wQefWY3K55H0PU6WR8xoU+Uitq
 PWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760584989; x=1761189789;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UpnGGrB5PMNwvV/RvMbbo4nd5HyujIkFcFof7YCCbfY=;
 b=e7cl/xD1Zu19rBXjVL5OSa7rBJSr84uMuPM21abLWE6GKTjN7XZeSZ7Z8SXX6x+Dv0
 4FKktUqFZDiRy9rFhK6HC+TC77xJ5ptAAaYjbGKKPF2sHvDD3BSdVJzPcaMpSWAAAZPA
 SWf1r+x0P/7vWrRDLXW/YXGDi0C4ROAOJvKFeuLjbNHycNr+8mQ136rTTrYZXnX2XtT8
 X/0mkTzXG/huoAsqiU4wcY1GabHCooMeAfd9mly58OiRvHN1sV+4/9ZXxdO4Mp0fxxyV
 JS0R7dVMDaSNsxmPbFWchZUztPCR1vOyHNgXViV9T3IxOWvL2PuLO9j0NzmPTuQkoSqC
 e3xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZDorw8hi+e5VHNXEa1T5toXZ4icglT/P+kWcwaEjHxWOkWrdmUFEsRtxJQH7vHLDwLd6mScgSCPRh@nongnu.org
X-Gm-Message-State: AOJu0YwgPSByY/ROn+Wlz5fh7D0dLN5yTuRI4WKivY51r+8XZr7L5LXL
 9P3ZnQ7/elkJl6EmUm+3RY/Mk/1ASHIXtbfXVkMM8Vo65TFGAss+0khTWErFb0GvS0A/oAzlYfU
 c3JxBzPUwhNWNW9e+JYlZ+AUZ2uYi9Nw=
X-Gm-Gg: ASbGncsCCo+ro1vwmzYmp7kJrXS/qJgL/cNjdEP6drTc+hvtDLXBIu/uwnrLlytClpo
 dSqo0F4Imv44Ey7imxPDeY2zt/Qw2hFoFBL3UNgZzmlSUQGUB1a17XvdwznhiyeIFoA1rYZnwEd
 ZcnLx7RseiVChFXL/fQMj/MXWVWNuiRjjTaLNMc9B6pTRwrRtSmQC/nX0p0+UTcKNH4UosZMh3/
 3pYRMlX7n5NS9Zxt9Iz7XE9sz6mgaN0PXaCUhr/YkqvYcWQlbkppgV2QM+/wO/mrxuatSFeK8DR
 NeT2efgaaJiGM4kmNO3AWJmmOw==
X-Google-Smtp-Source: AGHT+IE12MFMESGTOhtLO1O5no8AkLimvzq6V2G+xUTb0z/IoC7iAMVjZW+SqYVlb+aIijYyuGb0BNnY8mm2NPvWGvk=
X-Received: by 2002:a05:6402:350c:b0:63b:f1aa:11d1 with SMTP id
 4fb4d7f45d1cf-63bf1aa1307mr4002536a12.1.1760584989174; Wed, 15 Oct 2025
 20:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20251014203512.26282-1-anjo@rev.ng>
 <20251014203512.26282-5-anjo@rev.ng>
 <10307c42-8ac3-443d-9046-30c1b7dad12b@linaro.org>
In-Reply-To: <10307c42-8ac3-443d-9046-30c1b7dad12b@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 Oct 2025 13:22:42 +1000
X-Gm-Features: AS18NWAb9CvAI3M6gZMwFMvEAeRvKAbSsUw8wAMae-R3xj_z8gUUkNuhQh1eQjM
Message-ID: <CAKmqyKN9HigcixOYKqygc_TRm65ogGm462tq7dK_aMhq-oJ7KQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/34] target/riscv: Bugfix
 riscv_pmu_ctr_get_fixed_counters_val()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org, philmd@linaro.org, 
 alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52d.google.com
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

On Thu, Oct 16, 2025 at 4:16=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 10/14/25 1:34 PM, Anton Johansson wrote:
> >  From my understanding the upper_half argument only indicates whether t=
he
> > upper or lower 32 bits should be returned, and upper_half will only eve=
r
> > be set when MXLEN =3D=3D 32.  However, the function also uses upper_hal=
f to

Correct

> > determine whether the inhibit flags are located in mcyclecfgh or
> > mcyclecfg, but this misses the case where MXLEN =3D=3D 32, upper_half =
=3D=3D false
> > for TARGET_RISCV32 where we would also need to read the upper half fiel=
d.

Ok, I think I understand the confusion here.

It's a mistake that we have two registers in QEMU
(mcyclecfgh/mcyclecfg for example). It should be one single 64-bit
mcyclecfg register. For RV32 (MXLEN =3D=3D 32) the guest can read the top
or the bottom 32-bits, depending on the operation.

So it is valid for MXLEN =3D=3D 32 and upper_half =3D=3D false (although in
this case there is nothing actually stored there, but that's not our
problem). The fact that we have split the * and *h registers makes
this hard to read and understand, but MXLEN =3D=3D 32 and upper_half =3D=3D
false is a valid use case.

> >
> > Minor simplifications are also made along with some formatting fixes.
> >
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> >
> > ---
> > NOTE: I've not included any reviewed-bys or modified this patch as it's
> > still unclear to me whether this change is correct or not.  Alistair
> > mentioned that this can get called for MXLEN =3D=3D 32 and upper_half =
=3D=3D
> > false, meaning the lower field would be accessed.  I'm sure I'm missing

Correct, riscv_pmu_write_ctr() does this if the guest wants to read
the lower 32-bits.

Alistair

> > something but this is still not clear to me, it seems to me like we
> > always want to access the upper half for MXLEN =3D=3D 32 since that's w=
ere
> > the inhibit flags are stored.
>
> In case there is a doubt, having an assert for this situation would make
> it future proof.
> g_assert(!(rv32 && !upper_half));
>
> As well, maybe Alistair can point a call site where this combination is
> possible.
>
> > ---
> >   target/riscv/csr.c | 22 ++++++++++------------
> >   1 file changed, 10 insertions(+), 12 deletions(-)
> >
>

