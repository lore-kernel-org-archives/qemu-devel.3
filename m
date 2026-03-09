Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9FEF3C24C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzaR8-0008EB-St; Mon, 09 Mar 2026 09:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzaQx-0008Cr-Ck
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:14:08 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzaQr-0000hZ-He
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:14:04 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 31A705969E5;
 Mon, 09 Mar 2026 14:13:59 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Y4Q7AfnStpT1; Mon,  9 Mar 2026 14:13:54 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C7B265969ED; Mon, 09 Mar 2026 14:13:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C5EBC5969E5;
 Mon, 09 Mar 2026 14:13:54 +0100 (CET)
Date: Mon, 9 Mar 2026 14:13:54 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 marcandre.lureau@redhat.com, Chad Jablonski <chad@jablonski.xyz>
Subject: Re: [PATCH v12 0/9] ati-vga: Implement HOST_DATA transfers to enable
 X.org text rendering
In-Reply-To: <4afcf7e0-5ff0-49c3-9f5c-965454737550@linaro.org>
Message-ID: <b0f48520-08f6-be11-db53-2b7481c76594@eik.bme.hu>
References: <cover.1773020351.git.balaton@eik.bme.hu>
 <4afcf7e0-5ff0-49c3-9f5c-965454737550@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-357581170-1773062027=:23253"
Content-ID: <323ac77a-5d70-1470-9e09-e5951a982e9b@eik.bme.hu>
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

--3866299591-357581170-1773062027=:23253
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <f1124162-f517-0cda-127e-204a48eee97a@eik.bme.hu>

On Mon, 9 Mar 2026, Philippe Mathieu-Daudé wrote:
> On 9/3/26 02:47, BALATON Zoltan wrote:
>> Changes from v11:
>> - Drop already merged patches in [PULL 00/49] Misc HW patches for 
>> 2026-03-08
>> Based-on: 20260308223433.25503-1-philmd@linaro.org
>
> This didn't apply on this tag:
>
> Applying: ati-vga: Remove src and dst stride mutation in ati_2d_blt
> Applying: ati-vga: Use local variables for register values in ati_2d_blt
> Applying: ati-vga: Introduce ATI2DCtx struct for 2D blit context
> Patch failed at 0003 ati-vga: Introduce ATI2DCtx struct for 2D blit context
> error: patch failed: hw/display/ati_2d.c:43
> error: hw/display/ati_2d.c: patch does not apply
>
> But I figured it out (minor checkpatch change).

Checkpatch did not complain to me before but there seem to have been a 
white space change in you pull request. I noticed that now and sent v13 
for that patch but looks like you were faster. Thanks a lot again for your 
help.

> Series queued, thanks.
>
>> - Fix build without pixman
>> 
>> Chad Jablonski (9):
>>    ati-vga: Remove src and dst stride mutation in ati_2d_blt
>>    ati-vga: Use local variables for register values in ati_2d_blt
>>    ati-vga: Introduce ATI2DCtx struct for 2D blit context
>>    ati-vga: Extract setup_2d_blt_ctx from ati_2d_blt
>>    ati-vga: Split ati_2d_do_blt from ati_2d_blt
>>    ati-vga: Remove ATIVGAState param from ati_2d_do_blt
>>    ati-vga: Implement scissor rectangle clipping for 2D operations
>>    ati-vga: Implement HOST_DATA register writes
>>    ati-vga: Implement HOST_DATA flush to VRAM

There was the other two patch series to fix guest_hwcursor will you queue 
that too?

Regards,
BALATON Zoltan
--3866299591-357581170-1773062027=:23253--

