Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A4BC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 16:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1redlL-0001Ap-Dy; Mon, 26 Feb 2024 11:23:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1redlJ-000191-5y
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:23:29 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1redlF-0001Ak-Gf
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:23:28 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-56454c695e6so5758174a12.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 08:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708964604; x=1709569404; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R8cjoQrTkGA3CXcE7dt4RfYTbCi3yLhj64dJVI+faEM=;
 b=fUyb4sSZkVxIbu0sKiMEPxacJjxvj2wUCN3UqUE3mUE2MTpubak7cbJoxR3szpR06i
 vdaiel/VrvgusCDF0yz8QWjidifxiadGSDhMBNGT4CcgLXlT4MBvaQwbZEhZQLp/YHQ1
 0auVgaGO8Jamee9r6BlI+6OIPQ+T63kuAhRXcSZ59ohvaMSO/WuXui0eop0ZjaD0nOLv
 AaarNCzE3AmhENrCU1SW+rTzMKEYNsdiNLiEZXfSvanhDe2glgWTL1/l5nGNQazZh4CF
 TLthg+b9oLTZDLAv9a1r2k6lvoWaiiK26llVUt+2phQWgQJxQqObQJ2qNR/EjxqMx+d5
 YLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708964604; x=1709569404;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R8cjoQrTkGA3CXcE7dt4RfYTbCi3yLhj64dJVI+faEM=;
 b=LVaUCqPZGc91mUvmekposFNO/+rdS1gKuZAd8voUBueX6D5StLX/cO0oLwJDo3QGDT
 9PRn09I7ndVEp5kVvy2Nhhv4yvd7Zp/0gLaQpQludVX+cXI9Fi+ZrpOoM6BbjJLpu2a/
 e/Cs2UA91XdV9oIyslPsAUFfuWKVP7ies/FhFeZBo9UvnfXp38BZpJ8CgGx77hYInFEq
 kbJ7QEFhzAINACaqhbi/V5iJA5EgfsiKKudS/3hcCKOmYvDtQO6bn/XXEgciL/TVKY3N
 yGx0vWAnnmAvNuXcYNbvvv9zkwupAbozN4DzzgogZMVoM/k99nWyKbfQa8VMfZI5mwK/
 4bsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXGkzHf+Sgf2dB0aKfYia42O9wTiWtjCkMci8lz9UjELRMt1guPsO2Gp+zHT6uwlb3RyFkTQ3G0oSDKJ3lgLDeayhx5bc=
X-Gm-Message-State: AOJu0Yw0CAMH0h1SRsqR7qstT/oglTx24ksdb9QtFFn5YGi23q5z1/6C
 qjeySyL3uulmfYvmzeYoJL+noO/9cC6TmFVissNoeLKN0ThHqfoCjHpPI6sOE3pX5eMixPTWc9E
 Ta3pGS1s1yH7yFLqqoKJT6xw5zrq7NeUhbOqVww==
X-Google-Smtp-Source: AGHT+IHgIffekj36tJp8ofJTLhWQXkJelAid4sS0stQBrt4M7+Fd7sasOB0Z9axWcCbuVTGFM515+ndvl/bTlmHgRKU=
X-Received: by 2002:a05:6402:4581:b0:566:22b7:3324 with SMTP id
 ig1-20020a056402458100b0056622b73324mr591589edb.18.1708964604166; Mon, 26 Feb
 2024 08:23:24 -0800 (PST)
MIME-Version: 1.0
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
 <20240226000259.2752893-33-sergey.kambalin@auriga.com>
In-Reply-To: <20240226000259.2752893-33-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 16:23:13 +0000
Message-ID: <CAFEAcA_o+xFJpkDahOkz3UGdV1aHfvpSN_jUKT-EajxHCvYHOQ@mail.gmail.com>
Subject: Re: [PATCH v6 32/41] Add mailbox test constants
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 26 Feb 2024 at 00:10, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  tests/qtest/bcm2838-mailbox.c |  1 +
>  tests/qtest/bcm2838-mailbox.h | 88 +++++++++++++++++++++++++++++++++++
>  2 files changed, 89 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

