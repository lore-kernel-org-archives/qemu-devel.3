Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382A8C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 12:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpShw-0007Mj-J9; Wed, 27 Mar 2024 08:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rpShs-0007K0-O1
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 08:48:41 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rpShq-00049Z-1d
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 08:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711543719; x=1743079719;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=KjhtjLQ0OpS3vgpEUrPdd94QCyefMfbPx68PbnTemcg=;
 b=GwjQgL+raR093RAA4IBDCLT2uiEt/dJdd3zPhKWBLIFQwMzD/c3d9DpO
 W+L1Xfe7XwqoXJpWoAGE8nc9zokgbXTb/nrrG3uh0kokXHwPyS5GA6dgq
 Mu+dvrLjzrGJe5CzsZU58BJnSfOLYDXLRReDw3cyre6ZUVYX0t0yg3wXi
 ePO6UZQDcGvjVkjq7fuV+gYLysYvz38Dw103sIpT7uBuzuHkZ2I9w7xZD
 pJK/nbTU9sCW7MdRcrUkXrgm470N6mxuYf8XF46pXJXYOf1gIn/hwbSUb
 XJOLumXcjndBkXLvUxm5vzACT9YCN3G7IrTOOimuVa08iTsLQCC+dEt24 g==;
X-CSE-ConnectionGUID: 99Z3ndsnTwCVW7lMenP+Ag==
X-CSE-MsgGUID: xLdgF7f9Tk6cl6DjxHf6oA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="10433581"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; d="scan'208";a="10433581"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 05:48:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; d="scan'208";a="20943331"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 27 Mar 2024 05:48:34 -0700
Date: Wed, 27 Mar 2024 21:02:30 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [RFC] util/error-report: Add "error: " prefix for error-level
 report
Message-ID: <ZgQY5rQVQJH0Its9@intel.com>
References: <20240327114609.3858483-1-zhao1.liu@linux.intel.com>
 <a2d13494-aec2-427b-af9b-e8c41f7057f1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2d13494-aec2-427b-af9b-e8c41f7057f1@redhat.com>
Received-SPF: none client-ip=198.175.65.14;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Wed, Mar 27, 2024 at 01:36:07PM +0100, Thomas Huth wrote:

[snip]

> Sounds like a good idea to me, but I think you should then also remove
> the hard-coded "error:" strings in the various error_reports():

Thanks Thomas! I missed this case, will remove these hard-code prefix
first.

> $ grep -ri 'error_report.*"error:'
> migration/block-dirty-bitmap.c:        error_report("Error: block device name is not set");
> migration/block-dirty-bitmap.c:                error_report("Error: Unknown bitmap alias '%s' on node "
> migration/block-dirty-bitmap.c:                error_report("Error: unknown dirty bitmap "
> migration/block-dirty-bitmap.c:        error_report("Error: block device name is not set");
> target/i386/kvm/kvm.c:        error_report("error: failed to set MSR 0x%" PRIx32 " to 0x%" PRIx64,
> target/i386/kvm/kvm.c:        error_report("error: failed to get MSR 0x%" PRIx32,
> util/vhost-user-server.c:        error_report("Error: too big message request: %d, "
> accel/hvf/hvf-all.c:        error_report("Error: HV_ERROR");
> accel/hvf/hvf-all.c:        error_report("Error: HV_BUSY");
> accel/hvf/hvf-all.c:        error_report("Error: HV_BAD_ARGUMENT");
> accel/hvf/hvf-all.c:        error_report("Error: HV_NO_RESOURCES");
> accel/hvf/hvf-all.c:        error_report("Error: HV_NO_DEVICE");
> accel/hvf/hvf-all.c:        error_report("Error: HV_UNSUPPORTED");
> accel/hvf/hvf-all.c:        error_report("Error: HV_DENIED");
> monitor/hmp-cmds.c:        error_reportf_err(err, "Error: ");
> hw/arm/xlnx-zcu102.c:        error_report("ERROR: RAM size 0x%" PRIx64 " above max supported of "
> hw/block/dataplane/xen-block.c:        error_report("error: unknown operation (%d)", request->req.operation);
> hw/block/dataplane/xen-block.c:        error_report("error: write req for ro device");
> hw/block/dataplane/xen-block.c:            error_report("error: nr_segments too big");
> hw/block/dataplane/xen-block.c:            error_report("error: first > last sector");
> hw/block/dataplane/xen-block.c:            error_report("error: page crossing");
> hw/block/dataplane/xen-block.c:        error_report("error: access beyond end of file");
> hw/rdma/rdma_backend.c:            rdma_error_report("Error: Not a MAD request, skipping");
> hw/s390x/s390-skeys.c:        error_report("Error: Setting storage keys for pages with unallocated "
> hw/s390x/s390-skeys.c:        error_report("Error: Getting storage keys for pages with unallocated "
> hw/usb/bus.c:        error_report("Error: no usb bus to attach usbdevice %s, "
> gdbstub/gdbstub.c:            error_report("Error: Bad gdb register numbering for '%s', "
> 
>  Thomas
> 
> 

