Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F23B606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 22:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QAlhEynG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO0l6-00011b-RO; Mon, 02 Nov 2026 17:44:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1xO0l0-00010x-4Q
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 17:44:03 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1xO0ky-0004Tv-47
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 17:44:01 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 26EA841155;
 Mon,  2 Nov 2026 22:43:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8231F00A18;
 Mon,  2 Nov 2026 22:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793659429;
 bh=3FrCYyc5CI/MkZjBazcvWXfame1iKH+cknpE6tAJ1h4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=QAlhEynGOBbcrVcJzaLSXv1U0Avt5MPt2STyqtTwHWaRljxqqN/uD05w9ECL/AHu5
 HS3GCGi81Dwj2IQ0BO/sey8Ff7qDW7RQTwJdxVlUTONOHHWkORPLbYSWzceyLkvjfJ
 cyOgGxvaRYCjdtbhkHAt/XaNl0ByFvC4nSikiT10G0NUFBlurcMkpoRcSSXbTy63bl
 SIpUZqpjSgIWxcrgmbmDZV34uZImSPppl93Ti3zWdXc0kz4PEc5MY2fhggygawEg4l
 +QIiDrp/XLKWjmXYqePCjwi6aKcB2JpgvVz4Y5qsNLpGnMqHrnV27T6M4oH0S1zs7K
 Lnqhjsmrwua4w==
Date: Mon, 2 Nov 2026 22:43:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?VGFtw6FzIEtpcsOhbHk=?= <kiraly.tamas@outlook.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "philmd@mailo.com"
 <philmd@mailo.com>
Subject: Re: RFC sensor simulation in QEMU
Message-ID: <20261102224344.2a48fa3c@jic23-hlaptop>
In-Reply-To: <BESP192MB29196ED401270A194315234F9C1D2@BESP192MB2919.EURP192.PROD.OUTLOOK.COM>
References: <BESP192MB2919F3C79FA633DBB40571C89C122@BESP192MB2919.EURP192.PROD.OUTLOOK.COM>
 <20260609154258.7fae97b3@jic23-huawei>
 <BESP192MB29196ED401270A194315234F9C1D2@BESP192MB2919.EURP192.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=172.234.252.31; envelope-from=jic23@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 9 Jun 2026 16:38:54 +0000
Tam=C3=A1s Kir=C3=A1ly <kiraly.tamas@outlook.com> wrote:

> Hi Jonathan,
>=20
> Thank you for responding to my email. You are right I was a little bit va=
gue with the topic, allow me to elaborate:
>=20
> My starting point for sensors is the sensor hat<https://www.raspberrypi.c=
om/products/sense-hat/> for Raspberry Pi. It contains humidity, temperature=
, pressure, IMU, etc. so I am mainly talking about embedded sensors which p=
rovide their stuff via I2C, SPI or similar protocol. A lot of these sensors=
 have kernel drivers thanks to the IIO subsystem so the user side is pretty=
 much done.
> I think there is room for development on the sensor side, like replacing =
the hardware with software temporarily for testing or other purposes. I can=
 think of a simulation which generates for example temperature measurements=
 and those are provided to the user (e.g. kernel driver) according to the B=
ME280 sensor's register mapping and datasheet. The goal here is that the ke=
rnel driver (or generally the consumer of sensor output) does not see a dif=
ference between real hardware and software simulation.
> Always fascinated me that a piece of code was written assuming that it wi=
ll access a certain hardware and then I could swap that hardware with a sof=
tware component and see what happens. Is it depending on an undocumented ha=
rdware behavior? Is it able to handle inconsistent sensor state?
>=20
> What do you think? Is this something worth looking into?

Sensor emulation in general is fine, but I am a little unclear why
vhost user is particularly valuable for this vs just emulating in
tree.  I've very little interest in any complex hardening against
malicious or broken hardware.  I don't mind such things in the
kernel code if they are simple enough, but mostly this is considered
out of scope because it bloats drivers for conditions we should
never see.

If you are interested in testing kernel drivers then there are
lighter alternatives such as roadtest from axis.  I gathered from
a discussion at LPC that that might get reposted sometime soon
as it has been out of tree for years. Quite a bit can also be
done via the kernel selftesting environment these days.

So on the whole extra sensor emulation in qemu is fine and useful
for certain types of testing. Explain more on your thinking for
using vhost for this.

Jonathan


>=20
> Regards
> Tam=C3=A1s
>=20
> ________________________________
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Tuesday, June 9, 2026 16:42
> To: Tam=C3=A1s Kir=C3=A1ly <kiraly.tamas@outlook.com>
> Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>; philmd@mailo.com <phil=
md@mailo.com>
> Subject: Re: RFC sensor simulation in QEMU
>=20
> On Tue, 2 Jun 2026 13:23:14 +0000
> Tam=C3=A1s Kir=C3=A1ly <kiraly.tamas@outlook.com> wrote:
>=20
> > Hi all,
> >
> > I am interested in implementing sensor simulations. I already saw that =
there are some sensor implementations with varying details in QEMU. My ques=
tion is the following: Is that a good idea to extend that part of QEMU or n=
ew implementations should happen outside of QEMU and some protocol, e.g. vh=
ost user should be used to provide sensors to QEMU? I would like to align w=
ith the long term ideas. What was the original intent with the sensor subsy=
stem? =20
>=20
> Hi Tam=C3=A1s
>=20
> 'Sensors' is a very broad term. Could you be a little more specific in wh=
at
> types of sensors you are interested in?
>=20
> Thanks,
>=20
> Jonathan
>=20
> >
> > regards
> > Tam=C3=A1s Kir=C3=A1ly =20
>=20


