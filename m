Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EE2D711D2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 01:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWP4j-0000E9-JY; Thu, 18 Dec 2025 20:14:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vWP4f-0000DY-96; Thu, 18 Dec 2025 20:14:30 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vWP4c-0000FS-3U; Thu, 18 Dec 2025 20:14:28 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3BC15596A3F;
 Fri, 19 Dec 2025 02:14:20 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id whChqbyBlYtu; Fri, 19 Dec 2025 02:14:18 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3B1C4596A10; Fri, 19 Dec 2025 02:14:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 38D525969FB;
 Fri, 19 Dec 2025 02:14:18 +0100 (CET)
Date: Fri, 19 Dec 2025 02:14:18 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 qemu-rust@nongnu.org, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 3/6] hw/display/ati: Access host memory as
 little-endian
In-Reply-To: <20251218181812.58363-4-philmd@linaro.org>
Message-ID: <1cdc2735-d9e0-27c1-90e3-e250bb73cad6@eik.bme.hu>
References: <20251218181812.58363-1-philmd@linaro.org>
 <20251218181812.58363-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-506663333-1766106858=:43259"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-506663333-1766106858=:43259
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 18 Dec 2025, Philippe Mathieu-Daudé wrote:
> ati_2d.c is part of the ATI_VGA component, being built with
> the hw/display/ati.c file. Commit 339534d4025 ("ati-vga: Fix
> indexed access to video memory") made access to host memory
> using little-endian order. Assume the same order is used for
> the 2D component.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> hw/display/ati_2d.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 309bb5ccb6c..72fde6b8008 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -221,7 +221,7 @@ void ati_2d_blt(ATIVGAState *s)
>             for (y = 0; y < s->regs.dst_height; y++) {
>                 i = dst_x * bypp + (dst_y + y) * dst_pitch;
>                 for (x = 0; x < s->regs.dst_width; x++, i += bypp) {
> -                    stn_he_p(&dst_bits[i], bypp, filler);
> +                    stn_le_p(&dst_bits[i], bypp, filler);

I don't think this is correct as it would swap filler and thus break 
colors. This should just write the value as it is to dst_bits[i] location 
so if you want to remove stn_he_n then maybe inline it and make it a 
switch that casts to the right size and assigns the value. The stn_he_p is 
just used here as a short form instead of that switch.

Regards,
BALATON Zoltan

>                 }
>             }
>         }
>
--3866299591-506663333-1766106858=:43259--

