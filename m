Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41259C79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 08:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4aPw-0007Wb-Vz; Thu, 10 Sep 2026 04:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1x4aPt-0007WI-NK
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:45:58 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@kernel.org>) id 1x4aPq-0007n1-IA
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 04:45:56 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0493D600C8;
 Thu, 10 Sep 2026 08:45:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61BC01F000FF;
 Thu, 10 Sep 2026 08:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789029952;
 bh=avXl/fF9+VQkQxYHgUzeZRR/WjdBCfavQZlBA8CAv6c=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=oCi3WtTUou6cmVBcAG29Cfk36Qg95GsYNLacYP5HHi6mSSm+bxbfD1SdJmOl/TPvi
 Rc9iyslXM3L+PKw7FEezlaFKQOzTtlNba33+5mIY3IzGZIHMfNGlMmH0nMdewOBSPP
 oXeZUBzDfrdVCnPgcAr9bbCk9tJyYyLmeGY3BwoDyY5NhQ2uCWfchcWDQ1r0tNfYEy
 BFjKm+2fnuKhLGsoDbPmHvRqdr546idN+Zr5PSfMjKbACIxt2bAyAjYTsjUdCtNXiX
 5lDcLvcQsegMA/0eY40xsIE0B5E5YcCnXuvxi72AITDxO5f9h8XaA31N5p53L5ktwW
 /oQ9RW2G0MYRQ==
Message-ID: <9cebada1-bda8-4e70-bfcc-7776e202420c@kernel.org>
Date: Thu, 10 Sep 2026 10:45:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/12] KVM/hostmem: Support init-shared guest-memfd as
 VM backends
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 pankaj.gupta@amd.com, isaku.yamahata@intel.com, xiaoyao.li@intel.com,
 chao.p.peng@linux.intel.com
References: <20260908133151.836685-1-michael.roth@amd.com>
From: David Hildenbrand <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20260908133151.836685-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=david@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 9/8/26 15:30, Michael Roth wrote:
> v1: https://lore.kernel.org/r/20251023185913.2923322-1-peterx@redhat.com
> v2: https://lore.kernel.org/r/20251119172913.577392-1-peterx@redhat.com
> v3: https://lore.kernel.org/r/20251215205203.1185099-1-peterx@redhat.com/
> v4: https://lore.kernel.org/qemu-devel/20260812201938.198915-1-michael.roth@amd.com/
> v5:
> - Fix error handling for 'hugetlb' when guest-memfd=on (Daniel, Peter)
> - Default to 'seal' option being allowed/on for guest-memfd=on since
>   it already satisfies the documented semantics (Peter)
> - Don't explicitly set a placeholder URI for qtest/migration-test
>   as the code now relies on NULL for this path (Peter)
> - Clarify rationale for checking for kvm_enabled() in 
>   kvm_create_guest_memfd() (Philippe, Peter)
> 
> This patchset is also available at:
> 
>   https://github.com/amdese/qemu/commits/gmem-shared-mem-v5
> 
> and is based on top of qemu master (99e54ab5e7)
> 
> 
> OVERVIEW
> ========
> 
> (cover letter shamelessly adapted from Peter's prior postings)
> 
> Recent kernels allow guest_memfd to be initialized with an 'init-shared'
> flag that will default to allocating normal/non-private memory that can be
> used to back non-confidential VMs.
> 
> This allows QEMU to make use of these init-shared guest_memfd instances via
> a common memory backend that's usable for either provide a common memory
> backend.
> 
> On the QEMU side, before this series, guest_memfd was only used for private
> guest memory (and thus only applied to confidential VMs), and the guest_memfd
> FDs would be created implicitly whenever a confidential environment was
> detected/specified.
> 
> With this series, users can now explicitly configure QEMU to use guest_memfd
> for non-private memory; thus, it can be used for non-confidential
> VMs. It also has implications for confidential VMs, since with this series an
> init-shared guest_memfd instance can now be specified for the shared memory
> while the internally-allocated guest_memfd continues to be used for private
> memory. This same infrastructure will also be used as the base for enabling
> in-place conversion for confidential VMs, where these separate shared/private
> paths will be modified to act on the same underlying guest_memfd instance and
> use a unified pool of shared/private memory.
> 
> 
> IMPLEMENTATION
> ==============
> 
> In the current patchset, I reused the memory-backend-memfd object, rather
> than creating a new type of object.  After all, guest-memfd (at least from
> userspace POV) works similarly like a memfd, except that it was tailored
> for VM's use case. While there is potential that new guest_memfd features
> may eventually necessitate introducing a dedicated guest_memfd memory
> backend object, for now the memory-backend-memfd object is a good fit for
> the current feature set.
> 
> This will also make it easier when in-place conversion comes around, since
> confidential VMs typically already use memory-backend-memfd for their shared
> memory, so by also making using that approach to specify the guest_memfd
> backend for in-place conversion the command-line syntax remains similar, and
> even allow choosing between memfd vs. guest_memfd to be handled automatically
> based on whether or not we're dealing with a Confidential VM with in-place
> conversion enabled.
> 
> Now, instead of using a normal memfd backend using:
> 
>   -object memory-backend-memfd,id=ID,size=SIZE,share=on
> 
> One can also boot a VM with guest-memfd:
> 
>   -object memory-backend-memfd,id=ID,size=SIZE,share=on,guest-memfd=on
> 
> The init-shared guest-memfd relies on a recent kernel (6.18+). When run it on
> an older qemu, you'll see errors like:
> 
>   qemu-system-x86_64: KVM does not support guest_memfd
> 
> One thing to mention is live migration is by default supported, however
> postcopy is still currently not supported.  The postcopy support will have
> some kernel dependency work to be merged in Linux first.

All makes sense to me!
-- 
Cheers,

David


