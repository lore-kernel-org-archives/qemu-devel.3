Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028A4D68BC6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 15:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tByfE-00022B-6I; Fri, 15 Nov 2024 10:55:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roqueh@google.com>) id 1tByf8-0001yb-7b
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:55:11 -0500
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roqueh@google.com>) id 1tByf4-00027z-JB
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:55:09 -0500
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-85054107836so870830241.3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 07:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1731686104; x=1732290904; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a4HYRRIA5q/ZGEnFka+Byr5VVSYP/JpvMLSv0fXPWGQ=;
 b=XHI2ab24JQdCPQ6fJtGvIowFA1Dd9gzJ9ey8vzlshHiK/Ccx5ndW63Bf7DSFBaLRJ7
 cmAcR7Ur6Bddc5hfn9YkuiyrU8LNL2QGNpw92XSK7r20i2K02zg5BNDxKi2byr8iL6Dw
 oMKMyihXwk179xMJecow23zI8p0bwvyMSt/I8lsCZzoVi71gto2J/xbslhPnPfKzb6i5
 qfApwtjIFugi2opGWZ8OSuBmBKe5w6YSEQFHL3K9nAuDjX/t4qR0UedX9d7TSF0yaMYw
 Obg6rVxZk/hoZgtUlPOxnRCeka8HvES4s48/F/jfDRtwBvps7GUskHg+upePGmI3zTCB
 4GZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731686104; x=1732290904;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a4HYRRIA5q/ZGEnFka+Byr5VVSYP/JpvMLSv0fXPWGQ=;
 b=cRTKxxLkEVifV0Uasjr3XipwX9SCjplYiep0Mosedskt6yulkfH00uaiuYemR4TlXU
 uoNFvODng9QEy95G0e98Li108gCyDWZDaAryoyq5Hd4hLRfAbvYE1EUSWBIvrtxgGRs9
 a3Iu5c4FGW+nj18lGxN3aCQfvUC4T7zo/dwtOi5QpPlxHw1lxe/gI4HbKRt3pSRnOSdV
 GgG1IVO17unX95bgYhIt0AI+UN0yRiE6xh1DjddvHbATDZ7sxB1r73u714B9l+6YrSyV
 KjQnDYwbvJHO0/KERhf11eONjkEuf6e/hGotr5JCYvyf+n8ETreh1OfUMVxmbf7OiRPg
 Xdog==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGSw2Sh43IeGk9fwfKzpR8D/qsXLa+lupo/Q16WKBD7rlnPQGVDBMvfwdDum/qB2OLhD4VIrNGNRcH@nongnu.org
X-Gm-Message-State: AOJu0Yx/vfPmmMysNzSJ2AEuX6ojcloHHR/CRIRNvSKUAgmIU3DsQ+WZ
 Fqov/UtnPlc7V7ACumry7h237nBlTvJSZ1GHiW9R033D7jjzWZEF3pu5ieBTJPJfHx/rvMANW2w
 FZIjQ2AibmqIUuGiPgmwQo66gs7UpW1KMmB2S
X-Google-Smtp-Source: AGHT+IFBt2+X3QuSQt2L26UC6+e5sZ7Y2sazaRDlKvz8z95aMJkep+T06ZhXY4IwnzPlEhoXQOwBQmN0EKrxQYPnhBg=
X-Received: by 2002:a05:6102:5896:b0:4ad:635b:d17f with SMTP id
 ada2fe7eead31-4ad635bd208mr2773688137.10.1731686104289; Fri, 15 Nov 2024
 07:55:04 -0800 (PST)
MIME-Version: 1.0
References: <20241108191024.2931097-1-roqueh@google.com>
 <20241108191024.2931097-4-roqueh@google.com>
 <CAFEAcA9DDVqgOs7B3kC30=OgJ8iLZ3R3RB6BdEBMEKNxx0LAjQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9DDVqgOs7B3kC30=OgJ8iLZ3R3RB6BdEBMEKNxx0LAjQ@mail.gmail.com>
From: Roque Arcudia Hernandez <roqueh@google.com>
Date: Fri, 15 Nov 2024 07:54:52 -0800
Message-ID: <CAKbPEtYa6pr2v9rFizo5-TU5ong8j3zJVyWnEwTR2eK=cNA1Qg@mail.gmail.com>
Subject: Re: [PATCH 3/3] tests/qtest/cmsdk-apb-watchdog-test: Test INTEN as
 counter enable
To: Peter Maydell <peter.maydell@linaro.org>
Cc: farosas@suse.de, lvivier@redhat.com, slongfield@google.com, 
 komlodi@google.com, pbonzini@redhat.com, venture@google.com, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=roqueh@google.com; helo=mail-ua1-x92c.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Thanks for pointing this out. For now I'll be adding the extra line in
the version 2 of this patch.

On Thu, Nov 14, 2024 at 5:01=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Fri, 8 Nov 2024 at 19:10, Roque Arcudia Hernandez <roqueh@google.com> =
wrote:
> >
> > The following tests focus on making sure the counter is not running
> > out of reset and the proper use of INTEN as the counter enable. As
> > described in:
> >
> > https://developer.arm.com/documentation/ddi0479/d/apb-components/apb-wa=
tchdog/programmers-model
> >
> > The new tests have to target an MPS2 machine because the original
> > machine used by the test (stellaris) has a variation of the
> > cmsdk_apb_watchdog that locks INTEN when it is programmed to 1. The
> > stellaris machine also does not reproduce the problem of the counter
> > running out of cold reset due to the way the clocks are initialized.
> >
> > Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
> > Reviewed-by: Stephen Longfield <slongfield@google.com>
> > ---
> >  tests/qtest/cmsdk-apb-watchdog-test.c | 214 ++++++++++++++++++++++++++
> >  1 file changed, 214 insertions(+)
> >
> > diff --git a/tests/qtest/cmsdk-apb-watchdog-test.c b/tests/qtest/cmsdk-=
apb-watchdog-test.c
> > index fe535a553c..3777b7bd59 100644
> > --- a/tests/qtest/cmsdk-apb-watchdog-test.c
> > +++ b/tests/qtest/cmsdk-apb-watchdog-test.c
> > @@ -68,6 +68,15 @@ static const CMSDKAPBWatchdogTestArgs machine_info[]=
 =3D {
> >      },
> >  };
> >
> > +static void system_reset(QTestState *qtest)
> > +{
> > +    QDict *resp;
> > +
> > +    resp =3D qtest_qmp(qtest, "{'execute': 'system_reset'}");
> > +    g_assert(qdict_haskey(resp, "return"));
> > +    qobject_unref(resp);
> > +}
>
> The system_reset QMP command only requests a reset; it does
> not wait for it to actually happen. For that you need to
>    qtest_qmp_eventwait(qtest, "RESET");
>
> We seem to already have several implementations of this
> kind of "reset the system under test" function, several
> of which have this bug. That suggests to me that we ought
> to provide it as a utility method qtest_system_reset()
> in libqtest.
>
> thanks
> -- PMM

