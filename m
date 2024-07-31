Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA92C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 10:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ6a5-0002V7-KB; Wed, 31 Jul 2024 06:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZ6a4-0002Uc-E3
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 06:29:16 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZ6a2-0006To-Ua
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 06:29:16 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5af326eddb2so1396409a12.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 03:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722421753; x=1723026553; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x3jd6uQpRLcSiqYvfcp0Bn8+wVjS1FMr8cGifJuep2Y=;
 b=DLoa1SgYz0Baz+kYWySr/ODTOlCUvnlzW3JxaKTEZoZVI5gL0apvi0q1lZ1H+CPghi
 e4tmv4dUCSgotBkSDnA8MzC3dUdqQPPNI19VezEnLF95n3SVaLkevbqfjWMstY++J/l7
 +JgcWKg2GbaRi/y0vShSX9bKqWNmBX/VD4AaR5Gf4+fdn/Dbzazsvbgx/5L97sze2WBC
 KVZBhYgyznrHuPmvwwgojKsPngUOI78R0/ZtrmK18coAtfl60aE3Ez1m0OCTG0dDE291
 0JKNk+NHwJUpvNELi4tEYv5dPS9pKfDR000uwvZVXeixeg+J6dK6acGaJEeovontTgmB
 V/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722421753; x=1723026553;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x3jd6uQpRLcSiqYvfcp0Bn8+wVjS1FMr8cGifJuep2Y=;
 b=l+jZHyD70N6L+0PAvysW2p++HeeyFo2Loxs84dk4CS2UjdpqvIqDWjwrPTZ2UGjJnU
 o6pf/WwnFJP0M/xF1LHyrit/gJ4QG/MXlnNLxrKsK0SKQ2GdG0e7/uR1GSEtOBSgwOaU
 omQ7a72IVvnXRH+tgLtbCNSQCHPoUH2DN9/5zsb1RqjemgPxE/s9UKIa5O5+SBEoxc9n
 uro/ZnmxcdhiHDfkl6Wj1ZxpDDxfdxljOSdUUhCzvKi3O+7Cb4rllGjQQ2IGSqFsjaBL
 Ft/t0cHwnvVy1j2EgeJcY7r7WUNfeaxphET/lAX7bN2wkr2M5frHGnSOO2nSdVFqvO+m
 SnUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdN/LeTs5z1VUchEKxUKNZPYfi37KxV0dsKkh+nwGPTgP5qSAWRzRpQTCWp5U2C7h1lCYevjoNbkCizcCFXTGLoaFxJOY=
X-Gm-Message-State: AOJu0YwDlgKwW+7EdwN5Dq8+oDWlyUZnc1tCTAZ2v00eOt5gc+4np78Q
 Qi1LYdsBaaEtnBpRqTDd2pPEaWnvbQ8UQYfWtoZl5Uhkxdg/ruxFQhKMX+puGMZWcv7nyxwPFle
 SXbKYkm0ugLpe3xEs7YWwP6WiIeHHuNmhKsTjkw==
X-Google-Smtp-Source: AGHT+IFgdTyEODuXD1/OAWNlWcon4DC23x81l/IV0chxSLqqTq1VsGmdmBZKj8atabVyv42odVWdX8DEhcHgg7LGRSc=
X-Received: by 2002:a50:931d:0:b0:5b4:cbba:902a with SMTP id
 4fb4d7f45d1cf-5b4cbc9e0aamr4372577a12.4.1722421752898; Wed, 31 Jul 2024
 03:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <8AFDCC22-C476-45EF-9119-2E3C9A2A91C3@linux.dev>
 <87le1jc8qi.fsf@draig.linaro.org>
 <7F67EEEA-D222-4348-83EF-5C81C94C79D0@linux.dev>
 <87h6c5dh31.fsf@draig.linaro.org>
In-Reply-To: <87h6c5dh31.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 31 Jul 2024 11:29:01 +0100
Message-ID: <CAFEAcA_y1y+5aqDXDUmAzRJo2Kf9o+JwbH-6MB62UEZD=LQZ-w@mail.gmail.com>
Subject: Re: QEMU unexpectedly closed the monitor
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Itaru Kitayama <itaru.kitayama@linux.dev>, qemu-devel@nongnu.org, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Wed, 31 Jul 2024 at 10:52, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> You then need to manually strip out all the various chardevs for libvirt
> control sockets and you can an equivalent command line you can run from
> the console. One thing that did jump out as a bit weird to me was:
>
>  -rtc base=3Dutc -no-shutdown -no-acpi -boot strict=3Don \
>  -kernel /home/realm/Image-v6.10 \
>  -initrd /home/realm/rootfs.cpio \
>  -append 'earlycon console=3DttyAMA0 rdinit=3D/sbin/init rw root=3D/dev/v=
da acpi=3Don'

Also worth checking here I guess is whether virt-install
is running QEMU as a user which doesn't have access to
the /home/realm/Image-v6.10 etc files -- are they world
readable?

thanks
-- PMM

