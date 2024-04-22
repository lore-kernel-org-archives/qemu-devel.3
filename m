Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B20C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 11:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryrof-0004D8-Pv; Mon, 22 Apr 2024 07:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ryroX-0004CT-5U
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 07:26:26 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ryroS-0007mo-UQ
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 07:26:23 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a5224dfa9adso721748266b.0
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 04:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713785178; x=1714389978; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FjgYdEhWvwX0A9jBKVOxo1Q4kgonAvoLXDRpTOE3guk=;
 b=M3c09mxuTDQOVYaT4Gch8VJyPoCxmdFGj7J+IKph0F/MD8uhSvPrlwPeY9YU1sc/wA
 nxbvZpfFtYXutM46NX/oazDt16SSMVWNaNiJuBdAWAMA7fPVQNmfpqsHDuAWnj6FfYul
 3+DVASkF2pS3LYrA8ki4cp7lWJZxZXsDpnTeReUxwAXz5xB3p+mL2rbaoa6j7RWrdGKe
 aGC6WDbepvy3/C6nC2fG5bpXTWYXtQUMSk53ccjD3NPFh9ne4hna8cAGnpdISWUlA1Vx
 Mb3BOwOUe1uD2Zb7pfMGZtLgtVZHnZZ+CKhgOxylvK8/GWEynDiWqwQ36c6xPtuKDCKp
 ztQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713785178; x=1714389978;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FjgYdEhWvwX0A9jBKVOxo1Q4kgonAvoLXDRpTOE3guk=;
 b=tHHDyF63QXCJwmtIQR1fxDsX6RnC0IEx7pElBdWLUI0uS+r2eAT5Bn6Py8ugoxHfkT
 25G79lqrtorTTmWbj2RYw/2DqsgdwkpV5KRGNDnoxKsTvoEOii5bX5evNTXQplj2tFr9
 u3u4m8BhNB53x8SLiaS+eKPtCeX7hsRf/snT2MtqiFfiaQiVjw0L/CHgh45j7b43dhdo
 67+WsL3/KR/jMzVNnHO0j9E6pXcx78nafPqrEdlgvl+Vfj264eBlYafV1JGsrTTVBsRh
 R7SPjsM7o7HWnF7gmOzJWaPXWCjI1kw8CXdb6me7wJBMCyK23oeRlDJk8j40xe+ZITv3
 WApw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIZIpiTHXKS5V8Wc6uassqVSeQ+woCVaFFpORmfn6XZzP5ygf4U+est8o5IEujRQvFjme0bURcRpEUeGeRR7iiz0ASvK4=
X-Gm-Message-State: AOJu0YzCJTh8Gywf2UdPh2ijrurXzsDeVxAlPr9uOcyfPhfrZYphm8Yi
 0Kt5y/ImULBYpisLuUo+h5Y8lyoCZjqoWHGH2zvN8pwMxeUdp0cvcvg770GbiKxsin123xiIgF2
 X6hmkgNrEAqBvL+Ht9sDVCEkZ0kS7K/knpkg+d7DFAOlRIu7L
X-Google-Smtp-Source: AGHT+IHyHFX4hCplPonZWlyRKyp4vn0PtKlMh4C/Dv/y7Fo+UC/d9xxmZIDQl5SV+9JwrNEt9hvCRVHwE8rdsANgewY=
X-Received: by 2002:a17:906:161a:b0:a55:31e6:dddc with SMTP id
 m26-20020a170906161a00b00a5531e6dddcmr12106855ejd.23.1713785178459; Mon, 22
 Apr 2024 04:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240419183135.12276-1-dorjoychy111@gmail.com>
 <f397f267-06d9-46c1-8acc-1c9ebf9c3773@linaro.org>
 <CAFEAcA8i_wU+RSRk+D1L8YKy72zHz4YFV20r2Z7m+3ARfzb51w@mail.gmail.com>
In-Reply-To: <CAFEAcA8i_wU+RSRk+D1L8YKy72zHz4YFV20r2Z7m+3ARfzb51w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Apr 2024 12:26:06 +0100
Message-ID: <CAFEAcA_kHDGWVic=xRm4xOsi-cQC-fF5Z2FWRCrwe_E35KBmNw@mail.gmail.com>
Subject: Re: [PATCH] target/arm: fix MPIDR value for ARM CPUs with SMT
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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

On Mon, 22 Apr 2024 at 11:46, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Sun, 21 Apr 2024 at 06:40, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> > > --- a/target/arm/cpu.c
> > > +++ b/target/arm/cpu.c
> > > @@ -1314,8 +1314,18 @@ static void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
> > >       }
> > >   }
> > >
> > > -uint64_t arm_build_mp_affinity(int idx, uint8_t clustersz)
> > > +uint64_t arm_build_mp_affinity(ARMCPU *cpu, int idx, uint8_t clustersz)
> > >   {
> > > +    if (cpu->has_smt) {
> > > +        /*
> > > +         * Right now, the ARM CPUs with SMT supported by QEMU only have
> > > +         * one thread per core. So Aff0 is always 0.
> > > +         */
> >
> > Well, this isn't true.
> >
> >      -smp [[cpus=]n][,maxcpus=maxcpus][,drawers=drawers][,books=books][,sockets=sockets]
> >                     [,dies=dies][,clusters=clusters][,cores=cores][,threads=threads]
> >
> > I would expect all of Aff[0-3] to be settable with the proper topology parameters.
>
> As I understand it the MPIDR value is more or less independent
> of the topology information as presented to the guest OS.
> The options to the -smp command set the firmware topology
> information, which doesn't/shouldn't affect the reported
> MPIDR values, and in particular shouldn't change whether
> the CPU selected has the MT bit set or not.
>
> For Arm's CPUs they fall into two categories:
>  * older ones don't set MT in their MPIDR, and the Aff0
>    field is effectively the CPU number
>  * newer ones do set MT in their MPIDR, but don't have
>    SMT, so their Aff0 is always 0 and their Aff1
>    is the CPU number
>
> Of all the CPUs we model, none of them are the
> architecturally-permitted "MT is set, CPU implements
> actual SMT, Aff0 indicates the thread in the CPU" type.

Looking at the TRM, Neoverse-E1 is "MT is set, actual SMT,
Aff0 is the thread" (Aff0 can be 0 or 1). We just don't
model that CPU type yet. But we should probably make
sure we don't block ourselves into a corner where that
would be awkward -- I'll have a think about this and
look at what x86 does with the topology info.

thanks
-- PMM

