Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1A4C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 11:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2UoV-0005BD-0d; Thu, 02 May 2024 07:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s2UoA-0005AF-BK
 for qemu-devel@nongnu.org; Thu, 02 May 2024 07:41:03 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s2Uo5-0003Ce-MW
 for qemu-devel@nongnu.org; Thu, 02 May 2024 07:41:01 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a51a80b190bso507181366b.3
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 04:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714650055; x=1715254855; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JhJewUJoVLdrFN5sneQZXJ5z8Fn//kckeRZg9V9cBh4=;
 b=N+idCJxS0IBNNr5ytvQZjIZPSc2KzzvxF/3m2ggHMXigORSSuTdQgG86pcx29KdN+V
 oYnX1B745YRkstIEv7kvELE3YkSTQlbhv8i0YW6x39OlI6k2+gNDZpR3kpkNsSFYCDMV
 D8mW0dKEJBY7VdD1x5jjpOrHvZAry2KIsLluXzYlsQUXjCxvDwOsl0mlpYpqOanj22ki
 YFw30rKpbrkHspNnnGUZcitzKNbiepaBrvM5uaJ2R9a1q/9XUD9AQ5LBd4sAwjWCrVwQ
 RGiPxbuA6jxKmlN9m6UWHNrUjTQnv7VSwZPS/2avuD2S30sZ9vc6Q5j4CTkdAxQKb04n
 HVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714650055; x=1715254855;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JhJewUJoVLdrFN5sneQZXJ5z8Fn//kckeRZg9V9cBh4=;
 b=pcaOw6QKvdCrS3KcOVDdt7iPimjd6S6c75ahc7aczzyJ49gFjV/06KX8K6+HdflFj0
 If0VTEghaMYPfAZIk9lQINSxdEBC3b69VDLdTyKNFKK+9MRFX3KCo0QfbzlXc/1Q/Arz
 0/3Dbr+P4Xy2YI4MSeLeWDhDey3HKQ1P5YVVEpW6IUDbz8nNAaFgbL/D/y86fdrmKtkD
 Bd8VKyAAB3qmqWlEbE4KwUMCNZWyzDgCTDOoQksUdn0cvXxeXQerd3oaBhwdWFBPk7AB
 37v9RbUwzxNN7+/q6fL9NecUYQEt1n+1am68cpXFq7O6mhoYrDLfJRHbIiPSzbe1/c3D
 s4GQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw5hjB3WQLK13Okuwac2uGa+FcGA8DvUupsH2KECyEq5GRpyGC7/L8erek1FwyjpHGQ8ocDhIQxR436EHcBcATRAcyp8E=
X-Gm-Message-State: AOJu0YxM9+FN9vhcsjQXCZygY2FULyZGn34Nnpqk3Koh9IXkYRgCDj9l
 1AtoU40zreJQCuQRj7NP1Ru1ioISVaTL6Uwfg9fU/GJfq6h9KoxKB/bmmpQ7pL8HPk8VpSp04hu
 BO+SHHd6INsuNF8+Hy2P33IyedWUtdAC1NT4nag==
X-Google-Smtp-Source: AGHT+IHk2U1K0WF0QAE5EXgB7FclqhdFFzNV4RG6KUUbfr0YkFr5RRuFJQ37/Og0uQC2a4AVTK6OJFxxYShsgaI2Rh8=
X-Received: by 2002:a50:9b19:0:b0:572:4f:4efd with SMTP id
 o25-20020a509b19000000b00572004f4efdmr4242566edi.21.1714650055157; 
 Thu, 02 May 2024 04:40:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240419183135.12276-1-dorjoychy111@gmail.com>
 <f397f267-06d9-46c1-8acc-1c9ebf9c3773@linaro.org>
 <CAFEAcA8i_wU+RSRk+D1L8YKy72zHz4YFV20r2Z7m+3ARfzb51w@mail.gmail.com>
 <CAFEAcA_kHDGWVic=xRm4xOsi-cQC-fF5Z2FWRCrwe_E35KBmNw@mail.gmail.com>
 <753b3a55-9589-4dcb-b656-8b3025e847df@linaro.org>
 <cb2d4f21-8853-47af-a78f-e0db65460f46@linaro.org>
 <CAFEAcA_aN8ntxKuGPJ=M_Y3dLNjYEV-v--wK1hK8PyOxKSt=zA@mail.gmail.com>
 <CAFEAcA8+C1JcvF1WBN3ZkqbROZVTM9+UDnA5OaTNoOcKuBa4OQ@mail.gmail.com>
 <5da6dcc6-2c00-483f-bf33-cbeb3d931f2e@linaro.org>
In-Reply-To: <5da6dcc6-2c00-483f-bf33-cbeb3d931f2e@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 May 2024 12:40:43 +0100
Message-ID: <CAFEAcA-mwRWTe_getRR5Ap3ycY+BvpyyVuCOFQABHvJMWv5KgA@mail.gmail.com>
Subject: Re: [PATCH] target/arm: fix MPIDR value for ARM CPUs with SMT
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Dorjoy Chowdhury <dorjoychy111@gmail.com>, 
 qemu-devel@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x635.google.com
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

On Thu, 2 May 2024 at 11:56, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> W dniu 2.05.2024 o 12:37, Peter Maydell pisze:
> >>   * what are the constraints on the Aff* fields (eg that kernel
> >>     commit suggests Aff0 shouldn't be > 15)?
>
> > This one is apparently related to GICv3 -- if the GIC doesn't
> > implement RangeSelector support in ICC_SGI0R_EL1 and other
> > places (advertised via GICD_TYPER.RSS and ICC_CTLR_EL1.SS) then
> > there's no way to send an SGI to a CPU whose Aff0 is outside
> > [0..15], and so you shouldn't build a system with Aff0 > 15.
> > QEMU's GICv3 doesn't implement the RSS functionality (though it
> > wouldn't be hard to add if we really cared), so we should also
> > keep Aff0 in [0..15].
>
> Arm/virt uses 8 cores/cluster on GICv2 and 16 cores/cluster on GICv3 as
> this is amount of SGI target-list bits available.

You can't have more than 8 cores full stop on GICv2, though,
so you'll never be able to go beyond 8 cores/cluster
even if we didn't impose that limit.

-- PMM

