Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF569D15DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 15:09:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2u1v-0004w9-8Y; Mon, 21 Oct 2024 11:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t2u1r-0004vD-4T
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 11:09:07 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t2u1p-0003he-AC
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 11:09:06 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2fb584a8f81so49344981fa.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 08:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729523343; x=1730128143; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tBiNo7TNCD508RfgxEyHjKPVyw0CLHRlRIkc1GYxQbE=;
 b=lt9wn4IwYp1gZxG/WjERm+9R4EjKG8UrctkRfCumV1an5y71Hwhxjh50r5sxn+d+CD
 qx9EeBohfauFLoEnRxMsMzDkJdKdaeUVcHDO3c/sBrfSjRBDRn2GXqImyy9axIEOYtdQ
 ew8uFgwVeePUhgLcZMBpofUvPexJR0h/xSROhfr1XYSezAAvmEsr4mUhgmQ0GWc+u88y
 51Rxb6b1nCJxekyD+t2Gr8co1dbruaV1Nx5ENqeS2hjGg5cc3EBJ73j7P8095+iykEFj
 TJXfFNlZ5wcgPHAbcD45x63Cg5WqXLFauhI6RdDtngSEB5ytBCra6UAS3ad89StyvTvR
 ncrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729523343; x=1730128143;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tBiNo7TNCD508RfgxEyHjKPVyw0CLHRlRIkc1GYxQbE=;
 b=ZMQhTwn/raArqzFt5All71dKR6odseU5dbOCy74UDfjoLBFkuRs1WgctNBpGDhlODK
 vnwAuLWdvEO7Ggd2jL9fLmy9V5qeLn6xTHiif1vi4E8E6BnW3ONvOLWMLun/MEcKcZ0s
 EGLCIZsUc7bhZyehiKs2bTOyeoqjFr4GpZjJPx09oKZ4I8B0+pUMAEmfBUiYZs/D2RpI
 JT9yNYNGfB/9AhUY0+MseLtn27qndmn/nFQ0JX40/p0gLLpp22DvKlRLzU1youdvHfPX
 lA+D/j1hge3xr249bgdbr4kg/GZ4f8rLY+6nlClbm2aWwW0YM+5Q9QllC2z3rPlbSdIa
 rE+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5aa973m/gqFGefgI4E0u/87qSXNIGQ9qWjfsKeQHGqi3MHglTe6/+JjHA5w4OpmVhM+U3AiKwA2bB@nongnu.org
X-Gm-Message-State: AOJu0YxulcO/equbU/MXr/I2KZhwtKE0eUU363dwg+q303ahNCv0rTsa
 wzop90GcfwrbN+MTExqA2LQneXCbw5qD0J7bPu8Y0yTtH/HPuVajmMyiNnEFuLvL/lMKpdphGhn
 eGZHqgkXO9owtXOXlUl3mQAM+2pmXbY4lKJl0sw==
X-Google-Smtp-Source: AGHT+IG5lGasFFnScks6XFop3zELbFzBkDIuDV1wED0vuSbo3H0Lf1PBIWzMpPRR4LkEhRhm7qN76viqVGgHUZO/XKg=
X-Received: by 2002:a2e:4a0a:0:b0:2fb:5d41:bdac with SMTP id
 38308e7fff4ca-2fb82e93cbfmr47687531fa.1.1729523342563; Mon, 21 Oct 2024
 08:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <20241021150153.487057-1-iii@linux.ibm.com>
In-Reply-To: <20241021150153.487057-1-iii@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Oct 2024 16:08:51 +0100
Message-ID: <CAFEAcA9W6Fb-gvCx268xV+CV7LyWJwCQGqkKFpGQjdT+WiAEUQ@mail.gmail.com>
Subject: Re: [PATCH] tests/tcg: Stop using exit() in the gdbstub testcases
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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

On Mon, 21 Oct 2024 at 16:02, Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> GDB 15 does not like exit() anymore:
>
>     (gdb) python exit(0)
>     Python Exception <class 'SystemExit'>: 0
>     Error occurred in Python: 0
>
> Use the GDB's own exit command, like it's already done in a couple
> places, everywhere.

This is the same bug that commit 93a3048dcf4565 is
fixing, but it looks like we didn't catch everywhere.

thanks
-- PMM

