Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB69AC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4HpI-0007FL-No; Tue, 07 May 2024 06:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s4HpF-0007Ck-MY
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:13:33 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s4HpD-0007j7-TZ
 for qemu-devel@nongnu.org; Tue, 07 May 2024 06:13:33 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a59b097b202so520057566b.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 03:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715076809; x=1715681609; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6Aup3QI/STFkqcNVUFACURmwtXFEnMt4IqIBYADkig4=;
 b=QCrv6zp98jETic95ENHuj7o3BuqJXl8qaMtIV6ZkC6clDKydxA3nbL2JTd4lAgnPjM
 I/O0dpOTouw9n+5b7mOqjVPh/tzmqsdcPskZsiSpakY6SEjr154IUAloKQSqxG+6myhR
 K3T8I0nh3YMzlHNKusC1x9PwJWqwU0EajuTkqEij5cqRFU77o5MlUugGY6h3aB0mR+qs
 Y9kDfGiCODJPcf8gOASufQA2raTST/w9KLd3+IbFrdhdmKaMC+v6smasKRBW5l3GipGU
 kV+ppq6ZhFnz6hHo8NDTC7e/CKE4ZckQ2ZrO7bldoSLVvxEQbngkP2QESdP2dkCdvoQE
 Jvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715076809; x=1715681609;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6Aup3QI/STFkqcNVUFACURmwtXFEnMt4IqIBYADkig4=;
 b=UbRYlsosP2FVXNWlxMOliuHLP65meBO6ZXudO6C/7CTwsRSEb/Tx7hbc6oxI20BXmP
 3hpMaojT+il7fM3kfpqVoam7rCHHx5XTZoD0HdXY2gdzagf+fPDUUybvrGoLExGFzgNs
 r4jBB6zJftF9AndUarVJfY4OmB5hOkFNb9VtPwICAByHjW02fS28B6nBDGN6ZzOmrh2U
 glJ3/DeJMwG5uGnUsKR+dyvS3aZSk7ZjqWrnVB63CLqXQMkswO491O6/GjTWSpEvn/Er
 PHaC4DPLK/GyDg7r6iRKbCDcYIy4Nt3HLWuLoNTKPk6e1BF4FMjhs0iIPGROVTFhq1We
 D+0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcR/Wnd0X4C/sZeDVXRFfEwIIlELzxMIlR8fn8xiCPg1aEFdhh04AnSdHF4D4AtNb8+U7Iit529gCZhCO3mYjGfopME1U=
X-Gm-Message-State: AOJu0YzqvVYp6C53zoqE99iyN/gFOo6KAtaNkn79YFXy5pR5bolDBN6R
 rBcHGxwMRcxNnBBx42H2cj4SqojrLtqMd9lIxuXAQg0o9ef9y5iM0BmvXbqAL6IChXudTt08/St
 DqxxWRDzdKgz4LNkbZlavJsiJzkbysUDAFTgu1324HuY4VZey
X-Google-Smtp-Source: AGHT+IFodJHyF2AeUEQEO9RuqnQr8yUAMcPQujUsDy6zbiv4NkDv5fti4XyGV3WQPdJHAfGOg9niLCjiKu1aqJQjQKA=
X-Received: by 2002:a50:cccf:0:b0:56e:2cfc:1d3d with SMTP id
 b15-20020a50cccf000000b0056e2cfc1d3dmr7470682edj.16.1715076809580; Tue, 07
 May 2024 03:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <a4cbfe6c-27d6-4df0-ae31-db0d60d88f9e@nppct.ru>
 <95ab6dcf-cc96-4472-93ab-f08682b37d5e@tls.msk.ru>
 <4c4dfebb-698d-466f-90b0-9475ad4c123a@nppct.ru>
In-Reply-To: <4c4dfebb-698d-466f-90b0-9475ad4c123a@nppct.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 May 2024 11:13:18 +0100
Message-ID: <CAFEAcA9fGmNx4yLv+4jTx+j1zTfkXXoaiZewqWHUZuxKSEiV-g@mail.gmail.com>
Subject: Re: [sdl-qemu] [PATCH v1] /hw/intc/arm_gic WRONG ARGUMENTS
To: Andrey Shumilin <shum.sdl@nppct.ru>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
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

On Sun, 5 May 2024 at 20:58, Andrey Shumilin <shum.sdl@nppct.ru> wrote:
>
> Possibly mismatched call arguments in function 'gic_apr_ns_view': 'cpu' and 'regno' passed in place of 'int regno' and 'int cpu'.
> Possibly mismatched call arguments in function 'gic_apr_write_ns_view': 'cpu' and 'regno' passed in place of 'int regno' and 'int cpu'.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
>
> From 23b142f5046ba9d3aec57217f6d8f3127f9bff69 Mon Sep 17 00:00:00 2001
> From: Andrey Shumilin <shum.sdl@nppct.ru>
> Date: Sun, 5 May 2024 20:13:40 +0300
> Subject: [PATCH] Patch hw/intc/arm_gic.c
>
> Signed-off-by: Andrey Shumilin <shum.sdl@nppct.ru>
> ---
>  hw/intc/arm_gic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Thanks, I have applied your patch to target-arm.next (with a
rewritten commit message).

For future patches, it would be good if you can sort out the
mail format issues. It looks like you're using Thunderbird,
which ought to be configurable to do a reasonable job.
In particular, if you can set it to send plain text only
(not plain-text + HTML multipart) for all mailing list
messages that will help a lot. That will help the automated
tooling to have a better time trying to interpret it.
You might alternatively consider git-send-email.

thanks
-- PMM

