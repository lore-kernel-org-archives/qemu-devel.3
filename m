Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F26D18130
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 16:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0OD0-00006E-EF; Mon, 14 Oct 2024 12:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1t0OCx-0008Vr-SA
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 12:46:11 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1t0OCw-000295-3Q
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 12:46:11 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7733D4E6013;
 Mon, 14 Oct 2024 18:46:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Rp2QQhOk1b2r; Mon, 14 Oct 2024 18:46:02 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 83F514E6004; Mon, 14 Oct 2024 18:46:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 82860746F60;
 Mon, 14 Oct 2024 18:46:02 +0200 (CEST)
Date: Mon, 14 Oct 2024 18:46:02 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: qemu-devel@nongnu.org, philmd@linaro.org
Subject: Re: [PATCH 2/2] log: Suggest using -d guest_error,memaccess instead
 of guest_errors
In-Reply-To: <CAFEAcA_1ejDprH6H=EPoP59jweUkuaZR_mcuNhhGFmDiQBNKMg@mail.gmail.com>
Message-ID: <33dcb2dc-8dfd-422e-ffc8-3858d7da2d92@eik.bme.hu>
References: <cover.1728232526.git.balaton@eik.bme.hu>
 <0f5949d8ece522e30f990d25981f79965bf05bbf.1728232526.git.balaton@eik.bme.hu>
 <CAFEAcA_1ejDprH6H=EPoP59jweUkuaZR_mcuNhhGFmDiQBNKMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Mon, 14 Oct 2024, Peter Maydell wrote:
> On Sun, 6 Oct 2024 at 17:49, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>
>> Rename guest_errors to guest_error to match the log constant
>
> I don't think this is a good reason to change the user-facing
> behaviour. Also, I don't think the existing names are so bad:
>
> -d guest_errors
>   this is plural because we are asking to log all guest errors
> qemu_log_mask(LOG_GUEST_ERROR, ...)
>   this is singular because we are logging a single error here.
>
> If we do want to change things for consistency, we should decide
> on what the user-facing option name ought to be (and I think
> plural is fine), and then change the internal define to match
> that, not vice versa.

The point of this patch is not to match the define with the option. 
Originally I had a patch that just separated memory access logs and left 
guest_errors as it is but without the memory access logs. But I think 
Philippe said that he likes this option to log both. So to satisfy all 
needs I'v added this patch to preserve what guest_errors is doing now but 
let it be changed later after some time for people to get used to it (or 
leave it if that's what people like). Leaving guest_errors to log both is 
not an option as I want to have separate options for memory access and 
guest errors so they can be turned on or off independently. So if we have 
to keep guest_errors to log both then we need a new option for just guest 
errors for which one that matches the definen seemed like an easy way that 
is consistent with the other debug options. I'd be OK to leave 
guest_errors but without the memory access logs, then this patch is not 
needed but some people did not like that before.

Regards,
BALATON Zoltan

>> and print
>> a warning for -d guest_errors to remind using guest_error,memaccess
>> instead but preserve previous behaviour for convenience.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>
> thanks
> -- PMM
>
>

