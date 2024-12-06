Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBF1E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 13:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJYIp-0006H4-7v; Fri, 06 Dec 2024 08:23:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJYIn-0006GY-Gp
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:23:25 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJYIl-0001Zo-Oe
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:23:25 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5d3d14336f0so508685a12.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 05:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733491402; x=1734096202; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Z9xhYEb0O3i/4W/fQ5Pv3JovXnI2mGhEkf1tiEnaxSU=;
 b=WRzCkiRuMtSar5XyBRIaMBYbNEsVVA2YgqVOqFEfywOt1gqpb5vGsEPtHo90Kb4nNG
 2mUZwtU+NM4Dp6eeIcCIuUeLeH1HqGIXMA/wIqlQ2iKOU1RVRcIYLEg/do4EkAIv4T36
 CryXzUsuTzSDrXPXB1YXH+rcfadV4QITVLuGxUORiyfBAgLzLZmC0icIYbss7+LJZOw1
 YxKMsvHuHi/rrkMlGpcaHa5HjKXj+9z/cIXoGhZs4dXzKKcCfVHY5bZM35InyGtydS06
 gjEAbbdAFKpWT1+fwg4/wwijAgOP9ccwkV3mxNfJ10Qf6gA9rE3K+NPcghHo5rX21NKJ
 x7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733491402; x=1734096202;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z9xhYEb0O3i/4W/fQ5Pv3JovXnI2mGhEkf1tiEnaxSU=;
 b=gmUJeZRwFoJJjQSg93JR23caYqWLHtB+uwmP2c3bMcxLLLeHiA6Ag3V/NhU+fPd7da
 4azAvz/7HHcw0h1DErTFp+t2DMgnnNtmvXQyqYQhIfTKkiLd/JK12zKejkBcinVY72MA
 AYI7UMHMu5WbEzQXH6oNvfvXnwbC4CeJwyqnbol8Yygafvsp78Bf6mmnKjUORMFEfx5N
 XoBQCCix6VYYjQ21UCsnd4CywrH9ZvgGYtYw/tOpI04YhWDuDWNMfleWK4jBo+fFKH9W
 oK3UO1mgC9tDVL94IcrGfUIXrWxbBjtQb6u387EWmQo8cZEwDpLxLtUqH1WWXK0rv1fS
 8Upg==
X-Gm-Message-State: AOJu0YxT7T9I1AVDjVs87rxvQUEHAJ/nt16w7TnPrtE6V4P6ZOg0rfMU
 kexh8gBt/Yp+MY7eae3rLmWo0kq18C1ENI3uq8tDR+Cf2GoOsDP4fn4jsZ+7SZFqBPN7/qcbDdw
 vNbAISkdZMLNhRV6SgQv/ghlTQiQyp5rzf/4YLg==
X-Gm-Gg: ASbGncvAz2e6pLszMIc/GHgBZdJA0fbFobjz+VEnbQMcVCgPnimbaTH0e2S9EmWKaIM
 28taey+vHtIU9ayz9tX3YZxwbjdtjJF7n
X-Google-Smtp-Source: AGHT+IG9IGGBD4dOb/351cgLddp1eklZjM6nBxhI3jFPWYRc64BfiW49HSnPsboGUh34NKQD7FrvrCwhne1T7kOD1YQ=
X-Received: by 2002:a05:6402:354c:b0:5cf:d078:c9dc with SMTP id
 4fb4d7f45d1cf-5d3be763173mr3024162a12.22.1733491401875; Fri, 06 Dec 2024
 05:23:21 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-28-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-28-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2024 13:23:11 +0000
Message-ID: <CAFEAcA-fbGrd7R8FXnJL+wHx7FSSh4Hctkm2m7MCJmZuvf4pSw@mail.gmail.com>
Subject: Re: [PATCH 27/67] target/arm: Convert FRINT[NPMSAXI] (scalar) to
 decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Sun, 1 Dec 2024 at 15:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Remove handle_fp_1src_half as these were the last insns
> decoded by that function.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 107 ++++++++++-----------------------
>  target/arm/tcg/a64.decode      |   8 +++
>  2 files changed, 39 insertions(+), 76 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

