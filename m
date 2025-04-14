Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59618C369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 14:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4L3c-00055v-Nn; Mon, 14 Apr 2025 10:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u4L39-0004sC-TF
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 10:44:47 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u4L35-0000ZG-TI
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 10:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744641876; x=1776177876;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ZAr8EsbMKA6cIbAMNsxRH2W6hWWQ2ihzIYx1hJtcuFI=;
 b=RaTh837/0gr9xesRvf3dkPQs8L/aYdLrJVDGl2VvfhZbAtxBt1Xry6ih
 RRQzLNbhJE3plDp3j3zzn4gNEbzYqP0aVhfvVKGtTTw7L8GOvpmLLbq43
 HtEnZvUcmnSXbQEqQiANbIKVGdK8GC14lZMHX4zTGMiokogK/HCKBqbLH
 syxGapLprH0UFc4F96aWCXvwV6DZSjucwAbkhFrLi/K2UmkTf/YWHt6uF
 HedvkyJEHhonaNzJoGCd4iyCFyEIyqBQqQNU4HIyL/huPemP4o1Molvfs
 dgCOlmNOoKPFBS45BlE/PbI0uqTItqicYWkx6Txapm92f0iPgJS39iAYx Q==;
X-CSE-ConnectionGUID: zKsi/drPTz+zyE3xnJxF2g==
X-CSE-MsgGUID: 856pgPHhS7ae3hE+7ualoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="45251650"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; d="scan'208";a="45251650"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2025 07:44:33 -0700
X-CSE-ConnectionGUID: m5pQgL8ITKunepr4l3ULyQ==
X-CSE-MsgGUID: XauUsH3zSVOIWR1q0c2tAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; d="scan'208";a="130823355"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 14 Apr 2025 07:44:31 -0700
Date: Mon, 14 Apr 2025 23:05:22 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ewan Hai <ewanhai-oc@zhaoxin.com>
Cc: pbonzini@redhat.com, xiaoyao.li@intel.com, ewanhai@zhaoxin.com,
 cobechen@zhaoxin.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v3] target/i386: Fix model number of Zhaoxin YongFeng
 vCPU template
Message-ID: <Z/0kMumrF4XCo/C/@intel.com>
References: <20250414075342.411626-1-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414075342.411626-1-ewanhai-oc@zhaoxin.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Apr 14, 2025 at 03:53:42AM -0400, Ewan Hai wrote:
> Date: Mon, 14 Apr 2025 03:53:42 -0400
> From: Ewan Hai <ewanhai-oc@zhaoxin.com>
> Subject: [PATCH v3] target/i386: Fix model number of Zhaoxin YongFeng vCPU
>  template
> X-Mailer: git-send-email 2.34.1
> 
> The model number was mistakenly set to 0x0b (11) in commit ff04bc1ac4.
> The correct value is 0x5b. This mistake occurred because the extended
> model bits in cpuid[eax=0x1].eax were overlooked, and only the base
> model was used.
> 
> Using the wrong model number can affect guest behavior. One known issue
> is that vPMU (which relies on the model number) may fail to operate
> correctly.
> 
> This patch corrects the model field by introducing a new vCPU version.
> 
> Fixes: ff04bc1ac4 ("target/i386: Introduce Zhaoxin Yongfeng CPU model")
> Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
> ---
>  target/i386/cpu.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

BTW, if you want to add more notes or explaination to strongly ask users
to use v2, you can add a section "Preferred CPU models for Zhaoxin x86
hosts" in docs/system/cpu-models-x86.rst.inc.

Thanks,
Zhao


