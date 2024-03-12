Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B91C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 15:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk3om-0004b1-DD; Tue, 12 Mar 2024 11:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rk3oX-0004SO-Hv; Tue, 12 Mar 2024 11:13:15 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rk3oQ-0005rh-KV; Tue, 12 Mar 2024 11:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710256387; x=1741792387;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=4k9kmlLv+Q4tCeHDI4fUCwyPrd+stXUe1HJIrf8HOYc=;
 b=d8S24qZUrwE1imgIAaBqNzcH3qGScKY4tBp3bfFMxTVMNpvnfwT6zDwW
 mGFtghCrEwRHyNMW34FsJZ8hgZiFi6XHDgpuIkznW1Y3ikFMlRczT0Q8b
 WEJPa3Jaj2rpefb1rB5DszewZ0tlFGMp7JrnUyUijfzevxZe8HlFZfMEE
 jkOMoQrKupJcf3IwJ5KW4K3jJEV5FzuIsdf0y3mmMWHrxy5FaxQF0Uqja
 fTELvPd7yyHSaRIb1F5jw8AYpKQqSWhSFwuK1zNU7RhvcHc9/kYfSrKl7
 YbZkOv9psNSTb7OUqTUs9+ey4gooU91OIV5DUnv/5KFhZgvS06ROoaVgd A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5576087"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5576087"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 08:13:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="11472078"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 12 Mar 2024 08:13:01 -0700
Date: Tue, 12 Mar 2024 23:26:50 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 philmd@linaro.org, Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH 08/10] qapi: Correct error message for 'vcpu_dirty_limit'
 parameter
Message-ID: <ZfB0Oq7SSQgiqbz5@intel.com>
References: <20240312141343.3168265-1-armbru@redhat.com>
 <20240312141343.3168265-9-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240312141343.3168265-9-armbru@redhat.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, Mar 12, 2024 at 03:13:41PM +0100, Markus Armbruster wrote:
> Date: Tue, 12 Mar 2024 15:13:41 +0100
> From: Markus Armbruster <armbru@redhat.com>
> Subject: [PATCH 08/10] qapi: Correct error message for 'vcpu_dirty_limit'
>  parameter
> 
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> QERR_INVALID_PARAMETER_VALUE is defined as:
> 
>   #define QERR_INVALID_PARAMETER_VALUE \
>       "Parameter '%s' expects %s"
> 
> The current error is formatted as:
> 
>   "Parameter 'vcpu_dirty_limit' expects is invalid, it must greater then 1 MB/s"
> 
> Replace by:
> 
>   "Parameter 'vcpu_dirty_limit' is invalid, it must greater than 1 MB/s"

Is there a grammar error here? Maybe

s/it must greater/it must be greater/

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  migration/options.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/options.c b/migration/options.c
> index 40eb930940..c5115f1b5c 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -1264,9 +1264,8 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>  
>      if (params->has_vcpu_dirty_limit &&
>          (params->vcpu_dirty_limit < 1)) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
> -                   "vcpu_dirty_limit",
> -                   "is invalid, it must greater then 1 MB/s");
> +        error_setg(errp, "Parameter 'vcpu_dirty_limit' is invalid,"
> +                         " it must greater than 1 MB/s");
>          return false;
>      }
>

Otherwise,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


