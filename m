Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9C3C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 04:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Ai0-0007qV-LA; Fri, 25 Apr 2025 00:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u8Ahy-0007kp-DS
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 00:30:38 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u8Ahw-0007QK-Hf
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 00:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745555437; x=1777091437;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=jrg1aDeXoLxxrtkBe0F9V76/F3McIfskkL/U/DHIi9U=;
 b=TVuWumzzAtV17B+JGyqXzoXiztQ6ktR+9X6hXU4RmEA/rWJZ/c4O7iKL
 IVPK6/qv0OBGM+QCUtM/mpsdxN6zImMzNDL4dkJTg0HrjS8IZ5uwRhNd+
 ScP+Jnxpo2/FCO09IXwsFnN8ijbLXPjCMWTXRrruI+WbpmjJ7BM6RTz3v
 o1SkoFZZPFe186a1131wTKUeRZZNri9nt3zValA3gh3Kilgf3uQlX1IiO
 SrMeRBymAYIaxpykAthlThhgfM1tLjK/FR/6mJmG9hgl72zgvnmHQlflh
 6Q+ZHlkKDyu5mXcNWiJaeVrUyQU99w/OIGYcyOveRKNy6U2kIB92naBdj A==;
X-CSE-ConnectionGUID: TvrXA+/VSQKYGII4aF2k3g==
X-CSE-MsgGUID: 56epJ5cBT521oja+0ExI7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47226117"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; d="scan'208";a="47226117"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2025 21:30:35 -0700
X-CSE-ConnectionGUID: etNDMSCTQjepNLcgrTdQjQ==
X-CSE-MsgGUID: tToYd5ucSJuHzIzOIYrcbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; d="scan'208";a="133315385"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 24 Apr 2025 21:30:32 -0700
Date: Fri, 25 Apr 2025 12:51:28 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v8 22/55] headers: Add definitions from UEFI spec for
 volumes, resources, etc...
Message-ID: <aAsU0N4wx5MpzDkF@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-23-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-23-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

On Tue, Apr 01, 2025 at 09:01:32AM -0400, Xiaoyao Li wrote:
> Date: Tue,  1 Apr 2025 09:01:32 -0400
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v8 22/55] headers: Add definitions from UEFI spec for
>  volumes, resources, etc...
> X-Mailer: git-send-email 2.34.1
> 
> Add UEFI definitions for literals, enums, structs, GUIDs, etc... that
> will be used by TDX to build the UEFI Hand-Off Block (HOB) that is passed
> to the Trusted Domain Virtual Firmware (TDVF).
> 
> All values come from the UEFI specification [1], PI spec [2] and TDVF
> design guide[3].
> 
> [1] UEFI Specification v2.1.0 https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29.pdf
> [2] UEFI PI spec v1.8 https://uefi.org/sites/default/files/resources/UEFI_PI_Spec_1_8_March3.pdf
> [3] https://software.intel.com/content/dam/develop/external/us/en/documents/tdx-virtual-firmware-design-guide-rev-1.pdf
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
> Changes in v7:
>  - use SPDX tag;
> ---
>  include/standard-headers/uefi/uefi.h | 187 +++++++++++++++++++++++++++
>  1 file changed, 187 insertions(+)
>  create mode 100644 include/standard-headers/uefi/uefi.h

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


