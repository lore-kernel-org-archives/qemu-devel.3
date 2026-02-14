Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2641CEF48C4
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 11:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrDqj-0001bY-IT; Sat, 14 Feb 2026 06:30:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vrDqf-0001Zj-An; Sat, 14 Feb 2026 06:30:05 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vrDqb-0007CA-1R; Sat, 14 Feb 2026 06:30:03 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4214A596A29;
 Sat, 14 Feb 2026 12:29:56 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id WJp4W4OJEAbo; Sat, 14 Feb 2026 12:29:54 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 25FC25969F1; Sat, 14 Feb 2026 12:29:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 23E755969F0;
 Sat, 14 Feb 2026 12:29:54 +0100 (CET)
Date: Sat, 14 Feb 2026 12:29:54 +0100 (CET)
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
Subject: Re: [PATCH 3/8] hw/m68k/q800: Use MacFbMode fields in
 q800_machine_init()
In-Reply-To: <20260214021240.58657-4-philmd@linaro.org>
Message-ID: <e4af27a4-08b9-97a4-b775-1a8db71a234c@eik.bme.hu>
References: <20260214021240.58657-1-philmd@linaro.org>
 <20260214021240.58657-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-985540205-1771068594=:43665"
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

--3866299591-985540205-1771068594=:43665
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 14 Feb 2026, Philippe Mathieu-Daudé wrote:
> Once the Mac Frame Buffer device is realized on the NuBus,
> its MacFbMode might be different of the global graphic_depth
> and graphic_width globals. Prefer the device MacFbMode fields
> to initialize the BootInfo structure.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> hw/m68k/q800.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index 4767eb4298f..b55c03a90bf 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -605,9 +605,9 @@ static void q800_machine_init(MachineState *machine)
>         BOOTINFO2(param_ptr, BI_MEMCHUNK, 0, ram_size);
>         BOOTINFO1(param_ptr, BI_MAC_VADDR,
>                   VIDEO_BASE + macfb_mode->offset);
> -        BOOTINFO1(param_ptr, BI_MAC_VDEPTH, graphic_depth);
> +        BOOTINFO1(param_ptr, BI_MAC_VDEPTH, macfb_mode->depth);
>         BOOTINFO1(param_ptr, BI_MAC_VDIM,
> -                  (graphic_height << 16) | graphic_width);
> +                  (graphic_height << 16) | macfb_mode->width);
>         BOOTINFO1(param_ptr, BI_MAC_VROW, macfb_mode->stride);
>         BOOTINFO1(param_ptr, BI_MAC_SCCBASE, SCC_BASE);

I know nothing about this but the idea is to let the user override 
graphics resolution via the command line. Would this break that?

Regards,
BALATON Zoltan
--3866299591-985540205-1771068594=:43665--

