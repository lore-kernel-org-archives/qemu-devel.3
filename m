Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E61CD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 06:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN2kv-0003f1-8o; Wed, 13 May 2026 02:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1wN2kj-0003dx-2Y; Wed, 13 May 2026 02:07:29 -0400
Received: from dedi548.your-server.de ([85.10.215.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1wN2kf-0002WP-9r; Wed, 13 May 2026 02:07:28 -0400
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by dedi548.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1wN2kU-000MXy-2z; Wed, 13 May 2026 08:07:14 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1wN2kU-0003k1-2R; Wed, 13 May 2026 08:07:14 +0200
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 0AB63480051;
 Wed, 13 May 2026 08:07:14 +0200 (CEST)
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10032)
 with ESMTP id faMe_JtfmG7G; Wed, 13 May 2026 08:07:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 177EC480061;
 Wed, 13 May 2026 08:07:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.embedded-brains.de 177EC480061
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=embedded-brains.de;
 s=34EE5404-8E36-11F0-B577-2ECCAB4968F5; t=1778652433;
 bh=xnx1YDIwHeJYFz5i062OwXfkdYFLJzKfqBzLnblQ80M=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=VyJqXXyxTS9oV87mrwsMWisTXyN7DUiTgCWrnVH8YBMvIdIvcfZQot+hdMqZXuobZ
 WEwAnXuOl/HG+xI/JUSoM4wqGPFJ9DaafUkjP9LTUZsWg6XX++lxGVdh6tyrKZM1Pn
 e8l4l8op9LL3ngV9hqJ9/JdYtqIa2mqPLw4ccI9IzRG+TgKaxNce92L2K7iP0avhdk
 pxz3/PH6sd/x6pA/xhp/cyo9XIsxg6KaWPjjZjt/A4I5kmJy0dU/vfByaRINErxcND
 vNgnsLH9nW9PHzZxF8ptjFTRKZBa97AwbFo3HpH10SjhO/8VnZg2+mW0EkcdYxSOlC
 Lqjg7Incbwolw==
X-Virus-Scanned: amavis at zimbra.eb.localhost
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10026)
 with ESMTP id DpbXAPSN4x4T; Wed, 13 May 2026 08:07:12 +0200 (CEST)
Received: from zimbra.eb.localhost (zimbra.eb.localhost [192.168.96.204])
 by mail.embedded-brains.de (Postfix) with ESMTP id D8F11480059;
 Wed, 13 May 2026 08:07:12 +0200 (CEST)
Date: Wed, 13 May 2026 08:07:12 +0200 (CEST)
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
To: Markus Armbruster <armbru@redhat.com>
Cc: Alistair Francis <alistair23@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, liwei1518 <liwei1518@gmail.com>, 
 daniel barboza <daniel.barboza@oss.qualcomm.com>, 
 zhiwei liu <zhiwei_liu@linux.alibaba.com>, 
 chao liu zevorn <chao.liu.zevorn@gmail.com>, 
 qemu-riscv <qemu-riscv@nongnu.org>, 
 qemu-devel <qemu-devel@nongnu.org>, Conor Dooley <conor@kernel.org>, 
 alistair francis <alistair.francis@wdc.com>
Message-ID: <1898448862.14224.1778652432278.JavaMail.zimbra@embedded-brains.de>
In-Reply-To: <87mry3vomd.fsf@pond.sub.org>
References: <20260513023859.518484-1-alistair.francis@wdc.com>
 <1514447636.13520.1778641704122.JavaMail.zimbra@embedded-brains.de>
 <87mry3vomd.fsf@pond.sub.org>
Subject: Re: [PATCH] MAINTAINERS: Mark Microchip PolarFire SoC as Odd Fixes
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.168.96.204]
X-Mailer: Zimbra 10.1.16_GA_4850 (ZimbraWebClient - FF140
 (Linux)/10.1.16_GA_4863)
Thread-Topic: MAINTAINERS: Mark Microchip PolarFire SoC as Odd Fixes
Thread-Index: fYCMhywhgUtHNy/NKq9cfBK8uPC4WQ==
X-DKIM-Status: pass [(embedded-brains.de) - 78.47.199.104]
X-Virus-Scanned: Clear (ClamAV 1.4.3/27998/Tue May 12 08:24:57 2026)
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

----- Am 13. Mai 2026 um 7:56 schrieb Markus Armbruster armbru@redhat.com:

> Sebastian Huber <sebastian.huber@embedded-brains.de> writes:
>=20
>> ----- Am 13. Mai 2026 um 4:38 schrieb Alistair Francis alistair23@gmail.=
com:
>>
>>> From: Alistair Francis <alistair.francis@wdc.com>
>>>=20
>>> Mark the "Microchip PolarFire SoC Icicle Kit" as Odd Fixes and enlist
>>> Conor and Sebastian as people to help deal with the fixes.
>>>=20
>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>>
>> Thanks, this is fine.
>=20
> Can you make it official?  Acked-by: ...

Acked-by: Sebastian Huber <sebastian.huber@embedded-brains.de>

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

