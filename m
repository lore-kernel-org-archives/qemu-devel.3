Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEDEC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 10:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Toz-00036w-95; Thu, 02 May 2024 06:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s2Tox-00036Z-CU
 for qemu-devel@nongnu.org; Thu, 02 May 2024 06:37:47 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s2Tor-0008GV-Lq
 for qemu-devel@nongnu.org; Thu, 02 May 2024 06:37:46 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a5883518135so873758366b.3
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 03:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714646260; x=1715251060; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jwmdkreHFVl+O7wxHZLFM6WfWZrk3E53VhqxpIwqvkw=;
 b=u8rMRGUuBhHnkQXUgiHaHZ8wHSZh0ZVBQWCrl4IiZsmXVcucov6cm9MvadRSuDjI+S
 i0Ex/NLcZpkB7+dGENbFj79rAexWkwsyOt5GcyNqSbNr8cS8djfBacw9qb19eWJvO0Sa
 FtWrasZrpNya5v4x6X0q26RuTdAcAe6gQyu+liuwVcuDJgYEpE+0FS+8TVxDuPIBsAmh
 qVz9B7u31TSbwuQ7Q43hDspRaM5zlXJEHvfUDBHVpVhuZUIx0PtZfcxGyGfQNckQ1LuB
 ez8pyr3yw2jXmzw/Zj9QNSW8XVhzT11R2vLg2Nh0GiWS9mRpq9TO9om2b35ZFOkwtUEt
 y/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714646260; x=1715251060;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jwmdkreHFVl+O7wxHZLFM6WfWZrk3E53VhqxpIwqvkw=;
 b=RMjRPAz/MihkNRY/LP+4Zu0iGF+4wN62ntSBuFD/3Lw5s0gZBIZmgdXIFJe79AevMj
 LrrkJr/6IplCKwdRWf28jrK5GMajZOYDonibDZvY6NQSyUMZd4qmGV5l+cMgCXesTdh1
 SYndThBarporRDduDWV9+g8E6vhQsuB9EfcWKYAhE0eJ1ZJDAwby/DVy6kMtg6GbcOoi
 J4eVqDlBVMsqlKQJIvlhHZhxdUhgSDWs6mabXY2p6oP2LRtLBt3vspYSXjppEVsEbYLq
 NAHxTb8RbsoExz7ZT+qHdsfYBkTMtBn6i6ZU6oRH7NklzFmy5rHlH9HElOCiz6tlf1qS
 BpyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVS7p9hppKQER6hGW9GmmMwAPQ7ENnJ3bP9mUi56NZNyv/ieTZ2rU8ooRh4M5nz/UmCM4yTK8G++6jo/bmFmOd0vej6YE=
X-Gm-Message-State: AOJu0Yxbg2otOjRKCZFkkwfCecfOfTd+5qoIqfsBB/0qAHcn3dZCvDMY
 GWMVQDI/1L+s3i1zV9y68woDtj7jSXzbP8H03CUZ0XAbHJxM6+BHrfvxWrSt9q1vhrhu4Qe46fR
 FkLICB3Lwu8XBcXqWkEtne6/Al7gGYUluHL65zA==
X-Google-Smtp-Source: AGHT+IHXVs2egWEpf7+796aq42I3oVKEoRwtUVHtREEbXOcsOtWjfhc414TMmhxXekLlI5ObWl+ZlokNVgBO9TbQNiU=
X-Received: by 2002:a50:a6d8:0:b0:572:707f:1a99 with SMTP id
 f24-20020a50a6d8000000b00572707f1a99mr3658456edc.25.1714646259892; Thu, 02
 May 2024 03:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240419183135.12276-1-dorjoychy111@gmail.com>
 <f397f267-06d9-46c1-8acc-1c9ebf9c3773@linaro.org>
 <CAFEAcA8i_wU+RSRk+D1L8YKy72zHz4YFV20r2Z7m+3ARfzb51w@mail.gmail.com>
 <CAFEAcA_kHDGWVic=xRm4xOsi-cQC-fF5Z2FWRCrwe_E35KBmNw@mail.gmail.com>
 <753b3a55-9589-4dcb-b656-8b3025e847df@linaro.org>
 <cb2d4f21-8853-47af-a78f-e0db65460f46@linaro.org>
 <CAFEAcA_aN8ntxKuGPJ=M_Y3dLNjYEV-v--wK1hK8PyOxKSt=zA@mail.gmail.com>
In-Reply-To: <CAFEAcA_aN8ntxKuGPJ=M_Y3dLNjYEV-v--wK1hK8PyOxKSt=zA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 May 2024 11:37:28 +0100
Message-ID: <CAFEAcA8+C1JcvF1WBN3ZkqbROZVTM9+UDnA5OaTNoOcKuBa4OQ@mail.gmail.com>
Subject: Re: [PATCH] target/arm: fix MPIDR value for ARM CPUs with SMT
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Dorjoy Chowdhury <dorjoychy111@gmail.com>, 
 qemu-devel@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, 2 May 2024 at 10:11, Peter Maydell <peter.maydell@linaro.org> wrote:
> On the QEMU side I guess we should strive to set up the MPIDR
> fields to something plausibly matching the topology as defined
> by the user on the command line. Unanswered questions:
>
>  * I guess we need some kind of back-compat thing where for
>    old machine types we continue to report the old MPIDR
>  * what are the constraints on the Aff* fields (eg that kernel
>    commit suggests Aff0 shouldn't be > 15)?

This one is apparently related to GICv3 -- if the GIC doesn't
implement RangeSelector support in ICC_SGI0R_EL1 and other
places (advertised via GICD_TYPER.RSS and ICC_CTLR_EL1.SS) then
there's no way to send an SGI to a CPU whose Aff0 is outside
[0..15], and so you shouldn't build a system with Aff0 > 15.
QEMU's GICv3 doesn't implement the RSS functionality (though it
wouldn't be hard to add if we really cared), so we should also
keep Aff0 in [0..15].

We have ARM_DEFAULT_CPUS_PER_CLUSTER = 8, which does keep us
in that range. I don't think there's really a good reason for
it to be 8 rather than 16: this might be legacy from GICv2?

-- PMM

