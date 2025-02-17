Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC58EC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 14:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk2Hg-0000Xk-3Y; Mon, 17 Feb 2025 09:39:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1tjuuD-0008W9-Rp
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 01:47:01 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <naveen@kernel.org>) id 1tjuuC-0007Uw-3E
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 01:47:01 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 623A45C565E;
 Mon, 17 Feb 2025 06:46:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD2BC4CED1;
 Mon, 17 Feb 2025 06:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739774816;
 bh=wGEp05+aP4nRVSEcYNqbBBmVcNgBfNoXnSxpARVudB0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KqW1KybLXuKVrnFDHFiQ39uSkMrSQZORRAhuHSiVZBF030Qsx+WxRZfbHsWxSnCr1
 lYXE4MV+3LXcdbe9KSG+s042q9N0Zuk+9yXyhS+3TjCkB2K0VIsa8qNvwe0erUdv9Q
 C3929Be6vAhdTnetgcUlcKcxdgKNcaCX3VFaqJ+oMuF0I0uX5IcZamIAmlgwIniZh1
 ExJtlbTAMkIOlUEIs6y6s2q1mV4Q0bp4RZcCKoCCgh9KtCKJrtiFm8usbtKMACjjgZ
 iEd/F0KTKoG2b6WDv8aSwLQHrHefSYfXkdh8hUymZnLW7SAkvN82MhZW4KC0h2TC7B
 9AqPlIoo2jDjw==
Date: Mon, 17 Feb 2025 12:13:15 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Kim Phillips <kim.phillips@amd.com>, 
 Tom Lendacky <thomas.lendacky@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, 
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, 
 "Nikunj A . Dadhania" <nikunj@amd.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kishon Vijay Abraham I <kvijayab@amd.com>, Alexey Kardashevskiy <aik@amd.com>
Subject: Re: [PATCH v3 2/2] KVM: SEV: Configure "ALLOWED_SEV_FEATURES" VMCB
 Field
Message-ID: <gxyvqeslwhw6dirfg7jb7wavotlguctnxf5ystqfcnn5mk74qa@nlqbruetef22>
References: <20250207233410.130813-1-kim.phillips@amd.com>
 <20250207233410.130813-3-kim.phillips@amd.com>
 <4eb24414-4483-3291-894a-f5a58465a80d@amd.com>
 <Z6vFSTkGkOCy03jN@google.com>
 <6829cf75-5bf3-4a89-afbe-cfd489b2b24b@amd.com>
 <Z66UcY8otZosvnxY@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z66UcY8otZosvnxY@google.com>
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=naveen@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.382,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 17 Feb 2025 09:39:19 -0500
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

On Thu, Feb 13, 2025 at 04:55:13PM -0800, Sean Christopherson wrote:
> On Thu, Feb 13, 2025, Kim Phillips wrote:
> > On 2/11/25 3:46 PM, Sean Christopherson wrote:
> > > On Mon, Feb 10, 2025, Tom Lendacky wrote:
> > > > On 2/7/25 17:34, Kim Phillips wrote:
> 
> Third, letting userspace opt-in to something doesn't necessarily mean giving
> userspace full control.  Which is the entire reason I asked the question about
> whether or not this can break userspace.  E.g. we can likely get away with only
> making select features opt-in, and enforcing everything else by default.
> 
> I don't think RESTRICTED_INJECTION or ALTERNATE_INJECTION can work without KVM
> cooperation, so enforcing those shouldn't break anything.
> 
> It's still not clear to me that we don't have a bug with DEBUG_SWAP.  AIUI,
> DEBUG_SWAP is allowed by default.  I.e. if ALLOWED_FEATURES is unsupported, then
> the guest can use DEBUG_SWAP via SVM_VMGEXIT_AP_CREATE without KVM's knowledge.

In sev_es_prepare_switch_to_guest(), we save host debug register state 
(DR0-DR3) only if KVM is aware of DEBUG_SWAP being enabled in the guest 
(via vmsa_features). So, from what I can tell, it looks like the guest 
will end up overwriting host state if it enables DEBUG_SWAP without 
KVM's knowledge?

Not sure if that's reason enough to enforce ALLOWED_SEV_FEATURES for 
DEBUG_SWAP :)

If ALLOWED_SEV_FEATURES is not supported, we may still have to 
unconditionally save the host DR0-DR3 registers.


- Naveen


