Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1660C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 13:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXKMb-0006FS-LG; Thu, 03 Jul 2025 09:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXKMa-0006ET-Mk
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 09:52:32 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXKMU-0005uz-Qg
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 09:52:32 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-70e77831d68so59685847b3.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 06:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751550743; x=1752155543; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fiEXJuA4jGOdMWH0N2+Dj43mP+EiUIcu2HB9n8CqSn8=;
 b=H/8IUggT2o8ARyW35udVe6GxCPY6Kr3zZSfAWXUIa2mPoFrLhv+XSl51QIiuwgsajD
 atikJTruzORGI4gkRn9C6o0QOtoaOlq9uIUPA+pT9gqHOR3sm5U63PRAzVBHR2M3pyoP
 kaCfTuIRDaZ2QUd+UyHapHgqdYC2lah4qQMm1K2H/3R0MGbX5u0jr/zZeRbSh2uLpNAR
 gya76Dk7SPwVjndd9hSx+Xk5kWLetmW6RZMprWqvDDJdsYPVwtR4/VW3atpoMZ1lmvjb
 uFZIYNHxvhAVPl4a9bqGn+kPhl0X0xvD+qn7tjE0dFJdMKtMLqYiXm0iFqZ7tVgO3g9r
 d20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751550743; x=1752155543;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fiEXJuA4jGOdMWH0N2+Dj43mP+EiUIcu2HB9n8CqSn8=;
 b=tp0uq7r6IV2I7EEE6NIX5GyNonfOIBr0cruitJE0T4qZlgoRuhGlJ9TuD+S5sv5qpT
 7ytvPHdUv1IhrMnGyuUlOGcWDdTo+ppmjXmp3DKPhNyfE8popqwNfGzekpeqUuJ1TQ/n
 6ZelkdF4hKl3jyn7BUq78Dq1qmuORWGI+5ddMoO/E9G1wcxDxQ2pqsYdh9gnbaH1Dc6R
 KIPqjIO24Cy9YgkUlNi0NjKy6neasYYpRpRNhk7QYDkreGsTZAvwAjqD4xl/Rl2RWWsj
 SiTBPtBDOMLyvgRpAHee6aYFyYEJLGzAxnrkg68inJEMxTgZJapXOrkRukvrh1Uf3YLm
 xBYA==
X-Gm-Message-State: AOJu0YxgtlOVehvRy9FBZlsYeNev+bRMusHN70S/bG7t1QhAj6WfLk3c
 UJKsxjnefPJZ5Xyd6iSH3owonRSeKrF3oms3DVrkmljCjcACsYfzgHB1MWTOrhd0e2KMhz1V6z0
 mQ6pCFxfOcoDUd/x3mPTbjBVicTGd8Rtwc1Zbdtn20sL9AzLOYFtS
X-Gm-Gg: ASbGnctcdG7yHPHSW741+nuUdNay1rhgUaDrqpEIJeth1FB4/FUa1ayyR6IQdwCa9Xn
 6mzNFfLP7CvUjJkCW3kqwKk3b0ot/mrbRD733D/mvO0Em8LMFELHz1Tji/GKt/Kb7SsiCkL81IV
 Z6N53Ij6mV2C6KzvEA1F/FNUq6qcrQSX7+VjQPmZfwT2+I
X-Google-Smtp-Source: AGHT+IGtal3C9FUClHazLkbXCOqI0Q0w4ePiS6k9QSy3omS/tvmvxRqUzb6yM4eE/PtUO4++lPRByg+fMaoPPuY1Tqk=
X-Received: by 2002:a05:690c:6809:b0:702:52af:7168 with SMTP id
 00721157ae682-71658fd79camr55732987b3.2.1751550743024; Thu, 03 Jul 2025
 06:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250625214633.939709-1-pierrick.bouvier@linaro.org>
In-Reply-To: <20250625214633.939709-1-pierrick.bouvier@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 14:52:09 +0100
X-Gm-Features: Ac12FXwtBaAa5Xmx9bpVAg5o_RaKgd248KJnYQ9QDeU9UFplRUNf-S4lARNe4y8
Message-ID: <CAFEAcA-_JKVX9-uN_AgNcq3G3nzVk4e78qHymAgAy4wjUyh2DA@mail.gmail.com>
Subject: Re: [PATCH] tests/functional: Test device passthrough on aarch64
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, smostafa@google.com, 
 berrange@redhat.com, jean-philippe@linaro.org, eric.auger@redhat.com, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Wed, 25 Jun 2025 at 22:47, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> This test allows to document and exercise device passthrough, using a
> nested virtual machine setup. Two disks are generated and passed to the
> VM, and their content is compared to original images.
>
> Guest and nested guests commands are executed through two scripts, and
> init used in both system is configured to trigger a kernel panic in case
> any command fails. This is more reliable and readable than executing all
> commands through prompt injection and trying to guess what failed.
>
> Initially, this test was supposed to test smmuv3 nested emulation
> (combining both stages of translation), but I could not find any setup
> (kernel + vmm) able to do the passthrough correctly, despite several
> tries.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Whoops, I forgot to send the usual "applied" email, but I applied
this to target-arm.next and it's now in upstream git.

-- PMM

