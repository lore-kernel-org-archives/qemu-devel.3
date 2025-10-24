Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B6CCCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 09:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCDvR-0002IU-Oh; Fri, 24 Oct 2025 05:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vCDvP-0002IH-He
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 05:17:31 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vCDvN-0002Ji-3I
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 05:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761297449; x=1792833449;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=tcLfTjStFWPhky9cVwhCFuEpKS2V1yWBQGlu3nIEMto=;
 b=jJdDxTvIsdPStXy5/K6GmHkLldAfaEGzlNV4Hvj5eazB4SIRceyIbld4
 YZgEchNfer9NWL2Ge4lHgXpV2B/uN3LvcgvHn8CabZv7FBBSzFTUDRi7G
 F5Y3Y9jKVtXsTzjCKoApfrM+abuUvzOQBf+9nlkljq7+XK/6ORgYqRRmP
 WCYtLikEjuULjSPwH92L4cDuOHa61SA8Eb8CXJepGmbih0AlTlHLpU59d
 4qvDV56I5p4TxE8RLNAlD2VUwhvH2/ob0OhDB3qwrRwcP+Ne78sMkHQaE
 eHoVj27E3IAw+Z3UHZozsxHrlYFfSNEuzkZdmnr0qFG1qIxH2JyyY6Whj A==;
X-CSE-ConnectionGUID: FUOPO/+WTbGrN91hlVCBNg==
X-CSE-MsgGUID: hZTcQ2HUTDCFEB0AOv908A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63515257"
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="63515257"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 02:17:25 -0700
X-CSE-ConnectionGUID: JGG6a92PQNOd0EeaCQovpA==
X-CSE-MsgGUID: 0MJfe5T7QKqqZNQcfPjIww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="183611951"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 02:17:23 -0700
Message-ID: <872f9349-7d3d-4b7b-9ba9-bcbc44c9afe5@intel.com>
Date: Fri, 24 Oct 2025 17:17:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] memory: Rename RAM_GUEST_MEMFD to
 RAM_GUEST_MEMFD_PRIVATE
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Chenyi Qiang <chenyi.qiang@intel.com>, David Hildenbrand <david@redhat.com>,
 Alexey Kardashevskiy <aik@amd.com>, Juraj Marcin <jmarcin@redhat.com>
References: <20251023185913.2923322-1-peterx@redhat.com>
 <20251023185913.2923322-5-peterx@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20251023185913.2923322-5-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.14; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.998, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 10/24/2025 2:59 AM, Peter Xu wrote:
> This name is too generic, and can conflict with in-place guest-memfd
> support.  Add a _PRIVATE suffix to show what it really means: it is always
> silently using an internal guest-memfd to back a shared host backend,
> rather than used in-place.
> 
> This paves way for in-place guest-memfd, which means we can have a ramblock
> that allocates pages completely from guest-memfd (private or shared).

It's for patch 4-7. Regarding the rename. How about:

- RAM_GUEST_MEMFD => RAM_PRIVATE_MEMORY
- backend->guest_memfd => backend->private_memory
- machine_require_guest_memfd() => machine_require_private_memory()
- cgs->require_guest_memfd => cgs->require_private_memory

For CoCo VMs, what they require is the support of private memory, while 
the guest_memfd is how linux provides private memory support. But with 
mmap support added to guest memfd, it can serve as shared/non-private 
memory as well. Futher, in the future when in-place conversion support 
is implemented, a single guest memfd can serve as both shared and 
private in different parts. So guest_memfd_private will be confusing at 
that time.

