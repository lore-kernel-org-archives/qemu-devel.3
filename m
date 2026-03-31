Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE6E109B467
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7ZOd-0003DL-GU; Tue, 31 Mar 2026 09:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w7ZOK-0002tN-HJ
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:44:25 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w7ZOH-0000Yo-IH
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:44:24 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 62546596A1D;
 Tue, 31 Mar 2026 15:44:18 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id oW-cbBo8E-7U; Tue, 31 Mar 2026 15:44:16 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5BFE25969F2; Tue, 31 Mar 2026 15:44:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5A2355969EC;
 Tue, 31 Mar 2026 15:44:16 +0200 (CEST)
Date: Tue, 31 Mar 2026 15:44:16 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 marcandre.lureau@redhat.com, Chad Jablonski <chad@jablonski.xyz>, 
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/2] ati-vga: Silence warning about operator precedence
In-Reply-To: <29055103-a354-4079-88fa-ee239a3aa2ef@linaro.org>
Message-ID: <d7da2429-ebbd-c14c-15e4-f6fc70f6bebd@eik.bme.hu>
References: <cover.1774904832.git.balaton@eik.bme.hu>
 <24161ec41f118ad097387f8a84897dee7b4747b8.1774904832.git.balaton@eik.bme.hu>
 <29055103-a354-4079-88fa-ee239a3aa2ef@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1636160200-1774964656=:7804"
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

--3866299591-1636160200-1774964656=:7804
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 31 Mar 2026, Philippe Mathieu-Daudé wrote:
> On 30/3/26 23:09, BALATON Zoltan wrote:
>> Coverity in CID 1645969 warns about possible operator precendence
>> issue which is a false positive in this case but simplify the
>> expression to silence the warning.
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/display/ati_2d.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
>> index 23527b2c50..9baf6ff37b 100644
>> --- a/hw/display/ati_2d.c
>> +++ b/hw/display/ati_2d.c
>> @@ -91,7 +91,7 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, 
>> ATI2DCtx *ctx)
>>       ctx->host_data_active = s->host_data.active;
>>       ctx->left_to_right = s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT;
>>       ctx->top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM;
>> -    ctx->need_swap = HOST_BIG_ENDIAN != s->vga.big_endian_fb ? true : 
>> false;
>> +    ctx->need_swap = (HOST_BIG_ENDIAN != s->vga.big_endian_fb);
>
> Do we really need the parenthesis?

Should not be needed but it may be more readable and Coverity warned about 
the original that did not need parenthesis either so it seems the safest 
to write it this way.

Regards,
BALATON Zoltan

>>       ctx->frgd_clr = s->regs.dp_brush_frgd_clr;
>>       ctx->palette = s->vga.palette;
>>       ctx->dst_offset = s->regs.dst_offset;
>
>
--3866299591-1636160200-1774964656=:7804--

