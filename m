Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCE1C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 06:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubvhK-0006eo-G4; Wed, 16 Jul 2025 02:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubvgX-0006XQ-9V
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 02:32:09 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubvgV-0003lN-Eu
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 02:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752647527; x=1784183527;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=gxtVVRcWZqLAGE0eoWY0ia3LZr8Te28lKNF7vjEOsXM=;
 b=YPvEKY8lX+Tcyd/rIOlVzxW4HrWot1ugpKNkHErbof2W1TPJOluu9SOS
 Vx9WoT8MchAlQN/x4TPt4EGJHFyxz598pnZgkPq8Lw6DnOWYVjxZOYGYk
 +QAjA3qQKSKWLcv9l8bTlAgH1+/3s8OO2ceH7k3TY7u3drrDFgtbZYjTC
 LqKYGYaTn6VduKdHGstHUpP5HE1LEx7KsBYxMT5NJJjxJS5ImPuD4QPFd
 NKfF6+O/3f/X22vXJnsqllH8HbD4ygnHVwV/4P161jU0VUm0QwKPEhdK4
 ymGELHh5KPyJb0p/DGnxZdH35Wl5WyaOcy69dKMxkWaS7Z/mkzE9zi4n/ g==;
X-CSE-ConnectionGUID: ZxtgnRKuTQmTB5dhVF5nBA==
X-CSE-MsgGUID: hGKTE0f9Tnyp3pM0vhsFsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="53991323"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; d="scan'208";a="53991323"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 23:32:05 -0700
X-CSE-ConnectionGUID: Nas1J/ybSmWYwC+e1MT2DQ==
X-CSE-MsgGUID: 3sxmDLG4SGON5VXSUMW3Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; d="scan'208";a="162959264"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 23:32:02 -0700
Message-ID: <3bcfd1a7-10a8-4acb-be53-123f4dd280ee@intel.com>
Date: Wed, 16 Jul 2025 14:31:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1] system/runstate: Document
 qemu_add_vm_change_state_handler_prio* in hdr
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250715171920.89670-1-philmd@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250715171920.89670-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 7/16/2025 1:19 AM, Philippe Mathieu-Daudé wrote:
> Generally APIs to the rest of QEMU should be documented in the headers.
> Comments on individual functions or internal details are fine to live
> in the C files. Make qemu_add_vm_change_state_handler_prio[_full]()
> docstrings consistent by moving them from source to header.
> 
> Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
> Based-on: <20250703173248.44995-4-philmd@linaro.org>
> ---
>   include/system/runstate.h | 30 ++++++++++++++++++++++++++++++
>   system/runstate.c         | 30 ------------------------------
>   2 files changed, 30 insertions(+), 30 deletions(-)
> 

