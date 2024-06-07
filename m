Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A22C27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 22:25:11 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFaaM-0003CJ-45; Fri, 07 Jun 2024 10:28:54 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1sFaaK-0003Bu-Dc; Fri, 07 Jun 2024 10:28:52 -0400
Received: from dedi548.your-server.de ([85.10.215.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1sFaaI-0001o7-8N; Fri, 07 Jun 2024 10:28:52 -0400
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by dedi548.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1sFaaD-0004K4-0S; Fri, 07 Jun 2024 16:28:45 +0200
Received: from [82.100.198.138] (helo=mail.embedded-brains.de)
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <sebastian.huber@embedded-brains.de>)
 id 1sFaaD-0001sC-1k; Fri, 07 Jun 2024 16:28:45 +0200
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id BC7A84801B2;
 Fri,  7 Jun 2024 16:28:44 +0200 (CEST)
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10032)
 with ESMTP id ZzJMNP0hNsLq; Fri,  7 Jun 2024 16:28:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mail.embedded-brains.de (Postfix) with ESMTP id 782A2480282;
 Fri,  7 Jun 2024 16:28:44 +0200 (CEST)
X-Virus-Scanned: amavis at zimbra.eb.localhost
Received: from mail.embedded-brains.de ([127.0.0.1])
 by localhost (zimbra.eb.localhost [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 3O3w6ZK6WpYH; Fri,  7 Jun 2024 16:28:44 +0200 (CEST)
Received: from [192.168.96.179] (unknown [192.168.96.179])
 by mail.embedded-brains.de (Postfix) with ESMTPSA id 56F324801B2;
 Fri,  7 Jun 2024 16:28:44 +0200 (CEST)
Message-ID: <cdfed70e-9dd1-4169-a73d-6a6c98c41ac2@embedded-brains.de>
Date: Fri, 7 Jun 2024 16:28:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Zynq 7000 Improvements
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240524120837.10057-1-sebastian.huber@embedded-brains.de>
 <CAFEAcA81fqWKXL_7m6LTi0-zkmtMQC0RY6_ZNP49cdWCVJK+1Q@mail.gmail.com>
Content-Language: en-US
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
In-Reply-To: <CAFEAcA81fqWKXL_7m6LTi0-zkmtMQC0RY6_ZNP49cdWCVJK+1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Sender: smtp-embedded@poldi-networks.de
X-Virus-Scanned: Clear (ClamAV 1.0.3/27299/Fri Jun  7 10:27:20 2024)
Received-SPF: pass client-ip=85.10.215.148;
 envelope-from=sebastian.huber@embedded-brains.de; helo=dedi548.your-server.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 30.05.24 12:30, Peter Maydell wrote:
> On Fri, 24 May 2024 at 13:08, Sebastian Huber
> <sebastian.huber@embedded-brains.de> wrote:
>>
>> v2:
>>
>> * Add Kconfig support
>>
>> * Add array of CPUs to ZynqMachineState
>>
>> * Add FIQ support
>>
>> Sebastian Huber (2):
>>    hw/arm/xilinx_zynq: Add cache controller
>>    hw/arm/xilinx_zynq: Support up to two CPU cores
>=20
>=20
>=20
> Applied to target-arm.next, thanks.

Thanks, for the integration. I did some more tests and there is an issue=20
with the IPI support. My test case worked with this change:

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 7f7a3d23fb..8d84eaf070 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -253,9 +253,9 @@ static void zynq_init(MachineState *machine)
      sysbus_create_varargs("l2x0", MPCORE_PERIPHBASE + 0x2000, NULL);
      for (n =3D 0; n < smp_cpus; n++) {
          DeviceState *cpudev =3D DEVICE(zynq_machine->cpu[n]);
-        sysbus_connect_irq(busdev, (2 * n) + 0,
+        sysbus_connect_irq(busdev, n,
                             qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
-        sysbus_connect_irq(busdev, (2 * n) + 1,
+        sysbus_connect_irq(busdev, smp_cpus + n,
                             qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
      }

This is just guess work on my side since I have no idea how the second=20
parameter relates to the pin.

Originally I used the hw/arm/realview.c as a reference, but his target=20
doesn't use the ARM_CPU_FIQ at all.

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

