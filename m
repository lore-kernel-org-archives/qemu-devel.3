Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7428C606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Hs+5AJ86
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNpSC-0006bc-O8; Mon, 02 Nov 2026 05:39:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNpRl-0006a5-Bu
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 05:39:25 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNpRj-0007jY-Qb
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 05:39:25 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-8b0cf2c0785so21582327b3.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 02:39:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793615962; cv=none;
 d=google.com; s=arc-20260327;
 b=EcalErwok0JuBMy264Q5ywbJV/aws1YICBJ9gh8M7MfTKZVwqZoFUMzwH/jlqsjBZl
 W6htRyLfYH8oA9yZH9o8wp7Tm3kDz7E2Eyk7gGmtbVQsycyOm4aRTztylR7FXMjyB6G3
 dsJuOS+38PUJoLhR1S8zGTAA4yWkcUIMthA6mgFAk+y7DYeomhDaFEpkOh75OPWNpCkZ
 gYfZxE1AumG3Ssw/KoT80GSqHWUptIo0wznEAVuxizssG5ZUn8mYMDCj7SXIOxcJJoh2
 h7vI1HEHaim/wuV3q0rAhrN7IW7iMoyV7fJqPlNGalMgJf1TgSY++v7HCCXLyi57rKHj
 WzVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Lhsubxg6k7hazRlFI0CwA7rq6OJj8CB4c1RI2yEn2Vo=;
 fh=TYgLo6LSaCnSg4LxfB/cFu8QqHO9C1zPedgQPfry9ms=;
 b=Vz0vSiqJBXOuRULMnie/x7YjA4OxOMKsiPI5mj89H71wSkFMb5hnkVJKaSCdy0AITh
 C8zKtMWAmPxjgEG44WWXfIYxjMo08mlkB+Nwf2F2CoMfUmt5IHr6nbahLmUZ24gNB6Hd
 SXLolCf9lPRtdRSH4qD2JlvnCUU5olPQ1e3sOLUUZ1lRm43f3LqgsnQWO8MMPYVNedyt
 i6HU7JE1fZ52gywWbEcW1HdrllomohK3x8vY4zAQPNa+Y4QTea+P2C9xp6g80Urwv8gX
 B6V5yd3xL/YpnVku1FSLDI4SqnSjGN9xeDP+ma1diOt5J3iIIxy1djxxs5WiewEzCNys
 Bjwg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793615962; x=1794220762; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Lhsubxg6k7hazRlFI0CwA7rq6OJj8CB4c1RI2yEn2Vo=;
 b=Hs+5AJ86m/mwsAOh2oflbeq4Ezo0dNstcUkaYQezoLDWo/KTIsSiZNKpsPEsS++pcs
 UmY3KueqRGDSZTXR1X8cGvQWmmE2VochySZSfL9A4DbJbFUkdsErxHpipk2sbczUcDgF
 rDUXxmJfv4LaffMOAX2aJdPnyZ/f93OcwgIz93EYrLaE/ADfujbERGo5ClXKl/jdXmyf
 Mh7A1Lr/TPSDOcc+kPd7DFKACmBg+CpWrHIFhnqbrvEduUTjxP3WJgqnnqID/CpkIhay
 jv9J9UH0G6nPeYNinVC9lo1T/SkZzYoasQdfubdqjXlrCQroOP7J8zYTpOKMMaxQ+WyI
 It8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793615962; x=1794220762;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Lhsubxg6k7hazRlFI0CwA7rq6OJj8CB4c1RI2yEn2Vo=;
 b=l7zR0inkHeBhCtjQ29LH3O4iWK1DGqy5PpAzSzTuu1zcst9v8CW1Yjmzlzq9h55/lb
 CjEMOBJTglL+5a3n4xzIAvn2VcPbSDPctqS9IsMllcP16LrxZPnqkFY5lkJ0l9Jo1OG2
 ITTYPD89kiKO0N0IDI46qIHNOdBYr1XE8DS4CobJzSHhMNkvYFq1mlmep+LVbwJX0NR+
 l0ztC4pn8DU1/DXSAhsTaLooupxYHsG5xaQj0TZRfQouwvOghHzbgDb7FKFXYZFp9/FM
 F5/Sr2A+WSDvLmrJCjD4DsX13TjMwFOa7BUpMNi1zmzFVCoRsejuYsZGbv5yyj07w3+N
 st8g==
X-Gm-Message-State: APuU4Z9VLFp+PsG/ii6+Gy7RItbjwZ94/Ggz/2ph5cky8aNhymMn/3Aw
 /BTS8pmcxio6wzjtrljjCeV5Yhkj4p7MtswAsh1FX6h9ybj3ci4i8/MlYAMpfx0lNEC9G+KQYw5
 1uzesu2FfB17PbiVpUkrTjWC5zjm+y8QAeESMUgthzQ==
X-Gm-Gg: AYBFou0jvm8S96UKDOf8lqrd1KDFHQsPdJsx3a0ahV8Ru1wIUyho5yG6vXo7leoCT03
 6ogWMZVSv4hzLDXuKtrh3phjzOB2PAHtHIFqpmYls8bCQZsycu87AqLAe/SkB7O8cPNr+ZLEASF
 qr+D6u/PVTIkr03EeyyqH4gMAd+qGzWHIfkkYYXjaXldxCi6TtO7cAauJXlX7SABfteNn2Jz3Nh
 /JDzjs6cfal4ULPfPmfaulPDEvSjwt6pBDGnB5S/Vy1Rxh/nHCKn/27NfU2bwaa977PwguCscFK
 0+TDyT9HvN/SMLYsA5KgPhR0aaJnw49Cg6Cs5uIRsXTyLgF3XAjVT09QcyQHKUPgTZtTy9nUMVb
 lEgagJH1lUBlnK6AKh3ODocLp4lHG1sSsNSgWrkjAysPQI+ut5zsvEVJhbzu1DIkyq9u0+tZGgC
 f2fblrf6MYtjRlWiCr+ti6
X-Received: by 2002:a05:690c:74c5:b0:89a:63da:faa6 with SMTP id
 00721157ae682-8b2b67abe20mr59077857b3.97.1793615962259; Mon, 02 Nov 2026
 02:39:22 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1793613972.bcm2835-fixes-v1.git.lorandmarton.dev@gmail.com>
 <6262fa90e0dcbb87c33ed61c53ef55e83335a45f.1793613972.git.lorandmarton.dev@gmail.com>
In-Reply-To: <6262fa90e0dcbb87c33ed61c53ef55e83335a45f.1793613972.git.lorandmarton.dev@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2026 10:39:08 +0000
X-Gm-Features: AclHuK_tZq1EnjsojruP6sV6gJ3fWTFSzvgRDF1C_9UPK9gKStirdUWl2NLw8FI
Message-ID: <CAFEAcA9NmpX2gRdP29xnxpOzj_67Pazsybi7BgM7K_206skSdw@mail.gmail.com>
Subject: Re: [PATCH 5/5] hw/misc/bcm2835_cprman: a PLL channel divider of 0
 divides by 256
To: Lorand Marton <lorandmarton.dev@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com, qemu-arm@nongnu.org, 
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, 
 alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2 Nov 2026 at 10:33, Lorand Marton <lorandmarton.dev@gmail.com> wrote:
>
> The 8-bit DIV field of an A2W PLL channel divides by 256 when it is 0,
> as Linux clk-bcm2835 describes it (CLK_DIVIDER_MAX_AT_ZERO on the PLL
> dividers: 2^width at 0). pll_channel_update() took 0 as 255, so the
> channel and every clock fed from it ran 0.4% fast, and QEMU and the
> guest disagreed on its rate.
>
> Test the rate of PLLD_PER against PLLD with the divider at 0.
>
> Fixes: 957458111280 ("hw/misc/bcm2835_cprman: implement PLL channels behaviour")
> Signed-off-by: Lorand Marton <lorandmarton.dev@gmail.com>
> ---
>  hw/misc/bcm2835_cprman.c          |  6 ++--
>  tests/qtest/bcm2835-cprman-test.c | 49 +++++++++++++++++++++++++++++++
>  tests/qtest/meson.build           |  3 +-
>  3 files changed, 54 insertions(+), 4 deletions(-)
>  create mode 100644 tests/qtest/bcm2835-cprman-test.c
>
> diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
> index 10cad07623..144e553432 100644
> --- a/hw/misc/bcm2835_cprman.c
> +++ b/hw/misc/bcm2835_cprman.c
> @@ -184,10 +184,10 @@ static void pll_channel_update(CprmanPllChannelState *channel)
>
>      if (!div) {
>          /*
> -         * It seems that when the divider value is 0, it is considered as
> -         * being maximum by the hardware (see the Linux driver).
> +         * A divider of 0 divides by 256, one more than the largest value
> +         * the field holds (Linux clk-bcm2835 uses CLK_DIVIDER_MAX_AT_ZERO).
>           */
> -        div = R_A2W_PLLx_CHANNELy_DIV_MASK;
> +        div = 1 << R_A2W_PLLx_CHANNELy_DIV_LENGTH;

This kind of change should reference the hardware documentation, not
the Linux kernel behaviour. What does the actual hardware do?

thanks
-- PMM

