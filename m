Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA55C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 03:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUdOS-000823-IF; Wed, 25 Jun 2025 23:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uUdOO-00080o-7Z
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 23:35:17 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uUdOJ-0006PB-GV
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 23:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750908912; x=1782444912;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=llMrTR4+GZ084Esa1GOP/dHkfDy1q1kczNbbq9K6Exw=;
 b=D/+pcMYJ/NiazdI/YGTAkqADu8976wNHlgVhMUK2R9Y8+9oGyN6WB3Kt
 x+a/yz77RlS5u8ng1nBCip49WtMzGYXd/dqnm2XO+BdwVfn01hiV9VEqI
 iUFddMKS3az229i8mZ0B3whRPgYLk7mrqBj/qB4xBK/TMxIUYttjXXVUB
 zEn+fm/IFYs2Fm/BzHf0BcZH+dnMerbLo4pH5voJ6I94eGFrLkGuV7Ntu
 KlSq/3RqTXdR/Pcnq5fRsp6IcO8LruxaNgxrI9I+3tWBnVa9fhZj1lK9P
 H0L73jT8FnlvBeqKbmIp8rO7tiV8KRm1E4fVDCjHd6ucKi911HvUw46tF g==;
X-CSE-ConnectionGUID: HFhO/QAQRsqFQILRH6coew==
X-CSE-MsgGUID: Q/FjgLJXSOeVNSnVtqHOcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="70764904"
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; d="scan'208";a="70764904"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2025 20:35:02 -0700
X-CSE-ConnectionGUID: Ofs7Xa4jRUWVttfRa0Isug==
X-CSE-MsgGUID: Ndr2fOsETMSmTf59cMIJpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; d="scan'208";a="152516163"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 25 Jun 2025 20:35:00 -0700
Date: Thu, 26 Jun 2025 11:56:22 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] i386/tdx: Build TDX only for 64-bit target
Message-ID: <aFzE5npAn+F1FvBX@intel.com>
References: <20250625073310.2796298-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250625073310.2796298-1-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
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

On Wed, Jun 25, 2025 at 03:33:10PM +0800, Xiaoyao Li wrote:
> Date: Wed, 25 Jun 2025 15:33:10 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v2] i386/tdx: Build TDX only for 64-bit target
> X-Mailer: git-send-email 2.43.0
> 
> Build errors related to TDX were reported when QEMU built on 32-bit
> host[1][2].
> 
> Since TDX cannot work on 32-bit host and it's also not worth supporting
> TDX with 32-bit QEMU, limit TDX to 64-bit target only.
> 
> [1] https://lore.kernel.org/qemu-devel/20250602173101.1052983-1-clg@redhat.com/
> [2] https://lore.kernel.org/qemu-devel/b8171c39-6a92-4078-a59a-a63d7452e1e9@kaod.org/
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  hw/i386/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


