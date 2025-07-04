Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F7AC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhpm-0003Dx-9R; Fri, 04 Jul 2025 10:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uXhpg-000372-SF
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:56:10 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uXhpY-0004F2-Uw
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751640961; x=1783176961;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=5GtG/wmkgnyT0ZU2Hu6gD/etCGuiMQhO86A4BqUjCCQ=;
 b=ZTxRTfvlpDoi/ZryO/lxFVoK/RqhhvnP847qHVENB+vLda5IBkj3qKWq
 erCX7FCl6hiPwi7Tbhf3TkBgKKU5j7cO+PYSpuv+KNIJZFaJX6YOBqhNB
 jz1YmZBgScJKr6JkNIOa0mH38W5/2M63zjKRdzsc8PEa4qRSiU799vs+/
 TuIx2GdtEaj/3NNAdXdzquY7pYJy0NWD9WmxmaFo2zmHQIAN6VPrEl5+g
 nnAgQbReg8rHsQ62QD1SKJ9dOYRRea4SW2sA4FLi4aoa55kPpiQkQv1cr
 ySYaAjIXi22vYWKRp+OYTurlRPPuxPz+YeQ8y8kzUbEMtQDhJL57ymWUl A==;
X-CSE-ConnectionGUID: a8G1eEj8S9KI91tirZhbMQ==
X-CSE-MsgGUID: qBSfjLNVQCC+wCChgyk+Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11484"; a="57784621"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="57784621"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 07:55:59 -0700
X-CSE-ConnectionGUID: /06xJhrsQIyuVBBPeEqATA==
X-CSE-MsgGUID: HvA6Mq85RnSgsLFERmgXIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="158689760"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 07:55:57 -0700
Message-ID: <1c61adc2-acf7-4c17-bd0a-0e00c508ea00@intel.com>
Date: Fri, 4 Jul 2025 22:55:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/cpu: Remove FEAT_24_0_EBX for AVX10
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, tao1.su@intel.com, 
 chenyi.qiang@intel.com
References: <20250704144504.4094810-1-xiaoyao.li@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250704144504.4094810-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/4/2025 10:45 PM, Xiaoyao Li wrote:
> Intel AVX10 spec has been updated to make the bit 16-18 of
> CPUID.24_0.EBX as reserved at 1 because all the Intel processors with
> AVX10 support will support all the vector lengths.

FYI. The latest AVX10 spec:

https://cdrdv2.intel.com/v1/dl/getContent/828965

