Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36537C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 09:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXGKM-0008V5-Gh; Thu, 03 Jul 2025 05:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGK7-00082Q-Fm
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:33:43 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXGK5-0001H0-Nx
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:33:43 -0400
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e898fb745beso622299276.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 02:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751535219; x=1752140019; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qDNzk/7Z8Ql5XkmBp2VnyJwQr7oP/mQM40aWPFYuK2c=;
 b=SykqcK90E5SnPpXRU6hhXUtx8o79qkGo0tAGcEhbsn5ltcDtzzQbz1zWfV8zwAK7fR
 aW3tkLI0pQ1KAuIEGql2n5QCDmddDUOwY4dDj8pj59O56J3w/ZZ0NutM+ebZii5hYOUZ
 q3mU/R4q55mmnIj0NEq6QH+b5Cp6PlFJAa7ocLKox0onUI8E5SueTag8DebXz+cv0QvP
 Pm1LHWGgIGUXHQMCjv704FJ2aD+BNFjSO7m37GRNeF5bEfPREnk3p8IGVEWHgA4/PB/b
 riWgLsN4hBFfgtvzfmNk2mdmZgufxdk5LOyY9pJP6glyXTVKoIf1h3s1hAgxl5BhLvKB
 dWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751535219; x=1752140019;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qDNzk/7Z8Ql5XkmBp2VnyJwQr7oP/mQM40aWPFYuK2c=;
 b=xRB8g3IL94OknR+oE/MtANe4XvaOajyrF6N4muQPtRZIvrnb0MV2AT16T7jyK59hRv
 PAhtSIDaRYVk58B4ruv6ppopmWPA+h41J3bSqoQVD4mS9HOOV9w0ratM+lIgvZdrK56y
 ZvbMCHrqvwQ9Ht9BQNEld3TkGYg4Ho4CrVYgOInYKPq4/pVOlAlHzgmjMWTiBlvr1/Sb
 JbyiHMQ7R6QWoTx0vWv2TR0qa2FqchfdtqsaQu/Sryt9HgNZT5s++5C0YIkqTkhbQFir
 99FRNDHh4QQgi5tyhlKGhnugJO/Aa0m+qrZYvEIHw62vsOGFpaf25UdO0c3LAvAMwaBz
 F2AA==
X-Gm-Message-State: AOJu0YzqYTyaZe9St6NM27Q4E68LemWxIVk+N/U03TqGlvVIZTgGfTUx
 DmHQCtNEek5oWvEpZnK1mXqND4hzNA+bNLJln5gbzuPc8R0JUSX8PjE7UV6hqngjLfxk0mO8TvH
 yPr+rPA5UmnczK7snANEzXG/tgK4lf2w7XEPB/3eDEurXWSXL5w34
X-Gm-Gg: ASbGncvtkA49q9CZfAQHXBEyM3CiwjUmYDbkAyBgQNFeWAMd5MZpbEKFDFVQbMGet0Q
 3B/oxWTA866yjYLKQ8XXQ6lj5WRu0rlHP0LXonPupg7rFKKCHIaYfdcv8hkETIZIveZ+VhzR2B4
 Z3G68sucfJeoHQD9W6/c7liMAgVPhjFWDgbXqaC6Lo/EDF
X-Google-Smtp-Source: AGHT+IEdhWsEcwFx//xsSiASuSrqiNoCrICdYRpu5YGmw/+CIayY8WrR07aKlUQfkN4C3kYLB+VA4Sbg35urypYiduo=
X-Received: by 2002:a05:690c:3610:b0:70e:6c9c:e123 with SMTP id
 00721157ae682-7165c8affb2mr17761407b3.0.1751535219085; Thu, 03 Jul 2025
 02:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-15-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 10:33:24 +0100
X-Gm-Features: Ac12FXxe2aRH_m_GhpTXtuqo8m_T0t3Cv_XqmpU0PR5p9rzvS6cq6SbJSHbHAD4
Message-ID: <CAFEAcA-6mEnG1BKoP3FfhgrqVUg04Y1MY-pV0M69M8cvkKCo7A@mail.gmail.com>
Subject: Re: [PATCH v3 14/97] target/arm: Introduce ARMCPU.sme_max_vq
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
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

On Wed, 2 Jul 2025 at 13:34, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h   | 1 +
>  target/arm/cpu64.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 2f2c131613..b5c4fa1e80 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1118,6 +1118,7 @@ struct ArchCPU {
>
>      /* Used to set the maximum vector length the cpu will support.  */
>      uint32_t sve_max_vq;
> +    uint32_t sme_max_vq;
>
>  #ifdef CONFIG_USER_ONLY
>      /* Used to set the default vector length at process start. */
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index c5c289eadf..8400c7b567 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -343,6 +343,7 @@ void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp)
>      }
>
>      cpu->sme_vq.map = vq_map;
> +    cpu->sme_max_vq = 32 - clz32(vq_map);
>  }
>
>  static bool cpu_arm_get_sme(Object *obj, Error **errp)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

