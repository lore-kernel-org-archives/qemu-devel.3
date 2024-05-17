Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D544EC04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 08:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7szR-0003L5-Aj; Fri, 17 May 2024 04:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1s7sz9-0003I2-QY; Fri, 17 May 2024 04:30:39 -0400
Received: from dedi548.your-server.de ([85.10.215.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1s7sz4-00056f-OO; Fri, 17 May 2024 04:30:37 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by dedi548.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1s7syr-0007D9-2x; Fri, 17 May 2024 10:30:21 +0200
Received: from [82.100.198.138] (helo=mail.embedded-brains.de)
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1s7syq-0003EL-26; Fri, 17 May 2024 10:30:20 +0200
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 6C412480074;
 Fri, 17 May 2024 10:30:20 +0200 (CEST)
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 2ySUusHZZffG; Fri, 17 May 2024 10:30:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 2C596480154;
 Fri, 17 May 2024 10:30:20 +0200 (CEST)
X-Virus-Scanned: amavis at zimbra.eb.localhost
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10026)
 with ESMTP id YyON4gK1AiCO; Fri, 17 May 2024 10:30:20 +0200 (CEST)
Received: from [192.168.96.179] (unknown [192.168.96.179])
 by mail.embedded-brains.de (Postfix) with ESMTPSA id 0D544480074;
 Fri, 17 May 2024 10:30:20 +0200 (CEST)
Message-ID: <78f54624-2a7f-4478-88b9-bc69b2a482cd@embedded-brains.de>
Date: Fri, 17 May 2024 10:30:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Zynq 7000 SoC improvements
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20240507130349.86851-1-sebastian.huber@embedded-brains.de>
Content-Language: en-US
In-Reply-To: <20240507130349.86851-1-sebastian.huber@embedded-brains.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Sender: smtp-embedded@poldi-networks.de
X-Virus-Scanned: Clear (ClamAV 0.103.10/27277/Thu May 16 10:25:03 2024)
Received-SPF: pass client-ip=85.10.215.148;
 envelope-from=sebastian.huber@embedded-brains.de; helo=dedi548.your-server.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Hello,

is the mailing list the right place for contributions like this?

On 07.05.24 15:03, Sebastian Huber wrote:
> Add support for the cache controller and up to two Cortex-A9 MPCore.
>=20
> Sebastian Huber (2):
>    hw/arm/xilinx_zynq: Add cache controller
>    hw/arm/xilinx_zynq: Support up to two CPU cores
>=20
>   hw/arm/xilinx_zynq.c | 43 ++++++++++++++++++++++++++++---------------
>   1 file changed, 28 insertions(+), 15 deletions(-)
>=20

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
Vertretungsberechtigte Gesch=C3=A4ftsf=C3=BChrer: Peter Rasmussen, Thomas=
 D=C3=B6rfler
Unsere Datenschutzerkl=C3=A4rung finden Sie hier:
https://embedded-brains.de/datenschutzerklaerung/

