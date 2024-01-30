Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CB8C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 16:49:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUrI6-00015r-T3; Tue, 30 Jan 2024 11:48:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUrHl-0000wE-Ux
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 11:48:34 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUrHk-0007h9-0N
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 11:48:33 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-55f50cf2021so795630a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 08:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706633310; x=1707238110; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fvg7jTM04r68l8vH9kFk00E3u8Nth1zbgqcIbNnmmyY=;
 b=Jd7YgXwBoc1jlH/p88Dk4+G9TJ/kihGeEgKjtQEerreFV2V/ID5QanMV3dvm2kfJbp
 9/5BbtNwuXbUWp5UyBV6sa8VbbO6WS2m1Pt+J2W/x6np7TS+6cFWGDgwGL0KqT+49NaS
 o4KZBtN+MHSnLg+izUTif8B+YKqQeG9GOX/082BX4Rg15jc/l8r1RwleoTwX+L90rpQL
 ksaatxPuwEahACHjHOBPQJ5MXVEw2gLEOSccFeogMqrOSfIS7fz30UUyHXddAWT0ArGz
 VRIGgalZPQHrmNuGYPIzYI66X5nnFsoQZzDNX6ldvkqLsUaRic9u8Usn0S+msDp8AhDo
 eDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706633310; x=1707238110;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fvg7jTM04r68l8vH9kFk00E3u8Nth1zbgqcIbNnmmyY=;
 b=aomUHrRd6XHhRLBl3z+INVhN0AQTZqF8sTfMYjijMK03Lhl/g4gA8yMWDNXpWGiCeb
 OLh9ActkVzb0M9dnSdQ3SG6Yy72LL3WL0tyh7q+O8L+hU7PB0t8c8WiIlACJnpDC5MUl
 1ynX4Nks6t1KnbyTM6ePneyq0/R+3mLZ0yvs4k3TnCDiNdMJM/6ApDkvLewwjOdHsRQs
 WXERvWd1/gokpNb9YGKKyZ3R6GE4Z+57s8yNdq400hJ0XzmntPXOpg0dj2IhnDqChGwT
 eIVvFmVm0gJ9m9Cj19Nu/QmSdvrAY9RqsXcgXux5lM+wT6FTb6yjImKjpCpl/lEMv7D9
 VcdQ==
X-Gm-Message-State: AOJu0YxqkqBPOJAQ+qHJ9oKrSw9wEEIF4fzi5ueu3nIv1Oaj/HC9PE2/
 ouUR0ntfoXfC9XHYR4FmTW8nfFGErZxt5HjWYtyRrrmyXzbFNV+IQHRXw7Ewk/68qpQByLnSDyF
 V6Adb+yMtv4So3PFf/VqfA+YrzQBrCdzZOmOD4kW2HI6JgtIe
X-Google-Smtp-Source: AGHT+IFU7eHulGxFB9ezHYe0jc8UcZoIWEt9shcq67lEqXLd6VOqBk27ZbdRDd6k+xqpXZRQ68ktBm0yxJ+Dl/jJNIY=
X-Received: by 2002:a05:6402:510c:b0:55f:4b07:f383 with SMTP id
 m12-20020a056402510c00b0055f4b07f383mr1383554edd.17.1706633310521; Tue, 30
 Jan 2024 08:48:30 -0800 (PST)
MIME-Version: 1.0
References: <20240127202758.3326381-1-jan.kloetzke@kernkonzept.com>
In-Reply-To: <20240127202758.3326381-1-jan.kloetzke@kernkonzept.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jan 2024 16:48:19 +0000
Message-ID: <CAFEAcA_rF=wMB9agr9mt4iSz6_WKxRdMLGqLZoTSG+V+pePfig@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: fix exception syndrome for AArch32 bkpt
 insn
To: =?UTF-8?B?SmFuIEtsw7Z0emtl?= <jan.kloetzke@kernkonzept.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Sat, 27 Jan 2024 at 20:30, Jan Kl=C3=B6tzke <jan.kloetzke@kernkonzept.co=
m> wrote:
>
> Debug exceptions that target AArch32 Hyp mode are reported differently
> than on AAarch64. Internally, Qemu uses the AArch64 syndromes. Therefore
> such exceptions need to be either converted to a prefetch abort
> (breakpoints, vector catch) or a data abort (watchpoints).
>
> Signed-off-by: Jan Kl=C3=B6tzke <jan.kloetzke@kernkonzept.com>
> ---
> v2:
>  * Refactor watchpoint syndrome rewriting
>  * Drop ARM_EL_ISV from watchpoint syndrome
>
>  target/arm/helper.c   | 18 ++++++++++++++++++
>  target/arm/syndrome.h |  8 ++++++++
>  2 files changed, 26 insertions(+)
>

Applied to target-arm.next, thanks (with a cc: qemu-stable header added).

By the way, if you're interested in incorrect syndromes with
AArch32 Hyp mode, the other one I know about is
https://gitlab.com/qemu-project/qemu/-/issues/1153
which describes some issues with the syndrome for traps
of VFP or Neon instructions. I don't know if that affects
your use-case.

thanks
-- PMM

