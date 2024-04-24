Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6A5C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 08:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXqV-0006lk-Gi; Wed, 24 Apr 2024 04:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rzXqR-0006TH-AR
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:19:11 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rzXqP-0006h2-Bn
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713946749; x=1745482749;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=bFnz7FygbxZO/pmCm/pperaLmXCGTA5hGfUrid4KAIA=;
 b=LLpDb+rfeNG0JWi5SgkK7zGnc+gVnEsnXpK4iY1jBX3fGH93HHsirWa3
 +M9Mr5qJifIBX80NQIPZPPHX9IHcQsHX2iduhF+IuGHOCyoXlSmXvgMQC
 heBHavdjEL2b6MR5Vu8ueTYIMP5iKqSFFlXJvo9PNY+PaaNIIqWq5wO8R
 JY8FKQ6zw/RGNXgTnOPHyKjnQUv9cI7FD9Z78ShH2+H2RXhNBQAyfqQBo
 IR4MhLD7SGByMzZ30SN3rnGwrI7F7byJAw1Cc0gIRPr/RKhwkK8QCPR8k
 W3k4hQzXv3zuiFezWgjWlImLPrwvRkRSXTNHZjvQZiNgW6ZCZFE0CeuLy A==;
X-CSE-ConnectionGUID: FMRn5Kd+QkWOX+geEBLhrg==
X-CSE-MsgGUID: tuHTpugQRpS38wr/xl5Brw==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27079310"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; d="scan'208";a="27079310"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2024 01:19:07 -0700
X-CSE-ConnectionGUID: AGNbggYMQYC3KCECNdPdPA==
X-CSE-MsgGUID: jf/Xv6hwTbeaML7rtD2pcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; d="scan'208";a="29117820"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 24 Apr 2024 01:19:04 -0700
Date: Wed, 24 Apr 2024 16:33:11 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Lei Wang <lei4.wang@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, manish.mishra@nutanix.com,
 xiaoyao.li@intel.com, chenyi.qiang@intel.com, tao1.su@linux.intel.com
Subject: Re: [PATCH] target/i386: Introduce SapphireRapids-v3 to add missing
 features
Message-ID: <ZijDx4m117yv64JK@intel.com>
References: <20240424072912.43188-1-lei4.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424072912.43188-1-lei4.wang@intel.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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

Hi Lei,

On Wed, Apr 24, 2024 at 03:29:12AM -0400, Lei Wang wrote:
> Date: Wed, 24 Apr 2024 03:29:12 -0400
> From: Lei Wang <lei4.wang@intel.com>
> Subject: [PATCH] target/i386: Introduce SapphireRapids-v3 to add missing
>  features
> X-Mailer: git-send-email 2.39.3
> 
> Add the missing features(ss, tsc-adjust, cldemote, movdiri, movdir64b) in
> the SapphireRapids-v3 CPU model.

Considering that these are missing features, not hardware updates/fixes/Linux
support changes, then as opposed to adding v3, it would be more appropriate
to add these flags directly to the v1 SPR model with Fixes tag (Fixes:
commit 7eb061b06e97 ("i386: Add new CPU model SapphireRapids")).

Regards,
Zhao


