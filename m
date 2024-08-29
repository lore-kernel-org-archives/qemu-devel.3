Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B43CC83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 13:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjfFm-0002TU-Nl; Thu, 29 Aug 2024 09:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1sjfFk-0002ST-2t; Thu, 29 Aug 2024 09:31:56 -0400
Received: from dedi548.your-server.de ([85.10.215.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1sjfFh-0003L2-W4; Thu, 29 Aug 2024 09:31:55 -0400
Received: from sslproxy04.your-server.de ([78.46.152.42])
 by dedi548.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1sjfFc-000KqY-0q; Thu, 29 Aug 2024 15:31:48 +0200
Received: from [82.100.198.138] (helo=mail.embedded-brains.de)
 by sslproxy04.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1sjfFc-0008hG-1A; Thu, 29 Aug 2024 15:31:48 +0200
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id DDD5A480180;
 Thu, 29 Aug 2024 15:31:47 +0200 (CEST)
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 5UqitALMj2Q1; Thu, 29 Aug 2024 15:31:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 749BA4801BB;
 Thu, 29 Aug 2024 15:31:47 +0200 (CEST)
X-Virus-Scanned: amavis at zimbra.eb.localhost
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10026)
 with ESMTP id GJ3th0uv7_34; Thu, 29 Aug 2024 15:31:47 +0200 (CEST)
Received: from zimbra.eb.localhost (zimbra.eb.localhost [192.168.96.204])
 by mail.embedded-brains.de (Postfix) with ESMTP id 4F259480180;
 Thu, 29 Aug 2024 15:31:47 +0200 (CEST)
Date: Thu, 29 Aug 2024 15:31:47 +0200 (CEST)
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Alistair Francis <alistair@alistair23.me>
Message-ID: <694012793.134674.1724938307291.JavaMail.zimbra@embedded-brains.de>
In-Reply-To: <CAFEAcA-p+CBeKTgH-YXzrATKDpwG5iY+A3WGaVkbEeHCXxTzug@mail.gmail.com>
References: <20240828005019.57705-1-sebastian.huber@embedded-brains.de>
 <CAFEAcA-p+CBeKTgH-YXzrATKDpwG5iY+A3WGaVkbEeHCXxTzug@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/xilinx_zynq: Enable Security Extensions
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.168.96.204]
X-Mailer: Zimbra 9.0.0_GA_4615 (ZimbraWebClient - FF115 (Linux)/9.0.0_GA_4615)
Thread-Topic: hw/arm/xilinx_zynq: Enable Security Extensions
Thread-Index: xRCJRVSMo8Gofd7M0UxQXxVZXgJSAA==
X-Authenticated-Sender: smtp-embedded@poldi-networks.de
X-Virus-Scanned: Clear (ClamAV 1.0.5/27382/Thu Aug 29 10:52:14 2024)
Received-SPF: pass client-ip=85.10.215.148;
 envelope-from=sebastian.huber@embedded-brains.de; helo=dedi548.your-server.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello Peter,

----- Am 29. Aug 2024 um 14:50 schrieb Peter Maydell peter.maydell@linaro.o=
rg:

> On Wed, 28 Aug 2024 at 01:51, Sebastian Huber
> <sebastian.huber@embedded-brains.de> wrote:
>>
>> The system supports the Security Extensions (core and GIC).  This change=
 is
>> necessary to run tests which pass on the real hardware.
>>
>> Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
>=20
> (Added the maintainers to cc.)
>=20
> Does the system have any secure-only devices, RAM, etc?
>=20
> How much testing have you done with this change? (The main
> reason we disabled has-el3 on this board back in 2014 was
> as a backwards-compatibility thing when we added EL3 support
> to the CPU model -- we didn't have a ton of images for the
> board so we erred on the safe side of not changing the
> behaviour to avoid potentially breaking existing guest code.)

I only tested this change with the RTEMS test suite. I added new tests for =
the exception handling and this change was necessary to trigger FIQs.

I haven't used this machine to work with Linux so far.

--=20
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

