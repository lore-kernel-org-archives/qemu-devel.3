Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314D0CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 06:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcznC-0007i8-PR; Fri, 26 Jun 2026 02:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1wcznA-0007hy-2U
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 02:11:56 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1wczn8-0008Id-7E
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 02:11:55 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 30C3C43F69;
 Fri, 26 Jun 2026 06:11:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D88B1F00A3D;
 Fri, 26 Jun 2026 06:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782454305;
 bh=cHpPxak8ar0tO5SS2LI5zB4TQj0hoiurPZWrQ6MM8RA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ASjDxDMwJ4y03PSIVnFGqFc25S4P8Hen9Dkemejv5fu7hYqy4ybj1wemgXAsivS0k
 jgh/1YrEsC0/eeUk7RUJ4FepnXgd9X4nPR0nRB+dUwVT4D/uxCeW8Cw6SidqNwcLaD
 a+F/0+JqVO6V/X780/VTS07lHp1rMcnECcLbIohZfN1dpF8MsKHvw4PteX9zPgjx2d
 PjX4MYwaNEuaYdtkyt+7p4CrXM4jGmZF95UjsvCcRU4ukqfPavqt6VPrn0FmYwKQjl
 DyzDgSeOtEchMltPzwYEsKPAwpRwPGrFrM5mTt4Dt40kWOXUvsY4HidJhdgdqUURij
 17e8AzdJaLH8Q==
Date: Fri, 26 Jun 2026 11:39:59 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, 
	qemu-devel <qemu-devel@nongnu.org>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Nikunj A Dadhania <nikunj@amd.com>, 
 Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
 Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Srikanth Aithal <srikanth.aithal@amd.com>, 
 Kim Phillips <kim.phillips@amd.com>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v4 0/9] target/i386: SEV: Add support for enabling VMSA
 SEV features
Message-ID: <aj4XGXdOqxM1TYnQ@blrnaveerao1>
References: <cover.1779281646.git.naveen@kernel.org>
 <aifFPGfS8sv9WPgk@blrnaveerao1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aifFPGfS8sv9WPgk@blrnaveerao1>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=naveen@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Paolo,

On Tue, Jun 09, 2026 at 01:20:58PM +0530, Naveen N Rao wrote:
> Hi Paolo,
> 
> On Wed, May 20, 2026 at 06:57:53PM +0530, Naveen N Rao (AMD) wrote:
> > This series adds support for enabling VMSA SEV features for SEV-SNP 
> > guests through the Qemu command line. This is already supported for IGVM 
> > files, so some of that code has been generalized and reused.
> > 
> > The primary change w.r.t v3 (apart from rebasing and targeting v11.1) is 
> > a change to patch 6/9 to restrict debug-swap to SEV-SNP guests due to a 
> > compatibility issue with SEV-ES guests and pflash, discussed here:
> > http://lore.kernel.org/r/fcqjl5a7m27f2mfpblnhgmozbipdjmvpdyk3m5hhzwcenp4cpg@m2ooa7ykrcvs
> > 
> > I plan to post a workaround for that separately. For that reason, I have 
> > retained patch 5/9 so that enabling debug-swap for SEV-ES guests will be 
> > a simpler subsequent change.
> > 
> > The only other concern has been around patch 8/9 adding a new 
> > tsc-frequency property on sev-snp-guest object (and not re-using the one 
> > on the cpu object). If that's required/possible, I would appreciate some 
> > help since I've been unable to get that working.
> 
> Can you please review and let me know if you have any concerns with this 
> series?

There has only been a small change suggested on patch 2/9 from Daniel so 
far. Assuming no other concerns with this series, please let me know if 
you can squash that change in, or if you want me to re-post this series.


Thanks,
Naveen


