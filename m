Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFAF9C25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 10:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA5YT-0001dS-BS; Thu, 23 May 2024 06:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA5YP-0001ZE-Uu
 for qemu-devel@nongnu.org; Thu, 23 May 2024 06:20:10 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA5YM-0007jS-Ag
 for qemu-devel@nongnu.org; Thu, 23 May 2024 06:20:08 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57847c08e0cso693505a12.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 03:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716459604; x=1717064404; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YSKJynSj0E3qnZhoMM3nAwR+TUoxebdocPhmdy5mH4Y=;
 b=cUNpT6Z+FstWJyd3u4337q05cWR2rHfMLZ9kEcAPpesV5YQnq0mlj15Ep1re4PsakH
 Pp7Jubluy3Q1HEC70mTAcHtBc52ElZqX+sXSYhXLxnmKcECZQ40aUhz2rPvLEO6rRuOX
 PC2wh4vJt25c6iCIvo06IbTy01yCmq1Gx3uLqtnyFKx3Y771mniOS2KyESKZzHbuPcQ5
 oI/OWp/AN4KN8XtVVecZc+pEdV2J6Oupb35tJtdBtszR1jdGUQv/20bND6w1eASF/Vyr
 UfTThJGf55VBW6yrQTSD45kTgZ1O1qZihu3B++1ktId9I6jdnyHk9zEraBU9Zf5XlxWx
 edIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716459604; x=1717064404;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YSKJynSj0E3qnZhoMM3nAwR+TUoxebdocPhmdy5mH4Y=;
 b=UxKnqMlhstEPGeLGZi7oA6LCQsinGwvsQ6gUxYXEioNJAAeC+Qvp2IhCaJ82+uHDNU
 CerNqwXF6t2Kg9UoITkOw4fnYLa3FfPOKYT/6Jx1YUWEV3A8TRxdkyJBcDe1GJiTQDK8
 2UWW/IvNdue6+VMiD+Ozy+Vnrc5Z7X/scAaK0xP6NdTlGwX7fc3EUISFr86LThb8gnwt
 oSzMXlJeJlIHN2MQrxDQGm6Odk9x4lmwAhz+l1/15T2nCTCED2RwrD2dOjDYl70FKiSb
 OwnH57MCYXmpIsf6/5/oW+e+h0yY8WYDDGh3jD916JP4VJVEW+7+ULy6nWpRlpi0J25q
 0xyg==
X-Gm-Message-State: AOJu0Yxd8GXQWsPtrRL8OqL6IrkXWjrXcgmL0mbYxfdyVqD7natpmhiR
 5Il2SY4cZnjESgJcMzz+xfhlwK+uR0gAZ6ULlMM5HS3cvtt/3UqjocYGMtXxmcFfDDXJyuG8Hw0
 KXRkZBxvuVANTtu9Ncx2fvN9Xik52Nq4/GRMi/UZoKYWha+2M
X-Google-Smtp-Source: AGHT+IEMfP4qEU8ALNtHpuJEmnjdwWu9fI3sKEA0fbhY3qSQpqHq7D2ZAPhHh148PhBXtFqaoAYyh6seLLuexhfI9gg=
X-Received: by 2002:a50:871e:0:b0:572:a049:c797 with SMTP id
 4fb4d7f45d1cf-57843ebd123mr1475369a12.12.1716459603825; Thu, 23 May 2024
 03:20:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-10-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2024 11:19:52 +0100
Message-ID: <CAFEAcA9oPawHi1_oy0gvU65Ob5RK0dYWXo4XsusT6L3zddsygQ@mail.gmail.com>
Subject: Re: [PATCH 09/57] target/arm: Convert Cryptographic 3-register, imm2
 to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Mon, 6 May 2024 at 02:04, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/a64.decode      | 10 ++++++++
>  target/arm/tcg/translate-a64.c | 43 ++++++++++------------------------
>  2 files changed, 22 insertions(+), 31 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

