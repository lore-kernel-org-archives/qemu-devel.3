Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5349CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 23:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4T9n-0006aB-4x; Thu, 02 Oct 2025 19:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4T9i-0006Wm-SG
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 19:56:14 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4T9T-0004YX-Po
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 19:56:13 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b3e44f22f15so232228366b.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 16:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759449349; x=1760054149; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HPJn7z4uEK32lSgqCo6CeLfUB/KCEthQ234SXUx/6zs=;
 b=igiO2L8s2hb6W9dMaAWcxvoiV1pWQidkS1nPL1YUgo67YiZQlH/tsPPJXcCVOxmk5s
 nEG31tzqv80NtTgEA4bY4W6b88JfrM4HxCjY96NYgjY2wLZzbqQlAlZMd7EMLX82dalQ
 a7zTczMA/R86/1s7HpX+fl+P911GE7P3FoZIHSoPanF5jtKTH2BNSIMwzaBjUSwvr26+
 FdNiA2eZ3R7y2iy5uroxCFV9YFD3OVEUMmQfnYIFXhLtYSJTFpcA9ymkCoxpnJEph6JB
 7mzw/eu/fKmsnIBkglOe5VimzXhw2hxzqqzLnb4t1Ywbm/0zeJ3+jUptQvqxdVP9O+WW
 TNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759449349; x=1760054149;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HPJn7z4uEK32lSgqCo6CeLfUB/KCEthQ234SXUx/6zs=;
 b=ttPMgYMEIfQcw/PGFHmv0TvUdU9EPSX/JHmihvSZtHPcnH5Umtq0LtsXXUhIv2jqM8
 t1TEG/kYQpYsu42Vskp9M3ENflEXviQ1SoepaAYZy8Dd5bzxDpaX733tOwQfB6M6FryM
 YUkGMHfL+p2zGhSOLa2u5+PfxhXOJfp4GNAXVZWUAfSk+xHLyUdlUTjH3kIWWDM9+nUO
 24eHTCLq+PtAWP3lYGhh9aqN7+msngEkEvMPF00ra7z8bBBii+RnjNtMDIwWzjo0GHJy
 Vt+TWg+lELTi7rvU+gwHz6A+89q0AFjg5SSjqfsTjn+U0r6R82julEmAShqJUKTZqTaH
 43+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv3MRQs13C6+KIQC5UxKTqj6YCvEN8pHi04Zfy5JCQPd7uTnTAHACcvkFJvD/3p74PWjjM6e1emB44@nongnu.org
X-Gm-Message-State: AOJu0Yzb9OJyOZZIgkqDK+pNdBMAkRugysbduMqfhd8aIVw4JlBQAvWy
 eyjK4j1xcP1ILLIgCMBj8PCVgf8Qlx9ADoEBMWOef0LKgtB7jSIwWo05pYD9AnUG5RUVPnfwIVc
 8QDUdbFFo1qS4KcaZPuraYdqH4BH/5XY=
X-Gm-Gg: ASbGncul96bPxEMqrwXAcePDZLxBpLif0s8QvqV8rWph6Eur1tbfrkhpP5MQoEJ5nw/
 HpI+dhAvGkjewgkQYiJvBlWisOKNvBPZr53OvyaVJgzm4lwVsPtErQfNqa+fnGj70nvCk/e2eix
 RLxvrmQa7jmpGsMSwgeyhbvUg27FHHQNQEJZPMGOziLovcckfVifRKT0XWP5kjO8fAQTF/1/D5q
 QRLshLni22sfUOKTn8d/Sl7VsysiTjUz1rTc3xYkZUJu4lVuYiFxLPnc6YmrQ==
X-Google-Smtp-Source: AGHT+IFRdWJNdDZw6eBup70XP0LN5w23ktG33EvRMs6/gw03Rm1cI6ewqErfu3KPywOAijcqNO8QBTGrO4meSQzfwaA=
X-Received: by 2002:a17:907:9486:b0:b3c:f48:ed57 with SMTP id
 a640c23a62f3a-b49c334efb0mr127220766b.35.1759449349116; Thu, 02 Oct 2025
 16:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-6-anjo@rev.ng>
 <e1748ad3-3475-4cce-8add-2a1d76994f0b@linaro.org>
 <cbc22e4a-84dd-4209-82fd-ec56ea138d27@linaro.org>
In-Reply-To: <cbc22e4a-84dd-4209-82fd-ec56ea138d27@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 3 Oct 2025 09:55:22 +1000
X-Gm-Features: AS18NWBNyThXgjn0BUg9eRw6VLHLf8bbcNPEyC7gblqPxoJ6pV7NjihNMRs5xo4
Message-ID: <CAKmqyKO6rvjBe56pDPaa_TQn8z9npQ6h_F=JkVLWBA8qHciQig@mail.gmail.com>
Subject: Re: [PATCH v2 05/33] target/riscv: Combine mhpmevent and mhpmeventh
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org, philmd@linaro.org, 
 richard.henderson@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Oct 3, 2025 at 5:37=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 10/2/25 12:08 PM, Pierrick Bouvier wrote:
> > On 10/1/25 12:32 AM, Anton Johansson wrote:
> >> According to version 20250508 of the privileged specification,
> >> mhpmeventn is 64 bits in size and mhpmeventnh is only ever used
> >> when XLEN =3D=3D 32 and accesses the top 32 bits of the 64-bit
> >> mhpmeventn registers. Combine the two arrays of target_ulong
> >> mhpmeventh[] and mhpmevent[] to a single array of uint64_t.
> >>
> >> This also allows for some minor code simplification where branches
> >> handling either mhpmeventh[] or mhpmevent[] could be combined.
> >>
> >> Signed-off-by: Anton Johansson <anjo@rev.ng>
> >> ---
> >>    target/riscv/cpu.h     | 10 +++----
> >>    target/riscv/csr.c     | 67 +++++++++++++++------------------------=
---
> >>    target/riscv/machine.c |  3 +-
> >>    target/riscv/pmu.c     | 53 ++++++++-------------------------
> >>    4 files changed, 42 insertions(+), 91 deletions(-)
> >>
> >> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> >> index 3235108112..64b9964028 100644
> >> --- a/target/riscv/cpu.h
> >> +++ b/target/riscv/cpu.h
> >> @@ -427,11 +427,11 @@ struct CPUArchState {
> >>        /* PMU counter state */
> >>        PMUCTRState pmu_ctrs[RV_MAX_MHPMCOUNTERS];
> >>
> >> -    /* PMU event selector configured values. First three are unused *=
/
> >> -    target_ulong mhpmevent_val[RV_MAX_MHPMEVENTS];
> >> -
> >> -    /* PMU event selector configured values for RV32 */
> >> -    target_ulong mhpmeventh_val[RV_MAX_MHPMEVENTS];
> >> +    /*
> >> +     * PMU event selector configured values. First three are unused.
> >> +     * For RV32 top 32 bits are accessed via the mhpmeventh CSR.
> >> +     */
> >> +    uint64_t mhpmevent_val[RV_MAX_MHPMEVENTS];
> >>
> >>        PMUFixedCtrState pmu_fixed_ctrs[2];
> >>
> >> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> >> index 859f89aedd..2d8916ee40 100644
> >> --- a/target/riscv/csr.c
> >> +++ b/target/riscv/csr.c
> >> @@ -1166,8 +1166,9 @@ static RISCVException read_mhpmevent(CPURISCVSta=
te *env, int csrno,
> >>                                         target_ulong *val)
> >>    {
> >>        int evt_index =3D csrno - CSR_MCOUNTINHIBIT;
> >> +    bool rv32 =3D riscv_cpu_mxl(env) =3D=3D MXL_RV32;
> >>
> >> -    *val =3D env->mhpmevent_val[evt_index];
> >> +    *val =3D extract64(env->mhpmevent_val[evt_index], 0, rv32 ? 32 : =
64);
> >>
> >>        return RISCV_EXCP_NONE;
> >>    }
> >> @@ -1176,13 +1177,11 @@ static RISCVException write_mhpmevent(CPURISCV=
State *env, int csrno,
> >>                                          target_ulong val, uintptr_t r=
a)
> >>    {
> >>        int evt_index =3D csrno - CSR_MCOUNTINHIBIT;
> >> -    uint64_t mhpmevt_val =3D val;
> >> +    uint64_t mhpmevt_val;
> >>        uint64_t inh_avail_mask;
> >>
> >>        if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> >> -        env->mhpmevent_val[evt_index] =3D val;
> >> -        mhpmevt_val =3D mhpmevt_val |
> >> -                      ((uint64_t)env->mhpmeventh_val[evt_index] << 32=
);
> >> +        mhpmevt_val =3D deposit64(env->mhpmevent_val[evt_index], 0, 3=
2, val);
> >
> > Maybe I missed something, but should it be:
> > deposit64(env->mhpmevent_val[evt_index], 32, 32, val)
> > instead?
> >
> > Reading the rest of the patch, I'm a bit confused about which bits are
> > supposed to be used in 32/64 mode.
>
> Indeed I missed something, it's more clear with next patchs combining
> low/high parts.

Besides this missed part the patch looks good.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

> The concern I have that is left is regarding the definition of
> MHPMEVENT_BIT_OF. It seems to be out of sync with what we have now given
> that we now keep lower part in lower bits.

That might be a bug, it should be using MHPMEVENTH_BIT_OF with mhpmeventh_v=
al


Alistair

> Existing implementation is quite confusing to be honest.
>

