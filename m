Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3F5C5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 02:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjrUx-0001oZ-VH; Mon, 11 Mar 2024 22:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjrUh-0001a9-90
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 22:03:58 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjrUf-00050z-32
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 22:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710209033; x=1741745033;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=MEB913NrOfqDnqcPmnsKtC58zKmU31DU2o82RSFQV9M=;
 b=jtZpOLx5CetXtikkHsGKua55oOVMXS+PJQ56m4yiSVRUw4DdYcqpEdd2
 7OZYV3N6KF/ssma0XAhJTcEPdE3ub7gjnwyCQlo5cRP4bXh5oZihLFv57
 ZDdgGk+seSLyizbVpHFFhWAvejDS8ntivDr17qWPnwsPir9D7VUTfp7JC
 HEQtEIIfjmX9S+TTNwf1nrYdU4fd8YCnm5xaxcOnXvndLWI+j25v4sQaz
 bXzuUamsiYSF5olIq+Iz0vv81TqC7PssXTMq88qhunXPDTKJEUWVj6H/r
 jgTQ5dQEdQUFnuNCR2f4eEBEL9S17SP5z1552A7U+UMjMtlRHG5pmfQhm A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="16303325"
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; d="scan'208";a="16303325"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2024 19:03:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; d="scan'208";a="42284160"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa002.jf.intel.com with ESMTP; 11 Mar 2024 19:03:40 -0700
Date: Tue, 12 Mar 2024 10:17:29 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 1/3] hw/core: Cleanup unused included headers in
 cpu-common.c
Message-ID: <Ze+7OTO9BTe/WSSf@intel.com>
References: <20240311075621.3224684-1-zhao1.liu@linux.intel.com>
 <20240311075621.3224684-2-zhao1.liu@linux.intel.com>
 <752e3d2b-1834-4f6d-9764-3d7e951409c4@linaro.org>
 <Ze8m4YvRQrWFlFpN@intel.com>
 <0297cf9b-4591-4622-96b0-83dae349dc1f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0297cf9b-4591-4622-96b0-83dae349dc1f@linaro.org>
Received-SPF: none client-ip=192.198.163.10;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> > Thanks for helpping me verify this!!
> > 
> > EMM, but I'm still not understanding how this approach distinguishes
> > whether hw/core/cpu-common.c needs the header (include/exec/cpu-common.h)
> > directly or just include/exec/memory.h needs that header? For the latter,
> > the header needn't be included in .c file.
> 
> Yes, you are right, it might not be necessary.
> 
> For all other headers in your series I checked that no function /
> definition is used in the source, but "exec/cpu-common.h" is too
> big to do that manually.

Thanks! I checked manually as well... In the future I'll also think
about if there's a more elegant way to do it.

> I mostly skipped it because it is odd to
> have cpu-common.c not including the header with the same name...

Yes, I think the "cpu-common.c" is the related .c file of
exec/cpu-common.h.

And the related header of "hw/core/cpu-common.c" should be
"hw/core/cpu.h".

Could we rename "hw/core/cpu-common.c" to "hw/core/cpu.c"? Then the
relationship could be clear.

> Also, in another series I split / reworked "exec/cpu-common.h" and
> IIRC a part of it will be included here. Bah, I'll stop writing
> and take your patch unmodified.

Many thanks!

Regards,
Zhao

