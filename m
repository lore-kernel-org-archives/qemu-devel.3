Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF55C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 10:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc0Bj-00031G-Sy; Thu, 08 Aug 2024 06:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sc0BY-0002kL-60
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 06:15:56 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sc0BW-00035P-9S
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 06:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723112154; x=1754648154;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=5jStgwZ82O+yP8UIEKI1zciskdtjYX3WrtDCvgy9N3g=;
 b=ZDqGi5WVoonwyeCWwCnCVwzyEYORmYk1RUnzSIMIMZ5DjAyt8zChbxf1
 kj9LPZNSAcE8NPUkHV9rKJrn0Bt9zpdOchFGUzbWi22kPkFZuxjyc/Mu5
 +CAPRwYdUxji4jHZL1/Qi3CjJFM7wsXk7yzCZqjHjP+7MqFwjeCkJfmRF
 EAGK7WE0l/JOdzU3cIYkkdWUftHJ5sKY16F+QPBO9SF2308A+3WHfucIv
 EUAO6/qgNvQvRIImxn1KeQpSoSau5wYMWMdvJhyvaNWqJVFtV03Ypm/Jn
 qnfbOX7gAevX1IXgjXx/m7wwHAKCkmwWWL6P6y1TWXdvNzM6oKuF80zYC g==;
X-CSE-ConnectionGUID: WhbIB3zPTTOJpKm6Pv7qZA==
X-CSE-MsgGUID: k7ukqSwGSxOg5dCZDnAaew==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21109731"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; d="scan'208";a="21109731"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2024 03:15:52 -0700
X-CSE-ConnectionGUID: iK4dcg1pQ324EQ8t9FlAfA==
X-CSE-MsgGUID: sr9tcA2aQGyor8DR4EJiAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; d="scan'208";a="56853159"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 08 Aug 2024 03:15:51 -0700
Date: Thu, 8 Aug 2024 18:31:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: EwanHai <ewanhai-oc@zhaoxin.com>
Cc: pbonzini@redhat.com, xiaoyao.li@intel.com, qemu-devel@nongnu.org,
 ewanhai@zhaoxin.com, cobechen@zhaoxin.com, rockcui@zhaoxin.com,
 louisqi@zhaoxin.com, liamni@zhaoxin.com, frankzhu@zhaoxin.com
Subject: Re: [PATCH v2 1/4] target/i386: Add support for Zhaoxin CPU vendor
 identification
Message-ID: <ZrSejMP8SDEIm37l@intel.com>
References: <20240704112511.184257-1-ewanhai-oc@zhaoxin.com>
 <20240704112511.184257-2-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704112511.184257-2-ewanhai-oc@zhaoxin.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Thu, Jul 04, 2024 at 07:25:08AM -0400, EwanHai wrote:
> Date: Thu, 4 Jul 2024 07:25:08 -0400
> From: EwanHai <ewanhai-oc@zhaoxin.com>
> Subject: [PATCH v2 1/4] target/i386: Add support for Zhaoxin CPU vendor
>  identification
> X-Mailer: git-send-email 2.34.1
> 
> Zhaoxin currently uses two vendors: "Shanghai" and "Centaurhauls".
> It is important to note that the latter now belongs to Zhaoxin. Therefore,
> this patch replaces CPUID_VENDOR_VIA with CPUID_VENDOR_ZHAOXIN1.
> 
> The previous CPUID_VENDOR_VIA macro was only defined but never used in
> QEMU, making this change straightforward.
> 
> Additionally, the IS_ZHAOXIN_CPU macro has been added to simplify the
> checks for Zhaoxin CPUs.
> 
> Signed-off-by: EwanHai <ewanhai-oc@zhaoxin.com>
> ---
>  target/i386/cpu.h | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


