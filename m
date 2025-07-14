Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2597BC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 09:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubFa7-0004TZ-CT; Mon, 14 Jul 2025 05:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubFWp-0002OV-95
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 05:31:25 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubFWm-0003sN-SY
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 05:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752485477; x=1784021477;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=L3mfYb+8uULrCsZfg+p6WhqdOevhuFXnqsXkvJkvCnk=;
 b=VY0elqh0dFw9OGl5iMEHNICd0hunP8cerbwWIiKeVl1W5mQClOSvrn7E
 PK950MQS7vXGVWpVaHi7sLaSeqcGdfPkWqcBpwQ6MUWv5uI3n99OhnBYs
 x6s5TCQaM068scES3NFBHjvuOQypdc6GNEACU4lVd0gHlPNxFsq7MVoST
 ++g2pswZm5LjyzRDBEQ8WL1Isexj1TEGQPFyyIQAc6ibeDHD48G7MByZn
 nfhAWp3wcUGapvqk4QPYfiyqT/RbPym1WW1pGVIPSsYsnzwlocuIdjZFe
 MxEw6eGMmy5P4+2+NM6wNfRSTXG2V36o8lg1hMtKi2pOY7dZCFtnYmHET w==;
X-CSE-ConnectionGUID: M747mz9WTq6FrRf0lQH6MQ==
X-CSE-MsgGUID: 147RyGTnRyqyHp8eUCOd3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54826461"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="54826461"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 02:31:14 -0700
X-CSE-ConnectionGUID: t/39GAc2QgOy3y9GYhWEcQ==
X-CSE-MsgGUID: IGVdnOQ4S1CvKcvXAel42w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; d="scan'208";a="157377436"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 02:31:13 -0700
Message-ID: <8e7414d9-c53d-4f10-9053-3ab3afc39d03@intel.com>
Date: Mon, 14 Jul 2025 17:31:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] qemu-optios: Fix, cleanup and add description of
 tdx-guest
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250714091953.448226-1-xiaoyao.li@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250714091953.448226-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=xiaoyao.li@intel.com;
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

On 7/14/2025 5:19 PM, Xiaoyao Li wrote:
> Patch 1 is the fix to generated doc html.
> 
> Patch 2-4 are the cleanup of memory-encryption
> 
> Patch 5 add description of tdx-guest.

get_maintainer.pl doesn't provide me the maintainer of qemu-options.hx.

I have to send the series to the folks I'm familiar with in the QEMU 
community. Hope you can help cc the correct people.

> Xiaoyao Li (5):
>    qemu-options: Move sgx-epc options from "M" to "machine"
>    i386/sev: Remove the example that references memory-encryption
>    qemu-options: Change memory-encryption to confidential-guest-support
>      in the example
>    qemu-options: Add confidential-guest-support to machine options
>    qemu-options: Add description of tdx-guest object
> 
>   qemu-options.hx   | 66 ++++++++++++++++++++++++++++++++++++++---------
>   target/i386/sev.c |  4 ---
>   2 files changed, 54 insertions(+), 16 deletions(-)
> 


