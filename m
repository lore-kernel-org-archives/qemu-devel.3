Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5019CA0EE8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 06:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uylYF-0005bL-Jk; Wed, 17 Sep 2025 02:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uylYB-0005Wj-Gf; Wed, 17 Sep 2025 02:21:57 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uylY8-0006ik-Q2; Wed, 17 Sep 2025 02:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758090113; x=1789626113;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=rkk9BsNXl5Rvdut7FbzSncKbNWxRPvemZchr5iug/J0=;
 b=N1AWA8g1MdebW6iGnVEv6VnVQP8WJ/iGEjJ9BgeDhHiaRMi1l4BI8lop
 us1+lPrWfB6Ijr/O67KawlVa31JoH4FoPGGrVGggNfKLMUJlehzXPlQqN
 hfr/hBf/CDETZbo7rmOQ5/ueTEf15mMfIp8tjbmmJX2BUTNawsMO6LiwB
 asSsvc9+SI7BZQ32Q0zMfxpNLsv0YVgLU8OA9P0hSCv+jp553Q2e4X+m5
 wYFMccpO4dbfCFaKy7olmUkNLArmewgXsTfEQYStuWbhWn8VIA9ri95Yk
 BfXe08HomuLzRBxMHu0no77RerYuGoGdDbwCk6cJW45DiOCqdMiu7TLBe w==;
X-CSE-ConnectionGUID: XrHGQBZZRr2yREIj2DRhRg==
X-CSE-MsgGUID: 6QGt+HS3RReCwTBbFlMbEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="77825697"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; d="scan'208";a="77825697"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2025 23:21:49 -0700
X-CSE-ConnectionGUID: iBujJ8ACSoCoJ36aY/BOOA==
X-CSE-MsgGUID: UQh5KPfTRpm8zrOj2vUrGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; d="scan'208";a="212310402"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 16 Sep 2025 23:21:48 -0700
Date: Wed, 17 Sep 2025 14:43:42 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: Re: [PATCH 01/12] subprojects: Update .gitignore for proc-macro2 and
 syn
Message-ID: <aMpYnncKrxrkiBys@intel.com>
References: <20250916085557.2008344-1-zhao1.liu@intel.com>
 <20250916085557.2008344-2-zhao1.liu@intel.com>
 <CAAjaMXaLvSV=nfd8m4Q-RPTx4jpWisDpeH6J6rgTke4Mox=8pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAjaMXaLvSV=nfd8m4Q-RPTx4jpWisDpeH6J6rgTke4Mox=8pw@mail.gmail.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, Sep 16, 2025 at 12:58:24PM +0300, Manos Pitsidianakis wrote:
> Date: Tue, 16 Sep 2025 12:58:24 +0300
> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Subject: Re: [PATCH 01/12] subprojects: Update .gitignore for proc-macro2
>  and syn
> 
> On Tue, Sep 16, 2025 at 11:34 AM Zhao Liu <zhao1.liu@intel.com> wrote:
> >
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >  subprojects/.gitignore | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/subprojects/.gitignore b/subprojects/.gitignore
> > index f4281934ce11..9d579f72d121 100644
> > --- a/subprojects/.gitignore
> > +++ b/subprojects/.gitignore
> > @@ -16,7 +16,7 @@
> >  /libc-0.2.162
> >  /proc-macro-error-1.0.4
> >  /proc-macro-error-attr-1.0.4
> > -/proc-macro2-1.0.84
> > +/proc-macro2-1.0.95
> >  /quote-1.0.36
> > -/syn-2.0.66
> > +/syn-2.0.104
> >  /unicode-ident-1.0.12
> > --
> > 2.34.1
> >
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Thanks!

> Maybe we could change the entries to match any directory with a version, e.g.
> 
> /proc-macro2-[0-9.]*/

Here I prefer exact matching, as it allows for timely cleanup of outdated
subprojects.

Regards,
Zhao


