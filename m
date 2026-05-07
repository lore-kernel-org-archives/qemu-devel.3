Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15971CD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 00:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKmCf-0007eq-2R; Wed, 06 May 2026 20:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1wKmCU-0007dk-Jl; Wed, 06 May 2026 20:02:47 -0400
Received: from dedi548.your-server.de ([85.10.215.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1wKmCS-0000Mn-BX; Wed, 06 May 2026 20:02:46 -0400
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by dedi548.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1wKmCM-000G6b-1q; Thu, 07 May 2026 02:02:38 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1wKmCM-0003Uc-0u; Thu, 07 May 2026 02:02:38 +0200
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id EEB5548004C;
 Thu,  7 May 2026 02:02:37 +0200 (CEST)
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10032)
 with ESMTP id lqp8S7qUFLit; Thu,  7 May 2026 02:02:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 80EA9480069;
 Thu,  7 May 2026 02:02:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.embedded-brains.de 80EA9480069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=embedded-brains.de;
 s=34EE5404-8E36-11F0-B577-2ECCAB4968F5; t=1778112157;
 bh=L5LNGW6gYmlMwSWTqE0Cv2QikbxDpTgoHLa4jzrDamQ=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=hr28tlg7YqvINXFzf1HawXG5mqKk8g5rOPsXE5fYyJmChmVOw+/wdyKsIRNqR8bXU
 tjPSidBniCvA3A69sBWBV6e8lpw8eQ75Ke92UlRRM1041hfop5caob1HpXi+dUScG7
 NYQ6ikq0ndyq8CeZPOaNn9D4Agng0c5OGRyV7lS/Wq6orq44rzizVHdahHJNcwt9p8
 0eR+jNOinAR9H5lQGjpRyEUYKN4gfoMGx5N8tfeaC9jTeSa8/3CdQ160r3E+vuyvYs
 ig5qdKlVJFsmAPlHZ5tQ7pilZEGROXoYYFEu3iaTp9QkBaZwiwzYX3H4eMm6ZIgn5J
 C0RneuKmfzK+g==
X-Virus-Scanned: amavis at zimbra.eb.localhost
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10026)
 with ESMTP id B19WqZcRpJLm; Thu,  7 May 2026 02:02:37 +0200 (CEST)
Received: from zimbra.eb.localhost (zimbra.eb.localhost [192.168.96.204])
 by mail.embedded-brains.de (Postfix) with ESMTP id 32F9D48004C;
 Thu,  7 May 2026 02:02:37 +0200 (CEST)
Date: Thu, 7 May 2026 02:02:36 +0200 (CEST)
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
To: Alistair Francis <alistair23@gmail.com>
Cc: Conor Dooley <conor@kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
 qemu-devel <qemu-devel@nongnu.org>, qemu-riscv <qemu-riscv@nongnu.org>
Message-ID: <77105819.36210.1778112156670.JavaMail.zimbra@embedded-brains.de>
In-Reply-To: <CAKmqyKMC0jxMMV0RuPHZrwBbsAeHhOvM+Ak_+=hGgM1C8eeUxA@mail.gmail.com>
References: <87y0hwbvbp.fsf@pond.sub.org>
 <CAKmqyKMC0jxMMV0RuPHZrwBbsAeHhOvM+Ak_+=hGgM1C8eeUxA@mail.gmail.com>
Subject: Re: MAINTAINERS entries that aren't S: Orphan but maybe should be
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.168.96.204]
X-Mailer: Zimbra 10.1.16_GA_4850 (ZimbraWebClient - FF140
 (Linux)/10.1.16_GA_4863)
Thread-Topic: MAINTAINERS entries that aren't S: Orphan but maybe should be
Thread-Index: KRKp7g7fMSKOx4f2r4jPHSp7/u6W8w==
X-DKIM-Status: pass [(embedded-brains.de) - 78.47.199.104]
X-Virus-Scanned: Clear (ClamAV 1.4.3/27993/Wed May  6 08:24:57 2026)
Received-SPF: pass client-ip=85.10.215.148;
 envelope-from=sebastian.huber@embedded-brains.de; helo=dedi548.your-server.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Dear Alistair,

----- Am 7. Mai 2026 um 1:40 schrieb Alistair Francis alistair23@gmail.com:

> On Wed, May 6, 2026 at 10:03=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> I'm cc'ing reviewers and lists mentioned below, and frequent
>> contributors to MAINTAINERS.
>>
>> There are a number of MAINTAINERS entries with S: other than "Orphan"
>> without M:
>>
>>     $ awk '/^M: / { m++ } /^S: / { s=3D$2 } /^$/ && s { if (!m && s !=3D=
 "Orphan") print
>>     t; m=3D0; s=3D""; getline; t=3DFILENAME ":" FNR ": " $0; next }' MAI=
NTAINERS
>>     MAINTAINERS:1736: Microchip PolarFire SoC Icicle Kit
>=20
> Conor, Sebastian and Guenter, are you still using the Microchip
> PolarFire SoC Icicle Kit? We currently don't have a maintainer for it.
> I'm tempted to deprecate it, as I thought it didn't really work
> anyway, but I wasn't sure.

the Microchip PolarFire SoC Icicle Kit machine works great for running bare=
 metal / simple OS test suites.

>=20
> So is anyone using it and is anyone willing to maintain it?

I follow the Qemu development. If something breaks the machine, I would try=
 to fix it. However, I have am quite busy with all sorts of things so getti=
ng any kind of service and timing guarantees from my side is not possible. =
For example, I was still not able to have a look at the Linux command line =
regression.

Kind regards,
Sebastian

--=20
VISIT US @ SATELLITE ASIA IN SINGAPORE 20-22 MAY (https://asiatechxsg.com/s=
atelliteasia//): Hall 4, Booth 4K2-4
--
embedded brains GmbH & Co. KG
Herr Sebastian HUBER
Dornierstr. 4
82178 Puchheim
Germany
email: sebastian.huber@embedded-brains.de
phone: +49-89-18 94 741 - 16
fax:   +49-89-18 94 741 - 08

Registergericht: Amtsgericht M=C3=BCnchen
Registernummer: HRB 157899
Vertretungsberechtigte Gesch=C3=A4ftsf=C3=BChrer: Peter Rasmussen, Thomas D=
=C3=B6rfler
Unsere Datenschutzerkl=C3=A4rung finden Sie hier:
https://embedded-brains.de/datenschutzerklaerung/

