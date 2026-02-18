Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FC3E9A04B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 19:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsnaF-0002fp-S9; Wed, 18 Feb 2026 14:51:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vsnaE-0002fh-BC
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 14:51:38 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vsnaC-0000RT-Q5
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 14:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=7RfK2ubIEvLD/tHpKyvSNaPEdsc2wHffz49yO7B5wGk=; b=bFHqyeq+Oog8YFZ
 zIAuHGNYeIBEs7TvBgLtfiuJrzWgB3QeVAoeNinMytKr+8It+sRmgwO3rqKzeWyoOWF7ZRz4MAwvp
 tzameSGvpfqk7NWfTDdfaxgszuN319KQW3+eLmclpUW+0DUm+KeQlfMHsYzW/GjOcDfrXmOZeaBEF
 lI=;
Date: Wed, 18 Feb 2026 20:55:10 +0100
To: Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org, 
	Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 0/4] hppa: Add simple C3600 machine with PA-8600 CPU
Message-ID: <aZYYIfiomDjmB-zn@hive.localdomain>
References: <20260210-hppa-c3600-v2-0-9ca09c677012@rev.ng>
 <5ba38c75-e1c6-41cc-9a5d-b81c22527993@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ba38c75-e1c6-41cc-9a5d-b81c22527993@gmx.de>
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

On 10/02/26, Helge Deller wrote:
> On 2/10/26 17:37, Anton Johansson via qemu development wrote:
> > This patchset tries to address a discrepancy between the C3700 machine
> > in QEMU/SeaBIOS and the documentation (chapter 5)
> > 
> >    http://ftp.parisc-linux.org/docs/whitepapers/PA-8700wp.pdf
> > 
> > where 40 bits of physical address space are used in SeaBISO compared
> 
> SeaBIOS (typo)
> 
> > to the 44 bits specified in the documentation.
> > 
> > A PA-8600 CPU with 40 bits of physical address space is added along with
> > a C3600 machine using it by default.  AFAICT there are no major
> > differences from QEMUs side between the PA-8600 and 8700 aside from the
> > physical address space size.  The PA-8700 machine can then be
> > moved to using 44 bits.  To account for the discrepancy with SeaBIOS, the
> > functional tests now run a C3700 but with a PA-8600 CPU.
> > 
> > CPU model definitions now inherit from a TYPE_HPPA_CPU base class and
> > use a HPPACPUDef sturct to provide model specifics, similar to the SPARC
> > and RISCV targets.  This hopefully makes it easier to add other models,
> > such as the 8800/8900.
> > 
> > Based on:
> >    PATCH v4 0/8] single-binary: Drop TARGET_PHYS_ADDR_SPACE_BITS
> >    (20260210-phys_addr-v4-0-725a589e83c8@rev.ng)
> > 
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> 
> I like your patchset.
> I'm just wondering if we should merge it with my upcoming new SeaBIOS,
> which adds support for an A400 machine (with a PA8500 CPU).
> So, instead of adding a C3600 machine, we could add the A400 which
> has 40-bit physical addresss space too.
> See:
> https://github.com/hdeller/seabios-hppa/branches -> devel-v22 branch
> and
> https://github.com/hdeller/qemu-hppa/commit/1c969c925fb76236e76b09e011f07766ab4441cb
> 
> In addition, I wonder what's necessary to change in SeaBIOS to fully
> support the 40 and/or 44-bit case. It's easy to hand over the bits to
> SeaBIOS, so SeaBIOS could do the right thing.
> 
> Helge
> 

Hi Helge,

I submitted a rebased v3 with some minor spelling fixes.  If you want
you can pick up the series, otherwise I'll swap out the C3600/PA-8600
for a A400/PA-8500 and keep pushing it, whatever is easier for you.

I need to look into the A400, is there some other change from the C3600
I should be aware of?

//Anton

