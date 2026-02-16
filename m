Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F743E83841
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 23:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs7jd-0000x2-TL; Mon, 16 Feb 2026 18:10:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vs7jb-0000wl-Q0; Mon, 16 Feb 2026 18:10:31 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vs7jZ-0003eG-HM; Mon, 16 Feb 2026 18:10:31 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A1F05596A0A;
 Tue, 17 Feb 2026 00:10:24 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id l36ZfLa6wLrO; Tue, 17 Feb 2026 00:10:22 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 76FA45969FD; Tue, 17 Feb 2026 00:10:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 74A6E5969FA;
 Tue, 17 Feb 2026 00:10:22 +0100 (CET)
Date: Tue, 17 Feb 2026 00:10:22 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, unisono@quyllur.org, 
 qemu-ppc@nongnu.org
Subject: Re: [PATCH 11/11] target/ppc: Remove MonitorDef register entries
 available via gdbstub
In-Reply-To: <20260216225228.53959-12-philmd@linaro.org>
Message-ID: <ba0fd311-4c13-97ae-49e8-d40f0cc6b3a3@eik.bme.hu>
References: <20260216225228.53959-1-philmd@linaro.org>
 <20260216225228.53959-12-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1664473876-1771283422=:70802"
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

--3866299591-1664473876-1771283422=:70802
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 16 Feb 2026, Philippe Mathieu-Daudé wrote:
> All these registers are already provided by via gdbstub parsed XML
> and handler by the gdb_get_register() helper in the monitor/hmp.c
> file. Remove as now unreachable code.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> target/ppc/ppc-qmp-cmds.c | 5 -----
> 1 file changed, 5 deletions(-)
>
> diff --git a/target/ppc/ppc-qmp-cmds.c b/target/ppc/ppc-qmp-cmds.c
> index 7022564604f..7dfa78c2e0d 100644
> --- a/target/ppc/ppc-qmp-cmds.c
> +++ b/target/ppc/ppc-qmp-cmds.c
> @@ -93,16 +93,11 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
> }
>
> const MonitorDef monitor_defs[] = {
> -    { "fpscr", offsetof(CPUPPCState, fpscr) },
>     /* Next instruction pointer */

This comment should also go as it's for nip removed (nipped? :-) ) from 
next line.

Regards,
BALATON Zoltan

> -    { "nip|pc", offsetof(CPUPPCState, nip) },
> -    { "lr", offsetof(CPUPPCState, lr) },
> -    { "ctr", offsetof(CPUPPCState, ctr) },
>     { "decr", 0, &monitor_get_decr, },
>     { "ccr|cr", 0, &monitor_get_ccr, },
>     /* Machine state register */
>     { "xer", 0, &monitor_get_xer },
> -    { "msr", offsetof(CPUPPCState, msr) },
>     { "tbu", 0, &monitor_get_tbu, },
> #if defined(TARGET_PPC64)
>     { "tb", 0, &monitor_get_tbl, },
>
--3866299591-1664473876-1771283422=:70802--

