Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9348C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 10:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA5Kb-0000j3-7D; Thu, 23 May 2024 06:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA5KW-0000hL-PG
 for qemu-devel@nongnu.org; Thu, 23 May 2024 06:05:49 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA5KV-0005Gv-7N
 for qemu-devel@nongnu.org; Thu, 23 May 2024 06:05:48 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-574ea5184abso12054541a12.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 03:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716458745; x=1717063545; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w2e4UvwgiH9S4kLkyXGGu+7yChD2bqVWINfiO3Y1j4c=;
 b=amX6xIUVFvwizYIzGKVsziwCpJ5/nKAga3hIYHi/A2lCW4cu1J0NTrgmf6ftn575Kh
 Xjm5Nnnhf99eiZ/fA5opjO6poNAccVYtr1sHrxW54J8j8uNf9Ywf5qKglNhVSx/ryHdz
 fo0ceQw2e5opZ5q5AzEMSV/UBvOW/TX8Ep1jgrt+STxyIKJWHdwZP1JjJlky+pLN8wfM
 bX+9W04Iyn76x3D3YHMNdnW5AFUZl+/OUT2nGYcIR7j4cYVTg8SQ4hSz3FkBZnDs80cv
 TnXAdKhqTRgiVKwOIgucvC03heu2phFuBCX78X5hxNZwl1NJ8tlk/fxw87TtLmi5H+9B
 kHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716458745; x=1717063545;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w2e4UvwgiH9S4kLkyXGGu+7yChD2bqVWINfiO3Y1j4c=;
 b=F+KUvTGyLkGBR5VEKZqFKMPbkQTfkHhXgdDF/tDxPmiiKJoZuFGQ55gaLNpfeK97Fh
 NuWOttl24ofRaC5Rlz3ZeKR9NU5hbo1lfr3wqagmDv4CqO63au6AGQrkb/0azhGPflvy
 zl+fg+XmQPAbdUWCTa2+DegNz1BW3WibXKXDz6ohHgLgPqWv/rKhpSmzDr8t7RyXMlIS
 fe/a26Fkbp8PC8dwLMpD1ilCXT4v8sS4BonohyRGjecHWaiYyUR3RjN0sHg1qR9+Y70F
 MadEsYRet6kuoACb15jsmi8Z7TPjNYN9816/yipCv5Y8HNkmVSROueNrqp9N6sh+9bQi
 hQ4A==
X-Gm-Message-State: AOJu0YyF+Fz6QYt22TLL1sSpsjiRBAKQB4f4egxLprsOTWVtuHIxs8bL
 j7Y9z2lWFDFpLx0ERlWnRpZauKtbKBTOYdGuKopeGVON8fLDoYatMKBHS8yrOFr06exPK1xy7FC
 jD+LqM3wUneQInpDEvH0DEsQ+CrVSwKvIo4dmXokD1kPRP3yC
X-Google-Smtp-Source: AGHT+IGO8KaFPhRtJZsj7GYji0aZ9Q6Iy2M32ZZZFzdt3zMfy22M1pHwxeZ5H0TVP/u56+ulRqwnkzVIi1/1N0wrPjI=
X-Received: by 2002:a50:9b12:0:b0:572:a723:f1f4 with SMTP id
 4fb4d7f45d1cf-57832a01b31mr3159154a12.3.1716458744630; Thu, 23 May 2024
 03:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-6-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2024 11:05:33 +0100
Message-ID: <CAFEAcA8Gqt_h_Jf=hCcNB3vcDsZXvBc9dzkN1YsniBr8ZT+wgg@mail.gmail.com>
Subject: Re: [PATCH 05/57] target/arm: Convert Cryptographic 2-register SHA to
 decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Mon, 6 May 2024 at 02:05, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/a64.decode      |  6 ++++
>  target/arm/tcg/translate-a64.c | 54 +++-------------------------------
>  2 files changed, 10 insertions(+), 50 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

