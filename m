Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF9CC52D73
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 23:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scCDk-0000g2-PY; Thu, 08 Aug 2024 19:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1scCDi-0000ex-Pn
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 19:06:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1scCDf-0005M3-Lu
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 19:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723158413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mMaoJ0/hqQoRZjbZVaNAbspGsM2XLsbZr70Iy6OBVzc=;
 b=hncoLIlCNXORFVEgMcJU2UqIF57RwGHbsphjnHUyIP1Pkx4IUvcEveSi5kYERu/MGZnmes
 vUtDSTpH3ktGHkmEd3Qc5QSusAMUKfAmHVacdkv5BmrvmXDAfNuqwyzKuWbh21f+IQJpay
 2/9hUT/Zrm2tNeXLUtPs15XgDUHkXXw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578--7qBUdAqPaGeg5h6K36ffg-1; Thu, 08 Aug 2024 19:06:51 -0400
X-MC-Unique: -7qBUdAqPaGeg5h6K36ffg-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2cb696be198so1778322a91.3
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 16:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723158411; x=1723763211;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mMaoJ0/hqQoRZjbZVaNAbspGsM2XLsbZr70Iy6OBVzc=;
 b=ipLXiDSyXePSEvScOVC81ceyYDzeH9Ui6Bzuh1UfyfNTmvZALHr1BtlHlIBhgY020a
 S7dAPtwBC2rJo8CnNaKZUiFefYMAtxu9mj1YPkVHwhDtZD8UNaqbJnc4GNl5M4/BebF9
 KDILQj7Fdl++xjIK7dqMFyT+1U1fP9gc6ABR9rtAVXSczHPfWKkfL/yELr/yTC1MNdzc
 wdYfWCKNHlVahw01l5AdsN8eaCEQVFHjR4bm/D6Kn40c+h10nQ2JyTscCAMOk/HCxZXB
 r06JRYLBlHMSihEH/0Qxs7Lze4J2clR1ppYYr29dBMCmgaTs3UoinjzIgYMVSqFc2AFA
 //HA==
X-Gm-Message-State: AOJu0Yzw+xfgIG7EgrNz1at1uyqJv5f1xkdwpazFX3N4W+a2HsKZ1v7N
 D8PFt5HKf4DGQJLZPQcfrv5e+xZSqkWlDjFx2qrW2PQNcoqzIXrhbVE0AR8Vs+dPPpHMf7PqpfQ
 GA+OxXKcdiTeXZ5RdExdJMOYW0x6G4w/GgLvrJt/ZrV8aSzdxxpH5o1hGK9YoXVPamwXW/gWGSB
 8hfine5hL442X6E0kZWjoSX1bllmM=
X-Received: by 2002:a17:90a:9e9:b0:2c4:b0f0:8013 with SMTP id
 98e67ed59e1d1-2d1c33a6de1mr3795576a91.11.1723158410607; 
 Thu, 08 Aug 2024 16:06:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmvTtGDsm0lPjqosm1Y38fg4V+syLHS3JFuyVJVEn6Drj0c5bJbPD3HGrzKdfa3QxVZpL5neSLyeySVFRHtZk=
X-Received: by 2002:a17:90a:9e9:b0:2c4:b0f0:8013 with SMTP id
 98e67ed59e1d1-2d1c33a6de1mr3795539a91.11.1723158410202; Thu, 08 Aug 2024
 16:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240805201719.2345596-1-tavip@google.com>
 <20240805201719.2345596-4-tavip@google.com>
 <CAFn=p-abeXP+dUtp_gwH3dcD5DT-sTAFg=udVugrzcU1r8fXpA@mail.gmail.com>
 <CAGWr4cQL_LMWmEUdoPprRSp2k=CkQ0UJp5Q45qbAtUvvE6fDHg@mail.gmail.com>
In-Reply-To: <CAGWr4cQL_LMWmEUdoPprRSp2k=CkQ0UJp5Q45qbAtUvvE6fDHg@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 8 Aug 2024 19:06:38 -0400
Message-ID: <CAFn=p-bdR=_OQRnKwLwY12OO+tNXDycL6A4snaU6ESTW9V2ACQ@mail.gmail.com>
Subject: Re: [RFC PATCH 03/23] scripts: add script to generate C header files
 from SVD XML files
To: Octavian Purdila <tavip@google.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefanst@google.com, 
 pbonzini@redhat.com, alex.bennee@linaro.org, thuth@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, alistair@alistair23.me, 
 berrange@redhat.com, philmd@linaro.org, crosa@redhat.com, bleal@redhat.com
Content-Type: multipart/alternative; boundary="000000000000eeab91061f341454"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--000000000000eeab91061f341454
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 6:30=E2=80=AFPM Octavian Purdila <tavip@google.com> =
wrote:

> On Thu, Aug 8, 2024 at 2:56=E2=80=AFPM John Snow <jsnow@redhat.com> wrote=
:
> >
> >
> >
> > On Mon, Aug 5, 2024 at 4:17=E2=80=AFPM Octavian Purdila <tavip@google.c=
om>
> wrote:
> >>
> >> From: Stefan Stanacar <stefanst@google.com>
> >>
> >> From: Stefan Stanacar <stefanst@google.com>
> >>
> >> The CMSIS System View Description format(CMSIS-SVD) is an XML based
> >> description of Arm Cortex-M microcontrollers provided and maintained
> >> by sillicon vendors. It includes details such as peripherals registers
> >> (down to bitfields), peripheral register block addresses, reset
> >> values, etc.
> >>
> >> This script uses this information to create header files that makes it
> >> easier to emulate peripherals.
> >>
> >> The script can be used to create either peripheral specific headers or
> >> board / system specific information. The script generated headers are
> >> similar to the SVDConv utility.
> >>
> >> Peripheral specific headers contains information such as register
> >> layout, register names and reset values for registers:
> >>
> >>   typedef struct {
> >>     ...
> >>     union {
> >>       uint32_t PSELID;              /* 0x00000FF8 Peripheral Select an=
d
> >>                                      * Flexcomm module ID */
> >>       struct {
> >>         uint32_t PERSEL : 3;        /* [2..0] Peripheral Select */
> >>         uint32_t LOCK : 1;          /* [3..3] Lock the peripheral
> select */
> >>         uint32_t USARTPRESENT : 1;  /* [4..4] USART present indicator =
*/
> >>         uint32_t SPIPRESENT : 1;    /* [5..5] SPI present indicator */
> >>         uint32_t I2CPRESENT : 1;    /* [6..6] I2C present indicator */
> >>         uint32_t I2SPRESENT : 1;    /* [7..7] I2S Present */
> >>         uint32_t : 4;
> >>         uint32_t ID : 20;           /* [31..12] Flexcomm ID */
> >>       } PSELID_b;
> >>     };
> >>     ...
> >>   } FLEXCOMM_Type;                  /* Size =3D 4096 (0x1000) */
> >>
> >>   #define FLEXCOMM_PSELID_PERSEL_Pos (0UL)
> >>   #define FLEXCOMM_PSELID_PERSEL_Msk (0x7UL)
> >>   #define FLEXCOMM_PSELID_LOCK_Pos (3UL)
> >>   #define FLEXCOMM_PSELID_LOCK_Msk (0x8UL)
> >>   ...
> >>
> >>   typedef enum {                /* FLEXCOMM_PSELID_LOCK */
> >>     /* Peripheral select can be changed by software. */
> >>     FLEXCOMM_PSELID_LOCK_UNLOCKED =3D 0,
> >>     /* Peripheral select is locked and cannot be changed until this
> >>      * Flexcomm module or the entire device is reset. */
> >>     FLEXCOMM_PSELID_LOCK_LOCKED =3D 1,
> >>   } FLEXCOMM_PSELID_LOCK_Enum;
> >>   ...
> >>
> >>   #define FLEXCOMM_REGISTER_NAMES_ARRAY(_name) \
> >>     const char *_name[sizeof(FLEXCOMM_Type)] =3D { \
> >>         [4088 ... 4091] =3D "PSELID", \
> >>         [4092 ... 4095] =3D "PID", \
> >>     }
> >>
> >> Board specific headers contains information about peripheral base
> >> register addresses.
> >>
> >> Signed-off-by: Stefan Stanacar <stefanst@google.com>
> >> Signed-off-by: Octavian Purdila <tavip@google.com>
> >> ---
> >>  configure                 |   2 +-
> >>  meson.build               |   4 +
> >>  python/setup.cfg          |   1 +
> >>  python/tests/minreqs.txt  |   3 +
> >>  pythondeps.toml           |   3 +
> >>  scripts/svd-gen-header.py | 342 +++++++++++++++++++++++++++++++++++++=
+
> >>  6 files changed, 354 insertions(+), 1 deletion(-)
> >>  create mode 100755 scripts/svd-gen-header.py
> >>
> >> diff --git a/configure b/configure
> >> index 5ad1674ca5..811bfa5d54 100755
> >> --- a/configure
> >> +++ b/configure
> >> @@ -956,7 +956,7 @@ mkvenv=3D"$python
> ${source_path}/python/scripts/mkvenv.py"
> >>  # Finish preparing the virtual environment using vendored .whl files
> >>
> >>  $mkvenv ensuregroup --dir "${source_path}/python/wheels" \
> >> -     ${source_path}/pythondeps.toml meson || exit 1
> >> +     ${source_path}/pythondeps.toml meson svd-gen-header || exit 1
> >
>
> Hi John,
>
> Thanks for reviewing!
>

:)


>
> >
> > I haven't read the rest of this series; I'm chiming in solely from the
> build/python maintainer angle. Do we *always* need pysvd, no matter how
> QEMU was configured? Adding it to the meson line here is a very big hamme=
r.
> >
>
> I think the minimum we can do is to install it only if CONFIG_ARM is
> enabled. That might change in the future if the models we create with
> pysvd are enabled for other architectures.
>

OK, Understood. I will see if Paolo has any thoughts on this; I am
admittedly a little hesitant to add only our 2nd unconditional python
dependency. For context, meson is our first and only such dependency and
Paolo has been very active in development of that project as well; this
would be the first that none of us have any connection with. If the project
were to ever update in such a way that it became not pure-python or
required additional dependencies, the challenges in vendoring it might
cause unscheduled future headaches.

We can always pin to/vendor versions that suit our needs, but it may be
worth sending the developer an email to ask what his policies on
dependencies are, if only to let him know he might have a user out there
that's hedging on it remaining pure python and dep-free, as a courtesy.

(For my money, personally: it's probably fine; but very possibly any
boards/devices/models you add that require it *might* wind up needing a
configure flag that add this dependency, like --enable-svd-devices or
something of the sort. I'll let Paolo comment on that, don't take my word
as gospel - I handle the Python more than I do the build system; you
managed to find the precise intersection of the two.)


>
> > If not, consider looking at how sphinx (the "docs" group) is only
> conditionally installed into the configure venv and mimic that using the
> appropriate configure flags that necessitate the availability of pyvsd fo=
r
> the QEMU build.
>
> Thanks for the pointer, I'll take a look.
>
> >
> > We also need to provide a way for pysvd to be available offline; some
> packages are available via distro libs and if this package is available f=
or
> every distro we officially support, that's sufficient (but requires updat=
es
> to our various docker and VM test configuration files to add the new
> dependency). Otherwise, like we do for meson, we need to vendor the wheel
> in the tree so offline tarball builds will continue to work.
> >
> > It looks like pysvd is a pure python package with no dependencies, so i=
t
> should be OK to vendor it in qemu.git/python/wheels/ - look at
> qemu.git/python/scripts/vendor.py and consider updating and running this
> script.
>
> Thanks, I'll look at it and add it in v2.
>

Thanks! Sorry this area of the build system is so persnickety. If you run
into troubles please reach out. I've also pinged Paolo to take a look as
the build system "SME" in case there's something I overlooked, too.

Good luck! :)

~js


>
> >
> > (The real blocker here is that RPM builds are performed offline and
> dependencies that cannot be satisfied via rpm can't be added through pip.
> We need any one of these to be true: (A) pyvsd is available (of a
> sufficient version) in all distro repositories we target; (B) This build
> feature is conditional and nobody minds if it never gets enabled for RPM
> builds; (C) The package can be vendored.)
> >
> > ~~js
> >
> > That said, you might be the first person I've seen outside of Paolo and
> I to brave mucking around with the python build venv. You deserve a brave=
ry
> sticker :)
> >
> >>
>

 [...]

--000000000000eeab91061f341454
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 8, 2024 at 6:30=E2=80=AFP=
M Octavian Purdila &lt;<a href=3D"mailto:tavip@google.com">tavip@google.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
On Thu, Aug 8, 2024 at 2:56=E2=80=AFPM John Snow &lt;<a href=3D"mailto:jsno=
w@redhat.com" target=3D"_blank">jsnow@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Mon, Aug 5, 2024 at 4:17=E2=80=AFPM Octavian Purdila &lt;<a href=3D=
"mailto:tavip@google.com" target=3D"_blank">tavip@google.com</a>&gt; wrote:=
<br>
&gt;&gt;<br>
&gt;&gt; From: Stefan Stanacar &lt;<a href=3D"mailto:stefanst@google.com" t=
arget=3D"_blank">stefanst@google.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; From: Stefan Stanacar &lt;<a href=3D"mailto:stefanst@google.com" t=
arget=3D"_blank">stefanst@google.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; The CMSIS System View Description format(CMSIS-SVD) is an XML base=
d<br>
&gt;&gt; description of Arm Cortex-M microcontrollers provided and maintain=
ed<br>
&gt;&gt; by sillicon vendors. It includes details such as peripherals regis=
ters<br>
&gt;&gt; (down to bitfields), peripheral register block addresses, reset<br=
>
&gt;&gt; values, etc.<br>
&gt;&gt;<br>
&gt;&gt; This script uses this information to create header files that make=
s it<br>
&gt;&gt; easier to emulate peripherals.<br>
&gt;&gt;<br>
&gt;&gt; The script can be used to create either peripheral specific header=
s or<br>
&gt;&gt; board / system specific information. The script generated headers =
are<br>
&gt;&gt; similar to the SVDConv utility.<br>
&gt;&gt;<br>
&gt;&gt; Peripheral specific headers contains information such as register<=
br>
&gt;&gt; layout, register names and reset values for registers:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0typedef struct {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0...<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0union {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t PSELID;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 /* 0x00000FF8 Peripheral Select and<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Flexco=
mm module ID */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t PERSEL : 3;=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 /* [2..0] Peripheral Select */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t LOCK : 1;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 /* [3..3] Lock the peripheral select */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t USARTPRESENT : 1;=C2=A0 =
/* [4..4] USART present indicator */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t SPIPRESENT : 1;=C2=A0 =
=C2=A0 /* [5..5] SPI present indicator */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t I2CPRESENT : 1;=C2=A0 =
=C2=A0 /* [6..6] I2C present indicator */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t I2SPRESENT : 1;=C2=A0 =
=C2=A0 /* [7..7] I2S Present */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t : 4;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t ID : 20;=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0/* [31..12] Flexcomm ID */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0} PSELID_b;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0};<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0...<br>
&gt;&gt;=C2=A0 =C2=A0} FLEXCOMM_Type;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 /* Size =3D 4096 (0x1000) */<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0#define FLEXCOMM_PSELID_PERSEL_Pos (0UL)<br>
&gt;&gt;=C2=A0 =C2=A0#define FLEXCOMM_PSELID_PERSEL_Msk (0x7UL)<br>
&gt;&gt;=C2=A0 =C2=A0#define FLEXCOMM_PSELID_LOCK_Pos (3UL)<br>
&gt;&gt;=C2=A0 =C2=A0#define FLEXCOMM_PSELID_LOCK_Msk (0x8UL)<br>
&gt;&gt;=C2=A0 =C2=A0...<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0typedef enum {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 /* FLEXCOMM_PSELID_LOCK */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0/* Peripheral select can be changed by software=
. */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0FLEXCOMM_PSELID_LOCK_UNLOCKED =3D 0,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0/* Peripheral select is locked and cannot be ch=
anged until this<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 * Flexcomm module or the entire device is rese=
t. */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0FLEXCOMM_PSELID_LOCK_LOCKED =3D 1,<br>
&gt;&gt;=C2=A0 =C2=A0} FLEXCOMM_PSELID_LOCK_Enum;<br>
&gt;&gt;=C2=A0 =C2=A0...<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0#define FLEXCOMM_REGISTER_NAMES_ARRAY(_name) \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0const char *_name[sizeof(FLEXCOMM_Type)] =3D { =
\<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[4088 ... 4091] =3D &quot;PSELID&=
quot;, \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[4092 ... 4095] =3D &quot;PID&quo=
t;, \<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;<br>
&gt;&gt; Board specific headers contains information about peripheral base<=
br>
&gt;&gt; register addresses.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Stefan Stanacar &lt;<a href=3D"mailto:stefanst@goog=
le.com" target=3D"_blank">stefanst@google.com</a>&gt;<br>
&gt;&gt; Signed-off-by: Octavian Purdila &lt;<a href=3D"mailto:tavip@google=
.com" target=3D"_blank">tavip@google.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;&gt;=C2=A0 meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A04 +<br>
&gt;&gt;=C2=A0 python/setup.cfg=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A01 +<br>
&gt;&gt;=C2=A0 python/tests/minreqs.txt=C2=A0 |=C2=A0 =C2=A03 +<br>
&gt;&gt;=C2=A0 pythondeps.toml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A03 +<br>
&gt;&gt;=C2=A0 scripts/svd-gen-header.py | 342 ++++++++++++++++++++++++++++=
++++++++++<br>
&gt;&gt;=C2=A0 6 files changed, 354 insertions(+), 1 deletion(-)<br>
&gt;&gt;=C2=A0 create mode 100755 scripts/svd-gen-header.py<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/configure b/configure<br>
&gt;&gt; index 5ad1674ca5..811bfa5d54 100755<br>
&gt;&gt; --- a/configure<br>
&gt;&gt; +++ b/configure<br>
&gt;&gt; @@ -956,7 +956,7 @@ mkvenv=3D&quot;$python ${source_path}/python/s=
cripts/mkvenv.py&quot;<br>
&gt;&gt;=C2=A0 # Finish preparing the virtual environment using vendored .w=
hl files<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 $mkvenv ensuregroup --dir &quot;${source_path}/python/wheels=
&quot; \<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0${source_path}/pythondeps.toml meson || exit =
1<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0${source_path}/pythondeps.toml meson svd-gen-=
header || exit 1<br>
&gt;<br>
<br>
Hi John,<br>
<br>
Thanks for reviewing!<br></blockquote><div><br></div><div>:)</div><div>=C2=
=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;<br>
&gt; I haven&#39;t read the rest of this series; I&#39;m chiming in solely =
from the build/python maintainer angle. Do we *always* need pysvd, no matte=
r how QEMU was configured? Adding it to the meson line here is a very big h=
ammer.<br>
&gt;<br>
<br>
I think the minimum we can do is to install it only if CONFIG_ARM is<br>
enabled. That might change in the future if the models we create with<br>
pysvd are enabled for other architectures.<br></blockquote><div><br></div><=
div>OK, Understood. I will see if Paolo has any thoughts on this; I am admi=
ttedly a little hesitant to add only our 2nd unconditional python dependenc=
y. For context, meson is our first and only such dependency and Paolo has b=
een very active in development of that project as well; this would be the f=
irst that none of us have any connection with. If the project were to ever =
update in such a way that it became not pure-python or required additional =
dependencies, the challenges in vendoring it might cause unscheduled future=
 headaches.</div><div><br></div><div>We can always pin to/vendor versions t=
hat suit our needs, but it may be worth sending the developer an email to a=
sk what his policies on dependencies are, if only to let him know he might =
have a user out there that&#39;s hedging on it remaining pure python and de=
p-free, as a courtesy.<br></div></div><div class=3D"gmail_quote"><br></div>=
<div class=3D"gmail_quote">(For my money, personally: it&#39;s probably fin=
e; but very possibly any boards/devices/models you add that require it *mig=
ht* wind up needing a configure flag that add this dependency, like --enabl=
e-svd-devices or something of the sort. I&#39;ll let Paolo comment on that,=
 don&#39;t take my word as gospel - I handle the Python more than I do the =
build system; you managed to find the precise intersection of the two.)<br>=
</div><div class=3D"gmail_quote"><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
<br>
&gt; If not, consider looking at how sphinx (the &quot;docs&quot; group) is=
 only conditionally installed into the configure venv and mimic that using =
the appropriate configure flags that necessitate the availability of pyvsd =
for the QEMU build.<br>
<br>
Thanks for the pointer, I&#39;ll take a look.<br>
<br>
&gt;<br>
&gt; We also need to provide a way for pysvd to be available offline; some =
packages are available via distro libs and if this package is available for=
 every distro we officially support, that&#39;s sufficient (but requires up=
dates to our various docker and VM test configuration files to add the new =
dependency). Otherwise, like we do for meson, we need to vendor the wheel i=
n the tree so offline tarball builds will continue to work.<br>
&gt;<br>
&gt; It looks like pysvd is a pure python package with no dependencies, so =
it should be OK to vendor it in qemu.git/python/wheels/ - look at qemu.git/=
python/scripts/vendor.py and consider updating and running this script.<br>
<br>
Thanks, I&#39;ll look at it and add it in v2.<br></blockquote><div><br></di=
v><div>Thanks! Sorry this area of the build system is so persnickety. If yo=
u run into troubles please reach out. I&#39;ve also pinged Paolo to take a =
look as the build system &quot;SME&quot; in case there&#39;s something I ov=
erlooked, too.</div><div><br></div><div>Good luck! :)</div><div><br></div><=
div>~js<br></div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
<br>
&gt;<br>
&gt; (The real blocker here is that RPM builds are performed offline and de=
pendencies that cannot be satisfied via rpm can&#39;t be added through pip.=
 We need any one of these to be true: (A) pyvsd is available (of a sufficie=
nt version) in all distro repositories we target; (B) This build feature is=
 conditional and nobody minds if it never gets enabled for RPM builds; (C) =
The package can be vendored.)<br>
&gt;<br>
&gt; ~~js<br>
&gt;<br>
&gt; That said, you might be the first person I&#39;ve seen outside of Paol=
o and I to brave mucking around with the python build venv. You deserve a b=
ravery sticker :)<br>
&gt;<br>
&gt;&gt;<br></blockquote><div><br></div><div>=C2=A0[...]</div></div></div>

--000000000000eeab91061f341454--


