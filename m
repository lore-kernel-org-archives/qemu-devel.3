Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E57AD12D79
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 15:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQoVv-00056Q-RG; Wed, 03 Dec 2025 10:11:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQoVk-0004yd-3v; Wed, 03 Dec 2025 10:11:23 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQoVi-00022x-Jn; Wed, 03 Dec 2025 10:11:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764774679; x=1796310679;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=CxwoZKpDmOY4ipBKvr77cQ7VRWcA8D2unPwYqfGFUNQ=;
 b=ipzGA+6EuXdIeus2CJxzQAu9Qqq7FuMP7QPzqGmuFtqTtsFNk2n6fHBF
 BXmjtnTxaenNFI8MIcxapyfLoPpCDrJKMqGUuWi9F6NO5g5Iz22R3KnJT
 J5CFL5s9XQ8HS3ViroMQexTwJByP/HfZYzqqEppQ8w9Hn16uEnWgFdzvb
 wgOi+jfCMiHw9RVMgf6ElyGMFaEDhHefRuifJ8HMROrPu2WzxlVURtNGB
 asM1fC/z3DGUOaFwkUtNsTySI7MfE/KMa8JV0Qf4WoIP5f5Xp9RYaE60o
 MuJUCuRLPqTDYEaH8YTlLsZaW2HlXDO8C1/eks27dTkrMr09kExgnj8He Q==;
X-CSE-ConnectionGUID: DjoAvZFoQieZEjUoqIf0Eg==
X-CSE-MsgGUID: 6UZbfw3+QxiR58vZrUVOPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="66845690"
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; d="scan'208";a="66845690"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2025 07:11:16 -0800
X-CSE-ConnectionGUID: hNrQY6v8TSmWeVooafpSrA==
X-CSE-MsgGUID: CTH2QiH5RpmTk1bE3pTWXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,246,1758610800"; d="scan'208";a="225670978"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 03 Dec 2025 07:11:13 -0800
Date: Wed, 3 Dec 2025 23:35:56 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: Re: [PATCH-for-11.0 v6 02/13] hw/sparc/sun4m: Use
 fw_cfg_init_mem_nodma()
Message-ID: <aTBY3LMaoFDgVr7m@intel.com>
References: <20251203060942.57851-1-philmd@linaro.org>
 <20251203060942.57851-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251203060942.57851-3-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
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

On Wed, Dec 03, 2025 at 07:09:30AM +0100, Philippe Mathieu-Daudé wrote:
> Date: Wed,  3 Dec 2025 07:09:30 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH-for-11.0 v6 02/13] hw/sparc/sun4m: Use
>  fw_cfg_init_mem_nodma()
> X-Mailer: git-send-email 2.51.0
> 
> Use fw_cfg_init_mem_nodma() instead of open-coding it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/sparc/sun4m.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


