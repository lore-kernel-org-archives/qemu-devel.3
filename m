Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87865CF34C0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 14:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLjRQ-0008U8-JE; Wed, 19 Nov 2025 09:45:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vLjR8-0008SS-Lm
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 09:45:39 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vLjR5-0005J8-Na
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 09:45:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763563532; x=1795099532;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=/cyobN+98q7VyNmBjAXsbWEu8H3nXQZBsRVITkxFgT8=;
 b=Mk0bQMeLuHB3fPOXs2xHPHGxWtt99zfQDyssml1X41kb+u38lIkjAJBY
 QCRtYPKGHlAA6w8Gig+ub/jSZSBeNGMMG4f+KQV4Ma8JaxEmkjS5bgiYC
 eVrBGCDt8zz828ZRA8xBOjn9CT/Pi352cY9Tq2HMpc/spPN4boVGMhQ1Q
 Up5jN5S0+B9TQN/0us5J1UUlsAciCScE5pDuIGx0Ig6oTfjXczdi2vhef
 EruMy1yXYpmpYY0vvjWZmiM4O9xG/GjsjgxwAo6kU3iOngXoG6YKUA4TM
 JdoXDcus/gifXnLNG8ARdBJQBejGyIH4JSH1xGS+aw1qp9K5s1BvH/PIT Q==;
X-CSE-ConnectionGUID: udPjSk3LQfeJFfjw5QtiDQ==
X-CSE-MsgGUID: YwbrRHQeTm2cdZDEUNu3jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="53177287"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="53177287"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 06:45:28 -0800
X-CSE-ConnectionGUID: mWmJsYTkSL2reW34xKMWbA==
X-CSE-MsgGUID: 6OaXz6aETSiNJJH+E/P/Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="191200737"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.78])
 ([10.124.240.78])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 06:45:26 -0800
Message-ID: <e5a397a9-965e-4ef3-8ee2-b305a86df0fc@intel.com>
Date: Wed, 19 Nov 2025 22:45:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] memory: Rename RAM_GUEST_MEMFD to
 RAM_GUEST_MEMFD_PRIVATE
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Juraj Marcin <jmarcin@redhat.com>
References: <20251023185913.2923322-1-peterx@redhat.com>
 <20251023185913.2923322-5-peterx@redhat.com>
 <872f9349-7d3d-4b7b-9ba9-bcbc44c9afe5@intel.com> <aRZM3TyRU_kqcpVl@x1.local>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aRZM3TyRU_kqcpVl@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 11/14/2025 5:25 AM, Peter Xu wrote:
> On Fri, Oct 24, 2025 at 05:17:20PM +0800, Xiaoyao Li wrote:
>> On 10/24/2025 2:59 AM, Peter Xu wrote:
>>> This name is too generic, and can conflict with in-place guest-memfd
>>> support.  Add a _PRIVATE suffix to show what it really means: it is always
>>> silently using an internal guest-memfd to back a shared host backend,
>>> rather than used in-place.
>>>
>>> This paves way for in-place guest-memfd, which means we can have a ramblock
>>> that allocates pages completely from guest-memfd (private or shared).
>>
>> It's for patch 4-7. Regarding the rename. How about:
>>
>> - RAM_GUEST_MEMFD => RAM_PRIVATE_MEMORY
>> - backend->guest_memfd => backend->private_memory
>> - machine_require_guest_memfd() => machine_require_private_memory()
>> - cgs->require_guest_memfd => cgs->require_private_memory
>>
>> For CoCo VMs, what they require is the support of private memory, while the
>> guest_memfd is how linux provides private memory support. But with mmap
>> support added to guest memfd, it can serve as shared/non-private memory as
>> well. Futher, in the future when in-place conversion support is implemented,
>> a single guest memfd can serve as both shared and private in different
>> parts. So guest_memfd_private will be confusing at that time.
> 
> That's more or less a valid point.
> 
> Said so, I think PRIVATE_MEMORY is confusing too v.s. RAM_PRIVATE.  See:
> 
> commit 6169f1193657d0ba630a2ce33cef639ae918bce4
> Author: Steve Sistare <steven.sistare@oracle.com>
> Date:   Wed Jan 15 11:00:31 2025 -0800
> 
>      memory: add RAM_PRIVATE
> 
> Not to mention its possible confusion against mmap(MAP_PRIVATE) which is
> even more well known (where here RAM_PRIVATE is exactly about it).
> 
> It'll not be a concern until private gmemfd will start to back shared
> memories, even if it happens (I believe it will, a matter of time..) IMHO
> it's still fine to use guest_memfd_private, because here private describes
> that the fd is a private FD (not the memory is private).  It's private
> because it's hidden inside each ramblock that matters.  Then a fd that is
> private can still back shared memories.
> 
> Would you mind I keep everything as-is for now?

I'm fine.

> Thanks,
> 


