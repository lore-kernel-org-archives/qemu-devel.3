Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DA9CAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 09:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3AK9-0002Yd-Ed; Mon, 29 Sep 2025 05:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v3AJz-0002Y9-VF
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 05:37:27 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v3AJq-0005Kf-Jk
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 05:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=80Dr2gIhp/Kq0rHAEWQ+/7pm+Z421V3nfZeCo0d0pXM=; b=qfl6dvHCfcYkwuO
 4vyI6rOzH0Kz3bGtywjRwdE4HGpPtyqDL3xWaxmhFvwDgw0WgTbo6IRCBmOI9+PXI+4JW294pR3tz
 jckKrysl3iHgPSJg+B5hFMm8DmF23W+pdH6H+LusfzgcHTwI25KM4bxMEl6n8K2wdpOeQbu5cQ5nm
 7M=;
Date: Mon, 29 Sep 2025 11:39:48 +0200
To: Alistair Francis <alistair23@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
	qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 02/34] target/riscv: Fix size of trivial CPUArchState
 fields
Message-ID: <b3onx34e5csnxtsrttjbx2bu3ayzkyce4hfiqlrm32kuogibof@ow5z4z2ewan7>
References: <20250924072124.6493-1-anjo@rev.ng>
 <20250924072124.6493-3-anjo@rev.ng>
 <63d16a48-f5ad-4357-a33b-09a157d33826@linaro.org>
 <CAKmqyKP6oeF5Xy868A3D=4yZR5_=gFbSt9J2wzPB7Gr1RmO2dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKP6oeF5Xy868A3D=4yZR5_=gFbSt9J2wzPB7Gr1RmO2dQ@mail.gmail.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  "anjo@rev.ng" <anjo@rev.ng>
From:  "anjo@rev.ng" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 29/09/25, Alistair Francis wrote:
> On Thu, Sep 25, 2025 at 7:37 AM Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 9/24/25 00:20, Anton Johansson via wrote:
> > > +++ b/target/riscv/machine.c
> > > @@ -84,13 +84,13 @@ static const VMStateDescription vmstate_hyper = {
> > >       .minimum_version_id = 4,
> > >       .needed = hyper_needed,
> > >       .fields = (const VMStateField[]) {
> > > -        VMSTATE_UINTTL(env.hstatus, RISCVCPU),
> > > -        VMSTATE_UINTTL(env.hedeleg, RISCVCPU),
> > > +        VMSTATE_UINT64(env.hstatus, RISCVCPU),
> > > +        VMSTATE_UINT64(env.hedeleg, RISCVCPU),
> >
> > You can't change these sizes without bumping the version id.
> >
> > I don't know if riscv really cares about migration stability yet.
> > If it does, then you have to jump through more hoops.
> 
> Not really, I think a version bump would be enough
> 
> Alistair

Thanks, I will address this in v2.

//Anton

