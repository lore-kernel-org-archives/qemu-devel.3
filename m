Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3BBEF48C4
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 12:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrENf-0002PC-D9; Sat, 14 Feb 2026 07:04:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vrENc-0002Op-Cy; Sat, 14 Feb 2026 07:04:08 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vrENa-0007BW-8L; Sat, 14 Feb 2026 07:04:08 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2E6185969F6;
 Sat, 14 Feb 2026 13:04:01 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 2lLOvWOs37Ip; Sat, 14 Feb 2026 13:03:59 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0FE1F5969F1; Sat, 14 Feb 2026 13:03:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0A36E5969F0;
 Sat, 14 Feb 2026 13:03:59 +0100 (CET)
Date: Sat, 14 Feb 2026 13:03:58 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH 8/8] system/globals: Build as common code
In-Reply-To: <6c85073c-e70c-3cb2-d2ad-57c5177dab88@eik.bme.hu>
Message-ID: <c2a8834a-de12-d48e-f869-197acbbe1d3e@eik.bme.hu>
References: <20260214021240.58657-1-philmd@linaro.org>
 <20260214021240.58657-9-philmd@linaro.org>
 <6c85073c-e70c-3cb2-d2ad-57c5177dab88@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1326153323-1771070639=:43665"
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

--3866299591-1326153323-1771070639=:43665
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 14 Feb 2026, BALATON Zoltan wrote:
> On Sat, 14 Feb 2026, Philippe Mathieu-Daudé wrote:
>> Now than all targets have the graphic dimension variables
>
> Typo: ^^^^ that
>
>> initialized the same way, we can move them to the common
>> file unit, having them built once. Remove the now empty
>> globals-target.c file.
>> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> system/globals-target.c | 14 --------------
>> system/globals.c        |  3 +++
>> system/meson.build      |  4 ----
>> 3 files changed, 3 insertions(+), 18 deletions(-)
>> delete mode 100644 system/globals-target.c
>> 
>> diff --git a/system/globals-target.c b/system/globals-target.c
>> deleted file mode 100644
>> index ffa6c308b59..00000000000
>> --- a/system/globals-target.c
>> +++ /dev/null
>> @@ -1,14 +0,0 @@
>> -/*
>> - * Global variables that should not exist (target specific)
>> - *
>> - * Copyright (c) 2003-2008 Fabrice Bellard
>> - *
>> - * SPDX-License-Identifier: MIT
>> - */
>> -
>> -#include "qemu/osdep.h"
>> -#include "system/system.h"
>> -
>> -int graphic_width;
>> -int graphic_height;
>> -int graphic_depth;
>> diff --git a/system/globals.c b/system/globals.c
>> index c33f6ed3902..34fd3ce9c72 100644
>> --- a/system/globals.c
>> +++ b/system/globals.c
>> @@ -49,6 +49,9 @@ bool enable_cpu_pm;
>> int autostart = 1;
>> int vga_interface_type = VGA_NONE;
>> bool vga_interface_created;
>> +int graphic_width;
>> +int graphic_height;
>> +int graphic_depth;
>
> Where do other machines get their default values from now? This used to have 
> #else 800x600x32 which is the default resolution when not specifying a -g 
> option and some machines may depend on that. Where that default is
> established now?

So it seems this reverts your commit 5dc4337f7908 from a year ago. The 
message linked in that commit message says these are only used by ppc and 
sparc machines. In that case maybe not needed here as global and better be 
moved to ppc.{h,c} after removing the special cases as I thought in 
previous patch.

Regards,
BALATON Zoltan
--3866299591-1326153323-1771070639=:43665--

