Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F3CDC77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 16:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTk55-0005FG-0p; Mon, 23 Jun 2025 12:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTk4t-0005C0-Aj
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 12:31:27 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTk4q-0005Ud-OB
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 12:31:27 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-70e40e3f316so34001597b3.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 09:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750696282; x=1751301082; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yzAgDZtlaU8htsYgc5DEcrFHAafPsXCphqgaDN1N5lc=;
 b=xH0Gm+YzB1OMzCU7p7c2tGycvdEZPT3Bp9GiiJsMEykgEJ1VXo8KcHpzM8H8DhENQY
 +LbQ5IVMZxlsZW3QMC981VMJGZTtbcooOYeauz8BFahPTwmqxXz8pFonpfClzbZhwrml
 eLIRUWhCbS8cKyAtRz49hz6zzwnz2FpgIn4LUTDfRbiO79F8WFGZtnU1xSsoABCM6HPC
 F15CIFiU+cyf4r6FFFiOZzFKCiTaGaGDOHodjuJqsPOg7xpuEgWG6zfYEAcPTQFwiNn1
 OCqIxBbNHwAy0/fixQZCI0QJQ+1gAsKZ27bGYwvMBFysZj+nnRBPQngkQKh0MuMU8qLw
 Xsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750696282; x=1751301082;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yzAgDZtlaU8htsYgc5DEcrFHAafPsXCphqgaDN1N5lc=;
 b=cdS8Nj+Ok5+j0cgxR4ZciGHUozi4ZZufG6iQEdGeVnBTf4iDMsTVe1uXU/5sAejU5X
 mwnWlTknnyFS1XPrCDRUHKFyftrcWrV7FFrDgb2qU0WrxC/+s9sURagPnhSsYDt9Sn01
 pBLdJ2jQ5kEk2FVH9axyDD2XKJLDMr9qLDa41J/d7pTUXiPWFyjVlqiTkOinIzFlTKWV
 xKFXi/OqxM4gVYt0R/imskr//Vw4Fne4oaD14LNkjRz8ZRqOa7Uh5fiqDPYyqtapQcNK
 TwtTE9zEkT2vasRnVb0o71PL9qlYbSmBz/7wSvYj9IaI2ALWQPW3+w2JtlundADtDn2a
 HcyA==
X-Gm-Message-State: AOJu0Yx6Ahk2pIiPEQxLTDYvZ0w6XtkLCQCLZmmkjWA/lFtWp8IH2v8w
 S6+ES/41Z3iVgolK9tbvvgg9vS9ppriI82ArmMqalJ6Z+6YgKC/SxSl97hetXYhnmd1MwSItXdI
 3pv+Wi8XE9qMbPKr00tUmr70NhjPXAbkdsiUQQgdoWA==
X-Gm-Gg: ASbGncsFQqOTu/5IHvaEA8+0uY0Cd16dp5z4lVFmSMD1wkwaBjONU0DlSd55vodkvgY
 l+r+KocSfnRWkoNklretO5lt0JYqRagPiP2vzBGOyLjPng8aBpcAPr24MSC8WTEzzj67pjUFyM5
 2JOrhFtWMHXlRJo/gn0+rcddaP3REgf39A8Wue9gVvhHL9
X-Google-Smtp-Source: AGHT+IFpUZB/t+ISFBH5zpC+sDodbc9LZqq3oGPaScC0C09lMYALKJM4QVYmNtIENGSlgqB+WK3iSc3/aP6TFsDKcIE=
X-Received: by 2002:a05:690c:4c0e:b0:710:f1da:1b5f with SMTP id
 00721157ae682-712c677651dmr178305297b3.34.1750696282234; Mon, 23 Jun 2025
 09:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-35-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-35-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 17:31:10 +0100
X-Gm-Features: AX0GCFugNEfs7cuCMwhEmlnOpxm8ppyAgA-ysW6fbnUA5dJO6aQjO1s9w7R1rMM
Message-ID: <CAFEAcA-Bv8LOZK3hpLYwjuexBVG5mdZcteaJr0hnvmRRw4BcSQ@mail.gmail.com>
Subject: Re: [PATCH v2 034/101] target/arm: Implement SME2 FMLAL, BFMLAL
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Sun, 22 Jun 2025 at 00:55, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sme.c | 93 ++++++++++++++++++++++++++++++++++
>  target/arm/tcg/sme.decode      | 71 ++++++++++++++++++++++++++
>  2 files changed, 164 insertions(+)


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

