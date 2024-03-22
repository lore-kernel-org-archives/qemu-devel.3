Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FE9C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 12:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rne0x-0004fy-9v; Fri, 22 Mar 2024 08:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rne0v-0004fg-E7
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 08:28:49 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rne0t-0007hu-Tu
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 08:28:49 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-513e134f73aso2632576e87.2
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 05:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711110525; x=1711715325; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OuoV62rdX4upOdLa7ME4Zj//MWBhiH7bt8BB6pdrXqU=;
 b=TG8rsj+PGbxGNctWIXmQaNsp0OcJjZ5JWktuN8Q58/AqyzsZ8y1OlnHna2xvoHkKky
 ISAsOCCJ6jieutI9KoGh3uZai9WD/PkTfi4TaPqaaA/P+8sKCtlA6Cx3utiw0aZRhD9b
 3+LpMA4eUUMpFPc5uXWA88D6V2mcFllWULvBvygvAc+pND/tIGaWq0xfwyGTvrdELe1S
 CUpNawPgYlBB0nod26Z+R3aV3Edf16ADFCHnkjqV3hiWbtMYi8gYegFe8fRJVz0drc7F
 uewWkDh/zFBE0npGNnUJ1e7wKYP4IwezIydRZ8UgSuwQQFPuLtIyaixYHIM4EiutCHMi
 BkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711110525; x=1711715325;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OuoV62rdX4upOdLa7ME4Zj//MWBhiH7bt8BB6pdrXqU=;
 b=lK6LUVRO1jp3IjEvhtnIv9R1dxkma0Yycq1HNGBQ4oxb+7dtZNb+VAsDAWXUOBMXuo
 ++I2Za9YOxd0gCNKjK7TaooP2IMzxu1MsBiZpqt+/s5l/2xbQ0Pez1qTLLJFiMSSFnJX
 +hatzYJHtWgoEPbMt3lKduOnCOIKwFzW0ZMfD3UgFy7uZ9eEvrpgK/+XMdg/ixEExpgS
 Q3cJl/nktvVm+cwfWocWS9DPMwwmLSOKE1f014UKOI6ar4nIsdfUuVcRiWTSyOcrO0Vh
 2KWgaQ4zuXfVbEqTSzaho7vlTOJpU0rPZ62AKhnf+CoONgDNkoxgcelWjSC/ka9NjvNu
 /weg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXM4pbp8kmysz1vGQnUTLKej8YKptdNGgN5YuOFhHk0mTsvFxpfS8io70muSO+VrYGyKNRI5fUJSb7cICEIcvCm5Fn2DDQ=
X-Gm-Message-State: AOJu0YyxKsYleISVLfbs4u91Xahsog4fP8Ro9wTG6sECDO4MR6dq+8kj
 AFM7z54r1l0UpOl2curKs5Kde/9qiLZBT6zNFgcda1oyw2ZnB5KgTDmrbX37fdHzSy2bsa8CjKa
 UjOji2QEZ0Cg2rny+5x6ziXPMjnSvegotEEhfKA==
X-Google-Smtp-Source: AGHT+IEyHWXDxwS8aayLW/p7kPK9KNLfZClCbQ/Sum3HELDJXY7xdJOzgPPC5o/t5lsVSStQpWeSDZ9l5rAKy2I+x9g=
X-Received: by 2002:a19:4302:0:b0:513:df6:dcd3 with SMTP id
 q2-20020a194302000000b005130df6dcd3mr1620554lfa.48.1711110525576; Fri, 22 Mar
 2024 05:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240318-fixes-v1-0-34f1a849b0d9@daynix.com>
 <20240318-fixes-v1-3-34f1a849b0d9@daynix.com>
In-Reply-To: <20240318-fixes-v1-3-34f1a849b0d9@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Mar 2024 12:28:34 +0000
Message-ID: <CAFEAcA96rHXOmmdE2OLkc3Gou5sFfTLpV1VbnAwESpr8K4t60w@mail.gmail.com>
Subject: Re: [PATCH 3/3] ui/cocoa: Use NSTrackingInVisibleRect
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
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

On Mon, 18 Mar 2024 at 07:53, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> I observed [NSTrackingArea rect] becomes de-synchronized with the view
> frame with some unknown condition. Specify NSTrackingInVisibleRect
> option to let Cocoa automatically update NSTrackingArea, which also
> saves code for synchronization.
>
> Fixes: 91aa508d0274 ("ui/cocoa: Let the platform toggle fullscreen")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

It would be nice to specify in the commit message what
the user-visible consequences of this problem are (presumably
that the guest mouse stops following the host mouse correctly?)
but anyway

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

