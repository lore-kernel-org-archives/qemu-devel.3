Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1DED3E79D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 07:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTakb-0001sx-VD; Thu, 11 Dec 2025 02:06:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vTakV-0001s8-Nw
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 02:06:04 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vTakS-0003pz-3w
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 02:06:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765436760; x=1796972760;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=08IusJ3GI2su7G3UTddJRNF+p627QbG6HmVchPmrvM0=;
 b=VrrW0lVIp2JL9um334A0zU5z27kTWFxGO/m3DQwPt3AmE4ZtAW7EMOzB
 IYWuZpvHr0Xh/9GOZPODgfhAKYYc9qDrQ/+JMa3Tfsp0rKN6uXKywSic1
 eY9xIbnIEpy+MYVjJPOsFfN1Y/bhNsMi6KePaDxYZY0MmOgFqvdt0HbAs
 umHlj/s4z8lVraXtMC/HmmLO5BMWQKX/qyxzcYs6kORg505vBfFuCTBre
 Dx9dkh5Dy49+HL2yyVLyNSyeA+OyH71WNP3BcyLq+wrZhuK84mZMsuxtG
 mzEvFUPAfjaAFK6MdfXMyCGrH02OF6u5TNwk2QXRFp2qAuAW/qslKgk7X w==;
X-CSE-ConnectionGUID: bXofvfNgT5+hJp19fZXWmQ==
X-CSE-MsgGUID: BAHruRA0QDmkvVBamjPEog==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="85023217"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="85023217"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 23:05:57 -0800
X-CSE-ConnectionGUID: 9eofvOd9TAO7FDYcMAVAzQ==
X-CSE-MsgGUID: VLxRJd0tSpu6D94Dz65Psg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="201819112"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.173])
 ([10.124.240.173])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 23:05:54 -0800
Message-ID: <db88b88c-e08c-4392-b1bd-621934cca9ff@intel.com>
Date: Thu, 11 Dec 2025 15:05:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] memory: Rename RAM_GUEST_MEMFD to
 RAM_GUEST_MEMFD_PRIVATE
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand
 <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20251119172913.577392-1-peterx@redhat.com>
 <20251119172913.577392-4-peterx@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20251119172913.577392-4-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

On 11/20/2025 1:29 AM, Peter Xu wrote:
> This name is too generic, and can conflict with in-place guest-memfd
> support.  Add a _PRIVATE suffix to show what it really means: it is always
> silently using an internal guest-memfd to back a shared host backend,
> rather than used in-place.
> 
> This paves way for in-place guest-memfd, which means we can have a ramblock
> that allocates pages completely from guest-memfd (private or shared).
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

