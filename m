Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8D8606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=rev.ng header.i=@rev.ng header.a=rsa-sha256 header.s=dkim header.b=i3kohUDT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOvMB-0007xO-00; Thu, 05 Nov 2026 06:10:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xOvM9-0007wS-FR
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 06:10:09 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xOvM7-0001qv-UH
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 06:10:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=ZDgosfeoU5a29Xl9DIh5MzdYw6vGNA/RrfZMOaBQhhc=; b=i3kohUDTpbjlWWD
 L2ttFEB0q1D8bc6WGMOU4mtzriMwj3CdvFlqusOj6k/oj23kml6KT8gqDZc09+Fg6LEDifFy+8e5K
 s2b4G5bhjXEMs9bAt9+9c5ieVfViXQi9+bs0vVZNaAxhtJqAx2wCoIEL+Ol47X9+/fBrVNiTFsdSW
 6I=;
Date: Thu, 5 Nov 2026 12:15:26 +0100
To: Marco Liebel <marco.liebel@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, ale@rev.ng, brian.cain@oss.qualcomm.com
Subject: Re: [PATCH v1 0/6] target/hexagon: Misc HLX fixes
Message-ID: <auxlJi2zq7VCZS59@hive.localdomain>
References: <20261103192358.28589-1-anjo@rev.ng>
 <CAJ+KCYPaeruULiu8Y+bNYQvZosN1N98SntmF6vphF8tQSvV3hQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+KCYPaeruULiu8Y+bNYQvZosN1N98SntmF6vphF8tQSvV3hQ@mail.gmail.com>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 04/11/26, Marco Liebel wrote:
> On Tue, Nov 3, 2026 at 1:18 PM Anton Johansson <anjo@rev.ng> wrote:
> >
> > Hi,
> >
> > I was too slow on the review before the series got PRd, so I'll
> > submit these preliminary fixes instead.  Not included here is a
> > fix for --disable-hexagon-idef-parser being broken with the new
> > stub HMX helpers.
> >
> >
> > Anton Johansson (6):
> >   target/hexagon: HLX, preserve scalar :mem_noshuf ordering
> >   target/hexagon: HLX, search for .new values in pair high register
> >   target/hexagon: Forward return address to HLX load/store helpers
> >   linux-user/hexagon: Reset hlx_ctx pointer on cpu clone
> >   tests/tcg/hexagon: test HLX scalar :mem_noshuf ordering
> >   tests/tcg/hexagon: HLX, test .new on pair high register
> >
> >  linux-user/hexagon/target_cpu.h     |  1 +
> >  target/hexagon/macros.h             | 13 +++++++----
> >  target/hexagon/decode.c             | 20 +++++++++++++++--
> >  target/hexagon/hlx_helper.c         | 31 +++++++++++++++++--------
> >  target/hexagon/translate.c          |  7 +++---
> >  tests/tcg/hexagon/hlx_assign_conv.c | 35 +++++++++++++++++++++++++++++
> >  tests/tcg/hexagon/hlx_mem.c         | 22 ++++++++++++++++++
> >  7 files changed, 111 insertions(+), 18 deletions(-)
> >
> > --
> > 2.52.0
> >
> 
> General note: I think combining patch 1+5 and 2+6 would make sense,
> because then it's easier to reason about them and give feedback,
> since they belong together.
> 

Right, will do! :)

-- 
Anton Johansson
rev.ng Labs Srl.

