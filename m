Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DA0606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZrXkucmp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM6Oa-0004Pk-6y; Wed, 28 Oct 2026 12:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gessingate@gmail.com>)
 id 1xM6OY-0004PH-0q
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:20:58 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gessingate@gmail.com>)
 id 1xM6OV-0006P6-3m
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:20:57 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso896905f8f.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 09:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793204453; x=1793809253; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fgksD8YpRJ0dS5SAgOgXARJt//ksQAV43218ic9vy40=;
 b=ZrXkucmpSRN+92t/6bQrctK23Txr7oJZ5rQD2E4NbQqmdjUkC61YKVT219IG+6LTZM
 OTiCNkrbv1dsUBKAliE1BJknfzOUE/c/m7oJmfE+nIlsoBqlrd1phv40CdclkvKafEvs
 xfxs4d/DBj9JdM1gGNVjQ8A6PAvjRzwIYUBLHNchVP6+vQvZEFDqgOQodJN55bHGpdTK
 oUEDCNNP4rAo1AntnCiT+6vujZ3XeHu5NX1AcCYT2K71z+bRJNOxlWG9fYEk6xsp88OV
 BS8HEROvDlWdAW2NMvIWewULH3abQbScNTwPN5aK7lPcjD+D5lfxP/SBSBPDZSqFbpnO
 jsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793204453; x=1793809253;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fgksD8YpRJ0dS5SAgOgXARJt//ksQAV43218ic9vy40=;
 b=pGH7MpM/TKiCrg4N2CnNCqziNBmjE/LKe8/5XbIc5iEqr7brhDbuaM6UsXG+C6Xepo
 nGmnJFAkZpdlgXiKNejTWZ3B7QyyhwuZL6cio/nLW67vUHBqXs2ZpewmWdlRbP9XFAiv
 OWRBJMkNgUEVpBhbR1lnQt4YZtXP6TM8Ytk6P/2KMZTSIMdxU5kq19v5POait7tV0/JU
 1vAlHv7zBdbmCFCUB/kNiN1eEv/N+FJXt5L9aumGVFvZjKOT0nZX4COZt18towcWujoc
 AeqfzwP3p7aRsusoyGAcdGR0kjzBCMj9EpUnBg2h3cWGkKVUOJLhxu+DoTFCrtN62cvz
 Gjfg==
X-Gm-Message-State: AFq9FYKhPj+z3z9pVgu1FGaUe+1TBWb5ozjT+W2HHp1hS7lH/sqEdg/W
 9spFTLSNeTb5F2MXFjZH48OW3g/+r7CSxUeOoirRlEFb/GR26C4eWDWB
X-Gm-Gg: AYBFou0Iyk3eDrRuN8u3Ho7HgMzbskTJ/CmzZ3QoHM7YDyvLdY1gS1FpaN6mSh4W2IV
 hgafmgsCeQiR3xaPe0S4fyQ7RTa2RYjsb7/IyLpKKnE3zU7EXnzWd//gNxtbL+J2JJ9vBBpGill
 qDDC2m7LJvOwfwnW4zkutIVQwE8K2UbfysE1GkGyhh/JG2zGRDokbtUls8HFDyrceCaMkCgUbcE
 hq6shxF5DNialy+eEoGFMwvin0yR36bol1iG1H+oiJF9eW7gaO3OT7bsfwTsSDQ8Bhb9g9zYDNr
 bnNFGA0AB7Icq8zlH3TMVkrjpeay6u/EfnwMTM6b9u/MXV+035ySkOrCLL4YV3/ayJiHcfMArCc
 HdAT6zDyQVXcj1O4VqGkF/aqY8lNrYI/qQQ+b8AfLBugKTIYiRFk9LCOEoOeF8R93kWFk3bryYu
 ZBi/aEIBflVoN0jXALxonaXQy4cQDl8TUjJaBIV6SgT6uu3aDT3E7h2J+FfpLtF0Go/V6eUKkWW
 FQyCHF8uIWtL1BdouO7mdn+t4KHugHWQJXvE8DdRm4aGazCleCF2rONDqK/3dLzHhgfxfHfiKQc
 nh2LVH3U93MnPmkAgcll+xczsM9RRg1BdgDyAvLJKDddYRHjzAazW3L7YI5/G7v57+jA1u3ETeJ
 93MKJXwogEW+K
X-Received: by 2002:a05:6000:4026:b0:487:106f:ee31 with SMTP id
 ffacd0b85a97d-48e5d5c70b7mr6467891f8f.27.1793204453021; 
 Wed, 28 Oct 2026 09:20:53 -0700 (PDT)
Received: from [192.168.1.89] (95-24-99-141.broadband.corbina.ru.
 [95.24.99.141]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc39b3sm30269023f8f.10.2026.10.28.09.20.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:20:51 -0700 (PDT)
Message-ID: <5d219f231fb1f97c6d90cbef4068e82dff803a18.camel@gmail.com>
Subject: Re: [PATCH v2 1/6] hw/i2c: add dummy device
From: Timur Maksimov <gessingate@gmail.com>
To: Markus Armbruster <armbru@redhat.com>, =?ISO-8859-1?Q?C=E9dric?= Le
 Goater <clg@kaod.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter
 Maydell	 <peter.maydell@linaro.org>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Kane Chen	 <kane_chen@aspeedtech.com>, qemu-arm@nongnu.org, Fabiano Rosas
 <farosas@suse.de>,  Laurent Vivier <lvivier@redhat.com>, Corey Minyard
 <cminyard@mvista.com>
Date: Wed, 28 Oct 2026 19:20:48 +0300
In-Reply-To: <874ie6ku2u.fsf@pond.sub.org>
References: <20261027-aspeed-i2c-nonpkt-fix-v2-0-07deed1dff60@gmail.com>
 <20261027-aspeed-i2c-nonpkt-fix-v2-1-07deed1dff60@gmail.com>
 <2629ee8a-e817-4764-a1e3-72e0ccbb978b@kaod.org>
 <874ie6ku2u.fsf@pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=gessingate@gmail.com; helo=mail-wr1-x429.google.com
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi, thanks for the review.=C2=A0

It was my decision to use such API, I thought it would be okay for a
test device. I don't think there is a way to expose integer array as a
single QOM property.

Actually, we can go without this model. I suppose I will rewrite tests
so they don't use it.

On Wed, 2026-10-28 at 11:17 +0100, Markus Armbruster wrote:
> C=C3=A9dric Le Goater <clg@kaod.org> writes:
>=20
> > + Corey for I2C feed back.
> >=20
> > + Markus for QOM
> >=20
> > The brute-force solution to expose the contents of the device array
> > with 128 properties has a slight AI smell. I find it ugly but I am
> > human :)
>=20
> Timur, have you read docs/devel/code-provenance.rst section "Use of
> AI-generated content"?
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 That said I don't know=
 if there are better alternatives.
> > My approach would have been to use a string property :
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_property_add_str(obj, "tx",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i2c_dummy_device_get_tx, NULL);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_property_add_str(obj, "rx",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i2c_dummy_device_get_rx,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i2c_dummy_device_set_rx);
> > =C2=A0Any better ideas ?
>=20
> I believe you're talking about this function:
>=20
> [...]
>=20
> > > +static void i2c_dummy_device_init(Object *obj)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0 I2CDummyDeviceState *s =3D I2C_DUMMY_DEVICE(obj);
> > >=20
> > > +=C2=A0=C2=A0=C2=A0 for (int i =3D 0; i < I2C_DUMMY_ARRAY_SIZE; i++) =
{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_autofree char *name =3D=
 g_strdup_printf("tx[%d]", i);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_property_add_uint8=
_ptr(
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o=
bj, name, &s->tx[i],
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 O=
BJ_PROP_FLAG_READWRITE);
> > > +=C2=A0=C2=A0=C2=A0 }
> > > +
> > > +=C2=A0=C2=A0=C2=A0 for (int i =3D 0; i < I2C_DUMMY_ARRAY_SIZE; i++) =
{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_autofree char *name =3D=
 g_strdup_printf("rx[%d]", i);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_property_add_uint8=
_ptr(
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o=
bj, name, &s->rx[i],
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 O=
BJ_PROP_FLAG_READWRITE);
> > > +=C2=A0=C2=A0=C2=A0 }
> > > +
> > > +=C2=A0=C2=A0=C2=A0 object_property_add_uint8_ptr(
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o=
bj, "tx-pos", &s->tx_pos,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 O=
BJ_PROP_FLAG_READWRITE);
> > > +=C2=A0=C2=A0=C2=A0 object_property_add_uint8_ptr(
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o=
bj, "rx-pos", &s->rx_pos,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 O=
BJ_PROP_FLAG_READWRITE);
> >=20
> > alignment could be improved.
>=20
> Yes, this style is unusual in QEMU, and should therefore be avoided.
>=20
> > > +}
>=20
> The function adds properties "tx-pos", "tx[0]", ... "tx[63]", and
> same
> for rx.
>=20
> The commit message tells us this is a "Simple I2C device with QOM
> properties to access transmit and receive buffers [...] for testing
> or
> prototyping."=C2=A0 It doesn't tell us how it could be used, and I can't
> see
> any documentation, either.=C2=A0 So let's start right there: please show
> us
> how this device could be used.=C2=A0 This should help me understand what
> the
> properties are for.=C2=A0 Only then can I advise on proper QOM usage.
>=20
> [...]

