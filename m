Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BDCF46112
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4fVl-0005PM-RI; Mon, 23 Mar 2026 09:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w4fVi-0005OU-EY
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:40:02 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w4fVf-0003b1-Ld
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:40:01 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0ECD25969E6;
 Mon, 23 Mar 2026 14:39:58 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id QMTrKXHaJOyk; Mon, 23 Mar 2026 14:39:55 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A3FF25969E4; Mon, 23 Mar 2026 14:39:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A269A5968DD;
 Mon, 23 Mar 2026 14:39:55 +0100 (CET)
Date: Mon, 23 Mar 2026 14:39:55 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 marcandre.lureau@redhat.com, Chad Jablonski <chad@jablonski.xyz>
Subject: Re: [PATCH v6 7/8] ati-vga: Simplify pointer image handling
In-Reply-To: <b2895a1f-237e-4f9d-92dc-efa2ea747913@linaro.org>
Message-ID: <0415a314-d8ea-06f8-ad56-75c2524e76e1@eik.bme.hu>
References: <cover.1774110169.git.balaton@eik.bme.hu>
 <b9de530074b954d661a0eb9b8b4ad82a66085456.1774110169.git.balaton@eik.bme.hu>
 <7bb33f6d-8ff8-48d0-bc96-cea8cbd165ae@linaro.org>
 <b2895a1f-237e-4f9d-92dc-efa2ea747913@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1052141874-1774273195=:72485"
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

--3866299591-1052141874-1774273195=:72485
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 23 Mar 2026, Philippe Mathieu-Daudé wrote:
> On 23/3/26 13:21, Philippe Mathieu-Daudé wrote:
>> On 21/3/26 17:30, BALATON Zoltan wrote:
>>> Rewrite reading of mouse pointer image. I am not sure this is entirely
>>> correct but appears to work at least on little endian host with PPC
>>> guests using little or big endian frame buffer (MorphOS and MacOS) but
>>> still produces broken pointer image with Linux where I am not sure if
>>> it is a guest driver bug or still missing something.
>>> 
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>>   hw/display/ati.c | 53 ++++++++++++++++++++++--------------------------
>>>   1 file changed, 24 insertions(+), 29 deletions(-)
>
>
>>> @@ -197,9 +194,9 @@ static void ati_cursor_invalidate(VGACommonState *vga)
>>>   static void ati_cursor_draw_line(VGACommonState *vga, uint8_t *d, int 
>>> scr_y)
>>>   {
>>>       ATIVGAState *s = container_of(vga, ATIVGAState, vga);
>>> -    uint32_t srcoff;
>>> +    uint32_t h, srcoff, color;
>>> +    uint64_t abits, xbits, mask;
>>>       uint32_t *dp = (uint32_t *)d;
>>> -    int i, j, h, idx = 0;
>>>       if (!(s->regs.crtc_gen_cntl & CRTC2_CUR_EN) ||
>>>           scr_y < vga->hw_cursor_y || scr_y >= vga->hw_cursor_y + 64 ||
>>> @@ -210,26 +207,24 @@ static void ati_cursor_draw_line(VGACommonState 
>>> *vga, uint8_t *d, int scr_y)
>>>       srcoff = s->cursor_offset + (scr_y - vga->hw_cursor_y) * 16;
>>>       dp = &dp[vga->hw_cursor_x];
>>>       h = ((s->regs.crtc_h_total_disp >> 16) + 1) * 8;
>>> -    for (i = 0; i < 8; i++) {
>>> -        uint32_t color;
>>> -        uint8_t abits = vga_read_byte(vga, srcoff + i);
>>> -        uint8_t xbits = vga_read_byte(vga, srcoff + i + 8);
>>> -        for (j = 0; j < 8; j++, abits <<= 1, xbits <<= 1, idx++) {
>>> -            if (vga->hw_cursor_x + idx >= h) {
>>> -                return; /* end of screen, don't span to next line */
>>> -            }
>>> -            if (abits & BIT(7)) {
>>> -                if (xbits & BIT(7)) {
>>> -                    color = dp[idx] ^ 0xffffffff; /* complement */
>>> -                } else {
>>> -                    continue; /* transparent, no change */
>>> -                }
>>> +    abits = ldq_be_p(&vga->vram_ptr[srcoff]);
>>> +    xbits = ldq_be_p(&vga->vram_ptr[srcoff + 8]);
>>> +    mask = BIT(63);
>> 
>> This triggers:
>> 
>> In file included from include/qemu/timer.h:4,
>>                   from ../hw/display/ati_int.h:12,
>>                   from ../hw/display/ati.c:20:
>> ../hw/display/ati.c: In function 'ati_cursor_draw_line':
>> include/qemu/bitops.h:24:38: error: left shift count >= width of type [- 
>> Werror=shift-count-overflow]
>>     24 | #define BIT(nr)                 (1UL << (nr))
>>        |                                      ^~
>> ../hw/display/ati.c:217:12: note: in expansion of macro 'BIT'
>>    217 |     mask = BIT(63);
>>        |            ^~~
>
> BTW you can check that yourself by running our CI jobs on GitLab
> (https://www.qemu.org/docs/master/devel/testing/ci.html).
>
> This is the output of the 'cross-win64-system' job:
> https://gitlab.com/philmd/qemu/-/jobs/13605781786

I find Gitlab to be very inconvenient to use so I avoided it so far. If 
needed I can try but I could do without it.

Regards,
BALATON Zoltan
--3866299591-1052141874-1774273195=:72485--

