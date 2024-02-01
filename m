Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C64DC48286
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 20:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVdWo-00024f-D5; Thu, 01 Feb 2024 15:19:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rVdWk-000249-8W
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 15:19:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rVdWf-0001ec-2C
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 15:19:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706818747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LOkzmmBUqR6mrhDTlbb9FzVhJ1j4bAUpu/WIXg/ForM=;
 b=c2vTBdEesNYHB8mV6fKZJFZ60nMi2mlm/i71waQKGcPcYcpfXZ2/tUa3GPOK0NNuRt8aSL
 swzv0p/7LLR3woOOOB6G/uupeaa6xqYcPMbq8EWsbT/jdRG1P+uLCXNQBYKn8j0/7nnYxT
 m5rkZL3SxJRFVzWV1XbOB2Gdo/90/QA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-on3F7urOMDyH53FQUeQJeQ-1; Thu, 01 Feb 2024 15:19:06 -0500
X-MC-Unique: on3F7urOMDyH53FQUeQJeQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-290f607c1dfso1153915a91.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 12:19:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706818745; x=1707423545;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LOkzmmBUqR6mrhDTlbb9FzVhJ1j4bAUpu/WIXg/ForM=;
 b=Ivx7qKAbNVpv2N818CzB6WjdLR3VA3hHKssUNfTcZo98JNFJlloSG2/kV+jfju9Plv
 WWpiSmRN5wu+WEH1Rzy1Iyyrv12tiVF42k5RQDKk9QZsX5NyiSATTXOXbZ5EfRFtdCd2
 Nogi4RMYKznt84Dpiv+48L6LONFhXVpFAP8HmRL154GaGbQqWcSw5jhcXN8GClaQOr39
 lhVTeM6YMHnFvewhmAHSydagIoY4GM4i4qT6Mjvg/7QDUqyeh7HchK3jLROI/7Hxu6S/
 05aCDHReVAOSqZCpJ89qdAbhCoiW2Pm0BtkpFFOD3ROGEVLa+bMhbPSQQNS5wWN2G681
 IpQw==
X-Gm-Message-State: AOJu0Ywv+Hp1Da3D3ecFQPoFuvviIg61k/ZaR1FQBl/JeHjpjmSv01AR
 NT4YjPuimD0ZUu+DtzSFwoxx/fbU0yfGQuNifvLbqQhHaL4eQfOLKUr2w2o6LAXwnUq2j7+X9ub
 zkRcWAVl5tSa1fCqrzshs9BP3iwM7eo3Vlpg5Wk86IA77ZrnOM1V6TWl43CH2NIzyHp4kqtNapB
 C4z0eP74HZue5+bkbC4Xe7sYdRI7s=
X-Received: by 2002:a17:90a:1f81:b0:290:4637:1808 with SMTP id
 x1-20020a17090a1f8100b0029046371808mr114755pja.26.1706818745038; 
 Thu, 01 Feb 2024 12:19:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLWQ9vQn6T/amWmuveXAFTZu10qMxuqchxg8jkB1HOnoIMgFbO2Ccvc3DThUdvMm1nbdLnJ74oBkKupjmopbs=
X-Received: by 2002:a17:90a:1f81:b0:290:4637:1808 with SMTP id
 x1-20020a17090a1f8100b0029046371808mr114738pja.26.1706818744763; Thu, 01 Feb
 2024 12:19:04 -0800 (PST)
MIME-Version: 1.0
References: <20240117112407.22462-1-philmd@linaro.org>
 <5ae6d41e-e291-4fa1-94a1-6ec22cd809be@redhat.com>
 <8ae6c891-522d-435a-be63-2e5a5c9d6394@linaro.org>
In-Reply-To: <8ae6c891-522d-435a-be63-2e5a5c9d6394@linaro.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 1 Feb 2024 15:18:53 -0500
Message-ID: <CAFn=p-b1ejotX2coQcvbOvAQGeLuSJEnk+SF=n=68X1gB=MCgg@mail.gmail.com>
Subject: Re: [RFC PATCH] tests/vm/netbsd: Remove missing py311-expat package
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, 
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Reinoud Zandijk <reinoud@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
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

On Wed, Jan 17, 2024 at 9:03=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 17/1/24 13:10, Thomas Huth wrote:
> > On 17/01/2024 12.24, Philippe Mathieu-Daud=C3=A9 wrote:
> >> Per commits a9dbde71da ("mkvenv: add better error message for
> >> broken or missing ensurepip") and 1dee66c693 ("tests/vm: add
> >> py310-expat to NetBSD"), we need py-expat to use ensurepip.
> >>
> >> However the py311-expat package isn't available anymore:
> >>
> >>    ### Installing packages ...
> >>    processing remote summary
> >> (http://cdn.NetBSD.org/pub/pkgsrc/packages/NetBSD/amd64/9.3/All)...
> >>    database for
> >> http://cdn.NetBSD.org/pub/pkgsrc/packages/NetBSD/amd64/9.3/All is
> >> up-to-date
> >>    py311-expat is not available in the repository
> >>    ...
> >>    calculating dependencies.../py311-expat is not available in the
> >> repository
> >>    pkg_install error log can be found in
> >> /var/db/pkgin/pkg_install-err.log
> >>
> >> Dropping it from the default packages list allows creating the
> >> NetBSD VM and build / test QEMU, without error from ensurepip.
> >>
> >> This reverts commit 1dee66c693 ("tests/vm: add py310-expat to NetBSD")=
.
> >>
> >> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2109
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >> ---
> >> RFC because ensurepip seems important due to cited commits
> >>      but I'm not sure where it is used, and this fixes my CI build.
> >
> > Thanks for tackling it, I also ran into this problem already and just
> > did not have enough spare time yet to investigate.
> >
> > I searched a little bit, and found this text here:
> > https://mail-index.netbsd.org/netbsd-announce/2024/01/01/msg000360.html
> >
> > "
> > - Several packages have been folded into base packages.  While the
> >     result is simpler, those updating may need to force-remove the
> >     secondary packages, depending on the update method.  When doing
> >     make replace, one has to pkg_delete -f the secondary packages.
> >     pkgin handles at least the python packages correctly, removing the
> >     split package when updating python.  Specific packages and the
> >     former packages now included:
> >
> >       * cairo: cairo-gobject
> >       * python: py-cElementTree py-curses py-cursespanel py-expat
> >         py-readline py-sqlite3
> > "
>
> Thanks for digging, I'll update the description.
>
> > So it seems like the py-expat package has simply been merged into a bas=
e
> > package now. Thus I think your patch is fine. It also fixes the problem
> > for me, so:
> >
> > Tested-by: Thomas Huth <thuth@redhat.com>
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> >
>

Quite late, but thank you both. If py-expat was folded in, then this
is definitely safe. mkvenv.py could possibly use a small update to its
error message hint:

            "(Hint: NetBSD's pkgsrc debundles this to e.g. 'py310-expat'.)"

I don't know if this is safe to remove in its entirety just yet,
because I don't know right away if any NetBSD distributions that we
consider "supported" still use a de-bundled py-expat. (Maybe this
error is still helpful for certain users in some cases we technically
support?)

If that's not the case, then we can simplify mkvenv and remove this
error handling case entirely.

--js


