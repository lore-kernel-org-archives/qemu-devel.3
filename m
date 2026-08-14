Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D39C5B572
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 20:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuyVg-0008Sq-EQ; Fri, 14 Aug 2026 16:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wuyVf-0008SP-8O
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 16:28:11 -0400
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wuyVd-0005B5-9v
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 16:28:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=cUJ6RW0
 ZIfX/os+56ZkrWtcXcVkx6uxCq2wZUiEH7aUAHW5zVuy4tNmy01xpvhXgyWjLilopU33m5
 xKmbm1vAIjlih58/TJWK9b9ibUHWA2h7+Nwng0G9qlSOPnWUK9KzpuT4akfJhqQFFYCkRk
 +RbzqMm420XqXRNVWSPP8BJRjOu4+BjYU2m7y2u/L+3kDkP4xB8wuYsiJkIezQfgBaTCjb
 FIDxdxKjFbRePGD6pnEB2qw2TInsoIEkXatIB41FBIxjc9sYPW/msTzBZ+lMS/bopJ1i2D
 Ob/DkYF/B+Qwf8pBw5GvZ7YyhNjWDtpB22Q2deePihvqAkuCh3jajEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=X
 4RmfggyOqd7EQ2v0hVnL+oFatGri2ypJVcxLGWCkMo=;
 h=references:in-reply-to:
 subject:cc:to:from:date:dkim-signature:dkim-signature; d=mx.catap.net;
 b=WD5gvxmqV8dz6h7RhUMCFXva9SCIXCLNsNYO2QCTSiRd2MpeiRW7qsek88sybpJAADzk
 KScHklGEj9tpM9ZJA6046IYix3VEu0tYlCSExSl7kKWOOZ1nzpOeG5pKHJ6NHdjEFNCLs0
 gogP3Uwnad8D/7JAZKzt9cdSU1awOIi03/kphV1cji9wTTMRhveFWU/99v6Hbs8SEqGGOi
 cP/RTSDICC1j8jmNXd1nycDYSiUSJX5kSCi+hahsGAlhbCSneD8m9eearDyHg562rxaWJR
 y+B2OT6Im0iBUhTqV8TLBraUaYODuINjO46T/3T5wzYa9VTpz+Dk8BaI9TinwAEA==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=DoBrt+44; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=NzilajE9;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=X4Rmfggy
 Oqd7EQ2v0hVnL+oFatGri2ypJVcxLGWCkMo=; h=references:in-reply-to:
 subject:cc:to:from:date; d=korins.ky;
 b=DoBrt+44dMrlKWqMNfYCdeoXMDGXzB
 +UilBlIJk0Uj3qHD/K9wk1z/PbFzQEY9Mv4HOxeuQrxsjF56tMshnyXlXcnG66dA2EbQm2
 wPZHr6h3m333kfzb0lrQ56ZHwT5roOP6cNhFtXV0Q9J9j/roUSx0ropmSYpVGSqwwDrJzi
 n1vZSrsj4S31yGC78bkqSG2ieR0kY9LPoR0YU1X4QYIFSRxcVmtv34VOU2OUhjXupYyXxF
 j7W8mZzluXAUb1iOvscYVBqi5gEEbpiJhH2W5dSBCNtX3w/8Ud26mG7X/RmBgkI5ZA51Nb
 Rp4Z124Zf2WAiIOQvtBQ/4jG/DEeLiOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=X4RmfggyOqd7EQ2v0hVnL+oFatGri2ypJVcxLGWCkMo=; h=references:
 in-reply-to:subject:cc:to:from:date; d=korins.ky; b=NzilajE9TvoJ8QpNab
 3DKpJCXy+lLpy3F3y5+Y/3TBGqBQnPMCAyFRp2WY2sAA9h7BQ7uWFM65Mn2XfA6mF6Dw==
Received: by mx2.catap.net (OpenSMTPD) with ESMTPSA id 7443d3f7
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Fri, 14 Aug 2026 22:28:04 +0200 (CEST)
Received: by matebook.home.arpa (OpenSMTPD) with ESMTP id ab5a4b7c;
 Fri, 14 Aug 2026 22:28:02 +0200 (CEST)
Date: Fri, 14 Aug 2026 22:28:02 +0200
Message-ID: <87cxvkih0t.wl-kirill@korins.ky>
From: Kirill A. Korinsky <kirill@korins.ky>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 4/9] target/mips: drop hidden TLB shadowing for tlbwr
In-Reply-To: <026f1ddb-4725-4c3c-857c-a4adead18d7c@oss.qualcomm.com>
References: <20260713112004.4956-1-kirill@korins.ky>
 <20260713112004.4956-5-kirill@korins.ky>
 <026f1ddb-4725-4c3c-857c-a4adead18d7c@oss.qualcomm.com>
User-Agent: Wanderlust
Mail-Followup-To: philmd@oss.qualcomm.com, qemu-devel@nongnu.org,
 richard.henderson@linaro.org,
 "Kirill A. Korinsky" <kirill@korins.ky>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=65.21.79.163; envelope-from=kirill@korins.ky;
 helo=mx2.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

Hi Philippe,

Sorry for the very long reply.

I had some time to actually test it under stress to be sure.

On Tue, 28 Jul 2026 10:25:32 +0200,
Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> 
> Hi Kirill,
> 
> On 13/7/26 13:16, Kirill A. Korinsky wrote:
> > tlbwr replaces a random architectural TLB entry. Once that happens, the
> > evicted entry must stop translating guest virtual addresses.
> > 
> > The current helper keeps the evicted entry in QEMU-only extra TLB state.
> > That makes the old mapping survive until some later operation discards
> > the extra entries. A guest can observe this directly by writing through
> > a TLB mapping, replacing that entry with tlbwr, and writing through the
> > old virtual address again.
> > 
> > Invalidate the replaced entry instead of shadowing it. This keeps the
> > translated TLB state aligned with the architectural TLB contents.
> > 
> > Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
> > ---
> >   target/mips/tcg/system/tlb_helper.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
> > index 9772df5d6c..4c0a25e622 100644
> > --- a/target/mips/tcg/system/tlb_helper.c
> > +++ b/target/mips/tcg/system/tlb_helper.c
> > @@ -165,7 +165,7 @@ static void r4k_helper_tlbwr(CPUMIPSState *env)
> >   {
> >       int r = cpu_mips_get_random(env);
> >   -    r4k_invalidate_tlb(env, r, 1);
> > +    r4k_invalidate_tlb(env, r, 0);
> >       r4k_fill_tlb(env, r);
> >   }
> 
> This comes from commit 814b9a47490 ("MIPS TLB performance
> improvements, by Daniel Jacobowitz."), 20 years ago and is the
> single use of @use_extra. Should we remove it altogether,
> along with the @tlb_in_use index and r4k_mips_tlb_flush_extra,
> indeed reverting that commit?

No, I don't think that this code shall be reverted.

After weeks of testing I very confident that the issue is missed event ring
handling which I've posted here:
https://marc.info/?l=qemu-devel&m=178449808743198&w=2

With only this patch and octeon machine series, the VM survives different
stress tests, which includes a few bulds of gcc with 16 CPU for weeks.

And USB was used as the only disk.

No deadlock or missed interrupts were observed so far.

-- 
wbr, Kirill

