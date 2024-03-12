Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8064FC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3X5-0007ah-W4; Tue, 12 Mar 2024 10:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rk3X3-0007Yf-J8; Tue, 12 Mar 2024 10:55:09 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rk3X1-000245-Sh; Tue, 12 Mar 2024 10:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710255308; x=1741791308;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Tmk5c4ctNZx7xmRdwKIvUTw8peuZ+0aY0ceacotRs2g=;
 b=XzTCSn7nR5ZPQKxW68ppvj5eAO39M1rFmtPv4HkVMBF4pZ9S9Cw0W2lr
 rTOBs/ZmPRYt5bC61963Ir8K9ddKRhFojhPCCHBLjeRDg2hiqGJJcgS/D
 tiRMpnxOKdiwpKg0XAg1ClkdJSRU6IJnH1Bej/g4Eg3Qvl6oQf9z8u+ip
 /ydZgOvAH4+JvyBlGPsFeCloh7gyQtRhJmffyH2TOS1czRg2EkApVzoNb
 lgZMdYJkCG+64vtFDiT7gD/nOTC5XNmUWgH/ZrOi76AP/afKZj2MW+04r
 rWxF4kXY3Wi0F5FVo18c9PdP4YnfqY6+vAyUol/P8+kJ3fvLMo6E6AHsV Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="7914637"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="7914637"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 07:55:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="16220472"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 12 Mar 2024 07:55:02 -0700
Date: Tue, 12 Mar 2024 23:08:50 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 philmd@linaro.org
Subject: Re: [PATCH 03/10] qapi: Inline and remove QERR_DEVICE_HAS_NO_MEDIUM
 definition
Message-ID: <ZfBwAlgPMIhZKyiB@intel.com>
References: <20240312141343.3168265-1-armbru@redhat.com>
 <20240312141343.3168265-4-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240312141343.3168265-4-armbru@redhat.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Mar 12, 2024 at 03:13:36PM +0100, Markus Armbruster wrote:
> Date: Tue, 12 Mar 2024 15:13:36 +0100
> From: Markus Armbruster <armbru@redhat.com>
> Subject: [PATCH 03/10] qapi: Inline and remove QERR_DEVICE_HAS_NO_MEDIUM
>  definition
> 
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Address the comment added in commit 4629ed1e98
> ("qerror: Finally unused, clean up"), from 2015:
> 
>   /*
>    * These macros will go away, please don't use
>    * in new code, and do not add new ones!
>    */
> 
> Mechanical transformation using sed, and manual cleanup.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qapi/qmp/qerror.h | 3 ---
>  block/snapshot.c          | 7 ++++---
>  blockdev.c                | 2 +-
>  3 files changed, 5 insertions(+), 7 deletions(-)
>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


