Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC50C19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 09:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4dMb-0004XK-NP; Wed, 08 May 2024 05:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s4dMa-0004WF-1A
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:13:24 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s4dMY-0007QA-Fk
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:13:23 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-43ade9223c0so19724371cf.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 02:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715159601; x=1715764401; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=omOATQVdU8puAda5atQ74QtzUxYUp6MoLUxCOOsXj2Y=;
 b=UEhJA6lMFkdHBnCPVIzIHh/q/UFvD6x+gwmkTfeAvfdcH/ImrCy9f9GqeNGxwx83jQ
 kQNutktK6DP5CN5VyfqjRB/hZeNZdIDsuwIXreODn3M5UKAR7YdXK7z8oqFNomQ8TzhY
 JsljEeubE/wd49bVDWhmBO05sqNCvVljXhua4XTGrp6FlRXnhmb6ScsgfJ6UeI9guRgk
 A6W65OHmMUUtiQZlcnXjinSuI3cJjnICQ2r9UGf+UK4Uh2/rnMg8ApxRKvtyXOk5XEug
 hNf78E4k7//wbaExhraCdsJmPwwil/yexk/rwzBkPBcL1U3j/kneqXGGqi/gzRXrs/nN
 dlag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715159601; x=1715764401;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=omOATQVdU8puAda5atQ74QtzUxYUp6MoLUxCOOsXj2Y=;
 b=hUVbYu2YH6y9TG9GMThHAfrtehl/ruAd+CmFDJMBCmWaLB3ijX1QCJEJKa8FYu6om0
 TrEz/0Z4TlKkTalnknnQmf6E3UJ6SUadpFFNt/vn92r6rHd+CqafB/K259pL6wM9JNvr
 YYZ1Hha+xQi9lK7qHYF+6/LWfeCoWpNSGhhctGLCR0YfNPJpKJevtbRX1l8n/lthhGDf
 BX6D4ZxCutgd9bFp5AAqeZfPtisAg2ZYQED/Lub8ewBc7VhJXjQNSQetd4RPMgU5NleX
 Xh6N68v7ztJeKtXKdrdX4XlaE8CrPsVWj58KEcxjJIlaCxMHuOraHRCLYzjhiX/gbjV2
 qtAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4Ry0nW70QrIy8x54UzEZuK36hxN5DVmjeUlEs2gMfjaRgyyyYRecAets04QLkT59FbjPo8Mw1Yd7rdUPNz8BYrLDTIjA=
X-Gm-Message-State: AOJu0Yyevloqd3yPnUzzIwJIViz+uOGblFJoD4VwgQCV9PwOWqBdujIM
 d0AUTPW0yCYVJwhkSiZACGveFWRrB48GVkxtj9y/cOnduuWa3bOLr/Cnjqpiwj1PAE3u3sTB6WL
 JgDzrGKaxA4kZz1J6TUYdLo/GdOk=
X-Google-Smtp-Source: AGHT+IEuKpn2yEUCaZSVRPMudJ5PJUJI5fYezpn1G9WanCvpYOMWTkIP0auyuY4a3610a6wVOS5ULM/ljTF7Jd5CiyA=
X-Received: by 2002:a05:622a:1:b0:439:8741:5208 with SMTP id
 d75a77b69052e-43dbf50f7femr21737311cf.23.1715159601280; Wed, 08 May 2024
 02:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAOGAQeqOVAHJ4VxQNKqO43hmLJdxpA6E_JEQrfL380SwT4Y73w@mail.gmail.com>
 <Zh0NiI9ZfS5uzs5Z@redhat.com>
 <CAOGAQerx0DmHvJNf05wuJFOtXVwDFTt7fy0-GmBZ7xKoLAHTKQ@mail.gmail.com>
 <ZiDpM7ZusU0SvH7K@redhat.com>
 <nga2k5uuvpqm2sovguofglw6u3reiqqurbn7vbdexanzrhmw42@vuje72e57egu>
 <CAOGAQeqU692hHf3dU7udz8hwzP6KuFTNWir0mLcV-URF-JkFnA@mail.gmail.com>
 <zyj7huwfzji6c5bkq44o56nizo7fju5kn2nqg2n5niuwdzsnkl@ykhg5yqruvwr>
In-Reply-To: <zyj7huwfzji6c5bkq44o56nizo7fju5kn2nqg2n5niuwdzsnkl@ykhg5yqruvwr>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 8 May 2024 13:13:09 +0400
Message-ID: <CAJ+F1CKvBW_khQ+zwKiunWGUQYtC_RKnVvUWbZpZALHv07efBw@mail.gmail.com>
Subject: Re: Hermetic virtio-vsock in QEMU
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Roman Kiryanov <rkir@google.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org, 
 QEMU Developers <qemu-devel@nongnu.org>, JP Cottin <jpcottin@google.com>, 
 Erwin Jansen <jansene@google.com>, Mehdi Alizadeh <mett@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82b.google.com
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

Hi

On Wed, May 8, 2024 at 11:50=E2=80=AFAM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> Hi Roman,
>
> On Tue, May 07, 2024 at 11:20:50PM GMT, Roman Kiryanov wrote:
> >Hi Stefano,
> >
> >On Tue, May 7, 2024 at 1:10=E2=80=AFAM Stefano Garzarella <sgarzare@redh=
at.com> wrote:
> >> I have no experience with Windows, but what we need for vhost-user is:
> >>
> >> - AF_UNIX and be able to send file descriptors using ancillary data
> >>    (i.e. SCM_RIGHTS)
> >
> >As far as I understand, Windows does NOT support SCM_RIGHTS over AF_UNIX=
.
>
> Thank you for the information. This is unfortunate and does not allow
> us to use vhost-user as it is on Windows.
>

fwiw, Windows has other mechanisms to share resources between processes.

To share/pass sockets, you can use WSADuplicateSocket. For shared
memory and other resources, DuplicateHandle API.

(you can also share other things like D3D textures etc. those
mechanisms are used to enable -display dbus on Windows efficiently)


--=20
Marc-Andr=C3=A9 Lureau

