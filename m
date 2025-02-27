Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06157C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 15:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tngFD-0002KG-Ms; Thu, 27 Feb 2025 10:56:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tngFB-0002Jc-CI; Thu, 27 Feb 2025 10:56:13 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tngF8-0006JZ-FL; Thu, 27 Feb 2025 10:56:13 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 864215C54FF;
 Thu, 27 Feb 2025 15:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F349C4CEDD;
 Thu, 27 Feb 2025 15:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1740671765;
 bh=4XS/w8try2ACKldK10vEqyRkeuzlJ94ggQX1TVhimIo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=DJVvX8bgnM1Jhf6pxMjjppij2hlo+Src2FEWjX/NJSALnw9Kzrb6D7q5NI4qjoJdQ
 gBXgDlvII2zh0LKKIS7Qay3V5+RIacVvXtWDRxD5ueL9hnXV8+w5LJRv+jH1grSB78
 E5ebxNYzkuRKk0C19f96t77Upv4lAYzodoC8/troFcn6NDvtjQFnjMwI7prp/iO/EX
 Ah34a152RATvOfXSZIrXmoHSVFnC3FZwb3h8ikzfVvO8atpUjI0YUAUfvZNLql4Car
 b6tnRpVFwYBUttXx/yXPFnik6FIqL6odEH/gbjJAn09XcAWmUBjj+GFwT5T1ossxGg
 tscYM0guOszGw==
Date: Thu, 27 Feb 2025 16:56:00 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 17/21] tests/acpi: virt: update HEST table to accept
 two sources
Message-ID: <20250227165600.16a74895@foz.lan>
In-Reply-To: <20250227165124.221ef1b2@foz.lan>
References: <cover.1740653898.git.mchehab+huawei@kernel.org>
 <9d57e2a6ec3f523eb7691347403f05ad40782b94.1740653898.git.mchehab+huawei@kernel.org>
 <20250227141038.28501d73@imammedo.users.ipa.redhat.com>
 <20250227141603.3957e78b@imammedo.users.ipa.redhat.com>
 <20250227165124.221ef1b2@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -74
X-Spam_score: -7.5
X-Spam_bar: -------
X-Spam_report: (-7.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Em Thu, 27 Feb 2025 16:51:24 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Thu, 27 Feb 2025 14:16:03 +0100
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > On Thu, 27 Feb 2025 14:10:38 +0100
> > Igor Mammedov <imammedo@redhat.com> wrote:
> >   
> > > On Thu, 27 Feb 2025 12:03:47 +0100
> > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > > 
> > > squash this patch into the next one
> > > 
> > > Also at this point there is no visible HEST changes yet, so a soon as you remove
> > > white-list without enabling new HEST, the tests should start failing.
> > > 
> > > I suggest to move 20/21 before this patch,
> > > as result one would see dsdt and hest diffs when running tests
> > > and then you can use rebuild-expected-aml.sh to generate updated
> > > tables and update them in one patch (that's what we typically do,
> > > we don't split updates in increments).    
> > 
> > on top of that,
> > it seems the patch doesn't apply for some reason.  
> 
> Hmm... perhaps the diffstat that I place here (produced by bios-tables-test
> output) is causing some confusion when you're trying to apply the patch.
> 
> Any suggestions to avoid that?

Nevermind. I fixed by removing the name of the file before the diff, e.g.
the description is now:

  tests/acpi: virt: update HEST and DSDT tables
    
    - The HEST table now accept two sources;
    - The DSDT tables now have a GED error device.
    
    @@ -1,39 +1,39 @@
     /*
      * Intel ACPI Component Architecture
      * AML/ASL+ Disassembler version 20240322 (64-bit version)
      * Copyright (c) 2000

...

Regards,
Mauro

