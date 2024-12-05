Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8897BE77173
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 21:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJJNm-0005DE-5r; Thu, 05 Dec 2024 16:27:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJJNk-0005Cw-Lc
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:27:32 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJJNj-0005mo-7e
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:27:32 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d0f6fa6f8bso2024418a12.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 13:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733434050; x=1734038850; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1atv2OOJIGDmQ398j/z7UHHtE0Ox/5QmzfX+EUWF9KA=;
 b=KK2ASPxM1rDJDmsKSaZLcVgzLi7lfS+gq2WTQ/OA89NtSC1yAA5eF5pyBxUYoPXSiS
 s1HmfTulW0KLm6jb3r0v5Puj1T9rul9/ikMEPru2lGfl+auwFVIknCqhK7qmPJzkDon1
 KNwOl8L/8nKsFJ7Uzqb3AM17RAHD+hpFz133dD5ZMNl3eV26aAirupCjXOAhMNPWy0fg
 8Lll4TwXXtTx6p+LbFZPY/65SKzFSylqwIiIyHUVXt9rob11CG6M8YxfGG1Yd1kxnK7O
 q7TsAQoxqY8gTsmjUav3SQcvnqi2l126e7kTv9WbGgtyrAlGdWfE2F60e2CWvOdzzkdF
 NY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733434050; x=1734038850;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1atv2OOJIGDmQ398j/z7UHHtE0Ox/5QmzfX+EUWF9KA=;
 b=lDczP52HH2cs2k22iLOUyzbfQ7ZxNLBXnv2HdmiwZQQ3FAUWfzRalyPXYklyDceRlH
 fMJyUzCZVA9EqzzmQ4Va7VmNBzyw74pWcunlvEEcTJPlwhaIs0CZg63CyDw9jNoZ1zYV
 plYKVYL3BrgzBiQojrGYOU5+fPningDaAOMgUmTVDPE8F3/BI+0J5snjSzcKbV/qoig1
 /uZRHlObUfkO/B3WpYKCUbVmXiycxzUwG4+afpL2e2rD6Eqs/p+NphxkdK7KX05zRL6U
 CEb0Y6/aTscOCHVtmbsyjjfp9DOcdlbda+vUna5coxuYQRJpS6mahPohmalA+VVHCrE2
 FWkw==
X-Gm-Message-State: AOJu0Yyb1s5fE10sTZU+YrprKZe2tbG5EZOgGzT97Zw4NROt0JAR6Qxe
 foMy+Mf7mVbwdmF9QXfGHdszOfOEtNnpgwmOXkNT6MVh9AMfdGG25Qk+YmDFXeQlTWsXLMG6s9A
 2x6ezhwYwpRwKm8PYCHTO7z26EIEGS4281tVovQ==
X-Gm-Gg: ASbGncvcterw3wgs3zDYuUWMWIG7FqCNuaDBj2CdXP4dLgbBx4Q24r98Dq9Qs+Cdgi2
 bwfyAc16eobLPfhHk3mIKvI3pmcPFW3pn
X-Google-Smtp-Source: AGHT+IFJ583b287Dsj7sKJ+jKyQNqkRS3v0uUg9rPQnP7xOBOq/cyRVftdhQXDmd0aNUo05cCr1AILiOJy42zEmOPNI=
X-Received: by 2002:a05:6402:348a:b0:5d0:e54d:5ae8 with SMTP id
 4fb4d7f45d1cf-5d3be7a6cf5mr478484a12.34.1733434049634; Thu, 05 Dec 2024
 13:27:29 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-23-richard.henderson@linaro.org>
 <CAFEAcA-2nA_UYVt+U5hkngxxNEEUmLa6EBkt18v2=zv6PUMMnA@mail.gmail.com>
In-Reply-To: <CAFEAcA-2nA_UYVt+U5hkngxxNEEUmLa6EBkt18v2=zv6PUMMnA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2024 21:27:18 +0000
Message-ID: <CAFEAcA_aaioxN2_ePCcMBLkaXVoUx1mR8-MmAar9tVNJMtAa1Q@mail.gmail.com>
Subject: Re: [PATCH 22/67] target/arm: Convert FCMP, FCMPE, FCCMP,
 FCCMPE to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Thu, 5 Dec 2024 at 21:21, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Sun, 1 Dec 2024 at 15:17, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >  target/arm/tcg/translate-a64.c | 287 +++++++++++++--------------------
> >  target/arm/tcg/a64.decode      |   8 +
> >  2 files changed, 116 insertions(+), 179 deletions(-)
>
>
> > +/* FCMP, FCMPE */
> > +static bool trans_FCMP(DisasContext *s, arg_FCMP *a)
> > +{
> > +    int check;
> > +
> > +    if (a->z && a->rm != 0) {
> > +        return false;
>
> We did not check this case before, and the pseudocode in the
> Arm ARM doesn't check it either (there's a comment for the rm
> field that says "ignored when opc<0> == '1'").

...this probably falls under the "RES0 UNPREDICTABLE" handling,
but "ignore the field" is permitted for that. If we really want
to change our choice of UNPREDICTABLE here I think we should do
it separately from this refactoring.

-- PMM

