Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869F3C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 09:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXcTH-0003Uh-34; Fri, 04 Jul 2025 05:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXcTF-0003Tv-7C
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:12:37 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXcTD-0000mC-NR
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751620356; x=1783156356;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=seHcjEUvLZZrHFquBbeG1cvCcdKMwpI+Ck/pw8wQkhs=;
 b=NwBPLY98hZ3qbf+h9xKjl1PbgCEURbYOspZ4OmL0Hj/RijZGJEG66tj6
 DMzcR62gk8qM9bUF5rP9I8h1CP71AwxhFffqdgpvUA/BhmfaFHSgnh5m7
 pom5PEujrU3SgWE4Aakken9cXyRWWcAj10qcPK27vTpkAtYVfldbjHZxa
 yp+eKpZdUfLVnVDFdLXyNzPtYztraZZu4+uCzkuG4Xr1Cpn+nlkxLuj5h
 SgBJ4V7DOhoJXQQQrMUQIW2Z/sXsWjeGQmMEIW1wj0+EUSusSa7obVor+
 7ez0huQ/GN9a1v6Hwv++ermBqgtF1NxD6GpcaDrkZ0pMFTLkRJdaQu/9w A==;
X-CSE-ConnectionGUID: w1g20ovVS/aTItfDFcxwTA==
X-CSE-MsgGUID: cW79MPbMTNKavQDGWjYrew==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53176414"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="53176414"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 02:12:33 -0700
X-CSE-ConnectionGUID: hyeroxwbQpqPZhnJ/QCHpQ==
X-CSE-MsgGUID: EO1JYM7FRyGhU1G9jos7hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="154239108"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 04 Jul 2025 02:12:32 -0700
Date: Fri, 4 Jul 2025 17:33:58 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 06/39] accel/kvm: Reduce kvm_create_vcpu() declaration
 scope
Message-ID: <aGegBi0CP3Jty+fq@intel.com>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-7-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703173248.44995-7-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Jul 03, 2025 at 07:32:12PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu,  3 Jul 2025 19:32:12 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v6 06/39] accel/kvm: Reduce kvm_create_vcpu() declaration
>  scope
> X-Mailer: git-send-email 2.49.0
> 
> kvm_create_vcpu() is only used within the same file unit.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/system/kvm.h | 8 --------
>  accel/kvm/kvm-all.c  | 8 +++++++-
>  2 files changed, 7 insertions(+), 9 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


