Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1561EC27C44
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 12:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCfAU-000380-Li; Thu, 30 May 2024 08:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCfAS-000374-Qe
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:46:05 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCfAP-0001rb-0y
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:46:03 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2e73359b900so9662351fa.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 05:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717073159; x=1717677959; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7hRwG7B9L8ASh9+FSetrzB7NNEg9WzGIOSQTRoJ/uOA=;
 b=nL3EJFbqJ/A4Ccym1kwJcRROmgzq5PGJ+PL/b3Nbzv+fOG54M4n512k8tlK4cU21r3
 otSLUHNjz+MHffRyQgD5F1wm0X4UlkVu+3KpaQqWI+qjkS6pRJoM/MS8w4jg1aIj/K7J
 OFNuHurphIo/z7/JOTx7C1WC9REhd2ZJAro/aZbkiaLuyLxNBb1cxU9ZAdRzr5TfHhDX
 KDF7aqUlSD7dZg/53NjwW3V3QVbBMVQQ22Z2sN6bhKYZUAx5CcPA07riLUIihLHhOtIT
 mGeZCih83PMfgbqv5NPg69dC61sfgI/t3JNtSaKPjHf49Z2ElrPlFTMyMHFikNOJxx3k
 /O6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717073159; x=1717677959;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7hRwG7B9L8ASh9+FSetrzB7NNEg9WzGIOSQTRoJ/uOA=;
 b=s823Q5vIkEnY6kjkYSSjkDoPUTWrMcXcL3r+Fqk0X64MnKK7ldL+JE21CYVcgzPQqE
 XhDevgGr9PtG0tctdUa4n2sUQZogjZkB45R66dPsvoKAfphEjT8wvvhtLaaV33yER3cL
 P3gX0TsBrb3eT6Oi8MgN/KUW+Zrw6SzW8uOwWEFvl+JHi1tU0SZojMKG7jP0JDQh/cGe
 hAbv5rohfKTwWxmy+ct6ehyso3RSqVAH0WZcJ9O/N/n0H49EXlYmmpUYB4zprOkR7VoA
 xT3DwfHIJPIz09MuSx4pBa1mN2gSlVsAEEFXnRRDbNSF/DWQpsqpLyukwN6U5dldYzUh
 bd4Q==
X-Gm-Message-State: AOJu0YyGGC+Q2rwvy9+0MTUYUnyEh6BxlUYXfyi6z7MweSyXPkNPY6hP
 7Mr/c1TJKyPpFaKVc/6c6jUPY1rWQzk+pnOPmtuAJ6AeHE6G8gqNyJQ/OkZryEOGtxoBrDEOehj
 C8cB8XW76y7J8+3T72DG2IL96w7pmxCr58YWAkE08z5WuvCoq
X-Google-Smtp-Source: AGHT+IE/U2rk+tmfei60qc3jq6mhUYAGsq8lcB7fuQo5ubJezTsfymYlrE3v6vXeWILyEBc2GvapHUHHdowm8gmjN0o=
X-Received: by 2002:a05:6512:3b6:b0:51d:3b87:70a4 with SMTP id
 2adb3069b0e04-52b7d43a877mr1333344e87.36.1717073159103; Thu, 30 May 2024
 05:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240526193637.459064-1-richard.henderson@linaro.org>
 <20240526193637.459064-3-richard.henderson@linaro.org>
In-Reply-To: <20240526193637.459064-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 13:45:48 +0100
Message-ID: <CAFEAcA_Z3GocrN=-M9RG5puvqYiby3DrEDBfhYdjGnhZ2nOUZA@mail.gmail.com>
Subject: Re: [PATCH RISU v2 02/13] Build elf test cases instead of raw binaries
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sun, 26 May 2024 at 20:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> For test_arch64.s and test_arm.s, use '.inst' so that the risu
> control insns are marked as instructions for disassembly.
>
> For test_i386.S, split the data to be loaded into the data section;
> fix an error aligning the data: 16 not 2**16.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

