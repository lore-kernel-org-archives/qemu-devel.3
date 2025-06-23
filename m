Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25479C77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTgFS-0004RZ-7k; Mon, 23 Jun 2025 08:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTgF3-0004D3-Fa
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:25:41 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTgF0-0001uY-AS
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:25:41 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-70f94fe1e40so39947167b3.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 05:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750681531; x=1751286331; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iOtuCzhi55Q0saX8rrN1nyWE5gkK0uW5WLHzEHJcXF4=;
 b=voNRKg7rfEbvYkqVuGPiZbK5+jWRyUkJ3H7b1/jBy5PaNrG/Q8+dCxWAaFK0AsD0aR
 waqyAm+47fXtRv3zXXwU3PJulmVTqJmtiKBdANmm0u2p9a6VksfZ70lm02LEg4LtrhtH
 edpcIKTc/XTjRktcwHBi69c89mdj1KYOByp+8i8xtEQ30Y68cNc1jElP6Po95HZ+2wte
 O5cStnWGxK0xKYMXjjSa/DAmXdkbhIlsU+6JG48q2Klp0mcweNJpg3eGkOgv+2quQtA8
 g2rr65QhfB3gXQ6uK8MmSvQJDNqh7GV1LeQa8J+a9IQ88srfQrd/8d3cxDftBgqUpbx/
 hr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750681531; x=1751286331;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iOtuCzhi55Q0saX8rrN1nyWE5gkK0uW5WLHzEHJcXF4=;
 b=RWH/dwDF12tJVnV3N6NleAop9j8mv1XJcDWOjKnGuaXrR7Oc9KyJ0QxoUzBYSSR2tB
 BjuXb/o2fcUGbtJE9Z6avKhiskE7IMzzM7BAevzmFn2t1JP27LwN1Ojih4BdH+pREx1U
 4PpG4mo9p+1MNV2pPIUIbxv0KsxJCxJNDB3dTNwVmcjtAQa/na7wmwTepYpVZeaBeeEt
 gFO2xos/zCU6WP0wt4kj+8NWT7w/rccPouC1tyQVY1ZBk2j8XIPF5qc/McutxiH9vdID
 SmCh3WU/tkJAK0T5d/dHWzGyAKNuBdyj0WYKCx78TspRTP3fWR9bXB1ezOCfvFNzGitN
 oqmA==
X-Gm-Message-State: AOJu0YztsYAfvh24DNWuSX/VnorBgr6Ea1L+4FszMRBR5HS/IBPdil+j
 mf7sdMu2rualxppY9w+tcQ0rikqGItBAX/iVrt29yR9JugA4goNRGaGQ/xdHM44YQ5JZIy2vXlu
 AehKKZ6DIG4uT/XFRKZO3njyb4hMFveF+Eedv98uBTZmG11uDcMR0
X-Gm-Gg: ASbGncs1J05yhVE8VnQXiQZ93pra0Duk0VHwE6OxdxYpe2UwDea/lDE9u33HC7xkQUU
 o9Y2NrbajyZTgFbNecJiMV6Q1gKWKxtzkLvONTqRieHpUZobXzAvG857xk91IhFFdQ9Emp4aAMa
 SV9L++OMQIyehKopinb61dmba6CBpFIsT3C6a4Rn13J9MW
X-Google-Smtp-Source: AGHT+IGfa2Yx6j0hETW+n0hhz8UfWme2sFx64UDlgIRu8DJ1ll6n9yRRo3I8BiUCZEwdtWf+v33s6yne9DtevE3L4nU=
X-Received: by 2002:a05:690c:498c:b0:70e:6c9c:e123 with SMTP id
 00721157ae682-712ca337320mr152276417b3.0.1750681531496; Mon, 23 Jun 2025
 05:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-21-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-21-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 13:25:19 +0100
X-Gm-Features: AX0GCFtzYrcdNCLa7ouEbfLwQ7KfFwrSiAF9e-EgIRnTkz1iLA3fSXeYG9znvjI
Message-ID: <CAFEAcA_MXNMiPau+udbxefNX3waPj5dM2gnpzxkTGPm=oKM=5Q@mail.gmail.com>
Subject: Re: [PATCH v2 020/101] target/arm: Implement SME2 MOVT
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Sun, 22 Jun 2025 at 00:59, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sme.c | 13 +++++++++++++
>  target/arm/tcg/sme.decode      |  5 +++++
>  2 files changed, 18 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

