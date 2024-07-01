Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76260C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 13:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOH3Q-00053G-Nn; Mon, 01 Jul 2024 09:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOH3I-000515-10
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 09:26:41 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOH3F-0002eh-LF
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 09:26:39 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a6cb130027aso161364266b.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 06:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719840396; x=1720445196; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tABNxuZXrui19QDSvmAkfBzAC/CeGqFGvgJCxckChSE=;
 b=uxgqLl/y9wliKrHX2/x427BGtLnbt3aUBCNp/W2CvlHCkMGqdDk3W5z6TWuQvHNena
 YCbcftV0Z2nRhytoF9VTMBlQWYp44F5U6c1Rdwzklit7w3uZsaC2pdluArS33S+Berup
 CdIAqhV5JYJZiqKDpkeYicnANbwVx5eVkxjSYDhRY8D7+hcjfvzeBHJf3Q4awINnD8SY
 EYvc/LtualV/ENy7aVaVXiGp4QvjEvC4Wn5Jttmcit6KpD+PNqbCohxmc9XFfS61rama
 uNhDSosE0n8nERGzgdufTmy6nUjsO6T4zv677eJNch7pE+Hnk5x5Zr5q56nVvjLXsl9u
 mDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719840396; x=1720445196;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tABNxuZXrui19QDSvmAkfBzAC/CeGqFGvgJCxckChSE=;
 b=cZHHNDTqUfdCAD9ApxLKLT9HF08yA789lVWEj7wos0vbvL9UKsScr9J48YZInec20D
 af4B3Byx/mXGDjMUPIjnxsZ+vC15e3/1U51OX0g/DvaeNI7G7xQz9P5WzSR8mOia9Qb+
 2F4qfa8vwhTfvIjeWMm/xdfCQuN2twQH3HY7Pzfp8lVnvnwc1zCRBmjlbsNF0HsvP5h0
 BXpM72Gs/imKAKkM9iZCvPIxOLXoyHcJVNT61hgL0xcWlXxHiAYdbubQRT27aWiyOxNN
 SF0w+nKMegyjfzVgDoRlaQRYIrdCDzGU7jW8O49N2V9tD4W3RuGCy7gdpXuuY3oBpSVx
 7aww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKGkLgU1n9x7G4J0nIPnFakqmrvI8ULWyJ+CmUEyVrYxEfBMOxm5MI3MEKV5ntcin+8GRnrMjrL81cDS7Q+u2RwJTPsUk=
X-Gm-Message-State: AOJu0YwC+KF0USVH3qjJF2i3JrECm4iddVnrsYJdvuKtnDfW2XkgCfiM
 tXgKuNKRzqg/mB1e5Okr6gVhx939+MpL67prvjDZIpnbNXxcLCL2TSc93ZZCWnn7vwABStNI/Q0
 LG3oBJOF3OKuzlY1m0BneVvAf/YoBTEvIM9mJeA==
X-Google-Smtp-Source: AGHT+IEMf2+NK2XkvuDPgH3iOn+sF5pse9FlZDdvA4Ib/RomQzygbjufq6kaJI8SIY1Z5OCnyxrksNS0eLXzmGHJcko=
X-Received: by 2002:a05:6402:1e88:b0:57c:6d89:eaef with SMTP id
 4fb4d7f45d1cf-5879f3ac701mr5382864a12.18.1719840395651; Mon, 01 Jul 2024
 06:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240630151414.2969772-1-zheyuma97@gmail.com>
 <edf25494-1fd0-4a8c-959b-c4547da0ab23@linaro.org>
In-Reply-To: <edf25494-1fd0-4a8c-959b-c4547da0ab23@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2024 14:26:24 +0100
Message-ID: <CAFEAcA8Vgs=OqffFARSUEYarL+5K1vV2WmQ9nj5XfyjqOWXkuw@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/bcm2835_thermal: Handle invalid address accesses
 gracefully
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Zheyu Ma <zheyuma97@gmail.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 1 Jul 2024 at 12:18, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Hi Zheyu,
>
> On 30/6/24 17:14, Zheyu Ma wrote:
> > This commit handles invalid address accesses gracefully in both read an=
d write
> > functions. Instead of asserting and aborting, it logs an error message =
and returns
> > a neutral value for read operations and does nothing for write operatio=
ns.
> >
> > Error log:
> > ERROR:hw/misc/bcm2835_thermal.c:55:bcm2835_thermal_read: code should no=
t be reached
> > Bail out! ERROR:hw/misc/bcm2835_thermal.c:55:bcm2835_thermal_read: code=
 should not be reached
> > Aborted
> >
> > Reproducer:
> > cat << EOF | qemu-system-aarch64 -display \
> > none -machine accel=3Dqtest, -m 512M -machine raspi3b -m 1G -qtest stdi=
o
> > readw 0x3f212003
>
> Thanks for this very interesting bug report (and reproducer).
>
> > EOF
> >
> > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> > ---
> >   hw/misc/bcm2835_thermal.c | 12 ++++++++----
> >   1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/misc/bcm2835_thermal.c b/hw/misc/bcm2835_thermal.c
> > index ee7816b8a5..5c2a429d58 100644
> > --- a/hw/misc/bcm2835_thermal.c
> > +++ b/hw/misc/bcm2835_thermal.c
> > @@ -51,8 +51,10 @@ static uint64_t bcm2835_thermal_read(void *opaque, h=
waddr addr, unsigned size)
> >           val =3D FIELD_DP32(bcm2835_thermal_temp2adc(25), STAT, VALID,=
 true);
> >           break;
> >       default:
> > -        /* MemoryRegionOps are aligned, so this can not happen. */
> > -        g_assert_not_reached();
>
> Like Xingtao Yao mentioned, I believe the current code is correct
> and shouldn't be reached.
>
> Why is it reached? You might have uncovered a core memory bug.

I think we get here because the bcm2835_thermal_ops MemoryRegionOps
sets impl.max_access_size and valid.max_access_size to 4, but it leaves
impl.min_access_size and valid.min_access_size unset, which means
"default to 1". So the memory system is presented with an access
of size 2 at offset 3, and it tries to synthesize it as a pair
of byte accesses at offsets 3 and 4; but the offset 3 trips
our assert above. So I think the fix is:

@@ -80,8 +80,10 @@ static void bcm2835_thermal_write(void *opaque, hwaddr a=
ddr,
 static const MemoryRegionOps bcm2835_thermal_ops =3D {
     .read =3D bcm2835_thermal_read,
     .write =3D bcm2835_thermal_write,
+    .impl.min_access_size =3D 4,
     .impl.max_access_size =3D 4,
     .valid.min_access_size =3D 4,
+    .valid.max_access_size =3D 4,
     .endianness =3D DEVICE_NATIVE_ENDIAN,
 };

The .valid.max_access_size change is because otherwise we
fall over in a different way: the memory system tries to
synthesize a read using a 4-byte access at offset 3 even
though the device doesn't say it permits unaligned accesses.
This part does seem like a bug in the access_with_adjusted_size
code. If we want to look at that we should probably start with
this patch series from Tomoyuki Hirose from earlier this year:
https://lore.kernel.org/qemu-devel/20240201081313.1339788-1-tomoyuki.hirose=
@igel.co.jp/
which attempted to improve that code.

thanks
-- PMM

