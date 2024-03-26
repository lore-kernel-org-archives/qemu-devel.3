Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F17C54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 16:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp9dF-0000cd-8L; Tue, 26 Mar 2024 12:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rp9dE-0000Yt-E9
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 12:26:36 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rp9dB-0003RJ-2D
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 12:26:35 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56c29599e0cso1215000a12.0
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 09:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711470391; x=1712075191; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OfEC3a48B+Y1O7CUaD2OYonppU/NLJFsm3rizki4sPc=;
 b=fuXotmZOmtNGilUiLVKy48Pibnzap9SLvDMJGJG/PXELuSGk7nQEFQya2rgKdaVbSf
 Uuw8cb+ig6fItqiP9seo3CMsq7gZjdKA8smtAT6QFyOzO8jX1tbyvH69AJeT7GUm1jKr
 JSYgLtIpY8Tu71VOx8uVGfs0XhbQrBQst5i125pGytXsuh6fFG4iElUXhRe17Ou+jslP
 kXXWf0leMItSMYvpjNLOS0NuLVFckl6zUgpKzyjYNRidfDe5YCdyV2zSKzRFUn2ugOxZ
 cGoYubf4ffucTLWsHmvRTJ97hXxn29sn0o41U7/C+DgVpcaT9rg0rgUb0MwAJCeEeSJI
 IUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711470391; x=1712075191;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OfEC3a48B+Y1O7CUaD2OYonppU/NLJFsm3rizki4sPc=;
 b=br1GKjt/DqT5d36PXJjEKB6OXXpjRADtIKRwTrQuouBrCfnDx/IKf7jyCQc01Y1Ibd
 8PJG79IEQc1hrac03kmYMUBXMV/126eYY9p8Wv15USW2kQavkki1SnI5NMeOlkQKfL+f
 IW98RnU6Df2HAlsAXwq4zarfGFmGSvoOplmFLydIBFVGn0hXRx94CJTrxde51QEHyABT
 A7VPTQ+843PQ6LGrz8+Eisf8LfRCRZ7Psc30p7vnhJNjCE2/8r6ZZ6zcGPZbBiBp763E
 lewvTCn3Bkw6pUs0U6XjLEu2JiBR4bZbBBPz8kJEnJQkr+YxRj/0SFXvVJNH8CM9zQmM
 MwNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMdbFusXhrFF/7pc2OPBFrPyptRepGt4y9nk3TAb8I26ka3qgTTCI94UL/DexE9W8sM8c6RBrZEZs1UIB94kKbtLWrU7k=
X-Gm-Message-State: AOJu0YxpqaHNc1ZQ0IvVeNpXsWKWUGypUbCr3hBKdW6ouIMR6VtzPqa+
 +rPhE50vpOXwGFCFYPIq45VgRcPVPrfs5FO/+giaS+ZrSHOLCFZiS0+dLwitOK+/Zm0/I+dFnI6
 AJM+UFDlrlgwhyZhlj7xc1vqLHwE95NbepfeluqnLn9ehXXJb
X-Google-Smtp-Source: AGHT+IG1U+Sjgzi4a8mGfaN6lxFcfHAbAz3jx4PU/FdsDTCP9LwxHvsHxgWe4x7fZzRlesxGcxQ6l+yWA6A1Bg40Nm8=
X-Received: by 2002:a50:d781:0:b0:568:9d96:b2d1 with SMTP id
 w1-20020a50d781000000b005689d96b2d1mr2217781edi.32.1711470391072; Tue, 26 Mar
 2024 09:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240326131410.93866-1-philmd@linaro.org>
 <517935ff-6f0f-4ef8-878c-9778f6b1bb98@tls.msk.ru>
 <d5ff6e5e-963f-467a-9d5b-3e2d12e16695@linaro.org>
 <1788e23b-1681-4d4e-a281-df5c9ba330e7@tls.msk.ru>
In-Reply-To: <1788e23b-1681-4d4e-a281-df5c9ba330e7@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Mar 2024 16:26:19 +0000
Message-ID: <CAFEAcA-EtpAYq8daOugqGuzmeHzEDOjBq37a0PV=bt6OckTSVw@mail.gmail.com>
Subject: Re: [PATCH-for-9.1] hw/i386: Add a config to only build the microvm
 machine
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Sergio Lopez <slp@redhat.com>, mst@redhat.com, 
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Tue, 26 Mar 2024 at 16:03, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> 26.03.2024 18:58, Philippe Mathieu-Daud=C3=A9:
>
> >> This is not enough.  This step is good already, but it lacks default m=
achine
> >> type selection.  In debian we carry a tiny patch to make microvm the d=
efault
> >> machine type or else it crashes at startup not finding "pc" machine or=
 one
> >> of its required devices.
> >
> > No crash here, what is your base commit?
> >
> > ./qemu-system-x86_64
> > qemu-system-x86_64: No machine specified, and there is no default
> > Use -machine help to list supported machines
>
> Well, this is definitely better than a crash.  I haven't looked at that f=
or
> a long time, initially it just crashed.
>
> Still, this current behavior isn't nice, - in my opinion it should select
> microvm by default in this case.

I disagree. We shouldn't present users with a situation
where qemu-system-x86_64 binary A has a default of "pc" and
qemu-system-x86_64 binary B has a default of "microvm", just
because of the way they happened to be compiled. That seems
liable to lead to confusion. (In general I think that default
machine types are not a great piece of UI which we mostly have
for historical reasons and because all x86 machines look
very similar.)

-- PMM

