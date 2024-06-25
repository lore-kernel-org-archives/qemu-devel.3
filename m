Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33CDC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 23:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMEj7-0006Cw-Qr; Tue, 25 Jun 2024 18:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sMEil-0006Bq-If
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 18:33:05 -0400
Received: from [2a00:1450:4864:20::535] (helo=mail-ed1-x535.google.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sMEhb-0000gV-KB
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 18:32:51 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57cbc2a2496so7115790a12.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 15:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719354602; x=1719959402; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZXIz+d5w40cdWni0TnhrWsiE2g89YSo3ZwK5XpmqL9I=;
 b=zUxh6Oil7y/Z8eFJ6D2ooOnTyUdERx3dSbmIysmEU8nZzxCUfKf1JrajPYKs7C8CjW
 VpeFFwLPnPxVP37fJoXOezxSHo5Aw7uP29pQG0NhI22eAi0GT4AfAe1BPH7ZmpCADiUg
 z6cvvCCLBVg1506mQ9tsUq5pD962IdU3KZaBNY3yH/dLxwDq71VaRDOfBKbdqPsBiC3l
 aSV1TnztsoD+RbxEpPR/Sr9mtDaTSzvhkih2oWQRQyPFQvXjkGekAYnV/+/Mgg8mTYrO
 A9n5Ar+QYZU69G0sRzdFFl6oaXf64o4oA6SZfw6bdYn9NZ5jpgdomfxhB/AjggLQEFOq
 WwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719354602; x=1719959402;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZXIz+d5w40cdWni0TnhrWsiE2g89YSo3ZwK5XpmqL9I=;
 b=UmRthXeviyrqP4aF3ysH9HYO10hL1UaPbDd8ucKRLIyzoqVSTDfhdzQQUeGa8ZFJJb
 FoFb/Jcoa2erbtSTHBm3Qzqmyn6G5QaG0cNIYry8bqPmgkFu2NHUyIzUNlZVg9bnBpZR
 ShX4SCZl5XWc758G0uguMlavfarAwful/F1IxZI59Ics3r9HGaHk2W4Ju7gN3bcbgLb1
 848aIcx4YPOQfP+Q1niJ5+BYOZOgrEW7Andt0aWUvcJRePHf2zQ3sBV2mdPRuILtPgPY
 ro2s4SwyE9EQeoqFaE82Tv+6i2FazRAz0IiiB/3YbxNU6HR6rUNkH3LciFXWfAcToetp
 0iew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfoVUkIHLHI9HAs8AiN95B/LHckUaes8kO7lZ/BNFYZRpj1PxvYDBI+Wcoa0IyYRTuRRBnzt+aUkzrjCjNzBlgI8wCcOI=
X-Gm-Message-State: AOJu0YwPAJUH/dmrLCFnzIfN7oEY2VNPVF1wxjidG2KhR1OFn4lJwpBW
 8wC6rPDGY+lfOvWFBnBzqrR8cw8+0lJ7/4Ytoc0AKk8QCIa1DJmUnq4YRJlVBfAQsX31uhpc+go
 Fd/nrVlkmyDnnGx5D7JTmpIoUhE0E0EVC5UsxijUWngXtYn2Q
X-Google-Smtp-Source: AGHT+IHPx0VNRvcCqOwVRYpAvJUFGUVOwXB8f6kgkCWPn4VtBKZW34UnssULVjXQAoaMWKAbiOakWr5YcFCGdYT0RY0=
X-Received: by 2002:a2e:a788:0:b0:2ec:680d:daeb with SMTP id
 38308e7fff4ca-2ec680ddb46mr37053871fa.30.1719348224549; Tue, 25 Jun 2024
 13:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <229703c7f4394691f254b02c012ee0d7dcf57afb.1718827153.git.manos.pitsidianakis@linaro.org>
 <Znrt77XOc2YBNZyM@intel.com> <ZnsXOyYJAlae1Ito@redhat.com>
In-Reply-To: <ZnsXOyYJAlae1Ito@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jun 2024 21:43:33 +0100
Message-ID: <CAFEAcA-Pr1YT7=prVTukf8iNHjU1fvEvWz5-5_oR7Hgam833gQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 5/5] DO NOT MERGE: replace TYPE_PL011 with
 x-pl011-rust in arm virt machine
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 rowan.hart@intel.com, Richard Henderson <richard.henderson@linaro.org>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2a00:1450:4864:20::535
 (deferred)
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_HP_HELO_NORDNS=0.001, RDNS_NONE=0.793, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Tue, 25 Jun 2024 at 20:15, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Wed, Jun 26, 2024 at 12:18:55AM +0800, Zhao Liu wrote:
> > Hi Manos,
> >
> > On Wed, Jun 19, 2024 at 11:14:02PM +0300, Manos Pitsidianakis wrote:
> > > Date: Wed, 19 Jun 2024 23:14:02 +0300
> > > From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > > Subject: [RFC PATCH v3 5/5] DO NOT MERGE: replace TYPE_PL011 with
> > >  x-pl011-rust in arm virt machine
> > > X-Mailer: git-send-email 2.44.0
> > >
> > > Convenience patch for testing the rust device.
> > >
> > > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > > ---
> > >  hw/arm/virt.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > > index 3c93c0c0a6..f33b58ae0d 100644
> > > --- a/hw/arm/virt.c
> > > +++ b/hw/arm/virt.c
> > > @@ -912,7 +912,11 @@ static void create_uart(const VirtMachineState *=
vms, int uart,
> > >      int irq =3D vms->irqmap[uart];
> > >      const char compat[] =3D "arm,pl011\0arm,primecell";
> > >      const char clocknames[] =3D "uartclk\0apb_pclk";
> > > +#ifdef CONFIG_WITH_RUST
> > > +    DeviceState *dev =3D qdev_new("x-pl011-rust");
> > > +#else
> > >      DeviceState *dev =3D qdev_new(TYPE_PL011);
> > > +#endif
> > >      SysBusDevice *s =3D SYS_BUS_DEVICE(dev);
> > >      MachineState *ms =3D MACHINE(vms);
> > >
> >
> > I realized that if we want to merge the rust pl011 device, then this
> > patch or similar enablement support is necessary, otherwise, the rust
> > code is only used for compilation and cannot actually be run...
> >
> > This is also an open for the devices that are rewrite in Rust.
> >
> > I think there should be an option for the user to choose whether to
> > enable pl011 in C or pl011 in Rust. What do you think?
> >
> > Perhaps the easiest way to enable rust pl011 is to add an option for
> > virt machine... But that's certainly not a long-term approach. I think
> > the ideal way would be to allow rust pl011 to be specified in the
> > command line via -device, but this approach would mean allowing the
> > user to create pl011 and would require changes to the current buildin
> > pl011's creation logic.
>
> While having both impls present is reasonable for the RFC, IMHO, if
> we're to merge this, then the Rust impl of pl011 should fully replace
> the C impl. Maintaining 2 different impls of the same device in
> parallel is highly undesirable. This would of course impl that the
> Rust impls needs to be a feature match for the existing impl. If we
> do a full replacement, then the question of how the user chooses
> between the 2 impls is then entirely avoided.

Yes, I agree this is where we want to go for the long term. For
the short term of reaching consensus on all the earlier parts of
the patch series (build system integration, how to do a rust
device model, etc), I think this patch is fine as a "don't commit this"
way to test the series. In the medium term I guess "feature-parity
both in parallel for a (hopefully) short time and then drop the C
version" ? I definitely feel we don't want a user-facing runtime
option for selecting which one, at any rate.

thanks
-- PMM

