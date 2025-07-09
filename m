Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91728C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 15:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZWWy-0004G5-BO; Wed, 09 Jul 2025 11:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uZWWE-00040q-Ha; Wed, 09 Jul 2025 11:15:37 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uZWWB-00007h-Lx; Wed, 09 Jul 2025 11:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752074132; x=1783610132;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=oV2MLlPudMCBULl1a/J0eRgp0JUK85J+WMJstOdbCjY=;
 b=RNSdArQhSi2HbdS0DMJAcFNxVyJySa28A//iltk3s/8FiEU6u+Dlbukm
 v9j8nsQJ4H/8KFpgoknc5ZcBL9rLCOOicfsT+Q6r/OCfVjumMFdup/H1a
 fVsgauaC8zZFnhs5I3pQjNUT7mMtjpEtY74KVR5GKNFz9k0SQD9LmvZtw
 97MYd7XoemFaneEM1htg+dkgIdacYNVD9I3ccMcz9UZKIWpVxkOGpuqL1
 H3xbV5YabAHghscecsgfKNXfffuC7gVAEeg+ECnmUXRuxDomBRJDnywjq
 WFAGcCCCMnjCyl8LBm7aXIwSiPJNKcikk5n2spbZsz+OI3weC4T56Njqu g==;
X-CSE-ConnectionGUID: KQYIxjFXRvmDgreWvueF7Q==
X-CSE-MsgGUID: W3AKop1JQ2S3zhy+963+mQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="65398775"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; d="scan'208";a="65398775"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2025 08:15:27 -0700
X-CSE-ConnectionGUID: SN5XQ/W1TkuIBQ6knuLssA==
X-CSE-MsgGUID: t/4PXtB8SoOgEtBoFjIuVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; d="scan'208";a="161358880"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 09 Jul 2025 08:15:23 -0700
Date: Wed, 9 Jul 2025 23:36:51 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-block@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH-for-10.1 v6 10/14] hw/core/null-machine: Define machine
 as generic QOM type
Message-ID: <aG6Mkw7fHaelSfPZ@intel.com>
References: <20250707172009.3884-1-philmd@linaro.org>
 <20250707172009.3884-11-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250707172009.3884-11-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
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

On Mon, Jul 07, 2025 at 07:20:04PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Mon,  7 Jul 2025 19:20:04 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH-for-10.1 v6 10/14] hw/core/null-machine: Define machine as
>  generic QOM type
> X-Mailer: git-send-email 2.49.0
> 
> While DEFINE_MACHINE() is a succinct macro, it doesn't
> allow registering QOM interfaces to the defined machine.
> Convert to the generic DEFINE_TYPES() in preparation to
> register interfaces.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  hw/core/null-machine.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


