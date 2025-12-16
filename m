Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17496D5B161
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 05:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVNwV-0003st-Km; Tue, 16 Dec 2025 00:49:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vVNwI-0003qT-MV
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 00:49:39 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vVNwG-0004rZ-1z
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 00:49:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765864176; x=1797400176;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=3sfFwdr5SUwLsT7sOYgkScNPLwCA2E80lWcAUpCGP1g=;
 b=EMhobc2War0BzFwVRZ2q87T94cppnrHc4WkGqXGgOyPMranVqpxNAfoF
 9T9TENdsHddUtQVdyNTYxsP+DVVYIBn8TeGqDzSesQgYHHjr0R7YT5/+u
 6yEGwnHRNlv0ALDKoiFSSM+zMCT02AiQQrMTErm5OsLlif1zX+szzfPZw
 pZxVhb3LKHo+C53bcLBzurJXIjml13JjdauUrPkJIjgT+vEYe3Z/B7YMs
 FdycXmNbeqpDfPmPWmPZ5FbVETevoOIYaxdrWcoPSDtR5cTOetdYAF1I+
 qSw5rFACeF6d1kLH3Firy5Q2O6PFsxOs1x2NUWo572uruaOTvoXB1dEvs w==;
X-CSE-ConnectionGUID: Dij+MtytRRypJ+iRn6jhUQ==
X-CSE-MsgGUID: U0J1hJXoQaK2QTEJYYhrZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="78893671"
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; d="scan'208";a="78893671"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 21:49:32 -0800
X-CSE-ConnectionGUID: I6f0MtuaTBu5VU/esp8FOw==
X-CSE-MsgGUID: tbyCMpnpScCDMczs0kezkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; d="scan'208";a="197021458"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.173])
 ([10.124.240.173])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 21:49:30 -0800
Message-ID: <be8d7863-b803-4647-b69a-f61a1910cab9@intel.com>
Date: Tue, 16 Dec 2025 13:49:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/12] memory: Rename RAM_GUEST_MEMFD to
 RAM_GUEST_MEMFD_PRIVATE
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, David Hildenbrand <david@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Fabiano Rosas <farosas@suse.de>, Alexey Kardashevskiy <aik@amd.com>
References: <20251215205203.1185099-1-peterx@redhat.com>
 <20251215205203.1185099-6-peterx@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20251215205203.1185099-6-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=xiaoyao.li@intel.com;
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

On 12/16/2025 4:51 AM, Peter Xu wrote:
> This name is too generic, and can conflict with in-place guest-memfd
> support.  Add a _PRIVATE suffix to show what it really means: it is always
> silently using an internal guest-memfd to back a shared host backend,
> rather than used in-place.
> 
> This paves way for in-place guest-memfd, which means we can have a ramblock
> that allocates pages completely from guest-memfd (private or shared).

Well, the term of "in-place" needs to be changed to "init-shared".

