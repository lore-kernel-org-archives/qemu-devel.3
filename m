Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F20C021B3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 05:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmRFy-0005sI-Tc; Mon, 24 Feb 2025 00:43:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tmRFw-0005rz-TP
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 00:43:52 -0500
Received: from dedi548.your-server.de ([85.10.215.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tmRFu-00011T-Bg
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 00:43:52 -0500
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by dedi548.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tmRFo-000KuN-21; Mon, 24 Feb 2025 06:43:44 +0100
Received: from [82.100.198.138] (helo=mail.embedded-brains.de)
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1tmRFn-0006F6-32; Mon, 24 Feb 2025 06:43:44 +0100
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 09C95480198;
 Mon, 24 Feb 2025 06:43:44 +0100 (CET)
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10032)
 with ESMTP id l2CBCEf3iwp4; Mon, 24 Feb 2025 06:43:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 647A048019A;
 Mon, 24 Feb 2025 06:43:43 +0100 (CET)
X-Virus-Scanned: amavis at zimbra.eb.localhost
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10026)
 with ESMTP id GZkhY7_UnrTR; Mon, 24 Feb 2025 06:43:43 +0100 (CET)
Received: from zimbra.eb.localhost (zimbra.eb.localhost [192.168.96.204])
 by mail.embedded-brains.de (Postfix) with ESMTP id 3193B480198;
 Mon, 24 Feb 2025 06:43:43 +0100 (CET)
Date: Mon, 24 Feb 2025 06:43:42 +0100 (CET)
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Bin Meng <bin.meng@windriver.com>
Message-ID: <1989799473.175.1740375822271.JavaMail.zimbra@embedded-brains.de>
In-Reply-To: <CAKmqyKNZfBcqT08v-wYmApYuQgM7in__Q3b_vwEgZp+sXr8ckA@mail.gmail.com>
References: <20250214062443.9936-1-sebastian.huber@embedded-brains.de>
 <20250214062443.9936-4-sebastian.huber@embedded-brains.de>
 <CAKmqyKNZfBcqT08v-wYmApYuQgM7in__Q3b_vwEgZp+sXr8ckA@mail.gmail.com>
Subject: Re: [PATCH 3/5] hw/riscv: Make FDT optional for MPFS
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.168.96.204]
X-Mailer: Zimbra 10.1.5_GA_4724 (ZimbraWebClient - FF128
 (Linux)/10.1.5_GA_4734)
Thread-Topic: hw/riscv: Make FDT optional for MPFS
Thread-Index: 7aJoUcIhB1hkjtGqZklhGz5GBLNaAA==
X-Authenticated-Sender: smtp-embedded@poldi-networks.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27558/Sun Feb 23 10:40:51 2025)
Received-SPF: pass client-ip=85.10.215.148;
 envelope-from=sebastian.huber@embedded-brains.de; helo=dedi548.your-server.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

----- Am 24. Feb 2025 um 6:22 schrieb Alistair Francis alistair23@gmail.com=
:

> On Fri, Feb 14, 2025 at 4:27=E2=80=AFPM Sebastian Huber
> <sebastian.huber@embedded-brains.de> wrote:
>>
>> Real-time kernels such as RTEMS or Zephyr may use a static device tree
>> built into the kernel image.  Do not require to use the -dtb option if
>> -kernel is used for the microchip-icicle-kit machine.
>=20
> That's a fair point, but it might also confuse people who expect QEMU
> to generate a DTB if they don't specify one.
>=20
> This at least needs a documentation update, but a warning log might
> also be warranted if no `-dtb` is supplied

I will add a documentation update to:

docs/system/riscv/microchip-icicle-kit.rst

Should I change this patch to require "-dtb none" to select no DTB at all?

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

