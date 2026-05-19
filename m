Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B788CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 13:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPKpP-0005x4-Tn; Tue, 19 May 2026 09:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wPKpO-0005tw-IW
 for qemu-devel@nongnu.org; Tue, 19 May 2026 09:49:46 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wPKpL-0003cf-5g
 for qemu-devel@nongnu.org; Tue, 19 May 2026 09:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=7+i+4vxEN6TFKfcdM2g4y0Bknb+Gn8mILSxMFzAXsxo=; b=Iw8ADB8HJuN11Ca
 S2LOhW0NG7W+zKu2LCj3FR5RQxuJvkAnsrLFzNw8VjYqH3ZIdrwe1zgFwmhJUTxgysjJa5qrl4Q8g
 B2NpP7kh1RWLmiqaSF/Iqy14TtNmtP7rymY5CEeCrWnWC0w9NJw8tLXJ+T9ZBvvOSnFr8WmwpFRch
 Ww=;
Date: Tue, 19 May 2026 15:54:19 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, 
 alistair.francis@wdc.com
Subject: Re: [PATCH v6 16/27] target/riscv: Fix size of irq_overflow_left
Message-ID: <agxrNwt30D2Hxxav@hive.localdomain>
References: <20260515180437.23620-1-anjo@rev.ng>
 <20260515180437.23620-17-anjo@rev.ng>
 <ac41251a-d66f-47e3-8757-7c998464889e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac41251a-d66f-47e3-8757-7c998464889e@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 17/05/26, Philippe Mathieu-Daudé wrote:
> On 15/5/26 20:04, Anton Johansson wrote:
> > Fix to 64 bits to hold all relevant values.
> > 
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > Acked-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >   target/riscv/cpu.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index e9d3bed6f9..269bc07e2d 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -224,7 +224,7 @@ typedef struct PMUCTRState {
> >       /* Snapshot value of a counter */
> >       uint64_t mhpmcounter_prev;
> >       /* Value beyond UINT32_MAX/UINT64_MAX before overflow interrupt trigger */
> 
> Should we update the comment?

Right, I'll do that: "Value beyond INT64_MAX ..." seems correct to me.

-- 
Anton Johansson
rev.ng Labs Srl.

