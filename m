Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CCCC54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 08:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl2kV-0003qk-58; Fri, 15 Mar 2024 04:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rl2kS-0003n2-VD
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 04:17:05 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rl2kQ-0005oN-H9
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 04:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710490622; x=1742026622;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1dLDAeC6dadOshpCHadWZ9PmGzKkY+DvDSmeMrmZrRc=;
 b=StZfu2yrCISNFG0pHVvJd76D59Z8B8tjfWAmmQ2NX+O7IWKLfoeUod3G
 uOO42JPfXFdbRd39mhzc945+EdoLJ5ZbQ5/vg/uduqRLgn8PxikuvuwvH
 XH1OVDRFSmm2b9WFjpLBIi35zVHkaua/z+vq5eKSybmQiaEMAyH88BVNo
 hF27jXugW8eY+megw/jrRtcNsaz74c/MOlFfo+1BJj4oXTSghQI45EsbH
 90pslOw/sEtQLWnUtl/WdRlF7UV3/4vSr0ArUaPn5z7M8xn3TWn6XlLTh
 QllF6hmNOpXSyTbQsrlhyfqYEX/l/Am3xvitbDnvyP35pGq8HY14y6WTD w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="30792569"
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; d="scan'208";a="30792569"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2024 01:16:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; d="scan'208";a="13042975"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 15 Mar 2024 01:16:57 -0700
Date: Fri, 15 Mar 2024 16:30:47 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, chao.p.peng@intel.com
Subject: Re: [PATCH 2/2] qom/object_interfaces: Remove local_err in
 user_creatable_add_type
Message-ID: <ZfQHNxkzem2/cZbT@intel.com>
References: <20240229033739.1123076-1-zhenzhong.duan@intel.com>
 <20240229033739.1123076-3-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229033739.1123076-3-zhenzhong.duan@intel.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
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

On Thu, Feb 29, 2024 at 11:37:39AM +0800, Zhenzhong Duan wrote:
> Date: Thu, 29 Feb 2024 11:37:39 +0800
> From: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Subject: [PATCH 2/2] qom/object_interfaces: Remove local_err in
>  user_creatable_add_type
> X-Mailer: git-send-email 2.34.1
> 
> In user_creatable_add_type, there is mixed usage of ERRP_GUARD and
> local_err. This makes error_abort not taking effect in those callee
> functions with local_err passed.
> 
> Now that we already has ERRP_GUARD, remove local_err and use *errp
> instead.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  qom/object_interfaces.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> index 255a7bf659..165cd433e7 100644
> --- a/qom/object_interfaces.c
> +++ b/qom/object_interfaces.c
> @@ -81,7 +81,6 @@ Object *user_creatable_add_type(const char *type, const char *id,
>      ERRP_GUARD();
>      Object *obj;
>      ObjectClass *klass;
> -    Error *local_err = NULL;
>  
>      if (id != NULL && !id_wellformed(id)) {
>          error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "id", "an identifier");
> @@ -109,20 +108,20 @@ Object *user_creatable_add_type(const char *type, const char *id,
>  
>      assert(qdict);
>      obj = object_new(type);
> -    object_set_properties_from_qdict(obj, qdict, v, &local_err);
> -    if (local_err) {
> +    object_set_properties_from_qdict(obj, qdict, v, errp);

It's better to make object_set_properties_from_qdict someting (e.g.,
boolean). Maybe an extra cleanup?

> +    if (*errp) {
>          goto out;
>      }
>  
>      if (id != NULL) {
>          object_property_try_add_child(object_get_objects_root(),
> -                                      id, obj, &local_err);
> -        if (local_err) {
> +                                      id, obj, errp);
> +        if (*errp) {
>              goto out;
>          }
>      }

Here we could check whether the returned ObjectProperty* is NULL instaed
of dereferencing errp.

Thanks,
Zhao


