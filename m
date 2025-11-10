Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63AFACCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 10:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIP6E-0000kD-EU; Mon, 10 Nov 2025 05:26:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1vIOwK-0002iE-EP
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 05:16:12 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1vIOwI-0007y1-TO
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 05:16:00 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E78B560145;
 Mon, 10 Nov 2025 10:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB962C4CEFB;
 Mon, 10 Nov 2025 10:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762769749;
 bh=w7AT9elMGsxzEOMWWxfdjapKGh8rWLTtg/U6RbvGLy0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=L24agC5Rf2VqpGP8oHZeO7s8oCeoQW9VtxYLOxq4m03iOYfCpW2W3YZ7qS5c1S+AM
 tcJzNX7xP7+obwqPOawx8YDxHHiYVnk0RrtOp3xV396jlbXcPwLwzjOx3KqmqhT44L
 S/piK6Q8uWWX7tLM18DFrkg64Uw9GfO7GyraUnMZwFl8eGdH5ZKD30CqLuPgopZI97
 jpAZ3viBmYRVrwWNrwNGaUQL2JUEmJJii8U0HMW/pGBpRYrqXrovIZeaJ+8XyJG05X
 JGpDyIdE1GbBCqRcCUx+veXAIrc8MlcBz8RJOiMK+fBwQKv3j5nuW8N2ULxOpoRLkP
 MQhwaGp8al7Sg==
Date: Mon, 10 Nov 2025 15:42:59 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Michael Roth <michael.roth@amd.com>, Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Srikanth Aithal <srikanth.aithal@amd.com>
Subject: Re: [PATCH v3 8/9] target/i386: SEV: Add support for setting TSC
 frequency for Secure TSC
Message-ID: <ujwabh5smtas6cxmfrelhcw7x4yqrsfnyhga5ya5xf4rwjpn6d@oog37nj2fb6d>
References: <cover.1761648149.git.naveen@kernel.org>
 <cc40fed64f62649891bb8234daaba8a5cc926695.1761648149.git.naveen@kernel.org>
 <87cy5vgy66.fsf@pond.sub.org>
 <ot37mpc4y2oferchx6yroyriqickajnkiouok7quaaijq25c7n@cpqitwnuwyz2>
 <aQ3DEiKtuRf_bfqS@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQ3DEiKtuRf_bfqS@redhat.com>
Received-SPF: pass client-ip=172.105.4.254; envelope-from=naveen@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Nov 07, 2025 at 09:59:46AM +0000, Daniel P. Berrangé wrote:
> On Fri, Nov 07, 2025 at 02:21:24PM +0530, Naveen N Rao wrote:
> > On Thu, Nov 06, 2025 at 01:09:37PM +0100, Markus Armbruster wrote:
> > > Pardon my ignorance...
> > > 
> > > "Naveen N Rao (AMD)" <naveen@kernel.org> writes:
> > > 
> > > > Add support for configuring the TSC frequency when Secure TSC is enabled
> > > > in SEV-SNP guests through a new "tsc-frequency" property on SEV-SNP
> > > > guest objects, similar to the vCPU-specific property used by regular
> > > > guests and TDX.
> > > 
> > > Which property exactly?
> > 
> > Same name: tsc-frequency specified with '-cpu'
> > 
> > > 
> > > >                 A new property is needed since SEV-SNP guests require
> > > > the TSC frequency to be specified during early SNP_LAUNCH_START command
> > > > before any vCPUs are created.
> > > 
> > > Sounds awkward.
> > > 
> > > Do the two properties set the same thing at different times?
> > 
> > Yes. For regular guests, TSC frequency is set using a vCPU ioctl.  
> > However, TDX and SEV-SNP (with Secure TSC) require the TSC frequency to 
> > be set as a VM property (there is a VM ioctl for this purpose).
> 
> The '-cpu' arg is global to the VM, so even though the ioctl is per-VCPU,
> a single '-cpu ...,tsc-frequency=NNN' argument applies universally to all
> the vCPUs in regular guests. 
> 
> > This was Tom's question too (see v2): is there any way to re-use 
> > 'tsc-frequency' specified with '-cpu' for Secure TSC.
> 
> I see no reason why we can't simply use the existing '-cpu tsc-frequency'
> value. Fetch the CPU 0 object and query its "tsc-frequency" property,
> and just assume all non-0 CPUs have the same tsc-frequency, since we
> don't provide a way to set it differently per-CPU IIUC.

I might be missing something obvious, but did you mean using 
'qemu_get_cpu(0)' or 'first_cpu' in sev_snp_launch_start()?  That 
doesn't seem to work (both are NULL).


Thanks,
Naveen


