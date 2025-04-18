Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B9FC369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 08:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5hTS-0004SL-EQ; Fri, 18 Apr 2025 04:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u5hTP-0004RJ-GZ; Fri, 18 Apr 2025 04:53:23 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u5hTN-0001NZ-22; Fri, 18 Apr 2025 04:53:23 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6C8FA55D21A;
 Fri, 18 Apr 2025 10:53:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id kjrGb1OLwGkb; Fri, 18 Apr 2025 10:53:13 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 745DA55C592; Fri, 18 Apr 2025 10:53:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7185F745682;
 Fri, 18 Apr 2025 10:53:13 +0200 (CEST)
Date: Fri, 18 Apr 2025 10:53:13 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Andrey Smirnov <andrew.smirnov@gmail.com>, 
 Antony Pavlov <antonynpavlov@gmail.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Beniamino Galvani <b.galvani@gmail.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Felipe Balbi <balbi@kernel.org>, Bernhard Beschow <shentey@gmail.com>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, 
 Jan Kiszka <jan.kiszka@web.de>, Alistair Francis <alistair@alistair23.me>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, 
 Alexandre Iooss <erdnaxe@crans.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH 00/11] hw/arm: Define machines as generic QOM types
In-Reply-To: <20250417235814.98677-1-philmd@linaro.org>
Message-ID: <a302fb91-e2d8-ef36-ac53-5e460476c2d0@eik.bme.hu>
References: <20250417235814.98677-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-674896605-1744966393=:81771"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-674896605-1744966393=:81771
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 18 Apr 2025, Philippe Mathieu-Daudé wrote:
> While DEFINE_MACHINE() is a succinct macro, it doesn't
> allow registering QOM interfaces to the defined machine.
> Convert to the generic DEFINE_TYPES() in preparation to
> register interfaces.
>
> Philippe Mathieu-Daudé (11):
>  hw/core/null-machine: Define machine as generic QOM type
>  hw/arm/bananapi: Define machine as generic QOM type
>  hw/arm/cubieboard: Define machine as generic QOM type
>  hw/arm/digic: Define machine as generic QOM type
>  hw/arm/imx: Define machines as generic QOM types
>  hw/arm/integratorcp: Define machine as generic QOM type
>  hw/arm/kzm: Define machine as generic QOM type
>  hw/arm/msf2: Define machine as generic QOM type
>  hw/arm/musicpal: Define machine as generic QOM type
>  hw/arm/orangepi: Define machine as generic QOM type
>  hw/arm/stm32: Define machines as generic QOM types
>
> hw/arm/bananapi_m2u.c      | 13 +++++++++++--
> hw/arm/cubieboard.c        | 13 +++++++++++--
> hw/arm/digic_boards.c      | 14 ++++++++++++--
> hw/arm/imx25_pdk.c         | 14 ++++++++++++--
> hw/arm/imx8mp-evk.c        | 15 +++++++++++++--
> hw/arm/integratorcp.c      | 16 +++++++++++++---
> hw/arm/kzm.c               | 14 ++++++++++++--
> hw/arm/mcimx6ul-evk.c      | 15 +++++++++++++--
> hw/arm/mcimx7d-sabre.c     | 15 +++++++++++++--
> hw/arm/msf2-som.c          | 13 +++++++++++--
> hw/arm/musicpal.c          | 16 +++++++++++++---
> hw/arm/netduino2.c         | 13 +++++++++++--
> hw/arm/netduinoplus2.c     | 13 +++++++++++--
> hw/arm/olimex-stm32-h405.c | 13 +++++++++++--
> hw/arm/orangepi.c          | 13 +++++++++++--
> hw/arm/sabrelite.c         | 14 ++++++++++++--
> hw/arm/stm32vldiscovery.c  | 13 +++++++++++--
> hw/core/null-machine.c     | 14 ++++++++++++--
> 18 files changed, 213 insertions(+), 38 deletions(-)

This is much longer and exposing boiler plate code. Is it possible instead 
to change DEFINE_MACHINE or add another similar macro that allows 
specifying more details such as class state type and interfaces like we 
already have for OBJECT_DEFINE macros to keep the boiler plate code hidden 
and not bring it back?

Regards,
BALATON Zoltan
--3866299591-674896605-1744966393=:81771--

