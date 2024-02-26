Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBD7C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 17:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reeM9-0006il-MX; Mon, 26 Feb 2024 12:01:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1reeLj-000652-G3
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 12:01:10 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1reeLg-0000Si-3Z
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 12:01:05 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5648d92919dso4349192a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 09:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708966862; x=1709571662; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GXvsRrUPveDb3zsGpf6ad4dx8sWIyepWGFL6PdKE7tk=;
 b=t6feIVfhNsF12uXacI02SdfY7afpnkF7dY9aEDBBVOS4HHZ5SaUPyPpv4Ym90ySll8
 8rP29ei9oLsGdYCv+p2xH1EqP/eajrK40yppul4XtsKYO5pibD2QX2wJMnwALXDOeGMF
 uDsWlXc1LGUkpEB9DA2cXVGGrv7DxDR+eQZkT/mNVYNiypjHZaPTXRY6Q2NoCCYYMDJt
 OBj7kopHqN7tqiBoVRZnM0lj2kzHHDr4ysFnRzpolj/Ycsl44U7sr/3YIX+t5k27Ew00
 haf0+h9QX2HX3M+He5+/hmN/g3JyPNi4f1Vo1DTs19JOm2SK2zr/YUUrGTqo8aBp0slf
 VjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708966862; x=1709571662;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GXvsRrUPveDb3zsGpf6ad4dx8sWIyepWGFL6PdKE7tk=;
 b=aMPzN1bW8tZifvMRIPmnMaUYSTyM81hs2SKCEAzz+6b3leNdpBHx9bpdCcv1LAT9yF
 WY/pBYOYx9Gwkm7EaGmXjOfAsImkbVK/d+8TvCK+7Jc/cXJbSc6SzaQHjhbSsouHohER
 dDto//eYa4wOX5g0HRd1wx+QJwC0O2kTLI3DwUoEHl35yaEpN/TH9vK/gz0N6v+loCdt
 3dOl8G/BbupMtvBHBFq/xNJslfAMjtqAegcWgtEHVZef8E9yNdovdzDOLaqhsWer94wL
 JP+Rlmu+cZ4Dn9qWUeW0B73o5NPc2FwySth3lAbgMU7B1X1sEP1ksrmiqP3kEQoW4ONd
 giWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiLktKv+zcXkoQKbDdxJAedLv7KRr8TOGucEUXbyfUzUSjWLDOg+9jxyOyYnW8mzpGtPWqMfo2+xj7GYiyxIwFxCpuDa8=
X-Gm-Message-State: AOJu0Yx4Mux4usfwHiDjhasmEUZp678iskzFf+BLTYefOiybxN6IFK89
 YdzZOfxBI3EUMVwiIZW4d17Pz+uihlwaFcVsTJ1bMGCoYxkalkP6+HfvC3lYsNbmtz35q4hbs60
 l0tna0PeeITEhz0FieSCfSxsS2D6Q/UPnHOi98A==
X-Google-Smtp-Source: AGHT+IHiH4e8G5+541SE2zxBB01H2/72ap9GmCYHQIa9Dp50fK8f065kTToW7jJiPR7CIyMyj9gwx4dRWzYGf4majEA=
X-Received: by 2002:aa7:c695:0:b0:566:ef9:a499 with SMTP id
 n21-20020aa7c695000000b005660ef9a499mr1362944edq.1.1708966862601; Mon, 26 Feb
 2024 09:01:02 -0800 (PST)
MIME-Version: 1.0
References: <20240224-cocoa-v12-0-e89f70bdda71@daynix.com>
 <20240224-cocoa-v12-3-e89f70bdda71@daynix.com>
In-Reply-To: <20240224-cocoa-v12-3-e89f70bdda71@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 17:00:51 +0000
Message-ID: <CAFEAcA_h0cYY45Dwz2aOc6bBc5QErd-Uj42swNXf_MZRwncMsA@mail.gmail.com>
Subject: Re: [PATCH v12 03/10] ui/cocoa: Release specific mouse buttons
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Sat, 24 Feb 2024 at 12:43, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> ui/cocoa used to release all mouse buttons when it sees
> NSEventTypeLeftMouseUp, NSEventTypeRightMouseUp, or
> NSEventTypeOtherMouseUp, but it can instead release specific one
> according to the delivered event.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  ui/cocoa.m | 36 +++++++++++++++---------------------
>  1 file changed, 15 insertions(+), 21 deletions(-)
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

