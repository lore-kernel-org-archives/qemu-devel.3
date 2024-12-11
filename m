Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8702BE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPDE-00016r-Ps; Wed, 11 Dec 2024 11:05:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPDC-00012Q-63
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:05:18 -0500
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPDA-0005EE-Mi
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:05:17 -0500
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e39f43344c5so6346272276.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733933116; x=1734537916; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r1US8HCbPSTdlPt7AiAeBmc22Ii1leBluTUaRfuCUB8=;
 b=CEKPUKwoCi65uG3EyPKki0tqgnbQ5lp6jKQxJnIFb69vceBjz5whHE7+n8ebE8Qu03
 AZfj7uv+ItGlZw6o/bPSbOUHelZCG+PwOs2jv5HVtLY/jWLMROOWIiX4PjWV7karqDP3
 i4KE6P5UiMhCXotB6GWJuAQvVloehsL+lrb2LF5XxaGcW2xclOIw5Dn8t76yyrl4/8lW
 kDRAzaqHHqnw/WZjBuXTgXnrC42qdDIT9ib6uz7vnLkS3GAlUQTo8h8um305hTWE6JpM
 IFdJKXSY0fRhPR/E3SbJUkIuxtG2zsfgCl6b7Pp2UVvSBeREUHS4PkCSUbfiFc01sb5B
 IQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733933116; x=1734537916;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r1US8HCbPSTdlPt7AiAeBmc22Ii1leBluTUaRfuCUB8=;
 b=RJsbz1HJIPI46tOOZaJ91caNlrmhx422A3gO0PfVbw8Wxlne4q6TD7RW5/KPZuSyBI
 nzvyq4X6qHrHjoSUa9izJar/CE9gi7uQEgggdd/CjFzj4cuY5DIPOpsgFQ44BaValxK3
 laQ8KbPZi/K0Noak6WDMhioFHZ+ym9mI3gVRPjEdq8Mp/kx4cqwgaXfZfS7rCWsR42Ca
 UY96pxCsZDz4PzkCHyL+Cpmyc7tURa1DBsNbDuJsg1tD6aCpUmBHzv5fFDGj722JXPYK
 P5IZI4txm191x3xqBV/jB5eqxJX4J2/SY98u+NSPXLeyQAMW5EMxfusO0NLrLFuJiRdr
 kWqw==
X-Gm-Message-State: AOJu0Yy+F+vEgIXE7wDBSi8IvfD/pLWIgLKGkjoRk9DjphqrM2UfINEk
 1EfoY0Z9xnztJqTQlV5XDYqJL5owC7AglMl61V9pZGg3MLhDmBzMCLaSsvBmut0kemkE5/ECS7k
 ao6+L7+EQ5Mi2N1ICPFWuTZltoGfd3xLZ6d7rvQ==
X-Gm-Gg: ASbGncuX3s9LijPL4V+OjuH1AvxTj2mDUKV3U3N8/ZHwtHlybqapRFPl2RG6ra93LqD
 5c9axg7dvBjNnO3FkB5KbcenxoQ38p5Ql6nMi
X-Google-Smtp-Source: AGHT+IELsLBthjQfPnDEADBaWb8Xj5sexSFRsUzuPA8yB2H4UrBiYqV47aKoITkv032OT/dvaZzQ8YuAOkZMrt+UGuE=
X-Received: by 2002:a05:6902:210e:b0:e39:6c6a:f2de with SMTP id
 3f1490d57ef6-e3ca057c844mr349466276.47.1733933115734; Wed, 11 Dec 2024
 08:05:15 -0800 (PST)
MIME-Version: 1.0
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
 <20241210161733.1830573-61-richard.henderson@linaro.org>
In-Reply-To: <20241210161733.1830573-61-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Dec 2024 16:05:04 +0000
Message-ID: <CAFEAcA9=CsKJ8JtMO8ocvmL6odk0eCRwQwm9V+LAOa0nRphB7Q@mail.gmail.com>
Subject: Re: [PATCH v2 60/69] target/arm: Convert [US]CVTF (vector,
 fixed-point) scalar to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

On Tue, 10 Dec 2024 at 16:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Remove disas_simd_scalar_shift_imm as these were the
> last insns decoded by that function.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

