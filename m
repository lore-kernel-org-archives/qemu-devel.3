Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4BCC54E66
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 08:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl2aD-0006PW-LP; Fri, 15 Mar 2024 04:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rl2aC-0006PG-Lz
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 04:06:28 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rl2aA-0003ni-Aq
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 04:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710489987; x=1742025987;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=AXqOAEjv1ZhN0WXjBHth65arkNh1gy2ElebnZPdZC8Y=;
 b=RV8ZB84GYjSNDWOnpSAwj5Cof1Z7BBALzoi77r2VjnNznOJAjHWgUm7v
 zR/AIFusVfUQFQZSnwvYidWJh1g78eLPAczCk2/nDGyPE9bb6EUhSiPqy
 RaqU1qfEevmmSwEX2Ut8sxvbCzUcM3r/gfSYpxKUHinX3WuyyXB2mA+RF
 0ZeMSyFo9uxiE0OF3qWlXPZFKZfasIdtXnKanRD4FKMJLgD/3vmRCpLOQ
 MgYR3HjmHXbEhEzd5QJi1iruk1FEp3LATLjcNWYqowJOrrhBWXQv3n/zz
 ntbZaz6sLgMTQCXiVIhSx4X/cGKGfnDPz1Nfw9PXosp+VQSTXUDSBx0WB Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="27817630"
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; d="scan'208";a="27817630"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2024 01:06:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; d="scan'208";a="35726791"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 15 Mar 2024 01:06:17 -0700
Date: Fri, 15 Mar 2024 16:20:07 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, chao.p.peng@intel.com
Subject: Re: [PATCH 1/2] qom/object_interfaces: Remove unnecessary local_err
 check
Message-ID: <ZfQEt45kBG218Vs+@intel.com>
References: <20240229033739.1123076-1-zhenzhong.duan@intel.com>
 <20240229033739.1123076-2-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229033739.1123076-2-zhenzhong.duan@intel.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

On Thu, Feb 29, 2024 at 11:37:38AM +0800, Zhenzhong Duan wrote:
> Date: Thu, 29 Feb 2024 11:37:38 +0800
> From: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Subject: [PATCH 1/2] qom/object_interfaces: Remove unnecessary local_err
>  check
> X-Mailer: git-send-email 2.34.1
> 
> In the error return path, local_err is always set, no need to check it.

The original error handling code indicates "local_err is always set",
and error_propagate() can handle the case that local_err is NULL.

> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  qom/object_interfaces.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> index e0833c8bfe..255a7bf659 100644
> --- a/qom/object_interfaces.c
> +++ b/qom/object_interfaces.c
> @@ -128,13 +128,11 @@ Object *user_creatable_add_type(const char *type, const char *id,
>          }
>          goto out;
>      }
> -out:
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        object_unref(obj);
> -        return NULL;
> -    }
>      return obj;
> +out:

Maybe rename this to "err:"? Since now it's just used to handle error,
and "goto err" seems more clear.

> +    error_propagate(errp, local_err);
> +    object_unref(obj);
> +    return NULL;
>  }
>  
>  void user_creatable_add_qapi(ObjectOptions *options, Error **errp)
> -- 
> 2.34.1
> 

Otherwise,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



