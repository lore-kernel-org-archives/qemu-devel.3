Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F54CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 17:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP1SA-0003Zt-P7; Mon, 18 May 2026 13:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wP1S9-0003Zf-GS; Mon, 18 May 2026 13:08:29 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wP1S7-0004fB-7P; Mon, 18 May 2026 13:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=XzIbbkW9drCynrbaKJgfN4ziXVO5gtNtfEAeSVZk7Ho=; b=oS+QdP7knyIJVyc
 zKIb3BvDTHueEdlyccUt8vNyZeu16eRKRP1Gb4Yjtyf2PD/h0tAwl0VBODEMJ4q3G4KmG5Vn++0GR
 UnwQCkkdhSKfnUIItviqH36iQN2HsOgtbUnnOv0Fh01Ql1i678/1eI7FEC1KI/k7S6fwg41ZEOSnf
 ho=;
Date: Mon, 18 May 2026 19:12:58 +0200
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jay Chang <jay.chang@sifive.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: Re: [PATCH v4 2/2] target/riscv: Use macros for PMP address alignment
Message-ID: <agtIdAd7kotsFSlS@hive.localdomain>
References: <20260518070725.9816-1-jay.chang@sifive.com>
 <20260518070725.9816-3-jay.chang@sifive.com>
 <3bb15715-b11e-46a6-bba5-46a85c036632@linaro.org>
 <ccb35d50-514d-4b17-8018-8d6bf58934f8@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ccb35d50-514d-4b17-8018-8d6bf58934f8@oss.qualcomm.com>
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

On 18/05/26, Daniel Henrique Barboza wrote:
> 
> 
> On 5/18/2026 4:19 AM, Philippe Mathieu-Daudé wrote:
> > On 18/5/26 09:07, Jay Chang wrote:
> > > Replace manual bit manipulation with alignment macros for better
> > > readability:
> > > 
> > > - TOR: Use ROUND_DOWN() to clear lower bits
> > > - NAPOT: Use ROUND_UP() to set lower bits
> > > 
> > > The behavior remains unchanged.
> > > 
> > > Signed-off-by: Jay Chang <jay.chang@sifive.com>
> > > ---
> > >   target/riscv/pmp.c | 14 +++++++++-----
> > >   1 file changed, 9 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> > > index de2157c830..238c7c5162 100644
> > > --- a/target/riscv/pmp.c
> > > +++ b/target/riscv/pmp.c
> > > @@ -247,8 +247,9 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
> > >       case PMP_AMATCH_TOR:
> > >           /* Bits pmpaddr[G-1:0] do not affect the TOR address-matching logic. */
> > >           if (g >= 1) {
> > > -            prev_addr &= ~((1ULL << g) - 1ULL);
> > > -            this_addr &= ~((1ULL << g) - 1ULL);
> > > +            target_ulong granule = 1ULL << g;
> > 
> > Maybe better to directly use uint64_t, in preparation of
> > https://lore.kernel.org/qemu-devel/20260515180437.23620-1-anjo@rev.ng/
> 
> Can we please CC qemu-riscv@nongnu.org for the next version? This might
> be the first time the RISC-V reviewers are made aware that this series
> exists.  It surely is my first time :D

That's on me, will do!:)

-- 
Anton Johansson
rev.ng Labs Srl.

