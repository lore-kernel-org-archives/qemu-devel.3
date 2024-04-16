Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350C4C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 15:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwkTa-0003Q5-TI; Tue, 16 Apr 2024 11:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rwkTW-0003PN-UT; Tue, 16 Apr 2024 11:11:58 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rwkTU-0006sj-4i; Tue, 16 Apr 2024 11:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713280316; x=1744816316;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=EUtChf+ZT+k+KZQmMIjUdoCZtm/enqYV7iJUgl/8+Tw=;
 b=J20wpkzD/d9WccQ87A6BXo5XGHbeznlu6D1ZMYYeE1pgYTZJILGB+LcJ
 +RbM5ImvqqRgzQ80xJqRSk4N+6eWyRYg76abepjmOZOgdaVu9LRgGMCnH
 jd4MFrebLPCGB45JvLxTID91oUo2rOe2xlWblWjsW5+LIsHtritkOPNAV
 Por/4EfVBLJdwYXXZVBMpLznmLKHfkgZZ5rhJCios5l30vIdCvbMxQkjV
 12mP4z9gr136AwV3f7Y3PlrTFXTWeDkm7T6NdY7AhOUdOhkAmxEig61AO
 3Oit4nmryFAx03goFRN3tu+MNuCa4RANcpwm0aNcmyKS1XqL2EodVog/k g==;
X-CSE-ConnectionGUID: HCF6OgVuTwSGV4keRtzxuQ==
X-CSE-MsgGUID: mP9DiAl/SI6EgsgugfETJA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8588950"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="8588950"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2024 08:10:14 -0700
X-CSE-ConnectionGUID: y8EfDANkS62Od8/S5tuWYw==
X-CSE-MsgGUID: w6G+Jkn/SAaWkThb1NHYtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; d="scan'208";a="26868609"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 16 Apr 2024 08:10:11 -0700
Date: Tue, 16 Apr 2024 23:24:15 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, devel@lists.libvirt.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v3 20/22] hw/i386/pc: Remove deprecated pc-i440fx-2.3
 machine
Message-ID: <Zh6YHzRr8uPgoQds@intel.com>
References: <20240416135252.8384-1-philmd@linaro.org>
 <20240416135252.8384-21-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240416135252.8384-21-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On Tue, Apr 16, 2024 at 03:52:49PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Tue, 16 Apr 2024 15:52:49 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v3 20/22] hw/i386/pc: Remove deprecated pc-i440fx-2.3
>  machine
> X-Mailer: git-send-email 2.41.0
> 
> The pc-i440fx-2.3 machine was deprecated for the 8.2
> release (see commit c7437f0ddb "docs/about: Mark the
> old pc-i440fx-2.0 - 2.3 machine types as deprecated"),
> time to remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  docs/about/deprecated.rst       |  4 ++--
>  docs/about/removed-features.rst |  2 +-
>  hw/i386/pc.c                    | 25 -------------------------
>  hw/i386/pc_piix.c               | 19 -------------------
>  4 files changed, 3 insertions(+), 47 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


