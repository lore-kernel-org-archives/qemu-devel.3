Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F48D2FFE0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 09:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1jjg-0003Sj-FX; Fri, 18 Oct 2024 05:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jje-0003PE-TQ
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:57:30 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jjd-0003F5-E9
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729245450; x=1760781450;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=CfFQveU7PNVXCnx6MckeIU5ayV2Ut7YQqTWRONbf5m8=;
 b=jLPJtwEz+Jiiio+Yy9i0IWSN151TDuaL+zjlIh8Jw3PkNsAGR0svC1RQ
 WM5213ueiSPyUipxnq5+XTQr/vsO0XmfMnESk6qP3IC4MrVXmLNZqJqHn
 Gq7ZZwjYWjgG3c/wH1Go1otqmF6QWM/PFefPNJDIlUPxm9cyXCcVXeJUl
 8IRrmTGGpyP1ar+21m6awS0IRw4JTZvvHJO24TSu8X/4vpEy1NfR2Rkbn
 SFYjcsd046fIuzeLtHRCDnFmYJO0YVbjqP9FwLAuhxv2ly8fy7ifrlMet
 kh70eqZ0NxLYPmk8aJo05fHOmm4ZgWqXoINhiPHQbtARfchqUHw+9cQd8 g==;
X-CSE-ConnectionGUID: es2T2V38Tou41v1D1vO9Gg==
X-CSE-MsgGUID: V+6T0xR3S4iWPf4qGLogog==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28874122"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="28874122"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2024 02:57:28 -0700
X-CSE-ConnectionGUID: 3/fvcj1kSmahxIOkht3TOw==
X-CSE-MsgGUID: O/hzx3koTFOFGD/KciUlDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; d="scan'208";a="78866420"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa008.fm.intel.com with ESMTP; 18 Oct 2024 02:57:26 -0700
Date: Fri, 18 Oct 2024 18:13:41 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 29/31] qapi: remove header file compatibility symlinks
Message-ID: <ZxI01WJu8GsQ7tr6@intel.com>
References: <20241017113344.883424-1-berrange@redhat.com>
 <20241017113344.883424-30-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017113344.883424-30-berrange@redhat.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Oct 17, 2024 at 12:33:41PM +0100, Daniel P. Berrangé wrote:
> Date: Thu, 17 Oct 2024 12:33:41 +0100
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: [PATCH v2 29/31] qapi: remove header file compatibility symlinks
> 
> All code is converted to the new 'qobject/' import path, so
> the temporary header file compatibility symlinks are now
> redundant.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  qapi/qmp/dispatch.h    | 1 -
>  qapi/qmp/json-parser.h | 1 -
>  qapi/qmp/json-writer.h | 1 -
>  qapi/qmp/qbool.h       | 1 -
>  qapi/qmp/qdict.h       | 1 -
>  qapi/qmp/qjson.h       | 1 -
>  qapi/qmp/qlist.h       | 1 -
>  qapi/qmp/qlit.h        | 1 -
>  qapi/qmp/qnull.h       | 1 -
>  qapi/qmp/qnum.h        | 1 -
>  qapi/qmp/qobject.h     | 1 -
>  qapi/qmp/qstring.h     | 1 -
>  12 files changed, 12 deletions(-)
>  delete mode 120000 qapi/qmp/dispatch.h
>  delete mode 120000 qapi/qmp/json-parser.h
>  delete mode 120000 qapi/qmp/json-writer.h
>  delete mode 120000 qapi/qmp/qbool.h
>  delete mode 120000 qapi/qmp/qdict.h
>  delete mode 120000 qapi/qmp/qjson.h
>  delete mode 120000 qapi/qmp/qlist.h
>  delete mode 120000 qapi/qmp/qlit.h
>  delete mode 120000 qapi/qmp/qnull.h
>  delete mode 120000 qapi/qmp/qnum.h
>  delete mode 120000 qapi/qmp/qobject.h
>  delete mode 120000 qapi/qmp/qstring.h
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


