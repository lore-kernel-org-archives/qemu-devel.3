Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D917FEC0FC
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 20:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w58Ft-000178-3T; Tue, 24 Mar 2026 16:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w58Fq-00016i-Fi
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 16:21:34 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w58Fm-0008Sf-Si
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 16:21:34 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D1F16596A44;
 Tue, 24 Mar 2026 21:21:27 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id pAVLMfn4y14k; Tue, 24 Mar 2026 21:21:25 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 96CCD596A41; Tue, 24 Mar 2026 21:21:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 95139596A13;
 Tue, 24 Mar 2026 21:21:25 +0100 (CET)
Date: Tue, 24 Mar 2026 21:21:25 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Subject: Re: [PULL 17/27] ati-vga: Fix colors when frame buffer endianness
 does not match host
In-Reply-To: <CAFEAcA-SKjjEyYVi0myBa9akLJJpV9auPxrNmzU=wL=CK-RAaQ@mail.gmail.com>
Message-ID: <f27a7976-0f30-bf15-5f1e-d534ad6d80a9@eik.bme.hu>
References: <20260323165218.96607-1-philmd@linaro.org>
 <20260323165218.96607-18-philmd@linaro.org>
 <CAFEAcA-SKjjEyYVi0myBa9akLJJpV9auPxrNmzU=wL=CK-RAaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-667510134-1774383529=:10667"
Content-ID: <9a70efd6-8384-94b6-4906-2f5fc0d58f97@eik.bme.hu>
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--3866299591-667510134-1774383529=:10667
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <4bfb7ebf-020a-757b-5a38-2825098502a4@eik.bme.hu>

On Tue, 24 Mar 2026, Peter Maydell wrote:
> On Mon, 23 Mar 2026 at 16:54, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> From: BALATON Zoltan <balaton@eik.bme.hu>
>>
>> When writing pixels we have to take into account if the frame buffer
>> endianness matches the host endianness or we need to swap to correct
>> endianness. This caused wrong colors e.g. with PPC Linux guest that
>> uses big endian frame buffer when running on little endian host.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Tested-by: Chad Jablonski <chad@jablonski.xyz>
>> Reviewed-by: Chad Jablonski <chad@jablonski.xyz>
>> Message-ID: <759ed5e3b019cce94e9a4ef003f1fc2e0cea2ec1.1774110169.git.balaton@eik.bme.hu>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>
> Hi; Coverity flags this as possibly-wrong code (CID 1645969:

You probably meant to cc me too but now I'm registered for QEMU in 
coverity as well so I got the warning too.

>> @@ -89,6 +90,7 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2DCtx *ctx)
>>      ctx->host_data_active = s->host_data.active;
>>      ctx->left_to_right = s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT;
>>      ctx->top_to_bottom = s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM;
>> +    ctx->need_swap = HOST_BIG_ENDIAN != s->vga.big_endian_fb ? true : false;
>
> The issue is that != is higher priority than ?:, and people often
> write "X != A ? B : C" when they wanted "X != (A ? B : C)" but they
> get "(X != A) ? B : C". Either way, using parentheses helps clarify
> for readers.
>
> The priority is actually right for this particular case, but the

Yes I omitted the parenthesis as it's not needed here but will include it 
in the future.

> expression is unnecessarily complex: we could write more simply:
>
>  ctx->need_swap = (HOST_BIG_ENDIAN != s->vga.big_endian_fb);

I thought about that but too late and did not want to redo the series. 
I'll send a patch and check the other issue reported as well if it's a 
problem or can be avoided.

> I've marked the issue in Coverity as false-positive, but we might
> consider changing the code also.

Thank you,
BALATON Zoltan
--3866299591-667510134-1774383529=:10667--

