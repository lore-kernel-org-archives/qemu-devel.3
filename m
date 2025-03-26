Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CEBCC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 12:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txQ5q-000614-Hs; Wed, 26 Mar 2025 08:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1txQ5Q-0005bZ-7o
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 08:42:29 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1txQ5F-0000rB-75
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 08:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=UsrpfnQ7Tlb9qhFfqhes7AUBkBJQIFGBWZHNAKpN02k=; b=K5qs5Q4Zv4t94Fc
 qH8UhMMYFcuhGklA0nGfZLqO676lyrcSti4nuXvt24qndFA89HpuXh2UeYd6XJNHSg0oMsgL6Dcxz
 jGlw6/NQPn3UD53Q2lT8EirWAGlglDYdVeQWVvj/aHrA2u7de13/89iuJWJPGiP4wEpH51J1cM+LI
 VY=;
Date: Wed, 26 Mar 2025 13:42:35 +0100
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org, ale@rev.ng, 
 philmd@linaro.org
Subject: Re: [PATCH 2/2] target/hexagon: Drop `ident` postprocess step
Message-ID: <cg2nuphin6qlonwamvagphgdiky22uq3oaxqux5rwwthyimzbh@m5aq6yrw3i4k>
References: <20250312194547.7364-1-anjo@rev.ng>
 <20250312194547.7364-3-anjo@rev.ng>
 <001501db9d28$affce200$0ff6a600$@gmail.com>
 <e02be58e-9459-4799-8725-c7831169c89a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e02be58e-9459-4799-8725-c7831169c89a@oss.qualcomm.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-to:  'Anton Johansson' <anjo@rev.ng>
From:  'Anton Johansson' via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 25/03/25, Brian Cain wrote:
> 
> On 3/24/2025 8:53 PM, ltaylorsimpson@gmail.com wrote:
> > 
> > > -----Original Message-----
> > > From: Anton Johansson <anjo@rev.ng>
> > > Sent: Wednesday, March 12, 2025 2:46 PM
> > > To: qemu-devel@nongnu.org
> > > Cc: ale@rev.ng; ltaylorsimpson@gmail.com; brian.cain@oss.qualcomm.com;
> > > philmd@linaro.org
> > > Subject: [PATCH 2/2] target/hexagon: Drop `ident` postprocess step
> > > 
> > > The indent command is not available on a default mac osx setup with xcode
> > > cli tools installed.  While it does make idef-parser generated code nicer
> > to
> > > debug, it's not crucial and can be dropped.
> > > 
> > > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > > ---
> > >   target/hexagon/meson.build | 21 ++-------------------
> > >   1 file changed, 2 insertions(+), 19 deletions(-)
> > > 
> > > diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
> > > index abcf00ca1f..246dc7b241 100644
> > > --- a/target/hexagon/meson.build
> > > +++ b/target/hexagon/meson.build
> > > @@ -323,30 +323,13 @@ if idef_parser_enabled and 'hexagon-linux-user' in
> > > target_dirs
> > >           command: [idef_parser, '@INPUT@', '@OUTPUT0@', '@OUTPUT1@',
> > > '@OUTPUT2@']
> > >       )
> > > 
> > > -    indent = find_program('indent', required: false)
> > > -    if indent.found()
> > > -        idef_generated_tcg_c = custom_target(
> > > -            'indent',
> > > -            input: idef_generated_tcg[0],
> > > -            output: 'idef-generated-emitter.indented.c',
> > > -            command: [indent, '-linux', '@INPUT@', '-o', '@OUTPUT@']
> > > -        )
> > > -    else
> > > -        idef_generated_tcg_c = custom_target(
> > > -            'copy',
> > > -            input: idef_generated_tcg[0],
> > > -            output: 'idef-generated-emitter.indented.c',
> > > -            command: ['cp', '@INPUT@', '@OUTPUT@']
> > > -        )
> > > -    endif
> > > -
> > I prefer to have the indented version present.
> > 
> > Is the above check/fallback not sufficient on MacOS?  It works on a Linux
> > system where indent is not present.
> 
> 
> Aside: could using "clang-format" be another approach?  I suppose it's just
> exchanging one dependency for another, but maybe xcode comes w/this tool? 
> Then again, maybe it would be an inconvenient dependency on linux systems?
> 
> 
> 
> > Thanks,
> > Taylor

Sorry, I misspoke in the commit message. The problem does not occur for a
default xcode commandline tools install, but when the user has installed
indent via homebrew or some other source. I don't have access to a mac
at this moment so I cannot verify, but I think `-linux` is not
supported.

If we want to handle this situation we can either expand `-linux` into
it's constituent flags or add a `host_os == 'linux'` condition.

