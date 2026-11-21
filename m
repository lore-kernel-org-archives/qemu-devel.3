Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B83606A320
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Nov 2026 16:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=techtravels.org header.i=@techtravels.org header.a=rsa-sha256 header.s=s1175899 header.b=SSzsihiC;
	dkim=pass (2048-bit key, unprotected) header.d=techtravels.org header.i=@techtravels.org header.a=rsa-sha256 header.s=mail header.b=DE9VvAMN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUnzF-0001VQ-Vy; Sat, 21 Nov 2026 11:30:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.e7utx72ri9d0hb4=r7ei5pxom232=7d7rh0subzk0gy@em1175899.techtravels.org>)
 id 1xUnyx-0001Tv-AN
 for qemu-devel@nongnu.org; Sat, 21 Nov 2026 11:30:43 -0500
Received: from a4i891.smtp2go.com ([158.120.83.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.e7utx72ri9d0hb4=r7ei5pxom232=7d7rh0subzk0gy@em1175899.techtravels.org>)
 id 1xUnyv-0004Wb-28
 for qemu-devel@nongnu.org; Sat, 21 Nov 2026 11:30:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=techtravels.org;
 i=@techtravels.org; q=dns/txt; s=s1175899; t=1795278618; h=from :
 subject : to : message-id : date : list-unsubscribe :
 list-unsubscribe-post;
 bh=iox9Lo1ErbfjhmrkZmZEHcG5nqyc1DkuTA/w1QOG3nA=;
 b=SSzsihiCFAaHXwpe4ZOVJVx0vNyipOgLpN/obWuw76RJxH2CTehpc4Yj4tGOfhlwmBnOj
 THiKWKT0cdZTaY1w/aDxIj7K39+VESslruJdczFRXnz2C56fPSM4dHtS8ytU6bPQyAGRw8d
 OfpTelq2h166f6sJZgRlTBDHZv9SGEFrzr2s/tZjYieIJ+klJXez01bB055vm4/dJVdtdub
 WO0TRYJOgFh0ssPVLcgMmcHseDlNM8M/5c0LTpr1XznYtWW/2avPLpthvhJZ+cinZhul7I+
 EQ5orz/JpOz6rL7bLNlw3pRBkG6IDfXeyfkqfcvtnywp7GXe91doOvh5+RGA==
Received: from [10.91.249.253] (helo=boxtwo.techtravels.org)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256:X25519)
 (Exim 4.100.1) (envelope-from <keith@techtravels.org>)
 id 1xUnyd-AIkwcC8y8bA-q9OM; Sat, 21 Nov 2026 16:30:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=techtravels.org;
 s=mail; t=1795278609;
 bh=Q7mojMaUYiib10Y6dMeKukK9AyGtMg0G2HGNNf11lGM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=DE9VvAMNeoOr1MRGHPUgfvPLreG7zhiUTpFFBwYnHWHbcNQ2jH5snz/dy/0s4y+jW
 m4VunRFKDwPaqcn5mxmgVsWVOdB95LazJTE5IPwHxXK4yGBNAMTC0NXntwCfdAn5N4
 deFvThOFPxqaMrqNnFLCau+YB1WMm2e8sJ2fwo6dTuLnSV/eBzWmsc+s7Gry1giI4u
 h/6rBRrq8PjMjbC15w6PsJWJd+0iR7wpjjHfK17C0FnrqiTPm3T0C2Pr7xr5NmKF8k
 Yehn/JslADM42+PO1Qp4aDBw7Gr2pUMYPEQFvV/7XpN74kYNxy9fStADYIN0Ka4Axk
 34TpDSwABI4Ng==
Received: from authenticated-user (boxtwo.techtravels.org [54.196.37.146])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by boxtwo.techtravels.org (Postfix) with ESMTPSA id 1DCF63F325;
 Sat, 21 Nov 2026 11:30:09 -0500 (EST)
Message-ID: <a299d09a-9cb4-4050-b3c8-9313b03fef86@techtravels.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 1175899m:1175899aieqF3d:1175899siL3cVZZwx
X-smtpcorp-track: U0xfREkiFJXh._eiMhp4Sov4E.UBZ3ogzXBMn
Date: Sat, 21 Nov 2026 11:30:08 -0500
Subject: Re: [RFC PATCH-for-11.2? v4 11/14] hw/scsi/ncr53c710: Guard SCRIPTS
 reentrancy and cancel requests on soft reset
To: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Fam Zheng <fam@euphon.net>
References: <20261120171235.61325-1-philmd@oss.qualcomm.com>
 <20261120171235.61325-12-philmd@oss.qualcomm.com>
 <353f4998-ef46-4851-ceca-4d31e57765f4@eik.bme.hu>
From: Keith Monahan <keith@techtravels.org>
In-Reply-To: <353f4998-ef46-4851-ceca-4d31e57765f4@eik.bme.hu>
Received-SPF: pass client-ip=158.120.83.123;
 envelope-from=bounce.e7utx72ri9d0hb4=r7ei5pxom232=7d7rh0subzk0gy@em1175899.techtravels.org;
 helo=a4i891.smtp2go.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks Zoltan, Philippe and everyone for their help with this.

I apologize if you already know the background info I'm giving below.

On 11/20/2026 5:17 PM, BALATON Zoltan wrote:
> On Fri, 20 Nov 2026, Philippe Mathieu-Daudé wrote:
>> From: Keith Monahan <keith@techtravels.org>
>>
>> The interpreter guards the reentrancy class behind CVE-2023-0330: a
>> completion that fires synchronously while lsi_execute_script is already
>> on the stack no longer recurses, and a script that retriggers itself is
>> bounded by a recursion depth limit.
> 
> I don't understand this sentence above. Does it make sense or could it 
> be clarified?

This is a vulnerability found a few years ago, which affects the 895. A 
malicious guest could, on purpose, crash the host QEMU process by 
repeated nested controller restarts, which would eventually exhaust the 
stack.

QEMU added a generic restriction, where a device can't trigger its own 
control registers, while handling an access to them. This won't work for 
the 895, because real drivers need to access to the chip's own 
registers. So instead, they put a limit into the 895 model, and once it 
gets to 8 levels deep, it stops.

The 710 accesses its registers internally, but not through memory, so 
the global QEMU rule is ok here. Limiting the nesting to 8 levels, like 
the 895, isn't enough. One level can run part of the SCRIPTS program 
twice. During testing, this broke the timing the HP-UX driver relies on, 
and was hanging the install. My solution was to not let command 
completions nest, but instead deliver command completions afterwards, 
which is closer to the way the hardware works anyway. I kept the 8-level 
limit in the 710 just as a backstop.

So given all this, how about something like

The SCRIPTS interpreter guards against CVE-2023-0330. When a command 
finishes while the interpreter is running, the interpreter moves on to 
the next instruction without restarting itself. If a script keeps 
triggering itself, the interpreter stops it after 8 nested restarts.

Is that better?

Thanks,
Keith

> 
> Regards,
> BALATON Zoltan
> 
>> A guest ISTAT.RST soft reset cancels the connected and any queued
>> tagged requests, so a stale s->current cannot dangle into the next
>> command and queued requests are not leaked, mirroring the SCNTL1.RST
>> bus reset teardown.
>>
>> Signed-off-by: Keith Monahan <keith@techtravels.org>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> AI-used-for: Patch series decomposition (commit splitting and ordering)
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>> hw/scsi/ncr53c710.h |  5 +++++
>> hw/scsi/ncr53c710.c | 41 +++++++++++++++++++++++++++++++++++++++--
>> 2 files changed, 44 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/scsi/ncr53c710.h b/hw/scsi/ncr53c710.h
>> index 8b5cbfc135e3..9a4816794e1d 100644
>> --- a/hw/scsi/ncr53c710.h
>> +++ b/hw/scsi/ncr53c710.h
>> @@ -101,6 +101,11 @@ typedef struct NCR710State {
>>     bool sigp_pending_resume;
>>     /* A SCSI continue was deferred to lsi_issue_bh. */
>>     bool issue_pending;
>> +    /*
>> +     * SCRIPTS interpreter recursion depth; always 0 outside
>> +     * lsi_execute_script, so it is not migrated.
>> +     */
>> +    int reentrancy_level;
>>     lsi_request *current;
>>     /* Disconnected tagged commands awaiting reselection. */
>>     QTAILQ_HEAD(, lsi_request) queue;
>> diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
>> index dfed2f2f9fdd..f75540da7720 100644
>> --- a/hw/scsi/ncr53c710.c
>> +++ b/hw/scsi/ncr53c710.c
>> @@ -103,8 +103,23 @@ static int lsi_id_from_bits(unsigned bits)
>>
>> void ncr710_soft_reset(NCR710State *s)
>> {
>> +    lsi_request *p, *p_next;
>> +
>>     trace_ncr710_reset();
>>
>> +    /*
>> +     * A guest ISTAT.RST soft reset can land with commands still in 
>> flight.
>> +     * Cancel them so no stale pointer survives the reset.
>> +     */
>> +    if (s->current && s->current->req) {
>> +        scsi_req_cancel(s->current->req);
>> +    }
>> +    QTAILQ_FOREACH_SAFE(p, &s->queue, next, p_next) {
>> +        if (p->req) {
>> +            scsi_req_cancel(p->req);
>> +        }
>> +    }
>> +
>>     s->carry = 0;
>>     s->msg_action = LSI_MSG_ACTION_COMMAND;
>>     s->msg_len = 0;
>> @@ -114,6 +129,11 @@ void ncr710_soft_reset(NCR710State *s)
>>     s->command_complete = 0;
>>     s->script_running = false;
>>     s->sigp_pending_resume = false;
>> +    /*
>> +     * Do not reset reentrancy_level here.  A SCRIPTS driven soft 
>> reset can run
>> +     * while lsi_execute_script frames are still on the stack; those 
>> frames
>> +     * decrement the counter as they unwind.
>> +     */
>>
>>     s->scntl0 = 0xc0;       /* full arbitration */
>>     s->scntl1 = 0;
>> @@ -257,6 +277,16 @@ static int lsi_bad_phase(NCR710State *s, int 
>> new_phase)
>> static void lsi_resume_script(NCR710State *s)
>> {
>>     trace_ncr710_resume_script(s->waiting);
>> +    if (s->reentrancy_level > 0) {
>> +        /*
>> +         * A completion fired synchronously while the SCRIPTS 
>> interpreter is
>> +         * already on the stack.  Do not recurse: release the wait so 
>> the outer
>> +         * loop continues to the next instruction, which the 
>> completion has
>> +         * already armed.
>> +         */
>> +        s->waiting = LSI_NOWAIT;
>> +        return;
>> +    }
>>     if (s->waiting != LSI_DMA_SCRIPTS) {
>>         s->waiting = LSI_NOWAIT;
>>         lsi_execute_script(s);
>> @@ -857,13 +887,18 @@ static void lsi_execute_script(NCR710State *s)
>>         s->waiting = LSI_NOWAIT;
>>     }
>>
>> +    s->reentrancy_level++;
>>     s->script_running = true;
>> again:
>> -    /* Yield to the CPU after LSI_MAX_INSN instructions. */
>> -    if (++insn_processed > LSI_MAX_INSN) {
>> +    /*
>> +     * Yield to the CPU after LSI_MAX_INSN instructions, and guard 
>> against a
>> +     * script that retriggers itself (CVE-2023-0330).
>> +     */
>> +    if (++insn_processed > LSI_MAX_INSN || s->reentrancy_level > 8) {
>>         trace_ncr710_script_yield(insn_processed);
>>         s->waiting = LSI_WAIT_SCRIPTS;
>>         lsi_scripts_timer_start(s);
>> +        s->reentrancy_level--;
>>         return;
>>     }
>>
>> @@ -1209,6 +1244,8 @@ again:
>>             goto again;
>>         }
>>     }
>> +
>> +    s->reentrancy_level--;
>> }
>>
>> static uint8_t lsi_reg_readb(NCR710State *s, int offset)
>>


