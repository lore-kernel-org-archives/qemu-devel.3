Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728FAC4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 11:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXJMK-00019E-Cl; Tue, 06 Feb 2024 06:11:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rXJMJ-00017V-6x
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 06:11:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rXJMH-0002s4-FJ
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 06:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707217879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m4OTAh7xP4KOT7F/Xee7SiXfa0lfqd4FUK/7YCdTDv0=;
 b=ghJjFxNjUbCHgWNy0I9wowHOKg+UVzUcoXpL9D8EITXncBpADN7kxgI05vSNWEKr3GWstv
 m7GBvpgDAlnsojqdlmkhey9URXVVtl0JuOzz1bw/QX0K1KCOr0QSNUh7WurjiLHj1lOW39
 +cTnj0qv+zZ+B8cnKrLRaSrgKmfgilU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-xrZLabQdP5KbGGdljqL-Ng-1; Tue, 06 Feb 2024 06:11:18 -0500
X-MC-Unique: xrZLabQdP5KbGGdljqL-Ng-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-511577b5f74so562779e87.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 03:11:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707217876; x=1707822676;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m4OTAh7xP4KOT7F/Xee7SiXfa0lfqd4FUK/7YCdTDv0=;
 b=rCPjZeNVMjvktddWLAsvFkGmVIo39qJ1Rgbf+bY6CnGOKM1y/KOnWB+e8BuRpf0x+r
 WNdzo4+l0QLnCKrluz+zbK6XrdrMQNzB/KB0v3JzO7XTwz3p6hKztYIuFQCkLbBnDrnT
 wgMVoR8w5qsGCv3uoIwmpj6SiCwAAaYUgQC15bTOgUtDXNTzIAgdkqDox3Urnc7vci8y
 hn6waWlC0rjUIg6yqHjClV+sz4XFRN49PGLLzOPrxGnF5Z2g4j1zZKo3ItaDtMgm6uR0
 WR+XEIPfLEMykttDGGPSak12jGL1gyLHrF3m7gGyVywSDy7JEh6zuV3nMh51Pos4quSl
 uV7g==
X-Gm-Message-State: AOJu0YznAXSqcdZC02gXKfc7omEwpM6P39XMhmtiyImpKZZRID1N/Dfa
 oPv9APi+jI738yPiQF81t8IHf8oFRCsl6XtbbKaK8nI7dc2ifV7SvYm/+wG7yLm2Jxgx6uo5bW1
 QCFfrwu9vDUuOKCvxXeXAejPLOMi+Hr5V2r7tzMmUJw6fPqkhQrj6A2LRX/QHequWOLqttUbEfa
 FYHgBiiWIAeYJgtPbN7P5Qbo/o9zaPFNJRXqwBMw==
X-Received: by 2002:a05:6512:1248:b0:511:5ff3:bd91 with SMTP id
 fb8-20020a056512124800b005115ff3bd91mr1061762lfb.69.1707217876079; 
 Tue, 06 Feb 2024 03:11:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6s9KX2/Ao6v9n9QA/6VNDMGScyYFbGPvcd6qYTF/lcjgdKFt6P9yVDyPG/ZksB72ondPXfK/d8C6df33/8d4=
X-Received: by 2002:a05:6512:1248:b0:511:5ff3:bd91 with SMTP id
 fb8-20020a056512124800b005115ff3bd91mr1061744lfb.69.1707217875741; Tue, 06
 Feb 2024 03:11:15 -0800 (PST)
MIME-Version: 1.0
References: <688c6446-1085-47f8-b1f1-c27e2d71c4dc@tls.msk.ru>
In-Reply-To: <688c6446-1085-47f8-b1f1-c27e2d71c4dc@tls.msk.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 6 Feb 2024 15:11:04 +0400
Message-ID: <CAMxuvaz3D3KK6pzq_++RXgv3jfR3icvL2n-JpTsLzrXBOw-pNg@mail.gmail.com>
Subject: Re: ui/dbus-display1.[ch] are not properly listed in dependencies
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Michael

On Sat, Feb 3, 2024 at 5:41=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wro=
te:
>
> Doing a build of just a single target with --enable modules results in bu=
ild
> error:
>
>
>   rm -rf b; cd b
>   ../configure --enable-modules --target-list=3Dx86_64-softmmu
>   ninja qemu-system-x86_64
>
>    In file included from ../ui/dbus-chardev.c:34:
>   ../ui/dbus.h:34:10: fatal error: ui/dbus-display1.h: No such file or di=
rectory
>      34 | #include "ui/dbus-display1.h"
>         |          ^~~~~~~~~~~~~~~~~~~~
>   compilation terminated.
>
>
> When building without modules, or when not specifying a single target,
> the build succeeded.  So I'm concluding not all deps for ui/dbus-display1=
.h
> are specified, - dbus_ss should depend on this file I guess..

It looks like this can help, but I am not sure this is correct, as we
don't want dbus_display1 sources to be included in the targets.

-  dbus_display1_dep =3D declare_dependency(link_with:
dbus_display1_lib, include_directories: include_directories('.'))
+  dbus_display1_dep =3D declare_dependency(link_with:
dbus_display1_lib, include_directories: include_directories('.'),
sources: dbus_display1)

I have also opened a bug for meson,
https://github.com/mesonbuild/meson/issues/12814 ("Dependencies should
be built before any files of the target (?)")


