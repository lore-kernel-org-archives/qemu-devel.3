Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 417C1C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 21:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfOen-0001Vr-9x; Thu, 02 Jul 2026 17:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.vouylkrj3or46p0=bezyi0gcm5hq=40abjb5w22wyql@em1175899.techtravels.org>)
 id 1wfOem-0001RW-2E
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 17:09:12 -0400
Received: from a3i384.smtp2go.com ([203.31.37.128])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.vouylkrj3or46p0=bezyi0gcm5hq=40abjb5w22wyql@em1175899.techtravels.org>)
 id 1wfOeh-0000t6-O9
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 17:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=techtravels.org;
 i=@techtravels.org; q=dns/txt; s=s1175899; t=1783026490; h=from :
 subject : to : message-id : date;
 bh=YxUm2T+xScjE0VuExFQAlzbJexfZc3UX7cvYFdfJy5s=;
 b=aMIihZgSkQSafx0/B2keRyQ7ff0npVVj0HXXhOFOtE2/1hABAhCgrQKKljqfGp5YZ54ug
 tmogAWm2cgx74srsGIlxNQ6tcEaQJdos8ey7wwM54LUCbQthkYSbwvKsv+byk2a2wRdMWQK
 ld7snxOLgb7Nkf82dZmDnOK9oElPQEknBm6EIKE3Wt2G5wJZLT+Z5XkWGoZgQo+t+6WAPQx
 CbtLQxLMO/8GvB5v4jn3DMAUstGLr09bmJNKRHirSyUlVfKPunTEskw3JAzKAUMW/dVbW01
 XJuND13DnvS36pIKZskM2Z7mesNW629HI0j4n2AQm2PH4Jt4JlBvQaxEQmvQ==
Received: from [10.91.249.253] (helo=boxtwo.techtravels.org)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.99.4) (envelope-from <keith@techtravels.org>)
 id 1wfOdi-FnQW0hPvJnx-k735; Thu, 02 Jul 2026 21:08:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=techtravels.org;
 s=mail; t=1783026485;
 bh=NIBu+Fy8FN9C7zv7HlUMlNxvsAuJXq17xXLwn2WOfqw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=cMIzyJX1WDc7qXkCy8op1WCHLOjqWTyUyO76GApm/Sk5EiEyuk5NFSkbnfoF14MAw
 +XpEs2KVNidWg9x52ik431iZ8YNXLJpHIQ46J4odLuAMWdui25X0FaXc8P/p/coX9d
 bgaM6MtrakyVCwngvpmg7CENjdXxGhcEuutruzekIVmNV6gzJaXZmGdx8eNhTTUshU
 9m9pSzmM8KPMzOat8qKhyxH8JV1Q+I1SZrvIYvByrEAXmtsZFFZLg9szCogtAXt99I
 I9Wxy5zYJXiMlzfOB9yl0SJY1IR6na9mhdcMElvcUUMlC2+bGSEx3oSTw+h5ihDYyv
 YOpNia7TIwsAg==
Received: from authenticated-user (boxtwo.techtravels.org [54.196.37.146])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by boxtwo.techtravels.org (Postfix) with ESMTPSA id 504EF3F1AB;
 Thu,  2 Jul 2026 17:08:05 -0400 (EDT)
Message-ID: <cb26c50c-5445-4c07-8e01-7b5fa5ffed32@techtravels.org>
Date: Thu, 2 Jul 2026 17:08:05 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/4] hw/scsi/ncr53c710: rewrite the SCRIPTS engine
To: BALATON Zoltan <balaton@eik.bme.hu>, Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260701213359.1855870-1-keith@techtravels.org>
 <20260701213359.1855870-4-keith@techtravels.org>
 <17ed39f0-68e3-f931-2c50-936f5a07aa34@eik.bme.hu>
 <edecd56e-eb70-49bb-a45f-2d07ab85695e@gmx.de>
 <543f7dd7-74c9-c5c1-9fab-5eee55bcdce0@eik.bme.hu>
Content-Language: en-US
From: Keith Monahan <keith@techtravels.org>
In-Reply-To: <543f7dd7-74c9-c5c1-9fab-5eee55bcdce0@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 1175899m:1175899aieqF3d:1175899s5U9-VI9CJ
X-smtpcorp-track: 4s_QQqBHCaOI.d_nycUOobayo.DPhM3AwCOUM
Received-SPF: pass client-ip=203.31.37.128;
 envelope-from=bounce.vouylkrj3or46p0=bezyi0gcm5hq=40abjb5w22wyql@em1175899.techtravels.org;
 helo=a3i384.smtp2go.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Balaton,

I raised this in the v1 thread, but here it is again with more numbers.
Against ncr53c710.c's 1,243 significant lines, textually identical code
is 15.4 percent. If I first rename the symbols, lsi_ to ncr710_ and
LSIState to NCR710State, and then count every line that merely resembles
an 895 line, it reaches 32.8 percent. But that is a resemblance ceiling,
not a measure of code that can be cleanly factored out.

What actually matters for a refactor is how much could move into a
shared core without changing 895 behavior. I reviewed all 44 functions:
5.5 percent, about 58 lines, ten small helpers. In line counts, the gap
is the point: 32.8 percent looks like a shared core could absorb about
400 lines, but only about 58 come out cleanly. The rest is interleaved
line by line with the 710 differences: single byte interrupt model,
register map, big endian fetch, 24 bit DMA, and bottom half reselect.
Those differences live inside execute_script, reg_readb, and reg_writeb,
which are about half the file. Sharing that code means splitting every
hot path function or adding is_710 branches into the 895.

The macros make the same point, and they are worth calling out because
they are the first thing you see when you open the file. Of 102 macros
in the 710, only seven are identical to the 895, and those are just the
standard SCSI 2 bus phases. Another 38 match once you strip the prefix:
chip family register bit positions, the same value under a different
name. The 42 register offset macros are specific to the 710. So the most
visible overlap, that block of defines up top, is also the most trivial:
one liners, not logic. What you hit first is not representative of the
rest of the file, where the interpreters actually diverge!

So the genuinely shared code is about 12 to 15 percent, and the cleanly
factorable part is about 5 percent. I kept the models as siblings
because folding the interpreters together adds cross model coupling and
895 regression risk for very little deduplication.

My conclusion is the same as in my previous message, and the numbers
only make it firmer: the refactor work, the testing burden, and above
all the regression risk it forces onto lsi53c895a.c, a model that far
more guests and architectures depend on than this one, cannot be
justified by deduplicating roughly 5 percent of the file, the ~58 lines
that actually move cleanly.

That is trading real risk to a proven, widely used model for a cosmetic
win on code that is largely not duplicated to begin with. The 33 percent
resemblance figure does not change that, because none of that
resemblance is separable without cutting into the 895 hot path. I do not
think it is a good trade at any reading of the numbers.

Thanks,
Keith

On 7/2/2026 10:02 AM, BALATON Zoltan wrote:
> On Thu, 2 Jul 2026, Helge Deller wrote:
>> On 7/2/26 14:21, BALATON Zoltan wrote:
>>> On Wed, 1 Jul 2026, Keith Monahan wrote:
>>>> Replace the NCR 53C710 model with a SCRIPTS engine derived from QEMU's
>>>> LSI53C895A model (hw/scsi/lsi53c895a.c), another device in the same
>>>> NCR/LSI SCRIPTS family, adapted to the 53C710: its register map, the
>>>> single-byte DSTAT/SSTAT0 interrupt model, big-endian SCRIPTS and
>>>> table-indirect fetch (the part sits on the big-endian PA-RISC LASI 
>>>> bus),
>>>> and 24-bit DMA byte counts.  Behaviour follows the NCR 53C710 Data 
>>>> Manual
>>>> (Jun 1992) and Programmer's Guide (Oct 1990).
>>>>
>>>> The base engine supports connected I/O and reselection-interrupt
>>>> disconnect, enough to install and boot Debian off the 710 with the 
>>>> Linux
>>>> lasi700/53c700 driver and to boot NetBSD/hppa 9.4 and 10.1 (osiop) with
>>>> disk and CD-ROM enumeration.  Reselection follows the 53C700 family:
>>>> gated on the (re)selection interrupt enable (SIEN.SEL) alone, one-hot
>>>> SDID, and an SFBR id bitmask in 700-compatibility mode.  SDTR/WDTR/PPR
>>>> negotiation is declined with MESSAGE REJECT, which the 700-family 
>>>> drivers
>>>> require to proceed: unlike the 8xx parts they leave the target to drive
>>>> the phase after the reject.
>>>>
>>>> The LASI glue (hw/scsi/lasi_ncr710.c) embeds one NCR710State by value.
>>>> It gains the free_request SCSIBusInfo callback and request-queue 
>>>> init the
>>>> core needs, renames the reselection timer to scripts_timer, and narrows
>>>> the SCSI bus to the 8-bit inclusive maxima.
>>>>
>>>> The migration format is incompatible with the model this replaces, 
>>>> so the
>>>> vmstate version and minimum version are both raised.
>>>>
>>>> Signed-off-by: Keith Monahan <keith@techtravels.org>
>>>> ---
>>>> hw/scsi/lasi_ncr710.c |  117 +-
>>>> hw/scsi/lasi_ncr710.h |   12 +-
>>>> hw/scsi/ncr53c710.c   | 2795 +++++++++++++++--------------------------
>>>> hw/scsi/ncr53c710.h   |  276 ++--
>>>> hw/scsi/trace-events  |   43 +-
>>>> 5 files changed, 1191 insertions(+), 2052 deletions(-)
>>> [...]
>>>> diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
>>>> index 57967e7a84..57cd7d91a4 100644
>>>> --- a/hw/scsi/ncr53c710.c
>>>> +++ b/hw/scsi/ncr53c710.c
>>>> @@ -1,599 +1,308 @@
>>>> /*
>>>> - * QEMU NCR710 SCSI Controller
>>>> + * QEMU NCR 53C710 SCSI I/O Processor emulation
>>>>  *
>>>> - * Copyright (c) 2025 Soumyajyotii Ssarkar 
>>>> <soumyajyotisarkar23@gmail.com>
>>>> - * This driver was developed during the Google Summer of Code 2025 
>>>> program.
>>>> + * Copyright (c) 2026 Keith Monahan <keith@techtravels.org>
>>>> + * Copyright (c) 2006 CodeSourcery (lsi53c895a.c, written by Paul 
>>>> Brook)
>>>>  *
>>>> - * NCR710 SCSI Controller implementation
>>>> - * Based on the NCR53C710 Technical Manual Version 3.2, December 2000
>>>> + * A rewrite of the QEMU NCR 53C710 model.  The 53C710 is an early 
>>>> member of
>>>> + * the NCR/LSI SCRIPTS processor family, so the SCRIPTS engine here 
>>>> is derived
>>>> + * from QEMU's LSI53C895A model and adapted to the 53C710's 
>>>> register map,
>>>> + * single byte interrupt model, big endian SCRIPTS fetch (PA-RISC) 
>>>> and 24 bit
>>>> + * DMA, per the NCR 53C710 Data Manual (Jun 1992) and Programmer's 
>>>> Guide
>>>> + * (Oct 1990).
>>>>  *
>>>> - * Developed from an implementation of NCR53C710 by Helge Deller
>>>> - * which was interim based on the implementation by Toni Wilen for 
>>>> UAE.
>>>> + * Derived from hw/scsi/lsi53c895a.c (Copyright (c) 2006 
>>>> CodeSourcery, written
>>>> + * by Paul Brook).
>>>>  *
>>>> - * SPDX-License-Identifier: GPL-2.0-or-later
>>>> + * Replaces the 53C710 model written for Google Summer of Code 2025 by
>>>> + * Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>, itself 
>>>> based on
>>>> + * earlier NCR 53C710 work by Helge Deller and by Toni Wilen (for 
>>>> UAE).
>>>>  *
>>>> - * Contents:
>>>> - * 1. Register Definitions
>>>> - * 2. Register name functions
>>>> - * 3. Parity functions
>>>> - * 4. SCSI FIFO Structures
>>>> - * 5. Scripts Misc functions
>>>> - * 6. DMA functions
>>>> - * 7. Scripts functions
>>>> - * 8. Read and Write functions
>>>> - * 9. QEMU Device model functions
>>>> + * The only instantiated device is the LASI wrapper 
>>>> (lasi_ncr710.c), which
>>>> + * embeds one NCR710State by value and drives it through this file.
>>>>  *
>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>>  */
>>>>
>>>> #include "qemu/osdep.h"
>>>> -#include "qapi/error.h"
>>>> -#include "qemu/timer.h"
>>>> +#include "qemu/bitops.h"
>>>> +#include "qemu/log.h"
>>>> +#include "qemu/main-loop.h"
>>>> #include "hw/core/irq.h"
>>>> -#include "hw/core/sysbus.h"
>>>> -#include "hw/scsi/scsi.h"
>>>> #include "hw/scsi/ncr53c710.h"
>>>> -#include "migration/vmstate.h"
>>>> -#include "system/dma.h"
>>>> -#include "qemu/log.h"
>>>> -#include "qemu/module.h"
>>>> +#include "system/block-backend.h"
>>>> #include "trace.h"
>>>> -#include "qom/object.h"
>>>> -
>>>> -#define NCR710_MAX_DEVS 7
>>>> -
>>>> -/* SCNTL0 (0x00) - SCSI Control Register 0 */
>>>> -#define NCR710_SCNTL0_TRG    0x01
>>>> -#define NCR710_SCNTL0_AAP    0x02
>>>> -#define NCR710_SCNTL0_EPG    0x04
>>>> -#define NCR710_SCNTL0_EPC    0x08
>>>> -#define NCR710_SCNTL0_WATN   0x10
>>>> -#define NCR710_SCNTL0_START  0x20
>>>> -#define NCR710_SCNTL0_ARB0   0x40
>>>> -#define NCR710_SCNTL0_ARB1   0x80
>>>> -
>>>> -/* SCNTL1 (0x01) - SCSI Control Register 1 */
>>>> -#define NCR710_SCNTL1_RES0   0x01
>>>> -#define NCR710_SCNTL1_RES1   0x02
>>>> -#define NCR710_SCNTL1_AESP   0x04
>>>> -#define NCR710_SCNTL1_RST    0x08
>>>> -#define NCR710_SCNTL1_CON    0x10
>>>> -#define NCR710_SCNTL1_ESR    0x20
>>>> -#define NCR710_SCNTL1_ADB    0x40
>>>> -#define NCR710_SCNTL1_EXC    0x80
>>>> -
>>>> -/* ISTAT (0x21) - Interrupt Status Register */
>>>> -#define NCR710_ISTAT_DIP    0x01
>>>> -#define NCR710_ISTAT_SIP    0x02
>>>> -#define NCR710_ISTAT_CON    0x08
>>>> -#define NCR710_ISTAT_SIGP   0x20
>>>> -#define NCR710_ISTAT_RST    0x40
>>>> -#define NCR710_ISTAT_ABRT   0x80
>>>> -
>>>> -/* SSTAT0 (0x0D) - SCSI Status Register 0 */
>>>> -#define NCR710_SSTAT0_PAR    0x01
>>>> -#define NCR710_SSTAT0_RST    0x02
>>>> -#define NCR710_SSTAT0_UDC    0x04
>>>> -#define NCR710_SSTAT0_SGE    0x08
>>>> -#define NCR710_SSTAT0_SEL    0x10
>>>> -#define NCR710_SSTAT0_STO    0x20
>>>> -#define NCR710_SSTAT0_FCMP   0x40
>>>> -#define NCR710_SSTAT0_MA     0x80
>>>> -
>>>> -/* SSTAT1 (0x0E) - SCSI Status Register 1 */
>>>> -#define NCR710_SSTAT1_ORF    0x02
>>>> -#define NCR710_SSTAT1_ILF    0x04
>>>> -
>>>> -/* SSTAT2 (0x0F) - SCSI Status Register 2 */
>>>> -#define NCR710_SSTAT2_FF0    0x01
>>>> -#define NCR710_SSTAT2_FF1    0x02
>>>> -#define NCR710_SSTAT2_FF2    0x04
>>>> -#define NCR710_SSTAT2_FF3    0x08
>>>> -
>>>> -/* SOCL (0x07) / SBCL (0x0B) - SCSI Output/Bus Control Lines */
>>>> -#define NCR710_SOCL_IO       0x01
>>>> -#define NCR710_SOCL_CD       0x02
>>>> -#define NCR710_SOCL_MSG      0x04
>>>> -#define NCR710_SOCL_ATN      0x08
>>>> -#define NCR710_SOCL_SEL      0x10
>>>> -#define NCR710_SOCL_BSY      0x20
>>>> -#define NCR710_SOCL_ACK      0x40
>>>> -#define NCR710_SOCL_REQ      0x80
>>>> -
>>>> -/* SBCL bits same as SOCL */
>>>> -#define NCR710_SBCL_IO       0x01
>>>> -#define NCR710_SBCL_CD       0x02
>>>> -#define NCR710_SBCL_MSG      0x04
>>>> -#define NCR710_SBCL_ATN      0x08
>>>> -#define NCR710_SBCL_SEL      0x10
>>>> -#define NCR710_SBCL_BSY      0x20
>>>> -#define NCR710_SBCL_ACK      0x40
>>>> -#define NCR710_SBCL_REQ      0x80
>>>> -
>>>> -/* DSTAT (0x0C) - DMA Status Register */
>>>> -#define NCR710_DSTAT_IID     0x01
>>>> -#define NCR710_DSTAT_SIR     0x04
>>>> -#define NCR710_DSTAT_SSI     0x08
>>>> -#define NCR710_DSTAT_ABRT    0x10
>>>> -#define NCR710_DSTAT_BF      0x20
>>>> -#define NCR710_DSTAT_MDPE    0x40
>>>> -#define NCR710_DSTAT_DFE     0x80
>>>> -
>>>> -/* DCNTL (0x3B) - DMA Control Register */
>>>> -#define NCR710_DCNTL_COM     0x01
>>>> -#define NCR710_DCNTL_IRQD    0x02
>>>> -#define NCR710_DCNTL_STD     0x04
>>>> -#define NCR710_DCNTL_IRQM    0x08
>>>> -#define NCR710_DCNTL_SSM     0x10
>>>> -#define NCR710_DCNTL_PFEN    0x20
>>>> -#define NCR710_DCNTL_PFF     0x40
>>>> -
>>>> -/* DMODE (0x38) - DMA Mode Register */
>>>> -#define NCR710_DMODE_MAN     0x01
>>>> -#define NCR710_DMODE_BOF     0x02
>>>> -#define NCR710_DMODE_ERMP    0x04
>>>> -#define NCR710_DMODE_ERL     0x08
>>>> -#define NCR710_DMODE_DIOM    0x10
>>>> -#define NCR710_DMODE_SIOM    0x20
>>>> -#define NCR710_DMODE_BL_MASK 0xC0
>>>> -#define NCR710_DMODE_BL_1    0x00
>>>> -#define NCR710_DMODE_BL_2    0x40
>>>> -#define NCR710_DMODE_BL_4    0x80
>>>> -#define NCR710_DMODE_BL_8    0xC0
>>>> -
>>>> -/* CTEST2 (0x16) - Chip Test Register 2 */
>>>> -#define NCR710_CTEST2_DACK   0x01
>>>> -#define NCR710_CTEST2_DREQ   0x02
>>>> -#define NCR710_CTEST2_TEOP   0x04
>>>> -#define NCR710_CTEST2_PCICIE 0x08
>>>> -#define NCR710_CTEST2_CM     0x10
>>>> -#define NCR710_CTEST2_CIO    0x20
>>>> -#define NCR710_CTEST2_SIGP   0x40
>>>> -#define NCR710_CTEST2_DDIR   0x80
>>>> -
>>>> -/* CTEST5 (0x19) - Chip Test Register 5 */
>>>> -#define NCR710_CTEST5_BL2    0x04
>>>> -#define NCR710_CTEST5_DDIR   0x08
>>>> -#define NCR710_CTEST5_MASR   0x10
>>>> -#define NCR710_CTEST5_DFSN   0x20
>>>> -#define NCR710_CTEST5_BBCK   0x40
>>>> -#define NCR710_CTEST5_ADCK   0x80
>>>> -
>>>> -/* SCID (0x04) - SCSI Chip ID Register */
>>>> -#define NCR710_SCID_RRE      0x60
>>>> -#define NCR710_SCID_ID_MASK  0x07
>>>> -
>>>> -#define NCR710_HOST_ID       7
>>>> -
>>>> -/* NCR53C710 has 8-byte SCSI FIFO */
>>>> -#define NCR710_MAX_MSGIN_LEN 8
>>>> -#define NCR710_BUF_SIZE         4096
>>>> -
>>>> -/* Standard SCSI Message Byte Constants */
>>>> -#define SCSI_MSG_ABORT                      0x06
>>>> -#define SCSI_MSG_BUS_DEVICE_RESET           0x0c
>>>> -#define SCSI_MSG_COMMAND_COMPLETE           0x00
>>>> -#define SCSI_MSG_DISCONNECT                 0x04
>>>> -#define SCSI_MSG_EXTENDED_MESSAGE           0x01
>>>> -#define SCSI_MSG_IDENTIFY                   0x80
>>>> -#define SCSI_MSG_IGNORE_WIDE_RESIDUE        0x23
>>>> -#define SCSI_MSG_MESSAGE_PARITY_ERROR       0x09
>>>> -#define SCSI_MSG_MESSAGE_REJECT             0x07
>>>> -#define SCSI_MSG_NO_OPERATION               0x08
>>>> -#define SCSI_MSG_RELEASE_RECOVERY           0x10
>>>> -#define SCSI_MSG_RESTORE_POINTERS           0x03
>>>> -#define SCSI_MSG_SAVE_DATA_POINTER          0x02
>>>> -#define SCSI_MSG_SYNCHRONOUS_DATA_TRANSFER  0x01
>>>> -#define SCSI_MSG_WIDE_DATA_TRANSFER         0x03
>>>> -
>>>> -/* Script interrupt codes */
>>>> -#define A_GOOD_STATUS_AFTER_STATUS          0x401
>>>> -#define A_DISCONNECT_AFTER_CMD              0x380
>>>> -#define A_DISCONNECT_AFTER_DATA             0x580
>>>> -#define A_DISCONNECT_DURING_DATA            0x780
>>>> -#define A_RESELECTION_IDENTIFIED            0x1003
>>>> -#define A_UNEXPECTED_PHASE                  0x20
>>>> -#define A_FATAL                             0x2000
>>>> -#define A_DEBUG_INTERRUPT                   0x3000
>>>> -
>>>> -/* SCSI Script execution states */
>>>> -#define SCRIPT_STATE_IDLE                  0
>>>> -#define SCRIPT_STATE_SELECTING             1
>>>> -#define SCRIPT_STATE_COMMAND               2
>>>> -#define SCRIPT_STATE_DATA                  3
>>>> -#define SCRIPT_STATE_STATUS                4
>>>> -#define SCRIPT_STATE_MESSAGE               5
>>>> -#define SCRIPT_STATE_DISCONNECTED          6
>>>> -
>>>> -#define AFTER_SELECTION         0x100
>>>> -#define BEFORE_CMD              0x200
>>>> -#define AFTER_CMD               0x300
>>>> -#define AFTER_STATUS            0x400
>>>> -#define AFTER_DATA_IN           0x500
>>>> -#define AFTER_DATA_OUT          0x600
>>>> -#define DURING_DATA_IN          0x700
>>>> -
>>>> -#define NOT_MSG_OUT             0x10
>>>> -#define UNEXPECTED_PHASE        0x20
>>>> -#define NOT_MSG_IN              0x30
>>>> -#define UNEXPECTED_MSG          0x40
>>>> -#define MSG_IN                  0x50
>>>> -#define SDTR_MSG_R              0x60
>>>> -#define REJECT_MSG_R            0x70
>>>> -#define DISCONNECT              0x80
>>>> -#define MSG_OUT                 0x90
>>>> -#define WDTR_MSG_R              0xA0
>>>> -
>>>> -#define GOOD_STATUS             0x1
>>>> -
>>>> -#define NOT_MSG_OUT_AFTER_SELECTION         0x110
>>>> -#define UNEXPECTED_PHASE_BEFORE_CMD         0x220
>>>> -#define UNEXPECTED_PHASE_AFTER_CMD          0x320
>>>> -#define NOT_MSG_IN_AFTER_STATUS             0x430
>>>> -#define GOOD_STATUS_AFTER_STATUS            0x401
>>>> -#define UNEXPECTED_PHASE_AFTER_DATA_IN      0x520
>>>> -#define UNEXPECTED_PHASE_AFTER_DATA_OUT     0x620
>>>> -#define UNEXPECTED_MSG_BEFORE_CMD           0x240
>>>> -#define MSG_IN_BEFORE_CMD                   0x250
>>>> -#define MSG_IN_AFTER_CMD                    0x350
>>>> -#define SDTR_MSG_BEFORE_CMD                 0x260
>>>> -#define REJECT_MSG_BEFORE_CMD               0x270
>>>> -#define DISCONNECT_AFTER_CMD                0x380
>>>> -#define SDTR_MSG_AFTER_CMD                  0x360
>>>> -#define WDTR_MSG_AFTER_CMD                  0x3A0
>>>> -#define MSG_IN_AFTER_STATUS                 0x440
>>>> -#define DISCONNECT_AFTER_DATA               0x580
>>>> -#define MSG_IN_AFTER_DATA_IN                0x550
>>>> -#define MSG_IN_AFTER_DATA_OUT               0x650
>>>> -#define MSG_OUT_AFTER_DATA_IN               0x590
>>>> -#define DATA_IN_AFTER_DATA_IN               0x5a0
>>>> -#define MSG_IN_DURING_DATA_IN               0x750
>>>> -#define DISCONNECT_DURING_DATA              0x780
>>>> -
>>>> -#define RESELECTED_DURING_SELECTION      0x1000
>>>> -#define COMPLETED_SELECTION_AS_TARGET    0x1001
>>>> -#define RESELECTION_IDENTIFIED           0x1003
>>>> -
>>>> -#define FATAL                            0x2000
>>>> -#define FATAL_UNEXPECTED_RESELECTION_MSG 0x2000
>>>> -#define FATAL_SEND_MSG                   0x2001
>>>> -#define FATAL_NOT_MSG_IN_AFTER_SELECTION 0x2002
>>>> -#define FATAL_ILLEGAL_MSG_LENGTH         0x2003
>>>> -
>>>> -#define DEBUG_INTERRUPT     0x3000
>>>> -#define DEBUG_INTERRUPT1    0x3001
>>>> -#define DEBUG_INTERRUPT2    0x3002
>>>> -#define DEBUG_INTERRUPT3    0x3003
>>>> -#define DEBUG_INTERRUPT4    0x3004
>>>> -#define DEBUG_INTERRUPT5    0x3005
>>>> -#define DEBUG_INTERRUPT6    0x3006
>>>> -
>>>> -#define COMMAND_COMPLETE_MSG      0x00
>>>> -#define EXTENDED_MSG              0x01
>>>> -#define SDTR_MSG                  0x01
>>>> -#define SAVE_DATA_PTRS_MSG        0x02
>>>> -#define RESTORE_DATA_PTRS_MSG     0x03
>>>> -#define WDTR_MSG                  0x03
>>>> -#define DISCONNECT_MSG            0x04
>>>> -#define REJECT_MSG                0x07
>>>> -#define PARITY_ERROR_MSG          0x09
>>>> -#define SIMPLE_TAG_MSG            0x20
>>>> -#define IDENTIFY_MSG              0x80
>>>> -#define IDENTIFY_MSG_MASK         0x7F
>>>> -#define TWO_BYTE_MSG              0x20
>>>> -#define TWO_BYTE_MSG_MASK         0x0F
>>>> -
>>>> -/* SCSI phases */
>>>> -#define PHASE_DO   0  /* Data out phase */
>>>> -#define PHASE_DI   1  /* Data in phase */
>>>> -#define PHASE_CO   2  /* Command phase */
>>>> -#define PHASE_SI   3  /* Status phase */
>>>> -#define PHASE_ST   3  /* Status phase (alias) */
>>>> -#define PHASE_MO   6  /* Message out phase */
>>>> -#define PHASE_MI   7  /* Message in phase */
>>>> -#define PHASE_MASK 7  /* Mask for phase bits */
>>>> -
>>>> -#define NCR710_TAG_VALID     (1 << 16)
>>>> -
>>>> -static void ncr710_scsi_fifo_init(NCR710_SCSI_FIFO *fifo);
>>>> -static const char *ncr710_reg_name(int offset);
>>>> -static void ncr710_script_scsi_interrupt(NCR710State *s, int stat0);
>>>> -static void ncr710_update_irq(NCR710State *s);
>>>> -static void ncr710_script_dma_interrupt(NCR710State *s, int stat);
>>>> -static void ncr710_request_free(NCR710State *s, NCR710Request *p);
>>>> -static inline void ncr710_dma_read(NCR710State *s, uint32_t addr,
>>>> -                                   void *buf, uint32_t len);
>>>> -static inline void ncr710_dma_write(NCR710State *s, uint32_t addr,
>>>> -                                    const void *buf, uint32_t len);
>>>> -static uint8_t ncr710_reg_readb(NCR710State *s, int offset);
>>>> -static void ncr710_reg_writeb(NCR710State *s, int offset, uint8_t 
>>>> val);
>>>>
>>>> +/* SCNTL0 (0x00) */
>>>> +#define NCR710_SCNTL0_TRG       0x01
>>>> +#define NCR710_SCNTL0_AAP       0x02
>>>> +#define NCR710_SCNTL0_EPG       0x04
>>>> +#define NCR710_SCNTL0_EPC       0x08
>>>> +#define NCR710_SCNTL0_WATN      0x10
>>>> +#define NCR710_SCNTL0_START     0x20
>>>> +/* ARB1|ARB0 = 0xc0 (full arbitration) at reset */
>>>> +
>>>> +/* SCNTL1 (0x01) */
>>>> +#define NCR710_SCNTL1_AESP      0x04
>>>> +#define NCR710_SCNTL1_RST       0x08
>>>> +#define NCR710_SCNTL1_CON       0x10
>>>> +#define NCR710_SCNTL1_ESR       0x20
>>>> +#define NCR710_SCNTL1_ADB       0x40
>>>> +#define NCR710_SCNTL1_EXC       0x80
>>>> +
>>>> +/* SSTAT0 (0x0d) and SIEN (0x03) share this bit layout. */
>>>> +#define NCR710_STAT0_PAR        0x01
>>>> +#define NCR710_STAT0_RST        0x02
>>>> +#define NCR710_STAT0_UDC        0x04
>>>> +#define NCR710_STAT0_SGE        0x08
>>>> +#define NCR710_STAT0_SEL        0x10
>>>> +#define NCR710_STAT0_STO        0x20
>>>> +#define NCR710_STAT0_FCMP       0x40
>>>> +#define NCR710_STAT0_MA         0x80
>>>> +
>>>> +/* DSTAT (0x0c) and DIEN (0x39) share this bit layout. */
>>>> +#define NCR710_DSTAT_IID        0x01
>>>> +#define NCR710_DSTAT_WTD        0x02
>>>> +#define NCR710_DSTAT_SIR        0x04
>>>> +#define NCR710_DSTAT_SSI        0x08
>>>> +#define NCR710_DSTAT_ABRT       0x10
>>>> +#define NCR710_DSTAT_BF         0x20
>>>> +#define NCR710_DSTAT_DFE        0x80   /* pure status; never raises 
>>>> an IRQ */
>>>> +
>>>> +/* ISTAT (0x21) */
>>>> +#define NCR710_ISTAT_DIP        0x01
>>>> +#define NCR710_ISTAT_SIP        0x02
>>>> +#define NCR710_ISTAT_CON        0x08
>>>> +#define NCR710_ISTAT_SIGP       0x20
>>>> +#define NCR710_ISTAT_RST        0x40
>>>> +#define NCR710_ISTAT_ABRT       0x80
>>>> +
>>>> +/* SBCL (0x0b): low 3 bits mirror the SCSI phase, upper bits are 
>>>> bus signals. */
>>>> +#define NCR710_SBCL_ATN         0x08
>>>> +#define NCR710_SBCL_SEL         0x10
>>>> +#define NCR710_SBCL_BSY         0x20
>>>> +#define NCR710_SBCL_ACK         0x40
>>>> +#define NCR710_SBCL_REQ         0x80
>>>> +
>>>> +/* SOCL (0x07) */
>>>> +#define NCR710_SOCL_ATN         0x08
>>>> +
>>>> +/* CTEST2 (0x16) */
>>>> +#define NCR710_CTEST2_DACK      0x01
>>>> +#define NCR710_CTEST2_SIGP      0x40
>>>> +
>>>> +/* DMODE (0x38) */
>>>> +#define NCR710_DMODE_MAN        0x01
>>>> +
>>>> +/* DCNTL (0x3b) */
>>>> +#define NCR710_DCNTL_COM        0x01
>>>> +#define NCR710_DCNTL_FA         0x02
>>>> +#define NCR710_DCNTL_STD        0x04
>>>> +#define NCR710_DCNTL_LLM        0x08
>>>> +#define NCR710_DCNTL_SSM        0x10
>>>> +#define NCR710_DCNTL_EA         0x20
>>>> +
>>>> +/* SCSI phase (MSG,C/D,I/O); matches SSTAT2[2:0]/SBCL[2:0]/ 
>>>> DCMD[26:24]. */
>>>> +#define PHASE_DO        0
>>>> +#define PHASE_DI        1
>>>> +#define PHASE_CMD       2
>>>> +#define PHASE_ST        3
>>>> +#define PHASE_MO        6
>>>> +#define PHASE_MI        7
>>>> +#define PHASE_MASK      7
>>>> +
>>>> +/* Flag bit OR'd into select_tag/tag when a queue tag is valid. */
>>>> +#define NCR710_TAG_VALID    (1 << 16)
>>>> +
>>>> +/* Maximum SCRIPTS instructions to process before yielding to the 
>>>> CPU. */
>>>> +#define NCR710_MAX_INSN     500
>>>> +
>>>> +#define NCR710_BUF_SIZE     4096
>>>> +
>>>> +/* waiting state machine (mirrors lsi53c895a). */
>>>> +enum {
>>>> +    NCR710_NOWAIT = 0,        /* SCRIPTS running or stopped */
>>>> +    NCR710_WAIT_RESELECT,     /* Wait Reselect instruction issued */
>>>> +    NCR710_DMA_SCRIPTS,       /* DMA invoked from within 
>>>> execute_script */
>>>> +    NCR710_DMA_IN_PROGRESS,   /* asynchronous DMA in progress */
>>>> +    NCR710_WAIT_SCRIPTS,      /* stopped on the instruction count 
>>>> limit */
>>>> +};
>>>>
>>>> -static inline int ncr710_irq_on_rsl(NCR710State *s)
>>>> +enum {
>>>> +    NCR710_MSG_ACTION_COMMAND = 0,
>>>> +    NCR710_MSG_ACTION_DISCONNECT = 1,
>>>> +    NCR710_MSG_ACTION_DOUT = 2,
>>>> +    NCR710_MSG_ACTION_DIN = 3,
>>>> +};
>>>> +
>>>> +struct NCR710Request {
>>>> +    SCSIRequest *req;
>>>> +    uint32_t tag;
>>>> +    uint32_t dma_len;
>>>> +    uint8_t *dma_buf;
>>>> +    uint32_t pending;     /* bytes the SCSI layer has ready while 
>>>> queued */
>>>> +    int out;              /* nonzero if the queued transfer is DATA 
>>>> OUT */
>>>> +    bool orphan;
>>>> +    QTAILQ_ENTRY(NCR710Request) next;
>>>> +};
>>>
>>> This struct is exactly the same as lsi_request in lsi53c895a.c. As a
>>> start this and helper functions working on it should be split off in
>>> a shared file and header from lsi53c895a.c and reused here. That
>>> needs changing lsi53c895a.c but it's trivial changes easy to review
>>> and does not break it. That with more small chnages split off as
>>> suggested by Peter should reduce the size of this patch to a more
>>> managable size so we can see what else could be shared.
>>
>> I fully understand and generally support the wish to merge and share
>> things in the hope for easier review and possible maintanance reduction.
>>
>> But even in the Linux kernel those drivers don't share code.
>> Will we really gain much if we try to split the existing working drivers
>> and try share code between those?
> 
> Yes, reduced duplicated code and avoiding divergence with bugs only 
> introduced or fixed in one of them in the future. IMO that's worth some 
> restructuring.
> 
>> I mean, the 710 and 89x chips are quite different, and so will be the 
>> code.
>>
>> In this specific case IMHO it's better to keep them seperate.
> 
> I'm not asking for merging the two models and rewrite the 53c895a much 
> but trivially shareable code such as request queue handling that seems 
> to be just reused here should not be duplicated and this seems to be 
> easily split from exsting code and reused here.
> 
> I'm not the maintainer so whatever the one responsible here prefers but 
> I think trying to split this patch up and share some easily shared code 
> is reasonable to ask to avoid adding duplicated code. Then the rest 
> where these are really different can be separate without sharing more 
> code but currently there are a lot of defines, types and some functions 
> duplicated in this patch that could be split off and trivially shared.
> 
> Regards,
> BALATON Zoltan


