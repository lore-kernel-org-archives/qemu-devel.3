Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463CAC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 13:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJXij-0007Lk-DM; Mon, 26 May 2025 09:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uJXih-0007LO-Un; Mon, 26 May 2025 09:18:23 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uJXif-00084O-6F; Mon, 26 May 2025 09:18:23 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6269255BC03;
 Mon, 26 May 2025 15:18:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 4ZNuGtJBy_Vr; Mon, 26 May 2025 15:18:13 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5754055BC02; Mon, 26 May 2025 15:18:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 54C07745682;
 Mon, 26 May 2025 15:18:13 +0200 (CEST)
Date: Mon, 26 May 2025 15:18:13 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Nicholas Piggin <npiggin@gmail.com>, Yanan Wang <wangyanan55@huawei.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org, 
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 0/3] hw/boards: Remove MachineState::usb_disabled field
In-Reply-To: <20250526130006.49817-1-philmd@linaro.org>
Message-ID: <1c9f8e9d-1ee6-b2d9-98d6-5640f59f0e4a@eik.bme.hu>
References: <20250526130006.49817-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-2023561237-1748265493=:32022"
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

--3866299591-2023561237-1748265493=:32022
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 26 May 2025, Philippe Mathieu-Daudé wrote:
> Only add default devices checking defaults_enabled().
> Remove the unused usb_disabled field in MachineState.

At least for Mac machines this may be more complex. I think there is a 
-usb switch to enable/disable USB independently of defaults and due to 
some bugs some MacOS versions may need this to boot so maybe it's used.

Regards,
BALATON Zoltan

> Based-on: <20250526112346.48744-1-philmd@linaro.org>
>          "hw/ppc: Fix --without-default-devices build"
>
> Philippe Mathieu-Daudé (3):
>  hw/ppc/spapr: Only create default devices when requested
>  hw/ppc/mac_newworld: Only create default devices when requested
>  hw/boards: Remove MachineState::usb_disabled field
>
> include/hw/boards.h   | 1 -
> hw/core/machine.c     | 1 -
> hw/ppc/mac_newworld.c | 3 +--
> hw/ppc/spapr.c        | 3 +--
> 4 files changed, 2 insertions(+), 6 deletions(-)
>
>
--3866299591-2023561237-1748265493=:32022--

