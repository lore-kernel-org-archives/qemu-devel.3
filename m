Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED0BC5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 19:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcVX6-0002MI-To; Tue, 20 Feb 2024 14:12:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@google.com>)
 id 1rcVX5-0002M8-Ju
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:11:59 -0500
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <komlodi@google.com>)
 id 1rcVX3-000407-Vo
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 14:11:59 -0500
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-42e2507c6e1so34581cf.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 11:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1708456316; x=1709061116; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pvfWDYut8l6v8KBlWeQCoO3/Y8scb8lJBkXSrP9EqtA=;
 b=RK7LV4IzTBrm91gs/nh1uFgEvHPMilKGXut4KL0UHOTChfFiauVEHDQ4l7dnDPX2nT
 YYi5a2GhU2pTtiBMYf72uzYTQRaLasPvrllxblT/oJGj3VhaYKNNyBUYFd0COQGp09qp
 0vRSG12HRKeGOlw9lir9dThn5p7GkN2oom7zpEHst+zkLa4lAmHoqkiZbG+r6mUifJDn
 8OuOWpLntagNvlSAtLd5ffInKyD3TaRIcuDWdEpW9n1q+/tmyilLR4AeNXgwAZg+T+L8
 d5Nww4Maabxmo2Cg8G68XR8JBr5UlIi3A0HG2fqmkDTZy+G1t//OOKTNSV7DKctLsznj
 Rrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708456316; x=1709061116;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pvfWDYut8l6v8KBlWeQCoO3/Y8scb8lJBkXSrP9EqtA=;
 b=tucjvXBxaKG9ZpIL9SOADdo97Fa+zc4KgQ6+LoWXuTpKtT7IO0grot6h0fOl71LqQi
 EHgRONDAfXBdmb9wbhsku7WvTkpHEYTYk4iSNxQnb1n5v/0ET16ZVXPjVb7PFgqKycEj
 oRXdF/tC/PG7Hzd1FOrWHBA3ZRIOtpzUMgqQ87YXjmociwXDpJ/8mEyuMinfO0M+5dUR
 1g97FCrDIj/8atsP7pPSm62o5o/tvRaKcb5puAZMZDDqP2ounerWbIs78O1gPY0WiWzj
 rOf5dCmReEH6CE7uOU6iX3FjUm/gCKxdbERzIo9shuGX518b5e4x8krPVkQaYrOHVsNL
 iw5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX779CPPMs05t1g5EXBPpl2uB1jTtj1aK9aQgE8aUlwMInFFEbIpG+17bdCuMWv3YDkTIUYKNQfiHf3+M8g76xn2l//aSY=
X-Gm-Message-State: AOJu0YyM9QDMvJQZDWKqtta7Y404uZTbOCCTfWUjMao/QCE0e/nU0cn6
 XHET/zrzf0wO2IX5vHiRqNdm/zDi0FRVHWpZfes0S3uT98l57v/aICtyfOfP+US5tgRZgp3U7vj
 LeknN0JQyuSoji9o0DrFTUpebrP7amXJmPVfr
X-Google-Smtp-Source: AGHT+IEmM1KmYf4xQAQLmYQxQrvAnDytGMFCrG3217vb7qND8asZJufghQCcEZT5h8Q98oiJcN+phhTnmoyIXpSoIig=
X-Received: by 2002:ac8:4e36:0:b0:42e:382:8336 with SMTP id
 d22-20020ac84e36000000b0042e03828336mr15269qtw.6.1708456316149; Tue, 20 Feb
 2024 11:11:56 -0800 (PST)
MIME-Version: 1.0
References: <20240202204847.2062798-1-komlodi@google.com>
 <20240202204847.2062798-2-komlodi@google.com>
 <CAFEAcA8R13bQ7niSXhZPJ3vUD_OdNWpvjpKrWpz-gZsJxO_=dg@mail.gmail.com>
 <ZdAGHThxd2JSyX7b@mail.minyard.net>
In-Reply-To: <ZdAGHThxd2JSyX7b@mail.minyard.net>
From: Joe Komlodi <komlodi@google.com>
Date: Tue, 20 Feb 2024 11:11:43 -0800
Message-ID: <CAGDLtxvtpTyapH0n-T5Kuvuaeet-5g5nMNUbEEp6qarHfb3M2g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] hw/i2c: core: Add reset
To: minyard@acm.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 venture@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=komlodi@google.com; helo=mail-qt1-x82b.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Fri, Feb 16, 2024 at 5:04=E2=80=AFPM Corey Minyard <minyard@acm.org> wro=
te:
>
> On Thu, Feb 08, 2024 at 04:39:10PM +0000, Peter Maydell wrote:
> > On Fri, 2 Feb 2024 at 20:48, Joe Komlodi <komlodi@google.com> wrote:
> > >
> > > It's possible for a reset to come in the middle of a transaction, whi=
ch
> > > causes the bus to be in an old state when a new transaction comes in.
> > >
> > > Signed-off-by: Joe Komlodi <komlodi@google.com>
> > > ---
> > >  hw/i2c/core.c        | 19 +++++++++++++++++++
> > >  include/hw/i2c/i2c.h |  2 +-
> > >  2 files changed, 20 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/hw/i2c/core.c b/hw/i2c/core.c
> > > index 4cf30b2c86..3128067bba 100644
> > > --- a/hw/i2c/core.c
> > > +++ b/hw/i2c/core.c
> > > @@ -23,10 +23,29 @@ static Property i2c_props[] =3D {
> > >      DEFINE_PROP_END_OF_LIST(),
> > >  };
> > >
> > > +static void i2c_bus_hold_reset(Object *obj)
> > > +{
> > > +    I2CBus *bus =3D I2C_BUS(obj);
> > > +    I2CNode *node, *next;
> > > +
> > > +    bus->broadcast =3D false;
> > > +    QLIST_FOREACH_SAFE(node, &bus->current_devs, next, next) {
> > > +        QLIST_REMOVE(node, next);
> > > +        g_free(node);
> > > +    }
> > > +}
> >
> > This does what it says it's going to do; but I think it
> > would be good to hear from Corey whether it's better to
> > do this, or instead to call i2c_end_transfer() in the
> > reset-enter phase.
>
> Sorry, I missed this, I'm having major chaos going on right now in my
> life.

No worries! I also missed this for a bit.
>
> I don't think i2c_end_transfer() is the right thing to do.  The transfer
> has not cleanly ended, it is just forgotten.

Sounds good to me, I'll send up v4 with the change Peter pointed out.

Thanks,
Joe

>
> >
> > Mostly QEMU's "reset" is like power-cycling, in which case
> > I guess that what we have here where we just forget about
> > the in-progress transfer and assume the device on the other
> > end is also going to reset back to a neutral state is what
> > we want.
> >
> > Does i2c have a concept of a bus-level "reset" operation?
>
> No, it does not.  Most I2C devices don't even have a reset pin.  In a
> reset situation in real hardware, the operation would be aborted by
> the lines drifting high after the bus master has been reset.
>
> So I think this is fine as is.
>
> -corey
>
> >
> > > +
> > > +static void i2c_bus_class_init(ObjectClass *klass, void *data)
> > > +{
> > > +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> > > +    rc->phases.hold =3D i2c_bus_hold_reset;
> > > +}
> > > +
> > >  static const TypeInfo i2c_bus_info =3D {
> > >      .name =3D TYPE_I2C_BUS,
> > >      .parent =3D TYPE_BUS,
> > >      .instance_size =3D sizeof(I2CBus),
> > > +    .class_init =3D i2c_bus_class_init,
> > >  };
> >
> >
> >
> > >  static int i2c_bus_pre_save(void *opaque)
> > > diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
> > > index 2a3abacd1b..49580e30e2 100644
> > > --- a/include/hw/i2c/i2c.h
> > > +++ b/include/hw/i2c/i2c.h
> > > @@ -64,7 +64,7 @@ struct I2CSlave {
> > >  };
> > >
> > >  #define TYPE_I2C_BUS "i2c-bus"
> > > -OBJECT_DECLARE_SIMPLE_TYPE(I2CBus, I2C_BUS)
> > > +OBJECT_DECLARE_TYPE(I2CBus, I2CBusClass, I2C_BUS)
> >
> > I don't think you need this change any more ?
> >
> > thanks
> > -- PMM
> >

