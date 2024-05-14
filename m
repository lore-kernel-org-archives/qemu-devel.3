Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046C5C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 14:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6skZ-0002Bc-F2; Tue, 14 May 2024 10:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1s6skE-0002Ap-OC
 for qemu-devel@nongnu.org; Tue, 14 May 2024 10:03:07 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1s6sk9-0004u7-J9
 for qemu-devel@nongnu.org; Tue, 14 May 2024 10:03:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1715695378; x=1716300178; i=deller@gmx.de;
 bh=soaMMflMNbHyD8mfRwq1Yffc8Lnhq7RMR1e/pDZRQ5c=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=rBMkB2nKNX10VwofsjBrJIttLyhMvZZ9VqzHEXQzlgwpF5CMloqw6NH6Qx688NbG
 Aai8zwfe3xaxXcnfaewTRIS2JBuLVHNSmCRdqI15pka9rHJiQovgUE7UTERWJRqfv
 a5SjYyUb0VghhXA4j+9MyplroE0wa4aZExqfh7OyfS4cTLw4u2siae09lzBm4zPPY
 Idh2djIL2ebQ3CZcYVFOj/dYvhBwEmNUIXJa2hEtR69q7FsPtlM8ZlU62KQBCNyxy
 bzgIJG4lK9Hnxh5pqCErLw8muQrJAJgtbpSghd4X8D4IsgxguClpZU49EInS824Ip
 H1tQ1sVmx9gKBhDJSw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([89.244.186.200]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfpOT-1smY9L1veD-00gDC4; Tue, 14
 May 2024 16:02:58 +0200
Message-ID: <eaf083b6-0ce1-44d8-ada9-f0b9492686ff@gmx.de>
Date: Tue, 14 May 2024 16:02:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/45] target/hppa: Misc improvements
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240513074717.130949-1-richard.henderson@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IXTkL+ZKmmDItN7zQKSpwN6ZociTq3Ye2T1S/S+Ei7qdJSuvgfl
 1v2juWZSN9ZzS9ExZYeoMRbrulOBFtQI6hxCl2HRgnLaMj1CwxMjEEHBlk8mIO/YxJGI8CS
 om259pbpS4dfEI0jNN/6C/93TiCnyODM0tBB0iHrreneteOdxAM4sKMX/spQqKfVigqW2os
 sc1GLmlaFDrLhQrdELsnQ==
UI-OutboundReport: notjunk:1;M01:P0:6uhhFTdgHE4=;SUf9FXtLwNF9iavpcPJlsQzzdvA
 loXjPSiuVxYyq9fcfMKd8al00ySQibjnCbT0hxsLkuUTAVtMvb3ovG7A+5EZCoLmtlzvavUGE
 6+lsSvq7A1sDj1bc+d79jKpdYZv7PYpq6fqNcSvbIWXs1QOHl6B0LmBusH65Ja/1Ma141AR0a
 pQIGq020Ct/ricKCsRH0pqbupT6AsndZy0S2OUdm3K+usZZkjt85Jb/3ZivvvTDcwxaq19BhV
 AvM8BBF/0yipn/2iabvSFiduZpL/m5lJ4P0KxUMvbJikpQ8KpR9wKYGsuUiLOsw6T4nrRlOA9
 g+KyhYy0xcn/CGH91l5ifAaXXMLno0HY4D/gk/XmwnHmA9lLQwL7QaUZlL1nPfc9+UdsJmEt2
 YwgdsJEDhrr2p9xRAWONpnPvkAM4eDf+NuQC7QlbN3LR0ot8k2n7N0K/rZ2wcShfyejTtB0pX
 DEpiCzzOeZQrycADq4lu7Gz+hmWdz2XhPcaJFJFT/BtHQqXR8QqGXJrEvFEvxnzaD0BXopfBX
 4d/sd/MIBrZmk3dwkyh0c2rzXWfoLK1jUuLqs5d/Gx9JKyxP+ZWGzPV7OK0Z5Y5aYfyp9BFXi
 fYcb6tBNP19+W7fYW2mLIUhW+zbIizEFxt0W/nrsFeCoKCGR8H+/Kz5sEBMXgYf7aHcmTawW/
 XF7X6vNhyRXXliislPsphjfdI0U5+Et1Mw47q1oIKq3SG82fOmrSqaXw6fJ2WoMArFPUvMLl9
 Z7UDdX6coxvDKbYadCizUhcz1rjaKuY954sxVv07xcWV9ANewR36stfF8IU8kMwDKVsSuUb1Y
 gxyQe+BKTQT7wH+KUg7/R6Kkn4/aAdR+/0PN9JEBlsGFA=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/13/24 09:46, Richard Henderson wrote:
> Most of the patches lead up to implementing CF_PCREL.
> Along the way there is a grab bag of code updates (TCG_COND_TST*),
> bug fixes (space changes during branch-in-branch-delay-slot),
> and implementation of features (PSW bits B, X, T, H, L).
>
> Sven reported that PSW L tripped up HP/UX, so possibly there's
> something wrong there, but that's right at the end of the patch set.
> So I'd like some feedback on the rest leading up to that too.

I do see the PSW_L issue as well (32-bit machine when starting HP-UX 11).
When leaving out patches 42-45 ("target/hppa: Implement PSW_T" and followi=
ng)
I can boot 32-bit HP-UX 10 and 11.

Will review the patches now individually, but maybe you should
push the patches 1-41 first and we take the PSWT/L patches later?

Helge

>
> Changes for v2:
>    - Rebase and update for tcg_cflags_set.
>
>
> r~
>
>
> Richard Henderson (45):
>    target/hppa: Move cpu_get_tb_cpu_state out of line
>    target/hppa: Use hppa_form_gva_psw in hppa_cpu_get_pc
>    target/hppa: Move constant destination check into use_goto_tb
>    target/hppa: Pass displacement to do_dbranch
>    target/hppa: Allow prior nullification in do_ibranch
>    target/hppa: Use CF_BP_PAGE instead of cpu_breakpoint_test
>    target/hppa: Add install_iaq_entries
>    target/hppa: Add install_link
>    target/hppa: Delay computation of IAQ_Next
>    target/hppa: Skip nullified insns in unconditional dbranch path
>    target/hppa: Simplify TB end
>    target/hppa: Add IASQ entries to DisasContext
>    target/hppa: Add space arguments to install_iaq_entries
>    target/hppa: Add space argument to do_ibranch
>    target/hppa: Use umax in do_ibranch_priv
>    target/hppa: Always make a copy in do_ibranch_priv
>    target/hppa: Introduce and use DisasIAQE for branch management
>    target/hppa: Use displacements in DisasIAQE
>    target/hppa: Rename cond_make_* helpers
>    target/hppa: Use TCG_COND_TST* in do_cond
>    target/hppa: Use TCG_COND_TST* in do_log_cond
>    target/hppa: Use TCG_COND_TST* in do_unit_zero_cond
>    target/hppa: Use TCG_COND_TST* in do_unit_addsub
>    target/hppa: Use TCG_COND_TST* in trans_bb_imm
>    target/hppa: Use registerfields.h for FPSR
>    target/hppa: Use TCG_COND_TST* in trans_ftest
>    target/hppa: Remove cond_free
>    target/hppa: Introduce DisasDelayException
>    target/hppa: Use delay_excp for conditional traps
>    target/hppa: Use delay_excp for conditional trap on overflow
>    linux-user/hppa: Force all code addresses to PRIV_USER
>    target/hppa: Store full iaoq_f and page offset of iaoq_b in TB
>    target/hppa: Do not mask in copy_iaoq_entry
>    target/hppa: Improve hppa_cpu_dump_state
>    target/hppa: Split PSW X and B into their own field
>    target/hppa: Manage PSW_X and PSW_B in translator
>    target/hppa: Implement PSW_B
>    target/hppa: Implement PSW_X
>    target/hppa: Drop tlb_entry return from hppa_get_physical_address
>    target/hppa: Adjust priv for B,GATE at runtime
>    target/hppa: Implement CF_PCREL
>    target/hppa: Implement PSW_T
>    target/hppa: Implement PSW_H, PSW_L
>    target/hppa: Log cpu state at interrupt
>    target/hppa: Log cpu state on return-from-interrupt
>
>   linux-user/hppa/target_cpu.h |    4 +-
>   target/hppa/cpu.h            |   80 +--
>   target/hppa/helper.h         |    3 +-
>   linux-user/elfload.c         |    4 +-
>   linux-user/hppa/cpu_loop.c   |   14 +-
>   linux-user/hppa/signal.c     |    6 +-
>   target/hppa/cpu.c            |   92 ++-
>   target/hppa/fpu_helper.c     |   26 +-
>   target/hppa/gdbstub.c        |    6 +
>   target/hppa/helper.c         |   66 +-
>   target/hppa/int_helper.c     |   33 +-
>   target/hppa/mem_helper.c     |   99 +--
>   target/hppa/op_helper.c      |   17 +-
>   target/hppa/sys_helper.c     |   12 +
>   target/hppa/translate.c      | 1232 ++++++++++++++++++----------------
>   15 files changed, 947 insertions(+), 747 deletions(-)
>


