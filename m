Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 945F2C41513
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 17:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lNR-0001iG-5F; Wed, 08 May 2024 13:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s4lNE-0000vi-E4
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:46:36 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s4lNC-00086T-I2
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:46:36 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a5a0013d551so137274466b.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 10:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715190393; x=1715795193; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hs9mUHSQM5J5lc9WjW0t6eQY65okU2enj9pERnjZKaE=;
 b=U5BNEtzmisPJpGLOeke6UAialQwZwrQo0udw5qfeZjySFxktvBGcNF0ld2+8w1TUR9
 4p9Ge6011N5az7eyPUq8qJdkuBkFIH3+eGZX92cJzbxEZ8SQ8FfBwReWX1yu/RQmS4Ex
 +EuNJP+X2JQvxGTS2lX+ljtFfNotzyElPP+Sc2oP2mBVAbwXjiGBljfhm7lnUkTq7sgS
 0rAWtebRCBZmVvmWA3us2Z9Tm7Njk33UbAfiw9ZfF1I3k39AdeiZ5DUWajdjj4R2B5at
 5Gjrt0K/m32klRX5bJZkvh0ihv+wrvIP/MSVhxdoLqUcbnYYd+Z+poSwCQejrQJFmVZE
 Covg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715190393; x=1715795193;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hs9mUHSQM5J5lc9WjW0t6eQY65okU2enj9pERnjZKaE=;
 b=acscFlcjJLdBFjsCIGhfIvNL3H9qlUBS64ll6ezgZsjZpL7oDlIf5/BMHY5YqUnOQM
 qEFD1ndfEkjQTdOKuqDGFct8xehAcxvHQu6HJ6VGfrn/bW5Ay61YI1F4omDs5RkuBZgn
 DCl7dDtkx+0BpsCSda5Urnq1RT0A7Etn7UQlY5vWrdrR3ShqqJVLzCtaXlD2muRDdhpv
 F/ag+jWPwefM4jXb5MIC0JF+EE4b+t3vQozjmZxu3VFCyPx9mUOX5gW8z7yJK4ixz1RS
 CAGmSQBQKaWKbbDbmjXUUeqYlaUbbT19/+NIPr9f+AFhmOwAkLdkGmCNoxyTMi8ejgWa
 v+dw==
X-Gm-Message-State: AOJu0YyKd9H+MrchXjpAnwTPFnTLZlAkvfa/xIyASEGaFRj7WrvSxHA1
 TyICl+zCHreHbTlvd8XAyvN1JwYC/zAZeuB1RvdzjLNsedri/tdDzXrAtGDlaLkmxtcwNydfrzT
 1Yu3/eMtxv9XXqKzOwTPgJKwtteUvaHS7EpcKJEH9Yym142nd
X-Google-Smtp-Source: AGHT+IGszBGmITE9DIRk/tgGYbQvHMjutbJGA1MtkbVDGEZH6V3FIr4f313o9twCzLytYTj/I9U5t9nqEGsUo5sGnH4=
X-Received: by 2002:a50:f681:0:b0:56c:d35:1775 with SMTP id
 4fb4d7f45d1cf-5731da68e11mr3043602a12.35.1715190393039; Wed, 08 May 2024
 10:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240508141333.44610-1-philmd@linaro.org>
In-Reply-To: <20240508141333.44610-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 May 2024 18:46:21 +0100
Message-ID: <CAFEAcA84CfdNZSjZ1R96=5P-VhxGXyaaujF1Y8AxKa+Wvpdp3Q@mail.gmail.com>
Subject: Re: [PATCH] hw/clock: Expose 'freq-hz' QOM property
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Luc Michel <luc@lmichel.fr>, 
 Damien Hedde <damien.hedde@dahe.fr>,
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
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

On Wed, 8 May 2024 at 15:13, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Expose the clock frequency via the QOM 'freq-hz' property,
> as it might be useful for QTests.
>
> HMP example:
>
>   $ qemu-system-mips -S -monitor stdio -M mipssim
>   (qemu) qom-get /machine/cpu-refclk freq-hz
>   12000000
>
> Inspired-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

So I have a couple of thoughts here:

(1) if this is intended for qtests, would exposing the period (i.e.
QOM equivalent of clock_get() rather than clock_get_hz()) be better?
A Hz figure has rounding so it's not as accurate.

(2) We should document this in clocks.rst; I guess we want to say
"only intended for use in qtests" (i.e. if you're part of QEMU
use the existing function interface, not this).

thanks
-- PMM

