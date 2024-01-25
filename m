Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C09C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 14:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT18d-0003K9-6t; Thu, 25 Jan 2024 09:55:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rT18c-0003K0-7J
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 09:55:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rT18a-0006fB-FK
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 09:55:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706194527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CVyiBYfdFM4kEuPfBazWRhxgsFEEyA0O3kbPtWlu76o=;
 b=XDiAz8QC8MducITyZ+EVzn7tbV7vFV6pQFaqK5iZzmQZyMg4IpUSLH57b1TFlstgraYiWJ
 2KzHFzRWwNAb2c+RdKTiiHwD97nbMrRWm7omhnGiQ4peITX0IT4wuTm/LlLZS08AqLRTC+
 ls0YwRhc1KebG++sg+BbZVg265AxVrg=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-JQJy9MnwOUez1mcYvtliKw-1; Thu, 25 Jan 2024 09:55:25 -0500
X-MC-Unique: JQJy9MnwOUez1mcYvtliKw-1
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-7d2d72f7965so1403624241.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 06:55:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706194525; x=1706799325;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CVyiBYfdFM4kEuPfBazWRhxgsFEEyA0O3kbPtWlu76o=;
 b=VeehkwQqCyzaO067Ghdsv+feJssESuiwgTxlNi0wtzK6V6Fzph9bK6O84GywIRubp1
 YOmz8I8aOF67rIal+72Ytisd9RYyuPtD2JQkjS+Zow2TMb/S0HUrz0XpeakoklbOjQ97
 6gN22zhJ5k43x11zG272Sb/iFhQs8Ms3iUFxgz5Bsjke9es3jvR2BwztN2xiIsprYzzy
 /NieAO7ExmImhtA7p9U7J4CXPp40RaVsGkhiPL+Xv/u7w12vUy6hu8j7UV0F/csq2udc
 9eej5BofXy31m9VSAT65t8dDFv0oSeFQ17c40kM02qKhawgbhK+vVElR3AVwmmoyxMbp
 O7Mg==
X-Gm-Message-State: AOJu0YwawDqvQAuM3Y07nyAM16x3K93HFuzfJ+Mhap90krdzrvhdL/Ga
 Bb02Q4T4LeaS/Ry+Z4iYKKsKwPfWPKHf4UqpjdQobf2JgjozAFHxaFBeqo8XocIqpsiDCkH05R0
 mrRwQsDP6Ic7HWu2S98DZgvzBTUBD3QDaJaTzJh3OBic4xpsigOPJnyXb47IBgPFVWzv2aYkPLA
 c/7Ukd9AeNLwbxREdh6BSnR2ectOSa4sRyFPOWEQ==
X-Received: by 2002:a05:6102:30a4:b0:46b:2bb:6936 with SMTP id
 y4-20020a05610230a400b0046b02bb6936mr519073vsd.33.1706194524726; 
 Thu, 25 Jan 2024 06:55:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSDu0ldgOBBa3lQrlJXmmS2zcvTbkatr4zwGLgeqH8Q8jgRdL6met16Xa0lKNCRBAPW5B3+Q5to6R2nhHX2kI=
X-Received: by 2002:a05:6102:30a4:b0:46b:2bb:6936 with SMTP id
 y4-20020a05610230a400b0046b02bb6936mr519067vsd.33.1706194524369; Thu, 25 Jan
 2024 06:55:24 -0800 (PST)
MIME-Version: 1.0
References: <CABgObfaCq+++xj7ow5Sm22P5nfMZyh-BKt57m3Po6voKyCnuXQ@mail.gmail.com>
 <ZbJxlgqwkRdmdYmB@redhat.com>
In-Reply-To: <ZbJxlgqwkRdmdYmB@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 25 Jan 2024 15:55:12 +0100
Message-ID: <CABgObfYNcm+8_gZY4-ggCouCYvWDHfzrQKr1uRb5vQM4+x=zBQ@mail.gmail.com>
Subject: Re: Do we still need pre-meson compatibility hacks?
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Wolf, Kevin" <kwolf@redhat.com>, 
 "Maydell, Peter" <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jan 25, 2024 at 3:35=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
> The latter feels redundant, but the former feels worthwhile as long as we
> keep a wrapper cnofigure script around.
>
> It seems like we're not far off being able to do a build with the normal
> sequence of
>
>   meson setup build
>   meson compile -C build
>
> The creation of the config-host.mak and config-host.h files looks like
> the big one. I feel like config-host.mak ought not to even exist. Meson
> only consumes a subset of values written into that AFAICT:

The big one is actually everything else that configure does. :) All
emulator build tasks and tests (especially config-host.h) are done in
meson.build, but there's more than that to configure.

At this point, concerns are well separated between configure and
meson. QEMU has a complex multi-target build system that goes beyond
what Meson is designed to do well; but it also has a complex
multi-binary component (the emulators) that goes beyond what can be
done easily in Makefiles. So we have shell/Makefile to orchestrate the
build, and a single meson/ninja step underneath it for the emulators.

Creating the Python virtual environment _could_ be part of the Meson
Python module, but it doesn't make sense in my opinion to do so.
First, because the virtual environment is also used by other non-meson
parts of the build, notably by Avocado. Second, because it would force
us to use very new Meson versions now that we've been able to rein
that in. (Third, because I can't afford the required time :)).

Determining the firmware and tests trees to recurse into, based on the
list of targets and the detected compiler environments, cannot be done
in meson because it only supports two compiler environments. It also
does not map well to the meson DSL.

> $ git grep 'config_host\b'
> meson.build:config_host =3D keyval.load(meson.current_build_dir() / 'conf=
ig-host.mak')
> meson.build:target_dirs =3D config_host['TARGET_DIRS'].split()
> meson.build:default_targets =3D 'CONFIG_DEFAULT_TARGETS' in config_host
> meson.build:if config_host.has_key('GDB')
> meson.build:  summary_info +=3D {'gdb':             config_host['GDB']}
> meson.build:summary_info +=3D {'genisoimage':       config_host['GENISOIM=
AGE']}
>
> and I would have thought meson could detect 'gdb' / 'genisoimage' itself,

gdb/genisoimage are used by only used to print the summary, they are
not used anywhere in the emulator build but they are used by the TCG
and Avocado tests.

It should be possible to move TARGET_DIRS and CONFIG_DEFAULT_TARGETS
to meson options and remove the need for meson.build to read
config-host.mak. I would not reject patches to do so, but building
qemu.git without going through configure was never a goal of the
conversion. (The only wrinkle would be that the default TARGET_DIRS
are computed with globbing, which does not exist in meson, so one
would have to list the desired targets by hand. That's not a problem,
it's just different from "./configure").

Paolo


