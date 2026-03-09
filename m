Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51423EA8549
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 01:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzPq6-0001Wh-Hd; Sun, 08 Mar 2026 21:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzPq3-0001WR-4J
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 21:55:19 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vzPpz-0002H7-Ns
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 21:55:18 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D58F55966F4;
 Mon, 09 Mar 2026 02:55:13 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id JCqCdx6jkSZI; Mon,  9 Mar 2026 02:55:11 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1E7F35969E8; Mon, 09 Mar 2026 02:55:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1BA265969E7;
 Mon, 09 Mar 2026 02:55:11 +0100 (CET)
Date: Mon, 9 Mar 2026 02:55:11 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: Chad Jablonski <chad@jablonski.xyz>, qemu-devel@nongnu.org, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v11 00/17] ati-vga: Implement HOST_DATA transfers to
 enable X.org text rendering
In-Reply-To: <cff2726a-f4c0-e8b0-83b2-00727196b12a@eik.bme.hu>
Message-ID: <994345a2-9258-75bf-c669-29555373f7c0@eik.bme.hu>
References: <20260303024730.1489136-1-chad@jablonski.xyz>
 <a04c9f47-d371-4e78-93cd-7798b804f237@linaro.org>
 <cff2726a-f4c0-e8b0-83b2-00727196b12a@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-152344451-1773021311=:18519"
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

--3866299591-152344451-1773021311=:18519
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 9 Mar 2026, BALATON Zoltan wrote:
> On Sun, 8 Mar 2026, Philippe Mathieu-Daudé wrote:
>> Hi Chad,
>> 
>> On 3/3/26 03:47, Chad Jablonski wrote:
>>> This series implements HOST_DATA as a blit source enabling text rendering 
>>> in
>>> xterm under X.org with 2D acceleration.
>>> 
>>> The series builds up functionality incrementally:
>>> 
>>> * Patches   1-6:  Bug fixes and register implementations
>>> * Patches  7-14:  Refactor of ati_2d_blt to decouple from ATIVGAState
>>> * Patch      15:  Scissor clipping implementation
>>> * Patches 16-17:  HOST_DATA register writes, color expansion, and
>>>                    accumulator flush
>> 
>> 
>>> Chad Jablonski (17):
>>>    ati-vga: Fix framebuffer mapping by using hardware-correct aperture
>>>      sizes
>>>    ati-vga: Fix DST_PITCH and SRC_PITCH reads
>>>    ati-vga: Read aliased values from DP_GUI_MASTER_CNTL
>>>    ati-vga: Latch src and dst pitch and offset on master_cntl default
>>>    ati-vga: Implement foreground and background color register writes
>>>    ati-vga: Add scissor clipping register support
>>>    ati-vga: Remove dst_x/y updates after blit
>>>    ati-vga: Consolidate dirty region tracking in ati_2d_blt
>>>    ati-vga: Remove src and dst stride mutation in ati_2d_blt
>>>    ati-vga: Use local variables for register values in ati_2d_blt
>>>    ati-vga: Introduce ATI2DCtx struct for 2D blit context
>>>    ati-vga: Extract setup_2d_blt_ctx from ati_2d_blt
>>>    ati-vga: Split ati_2d_do_blt from ati_2d_blt
>>>    ati-vga: Remove ATIVGAState param from ati_2d_do_blt
>>>    ati-vga: Implement scissor rectangle clipping for 2D operations
>>>    ati-vga: Implement HOST_DATA register writes
>>>    ati-vga: Implement HOST_DATA flush to VRAM
>> 
>> Zoltan asked me to look at your series [*] but unfortunately I'm
>> getting a build failure when building without PIXMAN starting
>> with patch #9:
>> 
>> ../hw/display/ati_2d.c: In function ‘ati_2d_do_blt’:
>> ../hw/display/ati_2d.c:185:13: error: unused variable ‘src_stride_words’ 
>> [-Werror=unused-variable]
>>  185 |         int src_stride_words = ctx->src_stride / sizeof(uint32_t);
>>      |             ^~~~~~~~~~~~~~~~
>> ../hw/display/ati_2d.c:147:9: error: unused variable ‘dst_stride_words’ 
>> [-Werror=unused-variable]
>>  147 |     int dst_stride_words = ctx->dst_stride / sizeof(uint32_t);
>>      |         ^~~~~~~~~~~~~~~~
>> ../hw/display/ati_2d.c:137:10: error: unused variable ‘use_pixman_blt’ 
>> [-Werror=unused-variable]
>>  137 |     bool use_pixman_blt = use_pixman & BIT(1);
>>      |          ^~~~~~~~~~~~~~
>> ../hw/display/ati_2d.c:136:10: error: unused variable ‘use_pixman_fill’ 
>> [-Werror=unused-variable]
>>  136 |     bool use_pixman_fill = use_pixman & BIT(0);
>>      |          ^~~~~~~~~~~~~~~
>> 
>> I'm queueing the first 8 patches hoping it helps.
>> 
>> Also, please fix the checkpatch.pl coding style errors
>> before re-posting.
>
> Sorry, my mistake I did not notice this during review and testing. I'm fixing 
> it up and will send updated version of the last part of the series not yet 
> queued. Thanks a lot for your help.

I sent updated v12 fixing the above. Before that I've also sent this small 
fix independent of this series:
https://patchew.org/QEMU/cover.1773009887.git.balaton@eik.bme.hu/

Thank you,
BALATON Zoltan
--3866299591-152344451-1773021311=:18519--

