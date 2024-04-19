Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7D1C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 16:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxqnc-0003EX-Co; Fri, 19 Apr 2024 12:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.poggi@lynxleap.co.uk>)
 id 1rxqnZ-00030l-IO
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:09:13 -0400
Received: from 17.mo583.mail-out.ovh.net ([46.105.56.132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.poggi@lynxleap.co.uk>)
 id 1rxqnX-0002fC-1f
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:09:13 -0400
Received: from director1.ghost.mail-out.ovh.net (unknown [10.109.139.129])
 by mo583.mail-out.ovh.net (Postfix) with ESMTP id 4VLfhz3gldz1RyX
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 16:09:07 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-npzmc (unknown [10.110.113.115])
 by director1.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 176BC1FD4F
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 16:09:07 +0000 (UTC)
Received: from lynxleap.co.uk ([37.59.142.97])
 by ghost-submission-6684bf9d7b-npzmc with ESMTPSA
 id u5MnASOXImZjyhwA1Q5sOg
 (envelope-from <raphael.poggi@lynxleap.co.uk>)
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 16:09:07 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G0027b9ce061-cc7d-41be-92c0-9440cbb3cda3,
 F65BB45773F307CC52C61DE7E0999B19AE952020)
 smtp.auth=raphael.poggi@lynxleap.co.uk
X-OVh-ClientIp: 209.85.218.49
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-a4702457ccbso247906366b.3
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 09:09:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWSTDWpGMvAdi5d1yv1ePCtKZmQTG1wC+eacUWMuEb5Gs6Txa85sGC1EqRVM3XCATt1LgyMNFIq8z883sv2+e2Vng9SQqU=
X-Gm-Message-State: AOJu0YwEYjb3AJK3OHXI32QAH7kpoPsrJYuUNXwLmMmSQh/WN5zMcFpW
 F1p1euj4UD5TCQu+vNCWqtgOZdEEVNSK3Qe/H6GsYGWAvbs0udvTNKW658koyfMEjDUd0SjMhM7
 2hGbmZiSNWKQlP2UBx1o9DbodElc=
X-Google-Smtp-Source: AGHT+IEjLk8uJCnZMUkp56b4bRqHfQkioa045ntneEf5fVbhmBQGsAODH29ar9iNnFrwKJooKwvpfnQH9BiVTc4/ISk=
X-Received: by 2002:a17:906:7056:b0:a52:46ea:8b61 with SMTP id
 r22-20020a170906705600b00a5246ea8b61mr1563453ejj.53.1713542946184; Fri, 19
 Apr 2024 09:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240418191602.2017-1-raphael.poggi@lynxleap.co.uk>
 <5b8ce05b-62c6-4362-aa16-a9e845eb4df7@linaro.org>
 <CACqcpZCubN0Bnmht03TRCWdtYUd4aOpitcx31J+NiMEe2vWhSA@mail.gmail.com>
 <CAFEAcA9wcaptrL5LHWah0MeKP1CV-WbfwsS65kibLwJ4TpvjTg@mail.gmail.com>
In-Reply-To: <CAFEAcA9wcaptrL5LHWah0MeKP1CV-WbfwsS65kibLwJ4TpvjTg@mail.gmail.com>
From: Raphael Poggi <raphael.poggi@lynxleap.co.uk>
Date: Fri, 19 Apr 2024 17:08:33 +0100
X-Gmail-Original-Message-ID: <CACqcpZDv8gjKhMygmAWkyfYqPH-NVz4RpPb8Q0tBTege_Gro4Q@mail.gmail.com>
Message-ID: <CACqcpZDv8gjKhMygmAWkyfYqPH-NVz4RpPb8Q0tBTege_Gro4Q@mail.gmail.com>
Subject: Re: [PATCH] hw/core/clock: always iterate through childs in
 clock_propagate_period
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Raphael Poggi <raphael.poggi@lynxleap.co.uk>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, luc@lmichel.fr, damien.hedde@dahe.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 10890548327346806399
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudekvddguddttdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfhgjhfffkffuvfevtgfgsehtqhertddttdejnecuhfhrohhmpeftrghphhgrvghlucfrohhgghhiuceorhgrphhhrggvlhdrphhoghhgiheslhihnhiglhgvrghprdgtohdruhhkqeenucggtffrrghtthgvrhhnpedtheeivdehvddugfejueffhfegkedthfekieetvefhgeefleejvefggeefvdevffenucfkphepuddvjedrtddrtddruddpvddtledrkeehrddvudekrdegledpfeejrdehledrudegvddrleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehrrghphhgrvghlrdhpohhgghhisehlhihngihlvggrphdrtghordhukhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdfovfetjfhoshhtpehmohehkeefpdhmohguvgepshhmthhpohhuth
Received-SPF: pass client-ip=46.105.56.132;
 envelope-from=raphael.poggi@lynxleap.co.uk; helo=17.mo583.mail-out.ovh.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi Peter,

Le ven. 19 avr. 2024 =C3=A0 16:08, Peter Maydell <peter.maydell@linaro.org>=
 a =C3=A9crit :
>
> On Thu, 18 Apr 2024 at 21:39, Raphael Poggi
> <raphael.poggi@lynxleap.co.uk> wrote:
> >
> > Hi Philippe,
> >
> > Le jeu. 18 avr. 2024 =C3=A0 20:43, Philippe Mathieu-Daud=C3=A9
> > <philmd@linaro.org> a =C3=A9crit :
> > >
> > > Hi Raphael,
> > >
> > > On 18/4/24 21:16, Raphael Poggi wrote:
> > > > When dealing with few clocks depending with each others, sometimes
> > > > we might only want to update the multiplier/diviser on a specific c=
lock
> > > > (cf clockB in drawing below) and call "clock_propagate(clockA)" to
> > > > update the childs period according to the potential new multiplier/=
diviser values.
> > > >
> > > > +--------+     +--------+      +--------+
> > > > | clockA | --> | clockB |  --> | clockC |
> > > > +--------+     +--------+      +--------+
> > > >
> > > > The actual code would not allow that because, since we cannot call
> > > > "clock_propagate" directly on a child, it would exit on the
> > > > first child has the period has not changed for clockB, only clockC =
is
> > >
> > > Typo "as the period has not changed"?
> >
> > That's a typo indeed, thanks!
> >
> > >
> > > Why can't you call clock_propagate() on a child?
> >
> > There is an assert "assert(clk->source =3D=3D NULL);" in clock_propagat=
e().
> > If I am not wrong, clk->source is set when the clock has a parent.
>
> I think that assertion is probably there because we didn't
> originally have the idea of a clock having a multiplier/divider
> setting. So the idea was that calling clock_propagate() on a
> clock with a parent would always be wrong, because the only
> reason for its period to change would be if the parent had
> changed, and if the parent changes then clock_propagate()
> should be called on the parent.
>
> We added mul/div later, and we (I) didn't think through all
> the consequences. If you change the mul/div settings on
> clockB in this example then you need to call clock_propagate()
> on it, so we should remove that assert(). Then when you change
> the mul/div on clockB you can directly clock_propagate(clockB),
> and I don't think you need this patch at that point.

Alright, that makes sense, is that OK if I send a patch removing the assert=
 ?

Thanks,
>
> thanks
> -- PMM

