Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5720606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Moktj7cz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPFWn-0005mF-Ho; Fri, 06 Nov 2026 03:42:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xPFWe-0005lj-Pp
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 03:42:21 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xPFWc-0000pd-Hm
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 03:42:20 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6b570ff3dfdso300603a12.3
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 00:42:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793954535; cv=none;
 d=google.com; s=arc-20260327;
 b=FgdcHtCdXU4I/QwfUqF1ltC1WcmX3aqRMonBemf78Om18LMcJ2vHine3rQrqVVhY+g
 UpPf5ejiPd4rD4nfHCkCRzr9m60LIqivwg5VJ5q8avXJA3odp6Ui8IWYgENrl7glg+ov
 uQmaMdY0XA8KuhzsVOEv6COGJ17AlrtTZCXF6HUkIDIs8VxkaXL6mXjYtKfPy2RjccID
 HSMLqBxHf7aUnzwJ6LufMyI+qtITxqAem2h78z8mMqQ9wxQapP5+ny5gsMKGZ+1Y2zoq
 yd2k8j4dS4zTul6zn4DoFOHe+ko85RNpFfjneAKluAZsvoWw8YyScrCP3IVcklD7OYJd
 YnnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=4OdNCqYr2p7YwLKp+Gj2lFugwaiK5zTjdmbQRDLkOUE=;
 fh=U09kqB+fYg9BI5htTEHFdLvmbLawtKTxGHUDcZgWG5Y=;
 b=PsklFIQnao19MfMrSKC1kPRSA28mdAOfzwRi7MYu8ye4CjSA04puV9KwKwx5f01OhV
 WrA/Y2NVdtTBzufDE5Y3NV0KT90H9RwicXDtGKRfS3slxmqgwG/kO2i8kxZrzPTKg4B0
 K+p7IYSjkR0wtwprEtzGDRHebA14gTnx+FzPLMxVEfTx9cbi/8gqVmigYhcCs3X7mWQJ
 uyVYTUihj71TqZ9Swu0LfGIvu2a/9MMW6AME0a3RjiTug1vYPejjmDIRhlbEUteBzRU7
 YnWCuDECVjqpmP8PIXpQEz8a/QokPzBRaaFv+Qkym3uKKQpBNNnM4UhFCt8+3AH2dAhC
 aEpw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793954535; x=1794559335; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4OdNCqYr2p7YwLKp+Gj2lFugwaiK5zTjdmbQRDLkOUE=;
 b=Moktj7czknPFTM89LGr8w8+TeBJQOzFg2nTggwF/Gk5+kALPoU708jyvt4WPI/W9mE
 V3VVuvBCFo8TnCbMCzYjRRXqcK/mqM/a/pZk3x3WKp6e3DswDxumPttB51S1cLHlTIUF
 d9B3cjdembK7Dxj+in3nPlKhSjWr2SNqDqdYeDbYdeVHP1/W2UK5mdyqZcJjIwZT6nIW
 Sl8s4V9zVVewAz9znUF+eGoNkDLA/bJyRSZAKvAWvYLu0sPGRIkxCnxZqGKlCFq8fNGz
 AkJ2N6SYUZtxPVqeSsiICG0gnA+TP43TU7b+Nstevg7DtkP4jdBuaDwyZycs9QL/u0aa
 vJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793954535; x=1794559335;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4OdNCqYr2p7YwLKp+Gj2lFugwaiK5zTjdmbQRDLkOUE=;
 b=qtTO2DXAJu+eOOIatjm3D0yKO5mq0B0PTuFPaWTyg3hwlPjyvfi8dU8JF8zGpT0Fg4
 yi2fpBCQloXATyfdoiC/T4ul91R2vrbPD7cFmGDE0IA/LtguBuw47wPcoxH+KRMp6VE2
 2aPt9DRx233tWiuqG1nVXou0OwmfivphPyI3acAEYJgEtuvNIfdlynlCWHQDCcHuh1Px
 dglgkynKW2kbTQL+IdKFdR03JqMTkBP0PQYLDLQxz5mdDdSo5REF30/gGFf+hMT9Z9u8
 gna/k3ZEt8z/BIYQ3+tvoYuLx6/tcAdjfd6T94pUFxYAnkRBMm8nR8cLz3wXvJiqDLjK
 hNnQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByHVFOVnovPHJGNXNmrU+Upnv2t+tiRy6T0/Iq80S1oiyAKpdeZX9LsJq5hndABxvIs5vlyC//6w29s@nongnu.org
X-Gm-Message-State: APuU4Z9pPLbtcToWV41lmUpfQiWxzTcxYTlqwuzmRJ6LHDwG5Q30GBaO
 jxx0GgZ7AfTI6tPVK4KvSCXghjQccbdfZRPJm0Qz2K/uoN1otMM6kY2gxQNZj4ZngmT4L0LHGnc
 SLTEdUxRNlR3pl058eNttUFyeAmnJ4UM=
X-Gm-Gg: AYBFou11De5QP7czcvEySLjYLmsxDzzTxDaBgS+KNlsYwyIDvM64hJlwOzBwf86DDiU
 eCpgxoxJbvYhwAPnrViMpNC6gY71wdEkljadIQZKl/X7dXwNNyg/Vv3qkM0WRwNd1Gi+MGSNR/A
 bE/RFfgk/u12L9Li9r06J+QhgiC1wF88zosFk/YiMMxQy/y77iYOeIrEWTn8wyXlyw8llL+YwRH
 1em0bscFE6vMbEUFuhhJeZit6tQT8/hDfFOkbCepz1MqVMZKftvG1TIjPuAEpCkCqHSRXBYfFVA
 4OyuOC81ziLvX1ovf9ZWTyywYT5TFAfzxsE5wYflqWGetqywio5CyT7rppoCMvzJuaPjUyPt3sO
 D3TAZs8Bje4YVWB1X+aQpN1zuqIko7de4qv+avMxsROPHoIEKvcV2u1TYjA==
X-Received: by 2002:a05:6402:3889:b0:6b5:665a:d5d9 with SMTP id
 4fb4d7f45d1cf-6b5977ddea5mr1098789a12.14.1793954534859; Fri, 06 Nov 2026
 00:42:14 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105181449.1691-1-luoyonggang@gmail.com>
 <CAFEAcA8ScuuOgjaYNpQOZS37yx=WBzZaKLcVGQs8Tj3JYB3jOw@mail.gmail.com>
 <au2NnibVpewh5VwD@redhat.com>
In-Reply-To: <au2NnibVpewh5VwD@redhat.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Fri, 6 Nov 2026 16:42:02 +0800
X-Gm-Features: AclHuK9IiuqgkkZHvbK6gxNJ2ML39VqtZLwlUsDRIOWwm7OJslO6btRVe7vFdGM
Message-ID: <CAE2XoE-=dkrq+JApBC=x=gP6YU_Y8fGmPD=a_-+W7DuKdkNhSg@mail.gmail.com>
Subject: Re: [PATCH] meson: generate qemu-version.h with a custom target
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 John Snow <jsnow@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Philippe Mathieu-Daude <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 6, 2026 at 4:19=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Thu, Nov 05, 2026 at 06:34:31PM +0000, Peter Maydell wrote:
> > On Thu, 5 Nov 2026 at 18:15, Yonggang Luo <luoyonggang@gmail.com> wrote=
:
> > >
> > > configure_file() writes qemu-version.h at setup time. That result is
> > > not a ninja edge, so a missing header is never rebuilt and compiles
> > > that include it do not order on it. Generate the header with
> > > custom_target and list it in genh. scripts/qemu-version.py reads
> > > scripts/qemu-version.h.in and substitutes -version. An empty
> > > pkgversion drops the QEMU_PKGVERSION line.
> > >
> > > Link: https://lore.kernel.org/qemu-devel/CAFEAcA8bGODxRfRzrimhGN1v2Ht=
cWvApRsyucemZbMUUBVkYwA@mail.gmail.com/
> > >
> > > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> >
> > If we're going back to having an external script, the other
> > way to fix this would be to just revert ab78ac76f44a12 and
> > maybe fc35f2438770, since their commit messages suggest the
> > main aim was to not have an external script.
>
> I'm not clear what problem there was with an external script that these
> were solving ? These also seem to have appeared in a pull request
> without any prior posting for review, which is rather shortcutting our
> normal dev process.
>
> Personally I'd suggest we revert and then simplify the version handling
> in a different way:
>
>  * Remove the VERSION file and put the number in meson.build directly
>  * Emit QEMU_PKGVERSION into build/config-host.h
>  * Remove qemu/version.h and build/qemu-version.h

Oh, yeah, we already have config-host.h good idea.
Seems better, so we just revert the previous commits? and goes this way?
Still have an issue, how to deal with the git version? because that's much =
more
dynamic. Reset to different git versions does not mean we need to re-config=
ure.
So that when the git version changes, we have no need to reconfigure it at =
all.

>
> This avoids any need for rules to generate build/qemu-version.h
> and config-host.h already has logic to regenerate itself when
> meson.build changes.
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

