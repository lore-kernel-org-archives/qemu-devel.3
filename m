Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BFDC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 07:46:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfxai-0000VP-St; Fri, 01 Mar 2024 02:46:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfxae-0000V2-9V
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 02:45:57 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfxab-0002kg-RB
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 02:45:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709279154; x=1740815154;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=kVLJsx5v5qXn0TuWGotsuRJXrXBZ9M7Uy1kfXfj3gDY=;
 b=UnLiMF+pILmbeWiw0dyG870dlKI8/Zjd+HhBE0Z+/DK5sTYBNfwJSsQ1
 6LoAFOxMNlYRn/YQmBS0kIJZrtzLTHFX9PYh0IU5emku9V2XZ2STJZDam
 W1y84ghUuL8f4ReK9z1AFEtPcElPBcQMsA1fQ3YbKft0Y9Ocl7CNvuhib
 eTVs/9Lm/oagTtT6RWVhVeNrTNdKIptODuWW2ZdFjcMcZDMAfeQAtZ0an
 EsfsJiqjjw9bMN4+GnTHm5SeNQVDYAuFyt2niwPoIY8D+tWoq/1vTxTtV
 2xs6I2dBo3jhnbzKljJIYi7tvY/zEXOPrakvKeZcJHB/Xn5J/0k46V3Mu A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="21260266"
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; d="scan'208";a="21260266"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Feb 2024 23:45:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,195,1705392000"; d="scan'208";a="31294847"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 29 Feb 2024 23:45:49 -0800
Date: Fri, 1 Mar 2024 15:59:33 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-devel@nongnu.org,
 Xiaoling Song <xiaoling.song@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/8] tests/unit/test-smp-parse.c: Bump max_cpus to 4096
Message-ID: <ZeGK5WlKlvd2/jRJ@intel.com>
References: <20240118144857.2124034-1-zhao1.liu@linux.intel.com>
 <20240118144857.2124034-3-zhao1.liu@linux.intel.com>
 <50b48e30-9187-4909-94f4-ca982f1d70ed@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50b48e30-9187-4909-94f4-ca982f1d70ed@redhat.com>
Received-SPF: none client-ip=198.175.65.10;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Thomas,

On Fri, Mar 01, 2024 at 08:40:54AM +0100, Thomas Huth wrote:
> Date: Fri, 1 Mar 2024 08:40:54 +0100
> From: Thomas Huth <thuth@redhat.com>
> Subject: Re: [PATCH 2/8] tests/unit/test-smp-parse.c: Bump max_cpus to 4096
> 
> On 18/01/2024 15.48, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > PC mahine is trying to support up to 4096 vCPUs [1], so it's necessary
> 
> s/mahine/machine/
> 
> > to bump max_cpus in test-smp-parse to 4096 to cover the topological
> > needs of future machines.
> > 
> > [1]: https://lore.kernel.org/qemu-devel/20231208122611.32311-1-anisinha@redhat.com/
> 
> Is it ok for this test patch here to get included without that patch
> already, or shall this wait for the patch from Ani first?
>

This patch doesn't rely on Ani's, but given my typo and outdated links
(Ani already has v5), I can respin the series soon!

Thanks,
Zhao


