Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29BB606A33F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 22:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUWnd-0005Yt-JE; Fri, 20 Nov 2026 17:09:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xUWnZ-0005Wx-Ct
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 17:09:38 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xUWnX-0003FJ-DT
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 17:09:37 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E7F8360E017;
 Fri, 20 Nov 2026 23:09:29 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id IufqfFvxp0Fn; Fri, 20 Nov 2026 23:09:27 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CC18060CCE7; Fri, 20 Nov 2026 23:09:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CA17313C28F;
 Fri, 20 Nov 2026 23:09:27 +0100 (CET)
Date: Fri, 20 Nov 2026 23:09:27 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Fam Zheng <fam@euphon.net>, Keith Monahan <keith@techtravels.org>
Subject: Re: [RFC PATCH-for-11.2 v4 00/14] nc53c710 rewrite
In-Reply-To: <dfbbba97-a182-4f5e-acd1-c962285ff463@oss.qualcomm.com>
Message-ID: <6f9167e0-f043-8d36-42aa-a99201010b3a@eik.bme.hu>
References: <20261120171235.61325-1-philmd@oss.qualcomm.com>
 <dfbbba97-a182-4f5e-acd1-c962285ff463@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-628162528-1795212567=:80696"
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-628162528-1795212567=:80696
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 20 Nov 2026, Philippe Mathieu-Daudé wrote:
> On 20/11/26 18:12, Philippe Mathieu-DaudÃ© wrote:
>> Fourth attempt to replace the existing 53c710 driver by
>> a new driver based on the code of the lsi53c895a.c :)
>> 
>> Used LLM to decompose v3 as logical / atomic changes when
>> possible (didn't work well with the rewrite patch).
>> 
>> Fixes extracted first so could be merged for v11.2 (patches
>> 1 to 5). The rest is the rewrite, so up to the maintainers
>> (Helge, Mark) and is probably OK as hobbyist-only code.
>> 
>> Since v3:
>> - header split, Suggested-by tag (Zoltan)
>> - I couldn't figure the "hw/misc/lasi.c" change so dropped
>>    the comment about it.
>> - Dropped "move to COMMAND on CLEAR ACK after MESSAGE REJECT"
>> - Split rewrite patch as separated commits:
>>     - base engine
>>     - asynchronous completions
>>     - synchronous drain
>>     - HP-UX MESSAGE REJECT quirk
>>     - reentrancy guard and reset-time request cancel
>> 
>> hw/scsi/ncr53c710.c is derived from hw/scsi/lsi53c895a.c which
>> is LGPL, the rewrite is now declared GPL-2.0-or-later.
>> hw/scsi/lsi_scsi.h, which is moved verbatim from lsi53c895a.c,
>> keeps the original terms: its header says "This code is licensed
>> under the LGPL." with SPDX-License-Identifier: LGPL-2.1-or-later.
>> 
>> Series reviewed against the NCR 53C710 data manual but totally
>> untested (I don't have guest code to run), thus compile-checked
>> only. I haven't tested whether the series is bisectable.
>
> This is only a split experiment if Helge/Keith/Mark/Zoltan want
> to pursue, I'm not going to respin.

This helps reviewing but not perfect yet so if nobody is going to take it 
and make a v2 then it's a dead end. I added some comments nevertheless if 
somebody can do something about that.

Regards,
BALATON Zoltan

>> Keith Monahan (9):
>>    hw/scsi/scsi-disk: Add quirk_mode_page_no_flexible_disk, use it on the
>>      715
>>    hw/scsi: Move shared LSI/NCR definitions to lsi_scsi.h
>>    hw/scsi/ncr53c710: Rewrite the 53C710 SCRIPTS engine
>>    hw/scsi/ncr53c710: Deliver completions from bottom halves
>>    hw/scsi/ncr53c710: Drain asynchronous transfers in the register write
>>    hw/scsi/ncr53c710: Append SAVE DATA POINTERS after MESSAGE REJECT for
>>      HP-UX
>>    hw/scsi/ncr53c710: Guard SCRIPTS reentrancy and cancel requests on
>>      soft reset
>>    hw/scsi/lasi_ncr710: Map the full LASI SCSI module page
>>    hw/scsi/ncr53c710: Bump the migration version
>> 
>> Philippe Mathieu-Daudé (5):
>
> Oops here author should be Keith Monahan?
>
>>    hw/scsi/ncr53c710: Cancel the in-flight request on soft reset
>>    hw/scsi/ncr53c710: Do not load SBCL from DBC after a SCRIPTS phase
>>      move
>>    hw/scsi/lasi_ncr710: Limit max_target and max_lun to 7
>>    hw/scsi/ncr53c710: Keep DCNTL.EA and DMODE.FC1 across an ISTAT.RST
>>      reset
>>    hw/scsi/ncr53c710: Document the SIGP latch deviation
>
>
--3866299591-628162528-1795212567=:80696--

