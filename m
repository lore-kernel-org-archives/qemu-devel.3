Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC84C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 15:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3cL-0002vG-HZ; Tue, 12 Mar 2024 11:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rk3cG-0002uf-U4; Tue, 12 Mar 2024 11:00:33 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rk3cD-0003Yw-Ln; Tue, 12 Mar 2024 11:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710255630; x=1741791630;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=3GukMVtZzS1toW2RJTzhuu9AwGS5RRRUx9YsIDuK9xs=;
 b=LLshQdmJd4HnW9Y4II4/9eh8HYDefCzYCwKU8C7yts/J6ihA732fLJW2
 60766OMjFqYAQSxT3J97+rDIqYl9tS3bkEUBGo4pI3GBWb6r3WPQnJO+w
 r69tLTNoTuxRQfsBokK/a0PSA1fsjxI03JbL5NODyR5+cWTZfcPad9q1j
 ldN1B5SYQBmuPrtXhlF1XTSa5eswGrZsD6xpo7pmhGjL0g4GOWcUKlqvG
 Q78NCQq2sgeLoR+aCxgqg1ArgOYoxbVHhsm7xyZfigW1G7MesZnZ/bm4L
 NrYsjNt0sCspyIodHDc42PFKQ3VrXQqtAWYfXI2K4A8Q6YHoZQmQv88nO w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="16110556"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="16110556"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 08:00:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="11469247"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 12 Mar 2024 08:00:25 -0700
Date: Tue, 12 Mar 2024 23:14:14 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 philmd@linaro.org
Subject: Re: [PATCH 05/10] qapi: Inline and remove QERR_INVALID_PARAMETER
 definition
Message-ID: <ZfBxRqpjownNjA0o@intel.com>
References: <20240312141343.3168265-1-armbru@redhat.com>
 <20240312141343.3168265-6-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240312141343.3168265-6-armbru@redhat.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
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

On Tue, Mar 12, 2024 at 03:13:38PM +0100, Markus Armbruster wrote:
> Date: Tue, 12 Mar 2024 15:13:38 +0100
> From: Markus Armbruster <armbru@redhat.com>
> Subject: [PATCH 05/10] qapi: Inline and remove QERR_INVALID_PARAMETER
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
> Mechanical transformation using:
> 
>   $ sed -i -e "s/QERR_INVALID_PARAMETER,/\"Invalid parameter '%s'\",/" \
>     $(git grep -lw QERR_INVALID_PARAMETER)
> 
> Manually simplify qemu_opts_create(), and remove the macro definition
> in include/qapi/qmp/qerror.h.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qapi/qmp/qerror.h |  3 ---
>  qapi/opts-visitor.c       |  2 +-
>  util/qemu-option.c        | 10 +++++-----
>  3 files changed, 6 insertions(+), 9 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

