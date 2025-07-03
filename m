Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04476C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXH8a-0002ai-UA; Thu, 03 Jul 2025 06:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXH8Z-0002aI-FC
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:25:51 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXH8W-0006F8-KV
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:25:51 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-708d90aa8f9so79816607b3.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751538347; x=1752143147; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G3iJ5JjYU4isrADYml2qhwyxaowAjhQrTHID1xmE0IA=;
 b=eZ6UYqe6G9dcAtvi3p4qvhUn818/1tTpE4BFvPVcUtf3bR2Qk/QAMxtHtu5rxCkvAF
 FQYHP2wt1D9nquQtoLquKkIzmiwTuSJ3zaJNP+NN/JYDQ/gdXUTCUCYhGzijYoeDSD1S
 EDmMv3hGyhX2BjLW7ssMO1Sd0fg16d+9s9QyrsJllGfP2dxRwRRkXRg0L90OldUBuurq
 MefWI9rp8uSeiNnl9wF3ljNelvfw1Dv5I/NKa3ilJl981NVqB/PdD8/sQp32Z/9m6keD
 EPjujaCmQ4ZwkdZNqeGJVDajw24/3/IRb18eYupA4vmfZS+baiH1bR39qHx8hKpeXkrY
 LGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751538347; x=1752143147;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G3iJ5JjYU4isrADYml2qhwyxaowAjhQrTHID1xmE0IA=;
 b=XRLLc2y3BRPDreTc2dKzQML9vVgfMLEwpecPySEr/jdXMyzTQww+Xx44cS7GVqlWMp
 mXNrLfVlZu1Gg/UkBeo3Hd7mis1MAN2G/g7rjWYGXeQ/cJuTSAaQubMOy3lPUREz4j/+
 uvtSIQqFnUCm64e9PKMXs7jjdzGoaOmnUWZ43BEoeuobbbe340LlpTkxsnSC9xedzbSk
 0byfaHks/S/qIHKf6+iq2iR/EVn15HojmwyUhEWY5RJnU81tu2xMJcLhMZE1NCQjMYe7
 6x/I8jMq6/Vo5y34p3pPwBds2ust3k0eSX9VMxFalt84aU0OX3x9lvaJZAJBJfMvKVan
 gxRg==
X-Gm-Message-State: AOJu0YyLAsl61oOePwSZpJFK+tQT/7Rir+VoMmdqlKRpRH3qs2Vy0bA1
 X6DRL0LuUsCl+GWHnQmpi/6nPEe4aBNTPdqLP3Sp36R9X6X80DhAkiTRQkMz3JSvVnm/I20QSZX
 3gVqUB9dt5gsrgpNSwor+ABoncSIHOOa5i0WIzdZtTA==
X-Gm-Gg: ASbGncvu1TNdXkpm2T5GHqTrfUOLr4zpHvBmSIzAvCYcYVQ3DdcqaEfiDcaVXMcCbrn
 oaKo8qFhLdYg2QNHJCHh2EkXKwYMFvcWcl70ES9rbmBlVp28HUCEAgEWyPTUAqVt8Y7EY5j5B3H
 HYYnPkOO1moSd71v2t+4C4b8mgxCdVx9oxeDtnFxE6wX7hdNN/VjjmMcA=
X-Google-Smtp-Source: AGHT+IFQ9BR7EVyb17QIaNFVUQ+FbDpSbG5iKAGZKgHuYIwYt/3ESgBia2t37zbyHnS1t7WgvRAl+4VVaeg03+OfIjs=
X-Received: by 2002:a05:690c:10d:b0:70d:ed5d:b4da with SMTP id
 00721157ae682-7164d305dfbmr82215017b3.8.1751538346980; Thu, 03 Jul 2025
 03:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-53-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-53-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 11:25:35 +0100
X-Gm-Features: Ac12FXxROn1CBPYAo5MWRcA3z8ON9m1TIqbzsIcXYqsBKat4icIJY8gQWzvRYag
Message-ID: <CAFEAcA9Ugoe1MNLTaM-Mdb=YYv-Cpri+_=_PkRUi3g51YskSHQ@mail.gmail.com>
Subject: Re: [PATCH v3 52/97] target/arm: Implement SME2 ZIP,
 UZP (four registers)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Wed, 2 Jul 2025 at 13:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sme.h    | 12 ++++++
>  target/arm/tcg/sme_helper.c    | 68 ++++++++++++++++++++++++++++++++++
>  target/arm/tcg/translate-sme.c | 39 +++++++++++++++++++
>  target/arm/tcg/sme.decode      | 11 ++++++
>  4 files changed, 130 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

