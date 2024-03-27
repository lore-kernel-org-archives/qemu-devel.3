Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62A8C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 07:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpNwO-0002T0-O6; Wed, 27 Mar 2024 03:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpNwL-0002RY-Df
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 03:43:17 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpNwH-0005xW-DI
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 03:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711525393; x=1743061393;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=KGk0N9uMhHq6Ojw7Dbcb/h56tflaL/0mZXbk1gFaZq0=;
 b=L+w4DUGrIv96R7nSG/zphdJ7l27Ip/Dw9lS92BIJaBrThU+gMuGVkB0U
 SjB3+WmlJ/sNeQhPE6nv4lWQEUs47ViOQFsEfcYb++hH1Fq8Ua+kFW2UO
 k+ZKjTLEiuTA4YzWZQFEAPtuBaeaL5qUbO3OlrXSuv/Nvc8Z4/+fMLCmY
 lQ+1hjexVpGUjDU5sTYE1HYlZgWkxB8ylNs1l6fHc0EEbZbImZznHuFfk
 OUVXrPAo4nZ+vH2w+O9a77BXojk8slzFhyDs+VgFCI7Ezk4FNiKMzsNUR
 D0l70GoDl4a1T25Zp7xG6Jiq63WBrPexG+2AHOZ2wdD9lNv6NRcd1wXXq A==;
X-CSE-ConnectionGUID: j9s46a4TS8qefO8s3GPADg==
X-CSE-MsgGUID: CSP0U/SBT32un46vHBx5Wg==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="24052412"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; d="scan'208";a="24052412"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 00:43:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; d="scan'208";a="47406660"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 27 Mar 2024 00:43:05 -0700
Date: Wed, 27 Mar 2024 15:57:01 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH for-9.1 v5 1/3] hw: Add compat machines for 9.1
Message-ID: <ZgPRTc81XKA1cbDu@intel.com>
References: <20240325141422.1380087-1-pbonzini@redhat.com>
 <20240325141422.1380087-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325141422.1380087-2-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, Mar 25, 2024 at 03:14:20PM +0100, Paolo Bonzini wrote:
> Date: Mon, 25 Mar 2024 15:14:20 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH for-9.1 v5 1/3] hw: Add compat machines for 9.1
> X-Mailer: git-send-email 2.44.0
> 
> Add 9.1 machine types for arm/i440fx/m68k/q35/s390x/spapr.
> 
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Cc: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/hw/boards.h        |  3 +++
>  include/hw/i386/pc.h       |  3 +++
>  hw/arm/virt.c              | 11 +++++++++--
>  hw/core/machine.c          |  3 +++
>  hw/i386/pc.c               |  3 +++
>  hw/i386/pc_piix.c          | 17 ++++++++++++++---
>  hw/i386/pc_q35.c           | 14 ++++++++++++--
>  hw/m68k/virt.c             | 11 +++++++++--
>  hw/ppc/spapr.c             | 17 ++++++++++++++---
>  hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
>  10 files changed, 83 insertions(+), 13 deletions(-)
>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


