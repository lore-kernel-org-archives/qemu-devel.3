Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5CCFF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDjJ-0005ZD-4o; Wed, 29 Apr 2026 18:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wIDjG-0005Z5-Rp
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:50:02 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wIDjF-00053q-7W
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:50:02 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4AD93596964;
 Thu, 30 Apr 2026 00:49:57 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id n6cH1Aeujrvh; Thu, 30 Apr 2026 00:49:55 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 442F4596963; Thu, 30 Apr 2026 00:49:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 429B7596962;
 Thu, 30 Apr 2026 00:49:55 +0200 (CEST)
Date: Thu, 30 Apr 2026 00:49:55 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
cc: qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 12/26] ui: move FONT_WIDTH/HEIGHT to vgafont.h
In-Reply-To: <20260430-qemu-vnc-v3-12-be96757428d0@redhat.com>
Message-ID: <e4c137e8-30dd-0d94-b21b-1040fef6495e@eik.bme.hu>
References: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
 <20260430-qemu-vnc-v3-12-be96757428d0@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-891041428-1777502974=:45390"
Content-ID: <5b2731d2-e604-6fa6-2463-d50e7c8de3e5@eik.bme.hu>
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-891041428-1777502974=:45390
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <0960bc34-319e-ebf7-8dec-8bb99329b3ef@eik.bme.hu>

On Thu, 30 Apr 2026, Marc-André Lureau wrote:
> Since those values are related to the VGA font, it make sense to move
> them here.
>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
> ui/console-vc.c | 1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/ui/console-vc.c b/ui/console-vc.c
> index b9da9ddf30d..457d071c774 100644
> --- a/ui/console-vc.c
> +++ b/ui/console-vc.c
> @@ -13,6 +13,7 @@
> #include "ui/console.h"
> #include "ui/vgafont.h"
> #include "ui/cp437.h"
> +#include "ui/vgafont.h"
>
> #include "pixman.h"
> #include "trace.h"

Patch does not seem to contain what the commit message says. Maybe a 
rebase error?

Regards,
BALATON Zoltan
--3866299591-891041428-1777502974=:45390--

