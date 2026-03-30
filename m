Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13EAB1061B13
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 16:11:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7FCb-00080i-MA; Mon, 30 Mar 2026 12:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w7FCV-00080D-Jv; Mon, 30 Mar 2026 12:10:52 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w7FCS-0006MQ-G9; Mon, 30 Mar 2026 12:10:51 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8A1885969F3;
 Mon, 30 Mar 2026 18:10:44 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id wke83UrilpTp; Mon, 30 Mar 2026 18:10:42 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7D7975969F2; Mon, 30 Mar 2026 18:10:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7BB155969EC;
 Mon, 30 Mar 2026 18:10:42 +0200 (CEST)
Date: Mon, 30 Mar 2026 18:10:42 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Subject: Re: [PATCH] hw/display/vga: Fix debug message
In-Reply-To: <87ecl1perz.fsf@draig.linaro.org>
Message-ID: <6c3214ac-1679-d9db-2fed-c934fde8ddf2@eik.bme.hu>
References: <20260330140656.46FE55969F2@zero.eik.bme.hu>
 <87ecl1perz.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-268457526-1774887042=:9391"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--3866299591-268457526-1774887042=:9391
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 30 Mar 2026, Alex Bennée wrote:
> BALATON Zoltan <balaton@eik.bme.hu> writes:
>
>> Fixes: f9b925fd41 vga: introduce VGADisplayParams
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  hw/display/vga.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/display/vga.c b/hw/display/vga.c
>> index ee7d97b5c2..26039f0020 100644
>> --- a/hw/display/vga.c
>> +++ b/hw/display/vga.c
>> @@ -1662,7 +1662,7 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
>>
>>  #if 0
>>      printf("w=%d h=%d v=%d line_offset=%d cr[0x09]=0x%02x cr[0x17]=0x%02x linecmp=%d sr[0x01]=0x%02x\n",
>> -           width, height, v, line_offset, s->cr[9], s->cr[VGA_CRTC_MODE],
>> +           width, height, v, s->params.line_offset, s->cr[9], s->cr[VGA_CRTC_MODE],
>>             s->params.line_compare, sr(s, VGA_SEQ_CLOCK_MODE));
>>  #endif
>>      addr1 = (s->params.start_addr * 4);
>
> Really it would be worth just deleting the #if 0 code - if it's really
> useful for debugging you could turn it into a tracepoint.
>
> There are a bunch of other #if 0/#if DEBUG_* statements that could also
> be dumped/modernised.

Yes, it's useful for debugging (I used it to test frame buffer endianness) 
so probably should not be deleted. No, I don't want to overhaul and 
modernise the whole device and convert everything to trace points because 
as you say there's a bunch of those. So for now I just left it as it is 
and fixed the typo in it. I don't intend to do more work on this.

Regards,
BALATON Zoltan
--3866299591-268457526-1774887042=:9391--

