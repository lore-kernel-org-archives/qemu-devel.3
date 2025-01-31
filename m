Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1092C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 16:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdtir-0007vK-RS; Fri, 31 Jan 2025 11:18:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tdtin-0007v1-CF; Fri, 31 Jan 2025 11:18:21 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tdtil-00012c-8T; Fri, 31 Jan 2025 11:18:20 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7CDF65C2511;
 Fri, 31 Jan 2025 16:17:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597E5C4CED1;
 Fri, 31 Jan 2025 16:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738340297;
 bh=+DKv5p5gtr/qhVvWh4VwKvw+q8ap1xODp8LMl0FjSLA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=lnLB8DrXKJwyzfLcdlDTYUyTZB+XsYmVs1/BWFMCFkQCBUaYmMTPG3LorYW97DY8q
 x9VtBYrXOMeVPxAs/U/lkP268bqg6WFUr79FymjuCk0u6k79iPxxWeuPakJ7CeBFmt
 MXhuSMmI5/WpddygbxZlEoqKO0xyiTRb0UZ9fFY4Khz2ubCwGYe7w6yMMDN+WQCXb7
 uMbx13/O6F9Zs+g7SUV1Spsu3kuxBmbZ5ofnscv0hXADi0wFkPfppa0CgHFiVVz+IL
 HtefOVT1j9EM49Ee9UAkLdVM/H9BcCfC+l7GN5yft12vwYoyjQYV2B6qW21ktzkM7G
 0THzba+BGbLoA==
Date: Fri, 31 Jan 2025 17:18:12 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/13] tests/acpi: virt: allow acpi table changes for
 a new table: HEST
Message-ID: <20250131171812.2ad9b1fd@foz.lan>
In-Reply-To: <20250130153830.2e4e081d@imammedo.users.ipa.redhat.com>
References: <cover.1738137123.git.mchehab+huawei@kernel.org>
 <1390b46682f2bac3587239d03a0ba22d18a9a044.1738137123.git.mchehab+huawei@kernel.org>
 <20250129160328.2f66584c@imammedo.users.ipa.redhat.com>
 <20250130140324.06cdd4bf@foz.lan>
 <20250130153830.2e4e081d@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Em Thu, 30 Jan 2025 15:38:30 +0100
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Thu, 30 Jan 2025 14:03:24 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Em Wed, 29 Jan 2025 16:03:28 +0100
> > Igor Mammedov <imammedo@redhat.com> escreveu:
> >   
> > > On Wed, 29 Jan 2025 09:04:08 +0100
> > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > >     
> > > > The DSDT table will also be affected by such change.
> > > > 
> > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>      
> > > 
> > > move it right before the patch that would actually make changes to tables (10/13)    
> > 
> > Table changes happens on two patches:
> > 
> > - patch 03/13: acpi/ghes: add a firmware file with HEST address  
> 
> this one shouldn't affect bios tables test as it only checks ACPI and SMBIOS tables,
> and hest addr file is not either.

Heh, true.

> Do you really see test failing on this patch?

No. I just misunderstood the instructions, as it was not clear to me there 
that I shouldn't be adding there the HEST table.

> > 	HEST table was added here
> > 
> > - patch 10/13: arm/virt: Wire up a GED error device for ACPI / GHES 
> > 
> > 	DSDT changes happen here.
> > 
> > If the idea is to avoid make check to fail between those two patches,
> > we need either to split them on 4 patches (one before/one after each
> > change) or do like I did on this series: whitelist before patch 3,
> > update after patch 10.  
> 
> It would be better to group patches that should change ACPI tables
> close together so that a pair of whitelist/update could cover it.
> However it depends on how many changes are there, i.e. acpi diff
> should be digestible for a reader. So there is no hard border here,
> just use common sense.
> 
> However when the whitelist is covers all series where only few patches
> actually result in tables change, that miss-leads the reader since
> whitelist patch basically tells 'watch out for changes since this moment'
> and 'update' patch declares no more changes should happen.
> The same applies to bisection, where closer the gap between
> whitelist/update the better if the test case is the trigger.
> No need to be fanatical and do it around each patch,
> just make it observable (i.e. some small range of commits). 

Got it. Yeah, there was just one patch affecting DSDT table: the one
adding an AML representation for the GED notification device.

I fixed it for the next (hopefully the final) version.

Thanks,
Mauro

