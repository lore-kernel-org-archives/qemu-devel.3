Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA08E7719F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 08:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXFRA-0001sl-Sq; Mon, 13 Jan 2025 03:04:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tXFR8-0001sL-Hv
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 03:04:38 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tXFR6-0004wq-NN
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 03:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736755476; x=1768291476;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=CAPK5hpnndUBM6H8v1yGYOGEhIA93WWf/zSx2BmHPn0=;
 b=mpq1KQ99RVntMIwcDVkbN3WU5WJnRmqOyDiHNk+7uogw1V95y+oKWr1V
 o6x9d2/s4yAO+bgaye1NgTOSzQXUtpOqr5I+zv7hACLheBt209QR/Hi73
 93GANY1XtB/6PVPHX6EXbVEdnpBejJowM71k8S+ZgVuJPscmC9RhJ/Q7C
 fgdVQ5GiXumbP9kVP87bxQw+TxJde7kjCUrK5Ptio0aREcknnnnTMjDmm
 Dnejq/m+ACbVlUCGwJS4WKrw/XZyhTgVtm+FO7JRpILPkIo7cGjRNx1Gx
 EzJpDDD99W5UvRUFBjrGsW5uFhFkITvIZtLt0iCV+JFna/5p5hxH3q/Fo g==;
X-CSE-ConnectionGUID: 94fC+GsISbKr0Und+FcLRQ==
X-CSE-MsgGUID: DKj+WY05SQqXMCxvr3u8lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="47664653"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="47664653"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2025 00:04:33 -0800
X-CSE-ConnectionGUID: kmwpgRb1RZetxNLbY0t9zw==
X-CSE-MsgGUID: PfJRQRxRQWy1705U3xPYog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="104912040"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2025 00:04:32 -0800
Message-ID: <df9bf984-2845-497c-b2c2-dcdc43752b9b@intel.com>
Date: Mon, 13 Jan 2025 16:04:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Clean up and enhance of feature_word_description()
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org
References: <20241217123932.948789-1-xiaoyao.li@intel.com>
Content-Language: en-US
In-Reply-To: <20241217123932.948789-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.025,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-1.798, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 12/17/2024 8:39 PM, Xiaoyao Li wrote:
> This series grabs two patches related to feature_word_description() from
> two different old threads, they are simple and straightforward.
> 
> Patch 1 is grabbed from [1] while patch 2 is grabbed from [2].

Ping...

> [1]: https://lore.kernel.org/qemu-devel/20230106083826.5384-3-lei4.wang@intel.com/
> [2]: https://lore.kernel.org/qemu-devel/20220808085834.3227541-2-xiaoyao.li@intel.com/
> 
> Lei Wang (1):
>    i386: Remove unused parameter "uint32_t bit" in
>      feature_word_description()
> 
> Xiaoyao Li (1):
>    target/i386: Print CPUID subleaf info for unsupported feature
> 
>   target/i386/cpu.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 


