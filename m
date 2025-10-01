Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5EBCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3sAV-0006vz-Vu; Wed, 01 Oct 2025 04:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v3sAR-0006oj-JG
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:26:31 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v3sAG-00086S-Bj
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=QSm54R35lwuxkAYNaqQjLkq3fjMEvU+yagbTIwv/RqI=; b=wQ73VAHocGIzWgK
 ETF8GhYF28rOxGNKFv24JDvIvNsWzhBW2NkyJfxuDB+TwP4Ybw0cE7YX/UoDvmuT1Zzq7hRj7roVb
 1lSSawAu0a2U60w/xMded/AWec2x1T62T2rnluJUI4TAJZLUmO6lsPWOMK9rF3Ef6EOBog4cXXXTN
 9M=;
Date: Wed, 1 Oct 2025 10:28:46 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, 
 richard.henderson@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
Subject: Re: [PATCH v2 03/33] target/riscv: Fix size of mhartid
Message-ID: <o4orrvxjkhwz3r2q4dotnkpffwm2deamlgvffnxk26z622yfgo@fksfmpmm35ef>
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-4-anjo@rev.ng>
 <ed12dc41-afcb-410b-91dd-73ce4c958b02@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed12dc41-afcb-410b-91dd-73ce4c958b02@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 01/10/25, Philippe Mathieu-Daudé wrote:
> On 1/10/25 09:32, Anton Johansson wrote:
> > and update formatting in log.
> > 
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > ---
> >   target/riscv/cpu.h         | 2 +-
> >   target/riscv/cpu_helper.c  | 2 +-
> >   target/riscv/machine.c     | 2 +-
> >   target/riscv/tcg/tcg-cpu.c | 2 +-
> >   4 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 736e4f6daa..3235108112 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -279,7 +279,7 @@ struct CPUArchState {
> >       target_ulong geilen;
> >       uint64_t resetvec;
> > -    target_ulong mhartid;
> > +    uint64_t mhartid;
> >       /*
> >        * For RV32 this is 32-bit mstatus and 32-bit mstatush.
> >        * For RV64 this is a 64-bit mstatus.
> 
> 
> > diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> > index 99e46c3136..328fb674e1 100644
> > --- a/target/riscv/machine.c
> > +++ b/target/riscv/machine.c
> > @@ -425,7 +425,7 @@ const VMStateDescription vmstate_riscv_cpu = {
> >           VMSTATE_UINTTL(env.priv, RISCVCPU),
> >           VMSTATE_BOOL(env.virt_enabled, RISCVCPU),
> >           VMSTATE_UINT64(env.resetvec, RISCVCPU),
> > -        VMSTATE_UINTTL(env.mhartid, RISCVCPU),
> > +        VMSTATE_UINT64(env.mhartid, RISCVCPU),
> 
> The problem is you break the migration stream again. Maybe simpler to
> just squash with previous patch?
> 
> Thay said, IIUC mhartid is only set once in riscv_hart_realize().
> I suspect it is pointless to migrate it.

Right, wrt the other vmstate changes I only bumped the version on first
modification.  Maybe it makes more sense to group changes based on what
vmstate they touch?  If excessive version bumping is a problem that is.

